code
proc StringToFilter 160 8
file "../../../code/game/g_svcmds.c"
line 78
;1:/*
;2:===========================================================================
;3:Copyright (C) 1999-2005 Id Software, Inc.
;4:
;5:This file is part of Quake III Arena source code.
;6:
;7:Quake III Arena source code is free software; you can redistribute it
;8:and/or modify it under the terms of the GNU General Public License as
;9:published by the Free Software Foundation; either version 2 of the License,
;10:or (at your option) any later version.
;11:
;12:Quake III Arena source code is distributed in the hope that it will be
;13:useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;14:MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;15:GNU General Public License for more details.
;16:
;17:You should have received a copy of the GNU General Public License
;18:along with Quake III Arena source code; if not, write to the Free Software
;19:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;20:===========================================================================
;21:*/
;22://
;23:
;24:// this file holds commands that can be executed by the server console, but not remote clients
;25:
;26:#include "g_local.h"
;27:
;28:
;29:/*
;30:==============================================================================
;31:
;32:PACKET FILTERING
;33:
;34:
;35:You can add or remove addresses from the filter list with:
;36:
;37:addip <ip>
;38:removeip <ip>
;39:
;40:The ip address is specified in dot format, and you can use '*' to match any value
;41:so you can specify an entire class C network with "addip 192.246.40.*"
;42:
;43:Removeip will only remove an address specified exactly the same way.  You cannot addip a subnet, then removeip a single host.
;44:
;45:listip
;46:Prints the current list of filters.
;47:
;48:g_filterban <0 or 1>
;49:
;50:If 1 (the default), then ip addresses matching the current list will be prohibited from entering the game.  This is the default setting.
;51:
;52:If 0, then only addresses matching the list will be allowed.  This lets you easily set up a private game, or a game that only allows players from your local network.
;53:
;54:TTimo NOTE: for persistence, bans are stored in g_banIPs cvar MAX_CVAR_VALUE_STRING
;55:The size of the cvar string buffer is limiting the banning to around 20 masks
;56:this could be improved by putting some g_banIPs2 g_banIps3 etc. maybe
;57:still, you should rely on PB for banning instead
;58:
;59:==============================================================================
;60:*/
;61:
;62:typedef struct ipFilter_s {
;63:	unsigned	mask;
;64:	unsigned	compare;
;65:} ipFilter_t;
;66:
;67:#define	MAX_IPFILTERS	1024
;68:
;69:static ipFilter_t	ipFilters[MAX_IPFILTERS];
;70:static int			numIPFilters;
;71:
;72:/*
;73:=================
;74:StringToFilter
;75:=================
;76:*/
;77:static qboolean StringToFilter (char *s, ipFilter_t *f)
;78:{
line 84
;79:	char	num[128];
;80:	int		i, j;
;81:	byte	b[4];
;82:	byte	m[4];
;83:
;84:	for (i=0 ; i<4 ; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
LABELV $61
line 85
;85:		b[i] = 0;
ADDRLP4 132
INDIRI4
ADDRLP4 136
ADDP4
CNSTU1 0
ASGNU1
line 86
;86:		m[i] = 0;
ADDRLP4 132
INDIRI4
ADDRLP4 140
ADDP4
CNSTU1 0
ASGNU1
line 87
;87:	}
LABELV $62
line 84
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 4
LTI4 $61
line 89
;88:
;89:	for (i=0 ; i<4 ; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
LABELV $65
line 90
;90:		if (*s < '0' || *s > '9') {
ADDRLP4 144
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 48
LTI4 $71
ADDRLP4 144
INDIRI4
CNSTI4 57
LEI4 $69
LABELV $71
line 91
;91:			if (*s == '*') { // 'match any'
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $72
line 93
;92:				// b[i] and m[i] to 0
;93:				s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 94
;94:				if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $74
line 95
;95:					break;
ADDRGP4 $67
JUMPV
LABELV $74
line 96
;96:				s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 97
;97:				continue;
ADDRGP4 $66
JUMPV
LABELV $72
line 99
;98:			}
;99:			G_Printf( "Bad filter address: %s\n", s );
ADDRGP4 $76
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 100
;100:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $60
JUMPV
LABELV $69
line 103
;101:		}
;102:
;103:		j = 0;
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRGP4 $78
JUMPV
LABELV $77
line 104
;104:		while (*s >= '0' && *s <= '9') {
line 105
;105:			num[j++] = *s++;
ADDRLP4 148
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 156
CNSTI4 1
ASGNI4
ADDRLP4 128
ADDRLP4 148
INDIRI4
ADDRLP4 156
INDIRI4
ADDI4
ASGNI4
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 152
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
ASGNP4
ADDRLP4 148
INDIRI4
ADDRLP4 0
ADDP4
ADDRLP4 152
INDIRP4
INDIRI1
ASGNI1
line 106
;106:		}
LABELV $78
line 104
ADDRLP4 148
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 48
LTI4 $80
ADDRLP4 148
INDIRI4
CNSTI4 57
LEI4 $77
LABELV $80
line 107
;107:		num[j] = 0;
ADDRLP4 128
INDIRI4
ADDRLP4 0
ADDP4
CNSTI1 0
ASGNI1
line 108
;108:		b[i] = atoi(num);
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
ADDRLP4 136
ADDP4
ADDRLP4 152
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 109
;109:		m[i] = 255;
ADDRLP4 132
INDIRI4
ADDRLP4 140
ADDP4
CNSTU1 255
ASGNU1
line 111
;110:
;111:		if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $81
line 112
;112:			break;
ADDRGP4 $67
JUMPV
LABELV $81
line 113
;113:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 114
;114:	}
LABELV $66
line 89
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 4
LTI4 $65
LABELV $67
line 116
;115:
;116:	f->mask = *(unsigned *)m;
ADDRFP4 4
INDIRP4
ADDRLP4 140
INDIRU4
ASGNU4
line 117
;117:	f->compare = *(unsigned *)b;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 136
INDIRU4
ASGNU4
line 119
;118:
;119:	return qtrue;
CNSTI4 1
RETI4
LABELV $60
endproc StringToFilter 160 8
proc UpdateIPBans 344 12
line 128
;120:}
;121:
;122:/*
;123:=================
;124:UpdateIPBans
;125:=================
;126:*/
;127:static void UpdateIPBans (void)
;128:{
line 135
;129:	byte	b[4];
;130:	byte	m[4];
;131:	int		i,j;
;132:	char	iplist_final[MAX_CVAR_VALUE_STRING];
;133:	char	ip[64];
;134:
;135:	*iplist_final = 0;
ADDRLP4 80
CNSTI1 0
ASGNI1
line 136
;136:	for (i = 0 ; i < numIPFilters ; i++) {
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRGP4 $87
JUMPV
LABELV $84
line 137
;137:		if (ipFilters[i].compare == 0xffffffff)
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
INDIRU4
CNSTU4 4294967295
NEU4 $88
line 138
;138:			continue;
ADDRGP4 $85
JUMPV
LABELV $88
line 140
;139:
;140:		*(unsigned *)b = ipFilters[i].compare;
ADDRLP4 72
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
INDIRU4
ASGNU4
line 141
;141:		*(unsigned *)m = ipFilters[i].mask;
ADDRLP4 68
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters
ADDP4
INDIRU4
ASGNU4
line 142
;142:		*ip = 0;
ADDRLP4 4
CNSTI1 0
ASGNI1
line 143
;143:		for (j = 0 ; j < 4 ; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $92
line 144
;144:			if (m[j]!=255)
ADDRLP4 0
INDIRI4
ADDRLP4 68
ADDP4
INDIRU1
CVUI4 1
CNSTI4 255
EQI4 $96
line 145
;145:				Q_strcat(ip, sizeof(ip), "*");
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $98
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
ADDRGP4 $97
JUMPV
LABELV $96
line 147
;146:			else
;147:				Q_strcat(ip, sizeof(ip), va("%i", b[j]));
ADDRGP4 $99
ARGP4
ADDRLP4 0
INDIRI4
ADDRLP4 72
ADDP4
INDIRU1
CVUI4 1
ARGI4
ADDRLP4 336
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 336
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
LABELV $97
line 148
;148:			Q_strcat(ip, sizeof(ip), (j<3) ? "." : " ");
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 3
GEI4 $103
ADDRLP4 340
ADDRGP4 $100
ASGNP4
ADDRGP4 $104
JUMPV
LABELV $103
ADDRLP4 340
ADDRGP4 $101
ASGNP4
LABELV $104
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 149
;149:		}
LABELV $93
line 143
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $92
line 150
;150:		if (strlen(iplist_final)+strlen(ip) < MAX_CVAR_VALUE_STRING) {
ADDRLP4 80
ARGP4
ADDRLP4 336
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 340
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
ADDRLP4 340
INDIRI4
ADDI4
CNSTI4 256
GEI4 $105
line 151
;151:			Q_strcat( iplist_final, sizeof(iplist_final), ip);
ADDRLP4 80
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 152
;152:		}
ADDRGP4 $106
JUMPV
LABELV $105
line 153
;153:		else {
line 154
;154:			Com_Printf("g_banIPs overflowed at MAX_CVAR_VALUE_STRING\n");
ADDRGP4 $107
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 155
;155:			break;
ADDRGP4 $86
JUMPV
LABELV $106
line 157
;156:		}
;157:	}
LABELV $85
line 136
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $87
ADDRLP4 76
INDIRI4
ADDRGP4 numIPFilters
INDIRI4
LTI4 $84
LABELV $86
line 159
;158:
;159:	trap_Cvar_Set( "g_banIPs", iplist_final );
ADDRGP4 $108
ARGP4
ADDRLP4 80
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 160
;160:}
LABELV $83
endproc UpdateIPBans 344 12
export G_FilterPacket
proc G_FilterPacket 28 0
line 168
;161:
;162:/*
;163:=================
;164:G_FilterPacket
;165:=================
;166:*/
;167:qboolean G_FilterPacket (char *from)
;168:{
line 174
;169:	int		i;
;170:	unsigned	in;
;171:	byte m[4];
;172:	char *p;
;173:
;174:	i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 175
;175:	p = from;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $111
JUMPV
LABELV $110
line 176
;176:	while (*p && i < 4) {
line 177
;177:		m[i] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
CNSTU1 0
ASGNU1
ADDRGP4 $114
JUMPV
LABELV $113
line 178
;178:		while (*p >= '0' && *p <= '9') {
line 179
;179:			m[i] = m[i]*10 + (*p - '0');
ADDRLP4 16
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 10
ADDRLP4 16
INDIRP4
INDIRU1
CVUI4 1
MULI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ADDI4
CVIU4 4
CVUU1 4
ASGNU1
line 180
;180:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 181
;181:		}
LABELV $114
line 178
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 48
LTI4 $116
ADDRLP4 16
INDIRI4
CNSTI4 57
LEI4 $113
LABELV $116
line 182
;182:		if (!*p || *p == ':')
ADDRLP4 20
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $119
ADDRLP4 20
INDIRI4
CNSTI4 58
NEI4 $117
LABELV $119
line 183
;183:			break;
ADDRGP4 $112
JUMPV
LABELV $117
line 184
;184:		i++, p++;
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ASGNP4
line 185
;185:	}
LABELV $111
line 176
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $120
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $110
LABELV $120
LABELV $112
line 187
;186:
;187:	in = *(unsigned *)m;
ADDRLP4 12
ADDRLP4 8
INDIRU4
ASGNU4
line 189
;188:
;189:	for (i=0 ; i<numIPFilters ; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $121
line 190
;190:		if ( (in & ipFilters[i].mask) == ipFilters[i].compare)
ADDRLP4 16
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
ADDRLP4 12
INDIRU4
ADDRLP4 16
INDIRI4
ADDRGP4 ipFilters
ADDP4
INDIRU4
BANDU4
ADDRLP4 16
INDIRI4
ADDRGP4 ipFilters+4
ADDP4
INDIRU4
NEU4 $125
line 191
;191:			return g_filterBan.integer != 0;
ADDRGP4 g_filterBan+12
INDIRI4
CNSTI4 0
EQI4 $130
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $131
JUMPV
LABELV $130
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $131
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $109
JUMPV
LABELV $125
LABELV $122
line 189
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $124
ADDRLP4 4
INDIRI4
ADDRGP4 numIPFilters
INDIRI4
LTI4 $121
line 193
;192:
;193:	return g_filterBan.integer == 0;
ADDRGP4 g_filterBan+12
INDIRI4
CNSTI4 0
NEI4 $134
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $135
JUMPV
LABELV $134
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $135
ADDRLP4 24
INDIRI4
RETI4
LABELV $109
endproc G_FilterPacket 28 0
proc AddIP 8 8
line 202
;194:}
;195:
;196:/*
;197:=================
;198:AddIP
;199:=================
;200:*/
;201:static void AddIP( char *str )
;202:{
line 205
;203:	int		i;
;204:
;205:	for (i = 0 ; i < numIPFilters ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $140
JUMPV
LABELV $137
line 206
;206:		if (ipFilters[i].compare == 0xffffffff)
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
INDIRU4
CNSTU4 4294967295
NEU4 $141
line 207
;207:			break;		// free spot
ADDRGP4 $139
JUMPV
LABELV $141
LABELV $138
line 205
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $140
ADDRLP4 0
INDIRI4
ADDRGP4 numIPFilters
INDIRI4
LTI4 $137
LABELV $139
line 208
;208:	if (i == numIPFilters) {
ADDRLP4 0
INDIRI4
ADDRGP4 numIPFilters
INDIRI4
NEI4 $144
line 209
;209:		if (numIPFilters == MAX_IPFILTERS) {
ADDRGP4 numIPFilters
INDIRI4
CNSTI4 1024
NEI4 $146
line 210
;210:			G_Printf ("IP filter list is full\n");
ADDRGP4 $148
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 211
;211:			return;
ADDRGP4 $136
JUMPV
LABELV $146
line 213
;212:		}
;213:		numIPFilters++;
ADDRLP4 4
ADDRGP4 numIPFilters
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 214
;214:	}
LABELV $144
line 216
;215:
;216:	if (!StringToFilter (str, &ipFilters[i]))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 StringToFilter
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $149
line 217
;217:		ipFilters[i].compare = 0xffffffffu;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
CNSTU4 4294967295
ASGNU4
LABELV $149
line 219
;218:
;219:	UpdateIPBans();
ADDRGP4 UpdateIPBans
CALLV
pop
line 220
;220:}
LABELV $136
endproc AddIP 8 8
export G_ProcessIPBans
proc G_ProcessIPBans 276 12
line 228
;221:
;222:/*
;223:=================
;224:G_ProcessIPBans
;225:=================
;226:*/
;227:void G_ProcessIPBans(void)
;228:{
line 232
;229:	char *s, *t;
;230:	char		str[MAX_CVAR_VALUE_STRING];
;231:
;232:	Q_strncpyz( str, g_banIPs.string, sizeof(str) );
ADDRLP4 8
ARGP4
ADDRGP4 g_banIPs+16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 234
;233:
;234:	for (t = s = g_banIPs.string; *t; /* */ ) {
ADDRLP4 264
ADDRGP4 g_banIPs+16
ASGNP4
ADDRLP4 0
ADDRLP4 264
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 264
INDIRP4
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $154
line 235
;235:		s = strchr(s, ' ');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 268
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 268
INDIRP4
ASGNP4
line 236
;236:		if (!s)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $162
line 237
;237:			break;
ADDRGP4 $156
JUMPV
LABELV $161
line 239
;238:		while (*s == ' ')
;239:			*s++ = 0;
ADDRLP4 272
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 272
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI1 0
ASGNI1
LABELV $162
line 238
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $161
line 240
;240:		if (*t)
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $164
line 241
;241:			AddIP( t );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 AddIP
CALLV
pop
LABELV $164
line 242
;242:		t = s;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 243
;243:	}
LABELV $155
line 234
LABELV $157
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $154
LABELV $156
line 244
;244:}
LABELV $152
endproc G_ProcessIPBans 276 12
export Svcmd_AddIP_f
proc Svcmd_AddIP_f 1028 12
line 253
;245:
;246:
;247:/*
;248:=================
;249:Svcmd_AddIP_f
;250:=================
;251:*/
;252:void Svcmd_AddIP_f (void)
;253:{
line 256
;254:	char		str[MAX_TOKEN_CHARS];
;255:
;256:	if ( trap_Argc() < 2 ) {
ADDRLP4 1024
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
GEI4 $167
line 257
;257:		G_Printf("Usage:  addip <ip-mask>\n");
ADDRGP4 $169
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 258
;258:		return;
ADDRGP4 $166
JUMPV
LABELV $167
line 261
;259:	}
;260:
;261:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 263
;262:
;263:	AddIP( str );
ADDRLP4 0
ARGP4
ADDRGP4 AddIP
CALLV
pop
line 265
;264:
;265:}
LABELV $166
endproc Svcmd_AddIP_f 1028 12
export Svcmd_RemoveIP_f
proc Svcmd_RemoveIP_f 1048 12
line 273
;266:
;267:/*
;268:=================
;269:Svcmd_RemoveIP_f
;270:=================
;271:*/
;272:void Svcmd_RemoveIP_f (void)
;273:{
line 278
;274:	ipFilter_t	f;
;275:	int			i;
;276:	char		str[MAX_TOKEN_CHARS];
;277:
;278:	if ( trap_Argc() < 2 ) {
ADDRLP4 1036
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 2
GEI4 $171
line 279
;279:		G_Printf("Usage:  sv removeip <ip-mask>\n");
ADDRGP4 $173
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 280
;280:		return;
ADDRGP4 $170
JUMPV
LABELV $171
line 283
;281:	}
;282:
;283:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 285
;284:
;285:	if (!StringToFilter (str, &f))
ADDRLP4 12
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1040
ADDRGP4 StringToFilter
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $174
line 286
;286:		return;
ADDRGP4 $170
JUMPV
LABELV $174
line 288
;287:
;288:	for (i=0 ; i<numIPFilters ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $179
JUMPV
LABELV $176
line 289
;289:		if (ipFilters[i].mask == f.mask	&&
ADDRLP4 1044
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
ADDRLP4 1044
INDIRI4
ADDRGP4 ipFilters
ADDP4
INDIRU4
ADDRLP4 4
INDIRU4
NEU4 $180
ADDRLP4 1044
INDIRI4
ADDRGP4 ipFilters+4
ADDP4
INDIRU4
ADDRLP4 4+4
INDIRU4
NEU4 $180
line 290
;290:		        ipFilters[i].compare == f.compare) {
line 291
;291:			ipFilters[i].compare = 0xffffffffu;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 ipFilters+4
ADDP4
CNSTU4 4294967295
ASGNU4
line 292
;292:			G_Printf ("Removed.\n");
ADDRGP4 $185
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 294
;293:
;294:			UpdateIPBans();
ADDRGP4 UpdateIPBans
CALLV
pop
line 295
;295:			return;
ADDRGP4 $170
JUMPV
LABELV $180
line 297
;296:		}
;297:	}
LABELV $177
line 288
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $179
ADDRLP4 0
INDIRI4
ADDRGP4 numIPFilters
INDIRI4
LTI4 $176
line 298
;298:	G_Printf ( "Didn't find %s.\n", str );
ADDRGP4 $186
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 299
;299:}
LABELV $170
endproc Svcmd_RemoveIP_f 1048 12
export Svcmd_EntityList_f
proc Svcmd_EntityList_f 16 8
line 307
;300:
;301:/*
;302:===================
;303:Svcmd_EntityList_f
;304:===================
;305:*/
;306:void	Svcmd_EntityList_f (void)
;307:{
line 311
;308:	int			e;
;309:	gentity_t		*check;
;310:
;311:	check = g_entities;
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 312
;312:	for (e = 0; e < level.num_entities ; e++, check++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $191
JUMPV
LABELV $188
line 313
;313:		if ( !check->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $193
line 314
;314:			continue;
ADDRGP4 $189
JUMPV
LABELV $193
line 316
;315:		}
;316:		G_Printf("%3i:", e);
ADDRGP4 $195
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 317
;317:		switch ( check->s.eType ) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $196
ADDRLP4 8
INDIRI4
CNSTI4 11
GTI4 $196
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $224
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $224
address $199
address $201
address $203
address $205
address $207
address $209
address $211
address $213
address $215
address $217
address $219
address $221
code
LABELV $199
line 319
;318:		case ET_GENERAL:
;319:			G_Printf("ET_GENERAL          ");
ADDRGP4 $200
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 320
;320:			break;
ADDRGP4 $197
JUMPV
LABELV $201
line 322
;321:		case ET_PLAYER:
;322:			G_Printf("ET_PLAYER           ");
ADDRGP4 $202
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 323
;323:			break;
ADDRGP4 $197
JUMPV
LABELV $203
line 325
;324:		case ET_ITEM:
;325:			G_Printf("ET_ITEM             ");
ADDRGP4 $204
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 326
;326:			break;
ADDRGP4 $197
JUMPV
LABELV $205
line 328
;327:		case ET_MISSILE:
;328:			G_Printf("ET_MISSILE          ");
ADDRGP4 $206
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 329
;329:			break;
ADDRGP4 $197
JUMPV
LABELV $207
line 331
;330:		case ET_MOVER:
;331:			G_Printf("ET_MOVER            ");
ADDRGP4 $208
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 332
;332:			break;
ADDRGP4 $197
JUMPV
LABELV $209
line 334
;333:		case ET_BEAM:
;334:			G_Printf("ET_BEAM             ");
ADDRGP4 $210
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 335
;335:			break;
ADDRGP4 $197
JUMPV
LABELV $211
line 337
;336:		case ET_PORTAL:
;337:			G_Printf("ET_PORTAL           ");
ADDRGP4 $212
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 338
;338:			break;
ADDRGP4 $197
JUMPV
LABELV $213
line 340
;339:		case ET_SPEAKER:
;340:			G_Printf("ET_SPEAKER          ");
ADDRGP4 $214
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 341
;341:			break;
ADDRGP4 $197
JUMPV
LABELV $215
line 343
;342:		case ET_PUSH_TRIGGER:
;343:			G_Printf("ET_PUSH_TRIGGER     ");
ADDRGP4 $216
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 344
;344:			break;
ADDRGP4 $197
JUMPV
LABELV $217
line 346
;345:		case ET_TELEPORT_TRIGGER:
;346:			G_Printf("ET_TELEPORT_TRIGGER ");
ADDRGP4 $218
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 347
;347:			break;
ADDRGP4 $197
JUMPV
LABELV $219
line 349
;348:		case ET_INVISIBLE:
;349:			G_Printf("ET_INVISIBLE        ");
ADDRGP4 $220
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 350
;350:			break;
ADDRGP4 $197
JUMPV
LABELV $221
line 352
;351:		case ET_GRAPPLE:
;352:			G_Printf("ET_GRAPPLE          ");
ADDRGP4 $222
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 353
;353:			break;
ADDRGP4 $197
JUMPV
LABELV $196
line 355
;354:		default:
;355:			G_Printf("%3i                 ", check->s.eType);
ADDRGP4 $223
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 356
;356:			break;
LABELV $197
line 358
;357:		}
;358:		if ( check->classname ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $225
line 359
;359:			G_Printf("%s", check->classname);
ADDRGP4 $227
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 360
;360:		}
LABELV $225
line 361
;361:		G_Printf("\n");
ADDRGP4 $228
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 362
;362:	}
LABELV $189
line 312
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
LABELV $191
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $188
line 363
;363:}
LABELV $187
endproc Svcmd_EntityList_f 16 8
export ClientForString
proc ClientForString 24 8
line 366
;364:
;365:gclient_t	*ClientForString( const char *s )
;366:{
line 372
;367:	gclient_t	*cl;
;368:	int			i;
;369:	int			idnum;
;370:
;371:	// numeric values are just slot numbers
;372:	if ( s[0] >= '0' && s[0] <= '9' ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 48
LTI4 $230
ADDRLP4 12
INDIRI4
CNSTI4 57
GTI4 $230
line 373
;373:		idnum = atoi( s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 374
;374:		if ( idnum < 0 || idnum >= level.maxclients ) {
ADDRLP4 20
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $235
ADDRLP4 20
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $232
LABELV $235
line 375
;375:			Com_Printf( "Bad client slot: %i\n", idnum );
ADDRGP4 $236
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 376
;376:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $229
JUMPV
LABELV $232
line 379
;377:		}
;378:
;379:		cl = &level.clients[idnum];
ADDRLP4 0
CNSTI4 2116
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 380
;380:		if ( cl->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $237
line 381
;381:			G_Printf( "Client %i is not connected\n", idnum );
ADDRGP4 $239
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 382
;382:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $229
JUMPV
LABELV $237
line 384
;383:		}
;384:		return cl;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $229
JUMPV
LABELV $230
line 388
;385:	}
;386:
;387:	// check for a name match
;388:	for ( i=0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $243
JUMPV
LABELV $240
line 389
;389:		cl = &level.clients[i];
ADDRLP4 0
CNSTI4 2116
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 390
;390:		if ( cl->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $245
line 391
;391:			continue;
ADDRGP4 $241
JUMPV
LABELV $245
line 393
;392:		}
;393:		if ( Q_strequal( cl->pers.netname, s ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $247
line 394
;394:			return cl;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $229
JUMPV
LABELV $247
line 396
;395:		}
;396:	}
LABELV $241
line 388
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $243
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $240
line 397
;397:	G_Printf( "User %s is not on the server\n", s );
ADDRGP4 $249
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 399
;398:
;399:	return NULL;
CNSTP4 0
RETP4
LABELV $229
endproc ClientForString 24 8
export Svcmd_ForceTeam_f
proc Svcmd_ForceTeam_f 1032 12
line 410
;400:}
;401:
;402:/*
;403:===================
;404:Svcmd_ForceTeam_f
;405:
;406:forceteam <player> <team>
;407:===================
;408:*/
;409:void	Svcmd_ForceTeam_f( void )
;410:{
line 415
;411:	gclient_t	*cl;
;412:	char		str[MAX_TOKEN_CHARS];
;413:
;414:	// find the player
;415:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 416
;416:	cl = ClientForString( str );
ADDRLP4 0
ARGP4
ADDRLP4 1028
ADDRGP4 ClientForString
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1028
INDIRP4
ASGNP4
line 417
;417:	if ( !cl ) {
ADDRLP4 1024
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $251
line 418
;418:		return;
ADDRGP4 $250
JUMPV
LABELV $251
line 422
;419:	}
;420:
;421:	// set the team
;422:	trap_Argv( 2, str, sizeof( str ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 423
;423:	SetTeam( &g_entities[cl - level.clients], str );
CNSTI4 816
ADDRLP4 1024
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 2116
DIVI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 424
;424:}
LABELV $250
endproc Svcmd_ForceTeam_f 1032 12
export ClientKick_f
proc ClientKick_f 1040 12
line 427
;425:
;426:void	ClientKick_f( void )
;427:{
line 431
;428:	int idnum, i;
;429:	char	str[MAX_TOKEN_CHARS];
;430:
;431:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 433
;432:
;433:	for (i = 0; str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $257
JUMPV
LABELV $254
line 434
;434:		if (str[i] < '0' || str[i] > '9') {
ADDRLP4 1032
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 48
LTI4 $260
ADDRLP4 1032
INDIRI4
CNSTI4 57
LEI4 $258
LABELV $260
line 435
;435:			G_Printf("not a valid client number: \"%s\"\n",str);
ADDRGP4 $261
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 436
;436:			return;
ADDRGP4 $253
JUMPV
LABELV $258
line 438
;437:		}
;438:	}
LABELV $255
line 433
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $257
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $254
line 440
;439:
;440:	idnum = atoi( str );
ADDRLP4 4
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1032
INDIRI4
ASGNI4
line 443
;441:
;442:	//Local client
;443:	if ( strequals( level.clients[idnum].pers.ip, "localhost" ) ) {
CNSTI4 2116
ADDRLP4 1028
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 945
ADDP4
ARGP4
ADDRGP4 $264
ARGP4
ADDRLP4 1036
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $262
line 444
;444:		G_Printf("Kick failed - local player\n");
ADDRGP4 $265
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 445
;445:		return;
ADDRGP4 $253
JUMPV
LABELV $262
line 451
;446:	}
;447:
;448:	//Now clientkick has been moved into game, but we still need to find the idnum the server expects....
;449:	//FIXME: To fix this, we need a relieble way to generate difference between the server's client number and the game's client numbers
;450:	//FIXME: This should not depend on the engine's clientkick at all
;451:	trap_DropClient( idnum, "was kicked" );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRGP4 $266
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 454
;452:	//trap_SendConsoleCommand( EXEC_INSERT, va("clientkick %d\n", level.clients[idnum].ps.clientNum) );
;453:
;454:}
LABELV $253
endproc ClientKick_f 1040 12
export EndGame_f
proc EndGame_f 0 0
line 457
;455:
;456:void EndGame_f ( void )
;457:{
line 458
;458:	ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 459
;459:}
LABELV $267
endproc EndGame_f 0 0
data
export svcmds
align 4
LABELV svcmds
address $269
byte 4 0
address Svcmd_EntityList_f
address $270
byte 4 0
address Svcmd_ForceTeam_f
address $271
byte 4 0
address Svcmd_GameMem_f
address $272
byte 4 0
address Svcmd_AddBot_f
address $273
byte 4 0
address Svcmd_BotList_f
address $274
byte 4 0
address Svcmd_AbortPodium_f
address $275
byte 4 0
address Svcmd_AddIP_f
address $276
byte 4 0
address Svcmd_RemoveIP_f
address $277
byte 4 0
address Svcmd_ListIP_f
address $278
byte 4 0
address Svcmd_Status_f
address $279
byte 4 0
address Svcmd_EjectClient_f
address $280
byte 4 0
address Svcmd_DumpUser_f
address $281
byte 4 1
address Svcmd_CenterPrint_f
address $282
byte 4 1
address Svcmd_TeamMessage_f
address $283
byte 4 1
address Svcmd_MessageWrapper
address $284
byte 4 1
address Svcmd_Chat_f
address $285
byte 4 0
address ClientKick_f
address $286
byte 4 0
address EndGame_f
export ConsoleCommand
code
proc ConsoleCommand 1036 12
line 508
;460:
;461://KK-OAX Moved this Declaration to g_local.h
;462://char	*ConcatArgs( int start );
;463:
;464:/*KK-OAX
;465:===============
;466:Server Command Table
;467:Not Worth Listing Elsewhere
;468:================
;469:*/
;470:struct {
;471:	char      *cmd;
;472:	qboolean  dedicated; //if it has to be entered from a dedicated server or RCON
;473:	void      ( *function )( void );
;474:} svcmds[ ] = {
;475:
;476:	{ "entityList", qfalse, Svcmd_EntityList_f },
;477:	{ "forceTeam", qfalse, Svcmd_ForceTeam_f },
;478:	{ "game_memory", qfalse, Svcmd_GameMem_f },
;479:	{ "addbot", qfalse, Svcmd_AddBot_f },
;480:	{ "botlist", qfalse, Svcmd_BotList_f },
;481:	{ "abort_podium", qfalse, Svcmd_AbortPodium_f },
;482:	{ "addip", qfalse, Svcmd_AddIP_f },
;483:	{ "removeip", qfalse, Svcmd_RemoveIP_f },
;484:
;485:	//KK-OAX Uses wrapper in g_svccmds_ext.c
;486:	{ "listip", qfalse, Svcmd_ListIP_f },
;487:	//KK-OAX New
;488:	{ "status", qfalse, Svcmd_Status_f },
;489:	{ "eject", qfalse, Svcmd_EjectClient_f },
;490:	{ "dumpuser", qfalse, Svcmd_DumpUser_f },
;491:	// don't handle communication commands unless dedicated
;492:	{ "cp", qtrue, Svcmd_CenterPrint_f },
;493:	{ "say_team", qtrue, Svcmd_TeamMessage_f },
;494:	{ "say", qtrue, Svcmd_MessageWrapper },
;495:	{ "chat", qtrue, Svcmd_Chat_f },
;496:	//Kicks a player by number in the game logic rather than the server number
;497:	{ "clientkick_game", qfalse, ClientKick_f },
;498:	{ "endgamenow", qfalse, EndGame_f },
;499:};
;500:
;501:/*
;502:=================
;503:ConsoleCommand
;504:
;505:=================
;506:*/
;507:qboolean  ConsoleCommand( void )
;508:{
line 512
;509:	char cmd[ MAX_TOKEN_CHARS ];
;510:	int  i;
;511:
;512:	trap_Argv( 0, cmd, sizeof( cmd ) );
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 514
;513:
;514:	for( i = 0; i < sizeof( svcmds ) / sizeof( svcmds[ 0 ] ); i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $291
JUMPV
LABELV $288
line 515
;515:		if( Q_strequal( cmd, svcmds[ i ].cmd ) ) {
ADDRLP4 4
ARGP4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 svcmds
ADDP4
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $292
line 516
;516:			if( svcmds[ i ].dedicated && !g_dedicated.integer )
ADDRLP4 1032
CNSTI4 0
ASGNI4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 svcmds+4
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
EQI4 $294
ADDRGP4 g_dedicated+12
INDIRI4
ADDRLP4 1032
INDIRI4
NEI4 $294
line 517
;517:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $287
JUMPV
LABELV $294
line 518
;518:			svcmds[ i ].function( );
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 svcmds+8
ADDP4
INDIRP4
CALLV
pop
line 519
;519:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $287
JUMPV
LABELV $292
line 521
;520:		}
;521:	}
LABELV $289
line 514
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $291
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 18
LTU4 $288
line 524
;522:	// KK-OAX Will be enabled when admin is added.
;523:	// see if this is an admin command
;524:	if( G_admin_cmd_check( NULL, qfalse ) )
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1028
ADDRGP4 G_admin_cmd_check
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $299
line 525
;525:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $287
JUMPV
LABELV $299
line 527
;526:
;527:	if( g_dedicated.integer )
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $301
line 528
;528:		G_Printf( "unknown command: %s\n", cmd );
ADDRGP4 $304
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
LABELV $301
line 530
;529:
;530:	return qfalse;
CNSTI4 0
RETI4
LABELV $287
endproc ConsoleCommand 1036 12
bss
align 4
LABELV numIPFilters
skip 4
align 4
LABELV ipFilters
skip 8192
import G_IsARoundBasedGametype
import G_UsesTheWhiteFlag
import G_UsesTeamFlags
import G_IsATeamGametype
import monster_die
import MapInfoPrint
import G_admin_namelog_cleanup
import G_admin_cleanup
import G_admin_duration
import G_admin_buffer_end
import G_admin_buffer_begin
import G_admin_buffer_print
import G_admin_print
import G_admin_warn
import G_admin_slap
import G_admin_orient
import G_admin_disorient
import G_admin_unlock
import G_admin_lock
import G_admin_namelog
import G_admin_nextmap
import G_admin_restart
import G_admin_rename
import G_admin_spec999
import G_admin_passvote
import G_admin_cancelvote
import G_admin_allready
import G_admin_admintest
import G_admin_help
import G_admin_showbans
import G_admin_mute
import G_admin_map
import G_admin_listplayers
import G_admin_listadmins
import G_admin_putteam
import G_admin_unban
import G_admin_ban
import G_admin_adjustban
import G_admin_kick
import G_admin_setlevel
import G_admin_time
import G_admin_parse_time
import G_admin_level
import G_admin_namelog_update
import G_admin_name_check
import G_admin_permission
import G_admin_readconfig
import G_admin_cmd_check
import G_admin_ban_check
import G_ConfigClientExcellent
import G_checkForMultiKill
import G_CheckForSpree
import G_RunStreakLogic
import G_ReadAltKillSettings
import Svcmd_MessageWrapper
import Svcmd_ListIP_f
import Svcmd_Chat_f
import Svcmd_DumpUser_f
import Svcmd_EjectClient_f
import Svcmd_BannerPrint_f
import Svcmd_CenterPrint_f
import Svcmd_TeamMessage_f
import Svcmd_Status_f
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_RealTime
import trap_Milliseconds
import trap_Error
import trap_Printf
import g_bot_noChat
import g_spSkill
import g_developer
import g_ddRespawnDelay
import g_ddCaptureTime
import g_harvesterFromBodies
import g_grapple
import g_maxNameChanges
import g_minNameChangePeriod
import g_warningExpire
import g_maxWarnings
import g_publicAdminMessages
import g_specChat
import g_adminMaxBan
import g_adminTempBan
import g_adminNameProtect
import g_adminParseSay
import g_adminLog
import g_admin
import g_floodMinTime
import g_floodMaxDemerits
import g_spreeDiv
import g_altExcellent
import g_sprees
import g_lagLightning
import sv_fps
import g_truePing
import g_delagHitscan
import g_blueTeamClientNumbers
import g_redTeamClientNumbers
import g_humanplayers
import g_maxvotes
import g_voteMaxFraglimit
import g_voteMinFraglimit
import g_voteMaxTimelimit
import g_voteMinTimelimit
import g_voteGametypes
import g_voteBan
import g_voteNames
import g_mappools
import g_autonextmap
import g_catchup
import g_runes
import g_awardpushing
import g_elimination_ctf_oneway
import g_lms_mode
import g_lms_lives
import g_regen
import g_vampireMaxHealth
import g_vampire
import g_instantgib
import g_rockets
import g_elimination_lockspectator
import g_elimination_items
import g_elimination_nail
import g_elimination_mine
import g_elimination_chain
import g_elimination_plasmagun
import g_elimination_lightning
import g_elimination_railgun
import g_elimination_rocket
import g_elimination_grenade
import g_elimination_shotgun
import g_elimination_machinegun
import g_elimination_allgametypes
import g_elimination_activewarmup
import g_elimination_warmup
import g_elimination_roundtime
import g_elimination_bfg
import g_elimination_startArmor
import g_elimination_startHealth
import g_elimination_selfdamage
import g_spawnprotect
import g_music
import g_localTeamPref
import g_proxMineTimeout
import g_enableBreath
import g_enableDust
import g_rankings
import pmove_float
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_votecustom
import g_votemaps
import g_motdfile
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_respawntime
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_damageModifier
import g_gravityModifier
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_voteflags
import g_elimflags
import g_videoflags
import g_dmflags
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_poweruprespawn
import g_megahealthrespawn
import g_holdablerespawn
import g_ammorespawn
import g_healthrespawn
import g_armorrespawn
import g_ammolimit
import g_lavadamage
import g_drowndamage
import g_spawnselect
import g_speedfactor
import g_jumpheight
import g_respawnwait
import g_armorprotect
import g_medkitmodifier
import g_hastefirespeed
import g_autoflagreturn
import g_droppeditemtime
import g_poweruptime
import g_slowhealthregen
import g_fasthealthregen
import g_invultime
import g_ammoregenspeedfactor
import g_ammoregendamagefactor
import g_ammoregen_infammo
import g_ammoregenfirespeed
import g_guardspeedfactor
import g_guarddamagefactor
import g_guardfirespeed
import g_guardhealthmodifier
import g_doublerspeedfactor
import g_doublerdamagefactor
import g_doublerfirespeed
import g_scoutdamagefactor
import g_scoutfirespeed
import g_scoutspeedfactor
import g_cginf
import g_cgvampire
import g_cgspread
import g_cgdamage
import g_cgdelay
import g_plinf
import g_plvampire
import g_plgravity
import g_pldamage
import g_plsdamage
import g_plsradius
import g_pltimeout
import g_plspeed
import g_pldelay
import g_nginf
import g_ngvampire
import g_nggravity
import g_ngbounce
import g_ngcount
import g_ngtimeout
import g_ngdamage
import g_ngspread
import g_ngspeed
import g_ngdelay
import g_bfginf
import g_bfgvampire
import g_bfggravity
import g_bfgbounce
import g_bfgdamage
import g_bfgsdamage
import g_bfgsradius
import g_bfgtimeout
import g_bfgspeed
import g_bfgdelay
import g_pginf
import g_pgvampire
import g_pggravity
import g_pgbounce
import g_pgtimeout
import g_pgdamage
import g_pgsdamage
import g_pgspeed
import g_pgsradius
import g_pgdelay
import g_rginf
import g_rgvampire
import g_rgdamage
import g_rgdelay
import g_lginf
import g_lgvampire
import g_lgrange
import g_lgdelay
import g_lgdamage
import g_rlinf
import g_rlvampire
import g_rlgravity
import g_rlbounce
import g_rldamage
import g_rlsdamage
import g_rlsradius
import g_rltimeout
import g_rlspeed
import g_rldelay
import g_glinf
import g_glvampire
import g_glgravity
import g_glbounce
import g_gldamage
import g_glsdamage
import g_glsradius
import g_gltimeout
import g_glspeed
import g_gldelay
import g_sginf
import g_sgvampire
import g_sgcount
import g_sgspread
import g_sgdamage
import g_sgdelay
import g_mginf
import g_mgvampire
import g_mgspread
import g_mgdamage
import g_mgdelay
import g_grange
import g_gdamage
import g_gdelay
import mod_ghtimeout
import g_ghtimeout
import g_ghspeed
import mod_doublerfirespeed
import mod_guardfirespeed
import mod_poweruptime
import mod_scoutfirespeed
import mod_ammoregenfirespeed
import mod_hastefirespeed
import mod_vampire_max_health
import mod_cgspread
import mod_cgdelay
import mod_pldelay
import mod_ngdelay
import mod_bfgdelay
import mod_rgdelay
import mod_pgdelay
import mod_lgrange
import mod_lgdelay
import mod_rldelay
import mod_gldelay
import mod_sgcount
import mod_sgspread
import mod_sgdelay
import mod_mgspread
import mod_mgdelay
import mod_gdelay
import mod_jumpheight
import mod_ammolimit
import Newmodcommands
import nailgun_think
import bfg_think
import grenade_think
import rocket_think
import plasma_think
import G_SendWeaponProperties
import g_entities
import level
import Team_ForceGesture
import Team_DD_bonusAtPoints
import Team_RemoveDoubleDominationPoints
import Team_SpawnDoubleDominationPoints
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import Team_Dom_SpawnPoints
import SelectDominationSpawnPoint
import SelectDoubleDominationSpawnPoint
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import getCustomVote
import VoteParseCustomVotes
import allowedFraglimit
import allowedTimelimit
import allowedGametype
import allowedMap
import getMappage
import custom_vote_info
import whiteListedStr
import ClientLeaving
import CountVotes
import CheckVote
import allowedVote
import Possession_TouchFlag
import Possession_SpawnFlag
import PlayerStore_restore
import PlayerStore_store
import PlayerStoreInit
import LogAcc
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import Team_SetFlagStatus
import SelectRandomEntity
import SelectRandomEntityFilter
import G_TeamFromString
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import CheckTeamVote
import LogExit
import G_Error
import G_Printf
import SendYourTeamMessageToTeam
import SendDominationPointsStatusMessageToAllClients
import SendDDtimetakenMessageToAllClients
import SendEliminationMessageToAllClients
import SendScoreboardMessageToAllClients
import G_LogPrintf
import ExitLevel
import AddTournamentQueue
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import SendCustomVoteCommands
import ChallengeMessage
import DominationPointStatusMessage
import DominationPointNamesMessage
import RespawnTimeMessage
import EliminationMessage
import DeathmatchScoreboardMessage
import ObeliskHealthMessage
import AttackingTeamMessage
import YourTeamMessage
import DoubleDominationScoreTimeMessage
import G_SetStats
import MoveClientToIntermission
import G_StartKamikaze
import FireWeapon
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import ClientRespawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import LMSpoint
import EndEliminationRound
import DisableWeapons
import EnableWeapons
import RespawnDead
import RespawnAll
import TeamHumanParticipantsCount
import TeamLivingHumanCount
import TeamHealthCount
import TeamLivingCount
import TeamCount
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import MinSpawnpointCount
import DropPortalDestination
import DropPortalSource
import TeleportPlayer
import trigger_teleporter_touch
import MatchTeam
import Touch_DoorTrigger
import G_RunMover
import fire_prox
import fire_nail
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import ProximityMine_RemoveAll
import G_RunMissile
import TossClientCubes
import TossClientCubesValues
import TossClientPersistantPowerups
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_GlobalSound
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import writeFile_string
import writeFile_int
import readFile_string
import readFile_int
import WarmupEliminationRound
import StartLMSRound
import SendAttackingTeamMessageToAllClients
import RestartEliminationRound
import CheckLMS
import CheckElimination
import SanitizeString
import G_ClientIsLagging
import G_ClientNumberFromString
import Cmd_AdminMessage_f
import G_FloodLimited
import G_ClientNumbersFromString
import G_SanitiseString
import G_MatchOnePlayer
import G_DecolorString
import G_SayConcatArgs
import G_SayArgv
import G_SayArgc
import G_Say
import ConcatArgs
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import enableq
import MapInfoGet
import MatchesGametype
import BG_TeamName
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_DefragmentMemory
import BG_Free
import BG_InitMemory
import BG_Alloc
import BG_CanAlloc
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import Com_TruncateLongString
import va
import Q_CountChar
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_stristr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Q_StrToLower
import Com_RandomBytes
import Com_SkipCharset
import Com_SkipTokens
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_GetExtension
import COM_SkipPath
import Com_Clamp
import Q_isnan
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoundsIntersectPoint
import BoundsIntersectSphere
import BoundsIntersect
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import Q_snprintf
import Q_vsnprintf
import strtol
import _atoi
import atoi
import strtod
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strrchr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $304
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $286
byte 1 101
byte 1 110
byte 1 100
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $285
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $284
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $283
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $282
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $281
byte 1 99
byte 1 112
byte 1 0
align 1
LABELV $280
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 117
byte 1 115
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $279
byte 1 101
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $278
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $277
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $276
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $275
byte 1 97
byte 1 100
byte 1 100
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $274
byte 1 97
byte 1 98
byte 1 111
byte 1 114
byte 1 116
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $273
byte 1 98
byte 1 111
byte 1 116
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $272
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $271
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $270
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $269
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $266
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $265
byte 1 75
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 45
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $264
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $261
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $249
byte 1 85
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $239
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $236
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $228
byte 1 10
byte 1 0
align 1
LABELV $227
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $223
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $222
byte 1 69
byte 1 84
byte 1 95
byte 1 71
byte 1 82
byte 1 65
byte 1 80
byte 1 80
byte 1 76
byte 1 69
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $220
byte 1 69
byte 1 84
byte 1 95
byte 1 73
byte 1 78
byte 1 86
byte 1 73
byte 1 83
byte 1 73
byte 1 66
byte 1 76
byte 1 69
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $218
byte 1 69
byte 1 84
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 32
byte 1 0
align 1
LABELV $216
byte 1 69
byte 1 84
byte 1 95
byte 1 80
byte 1 85
byte 1 83
byte 1 72
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $214
byte 1 69
byte 1 84
byte 1 95
byte 1 83
byte 1 80
byte 1 69
byte 1 65
byte 1 75
byte 1 69
byte 1 82
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $212
byte 1 69
byte 1 84
byte 1 95
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 65
byte 1 76
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $210
byte 1 69
byte 1 84
byte 1 95
byte 1 66
byte 1 69
byte 1 65
byte 1 77
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $208
byte 1 69
byte 1 84
byte 1 95
byte 1 77
byte 1 79
byte 1 86
byte 1 69
byte 1 82
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $206
byte 1 69
byte 1 84
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $204
byte 1 69
byte 1 84
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $202
byte 1 69
byte 1 84
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $200
byte 1 69
byte 1 84
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $195
byte 1 37
byte 1 51
byte 1 105
byte 1 58
byte 1 0
align 1
LABELV $186
byte 1 68
byte 1 105
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $185
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $173
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 32
byte 1 115
byte 1 118
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 105
byte 1 112
byte 1 32
byte 1 60
byte 1 105
byte 1 112
byte 1 45
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $169
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 105
byte 1 112
byte 1 32
byte 1 60
byte 1 105
byte 1 112
byte 1 45
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $148
byte 1 73
byte 1 80
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $108
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 110
byte 1 73
byte 1 80
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 110
byte 1 73
byte 1 80
byte 1 115
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 67
byte 1 86
byte 1 65
byte 1 82
byte 1 95
byte 1 86
byte 1 65
byte 1 76
byte 1 85
byte 1 69
byte 1 95
byte 1 83
byte 1 84
byte 1 82
byte 1 73
byte 1 78
byte 1 71
byte 1 10
byte 1 0
align 1
LABELV $101
byte 1 32
byte 1 0
align 1
LABELV $100
byte 1 46
byte 1 0
align 1
LABELV $99
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $98
byte 1 42
byte 1 0
align 1
LABELV $76
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
