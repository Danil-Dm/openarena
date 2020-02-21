bss
align 1
LABELV $75
skip 64
export CG_PlaceString
code
proc CG_PlaceString 12 20
file "../../../code/cgame/cg_event.c"
line 40
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
;21: */
;22://
;23:// cg_event.c -- handle entity events at snapshot or playerstate transitions
;24:
;25:#include "cg_local.h"
;26:
;27:// for the voice chats
;28:#ifdef MISSIONPACK // bk001205
;29:#include "../../ui/menudef.h"
;30:#endif
;31://==========================================================================
;32:
;33:/*
;34:===================
;35:CG_PlaceString
;36:
;37:Also called by scoreboard drawing
;38:===================
;39: */
;40:const char *CG_PlaceString(int rank) {
line 44
;41:	static char str[64];
;42:	char *s, *t;
;43:
;44:	if (rank & RANK_TIED_FLAG) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $76
line 45
;45:		rank &= ~RANK_TIED_FLAG;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 46
;46:		t = "Tied for ";
ADDRLP4 4
ADDRGP4 $78
ASGNP4
line 47
;47:	} else {
ADDRGP4 $77
JUMPV
LABELV $76
line 48
;48:		t = "";
ADDRLP4 4
ADDRGP4 $79
ASGNP4
line 49
;49:	}
LABELV $77
line 51
;50:
;51:	if (rank == 1) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $80
line 52
;52:		s = S_COLOR_BLUE "1st" S_COLOR_WHITE; // draw in blue
ADDRLP4 0
ADDRGP4 $82
ASGNP4
line 53
;53:	} else if (rank == 2) {
ADDRGP4 $81
JUMPV
LABELV $80
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $83
line 54
;54:		s = S_COLOR_RED "2nd" S_COLOR_WHITE; // draw in red
ADDRLP4 0
ADDRGP4 $85
ASGNP4
line 55
;55:	} else if (rank == 3) {
ADDRGP4 $84
JUMPV
LABELV $83
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $86
line 56
;56:		s = S_COLOR_YELLOW "3rd" S_COLOR_WHITE; // draw in yellow
ADDRLP4 0
ADDRGP4 $88
ASGNP4
line 57
;57:	} else if (rank == 11) {
ADDRGP4 $87
JUMPV
LABELV $86
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $89
line 58
;58:		s = "11th";
ADDRLP4 0
ADDRGP4 $91
ASGNP4
line 59
;59:	} else if (rank == 12) {
ADDRGP4 $90
JUMPV
LABELV $89
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $92
line 60
;60:		s = "12th";
ADDRLP4 0
ADDRGP4 $94
ASGNP4
line 61
;61:	} else if (rank == 13) {
ADDRGP4 $93
JUMPV
LABELV $92
ADDRFP4 0
INDIRI4
CNSTI4 13
NEI4 $95
line 62
;62:		s = "13th";
ADDRLP4 0
ADDRGP4 $97
ASGNP4
line 63
;63:	} else if (rank % 10 == 1) {
ADDRGP4 $96
JUMPV
LABELV $95
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $98
line 64
;64:		s = va("%ist", rank);
ADDRGP4 $100
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 65
;65:	} else if (rank % 10 == 2) {
ADDRGP4 $99
JUMPV
LABELV $98
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
NEI4 $101
line 66
;66:		s = va("%ind", rank);
ADDRGP4 $103
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 67
;67:	} else if (rank % 10 == 3) {
ADDRGP4 $102
JUMPV
LABELV $101
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 3
NEI4 $104
line 68
;68:		s = va("%ird", rank);
ADDRGP4 $106
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 69
;69:	} else {
ADDRGP4 $105
JUMPV
LABELV $104
line 70
;70:		s = va("%ith", rank);
ADDRGP4 $107
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 71
;71:	}
LABELV $105
LABELV $102
LABELV $99
LABELV $96
LABELV $93
LABELV $90
LABELV $87
LABELV $84
LABELV $81
line 73
;72:
;73:	Com_sprintf(str, sizeof ( str), "%s%s", t, s);
ADDRGP4 $75
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $108
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 74
;74:	return str;
ADDRGP4 $75
RETP4
LABELV $74
endproc CG_PlaceString 12 20
proc CG_Obituary 164 20
line 82
;75:}
;76:
;77:/*
;78:=============
;79:CG_Obituary
;80:=============
;81: */
;82:static void CG_Obituary(entityState_t *ent) {
line 96
;83:	int mod;
;84:	int target, attacker;
;85:	char *message;
;86:	char *message2;
;87:	const char *targetInfo;
;88:	const char *attackerInfo;
;89:	char targetName[32];
;90:	char attackerName[32];
;91:	gender_t gender;
;92:	clientInfo_t *ci;
;93:	int i;
;94:	char *s;
;95:	qhandle_t causeShader;
;96:	fragInfo_t *lastFrag = &cgs.fragMsg[FRAGMSG_MAX - 1];
ADDRLP4 44
ADDRGP4 cgs+178828+1104
ASGNP4
line 98
;97:
;98:	target = ent->otherEntityNum;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 99
;99:	attacker = ent->otherEntityNum2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 100
;100:	mod = ent->eventParm;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 102
;101:
;102:	if (target < 0 || target >= MAX_CLIENTS) {
ADDRLP4 40
INDIRI4
CNSTI4 0
LTI4 $114
ADDRLP4 40
INDIRI4
CNSTI4 64
LTI4 $112
LABELV $114
line 103
;103:		CG_Error("CG_Obituary: target out of range");
ADDRGP4 $115
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 104
;104:	}
LABELV $112
line 105
;105:	ci = &cgs.clientinfo[target];
ADDRLP4 104
CNSTI4 2120
ADDRLP4 40
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 107
;106:
;107:	if (attacker < 0 || attacker >= MAX_CLIENTS) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $119
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $117
LABELV $119
line 108
;108:		attacker = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 109
;109:		attackerInfo = NULL;
ADDRLP4 96
CNSTP4 0
ASGNP4
line 110
;110:	} else {
ADDRGP4 $118
JUMPV
LABELV $117
line 111
;111:		attackerInfo = CG_ConfigString(CS_PLAYERS + attacker);
ADDRLP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 124
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 96
ADDRLP4 124
INDIRP4
ASGNP4
line 112
;112:	}
LABELV $118
line 114
;113:
;114:	targetInfo = CG_ConfigString(CS_PLAYERS + target);
ADDRLP4 40
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 124
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 88
ADDRLP4 124
INDIRP4
ASGNP4
line 115
;115:	if (!targetInfo) {
ADDRLP4 88
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $120
line 116
;116:		return;
ADDRGP4 $109
JUMPV
LABELV $120
line 118
;117:	}
;118:	Q_strncpyz(targetName, Info_ValueForKey(targetInfo, "n"), sizeof (targetName) - 2);
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 $122
ARGP4
ADDRLP4 128
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 119
;119:	strcat(targetName, S_COLOR_WHITE);
ADDRLP4 8
ARGP4
ADDRGP4 $123
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 121
;120:
;121:	message2 = "";
ADDRLP4 100
ADDRGP4 $79
ASGNP4
line 125
;122:
;123:	// check for single client messages
;124:
;125:	if (attacker != ENTITYNUM_WORLD) {
ADDRLP4 4
INDIRI4
CNSTI4 1022
EQI4 $124
line 126
;126:		message = NULL;
ADDRLP4 48
CNSTP4 0
ASGNP4
line 127
;127:		causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 128
;128:	} else {
ADDRGP4 $125
JUMPV
LABELV $124
line 129
;129:		switch (mod) {
ADDRLP4 52
INDIRI4
CNSTI4 14
LTI4 $128
ADDRLP4 52
INDIRI4
CNSTI4 22
GTI4 $128
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $164-56
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $164
address $142
address $146
address $150
address $138
address $128
address $134
address $130
address $154
address $158
code
LABELV $130
line 131
;130:			case MOD_SUICIDE:
;131:				message = "suicides";
ADDRLP4 48
ADDRGP4 $131
ASGNP4
line 132
;132:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 133
;133:				break;
ADDRGP4 $129
JUMPV
LABELV $134
line 135
;134:			case MOD_FALLING:
;135:				message = "cratered";
ADDRLP4 48
ADDRGP4 $135
ASGNP4
line 136
;136:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 137
;137:				break;
ADDRGP4 $129
JUMPV
LABELV $138
line 139
;138:			case MOD_CRUSH:
;139:				message = "was squished";
ADDRLP4 48
ADDRGP4 $139
ASGNP4
line 140
;140:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 141
;141:				break;
ADDRGP4 $129
JUMPV
LABELV $142
line 143
;142:			case MOD_WATER:
;143:				message = "sank like a rock";
ADDRLP4 48
ADDRGP4 $143
ASGNP4
line 144
;144:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 145
;145:				break;
ADDRGP4 $129
JUMPV
LABELV $146
line 147
;146:			case MOD_SLIME:
;147:				message = "melted";
ADDRLP4 48
ADDRGP4 $147
ASGNP4
line 148
;148:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 149
;149:				break;
ADDRGP4 $129
JUMPV
LABELV $150
line 151
;150:			case MOD_LAVA:
;151:				message = "does a back flip into the lava";
ADDRLP4 48
ADDRGP4 $151
ASGNP4
line 152
;152:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 153
;153:				break;
ADDRGP4 $129
JUMPV
LABELV $154
line 155
;154:			case MOD_TARGET_LASER:
;155:				message = "saw the light";
ADDRLP4 48
ADDRGP4 $155
ASGNP4
line 156
;156:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 157
;157:				break;
ADDRGP4 $129
JUMPV
LABELV $158
line 159
;158:			case MOD_TRIGGER_HURT:
;159:				message = "was in the wrong place";
ADDRLP4 48
ADDRGP4 $159
ASGNP4
line 160
;160:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 161
;161:				break;
ADDRGP4 $129
JUMPV
LABELV $128
line 163
;162:			default:
;163:				message = NULL;
ADDRLP4 48
CNSTP4 0
ASGNP4
line 164
;164:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 165
;165:				break;
LABELV $129
line 167
;166:		}
;167:	}
LABELV $125
line 169
;168:
;169:	if (attacker == target) {
ADDRLP4 4
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $166
line 170
;170:		gender = ci->gender;
ADDRLP4 108
ADDRLP4 104
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 171
;171:		switch (mod) {
ADDRLP4 136
CNSTI4 13
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 136
INDIRI4
EQI4 $204
ADDRLP4 52
INDIRI4
ADDRLP4 136
INDIRI4
GTI4 $228
LABELV $227
ADDRLP4 52
INDIRI4
CNSTI4 5
EQI4 $174
ADDRLP4 52
INDIRI4
CNSTI4 7
EQI4 $184
ADDRLP4 52
INDIRI4
CNSTI4 9
EQI4 $194
ADDRGP4 $168
JUMPV
LABELV $228
ADDRLP4 52
INDIRI4
CNSTI4 25
EQI4 $208
ADDRLP4 52
INDIRI4
CNSTI4 26
EQI4 $170
ADDRGP4 $168
JUMPV
LABELV $170
line 173
;172:			case MOD_KAMIKAZE:
;173:				message = "goes out with a bang";
ADDRLP4 48
ADDRGP4 $171
ASGNP4
line 174
;174:				causeShader = cgs.media.kamikazeShader;
ADDRLP4 92
ADDRGP4 cgs+180268+764
INDIRI4
ASGNI4
line 175
;175:				break;
ADDRGP4 $169
JUMPV
LABELV $174
line 177
;176:			case MOD_GRENADE_SPLASH:
;177:				if (gender == GENDER_FEMALE)
ADDRLP4 108
INDIRI4
CNSTI4 1
NEI4 $175
line 178
;178:					message = "tripped on her own grenade";
ADDRLP4 48
ADDRGP4 $177
ASGNP4
ADDRGP4 $176
JUMPV
LABELV $175
line 179
;179:				else if (gender == GENDER_NEUTER)
ADDRLP4 108
INDIRI4
CNSTI4 2
NEI4 $178
line 180
;180:					message = "tripped on their own grenade";
ADDRLP4 48
ADDRGP4 $180
ASGNP4
ADDRGP4 $179
JUMPV
LABELV $178
line 182
;181:				else
;182:					message = "tripped on his own grenade";
ADDRLP4 48
ADDRGP4 $181
ASGNP4
LABELV $179
LABELV $176
line 183
;183:				causeShader = cgs.media.grenadeShader;
ADDRLP4 92
ADDRGP4 cgs+180268+760
INDIRI4
ASGNI4
line 184
;184:				break;
ADDRGP4 $169
JUMPV
LABELV $184
line 186
;185:			case MOD_ROCKET_SPLASH:
;186:				if (gender == GENDER_FEMALE)
ADDRLP4 108
INDIRI4
CNSTI4 1
NEI4 $185
line 187
;187:					message = "blew herself up";
ADDRLP4 48
ADDRGP4 $187
ASGNP4
ADDRGP4 $186
JUMPV
LABELV $185
line 188
;188:				else if (gender == GENDER_NEUTER)
ADDRLP4 108
INDIRI4
CNSTI4 2
NEI4 $188
line 189
;189:					message = "blew themself up";
ADDRLP4 48
ADDRGP4 $190
ASGNP4
ADDRGP4 $189
JUMPV
LABELV $188
line 191
;190:				else
;191:					message = "blew himself up";
ADDRLP4 48
ADDRGP4 $191
ASGNP4
LABELV $189
LABELV $186
line 192
;192:				causeShader = cgs.media.rocketShader;
ADDRLP4 92
ADDRGP4 cgs+180268+792
INDIRI4
ASGNI4
line 193
;193:				break;
ADDRGP4 $169
JUMPV
LABELV $194
line 195
;194:			case MOD_PLASMA_SPLASH:
;195:				if (gender == GENDER_FEMALE)
ADDRLP4 108
INDIRI4
CNSTI4 1
NEI4 $195
line 196
;196:					message = "melted herself";
ADDRLP4 48
ADDRGP4 $197
ASGNP4
ADDRGP4 $196
JUMPV
LABELV $195
line 197
;197:				else if (gender == GENDER_NEUTER)
ADDRLP4 108
INDIRI4
CNSTI4 2
NEI4 $198
line 198
;198:					message = "melted themself";
ADDRLP4 48
ADDRGP4 $200
ASGNP4
ADDRGP4 $199
JUMPV
LABELV $198
line 200
;199:				else
;200:					message = "melted himself";
ADDRLP4 48
ADDRGP4 $201
ASGNP4
LABELV $199
LABELV $196
line 201
;201:				causeShader = cgs.media.plasmaShader;
ADDRLP4 92
ADDRGP4 cgs+180268+780
INDIRI4
ASGNI4
line 202
;202:				break;
ADDRGP4 $169
JUMPV
LABELV $204
line 204
;203:			case MOD_BFG_SPLASH:
;204:				message = "should have used a smaller gun";
ADDRLP4 48
ADDRGP4 $205
ASGNP4
line 205
;205:				causeShader = cgs.media.bfgShader;
ADDRLP4 92
ADDRGP4 cgs+180268+744
INDIRI4
ASGNI4
line 206
;206:				break;
ADDRGP4 $169
JUMPV
LABELV $208
line 208
;207:			case MOD_PROXIMITY_MINE:
;208:				if (gender == GENDER_FEMALE) {
ADDRLP4 108
INDIRI4
CNSTI4 1
NEI4 $209
line 209
;209:					message = "found her prox mine";
ADDRLP4 48
ADDRGP4 $211
ASGNP4
line 210
;210:				} else if (gender == GENDER_NEUTER) {
ADDRGP4 $210
JUMPV
LABELV $209
ADDRLP4 108
INDIRI4
CNSTI4 2
NEI4 $212
line 211
;211:					message = "found their prox mine";
ADDRLP4 48
ADDRGP4 $214
ASGNP4
line 212
;212:				} else {
ADDRGP4 $213
JUMPV
LABELV $212
line 213
;213:					message = "found his prox mine";
ADDRLP4 48
ADDRGP4 $215
ASGNP4
line 214
;214:				}
LABELV $213
LABELV $210
line 215
;215:				causeShader = cgs.media.proxlauncherShader;
ADDRLP4 92
ADDRGP4 cgs+180268+784
INDIRI4
ASGNI4
line 216
;216:				break;
ADDRGP4 $169
JUMPV
LABELV $168
line 218
;217:			default:
;218:				if (gender == GENDER_FEMALE)
ADDRLP4 108
INDIRI4
CNSTI4 1
NEI4 $218
line 219
;219:					message = "killed herself";
ADDRLP4 48
ADDRGP4 $220
ASGNP4
ADDRGP4 $219
JUMPV
LABELV $218
line 220
;220:				else if (gender == GENDER_NEUTER)
ADDRLP4 108
INDIRI4
CNSTI4 2
NEI4 $221
line 221
;221:					message = "killed themself";
ADDRLP4 48
ADDRGP4 $223
ASGNP4
ADDRGP4 $222
JUMPV
LABELV $221
line 223
;222:				else
;223:					message = "killed himself";
ADDRLP4 48
ADDRGP4 $224
ASGNP4
LABELV $222
LABELV $219
line 224
;224:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 225
;225:				break;
LABELV $169
line 227
;226:		}
;227:	}
LABELV $166
line 231
;228:
;229:	// If a suicide happens while disconnecting
;230:	// then we might not have a targetName
;231:	if (message && strlen(targetName)) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $229
ADDRLP4 8
ARGP4
ADDRLP4 132
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $229
line 232
;232:		if (cg_obituaryOutput.integer == 1 || cg_obituaryOutput.integer == 4) {
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 1
EQI4 $235
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 4
NEI4 $231
LABELV $235
line 233
;233:			CG_Printf("%s %s.\n", targetName, message);
ADDRGP4 $236
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 234
;234:		}
LABELV $231
line 235
;235:		if (cg_obituaryOutput.integer >= 2) {
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 2
LTI4 $109
line 236
;236:			for (i = 0; i < FRAGMSG_MAX - 1; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $240
line 237
;237:				cgs.fragMsg[i] = cgs.fragMsg[i + 1];
ADDRLP4 136
CNSTI4 276
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 136
INDIRI4
ADDRGP4 cgs+178828
ADDP4
ADDRLP4 136
INDIRI4
ADDRGP4 cgs+178828+276
ADDP4
INDIRB
ASGNB 276
line 238
;238:			}
LABELV $241
line 236
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $240
line 239
;239:			memset(&cgs.fragMsg[FRAGMSG_MAX - 1], 0, sizeof (fragInfo_t));
ADDRGP4 cgs+178828+1104
ARGP4
CNSTI4 0
ARGI4
CNSTI4 276
ARGI4
ADDRGP4 memset
CALLP4
pop
line 241
;240:
;241:			Q_strncpyz(lastFrag->targetName, targetName,
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 243
;242:					sizeof (lastFrag->targetName));
;243:			lastFrag->causeShader = causeShader;
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 92
INDIRI4
ASGNI4
line 244
;244:			lastFrag->fragTime = cg.time;
ADDRLP4 44
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 245
;245:			lastFrag->teamFrag = qfalse;
ADDRLP4 44
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 246
;246:			s = va("%s %s.", targetName, message);
ADDRGP4 $250
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 112
ADDRLP4 136
INDIRP4
ASGNP4
line 247
;247:			Q_strncpyz(lastFrag->message, s, sizeof (lastFrag->message));
ADDRLP4 44
INDIRP4
CNSTI4 76
ADDP4
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTI4 200
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 248
;248:		}
line 250
;249:
;250:		return;
ADDRGP4 $109
JUMPV
LABELV $229
line 254
;251:	}
;252:
;253:	// check for kill messages from the current clientNum
;254:	if (attacker == cg.snap->ps.clientNum) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $251
line 257
;255:		char *s;
;256:
;257:		if (!CG_IsATeamGametype(cgs.gametype) && !CG_UsesTeamFlags(cgs.gametype) &&
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 140
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $254
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 144
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $254
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $254
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $254
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
EQI4 $254
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 12
EQI4 $254
line 259
;258:				!CG_UsesTheWhiteFlag(cgs.gametype) && !CG_IsARoundBasedGametype(cgs.gametype) &&
;259:				cgs.gametype != GT_DOUBLE_D && cgs.gametype != GT_DOMINATION) {
line 260
;260:			s = va("You fragged %s\n%s place with %i", targetName,
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 156
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $262
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 136
ADDRLP4 160
INDIRP4
ASGNP4
line 263
;261:					CG_PlaceString(cg.snap->ps.persistant[PERS_RANK] + 1),
;262:					cg.snap->ps.persistant[PERS_SCORE]);
;263:		} else {
ADDRGP4 $255
JUMPV
LABELV $254
line 264
;264:			if (ent->generic1)
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
EQI4 $265
line 265
;265:				s = va("You fragged your ^1TEAMMATE^7 %s", targetName);
ADDRGP4 $267
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 156
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 136
ADDRLP4 156
INDIRP4
ASGNP4
ADDRGP4 $266
JUMPV
LABELV $265
line 267
;266:			else
;267:				s = va("You fragged %s", targetName);
ADDRGP4 $268
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 160
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 136
ADDRLP4 160
INDIRP4
ASGNP4
LABELV $266
line 268
;268:		}
LABELV $255
line 274
;269:#ifdef MISSIONPACK
;270:		if (!(cg_singlePlayerActive.integer && cg_cameraOrbit.integer)) {
;271:			CG_CenterPrint(s, SCREEN_HEIGHT * 0.30, (int) (BIGCHAR_WIDTH * cg_fragmsgsize.value));
;272:		}
;273:#else
;274:		CG_CenterPrint(s, SCREEN_HEIGHT * 0.30, (int) (BIGCHAR_WIDTH * cg_fragmsgsize.value));
ADDRLP4 136
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTF4 1098907648
ADDRGP4 cg_fragmsgsize+8
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 278
;275:#endif
;276:
;277:		// print the text message as well
;278:	}
LABELV $251
line 281
;279:
;280:	// check for double client messages
;281:	if (!attackerInfo) {
ADDRLP4 96
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $270
line 282
;282:		attacker = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 283
;283:		strcpy(attackerName, "noname");
ADDRLP4 56
ARGP4
ADDRGP4 $272
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 284
;284:	} else {
ADDRGP4 $271
JUMPV
LABELV $270
line 285
;285:		Q_strncpyz(attackerName, Info_ValueForKey(attackerInfo, "n"), sizeof (attackerName) - 2);
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 $122
ARGP4
ADDRLP4 136
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 286
;286:		strcat(attackerName, S_COLOR_WHITE);
ADDRLP4 56
ARGP4
ADDRGP4 $123
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 288
;287:		// check for kill messages about the current clientNum
;288:		if (target == cg.snap->ps.clientNum) {
ADDRLP4 40
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $273
line 289
;289:			Q_strncpyz(cg.killerName, attackerName, sizeof ( cg.killerName));
ADDRGP4 cg+114924
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 290
;290:		}
LABELV $273
line 291
;291:	}
LABELV $271
line 293
;292:
;293:	if (attacker != ENTITYNUM_WORLD) {
ADDRLP4 4
INDIRI4
CNSTI4 1022
EQI4 $278
line 294
;294:		switch (mod) {
ADDRLP4 52
INDIRI4
CNSTI4 1
LTI4 $280
ADDRLP4 52
INDIRI4
CNSTI4 28
GTI4 $280
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $393-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $393
address $294
address $286
address $290
address $298
address $303
address $308
address $312
address $316
address $321
address $324
address $328
address $332
address $332
address $280
address $369
address $365
address $381
address $360
address $373
address $386
address $280
address $377
address $337
address $341
address $346
address $351
address $356
address $282
code
LABELV $282
line 296
;295:			case MOD_GRAPPLE:
;296:				message = "was caught by";
ADDRLP4 48
ADDRGP4 $283
ASGNP4
line 297
;297:				causeShader = cgs.media.grapplehookShader;
ADDRLP4 92
ADDRGP4 cgs+180268+756
INDIRI4
ASGNI4
line 298
;298:				break;
ADDRGP4 $281
JUMPV
LABELV $286
line 300
;299:			case MOD_GAUNTLET:
;300:				message = "was pummeled by";
ADDRLP4 48
ADDRGP4 $287
ASGNP4
line 301
;301:				causeShader = cgs.media.gauntletShader;
ADDRLP4 92
ADDRGP4 cgs+180268+752
INDIRI4
ASGNI4
line 302
;302:				break;
ADDRGP4 $281
JUMPV
LABELV $290
line 304
;303:			case MOD_MACHINEGUN:
;304:				message = "was machinegunned by";
ADDRLP4 48
ADDRGP4 $291
ASGNP4
line 305
;305:				causeShader = cgs.media.machinegunShader;
ADDRLP4 92
ADDRGP4 cgs+180268+772
INDIRI4
ASGNI4
line 306
;306:				break;
ADDRGP4 $281
JUMPV
LABELV $294
line 308
;307:			case MOD_SHOTGUN:
;308:				message = "was gunned down by";
ADDRLP4 48
ADDRGP4 $295
ASGNP4
line 309
;309:				causeShader = cgs.media.shotgunShader;
ADDRLP4 92
ADDRGP4 cgs+180268+796
INDIRI4
ASGNI4
line 310
;310:				break;
ADDRGP4 $281
JUMPV
LABELV $298
line 312
;311:			case MOD_GRENADE:
;312:				message = "ate";
ADDRLP4 48
ADDRGP4 $299
ASGNP4
line 313
;313:				message2 = "'s grenade";
ADDRLP4 100
ADDRGP4 $300
ASGNP4
line 314
;314:				causeShader = cgs.media.grenadeShader;
ADDRLP4 92
ADDRGP4 cgs+180268+760
INDIRI4
ASGNI4
line 315
;315:				break;
ADDRGP4 $281
JUMPV
LABELV $303
line 317
;316:			case MOD_GRENADE_SPLASH:
;317:				message = "was shredded by";
ADDRLP4 48
ADDRGP4 $304
ASGNP4
line 318
;318:				message2 = "'s shrapnel";
ADDRLP4 100
ADDRGP4 $305
ASGNP4
line 319
;319:				causeShader = cgs.media.grenadeShader;
ADDRLP4 92
ADDRGP4 cgs+180268+760
INDIRI4
ASGNI4
line 320
;320:				break;
ADDRGP4 $281
JUMPV
LABELV $308
line 322
;321:			case MOD_ROCKET:
;322:				message = "ate";
ADDRLP4 48
ADDRGP4 $299
ASGNP4
line 323
;323:				message2 = "'s rocket";
ADDRLP4 100
ADDRGP4 $309
ASGNP4
line 324
;324:				causeShader = cgs.media.rocketShader;
ADDRLP4 92
ADDRGP4 cgs+180268+792
INDIRI4
ASGNI4
line 325
;325:				break;
ADDRGP4 $281
JUMPV
LABELV $312
line 327
;326:			case MOD_ROCKET_SPLASH:
;327:				message = "almost dodged";
ADDRLP4 48
ADDRGP4 $313
ASGNP4
line 328
;328:				message2 = "'s rocket";
ADDRLP4 100
ADDRGP4 $309
ASGNP4
line 329
;329:				causeShader = cgs.media.rocketShader;
ADDRLP4 92
ADDRGP4 cgs+180268+792
INDIRI4
ASGNI4
line 330
;330:				break;
ADDRGP4 $281
JUMPV
LABELV $316
line 332
;331:			case MOD_PLASMA:
;332:				message = "was melted by";
ADDRLP4 48
ADDRGP4 $317
ASGNP4
line 333
;333:				message2 = "'s plasmagun";
ADDRLP4 100
ADDRGP4 $318
ASGNP4
line 334
;334:				causeShader = cgs.media.plasmaShader;
ADDRLP4 92
ADDRGP4 cgs+180268+780
INDIRI4
ASGNI4
line 335
;335:				break;
ADDRGP4 $281
JUMPV
LABELV $321
line 337
;336:			case MOD_PLASMA_SPLASH:
;337:				message = "was melted by";
ADDRLP4 48
ADDRGP4 $317
ASGNP4
line 338
;338:				message2 = "'s plasmagun";
ADDRLP4 100
ADDRGP4 $318
ASGNP4
line 339
;339:				causeShader = cgs.media.plasmaShader;
ADDRLP4 92
ADDRGP4 cgs+180268+780
INDIRI4
ASGNI4
line 340
;340:				break;
ADDRGP4 $281
JUMPV
LABELV $324
line 342
;341:			case MOD_RAILGUN:
;342:				message = "was railed by";
ADDRLP4 48
ADDRGP4 $325
ASGNP4
line 343
;343:				causeShader = cgs.media.railgunShader;
ADDRLP4 92
ADDRGP4 cgs+180268+788
INDIRI4
ASGNI4
line 344
;344:				break;
ADDRGP4 $281
JUMPV
LABELV $328
line 346
;345:			case MOD_LIGHTNING:
;346:				message = "was electrocuted by";
ADDRLP4 48
ADDRGP4 $329
ASGNP4
line 347
;347:				causeShader = cgs.media.lightninggunShader;
ADDRLP4 92
ADDRGP4 cgs+180268+768
INDIRI4
ASGNI4
line 348
;348:				break;
ADDRGP4 $281
JUMPV
LABELV $332
line 351
;349:			case MOD_BFG:
;350:			case MOD_BFG_SPLASH:
;351:				message = "was blasted by";
ADDRLP4 48
ADDRGP4 $333
ASGNP4
line 352
;352:				message2 = "'s BFG";
ADDRLP4 100
ADDRGP4 $334
ASGNP4
line 353
;353:				causeShader = cgs.media.bfgShader;
ADDRLP4 92
ADDRGP4 cgs+180268+744
INDIRI4
ASGNI4
line 354
;354:				break;
ADDRGP4 $281
JUMPV
LABELV $337
line 356
;355:			case MOD_NAIL:
;356:				message = "was nailed by";
ADDRLP4 48
ADDRGP4 $338
ASGNP4
line 357
;357:				causeShader = cgs.media.nailgunShader;
ADDRLP4 92
ADDRGP4 cgs+180268+776
INDIRI4
ASGNI4
line 358
;358:				break;
ADDRGP4 $281
JUMPV
LABELV $341
line 360
;359:			case MOD_CHAINGUN:
;360:				message = "got lead poisoning from";
ADDRLP4 48
ADDRGP4 $342
ASGNP4
line 361
;361:				message2 = "'s Chaingun";
ADDRLP4 100
ADDRGP4 $343
ASGNP4
line 362
;362:				causeShader = cgs.media.chaingunShader;
ADDRLP4 92
ADDRGP4 cgs+180268+748
INDIRI4
ASGNI4
line 363
;363:				break;
ADDRGP4 $281
JUMPV
LABELV $346
line 365
;364:			case MOD_PROXIMITY_MINE:
;365:				message = "was too close to";
ADDRLP4 48
ADDRGP4 $347
ASGNP4
line 366
;366:				message2 = "'s Prox Mine";
ADDRLP4 100
ADDRGP4 $348
ASGNP4
line 367
;367:				causeShader = cgs.media.proxlauncherShader;
ADDRLP4 92
ADDRGP4 cgs+180268+784
INDIRI4
ASGNI4
line 368
;368:				break;
ADDRGP4 $281
JUMPV
LABELV $351
line 370
;369:			case MOD_KAMIKAZE:
;370:				message = "falls to";
ADDRLP4 48
ADDRGP4 $352
ASGNP4
line 371
;371:				message2 = "'s Kamikaze blast";
ADDRLP4 100
ADDRGP4 $353
ASGNP4
line 372
;372:				causeShader = cgs.media.kamikazeShader;
ADDRLP4 92
ADDRGP4 cgs+180268+764
INDIRI4
ASGNI4
line 373
;373:				break;
ADDRGP4 $281
JUMPV
LABELV $356
line 375
;374:			case MOD_JUICED:
;375:				message = "was juiced by";
ADDRLP4 48
ADDRGP4 $357
ASGNP4
line 376
;376:				causeShader = cgs.media.proxlauncherShader;
ADDRLP4 92
ADDRGP4 cgs+180268+784
INDIRI4
ASGNI4
line 377
;377:				break;
ADDRGP4 $281
JUMPV
LABELV $360
line 379
;378:			case MOD_TELEFRAG:
;379:				message = "tried to invade";
ADDRLP4 48
ADDRGP4 $361
ASGNP4
line 380
;380:				message2 = "'s personal space";
ADDRLP4 100
ADDRGP4 $362
ASGNP4
line 381
;381:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 382
;382:				break;
ADDRGP4 $281
JUMPV
LABELV $365
line 384
;383:			case MOD_LAVA:
;384:				message = "was given a hot bath by";
ADDRLP4 48
ADDRGP4 $366
ASGNP4
line 385
;385:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 386
;386:				break;
ADDRGP4 $281
JUMPV
LABELV $369
line 388
;387:			case MOD_SLIME:
;388:				message = "was given a acid bath by";
ADDRLP4 48
ADDRGP4 $370
ASGNP4
line 389
;389:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 390
;390:				break;
ADDRGP4 $281
JUMPV
LABELV $373
line 392
;391:			case MOD_FALLING:
;392:				message = "was given a small push by";
ADDRLP4 48
ADDRGP4 $374
ASGNP4
line 393
;393:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 394
;394:				break;
ADDRGP4 $281
JUMPV
LABELV $377
line 396
;395:			case MOD_TRIGGER_HURT:
;396:				message = "was helped on the way by";
ADDRLP4 48
ADDRGP4 $378
ASGNP4
line 397
;397:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 398
;398:				break;
ADDRGP4 $281
JUMPV
LABELV $381
line 400
;399:			case MOD_CRUSH:
;400:				message = "was crushed in";
ADDRLP4 48
ADDRGP4 $382
ASGNP4
line 401
;401:				message2 = "'s trap";
ADDRLP4 100
ADDRGP4 $383
ASGNP4
line 402
;402:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 403
;403:				break;
ADDRGP4 $281
JUMPV
LABELV $386
line 405
;404:			case MOD_SUICIDE:
;405:				message = "was too eager against";
ADDRLP4 48
ADDRGP4 $387
ASGNP4
line 406
;406:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 407
;407:				break;
ADDRGP4 $281
JUMPV
LABELV $280
line 409
;408:			default:
;409:				message = "was killed by";
ADDRLP4 48
ADDRGP4 $390
ASGNP4
line 410
;410:				causeShader = cgs.media.skullShader;
ADDRLP4 92
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 411
;411:				break;
LABELV $281
line 414
;412:		}
;413:
;414:		if (message) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $395
line 415
;415:			if (ent->generic1) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
EQI4 $397
line 416
;416:				message = "was killed by ^1TEAMMATE^7";
ADDRLP4 48
ADDRGP4 $399
ASGNP4
line 417
;417:				message2 = "";
ADDRLP4 100
ADDRGP4 $79
ASGNP4
line 418
;418:			}
LABELV $397
line 420
;419:
;420:			if (cg_obituaryOutput.integer == 1 || cg_obituaryOutput.integer == 4) {
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 1
EQI4 $404
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 4
NEI4 $400
LABELV $404
line 421
;421:				CG_Printf("%s %s %s%s\n",
ADDRGP4 $405
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 423
;422:						targetName, message, attackerName, message2);
;423:			}
LABELV $400
line 424
;424:			if (cg_obituaryOutput.integer >= 2) {
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 2
LTI4 $109
line 425
;425:				for (i = 0; i < FRAGMSG_MAX - 1; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $409
line 426
;426:					cgs.fragMsg[i] = cgs.fragMsg[i + 1];
ADDRLP4 140
CNSTI4 276
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 140
INDIRI4
ADDRGP4 cgs+178828
ADDP4
ADDRLP4 140
INDIRI4
ADDRGP4 cgs+178828+276
ADDP4
INDIRB
ASGNB 276
line 427
;427:				}
LABELV $410
line 425
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $409
line 428
;428:				memset(&cgs.fragMsg[FRAGMSG_MAX - 1], 0, sizeof (fragInfo_t));
ADDRGP4 cgs+178828+1104
ARGP4
CNSTI4 0
ARGI4
CNSTI4 276
ARGI4
ADDRGP4 memset
CALLP4
pop
line 430
;429:
;430:				lastFrag->teamFrag = ent->generic1;
ADDRLP4 44
INDIRP4
CNSTI4 72
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 432
;431:
;432:				Q_strncpyz(lastFrag->targetName, targetName,
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 434
;433:						sizeof (lastFrag->targetName));
;434:				Q_strncpyz(lastFrag->attackerName, attackerName,
ADDRLP4 140
CNSTI4 32
ASGNI4
ADDRLP4 44
INDIRP4
ADDRLP4 140
INDIRI4
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 436
;435:						sizeof (lastFrag->attackerName));
;436:				lastFrag->causeShader = causeShader;
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 92
INDIRI4
ASGNI4
line 437
;437:				lastFrag->fragTime = cg.time;
ADDRLP4 44
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 438
;438:				s = va("%s %s %s%s.", targetName, message, attackerName,
ADDRGP4 $419
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 112
ADDRLP4 144
INDIRP4
ASGNP4
line 440
;439:						message2);
;440:				Q_strncpyz(lastFrag->message, s, sizeof (lastFrag->message));
ADDRLP4 44
INDIRP4
CNSTI4 76
ADDP4
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTI4 200
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 441
;441:			}
line 443
;442:
;443:			return;
ADDRGP4 $109
JUMPV
LABELV $395
line 445
;444:		}
;445:	}
LABELV $278
line 448
;446:
;447:	// we don't know what it was
;448:	if (cg_obituaryOutput.integer == 1 || cg_obituaryOutput.integer == 4) {
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 1
EQI4 $424
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 4
NEI4 $420
LABELV $424
line 449
;449:		CG_Printf("%s died.\n", targetName);
ADDRGP4 $425
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 450
;450:	}
LABELV $420
line 451
;451:	if (cg_obituaryOutput.integer >= 2) {
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 2
LTI4 $426
line 452
;452:		for (i = 0; i < FRAGMSG_MAX - 1; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $429
line 453
;453:			cgs.fragMsg[i] = cgs.fragMsg[i + 1];
ADDRLP4 136
CNSTI4 276
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 136
INDIRI4
ADDRGP4 cgs+178828
ADDP4
ADDRLP4 136
INDIRI4
ADDRGP4 cgs+178828+276
ADDP4
INDIRB
ASGNB 276
line 454
;454:		}
LABELV $430
line 452
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $429
line 455
;455:		memset(&cgs.fragMsg[FRAGMSG_MAX - 1], 0, sizeof (fragInfo_t));
ADDRGP4 cgs+178828+1104
ARGP4
CNSTI4 0
ARGI4
CNSTI4 276
ARGI4
ADDRGP4 memset
CALLP4
pop
line 457
;456:
;457:		Q_strncpyz(lastFrag->targetName, targetName, 32);
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 458
;458:		Q_strncpyz(lastFrag->attackerName, attackerName, 32);
ADDRLP4 136
CNSTI4 32
ASGNI4
ADDRLP4 44
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 136
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 459
;459:		lastFrag->causeShader = cgs.media.skullShader;
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
ADDRGP4 cgs+180268+800
INDIRI4
ASGNI4
line 460
;460:		lastFrag->fragTime = cg.time;
ADDRLP4 44
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 461
;461:		Q_strncpyz(lastFrag->message, va("%s died.", targetName), 200);
ADDRGP4 $441
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 140
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 76
ADDP4
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 200
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 462
;462:	}
LABELV $426
line 463
;463:}
LABELV $109
endproc CG_Obituary 164 20
proc CG_UseItem 32 16
line 472
;464:
;465://==========================================================================
;466:
;467:/*
;468:===============
;469:CG_UseItem
;470:===============
;471: */
;472:static void CG_UseItem(centity_t *cent) {
line 478
;473:	clientInfo_t *ci;
;474:	int itemNum, clientNum;
;475:	gitem_t *item;
;476:	entityState_t *es;
;477:
;478:	es = &cent->currentState;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 480
;479:
;480:	itemNum = (es->event & ~EV_EVENT_BITS) - EV_USE_ITEM0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 24
SUBI4
ASGNI4
line 481
;481:	if (itemNum < 0 || itemNum > HI_NUM_HOLDABLE) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $445
ADDRLP4 0
INDIRI4
CNSTI4 6
LEI4 $443
LABELV $445
line 482
;482:		itemNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 483
;483:	}
LABELV $443
line 486
;484:
;485:	// print a message if the local player
;486:	if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $446
line 487
;487:		if (!itemNum) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $449
line 488
;488:			CG_CenterPrint("No item to use", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRGP4 $451
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 489
;489:		} else {
ADDRGP4 $450
JUMPV
LABELV $449
line 490
;490:			item = BG_FindItemForHoldable(itemNum);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForHoldable
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 491
;491:			CG_CenterPrint(va("Use %s", item->pickup_name), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRGP4 $452
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 492
;492:		}
LABELV $450
line 493
;493:	}
LABELV $446
line 495
;494:
;495:	switch (itemNum) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $453
ADDRLP4 0
INDIRI4
CNSTI4 5
GTI4 $453
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $471
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $471
address $455
address $454
address $459
address $454
address $454
address $468
code
LABELV $453
LABELV $455
line 498
;496:		default:
;497:		case HI_NONE:
;498:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.useNothingSound);
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+180268+816
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 499
;499:			break;
ADDRGP4 $454
JUMPV
line 502
;500:
;501:		case HI_TELEPORTER:
;502:			break;
LABELV $459
line 505
;503:
;504:		case HI_MEDKIT:
;505:			clientNum = cent->currentState.clientNum;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 506
;506:			if (clientNum >= 0 && clientNum < MAX_CLIENTS) {
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $460
ADDRLP4 28
INDIRI4
CNSTI4 64
GEI4 $460
line 507
;507:				ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 16
CNSTI4 2120
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 508
;508:				ci->medkitUsageTime = cg.time;
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 509
;509:			}
LABELV $460
line 510
;510:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.medkitSound);
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+180268+1260
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 511
;511:			break;
ADDRGP4 $454
JUMPV
line 514
;512:
;513:		case HI_KAMIKAZE:
;514:			break;
line 517
;515:
;516:		case HI_PORTAL:
;517:			break;
LABELV $468
line 519
;518:		case HI_INVULNERABILITY:
;519:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.useInvulnerabilitySound);
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+180268+1012
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 520
;520:			break;
LABELV $454
line 523
;521:	}
;522:
;523:}
LABELV $442
endproc CG_UseItem 32 16
proc CG_WeaponHigher 32 16
line 532
;524:
;525:/**
;526: * Function to check if a new is better according to cg_weaponOrder
;527: * If the order is unspecified (at least one of the weapons are not specified in cg_weaponOrder) the result is false
;528: * @param currentWeapon The weapon currently equipped
;529: * @param newWeapon The new weapon that we might want to change to
;530: * @return true if newWeapon is placed after currentWeapon in cg_weaponOrder. False otherwise
;531: */
;532:static qboolean CG_WeaponHigher(int currentWeapon, int newWeapon) {
line 533
;533:	char *currentScore = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 534
;534:	char *newScore = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 536
;535:	char weapon[5];
;536:	Com_sprintf(weapon, 5, "/%i/", currentWeapon);
ADDRLP4 8
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $473
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 537
;537:	currentScore = strstr(cg_weaponOrder.string, weapon);
ADDRGP4 cg_weaponOrder+16
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 16
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 538
;538:	Com_sprintf(weapon, 5, "/%i/", newWeapon);
ADDRLP4 8
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $473
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 539
;539:	newScore = strstr(cg_weaponOrder.string, weapon);
ADDRGP4 cg_weaponOrder+16
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 540
;540:	if (!newScore || !currentScore) {
ADDRLP4 24
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRU4
EQU4 $478
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRU4
NEU4 $476
LABELV $478
line 541
;541:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $472
JUMPV
LABELV $476
line 543
;542:	}
;543:	return newScore > currentScore;
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
LEU4 $480
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRGP4 $481
JUMPV
LABELV $480
ADDRLP4 28
CNSTI4 0
ASGNI4
LABELV $481
ADDRLP4 28
INDIRI4
RETI4
LABELV $472
endproc CG_WeaponHigher 32 16
proc CG_ItemPickup 12 8
line 553
;544:}
;545:
;546:/*
;547:================
;548:CG_ItemPickup
;549:
;550:A new item was picked up this frame
;551:================
;552: */
;553:static void CG_ItemPickup(int itemNum) {
line 554
;554:	cg.itemPickup = itemNum;
ADDRGP4 cg+125256
ADDRFP4 0
INDIRI4
ASGNI4
line 555
;555:	cg.itemPickupTime = cg.time;
ADDRGP4 cg+125260
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 556
;556:	cg.itemPickupBlendTime = cg.time;
ADDRGP4 cg+125264
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 558
;557:	// see if it should be the grabbed weapon
;558:	if (bg_itemlist[itemNum].giType == IT_WEAPON) {
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $488
line 561
;559:		// select it immediately
;560:		/* always*/
;561:		if (cg_autoswitch.integer == 1 && bg_itemlist[itemNum].giTag != WP_MACHINEGUN) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 1
NEI4 $491
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
EQI4 $491
line 562
;562:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+125268
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 563
;563:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+109152
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 564
;564:		}
LABELV $491
line 566
;565:		/* if new */
;566:		if (cg_autoswitch.integer == 2 && 0 == (cg.snap->ps.stats[ STAT_WEAPONS ] & (1 << bg_itemlist[itemNum].giTag))) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 2
NEI4 $499
ADDRGP4 cg+36
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 1
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $499
line 567
;567:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+125268
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 568
;568:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+109152
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 569
;569:		}
LABELV $499
line 571
;570:		/* if better */
;571:		if (cg_autoswitch.integer == 3 && CG_WeaponHigher(cg.weaponSelect, bg_itemlist[itemNum].giTag)) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 3
NEI4 $508
ADDRGP4 cg+109152
INDIRI4
ARGI4
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 CG_WeaponHigher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $508
line 572
;572:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+125268
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 573
;573:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+109152
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 574
;574:		}
LABELV $508
line 576
;575:		/* if new and better */
;576:		if (cg_autoswitch.integer == 4 && 0 == (cg.snap->ps.stats[ STAT_WEAPONS ] & (1 << bg_itemlist[itemNum].giTag))
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 4
NEI4 $517
ADDRLP4 4
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 4
INDIRI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $517
ADDRGP4 cg+109152
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_WeaponHigher
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $517
line 577
;577:				&& CG_WeaponHigher(cg.weaponSelect, bg_itemlist[itemNum].giTag)) {
line 578
;578:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+125268
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 579
;579:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+109152
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 580
;580:		}
LABELV $517
line 582
;581:		//
;582:	}
LABELV $488
line 584
;583:
;584:}
LABELV $482
endproc CG_ItemPickup 12 8
export CG_WaterLevel
proc CG_WaterLevel 52 8
line 593
;585:
;586:/*
;587:================
;588:CG_WaterLevel
;589:
;590:Returns waterlevel for entity origin
;591:================
;592: */
;593:int CG_WaterLevel(centity_t *cent) {
line 598
;594:	vec3_t point;
;595:	int contents, sample1, sample2, anim, waterlevel;
;596:	int viewheight;
;597:
;598:	anim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 600
;599:
;600:	if (anim == LEGS_WALKCR || anim == LEGS_IDLECR) {
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $531
ADDRLP4 16
INDIRI4
CNSTI4 23
NEI4 $529
LABELV $531
line 601
;601:		viewheight = CROUCH_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 12
ASGNI4
line 602
;602:	} else {
ADDRGP4 $530
JUMPV
LABELV $529
line 603
;603:		if (cg_enableQ.integer)
ADDRGP4 cg_enableQ+12
INDIRI4
CNSTI4 0
EQI4 $532
line 604
;604:			viewheight = QUACK_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 22
ASGNI4
ADDRGP4 $533
JUMPV
LABELV $532
line 606
;605:		else
;606:			viewheight = DEFAULT_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 26
ASGNI4
LABELV $533
line 607
;607:	}
LABELV $530
line 612
;608:
;609:	//
;610:	// get waterlevel, accounting for ducking
;611:	//
;612:	waterlevel = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 614
;613:
;614:	point[0] = cent->lerpOrigin[0];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRF4
ASGNF4
line 615
;615:	point[1] = cent->lerpOrigin[1];
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRF4
ASGNF4
line 616
;616:	point[2] = cent->lerpOrigin[2] + MINS_Z + 1;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 617
;617:	contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 40
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 40
INDIRI4
ASGNI4
line 619
;618:
;619:	if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $537
line 620
;620:		sample2 = viewheight - MINS_Z;
ADDRLP4 28
ADDRLP4 24
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 621
;621:		sample1 = sample2 / 2;
ADDRLP4 32
ADDRLP4 28
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 622
;622:		waterlevel = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 623
;623:		point[2] = cent->lerpOrigin[2] + MINS_Z + sample1;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 32
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 624
;624:		contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 44
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 626
;625:
;626:		if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $540
line 627
;627:			waterlevel = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 628
;628:			point[2] = cent->lerpOrigin[2] + MINS_Z + sample2;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 629
;629:			contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 48
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 631
;630:
;631:			if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $543
line 632
;632:				waterlevel = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 633
;633:			}
LABELV $543
line 634
;634:		}
LABELV $540
line 635
;635:	}
LABELV $537
line 637
;636:
;637:	return waterlevel;
ADDRLP4 20
INDIRI4
RETI4
LABELV $528
endproc CG_WaterLevel 52 8
export CG_PainEvent
proc CG_PainEvent 16 16
line 647
;638:}
;639:
;640:/*
;641:================
;642:CG_PainEvent
;643:
;644:Also called by playerstate transition
;645:================
;646: */
;647:void CG_PainEvent(centity_t *cent, int health) {
line 651
;648:	char *snd;
;649:
;650:	// don't do more than two pain sounds a second
;651:	if (cg.time - cent->pe.painTime < 500) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
SUBI4
CNSTI4 500
GEI4 $546
line 652
;652:		return;
ADDRGP4 $545
JUMPV
LABELV $546
line 655
;653:	}
;654:
;655:	if (health < 25) {
ADDRFP4 4
INDIRI4
CNSTI4 25
GEI4 $549
line 656
;656:		snd = "*pain25_1.wav";
ADDRLP4 0
ADDRGP4 $551
ASGNP4
line 657
;657:	} else if (health < 50) {
ADDRGP4 $550
JUMPV
LABELV $549
ADDRFP4 4
INDIRI4
CNSTI4 50
GEI4 $552
line 658
;658:		snd = "*pain50_1.wav";
ADDRLP4 0
ADDRGP4 $554
ASGNP4
line 659
;659:	} else if (health < 75) {
ADDRGP4 $553
JUMPV
LABELV $552
ADDRFP4 4
INDIRI4
CNSTI4 75
GEI4 $555
line 660
;660:		snd = "*pain75_1.wav";
ADDRLP4 0
ADDRGP4 $557
ASGNP4
line 661
;661:	} else {
ADDRGP4 $556
JUMPV
LABELV $555
line 662
;662:		snd = "*pain100_1.wav";
ADDRLP4 0
ADDRGP4 $558
ASGNP4
line 663
;663:	}
LABELV $556
LABELV $553
LABELV $550
line 665
;664:	// play a gurp sound instead of a normal pain sound
;665:	if (CG_WaterLevel(cent) == 3) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CG_WaterLevel
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $559
line 666
;666:		if (rand()&1) {
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $561
line 667
;667:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, "sound/player/gurp1.wav"));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $563
ARGP4
ADDRLP4 12
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 668
;668:		} else {
ADDRGP4 $560
JUMPV
LABELV $561
line 669
;669:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, "sound/player/gurp2.wav"));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $564
ARGP4
ADDRLP4 12
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 670
;670:		}
line 671
;671:	} else {
ADDRGP4 $560
JUMPV
LABELV $559
line 672
;672:		trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, snd));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 673
;673:	}
LABELV $560
line 675
;674:	// save pain time for programitic twitch animation
;675:	cent->pe.painTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 676
;676:	cent->pe.painDirection ^= 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 677
;677:}
LABELV $545
endproc CG_PainEvent 16 16
lit
align 4
LABELV $712
byte 4 0
byte 4 0
byte 4 1065353216
export CG_EntityEvent
code
proc CG_EntityEvent 140 48
line 691
;678:
;679:
;680:
;681:/*
;682:==============
;683:CG_EntityEvent
;684:
;685:An entity has an event value
;686:also called by CG_CheckPlayerstateEvents
;687:==============
;688: */
;689:#define DEBUGNAME(x) if(cg_debugEvents.integer){CG_Printf(x"\n");}
;690:
;691:void CG_EntityEvent(centity_t *cent, vec3_t position) {
line 699
;692:	entityState_t *es;
;693:	int event;
;694:	vec3_t dir;
;695:	const char *s;
;696:	int clientNum;
;697:	clientInfo_t *ci;
;698:
;699:	es = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 700
;700:	event = es->event & ~EV_EVENT_BITS;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 702
;701:
;702:	if (cg_debugEvents.integer) {
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $567
line 703
;703:		CG_Printf("ent:%3i  event:%3i ", es->number, event);
ADDRGP4 $570
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 704
;704:	}
LABELV $567
line 706
;705:
;706:	if (!event) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $571
line 707
;707:		DEBUGNAME("ZEROEVENT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $566
ADDRGP4 $576
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 708
;708:		return;
ADDRGP4 $566
JUMPV
LABELV $571
line 711
;709:	}
;710:
;711:	clientNum = es->clientNum;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 712
;712:	if (clientNum < 0 || clientNum >= MAX_CLIENTS) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $579
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $577
LABELV $579
line 713
;713:		clientNum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 714
;714:	}
LABELV $577
line 715
;715:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 12
CNSTI4 2120
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 717
;716:
;717:	switch (event) {
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $581
ADDRLP4 8
INDIRI4
CNSTI4 76
GTI4 $581
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1354-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1354
address $583
address $593
address $604
address $615
address $626
address $677
address $677
address $677
address $677
address $637
address $651
address $663
address $707
address $719
address $730
address $737
address $744
address $751
address $757
address $792
address $806
address $814
address $821
address $826
address $831
address $836
address $841
address $846
address $851
address $856
address $861
address $866
address $871
address $876
address $881
address $886
address $891
address $896
address $901
address $933
address $926
address $906
address $916
address $944
address $1119
address $1128
address $1139
address $1093
address $1080
address $1018
address $1023
address $1028
address $1033
address $1106
address $581
address $1266
address $1274
address $1274
address $1274
address $1283
address $1288
address $1301
address $1314
address $1327
address $1013
address $955
address $970
address $977
address $982
address $990
address $995
address $1003
address $1008
address $1344
address $1339
address $724
code
LABELV $583
line 722
;718:			//
;719:			// movement generated events
;720:			//
;721:		case EV_FOOTSTEP:
;722:			DEBUGNAME("EV_FOOTSTEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $584
ADDRGP4 $587
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $584
line 723
;723:			if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $582
line 724
;724:				trap_S_StartSound(NULL, es->number, CHAN_BODY,
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 cgs+180268+824
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 726
;725:						cgs.media.footsteps[ ci->footsteps ][rand()&3]);
;726:			}
line 727
;727:			break;
ADDRGP4 $582
JUMPV
LABELV $593
line 729
;728:		case EV_FOOTSTEP_METAL:
;729:			DEBUGNAME("EV_FOOTSTEP_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $594
ADDRGP4 $597
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $594
line 730
;730:			if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $582
line 731
;731:				trap_S_StartSound(NULL, es->number, CHAN_BODY,
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824+80
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 733
;732:						cgs.media.footsteps[ FOOTSTEP_METAL ][rand()&3]);
;733:			}
line 734
;734:			break;
ADDRGP4 $582
JUMPV
LABELV $604
line 736
;735:		case EV_FOOTSPLASH:
;736:			DEBUGNAME("EV_FOOTSPLASH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $605
ADDRGP4 $608
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $605
line 737
;737:			if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $582
line 738
;738:				trap_S_StartSound(NULL, es->number, CHAN_BODY,
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 740
;739:						cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3]);
;740:			}
line 741
;741:			break;
ADDRGP4 $582
JUMPV
LABELV $615
line 743
;742:		case EV_FOOTWADE:
;743:			DEBUGNAME("EV_FOOTWADE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $616
ADDRGP4 $619
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $616
line 744
;744:			if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $582
line 745
;745:				trap_S_StartSound(NULL, es->number, CHAN_BODY,
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 747
;746:						cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3]);
;747:			}
line 748
;748:			break;
ADDRGP4 $582
JUMPV
LABELV $626
line 750
;749:		case EV_SWIM:
;750:			DEBUGNAME("EV_SWIM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $627
ADDRGP4 $630
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $627
line 751
;751:			if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $582
line 752
;752:				trap_S_StartSound(NULL, es->number, CHAN_BODY,
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 754
;753:						cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3]);
;754:			}
line 755
;755:			break;
ADDRGP4 $582
JUMPV
LABELV $637
line 759
;756:
;757:
;758:		case EV_FALL_SHORT:
;759:			DEBUGNAME("EV_FALL_SHORT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $638
ADDRGP4 $641
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $638
line 760
;760:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.landSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1096
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 761
;761:			if (clientNum == cg.predictedPlayerState.clientNum) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $582
line 763
;762:				// smooth landing z changes
;763:				cg.landChange = -8;
ADDRGP4 cg+109144
CNSTF4 3238002688
ASGNF4
line 764
;764:				cg.landTime = cg.time;
ADDRGP4 cg+109148
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 765
;765:			}
line 766
;766:			break;
ADDRGP4 $582
JUMPV
LABELV $651
line 768
;767:		case EV_FALL_MEDIUM:
;768:			DEBUGNAME("EV_FALL_MEDIUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $652
ADDRGP4 $655
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $652
line 770
;769:			// use normal pain sound
;770:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*pain100_1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $558
ARGP4
ADDRLP4 40
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 771
;771:			if (clientNum == cg.predictedPlayerState.clientNum) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $582
line 773
;772:				// smooth landing z changes
;773:				cg.landChange = -16;
ADDRGP4 cg+109144
CNSTF4 3246391296
ASGNF4
line 774
;774:				cg.landTime = cg.time;
ADDRGP4 cg+109148
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 775
;775:			}
line 776
;776:			break;
ADDRGP4 $582
JUMPV
LABELV $663
line 778
;777:		case EV_FALL_FAR:
;778:			DEBUGNAME("EV_FALL_FAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $664
ADDRGP4 $667
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $664
line 779
;779:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, CG_CustomSound(es->number, "*fall1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $668
ARGP4
ADDRLP4 44
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 780
;780:			cent->pe.painTime = cg.time; // don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 781
;781:			if (clientNum == cg.predictedPlayerState.clientNum) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $582
line 783
;782:				// smooth landing z changes
;783:				cg.landChange = -24;
ADDRGP4 cg+109144
CNSTF4 3250585600
ASGNF4
line 784
;784:				cg.landTime = cg.time;
ADDRGP4 cg+109148
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 785
;785:			}
line 786
;786:			break;
ADDRGP4 $582
JUMPV
LABELV $677
line 792
;787:
;788:		case EV_STEP_4:
;789:		case EV_STEP_8:
;790:		case EV_STEP_12:
;791:		case EV_STEP_16: // smooth out step up transitions
;792:			DEBUGNAME("EV_STEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $678
ADDRGP4 $681
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $678
line 793
;793:		{
line 798
;794:			float oldStep;
;795:			int delta;
;796:			int step;
;797:
;798:			if (clientNum != cg.predictedPlayerState.clientNum) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $682
line 799
;799:				break;
ADDRGP4 $582
JUMPV
LABELV $682
line 802
;800:			}
;801:			// if we are interpolating, we don't need to smooth steps
;802:			if (cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ||
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRGP4 cg+8
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $694
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 60
INDIRI4
NEI4 $694
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $694
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $686
LABELV $694
line 803
;803:					cg_nopredict.integer || cg_synchronousClients.integer) {
line 804
;804:				break;
ADDRGP4 $582
JUMPV
LABELV $686
line 807
;805:			}
;806:			// check for stepping up before a previous step is completed
;807:			delta = cg.time - cg.stepTime;
ADDRLP4 48
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109132
INDIRI4
SUBI4
ASGNI4
line 808
;808:			if (delta < STEP_TIME) {
ADDRLP4 48
INDIRI4
CNSTI4 200
GEI4 $697
line 809
;809:				oldStep = cg.stepChange * (STEP_TIME - delta) / STEP_TIME;
ADDRLP4 52
ADDRGP4 cg+109128
INDIRF4
CNSTI4 200
ADDRLP4 48
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 810
;810:			} else {
ADDRGP4 $698
JUMPV
LABELV $697
line 811
;811:				oldStep = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 812
;812:			}
LABELV $698
line 815
;813:
;814:			// add this amount
;815:			step = 4 * (event - EV_STEP_4 + 1);
ADDRLP4 56
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 24
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 816
;816:			cg.stepChange = oldStep + step;
ADDRGP4 cg+109128
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 817
;817:			if (cg.stepChange > MAX_STEP_CHANGE) {
ADDRGP4 cg+109128
INDIRF4
CNSTF4 1107296256
LEF4 $701
line 818
;818:				cg.stepChange = MAX_STEP_CHANGE;
ADDRGP4 cg+109128
CNSTF4 1107296256
ASGNF4
line 819
;819:			}
LABELV $701
line 820
;820:			cg.stepTime = cg.time;
ADDRGP4 cg+109132
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 821
;821:			break;
ADDRGP4 $582
JUMPV
LABELV $707
line 825
;822:		}
;823:
;824:		case EV_JUMP_PAD:
;825:			DEBUGNAME("EV_JUMP_PAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $708
ADDRGP4 $711
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $708
line 827
;826:			//		CG_Printf( "EV_JUMP_PAD w/effect #%i\n", es->eventParm );
;827:		{
line 828
;828:			vec3_t up = {0, 0, 1};
ADDRLP4 48
ADDRGP4 $712
INDIRB
ASGNB 12
line 829
;829:			CG_SmokePuff(cent->lerpOrigin, up,
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 48
ARGP4
CNSTF4 1107296256
ARGF4
ADDRLP4 60
CNSTF4 1065353216
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+180268+340
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 836
;830:					32,
;831:					1, 1, 1, 0.33f,
;832:					1000,
;833:					cg.time, 0,
;834:					LEF_PUFF_DONT_SCALE,
;835:					cgs.media.smokePuffShader);
;836:		}
line 839
;837:
;838:			// boing sound at origin, jump sound on player
;839:			trap_S_StartSound(cent->lerpOrigin, -1, CHAN_VOICE, cgs.media.jumpPadSound);
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+180268+1104
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 840
;840:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*jump1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $718
ARGP4
ADDRLP4 48
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 841
;841:			break;
ADDRGP4 $582
JUMPV
LABELV $719
line 844
;842:
;843:		case EV_JUMP:
;844:			DEBUGNAME("EV_JUMP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $720
ADDRGP4 $723
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $720
line 845
;845:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*jump1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $718
ARGP4
ADDRLP4 52
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 846
;846:			break;
ADDRGP4 $582
JUMPV
LABELV $724
line 848
;847:		case EV_TAUNT:
;848:			DEBUGNAME("EV_TAUNT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $725
ADDRGP4 $728
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $725
line 849
;849:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*taunt.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $729
ARGP4
ADDRLP4 56
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 850
;850:			break;
ADDRGP4 $582
JUMPV
LABELV $730
line 878
;851:#ifdef MISSIONPACK
;852:		case EV_TAUNT_YES:
;853:			DEBUGNAME("EV_TAUNT_YES");
;854:			CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_YES);
;855:			break;
;856:		case EV_TAUNT_NO:
;857:			DEBUGNAME("EV_TAUNT_NO");
;858:			CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_NO);
;859:			break;
;860:		case EV_TAUNT_FOLLOWME:
;861:			DEBUGNAME("EV_TAUNT_FOLLOWME");
;862:			CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_FOLLOWME);
;863:			break;
;864:		case EV_TAUNT_GETFLAG:
;865:			DEBUGNAME("EV_TAUNT_GETFLAG");
;866:			CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONGETFLAG);
;867:			break;
;868:		case EV_TAUNT_GUARDBASE:
;869:			DEBUGNAME("EV_TAUNT_GUARDBASE");
;870:			CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONDEFENSE);
;871:			break;
;872:		case EV_TAUNT_PATROL:
;873:			DEBUGNAME("EV_TAUNT_PATROL");
;874:			CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONPATROL);
;875:			break;
;876:#endif
;877:		case EV_WATER_TOUCH:
;878:			DEBUGNAME("EV_WATER_TOUCH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $731
ADDRGP4 $734
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $731
line 879
;879:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.watrInSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 880
;880:			break;
ADDRGP4 $582
JUMPV
LABELV $737
line 882
;881:		case EV_WATER_LEAVE:
;882:			DEBUGNAME("EV_WATER_LEAVE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $738
ADDRGP4 $741
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $738
line 883
;883:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.watrOutSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1248
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 884
;884:			break;
ADDRGP4 $582
JUMPV
LABELV $744
line 886
;885:		case EV_WATER_UNDER:
;886:			DEBUGNAME("EV_WATER_UNDER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $745
ADDRGP4 $748
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $745
line 887
;887:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.watrUnSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1252
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 888
;888:			break;
ADDRGP4 $582
JUMPV
LABELV $751
line 890
;889:		case EV_WATER_CLEAR:
;890:			DEBUGNAME("EV_WATER_CLEAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $752
ADDRGP4 $755
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $752
line 891
;891:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, CG_CustomSound(es->number, "*gasp.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $756
ARGP4
ADDRLP4 60
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 892
;892:			break;
ADDRGP4 $582
JUMPV
LABELV $757
line 895
;893:
;894:		case EV_ITEM_PICKUP:
;895:			DEBUGNAME("EV_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $758
ADDRGP4 $761
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $758
line 896
;896:		{
line 900
;897:			gitem_t *item;
;898:			int index;
;899:
;900:			index = es->eventParm; // player predicted
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 902
;901:
;902:			if (index < 1 || index >= bg_numItems) {
ADDRLP4 72
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 1
LTI4 $764
ADDRLP4 72
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $762
LABELV $764
line 903
;903:				break;
ADDRGP4 $582
JUMPV
LABELV $762
line 905
;904:			}
;905:			item = &bg_itemlist[ index ];
ADDRLP4 68
CNSTI4 52
ADDRLP4 64
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 909
;906:
;907:			// powerups and team items will have a separate global sound, this one
;908:			// will be played at prediction time
;909:			if (item->giType == IT_POWERUP || item->giType == IT_TEAM) {
ADDRLP4 76
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 5
EQI4 $767
ADDRLP4 76
INDIRI4
CNSTI4 8
NEI4 $765
LABELV $767
line 910
;910:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.n_healthSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1412
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 911
;911:			} else if (item->giType == IT_PERSISTANT_POWERUP) {
ADDRGP4 $766
JUMPV
LABELV $765
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $770
line 912
;912:				switch (item->giTag) {
ADDRLP4 80
ADDRLP4 68
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 10
LTI4 $771
ADDRLP4 80
INDIRI4
CNSTI4 13
GTI4 $771
ADDRLP4 80
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $787-40
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $787
address $775
address $778
address $781
address $784
code
LABELV $775
line 914
;913:					case PW_SCOUT:
;914:						trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.scoutSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1388
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 915
;915:						break;
ADDRGP4 $771
JUMPV
LABELV $778
line 917
;916:					case PW_GUARD:
;917:						trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.guardSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1384
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 918
;918:						break;
ADDRGP4 $771
JUMPV
LABELV $781
line 920
;919:					case PW_DOUBLER:
;920:						trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.doublerSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1380
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 921
;921:						break;
ADDRGP4 $771
JUMPV
LABELV $784
line 923
;922:					case PW_AMMOREGEN:
;923:						trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.ammoregenSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1376
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 924
;924:						break;
line 926
;925:				}
;926:			} else {
ADDRGP4 $771
JUMPV
LABELV $770
line 927
;927:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, trap_S_RegisterSound(item->pickup_sound, qfalse));
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 80
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 928
;928:			}
LABELV $771
LABELV $766
line 931
;929:
;930:			// show icon and name on status bar
;931:			if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $582
line 932
;932:				CG_ItemPickup(index);
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 933
;933:			}
line 934
;934:		}
line 935
;935:			break;
ADDRGP4 $582
JUMPV
LABELV $792
line 938
;936:
;937:		case EV_GLOBAL_ITEM_PICKUP:
;938:			DEBUGNAME("EV_GLOBAL_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $793
ADDRGP4 $796
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $793
line 939
;939:		{
line 943
;940:			gitem_t *item;
;941:			int index;
;942:
;943:			index = es->eventParm; // player predicted
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 945
;944:
;945:			if (index < 1 || index >= bg_numItems) {
ADDRLP4 72
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 1
LTI4 $799
ADDRLP4 72
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $797
LABELV $799
line 946
;946:				break;
ADDRGP4 $582
JUMPV
LABELV $797
line 948
;947:			}
;948:			item = &bg_itemlist[ index ];
ADDRLP4 68
CNSTI4 52
ADDRLP4 64
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 950
;949:			// powerup pickups are global
;950:			if (item->pickup_sound) {
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $800
line 951
;951:				trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_AUTO, trap_S_RegisterSound(item->pickup_sound, qfalse));
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 952
;952:			}
LABELV $800
line 955
;953:
;954:			// show icon and name on status bar
;955:			if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $582
line 956
;956:				CG_ItemPickup(index);
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 957
;957:			}
line 958
;958:		}
line 959
;959:			break;
ADDRGP4 $582
JUMPV
LABELV $806
line 965
;960:
;961:			//
;962:			// weapon events
;963:			//
;964:		case EV_NOAMMO:
;965:			DEBUGNAME("EV_NOAMMO");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $807
ADDRGP4 $810
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $807
line 967
;966:			//		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound );
;967:			if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $582
line 968
;968:				CG_OutOfAmmoChange();
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 969
;969:			}
line 970
;970:			break;
ADDRGP4 $582
JUMPV
LABELV $814
line 972
;971:		case EV_CHANGE_WEAPON:
;972:			DEBUGNAME("EV_CHANGE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $815
ADDRGP4 $818
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $815
line 973
;973:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.selectSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+812
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 974
;974:			break;
ADDRGP4 $582
JUMPV
LABELV $821
line 976
;975:		case EV_FIRE_WEAPON:
;976:			DEBUGNAME("EV_FIRE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $822
ADDRGP4 $825
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $822
line 977
;977:			CG_FireWeapon(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 978
;978:			break;
ADDRGP4 $582
JUMPV
LABELV $826
line 981
;979:
;980:		case EV_USE_ITEM0:
;981:			DEBUGNAME("EV_USE_ITEM0");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $827
ADDRGP4 $830
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $827
line 982
;982:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 983
;983:			break;
ADDRGP4 $582
JUMPV
LABELV $831
line 985
;984:		case EV_USE_ITEM1:
;985:			DEBUGNAME("EV_USE_ITEM1");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $832
ADDRGP4 $835
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $832
line 986
;986:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 987
;987:			break;
ADDRGP4 $582
JUMPV
LABELV $836
line 989
;988:		case EV_USE_ITEM2:
;989:			DEBUGNAME("EV_USE_ITEM2");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $837
ADDRGP4 $840
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $837
line 990
;990:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 991
;991:			break;
ADDRGP4 $582
JUMPV
LABELV $841
line 993
;992:		case EV_USE_ITEM3:
;993:			DEBUGNAME("EV_USE_ITEM3");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $842
ADDRGP4 $845
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $842
line 994
;994:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 995
;995:			break;
ADDRGP4 $582
JUMPV
LABELV $846
line 997
;996:		case EV_USE_ITEM4:
;997:			DEBUGNAME("EV_USE_ITEM4");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $847
ADDRGP4 $850
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $847
line 998
;998:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 999
;999:			break;
ADDRGP4 $582
JUMPV
LABELV $851
line 1001
;1000:		case EV_USE_ITEM5:
;1001:			DEBUGNAME("EV_USE_ITEM5");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $852
ADDRGP4 $855
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $852
line 1002
;1002:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1003
;1003:			break;
ADDRGP4 $582
JUMPV
LABELV $856
line 1005
;1004:		case EV_USE_ITEM6:
;1005:			DEBUGNAME("EV_USE_ITEM6");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $857
ADDRGP4 $860
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $857
line 1006
;1006:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1007
;1007:			break;
ADDRGP4 $582
JUMPV
LABELV $861
line 1009
;1008:		case EV_USE_ITEM7:
;1009:			DEBUGNAME("EV_USE_ITEM7");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $862
ADDRGP4 $865
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $862
line 1010
;1010:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1011
;1011:			break;
ADDRGP4 $582
JUMPV
LABELV $866
line 1013
;1012:		case EV_USE_ITEM8:
;1013:			DEBUGNAME("EV_USE_ITEM8");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $867
ADDRGP4 $870
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $867
line 1014
;1014:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1015
;1015:			break;
ADDRGP4 $582
JUMPV
LABELV $871
line 1017
;1016:		case EV_USE_ITEM9:
;1017:			DEBUGNAME("EV_USE_ITEM9");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $872
ADDRGP4 $875
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $872
line 1018
;1018:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1019
;1019:			break;
ADDRGP4 $582
JUMPV
LABELV $876
line 1021
;1020:		case EV_USE_ITEM10:
;1021:			DEBUGNAME("EV_USE_ITEM10");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $877
ADDRGP4 $880
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $877
line 1022
;1022:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1023
;1023:			break;
ADDRGP4 $582
JUMPV
LABELV $881
line 1025
;1024:		case EV_USE_ITEM11:
;1025:			DEBUGNAME("EV_USE_ITEM11");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $882
ADDRGP4 $885
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $882
line 1026
;1026:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1027
;1027:			break;
ADDRGP4 $582
JUMPV
LABELV $886
line 1029
;1028:		case EV_USE_ITEM12:
;1029:			DEBUGNAME("EV_USE_ITEM12");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $887
ADDRGP4 $890
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $887
line 1030
;1030:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1031
;1031:			break;
ADDRGP4 $582
JUMPV
LABELV $891
line 1033
;1032:		case EV_USE_ITEM13:
;1033:			DEBUGNAME("EV_USE_ITEM13");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $892
ADDRGP4 $895
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $892
line 1034
;1034:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1035
;1035:			break;
ADDRGP4 $582
JUMPV
LABELV $896
line 1037
;1036:		case EV_USE_ITEM14:
;1037:			DEBUGNAME("EV_USE_ITEM14");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $897
ADDRGP4 $900
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $897
line 1038
;1038:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1039
;1039:			break;
ADDRGP4 $582
JUMPV
LABELV $901
line 1041
;1040:		case EV_USE_ITEM15:
;1041:			DEBUGNAME("EV_USE_ITEM15");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $902
ADDRGP4 $905
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $902
line 1042
;1042:			CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 1043
;1043:			break;
ADDRGP4 $582
JUMPV
LABELV $906
line 1051
;1044:
;1045:			//=================================================================
;1046:
;1047:			//
;1048:			// other events
;1049:			//
;1050:		case EV_PLAYER_TELEPORT_IN:
;1051:			DEBUGNAME("EV_PLAYER_TELEPORT_IN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $907
ADDRGP4 $910
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $907
line 1052
;1052:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.teleInSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1076
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1053
;1053:			if (cg_leiEnhancement.integer)
ADDRGP4 cg_leiEnhancement+12
INDIRI4
CNSTI4 0
EQI4 $913
line 1054
;1054:				trap_R_LFX_ParticleEffect(18, cent->lerpOrigin, cent->currentState.angles);
CNSTI4 18
ARGI4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 trap_R_LFX_ParticleEffect
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $913
line 1056
;1055:			else
;1056:				CG_SpawnEffect(position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 1057
;1057:			break;
ADDRGP4 $582
JUMPV
LABELV $916
line 1060
;1058:
;1059:		case EV_PLAYER_TELEPORT_OUT:
;1060:			DEBUGNAME("EV_PLAYER_TELEPORT_OUT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $917
ADDRGP4 $920
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $917
line 1061
;1061:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.teleOutSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1080
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1062
;1062:			if (cg_leiEnhancement.integer)
ADDRGP4 cg_leiEnhancement+12
INDIRI4
CNSTI4 0
EQI4 $923
line 1063
;1063:				trap_R_LFX_ParticleEffect(18, cent->lerpOrigin, cent->currentState.angles);
CNSTI4 18
ARGI4
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 trap_R_LFX_ParticleEffect
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $923
line 1065
;1064:			else
;1065:				CG_SpawnEffect(position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 1066
;1066:			break;
ADDRGP4 $582
JUMPV
LABELV $926
line 1069
;1067:
;1068:		case EV_ITEM_POP:
;1069:			DEBUGNAME("EV_ITEM_POP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $927
ADDRGP4 $930
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $927
line 1070
;1070:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.respawnSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1088
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1071
;1071:			break;
ADDRGP4 $582
JUMPV
LABELV $933
line 1073
;1072:		case EV_ITEM_RESPAWN:
;1073:			DEBUGNAME("EV_ITEM_RESPAWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $934
ADDRGP4 $937
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $934
line 1074
;1074:			cent->miscTime = cg.time; // scale up from this
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1075
;1075:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.respawnSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1088
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1077
;1076:
;1077:			if (cg_leiEnhancement.integer)
ADDRGP4 cg_leiEnhancement+12
INDIRI4
CNSTI4 0
EQI4 $582
line 1078
;1078:				trap_R_LFX_ParticleEffect(41, cent->lerpOrigin, cent->currentState.angles);
CNSTI4 41
ARGI4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 trap_R_LFX_ParticleEffect
CALLV
pop
line 1079
;1079:			break;
ADDRGP4 $582
JUMPV
LABELV $944
line 1082
;1080:
;1081:		case EV_GRENADE_BOUNCE:
;1082:			DEBUGNAME("EV_GRENADE_BOUNCE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $945
ADDRGP4 $948
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $945
line 1083
;1083:			if (rand() & 1) {
ADDRLP4 76
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $949
line 1084
;1084:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.hgrenb1aSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1416
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1085
;1085:			} else {
ADDRGP4 $582
JUMPV
LABELV $949
line 1086
;1086:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.hgrenb2aSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1420
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1087
;1087:			}
line 1088
;1088:			break;
ADDRGP4 $582
JUMPV
LABELV $955
line 1092
;1089:
;1090:
;1091:		case EV_PROXIMITY_MINE_STICK:
;1092:			DEBUGNAME("EV_PROXIMITY_MINE_STICK");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $956
ADDRGP4 $959
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $956
line 1093
;1093:			if (es->eventParm & SURF_FLESH) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $960
line 1094
;1094:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbimplSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1424
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1095
;1095:			} else if (es->eventParm & SURF_METALSTEPS) {
ADDRGP4 $582
JUMPV
LABELV $960
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $964
line 1096
;1096:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbimpmSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1428
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1097
;1097:			} else {
ADDRGP4 $582
JUMPV
LABELV $964
line 1098
;1098:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbimpdSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1432
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1099
;1099:			}
line 1100
;1100:			break;
ADDRGP4 $582
JUMPV
LABELV $970
line 1103
;1101:
;1102:		case EV_PROXIMITY_MINE_TRIGGER:
;1103:			DEBUGNAME("EV_PROXIMITY_MINE_TRIGGER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $971
ADDRGP4 $974
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $971
line 1104
;1104:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbactvSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+180268+1436
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1105
;1105:			break;
ADDRGP4 $582
JUMPV
LABELV $977
line 1107
;1106:		case EV_KAMIKAZE:
;1107:			DEBUGNAME("EV_KAMIKAZE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $978
ADDRGP4 $981
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $978
line 1108
;1108:			CG_KamikazeEffect(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 CG_KamikazeEffect
CALLV
pop
line 1109
;1109:			break;
ADDRGP4 $582
JUMPV
LABELV $982
line 1111
;1110:		case EV_OBELISKEXPLODE:
;1111:			DEBUGNAME("EV_OBELISKEXPLODE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $983
ADDRGP4 $986
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $983
line 1112
;1112:			if (cg_leiEnhancement.integer)
ADDRGP4 cg_leiEnhancement+12
INDIRI4
CNSTI4 0
EQI4 $987
line 1113
;1113:				trap_R_LFX_ParticleEffect(17, cent->lerpOrigin, cent->currentState.angles);
CNSTI4 17
ARGI4
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 trap_R_LFX_ParticleEffect
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $987
line 1115
;1114:			else
;1115:				CG_ObeliskExplode(cent->lerpOrigin, es->eventParm);
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ObeliskExplode
CALLV
pop
line 1116
;1116:			break;
ADDRGP4 $582
JUMPV
LABELV $990
line 1118
;1117:		case EV_OBELISKPAIN:
;1118:			DEBUGNAME("EV_OBELISKPAIN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $991
ADDRGP4 $994
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $991
line 1119
;1119:			CG_ObeliskPain(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 CG_ObeliskPain
CALLV
pop
line 1120
;1120:			break;
ADDRGP4 $582
JUMPV
LABELV $995
line 1122
;1121:		case EV_INVUL_IMPACT:
;1122:			DEBUGNAME("EV_INVUL_IMPACT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $996
ADDRGP4 $999
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $996
line 1123
;1123:			if (cg_leiEnhancement.integer)
ADDRGP4 cg_leiEnhancement+12
INDIRI4
CNSTI4 0
EQI4 $1000
line 1124
;1124:				trap_R_LFX_ParticleEffect(42, cent->lerpOrigin, cent->currentState.angles);
CNSTI4 42
ARGI4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 trap_R_LFX_ParticleEffect
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $1000
line 1126
;1125:			else
;1126:				CG_InvulnerabilityImpact(cent->lerpOrigin, cent->currentState.angles);
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 CG_InvulnerabilityImpact
CALLV
pop
line 1127
;1127:			break;
ADDRGP4 $582
JUMPV
LABELV $1003
line 1129
;1128:		case EV_JUICED:
;1129:			DEBUGNAME("EV_JUICED");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1004
ADDRGP4 $1007
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1004
line 1130
;1130:			CG_InvulnerabilityJuiced(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 CG_InvulnerabilityJuiced
CALLV
pop
line 1131
;1131:			break;
ADDRGP4 $582
JUMPV
LABELV $1008
line 1133
;1132:		case EV_LIGHTNINGBOLT:
;1133:			DEBUGNAME("EV_LIGHTNINGBOLT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1009
ADDRGP4 $1012
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1009
line 1134
;1134:			CG_LightningBoltBeam(es->origin2, es->pos.trBase);
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_LightningBoltBeam
CALLV
pop
line 1135
;1135:			break;
ADDRGP4 $582
JUMPV
LABELV $1013
line 1137
;1136:		case EV_SCOREPLUM:
;1137:			DEBUGNAME("EV_SCOREPLUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1014
ADDRGP4 $1017
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1014
line 1138
;1138:			CG_ScorePlum(cent->currentState.otherEntityNum, cent->lerpOrigin, cent->currentState.time);
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ScorePlum
CALLV
pop
line 1139
;1139:			break;
ADDRGP4 $582
JUMPV
LABELV $1018
line 1145
;1140:
;1141:			//
;1142:			// missile impacts
;1143:			//
;1144:		case EV_MISSILE_HIT:
;1145:			DEBUGNAME("EV_MISSILE_HIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1019
ADDRGP4 $1022
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1019
line 1146
;1146:			ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1147
;1147:			CG_MissileHitPlayer(es->weapon, position, dir, es->otherEntityNum);
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 1148
;1148:			break;
ADDRGP4 $582
JUMPV
LABELV $1023
line 1151
;1149:
;1150:		case EV_MISSILE_MISS:
;1151:			DEBUGNAME("EV_MISSILE_MISS");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1024
ADDRGP4 $1027
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1024
line 1152
;1152:			ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1153
;1153:			CG_MissileHitWall(es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT);
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
CNSTI4 0
ASGNI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 104
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1154
;1154:			break;
ADDRGP4 $582
JUMPV
LABELV $1028
line 1157
;1155:
;1156:		case EV_MISSILE_MISS_METAL:
;1157:			DEBUGNAME("EV_MISSILE_MISS_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1029
ADDRGP4 $1032
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1029
line 1158
;1158:			ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1159
;1159:			CG_MissileHitWall(es->weapon, 0, position, dir, IMPACTSOUND_METAL);
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1160
;1160:			break;
ADDRGP4 $582
JUMPV
LABELV $1033
line 1163
;1161:
;1162:		case EV_RAILTRAIL:
;1163:			DEBUGNAME("EV_RAILTRAIL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1034
ADDRGP4 $1037
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1034
line 1164
;1164:			cent->currentState.weapon = WP_RAILGUN;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 7
ASGNI4
line 1167
;1165:			//unlagged - attack prediction #2
;1166:			// if the client is us, unlagged is on server-side, and we've got it client-side
;1167:			if (es->clientNum == cg.predictedPlayerState.clientNum &&
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $1038
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRGP4 cgs+181708
INDIRI4
ADDRLP4 108
INDIRI4
EQI4 $1038
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 108
INDIRI4
NEI4 $1045
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 108
INDIRI4
EQI4 $1038
LABELV $1045
line 1168
;1168:					cgs.delagHitscan && (cg_delag.integer & 1 || cg_delag.integer & 16)) {
line 1171
;1169:				// do nothing, because it was already predicted
;1170:				//Com_Printf("Ignoring rail trail event\n");
;1171:			} else {
ADDRGP4 $582
JUMPV
LABELV $1038
line 1172
;1172:				if (es->clientNum == cg.snap->ps.clientNum && !cg.renderingThirdPerson) {
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1046
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1046
line 1173
;1173:					if (cg_drawGun.integer == 2)
ADDRGP4 cg_drawGun+12
INDIRI4
CNSTI4 2
NEI4 $1050
line 1174
;1174:						VectorMA(es->origin2, 8, cg.refdef.viewaxis[1], es->origin2);
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+109252+36+12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 116
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+109252+36+12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+109252+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1051
JUMPV
LABELV $1050
line 1175
;1175:					else if (cg_drawGun.integer == 3)
ADDRGP4 cg_drawGun+12
INDIRI4
CNSTI4 3
NEI4 $1064
line 1176
;1176:						VectorMA(es->origin2, 4, cg.refdef.viewaxis[1], es->origin2);
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 cg+109252+36+12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 cg+109252+36+12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 132
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 cg+109252+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1064
LABELV $1051
line 1177
;1177:				}
LABELV $1046
line 1181
;1178:
;1179:
;1180:				// draw a rail trail, because it wasn't predicted
;1181:				CG_RailTrail(ci, es->origin2, es->pos.trBase);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 1184
;1182:
;1183:				// if the end was on a nomark surface, don't make an explosion
;1184:				if (es->eventParm != 255) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 255
EQI4 $582
line 1185
;1185:					ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1186
;1186:					CG_MissileHitWall(es->weapon, es->clientNum, position, dir, IMPACTSOUND_DEFAULT);
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1187
;1187:				}
line 1189
;1188:				//Com_Printf("Non-predicted rail trail\n");
;1189:			}
line 1191
;1190:			//unlagged - attack prediction #2
;1191:			break;
ADDRGP4 $582
JUMPV
LABELV $1080
line 1194
;1192:
;1193:		case EV_BULLET_HIT_WALL:
;1194:			DEBUGNAME("EV_BULLET_HIT_WALL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1081
ADDRGP4 $1084
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1081
line 1197
;1195:			//unlagged - attack prediction #2
;1196:			// if the client is us, unlagged is on server-side, and we've got it client-side
;1197:			if (es->clientNum == cg.predictedPlayerState.clientNum &&
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $1085
ADDRLP4 112
CNSTI4 0
ASGNI4
ADDRGP4 cgs+181708
INDIRI4
ADDRLP4 112
INDIRI4
EQI4 $1085
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 112
INDIRI4
NEI4 $1092
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 112
INDIRI4
EQI4 $1085
LABELV $1092
line 1198
;1198:					cgs.delagHitscan && (cg_delag.integer & 1 || cg_delag.integer & 2)) {
line 1201
;1199:				// do nothing, because it was already predicted
;1200:				//Com_Printf("Ignoring bullet event\n");
;1201:			} else {
ADDRGP4 $582
JUMPV
LABELV $1085
line 1203
;1202:				// do the bullet, because it wasn't predicted
;1203:				ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1204
;1204:				CG_Bullet(es->pos.trBase, es->otherEntityNum, dir, qfalse, ENTITYNUM_WORLD);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1022
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1206
;1205:				//Com_Printf("Non-predicted bullet\n");
;1206:			}
line 1208
;1207:			//unlagged - attack prediction #2
;1208:			break;
ADDRGP4 $582
JUMPV
LABELV $1093
line 1211
;1209:
;1210:		case EV_BULLET_HIT_FLESH:
;1211:			DEBUGNAME("EV_BULLET_HIT_FLESH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1094
ADDRGP4 $1097
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1094
line 1214
;1212:			//unlagged - attack prediction #2
;1213:			// if the client is us, unlagged is on server-side, and we've got it client-side
;1214:			if (es->clientNum == cg.predictedPlayerState.clientNum &&
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $1098
ADDRLP4 116
CNSTI4 0
ASGNI4
ADDRGP4 cgs+181708
INDIRI4
ADDRLP4 116
INDIRI4
EQI4 $1098
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 116
INDIRI4
NEI4 $1105
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 116
INDIRI4
EQI4 $1098
LABELV $1105
line 1215
;1215:					cgs.delagHitscan && (cg_delag.integer & 1 || cg_delag.integer & 2)) {
line 1218
;1216:				// do nothing, because it was already predicted
;1217:				//Com_Printf("Ignoring bullet event\n");
;1218:			} else {
ADDRGP4 $582
JUMPV
LABELV $1098
line 1220
;1219:				// do the bullet, because it wasn't predicted
;1220:				CG_Bullet(es->pos.trBase, es->otherEntityNum, dir, qtrue, es->eventParm);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1222
;1221:				//Com_Printf("Non-predicted bullet\n");
;1222:			}
line 1224
;1223:			//unlagged - attack prediction #2
;1224:			break;
ADDRGP4 $582
JUMPV
LABELV $1106
line 1227
;1225:
;1226:		case EV_SHOTGUN:
;1227:			DEBUGNAME("EV_SHOTGUN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1107
ADDRGP4 $1110
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1107
line 1230
;1228:			//unlagged - attack prediction #2
;1229:			// if the client is us, unlagged is on server-side, and we've got it client-side
;1230:			if (es->otherEntityNum == cg.predictedPlayerState.clientNum &&
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $1111
ADDRLP4 120
CNSTI4 0
ASGNI4
ADDRGP4 cgs+181708
INDIRI4
ADDRLP4 120
INDIRI4
EQI4 $1111
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 120
INDIRI4
NEI4 $1118
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 120
INDIRI4
EQI4 $1111
LABELV $1118
line 1231
;1231:					cgs.delagHitscan && (cg_delag.integer & 1 || cg_delag.integer & 4)) {
line 1234
;1232:				// do nothing, because it was already predicted
;1233:				//Com_Printf("Ignoring shotgun event\n");
;1234:			} else {
ADDRGP4 $582
JUMPV
LABELV $1111
line 1236
;1235:				// do the shotgun pattern, because it wasn't predicted
;1236:				CG_ShotgunFire(es);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ShotgunFire
CALLV
pop
line 1238
;1237:				//Com_Printf("Non-predicted shotgun pattern\n");
;1238:			}
line 1240
;1239:			//unlagged - attack prediction #2
;1240:			break;
ADDRGP4 $582
JUMPV
LABELV $1119
line 1243
;1241:
;1242:		case EV_GENERAL_SOUND:
;1243:			DEBUGNAME("EV_GENERAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1120
ADDRGP4 $1123
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1120
line 1244
;1244:			if (cgs.gameSounds[ es->eventParm ]) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1124
line 1245
;1245:				trap_S_StartSound(NULL, es->number, CHAN_VOICE, cgs.gameSounds[ es->eventParm ]);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36028
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1246
;1246:			} else {
ADDRGP4 $582
JUMPV
LABELV $1124
line 1247
;1247:				s = CG_ConfigString(CS_SOUNDS + es->eventParm);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 124
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 124
INDIRP4
ASGNP4
line 1248
;1248:				trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, s));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1249
;1249:			}
line 1250
;1250:			break;
ADDRGP4 $582
JUMPV
LABELV $1128
line 1253
;1251:
;1252:		case EV_GLOBAL_SOUND: // play from the player's head so it never diminishes
;1253:			DEBUGNAME("EV_GLOBAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1129
ADDRGP4 $1132
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1129
line 1254
;1254:			if (cgs.gameSounds[ es->eventParm ]) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36028
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1133
line 1255
;1255:				trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.gameSounds[ es->eventParm ]);
CNSTP4 0
ARGP4
ADDRLP4 124
CNSTI4 184
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36028
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1256
;1256:			} else {
ADDRGP4 $582
JUMPV
LABELV $1133
line 1257
;1257:				s = CG_ConfigString(CS_SOUNDS + es->eventParm);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 124
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 124
INDIRP4
ASGNP4
line 1258
;1258:				trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_AUTO, CG_CustomSound(es->number, s));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1259
;1259:			}
line 1260
;1260:			break;
ADDRGP4 $582
JUMPV
LABELV $1139
line 1263
;1261:
;1262:		case EV_GLOBAL_TEAM_SOUND: // play from the player's head so it never diminishes
;1263:		{
line 1264
;1264:			DEBUGNAME("EV_GLOBAL_TEAM_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1140
ADDRGP4 $1143
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1140
line 1265
;1265:			switch (es->eventParm) {
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
LTI4 $582
ADDRLP4 124
INDIRI4
CNSTI4 13
GTI4 $582
ADDRLP4 124
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1265
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1265
address $1147
address $1155
address $1163
address $1173
address $1183
address $1209
address $1235
address $1241
address $1247
address $1250
address $1253
address $1256
address $1259
address $1262
code
LABELV $1147
line 1267
;1266:				case GTS_RED_CAPTURE: // CTF: red team captured the blue flag, 1FCTF: red team captured the neutral flag
;1267:					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1148
line 1268
;1268:						CG_AddBufferedSound(cgs.media.captureYourTeamSound);
ADDRGP4 cgs+180268+1292
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $1148
line 1270
;1269:					else
;1270:						CG_AddBufferedSound(cgs.media.captureOpponentSound);
ADDRGP4 cgs+180268+1296
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1271
;1271:					break;
ADDRGP4 $582
JUMPV
LABELV $1155
line 1273
;1272:				case GTS_BLUE_CAPTURE: // CTF: blue team captured the red flag, 1FCTF: blue team captured the neutral flag
;1273:					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1156
line 1274
;1274:						CG_AddBufferedSound(cgs.media.captureYourTeamSound);
ADDRGP4 cgs+180268+1292
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $1156
line 1276
;1275:					else
;1276:						CG_AddBufferedSound(cgs.media.captureOpponentSound);
ADDRGP4 cgs+180268+1296
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1277
;1277:					break;
ADDRGP4 $582
JUMPV
LABELV $1163
line 1279
;1278:				case GTS_RED_RETURN: // CTF: blue flag returned, 1FCTF: never used
;1279:					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1164
line 1280
;1280:						CG_AddBufferedSound(cgs.media.returnYourTeamSound);
ADDRGP4 cgs+180268+1300
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $1165
JUMPV
LABELV $1164
line 1282
;1281:					else
;1282:						CG_AddBufferedSound(cgs.media.returnOpponentSound);
ADDRGP4 cgs+180268+1304
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $1165
line 1284
;1283:					//
;1284:					CG_AddBufferedSound(cgs.media.blueFlagReturnedSound);
ADDRGP4 cgs+180268+1320
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1285
;1285:					break;
ADDRGP4 $582
JUMPV
LABELV $1173
line 1287
;1286:				case GTS_BLUE_RETURN: // CTF red flag returned, 1FCTF: neutral flag returned
;1287:					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1174
line 1288
;1288:						CG_AddBufferedSound(cgs.media.returnYourTeamSound);
ADDRGP4 cgs+180268+1300
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $1175
JUMPV
LABELV $1174
line 1290
;1289:					else
;1290:						CG_AddBufferedSound(cgs.media.returnOpponentSound);
ADDRGP4 cgs+180268+1304
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $1175
line 1292
;1291:					//
;1292:					CG_AddBufferedSound(cgs.media.redFlagReturnedSound);
ADDRGP4 cgs+180268+1316
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1293
;1293:					break;
ADDRGP4 $582
JUMPV
LABELV $1183
line 1297
;1294:
;1295:				case GTS_RED_TAKEN: // CTF: red team took blue flag, 1FCTF: blue team took the neutral flag
;1296:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1297:					if (cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
ADDRLP4 132
INDIRI4
NEI4 $1188
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
ADDRLP4 132
INDIRI4
EQI4 $1184
LABELV $1188
line 1298
;1298:					} else {
ADDRGP4 $582
JUMPV
LABELV $1184
line 1299
;1299:						if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1189
line 1300
;1300:							if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 5
NEI4 $1192
line 1301
;1301:								CG_AddBufferedSound(cgs.media.yourTeamTookTheFlagSound);
ADDRGP4 cgs+180268+1340
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $1192
line 1303
;1302:							else
;1303:								CG_AddBufferedSound(cgs.media.enemyTookYourFlagSound);
ADDRGP4 cgs+180268+1328
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1304
;1304:						} else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 $582
JUMPV
LABELV $1189
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $582
line 1305
;1305:							if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 5
NEI4 $1202
line 1306
;1306:								CG_AddBufferedSound(cgs.media.enemyTookTheFlagSound);
ADDRGP4 cgs+180268+1332
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $1202
line 1308
;1307:							else
;1308:								CG_AddBufferedSound(cgs.media.yourTeamTookEnemyFlagSound);
ADDRGP4 cgs+180268+1336
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1309
;1309:						}
line 1310
;1310:					}
line 1311
;1311:					break;
ADDRGP4 $582
JUMPV
LABELV $1209
line 1314
;1312:				case GTS_BLUE_TAKEN: // CTF: blue team took the red flag, 1FCTF red team took the neutral flag
;1313:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1314:					if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
ADDRLP4 136
INDIRI4
NEI4 $1214
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
ADDRLP4 136
INDIRI4
EQI4 $1210
LABELV $1214
line 1315
;1315:					} else {
ADDRGP4 $582
JUMPV
LABELV $1210
line 1316
;1316:						if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1215
line 1317
;1317:							if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 5
NEI4 $1218
line 1318
;1318:								CG_AddBufferedSound(cgs.media.yourTeamTookTheFlagSound);
ADDRGP4 cgs+180268+1340
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $1218
line 1320
;1319:							else
;1320:								CG_AddBufferedSound(cgs.media.enemyTookYourFlagSound);
ADDRGP4 cgs+180268+1328
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1321
;1321:						} else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 $582
JUMPV
LABELV $1215
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $582
line 1322
;1322:							if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 5
NEI4 $1228
line 1323
;1323:								CG_AddBufferedSound(cgs.media.enemyTookTheFlagSound);
ADDRGP4 cgs+180268+1332
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $1228
line 1325
;1324:							else
;1325:								CG_AddBufferedSound(cgs.media.yourTeamTookEnemyFlagSound);
ADDRGP4 cgs+180268+1336
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1326
;1326:						}
line 1327
;1327:					}
line 1328
;1328:					break;
ADDRGP4 $582
JUMPV
LABELV $1235
line 1330
;1329:				case GTS_REDOBELISK_ATTACKED: // Overload: red obelisk is being attacked
;1330:					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $582
line 1331
;1331:						CG_AddBufferedSound(cgs.media.yourBaseIsUnderAttackSound);
ADDRGP4 cgs+180268+1348
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1332
;1332:					}
line 1333
;1333:					break;
ADDRGP4 $582
JUMPV
LABELV $1241
line 1335
;1334:				case GTS_BLUEOBELISK_ATTACKED: // Overload: blue obelisk is being attacked
;1335:					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $582
line 1336
;1336:						CG_AddBufferedSound(cgs.media.yourBaseIsUnderAttackSound);
ADDRGP4 cgs+180268+1348
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1337
;1337:					}
line 1338
;1338:					break;
ADDRGP4 $582
JUMPV
LABELV $1247
line 1341
;1339:
;1340:				case GTS_REDTEAM_SCORED:
;1341:					CG_AddBufferedSound(cgs.media.redScoredSound);
ADDRGP4 cgs+180268+1272
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1342
;1342:					break;
ADDRGP4 $582
JUMPV
LABELV $1250
line 1344
;1343:				case GTS_BLUETEAM_SCORED:
;1344:					CG_AddBufferedSound(cgs.media.blueScoredSound);
ADDRGP4 cgs+180268+1276
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1345
;1345:					break;
ADDRGP4 $582
JUMPV
LABELV $1253
line 1347
;1346:				case GTS_REDTEAM_TOOK_LEAD:
;1347:					CG_AddBufferedSound(cgs.media.redLeadsSound);
ADDRGP4 cgs+180268+1280
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1348
;1348:					break;
ADDRGP4 $582
JUMPV
LABELV $1256
line 1350
;1349:				case GTS_BLUETEAM_TOOK_LEAD:
;1350:					CG_AddBufferedSound(cgs.media.blueLeadsSound);
ADDRGP4 cgs+180268+1284
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1351
;1351:					break;
ADDRGP4 $582
JUMPV
LABELV $1259
line 1353
;1352:				case GTS_TEAMS_ARE_TIED:
;1353:					CG_AddBufferedSound(cgs.media.teamsTiedSound);
ADDRGP4 cgs+180268+1288
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1354
;1354:					break;
ADDRGP4 $582
JUMPV
LABELV $1262
line 1356
;1355:				case GTS_KAMIKAZE:
;1356:					trap_S_StartLocalSound(cgs.media.kamikazeFarSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1008
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1357
;1357:					break;
line 1359
;1358:				default:
;1359:					break;
line 1361
;1360:			}
;1361:			break;
ADDRGP4 $582
JUMPV
LABELV $1266
line 1367
;1362:		}
;1363:
;1364:		case EV_PAIN:
;1365:			// local player sounds are triggered in CG_CheckLocalSounds,
;1366:			// so ignore events on the player
;1367:			DEBUGNAME("EV_PAIN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1267
ADDRGP4 $1270
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1267
line 1368
;1368:			if (cent->currentState.number != cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $582
line 1369
;1369:				CG_PainEvent(cent, es->eventParm);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 1370
;1370:			}
line 1371
;1371:			break;
ADDRGP4 $582
JUMPV
LABELV $1274
line 1376
;1372:
;1373:		case EV_DEATH1:
;1374:		case EV_DEATH2:
;1375:		case EV_DEATH3:
;1376:			DEBUGNAME("EV_DEATHx");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1275
ADDRGP4 $1278
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1275
line 1378
;1377:
;1378:			if (CG_WaterLevel(cent) == 3) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 CG_WaterLevel
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 3
NEI4 $1279
line 1379
;1379:				trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*drown.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $1281
ARGP4
ADDRLP4 128
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1380
;1380:			} else {
ADDRGP4 $582
JUMPV
LABELV $1279
line 1381
;1381:				trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, va("*death%i.wav", event - EV_DEATH1 + 1)));
ADDRGP4 $1282
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 57
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1382
;1382:			}
line 1384
;1383:
;1384:			break;
ADDRGP4 $582
JUMPV
LABELV $1283
line 1388
;1385:
;1386:
;1387:		case EV_OBITUARY:
;1388:			DEBUGNAME("EV_OBITUARY");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1284
ADDRGP4 $1287
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1284
line 1389
;1389:			CG_Obituary(es);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Obituary
CALLV
pop
line 1390
;1390:			break;
ADDRGP4 $582
JUMPV
LABELV $1288
line 1396
;1391:
;1392:			//
;1393:			// powerup events
;1394:			//
;1395:		case EV_POWERUP_QUAD:
;1396:			DEBUGNAME("EV_POWERUP_QUAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1289
ADDRGP4 $1292
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1289
line 1397
;1397:			if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1293
line 1398
;1398:				cg.powerupActive = PW_QUAD;
ADDRGP4 cg+125000
CNSTI4 1
ASGNI4
line 1399
;1399:				cg.powerupTime = cg.time;
ADDRGP4 cg+125004
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1400
;1400:			}
LABELV $1293
line 1401
;1401:			trap_S_StartSound(NULL, es->number, CHAN_ITEM, cgs.media.quadSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+180268+804
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1402
;1402:			break;
ADDRGP4 $582
JUMPV
LABELV $1301
line 1404
;1403:		case EV_POWERUP_BATTLESUIT:
;1404:			DEBUGNAME("EV_POWERUP_BATTLESUIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1302
ADDRGP4 $1305
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1302
line 1405
;1405:			if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1306
line 1406
;1406:				cg.powerupActive = PW_BATTLESUIT;
ADDRGP4 cg+125000
CNSTI4 2
ASGNI4
line 1407
;1407:				cg.powerupTime = cg.time;
ADDRGP4 cg+125004
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1408
;1408:			}
LABELV $1306
line 1409
;1409:			trap_S_StartSound(NULL, es->number, CHAN_ITEM, cgs.media.protectSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+180268+1408
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1410
;1410:			break;
ADDRGP4 $582
JUMPV
LABELV $1314
line 1412
;1411:		case EV_POWERUP_REGEN:
;1412:			DEBUGNAME("EV_POWERUP_REGEN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1315
ADDRGP4 $1318
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1315
line 1413
;1413:			if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1319
line 1414
;1414:				cg.powerupActive = PW_REGEN;
ADDRGP4 cg+125000
CNSTI4 5
ASGNI4
line 1415
;1415:				cg.powerupTime = cg.time;
ADDRGP4 cg+125004
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1416
;1416:			}
LABELV $1319
line 1417
;1417:			trap_S_StartSound(NULL, es->number, CHAN_ITEM, cgs.media.regenSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+180268+1404
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1418
;1418:			break;
ADDRGP4 $582
JUMPV
LABELV $1327
line 1421
;1419:
;1420:		case EV_GIB_PLAYER:
;1421:			DEBUGNAME("EV_GIB_PLAYER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1328
ADDRGP4 $1331
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1328
line 1425
;1422:			// don't play gib sound when using the kamikaze because it interferes
;1423:			// with the kamikaze sound, downside is that the gib sound will also
;1424:			// not be played when someone is gibbed while just carrying the kamikaze
;1425:			if (!(es->eFlags & EF_KAMIKAZE)) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $1332
line 1426
;1426:				trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.gibSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+180268+1060
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1427
;1427:			}
LABELV $1332
line 1428
;1428:			CG_GibPlayer(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 1430
;1429:			// TODO: New function option for a more directional gib effect
;1430:			if (cg_leiEnhancement.integer)
ADDRGP4 cg_leiEnhancement+12
INDIRI4
CNSTI4 0
EQI4 $582
line 1431
;1431:				trap_R_LFX_ParticleEffect(16, cent->lerpOrigin, cent->currentState.angles);
CNSTI4 16
ARGI4
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 128
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 trap_R_LFX_ParticleEffect
CALLV
pop
line 1433
;1432:
;1433:			break;
ADDRGP4 $582
JUMPV
LABELV $1339
line 1436
;1434:
;1435:		case EV_STOPLOOPINGSOUND:
;1436:			DEBUGNAME("EV_STOPLOOPINGSOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1340
ADDRGP4 $1343
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1340
line 1437
;1437:			trap_S_StopLoopingSound(es->number);
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 1438
;1438:			es->loopSound = 0;
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1439
;1439:			break;
ADDRGP4 $582
JUMPV
LABELV $1344
line 1442
;1440:
;1441:		case EV_DEBUG_LINE:
;1442:			DEBUGNAME("EV_DEBUG_LINE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1345
ADDRGP4 $1348
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1345
line 1443
;1443:			CG_Beam(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1444
;1444:			break;
ADDRGP4 $582
JUMPV
LABELV $581
line 1447
;1445:
;1446:		default:
;1447:			DEBUGNAME("UNKNOWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1349
ADDRGP4 $1352
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1349
line 1448
;1448:			CG_Error("Unknown event: %i", event);
ADDRGP4 $1353
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1449
;1449:			break;
LABELV $582
line 1452
;1450:	}
;1451:
;1452:}
LABELV $566
endproc CG_EntityEvent 140 48
export CG_CheckEvents
proc CG_CheckEvents 8 12
line 1460
;1453:
;1454:/*
;1455:==============
;1456:CG_CheckEvents
;1457:
;1458:==============
;1459: */
;1460:void CG_CheckEvents(centity_t *cent) {
line 1462
;1461:	// check for event-only entities
;1462:	if (cent->currentState.eType > ET_EVENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $1357
line 1463
;1463:		if (cent->previousEvent) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1359
line 1464
;1464:			return; // already fired
ADDRGP4 $1356
JUMPV
LABELV $1359
line 1467
;1465:		}
;1466:		// if this is a player event set the entity number of the client entity number
;1467:		if (cent->currentState.eFlags & EF_PLAYER_EVENT) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1361
line 1468
;1468:			cent->currentState.number = cent->currentState.otherEntityNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 1469
;1469:		}
LABELV $1361
line 1471
;1470:
;1471:		cent->previousEvent = 1;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 1
ASGNI4
line 1473
;1472:
;1473:		cent->currentState.event = cent->currentState.eType - ET_EVENTS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
ASGNI4
line 1474
;1474:	} else {
ADDRGP4 $1358
JUMPV
LABELV $1357
line 1476
;1475:		// check for events riding with another entity
;1476:		if (cent->currentState.event == cent->previousEvent) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
NEI4 $1363
line 1477
;1477:			return;
ADDRGP4 $1356
JUMPV
LABELV $1363
line 1479
;1478:		}
;1479:		cent->previousEvent = cent->currentState.event;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1480
;1480:		if ((cent->currentState.event & ~EV_EVENT_BITS) == 0) {
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 0
NEI4 $1365
line 1481
;1481:			return;
ADDRGP4 $1356
JUMPV
LABELV $1365
line 1483
;1482:		}
;1483:	}
LABELV $1358
line 1486
;1484:
;1485:	// calculate the position at exactly the frame time
;1486:	BG_EvaluateTrajectory(&cent->currentState.pos, cg.snap->serverTime, cent->lerpOrigin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1487
;1487:	CG_SetEntitySoundPosition(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 1489
;1488:
;1489:	CG_EntityEvent(cent, cent->lerpOrigin);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 1490
;1490:}
LABELV $1356
endproc CG_CheckEvents 8 12
import CG_IsARoundBasedGametype
import CG_UsesTheWhiteFlag
import CG_UsesTeamFlags
import CG_IsATeamGametype
import trap_R_LFX_ParticleEffect
import wideAdjustX
import initparticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import addChallenge
import getChallenge
import challenges_save
import challenges_init
import CG_DrawTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_TransitionEntity
import CG_ProcessSnapshots
import CG_SpurtBlood
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayer
import CG_ScorePlum
import CG_LightningBoltBeam
import CG_InvulnerabilityJuiced
import CG_InvulnerabilityImpact
import CG_ObeliskPain
import CG_ObeliskExplode
import CG_KamikazeEffect
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponBar7
import CG_DrawWeaponBar6
import CG_DrawWeaponBar5
import CG_DrawWeaponBar4
import CG_DrawWeaponBar3
import CG_DrawWeaponBar2
import CG_DrawWeaponBar1
import CG_DrawWeaponBar0
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_BestWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawString
import CG_DrawPic
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_FairCvars
import SnapVectorTowards
import CG_GetCVar
import CG_BuildSpectatorString
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import CG_Cvar_ClampInt
import CG_PredictWeaponEffects
import cg_developer
import cg_leiChibi
import cg_missionpackChecks
import cg_teamChatBeep
import cg_chatBeep
import cg_weaponOrder
import cg_weaponBarStyle
import cg_crosshairColorBlue
import cg_crosshairColorGreen
import cg_crosshairColorRed
import cg_ch13size
import cg_ch13
import cg_ch12size
import cg_ch12
import cg_ch11size
import cg_ch11
import cg_ch10size
import cg_ch10
import cg_ch9size
import cg_ch9
import cg_ch8size
import cg_ch8
import cg_ch7size
import cg_ch7
import cg_ch6size
import cg_ch6
import cg_ch5size
import cg_ch5
import cg_ch4size
import cg_ch4
import cg_ch3size
import cg_ch3
import cg_ch2size
import cg_ch2
import cg_ch1size
import cg_ch1
import cg_differentCrosshairs
import cg_crosshairPulse
import cg_fragmsgsize
import cg_autovertex
import cg_vote_custom_commands
import cg_cyclegrapple
import cg_voteflags
import cg_voip_teamonly
import cg_hitsound
import cg_alwaysWeaponBar
import cl_timeNudge
import cg_optimizePrediction
import cg_projectileNudge
import sv_fps
import cg_cmdTimeNudge
import cg_delag
import cg_enableFS
import cg_enableQ
import cg_enableBreath
import cg_enableDust
import cg_obeliskRespawnDelay
import cg_music
import cg_trueLightning
import cg_oldPlasma
import cg_modelEyes_Fwd
import cg_modelEyes_Right
import cg_modelEyes_Up
import cg_cameraEyes_Up
import cg_cameraEyes_Fwd
import cg_cameraEyes
import cg_cameramode
import cg_deathcam
import cg_leiDebug
import cg_muzzleflashStyle
import cg_leiSuperGoreyAwesome
import cg_leiBrassNoise
import cg_leiGoreNoise
import cg_leiEnhancement
import cg_oldRocket
import cg_oldRail
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import pmove_float
import pmove_msec
import pmove_fixed
import cg_obituaryOutput
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawSpeed
import cg_drawAttacker
import cg_lagometer
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_ignore
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewnudge
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_kickScale
import cg_bobmodel
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_bob
import cg_runroll
import cg_runpitch
import cg_centertime
import mod_sgspread
import mod_sgcount
import mod_lgrange
import mod_cgspread
import mod_mgspread
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
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
LABELV $1353
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1352
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $1348
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 69
byte 1 66
byte 1 85
byte 1 71
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $1343
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 84
byte 1 79
byte 1 80
byte 1 76
byte 1 79
byte 1 79
byte 1 80
byte 1 73
byte 1 78
byte 1 71
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $1331
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 73
byte 1 66
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $1318
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 82
byte 1 69
byte 1 71
byte 1 69
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $1305
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 66
byte 1 65
byte 1 84
byte 1 84
byte 1 76
byte 1 69
byte 1 83
byte 1 85
byte 1 73
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $1292
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 81
byte 1 85
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $1287
byte 1 69
byte 1 86
byte 1 95
byte 1 79
byte 1 66
byte 1 73
byte 1 84
byte 1 85
byte 1 65
byte 1 82
byte 1 89
byte 1 10
byte 1 0
align 1
LABELV $1282
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1281
byte 1 42
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1278
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 69
byte 1 65
byte 1 84
byte 1 72
byte 1 120
byte 1 10
byte 1 0
align 1
LABELV $1270
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 65
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $1143
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $1132
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $1123
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $1110
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $1097
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 85
byte 1 76
byte 1 76
byte 1 69
byte 1 84
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 95
byte 1 70
byte 1 76
byte 1 69
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $1084
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 85
byte 1 76
byte 1 76
byte 1 69
byte 1 84
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 95
byte 1 87
byte 1 65
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $1037
byte 1 69
byte 1 86
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 84
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $1032
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 95
byte 1 77
byte 1 69
byte 1 84
byte 1 65
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $1027
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 10
byte 1 0
align 1
LABELV $1022
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $1017
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 67
byte 1 79
byte 1 82
byte 1 69
byte 1 80
byte 1 76
byte 1 85
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $1012
byte 1 69
byte 1 86
byte 1 95
byte 1 76
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 66
byte 1 79
byte 1 76
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $1007
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 73
byte 1 67
byte 1 69
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $999
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 78
byte 1 86
byte 1 85
byte 1 76
byte 1 95
byte 1 73
byte 1 77
byte 1 80
byte 1 65
byte 1 67
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $994
byte 1 69
byte 1 86
byte 1 95
byte 1 79
byte 1 66
byte 1 69
byte 1 76
byte 1 73
byte 1 83
byte 1 75
byte 1 80
byte 1 65
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $986
byte 1 69
byte 1 86
byte 1 95
byte 1 79
byte 1 66
byte 1 69
byte 1 76
byte 1 73
byte 1 83
byte 1 75
byte 1 69
byte 1 88
byte 1 80
byte 1 76
byte 1 79
byte 1 68
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $981
byte 1 69
byte 1 86
byte 1 95
byte 1 75
byte 1 65
byte 1 77
byte 1 73
byte 1 75
byte 1 65
byte 1 90
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $974
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 82
byte 1 79
byte 1 88
byte 1 73
byte 1 77
byte 1 73
byte 1 84
byte 1 89
byte 1 95
byte 1 77
byte 1 73
byte 1 78
byte 1 69
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $959
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 82
byte 1 79
byte 1 88
byte 1 73
byte 1 77
byte 1 73
byte 1 84
byte 1 89
byte 1 95
byte 1 77
byte 1 73
byte 1 78
byte 1 69
byte 1 95
byte 1 83
byte 1 84
byte 1 73
byte 1 67
byte 1 75
byte 1 10
byte 1 0
align 1
LABELV $948
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 66
byte 1 79
byte 1 85
byte 1 78
byte 1 67
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $937
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 82
byte 1 69
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $930
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 79
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $920
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
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
byte 1 79
byte 1 85
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $910
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
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
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $905
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 53
byte 1 10
byte 1 0
align 1
LABELV $900
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 52
byte 1 10
byte 1 0
align 1
LABELV $895
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $890
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $885
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $880
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $875
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 57
byte 1 10
byte 1 0
align 1
LABELV $870
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 56
byte 1 10
byte 1 0
align 1
LABELV $865
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 55
byte 1 10
byte 1 0
align 1
LABELV $860
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 54
byte 1 10
byte 1 0
align 1
LABELV $855
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 53
byte 1 10
byte 1 0
align 1
LABELV $850
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 52
byte 1 10
byte 1 0
align 1
LABELV $845
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $840
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $835
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $830
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $825
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $818
byte 1 69
byte 1 86
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 78
byte 1 71
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $810
byte 1 69
byte 1 86
byte 1 95
byte 1 78
byte 1 79
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 10
byte 1 0
align 1
LABELV $796
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $761
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $756
byte 1 42
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $755
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 67
byte 1 76
byte 1 69
byte 1 65
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $748
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 85
byte 1 78
byte 1 68
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $741
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 76
byte 1 69
byte 1 65
byte 1 86
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $734
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 79
byte 1 85
byte 1 67
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $729
byte 1 42
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $728
byte 1 69
byte 1 86
byte 1 95
byte 1 84
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $723
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 77
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $718
byte 1 42
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $711
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 77
byte 1 80
byte 1 95
byte 1 80
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $681
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $668
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $667
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 70
byte 1 65
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $655
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 77
byte 1 69
byte 1 68
byte 1 73
byte 1 85
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $641
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 82
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $630
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 87
byte 1 73
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $619
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 87
byte 1 65
byte 1 68
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $608
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $597
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 95
byte 1 77
byte 1 69
byte 1 84
byte 1 65
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $587
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $576
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 69
byte 1 86
byte 1 69
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $570
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $564
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $563
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $558
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 49
byte 1 48
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $557
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 55
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $554
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 53
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $551
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 50
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $473
byte 1 47
byte 1 37
byte 1 105
byte 1 47
byte 1 0
align 1
LABELV $452
byte 1 85
byte 1 115
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $451
byte 1 78
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $441
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 0
align 1
LABELV $425
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $419
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 46
byte 1 0
align 1
LABELV $405
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $399
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 94
byte 1 49
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 77
byte 1 65
byte 1 84
byte 1 69
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $390
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $387
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 101
byte 1 97
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 103
byte 1 97
byte 1 105
byte 1 110
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $383
byte 1 39
byte 1 115
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $382
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $378
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $374
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 112
byte 1 117
byte 1 115
byte 1 104
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $370
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 97
byte 1 99
byte 1 105
byte 1 100
byte 1 32
byte 1 98
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $366
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 98
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $362
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $361
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $357
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 106
byte 1 117
byte 1 105
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $353
byte 1 39
byte 1 115
byte 1 32
byte 1 75
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $352
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 0
align 1
LABELV $348
byte 1 39
byte 1 115
byte 1 32
byte 1 80
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 77
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $347
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 0
align 1
LABELV $343
byte 1 39
byte 1 115
byte 1 32
byte 1 67
byte 1 104
byte 1 97
byte 1 105
byte 1 110
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $342
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 115
byte 1 111
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $338
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $334
byte 1 39
byte 1 115
byte 1 32
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $333
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $329
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 114
byte 1 111
byte 1 99
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $325
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $318
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $317
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $313
byte 1 97
byte 1 108
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 100
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $309
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $305
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $304
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $300
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $299
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $295
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $291
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $287
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 109
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $283
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $272
byte 1 110
byte 1 111
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $268
byte 1 89
byte 1 111
byte 1 117
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
byte 1 0
align 1
LABELV $267
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 94
byte 1 49
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 77
byte 1 65
byte 1 84
byte 1 69
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $262
byte 1 89
byte 1 111
byte 1 117
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
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $250
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 0
align 1
LABELV $236
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $224
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $223
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $220
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $215
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $214
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 105
byte 1 114
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $211
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $205
byte 1 115
byte 1 104
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $201
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $200
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $197
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $191
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $190
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $187
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $181
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $180
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 105
byte 1 114
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $177
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $171
byte 1 103
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $159
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $155
byte 1 115
byte 1 97
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $151
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $147
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $143
byte 1 115
byte 1 97
byte 1 110
byte 1 107
byte 1 32
byte 1 108
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $139
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 113
byte 1 117
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $135
byte 1 99
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $131
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $123
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $122
byte 1 110
byte 1 0
align 1
LABELV $115
byte 1 67
byte 1 71
byte 1 95
byte 1 79
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 58
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $108
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 37
byte 1 105
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $106
byte 1 37
byte 1 105
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $103
byte 1 37
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $100
byte 1 37
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $97
byte 1 49
byte 1 51
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $94
byte 1 49
byte 1 50
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $91
byte 1 49
byte 1 49
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $88
byte 1 94
byte 1 51
byte 1 51
byte 1 114
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $85
byte 1 94
byte 1 49
byte 1 50
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $82
byte 1 94
byte 1 52
byte 1 49
byte 1 115
byte 1 116
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $79
byte 1 0
align 1
LABELV $78
byte 1 84
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 0
