export Team_InitGame
code
proc Team_InitGame 8 12
file "../../../code/game/g_team.c"
line 53
;1:/*
;2:===========================================================================
;3:Copyright (C) 1999-2005 Id Software, Inc.
;4:
;5:This file is part of Open Arena source code.
;6:Portions copied from Tremulous under GPL version 2 including any later version.
;7:
;8:Open Arena source code is free software; you can redistribute it
;9:and/or modify it under the terms of the GNU General Public License as
;10:published by the Free Software Foundation; either version 2 of the License,
;11:or (at your option) any later version.
;12:
;13:Open Arena source code is distributed in the hope that it will be
;14:useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;15:MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;16:GNU General Public License for more details.
;17:
;18:You should have received a copy of the GNU General Public License
;19:along with Open Arena source code; if not, write to the Free Software
;20:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;21:===========================================================================
;22:*/
;23://
;24:
;25:#include "g_local.h"
;26:
;27:
;28:typedef struct teamgame_s {
;29:	float			last_flag_capture;
;30:	int				last_capture_team;
;31:	flagStatus_t	redStatus;	// CTF
;32:	flagStatus_t	blueStatus;	// CTF
;33:	flagStatus_t	flagStatus;	// One Flag CTF
;34:	int				redTakenTime;
;35:	int				blueTakenTime;
;36:	int				redObeliskAttackedTime;
;37:	int				blueObeliskAttackedTime;
;38:} teamgame_t;
;39:
;40:teamgame_t teamgame;
;41:
;42:gentity_t	*neutralObelisk;
;43:
;44://Some pointers for Double Domination so we don't need GFind (I think it might crash at random times...)
;45:gentity_t	*ddA;
;46:gentity_t	*ddB;
;47://Pointers for Standard Domination
;48:gentity_t	*dom_points[MAX_DOMINATION_POINTS];
;49:
;50:qboolean dominationPointsSpawned;
;51:
;52:void Team_InitGame( void )
;53:{
line 54
;54:	memset(&teamgame, 0, sizeof teamgame);
ADDRGP4 teamgame
ARGP4
CNSTI4 0
ARGI4
CNSTI4 36
ARGI4
ADDRGP4 memset
CALLP4
pop
line 56
;55:
;56:	switch( g_gametype.integer ) {
ADDRLP4 0
ADDRGP4 g_gametype+12
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $62
ADDRLP4 0
INDIRI4
CNSTI4 13
GTI4 $62
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $70-16
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $70
address $64
address $68
address $62
address $62
address $62
address $64
address $62
address $64
address $67
address $68
code
LABELV $64
line 60
;57:	case GT_CTF:
;58:	case GT_CTF_ELIMINATION:
;59:	case GT_DOUBLE_D:
;60:		teamgame.redStatus = -1; // Invalid to force update
ADDRGP4 teamgame+8
CNSTI4 -1
ASGNI4
line 61
;61:		Team_SetFlagStatus( TEAM_RED, FLAG_ATBASE );
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 62
;62:		teamgame.blueStatus = -1; // Invalid to force update
ADDRGP4 teamgame+12
CNSTI4 -1
ASGNI4
line 63
;63:		Team_SetFlagStatus( TEAM_BLUE, FLAG_ATBASE );
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 64
;64:		ddA = NULL;
ADDRGP4 ddA
CNSTP4 0
ASGNP4
line 65
;65:		ddB = NULL;
ADDRGP4 ddB
CNSTP4 0
ASGNP4
line 66
;66:		break;
ADDRGP4 $62
JUMPV
LABELV $67
line 68
;67:	case GT_DOMINATION:
;68:		dominationPointsSpawned = qfalse;
ADDRGP4 dominationPointsSpawned
CNSTI4 0
ASGNI4
line 69
;69:		break;
ADDRGP4 $62
JUMPV
LABELV $68
line 72
;70:	case GT_1FCTF:
;71:	case GT_POSSESSION:
;72:		teamgame.flagStatus = -1; // Invalid to force update
ADDRGP4 teamgame+16
CNSTI4 -1
ASGNI4
line 73
;73:		Team_SetFlagStatus( TEAM_FREE, FLAG_ATBASE );
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 74
;74:		break;
line 76
;75:	default:
;76:		break;
LABELV $62
line 78
;77:	}
;78:}
LABELV $60
endproc Team_InitGame 8 12
export OtherTeam
proc OtherTeam 0 0
line 81
;79:
;80:int OtherTeam(int team)
;81:{
line 82
;82:	if (team==TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $73
line 83
;83:		return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $72
JUMPV
LABELV $73
line 84
;84:	else if (team==TEAM_BLUE)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $75
line 85
;85:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $72
JUMPV
LABELV $75
line 86
;86:	return team;
ADDRFP4 0
INDIRI4
RETI4
LABELV $72
endproc OtherTeam 0 0
export TeamName
proc TeamName 0 0
line 90
;87:}
;88:
;89:const char *TeamName(int team)
;90:{
line 91
;91:	if (team==TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $78
line 92
;92:		return "RED";
ADDRGP4 $80
RETP4
ADDRGP4 $77
JUMPV
LABELV $78
line 93
;93:	else if (team==TEAM_BLUE)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $81
line 94
;94:		return "BLUE";
ADDRGP4 $83
RETP4
ADDRGP4 $77
JUMPV
LABELV $81
line 95
;95:	else if (team==TEAM_SPECTATOR)
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $84
line 96
;96:		return "SPECTATOR";
ADDRGP4 $86
RETP4
ADDRGP4 $77
JUMPV
LABELV $84
line 97
;97:	return "FREE";
ADDRGP4 $87
RETP4
LABELV $77
endproc TeamName 0 0
export OtherTeamName
proc OtherTeamName 0 0
line 101
;98:}
;99:
;100:const char *OtherTeamName(int team)
;101:{
line 102
;102:	if (team==TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $89
line 103
;103:		return "BLUE";
ADDRGP4 $83
RETP4
ADDRGP4 $88
JUMPV
LABELV $89
line 104
;104:	else if (team==TEAM_BLUE)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $91
line 105
;105:		return "RED";
ADDRGP4 $80
RETP4
ADDRGP4 $88
JUMPV
LABELV $91
line 106
;106:	else if (team==TEAM_SPECTATOR)
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $93
line 107
;107:		return "SPECTATOR";
ADDRGP4 $86
RETP4
ADDRGP4 $88
JUMPV
LABELV $93
line 108
;108:	return "FREE";
ADDRGP4 $87
RETP4
LABELV $88
endproc OtherTeamName 0 0
export TeamColorString
proc TeamColorString 0 0
line 112
;109:}
;110:
;111:const char *TeamColorString(int team)
;112:{
line 113
;113:	if (team==TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $96
line 114
;114:		return S_COLOR_RED;
ADDRGP4 $98
RETP4
ADDRGP4 $95
JUMPV
LABELV $96
line 115
;115:	else if (team==TEAM_BLUE)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $99
line 116
;116:		return S_COLOR_BLUE;
ADDRGP4 $101
RETP4
ADDRGP4 $95
JUMPV
LABELV $99
line 117
;117:	else if (team==TEAM_SPECTATOR)
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $102
line 118
;118:		return S_COLOR_YELLOW;
ADDRGP4 $104
RETP4
ADDRGP4 $95
JUMPV
LABELV $102
line 119
;119:	return S_COLOR_WHITE;
ADDRGP4 $105
RETP4
LABELV $95
endproc TeamColorString 0 0
export PrintMsg
proc PrintMsg 1048 16
line 125
;120:}
;121:
;122:// NULL for everyone
;123:void QDECL PrintMsg( gentity_t *ent, const char *fmt, ... ) __attribute__((format(printf,2,3)));
;124:void QDECL PrintMsg( gentity_t *ent, const char *fmt, ... )
;125:{
line 130
;126:	char		msg[1024];
;127:	va_list		argptr;
;128:	char		*p;
;129:
;130:	va_start (argptr,fmt);
ADDRLP4 1028
ADDRFP4 4+4
ASGNP4
line 131
;131:	if (Q_vsnprintf (msg, sizeof(msg), fmt, argptr) >= sizeof(msg)) {
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 Q_vsnprintf
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CVIU4 4
CNSTU4 1024
LTU4 $108
line 132
;132:		G_Error ( "PrintMsg overrun" );
ADDRGP4 $110
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 133
;133:	}
LABELV $108
line 134
;134:	va_end (argptr);
ADDRLP4 1028
CNSTP4 0
ASGNP4
ADDRGP4 $112
JUMPV
LABELV $111
line 138
;135:
;136:	// double quotes are bad
;137:	while ((p = strchr(msg, '"')) != NULL)
;138:		*p = '\'';
ADDRLP4 0
INDIRP4
CNSTI1 39
ASGNI1
LABELV $112
line 137
ADDRLP4 4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 1036
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1036
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $111
line 140
;139:
;140:	trap_SendServerCommand ( ( (ent == NULL) ? -1 : ent-g_entities ), va("print \"%s\"", msg ));
ADDRGP4 $115
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1044
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $116
ADDRLP4 1040
CNSTI4 -1
ASGNI4
ADDRGP4 $117
JUMPV
LABELV $116
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ASGNI4
LABELV $117
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 141
;141:}
LABELV $106
endproc PrintMsg 1048 16
export G_TeamFromString
proc G_TeamFromString 32 4
line 151
;142:
;143:/*
;144:================
;145:KK-OAX From Tremulous
;146:G_TeamFromString
;147:Return the team referenced by a string
;148:================
;149:*/
;150:team_t G_TeamFromString( char *str )
;151:{
line 152
;152:	switch( tolower( *str ) ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 12
CNSTI4 98
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $125
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
GTI4 $127
LABELV $126
ADDRLP4 0
INDIRI4
CNSTI4 48
LTI4 $119
ADDRLP4 0
INDIRI4
CNSTI4 51
GTI4 $119
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $128-192
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $128
address $122
address $123
address $124
address $125
code
LABELV $127
ADDRLP4 24
CNSTI4 102
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $123
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $119
LABELV $130
ADDRLP4 0
INDIRI4
CNSTI4 114
EQI4 $124
ADDRLP4 0
INDIRI4
CNSTI4 115
EQI4 $122
ADDRGP4 $119
JUMPV
LABELV $122
line 155
;153:	case '0':
;154:	case 's':
;155:		return TEAM_NONE;
CNSTI4 3
RETI4
ADDRGP4 $118
JUMPV
LABELV $123
line 158
;156:	case '1':
;157:	case 'f':
;158:		return TEAM_FREE;
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $124
line 161
;159:	case '2':
;160:	case 'r':
;161:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $118
JUMPV
LABELV $125
line 164
;162:	case '3':
;163:	case 'b':
;164:		return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $118
JUMPV
LABELV $119
line 166
;165:	default:
;166:		return TEAM_NUM_TEAMS;
CNSTI4 4
RETI4
LABELV $118
endproc G_TeamFromString 32 4
export AddTeamScore
proc AddTeamScore 12 8
line 179
;167:	}
;168:}
;169:
;170:/*
;171:==============
;172:AddTeamScore
;173:
;174: used for gametype > GT_TEAM
;175: for gametype GT_TEAM the level.teamScores is updated in AddScore in g_combat.c
;176:==============
;177:*/
;178:void AddTeamScore(vec3_t origin, int team, int score)
;179:{
line 183
;180:	gentity_t	*te;
;181:
;182:
;183:	if ( g_gametype.integer != GT_DOMINATION ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 12
EQI4 $132
line 184
;184:		te = G_TempEntity(origin, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 185
;185:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 189
;186:
;187:
;188:
;189:		if ( team == TEAM_RED ) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $135
line 190
;190:			if ( level.teamScores[ TEAM_RED ] + score == level.teamScores[ TEAM_BLUE ] ) {
ADDRGP4 level+44+4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRGP4 level+44+8
INDIRI4
NEI4 $137
line 192
;191:				//teams are tied sound
;192:				te->s.eventParm = GTS_TEAMS_ARE_TIED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 12
ASGNI4
line 193
;193:			}
ADDRGP4 $136
JUMPV
LABELV $137
line 194
;194:			else if ( level.teamScores[ TEAM_RED ] <= level.teamScores[ TEAM_BLUE ] &&
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 level+44+8
INDIRI4
GTI4 $143
ADDRGP4 level+44+4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRGP4 level+44+8
INDIRI4
LEI4 $143
line 195
;195:			          level.teamScores[ TEAM_RED ] + score > level.teamScores[ TEAM_BLUE ]) {
line 197
;196:				// red took the lead sound
;197:				te->s.eventParm = GTS_REDTEAM_TOOK_LEAD;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 10
ASGNI4
line 198
;198:			}
ADDRGP4 $136
JUMPV
LABELV $143
line 199
;199:			else {
line 201
;200:				// red scored sound
;201:				te->s.eventParm = GTS_REDTEAM_SCORED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 8
ASGNI4
line 202
;202:			}
line 203
;203:		}
ADDRGP4 $136
JUMPV
LABELV $135
line 204
;204:		else {
line 205
;205:			if ( level.teamScores[ TEAM_BLUE ] + score == level.teamScores[ TEAM_RED ] ) {
ADDRGP4 level+44+8
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRGP4 level+44+4
INDIRI4
NEI4 $153
line 207
;206:				//teams are tied sound
;207:				te->s.eventParm = GTS_TEAMS_ARE_TIED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 12
ASGNI4
line 208
;208:			}
ADDRGP4 $154
JUMPV
LABELV $153
line 209
;209:			else if ( level.teamScores[ TEAM_BLUE ] <= level.teamScores[ TEAM_RED ] &&
ADDRGP4 level+44+8
INDIRI4
ADDRGP4 level+44+4
INDIRI4
GTI4 $159
ADDRGP4 level+44+8
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRGP4 level+44+4
INDIRI4
LEI4 $159
line 210
;210:			          level.teamScores[ TEAM_BLUE ] + score > level.teamScores[ TEAM_RED ]) {
line 212
;211:				// blue took the lead sound
;212:				te->s.eventParm = GTS_BLUETEAM_TOOK_LEAD;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 11
ASGNI4
line 213
;213:			}
ADDRGP4 $160
JUMPV
LABELV $159
line 214
;214:			else {
line 216
;215:				// blue scored sound
;216:				te->s.eventParm = GTS_BLUETEAM_SCORED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 9
ASGNI4
line 217
;217:			}
LABELV $160
LABELV $154
line 218
;218:		}
LABELV $136
line 219
;219:	}
LABELV $132
line 220
;220:	level.teamScores[ team ] += score;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 221
;221:}
LABELV $131
endproc AddTeamScore 12 8
export OnSameTeam
proc OnSameTeam 20 4
line 229
;222:
;223:/*
;224:==============
;225:OnSameTeam
;226:==============
;227:*/
;228:qboolean OnSameTeam( const gentity_t *ent1, const gentity_t *ent2 )
;229:{
line 230
;230:	if ( !ent1->client || !ent2->client ) {
ADDRLP4 0
CNSTI4 516
ASGNI4
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $173
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
NEU4 $171
LABELV $173
line 231
;231:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $170
JUMPV
LABELV $171
line 234
;232:	}
;233:
;234:	if (!G_IsATeamGametype(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $174
line 235
;235:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $170
JUMPV
LABELV $174
line 238
;236:	}
;237:
;238:	if ( ent1->client->sess.sessionTeam == ent2->client->sess.sessionTeam ) {
ADDRLP4 12
CNSTI4 516
ASGNI4
ADDRLP4 16
CNSTI4 1024
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
NEI4 $177
line 239
;239:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $170
JUMPV
LABELV $177
line 242
;240:	}
;241:
;242:	return qfalse;
CNSTI4 0
RETI4
LABELV $170
endproc OnSameTeam 20 4
data
align 1
LABELV ctfFlagStatusRemap
byte 1 48
byte 1 49
byte 1 42
byte 1 42
byte 1 50
align 1
LABELV oneFlagStatusRemap
byte 1 48
byte 1 49
byte 1 50
byte 1 51
byte 1 52
export Team_SetFlagStatus
code
proc Team_SetFlagStatus 20 8
line 250
;243:}
;244:
;245:
;246:static char ctfFlagStatusRemap[] = { '0', '1', '*', '*', '2' };
;247:static char oneFlagStatusRemap[] = { '0', '1', '2', '3', '4' };
;248:
;249:void Team_SetFlagStatus( int team, flagStatus_t status )
;250:{
line 251
;251:	qboolean modified = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 253
;252:
;253:	switch( team ) {
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $192
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $182
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $187
ADDRGP4 $180
JUMPV
LABELV $182
line 255
;254:	case TEAM_RED:	// CTF
;255:		if( teamgame.redStatus != status ) {
ADDRGP4 teamgame+8
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $181
line 256
;256:			teamgame.redStatus = status;
ADDRGP4 teamgame+8
ADDRFP4 4
INDIRI4
ASGNI4
line 257
;257:			modified = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 258
;258:		}
line 259
;259:		break;
ADDRGP4 $181
JUMPV
LABELV $187
line 262
;260:
;261:	case TEAM_BLUE:	// CTF
;262:		if( teamgame.blueStatus != status ) {
ADDRGP4 teamgame+12
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $181
line 263
;263:			teamgame.blueStatus = status;
ADDRGP4 teamgame+12
ADDRFP4 4
INDIRI4
ASGNI4
line 264
;264:			modified = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 265
;265:		}
line 266
;266:		break;
ADDRGP4 $181
JUMPV
LABELV $192
line 269
;267:
;268:	case TEAM_FREE:	// One Flag CTF
;269:		if( teamgame.flagStatus != status ) {
ADDRGP4 teamgame+16
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $181
line 270
;270:			teamgame.flagStatus = status;
ADDRGP4 teamgame+16
ADDRFP4 4
INDIRI4
ASGNI4
line 271
;271:			modified = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 272
;272:		}
line 273
;273:		break;
LABELV $180
LABELV $181
line 277
;274:	}
;275:
;276:
;277:	if( modified ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $197
line 280
;278:		char st[4];
;279:
;280:		if(G_UsesTeamFlags(g_gametype.integer) && !G_UsesTheWhiteFlag(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $199
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $199
line 281
;281:			st[0] = ctfFlagStatusRemap[teamgame.redStatus];
ADDRLP4 8
ADDRGP4 teamgame+8
INDIRI4
ADDRGP4 ctfFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 282
;282:			st[1] = ctfFlagStatusRemap[teamgame.blueStatus];
ADDRLP4 8+1
ADDRGP4 teamgame+12
INDIRI4
ADDRGP4 ctfFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 283
;283:			st[2] = 0;
ADDRLP4 8+2
CNSTI1 0
ASGNI1
line 284
;284:		}
ADDRGP4 $200
JUMPV
LABELV $199
line 285
;285:		else if (g_gametype.integer == GT_DOUBLE_D) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 11
NEI4 $207
line 286
;286:			st[0] = oneFlagStatusRemap[teamgame.redStatus];
ADDRLP4 8
ADDRGP4 teamgame+8
INDIRI4
ADDRGP4 oneFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 287
;287:			st[1] = oneFlagStatusRemap[teamgame.blueStatus];
ADDRLP4 8+1
ADDRGP4 teamgame+12
INDIRI4
ADDRGP4 oneFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 288
;288:			st[2] = 0;
ADDRLP4 8+2
CNSTI1 0
ASGNI1
line 289
;289:		}
ADDRGP4 $208
JUMPV
LABELV $207
line 290
;290:		else {		// GT_1FCTF
line 291
;291:			st[0] = oneFlagStatusRemap[teamgame.flagStatus];
ADDRLP4 8
ADDRGP4 teamgame+16
INDIRI4
ADDRGP4 oneFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 292
;292:			st[1] = 0;
ADDRLP4 8+1
CNSTI1 0
ASGNI1
line 293
;293:		}
LABELV $208
LABELV $200
line 295
;294:
;295:		trap_SetConfigstring( CS_FLAGSTATUS, st );
CNSTI4 23
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 296
;296:	}
LABELV $197
line 297
;297:}
LABELV $179
endproc Team_SetFlagStatus 20 8
export Team_CheckDroppedItem
proc Team_CheckDroppedItem 0 8
line 300
;298:
;299:void Team_CheckDroppedItem( const gentity_t *dropped )
;300:{
line 301
;301:	if( dropped->item->giTag == PW_REDFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $217
line 302
;302:		Team_SetFlagStatus( TEAM_RED, FLAG_DROPPED );
CNSTI4 1
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 303
;303:	}
ADDRGP4 $218
JUMPV
LABELV $217
line 304
;304:	else if( dropped->item->giTag == PW_BLUEFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $219
line 305
;305:		Team_SetFlagStatus( TEAM_BLUE, FLAG_DROPPED );
CNSTI4 2
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 306
;306:	}
ADDRGP4 $220
JUMPV
LABELV $219
line 307
;307:	else if( dropped->item->giTag == PW_NEUTRALFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $221
line 308
;308:		Team_SetFlagStatus( TEAM_FREE, FLAG_DROPPED );
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 309
;309:	}
LABELV $221
LABELV $220
LABELV $218
line 310
;310:}
LABELV $216
endproc Team_CheckDroppedItem 0 8
export Team_ForceGesture
proc Team_ForceGesture 12 0
line 318
;311:
;312:/*
;313:================
;314:Team_ForceGesture
;315:================
;316:*/
;317:void Team_ForceGesture(int team)
;318:{
line 322
;319:	int i;
;320:	gentity_t *ent;
;321:
;322:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $224
line 323
;323:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 324
;324:		if (!ent->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $228
line 325
;325:			continue;
ADDRGP4 $225
JUMPV
LABELV $228
line 326
;326:		if (!ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $230
line 327
;327:			continue;
ADDRGP4 $225
JUMPV
LABELV $230
line 328
;328:		if (ent->client->sess.sessionTeam != team)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $232
line 329
;329:			continue;
ADDRGP4 $225
JUMPV
LABELV $232
line 330
;330:		ent->flags |= FL_FORCE_GESTURE;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 331
;331:	}
LABELV $225
line 322
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $224
line 332
;332:}
LABELV $223
endproc Team_ForceGesture 12 0
export Team_DD_bonusAtPoints
proc Team_DD_bonusAtPoints 100 12
line 342
;333:
;334:/*
;335:================
;336:Team_DD_bonusAtPoints
;337:Adds bonus point to a player if he is close to the point and on the team that scores
;338:================
;339:*/
;340:
;341:void Team_DD_bonusAtPoints(int team)
;342:{
line 347
;343:	vec3_t v1, v2;
;344:	int i;
;345:	gentity_t *player;
;346:
;347:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 28
CNSTI4 0
ASGNI4
LABELV $235
line 348
;348:		player = &g_entities[i];
ADDRLP4 0
CNSTI4 816
ADDRLP4 28
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 349
;349:		if (!player->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $239
line 350
;350:			continue;
ADDRGP4 $236
JUMPV
LABELV $239
line 351
;351:		if (!player->client)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $241
line 352
;352:			continue;
ADDRGP4 $236
JUMPV
LABELV $241
line 354
;353:
;354:		if( player->client->sess.sessionTeam != team )
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $243
line 355
;355:			return; //player was not on scoring team
ADDRGP4 $234
JUMPV
LABELV $243
line 358
;356:
;357:		//See if the player is close to any of the points:
;358:		VectorSubtract(player->r.currentOrigin, ddA->r.currentOrigin, v1);
ADDRLP4 36
CNSTI4 488
ASGNI4
ADDRLP4 40
ADDRGP4 ddA
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
CNSTI4 492
ASGNI4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 496
ASGNI4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRGP4 ddA
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 359
;359:		VectorSubtract(player->r.currentOrigin, ddB->r.currentOrigin, v2);
ADDRLP4 56
CNSTI4 488
ASGNI4
ADDRLP4 60
ADDRGP4 ddB
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
CNSTI4 492
ASGNI4
ADDRLP4 16+4
ADDRLP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 68
CNSTI4 496
ASGNI4
ADDRLP4 16+8
ADDRLP4 0
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ADDRGP4 ddB
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 360
;360:		if (!( ( ( VectorLength(v1) < CTF_TARGET_PROTECT_RADIUS &&
ADDRLP4 4
ARGP4
ADDRLP4 72
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 72
INDIRF4
CNSTF4 1148846080
GEF4 $251
ADDRLP4 76
CNSTI4 488
ASGNI4
ADDRGP4 ddA
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ARGP4
ADDRLP4 80
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
NEI4 $249
LABELV $251
ADDRLP4 16
ARGP4
ADDRLP4 84
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 84
INDIRF4
CNSTF4 1148846080
GEF4 $252
ADDRLP4 88
CNSTI4 488
ASGNI4
ADDRGP4 ddB
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
ARGP4
ADDRLP4 92
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $249
LABELV $252
line 364
;361:		           trap_InPVS(ddA->r.currentOrigin, player->r.currentOrigin ) ) ||
;362:		         ( VectorLength(v2) < CTF_TARGET_PROTECT_RADIUS &&
;363:		           trap_InPVS(ddB->r.currentOrigin, player->r.currentOrigin ) ) )))
;364:			return; //Wasn't close to any of the points
ADDRGP4 $234
JUMPV
LABELV $249
line 366
;365:
;366:		AddScore(player, player->r.currentOrigin, DD_AT_POINT_AT_CAPTURE);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 367
;367:	}
LABELV $236
line 347
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 64
LTI4 $235
line 368
;368:}
LABELV $234
endproc Team_DD_bonusAtPoints 100 12
export Team_FragBonuses
proc Team_FragBonuses 288 40
line 380
;369:
;370:/*
;371:================
;372:Team_FragBonuses
;373:
;374:Calculate the bonuses for flag defense, flag carrier defense, etc.
;375:Note that bonuses are not cumulative.  You get one, they are in importance
;376:order.
;377:================
;378:*/
;379:void Team_FragBonuses(gentity_t *targ, gentity_t *inflictor, gentity_t *attacker)
;380:{
line 386
;381:	int i;
;382:	gentity_t *ent;
;383:	int flag_pw, enemy_flag_pw;
;384:	int otherteam;
;385:	int tokens;
;386:	gentity_t *flag, *carrier = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 392
;387:	char *c;
;388:	vec3_t v1, v2;
;389:	int team;
;390:
;391:	// no bonus for fragging yourself or team mates
;392:	if (!targ->client || !attacker->client || targ == attacker || OnSameTeam(targ, attacker))
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 516
ASGNI4
ADDRLP4 72
CNSTU4 0
ASGNU4
ADDRLP4 64
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRU4
EQU4 $258
ADDRLP4 76
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRU4
EQU4 $258
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRLP4 76
INDIRP4
CVPU4 4
EQU4 $258
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $254
LABELV $258
line 393
;393:		return;
ADDRGP4 $253
JUMPV
LABELV $254
line 395
;394:
;395:	team = targ->client->sess.sessionTeam;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 396
;396:	otherteam = OtherTeam(targ->client->sess.sessionTeam);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 84
INDIRI4
ASGNI4
line 397
;397:	if (otherteam < 0)
ADDRLP4 16
INDIRI4
CNSTI4 0
GEI4 $259
line 398
;398:		return; // whoever died isn't on a team
ADDRGP4 $253
JUMPV
LABELV $259
line 401
;399:
;400:	// same team, if the flag at base, check to he has the enemy flag
;401:	if (team == TEAM_RED) {
ADDRLP4 48
INDIRI4
CNSTI4 1
NEI4 $261
line 402
;402:		flag_pw = PW_REDFLAG;
ADDRLP4 52
CNSTI4 7
ASGNI4
line 403
;403:		enemy_flag_pw = PW_BLUEFLAG;
ADDRLP4 60
CNSTI4 8
ASGNI4
line 404
;404:	}
ADDRGP4 $262
JUMPV
LABELV $261
line 405
;405:	else {
line 406
;406:		flag_pw = PW_BLUEFLAG;
ADDRLP4 52
CNSTI4 8
ASGNI4
line 407
;407:		enemy_flag_pw = PW_REDFLAG;
ADDRLP4 60
CNSTI4 7
ASGNI4
line 408
;408:	}
LABELV $262
line 410
;409:
;410:	if (G_UsesTheWhiteFlag(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $263
line 411
;411:		flag_pw = PW_NEUTRALFLAG;
ADDRLP4 52
CNSTI4 9
ASGNI4
line 412
;412:		enemy_flag_pw = PW_NEUTRALFLAG;
ADDRLP4 60
CNSTI4 9
ASGNI4
line 413
;413:	}
LABELV $263
line 416
;414:
;415:	// did the attacker frag the flag carrier?
;416:	tokens = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 417
;417:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $266
line 418
;418:		tokens = targ->client->ps.generic1;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 419
;419:	}
LABELV $266
line 420
;420:	if (targ->client->ps.powerups[enemy_flag_pw]) {
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $269
line 421
;421:		attacker->client->pers.teamState.lastfraggedcarrier = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 600
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 422
;422:		if (g_gametype.integer != GT_POSSESSION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
EQI4 $272
line 423
;423:			AddScore(attacker, targ->r.currentOrigin, CTF_FRAG_CARRIER_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 424
;424:		}
LABELV $272
line 425
;425:		attacker->client->pers.teamState.fragcarrier++;
ADDRLP4 92
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 580
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 426
;426:		if (g_gametype.integer != GT_POSSESSION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
EQI4 $275
line 427
;427:			PrintMsg(NULL, "%s" S_COLOR_WHITE " fragged %s's flag carrier!\n",
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $278
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 429
;428:			         attacker->client->pers.netname, TeamName(team));
;429:		}
ADDRGP4 $276
JUMPV
LABELV $275
line 430
;430:		else {
line 431
;431:			PrintMsg(NULL, "%s" S_COLOR_WHITE " fragged the flag carrier!\n",
CNSTP4 0
ARGP4
ADDRGP4 $279
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 433
;432:			         attacker->client->pers.netname);
;433:			G_LogPrintf("POS: %i %i: %s^7 fragged the carrier\n", attacker->s.number, 2, attacker->client->pers.netname);
ADDRGP4 $280
ARGP4
ADDRLP4 96
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 434
;434:		}
LABELV $276
line 435
;435:		if(g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $281
line 436
;436:			G_LogPrintf( "CTF: %i %i %i: %s fragged %s's flag carrier!\n", attacker->client->ps.clientNum, team, 3, attacker->client->pers.netname, TeamName(team) );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $284
ARGP4
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 100
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 437
;437:		}
ADDRGP4 $282
JUMPV
LABELV $281
line 438
;438:		else if(g_gametype.integer == GT_CTF_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $285
line 439
;439:			G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s fragged %s's flag carrier!\n", level.roundNumber, attacker->client->ps.clientNum, team, 3, attacker->client->pers.netname, TeamName(team) );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $288
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 100
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 440
;440:		}
ADDRGP4 $286
JUMPV
LABELV $285
line 441
;441:		else if(g_gametype.integer == GT_1FCTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $290
line 442
;442:			G_LogPrintf( "1fCTF: %i %i %i: %s fragged %s's flag carrier!\n", attacker->client->ps.clientNum, team, 3, attacker->client->pers.netname, TeamName(team) );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $293
ARGP4
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 100
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 443
;443:		}
LABELV $290
LABELV $286
LABELV $282
line 448
;444:
;445:
;446:		// the target had the flag, clear the hurt carrier
;447:		// field on the other team
;448:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $297
JUMPV
LABELV $294
line 449
;449:			ent = g_entities + i;
ADDRLP4 8
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 450
;450:			if (ent->inuse && ent->client->sess.sessionTeam == otherteam)
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $299
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $299
line 451
;451:				ent->client->pers.teamState.lasthurtcarrier = 0;
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 588
ADDP4
CNSTF4 0
ASGNF4
LABELV $299
line 452
;452:		}
LABELV $295
line 448
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $297
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $294
line 453
;453:		return;
ADDRGP4 $253
JUMPV
LABELV $269
line 457
;454:	}
;455:
;456:	// did the attacker frag a head carrier? other->client->ps.generic1
;457:	if (tokens) {
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $301
line 458
;458:		attacker->client->pers.teamState.lastfraggedcarrier = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 600
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 459
;459:		AddScore(attacker, targ->r.currentOrigin, CTF_FRAG_CARRIER_BONUS * tokens * tokens);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 56
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 56
INDIRI4
MULI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 460
;460:		attacker->client->pers.teamState.fragcarrier++;
ADDRLP4 96
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 580
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 461
;461:		PrintMsg(NULL, "%s" S_COLOR_WHITE " fragged %s's skull carrier!\n",
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $304
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 464
;462:		         attacker->client->pers.netname, TeamName(team));
;463:
;464:		G_LogPrintf("HARVESTER: %i %i %i %i %i: %s fragged %s (%s) who had %i skulls.\n",
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $305
ARGP4
ADDRLP4 108
CNSTI4 516
ASGNI4
ADDRLP4 112
ADDRFP4 8
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 116
CNSTI4 140
ASGNI4
ADDRLP4 112
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 120
ADDRFP4 0
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 128
CNSTI4 512
ASGNI4
ADDRLP4 112
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
ARGP4
ADDRLP4 120
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 470
;465:		            attacker->client->ps.clientNum, team, 1, targ->client->ps.clientNum, tokens,
;466:		            attacker->client->pers.netname, targ->client->pers.netname,TeamName(team),tokens);
;467:
;468:		// the target had the flag, clear the hurt carrier
;469:		// field on the other team
;470:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $309
JUMPV
LABELV $306
line 471
;471:			ent = g_entities + i;
ADDRLP4 8
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 472
;472:			if (ent->inuse && ent->client->sess.sessionTeam == otherteam)
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $311
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $311
line 473
;473:				ent->client->pers.teamState.lasthurtcarrier = 0;
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 588
ADDP4
CNSTF4 0
ASGNF4
LABELV $311
line 474
;474:		}
LABELV $307
line 470
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $309
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $306
line 475
;475:		return;
ADDRGP4 $253
JUMPV
LABELV $301
line 478
;476:	}
;477:
;478:	if (targ->client->pers.teamState.lasthurtcarrier &&
ADDRLP4 92
CNSTI4 516
ASGNI4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRP4
CNSTI4 588
ADDP4
INDIRF4
ASGNF4
ADDRLP4 96
INDIRF4
CNSTF4 0
EQF4 $313
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRLP4 96
INDIRF4
SUBF4
CNSTF4 1174011904
GEF4 $313
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $313
line 480
;479:	        level.time - targ->client->pers.teamState.lasthurtcarrier < CTF_CARRIER_DANGER_PROTECT_TIMEOUT &&
;480:	        !attacker->client->ps.powerups[flag_pw]) {
line 483
;481:		// attacker is on the same team as the flag carrier and
;482:		// fragged a guy who hurt our flag carrier
;483:		AddScore(attacker, targ->r.currentOrigin, CTF_CARRIER_DANGER_PROTECT_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 485
;484:
;485:		attacker->client->pers.teamState.carrierdefense++;
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 572
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 486
;486:		targ->client->pers.teamState.lasthurtcarrier = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 588
ADDP4
CNSTF4 0
ASGNF4
line 488
;487:
;488:		attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 104
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 489
;489:		G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", attacker->client->ps.clientNum, 3, attacker->client->pers.netname, "DEFENCE" );
ADDRGP4 $316
ARGP4
ADDRLP4 108
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 108
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $317
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 490
;490:		if(!level.hadBots)
ADDRGP4 level+9436
INDIRI4
CNSTI4 0
NEI4 $318
line 491
;491:			ChallengeMessage(attacker,AWARD_DEFENCE);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 305
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
LABELV $318
line 492
;492:		team = attacker->client->sess.sessionTeam;
ADDRLP4 48
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 494
;493:		// add the sprite over the player's head
;494:		attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 112
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 495
;495:		attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 116
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 496
;496:		attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 498
;497:
;498:		return;
ADDRGP4 $253
JUMPV
LABELV $313
line 501
;499:	}
;500://We place the Double Domination bonus test here! This appears to be the best place to place them.
;501:	if ( g_gametype.integer == GT_DOUBLE_D ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 11
NEI4 $322
line 502
;502:		if(attacker->client->sess.sessionTeam == level.pointStatusA ) { //Attack must defend point A
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRGP4 level+9264
INDIRI4
NEI4 $325
line 504
;503:			//See how close attacker and target was to Point A:
;504:			VectorSubtract(targ->r.currentOrigin, ddA->r.currentOrigin, v1);
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
CNSTI4 488
ASGNI4
ADDRLP4 108
ADDRGP4 ddA
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 100
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRF4
ADDRLP4 108
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112
CNSTI4 492
ASGNI4
ADDRLP4 24+4
ADDRLP4 100
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRF4
ADDRLP4 108
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 116
CNSTI4 496
ASGNI4
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRF4
ADDRGP4 ddA
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 505
;505:			VectorSubtract(attacker->r.currentOrigin, ddA->r.currentOrigin, v2);
ADDRLP4 120
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 124
CNSTI4 488
ASGNI4
ADDRLP4 128
ADDRGP4 ddA
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 120
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRF4
ADDRLP4 128
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 132
CNSTI4 492
ASGNI4
ADDRLP4 36+4
ADDRLP4 120
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
INDIRF4
ADDRLP4 128
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136
CNSTI4 496
ASGNI4
ADDRLP4 36+8
ADDRFP4 8
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
ADDRGP4 ddA
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 507
;506:
;507:			if ( ( ( VectorLength(v1) < CTF_TARGET_PROTECT_RADIUS &&
ADDRLP4 24
ARGP4
ADDRLP4 140
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1148846080
GEF4 $335
ADDRLP4 144
CNSTI4 488
ASGNI4
ADDRGP4 ddA
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
ARGP4
ADDRLP4 148
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $334
LABELV $335
ADDRLP4 36
ARGP4
ADDRLP4 152
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 1148846080
GEF4 $332
ADDRLP4 156
CNSTI4 488
ASGNI4
ADDRGP4 ddA
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
ARGP4
ADDRLP4 160
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $332
LABELV $334
ADDRLP4 164
CNSTI4 516
ASGNI4
ADDRLP4 168
CNSTI4 1024
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRI4
EQI4 $332
line 511
;508:			         trap_InPVS(ddA->r.currentOrigin, targ->r.currentOrigin ) ) ||
;509:			        ( VectorLength(v2) < CTF_TARGET_PROTECT_RADIUS &&
;510:			          trap_InPVS(ddA->r.currentOrigin, attacker->r.currentOrigin ) ) ) &&
;511:			        attacker->client->sess.sessionTeam != targ->client->sess.sessionTeam) {
line 515
;512:
;513:				//We defended point A
;514:				//Was we dominating and maybe close to score?
;515:				if(attacker->client->sess.sessionTeam == level.pointStatusB && level.time - level.timeTaken > (g_ddCaptureTime.integer-DD_CLOSE)*1000)
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRGP4 level+9268
INDIRI4
NEI4 $336
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9272
INDIRI4
SUBI4
CNSTI4 1000
ADDRGP4 g_ddCaptureTime+12
INDIRI4
MULI4
CNSTI4 3000
SUBI4
LEI4 $336
line 516
;516:					AddScore(attacker, targ->r.currentOrigin, DD_POINT_DEFENCE_CLOSE_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 AddScore
CALLV
pop
ADDRGP4 $337
JUMPV
LABELV $336
line 518
;517:				else
;518:					AddScore(attacker, targ->r.currentOrigin, DD_POINT_DEFENCE_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
LABELV $337
line 519
;519:				attacker->client->pers.teamState.basedefense++;
ADDRLP4 172
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 568
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 521
;520:
;521:				attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 176
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 522
;522:				G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", attacker->client->ps.clientNum, 3, attacker->client->pers.netname, "DEFENCE" );
ADDRGP4 $316
ARGP4
ADDRLP4 180
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 180
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 180
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $317
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 523
;523:				if(!level.hadBots)
ADDRGP4 level+9436
INDIRI4
CNSTI4 0
NEI4 $342
line 524
;524:					ChallengeMessage(attacker,AWARD_DEFENCE);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 305
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
LABELV $342
line 526
;525:				// add the sprite over the player's head
;526:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 184
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 184
INDIRP4
ADDRLP4 184
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 527
;527:				attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 188
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 528
;528:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 530
;529:
;530:				return; //Return so we don't recieve credits for point B also
ADDRGP4 $253
JUMPV
LABELV $332
line 536
;531:
;532:			} //We denfended point A
;533:
;534:
;535:
;536:		} //Defend point A
LABELV $325
line 538
;537:
;538:		if(attacker->client->sess.sessionTeam == level.pointStatusB ) { //Attack must defend point B
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRGP4 level+9268
INDIRI4
NEI4 $253
line 540
;539:			//See how close attacker and target was to Point B:
;540:			VectorSubtract(targ->r.currentOrigin, ddB->r.currentOrigin, v1);
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
CNSTI4 488
ASGNI4
ADDRLP4 108
ADDRGP4 ddB
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 100
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRF4
ADDRLP4 108
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112
CNSTI4 492
ASGNI4
ADDRLP4 24+4
ADDRLP4 100
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRF4
ADDRLP4 108
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 116
CNSTI4 496
ASGNI4
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRF4
ADDRGP4 ddB
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 541
;541:			VectorSubtract(attacker->r.currentOrigin, ddB->r.currentOrigin, v2);
ADDRLP4 120
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 124
CNSTI4 488
ASGNI4
ADDRLP4 128
ADDRGP4 ddB
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 120
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRF4
ADDRLP4 128
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 132
CNSTI4 492
ASGNI4
ADDRLP4 36+4
ADDRLP4 120
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
INDIRF4
ADDRLP4 128
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136
CNSTI4 496
ASGNI4
ADDRLP4 36+8
ADDRFP4 8
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
ADDRGP4 ddB
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 543
;542:
;543:			if ( ( ( VectorLength(v1) < CTF_TARGET_PROTECT_RADIUS &&
ADDRLP4 24
ARGP4
ADDRLP4 140
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1148846080
GEF4 $356
ADDRLP4 144
CNSTI4 488
ASGNI4
ADDRGP4 ddB
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
ARGP4
ADDRLP4 148
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $355
LABELV $356
ADDRLP4 36
ARGP4
ADDRLP4 152
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 1148846080
GEF4 $253
ADDRLP4 156
CNSTI4 488
ASGNI4
ADDRGP4 ddB
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
ARGP4
ADDRLP4 160
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $253
LABELV $355
ADDRLP4 164
CNSTI4 516
ASGNI4
ADDRLP4 168
CNSTI4 1024
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRI4
EQI4 $253
line 547
;544:			         trap_InPVS(ddB->r.currentOrigin, targ->r.currentOrigin ) ) ||
;545:			        ( VectorLength(v2) < CTF_TARGET_PROTECT_RADIUS &&
;546:			          trap_InPVS(ddB->r.currentOrigin, attacker->r.currentOrigin ) ) ) &&
;547:			        attacker->client->sess.sessionTeam != targ->client->sess.sessionTeam) {
line 551
;548:
;549:				//We defended point B
;550:				//Was we dominating and maybe close to score?
;551:				if(attacker->client->sess.sessionTeam == level.pointStatusA && level.time - level.timeTaken > (g_ddCaptureTime.integer-DD_CLOSE)*1000)
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRGP4 level+9264
INDIRI4
NEI4 $357
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9272
INDIRI4
SUBI4
CNSTI4 1000
ADDRGP4 g_ddCaptureTime+12
INDIRI4
MULI4
CNSTI4 3000
SUBI4
LEI4 $357
line 552
;552:					AddScore(attacker, targ->r.currentOrigin, DD_POINT_DEFENCE_CLOSE_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 AddScore
CALLV
pop
ADDRGP4 $358
JUMPV
LABELV $357
line 554
;553:				else
;554:					AddScore(attacker, targ->r.currentOrigin, DD_POINT_DEFENCE_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
LABELV $358
line 555
;555:				attacker->client->pers.teamState.basedefense++;
ADDRLP4 172
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 568
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 557
;556:
;557:				attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 176
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 558
;558:				if(!level.hadBots)
ADDRGP4 level+9436
INDIRI4
CNSTI4 0
NEI4 $363
line 559
;559:					ChallengeMessage(attacker,AWARD_DEFENCE);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 305
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
LABELV $363
line 560
;560:				G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", attacker->client->ps.clientNum, 3, attacker->client->pers.netname, "DEFENCE" );
ADDRGP4 $316
ARGP4
ADDRLP4 180
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 180
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 180
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $317
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 562
;561:				// add the sprite over the player's head
;562:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 184
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 184
INDIRP4
ADDRLP4 184
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 563
;563:				attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 188
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 564
;564:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 566
;565:
;566:				return;
ADDRGP4 $253
JUMPV
line 572
;567:
;568:			} //We denfended point B
;569:
;570:
;571:
;572:		} //Defend point B
line 573
;573:		return; //In double Domination we shall not go on, or we would test for team bases that we don't use
LABELV $322
line 580
;574:	}
;575:
;576:	// flag and flag carrier area defense bonuses
;577:
;578:	// we have to find the flag and carrier entities
;579:
;580:	if( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $367
line 582
;581:		// find the team obelisk
;582:		switch (attacker->client->sess.sessionTeam) {
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 1
EQI4 $373
ADDRLP4 100
INDIRI4
CNSTI4 2
EQI4 $375
ADDRGP4 $253
JUMPV
LABELV $373
line 584
;583:		case TEAM_RED:
;584:			c = "team_redobelisk";
ADDRLP4 20
ADDRGP4 $374
ASGNP4
line 585
;585:			break;
ADDRGP4 $368
JUMPV
LABELV $375
line 587
;586:		case TEAM_BLUE:
;587:			c = "team_blueobelisk";
ADDRLP4 20
ADDRGP4 $376
ASGNP4
line 588
;588:			break;
line 590
;589:		default:
;590:			return;
line 593
;591:		}
;592:
;593:	}
ADDRGP4 $368
JUMPV
LABELV $367
line 594
;594:	else if (g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $377
line 596
;595:		// find the center obelisk
;596:		c = "team_neutralobelisk";
ADDRLP4 20
ADDRGP4 $380
ASGNP4
line 597
;597:	}
ADDRGP4 $378
JUMPV
LABELV $377
line 598
;598:	else {
line 600
;599:		// find the flag
;600:		switch (attacker->client->sess.sessionTeam) {
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 1
EQI4 $384
ADDRLP4 100
INDIRI4
CNSTI4 2
EQI4 $386
ADDRGP4 $253
JUMPV
LABELV $384
line 602
;601:		case TEAM_RED:
;602:			c = "team_CTF_redflag";
ADDRLP4 20
ADDRGP4 $385
ASGNP4
line 603
;603:			break;
ADDRGP4 $382
JUMPV
LABELV $386
line 605
;604:		case TEAM_BLUE:
;605:			c = "team_CTF_blueflag";
ADDRLP4 20
ADDRGP4 $387
ASGNP4
line 606
;606:			break;
line 608
;607:		default:
;608:			return;
LABELV $382
line 611
;609:		}
;610:		// find attacker's team's flag carrier
;611:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $391
JUMPV
LABELV $388
line 612
;612:			carrier = g_entities + i;
ADDRLP4 12
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 613
;613:			if (carrier->inuse && carrier->client->ps.powerups[flag_pw])
ADDRLP4 112
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRLP4 112
INDIRI4
EQI4 $393
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRLP4 112
INDIRI4
EQI4 $393
line 614
;614:				break;
ADDRGP4 $390
JUMPV
LABELV $393
line 615
;615:			carrier = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 616
;616:		}
LABELV $389
line 611
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $391
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $388
LABELV $390
line 617
;617:	}
LABELV $378
LABELV $368
line 618
;618:	flag = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $396
JUMPV
LABELV $395
line 619
;619:	while ((flag = G_Find (flag, FOFS(classname), c)) != NULL) {
line 620
;620:		if (!(flag->flags & FL_DROPPED_ITEM))
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $398
line 621
;621:			break;
ADDRGP4 $397
JUMPV
LABELV $398
line 622
;622:	}
LABELV $396
line 619
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $395
LABELV $397
line 624
;623:
;624:	if (!flag)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $400
line 625
;625:		return; // can't find attacker's flag
ADDRGP4 $253
JUMPV
LABELV $400
line 630
;626:
;627:	// ok we have the attackers flag and a pointer to the carrier
;628:
;629:	// check to see if we are defending the base's flag
;630:	VectorSubtract(targ->r.currentOrigin, flag->r.currentOrigin, v1);
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
CNSTI4 488
ASGNI4
ADDRLP4 24
ADDRLP4 104
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 116
CNSTI4 492
ASGNI4
ADDRLP4 24+4
ADDRLP4 104
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120
CNSTI4 496
ASGNI4
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
ADDRLP4 120
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 120
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 631
;631:	VectorSubtract(attacker->r.currentOrigin, flag->r.currentOrigin, v2);
ADDRLP4 124
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 128
CNSTI4 488
ASGNI4
ADDRLP4 36
ADDRLP4 124
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136
CNSTI4 492
ASGNI4
ADDRLP4 36+4
ADDRLP4 124
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140
CNSTI4 496
ASGNI4
ADDRLP4 36+8
ADDRFP4 8
INDIRP4
ADDRLP4 140
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 140
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 633
;632:
;633:	if ( ( ( VectorLength(v1) < CTF_TARGET_PROTECT_RADIUS &&
ADDRLP4 24
ARGP4
ADDRLP4 144
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 144
INDIRF4
CNSTF4 1148846080
GEF4 $416
ADDRLP4 148
CNSTI4 488
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 148
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 148
INDIRI4
ADDP4
ARGP4
ADDRLP4 152
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $415
LABELV $416
ADDRLP4 36
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 156
INDIRF4
CNSTF4 1148846080
GEF4 $406
ADDRLP4 160
CNSTI4 488
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
ARGP4
ADDRLP4 164
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $406
LABELV $415
ADDRLP4 168
CNSTI4 516
ASGNI4
ADDRLP4 172
CNSTI4 1024
ASGNI4
ADDRLP4 176
ADDRFP4 8
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 176
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
INDIRI4
EQI4 $406
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $406
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $419
ADDRLP4 180
CNSTI4 0
ASGNI4
ADDRGP4 g_elimination_ctf_oneway+12
INDIRI4
ADDRLP4 180
INDIRI4
EQI4 $419
ADDRLP4 184
CNSTI4 2
ASGNI4
ADDRGP4 level+9256
INDIRI4
ADDRGP4 level+9236
INDIRI4
ADDI4
ADDRLP4 184
INDIRI4
MODI4
ADDRLP4 180
INDIRI4
NEI4 $420
ADDRLP4 176
INDIRI4
ADDRLP4 184
INDIRI4
EQI4 $419
LABELV $420
ADDRLP4 188
CNSTI4 1
ASGNI4
ADDRGP4 level+9256
INDIRI4
ADDRGP4 level+9236
INDIRI4
ADDI4
CNSTI4 2
MODI4
ADDRLP4 188
INDIRI4
NEI4 $406
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 188
INDIRI4
NEI4 $406
LABELV $419
line 640
;634:	         trap_InPVS(flag->r.currentOrigin, targ->r.currentOrigin ) ) ||
;635:	        ( VectorLength(v2) < CTF_TARGET_PROTECT_RADIUS &&
;636:	          trap_InPVS(flag->r.currentOrigin, attacker->r.currentOrigin ) ) ) &&
;637:	        attacker->client->sess.sessionTeam != targ->client->sess.sessionTeam && g_gametype.integer != GT_ELIMINATION &&
;638:	        (g_gametype.integer != GT_CTF_ELIMINATION || !g_elimination_ctf_oneway.integer ||
;639:	         ((level.eliminationSides+level.roundNumber)%2 == 0 && attacker->client->sess.sessionTeam == TEAM_BLUE ) ||
;640:	         ((level.eliminationSides+level.roundNumber)%2 == 1 && attacker->client->sess.sessionTeam == TEAM_RED ) ) ) {
line 643
;641:
;642:		// we defended the base flag
;643:		AddScore(attacker, targ->r.currentOrigin, CTF_FLAG_DEFENSE_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 644
;644:		attacker->client->pers.teamState.basedefense++;
ADDRLP4 192
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 568
ADDP4
ASGNP4
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 646
;645:
;646:		attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 196
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 647
;647:		if(!level.hadBots)
ADDRGP4 level+9436
INDIRI4
CNSTI4 0
NEI4 $421
line 648
;648:			ChallengeMessage(attacker,AWARD_DEFENCE);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 305
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
LABELV $421
line 649
;649:		G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", attacker->client->ps.clientNum, 3, attacker->client->pers.netname, "DEFENCE" );
ADDRGP4 $316
ARGP4
ADDRLP4 200
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 200
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $317
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 651
;650:		// add the sprite over the player's head
;651:		attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 204
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 204
INDIRP4
ADDRLP4 204
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 652
;652:		attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 208
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 208
INDIRP4
ADDRLP4 208
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 653
;653:		attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 655
;654:
;655:		return;
ADDRGP4 $253
JUMPV
LABELV $406
line 658
;656:	}
;657:
;658:	if (carrier && carrier != attacker) {
ADDRLP4 192
ADDRLP4 12
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 192
INDIRU4
CNSTU4 0
EQU4 $425
ADDRLP4 192
INDIRU4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $425
line 659
;659:		VectorSubtract(targ->r.currentOrigin, carrier->r.currentOrigin, v1);
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
CNSTI4 488
ASGNI4
ADDRLP4 24
ADDRLP4 196
INDIRP4
ADDRLP4 200
INDIRI4
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
ADDRLP4 200
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 208
CNSTI4 492
ASGNI4
ADDRLP4 24+4
ADDRLP4 196
INDIRP4
ADDRLP4 208
INDIRI4
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
ADDRLP4 208
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 212
CNSTI4 496
ASGNI4
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
ADDRLP4 212
INDIRI4
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
ADDRLP4 212
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 660
;660:		VectorSubtract(attacker->r.currentOrigin, carrier->r.currentOrigin, v2);
ADDRLP4 216
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 220
CNSTI4 488
ASGNI4
ADDRLP4 36
ADDRLP4 216
INDIRP4
ADDRLP4 220
INDIRI4
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
ADDRLP4 220
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 228
CNSTI4 492
ASGNI4
ADDRLP4 36+4
ADDRLP4 216
INDIRP4
ADDRLP4 228
INDIRI4
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
ADDRLP4 228
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 232
CNSTI4 496
ASGNI4
ADDRLP4 36+8
ADDRFP4 8
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 662
;661:
;662:		if ( ( ( VectorLength(v1) < CTF_ATTACKER_PROTECT_RADIUS &&
ADDRLP4 24
ARGP4
ADDRLP4 236
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 236
INDIRF4
CNSTF4 1148846080
GEF4 $434
ADDRLP4 240
CNSTI4 488
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 240
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 240
INDIRI4
ADDP4
ARGP4
ADDRLP4 244
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 0
NEI4 $433
LABELV $434
ADDRLP4 36
ARGP4
ADDRLP4 248
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 248
INDIRF4
CNSTF4 1148846080
GEF4 $431
ADDRLP4 252
CNSTI4 488
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
ARGP4
ADDRLP4 256
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
EQI4 $431
LABELV $433
ADDRLP4 260
CNSTI4 516
ASGNI4
ADDRLP4 264
CNSTI4 1024
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 260
INDIRI4
ADDP4
INDIRP4
ADDRLP4 264
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 260
INDIRI4
ADDP4
INDIRP4
ADDRLP4 264
INDIRI4
ADDP4
INDIRI4
EQI4 $431
line 666
;663:		         trap_InPVS(carrier->r.currentOrigin, targ->r.currentOrigin ) ) ||
;664:		        ( VectorLength(v2) < CTF_ATTACKER_PROTECT_RADIUS &&
;665:		          trap_InPVS(carrier->r.currentOrigin, attacker->r.currentOrigin ) ) ) &&
;666:		        attacker->client->sess.sessionTeam != targ->client->sess.sessionTeam) {
line 667
;667:			AddScore(attacker, targ->r.currentOrigin, CTF_CARRIER_PROTECT_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 668
;668:			attacker->client->pers.teamState.carrierdefense++;
ADDRLP4 268
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 572
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ADDRLP4 268
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 670
;669:
;670:			attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 272
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 272
INDIRP4
ADDRLP4 272
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 671
;671:			if (!level.hadBots)
ADDRGP4 level+9436
INDIRI4
CNSTI4 0
NEI4 $435
line 672
;672:				ChallengeMessage(attacker,AWARD_DEFENCE);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 305
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
LABELV $435
line 673
;673:			G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", attacker->client->ps.clientNum, 3, attacker->client->pers.netname, "DEFENCE" );
ADDRGP4 $316
ARGP4
ADDRLP4 276
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 276
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $317
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 675
;674:			// add the sprite over the player's head
;675:			attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 280
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 676
;676:			attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 284
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
ADDRLP4 284
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 677
;677:			attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 679
;678:
;679:			return;
LABELV $431
line 681
;680:		}
;681:	}
LABELV $425
line 682
;682:}
LABELV $253
endproc Team_FragBonuses 288 40
export Team_CheckHurtCarrier
proc Team_CheckHurtCarrier 36 0
line 693
;683:
;684:/*
;685:================
;686:Team_CheckHurtCarrier
;687:
;688:Check to see if attacker hurt the flag carrier.  Needed when handing out bonuses for assistance to flag
;689:carrier defense.
;690:================
;691:*/
;692:void Team_CheckHurtCarrier(gentity_t *targ, gentity_t *attacker)
;693:{
line 696
;694:	int flag_pw;
;695:
;696:	if (!targ->client || !attacker->client) {
ADDRLP4 4
CNSTI4 516
ASGNI4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $442
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
NEU4 $440
LABELV $442
line 697
;697:		return;
ADDRGP4 $439
JUMPV
LABELV $440
line 700
;698:	}
;699:
;700:	if (targ->client->sess.sessionTeam == TEAM_RED) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 1
NEI4 $443
line 701
;701:		flag_pw = PW_BLUEFLAG;
ADDRLP4 0
CNSTI4 8
ASGNI4
line 702
;702:	}
ADDRGP4 $444
JUMPV
LABELV $443
line 703
;703:	else {
line 704
;704:		flag_pw = PW_REDFLAG;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 705
;705:	}
LABELV $444
line 707
;706:
;707:	if (g_gametype.integer == GT_1FCTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $445
line 708
;708:		flag_pw = PW_NEUTRALFLAG;
ADDRLP4 0
CNSTI4 9
ASGNI4
line 709
;709:	}
LABELV $445
line 712
;710:
;711:	// flags
;712:	if (targ->client->ps.powerups[flag_pw] &&
ADDRLP4 12
CNSTI4 516
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $448
ADDRLP4 20
CNSTI4 1024
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
EQI4 $448
line 713
;713:	        targ->client->sess.sessionTeam != attacker->client->sess.sessionTeam) {
line 714
;714:		attacker->client->pers.teamState.lasthurtcarrier = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 588
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 715
;715:	}
LABELV $448
line 718
;716:
;717:	// skulls
;718:	if (targ->client->ps.generic1 &&
ADDRLP4 24
CNSTI4 516
ASGNI4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
EQI4 $451
ADDRLP4 32
CNSTI4 1024
ASGNI4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $451
line 719
;719:	        targ->client->sess.sessionTeam != attacker->client->sess.sessionTeam) {
line 720
;720:		attacker->client->pers.teamState.lasthurtcarrier = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 588
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 721
;721:	}
LABELV $451
line 722
;722:}
LABELV $439
endproc Team_CheckHurtCarrier 36 0
export Team_ResetFlag
proc Team_ResetFlag 20 12
line 726
;723:
;724:
;725:gentity_t *Team_ResetFlag( int team )
;726:{
line 728
;727:	char *c;
;728:	gentity_t *ent, *rent = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 730
;729:
;730:	switch (team) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $459
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $457
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $458
ADDRGP4 $455
JUMPV
LABELV $457
line 732
;731:	case TEAM_RED:
;732:		c = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $385
ASGNP4
line 733
;733:		break;
ADDRGP4 $456
JUMPV
LABELV $458
line 735
;734:	case TEAM_BLUE:
;735:		c = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $387
ASGNP4
line 736
;736:		break;
ADDRGP4 $456
JUMPV
LABELV $459
line 738
;737:	case TEAM_FREE:
;738:		c = "team_CTF_neutralflag";
ADDRLP4 4
ADDRGP4 $460
ASGNP4
line 739
;739:		break;
ADDRGP4 $456
JUMPV
LABELV $455
line 741
;740:	default:
;741:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $454
JUMPV
LABELV $456
line 744
;742:	}
;743:
;744:	ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $462
JUMPV
LABELV $461
line 745
;745:	while ((ent = G_Find (ent, FOFS(classname), c)) != NULL) {
line 746
;746:		if (ent->flags & FL_DROPPED_ITEM) {
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $464
line 747
;747:			G_FreeEntity(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 748
;748:		}
ADDRGP4 $465
JUMPV
LABELV $464
line 749
;749:		else {
line 750
;750:			rent = ent;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
line 751
;751:			RespawnItem(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RespawnItem
CALLV
pop
line 752
;752:		}
LABELV $465
line 753
;753:	}
LABELV $462
line 745
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $461
line 755
;754:
;755:	Team_SetFlagStatus( team, FLAG_ATBASE );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 757
;756:
;757:	return rent;
ADDRLP4 8
INDIRP4
RETP4
LABELV $454
endproc Team_ResetFlag 20 12
export Team_Dom_SpawnPoints
proc Team_Dom_SpawnPoints 24 12
line 763
;758:}
;759:
;760://Functions for Domination
;761:
;762:void Team_Dom_SpawnPoints( void )
;763:{
line 769
;764:	char *c;
;765:	gentity_t *flag;
;766:	int i;
;767:	gitem_t			*it;
;768:
;769:	flag = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 771
;770:
;771:	if(dominationPointsSpawned)
ADDRGP4 dominationPointsSpawned
INDIRI4
CNSTI4 0
EQI4 $467
line 772
;772:		return;
ADDRGP4 $466
JUMPV
LABELV $467
line 773
;773:	dominationPointsSpawned = qtrue;
ADDRGP4 dominationPointsSpawned
CNSTI4 1
ASGNI4
line 775
;774:
;775:	it = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 776
;776:	it = BG_FindItem ("Neutral domination point");
ADDRGP4 $469
ARGP4
ADDRLP4 16
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 777
;777:	if(it == NULL) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $470
line 778
;778:		PrintMsg( NULL, "No domination item\n");
CNSTP4 0
ARGP4
ADDRGP4 $472
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 779
;779:		return;
ADDRGP4 $466
JUMPV
LABELV $470
line 781
;780:	}
;781:	else {
line 782
;782:		PrintMsg( NULL, "Domination item found\n");
CNSTP4 0
ARGP4
ADDRGP4 $473
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 783
;783:	}
line 784
;784:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 785
;785:	c = "domination_point";
ADDRLP4 12
ADDRGP4 $474
ASGNP4
ADDRGP4 $476
JUMPV
LABELV $475
line 789
;786:
;787:	//return; Just to test, the lines below crashes game
;788:
;789:	while ((flag = G_Find (flag, FOFS(classname), c)) != NULL) {
line 790
;790:		if(i>=MAX_DOMINATION_POINTS)
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $478
line 791
;791:			break;
ADDRGP4 $477
JUMPV
LABELV $478
line 793
;792:		//domination_points_names[i] = flag->message;
;793:		if(flag->message) {
ADDRLP4 4
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $480
line 794
;794:			Q_strncpyz(level.domination_points_names[i],flag->message,MAX_DOMINATION_POINTS_NAMES-1);
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level+9316
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 795
;795:			PrintMsg( NULL, "Domination point \'%s\' found\n",level.domination_points_names[i]);
CNSTP4 0
ARGP4
ADDRGP4 $483
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level+9316
ADDP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 796
;796:		}
ADDRGP4 $481
JUMPV
LABELV $480
line 797
;797:		else {
line 798
;798:			Q_strncpyz(level.domination_points_names[i],va("Point %i",i),MAX_DOMINATION_POINTS_NAMES-1);
ADDRGP4 $486
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level+9316
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 799
;799:			PrintMsg( NULL, "Domination point \'%s\' found (autonamed)\n",level.domination_points_names[i]);
CNSTP4 0
ARGP4
ADDRGP4 $487
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level+9316
ADDP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 800
;800:		}
LABELV $481
line 801
;801:		dom_points[i] = G_Spawn();
ADDRLP4 20
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 dom_points
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 802
;802:		VectorCopy( flag->r.currentOrigin, dom_points[i]->s.origin );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 dom_points
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 803
;803:		dom_points[i]->classname = it->classname;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 dom_points
ADDP4
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 8
INDIRP4
INDIRP4
ASGNP4
line 804
;804:		G_SpawnItem(dom_points[i], it);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 dom_points
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_SpawnItem
CALLV
pop
line 805
;805:		FinishSpawningItem(dom_points[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 dom_points
ADDP4
INDIRP4
ARGP4
ADDRGP4 FinishSpawningItem
CALLV
pop
line 807
;806:
;807:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 808
;808:	}
LABELV $476
line 789
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $475
LABELV $477
line 809
;809:	level.domination_points_count = i;
ADDRGP4 level+9312
ADDRLP4 0
INDIRI4
ASGNI4
line 810
;810:}
LABELV $466
endproc Team_Dom_SpawnPoints 24 12
export getDomPointNumber
proc getDomPointNumber 8 0
line 813
;811:
;812:int getDomPointNumber( gentity_t *point )
;813:{
line 815
;814:	int i;
;815:	for(i=1; i<MAX_DOMINATION_POINTS && i<level.domination_points_count; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $494
JUMPV
LABELV $491
line 816
;816:		if(dom_points[i] == NULL)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 dom_points
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $496
line 817
;817:			return 0; //Not found, just return first, so we don't crash
CNSTI4 0
RETI4
ADDRGP4 $490
JUMPV
LABELV $496
line 818
;818:		if(dom_points[i] == point)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 dom_points
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $498
line 819
;819:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $490
JUMPV
LABELV $498
line 820
;820:	}
LABELV $492
line 815
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $494
ADDRLP4 0
INDIRI4
CNSTI4 6
GEI4 $500
ADDRLP4 0
INDIRI4
ADDRGP4 level+9312
INDIRI4
LTI4 $491
LABELV $500
line 821
;821:	return 0;
CNSTI4 0
RETI4
LABELV $490
endproc getDomPointNumber 8 0
export Team_Dom_TakePoint
proc Team_Dom_TakePoint 44 28
line 825
;822:}
;823:
;824:void Team_Dom_TakePoint( gentity_t *point, int team, int clientnumber )
;825:{
line 829
;826:	gitem_t			*it;
;827:	vec3_t			origin;
;828:	int i;
;829:	i = getDomPointNumber(point);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 getDomPointNumber
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 830
;830:	if(i<0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $502
line 831
;831:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 832
;832:	}
LABELV $502
line 833
;833:	if(i>=MAX_DOMINATION_POINTS) {
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $504
line 834
;834:		i = MAX_DOMINATION_POINTS - 1;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 835
;835:	}
LABELV $504
line 837
;836:
;837:	it = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 838
;838:	VectorCopy( point->r.currentOrigin, origin );
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 840
;839:
;840:	if(team == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $506
line 841
;841:		it = BG_FindItem ("Red domination point");
ADDRGP4 $508
ARGP4
ADDRLP4 24
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 842
;842:		PrintMsg( NULL, "Red took \'%s\'\n",level.domination_points_names[i]);
CNSTP4 0
ARGP4
ADDRGP4 $509
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level+9316
ADDP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 843
;843:	}
ADDRGP4 $507
JUMPV
LABELV $506
line 844
;844:	else if(team == TEAM_BLUE) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $511
line 845
;845:		it = BG_FindItem ("Blue domination point");
ADDRGP4 $513
ARGP4
ADDRLP4 24
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 846
;846:		PrintMsg( NULL, "Blue took \'%s\'\n",level.domination_points_names[i]);
CNSTP4 0
ARGP4
ADDRGP4 $514
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level+9316
ADDP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 847
;847:	}
LABELV $511
LABELV $507
line 848
;848:	if (!it || it == NULL) {
ADDRLP4 24
ADDRLP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 28
CNSTU4 0
ASGNU4
ADDRLP4 24
INDIRU4
ADDRLP4 28
INDIRU4
EQU4 $518
ADDRLP4 24
INDIRU4
ADDRLP4 28
INDIRU4
NEU4 $516
LABELV $518
line 849
;849:		PrintMsg( NULL, "No item\n");
CNSTP4 0
ARGP4
ADDRGP4 $519
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 850
;850:		return;
ADDRGP4 $501
JUMPV
LABELV $516
line 853
;851:	}
;852:
;853:	G_FreeEntity(point);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 855
;854:
;855:	point = G_Spawn();
ADDRLP4 32
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 857
;856:
;857:	VectorCopy( origin, point->s.origin );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 8
INDIRB
ASGNB 12
line 858
;858:	point->classname = it->classname;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 4
INDIRP4
INDIRP4
ASGNP4
line 859
;859:	dom_points[i] = point;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 dom_points
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 860
;860:	G_SpawnItem(point, it);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_SpawnItem
CALLV
pop
line 861
;861:	FinishSpawningItem( point );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 FinishSpawningItem
CALLV
pop
line 862
;862:	level.pointStatusDom[i] = team;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9284
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 863
;863:	G_LogPrintf( "DOM: %i %i %i %i: %s takes point %s!\n",
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $521
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level+9316
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 866
;864:	             clientnumber,i,0,team,
;865:	             TeamName(team),level.domination_points_names[i]);
;866:	SendDominationPointsStatusMessageToAllClients();
ADDRGP4 SendDominationPointsStatusMessageToAllClients
CALLV
pop
line 867
;867:}
LABELV $501
endproc Team_Dom_TakePoint 44 28
export Team_DD_RemovePointAgfx
proc Team_DD_RemovePointAgfx 0 4
line 872
;868:
;869://Functions for Double Domination
;870:
;871:void Team_DD_RemovePointAgfx( void )
;872:{
line 873
;873:	if(ddA!=NULL) {
ADDRGP4 ddA
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $524
line 874
;874:		G_FreeEntity(ddA);
ADDRGP4 ddA
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 875
;875:		ddA = NULL;
ADDRGP4 ddA
CNSTP4 0
ASGNP4
line 876
;876:	}
LABELV $524
line 877
;877:}
LABELV $523
endproc Team_DD_RemovePointAgfx 0 4
export Team_DD_RemovePointBgfx
proc Team_DD_RemovePointBgfx 0 4
line 880
;878:
;879:void Team_DD_RemovePointBgfx( void )
;880:{
line 881
;881:	if(ddB!=NULL) {
ADDRGP4 ddB
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $527
line 882
;882:		G_FreeEntity(ddB);
ADDRGP4 ddB
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 883
;883:		ddB = NULL;
ADDRGP4 ddB
CNSTP4 0
ASGNP4
line 884
;884:	}
LABELV $527
line 885
;885:}
LABELV $526
endproc Team_DD_RemovePointBgfx 0 4
export Team_DD_makeA2team
proc Team_DD_makeA2team 16 8
line 889
;886:
;887:
;888:void Team_DD_makeA2team( gentity_t *target, int team )
;889:{
line 892
;890:	gitem_t			*it;
;891:	//gentity_t		*it_ent;
;892:	Team_DD_RemovePointAgfx();
ADDRGP4 Team_DD_RemovePointAgfx
CALLV
pop
line 893
;893:	it = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 894
;894:	if(team == TEAM_NONE || !target) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $532
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $530
LABELV $532
line 895
;895:		return;
ADDRGP4 $529
JUMPV
LABELV $530
line 897
;896:	}
;897:	else if(team == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $533
line 898
;898:		it = BG_FindItem ("Point A (Red)");
ADDRGP4 $535
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 899
;899:	}
ADDRGP4 $534
JUMPV
LABELV $533
line 900
;900:	else if(team == TEAM_BLUE) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $536
line 901
;901:		it = BG_FindItem ("Point A (Blue)");
ADDRGP4 $538
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 902
;902:	}
ADDRGP4 $537
JUMPV
LABELV $536
line 903
;903:	else if(team == TEAM_FREE) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $539
line 904
;904:		it = BG_FindItem ("Point A (White)");
ADDRGP4 $541
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 905
;905:	}
LABELV $539
LABELV $537
LABELV $534
line 906
;906:	if (!it || it == NULL) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRU4
ADDRLP4 8
INDIRU4
EQU4 $544
ADDRLP4 4
INDIRU4
ADDRLP4 8
INDIRU4
NEU4 $542
LABELV $544
line 907
;907:		PrintMsg( NULL, "No item\n");
CNSTP4 0
ARGP4
ADDRGP4 $519
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 908
;908:		return;
ADDRGP4 $529
JUMPV
LABELV $542
line 910
;909:	}
;910:	ddA = G_Spawn();
ADDRLP4 12
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRGP4 ddA
ADDRLP4 12
INDIRP4
ASGNP4
line 912
;911:
;912:	VectorCopy( target->r.currentOrigin, ddA->s.origin );
ADDRGP4 ddA
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 913
;913:	ddA->classname = it->classname;
ADDRGP4 ddA
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 914
;914:	G_SpawnItem(ddA, it);
ADDRGP4 ddA
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_SpawnItem
CALLV
pop
line 915
;915:	FinishSpawningItem(ddA );
ADDRGP4 ddA
INDIRP4
ARGP4
ADDRGP4 FinishSpawningItem
CALLV
pop
line 916
;916:}
LABELV $529
endproc Team_DD_makeA2team 16 8
proc Team_DD_makeB2team 16 8
line 919
;917:
;918:static void Team_DD_makeB2team( gentity_t *target, int team )
;919:{
line 923
;920:	gitem_t			*it;
;921:	//gentity_t		*it_ent;
;922:
;923:	Team_DD_RemovePointBgfx();
ADDRGP4 Team_DD_RemovePointBgfx
CALLV
pop
line 924
;924:	it = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 925
;925:	if(team == TEAM_NONE || !target) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $548
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $546
LABELV $548
line 926
;926:		return;
ADDRGP4 $545
JUMPV
LABELV $546
line 928
;927:	}
;928:	if(team == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $549
line 929
;929:		it = BG_FindItem ("Point B (Red)");
ADDRGP4 $551
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 930
;930:	}
LABELV $549
line 931
;931:	if(team == TEAM_BLUE) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $552
line 932
;932:		it = BG_FindItem ("Point B (Blue)");
ADDRGP4 $554
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 933
;933:	}
LABELV $552
line 934
;934:	if(team == TEAM_FREE) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $555
line 935
;935:		it = BG_FindItem ("Point B (White)");
ADDRGP4 $557
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 936
;936:	}
LABELV $555
line 937
;937:	if (!it || it == NULL) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRU4
ADDRLP4 8
INDIRU4
EQU4 $560
ADDRLP4 4
INDIRU4
ADDRLP4 8
INDIRU4
NEU4 $558
LABELV $560
line 938
;938:		PrintMsg( NULL, "No item\n");
CNSTP4 0
ARGP4
ADDRGP4 $519
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 939
;939:		return;
ADDRGP4 $545
JUMPV
LABELV $558
line 941
;940:	}
;941:	ddB = G_Spawn();
ADDRLP4 12
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRGP4 ddB
ADDRLP4 12
INDIRP4
ASGNP4
line 943
;942:
;943:	VectorCopy( target->r.currentOrigin, ddB->s.origin );
ADDRGP4 ddB
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 944
;944:	ddB->classname = it->classname;
ADDRGP4 ddB
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 945
;945:	G_SpawnItem(ddB, it);
ADDRGP4 ddB
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_SpawnItem
CALLV
pop
line 946
;946:	FinishSpawningItem(ddB );
ADDRGP4 ddB
INDIRP4
ARGP4
ADDRGP4 FinishSpawningItem
CALLV
pop
line 947
;947:}
LABELV $545
endproc Team_DD_makeB2team 16 8
proc Team_ResetFlags 12 4
line 950
;948:
;949:static void Team_ResetFlags( void )
;950:{
line 951
;951:	if(G_UsesTeamFlags(g_gametype.integer) && !G_UsesTheWhiteFlag(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $562
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $562
line 952
;952:		Team_ResetFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ResetFlag
CALLP4
pop
line 953
;953:		Team_ResetFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ResetFlag
CALLP4
pop
line 954
;954:	}
ADDRGP4 $563
JUMPV
LABELV $562
line 955
;955:	else if(G_UsesTheWhiteFlag(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $566
line 956
;956:		Team_ResetFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ResetFlag
CALLP4
pop
line 957
;957:	}
LABELV $566
LABELV $563
line 958
;958:}
LABELV $561
endproc Team_ResetFlags 12 4
export Team_ReturnFlagSound
proc Team_ReturnFlagSound 12 8
line 961
;959:
;960:void Team_ReturnFlagSound( gentity_t *ent, int team )
;961:{
line 964
;962:	gentity_t	*te;
;963:
;964:	if (ent == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $570
line 965
;965:		G_Printf ("Warning:  NULL passed to Team_ReturnFlagSound\n");
ADDRGP4 $572
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 966
;966:		return;
ADDRGP4 $569
JUMPV
LABELV $570
line 970
;967:	}
;968:
;969:	//See if we are during CTF_ELIMINATION warmup
;970:	if((level.time<=level.roundStartTime && level.time>level.roundStartTime-1000*g_elimination_activewarmup.integer)&&g_gametype.integer == GT_CTF_ELIMINATION) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
GTI4 $573
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
MULI4
SUBI4
LEI4 $573
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $573
line 971
;971:		return;
ADDRGP4 $569
JUMPV
LABELV $573
line 974
;972:	}
;973:
;974:	te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 975
;975:	if( team == TEAM_BLUE ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $581
line 976
;976:		te->s.eventParm = GTS_RED_RETURN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 2
ASGNI4
line 977
;977:	}
ADDRGP4 $582
JUMPV
LABELV $581
line 978
;978:	else {
line 979
;979:		te->s.eventParm = GTS_BLUE_RETURN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 3
ASGNI4
line 980
;980:	}
LABELV $582
line 981
;981:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 982
;982:}
LABELV $569
endproc Team_ReturnFlagSound 12 8
export Team_TakeFlagSound
proc Team_TakeFlagSound 16 8
line 985
;983:
;984:void Team_TakeFlagSound( gentity_t *ent, int team )
;985:{
line 988
;986:	gentity_t	*te;
;987:
;988:	if (ent == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $584
line 989
;989:		G_Printf ("Warning:  NULL passed to Team_TakeFlagSound\n");
ADDRGP4 $586
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 990
;990:		return;
ADDRGP4 $583
JUMPV
LABELV $584
line 995
;991:	}
;992:
;993:	// only play sound when the flag was at the base
;994:	// or not picked up the last 10 seconds
;995:	switch(team) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $589
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $600
ADDRGP4 $587
JUMPV
LABELV $589
line 997
;996:	case TEAM_RED:
;997:		if( teamgame.blueStatus != FLAG_ATBASE ) {
ADDRGP4 teamgame+12
INDIRI4
CNSTI4 0
EQI4 $590
line 998
;998:			if (teamgame.blueTakenTime > level.time - 10000 && g_gametype.integer != GT_CTF_ELIMINATION)
ADDRGP4 teamgame+24
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $593
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $593
line 999
;999:				return;
ADDRGP4 $583
JUMPV
LABELV $593
line 1000
;1000:		}
LABELV $590
line 1001
;1001:		teamgame.blueTakenTime = level.time;
ADDRGP4 teamgame+24
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1002
;1002:		break;
ADDRGP4 $588
JUMPV
LABELV $600
line 1005
;1003:
;1004:	case TEAM_BLUE:	// CTF
;1005:		if( teamgame.redStatus != FLAG_ATBASE ) {
ADDRGP4 teamgame+8
INDIRI4
CNSTI4 0
EQI4 $601
line 1006
;1006:			if (teamgame.redTakenTime > level.time - 10000 && g_gametype.integer != GT_CTF_ELIMINATION)
ADDRGP4 teamgame+20
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $604
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $604
line 1007
;1007:				return;
ADDRGP4 $583
JUMPV
LABELV $604
line 1008
;1008:		}
LABELV $601
line 1009
;1009:		teamgame.redTakenTime = level.time;
ADDRGP4 teamgame+20
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1010
;1010:		break;
LABELV $587
LABELV $588
line 1013
;1011:	}
;1012:
;1013:	te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 8
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1014
;1014:	if( team == TEAM_BLUE ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $611
line 1015
;1015:		te->s.eventParm = GTS_RED_TAKEN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 4
ASGNI4
line 1016
;1016:	}
ADDRGP4 $612
JUMPV
LABELV $611
line 1017
;1017:	else {
line 1018
;1018:		te->s.eventParm = GTS_BLUE_TAKEN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 5
ASGNI4
line 1019
;1019:	}
LABELV $612
line 1020
;1020:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1021
;1021:}
LABELV $583
endproc Team_TakeFlagSound 16 8
export Team_CaptureFlagSound
proc Team_CaptureFlagSound 12 8
line 1024
;1022:
;1023:void Team_CaptureFlagSound( gentity_t *ent, int team )
;1024:{
line 1027
;1025:	gentity_t	*te;
;1026:
;1027:	if (ent == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $614
line 1028
;1028:		G_Printf ("Warning:  NULL passed to Team_CaptureFlagSound\n");
ADDRGP4 $616
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1029
;1029:		return;
ADDRGP4 $613
JUMPV
LABELV $614
line 1032
;1030:	}
;1031:
;1032:	te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1033
;1033:	if( team == TEAM_BLUE ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $617
line 1034
;1034:		te->s.eventParm = GTS_BLUE_CAPTURE;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 1
ASGNI4
line 1035
;1035:	}
ADDRGP4 $618
JUMPV
LABELV $617
line 1036
;1036:	else {
line 1037
;1037:		te->s.eventParm = GTS_RED_CAPTURE;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 0
ASGNI4
line 1038
;1038:	}
LABELV $618
line 1039
;1039:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1040
;1040:}
LABELV $613
endproc Team_CaptureFlagSound 12 8
export Team_ReturnFlag
proc Team_ReturnFlag 12 24
line 1043
;1041:
;1042:void Team_ReturnFlag( int team )
;1043:{
line 1044
;1044:	Team_ReturnFlagSound(Team_ResetFlag(team), team);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 1045
;1045:	if( team == TEAM_FREE ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $620
line 1046
;1046:		PrintMsg(NULL, "The flag has returned!\n" );
CNSTP4 0
ARGP4
ADDRGP4 $622
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1047
;1047:		if(g_gametype.integer == GT_1FCTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $621
line 1048
;1048:			G_LogPrintf( "1FCTF: %i %i %i: The flag was returned!\n", -1, -1, 2 );
ADDRGP4 $626
ARGP4
ADDRLP4 4
CNSTI4 -1
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1049
;1049:		}
line 1050
;1050:	}
ADDRGP4 $621
JUMPV
LABELV $620
line 1051
;1051:	else {
line 1052
;1052:		PrintMsg(NULL, "The %s flag has returned!\n", TeamName(team));
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $627
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1053
;1053:		if (g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $628
line 1054
;1054:			G_LogPrintf( "CTF: %i %i %i: The %s flag was returned!\n", -1, team, 2, TeamName(team) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $631
ARGP4
CNSTI4 -1
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1055
;1055:		}
ADDRGP4 $629
JUMPV
LABELV $628
line 1056
;1056:		else if(g_gametype.integer == GT_CTF_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $632
line 1057
;1057:			G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: The %s flag was returned!\n", level.roundNumber, -1, team, 2, TeamName(team) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $635
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1058
;1058:		}
LABELV $632
LABELV $629
line 1059
;1059:	}
LABELV $621
line 1060
;1060:}
LABELV $619
endproc Team_ReturnFlag 12 24
export Team_FreeEntity
proc Team_FreeEntity 0 4
line 1063
;1061:
;1062:void Team_FreeEntity( gentity_t *ent )
;1063:{
line 1064
;1064:	if( ent->item->giTag == PW_REDFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $638
line 1065
;1065:		Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 1066
;1066:	}
ADDRGP4 $639
JUMPV
LABELV $638
line 1067
;1067:	else if( ent->item->giTag == PW_BLUEFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $640
line 1068
;1068:		Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 1069
;1069:	}
ADDRGP4 $641
JUMPV
LABELV $640
line 1070
;1070:	else if( ent->item->giTag == PW_NEUTRALFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $642
line 1071
;1071:		Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 1072
;1072:	}
LABELV $642
LABELV $641
LABELV $639
line 1073
;1073:}
LABELV $637
endproc Team_FreeEntity 0 4
export Team_DroppedFlagThink
proc Team_DroppedFlagThink 8 8
line 1085
;1074:
;1075:/*
;1076:==============
;1077:Team_DroppedFlagThink
;1078:
;1079:Automatically set in Launch_Item if the item is one of the flags
;1080:
;1081:Flags are unique in that if they are dropped, the base flag must be respawned when they time out
;1082:==============
;1083:*/
;1084:void Team_DroppedFlagThink(gentity_t *ent)
;1085:{
line 1086
;1086:	int		team = TEAM_FREE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1088
;1087:
;1088:	if( ent->item->giTag == PW_REDFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $645
line 1089
;1089:		team = TEAM_RED;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1090
;1090:	}
ADDRGP4 $646
JUMPV
LABELV $645
line 1091
;1091:	else if( ent->item->giTag == PW_BLUEFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $647
line 1092
;1092:		team = TEAM_BLUE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1093
;1093:	}
ADDRGP4 $648
JUMPV
LABELV $647
line 1094
;1094:	else if( ent->item->giTag == PW_NEUTRALFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $649
line 1095
;1095:		team = TEAM_FREE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1096
;1096:	}
LABELV $649
LABELV $648
LABELV $646
line 1098
;1097:
;1098:	Team_ReturnFlagSound( Team_ResetFlag( team ), team );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 1100
;1099:	// Reset Flag will delete this entity
;1100:}
LABELV $644
endproc Team_DroppedFlagThink 8 8
export updateDDpoints
proc updateDDpoints 0 8
line 1107
;1101:
;1102:/*
;1103:Update DD points
;1104:*/
;1105:
;1106:void updateDDpoints(void)
;1107:{
line 1109
;1108:	//teamgame.redStatus = -1; // Invalid to force update
;1109:	Team_SetFlagStatus( TEAM_RED, level.pointStatusA );
CNSTI4 1
ARGI4
ADDRGP4 level+9264
INDIRI4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 1111
;1110:	//teamgame.blueStatus = -1; // Invalid to force update
;1111:	Team_SetFlagStatus( TEAM_BLUE, level.pointStatusB );
CNSTI4 2
ARGI4
ADDRGP4 level+9268
INDIRI4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 1112
;1112:}
LABELV $651
endproc updateDDpoints 0 8
export Team_SpawnDoubleDominationPoints
proc Team_SpawnDoubleDominationPoints 12 12
line 1121
;1113:
;1114:/*
;1115:==============
;1116:Team_SpawnDoubleDominationPoints
;1117:==============
;1118:*/
;1119:
;1120:int Team_SpawnDoubleDominationPoints ( void )
;1121:{
line 1123
;1122:	gentity_t	*ent;
;1123:	level.pointStatusA = TEAM_FREE;
ADDRGP4 level+9264
CNSTI4 0
ASGNI4
line 1124
;1124:	level.pointStatusB = TEAM_FREE;
ADDRGP4 level+9268
CNSTI4 0
ASGNI4
line 1125
;1125:	updateDDpoints();
ADDRGP4 updateDDpoints
CALLV
pop
line 1126
;1126:	ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 1127
;1127:	if ((ent = G_Find (ent, FOFS(classname), "team_CTF_redflag")) != NULL) {
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $385
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $657
line 1128
;1128:		Team_DD_makeA2team( ent, TEAM_FREE );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Team_DD_makeA2team
CALLV
pop
line 1129
;1129:	}
LABELV $657
line 1130
;1130:	ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 1131
;1131:	if ((ent = G_Find (ent, FOFS(classname), "team_CTF_blueflag")) != NULL) {
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $387
ARGP4
ADDRLP4 8
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $659
line 1132
;1132:		Team_DD_makeB2team( ent, TEAM_FREE );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Team_DD_makeB2team
CALLV
pop
line 1133
;1133:	}
LABELV $659
line 1134
;1134:	return 1;
CNSTI4 1
RETI4
LABELV $654
endproc Team_SpawnDoubleDominationPoints 12 12
export Team_RemoveDoubleDominationPoints
proc Team_RemoveDoubleDominationPoints 0 8
line 1146
;1135:}
;1136:
;1137:
;1138:
;1139:/*
;1140:==============
;1141:Team_RemoveDoubleDominationPoints
;1142:==============
;1143:*/
;1144:
;1145:int Team_RemoveDoubleDominationPoints ( void )
;1146:{
line 1147
;1147:	level.pointStatusA = TEAM_NONE;
ADDRGP4 level+9264
CNSTI4 3
ASGNI4
line 1148
;1148:	level.pointStatusB = TEAM_NONE;
ADDRGP4 level+9268
CNSTI4 3
ASGNI4
line 1149
;1149:	updateDDpoints();
ADDRGP4 updateDDpoints
CALLV
pop
line 1150
;1150:	Team_DD_makeA2team( NULL, TEAM_NONE );
CNSTP4 0
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 Team_DD_makeA2team
CALLV
pop
line 1151
;1151:	Team_DD_makeB2team( NULL, TEAM_NONE );
CNSTP4 0
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 Team_DD_makeB2team
CALLV
pop
line 1152
;1152:	return 1;
CNSTI4 1
RETI4
LABELV $661
endproc Team_RemoveDoubleDominationPoints 0 8
export Team_TouchDoubleDominationPoint
proc Team_TouchDoubleDominationPoint 44 24
line 1164
;1153:}
;1154:
;1155:/*
;1156:==============
;1157:Team_TouchDoubleDominationPoint
;1158:==============
;1159:*/
;1160:
;1161:
;1162://team is the either TEAM_RED(A) or TEAM_BLUE(B)
;1163:int Team_TouchDoubleDominationPoint( gentity_t *ent, gentity_t *other, int team )
;1164:{
line 1165
;1165:	gclient_t	*cl = other->client;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1167
;1166:	qboolean	otherDominating, isClose;
;1167:	int 		clientTeam = cl->sess.sessionTeam;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 1171
;1168:	int		otherTeam;
;1169:	int		score; //Used to add the scores together
;1170:
;1171:	if(clientTeam == TEAM_RED) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $665
line 1172
;1172:		otherTeam = TEAM_BLUE;
ADDRLP4 8
CNSTI4 2
ASGNI4
line 1173
;1173:	}
ADDRGP4 $666
JUMPV
LABELV $665
line 1174
;1174:	else {
line 1175
;1175:		otherTeam = TEAM_RED;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1176
;1176:	}
LABELV $666
line 1178
;1177:
;1178:	otherDominating = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1179
;1179:	isClose = qfalse;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 1181
;1180:
;1181:	if(level.pointStatusA == otherTeam && level.pointStatusB == otherTeam) {
ADDRGP4 level+9264
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $667
ADDRGP4 level+9268
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $667
line 1182
;1182:		otherDominating = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 1183
;1183:		if(level.time - level.timeTaken > (g_ddCaptureTime.integer-DD_CLOSE)*1000) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9272
INDIRI4
SUBI4
CNSTI4 1000
ADDRGP4 g_ddCaptureTime+12
INDIRI4
MULI4
CNSTI4 3000
SUBI4
LEI4 $671
line 1184
;1184:			isClose = qtrue;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 1185
;1185:		}
LABELV $671
line 1186
;1186:	}
LABELV $667
line 1189
;1187:
;1188:
;1189:	if(team == TEAM_RED) { //We have touched point A
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $676
line 1190
;1190:		if(TEAM_NONE == level.pointStatusA) {
ADDRGP4 level+9264
INDIRI4
CNSTI4 3
NEI4 $678
line 1191
;1191:			return 0; //Haven't spawned yet
CNSTI4 0
RETI4
ADDRGP4 $664
JUMPV
LABELV $678
line 1193
;1192:		}
;1193:		if(clientTeam == level.pointStatusA) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+9264
INDIRI4
NEI4 $681
line 1194
;1194:			return 0; //If we already have the flag
CNSTI4 0
RETI4
ADDRGP4 $664
JUMPV
LABELV $681
line 1197
;1195:		}
;1196:		//if we didn't have the point, then we have now!
;1197:		level.pointStatusA = clientTeam;
ADDRGP4 level+9264
ADDRLP4 0
INDIRI4
ASGNI4
line 1198
;1198:		PrintMsg( NULL, "%s" S_COLOR_WHITE " (%s) took control of A!\n", cl->pers.netname, TeamName(clientTeam) );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $685
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1199
;1199:		Team_DD_makeA2team( ent, clientTeam );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Team_DD_makeA2team
CALLV
pop
line 1200
;1200:		G_LogPrintf( "DD: %i %i %i: %s took point A for %s!\n", cl->ps.clientNum, clientTeam, 0, cl->pers.netname, TeamName(clientTeam) );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $686
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1202
;1201:		//Give personal score
;1202:		score = DD_POINT_CAPTURE; //Base score for capture
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1203
;1203:		if(otherDominating) {
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $687
line 1204
;1204:			score += DD_POINT_CAPTURE_BREAK;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1205
;1205:			if(isClose) {
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $689
line 1206
;1206:				score += DD_POINT_CAPTURE_CLOSE;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1207
;1207:			}
LABELV $689
line 1208
;1208:		}
LABELV $687
line 1209
;1209:		AddScore(other, ent->r.currentOrigin, score);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1211
;1210:		//Do we also have point B?
;1211:		if(clientTeam == level.pointStatusB) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+9268
INDIRI4
NEI4 $691
line 1213
;1212:			//We are dominating!
;1213:			level.timeTaken = level.time; //At this time
ADDRGP4 level+9272
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1214
;1214:			PrintMsg( NULL, "%s" S_COLOR_WHITE " is dominating!\n", TeamName(clientTeam) );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $696
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1215
;1215:			SendDDtimetakenMessageToAllClients();
ADDRGP4 SendDDtimetakenMessageToAllClients
CALLV
pop
line 1216
;1216:		}
LABELV $691
line 1217
;1217:	}
LABELV $676
line 1219
;1218:
;1219:	if(team == TEAM_BLUE) { //We have touched point B
ADDRFP4 8
INDIRI4
CNSTI4 2
NEI4 $697
line 1220
;1220:		if(TEAM_NONE == level.pointStatusB) {
ADDRGP4 level+9268
INDIRI4
CNSTI4 3
NEI4 $699
line 1221
;1221:			return 0; //Haven't spawned yet
CNSTI4 0
RETI4
ADDRGP4 $664
JUMPV
LABELV $699
line 1223
;1222:		}
;1223:		if(clientTeam == level.pointStatusB) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+9268
INDIRI4
NEI4 $702
line 1224
;1224:			return 0; //If we already have the flag
CNSTI4 0
RETI4
ADDRGP4 $664
JUMPV
LABELV $702
line 1227
;1225:		}
;1226:		//if we didn't have the point, then we have now!
;1227:		level.pointStatusB = clientTeam;
ADDRGP4 level+9268
ADDRLP4 0
INDIRI4
ASGNI4
line 1228
;1228:		PrintMsg( NULL, "%s" S_COLOR_WHITE " (%s) took control of B!\n", cl->pers.netname, TeamName(clientTeam) );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $706
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1229
;1229:		Team_DD_makeB2team( ent, clientTeam );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Team_DD_makeB2team
CALLV
pop
line 1230
;1230:		G_LogPrintf( "DD: %i %i %i: %s took point B for %s!\n", cl->ps.clientNum, clientTeam, 1, cl->pers.netname, TeamName(clientTeam) );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $707
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1232
;1231:		//Give personal score
;1232:		score = DD_POINT_CAPTURE; //Base score for capture
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1233
;1233:		if(otherDominating) {
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $708
line 1234
;1234:			score += DD_POINT_CAPTURE_BREAK;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1235
;1235:			if(isClose) {
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $710
line 1236
;1236:				score += DD_POINT_CAPTURE_CLOSE;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1237
;1237:			}
LABELV $710
line 1238
;1238:		}
LABELV $708
line 1239
;1239:		AddScore(other, ent->r.currentOrigin, score);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1241
;1240:		//Do we also have point A?
;1241:		if(clientTeam == level.pointStatusA) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+9264
INDIRI4
NEI4 $712
line 1243
;1242:			//We are dominating!
;1243:			level.timeTaken = level.time; //At this time
ADDRGP4 level+9272
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1244
;1244:			PrintMsg( NULL, "%s" S_COLOR_WHITE " is dominating!\n", TeamName(clientTeam) );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $696
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1245
;1245:			SendDDtimetakenMessageToAllClients();
ADDRGP4 SendDDtimetakenMessageToAllClients
CALLV
pop
line 1246
;1246:		}
LABELV $712
line 1247
;1247:	}
LABELV $697
line 1249
;1248:
;1249:	updateDDpoints();
ADDRGP4 updateDDpoints
CALLV
pop
line 1251
;1250:
;1251:	return 0;
CNSTI4 0
RETI4
LABELV $664
endproc Team_TouchDoubleDominationPoint 44 24
export Team_TouchOurFlag
proc Team_TouchOurFlag 80 28
line 1260
;1252:}
;1253:
;1254:/*
;1255:==============
;1256:Team_TouchOurFlag
;1257:==============
;1258:*/
;1259:int Team_TouchOurFlag( gentity_t *ent, gentity_t *other, int team )
;1260:{
line 1263
;1261:	int			i;
;1262:	gentity_t	*player;
;1263:	gclient_t	*cl = other->client;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1266
;1264:	int			enemy_flag;
;1265:
;1266:	if(G_UsesTheWhiteFlag(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $718
line 1267
;1267:		enemy_flag = PW_NEUTRALFLAG;
ADDRLP4 12
CNSTI4 9
ASGNI4
line 1268
;1268:	}
ADDRGP4 $719
JUMPV
LABELV $718
line 1269
;1269:	else {
line 1270
;1270:		if (cl->sess.sessionTeam == TEAM_RED) {
ADDRLP4 8
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 1
NEI4 $721
line 1271
;1271:			enemy_flag = PW_BLUEFLAG;
ADDRLP4 12
CNSTI4 8
ASGNI4
line 1272
;1272:		}
ADDRGP4 $722
JUMPV
LABELV $721
line 1273
;1273:		else {
line 1274
;1274:			enemy_flag = PW_REDFLAG;
ADDRLP4 12
CNSTI4 7
ASGNI4
line 1275
;1275:		}
LABELV $722
line 1277
;1276:
;1277:		if ( ent->flags & FL_DROPPED_ITEM ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $723
line 1279
;1278:			// hey, its not home.  return it by teleporting it back
;1279:			PrintMsg( NULL, "%s" S_COLOR_WHITE " returned the %s flag!\n",
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $725
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1281
;1280:			          cl->pers.netname, TeamName(team));
;1281:			AddScore(other, ent->r.currentOrigin, CTF_RECOVERY_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1282
;1282:			if(g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $726
line 1283
;1283:				G_LogPrintf( "CTF: %i %i %i: %s returned the %s flag!\n", cl->ps.clientNum, team, 2, cl->pers.netname, TeamName(team) );
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $729
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1284
;1284:			}
ADDRGP4 $727
JUMPV
LABELV $726
line 1285
;1285:			else if(g_gametype.integer == GT_CTF_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $730
line 1286
;1286:				G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s returned the %s flag!\n", level.roundNumber, cl->ps.clientNum, team, 2, cl->pers.netname, TeamName(team) );
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $733
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1287
;1287:			}
LABELV $730
LABELV $727
line 1288
;1288:			other->client->pers.teamState.flagrecovery++;
ADDRLP4 24
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 576
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1289
;1289:			other->client->pers.teamState.lastreturnedflag = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 1291
;1290:			//ResetFlag will remove this entity!  We must return zero
;1291:			Team_ReturnFlagSound(Team_ResetFlag(team), team);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 1292
;1292:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $717
JUMPV
LABELV $723
line 1294
;1293:		}
;1294:	}
LABELV $719
line 1298
;1295:
;1296:	// the flag is at home base.  if the player has the enemy
;1297:	// flag, he's just won!
;1298:	if (!cl->ps.powerups[enemy_flag]) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $736
line 1299
;1299:		return 0; // We don't have the flag
CNSTI4 0
RETI4
ADDRGP4 $717
JUMPV
LABELV $736
line 1301
;1300:	}
;1301:	if( g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $738
line 1302
;1302:		PrintMsg( NULL, "%s" S_COLOR_WHITE " captured the flag!\n", cl->pers.netname );
CNSTP4 0
ARGP4
ADDRGP4 $741
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1303
;1303:		G_LogPrintf( "1FCTF: %i %i %i: %s captured the flag!\n", cl->ps.clientNum, -1, 1, cl->pers.netname );
ADDRGP4 $742
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1304
;1304:	}
ADDRGP4 $739
JUMPV
LABELV $738
line 1305
;1305:	else {
line 1306
;1306:		PrintMsg( NULL, "%s" S_COLOR_WHITE " captured the %s flag!\n", cl->pers.netname, TeamName(OtherTeam(team)));
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $743
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1307
;1307:		if(g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $744
line 1308
;1308:			G_LogPrintf( "CTF: %i %i %i: %s captured the %s flag!\n", cl->ps.clientNum, OtherTeam(team), 1, cl->pers.netname, TeamName(OtherTeam(team)) );
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $747
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1309
;1309:		}
LABELV $744
line 1310
;1310:		if(g_gametype.integer == GT_CTF_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $748
line 1311
;1311:			G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s captured the %s flag!\n", level.roundNumber, cl->ps.clientNum, OtherTeam(team), 1, cl->pers.netname, TeamName(OtherTeam(team)) );
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $751
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1312
;1312:		}
LABELV $748
line 1313
;1313:	}
LABELV $739
line 1315
;1314:
;1315:	cl->ps.powerups[enemy_flag] = 0;
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 1317
;1316:
;1317:	teamgame.last_flag_capture = level.time;
ADDRGP4 teamgame
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 1318
;1318:	teamgame.last_capture_team = team;
ADDRGP4 teamgame+4
ADDRFP4 8
INDIRI4
ASGNI4
line 1321
;1319:
;1320:	// Increase the team's score
;1321:	AddTeamScore(ent->s.pos.trBase, other->client->sess.sessionTeam, 1);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 1322
;1322:	Team_ForceGesture(other->client->sess.sessionTeam);
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 1324
;1323:	//If CTF Elimination, stop the round:
;1324:	if(g_gametype.integer==GT_CTF_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $755
line 1325
;1325:		EndEliminationRound();
ADDRGP4 EndEliminationRound
CALLV
pop
line 1326
;1326:	}
LABELV $755
line 1328
;1327:
;1328:	other->client->pers.teamState.captures++;
ADDRLP4 20
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 564
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1330
;1329:	// add the sprite over the player's head
;1330:	other->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 24
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 1331
;1331:	other->client->ps.eFlags |= EF_AWARD_CAP;
ADDRLP4 28
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 1332
;1332:	other->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1333
;1333:	other->client->ps.persistant[PERS_CAPTURES]++;
ADDRLP4 32
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 304
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1334
;1334:	G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", other->client->ps.clientNum, 4, other->client->pers.netname, "CAPTURE" );
ADDRGP4 $316
ARGP4
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 36
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $759
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1335
;1335:	if(TeamCount(-1,TEAM_RED) && TeamCount(-1,TEAM_BLUE) && !level.hadBots) {
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $760
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 44
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $760
ADDRGP4 level+9436
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $760
line 1336
;1336:		ChallengeMessage(other,AWARD_CAPTURE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 303
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 1337
;1337:	}
LABELV $760
line 1339
;1338:	// other gets another 10 frag bonus
;1339:	AddScore(other, ent->r.currentOrigin, CTF_CAPTURE_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1341
;1340:
;1341:	Team_CaptureFlagSound( ent, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_CaptureFlagSound
CALLV
pop
line 1344
;1342:
;1343:	// Ok, let's do the player loop, hand out the bonuses
;1344:	for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $766
JUMPV
LABELV $763
line 1345
;1345:		player = &g_entities[i];
ADDRLP4 0
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1346
;1346:		if (!player->inuse || player == other) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $770
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $768
LABELV $770
line 1347
;1347:			continue;
ADDRGP4 $764
JUMPV
LABELV $768
line 1350
;1348:		}
;1349:
;1350:		if (player->client->sess.sessionTeam != cl->sess.sessionTeam) {
ADDRLP4 56
CNSTI4 1024
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
EQI4 $771
line 1351
;1351:			player->client->pers.teamState.lasthurtcarrier = -5;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 588
ADDP4
CNSTF4 3231711232
ASGNF4
line 1352
;1352:		}
ADDRGP4 $772
JUMPV
LABELV $771
line 1353
;1353:		else {
line 1354
;1354:			if (player != other) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
EQU4 $773
line 1355
;1355:				AddScore(player, ent->r.currentOrigin, CTF_TEAM_BONUS);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1356
;1356:			}
LABELV $773
line 1358
;1357:			// award extra points for capture assists
;1358:			if (player->client->pers.teamState.lastreturnedflag +
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
INDIRF4
CNSTF4 1176256512
ADDF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $775
line 1359
;1359:			        CTF_RETURN_FLAG_ASSIST_TIMEOUT > level.time) {
line 1360
;1360:				AddScore (player, ent->r.currentOrigin, CTF_RETURN_FLAG_ASSIST_BONUS);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1361
;1361:				other->client->pers.teamState.assists++;
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1363
;1362:
;1363:				player->client->ps.persistant[PERS_ASSIST_COUNT]++;
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1364
;1364:				if(!level.hadBots) {
ADDRGP4 level+9436
INDIRI4
CNSTI4 0
NEI4 $778
line 1365
;1365:					ChallengeMessage(player,AWARD_ASSIST);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 304
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 1366
;1366:				}
LABELV $778
line 1367
;1367:				G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", player->client->ps.clientNum, 5, player->client->pers.netname, "ASSIST" );
ADDRGP4 $316
ARGP4
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $781
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1369
;1368:				// add the sprite over the player's head
;1369:				player->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 1370
;1370:				player->client->ps.eFlags |= EF_AWARD_ASSIST;
ADDRLP4 76
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 1371
;1371:				player->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1373
;1372:
;1373:			}
LABELV $775
line 1374
;1374:			if (player->client->pers.teamState.lastfraggedcarrier +
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 600
ADDP4
INDIRF4
CNSTF4 1176256512
ADDF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $783
line 1375
;1375:			        CTF_FRAG_CARRIER_ASSIST_TIMEOUT > level.time) {
line 1376
;1376:				AddScore(player, ent->r.currentOrigin, CTF_FRAG_CARRIER_ASSIST_BONUS);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1377
;1377:				other->client->pers.teamState.assists++;
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1378
;1378:				player->client->ps.persistant[PERS_ASSIST_COUNT]++;
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1379
;1379:				if(!level.hadBots) {
ADDRGP4 level+9436
INDIRI4
CNSTI4 0
NEI4 $786
line 1380
;1380:					ChallengeMessage(player,AWARD_ASSIST);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 304
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 1381
;1381:				}
LABELV $786
line 1382
;1382:				G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", player->client->ps.clientNum, 5, player->client->pers.netname, "ASSIST" );
ADDRGP4 $316
ARGP4
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $781
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1384
;1383:				// add the sprite over the player's head
;1384:				player->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 1385
;1385:				player->client->ps.eFlags |= EF_AWARD_ASSIST;
ADDRLP4 76
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 1386
;1386:				player->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1387
;1387:			}
LABELV $783
line 1388
;1388:		}
LABELV $772
line 1389
;1389:	}
LABELV $764
line 1344
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $766
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $763
line 1390
;1390:	Team_ResetFlags();
ADDRGP4 Team_ResetFlags
CALLV
pop
line 1392
;1391:
;1392:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1394
;1393:
;1394:	return 0; // Do not respawn this automatically
CNSTI4 0
RETI4
LABELV $717
endproc Team_TouchOurFlag 80 28
export Team_TouchEnemyFlag
proc Team_TouchEnemyFlag 16 28
line 1398
;1395:}
;1396:
;1397:int Team_TouchEnemyFlag( gentity_t *ent, gentity_t *other, int team )
;1398:{
line 1399
;1399:	gclient_t *cl = other->client;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1401
;1400:
;1401:	if( g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $791
line 1402
;1402:		PrintMsg (NULL, "%s" S_COLOR_WHITE " got the flag!\n", other->client->pers.netname );
CNSTP4 0
ARGP4
ADDRGP4 $794
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1403
;1403:		G_LogPrintf( "1FCTF: %i %i %i: %s got the flag!\n", cl->ps.clientNum, team, 0, cl->pers.netname);
ADDRGP4 $795
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1405
;1404:
;1405:		cl->ps.powerups[PW_NEUTRALFLAG] = INT_MAX; // flags never expire
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
CNSTI4 2147483647
ASGNI4
line 1407
;1406:
;1407:		if( team == TEAM_RED ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $796
line 1408
;1408:			Team_SetFlagStatus( TEAM_FREE, FLAG_TAKEN_RED );
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 1409
;1409:		}
ADDRGP4 $792
JUMPV
LABELV $796
line 1410
;1410:		else {
line 1411
;1411:			Team_SetFlagStatus( TEAM_FREE, FLAG_TAKEN_BLUE );
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 1412
;1412:		}
line 1413
;1413:	}
ADDRGP4 $792
JUMPV
LABELV $791
line 1414
;1414:	else {
line 1415
;1415:		PrintMsg (NULL, "%s" S_COLOR_WHITE " got the %s flag!\n",
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $798
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1418
;1416:		          other->client->pers.netname, TeamName(team));
;1417:
;1418:		if(g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $799
line 1419
;1419:			G_LogPrintf( "CTF: %i %i %i: %s got the %s flag!\n", cl->ps.clientNum, team, 0, cl->pers.netname, TeamName(team));
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $802
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1420
;1420:		}
ADDRGP4 $800
JUMPV
LABELV $799
line 1421
;1421:		else if(g_gametype.integer == GT_CTF_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $803
line 1422
;1422:			G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s got the %s flag!\n", level.roundNumber, cl->ps.clientNum, team, 0, cl->pers.netname, TeamName(team));
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $806
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1423
;1423:		}
LABELV $803
LABELV $800
line 1425
;1424:
;1425:		if (team == TEAM_RED) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $808
line 1426
;1426:			cl->ps.powerups[PW_REDFLAG] = INT_MAX; // flags never expire
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 2147483647
ASGNI4
line 1427
;1427:		}
ADDRGP4 $809
JUMPV
LABELV $808
line 1428
;1428:		else {
line 1429
;1429:			cl->ps.powerups[PW_BLUEFLAG] = INT_MAX; // flags never expire
ADDRLP4 0
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 2147483647
ASGNI4
line 1430
;1430:		}
LABELV $809
line 1432
;1431:
;1432:		Team_SetFlagStatus( team, FLAG_TAKEN );
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 1433
;1433:	}
LABELV $792
line 1435
;1434:
;1435:	AddScore(other, ent->r.currentOrigin, CTF_FLAG_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1436
;1436:	cl->pers.teamState.flagsince = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ASGNF4
line 1437
;1437:	Team_TakeFlagSound( ent, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_TakeFlagSound
CALLV
pop
line 1439
;1438:
;1439:	return -1; // Do not respawn this automatically, but do delete it if it was FL_DROPPED
CNSTI4 -1
RETI4
LABELV $790
endproc Team_TouchEnemyFlag 16 28
export Pickup_Team
proc Pickup_Team 24 28
line 1443
;1440:}
;1441:
;1442:int Pickup_Team( gentity_t *ent, gentity_t *other )
;1443:{
line 1445
;1444:	int team;
;1445:	gclient_t *cl = other->client;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1447
;1446:
;1447:	if( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $812
line 1449
;1448:		// there are no team items that can be picked up in obelisk
;1449:		G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1450
;1450:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $811
JUMPV
LABELV $812
line 1453
;1451:	}
;1452:
;1453:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $815
line 1455
;1454:		// the only team items that can be picked up in harvester are the cubes
;1455:		if( ent->spawnflags != cl->sess.sessionTeam ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
EQI4 $818
line 1456
;1456:			cl->ps.generic1 += 1; //Skull pickedup
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1457
;1457:			G_LogPrintf("HARVESTER: %i %i %i %i %i: %s picked up a skull.\n",
ADDRGP4 $820
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1460
;1458:			            cl->ps.clientNum,cl->sess.sessionTeam,3,-1,1,
;1459:			            cl->pers.netname);
;1460:		}
ADDRGP4 $819
JUMPV
LABELV $818
line 1461
;1461:		else {
line 1462
;1462:			G_LogPrintf("HARVESTER: %i %i %i %i %i: %s destroyed a skull.\n,",
ADDRGP4 $821
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1465
;1463:			            cl->ps.clientNum,cl->sess.sessionTeam,2,-1,1,
;1464:			            cl->pers.netname);
;1465:		}
LABELV $819
line 1466
;1466:		G_FreeEntity( ent ); //Destory skull
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1467
;1467:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $811
JUMPV
LABELV $815
line 1469
;1468:	}
;1469:	if ( g_gametype.integer == GT_DOMINATION ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 12
NEI4 $822
line 1470
;1470:		Team_Dom_TakePoint(ent, cl->sess.sessionTeam,cl->ps.clientNum);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 Team_Dom_TakePoint
CALLV
pop
line 1471
;1471:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $811
JUMPV
LABELV $822
line 1474
;1472:	}
;1473:	// figure out what team this flag is
;1474:	if( strequals(ent->classname, "team_CTF_redflag") ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $385
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $825
line 1475
;1475:		team = TEAM_RED;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1476
;1476:	}
ADDRGP4 $826
JUMPV
LABELV $825
line 1477
;1477:	else if( strequals(ent->classname, "team_CTF_blueflag") ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $387
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $827
line 1478
;1478:		team = TEAM_BLUE;
ADDRLP4 4
CNSTI4 2
ASGNI4
line 1479
;1479:	}
ADDRGP4 $828
JUMPV
LABELV $827
line 1480
;1480:	else if( strequals(ent->classname, "team_CTF_neutralflag") ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $460
ARGP4
ADDRLP4 16
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $829
line 1481
;1481:		team = TEAM_FREE;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1482
;1482:	}
ADDRGP4 $830
JUMPV
LABELV $829
line 1483
;1483:	else {
line 1484
;1484:		PrintMsg ( other, "Don't know what team the flag is on.\n");
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $831
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1485
;1485:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $811
JUMPV
LABELV $830
LABELV $828
LABELV $826
line 1487
;1486:	}
;1487:	if (g_gametype.integer == GT_POSSESSION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
NEI4 $832
line 1488
;1488:		return Possession_TouchFlag( other );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Possession_TouchFlag
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $811
JUMPV
LABELV $832
line 1490
;1489:	}
;1490:	if( g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $835
line 1491
;1491:		if( team == TEAM_FREE ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $838
line 1492
;1492:			return Team_TouchEnemyFlag( ent, other, cl->sess.sessionTeam );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Team_TouchEnemyFlag
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $811
JUMPV
LABELV $838
line 1494
;1493:		}
;1494:		if( team != cl->sess.sessionTeam) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
EQI4 $840
line 1495
;1495:			return Team_TouchOurFlag( ent, other, cl->sess.sessionTeam );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Team_TouchOurFlag
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $811
JUMPV
LABELV $840
line 1497
;1496:		}
;1497:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $811
JUMPV
LABELV $835
line 1499
;1498:	}
;1499:	if( g_gametype.integer == GT_DOUBLE_D) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 11
NEI4 $842
line 1500
;1500:		return Team_TouchDoubleDominationPoint( ent, other, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Team_TouchDoubleDominationPoint
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $811
JUMPV
LABELV $842
line 1503
;1501:	}
;1502:	// GT_CTF
;1503:	if( team == cl->sess.sessionTeam) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
NEI4 $845
line 1504
;1504:		return Team_TouchOurFlag( ent, other, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Team_TouchOurFlag
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $811
JUMPV
LABELV $845
line 1506
;1505:	}
;1506:	return Team_TouchEnemyFlag( ent, other, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Team_TouchEnemyFlag
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
LABELV $811
endproc Pickup_Team 24 28
export Team_GetLocation
proc Team_GetLocation 48 8
line 1517
;1507:}
;1508:
;1509:/*
;1510:===========
;1511:Team_GetLocation
;1512:
;1513:Report a location for the player. Uses placed nearby target_location entities
;1514:============
;1515:*/
;1516:gentity_t *Team_GetLocation(gentity_t *ent)
;1517:{
line 1522
;1518:	gentity_t		*eloc, *best;
;1519:	float			bestlen, len;
;1520:	vec3_t			origin;
;1521:
;1522:	best = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 1523
;1523:	bestlen = 3*8192.0*8192.0;
ADDRLP4 20
CNSTF4 1296039936
ASGNF4
line 1525
;1524:
;1525:	VectorCopy( ent->r.currentOrigin, origin );
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1527
;1526:
;1527:	for (eloc = level.locationHead; eloc; eloc = eloc->nextTrain) {
ADDRLP4 0
ADDRGP4 level+9188
INDIRP4
ASGNP4
ADDRGP4 $851
JUMPV
LABELV $848
line 1528
;1528:		len = ( origin[0] - eloc->r.currentOrigin[0] ) * ( origin[0] - eloc->r.currentOrigin[0] )
ADDRLP4 32
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 32
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1532
;1529:		      + ( origin[1] - eloc->r.currentOrigin[1] ) * ( origin[1] - eloc->r.currentOrigin[1] )
;1530:		      + ( origin[2] - eloc->r.currentOrigin[2] ) * ( origin[2] - eloc->r.currentOrigin[2] );
;1531:
;1532:		if ( len > bestlen ) {
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LEF4 $857
line 1533
;1533:			continue;
ADDRGP4 $849
JUMPV
LABELV $857
line 1536
;1534:		}
;1535:
;1536:		if ( !trap_InPVS( origin, eloc->r.currentOrigin ) ) {
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $859
line 1537
;1537:			continue;
ADDRGP4 $849
JUMPV
LABELV $859
line 1540
;1538:		}
;1539:
;1540:		bestlen = len;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 1541
;1541:		best = eloc;
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
line 1542
;1542:	}
LABELV $849
line 1527
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
ASGNP4
LABELV $851
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $848
line 1544
;1543:
;1544:	return best;
ADDRLP4 24
INDIRP4
RETP4
LABELV $847
endproc Team_GetLocation 48 8
export Team_GetLocationMsg
proc Team_GetLocationMsg 12 24
line 1556
;1545:}
;1546:
;1547:
;1548:/*
;1549:===========
;1550:Team_GetLocation
;1551:
;1552:Report a location for the player. Uses placed nearby target_location entities
;1553:============
;1554:*/
;1555:qboolean Team_GetLocationMsg(gentity_t *ent, char *loc, int loclen)
;1556:{
line 1559
;1557:	gentity_t *best;
;1558:
;1559:	best = Team_GetLocation( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Team_GetLocation
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1561
;1560:
;1561:	if (!best) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $862
line 1562
;1562:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $861
JUMPV
LABELV $862
line 1565
;1563:	}
;1564:
;1565:	if (best->count) {
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $864
line 1566
;1566:		if (best->count < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
GEI4 $866
line 1567
;1567:			best->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 1568
;1568:		}
LABELV $866
line 1569
;1569:		if (best->count > 7) {
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 7
LEI4 $868
line 1570
;1570:			best->count = 7;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 7
ASGNI4
line 1571
;1571:		}
LABELV $868
line 1572
;1572:		Com_sprintf(loc, loclen, "%c%c%s" S_COLOR_WHITE, Q_COLOR_ESCAPE, best->count + '0', best->message );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $870
ARGP4
CNSTI4 94
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 48
ADDI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1573
;1573:	}
ADDRGP4 $865
JUMPV
LABELV $864
line 1574
;1574:	else {
line 1575
;1575:		Com_sprintf(loc, loclen, "%s", best->message);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $871
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1576
;1576:	}
LABELV $865
line 1578
;1577:
;1578:	return qtrue;
CNSTI4 1
RETI4
LABELV $861
endproc Team_GetLocationMsg 12 24
export SelectRandomEntityFilter
proc SelectRandomEntityFilter 532 12
line 1586
;1579:}
;1580:
;1581:
;1582:/*---------------------------------------------------------------------------*/
;1583:
;1584:#define MAX_RANDOM_SET_SIZE 128
;1585:gentity_t* SelectRandomEntityFilter (const char* classname, qboolean (*filter)(const gentity_t*))
;1586:{
line 1592
;1587:	gentity_t	*spot;
;1588:	int			count;
;1589:	int			selection;
;1590:	gentity_t	*spots[MAX_RANDOM_SET_SIZE];
;1591:
;1592:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1593
;1593:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $874
JUMPV
LABELV $873
line 1595
;1594:
;1595:	while ((spot = G_Find (spot, FOFS(classname), classname)) != NULL) {
line 1596
;1596:		if (filter) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $876
line 1597
;1597:			if (!filter(spot)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 524
ADDRFP4 4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 524
INDIRI4
CNSTI4 0
NEI4 $878
line 1598
;1598:				continue;
ADDRGP4 $874
JUMPV
LABELV $878
line 1600
;1599:			}
;1600:		}
LABELV $876
line 1601
;1601:		spots[ count ] = spot;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1602
;1602:		if (++count == MAX_RANDOM_SET_SIZE)
ADDRLP4 524
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 524
INDIRI4
ASGNI4
ADDRLP4 524
INDIRI4
CNSTI4 128
NEI4 $880
line 1603
;1603:			break;
ADDRGP4 $875
JUMPV
LABELV $880
line 1604
;1604:	}
LABELV $874
line 1595
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 524
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 524
INDIRP4
ASGNP4
ADDRLP4 524
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $873
LABELV $875
line 1606
;1605:
;1606:	if (!count) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $882
line 1607
;1607:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $872
JUMPV
LABELV $882
line 1610
;1608:	}
;1609:
;1610:	selection = rand() % count;
ADDRLP4 528
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 520
ADDRLP4 528
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
ASGNI4
line 1611
;1611:	return spots[ selection ];
ADDRLP4 520
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
RETP4
LABELV $872
endproc SelectRandomEntityFilter 532 12
export SelectRandomEntity
proc SelectRandomEntity 4 8
line 1615
;1612:}
;1613:
;1614:gentity_t* SelectRandomEntity (const char* classname)
;1615:{
line 1616
;1616:	return SelectRandomEntityFilter(classname, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ADDRGP4 SelectRandomEntityFilter
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
RETP4
LABELV $884
endproc SelectRandomEntity 4 8
export SelectRandomTeamSpawnPoint
proc SelectRandomTeamSpawnPoint 152 12
line 1628
;1617:}
;1618:
;1619:/*
;1620:================
;1621:SelectRandomTeamSpawnPoint
;1622:
;1623:go to a random point that doesn't telefrag
;1624:================
;1625:*/
;1626:#define	MAX_TEAM_SPAWN_POINTS	32
;1627:gentity_t *SelectRandomTeamSpawnPoint( int teamstate, team_t team )
;1628:{
line 1635
;1629:	gentity_t	*spot;
;1630:	int			count;
;1631:	int			selection;
;1632:	gentity_t	*spots[MAX_TEAM_SPAWN_POINTS];
;1633:	char		*classname;
;1634:
;1635:	if(g_gametype.integer == GT_ELIMINATION) { //change sides every round
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $886
line 1636
;1636:		if((level.roundNumber+level.eliminationSides)%2==1) {
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9256
INDIRI4
ADDI4
CNSTI4 2
MODI4
CNSTI4 1
NEI4 $889
line 1637
;1637:			if(team == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $893
line 1638
;1638:				team = TEAM_BLUE;
ADDRFP4 4
CNSTI4 2
ASGNI4
line 1639
;1639:			}
ADDRGP4 $894
JUMPV
LABELV $893
line 1640
;1640:			else if(team == TEAM_BLUE) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $895
line 1641
;1641:				team = TEAM_RED;
ADDRFP4 4
CNSTI4 1
ASGNI4
line 1642
;1642:			}
LABELV $895
LABELV $894
line 1643
;1643:		}
LABELV $889
line 1644
;1644:	}
LABELV $886
line 1646
;1645:
;1646:	if (teamstate == TEAM_BEGIN) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $897
line 1647
;1647:		if (team == TEAM_RED)
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $899
line 1648
;1648:			classname = "team_CTF_redplayer";
ADDRLP4 8
ADDRGP4 $901
ASGNP4
ADDRGP4 $898
JUMPV
LABELV $899
line 1649
;1649:		else if (team == TEAM_BLUE)
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $902
line 1650
;1650:			classname = "team_CTF_blueplayer";
ADDRLP4 8
ADDRGP4 $904
ASGNP4
ADDRGP4 $898
JUMPV
LABELV $902
line 1652
;1651:		else
;1652:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $885
JUMPV
line 1653
;1653:	}
LABELV $897
line 1654
;1654:	else {
line 1655
;1655:		if (team == TEAM_RED)
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $905
line 1656
;1656:			classname = "team_CTF_redspawn";
ADDRLP4 8
ADDRGP4 $907
ASGNP4
ADDRGP4 $906
JUMPV
LABELV $905
line 1657
;1657:		else if (team == TEAM_BLUE)
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $908
line 1658
;1658:			classname = "team_CTF_bluespawn";
ADDRLP4 8
ADDRGP4 $910
ASGNP4
ADDRGP4 $909
JUMPV
LABELV $908
line 1660
;1659:		else
;1660:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $885
JUMPV
LABELV $909
LABELV $906
line 1661
;1661:	}
LABELV $898
line 1662
;1662:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1664
;1663:
;1664:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $912
JUMPV
LABELV $911
line 1666
;1665:
;1666:	while ((spot = G_Find (spot, FOFS(classname), classname)) != NULL) {
line 1667
;1667:		if ( SpotWouldTelefrag( spot ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $914
line 1668
;1668:			continue;
ADDRGP4 $912
JUMPV
LABELV $914
line 1670
;1669:		}
;1670:		spots[ count ] = spot;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1671
;1671:		if (++count == MAX_TEAM_SPAWN_POINTS)
ADDRLP4 148
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 148
INDIRI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 32
NEI4 $916
line 1672
;1672:			break;
ADDRGP4 $913
JUMPV
LABELV $916
line 1673
;1673:	}
LABELV $912
line 1666
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 144
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $911
LABELV $913
line 1675
;1674:
;1675:	if ( !count ) {	// no spots that won't telefrag
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $918
line 1676
;1676:		return G_Find( NULL, FOFS(classname), classname);
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 148
INDIRP4
RETP4
ADDRGP4 $885
JUMPV
LABELV $918
line 1679
;1677:	}
;1678:
;1679:	selection = rand() % count;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 148
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
ASGNI4
line 1680
;1680:	return spots[ selection ];
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
RETP4
LABELV $885
endproc SelectRandomTeamSpawnPoint 152 12
export SelectRandomDDSpawnPoint
proc SelectRandomDDSpawnPoint 152 12
line 1692
;1681:}
;1682:
;1683:/*
;1684:================
;1685:SelectRandomDDSpawnPoint
;1686:
;1687:go to a random Double Domination Spawn Point
;1688:================
;1689:*/
;1690:#define	MAX_TEAM_SPAWN_POINTS	32
;1691:gentity_t *SelectRandomDDSpawnPoint( void )
;1692:{
line 1700
;1693:	gentity_t	*spot;
;1694:	int			count;
;1695:	int			selection;
;1696:	gentity_t	*spots[MAX_TEAM_SPAWN_POINTS];
;1697:	char		*classname;
;1698:
;1699:
;1700:	classname = "info_player_dd";
ADDRLP4 8
ADDRGP4 $921
ASGNP4
line 1702
;1701:
;1702:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1704
;1703:
;1704:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $923
JUMPV
LABELV $922
line 1706
;1705:
;1706:	while ((spot = G_Find (spot, FOFS(classname), classname)) != NULL) {
line 1707
;1707:		if ( SpotWouldTelefrag( spot ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $925
line 1708
;1708:			continue;
ADDRGP4 $923
JUMPV
LABELV $925
line 1710
;1709:		}
;1710:		spots[ count ] = spot;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1711
;1711:		if (++count == MAX_TEAM_SPAWN_POINTS)
ADDRLP4 148
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 148
INDIRI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 32
NEI4 $927
line 1712
;1712:			break;
ADDRGP4 $924
JUMPV
LABELV $927
line 1713
;1713:	}
LABELV $923
line 1706
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 144
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $922
LABELV $924
line 1715
;1714:
;1715:	if ( !count ) {	// no spots that won't telefrag
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $929
line 1716
;1716:		return G_Find( NULL, FOFS(classname), classname);
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 148
INDIRP4
RETP4
ADDRGP4 $920
JUMPV
LABELV $929
line 1719
;1717:	}
;1718:
;1719:	selection = rand() % count;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 148
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
ASGNI4
line 1720
;1720:	return spots[ selection ];
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
RETP4
LABELV $920
endproc SelectRandomDDSpawnPoint 152 12
export SelectRandomTeamDDSpawnPoint
proc SelectRandomTeamDDSpawnPoint 152 12
line 1724
;1721:}
;1722:
;1723:gentity_t *SelectRandomTeamDDSpawnPoint( team_t team )
;1724:{
line 1731
;1725:	gentity_t	*spot;
;1726:	int			count;
;1727:	int			selection;
;1728:	gentity_t	*spots[MAX_TEAM_SPAWN_POINTS];
;1729:	char		*classname;
;1730:
;1731:	if(team == TEAM_RED) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $932
line 1732
;1732:		classname = "info_player_dd_red";
ADDRLP4 8
ADDRGP4 $934
ASGNP4
line 1733
;1733:	}
ADDRGP4 $933
JUMPV
LABELV $932
line 1734
;1734:	else {
line 1735
;1735:		classname = "info_player_dd_blue";
ADDRLP4 8
ADDRGP4 $935
ASGNP4
line 1736
;1736:	}
LABELV $933
line 1738
;1737:
;1738:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1740
;1739:
;1740:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $937
JUMPV
LABELV $936
line 1742
;1741:
;1742:	while ((spot = G_Find (spot, FOFS(classname), classname)) != NULL) {
line 1743
;1743:		if ( SpotWouldTelefrag( spot ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $939
line 1744
;1744:			continue;
ADDRGP4 $937
JUMPV
LABELV $939
line 1746
;1745:		}
;1746:		spots[ count ] = spot;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1747
;1747:		if (++count == MAX_TEAM_SPAWN_POINTS)
ADDRLP4 148
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 148
INDIRI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 32
NEI4 $941
line 1748
;1748:			break;
ADDRGP4 $938
JUMPV
LABELV $941
line 1749
;1749:	}
LABELV $937
line 1742
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 144
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $936
LABELV $938
line 1751
;1750:
;1751:	if ( !count ) {	// no spots that won't telefrag
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $943
line 1752
;1752:		return G_Find( NULL, FOFS(classname), classname);
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 148
INDIRP4
RETP4
ADDRGP4 $931
JUMPV
LABELV $943
line 1755
;1753:	}
;1754:
;1755:	selection = rand() % count;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 148
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
ASGNI4
line 1756
;1756:	return spots[ selection ];
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
RETP4
LABELV $931
endproc SelectRandomTeamDDSpawnPoint 152 12
export SelectRandomTeamDomSpawnPoint
proc SelectRandomTeamDomSpawnPoint 152 12
line 1760
;1757:}
;1758:
;1759:gentity_t *SelectRandomTeamDomSpawnPoint( team_t team )
;1760:{
line 1767
;1761:	gentity_t	*spot;
;1762:	int			count;
;1763:	int			selection;
;1764:	gentity_t	*spots[MAX_TEAM_SPAWN_POINTS];
;1765:	char		*classname;
;1766:
;1767:	if(team == TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $946
line 1768
;1768:		classname = "info_player_dom_red";
ADDRLP4 8
ADDRGP4 $948
ASGNP4
ADDRGP4 $947
JUMPV
LABELV $946
line 1770
;1769:	else
;1770:		classname = "info_player_dom_blue";
ADDRLP4 8
ADDRGP4 $949
ASGNP4
LABELV $947
line 1772
;1771:
;1772:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1774
;1773:
;1774:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $951
JUMPV
LABELV $950
line 1776
;1775:
;1776:	while ((spot = G_Find (spot, FOFS(classname), classname)) != NULL) {
line 1777
;1777:		if ( SpotWouldTelefrag( spot ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $953
line 1778
;1778:			continue;
ADDRGP4 $951
JUMPV
LABELV $953
line 1780
;1779:		}
;1780:		spots[ count ] = spot;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1781
;1781:		if (++count == MAX_TEAM_SPAWN_POINTS)
ADDRLP4 148
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 148
INDIRI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 32
NEI4 $955
line 1782
;1782:			break;
ADDRGP4 $952
JUMPV
LABELV $955
line 1783
;1783:	}
LABELV $951
line 1776
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 144
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $950
LABELV $952
line 1785
;1784:
;1785:	if ( !count ) {	// no spots that won't telefrag
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $957
line 1786
;1786:		return G_Find( NULL, FOFS(classname), classname);
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 148
INDIRP4
RETP4
ADDRGP4 $945
JUMPV
LABELV $957
line 1789
;1787:	}
;1788:
;1789:	selection = rand() % count;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 148
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
ASGNI4
line 1790
;1790:	return spots[ selection ];
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
RETP4
LABELV $945
endproc SelectRandomTeamDomSpawnPoint 152 12
export SelectCTFSpawnPoint
proc SelectCTFSpawnPoint 12 16
line 1801
;1791:}
;1792:
;1793:
;1794:/*
;1795:===========
;1796:SelectCTFSpawnPoint
;1797:
;1798:============
;1799:*/
;1800:gentity_t *SelectCTFSpawnPoint ( team_t team, int teamstate, vec3_t origin, vec3_t angles )
;1801:{
line 1804
;1802:	gentity_t	*spot;
;1803:
;1804:	spot = SelectRandomTeamSpawnPoint ( teamstate, team );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 SelectRandomTeamSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1806
;1805:
;1806:	if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $960
line 1807
;1807:		return SelectSpawnPoint( vec3_origin, origin, angles, 0 );
ADDRGP4 vec3_origin
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $959
JUMPV
LABELV $960
line 1810
;1808:	}
;1809:
;1810:	VectorCopy (spot->s.origin, origin);
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1811
;1811:	origin[2] += 9;
ADDRLP4 8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 1812
;1812:	VectorCopy (spot->s.angles, angles);
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1814
;1813:
;1814:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $959
endproc SelectCTFSpawnPoint 12 16
export SelectDoubleDominationSpawnPoint
proc SelectDoubleDominationSpawnPoint 12 16
line 1824
;1815:}
;1816:
;1817:/*
;1818:===========
;1819:SelectDoubleDominationSpawnPoint
;1820:
;1821:============
;1822:*/
;1823:gentity_t *SelectDoubleDominationSpawnPoint ( team_t team, vec3_t origin, vec3_t angles )
;1824:{
line 1827
;1825:	gentity_t	*spot;
;1826:
;1827:	spot = SelectRandomTeamDDSpawnPoint( team );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 SelectRandomTeamDDSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1829
;1828:
;1829:	if(!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $963
line 1830
;1830:		spot = SelectRandomDDSpawnPoint ( );
ADDRLP4 8
ADDRGP4 SelectRandomDDSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1831
;1831:	}
LABELV $963
line 1833
;1832:
;1833:	if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $965
line 1834
;1834:		return SelectSpawnPoint( vec3_origin, origin, angles, 0 );
ADDRGP4 vec3_origin
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $962
JUMPV
LABELV $965
line 1837
;1835:	}
;1836:
;1837:	VectorCopy (spot->s.origin, origin);
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1838
;1838:	origin[2] += 9;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 1839
;1839:	VectorCopy (spot->s.angles, angles);
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1841
;1840:
;1841:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $962
endproc SelectDoubleDominationSpawnPoint 12 16
export SelectDominationSpawnPoint
proc SelectDominationSpawnPoint 12 16
line 1851
;1842:}
;1843:
;1844:/*
;1845:===========
;1846:SelectDominationSpawnPoint
;1847:
;1848:============
;1849:*/
;1850:gentity_t *SelectDominationSpawnPoint ( team_t team, vec3_t origin, vec3_t angles )
;1851:{
line 1854
;1852:	gentity_t	*spot;
;1853:
;1854:	spot = SelectRandomTeamDomSpawnPoint( team );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 SelectRandomTeamDomSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1856
;1855:
;1856:	if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $968
line 1857
;1857:		return SelectSpawnPoint( vec3_origin, origin, angles, 0 );
ADDRGP4 vec3_origin
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $967
JUMPV
LABELV $968
line 1860
;1858:	}
;1859:
;1860:	VectorCopy (spot->s.origin, origin);
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1861
;1861:	origin[2] += 9;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 1862
;1862:	VectorCopy (spot->s.angles, angles);
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1864
;1863:
;1864:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $967
endproc SelectDominationSpawnPoint 12 16
proc SortClients 0 0
line 1870
;1865:}
;1866:
;1867:/*---------------------------------------------------------------------------*/
;1868:
;1869:static int QDECL SortClients( const void *a, const void *b )
;1870:{
line 1871
;1871:	return *(int *)a - *(int *)b;
ADDRFP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRP4
INDIRI4
SUBI4
RETI4
LABELV $970
endproc SortClients 0 0
export TeamplayInfoMessage
proc TeamplayInfoMessage 9408 36
line 1885
;1872:}
;1873:
;1874:
;1875:/*
;1876:==================
;1877:TeamplayLocationsMessage
;1878:
;1879:Format:
;1880:	clientNum location health armor weapon powerups
;1881:
;1882:==================
;1883:*/
;1884:void TeamplayInfoMessage( gentity_t *ent )
;1885:{
line 1896
;1886:	char		entry[1024];
;1887:	char		string[8192];
;1888:	int			stringlength;
;1889:	int			i, j;
;1890:	gentity_t	*player;
;1891:	int			cnt;
;1892:	int			h, a, w;
;1893:	int			clients[TEAM_MAXOVERLAY];
;1894:	int			team;
;1895:
;1896:	if ( ! ent->client->pers.teamInfo )
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $972
line 1897
;1897:		return;
ADDRGP4 $971
JUMPV
LABELV $972
line 1900
;1898:
;1899:	// send team info to spectator for team of followed client
;1900:	if (ent->client->sess.sessionTeam == TEAM_SPECTATOR) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $974
line 1901
;1901:		if ( ent->client->sess.spectatorState != SPECTATOR_FOLLOW
ADDRLP4 9380
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 9380
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
NEI4 $978
ADDRLP4 9380
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
CNSTI4 0
GEI4 $976
LABELV $978
line 1902
;1902:		        || ent->client->sess.spectatorClient < 0 ) {
line 1903
;1903:			return;
ADDRGP4 $971
JUMPV
LABELV $976
line 1905
;1904:		}
;1905:		team = g_entities[ ent->client->sess.spectatorClient ].client->sess.sessionTeam;
ADDRLP4 12
CNSTI4 816
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 1906
;1906:	}
ADDRGP4 $975
JUMPV
LABELV $974
line 1907
;1907:	else {
line 1908
;1908:		team = ent->client->sess.sessionTeam;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 1909
;1909:	}
LABELV $975
line 1911
;1910:
;1911:	if (team != TEAM_RED && team != TEAM_BLUE) {
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $980
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $980
line 1912
;1912:		return;
ADDRGP4 $971
JUMPV
LABELV $980
line 1918
;1913:	}
;1914:
;1915:	// figure out what client should be on the display
;1916:	// we are limited to 8, but we want to use the top eight players
;1917:	// but in client order (so they don't keep changing position on the overlay)
;1918:	for (i = 0, cnt = 0; i < g_maxclients.integer && i < MAX_CLIENTS && cnt < TEAM_MAXOVERLAY; i++) {
ADDRLP4 9384
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRLP4 9384
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 9384
INDIRI4
ASGNI4
ADDRGP4 $985
JUMPV
LABELV $982
line 1919
;1919:		player = g_entities + level.sortedClients[i];
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1920
;1920:		if (player->inuse && player->client->sess.sessionTeam == team ) {
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $988
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $988
line 1921
;1921:			clients[cnt++] = level.sortedClients[i];
ADDRLP4 9392
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 9392
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 9396
CNSTI4 2
ASGNI4
ADDRLP4 9392
INDIRI4
ADDRLP4 9396
INDIRI4
LSHI4
ADDRLP4 9252
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 9396
INDIRI4
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
ASGNI4
line 1922
;1922:		}
LABELV $988
line 1923
;1923:	}
LABELV $983
line 1918
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $985
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
GEI4 $992
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $992
ADDRLP4 8
INDIRI4
CNSTI4 32
LTI4 $982
LABELV $992
line 1926
;1924:
;1925:	// We have the top eight players, sort them by clientNum
;1926:	qsort( clients, cnt, sizeof( clients[0] ), SortClients );
ADDRLP4 9252
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 SortClients
ARGP4
ADDRGP4 qsort
CALLV
pop
line 1929
;1927:
;1928:	// send the latest information on all clients
;1929:	string[0] = 0;
ADDRLP4 1060
CNSTI1 0
ASGNI1
line 1930
;1930:	stringlength = 0;
ADDRLP4 1048
CNSTI4 0
ASGNI4
line 1932
;1931:
;1932:	for (i = 0, cnt = 0; i < g_maxclients.integer && i < MAX_GENTITIES && cnt < TEAM_MAXOVERLAY; i++) {
ADDRLP4 9392
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRLP4 9392
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 9392
INDIRI4
ASGNI4
ADDRGP4 $996
JUMPV
LABELV $993
line 1933
;1933:		player = g_entities + i;
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1934
;1934:		if (player->inuse && player->client->sess.sessionTeam == team ) {
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $998
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $998
line 1936
;1935:
;1936:			h = player->client->ps.stats[STAT_HEALTH];
ADDRLP4 1040
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 1937
;1937:			a = player->client->ps.stats[STAT_ARMOR];
ADDRLP4 1044
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 1938
;1938:			w = player->client->ps.weapon;
ADDRLP4 1056
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 1939
;1939:			if(player->client->isEliminated) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1000
line 1940
;1940:				h = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 1941
;1941:				a = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 1942
;1942:				w = 0;
ADDRLP4 1056
CNSTI4 0
ASGNI4
line 1943
;1943:			}
LABELV $1000
line 1944
;1944:			if (h < 0) h = 0;
ADDRLP4 1040
INDIRI4
CNSTI4 0
GEI4 $1002
ADDRLP4 1040
CNSTI4 0
ASGNI4
LABELV $1002
line 1945
;1945:			if (a < 0) a = 0;
ADDRLP4 1044
INDIRI4
CNSTI4 0
GEI4 $1004
ADDRLP4 1044
CNSTI4 0
ASGNI4
LABELV $1004
line 1947
;1946:
;1947:			Com_sprintf (entry, sizeof(entry),
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1006
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1044
INDIRI4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1952
;1948:			             " %i %i %i %i %i %i",
;1949://				level.sortedClients[i], player->client->pers.teamState.location, h, a,
;1950:			             i, player->client->pers.teamState.location, h, a,
;1951:			             w, player->s.powerups);
;1952:			j = strlen(entry);
ADDRLP4 16
ARGP4
ADDRLP4 9404
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1052
ADDRLP4 9404
INDIRI4
ASGNI4
line 1953
;1953:			if (stringlength + j > sizeof(string))
ADDRLP4 1048
INDIRI4
ADDRLP4 1052
INDIRI4
ADDI4
CVIU4 4
CNSTU4 8192
LEU4 $1007
line 1954
;1954:				break;
ADDRGP4 $995
JUMPV
LABELV $1007
line 1955
;1955:			strcpy (string + stringlength, entry);
ADDRLP4 1048
INDIRI4
ADDRLP4 1060
ADDP4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1956
;1956:			stringlength += j;
ADDRLP4 1048
ADDRLP4 1048
INDIRI4
ADDRLP4 1052
INDIRI4
ADDI4
ASGNI4
line 1957
;1957:			cnt++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1958
;1958:		}
LABELV $998
line 1959
;1959:	}
LABELV $994
line 1932
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $996
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
GEI4 $1010
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $1010
ADDRLP4 8
INDIRI4
CNSTI4 32
LTI4 $993
LABELV $1010
LABELV $995
line 1961
;1960:
;1961:	trap_SendServerCommand( ent-g_entities, va("tinfo %i %s", cnt, string) );
ADDRGP4 $1011
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1060
ARGP4
ADDRLP4 9400
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 9400
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1962
;1962:}
LABELV $971
endproc TeamplayInfoMessage 9408 36
export CheckTeamStatus
proc CheckTeamStatus 24 4
line 1965
;1963:
;1964:void CheckTeamStatus(void)
;1965:{
line 1969
;1966:	int i;
;1967:	gentity_t *loc, *ent;
;1968:
;1969:	if (level.time - level.lastTeamLocationTime > TEAM_LOCATION_UPDATE_TIME) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+60
INDIRI4
SUBI4
CNSTI4 1000
LEI4 $1013
line 1971
;1970:
;1971:		level.lastTeamLocationTime = level.time;
ADDRGP4 level+60
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1973
;1972:
;1973:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1022
JUMPV
LABELV $1019
line 1974
;1974:			ent = g_entities + i;
ADDRLP4 0
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1976
;1975:
;1976:			if ( ent->client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1024
line 1977
;1977:				continue;
ADDRGP4 $1020
JUMPV
LABELV $1024
line 1980
;1978:			}
;1979:
;1980:			if (ent->inuse && (ent->client->sess.sessionTeam == TEAM_RED ||	ent->client->sess.sessionTeam == TEAM_BLUE)) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1026
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $1028
ADDRLP4 16
INDIRI4
CNSTI4 2
NEI4 $1026
LABELV $1028
line 1981
;1981:				loc = Team_GetLocation( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Team_GetLocation
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 1982
;1982:				if (loc)
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1029
line 1983
;1983:					ent->client->pers.teamState.location = loc->health;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 560
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $1030
JUMPV
LABELV $1029
line 1985
;1984:				else
;1985:					ent->client->pers.teamState.location = 0;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 0
ASGNI4
LABELV $1030
line 1986
;1986:			}
LABELV $1026
line 1987
;1987:		}
LABELV $1020
line 1973
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1022
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $1019
line 1989
;1988:
;1989:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1034
JUMPV
LABELV $1031
line 1990
;1990:			ent = g_entities + i;
ADDRLP4 0
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1992
;1991:
;1992:			if ( ent->client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1036
line 1993
;1993:				continue;
ADDRGP4 $1032
JUMPV
LABELV $1036
line 1996
;1994:			}
;1995:
;1996:			if (ent->inuse) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1038
line 1997
;1997:				TeamplayInfoMessage( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamplayInfoMessage
CALLV
pop
line 1998
;1998:			}
LABELV $1038
line 1999
;1999:		}
LABELV $1032
line 1989
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1034
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $1031
line 2000
;2000:	}
LABELV $1013
line 2001
;2001:}
LABELV $1012
endproc CheckTeamStatus 24 4
export SP_team_CTF_redplayer
proc SP_team_CTF_redplayer 0 0
line 2009
;2002:
;2003:/*-----------------------------------------------------------------*/
;2004:
;2005:/*QUAKED team_CTF_redplayer (1 0 0) (-16 -16 -24) (16 16 32)
;2006:Only in CTF games.  Red players spawn here at game start.
;2007:*/
;2008:void SP_team_CTF_redplayer( gentity_t *ent )
;2009:{
line 2010
;2010:}
LABELV $1040
endproc SP_team_CTF_redplayer 0 0
export SP_team_CTF_blueplayer
proc SP_team_CTF_blueplayer 0 0
line 2017
;2011:
;2012:
;2013:/*QUAKED team_CTF_blueplayer (0 0 1) (-16 -16 -24) (16 16 32)
;2014:Only in CTF games.  Blue players spawn here at game start.
;2015:*/
;2016:void SP_team_CTF_blueplayer( gentity_t *ent )
;2017:{
line 2018
;2018:}
LABELV $1041
endproc SP_team_CTF_blueplayer 0 0
export SP_team_CTF_redspawn
proc SP_team_CTF_redspawn 0 0
line 2026
;2019:
;2020:
;2021:/*QUAKED team_CTF_redspawn (1 0 0) (-16 -16 -24) (16 16 32)
;2022:potential spawning position for red team in CTF games.
;2023:Targets will be fired when someone spawns in on them.
;2024:*/
;2025:void SP_team_CTF_redspawn(gentity_t *ent)
;2026:{
line 2027
;2027:}
LABELV $1042
endproc SP_team_CTF_redspawn 0 0
export SP_team_CTF_bluespawn
proc SP_team_CTF_bluespawn 0 0
line 2034
;2028:
;2029:/*QUAKED team_CTF_bluespawn (0 0 1) (-16 -16 -24) (16 16 32)
;2030:potential spawning position for blue team in CTF games.
;2031:Targets will be fired when someone spawns in on them.
;2032:*/
;2033:void SP_team_CTF_bluespawn(gentity_t *ent)
;2034:{
line 2035
;2035:}
LABELV $1043
endproc SP_team_CTF_bluespawn 0 0
proc ObeliskHealthChange 8 0
line 2063
;2036:
;2037:/*QUAKED info_player_dd (1 1 0) (-16 -16 -24) (16 16 32)
;2038:Spawn point used in Double Domination if no team specific spawn points exists
;2039:Usually placed in the middle of CTF maps
;2040:See info_player_dd_red and info_player_dd_blue for team specific versions
;2041:*/
;2042:
;2043:/*QUAKED info_player_dd_red (1 1 0) (-16 -16 -24) (16 16 32)
;2044:Spawn point used in Double Domination by the red team
;2045:*/
;2046:
;2047:/*QUAKED info_player_dd_blue (1 1 0) (-16 -16 -24) (16 16 32)
;2048:Spawn point used in Double Domination by the blue team
;2049:*/
;2050:
;2051:/*QUAKED domination_point (1 0 .5) (-16 -16 -16) (16 16 16)
;2052:Place to spawn domination points in Standard domination.
;2053:The message-key gives the point a name that is showed while playing (MAX length: 19 chars)
;2054:*/
;2055:
;2056:/*
;2057:================
;2058:Obelisks
;2059:================
;2060:*/
;2061:
;2062:static void ObeliskHealthChange( int team, int health )
;2063:{
line 2065
;2064:	int currentPercentage;
;2065:	int percentage = (health*100)/g_obeliskHealth.integer;
ADDRLP4 0
CNSTI4 100
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 g_obeliskHealth+12
INDIRI4
DIVI4
ASGNI4
line 2066
;2066:	if(percentage < 0)
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1046
line 2067
;2067:		percentage = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1046
line 2068
;2068:	currentPercentage = level.healthRedObelisk;
ADDRLP4 4
ADDRGP4 level+9476
INDIRI4
ASGNI4
line 2069
;2069:	if(team != TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
EQI4 $1049
line 2070
;2070:		currentPercentage = level.healthBlueObelisk;
ADDRLP4 4
ADDRGP4 level+9480
INDIRI4
ASGNI4
LABELV $1049
line 2071
;2071:	if(percentage != currentPercentage) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $1052
line 2072
;2072:		if(team == TEAM_RED) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $1054
line 2073
;2073:			level.healthRedObelisk = percentage;
ADDRGP4 level+9476
ADDRLP4 0
INDIRI4
ASGNI4
line 2074
;2074:		}
ADDRGP4 $1055
JUMPV
LABELV $1054
line 2075
;2075:		else {
line 2076
;2076:			level.healthBlueObelisk = percentage;
ADDRGP4 level+9480
ADDRLP4 0
INDIRI4
ASGNI4
line 2077
;2077:		}
LABELV $1055
line 2078
;2078:		level.MustSendObeliskHealth = qtrue;
ADDRGP4 level+9484
CNSTI4 1
ASGNI4
line 2080
;2079:		//G_Printf("Obelisk health %i %i\n",team,percentage);
;2080:		ObeliskHealthMessage();
ADDRGP4 ObeliskHealthMessage
CALLV
pop
line 2081
;2081:	}
LABELV $1052
line 2082
;2082:}
LABELV $1044
endproc ObeliskHealthChange 8 0
proc ObeliskRegen 12 12
line 2085
;2083:
;2084:static void ObeliskRegen( gentity_t *self )
;2085:{
line 2086
;2086:	self->nextthink = level.time + g_obeliskRegenPeriod.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_obeliskRegenPeriod+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 2087
;2087:	ObeliskHealthChange(self->spawnflags,self->health);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ARGI4
ADDRGP4 ObeliskHealthChange
CALLV
pop
line 2088
;2088:	if( self->health >= g_obeliskHealth.integer ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 g_obeliskHealth+12
INDIRI4
LTI4 $1062
line 2089
;2089:		return;
ADDRGP4 $1059
JUMPV
LABELV $1062
line 2092
;2090:	}
;2091:
;2092:	G_AddEvent( self, EV_POWERUP_REGEN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 63
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 2093
;2093:	self->health += g_obeliskRegenAmount.integer;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 g_obeliskRegenAmount+12
INDIRI4
ADDI4
ASGNI4
line 2094
;2094:	if ( self->health > g_obeliskHealth.integer ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 g_obeliskHealth+12
INDIRI4
LEI4 $1066
line 2095
;2095:		self->health = g_obeliskHealth.integer;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 g_obeliskHealth+12
INDIRI4
ASGNI4
line 2096
;2096:	}
LABELV $1066
line 2098
;2097:
;2098:	self->activator->s.modelindex2 = self->health * 0xff / g_obeliskHealth.integer;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 255
ADDRLP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
MULI4
ADDRGP4 g_obeliskHealth+12
INDIRI4
DIVI4
ASGNI4
line 2099
;2099:	self->activator->s.frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 0
ASGNI4
line 2100
;2100:}
LABELV $1059
endproc ObeliskRegen 12 12
proc ObeliskRespawn 0 0
line 2104
;2101:
;2102:
;2103:static void ObeliskRespawn( gentity_t *self )
;2104:{
line 2105
;2105:	self->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 2106
;2106:	self->health = g_obeliskHealth.integer;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 g_obeliskHealth+12
INDIRI4
ASGNI4
line 2108
;2107:
;2108:	self->think = ObeliskRegen;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ObeliskRegen
ASGNP4
line 2109
;2109:	self->nextthink = level.time + g_obeliskRegenPeriod.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_obeliskRegenPeriod+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 2111
;2110:
;2111:	self->activator->s.frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 0
ASGNI4
line 2112
;2112:}
LABELV $1071
endproc ObeliskRespawn 0 0
proc ObeliskDie 44 24
line 2116
;2113:
;2114:
;2115:static void ObeliskDie( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int mod )
;2116:{
line 2119
;2117:	int			otherTeam;
;2118:
;2119:	otherTeam = OtherTeam( self->spawnflags );
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2120
;2120:	AddTeamScore(self->s.pos.trBase, otherTeam, 1);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 2121
;2121:	Team_ForceGesture(otherTeam);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 2123
;2122:
;2123:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 2125
;2124:
;2125:	self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 2126
;2126:	self->think = ObeliskRespawn;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ObeliskRespawn
ASGNP4
line 2127
;2127:	self->nextthink = level.time + g_obeliskRespawnDelay.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_obeliskRespawnDelay+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 2129
;2128:
;2129:	self->activator->s.modelindex2 = 0xff;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 255
ASGNI4
line 2130
;2130:	self->activator->s.frame = 2;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 2
ASGNI4
line 2132
;2131:
;2132:	G_AddEvent( self->activator, EV_OBELISKEXPLODE, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
CNSTI4 69
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 2134
;2133:
;2134:	AddScore(attacker, self->r.currentOrigin, CTF_CAPTURE_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 2137
;2135:
;2136:	// add the sprite over the player's head
;2137:	attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 8
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 2138
;2138:	attacker->client->ps.eFlags |= EF_AWARD_CAP;
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 2139
;2139:	attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 2140
;2140:	attacker->client->ps.persistant[PERS_CAPTURES]++;
ADDRLP4 16
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 304
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2141
;2141:	G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", attacker->client->ps.clientNum, 4, attacker->client->pers.netname, "CAPTURE" );
ADDRGP4 $316
ARGP4
ADDRLP4 20
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $759
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 2142
;2142:	G_LogPrintf("OBELISK: %i %i %i %i: %s destroyed the enemy obelisk.\n",
ADDRGP4 $1079
ARGP4
ADDRLP4 24
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 2145
;2143:	            attacker->client->ps.clientNum,attacker->client->sess.sessionTeam,3,0,
;2144:	            attacker->client->pers.netname);
;2145:	if(TeamCount(-1,TEAM_RED) && TeamCount(-1,TEAM_BLUE) && !level.hadBots) {
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 28
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $1080
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 32
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $1080
ADDRGP4 level+9436
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1080
line 2146
;2146:		ChallengeMessage(attacker,AWARD_CAPTURE);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 303
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 2147
;2147:	}
LABELV $1080
line 2148
;2148:	ObeliskHealthChange(self->spawnflags,self->health);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ARGI4
ADDRGP4 ObeliskHealthChange
CALLV
pop
line 2149
;2149:	teamgame.redObeliskAttackedTime = 0;
ADDRGP4 teamgame+28
CNSTI4 0
ASGNI4
line 2150
;2150:	teamgame.blueObeliskAttackedTime = 0;
ADDRGP4 teamgame+32
CNSTI4 0
ASGNI4
line 2151
;2151:}
LABELV $1075
endproc ObeliskDie 44 24
proc ObeliskTouch 64 40
line 2155
;2152:
;2153:
;2154:static void ObeliskTouch( gentity_t *self, gentity_t *other, trace_t *trace )
;2155:{
line 2158
;2156:	int			tokens,i;
;2157:
;2158:	if ( !other->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1086
line 2159
;2159:		return;
ADDRGP4 $1085
JUMPV
LABELV $1086
line 2162
;2160:	}
;2161:
;2162:	if ( OtherTeam(other->client->sess.sessionTeam) != self->spawnflags ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
EQI4 $1088
line 2163
;2163:		return;
ADDRGP4 $1085
JUMPV
LABELV $1088
line 2166
;2164:	}
;2165:
;2166:	tokens = other->client->ps.generic1;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 2167
;2167:	if( tokens <= 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GTI4 $1090
line 2168
;2168:		return;
ADDRGP4 $1085
JUMPV
LABELV $1090
line 2171
;2169:	}
;2170:
;2171:	PrintMsg(NULL, "%s" S_COLOR_WHITE " brought in %i %s.\n",
CNSTP4 0
ARGP4
ADDRGP4 $1092
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $1096
ADDRLP4 12
ADDRGP4 $1093
ASGNP4
ADDRGP4 $1097
JUMPV
LABELV $1096
ADDRLP4 12
ADDRGP4 $1094
ASGNP4
LABELV $1097
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 2174
;2172:		other->client->pers.netname, tokens, ( tokens == 1 ) ? "skull" : "skulls" );
;2173:
;2174:	G_LogPrintf("HARVESTER: %i %i %i %i %i: %s brought in %i skull%s for %s\n",
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $1098
ARGP4
ADDRLP4 28
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 -1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LEI4 $1102
ADDRLP4 20
ADDRGP4 $1099
ASGNP4
ADDRGP4 $1103
JUMPV
LABELV $1102
ADDRLP4 20
ADDRGP4 $1100
ASGNP4
LABELV $1103
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 2178
;2175:	            other->client->ps.clientNum,other->client->sess.sessionTeam,0,-1,tokens,
;2176:	            other->client->pers.netname,tokens, tokens>1 ? "s" : "", TeamName(other->client->sess.sessionTeam));
;2177:
;2178:	AddTeamScore(self->s.pos.trBase, other->client->sess.sessionTeam, tokens);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 2179
;2179:	Team_ForceGesture(other->client->sess.sessionTeam);
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 2181
;2180:
;2181:	AddScore(other, self->r.currentOrigin, CTF_CAPTURE_BONUS*tokens);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 5
ADDRLP4 4
INDIRI4
MULI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 2184
;2182:
;2183:	// add the sprite over the player's head
;2184:	other->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 2185
;2185:	other->client->ps.eFlags |= EF_AWARD_CAP;
ADDRLP4 40
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 2186
;2186:	other->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 2187
;2187:	other->client->ps.persistant[PERS_CAPTURES] += tokens;
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 304
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 2188
;2188:	for(i = 0; i<tokens; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1108
JUMPV
LABELV $1105
line 2189
;2189:		G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", other->client->ps.clientNum, 4, other->client->pers.netname, "CAPTURE" );
ADDRGP4 $316
ARGP4
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $759
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 2190
;2190:		if(TeamCount(-1,TEAM_RED) && TeamCount(-1,TEAM_BLUE) && !level.hadBots) {
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 52
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $1109
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 56
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $1109
ADDRGP4 level+9436
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $1109
line 2191
;2191:			ChallengeMessage(other,AWARD_CAPTURE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 303
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 2192
;2192:		}
LABELV $1109
line 2193
;2193:	}
LABELV $1106
line 2188
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1108
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $1105
line 2195
;2194:
;2195:	other->client->ps.generic1 = 0;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
CNSTI4 0
ASGNI4
line 2196
;2196:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 2198
;2197:
;2198:	Team_CaptureFlagSound( self, self->spawnflags );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ARGI4
ADDRGP4 Team_CaptureFlagSound
CALLV
pop
line 2199
;2199:}
LABELV $1085
endproc ObeliskTouch 64 40
proc ObeliskPain 16 28
line 2202
;2200:
;2201:static void ObeliskPain( gentity_t *self, gentity_t *attacker, int damage )
;2202:{
line 2203
;2203:	int actualDamage = damage / 10;
ADDRLP4 0
ADDRFP4 8
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 2204
;2204:	if (actualDamage <= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $1113
line 2205
;2205:		actualDamage = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2206
;2206:	}
LABELV $1113
line 2207
;2207:	self->activator->s.modelindex2 = self->health * 0xff / g_obeliskHealth.integer;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 255
ADDRLP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
MULI4
ADDRGP4 g_obeliskHealth+12
INDIRI4
DIVI4
ASGNI4
line 2208
;2208:	if (!self->activator->s.frame) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1116
line 2209
;2209:		G_AddEvent(self, EV_OBELISKPAIN, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 70
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 2210
;2210:	}
LABELV $1116
line 2211
;2211:	self->activator->s.frame = 1;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 1
ASGNI4
line 2212
;2212:	AddScore(attacker, self->r.currentOrigin, actualDamage);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 2213
;2213:	G_LogPrintf("OBELISK: %i %i %i %i: %s dealt %i damage to the enemy obelisk.\n",
ADDRGP4 $1118
ARGP4
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 2216
;2214:	            attacker->client->ps.clientNum,attacker->client->sess.sessionTeam,1,actualDamage,
;2215:	            attacker->client->pers.netname,actualDamage);
;2216:}
LABELV $1112
endproc ObeliskPain 16 28
proc SpawnObelisk 12 8
line 2219
;2217:
;2218:// spawn invisible damagable obelisk entity / harvester base trigger.
;2219:static gentity_t *SpawnObelisk( vec3_t origin, vec3_t mins, vec3_t maxs, int team ) {
line 2222
;2220:	gentity_t	*ent;
;2221:
;2222:	ent = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 2224
;2223:
;2224:	VectorCopy( origin, ent->s.origin );
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 2225
;2225:	VectorCopy( origin, ent->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 2226
;2226:	VectorCopy( origin, ent->r.currentOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 2228
;2227:
;2228:	VectorCopy( mins, ent->r.mins );
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2229
;2229:	VectorCopy( maxs, ent->r.maxs );
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 2231
;2230:
;2231:	ent->s.eType = ET_GENERAL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 2232
;2232:	ent->flags = FL_NO_KNOCKBACK;
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 2048
ASGNI4
line 2234
;2233:
;2234:	if( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $1120
line 2235
;2235:		ent->r.contents = CONTENTS_SOLID;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1
ASGNI4
line 2236
;2236:		ent->takedamage = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 2237
;2237:		ent->health = g_obeliskHealth.integer;
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 g_obeliskHealth+12
INDIRI4
ASGNI4
line 2238
;2238:		ent->die = ObeliskDie;
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 ObeliskDie
ASGNP4
line 2239
;2239:		ent->pain = ObeliskPain;
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRGP4 ObeliskPain
ASGNP4
line 2240
;2240:		ent->think = ObeliskRegen;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ObeliskRegen
ASGNP4
line 2241
;2241:		ent->nextthink = level.time + g_obeliskRegenPeriod.integer * 1000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_obeliskRegenPeriod+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 2242
;2242:	}
LABELV $1120
line 2243
;2243:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $1126
line 2244
;2244:		ent->r.contents = CONTENTS_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 2245
;2245:		ent->touch = ObeliskTouch;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 ObeliskTouch
ASGNP4
line 2246
;2246:	}
LABELV $1126
line 2248
;2247:
;2248:	G_SetOrigin( ent, ent->s.origin );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 2250
;2249:
;2250:	ent->spawnflags = team;
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRFP4 12
INDIRI4
ASGNI4
line 2252
;2251:
;2252:	trap_LinkEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 2254
;2253:
;2254:	return ent;
ADDRLP4 0
INDIRP4
RETP4
LABELV $1119
endproc SpawnObelisk 12 8
export ObeliskInit
proc ObeliskInit 92 28
line 2258
;2255:}
;2256:
;2257:// setup entity for team base model / obelisk model.
;2258:void ObeliskInit( gentity_t *ent ) {
line 2262
;2259:	trace_t tr;
;2260:	vec3_t dest;
;2261:
;2262:	ent->s.eType = ET_TEAM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 12
ASGNI4
line 2264
;2263:
;2264:	VectorSet( ent->r.mins, -15, -15, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 0
ASGNF4
line 2265
;2265:	VectorSet( ent->r.maxs, 15, 15, 87 );
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1118699520
ASGNF4
line 2267
;2266:
;2267:	if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1130
line 2269
;2268:		// suspended
;2269:		G_SetOrigin( ent, ent->s.origin );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 2270
;2270:	}
ADDRGP4 $1131
JUMPV
LABELV $1130
line 2271
;2271:	else {
line 2274
;2272:		// mappers like to put them exactly on the floor, but being coplanar
;2273:		// will sometimes show up as starting in solid, so lif it up one pixel
;2274:		ent->s.origin[2] += 1;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2277
;2275:
;2276:		// drop to floor
;2277:		VectorSet( dest, ent->s.origin[0], ent->s.origin[1], ent->s.origin[2] - 4096 );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 72
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 2278
;2278:		trap_Trace( &tr, ent->s.origin, ent->r.mins, ent->r.maxs, dest, ent->s.number, MASK_SOLID );
ADDRLP4 12
ARGP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 76
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2279
;2279:		if ( tr.startsolid ) {
ADDRLP4 12+4
INDIRI4
CNSTI4 0
EQI4 $1134
line 2280
;2280:			ent->s.origin[2] -= 1;
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 2281
;2281:			G_Printf( "SpawnObelisk: %s startsolid at %s\n", ent->classname, vtos(ent->s.origin) );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 84
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $1137
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 2283
;2282:
;2283:			ent->s.groundEntityNum = ENTITYNUM_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1023
ASGNI4
line 2284
;2284:			G_SetOrigin( ent, ent->s.origin );
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 2285
;2285:		}
ADDRGP4 $1135
JUMPV
LABELV $1134
line 2286
;2286:		else {
line 2288
;2287:			// allow to ride movers
;2288:			ent->s.groundEntityNum = tr.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRLP4 12+52
INDIRI4
ASGNI4
line 2289
;2289:			G_SetOrigin( ent, tr.endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12+12
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 2290
;2290:		}
LABELV $1135
line 2291
;2291:	}
LABELV $1131
line 2292
;2292:}
LABELV $1129
endproc ObeliskInit 92 28
export SP_team_redobelisk
proc SP_team_redobelisk 12 16
line 2297
;2293:
;2294:/*QUAKED team_redobelisk (1 0 0) (-16 -16 0) (16 16 8)
;2295:*/
;2296:void SP_team_redobelisk( gentity_t *ent )
;2297:{
line 2300
;2298:	gentity_t *obelisk;
;2299:
;2300:	if (g_gametype.integer != GT_HARVESTER && g_gametype.integer != GT_OBELISK) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $1141
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
EQI4 $1141
line 2301
;2301:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2302
;2302:		return;
ADDRGP4 $1140
JUMPV
LABELV $1141
line 2304
;2303:	}
;2304:	ObeliskInit( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ObeliskInit
CALLV
pop
line 2305
;2305:	if ( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $1145
line 2306
;2306:		obelisk = SpawnObelisk( ent->s.origin, ent->r.mins, ent->r.maxs, TEAM_RED );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 SpawnObelisk
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 2307
;2307:		obelisk->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 2309
;2308:		// initial obelisk health value
;2309:		ent->s.modelindex2 = 0xff;
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 255
ASGNI4
line 2310
;2310:		ent->s.frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 0
ASGNI4
line 2311
;2311:	}
LABELV $1145
line 2312
;2312:	if ( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $1148
line 2313
;2313:		obelisk = SpawnObelisk( ent->s.origin, ent->r.mins, ent->r.maxs, TEAM_RED );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 SpawnObelisk
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 2314
;2314:		obelisk->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 2315
;2315:	}
LABELV $1148
line 2316
;2316:	ent->s.modelindex = TEAM_RED;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 1
ASGNI4
line 2317
;2317:	trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 2318
;2318:}
LABELV $1140
endproc SP_team_redobelisk 12 16
export SP_team_blueobelisk
proc SP_team_blueobelisk 12 16
line 2323
;2319:
;2320:/*QUAKED team_blueobelisk (0 0 1) (-16 -16 0) (16 16 88)
;2321:*/
;2322:void SP_team_blueobelisk( gentity_t *ent )
;2323:{
line 2326
;2324:	gentity_t *obelisk;
;2325:
;2326:	if (g_gametype.integer != GT_HARVESTER && g_gametype.integer != GT_OBELISK) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $1152
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
EQI4 $1152
line 2327
;2327:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2328
;2328:		return;
ADDRGP4 $1151
JUMPV
LABELV $1152
line 2330
;2329:	}
;2330:	ObeliskInit( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ObeliskInit
CALLV
pop
line 2331
;2331:	if ( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $1156
line 2332
;2332:		obelisk = SpawnObelisk( ent->s.origin, ent->r.mins, ent->r.maxs, TEAM_BLUE );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 8
ADDRGP4 SpawnObelisk
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 2333
;2333:		obelisk->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 2335
;2334:		// initial obelisk health value
;2335:		ent->s.modelindex2 = 0xff;
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 255
ASGNI4
line 2336
;2336:		ent->s.frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 0
ASGNI4
line 2337
;2337:	}
LABELV $1156
line 2338
;2338:	if ( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $1159
line 2339
;2339:		obelisk = SpawnObelisk( ent->s.origin, ent->r.mins, ent->r.maxs, TEAM_BLUE );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 8
ADDRGP4 SpawnObelisk
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 2340
;2340:		obelisk->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 2341
;2341:	}
LABELV $1159
line 2342
;2342:	ent->s.modelindex = TEAM_BLUE;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 2
ASGNI4
line 2343
;2343:	trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 2344
;2344:}
LABELV $1151
endproc SP_team_blueobelisk 12 16
export SP_team_neutralobelisk
proc SP_team_neutralobelisk 8 16
line 2349
;2345:
;2346:/*QUAKED team_neutralobelisk (0 0 1) (-16 -16 0) (16 16 88)
;2347:*/
;2348:void SP_team_neutralobelisk( gentity_t *ent )
;2349:{
line 2350
;2350:	if (g_gametype.integer != GT_HARVESTER) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $1163
line 2351
;2351:		G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2352
;2352:		return;
ADDRGP4 $1162
JUMPV
LABELV $1163
line 2354
;2353:	}
;2354:	ObeliskInit( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ObeliskInit
CALLV
pop
line 2355
;2355:	neutralObelisk = SpawnObelisk( ent->s.origin, ent->r.mins, ent->r.maxs, TEAM_FREE );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 SpawnObelisk
CALLP4
ASGNP4
ADDRGP4 neutralObelisk
ADDRLP4 4
INDIRP4
ASGNP4
line 2356
;2356:	neutralObelisk->activator = ent;
ADDRGP4 neutralObelisk
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 2357
;2357:	ent->s.modelindex = TEAM_FREE;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 2358
;2358:	trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 2359
;2359:}
LABELV $1162
endproc SP_team_neutralobelisk 8 16
export CheckObeliskAttack
proc CheckObeliskAttack 12 8
line 2368
;2360:
;2361:
;2362:/*
;2363:================
;2364:CheckObeliskAttack
;2365:================
;2366:*/
;2367:qboolean CheckObeliskAttack( const gentity_t *obelisk, const gentity_t *attacker )
;2368:{
line 2372
;2369:	gentity_t	*te;
;2370:
;2371:	// if this really is an obelisk
;2372:	if( obelisk->die != ObeliskDie ) {
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 ObeliskDie
CVPU4 4
EQU4 $1167
line 2373
;2373:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1166
JUMPV
LABELV $1167
line 2377
;2374:	}
;2375:
;2376:	// if the attacker is a client
;2377:	if( !attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1169
line 2378
;2378:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1166
JUMPV
LABELV $1169
line 2382
;2379:	}
;2380:
;2381:	// if the obelisk is on the same team as the attacker then don't hurt it
;2382:	if( obelisk->spawnflags == attacker->client->sess.sessionTeam ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
NEI4 $1171
line 2383
;2383:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1166
JUMPV
LABELV $1171
line 2389
;2384:	}
;2385:
;2386:	// obelisk may be hurt
;2387:
;2388:	// if not played any sounds recently
;2389:	if ((obelisk->spawnflags == TEAM_RED &&
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1180
ADDRGP4 teamgame+28
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 20000
SUBI4
LTI4 $1179
LABELV $1180
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1173
ADDRGP4 teamgame+32
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 20000
SUBI4
GEI4 $1173
LABELV $1179
line 2392
;2390:	        teamgame.redObeliskAttackedTime < level.time - OVERLOAD_ATTACK_BASE_SOUND_TIME) ||
;2391:	        (obelisk->spawnflags == TEAM_BLUE &&
;2392:	         teamgame.blueObeliskAttackedTime < level.time - OVERLOAD_ATTACK_BASE_SOUND_TIME) ) {
line 2395
;2393:
;2394:		// tell which obelisk is under attack
;2395:		te = G_TempEntity( obelisk->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 2396
;2396:		if( obelisk->spawnflags == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1181
line 2397
;2397:			te->s.eventParm = GTS_REDOBELISK_ATTACKED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 6
ASGNI4
line 2398
;2398:			teamgame.redObeliskAttackedTime = level.time;
ADDRGP4 teamgame+28
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2399
;2399:		}
ADDRGP4 $1182
JUMPV
LABELV $1181
line 2400
;2400:		else {
line 2401
;2401:			te->s.eventParm = GTS_BLUEOBELISK_ATTACKED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 7
ASGNI4
line 2402
;2402:			teamgame.blueObeliskAttackedTime = level.time;
ADDRGP4 teamgame+32
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2403
;2403:		}
LABELV $1182
line 2404
;2404:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 2405
;2405:	}
LABELV $1173
line 2407
;2406:
;2407:	return qfalse;
CNSTI4 0
RETI4
LABELV $1166
endproc CheckObeliskAttack 12 8
bss
export dominationPointsSpawned
align 4
LABELV dominationPointsSpawned
skip 4
export dom_points
align 4
LABELV dom_points
skip 24
export ddB
align 4
LABELV ddB
skip 4
export ddA
align 4
LABELV ddA
skip 4
export neutralObelisk
align 4
LABELV neutralObelisk
skip 4
export teamgame
align 4
LABELV teamgame
skip 36
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
import ClientForString
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
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
LABELV $1137
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1118
byte 1 79
byte 1 66
byte 1 69
byte 1 76
byte 1 73
byte 1 83
byte 1 75
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1100
byte 1 0
align 1
LABELV $1099
byte 1 115
byte 1 0
align 1
LABELV $1098
byte 1 72
byte 1 65
byte 1 82
byte 1 86
byte 1 69
byte 1 83
byte 1 84
byte 1 69
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 114
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1094
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $1093
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1092
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 98
byte 1 114
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1079
byte 1 79
byte 1 66
byte 1 69
byte 1 76
byte 1 73
byte 1 83
byte 1 75
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 121
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1011
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1006
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $949
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $948
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $935
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 100
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $934
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $921
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 100
byte 1 0
align 1
LABELV $910
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $907
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $904
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $901
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $871
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $870
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $831
byte 1 68
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 119
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $821
byte 1 72
byte 1 65
byte 1 82
byte 1 86
byte 1 69
byte 1 83
byte 1 84
byte 1 69
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 121
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 10
byte 1 44
byte 1 0
align 1
LABELV $820
byte 1 72
byte 1 65
byte 1 82
byte 1 86
byte 1 69
byte 1 83
byte 1 84
byte 1 69
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 105
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $806
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $802
byte 1 67
byte 1 84
byte 1 70
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $798
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $795
byte 1 49
byte 1 70
byte 1 67
byte 1 84
byte 1 70
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $794
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $781
byte 1 65
byte 1 83
byte 1 83
byte 1 73
byte 1 83
byte 1 84
byte 1 0
align 1
LABELV $759
byte 1 67
byte 1 65
byte 1 80
byte 1 84
byte 1 85
byte 1 82
byte 1 69
byte 1 0
align 1
LABELV $751
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $747
byte 1 67
byte 1 84
byte 1 70
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $743
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $742
byte 1 49
byte 1 70
byte 1 67
byte 1 84
byte 1 70
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $741
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $733
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $729
byte 1 67
byte 1 84
byte 1 70
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $725
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $707
byte 1 68
byte 1 68
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 66
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $706
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 66
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $696
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $686
byte 1 68
byte 1 68
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $685
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 65
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $635
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $631
byte 1 67
byte 1 84
byte 1 70
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $627
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $626
byte 1 49
byte 1 70
byte 1 67
byte 1 84
byte 1 70
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $622
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $616
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $586
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 84
byte 1 97
byte 1 107
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $572
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 82
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $557
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 66
byte 1 32
byte 1 40
byte 1 87
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 41
byte 1 0
align 1
LABELV $554
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 66
byte 1 32
byte 1 40
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 41
byte 1 0
align 1
LABELV $551
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 66
byte 1 32
byte 1 40
byte 1 82
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $541
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 32
byte 1 40
byte 1 87
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 41
byte 1 0
align 1
LABELV $538
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 32
byte 1 40
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 41
byte 1 0
align 1
LABELV $535
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 32
byte 1 40
byte 1 82
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $521
byte 1 68
byte 1 79
byte 1 77
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 115
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $519
byte 1 78
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $514
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $513
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $509
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $508
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $487
byte 1 68
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 40
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $486
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $483
byte 1 68
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $474
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 95
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $473
byte 1 68
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $472
byte 1 78
byte 1 111
byte 1 32
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $469
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $460
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $387
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $385
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $380
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $376
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $374
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $317
byte 1 68
byte 1 69
byte 1 70
byte 1 69
byte 1 78
byte 1 67
byte 1 69
byte 1 0
align 1
LABELV $316
byte 1 65
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 97
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $305
byte 1 72
byte 1 65
byte 1 82
byte 1 86
byte 1 69
byte 1 83
byte 1 84
byte 1 69
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 119
byte 1 104
byte 1 111
byte 1 32
byte 1 104
byte 1 97
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $304
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $293
byte 1 49
byte 1 102
byte 1 67
byte 1 84
byte 1 70
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $288
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $284
byte 1 67
byte 1 84
byte 1 70
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $280
byte 1 80
byte 1 79
byte 1 83
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $279
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $278
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $115
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $110
byte 1 80
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 77
byte 1 115
byte 1 103
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 114
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $105
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $104
byte 1 94
byte 1 51
byte 1 0
align 1
LABELV $101
byte 1 94
byte 1 52
byte 1 0
align 1
LABELV $98
byte 1 94
byte 1 49
byte 1 0
align 1
LABELV $87
byte 1 70
byte 1 82
byte 1 69
byte 1 69
byte 1 0
align 1
LABELV $86
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $83
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 0
align 1
LABELV $80
byte 1 82
byte 1 69
byte 1 68
byte 1 0
