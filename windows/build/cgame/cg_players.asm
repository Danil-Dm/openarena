data
align 4
LABELV cg_customSoundNames
address $74
address $75
address $76
address $77
address $78
address $79
address $80
address $81
address $82
address $83
address $84
address $85
address $86
skip 76
export CG_CustomSound
code
proc CG_CustomSound 16 8
file "../../../code/cgame/cg_players.c"
line 55
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
;23:// cg_players.c -- handle the media and animation for player entities
;24:#include "cg_local.h"
;25:
;26:static char *cg_customSoundNames[MAX_CUSTOM_SOUNDS] = {
;27:	"*death1.wav",
;28:	"*death2.wav",
;29:	"*death3.wav",
;30:	"*jump1.wav",
;31:	"*pain25_1.wav",
;32:	"*pain50_1.wav",
;33:	"*pain75_1.wav",
;34:	"*pain100_1.wav",
;35:	"*falling1.wav",
;36:	"*gasp.wav",
;37:	"*drown.wav",
;38:	"*fall1.wav",
;39:	"*taunt.wav"
;40:};
;41:
;42:// leilei - eyes hack
;43:
;44:vec3_t headpos;
;45:vec3_t headang;
;46:
;47:int enableQ;
;48:
;49:/*
;50:================
;51:CG_CustomSound
;52:
;53:================
;54: */
;55:sfxHandle_t CG_CustomSound(int clientNum, const char *soundName) {
line 59
;56:	clientInfo_t *ci;
;57:	int i;
;58:
;59:	if (soundName[0] != '*') {
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $88
line 60
;60:		return trap_S_RegisterSound(soundName, qfalse);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $87
JUMPV
LABELV $88
line 63
;61:	}
;62:
;63:	if (clientNum < 0 || clientNum >= MAX_CLIENTS) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $92
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $90
LABELV $92
line 64
;64:		clientNum = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 65
;65:	}
LABELV $90
line 66
;66:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 4
CNSTI4 2120
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 68
;67:
;68:	for (i = 0; i < MAX_CUSTOM_SOUNDS && cg_customSoundNames[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $97
JUMPV
LABELV $94
line 69
;69:		if (strequals(soundName, cg_customSoundNames[i])) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $98
line 70
;70:			return ci->sounds[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 1972
ADDP4
ADDP4
INDIRI4
RETI4
ADDRGP4 $87
JUMPV
LABELV $98
line 72
;71:		}
;72:	}
LABELV $95
line 68
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $97
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $100
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $94
LABELV $100
line 74
;73:
;74:	CG_Error("Unknown custom sound: %s", soundName);
ADDRGP4 $101
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 75
;75:	return 0;
CNSTI4 0
RETI4
LABELV $87
endproc CG_CustomSound 16 8
proc CG_ParseAnimationFile 20084 12
line 96
;76:}
;77:
;78:
;79:
;80:/*
;81:=============================================================================
;82:
;83:CLIENT INFO
;84:
;85:=============================================================================
;86: */
;87:
;88:/*
;89:======================
;90:CG_ParseAnimationFile
;91:
;92:Read a configuration file containing animation counts and rates
;93:models/players/visor/animation.cfg, etc
;94:======================
;95: */
;96:static qboolean CG_ParseAnimationFile(const char *filename, clientInfo_t *ci) {
line 107
;97:	char *text_p, *prev;
;98:	int len;
;99:	int i;
;100:	char *token;
;101:	float fps;
;102:	int skip;
;103:	char text[20000];
;104:	fileHandle_t f;
;105:	animation_t *animations;
;106:
;107:	animations = ci->animations;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 544
ADDP4
ASGNP4
line 110
;108:
;109:	// load the file
;110:	len = trap_FS_FOpenFile(filename, &f, FS_READ);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20032
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20036
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 20036
INDIRI4
ASGNI4
line 111
;111:	if (len <= 0) {
ADDRLP4 28
INDIRI4
CNSTI4 0
GTI4 $103
line 112
;112:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $102
JUMPV
LABELV $103
line 114
;113:	}
;114:	if (len >= sizeof ( text) - 1) {
ADDRLP4 28
INDIRI4
CVIU4 4
CNSTU4 19999
LTU4 $105
line 115
;115:		CG_Printf("File %s too long\n", filename);
ADDRGP4 $107
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 116
;116:		trap_FS_FCloseFile(f);
ADDRLP4 20032
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 117
;117:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $102
JUMPV
LABELV $105
line 119
;118:	}
;119:	trap_FS_Read(text, len, f);
ADDRLP4 32
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 20032
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 120
;120:	text[len] = 0;
ADDRLP4 28
INDIRI4
ADDRLP4 32
ADDP4
CNSTI1 0
ASGNI1
line 121
;121:	trap_FS_FCloseFile(f);
ADDRLP4 20032
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 124
;122:
;123:	// parse the text
;124:	text_p = text;
ADDRLP4 12
ADDRLP4 32
ASGNP4
line 125
;125:	skip = 0; // quite the compiler warning
ADDRLP4 24
CNSTI4 0
ASGNI4
line 127
;126:
;127:	ci->footsteps = FOOTSTEP_NORMAL;
ADDRFP4 4
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 0
ASGNI4
line 128
;128:	VectorClear(ci->headOffset);
ADDRLP4 20040
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20044
CNSTF4 0
ASGNF4
ADDRLP4 20040
INDIRP4
CNSTI4 504
ADDP4
ADDRLP4 20044
INDIRF4
ASGNF4
ADDRLP4 20040
INDIRP4
CNSTI4 500
ADDP4
ADDRLP4 20044
INDIRF4
ASGNF4
ADDRLP4 20040
INDIRP4
CNSTI4 496
ADDP4
ADDRLP4 20044
INDIRF4
ASGNF4
line 129
;129:	ci->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 0
ASGNI4
line 130
;130:	ci->fixedlegs = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 488
ADDP4
CNSTI4 0
ASGNI4
line 131
;131:	ci->fixedtorso = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 492
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $109
JUMPV
LABELV $108
line 134
;132:
;133:	// read optional parameters
;134:	while (1) {
line 135
;135:		prev = text_p; // so we can unget
ADDRLP4 20
ADDRLP4 12
INDIRP4
ASGNP4
line 136
;136:		token = COM_Parse(&text_p);
ADDRLP4 12
ARGP4
ADDRLP4 20048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20048
INDIRP4
ASGNP4
line 137
;137:		if ( !token[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $111
line 138
;138:			break;
ADDRGP4 $110
JUMPV
LABELV $111
line 140
;139:		}
;140:		if (Q_strequal(token, "footsteps")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $115
ARGP4
ADDRLP4 20052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20052
INDIRI4
CNSTI4 0
NEI4 $113
line 141
;141:			token = COM_Parse(&text_p);
ADDRLP4 12
ARGP4
ADDRLP4 20056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20056
INDIRP4
ASGNP4
line 142
;142:			if ( !token[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $116
line 143
;143:				break;
ADDRGP4 $110
JUMPV
LABELV $116
line 145
;144:			}
;145:			if (Q_strequal(token, "default") || Q_strequal(token, "normal")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $120
ARGP4
ADDRLP4 20060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 0
EQI4 $122
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $121
ARGP4
ADDRLP4 20064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 0
NEI4 $118
LABELV $122
line 146
;146:				ci->footsteps = FOOTSTEP_NORMAL;
ADDRFP4 4
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 0
ASGNI4
line 147
;147:			} else if (Q_strequal(token, "boot")) {
ADDRGP4 $109
JUMPV
LABELV $118
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $125
ARGP4
ADDRLP4 20068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20068
INDIRI4
CNSTI4 0
NEI4 $123
line 148
;148:				ci->footsteps = FOOTSTEP_BOOT;
ADDRFP4 4
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 1
ASGNI4
line 149
;149:			} else if (Q_strequal(token, "flesh")) {
ADDRGP4 $109
JUMPV
LABELV $123
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $128
ARGP4
ADDRLP4 20072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 0
NEI4 $126
line 150
;150:				ci->footsteps = FOOTSTEP_FLESH;
ADDRFP4 4
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 2
ASGNI4
line 151
;151:			} else if (Q_strequal(token, "mech")) {
ADDRGP4 $109
JUMPV
LABELV $126
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $131
ARGP4
ADDRLP4 20076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20076
INDIRI4
CNSTI4 0
NEI4 $129
line 152
;152:				ci->footsteps = FOOTSTEP_MECH;
ADDRFP4 4
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 3
ASGNI4
line 153
;153:			} else if (Q_strequal(token, "energy")) {
ADDRGP4 $109
JUMPV
LABELV $129
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $134
ARGP4
ADDRLP4 20080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20080
INDIRI4
CNSTI4 0
NEI4 $132
line 154
;154:				ci->footsteps = FOOTSTEP_ENERGY;
ADDRFP4 4
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 4
ASGNI4
line 155
;155:			} else {
ADDRGP4 $109
JUMPV
LABELV $132
line 156
;156:				CG_Printf("Bad footsteps parm in %s: %s\n", filename, token);
ADDRGP4 $135
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 157
;157:			}
line 158
;158:			continue;
ADDRGP4 $109
JUMPV
LABELV $113
line 159
;159:		} else if (Q_strequal(token, "headoffset")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $138
ARGP4
ADDRLP4 20056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20056
INDIRI4
CNSTI4 0
NEI4 $136
line 160
;160:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $139
line 161
;161:				token = COM_Parse(&text_p);
ADDRLP4 12
ARGP4
ADDRLP4 20060
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20060
INDIRP4
ASGNP4
line 162
;162:				if ( !token[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $143
line 163
;163:					break;
ADDRGP4 $109
JUMPV
LABELV $143
line 165
;164:				}
;165:				ci->headOffset[i] = atof(token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20064
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 496
ADDP4
ADDP4
ADDRLP4 20064
INDIRF4
ASGNF4
line 166
;166:			}
LABELV $140
line 160
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $139
line 167
;167:			continue;
ADDRGP4 $109
JUMPV
LABELV $136
line 168
;168:		} else if (Q_strequal(token, "eyes")) { // leilei - EYES
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 20060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 0
NEI4 $145
line 169
;169:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $148
line 170
;170:				token = COM_Parse(&text_p);
ADDRLP4 12
ARGP4
ADDRLP4 20064
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20064
INDIRP4
ASGNP4
line 171
;171:				if ( !token[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $152
line 172
;172:					break;
ADDRGP4 $109
JUMPV
LABELV $152
line 174
;173:				}
;174:				ci->eyepos[i] = atof(token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20068
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 2104
ADDP4
ADDP4
ADDRLP4 20068
INDIRF4
ASGNF4
line 175
;175:			}
LABELV $149
line 169
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $148
line 176
;176:			continue;
ADDRGP4 $109
JUMPV
LABELV $145
line 177
;177:		} else if (Q_strequal(token, "sex")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $156
ARGP4
ADDRLP4 20064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 0
NEI4 $154
line 178
;178:			token = COM_Parse(&text_p);
ADDRLP4 12
ARGP4
ADDRLP4 20068
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20068
INDIRP4
ASGNP4
line 179
;179:			if ( !token[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $157
line 180
;180:				break;
ADDRGP4 $110
JUMPV
LABELV $157
line 182
;181:			}
;182:			if (token[0] == 'f' || token[0] == 'F') {
ADDRLP4 20072
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 102
EQI4 $161
ADDRLP4 20072
INDIRI4
CNSTI4 70
NEI4 $159
LABELV $161
line 183
;183:				ci->gender = GENDER_FEMALE;
ADDRFP4 4
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 1
ASGNI4
line 184
;184:			} else if (token[0] == 'n' || token[0] == 'N') {
ADDRGP4 $109
JUMPV
LABELV $159
ADDRLP4 20076
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20076
INDIRI4
CNSTI4 110
EQI4 $164
ADDRLP4 20076
INDIRI4
CNSTI4 78
NEI4 $162
LABELV $164
line 185
;185:				ci->gender = GENDER_NEUTER;
ADDRFP4 4
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 2
ASGNI4
line 186
;186:			} else {
ADDRGP4 $109
JUMPV
LABELV $162
line 187
;187:				ci->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 0
ASGNI4
line 188
;188:			}
line 189
;189:			continue;
ADDRGP4 $109
JUMPV
LABELV $154
line 190
;190:		} else if (Q_strequal(token, "fixedlegs")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $167
ARGP4
ADDRLP4 20068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20068
INDIRI4
CNSTI4 0
NEI4 $165
line 191
;191:			ci->fixedlegs = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 488
ADDP4
CNSTI4 1
ASGNI4
line 192
;192:			continue;
ADDRGP4 $109
JUMPV
LABELV $165
line 193
;193:		} else if (Q_strequal(token, "fixedtorso")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 20072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 0
NEI4 $168
line 194
;194:			ci->fixedtorso = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 492
ADDP4
CNSTI4 1
ASGNI4
line 195
;195:			continue;
ADDRGP4 $109
JUMPV
LABELV $168
line 199
;196:		}
;197:
;198:		// if it is a number, start parsing animations
;199:		if (token[0] >= '0' && token[0] <= '9') {
ADDRLP4 20076
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20076
INDIRI4
CNSTI4 48
LTI4 $171
ADDRLP4 20076
INDIRI4
CNSTI4 57
GTI4 $171
line 200
;200:			text_p = prev; // unget the token
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 201
;201:			break;
ADDRGP4 $110
JUMPV
LABELV $171
line 203
;202:		}
;203:		Com_Printf("unknown token '%s' in %s\n", token, filename);
ADDRGP4 $173
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 204
;204:	}
LABELV $109
line 134
ADDRGP4 $108
JUMPV
LABELV $110
line 207
;205:
;206:	// read information for each frame
;207:	for (i = 0; i < MAX_ANIMATIONS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $174
line 209
;208:
;209:		token = COM_Parse(&text_p);
ADDRLP4 12
ARGP4
ADDRLP4 20048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20048
INDIRP4
ASGNP4
line 210
;210:		if ( !token[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $178
line 211
;211:			if (i >= TORSO_GETFLAG && i <= TORSO_NEGATIVE) {
ADDRLP4 0
INDIRI4
CNSTI4 25
LTI4 $180
ADDRLP4 0
INDIRI4
CNSTI4 30
GTI4 $180
line 212
;212:				animations[i] = animations[TORSO_GESTURE];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRB
ASGNB 28
line 213
;213:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 214
;214:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 215
;215:				continue;
ADDRGP4 $175
JUMPV
LABELV $180
line 218
;216:			}
;217:			// LEILEI - run animation fallback.
;218:			if (i == TORSO_RUN) {
ADDRLP4 0
INDIRI4
CNSTI4 31
NEI4 $182
line 219
;219:				animations[i] = animations[TORSO_STAND];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
INDIRB
ASGNB 28
line 220
;220:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 221
;221:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 222
;222:				continue;
ADDRGP4 $175
JUMPV
LABELV $182
line 224
;223:			}
;224:			if (i == TORSO_RUN2) {
ADDRLP4 0
INDIRI4
CNSTI4 32
NEI4 $184
line 225
;225:				animations[i] = animations[TORSO_STAND2];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 336
ADDP4
INDIRB
ASGNB 28
line 226
;226:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 227
;227:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 228
;228:				continue;
ADDRGP4 $175
JUMPV
LABELV $184
line 230
;229:			}
;230:			if (i == TORSO_RUN3) {
ADDRLP4 0
INDIRI4
CNSTI4 33
NEI4 $186
line 231
;231:				animations[i] = animations[TORSO_STAND];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
INDIRB
ASGNB 28
line 232
;232:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 233
;233:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 234
;234:				continue;
ADDRGP4 $175
JUMPV
LABELV $186
line 236
;235:			}
;236:			if (i == TORSO_STRAFE) {
ADDRLP4 0
INDIRI4
CNSTI4 42
NEI4 $188
line 237
;237:				animations[i] = animations[TORSO_STAND];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
INDIRB
ASGNB 28
line 238
;238:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 239
;239:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 240
;240:				continue;
ADDRGP4 $175
JUMPV
LABELV $188
line 242
;241:			}
;242:			if (i == TORSO_STAND3) {
ADDRLP4 0
INDIRI4
CNSTI4 34
NEI4 $190
line 243
;243:				animations[i] = animations[TORSO_STAND];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
INDIRB
ASGNB 28
line 244
;244:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 245
;245:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 246
;246:				continue;
ADDRGP4 $175
JUMPV
LABELV $190
line 248
;247:			}
;248:			if (i == TORSO_JUMP) {
ADDRLP4 0
INDIRI4
CNSTI4 35
NEI4 $192
line 249
;249:				animations[i] = animations[TORSO_STAND];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
INDIRB
ASGNB 28
line 250
;250:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 251
;251:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 252
;252:				continue;
ADDRGP4 $175
JUMPV
LABELV $192
line 254
;253:			}
;254:			if (i == TORSO_JUMP2) {
ADDRLP4 0
INDIRI4
CNSTI4 36
NEI4 $194
line 255
;255:				animations[i] = animations[TORSO_STAND];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
INDIRB
ASGNB 28
line 256
;256:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 257
;257:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 258
;258:				continue;
ADDRGP4 $175
JUMPV
LABELV $194
line 260
;259:			}
;260:			if (i == TORSO_JUMP3) {
ADDRLP4 0
INDIRI4
CNSTI4 37
NEI4 $196
line 261
;261:				animations[i] = animations[TORSO_STAND];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
INDIRB
ASGNB 28
line 262
;262:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 263
;263:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 264
;264:				continue;
ADDRGP4 $175
JUMPV
LABELV $196
line 266
;265:			}
;266:			if (i == TORSO_FALL) {
ADDRLP4 0
INDIRI4
CNSTI4 38
NEI4 $198
line 267
;267:				animations[i] = animations[TORSO_STAND];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
INDIRB
ASGNB 28
line 268
;268:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 269
;269:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 270
;270:				continue;
ADDRGP4 $175
JUMPV
LABELV $198
line 272
;271:			}
;272:			if (i == TORSO_FALL2) {
ADDRLP4 0
INDIRI4
CNSTI4 39
NEI4 $200
line 273
;273:				animations[i] = animations[TORSO_STAND2];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 336
ADDP4
INDIRB
ASGNB 28
line 274
;274:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 275
;275:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 276
;276:				continue;
ADDRGP4 $175
JUMPV
LABELV $200
line 278
;277:			}
;278:			if (i == TORSO_FALL3) {
ADDRLP4 0
INDIRI4
CNSTI4 40
NEI4 $202
line 279
;279:				animations[i] = animations[TORSO_STAND];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
INDIRB
ASGNB 28
line 280
;280:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 281
;281:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 282
;282:				continue;
ADDRGP4 $175
JUMPV
LABELV $202
line 284
;283:			}
;284:			if (i == TORSO_TALK) {
ADDRLP4 0
INDIRI4
CNSTI4 41
NEI4 $204
line 285
;285:				animations[i] = animations[TORSO_STAND];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
INDIRB
ASGNB 28
line 286
;286:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 287
;287:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 288
;288:				continue;
ADDRGP4 $175
JUMPV
LABELV $204
line 290
;289:			}
;290:			if (i == LEGS_STRAFE_LEFT) {
ADDRLP4 0
INDIRI4
CNSTI4 43
NEI4 $206
line 291
;291:				animations[i] = animations[LEGS_RUN];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 420
ADDP4
INDIRB
ASGNB 28
line 292
;292:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 293
;293:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 294
;294:				continue;
ADDRGP4 $175
JUMPV
LABELV $206
line 296
;295:			}
;296:			if (i == LEGS_STRAFE_RIGHT) {
ADDRLP4 0
INDIRI4
CNSTI4 44
NEI4 $176
line 297
;297:				animations[i] = animations[LEGS_RUN];
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 420
ADDP4
INDIRB
ASGNB 28
line 298
;298:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 299
;299:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 300
;300:				continue;
ADDRGP4 $175
JUMPV
line 302
;301:			}
;302:			break;
LABELV $178
line 304
;303:		}
;304:		animations[i].firstFrame = atoi(token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20052
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 20052
INDIRI4
ASGNI4
line 306
;305:		// leg only frames are adjusted to not count the upper body only frames
;306:		if (i == LEGS_WALKCR) {
ADDRLP4 0
INDIRI4
CNSTI4 13
NEI4 $210
line 307
;307:			skip = animations[LEGS_WALKCR].firstFrame - animations[TORSO_GESTURE].firstFrame;
ADDRLP4 24
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
SUBI4
ASGNI4
line 308
;308:		}
LABELV $210
line 309
;309:		if (i >= LEGS_WALKCR && i < TORSO_GETFLAG) {
ADDRLP4 0
INDIRI4
CNSTI4 13
LTI4 $212
ADDRLP4 0
INDIRI4
CNSTI4 25
GEI4 $212
line 310
;310:			animations[i].firstFrame -= skip;
ADDRLP4 20060
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ASGNP4
ADDRLP4 20060
INDIRP4
ADDRLP4 20060
INDIRP4
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 311
;311:		}
LABELV $212
line 313
;312:
;313:		token = COM_Parse(&text_p);
ADDRLP4 12
ARGP4
ADDRLP4 20060
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20060
INDIRP4
ASGNP4
line 314
;314:		if ( !token[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $214
line 315
;315:			break;
ADDRGP4 $176
JUMPV
LABELV $214
line 317
;316:		}
;317:		animations[i].numFrames = atoi(token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20064
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20064
INDIRI4
ASGNI4
line 319
;318:
;319:		animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 320
;320:		animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 322
;321:		// if numFrames is negative the animation is reversed
;322:		if (animations[i].numFrames < 0) {
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
GEI4 $216
line 323
;323:			animations[i].numFrames = -animations[i].numFrames;
ADDRLP4 20068
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 20068
INDIRP4
ADDRLP4 20068
INDIRP4
INDIRI4
NEGI4
ASGNI4
line 324
;324:			animations[i].reversed = qtrue;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 1
ASGNI4
line 325
;325:		}
LABELV $216
line 327
;326:
;327:		token = COM_Parse(&text_p);
ADDRLP4 12
ARGP4
ADDRLP4 20068
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20068
INDIRP4
ASGNP4
line 328
;328:		if ( !token[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $218
line 329
;329:			break;
ADDRGP4 $176
JUMPV
LABELV $218
line 331
;330:		}
;331:		animations[i].loopFrames = atoi(token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20072
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 20072
INDIRI4
ASGNI4
line 333
;332:
;333:		token = COM_Parse(&text_p);
ADDRLP4 12
ARGP4
ADDRLP4 20076
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20076
INDIRP4
ASGNP4
line 334
;334:		if ( !token[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $220
line 335
;335:			break;
ADDRGP4 $176
JUMPV
LABELV $220
line 337
;336:		}
;337:		fps = atof(token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20080
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 20080
INDIRF4
ASGNF4
line 338
;338:		if (fps == 0) {
ADDRLP4 16
INDIRF4
CNSTF4 0
NEF4 $222
line 339
;339:			fps = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 340
;340:		}
LABELV $222
line 341
;341:		animations[i].frameLerp = 1000 / fps;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 12
ADDP4
CNSTF4 1148846080
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 342
;342:		animations[i].initialLerp = 1000 / fps;
CNSTI4 28
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 16
ADDP4
CNSTF4 1148846080
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 343
;343:	}
LABELV $175
line 207
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 45
LTI4 $174
LABELV $176
line 345
;344:
;345:	if (i != MAX_ANIMATIONS) {
ADDRLP4 0
INDIRI4
CNSTI4 45
EQI4 $224
line 346
;346:		CG_Printf("Error parsing animation file: %s\n", filename);
ADDRGP4 $226
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 347
;347:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $102
JUMPV
LABELV $224
line 351
;348:	}
;349:
;350:	// crouch backward animation
;351:	memcpy(&animations[LEGS_BACKCR], &animations[LEGS_WALKCR], sizeof (animation_t));
ADDRLP4 8
INDIRP4
CNSTI4 1288
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
ARGP4
CNSTI4 28
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 352
;352:	animations[LEGS_BACKCR].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 1308
ADDP4
CNSTI4 1
ASGNI4
line 354
;353:	// walk backward animation
;354:	memcpy(&animations[LEGS_BACKWALK], &animations[LEGS_WALK], sizeof (animation_t));
ADDRLP4 8
INDIRP4
CNSTI4 1316
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 392
ADDP4
ARGP4
CNSTI4 28
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 355
;355:	animations[LEGS_BACKWALK].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 1336
ADDP4
CNSTI4 1
ASGNI4
line 357
;356:	// flag moving fast
;357:	animations[FLAG_RUN].firstFrame = 0;
ADDRLP4 8
INDIRP4
CNSTI4 1344
ADDP4
CNSTI4 0
ASGNI4
line 358
;358:	animations[FLAG_RUN].numFrames = 16;
ADDRLP4 8
INDIRP4
CNSTI4 1348
ADDP4
CNSTI4 16
ASGNI4
line 359
;359:	animations[FLAG_RUN].loopFrames = 16;
ADDRLP4 8
INDIRP4
CNSTI4 1352
ADDP4
CNSTI4 16
ASGNI4
line 360
;360:	animations[FLAG_RUN].frameLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1356
ADDP4
CNSTI4 66
ASGNI4
line 361
;361:	animations[FLAG_RUN].initialLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1360
ADDP4
CNSTI4 66
ASGNI4
line 362
;362:	animations[FLAG_RUN].reversed = qfalse;
ADDRLP4 8
INDIRP4
CNSTI4 1364
ADDP4
CNSTI4 0
ASGNI4
line 364
;363:	// flag not moving or moving slowly
;364:	animations[FLAG_STAND].firstFrame = 16;
ADDRLP4 8
INDIRP4
CNSTI4 1372
ADDP4
CNSTI4 16
ASGNI4
line 365
;365:	animations[FLAG_STAND].numFrames = 5;
ADDRLP4 8
INDIRP4
CNSTI4 1376
ADDP4
CNSTI4 5
ASGNI4
line 366
;366:	animations[FLAG_STAND].loopFrames = 0;
ADDRLP4 8
INDIRP4
CNSTI4 1380
ADDP4
CNSTI4 0
ASGNI4
line 367
;367:	animations[FLAG_STAND].frameLerp = 1000 / 20;
ADDRLP4 8
INDIRP4
CNSTI4 1384
ADDP4
CNSTI4 50
ASGNI4
line 368
;368:	animations[FLAG_STAND].initialLerp = 1000 / 20;
ADDRLP4 8
INDIRP4
CNSTI4 1388
ADDP4
CNSTI4 50
ASGNI4
line 369
;369:	animations[FLAG_STAND].reversed = qfalse;
ADDRLP4 8
INDIRP4
CNSTI4 1392
ADDP4
CNSTI4 0
ASGNI4
line 371
;370:	// flag speeding up
;371:	animations[FLAG_STAND2RUN].firstFrame = 16;
ADDRLP4 8
INDIRP4
CNSTI4 1400
ADDP4
CNSTI4 16
ASGNI4
line 372
;372:	animations[FLAG_STAND2RUN].numFrames = 5;
ADDRLP4 8
INDIRP4
CNSTI4 1404
ADDP4
CNSTI4 5
ASGNI4
line 373
;373:	animations[FLAG_STAND2RUN].loopFrames = 1;
ADDRLP4 8
INDIRP4
CNSTI4 1408
ADDP4
CNSTI4 1
ASGNI4
line 374
;374:	animations[FLAG_STAND2RUN].frameLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1412
ADDP4
CNSTI4 66
ASGNI4
line 375
;375:	animations[FLAG_STAND2RUN].initialLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1416
ADDP4
CNSTI4 66
ASGNI4
line 376
;376:	animations[FLAG_STAND2RUN].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 1420
ADDP4
CNSTI4 1
ASGNI4
line 380
;377:	//
;378:	// new anims changes
;379:	//
;380:	animations[TORSO_GETFLAG].flipflop = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 724
ADDP4
CNSTI4 1
ASGNI4
line 381
;381:	animations[TORSO_GUARDBASE].flipflop = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 1
ASGNI4
line 382
;382:	animations[TORSO_PATROL].flipflop = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 780
ADDP4
CNSTI4 1
ASGNI4
line 383
;383:	animations[TORSO_AFFIRMATIVE].flipflop = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 836
ADDP4
CNSTI4 1
ASGNI4
line 384
;384:	animations[TORSO_NEGATIVE].flipflop = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 864
ADDP4
CNSTI4 1
ASGNI4
line 386
;385:	//
;386:	return qtrue;
CNSTI4 1
RETI4
LABELV $102
endproc CG_ParseAnimationFile 20084 12
proc CG_ParseEyesFile 20040 12
line 396
;387:}
;388:
;389:/*
;390:======================
;391:CG_ParseEyesFile
;392:
;393:Read eyes definitions.  Maybe this should be done engine-side for mod compatiblity? :S
;394:======================
;395: */
;396:static qboolean CG_ParseEyesFile(const char *filename, clientInfo_t *ci) {
line 404
;397:	char *text_p;
;398:	int len;
;399:	int i;
;400:	char *token;
;401:	char text[20000];
;402:	fileHandle_t f;
;403:	// load the file
;404:	len = trap_FS_FOpenFile(filename, &f, FS_READ);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20016
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20020
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20020
INDIRI4
ASGNI4
line 405
;405:	if (len <= 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GTI4 $228
line 406
;406:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $227
JUMPV
LABELV $228
line 408
;407:	}
;408:	if (len >= sizeof ( text) - 1) {
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 19999
LTU4 $230
line 409
;409:		CG_Printf("File %s too long\n", filename);
ADDRGP4 $107
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 410
;410:		trap_FS_FCloseFile(f);
ADDRLP4 20016
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 411
;411:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $227
JUMPV
LABELV $230
line 413
;412:	}
;413:	trap_FS_Read(text, len, f);
ADDRLP4 16
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 20016
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 414
;414:	text[len] = 0;
ADDRLP4 12
INDIRI4
ADDRLP4 16
ADDP4
CNSTI1 0
ASGNI1
line 415
;415:	trap_FS_FCloseFile(f);
ADDRLP4 20016
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 418
;416:
;417:	// parse the text
;418:	text_p = text;
ADDRLP4 8
ADDRLP4 16
ASGNP4
ADDRGP4 $233
JUMPV
LABELV $232
line 422
;419:
;420:
;421:	// read optional parameters
;422:	while (1) {
line 423
;423:		token = COM_Parse(&text_p);
ADDRLP4 8
ARGP4
ADDRLP4 20024
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20024
INDIRP4
ASGNP4
line 424
;424:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $235
line 425
;425:			break;
ADDRGP4 $234
JUMPV
LABELV $235
line 429
;426:		}
;427:
;428:
;429:		if (!Q_stricmp(token, "eyes")) { // leilei - EYES
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 20028
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20028
INDIRI4
CNSTI4 0
NEI4 $234
line 430
;430:			for (i = 0; i < 3; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $239
line 431
;431:				token = COM_Parse(&text_p);
ADDRLP4 8
ARGP4
ADDRLP4 20032
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20032
INDIRP4
ASGNP4
line 432
;432:				if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $243
line 433
;433:					break;
ADDRGP4 $233
JUMPV
LABELV $243
line 435
;434:				}
;435:				ci->eyepos[i] = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20036
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 2104
ADDP4
ADDP4
ADDRLP4 20036
INDIRF4
ASGNF4
line 436
;436:			}
LABELV $240
line 430
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $239
line 437
;437:			continue;
line 439
;438:		}
;439:		break;
LABELV $233
line 422
ADDRGP4 $232
JUMPV
LABELV $234
line 442
;440:	}
;441:
;442:	return qtrue;
CNSTI4 1
RETI4
LABELV $227
endproc CG_ParseEyesFile 20040 12
proc CG_FileExists 8 12
line 450
;443:}
;444:
;445:/*
;446:==========================
;447:CG_FileExists
;448:==========================
;449: */
;450:static qboolean CG_FileExists(const char *filename) {
line 453
;451:	int len;
;452:
;453:	len = trap_FS_FOpenFile(filename, NULL, FS_READ);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 454
;454:	if (len > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $246
line 455
;455:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $245
JUMPV
LABELV $246
line 457
;456:	}
;457:	return qfalse;
CNSTI4 0
RETI4
LABELV $245
endproc CG_FileExists 8 12
proc CG_FindClientModelFile 40 40
line 465
;458:}
;459:
;460:/*
;461:==========================
;462:CG_FindClientModelFile
;463:==========================
;464: */
;465:static qboolean CG_FindClientModelFile(char *filename, int length, clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *base, const char *ext) {
line 469
;466:	char *team, *charactersFolder;
;467:	int i;
;468:
;469:	if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $249
line 470
;470:		switch (ci->team) {
ADDRLP4 16
ADDRFP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $255
ADDRGP4 $252
JUMPV
LABELV $255
line 472
;471:			case TEAM_BLUE:
;472:			{
line 473
;473:				team = "blue";
ADDRLP4 8
ADDRGP4 $256
ASGNP4
line 474
;474:				break;
ADDRGP4 $250
JUMPV
LABELV $252
line 477
;475:			}
;476:			default:
;477:			{
line 478
;478:				team = "red";
ADDRLP4 8
ADDRGP4 $257
ASGNP4
line 479
;479:				break;
line 482
;480:			}
;481:		}
;482:	} else {
ADDRGP4 $250
JUMPV
LABELV $249
line 483
;483:		team = "default";
ADDRLP4 8
ADDRGP4 $120
ASGNP4
line 484
;484:	}
LABELV $250
line 485
;485:	charactersFolder = "";
ADDRLP4 4
ADDRGP4 $258
ASGNP4
ADDRGP4 $260
JUMPV
LABELV $259
line 486
;486:	while (1) {
line 487
;487:		for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $262
line 488
;488:			if (i == 0 && teamName && *teamName) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $266
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $266
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 16
INDIRI4
EQI4 $266
line 490
;489:				//								"models/players/characters/sergei/stroggs/lower_lily_red.skin"
;490:				Com_sprintf(filename, length, "models/players/%s%s/%s%s_%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, team, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $268
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 491
;491:			} else {
ADDRGP4 $267
JUMPV
LABELV $266
line 493
;492:				//								"models/players/characters/sergei/lower_lily_red.skin"
;493:				Com_sprintf(filename, length, "models/players/%s%s/%s_%s_%s.%s", charactersFolder, modelName, base, skinName, team, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $269
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 494
;494:			}
LABELV $267
line 495
;495:			if (CG_FileExists(filename)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $270
line 496
;496:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $248
JUMPV
LABELV $270
line 498
;497:			}
;498:			if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $272
line 499
;499:				if (i == 0 && teamName && *teamName) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $275
ADDRLP4 36
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $275
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 32
INDIRI4
EQI4 $275
line 501
;500:					//								"models/players/characters/sergei/stroggs/lower_red.skin"
;501:					Com_sprintf(filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, team, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $277
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 502
;502:				} else {
ADDRGP4 $273
JUMPV
LABELV $275
line 504
;503:					//								"models/players/characters/sergei/lower_red.skin"
;504:					Com_sprintf(filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, team, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $278
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 505
;505:				}
line 506
;506:			} else {
ADDRGP4 $273
JUMPV
LABELV $272
line 507
;507:				if (i == 0 && teamName && *teamName) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $279
ADDRLP4 36
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $279
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 32
INDIRI4
EQI4 $279
line 509
;508:					//								"models/players/characters/sergei/stroggs/lower_lily.skin"
;509:					Com_sprintf(filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $277
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 510
;510:				} else {
ADDRGP4 $280
JUMPV
LABELV $279
line 512
;511:					//								"models/players/characters/sergei/lower_lily.skin"
;512:					Com_sprintf(filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, skinName, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $278
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 513
;513:				}
LABELV $280
line 514
;514:			}
LABELV $273
line 515
;515:			if (CG_FileExists(filename)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $281
line 516
;516:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $248
JUMPV
LABELV $281
line 518
;517:			}
;518:			if (!teamName || !*teamName) {
ADDRLP4 36
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $285
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $283
LABELV $285
line 519
;519:				break;
ADDRGP4 $264
JUMPV
LABELV $283
line 521
;520:			}
;521:		}
LABELV $263
line 487
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $262
LABELV $264
line 523
;522:		// if tried the heads folder first
;523:		if (charactersFolder[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $286
line 524
;524:			break;
ADDRGP4 $261
JUMPV
LABELV $286
line 526
;525:		}
;526:		charactersFolder = "characters/";
ADDRLP4 4
ADDRGP4 $288
ASGNP4
line 527
;527:	}
LABELV $260
line 486
ADDRGP4 $259
JUMPV
LABELV $261
line 529
;528:
;529:	return qfalse;
CNSTI4 0
RETI4
LABELV $248
endproc CG_FindClientModelFile 40 40
proc CG_FindClientHeadFile 40 40
line 537
;530:}
;531:
;532:/*
;533:==========================
;534:CG_FindClientHeadFile
;535:==========================
;536: */
;537:static qboolean CG_FindClientHeadFile(char *filename, int length, clientInfo_t *ci, const char *teamName, const char *headModelName, const char *headSkinName, const char *base, const char *ext) {
line 541
;538:	char *team, *headsFolder;
;539:	int i;
;540:
;541:	if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $290
line 542
;542:		switch (ci->team) {
ADDRLP4 16
ADDRFP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $296
ADDRGP4 $293
JUMPV
LABELV $296
line 544
;543:			case TEAM_BLUE:
;544:			{
line 545
;545:				team = "blue";
ADDRLP4 8
ADDRGP4 $256
ASGNP4
line 546
;546:				break;
ADDRGP4 $291
JUMPV
LABELV $293
line 549
;547:			}
;548:			default:
;549:			{
line 550
;550:				team = "red";
ADDRLP4 8
ADDRGP4 $257
ASGNP4
line 551
;551:				break;
line 554
;552:			}
;553:		}
;554:	} else {
ADDRGP4 $291
JUMPV
LABELV $290
line 555
;555:		team = "default";
ADDRLP4 8
ADDRGP4 $120
ASGNP4
line 556
;556:	}
LABELV $291
line 558
;557:
;558:	if (headModelName[0] == '*') {
ADDRFP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $297
line 559
;559:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $299
ASGNP4
line 560
;560:		headModelName++;
ADDRFP4 16
ADDRFP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 561
;561:	} else {
ADDRGP4 $301
JUMPV
LABELV $297
line 562
;562:		headsFolder = "";
ADDRLP4 4
ADDRGP4 $258
ASGNP4
line 563
;563:	}
ADDRGP4 $301
JUMPV
LABELV $300
line 564
;564:	while (1) {
line 565
;565:		for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $303
line 566
;566:			if (i == 0 && teamName && *teamName) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $307
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $307
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 16
INDIRI4
EQI4 $307
line 567
;567:				Com_sprintf(filename, length, "models/players/%s%s/%s/%s%s_%s.%s", headsFolder, headModelName, headSkinName, teamName, base, team, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $309
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 568
;568:			} else {
ADDRGP4 $308
JUMPV
LABELV $307
line 569
;569:				Com_sprintf(filename, length, "models/players/%s%s/%s/%s_%s.%s", headsFolder, headModelName, headSkinName, base, team, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $310
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 570
;570:			}
LABELV $308
line 571
;571:			if (CG_FileExists(filename)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $311
line 572
;572:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $289
JUMPV
LABELV $311
line 574
;573:			}
;574:			if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $313
line 575
;575:				if (i == 0 && teamName && *teamName) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $316
ADDRLP4 36
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $316
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 32
INDIRI4
EQI4 $316
line 576
;576:					Com_sprintf(filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, team, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $277
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 577
;577:				} else {
ADDRGP4 $314
JUMPV
LABELV $316
line 578
;578:					Com_sprintf(filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, team, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $278
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 579
;579:				}
line 580
;580:			} else {
ADDRGP4 $314
JUMPV
LABELV $313
line 581
;581:				if (i == 0 && teamName && *teamName) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $318
ADDRLP4 36
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $318
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 32
INDIRI4
EQI4 $318
line 582
;582:					Com_sprintf(filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, headSkinName, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $277
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 583
;583:				} else {
ADDRGP4 $319
JUMPV
LABELV $318
line 584
;584:					Com_sprintf(filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, headSkinName, ext);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $278
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 585
;585:				}
LABELV $319
line 586
;586:			}
LABELV $314
line 587
;587:			if (CG_FileExists(filename)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $320
line 588
;588:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $289
JUMPV
LABELV $320
line 590
;589:			}
;590:			if (!teamName || !*teamName) {
ADDRLP4 36
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $324
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $322
LABELV $324
line 591
;591:				break;
ADDRGP4 $305
JUMPV
LABELV $322
line 593
;592:			}
;593:		}
LABELV $304
line 565
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $303
LABELV $305
line 595
;594:		// if tried the heads folder first
;595:		if (headsFolder[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $325
line 596
;596:			break;
ADDRGP4 $302
JUMPV
LABELV $325
line 598
;597:		}
;598:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $299
ASGNP4
line 599
;599:	}
LABELV $301
line 564
ADDRGP4 $300
JUMPV
LABELV $302
line 601
;600:
;601:	return qfalse;
CNSTI4 0
RETI4
LABELV $289
endproc CG_FindClientHeadFile 40 40
proc CG_RegisterClientSkin 80 32
line 609
;602:}
;603:
;604:/*
;605:==========================
;606:CG_RegisterClientSkin
;607:==========================
;608: */
;609:static qboolean CG_RegisterClientSkin(clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName) {
line 612
;610:	char filename[MAX_QPATH];
;611:
;612:	if (ci->onepiece) {
ADDRFP4 0
INDIRP4
CNSTI4 2116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $328
line 613
;613:		Com_sprintf(filename, sizeof ( filename), "models/playerfs/%s/%stris_%s.skin", modelName, teamName, skinName);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $330
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 614
;614:		ci->legsSkin = trap_R_RegisterSkin(filename);
ADDRLP4 0
ARGP4
ADDRLP4 64
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 615
;615:		if (!ci->legsSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $329
line 616
;616:			Com_Printf("Onepieced model skin load failure: %s\n", filename);
ADDRGP4 $333
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 617
;617:		}
line 618
;618:	} else {
ADDRGP4 $329
JUMPV
LABELV $328
line 619
;619:		if (CG_FindClientModelFile(filename, sizeof (filename), ci, teamName, modelName, skinName, "lower", "skin")) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 $337
ARGP4
ADDRLP4 64
ADDRGP4 CG_FindClientModelFile
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $334
line 620
;620:			ci->legsSkin = trap_R_RegisterSkin(filename);
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 621
;621:		}
LABELV $334
line 622
;622:		if (!ci->legsSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $338
line 623
;623:			Com_Printf("Leg skin load failure: %s\n", filename);
ADDRGP4 $340
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 624
;624:		}
LABELV $338
line 625
;625:	}
LABELV $329
line 627
;626:
;627:	if (CG_FindClientModelFile(filename, sizeof (filename), ci, teamName, modelName, skinName, "upper", "skin")) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 $343
ARGP4
ADDRGP4 $337
ARGP4
ADDRLP4 64
ADDRGP4 CG_FindClientModelFile
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $341
line 628
;628:		ci->torsoSkin = trap_R_RegisterSkin(filename);
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 629
;629:	}
LABELV $341
line 630
;630:	if (!ci->torsoSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 0
NEI4 $344
line 631
;631:		Com_Printf("Torso skin load failure: %s\n", filename);
ADDRGP4 $346
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 632
;632:	}
LABELV $344
line 634
;633:
;634:	if (CG_FindClientHeadFile(filename, sizeof (filename), ci, teamName, headModelName, headSkinName, "head", "skin")) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 $349
ARGP4
ADDRGP4 $337
ARGP4
ADDRLP4 68
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $347
line 635
;635:		ci->headSkin = trap_R_RegisterSkin(filename);
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 636
;636:	}
LABELV $347
line 637
;637:	if (!ci->headSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 0
NEI4 $350
line 638
;638:		Com_Printf("Head skin load failure: %s\n", filename);
ADDRGP4 $352
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 639
;639:	}
LABELV $350
line 642
;640:
;641:	// if any skins failed to load
;642:	if (!ci->legsSkin || !ci->torsoSkin || !ci->headSkin) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $356
ADDRLP4 72
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $356
ADDRLP4 72
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
NEI4 $353
LABELV $356
line 643
;643:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $327
JUMPV
LABELV $353
line 645
;644:	}
;645:	return qtrue;
CNSTI4 1
RETI4
LABELV $327
endproc CG_RegisterClientSkin 80 32
proc CG_RegisterClientModelname 288 32
line 653
;646:}
;647:
;648:/*
;649:==========================
;650:CG_RegisterClientModelname
;651:==========================
;652: */
;653:static qboolean CG_RegisterClientModelname(clientInfo_t *ci, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName, const char *teamName) {
line 657
;654:	char filename[MAX_QPATH * 2];
;655:	const char *headName;
;656:	char newTeamName[MAX_QPATH * 2];
;657:	int FSloaded = 0;
ADDRLP4 132
CNSTI4 0
ASGNI4
line 659
;658:
;659:	if (headModelName[0] == '\0') {
ADDRFP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $358
line 660
;660:		headName = modelName;
ADDRLP4 128
ADDRFP4 4
INDIRP4
ASGNP4
line 661
;661:	} else {
ADDRGP4 $359
JUMPV
LABELV $358
line 662
;662:		headName = headModelName;
ADDRLP4 128
ADDRFP4 12
INDIRP4
ASGNP4
line 663
;663:	}
LABELV $359
line 666
;664:
;665:	// leilei - onepiece model loading for certain maps or WIP animation debug
;666:	ci->onepiece = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2116
ADDP4
CNSTI4 0
ASGNI4
line 667
;667:	if (cg_enableFS.integer) {
ADDRGP4 cg_enableFS+12
INDIRI4
CNSTI4 0
EQI4 $360
line 668
;668:		Com_sprintf(filename, sizeof ( filename), "models/playerfs/%s/tris.mdr", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $363
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 669
;669:		ci->legsModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 670
;670:		if (ci->legsModel) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
CNSTI4 0
EQI4 $364
line 671
;671:			FSloaded = 1;
ADDRLP4 132
CNSTI4 1
ASGNI4
line 672
;672:			ci->onepiece = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2116
ADDP4
CNSTI4 1
ASGNI4
line 673
;673:		}
LABELV $364
line 674
;674:		if (!ci->legsModel)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
CNSTI4 0
NEI4 $366
line 675
;675:			FSloaded = 0; // just end it
ADDRLP4 132
CNSTI4 0
ASGNI4
LABELV $366
line 677
;676:
;677:		if (FSloaded) {
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $368
line 678
;678:			Com_Printf("%s is fanservice\n", filename);
ADDRGP4 $370
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 679
;679:		} else {
ADDRGP4 $369
JUMPV
LABELV $368
line 680
;680:			Com_Printf("%s can't provide fanservice\n", filename);
ADDRGP4 $371
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 681
;681:		}
LABELV $369
line 682
;682:	}
LABELV $360
line 685
;683:
;684:	// load the usual model
;685:	if (FSloaded == 0) {
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $372
line 686
;686:		Com_sprintf(filename, sizeof ( filename), "models/players/%s/lower.mdr", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $374
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 687
;687:		ci->legsModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 688
;688:		if (!ci->legsModel) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
CNSTI4 0
NEI4 $375
line 689
;689:			Com_sprintf(filename, sizeof ( filename), "models/players/characters/%s/lower.mdr", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $377
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 690
;690:			ci->legsModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 691
;691:			if (!ci->legsModel) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
CNSTI4 0
NEI4 $378
line 692
;692:				Com_sprintf(filename, sizeof ( filename), "models/players/%s/lower.md3", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $380
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 693
;693:				ci->legsModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 694
;694:				if (!ci->legsModel) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
CNSTI4 0
NEI4 $381
line 695
;695:					Com_sprintf(filename, sizeof ( filename), "models/players/characters/%s/lower.md3", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $383
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 696
;696:					ci->legsModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 276
INDIRI4
ASGNI4
line 697
;697:					if (!ci->legsModel) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
CNSTI4 0
NEI4 $384
line 698
;698:						Com_Printf("Failed to load model file %s\n", filename);
ADDRGP4 $386
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 699
;699:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $357
JUMPV
LABELV $384
line 701
;700:					}
;701:				}
LABELV $381
line 702
;702:			}
LABELV $378
line 703
;703:		}
LABELV $375
line 705
;704:
;705:		Com_sprintf(filename, sizeof ( filename), "models/players/%s/upper.mdr", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $387
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 706
;706:		ci->torsoModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 707
;707:		if (!ci->torsoModel) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $388
line 708
;708:			Com_sprintf(filename, sizeof ( filename), "models/players/characters/%s/upper.mdr", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $390
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 709
;709:			ci->torsoModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 710
;710:			if (!ci->torsoModel) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $391
line 711
;711:				Com_sprintf(filename, sizeof ( filename), "models/players/%s/upper.md3", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $393
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 712
;712:				ci->torsoModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 276
INDIRI4
ASGNI4
line 713
;713:				if (!ci->torsoModel) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $394
line 714
;714:					Com_sprintf(filename, sizeof ( filename), "models/players/characters/%s/upper.md3", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $396
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 715
;715:					ci->torsoModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 280
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 280
INDIRI4
ASGNI4
line 716
;716:					if (!ci->torsoModel) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
NEI4 $397
line 717
;717:						Com_Printf("Failed to load model file %s\n", filename);
ADDRGP4 $386
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 718
;718:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $357
JUMPV
LABELV $397
line 720
;719:					}
;720:				}
LABELV $394
line 721
;721:			}
LABELV $391
line 722
;722:		}
LABELV $388
line 724
;723:
;724:	} // enableFS
LABELV $372
line 726
;725:
;726:	if (headName[0] == '*') {
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $399
line 727
;727:		Com_sprintf(filename, sizeof ( filename), "models/players/heads/%s/%s.mdr", &headModelName[1], &headModelName[1]);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $401
ARGP4
ADDRLP4 264
ADDRFP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 264
INDIRP4
ARGP4
ADDRLP4 264
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 728
;728:	} else {
ADDRGP4 $400
JUMPV
LABELV $399
line 729
;729:		Com_sprintf(filename, sizeof ( filename), "models/players/%s/head.mdr", headName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $402
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 730
;730:	}
LABELV $400
line 731
;731:	ci->headModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 733
;732:	// if the head model could not be found and we didn't load from the heads folder try to load from there
;733:	if (!ci->headModel && headName[0] != '*') {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
NEI4 $403
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $403
line 734
;734:		Com_sprintf(filename, sizeof ( filename), "models/players/heads/%s/%s.mdr", headModelName, headModelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $401
ARGP4
ADDRLP4 268
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 268
INDIRP4
ARGP4
ADDRLP4 268
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 735
;735:		ci->headModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 736
;736:	}
LABELV $403
line 737
;737:	if (!ci->headModel) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
NEI4 $405
line 738
;738:		if (headName[0] == '*') {
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $407
line 739
;739:			Com_sprintf(filename, sizeof ( filename), "models/players/heads/%s/%s.md3", &headModelName[1], &headModelName[1]);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $409
ARGP4
ADDRLP4 268
ADDRFP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ARGP4
ADDRLP4 268
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 740
;740:		} else {
ADDRGP4 $408
JUMPV
LABELV $407
line 741
;741:			Com_sprintf(filename, sizeof ( filename), "models/players/%s/head.md3", headName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $410
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 742
;742:		}
LABELV $408
line 743
;743:		ci->headModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 745
;744:		// if the head model could not be found and we didn't load from the heads folder try to load from there
;745:		if (!ci->headModel && headName[0] != '*') {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
NEI4 $411
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $411
line 746
;746:			Com_sprintf(filename, sizeof ( filename), "models/players/heads/%s/%s.md3", headModelName, headModelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $409
ARGP4
ADDRLP4 272
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 747
;747:			ci->headModel = trap_R_RegisterModel(filename);
ADDRLP4 0
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 276
INDIRI4
ASGNI4
line 748
;748:		}
LABELV $411
line 749
;749:		if (!ci->headModel) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
NEI4 $413
line 750
;750:			Com_Printf("Failed to load model file %s\n", filename);
ADDRGP4 $386
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 751
;751:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $357
JUMPV
LABELV $413
line 753
;752:		}
;753:	}
LABELV $405
line 756
;754:
;755:	// if any skins failed to load, return failure
;756:	if (!CG_RegisterClientSkin(ci, teamName, modelName, skinName, headName, headSkinName)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 CG_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
NEI4 $415
line 757
;757:		if (teamName && *teamName) {
ADDRLP4 272
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $417
ADDRLP4 272
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $417
line 758
;758:			Com_Printf("Failed to load skin file: %s : %s : %s, %s : %s\n", teamName, modelName, skinName, headName, headSkinName);
ADDRGP4 $419
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 759
;759:			if (ci->team == TEAM_BLUE) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $420
line 760
;760:				Com_sprintf(newTeamName, sizeof (newTeamName), "%s/", DEFAULT_BLUETEAM_NAME);
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $422
ARGP4
ADDRGP4 $423
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 761
;761:			} else {
ADDRGP4 $421
JUMPV
LABELV $420
line 762
;762:				Com_sprintf(newTeamName, sizeof (newTeamName), "%s/", DEFAULT_REDTEAM_NAME);
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $422
ARGP4
ADDRGP4 $424
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 763
;763:			}
LABELV $421
line 764
;764:			if (!CG_RegisterClientSkin(ci, newTeamName, modelName, skinName, headName, headSkinName)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 CG_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
NEI4 $418
line 765
;765:				Com_Printf("Failed to load skin file: %s : %s : %s, %s : %s\n", newTeamName, modelName, skinName, headName, headSkinName);
ADDRGP4 $419
ARGP4
ADDRLP4 136
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 766
;766:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $357
JUMPV
line 768
;767:			}
;768:		} else {
LABELV $417
line 769
;769:			Com_Printf("Failed to load skin file: %s : %s, %s : %s\n", modelName, skinName, headName, headSkinName);
ADDRGP4 $427
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 770
;770:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $357
JUMPV
LABELV $418
line 772
;771:		}
;772:	}
LABELV $415
line 776
;773:
;774:	// load the animations
;775:	// leilei - load one piece animation
;776:	if (ci->onepiece) {
ADDRFP4 0
INDIRP4
CNSTI4 2116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $428
line 777
;777:		Com_sprintf(filename, sizeof ( filename), "models/playerfs/%s/animation.cfg", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $430
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 778
;778:		if (!CG_ParseAnimationFile(filename, ci)) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $429
line 779
;779:			Com_Printf("Failed to load animation file %s\n", filename);
ADDRGP4 $433
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 780
;780:		}
line 781
;781:	} else {
ADDRGP4 $429
JUMPV
LABELV $428
line 782
;782:		Com_sprintf(filename, sizeof ( filename), "models/players/%s/animation.cfg", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $434
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 783
;783:		if (!CG_ParseAnimationFile(filename, ci)) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $435
line 784
;784:			Com_sprintf(filename, sizeof ( filename), "models/players/characters/%s/animation.cfg", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $437
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 785
;785:			if (!CG_ParseAnimationFile(filename, ci)) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
NEI4 $438
line 786
;786:				Com_Printf("Failed to load animation file %s\n", filename);
ADDRGP4 $433
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 787
;787:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $357
JUMPV
LABELV $438
line 789
;788:			}
;789:		}
LABELV $435
line 790
;790:	}
LABELV $429
line 796
;791:
;792:
;793:
;794:
;795:	// leilei - load eyes
;796:	Com_sprintf(filename, sizeof ( filename), "models/players/%s/eyes.cfg", modelName);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $440
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 797
;797:	if (!CG_ParseEyesFile(filename, ci)) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 CG_ParseEyesFile
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $441
line 799
;798:		//	Com_Printf( "No eyes for %s\n", filename );
;799:	}
LABELV $441
line 803
;800:
;801:
;802:
;803:	if (CG_FindClientHeadFile(filename, sizeof (filename), ci, teamName, headName, headSkinName, "icon", "skin")) {
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $445
ARGP4
ADDRGP4 $337
ARGP4
ADDRLP4 276
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
EQI4 $443
line 804
;804:		ci->modelIcon = trap_R_RegisterShaderNoMip(filename);
ADDRLP4 0
ARGP4
ADDRLP4 280
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ADDRLP4 280
INDIRI4
ASGNI4
line 805
;805:	} else if (CG_FindClientHeadFile(filename, sizeof (filename), ci, teamName, headName, headSkinName, "icon", "tga")) {
ADDRGP4 $444
JUMPV
LABELV $443
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $445
ARGP4
ADDRGP4 $448
ARGP4
ADDRLP4 280
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $446
line 806
;806:		ci->modelIcon = trap_R_RegisterShaderNoMip(filename);
ADDRLP4 0
ARGP4
ADDRLP4 284
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
ADDRLP4 284
INDIRI4
ASGNI4
line 807
;807:	}
LABELV $446
LABELV $444
line 809
;808:
;809:	if (!ci->modelIcon) {
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 0
NEI4 $449
line 810
;810:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $357
JUMPV
LABELV $449
line 813
;811:	}
;812:
;813:	return qtrue;
CNSTI4 1
RETI4
LABELV $357
endproc CG_RegisterClientModelname 288 32
proc CG_ColorFromString 20 4
line 821
;814:}
;815:
;816:/*
;817:====================
;818:CG_ColorFromString
;819:====================
;820: */
;821:static void CG_ColorFromString(const char *v, vec3_t color) {
line 824
;822:	int val;
;823:
;824:	VectorClear(color);
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRF4
ASGNF4
line 826
;825:
;826:	val = atoi(v);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 828
;827:
;828:	if (val < 1 || val > 7) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $454
ADDRLP4 0
INDIRI4
CNSTI4 7
LEI4 $452
LABELV $454
line 829
;829:		VectorSet(color, 1, 1, 1);
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 830
;830:		return;
ADDRGP4 $451
JUMPV
LABELV $452
line 833
;831:	}
;832:
;833:	if (val & 1) {
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $455
line 834
;834:		color[2] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 835
;835:	}
LABELV $455
line 836
;836:	if (val & 2) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $457
line 837
;837:		color[1] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 838
;838:	}
LABELV $457
line 839
;839:	if (val & 4) {
ADDRLP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $459
line 840
;840:		color[0] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
line 841
;841:	}
LABELV $459
line 842
;842:}
LABELV $451
endproc CG_ColorFromString 20 4
proc CG_LoadClientInfo 148 24
line 852
;843:
;844:/*
;845:===================
;846:CG_LoadClientInfo
;847:
;848:Load it now, taking the disk hits.
;849:This will usually be deferred to a safe time
;850:===================
;851: */
;852:static void CG_LoadClientInfo(int clientNum, clientInfo_t *ci) {
line 858
;853:	const char *dir, *fallback;
;854:	int i, modelloaded;
;855:	const char *s;
;856:	char teamname[MAX_QPATH];
;857:
;858:	teamname[0] = 0;
ADDRLP4 20
CNSTI1 0
ASGNI1
line 871
;859:#ifdef MISSIONPACK
;860:	if (CG_IsATeamGametype(cgs.gametype)) {
;861:		if (ci->team == TEAM_BLUE) {
;862:			Q_strncpyz(teamname, cg_blueTeamName.string, sizeof (teamname));
;863:		} else {
;864:			Q_strncpyz(teamname, cg_redTeamName.string, sizeof (teamname));
;865:		}
;866:	}
;867:	if (teamname[0]) {
;868:		strcat(teamname, "/");
;869:	}
;870:#endif
;871:	modelloaded = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 872
;872:	if (!CG_RegisterClientModelname(ci, ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname)) {
ADDRLP4 84
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 288
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 352
ADDP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 88
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $462
line 873
;873:		if (cg_buildScript.integer) {
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $464
line 874
;874:			CG_Error("CG_RegisterClientModelname( %s, %s, %s, %s %s ) failed", ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname);
ADDRGP4 $467
ARGP4
ADDRLP4 92
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 288
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 352
ADDP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 875
;875:		}
LABELV $464
line 878
;876:
;877:		// fall back to default team name
;878:		if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $468
line 880
;879:			// keep skin name
;880:			if (ci->team == TEAM_BLUE) {
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $471
line 881
;881:				Q_strncpyz(teamname, DEFAULT_BLUETEAM_NAME, sizeof (teamname));
ADDRLP4 20
ARGP4
ADDRGP4 $423
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 882
;882:			} else {
ADDRGP4 $472
JUMPV
LABELV $471
line 883
;883:				Q_strncpyz(teamname, DEFAULT_REDTEAM_NAME, sizeof (teamname));
ADDRLP4 20
ARGP4
ADDRGP4 $424
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 884
;884:			}
LABELV $472
line 886
;885:			/* Neon_Knight: Missionpack checks, if != 0, enables this. */
;886:			if (cg_missionpackChecks.integer != 0) {
ADDRGP4 cg_missionpackChecks+12
INDIRI4
CNSTI4 0
EQI4 $469
line 887
;887:				if (!CG_RegisterClientModelname(ci, DEFAULT_TEAM_MODEL, ci->skinName, DEFAULT_TEAM_HEAD, ci->skinName, teamname)) {
ADDRLP4 96
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 $478
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 104
ADDRLP4 96
INDIRP4
CNSTI4 224
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 108
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $469
line 888
;888:					CG_Error("DEFAULT_TEAM_MODEL / skin (%s/%s) failed to register", DEFAULT_TEAM_MODEL, ci->skinName);
ADDRGP4 $479
ARGP4
ADDRGP4 $478
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 889
;889:				}
line 890
;890:			}
line 892
;891:			/* /Neon_Knight */
;892:		} else {
ADDRGP4 $469
JUMPV
LABELV $468
line 893
;893:			if (!CG_RegisterClientModelname(ci, DEFAULT_MODEL, "default", DEFAULT_MODEL, "default", teamname)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 $478
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 $120
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 104
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $480
line 894
;894:				CG_Error("DEFAULT_MODEL (%s) failed to register", DEFAULT_MODEL);
ADDRGP4 $482
ARGP4
ADDRGP4 $478
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 895
;895:			}
LABELV $480
line 896
;896:		}
LABELV $469
line 897
;897:		modelloaded = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 898
;898:	}
LABELV $462
line 900
;899:
;900:	ci->newAnims = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 484
ADDP4
CNSTI4 0
ASGNI4
line 901
;901:	if (ci->torsoModel) {
ADDRFP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $483
line 904
;902:		orientation_t tag;
;903:		// if the torso model has the "tag_flag"
;904:		if (trap_R_LerpTag(&tag, ci->torsoModel, 0, 0, 1, "tag_flag")) {
ADDRLP4 92
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 140
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 $487
ARGP4
ADDRLP4 144
ADDRGP4 trap_R_LerpTag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $485
line 905
;905:			ci->newAnims = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 484
ADDP4
CNSTI4 1
ASGNI4
line 906
;906:		}
LABELV $485
line 907
;907:	}
LABELV $483
line 910
;908:
;909:	// sounds
;910:	dir = ci->modelName;
ADDRLP4 12
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
line 911
;911:	fallback = (CG_IsATeamGametype(cgs.gametype)) ? DEFAULT_TEAM_MODEL : DEFAULT_MODEL;
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $490
ADDRLP4 92
ADDRGP4 $478
ASGNP4
ADDRGP4 $491
JUMPV
LABELV $490
ADDRLP4 92
ADDRGP4 $478
ASGNP4
LABELV $491
ADDRLP4 16
ADDRLP4 92
INDIRP4
ASGNP4
line 913
;912:
;913:	for (i = 0; i < MAX_CUSTOM_SOUNDS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $492
line 914
;914:		s = cg_customSoundNames[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ASGNP4
line 915
;915:		if (!s) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $496
line 916
;916:			break;
ADDRGP4 $494
JUMPV
LABELV $496
line 918
;917:		}
;918:		ci->sounds[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 1972
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 920
;919:		// if the model didn't load use the sounds of the default model
;920:		if (modelloaded) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $498
line 921
;921:			ci->sounds[i] = trap_S_RegisterSound(va("sound/player/%s/%s", dir, s + 1), qfalse);
ADDRGP4 $500
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 104
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 1972
ADDP4
ADDP4
ADDRLP4 104
INDIRI4
ASGNI4
line 922
;922:		}
LABELV $498
line 924
;923:		/* Neon_Knight: Missionpack checks, if != 0, enables this. */
;924:		if (cg_missionpackChecks.integer) {
ADDRGP4 cg_missionpackChecks+12
INDIRI4
CNSTI4 0
EQI4 $501
line 925
;925:			if (!ci->sounds[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 1972
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $504
line 926
;926:				ci->sounds[i] = trap_S_RegisterSound(va("sound/player/%s/%s", fallback, s + 1), qfalse);
ADDRGP4 $500
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 104
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 1972
ADDP4
ADDP4
ADDRLP4 104
INDIRI4
ASGNI4
line 927
;927:			}
LABELV $504
line 928
;928:		}
LABELV $501
line 930
;929:		/* /Neon_Knight */
;930:	}
LABELV $493
line 913
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $492
LABELV $494
line 932
;931:
;932:	ci->deferred = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 480
ADDP4
CNSTI4 0
ASGNI4
line 936
;933:
;934:	// reset any existing players and bodies, because they might be in bad
;935:	// frames for this new model
;936:	for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $506
line 937
;937:		if (cg_entities[i].currentState.clientNum == clientNum
ADDRLP4 100
CNSTI4 936
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 100
INDIRI4
ADDRGP4 cg_entities+168
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $510
ADDRLP4 100
INDIRI4
ADDRGP4 cg_entities+4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $510
line 938
;938:				&& cg_entities[i].currentState.eType == ET_PLAYER) {
line 939
;939:			CG_ResetPlayerEntity(&cg_entities[i]);
CNSTI4 936
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 940
;940:		}
LABELV $510
line 941
;941:	}
LABELV $507
line 936
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $506
line 942
;942:}
LABELV $461
endproc CG_LoadClientInfo 148 24
proc CG_CopyClientInfoModel 56 12
line 949
;943:
;944:/*
;945:======================
;946:CG_CopyClientInfoModel
;947:======================
;948: */
;949:static void CG_CopyClientInfoModel(clientInfo_t *from, clientInfo_t *to) {
line 950
;950:	VectorCopy(from->headOffset, to->headOffset);
ADDRLP4 0
CNSTI4 496
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 951
;951:	VectorCopy(from->eyepos, to->eyepos);
ADDRLP4 4
CNSTI4 2104
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 952
;952:	to->footsteps = from->footsteps;
ADDRLP4 8
CNSTI4 508
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 953
;953:	to->gender = from->gender;
ADDRLP4 12
CNSTI4 512
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 955
;954:
;955:	to->legsModel = from->legsModel;
ADDRLP4 16
CNSTI4 516
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 956
;956:	to->legsSkin = from->legsSkin;
ADDRLP4 20
CNSTI4 520
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 957
;957:	to->torsoModel = from->torsoModel;
ADDRLP4 24
CNSTI4 524
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 958
;958:	to->torsoSkin = from->torsoSkin;
ADDRLP4 28
CNSTI4 528
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 959
;959:	to->headModel = from->headModel;
ADDRLP4 32
CNSTI4 532
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 960
;960:	to->headSkin = from->headSkin;
ADDRLP4 36
CNSTI4 536
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 961
;961:	to->modelIcon = from->modelIcon;
ADDRLP4 40
CNSTI4 540
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 963
;962:
;963:	to->newAnims = from->newAnims;
ADDRLP4 44
CNSTI4 484
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 965
;964:
;965:	memcpy(to->animations, from->animations, sizeof ( to->animations));
ADDRLP4 48
CNSTI4 544
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ARGP4
CNSTI4 1428
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 966
;966:	memcpy(to->sounds, from->sounds, sizeof ( to->sounds));
ADDRLP4 52
CNSTI4 1972
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 967
;967:}
LABELV $514
endproc CG_CopyClientInfoModel 56 12
proc CG_ScanForExistingClientInfo 64 8
line 974
;968:
;969:/*
;970:======================
;971:CG_ScanForExistingClientInfo
;972:======================
;973: */
;974:static qboolean CG_ScanForExistingClientInfo(clientInfo_t *ci) {
line 978
;975:	int i;
;976:	clientInfo_t *match;
;977:
;978:	for (i = 0; i < cgs.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $519
JUMPV
LABELV $516
line 979
;979:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 2120
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 980
;980:		if (!match->infoValid) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $522
line 981
;981:			continue;
ADDRGP4 $517
JUMPV
LABELV $522
line 983
;982:		}
;983:		if (match->deferred) {
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
CNSTI4 0
EQI4 $524
line 984
;984:			continue;
ADDRGP4 $517
JUMPV
LABELV $524
line 986
;985:		}
;986:		if (Q_strequal(ci->modelName, match->modelName)
ADDRLP4 8
CNSTI4 160
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $526
ADDRLP4 16
CNSTI4 224
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $526
ADDRLP4 24
CNSTI4 288
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $526
ADDRLP4 32
CNSTI4 352
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $526
ADDRLP4 40
CNSTI4 448
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $526
ADDRLP4 48
CNSTI4 416
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $526
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $529
ADDRLP4 60
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
NEI4 $526
LABELV $529
line 992
;987:				&& Q_strequal(ci->skinName, match->skinName)
;988:				&& Q_strequal(ci->headModelName, match->headModelName)
;989:				&& Q_strequal(ci->headSkinName, match->headSkinName)
;990:				&& Q_strequal(ci->blueTeam, match->blueTeam)
;991:				&& Q_strequal(ci->redTeam, match->redTeam)
;992:				&& (!CG_IsATeamGametype(cgs.gametype) || ci->team == match->team)) {
line 995
;993:			// this clientinfo is identical, so use it's handles
;994:
;995:			ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
CNSTI4 0
ASGNI4
line 997
;996:
;997:			CG_CopyClientInfoModel(match, ci);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 999
;998:
;999:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $515
JUMPV
LABELV $526
line 1001
;1000:		}
;1001:	}
LABELV $517
line 978
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $519
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31488
INDIRI4
LTI4 $516
line 1004
;1002:
;1003:	// nothing matches, so defer the load
;1004:	return qfalse;
CNSTI4 0
RETI4
LABELV $515
endproc CG_ScanForExistingClientInfo 64 8
proc CG_SetDeferredClientInfo 40 8
line 1015
;1005:}
;1006:
;1007:/*
;1008:======================
;1009:CG_SetDeferredClientInfo
;1010:
;1011:We aren't going to load it now, so grab some other
;1012:client's info to use until we have some spare time.
;1013:======================
;1014: */
;1015:static void CG_SetDeferredClientInfo(int clientNum, clientInfo_t *ci) {
line 1021
;1016:	int i;
;1017:	clientInfo_t *match;
;1018:
;1019:	// if someone else is already the same models and skins we
;1020:	// can just load the client info
;1021:	for (i = 0; i < cgs.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $534
JUMPV
LABELV $531
line 1022
;1022:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 2120
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 1023
;1023:		if (!match->infoValid || match->deferred) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $539
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $537
LABELV $539
line 1024
;1024:			continue;
ADDRGP4 $532
JUMPV
LABELV $537
line 1026
;1025:		}
;1026:		if (!Q_strequal(ci->skinName, match->skinName) ||
ADDRLP4 16
CNSTI4 224
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $544
ADDRLP4 24
CNSTI4 160
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $544
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $540
ADDRLP4 36
CNSTI4 68
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
EQI4 $540
LABELV $544
line 1028
;1027:				!Q_strequal(ci->modelName, match->modelName) ||
;1028:				(CG_IsATeamGametype(cgs.gametype) && ci->team != match->team)) {
line 1029
;1029:			continue;
ADDRGP4 $532
JUMPV
LABELV $540
line 1032
;1030:		}
;1031:		// just load the real info cause it uses the same models and skins
;1032:		CG_LoadClientInfo(clientNum, ci);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1033
;1033:		return;
ADDRGP4 $530
JUMPV
LABELV $532
line 1021
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $534
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31488
INDIRI4
LTI4 $531
line 1037
;1034:	}
;1035:
;1036:	// if we are in teamplay, only grab a model if the skin is correct
;1037:	if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $545
line 1038
;1038:		for (i = 0; i < cgs.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $551
JUMPV
LABELV $548
line 1039
;1039:			match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 2120
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 1040
;1040:			if (!match->infoValid || match->deferred) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $556
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $554
LABELV $556
line 1041
;1041:				continue;
ADDRGP4 $549
JUMPV
LABELV $554
line 1043
;1042:			}
;1043:			if (!Q_strequal(ci->skinName, match->skinName) ||
ADDRLP4 20
CNSTI4 224
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $560
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $557
ADDRLP4 32
CNSTI4 68
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $557
LABELV $560
line 1044
;1044:					(CG_IsATeamGametype(cgs.gametype) && ci->team != match->team)) {
line 1045
;1045:				continue;
ADDRGP4 $549
JUMPV
LABELV $557
line 1047
;1046:			}
;1047:			ci->deferred = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 480
ADDP4
CNSTI4 1
ASGNI4
line 1048
;1048:			CG_CopyClientInfoModel(match, ci);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 1049
;1049:			return;
ADDRGP4 $530
JUMPV
LABELV $549
line 1038
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $551
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31488
INDIRI4
LTI4 $548
line 1055
;1050:		}
;1051:		// load the full model, because we don't ever want to show
;1052:		// an improper team skin.  This will cause a hitch for the first
;1053:		// player, when the second enters.  Combat shouldn't be going on
;1054:		// yet, so it shouldn't matter
;1055:		CG_LoadClientInfo(clientNum, ci);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1056
;1056:		return;
ADDRGP4 $530
JUMPV
LABELV $545
line 1060
;1057:	}
;1058:
;1059:	// find the first valid clientinfo and grab its stuff
;1060:	for (i = 0; i < cgs.maxclients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $564
JUMPV
LABELV $561
line 1061
;1061:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 2120
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 1062
;1062:		if (!match->infoValid) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $567
line 1063
;1063:			continue;
ADDRGP4 $562
JUMPV
LABELV $567
line 1066
;1064:		}
;1065:
;1066:		ci->deferred = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 480
ADDP4
CNSTI4 1
ASGNI4
line 1067
;1067:		CG_CopyClientInfoModel(match, ci);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 1068
;1068:		return;
ADDRGP4 $530
JUMPV
LABELV $562
line 1060
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $564
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31488
INDIRI4
LTI4 $561
line 1072
;1069:	}
;1070:
;1071:	// we should never get here...
;1072:	CG_Printf("CG_SetDeferredClientInfo: no valid clients!\n");
ADDRGP4 $569
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1074
;1073:
;1074:	CG_LoadClientInfo(clientNum, ci);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1075
;1075:}
LABELV $530
endproc CG_SetDeferredClientInfo 40 8
export CG_NewClientInfo
proc CG_NewClientInfo 2300 12
line 1082
;1076:
;1077:/*
;1078:======================
;1079:CG_NewClientInfo
;1080:======================
;1081: */
;1082:void CG_NewClientInfo(int clientNum) {
line 1089
;1083:	clientInfo_t *ci;
;1084:	clientInfo_t newInfo;
;1085:	const char *configstring;
;1086:	const char *v;
;1087:	char *slash;
;1088:
;1089:	ci = &cgs.clientinfo[clientNum];
ADDRLP4 2132
CNSTI4 2120
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 1091
;1090:
;1091:	configstring = CG_ConfigString(clientNum + CS_PLAYERS);
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 2136
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 2124
ADDRLP4 2136
INDIRP4
ASGNP4
line 1092
;1092:	if (!configstring[0]) {
ADDRLP4 2124
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $572
line 1093
;1093:		memset(ci, 0, sizeof ( *ci));
ADDRLP4 2132
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2120
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1094
;1094:		return; // player just left
ADDRGP4 $570
JUMPV
LABELV $572
line 1099
;1095:	}
;1096:
;1097:	// build into a temp buffer so the defer checks can use
;1098:	// the old value
;1099:	memset(&newInfo, 0, sizeof ( newInfo));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2120
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1102
;1100:
;1101:	// isolate the player's name
;1102:	v = Info_ValueForKey(configstring, "n");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $574
ARGP4
ADDRLP4 2140
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2140
INDIRP4
ASGNP4
line 1103
;1103:	Q_strncpyz(newInfo.name, v, sizeof ( newInfo.name));
ADDRLP4 4+4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1106
;1104:
;1105:	// colors
;1106:	v = Info_ValueForKey(configstring, "c1");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $577
ARGP4
ADDRLP4 2144
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2144
INDIRP4
ASGNP4
line 1107
;1107:	CG_ColorFromString(v, newInfo.color1);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4+76
ARGP4
ADDRGP4 CG_ColorFromString
CALLV
pop
line 1109
;1108:
;1109:	v = Info_ValueForKey(configstring, "c2");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $579
ARGP4
ADDRLP4 2148
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2148
INDIRP4
ASGNP4
line 1110
;1110:	CG_ColorFromString(v, newInfo.color2);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4+88
ARGP4
ADDRGP4 CG_ColorFromString
CALLV
pop
line 1113
;1111:
;1112:	// bot skill
;1113:	v = Info_ValueForKey(configstring, "skill");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $581
ARGP4
ADDRLP4 2152
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2152
INDIRP4
ASGNP4
line 1114
;1114:	newInfo.botSkill = atoi(v);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2156
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+72
ADDRLP4 2156
INDIRI4
ASGNI4
line 1117
;1115:
;1116:	// handicap
;1117:	v = Info_ValueForKey(configstring, "hc");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $583
ARGP4
ADDRLP4 2160
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2160
INDIRP4
ASGNP4
line 1118
;1118:	newInfo.handicap = atoi(v);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2164
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+120
ADDRLP4 2164
INDIRI4
ASGNI4
line 1121
;1119:
;1120:	// wins
;1121:	v = Info_ValueForKey(configstring, "w");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $585
ARGP4
ADDRLP4 2168
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2168
INDIRP4
ASGNP4
line 1122
;1122:	newInfo.wins = atoi(v);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2172
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+124
ADDRLP4 2172
INDIRI4
ASGNI4
line 1125
;1123:
;1124:	// losses
;1125:	v = Info_ValueForKey(configstring, "l");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $587
ARGP4
ADDRLP4 2176
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2176
INDIRP4
ASGNP4
line 1126
;1126:	newInfo.losses = atoi(v);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2180
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+128
ADDRLP4 2180
INDIRI4
ASGNI4
line 1129
;1127:
;1128:	// team
;1129:	v = Info_ValueForKey(configstring, "t");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 2184
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2184
INDIRP4
ASGNP4
line 1130
;1130:	newInfo.team = atoi(v);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2188
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+68
ADDRLP4 2188
INDIRI4
ASGNI4
line 1133
;1131:
;1132:	// team task
;1133:	v = Info_ValueForKey(configstring, "tt");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $591
ARGP4
ADDRLP4 2192
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2192
INDIRP4
ASGNP4
line 1134
;1134:	newInfo.teamTask = atoi(v);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2196
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+132
ADDRLP4 2196
INDIRI4
ASGNI4
line 1137
;1135:
;1136:	// team leader
;1137:	v = Info_ValueForKey(configstring, "tl");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $593
ARGP4
ADDRLP4 2200
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2200
INDIRP4
ASGNP4
line 1138
;1138:	newInfo.teamLeader = atoi(v);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2204
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4+136
ADDRLP4 2204
INDIRI4
ASGNI4
line 1140
;1139:
;1140:	v = Info_ValueForKey(configstring, "g_redteam");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $595
ARGP4
ADDRLP4 2208
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2208
INDIRP4
ASGNP4
line 1141
;1141:	Q_strncpyz(newInfo.redTeam, v, MAX_TEAMNAME);
ADDRLP4 4+416
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1143
;1142:
;1143:	v = Info_ValueForKey(configstring, "g_blueteam");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $597
ARGP4
ADDRLP4 2212
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2212
INDIRP4
ASGNP4
line 1144
;1144:	Q_strncpyz(newInfo.blueTeam, v, MAX_TEAMNAME);
ADDRLP4 4+448
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1147
;1145:
;1146:	// model
;1147:	v = Info_ValueForKey(configstring, "model");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $599
ARGP4
ADDRLP4 2216
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2216
INDIRP4
ASGNP4
line 1148
;1148:	if (cg_forceModel.integer) {
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $600
line 1155
;1149:		// forcemodel makes everyone use a single model
;1150:		// to prevent load hitches
;1151:		char modelStr[MAX_QPATH];
;1152:		char *skin;
;1153:
;1154:		/* Neon_Knight: Missionpack checks, if != 0, enables this. */
;1155:		if (cg_missionpackChecks.integer) {
ADDRGP4 cg_missionpackChecks+12
INDIRI4
CNSTI4 0
EQI4 $603
line 1156
;1156:			if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 2288
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 2288
INDIRI4
CNSTI4 0
EQI4 $604
line 1157
;1157:				Q_strncpyz(newInfo.modelName, DEFAULT_TEAM_MODEL, sizeof ( newInfo.modelName));
ADDRLP4 4+160
ARGP4
ADDRGP4 $478
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1158
;1158:				Q_strncpyz(newInfo.skinName, "default", sizeof ( newInfo.skinName));
ADDRLP4 4+224
ARGP4
ADDRGP4 $120
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1159
;1159:			}
line 1160
;1160:		} else {
ADDRGP4 $604
JUMPV
LABELV $603
line 1161
;1161:			trap_Cvar_VariableStringBuffer("model", modelStr, sizeof ( modelStr));
ADDRGP4 $599
ARGP4
ADDRLP4 2220
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1162
;1162:			if ((skin = strchr(modelStr, '/')) == NULL) {
ADDRLP4 2220
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2288
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2284
ADDRLP4 2288
INDIRP4
ASGNP4
ADDRLP4 2288
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $613
line 1163
;1163:				skin = "default";
ADDRLP4 2284
ADDRGP4 $120
ASGNP4
line 1164
;1164:			} else {
ADDRGP4 $614
JUMPV
LABELV $613
line 1165
;1165:				*skin++ = 0;
ADDRLP4 2292
ADDRLP4 2284
INDIRP4
ASGNP4
ADDRLP4 2284
ADDRLP4 2292
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2292
INDIRP4
CNSTI1 0
ASGNI1
line 1166
;1166:			}
LABELV $614
line 1168
;1167:
;1168:			Q_strncpyz(newInfo.skinName, skin, sizeof ( newInfo.skinName));
ADDRLP4 4+224
ARGP4
ADDRLP4 2284
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1169
;1169:			Q_strncpyz(newInfo.modelName, modelStr, sizeof ( newInfo.modelName));
ADDRLP4 4+160
ARGP4
ADDRLP4 2220
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1170
;1170:		}
LABELV $604
line 1172
;1171:		/* /Neon_Knight */
;1172:		if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 2288
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 2288
INDIRI4
CNSTI4 0
EQI4 $601
line 1174
;1173:			// keep skin name
;1174:			slash = strchr(v, '/');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2292
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2128
ADDRLP4 2292
INDIRP4
ASGNP4
line 1175
;1175:			if (slash) {
ADDRLP4 2128
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $601
line 1176
;1176:				Q_strncpyz(newInfo.skinName, slash + 1, sizeof ( newInfo.skinName));
ADDRLP4 4+224
ARGP4
ADDRLP4 2128
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1177
;1177:			}
line 1178
;1178:		}
line 1179
;1179:	} else {
ADDRGP4 $601
JUMPV
LABELV $600
line 1180
;1180:		Q_strncpyz(newInfo.modelName, v, sizeof ( newInfo.modelName));
ADDRLP4 4+160
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1182
;1181:
;1182:		slash = strchr(newInfo.modelName, '/');
ADDRLP4 4+160
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2220
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2128
ADDRLP4 2220
INDIRP4
ASGNP4
line 1183
;1183:		if (!slash) {
ADDRLP4 2128
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $629
line 1185
;1184:			// modelName didn not include a skin name
;1185:			Q_strncpyz(newInfo.skinName, "default", sizeof ( newInfo.skinName));
ADDRLP4 4+224
ARGP4
ADDRGP4 $120
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1186
;1186:		} else {
ADDRGP4 $630
JUMPV
LABELV $629
line 1187
;1187:			Q_strncpyz(newInfo.skinName, slash + 1, sizeof ( newInfo.skinName));
ADDRLP4 4+224
ARGP4
ADDRLP4 2128
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1189
;1188:			// truncate modelName
;1189:			*slash = 0;
ADDRLP4 2128
INDIRP4
CNSTI1 0
ASGNI1
line 1190
;1190:		}
LABELV $630
line 1191
;1191:	}
LABELV $601
line 1194
;1192:
;1193:	// head model
;1194:	v = Info_ValueForKey(configstring, "hmodel");
ADDRLP4 2124
INDIRP4
ARGP4
ADDRGP4 $635
ARGP4
ADDRLP4 2220
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2220
INDIRP4
ASGNP4
line 1195
;1195:	if (cg_forceModel.integer) {
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $636
line 1202
;1196:		// forcemodel makes everyone use a single model
;1197:		// to prevent load hitches
;1198:		char modelStr[MAX_QPATH];
;1199:		char *skin;
;1200:
;1201:		/* Neon_Knight: Missionpack checks, if != 0, enables this. */
;1202:		if (cg_missionpackChecks.integer) {
ADDRGP4 cg_missionpackChecks+12
INDIRI4
CNSTI4 0
EQI4 $639
line 1203
;1203:			if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 2292
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 2292
INDIRI4
CNSTI4 0
EQI4 $640
line 1204
;1204:				Q_strncpyz(newInfo.headModelName, DEFAULT_TEAM_MODEL, sizeof ( newInfo.headModelName));
ADDRLP4 4+288
ARGP4
ADDRGP4 $478
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1205
;1205:				Q_strncpyz(newInfo.headSkinName, "default", sizeof ( newInfo.headSkinName));
ADDRLP4 4+352
ARGP4
ADDRGP4 $120
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1206
;1206:			}
line 1207
;1207:		} else {
ADDRGP4 $640
JUMPV
LABELV $639
line 1208
;1208:			trap_Cvar_VariableStringBuffer("headmodel", modelStr, sizeof ( modelStr));
ADDRGP4 $649
ARGP4
ADDRLP4 2224
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1209
;1209:			if ((skin = strchr(modelStr, '/')) == NULL) {
ADDRLP4 2224
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2292
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2288
ADDRLP4 2292
INDIRP4
ASGNP4
ADDRLP4 2292
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $650
line 1210
;1210:				skin = "default";
ADDRLP4 2288
ADDRGP4 $120
ASGNP4
line 1211
;1211:			} else {
ADDRGP4 $651
JUMPV
LABELV $650
line 1212
;1212:				*skin++ = 0;
ADDRLP4 2296
ADDRLP4 2288
INDIRP4
ASGNP4
ADDRLP4 2288
ADDRLP4 2296
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2296
INDIRP4
CNSTI1 0
ASGNI1
line 1213
;1213:			}
LABELV $651
line 1215
;1214:
;1215:			Q_strncpyz(newInfo.headSkinName, skin, sizeof ( newInfo.headSkinName));
ADDRLP4 4+352
ARGP4
ADDRLP4 2288
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1216
;1216:			Q_strncpyz(newInfo.headModelName, modelStr, sizeof ( newInfo.headModelName));
ADDRLP4 4+288
ARGP4
ADDRLP4 2224
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1217
;1217:		}
LABELV $640
line 1220
;1218:		/* /Neon_Knight */
;1219:
;1220:		if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 2292
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 2292
INDIRI4
CNSTI4 0
EQI4 $637
line 1222
;1221:			// keep skin name
;1222:			slash = strchr(v, '/');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2296
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2128
ADDRLP4 2296
INDIRP4
ASGNP4
line 1223
;1223:			if (slash) {
ADDRLP4 2128
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $637
line 1224
;1224:				Q_strncpyz(newInfo.headSkinName, slash + 1, sizeof ( newInfo.headSkinName));
ADDRLP4 4+352
ARGP4
ADDRLP4 2128
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1225
;1225:			}
line 1226
;1226:		}
line 1227
;1227:	} else {
ADDRGP4 $637
JUMPV
LABELV $636
line 1228
;1228:		Q_strncpyz(newInfo.headModelName, v, sizeof ( newInfo.headModelName));
ADDRLP4 4+288
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1230
;1229:
;1230:		slash = strchr(newInfo.headModelName, '/');
ADDRLP4 4+288
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2224
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2128
ADDRLP4 2224
INDIRP4
ASGNP4
line 1231
;1231:		if (!slash) {
ADDRLP4 2128
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $666
line 1233
;1232:			// modelName didn not include a skin name
;1233:			Q_strncpyz(newInfo.headSkinName, "default", sizeof ( newInfo.headSkinName));
ADDRLP4 4+352
ARGP4
ADDRGP4 $120
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1234
;1234:		} else {
ADDRGP4 $667
JUMPV
LABELV $666
line 1235
;1235:			Q_strncpyz(newInfo.headSkinName, slash + 1, sizeof ( newInfo.headSkinName));
ADDRLP4 4+352
ARGP4
ADDRLP4 2128
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1237
;1236:			// truncate modelName
;1237:			*slash = 0;
ADDRLP4 2128
INDIRP4
CNSTI1 0
ASGNI1
line 1238
;1238:		}
LABELV $667
line 1239
;1239:	}
LABELV $637
line 1243
;1240:
;1241:	// scan for an existing clientinfo that matches this modelname
;1242:	// so we can avoid loading checks if possible
;1243:	if (!CG_ScanForExistingClientInfo(&newInfo)) {
ADDRLP4 4
ARGP4
ADDRLP4 2224
ADDRGP4 CG_ScanForExistingClientInfo
CALLI4
ASGNI4
ADDRLP4 2224
INDIRI4
CNSTI4 0
NEI4 $672
line 1246
;1244:		qboolean forceDefer;
;1245:
;1246:		forceDefer = trap_MemoryRemaining() < 4000000;
ADDRLP4 2236
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 2236
INDIRI4
CNSTI4 4000000
GEI4 $675
ADDRLP4 2232
CNSTI4 1
ASGNI4
ADDRGP4 $676
JUMPV
LABELV $675
ADDRLP4 2232
CNSTI4 0
ASGNI4
LABELV $676
ADDRLP4 2228
ADDRLP4 2232
INDIRI4
ASGNI4
line 1249
;1247:
;1248:		// if we are defering loads, just have it pick the first valid
;1249:		if (forceDefer || (cg_deferPlayers.integer && !cg_buildScript.integer && !cg.loading)) {
ADDRLP4 2240
CNSTI4 0
ASGNI4
ADDRLP4 2228
INDIRI4
ADDRLP4 2240
INDIRI4
NEI4 $682
ADDRGP4 cg_deferPlayers+12
INDIRI4
ADDRLP4 2240
INDIRI4
EQI4 $677
ADDRGP4 cg_buildScript+12
INDIRI4
ADDRLP4 2240
INDIRI4
NEI4 $677
ADDRGP4 cg+20
INDIRI4
ADDRLP4 2240
INDIRI4
NEI4 $677
LABELV $682
line 1251
;1250:			// keep whatever they had if it won't violate team skins
;1251:			CG_SetDeferredClientInfo(clientNum, &newInfo);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_SetDeferredClientInfo
CALLV
pop
line 1253
;1252:			// if we are low on memory, leave them with this model
;1253:			if (forceDefer) {
ADDRLP4 2228
INDIRI4
CNSTI4 0
EQI4 $678
line 1254
;1254:				CG_Printf("Memory is low. Using deferred model.\n");
ADDRGP4 $685
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1255
;1255:				newInfo.deferred = qfalse;
ADDRLP4 4+480
CNSTI4 0
ASGNI4
line 1256
;1256:			}
line 1257
;1257:		} else {
ADDRGP4 $678
JUMPV
LABELV $677
line 1258
;1258:			CG_LoadClientInfo(clientNum, &newInfo);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1259
;1259:		}
LABELV $678
line 1260
;1260:	}
LABELV $672
line 1263
;1261:
;1262:	// replace whatever was there with the new one
;1263:	newInfo.infoValid = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1264
;1264:	*ci = newInfo;
ADDRLP4 2132
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 2120
line 1265
;1265:}
LABELV $570
endproc CG_NewClientInfo 2300 12
export CG_LoadDeferredPlayers
proc CG_LoadDeferredPlayers 20 8
line 1276
;1266:
;1267:/*
;1268:======================
;1269:CG_LoadDeferredPlayers
;1270:
;1271:Called each frame when a player is dead
;1272:and the scoreboard is up
;1273:so deferred players can be loaded
;1274:======================
;1275: */
;1276:void CG_LoadDeferredPlayers(void) {
line 1281
;1277:	int i;
;1278:	clientInfo_t *ci;
;1279:
;1280:	// scan for a deferred player to load
;1281:	for (i = 0, ci = cgs.clientinfo; i < cgs.maxclients; i++, ci++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cgs+41152
ASGNP4
ADDRGP4 $691
JUMPV
LABELV $688
line 1282
;1282:		if (ci->infoValid && ci->deferred) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $694
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $694
line 1284
;1283:			// if we are low on memory, leave it deferred
;1284:			if (trap_MemoryRemaining() < 4000000) {
ADDRLP4 16
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 4000000
GEI4 $696
line 1285
;1285:				CG_Printf("Memory is low. Using deferred model.\n");
ADDRGP4 $685
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1286
;1286:				ci->deferred = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
CNSTI4 0
ASGNI4
line 1287
;1287:				continue;
ADDRGP4 $689
JUMPV
LABELV $696
line 1289
;1288:			}
;1289:			CG_LoadClientInfo(i, ci);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1291
;1290:			//			break;
;1291:		}
LABELV $694
line 1292
;1292:	}
LABELV $689
line 1281
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2120
ADDP4
ASGNP4
LABELV $691
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31488
INDIRI4
LTI4 $688
line 1293
;1293:}
LABELV $687
endproc CG_LoadDeferredPlayers 20 8
proc CG_SetLerpFrameAnimation 12 8
line 1310
;1294:
;1295:/*
;1296:=============================================================================
;1297:
;1298:PLAYER ANIMATION
;1299:
;1300:=============================================================================
;1301: */
;1302:
;1303:/*
;1304:===============
;1305:CG_SetLerpFrameAnimation
;1306:
;1307:may include ANIM_TOGGLEBIT
;1308:===============
;1309: */
;1310:static void CG_SetLerpFrameAnimation(clientInfo_t *ci, lerpFrame_t *lf, int newAnimation) {
line 1313
;1311:	animation_t *anim;
;1312:
;1313:	lf->animationNumber = newAnimation;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1314
;1314:	newAnimation &= ~ANIM_TOGGLEBIT;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1316
;1315:
;1316:	if (newAnimation < 0 || newAnimation >= MAX_TOTALANIMATIONS) {
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $701
ADDRLP4 4
INDIRI4
CNSTI4 51
LTI4 $699
LABELV $701
line 1317
;1317:		CG_Error("Bad animation number: %i", newAnimation);
ADDRGP4 $702
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1318
;1318:	}
LABELV $699
line 1320
;1319:
;1320:	anim = &ci->animations[ newAnimation ];
ADDRLP4 0
CNSTI4 28
ADDRFP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDP4
ASGNP4
line 1322
;1321:
;1322:	lf->animation = anim;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1323
;1323:	lf->animationTime = lf->frameTime + anim->initialLerp;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1325
;1324:
;1325:	if (cg_debugAnim.integer) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $703
line 1326
;1326:		CG_Printf("Anim: %i\n", newAnimation);
ADDRGP4 $706
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1327
;1327:	}
LABELV $703
line 1328
;1328:}
LABELV $698
endproc CG_SetLerpFrameAnimation 12 8
proc CG_RunLerpFrame 44 12
line 1338
;1329:
;1330:/*
;1331:===============
;1332:CG_RunLerpFrame
;1333:
;1334:Sets cg.snap, cg.oldFrame, and cg.backlerp
;1335:cg.time should be between oldFrameTime and frameTime after exit
;1336:===============
;1337: */
;1338:static void CG_RunLerpFrame(clientInfo_t *ci, lerpFrame_t *lf, int newAnimation, float speedScale) {
line 1343
;1339:	int f, numFrames;
;1340:	animation_t *anim;
;1341:
;1342:	// debugging tool to get no animations
;1343:	if (cg_animSpeed.integer == 0) {
ADDRGP4 cg_animSpeed+12
INDIRI4
CNSTI4 0
NEI4 $708
line 1344
;1344:		lf->oldFrame = lf->frame = lf->backlerp = 0;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1345
;1345:		return;
ADDRGP4 $707
JUMPV
LABELV $708
line 1349
;1346:	}
;1347:
;1348:	// see if the animation sequence is switching
;1349:	if (newAnimation != lf->animationNumber || !lf->animation) {
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
NEI4 $713
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $711
LABELV $713
line 1350
;1350:		CG_SetLerpFrameAnimation(ci, lf, newAnimation);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1351
;1351:	}
LABELV $711
line 1355
;1352:
;1353:	// if we have passed the current frame, move it to
;1354:	// oldFrame and calculate a new frame
;1355:	if (cg.time >= lf->frameTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LTI4 $714
line 1356
;1356:		lf->oldFrame = lf->frame;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1357
;1357:		lf->oldFrameTime = lf->frameTime;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1360
;1358:
;1359:		// get the next frame based on the animation
;1360:		anim = lf->animation;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ASGNP4
line 1361
;1361:		if (!anim->frameLerp) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $717
line 1362
;1362:			return; // shouldn't happen
ADDRGP4 $707
JUMPV
LABELV $717
line 1364
;1363:		}
;1364:		if (cg.time < lf->animationTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
GEI4 $719
line 1365
;1365:			lf->frameTime = lf->animationTime; // initial lerp
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ASGNI4
line 1366
;1366:		} else {
ADDRGP4 $720
JUMPV
LABELV $719
line 1367
;1367:			lf->frameTime = lf->oldFrameTime + anim->frameLerp;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 12
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1368
;1368:		}
LABELV $720
line 1369
;1369:		f = (lf->frameTime - lf->animationTime) / anim->frameLerp;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 12
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
SUBI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
DIVI4
ASGNI4
line 1370
;1370:		f *= speedScale; // adjust for haste, etc
ADDRLP4 4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRFP4 12
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1372
;1371:
;1372:		numFrames = anim->numFrames;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1373
;1373:		if (anim->flipflop) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $722
line 1374
;1374:			numFrames *= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1375
;1375:		}
LABELV $722
line 1376
;1376:		if (f >= numFrames) {
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $724
line 1377
;1377:			f -= numFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1378
;1378:			if (anim->loopFrames) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $726
line 1379
;1379:				f %= anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MODI4
ASGNI4
line 1380
;1380:				f += anim->numFrames - anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1381
;1381:			} else {
ADDRGP4 $727
JUMPV
LABELV $726
line 1382
;1382:				f = numFrames - 1;
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1385
;1383:				// the animation is stuck at the end, so it
;1384:				// can immediately transition to another sequence
;1385:				lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1386
;1386:			}
LABELV $727
line 1387
;1387:		}
LABELV $724
line 1388
;1388:		if (anim->reversed) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $729
line 1389
;1389:			lf->frame = anim->firstFrame + anim->numFrames - 1 - f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1390
;1390:		} else if (anim->flipflop && f >= anim->numFrames) {
ADDRGP4 $730
JUMPV
LABELV $729
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $731
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $731
line 1391
;1391:			lf->frame = anim->firstFrame + anim->numFrames - 1 - (f % anim->numFrames);
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
ADDRLP4 40
INDIRI4
MODI4
SUBI4
ASGNI4
line 1392
;1392:		} else {
ADDRGP4 $732
JUMPV
LABELV $731
line 1393
;1393:			lf->frame = anim->firstFrame + f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1394
;1394:		}
LABELV $732
LABELV $730
line 1395
;1395:		if (cg.time > lf->frameTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LEI4 $733
line 1396
;1396:			lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1397
;1397:			if (cg_debugAnim.integer) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $737
line 1398
;1398:				CG_Printf("Clamp lf->frameTime\n");
ADDRGP4 $740
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1399
;1399:			}
LABELV $737
line 1400
;1400:		}
LABELV $733
line 1401
;1401:	}
LABELV $714
line 1403
;1402:
;1403:	if (lf->frameTime > cg.time + 200) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 200
ADDI4
LEI4 $741
line 1404
;1404:		lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1405
;1405:	}
LABELV $741
line 1407
;1406:
;1407:	if (lf->oldFrameTime > cg.time) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $745
line 1408
;1408:		lf->oldFrameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1409
;1409:	}
LABELV $745
line 1411
;1410:	// calculate current lerp value
;1411:	if (lf->frameTime == lf->oldFrameTime) {
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $749
line 1412
;1412:		lf->backlerp = 0;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 0
ASGNF4
line 1413
;1413:	} else {
ADDRGP4 $750
JUMPV
LABELV $749
line 1414
;1414:		lf->backlerp = 1.0 - (float) (cg.time - lf->oldFrameTime) / (lf->frameTime - lf->oldFrameTime);
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1065353216
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 1415
;1415:	}
LABELV $750
line 1416
;1416:}
LABELV $707
endproc CG_RunLerpFrame 44 12
proc CG_ClearLerpFrame 16 12
line 1423
;1417:
;1418:/*
;1419:===============
;1420:CG_ClearLerpFrame
;1421:===============
;1422: */
;1423:static void CG_ClearLerpFrame(clientInfo_t *ci, lerpFrame_t *lf, int animationNumber) {
line 1424
;1424:	lf->frameTime = lf->oldFrameTime = cg.time;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1425
;1425:	CG_SetLerpFrameAnimation(ci, lf, animationNumber);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1426
;1426:	lf->oldFrame = lf->frame = lf->animation->firstFrame;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1427
;1427:}
LABELV $752
endproc CG_ClearLerpFrame 16 12
proc CG_PlayerAnimation 20 16
line 1435
;1428:
;1429:/*
;1430:===============
;1431:CG_PlayerAnimation
;1432:===============
;1433: */
;1434:static void CG_PlayerAnimation(centity_t *cent, int *legsOld, int *legs, float *legsBackLerp,
;1435:		int *torsoOld, int *torso, float *torsoBackLerp) {
line 1440
;1436:	clientInfo_t *ci;
;1437:	int clientNum;
;1438:	float speedScale;
;1439:
;1440:	clientNum = cent->currentState.clientNum;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1442
;1441:
;1442:	if (cg_noPlayerAnims.integer) {
ADDRGP4 cg_noPlayerAnims+12
INDIRI4
CNSTI4 0
EQI4 $755
line 1443
;1443:		*legsOld = *legs = *torsoOld = *torso = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1444
;1444:		return;
ADDRGP4 $754
JUMPV
LABELV $755
line 1447
;1445:	}
;1446:
;1447:	if (cent->currentState.powerups & (1 << PW_HASTE)) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $758
line 1448
;1448:		speedScale = 1.5;
ADDRLP4 4
CNSTF4 1069547520
ASGNF4
line 1449
;1449:	} else {
ADDRGP4 $759
JUMPV
LABELV $758
line 1450
;1450:		speedScale = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1451
;1451:	}
LABELV $759
line 1453
;1452:
;1453:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
CNSTI4 2120
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 1456
;1454:
;1455:	// do the shuffle turn frames locally
;1456:	if (cent->pe.legs.yawing && (cent->currentState.legsAnim & ~ANIM_TOGGLEBIT) == LEGS_IDLE) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 0
EQI4 $761
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $761
line 1457
;1457:		CG_RunLerpFrame(ci, &cent->pe.legs, LEGS_TURN, speedScale);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1458
;1458:	} else {
ADDRGP4 $762
JUMPV
LABELV $761
line 1459
;1459:		CG_RunLerpFrame(ci, &cent->pe.legs, cent->currentState.legsAnim, speedScale);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 452
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1460
;1460:	}
LABELV $762
line 1462
;1461:
;1462:	*legsOld = cent->pe.legs.oldFrame;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 1463
;1463:	*legs = cent->pe.legs.frame;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ASGNI4
line 1464
;1464:	*legsBackLerp = cent->pe.legs.backlerp;
ADDRFP4 12
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ASGNF4
line 1466
;1465:
;1466:	CG_RunLerpFrame(ci, &cent->pe.torso, cent->currentState.torsoAnim, speedScale);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 500
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1468
;1467:
;1468:	*torsoOld = cent->pe.torso.oldFrame;
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
ASGNI4
line 1469
;1469:	*torso = cent->pe.torso.frame;
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
ASGNI4
line 1470
;1470:	*torsoBackLerp = cent->pe.torso.backlerp;
ADDRFP4 24
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRF4
ASGNF4
line 1471
;1471:}
LABELV $754
endproc CG_PlayerAnimation 20 16
proc CG_SwingAngles 28 8
line 1487
;1472:
;1473:/*
;1474:=============================================================================
;1475:
;1476:PLAYER ANGLES
;1477:
;1478:=============================================================================
;1479: */
;1480:
;1481:/*
;1482:==================
;1483:CG_SwingAngles
;1484:==================
;1485: */
;1486:static void CG_SwingAngles(float destination, float swingTolerance, float clampTolerance,
;1487:		float speed, float *angle, qboolean *swinging) {
line 1492
;1488:	float swing;
;1489:	float move;
;1490:	float scale;
;1491:
;1492:	if (!*swinging) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $764
line 1494
;1493:		// see if a swing should be started
;1494:		swing = AngleSubtract(*angle, destination);
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1495
;1495:		if (swing > swingTolerance || swing < -swingTolerance) {
ADDRLP4 20
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
GTF4 $768
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
NEGF4
GEF4 $766
LABELV $768
line 1496
;1496:			*swinging = qtrue;
ADDRFP4 20
INDIRP4
CNSTI4 1
ASGNI4
line 1497
;1497:		}
LABELV $766
line 1498
;1498:	}
LABELV $764
line 1500
;1499:
;1500:	if (!*swinging) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $769
line 1501
;1501:		return;
ADDRGP4 $763
JUMPV
LABELV $769
line 1506
;1502:	}
;1503:
;1504:	// modify the speed depending on the delta
;1505:	// so it doesn't seem so linear
;1506:	swing = AngleSubtract(destination, *angle);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1507
;1507:	scale = fabs(swing);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 1508
;1508:	if (scale < swingTolerance * 0.5) {
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
MULF4
GEF4 $771
line 1509
;1509:		scale = 0.5;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1510
;1510:	} else if (scale < swingTolerance) {
ADDRGP4 $772
JUMPV
LABELV $771
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
GEF4 $773
line 1511
;1511:		scale = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1512
;1512:	} else {
ADDRGP4 $774
JUMPV
LABELV $773
line 1513
;1513:		scale = 2.0;
ADDRLP4 4
CNSTF4 1073741824
ASGNF4
line 1514
;1514:	}
LABELV $774
LABELV $772
line 1517
;1515:
;1516:	// swing towards the destination angle
;1517:	if (swing >= 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LTF4 $775
line 1518
;1518:		move = cg.frametime * scale * speed;
ADDRLP4 8
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 1519
;1519:		if (move >= swing) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
LTF4 $778
line 1520
;1520:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1521
;1521:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1522
;1522:		}
LABELV $778
line 1523
;1523:		*angle = AngleMod(*angle + move);
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1524
;1524:	} else {
ADDRGP4 $776
JUMPV
LABELV $775
line 1525
;1525:		move = cg.frametime * scale * -speed;
ADDRLP4 8
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
NEGF4
MULF4
ASGNF4
line 1526
;1526:		if (move <= swing) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $781
line 1527
;1527:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1528
;1528:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1529
;1529:		}
LABELV $781
line 1530
;1530:		*angle = AngleMod(*angle + move);
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1531
;1531:	}
LABELV $776
line 1534
;1532:
;1533:	// clamp to no more than tolerance
;1534:	swing = AngleSubtract(destination, *angle);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 1535
;1535:	if (swing > clampTolerance) {
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $783
line 1536
;1536:		*angle = AngleMod(destination - (clampTolerance - 1));
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
SUBF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1537
;1537:	} else if (swing < -clampTolerance) {
ADDRGP4 $784
JUMPV
LABELV $783
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $785
line 1538
;1538:		*angle = AngleMod(destination + (clampTolerance - 1));
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1539
;1539:	}
LABELV $785
LABELV $784
line 1540
;1540:}
LABELV $763
endproc CG_SwingAngles 28 8
proc CG_AddPainTwitch 12 0
line 1547
;1541:
;1542:/*
;1543:=================
;1544:CG_AddPainTwitch
;1545:=================
;1546: */
;1547:static void CG_AddPainTwitch(centity_t *cent, vec3_t torsoAngles) {
line 1551
;1548:	int t;
;1549:	float f;
;1550:
;1551:	t = cg.time - cent->pe.painTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1552
;1552:	if (t >= PAIN_TWITCH_TIME) {
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $789
line 1553
;1553:		return;
ADDRGP4 $787
JUMPV
LABELV $789
line 1556
;1554:	}
;1555:
;1556:	f = 1.0 - (float) t / PAIN_TWITCH_TIME;
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 1558
;1557:
;1558:	if (cent->pe.painDirection) {
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRI4
CNSTI4 0
EQI4 $791
line 1559
;1559:		torsoAngles[ROLL] += 20 * f;
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
CNSTF4 1101004800
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1560
;1560:	} else {
ADDRGP4 $792
JUMPV
LABELV $791
line 1561
;1561:		torsoAngles[ROLL] -= 20 * f;
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
CNSTF4 1101004800
ADDRLP4 4
INDIRF4
MULF4
SUBF4
ASGNF4
line 1562
;1562:	}
LABELV $792
line 1563
;1563:}
LABELV $787
endproc CG_AddPainTwitch 12 0
data
align 4
LABELV $794
byte 4 0
byte 4 22
byte 4 45
byte 4 -22
byte 4 0
byte 4 22
byte 4 -45
byte 4 -22
code
proc CG_PlayerAngles 140 24
line 1583
;1564:
;1565:
;1566:/*
;1567:===============
;1568:CG_PlayerAngles
;1569:
;1570:Handles seperate torso motion
;1571:
;1572:  legs pivot based on direction of movement
;1573:
;1574:  head always looks exactly at cent->lerpAngles
;1575:
;1576:  if motion < 20 degrees, show in head only
;1577:  if < 45 degrees, also show in torso
;1578:===============
;1579: */
;1580:
;1581:vec3_t eyeat;
;1582:
;1583:static void CG_PlayerAngles(centity_t *cent, vec3_t legs[3], vec3_t torso[3], vec3_t head[3]) {
line 1590
;1584:	vec3_t legsAngles, torsoAngles, headAngles;
;1585:	float dest;
;1586:	static int movementOffsets[8] = {0, 22, 45, -22, 0, 22, -45, -22};
;1587:	vec3_t velocity;
;1588:	float speed;
;1589:	int dir, clientNum;
;1590:	clientInfo_t *ci = NULL;
ADDRLP4 60
CNSTP4 0
ASGNP4
line 1595
;1591:	int camereyes;
;1592:
;1593:
;1594:
;1595:	{
line 1596
;1596:		VectorCopy(cent->lerpAngles, headAngles);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRB
ASGNB 12
line 1597
;1597:		headAngles[YAW] = AngleMod(headAngles[YAW]);
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 72
INDIRF4
ASGNF4
line 1598
;1598:	}
line 1604
;1599:
;1600:
;1601:	//headAngles[YAW] = AngleMod( headAngles[YAW] );
;1602:
;1603:
;1604:	VectorClear(legsAngles);
ADDRLP4 72
CNSTF4 0
ASGNF4
ADDRLP4 24+8
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 72
INDIRF4
ASGNF4
line 1605
;1605:	VectorClear(torsoAngles);
ADDRLP4 76
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 76
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 76
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 76
INDIRF4
ASGNF4
line 1608
;1606:
;1607:
;1608:	camereyes = 0;
ADDRLP4 64
CNSTI4 0
ASGNI4
line 1609
;1609:	if (cent->currentState.number == cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $801
line 1610
;1610:		camereyes = 1; // it's me!
ADDRLP4 64
CNSTI4 1
ASGNI4
line 1611
;1611:	}
LABELV $801
line 1614
;1612:
;1613:	// leilei -- new third person camera prep
;1614:	cent->newcamrunning = 0;
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
CNSTI4 0
ASGNI4
line 1615
;1615:	if (cg_cameramode.integer == 1) {
ADDRGP4 cg_cameramode+12
INDIRI4
CNSTI4 1
NEI4 $804
line 1616
;1616:		if ((cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_ATTACK) {
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 7
EQI4 $807
line 1617
;1617:			cent->newcamrunning = 1;
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
CNSTI4 1
ASGNI4
line 1618
;1618:		} else {
ADDRGP4 $808
JUMPV
LABELV $807
line 1619
;1619:			cent->newcamrunning = 0;
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
CNSTI4 0
ASGNI4
line 1620
;1620:		}
LABELV $808
line 1621
;1621:	}
LABELV $804
line 1629
;1622:
;1623:	// --------- yaw -------------
;1624:
;1625:
;1626:	// turn head if reached the eye tolerance limit
;1627:
;1628:	// allow yaw to drift a bit
;1629:	if ((cent->currentState.legsAnim & ~ANIM_TOGGLEBIT) != LEGS_IDLE
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTI4 -129
ASGNI4
ADDRLP4 80
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
BANDI4
CNSTI4 22
NEI4 $811
ADDRLP4 88
ADDRLP4 80
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
BANDI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 11
EQI4 $809
ADDRLP4 88
INDIRI4
CNSTI4 12
EQI4 $809
LABELV $811
line 1631
;1630:			|| ((cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_STAND
;1631:			&& (cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_STAND2)) {
line 1633
;1632:		// if not standing still, always point all in the same direction
;1633:		cent->pe.torso.yawing = qtrue; // always center
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
CNSTI4 1
ASGNI4
line 1634
;1634:		cent->pe.torso.pitching = qtrue; // always center
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 1
ASGNI4
line 1635
;1635:		cent->pe.legs.yawing = qtrue; // always center
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
CNSTI4 1
ASGNI4
line 1637
;1636:
;1637:	}
LABELV $809
line 1644
;1638:
;1639:
;1640:
;1641:
;1642:	// etc
;1643:
;1644:	if (cent->newcamrunning) {
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRI4
CNSTI4 0
EQI4 $812
line 1646
;1645:		// lean towards the direction of travel
;1646:		VectorCopy(cent->currentState.pos.trDelta, velocity);
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1647
;1647:		speed = VectorNormalize(velocity);
ADDRLP4 40
ARGP4
ADDRLP4 92
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 92
INDIRF4
ASGNF4
line 1648
;1648:		if (speed) {
ADDRLP4 52
INDIRF4
CNSTF4 0
EQF4 $814
line 1651
;1649:			vec3_t veel;
;1650:			vec3_t fwad, rait;
;1651:			AngleVectors(veel, velocity, fwad, rait);
ADDRLP4 96
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 120
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1652
;1652:			speed *= 0.05f;
ADDRLP4 52
CNSTF4 1028443341
ADDRLP4 52
INDIRF4
MULF4
ASGNF4
line 1653
;1653:		}
LABELV $814
line 1654
;1654:	}
LABELV $812
line 1657
;1655:
;1656:	// adjust legs for movement dir
;1657:	if (cent->currentState.eFlags & EF_DEAD) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $816
line 1659
;1658:		// don't let dead bodies twitch
;1659:		dir = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 1660
;1660:	} else {
ADDRGP4 $817
JUMPV
LABELV $816
line 1661
;1661:		dir = cent->currentState.angles2[YAW];
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1662
;1662:		if (dir < 0 || dir > 7) {
ADDRLP4 56
INDIRI4
CNSTI4 0
LTI4 $820
ADDRLP4 56
INDIRI4
CNSTI4 7
LEI4 $818
LABELV $820
line 1663
;1663:			CG_Error("Bad player movement angle");
ADDRGP4 $821
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1664
;1664:		}
LABELV $818
line 1665
;1665:	}
LABELV $817
line 1668
;1666:
;1667:
;1668:	legsAngles[YAW] = headAngles[YAW] + movementOffsets[ dir ];
ADDRLP4 24+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 56
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $794
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1669
;1669:	torsoAngles[YAW] = headAngles[YAW] + 0.25 * movementOffsets[ dir ];
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1048576000
ADDRLP4 56
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $794
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 1673
;1670:
;1671:
;1672:	// torso
;1673:	if (cg_cameramode.integer == 1) {
ADDRGP4 cg_cameramode+12
INDIRI4
CNSTI4 1
NEI4 $826
line 1674
;1674:		CG_SwingAngles(torsoAngles[YAW], 180, 90, cg_swingSpeed.value, &cent->pe.torso.yawAngle, &cent->pe.torso.yawing);
ADDRLP4 0+4
INDIRF4
ARGF4
CNSTF4 1127481344
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 520
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 524
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1675
;1675:		CG_SwingAngles(legsAngles[YAW], 180, 90, cg_swingSpeed.value, &cent->pe.legs.yawAngle, &cent->pe.legs.yawing);
ADDRLP4 24+4
INDIRF4
ARGF4
CNSTF4 1127481344
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 476
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1676
;1676:	} else {
ADDRGP4 $827
JUMPV
LABELV $826
line 1677
;1677:		CG_SwingAngles(torsoAngles[YAW], 25, 90, cg_swingSpeed.value, &cent->pe.torso.yawAngle, &cent->pe.torso.yawing);
ADDRLP4 0+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 520
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 524
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1678
;1678:		CG_SwingAngles(legsAngles[YAW], 40, 90, cg_swingSpeed.value, &cent->pe.legs.yawAngle, &cent->pe.legs.yawing);
ADDRLP4 24+4
INDIRF4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 476
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1679
;1679:	}
LABELV $827
line 1683
;1680:
;1681:
;1682:
;1683:	torsoAngles[YAW] = cent->pe.torso.yawAngle;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRF4
ASGNF4
line 1684
;1684:	legsAngles[YAW] = cent->pe.legs.yawAngle;
ADDRLP4 24+4
ADDRFP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ASGNF4
line 1692
;1685:
;1686:
;1687:	// --------- pitch -------------
;1688:	// turn head if reached the eye tolerance limit
;1689:
;1690:	// only show a fraction of the pitch angle in the torso
;1691:
;1692:	{
line 1693
;1693:		if (headAngles[PITCH] > 180) {
ADDRLP4 12
INDIRF4
CNSTF4 1127481344
LEF4 $839
line 1694
;1694:			dest = (-360 + headAngles[PITCH]) * 0.75f;
ADDRLP4 68
CNSTF4 1061158912
ADDRLP4 12
INDIRF4
CNSTF4 3283353600
ADDF4
MULF4
ASGNF4
line 1695
;1695:		} else {
ADDRGP4 $840
JUMPV
LABELV $839
line 1696
;1696:			dest = headAngles[PITCH] * 0.75f;
ADDRLP4 68
CNSTF4 1061158912
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 1697
;1697:		}
LABELV $840
line 1698
;1698:	}
line 1699
;1699:	if (cg_cameramode.integer == 1) {
ADDRGP4 cg_cameramode+12
INDIRI4
CNSTI4 1
NEI4 $841
line 1700
;1700:		CG_SwingAngles(dest, 15, 30, 0.1f, &cent->pe.torso.pitchAngle, &cent->pe.torso.pitching);
ADDRLP4 68
INDIRF4
ARGF4
CNSTF4 1097859072
ARGF4
CNSTF4 1106247680
ARGF4
CNSTF4 1036831949
ARGF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 532
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1702
;1701:
;1702:		headAngles[PITCH] = cent->pe.torso.pitchAngle;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ASGNF4
line 1705
;1703:		//headAngles[YAW] = cent->pe.torso.yawAngle;
;1704:
;1705:		headAngles[YAW] = torsoAngles[YAW] + 0.25 * movementOffsets[ dir ];
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1048576000
ADDRLP4 56
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $794
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 1706
;1706:		torsoAngles[PITCH] = cent->pe.torso.pitchAngle;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ASGNF4
line 1707
;1707:	} else {
ADDRGP4 $842
JUMPV
LABELV $841
line 1708
;1708:		CG_SwingAngles(dest, 15, 30, 0.1f, &cent->pe.torso.pitchAngle, &cent->pe.torso.pitching);
ADDRLP4 68
INDIRF4
ARGF4
CNSTF4 1097859072
ARGF4
CNSTF4 1106247680
ARGF4
CNSTF4 1036831949
ARGF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 532
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1710
;1709:
;1710:		torsoAngles[PITCH] = cent->pe.torso.pitchAngle;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ASGNF4
line 1711
;1711:	}
LABELV $842
line 1714
;1712:
;1713:	//
;1714:	clientNum = cent->currentState.clientNum;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1715
;1715:	if (clientNum >= 0 && clientNum < MAX_CLIENTS) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $846
ADDRLP4 36
INDIRI4
CNSTI4 64
GEI4 $846
line 1716
;1716:		ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 60
CNSTI4 2120
ADDRLP4 36
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 1717
;1717:		if (ci->fixedtorso) {
ADDRLP4 60
INDIRP4
CNSTI4 492
ADDP4
INDIRI4
CNSTI4 0
EQI4 $849
line 1718
;1718:			torsoAngles[PITCH] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1719
;1719:		}
LABELV $849
line 1723
;1720:	//	if (camereyes) {
;1721:	//		torsoAngles[PITCH] = 0.0f; // don't pitch 
;1722:	//	}
;1723:	}
LABELV $846
line 1731
;1724:
;1725:
;1726:
;1727:	// --------- roll -------------
;1728:
;1729:
;1730:	// lean towards the direction of travel
;1731:	VectorCopy(cent->currentState.pos.trDelta, velocity);
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1732
;1732:	speed = VectorNormalize(velocity);
ADDRLP4 40
ARGP4
ADDRLP4 96
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 96
INDIRF4
ASGNF4
line 1733
;1733:	if (speed) {
ADDRLP4 52
INDIRF4
CNSTF4 0
EQF4 $851
line 1737
;1734:		vec3_t axis[3];
;1735:		float side;
;1736:
;1737:		speed *= 0.05f;
ADDRLP4 52
CNSTF4 1028443341
ADDRLP4 52
INDIRF4
MULF4
ASGNF4
line 1739
;1738:
;1739:		AnglesToAxis(legsAngles, axis);
ADDRLP4 24
ARGP4
ADDRLP4 100
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1740
;1740:		side = speed * DotProduct(velocity, axis[1]);
ADDRLP4 136
ADDRLP4 52
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 100+12
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 100+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 100+12+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 1741
;1741:		legsAngles[ROLL] -= side;
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 136
INDIRF4
SUBF4
ASGNF4
line 1743
;1742:
;1743:		side = speed * DotProduct(velocity, axis[0]);
ADDRLP4 136
ADDRLP4 52
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 100+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 100+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 1744
;1744:		legsAngles[PITCH] += side;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 136
INDIRF4
ADDF4
ASGNF4
line 1745
;1745:	}
LABELV $851
line 1748
;1746:
;1747:	//
;1748:	clientNum = cent->currentState.clientNum;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1749
;1749:	if (clientNum >= 0 && clientNum < MAX_CLIENTS) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $865
ADDRLP4 36
INDIRI4
CNSTI4 64
GEI4 $865
line 1750
;1750:		ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 60
CNSTI4 2120
ADDRLP4 36
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 1753
;1751:
;1752:
;1753:		if (ci->fixedlegs) {
ADDRLP4 60
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 0
EQI4 $868
line 1754
;1754:			legsAngles[YAW] = torsoAngles[YAW];
ADDRLP4 24+4
ADDRLP4 0+4
INDIRF4
ASGNF4
line 1755
;1755:			legsAngles[PITCH] = 0.0f;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 1756
;1756:			legsAngles[ROLL] = 0.0f;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 1757
;1757:		}
LABELV $868
line 1759
;1758:
;1759:	}
LABELV $865
line 1762
;1760:
;1761:	// pain twitch
;1762:	CG_AddPainTwitch(cent, torsoAngles);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_AddPainTwitch
CALLV
pop
line 1767
;1763:	// TODO: make eyes erode on pain twitch
;1764:
;1765:	// leilei - eyes hack
;1766:
;1767:	if (camereyes) {
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $873
line 1768
;1768:		cent->eyesAngles[YAW] = headAngles[YAW];
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 1769
;1769:		cent->eyesAngles[PITCH] = headAngles[PITCH];
ADDRFP4 0
INDIRP4
CNSTI4 816
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 1770
;1770:		cent->eyesAngles[ROLL] = headAngles[ROLL];
ADDRFP4 0
INDIRP4
CNSTI4 824
ADDP4
ADDRLP4 12+8
INDIRF4
ASGNF4
line 1771
;1771:	}
LABELV $873
line 1774
;1772:
;1773:	// pull the angles back out of the hierarchial chain
;1774:	AnglesSubtract(headAngles, torsoAngles, headAngles);
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1775
;1775:	AnglesSubtract(torsoAngles, legsAngles, torsoAngles);
ADDRLP4 0
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1776
;1776:	AnglesToAxis(legsAngles, legs);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1777
;1777:	AnglesToAxis(torsoAngles, torso);
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1778
;1778:	AnglesToAxis(headAngles, head);
ADDRLP4 12
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1781
;1779:
;1780:	// eyes crap
;1781:	{
line 1785
;1782:		vec3_t eyelookfrom;
;1783:
;1784:		// offset from the model we have.
;1785:		VectorClear(eyelookfrom);
ADDRLP4 116
CNSTF4 0
ASGNF4
ADDRLP4 104+8
ADDRLP4 116
INDIRF4
ASGNF4
ADDRLP4 104+4
ADDRLP4 116
INDIRF4
ASGNF4
ADDRLP4 104
ADDRLP4 116
INDIRF4
ASGNF4
line 1786
;1786:		if (ci) {
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $879
line 1787
;1787:			VectorCopy(ci->eyepos, cent->pe.eyepos);
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 2104
ADDP4
INDIRB
ASGNB 12
line 1788
;1788:		}
LABELV $879
line 1790
;1789:		//VectorCopy(eyelookfrom, cent->pe.eyepos);			// leilei - copy eye poistion
;1790:	}
line 1792
;1791:
;1792:}
LABELV $793
endproc CG_PlayerAngles 140 24
proc CG_HasteTrail 40 48
line 1802
;1793:
;1794:
;1795://==========================================================================
;1796:
;1797:/*
;1798:===============
;1799:CG_HasteTrail
;1800:===============
;1801: */
;1802:static void CG_HasteTrail(centity_t *cent) {
line 1807
;1803:	localEntity_t *smoke;
;1804:	vec3_t origin;
;1805:	int anim;
;1806:
;1807:	if (cent->trailTime > cg.time) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $882
line 1808
;1808:		return;
ADDRGP4 $881
JUMPV
LABELV $882
line 1810
;1809:	}
;1810:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1811
;1811:	if (anim != LEGS_RUN && anim != LEGS_BACK) {
ADDRLP4 12
INDIRI4
CNSTI4 15
EQI4 $885
ADDRLP4 12
INDIRI4
CNSTI4 16
EQI4 $885
line 1812
;1812:		return;
ADDRGP4 $881
JUMPV
LABELV $885
line 1815
;1813:	}
;1814:
;1815:	cent->trailTime += 100;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1816
;1816:	if (cent->trailTime < cg.time) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $887
line 1817
;1817:		cent->trailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1818
;1818:	}
LABELV $887
line 1820
;1819:
;1820:	VectorCopy(cent->lerpOrigin, origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 1821
;1821:	origin[2] -= 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1823
;1822:
;1823:	smoke = CG_SmokePuff(origin, vec3_origin,
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 1140457472
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 cgs+180268+572
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 1833
;1824:			8,
;1825:			1, 1, 1, 1,
;1826:			500,
;1827:			cg.time,
;1828:			0,
;1829:			0,
;1830:			cgs.media.hastePuffShader);
;1831:
;1832:	// use the optimized local entity add
;1833:	smoke->leType = LE_SCALE_FADE;
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 7
ASGNI4
line 1834
;1834:}
LABELV $881
endproc CG_HasteTrail 40 48
proc CG_BreathPuffs 64 48
line 1841
;1835:
;1836:/*
;1837:===============
;1838:CG_BreathPuffs
;1839:===============
;1840: */
;1841:static void CG_BreathPuffs(centity_t *cent, refEntity_t *head) {
line 1846
;1842:	clientInfo_t *ci;
;1843:	vec3_t up, origin;
;1844:	int contents;
;1845:
;1846:	ci = &cgs.clientinfo[ cent->currentState.number ];
ADDRLP4 24
CNSTI4 2120
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 1848
;1847:
;1848:	if (!cg_enableBreath.integer) {
ADDRGP4 cg_enableBreath+12
INDIRI4
CNSTI4 0
NEI4 $897
line 1849
;1849:		return;
ADDRGP4 $895
JUMPV
LABELV $897
line 1851
;1850:	}
;1851:	if (cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $900
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $900
line 1852
;1852:		return;
ADDRGP4 $895
JUMPV
LABELV $900
line 1854
;1853:	}
;1854:	if (cent->currentState.eFlags & EF_DEAD) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $904
line 1855
;1855:		return;
ADDRGP4 $895
JUMPV
LABELV $904
line 1857
;1856:	}
;1857:	contents = CG_PointContents(head->origin, 0);
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 32
INDIRI4
ASGNI4
line 1858
;1858:	if (contents & (CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA)) {
ADDRLP4 28
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $906
line 1859
;1859:		return;
ADDRGP4 $895
JUMPV
LABELV $906
line 1861
;1860:	}
;1861:	if (ci->breathPuffTime > cg.time) {
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $908
line 1862
;1862:		return;
ADDRGP4 $895
JUMPV
LABELV $908
line 1865
;1863:	}
;1864:
;1865:	VectorSet(up, 0, 0, 8);
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 12
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12+8
CNSTF4 1090519040
ASGNF4
line 1866
;1866:	VectorMA(head->origin, 8, head->axis[0], origin);
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 44
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 44
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 40
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 44
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 48
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 48
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 48
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1867
;1867:	VectorMA(origin, -4, head->axis[2], origin);
ADDRLP4 52
CNSTF4 3229614080
ASGNF4
ADDRLP4 56
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 3229614080
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1868
;1868:	CG_SmokePuff(origin, up, 16, 1, 1, 1, 0.66f, 1500, cg.time, cg.time + 400, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTF4 1098907648
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
CNSTF4 1059648963
ARGF4
CNSTF4 1153138688
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 400
ADDI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+180268+348
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 1869
;1869:	ci->breathPuffTime = cg.time + 2000;
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1870
;1870:}
LABELV $895
endproc CG_BreathPuffs 64 48
proc CG_DustTrail 112 48
line 1877
;1871:
;1872:/*
;1873:===============
;1874:CG_DustTrail
;1875:===============
;1876: */
;1877:static void CG_DustTrail(centity_t *cent) {
line 1882
;1878:	int anim;
;1879:	vec3_t end, vel;
;1880:	trace_t tr;
;1881:
;1882:	if (!cg_enableDust.integer)
ADDRGP4 cg_enableDust+12
INDIRI4
CNSTI4 0
NEI4 $925
line 1883
;1883:		return;
ADDRGP4 $924
JUMPV
LABELV $925
line 1885
;1884:
;1885:	if (cent->dustTrailTime > cg.time) {
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $928
line 1886
;1886:		return;
ADDRGP4 $924
JUMPV
LABELV $928
line 1889
;1887:	}
;1888:
;1889:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1890
;1890:	if (anim != LEGS_LANDB && anim != LEGS_LAND) {
ADDRLP4 24
INDIRI4
CNSTI4 21
EQI4 $931
ADDRLP4 24
INDIRI4
CNSTI4 19
EQI4 $931
line 1891
;1891:		return;
ADDRGP4 $924
JUMPV
LABELV $931
line 1894
;1892:	}
;1893:
;1894:	cent->dustTrailTime += 40;
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 40
ADDI4
ASGNI4
line 1895
;1895:	if (cent->dustTrailTime < cg.time) {
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $933
line 1896
;1896:		cent->dustTrailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1897
;1897:	}
LABELV $933
line 1899
;1898:
;1899:	VectorCopy(cent->currentState.pos.trBase, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1900
;1900:	end[2] -= 64;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 1901
;1901:	CG_Trace(&tr, cent->currentState.pos.trBase, NULL, NULL, end, cent->currentState.number, MASK_PLAYERSOLID);
ADDRLP4 28
ARGP4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 96
CNSTP4 0
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 92
INDIRP4
INDIRI4
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 1903
;1902:
;1903:	if (!(tr.surfaceFlags & SURF_DUST))
ADDRLP4 28+44
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
NEI4 $938
line 1904
;1904:		return;
ADDRGP4 $924
JUMPV
LABELV $938
line 1906
;1905:
;1906:	VectorCopy(cent->currentState.pos.trBase, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1907
;1907:	end[2] -= 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1909
;1908:
;1909:	VectorSet(vel, 0, 0, -30);
ADDRLP4 100
CNSTF4 0
ASGNF4
ADDRLP4 12
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 12+8
CNSTF4 3253731328
ASGNF4
line 1910
;1910:	CG_SmokePuff(end, vel,
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTF4 1103101952
ARGF4
ADDRLP4 104
CNSTF4 1061997773
ASGNF4
ADDRLP4 104
INDIRF4
ARGF4
ADDRLP4 104
INDIRF4
ARGF4
CNSTF4 1060320051
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1140457472
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 cgs+180268+692
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 1918
;1911:			24,
;1912:			.8f, .8f, 0.7f, 0.33f,
;1913:			500,
;1914:			cg.time,
;1915:			0,
;1916:			0,
;1917:			cgs.media.dustPuffShader);
;1918:}
LABELV $924
endproc CG_DustTrail 112 48
proc CG_TrailItem 224 12
line 1925
;1919:
;1920:/*
;1921:===============
;1922:CG_TrailItem
;1923:===============
;1924: */
;1925:static void CG_TrailItem(centity_t *cent, qhandle_t hModel) {
line 1930
;1926:	refEntity_t ent;
;1927:	vec3_t angles;
;1928:	vec3_t axis[3];
;1929:
;1930:	VectorCopy(cent->lerpAngles, angles);
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRB
ASGNB 12
line 1931
;1931:	angles[PITCH] = 0;
ADDRLP4 176
CNSTF4 0
ASGNF4
line 1932
;1932:	angles[ROLL] = 0;
ADDRLP4 176+8
CNSTF4 0
ASGNF4
line 1933
;1933:	AnglesToAxis(angles, axis);
ADDRLP4 176
ARGP4
ADDRLP4 188
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1935
;1934:
;1935:	memset(&ent, 0, sizeof ( ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1936
;1936:	VectorMA(cent->lerpOrigin, -16, axis[0], ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRF4
CNSTF4 3246391296
ADDRLP4 188
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRF4
CNSTF4 3246391296
ADDRLP4 188+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRF4
CNSTF4 3246391296
ADDRLP4 188+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1937
;1937:	ent.origin[2] += 16;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1938
;1938:	angles[YAW] += 90;
ADDRLP4 176+4
ADDRLP4 176+4
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 1939
;1939:	AnglesToAxis(angles, ent.axis);
ADDRLP4 176
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1941
;1940:
;1941:	ent.hModel = hModel;
ADDRLP4 0+8
ADDRFP4 4
INDIRI4
ASGNI4
line 1942
;1942:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1943
;1943:}
LABELV $947
endproc CG_TrailItem 224 12
proc CG_PlayerFlag 428 24
line 1950
;1944:
;1945:/*
;1946:===============
;1947:CG_PlayerFlag
;1948:===============
;1949: */
;1950:static void CG_PlayerFlag(centity_t *cent, qhandle_t hSkin, refEntity_t *torso) {
line 1959
;1951:	clientInfo_t *ci;
;1952:	refEntity_t pole;
;1953:	refEntity_t flag;
;1954:	vec3_t angles, dir;
;1955:	int legsAnim, flagAnim, updateangles;
;1956:	float angle, d;
;1957:
;1958:	// show the flag pole model
;1959:	memset(&pole, 0, sizeof (pole));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1960
;1960:	pole.hModel = cgs.media.flagPoleModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+120
INDIRI4
ASGNI4
line 1961
;1961:	VectorCopy(torso->lightingOrigin, pole.lightingOrigin);
ADDRLP4 0+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1962
;1962:	pole.shadowPlane = torso->shadowPlane;
ADDRLP4 0+24
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1963
;1963:	pole.renderfx = torso->renderfx;
ADDRLP4 0+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1964
;1964:	CG_PositionEntityOnTag(&pole, torso, torso->hModel, "tag_flag");
ADDRLP4 0
ARGP4
ADDRLP4 400
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 400
INDIRP4
ARGP4
ADDRLP4 400
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $487
ARGP4
ADDRGP4 CG_PositionEntityOnTag
CALLV
pop
line 1965
;1965:	trap_R_AddRefEntityToScene(&pole);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1968
;1966:
;1967:	// show the flag model
;1968:	memset(&flag, 0, sizeof (flag));
ADDRLP4 176
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1969
;1969:	flag.hModel = cgs.media.flagFlapModel;
ADDRLP4 176+8
ADDRGP4 cgs+180268+124
INDIRI4
ASGNI4
line 1970
;1970:	flag.customSkin = hSkin;
ADDRLP4 176+108
ADDRFP4 4
INDIRI4
ASGNI4
line 1971
;1971:	VectorCopy(torso->lightingOrigin, flag.lightingOrigin);
ADDRLP4 176+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1972
;1972:	flag.shadowPlane = torso->shadowPlane;
ADDRLP4 176+24
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1973
;1973:	flag.renderfx = torso->renderfx;
ADDRLP4 176+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1975
;1974:
;1975:	VectorClear(angles);
ADDRLP4 404
CNSTF4 0
ASGNF4
ADDRLP4 352+8
ADDRLP4 404
INDIRF4
ASGNF4
ADDRLP4 352+4
ADDRLP4 404
INDIRF4
ASGNF4
ADDRLP4 352
ADDRLP4 404
INDIRF4
ASGNF4
line 1977
;1976:
;1977:	updateangles = qfalse;
ADDRLP4 384
CNSTI4 0
ASGNI4
line 1978
;1978:	legsAnim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 376
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1979
;1979:	if (legsAnim == LEGS_IDLE || legsAnim == LEGS_IDLECR) {
ADDRLP4 376
INDIRI4
CNSTI4 22
EQI4 $979
ADDRLP4 376
INDIRI4
CNSTI4 23
NEI4 $977
LABELV $979
line 1980
;1980:		flagAnim = FLAG_STAND;
ADDRLP4 392
CNSTI4 49
ASGNI4
line 1981
;1981:	} else if (legsAnim == LEGS_WALK || legsAnim == LEGS_WALKCR) {
ADDRGP4 $978
JUMPV
LABELV $977
ADDRLP4 376
INDIRI4
CNSTI4 14
EQI4 $982
ADDRLP4 376
INDIRI4
CNSTI4 13
NEI4 $980
LABELV $982
line 1982
;1982:		flagAnim = FLAG_STAND;
ADDRLP4 392
CNSTI4 49
ASGNI4
line 1983
;1983:		updateangles = qtrue;
ADDRLP4 384
CNSTI4 1
ASGNI4
line 1984
;1984:	} else {
ADDRGP4 $981
JUMPV
LABELV $980
line 1985
;1985:		flagAnim = FLAG_RUN;
ADDRLP4 392
CNSTI4 48
ASGNI4
line 1986
;1986:		updateangles = qtrue;
ADDRLP4 384
CNSTI4 1
ASGNI4
line 1987
;1987:	}
LABELV $981
LABELV $978
line 1989
;1988:
;1989:	if (updateangles) {
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $983
line 1991
;1990:
;1991:		VectorCopy(cent->currentState.pos.trDelta, dir);
ADDRLP4 364
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1993
;1992:		// add gravity
;1993:		dir[2] += 100;
ADDRLP4 364+8
ADDRLP4 364+8
INDIRF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 1994
;1994:		VectorNormalize(dir);
ADDRLP4 364
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1995
;1995:		d = DotProduct(pole.axis[2], dir);
ADDRLP4 380
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 364
INDIRF4
MULF4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 364+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 364+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1997
;1996:		// if there is anough movement orthogonal to the flag pole
;1997:		if (fabs(d) < 0.9) {
ADDRLP4 380
INDIRF4
ARGF4
ADDRLP4 416
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 416
INDIRF4
CNSTF4 1063675494
GEF4 $996
line 1999
;1998:			//
;1999:			d = DotProduct(pole.axis[0], dir);
ADDRLP4 380
ADDRLP4 0+28
INDIRF4
ADDRLP4 364
INDIRF4
MULF4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 364+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 364+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2000
;2000:			if (d > 1.0f) {
ADDRLP4 380
INDIRF4
CNSTF4 1065353216
LEF4 $1005
line 2001
;2001:				d = 1.0f;
ADDRLP4 380
CNSTF4 1065353216
ASGNF4
line 2002
;2002:			} else if (d < -1.0f) {
ADDRGP4 $1006
JUMPV
LABELV $1005
ADDRLP4 380
INDIRF4
CNSTF4 3212836864
GEF4 $1007
line 2003
;2003:				d = -1.0f;
ADDRLP4 380
CNSTF4 3212836864
ASGNF4
line 2004
;2004:			}
LABELV $1007
LABELV $1006
line 2005
;2005:			angle = acos(d);
ADDRLP4 380
INDIRF4
ARGF4
ADDRLP4 420
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 396
ADDRLP4 420
INDIRF4
ASGNF4
line 2007
;2006:
;2007:			d = DotProduct(pole.axis[1], dir);
ADDRLP4 380
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 364
INDIRF4
MULF4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 364+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 364+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2008
;2008:			if (d < 0) {
ADDRLP4 380
INDIRF4
CNSTF4 0
GEF4 $1019
line 2009
;2009:				angles[YAW] = 360 - angle * 180 / M_PI;
ADDRLP4 352+4
CNSTF4 1135869952
CNSTF4 1127481344
ADDRLP4 396
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
SUBF4
ASGNF4
line 2010
;2010:			} else {
ADDRGP4 $1020
JUMPV
LABELV $1019
line 2011
;2011:				angles[YAW] = angle * 180 / M_PI;
ADDRLP4 352+4
CNSTF4 1127481344
ADDRLP4 396
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 2012
;2012:			}
LABELV $1020
line 2013
;2013:			if (angles[YAW] < 0)
ADDRLP4 352+4
INDIRF4
CNSTF4 0
GEF4 $1023
line 2014
;2014:				angles[YAW] += 360;
ADDRLP4 352+4
ADDRLP4 352+4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $1023
line 2015
;2015:			if (angles[YAW] > 360)
ADDRLP4 352+4
INDIRF4
CNSTF4 1135869952
LEF4 $1027
line 2016
;2016:				angles[YAW] -= 360;
ADDRLP4 352+4
ADDRLP4 352+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1027
line 2021
;2017:
;2018:			//vectoangles( cent->currentState.pos.trDelta, tmpangles );
;2019:			//angles[YAW] = tmpangles[YAW] + 45 - cent->pe.torso.yawAngle;
;2020:			// change the yaw angle
;2021:			CG_SwingAngles(angles[YAW], 25, 90, 0.15f, &cent->pe.flag.yawAngle, &cent->pe.flag.yawing);
ADDRLP4 352+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1041865114
ARGF4
ADDRLP4 424
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 424
INDIRP4
CNSTI4 568
ADDP4
ARGP4
ADDRLP4 424
INDIRP4
CNSTI4 572
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 2022
;2022:		}
LABELV $996
line 2023
;2023:	}
LABELV $983
line 2026
;2024:
;2025:	// set the yaw angle
;2026:	angles[YAW] = cent->pe.flag.yawAngle;
ADDRLP4 352+4
ADDRFP4 0
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
ASGNF4
line 2028
;2027:	// lerp the flag animation frames
;2028:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 388
CNSTI4 2120
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 2029
;2029:	CG_RunLerpFrame(ci, &cent->pe.flag, flagAnim, 1);
ADDRLP4 388
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
ARGP4
ADDRLP4 392
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 2030
;2030:	flag.oldframe = cent->pe.flag.oldFrame;
ADDRLP4 176+96
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
line 2031
;2031:	flag.frame = cent->pe.flag.frame;
ADDRLP4 176+80
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ASGNI4
line 2032
;2032:	flag.backlerp = cent->pe.flag.backlerp;
ADDRLP4 176+100
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRF4
ASGNF4
line 2034
;2033:
;2034:	AnglesToAxis(angles, flag.axis);
ADDRLP4 352
ARGP4
ADDRLP4 176+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2035
;2035:	CG_PositionRotatedEntityOnTag(&flag, &pole, pole.hModel, "tag_flag");
ADDRLP4 176
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $487
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2037
;2036:
;2037:	trap_R_AddRefEntityToScene(&flag);
ADDRLP4 176
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2038
;2038:}
LABELV $961
endproc CG_PlayerFlag 428 24
proc CG_PlayerTokens 232 12
line 2045
;2039:
;2040:/*
;2041:===============
;2042:CG_PlayerTokens
;2043:===============
;2044: */
;2045:static void CG_PlayerTokens(centity_t *cent, int renderfx) {
line 2051
;2046:	int tokens, i, j;
;2047:	float angle;
;2048:	refEntity_t ent;
;2049:	vec3_t dir, origin;
;2050:	skulltrail_t *trail;
;2051:	if (cent->currentState.number >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 64
LTI4 $1040
line 2052
;2052:		return;
ADDRGP4 $1039
JUMPV
LABELV $1040
line 2054
;2053:	}
;2054:	trail = &cg.skulltrails[cent->currentState.number];
ADDRLP4 4
CNSTI4 124
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg+116008
ADDP4
ASGNP4
line 2055
;2055:	tokens = cent->currentState.generic1;
ADDRLP4 216
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 2056
;2056:	if (!tokens) {
ADDRLP4 216
INDIRI4
CNSTI4 0
NEI4 $1043
line 2057
;2057:		trail->numpositions = 0;
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
CNSTI4 0
ASGNI4
line 2058
;2058:		return;
ADDRGP4 $1039
JUMPV
LABELV $1043
line 2061
;2059:	}
;2060:
;2061:	if (tokens > MAX_SKULLTRAIL) {
ADDRLP4 216
INDIRI4
CNSTI4 10
LEI4 $1045
line 2062
;2062:		tokens = MAX_SKULLTRAIL;
ADDRLP4 216
CNSTI4 10
ASGNI4
line 2063
;2063:	}
LABELV $1045
line 2066
;2064:
;2065:	// add skulls if there are more than last time
;2066:	for (i = 0; i < tokens - trail->numpositions; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1050
JUMPV
LABELV $1047
line 2067
;2067:		for (j = trail->numpositions; j > 0; j--) {
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $1054
JUMPV
LABELV $1051
line 2068
;2068:			VectorCopy(trail->positions[j - 1], trail->positions[j]);
ADDRLP4 220
CNSTI4 12
ASGNI4
ADDRLP4 224
ADDRLP4 220
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 224
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 224
INDIRI4
ADDRLP4 220
INDIRI4
SUBI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 2069
;2069:		}
LABELV $1052
line 2067
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1054
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $1051
line 2070
;2070:		VectorCopy(cent->lerpOrigin, trail->positions[0]);
ADDRLP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2071
;2071:	}
LABELV $1048
line 2066
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1050
ADDRLP4 8
INDIRI4
ADDRLP4 216
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
SUBI4
LTI4 $1047
line 2072
;2072:	trail->numpositions = tokens;
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 216
INDIRI4
ASGNI4
line 2075
;2073:
;2074:	// move all the skulls along the trail
;2075:	VectorCopy(cent->lerpOrigin, origin);
ADDRLP4 188
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2076
;2076:	for (i = 0; i < trail->numpositions; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1058
JUMPV
LABELV $1055
line 2077
;2077:		VectorSubtract(trail->positions[i], origin, dir);
ADDRLP4 220
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
ADDRLP4 200
ADDRLP4 220
INDIRP4
INDIRF4
ADDRLP4 188
INDIRF4
SUBF4
ASGNF4
ADDRLP4 200+4
ADDRLP4 220
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 188+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 200+8
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 188+8
INDIRF4
SUBF4
ASGNF4
line 2078
;2078:		if (VectorNormalize(dir) > 30) {
ADDRLP4 200
ARGP4
ADDRLP4 224
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 224
INDIRF4
CNSTF4 1106247680
LEF4 $1063
line 2079
;2079:			VectorMA(origin, 30, dir, trail->positions[i]);
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 188
INDIRF4
CNSTF4 1106247680
ADDRLP4 200
INDIRF4
MULF4
ADDF4
ASGNF4
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 188+4
INDIRF4
CNSTF4 1106247680
ADDRLP4 200+4
INDIRF4
MULF4
ADDF4
ASGNF4
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 188+8
INDIRF4
CNSTF4 1106247680
ADDRLP4 200+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2080
;2080:		}
LABELV $1063
line 2081
;2081:		VectorCopy(trail->positions[i], origin);
ADDRLP4 188
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 2082
;2082:	}
LABELV $1056
line 2076
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1058
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
LTI4 $1055
line 2084
;2083:
;2084:	memset(&ent, 0, sizeof ( ent));
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2085
;2085:	if (cgs.clientinfo[ cent->currentState.clientNum ].team == TEAM_BLUE) {
CNSTI4 2120
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1069
line 2086
;2086:		ent.hModel = cgs.media.redCubeModel;
ADDRLP4 12+8
ADDRGP4 cgs+180268+20
INDIRI4
ASGNI4
line 2087
;2087:	} else {
ADDRGP4 $1070
JUMPV
LABELV $1069
line 2088
;2088:		ent.hModel = cgs.media.blueCubeModel;
ADDRLP4 12+8
ADDRGP4 cgs+180268+24
INDIRI4
ASGNI4
line 2089
;2089:	}
LABELV $1070
line 2090
;2090:	ent.renderfx = renderfx;
ADDRLP4 12+4
ADDRFP4 4
INDIRI4
ASGNI4
line 2092
;2091:
;2092:	VectorCopy(cent->lerpOrigin, origin);
ADDRLP4 188
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2093
;2093:	for (i = 0; i < trail->numpositions; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1083
JUMPV
LABELV $1080
line 2094
;2094:		VectorSubtract(origin, trail->positions[i], ent.axis[0]);
ADDRLP4 12+28
ADDRLP4 188
INDIRF4
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+28+4
ADDRLP4 188+4
INDIRF4
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+28+8
ADDRLP4 188+8
INDIRF4
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2095
;2095:		ent.axis[0][2] = 0;
ADDRLP4 12+28+8
CNSTF4 0
ASGNF4
line 2096
;2096:		VectorNormalize(ent.axis[0]);
ADDRLP4 12+28
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2097
;2097:		VectorSet(ent.axis[2], 0, 0, 1);
ADDRLP4 12+28+24
CNSTF4 0
ASGNF4
ADDRLP4 12+28+24+4
CNSTF4 0
ASGNF4
ADDRLP4 12+28+24+8
CNSTF4 1065353216
ASGNF4
line 2098
;2098:		CrossProduct(ent.axis[0], ent.axis[2], ent.axis[1]);
ADDRLP4 12+28
ARGP4
ADDRLP4 12+28+24
ARGP4
ADDRLP4 12+28+12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2100
;2099:
;2100:		VectorCopy(trail->positions[i], ent.origin);
ADDRLP4 12+68
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 2101
;2101:		angle = (((cg.time + 500 * MAX_SKULLTRAIL - 500 * i) / 16) & 255) * (M_PI * 2) / 255;
ADDRLP4 212
CNSTF4 1086918619
ADDRGP4 cg+107604
INDIRI4
CNSTI4 5000
ADDI4
CNSTI4 500
ADDRLP4 8
INDIRI4
MULI4
SUBI4
CNSTI4 16
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
ASGNF4
line 2102
;2102:		ent.origin[2] += sin(angle) * 10;
ADDRLP4 212
INDIRF4
ARGF4
ADDRLP4 220
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 12+68+8
ADDRLP4 12+68+8
INDIRF4
CNSTF4 1092616192
ADDRLP4 220
INDIRF4
MULF4
ADDF4
ASGNF4
line 2103
;2103:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2104
;2104:		VectorCopy(trail->positions[i], origin);
ADDRLP4 188
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 2105
;2105:	}
LABELV $1081
line 2093
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1083
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
LTI4 $1080
line 2106
;2106:}
LABELV $1039
endproc CG_PlayerTokens 232 12
proc CG_PlayerPowerups 16 20
line 2113
;2107:
;2108:/*
;2109:===============
;2110:CG_PlayerPowerups
;2111:===============
;2112: */
;2113:static void CG_PlayerPowerups(centity_t *cent, refEntity_t *torso) {
line 2117
;2114:	int powerups;
;2115:	clientInfo_t *ci;
;2116:
;2117:	powerups = cent->currentState.powerups;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 2118
;2118:	if (!powerups) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1112
line 2119
;2119:		return;
ADDRGP4 $1111
JUMPV
LABELV $1112
line 2123
;2120:	}
;2121:
;2122:	// quad gives a dlight
;2123:	if (powerups & (1 << PW_QUAD)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1114
line 2124
;2124:		trap_R_AddLightToScene(cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1);
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1045220557
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2125
;2125:	}
LABELV $1114
line 2128
;2126:
;2127:	// flight plays a looped sound
;2128:	if (powerups & (1 << PW_FLIGHT)) {
ADDRLP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1116
line 2129
;2129:		trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.flightSound);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+180268+1256
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 2130
;2130:	}
LABELV $1116
line 2132
;2131:
;2132:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 4
CNSTI4 2120
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 2134
;2133:	// redflag
;2134:	if (powerups & (1 << PW_REDFLAG)) {
ADDRLP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1121
line 2135
;2135:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1123
line 2136
;2136:			CG_PlayerFlag(cent, cgs.media.redFlagFlapSkin, torso);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+128
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2137
;2137:		} else {
ADDRGP4 $1124
JUMPV
LABELV $1123
line 2138
;2138:			CG_TrailItem(cent, cgs.media.redFlagModel);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+36
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2139
;2139:		}
LABELV $1124
line 2140
;2140:		trap_R_AddLightToScene(cent->lerpOrigin, 200 + (rand()&31), 1.0, 0.2f, 0.2f);
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 12
CNSTF4 1045220557
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2141
;2141:	}
LABELV $1121
line 2144
;2142:
;2143:	// blueflag
;2144:	if (powerups & (1 << PW_BLUEFLAG)) {
ADDRLP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1129
line 2145
;2145:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1131
line 2146
;2146:			CG_PlayerFlag(cent, cgs.media.blueFlagFlapSkin, torso);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+132
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2147
;2147:		} else {
ADDRGP4 $1132
JUMPV
LABELV $1131
line 2148
;2148:			CG_TrailItem(cent, cgs.media.blueFlagModel);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+40
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2149
;2149:		}
LABELV $1132
line 2150
;2150:		trap_R_AddLightToScene(cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1.0);
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1045220557
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2151
;2151:	}
LABELV $1129
line 2154
;2152:
;2153:	// neutralflag
;2154:	if (powerups & (1 << PW_NEUTRALFLAG)) {
ADDRLP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1137
line 2155
;2155:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1139
line 2156
;2156:			CG_PlayerFlag(cent, cgs.media.neutralFlagFlapSkin, torso);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+136
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2157
;2157:		} else {
ADDRGP4 $1140
JUMPV
LABELV $1139
line 2158
;2158:			CG_TrailItem(cent, cgs.media.neutralFlagModel);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+44
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2159
;2159:		}
LABELV $1140
line 2160
;2160:		trap_R_AddLightToScene(cent->lerpOrigin, 200 + (rand()&31), 1.0, 1.0, 1.0);
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2161
;2161:	}
LABELV $1137
line 2164
;2162:
;2163:	// haste leaves smoke trails
;2164:	if (powerups & (1 << PW_HASTE)) {
ADDRLP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1145
line 2165
;2165:		CG_HasteTrail(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_HasteTrail
CALLV
pop
line 2166
;2166:	}
LABELV $1145
line 2167
;2167:}
LABELV $1111
endproc CG_PlayerPowerups 16 20
proc CG_PlayerFloatSprite 180 12
line 2176
;2168:
;2169:/*
;2170:===============
;2171:CG_PlayerFloatSprite
;2172:
;2173:Float a sprite over the player's head
;2174:===============
;2175: */
;2176:static void CG_PlayerFloatSprite(centity_t *cent, qhandle_t shader) {
line 2180
;2177:	int rf;
;2178:	refEntity_t ent;
;2179:
;2180:	if (cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1148
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1148
line 2181
;2181:		rf = RF_THIRD_PERSON; // only show in mirrors
ADDRLP4 176
CNSTI4 2
ASGNI4
line 2182
;2182:	} else {
ADDRGP4 $1149
JUMPV
LABELV $1148
line 2183
;2183:		rf = 0;
ADDRLP4 176
CNSTI4 0
ASGNI4
line 2184
;2184:	}
LABELV $1149
line 2186
;2185:
;2186:	memset(&ent, 0, sizeof ( ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2187
;2187:	VectorCopy(cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2188
;2188:	ent.origin[2] += 48;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 2189
;2189:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 2190
;2190:	ent.customShader = shader;
ADDRLP4 0+112
ADDRFP4 4
INDIRI4
ASGNI4
line 2191
;2191:	ent.radius = 10;
ADDRLP4 0+132
CNSTF4 1092616192
ASGNF4
line 2192
;2192:	ent.renderfx = rf;
ADDRLP4 0+4
ADDRLP4 176
INDIRI4
ASGNI4
line 2193
;2193:	ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 2194
;2194:	ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 2195
;2195:	ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 2196
;2196:	ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 2197
;2197:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2198
;2198:}
LABELV $1147
endproc CG_PlayerFloatSprite 180 12
proc CG_PlayerSprites 12 8
line 2207
;2199:
;2200:/*
;2201:===============
;2202:CG_PlayerSprites
;2203:
;2204:Float sprites over the player's head
;2205:===============
;2206: */
;2207:static void CG_PlayerSprites(centity_t *cent) {
line 2210
;2208:	int team;
;2209:
;2210:	if (cent->currentState.eFlags & EF_CONNECTION) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1166
line 2211
;2211:		CG_PlayerFloatSprite(cent, cgs.media.connectionShader);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+272
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2212
;2212:		return;
ADDRGP4 $1165
JUMPV
LABELV $1166
line 2215
;2213:	}
;2214:
;2215:	if (cent->currentState.eFlags & EF_TALK) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1170
line 2216
;2216:		CG_PlayerFloatSprite(cent, cgs.media.balloonShader);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+268
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2217
;2217:		return;
ADDRGP4 $1165
JUMPV
LABELV $1170
line 2220
;2218:	}
;2219:
;2220:	if (cent->currentState.eFlags & EF_AWARD_IMPRESSIVE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $1174
line 2221
;2221:		CG_PlayerFloatSprite(cent, cgs.media.medalImpressive);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+720
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2222
;2222:		return;
ADDRGP4 $1165
JUMPV
LABELV $1174
line 2225
;2223:	}
;2224:
;2225:	if (cent->currentState.eFlags & EF_AWARD_EXCELLENT) {
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $1178
line 2226
;2226:		CG_PlayerFloatSprite(cent, cgs.media.medalExcellent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+724
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2227
;2227:		return;
ADDRGP4 $1165
JUMPV
LABELV $1178
line 2230
;2228:	}
;2229:
;2230:	if (cent->currentState.eFlags & EF_AWARD_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1182
line 2231
;2231:		CG_PlayerFloatSprite(cent, cgs.media.medalGauntlet);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+728
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2232
;2232:		return;
ADDRGP4 $1165
JUMPV
LABELV $1182
line 2235
;2233:	}
;2234:
;2235:	if (cent->currentState.eFlags & EF_AWARD_DEFEND) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $1186
line 2236
;2236:		CG_PlayerFloatSprite(cent, cgs.media.medalDefend);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+732
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2237
;2237:		return;
ADDRGP4 $1165
JUMPV
LABELV $1186
line 2240
;2238:	}
;2239:
;2240:	if (cent->currentState.eFlags & EF_AWARD_ASSIST) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1190
line 2241
;2241:		CG_PlayerFloatSprite(cent, cgs.media.medalAssist);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+736
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2242
;2242:		return;
ADDRGP4 $1165
JUMPV
LABELV $1190
line 2245
;2243:	}
;2244:
;2245:	if (cent->currentState.eFlags & EF_AWARD_CAP) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1194
line 2246
;2246:		CG_PlayerFloatSprite(cent, cgs.media.medalCapture);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+740
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2247
;2247:		return;
ADDRGP4 $1165
JUMPV
LABELV $1194
line 2250
;2248:	}
;2249:
;2250:	team = cgs.clientinfo[ cent->currentState.clientNum ].team;
ADDRLP4 0
CNSTI4 2120
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152+68
ADDP4
INDIRI4
ASGNI4
line 2251
;2251:	if (!(cent->currentState.eFlags & EF_DEAD) &&
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1200
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1200
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1200
line 2253
;2252:			cg.snap->ps.persistant[PERS_TEAM] == team &&
;2253:			CG_IsATeamGametype(cgs.gametype)) {
line 2254
;2254:		if (cg_drawFriend.integer) {
ADDRGP4 cg_drawFriend+12
INDIRI4
CNSTI4 0
EQI4 $1165
line 2255
;2255:			CG_PlayerFloatSprite(cent, cgs.media.friendShader);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+180268+264
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2256
;2256:		}
line 2257
;2257:		return;
LABELV $1200
line 2259
;2258:	}
;2259:}
LABELV $1165
endproc CG_PlayerSprites 12 8
lit
align 4
LABELV $1210
byte 4 3245342720
byte 4 3245342720
byte 4 0
align 4
LABELV $1211
byte 4 1097859072
byte 4 1097859072
byte 4 1073741824
code
proc CG_PlayerShadow 104 44
line 2272
;2260:
;2261:/*
;2262:===============
;2263:CG_PlayerShadow
;2264:
;2265:Returns the Z component of the surface being shadowed
;2266:
;2267:  should it return a full plane instead of a Z?
;2268:===============
;2269: */
;2270:#define SHADOW_DISTANCE  128
;2271:
;2272:static qboolean CG_PlayerShadow(centity_t *cent, float *shadowPlane) {
line 2273
;2273:	vec3_t end, mins = {-15, -15, 0}, maxs = {15, 15, 2};
ADDRLP4 72
ADDRGP4 $1210
INDIRB
ASGNB 12
ADDRLP4 84
ADDRGP4 $1211
INDIRB
ASGNB 12
line 2277
;2274:	trace_t trace;
;2275:	float alpha;
;2276:
;2277:	*shadowPlane = 0;
ADDRFP4 4
INDIRP4
CNSTF4 0
ASGNF4
line 2279
;2278:
;2279:	if (cg_shadows.integer == 0) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1212
line 2280
;2280:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1209
JUMPV
LABELV $1212
line 2284
;2281:	}
;2282:
;2283:	// no shadows when invisible
;2284:	if (cent->currentState.powerups & (1 << PW_INVIS)) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1215
line 2285
;2285:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1209
JUMPV
LABELV $1215
line 2289
;2286:	}
;2287:
;2288:	// send a trace down from the player to the ground
;2289:	VectorCopy(cent->lerpOrigin, end);
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2290
;2290:	end[2] -= SHADOW_DISTANCE;
ADDRLP4 60+8
ADDRLP4 60+8
INDIRF4
CNSTF4 1124073472
SUBF4
ASGNF4
line 2292
;2291:
;2292:	trap_CM_BoxTrace(&trace, cent->lerpOrigin, end, mins, maxs, 0, MASK_PLAYERSOLID);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 0
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2295
;2293:
;2294:	// no shadow if too high
;2295:	if (trace.fraction == 1.0 || trace.startsolid || trace.allsolid) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $1223
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRLP4 0+4
INDIRI4
ADDRLP4 96
INDIRI4
NEI4 $1223
ADDRLP4 0
INDIRI4
ADDRLP4 96
INDIRI4
EQI4 $1218
LABELV $1223
line 2296
;2296:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1209
JUMPV
LABELV $1218
line 2299
;2297:	}
;2298:
;2299:	*shadowPlane = trace.endpos[2] + 1;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2301
;2300:
;2301:	if (cg_shadows.integer != 1) { // no mark for stencil or projection shadows
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 1
EQI4 $1226
line 2302
;2302:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1209
JUMPV
LABELV $1226
line 2306
;2303:	}
;2304:
;2305:	// fade the shadow out with height
;2306:	alpha = 1.0 - trace.fraction;
ADDRLP4 56
CNSTF4 1065353216
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2313
;2307:
;2308:	// bk0101022 - hack / FPE - bogus planes?
;2309:	//assert( DotProduct( trace.plane.normal, trace.plane.normal ) != 0.0f ) 
;2310:
;2311:	// add the mark as a temporary, so it goes directly to the renderer
;2312:	// without taking a spot in the cg_marks array
;2313:	CG_ImpactMark(cgs.media.shadowMarkShader, trace.endpos, trace.plane.normal,
ADDRGP4 cgs+180268+496
INDIRI4
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 0+24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTI4 0
ARGI4
CNSTF4 1103101952
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 2316
;2314:			cent->pe.legs.yawAngle, alpha, alpha, alpha, 1, qfalse, 24, qtrue);
;2315:
;2316:	return qtrue;
CNSTI4 1
RETI4
LABELV $1209
endproc CG_PlayerShadow 104 44
proc CG_PlayerSplash 192 28
line 2326
;2317:}
;2318:
;2319:/*
;2320:===============
;2321:CG_PlayerSplash
;2322:
;2323:Draw a mark at the water surface
;2324:===============
;2325: */
;2326:static void CG_PlayerSplash(centity_t *cent) {
line 2332
;2327:	vec3_t start, end;
;2328:	trace_t trace;
;2329:	int contents;
;2330:	polyVert_t verts[4];
;2331:
;2332:	if (!cg_shadows.integer) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1235
line 2333
;2333:		return;
ADDRGP4 $1234
JUMPV
LABELV $1235
line 2336
;2334:	}
;2335:
;2336:	VectorCopy(cent->lerpOrigin, end);
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2337
;2337:	end[2] -= 24;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 2341
;2338:
;2339:	// if the feet aren't in liquid, don't make a mark
;2340:	// this won't handle moving water brushes, but they wouldn't draw right anyway...
;2341:	contents = CG_PointContents(end, 0);
ADDRLP4 164
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 180
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 176
ADDRLP4 180
INDIRI4
ASGNI4
line 2342
;2342:	if (!(contents & (CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA))) {
ADDRLP4 176
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $1239
line 2343
;2343:		return;
ADDRGP4 $1234
JUMPV
LABELV $1239
line 2346
;2344:	}
;2345:
;2346:	VectorCopy(cent->lerpOrigin, start);
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2347
;2347:	start[2] += 32;
ADDRLP4 152+8
ADDRLP4 152+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2350
;2348:
;2349:	// if the head isn't out of liquid, don't make a mark
;2350:	contents = CG_PointContents(start, 0);
ADDRLP4 152
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 184
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 176
ADDRLP4 184
INDIRI4
ASGNI4
line 2351
;2351:	if (contents & (CONTENTS_SOLID | CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA)) {
ADDRLP4 176
INDIRI4
CNSTI4 57
BANDI4
CNSTI4 0
EQI4 $1242
line 2352
;2352:		return;
ADDRGP4 $1234
JUMPV
LABELV $1242
line 2356
;2353:	}
;2354:
;2355:	// trace down to find the surface
;2356:	trap_CM_BoxTrace(&trace, start, end, NULL, NULL, 0, (CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA));
ADDRLP4 96
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 164
ARGP4
ADDRLP4 188
CNSTP4 0
ASGNP4
ADDRLP4 188
INDIRP4
ARGP4
ADDRLP4 188
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2358
;2357:
;2358:	if (trace.fraction == 1.0) {
ADDRLP4 96+8
INDIRF4
CNSTF4 1065353216
NEF4 $1244
line 2359
;2359:		return;
ADDRGP4 $1234
JUMPV
LABELV $1244
line 2363
;2360:	}
;2361:
;2362:	// create a mark polygon
;2363:	VectorCopy(trace.endpos, verts[0].xyz);
ADDRLP4 0
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2364
;2364:	verts[0].xyz[0] -= 32;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2365
;2365:	verts[0].xyz[1] -= 32;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2366
;2366:	verts[0].st[0] = 0;
ADDRLP4 0+12
CNSTF4 0
ASGNF4
line 2367
;2367:	verts[0].st[1] = 0;
ADDRLP4 0+12+4
CNSTF4 0
ASGNF4
line 2368
;2368:	verts[0].modulate[0] = 255;
ADDRLP4 0+20
CNSTU1 255
ASGNU1
line 2369
;2369:	verts[0].modulate[1] = 255;
ADDRLP4 0+20+1
CNSTU1 255
ASGNU1
line 2370
;2370:	verts[0].modulate[2] = 255;
ADDRLP4 0+20+2
CNSTU1 255
ASGNU1
line 2371
;2371:	verts[0].modulate[3] = 255;
ADDRLP4 0+20+3
CNSTU1 255
ASGNU1
line 2373
;2372:
;2373:	VectorCopy(trace.endpos, verts[1].xyz);
ADDRLP4 0+24
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2374
;2374:	verts[1].xyz[0] -= 32;
ADDRLP4 0+24
ADDRLP4 0+24
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2375
;2375:	verts[1].xyz[1] += 32;
ADDRLP4 0+24+4
ADDRLP4 0+24+4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2376
;2376:	verts[1].st[0] = 0;
ADDRLP4 0+24+12
CNSTF4 0
ASGNF4
line 2377
;2377:	verts[1].st[1] = 1;
ADDRLP4 0+24+12+4
CNSTF4 1065353216
ASGNF4
line 2378
;2378:	verts[1].modulate[0] = 255;
ADDRLP4 0+24+20
CNSTU1 255
ASGNU1
line 2379
;2379:	verts[1].modulate[1] = 255;
ADDRLP4 0+24+20+1
CNSTU1 255
ASGNU1
line 2380
;2380:	verts[1].modulate[2] = 255;
ADDRLP4 0+24+20+2
CNSTU1 255
ASGNU1
line 2381
;2381:	verts[1].modulate[3] = 255;
ADDRLP4 0+24+20+3
CNSTU1 255
ASGNU1
line 2383
;2382:
;2383:	VectorCopy(trace.endpos, verts[2].xyz);
ADDRLP4 0+48
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2384
;2384:	verts[2].xyz[0] += 32;
ADDRLP4 0+48
ADDRLP4 0+48
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2385
;2385:	verts[2].xyz[1] += 32;
ADDRLP4 0+48+4
ADDRLP4 0+48+4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2386
;2386:	verts[2].st[0] = 1;
ADDRLP4 0+48+12
CNSTF4 1065353216
ASGNF4
line 2387
;2387:	verts[2].st[1] = 1;
ADDRLP4 0+48+12+4
CNSTF4 1065353216
ASGNF4
line 2388
;2388:	verts[2].modulate[0] = 255;
ADDRLP4 0+48+20
CNSTU1 255
ASGNU1
line 2389
;2389:	verts[2].modulate[1] = 255;
ADDRLP4 0+48+20+1
CNSTU1 255
ASGNU1
line 2390
;2390:	verts[2].modulate[2] = 255;
ADDRLP4 0+48+20+2
CNSTU1 255
ASGNU1
line 2391
;2391:	verts[2].modulate[3] = 255;
ADDRLP4 0+48+20+3
CNSTU1 255
ASGNU1
line 2393
;2392:
;2393:	VectorCopy(trace.endpos, verts[3].xyz);
ADDRLP4 0+72
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2394
;2394:	verts[3].xyz[0] += 32;
ADDRLP4 0+72
ADDRLP4 0+72
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2395
;2395:	verts[3].xyz[1] -= 32;
ADDRLP4 0+72+4
ADDRLP4 0+72+4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2396
;2396:	verts[3].st[0] = 1;
ADDRLP4 0+72+12
CNSTF4 1065353216
ASGNF4
line 2397
;2397:	verts[3].st[1] = 0;
ADDRLP4 0+72+12+4
CNSTF4 0
ASGNF4
line 2398
;2398:	verts[3].modulate[0] = 255;
ADDRLP4 0+72+20
CNSTU1 255
ASGNU1
line 2399
;2399:	verts[3].modulate[1] = 255;
ADDRLP4 0+72+20+1
CNSTU1 255
ASGNU1
line 2400
;2400:	verts[3].modulate[2] = 255;
ADDRLP4 0+72+20+2
CNSTU1 255
ASGNU1
line 2401
;2401:	verts[3].modulate[3] = 255;
ADDRLP4 0+72+20+3
CNSTU1 255
ASGNU1
line 2403
;2402:
;2403:	trap_R_AddPolyToScene(cgs.media.wakeMarkShader, 4, verts);
ADDRGP4 cgs+180268+520
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 2404
;2404:}
LABELV $1234
endproc CG_PlayerSplash 192 28
export CG_AddRefEntityWithPowerups
proc CG_AddRefEntityWithPowerups 8 4
line 2414
;2405:
;2406:/*
;2407:===============
;2408:CG_AddRefEntityWithPowerups
;2409:
;2410:Adds a piece with modifications or duplications for powerups
;2411:Also called by CG_Missile for quad rockets, but nobody can tell...
;2412:===============
;2413: */
;2414:void CG_AddRefEntityWithPowerups(refEntity_t *ent, entityState_t *state, int team, qboolean isMissile) {
line 2416
;2415:
;2416:	if (state->powerups & (1 << PW_INVIS)) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1325
line 2417
;2417:		if ((cgs.dmflags & DF_INVIS) == 0) {
ADDRGP4 cgs+31460
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $1326
line 2418
;2418:			ent->customShader = cgs.media.invisShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+180268+556
INDIRI4
ASGNI4
line 2419
;2419:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2420
;2420:		}
line 2421
;2421:	} else {
ADDRGP4 $1326
JUMPV
LABELV $1325
line 2422
;2422:		trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2423
;2423:		if (!isMissile && (cgs.dmflags & DF_PLAYER_OVERLAY) && !(state->eFlags & EF_DEAD)) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 12
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1332
ADDRGP4 cgs+31460
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 0
INDIRI4
EQI4 $1332
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 0
INDIRI4
NEI4 $1332
line 2424
;2424:			switch (team) {
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $1337
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $1340
ADDRGP4 $1335
JUMPV
LABELV $1337
line 2426
;2425:				case TEAM_RED:
;2426:					ent->customShader = cgs.media.redOverlay;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+180268+588
INDIRI4
ASGNI4
line 2427
;2427:					trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2428
;2428:					break;
ADDRGP4 $1336
JUMPV
LABELV $1340
line 2430
;2429:				case TEAM_BLUE:
;2430:					ent->customShader = cgs.media.blueOverlay;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+180268+592
INDIRI4
ASGNI4
line 2431
;2431:					trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2432
;2432:					break;
ADDRGP4 $1336
JUMPV
LABELV $1335
line 2434
;2433:				default:
;2434:					ent->customShader = cgs.media.neutralOverlay;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+180268+584
INDIRI4
ASGNI4
line 2435
;2435:					trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2436
;2436:			}
LABELV $1336
line 2437
;2437:		}
LABELV $1332
line 2439
;2438:
;2439:		if (state->powerups & (1 << PW_QUAD)) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1345
line 2440
;2440:			if (team == TEAM_RED)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1347
line 2441
;2441:				ent->customShader = cgs.media.redQuadShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+180268+548
INDIRI4
ASGNI4
ADDRGP4 $1348
JUMPV
LABELV $1347
line 2443
;2442:			else
;2443:				ent->customShader = cgs.media.quadShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+180268+544
INDIRI4
ASGNI4
LABELV $1348
line 2444
;2444:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2445
;2445:		}
LABELV $1345
line 2446
;2446:		if (state->powerups & (1 << PW_REGEN)) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1353
line 2447
;2447:			if (((cg.time / 100) % 10) == 1) {
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
DIVI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $1355
line 2448
;2448:				ent->customShader = cgs.media.regenShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+180268+560
INDIRI4
ASGNI4
line 2449
;2449:				trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2450
;2450:			}
LABELV $1355
line 2451
;2451:		}
LABELV $1353
line 2452
;2452:		if (state->powerups & (1 << PW_BATTLESUIT)) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1360
line 2453
;2453:			ent->customShader = cgs.media.battleSuitShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+180268+564
INDIRI4
ASGNI4
line 2454
;2454:			trap_R_AddRefEntityToScene(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2455
;2455:		}
LABELV $1360
line 2456
;2456:	}
LABELV $1326
line 2457
;2457:}
LABELV $1324
endproc CG_AddRefEntityWithPowerups 8 4
export CG_LightVerts
proc CG_LightVerts 88 16
line 2464
;2458:
;2459:/*
;2460:=================
;2461:CG_LightVerts
;2462:=================
;2463: */
;2464:int CG_LightVerts(vec3_t normal, int numVerts, polyVert_t *verts) {
line 2471
;2465:	int i, j;
;2466:	float incoming;
;2467:	vec3_t ambientLight;
;2468:	vec3_t lightDir;
;2469:	vec3_t directedLight;
;2470:
;2471:	trap_R_LightForPoint(verts[0].xyz, ambientLight, directedLight, lightDir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_LightForPoint
CALLI4
pop
line 2473
;2472:
;2473:	for (i = 0; i < numVerts; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1368
JUMPV
LABELV $1365
line 2474
;2474:		incoming = DotProduct(normal, lightDir);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2475
;2475:		if (incoming <= 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $1371
line 2476
;2476:			verts[i].modulate[0] = ambientLight[0];
ADDRLP4 56
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 60
CNSTF4 1325400064
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
LTF4 $1374
ADDRLP4 52
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1375
JUMPV
LABELV $1374
ADDRLP4 52
ADDRLP4 56
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1375
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 52
INDIRU4
CVUU1 4
ASGNU1
line 2477
;2477:			verts[i].modulate[1] = ambientLight[1];
ADDRLP4 68
ADDRLP4 12+4
INDIRF4
ASGNF4
ADDRLP4 72
CNSTF4 1325400064
ASGNF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $1378
ADDRLP4 64
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1379
JUMPV
LABELV $1378
ADDRLP4 64
ADDRLP4 68
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1379
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 2478
;2478:			verts[i].modulate[2] = ambientLight[2];
ADDRLP4 80
ADDRLP4 12+8
INDIRF4
ASGNF4
ADDRLP4 84
CNSTF4 1325400064
ASGNF4
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
LTF4 $1382
ADDRLP4 76
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1383
JUMPV
LABELV $1382
ADDRLP4 76
ADDRLP4 80
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1383
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 76
INDIRU4
CVUU1 4
ASGNU1
line 2479
;2479:			verts[i].modulate[3] = 255;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 2480
;2480:			continue;
ADDRGP4 $1366
JUMPV
LABELV $1371
line 2482
;2481:		}
;2482:		j = (ambientLight[0] + incoming * directedLight[0]);
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2483
;2483:		if (j > 255) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1384
line 2484
;2484:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2485
;2485:		}
LABELV $1384
line 2486
;2486:		verts[i].modulate[0] = j;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2488
;2487:
;2488:		j = (ambientLight[1] + incoming * directedLight[1]);
ADDRLP4 0
ADDRLP4 12+4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2489
;2489:		if (j > 255) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1388
line 2490
;2490:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2491
;2491:		}
LABELV $1388
line 2492
;2492:		verts[i].modulate[1] = j;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2494
;2493:
;2494:		j = (ambientLight[2] + incoming * directedLight[2]);
ADDRLP4 0
ADDRLP4 12+8
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+8
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2495
;2495:		if (j > 255) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1392
line 2496
;2496:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2497
;2497:		}
LABELV $1392
line 2498
;2498:		verts[i].modulate[2] = j;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2500
;2499:
;2500:		verts[i].modulate[3] = 255;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 2501
;2501:	}
LABELV $1366
line 2473
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1368
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $1365
line 2502
;2502:	return qtrue;
CNSTI4 1
RETI4
LABELV $1364
endproc CG_LightVerts 88 16
export CG_Player
proc CG_Player 1068 28
line 2510
;2503:}
;2504:
;2505:/*
;2506:===============
;2507:CG_Player
;2508:===============
;2509: */
;2510:void CG_Player(centity_t *cent) {
line 2525
;2511:	clientInfo_t *ci;
;2512:	refEntity_t legs;
;2513:	refEntity_t torso;
;2514:	refEntity_t head;
;2515:	int clientNum;
;2516:	int renderfx;
;2517:	qboolean shadow;
;2518:	float shadowPlane;
;2519:	refEntity_t skull;
;2520:	refEntity_t powerup;
;2521:	int t;
;2522:	float c;
;2523:	float angle;
;2524:	vec3_t dir, angles;
;2525:	int camereyes = 0;
ADDRLP4 944
CNSTI4 0
ASGNI4
line 2527
;2526:	// leilei - chibi hack
;2527:	float chibifactorbody = 0.0f;
ADDRLP4 884
CNSTF4 0
ASGNF4
line 2528
;2528:	float chibifactortorso = 0.0f;
ADDRLP4 888
CNSTF4 0
ASGNF4
line 2529
;2529:	float chibifactorhead = 0.0f;
ADDRLP4 892
CNSTF4 0
ASGNF4
line 2531
;2530:
;2531:	if (cg_leiChibi.integer > 0) {
ADDRGP4 cg_leiChibi+12
INDIRI4
CNSTI4 0
LEI4 $1395
line 2532
;2532:		if (cg_leiChibi.integer == 1) {
ADDRGP4 cg_leiChibi+12
INDIRI4
CNSTI4 1
NEI4 $1398
line 2534
;2533:			// chibi SD proportion
;2534:			chibifactortorso = 0.0f;
ADDRLP4 888
CNSTF4 0
ASGNF4
line 2535
;2535:			chibifactorbody = 0.62f;
ADDRLP4 884
CNSTF4 1058977874
ASGNF4
line 2536
;2536:			chibifactorhead = 2.7f;
ADDRLP4 892
CNSTF4 1076677837
ASGNF4
line 2537
;2537:		} else if (cg_leiChibi.integer == 2) {
ADDRGP4 $1396
JUMPV
LABELV $1398
ADDRGP4 cg_leiChibi+12
INDIRI4
CNSTI4 2
NEI4 $1401
line 2539
;2538:			// slightly younger proportion
;2539:			chibifactorbody = 0.92f;
ADDRLP4 884
CNSTF4 1064011039
ASGNF4
line 2540
;2540:			chibifactortorso = 0.82f;
ADDRLP4 888
CNSTF4 1062333317
ASGNF4
line 2541
;2541:			chibifactorhead = 1.30f;
ADDRLP4 892
CNSTF4 1067869798
ASGNF4
line 2542
;2542:		} else if (cg_leiChibi.integer == 3) {
ADDRGP4 $1396
JUMPV
LABELV $1401
ADDRGP4 cg_leiChibi+12
INDIRI4
CNSTI4 3
NEI4 $1404
line 2544
;2543:			// slightly more 'real' proportion
;2544:			chibifactorbody = 0.92f;
ADDRLP4 884
CNSTF4 1064011039
ASGNF4
line 2545
;2545:			chibifactortorso = 0.97f;
ADDRLP4 888
CNSTF4 1064849900
ASGNF4
line 2546
;2546:			chibifactorhead = 0.92f;
ADDRLP4 892
CNSTF4 1064011039
ASGNF4
line 2547
;2547:		} else if (cg_leiChibi.integer == 4) {
ADDRGP4 $1396
JUMPV
LABELV $1404
ADDRGP4 cg_leiChibi+12
INDIRI4
CNSTI4 4
NEI4 $1396
line 2549
;2548:			// big torso
;2549:			chibifactorbody = 0.85f;
ADDRLP4 884
CNSTF4 1062836634
ASGNF4
line 2550
;2550:			chibifactortorso = 1.3f;
ADDRLP4 888
CNSTF4 1067869798
ASGNF4
line 2551
;2551:			chibifactorhead = 0.91f;
ADDRLP4 892
CNSTF4 1063843267
ASGNF4
line 2552
;2552:		}
line 2553
;2553:	} else {
ADDRGP4 $1396
JUMPV
LABELV $1395
line 2554
;2554:		chibifactorbody = chibifactortorso = chibifactorhead = 0; // normal scale...
ADDRLP4 952
CNSTF4 0
ASGNF4
ADDRLP4 892
ADDRLP4 952
INDIRF4
ASGNF4
ADDRLP4 888
ADDRLP4 952
INDIRF4
ASGNF4
ADDRLP4 884
ADDRLP4 952
INDIRF4
ASGNF4
line 2555
;2555:	}
LABELV $1396
line 2561
;2556:
;2557:
;2558:	// the client number is stored in clientNum.  It can't be derived
;2559:	// from the entity number, because a single client may have
;2560:	// multiple corpses on the level using the same clientinfo
;2561:	clientNum = cent->currentState.clientNum;
ADDRLP4 932
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 2562
;2562:	if (clientNum < 0 || clientNum >= MAX_CLIENTS) {
ADDRLP4 932
INDIRI4
CNSTI4 0
LTI4 $1412
ADDRLP4 932
INDIRI4
CNSTI4 64
LTI4 $1410
LABELV $1412
line 2563
;2563:		CG_Error("Bad clientNum on player entity");
ADDRGP4 $1413
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2564
;2564:	}
LABELV $1410
line 2565
;2565:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 704
CNSTI4 2120
ADDRLP4 932
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 2569
;2566:
;2567:	// it is possible to see corpses from disconnected players that may
;2568:	// not have valid clientinfo
;2569:	if (!ci->infoValid) {
ADDRLP4 704
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $1415
line 2570
;2570:		return;
ADDRGP4 $1394
JUMPV
LABELV $1415
line 2574
;2571:	}
;2572:
;2573:	// get the player model information
;2574:	renderfx = 0;
ADDRLP4 896
CNSTI4 0
ASGNI4
line 2575
;2575:	if (cent->currentState.number == cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1417
line 2576
;2576:		camereyes = 1; // it's me!
ADDRLP4 944
CNSTI4 1
ASGNI4
line 2577
;2577:		if (!cg.renderingThirdPerson) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1420
line 2578
;2578:			renderfx = RF_THIRD_PERSON; // only draw in mirrors
ADDRLP4 896
CNSTI4 2
ASGNI4
line 2579
;2579:		} else {
LABELV $1420
line 2583
;2580:			//		if (cg_cameraMode.integer) {
;2581:			//			return;
;2582:			//		}
;2583:		}
LABELV $1421
line 2584
;2584:	}
LABELV $1417
line 2587
;2585:
;2586:
;2587:	memset(&legs, 0, sizeof (legs));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2588
;2588:	memset(&torso, 0, sizeof (torso));
ADDRLP4 176
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2589
;2589:	memset(&head, 0, sizeof (head));
ADDRLP4 352
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2592
;2590:
;2591:	// get the rotation information
;2592:	CG_PlayerAngles(cent, legs.axis, torso.axis, head.axis);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 176+28
ARGP4
ADDRLP4 352+28
ARGP4
ADDRGP4 CG_PlayerAngles
CALLV
pop
line 2595
;2593:
;2594:	// get the animation state (after rotation, to allow feet shuffle)
;2595:	CG_PlayerAnimation(cent, &legs.oldframe, &legs.frame, &legs.backlerp,
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+96
ARGP4
ADDRLP4 0+80
ARGP4
ADDRLP4 0+100
ARGP4
ADDRLP4 176+96
ARGP4
ADDRLP4 176+80
ARGP4
ADDRLP4 176+100
ARGP4
ADDRGP4 CG_PlayerAnimation
CALLV
pop
line 2599
;2596:			&torso.oldframe, &torso.frame, &torso.backlerp);
;2597:
;2598:	// add the talk baloon or disconnect icon
;2599:	CG_PlayerSprites(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSprites
CALLV
pop
line 2602
;2600:
;2601:	// add the shadow
;2602:	shadow = CG_PlayerShadow(cent, &shadowPlane);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 916
ARGP4
ADDRLP4 956
ADDRGP4 CG_PlayerShadow
CALLI4
ASGNI4
ADDRLP4 948
ADDRLP4 956
INDIRI4
ASGNI4
line 2605
;2603:
;2604:	// add a water splash if partially in and out of water
;2605:	CG_PlayerSplash(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSplash
CALLV
pop
line 2607
;2606:
;2607:	if (cg_shadows.integer == 3 && shadow) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 3
NEI4 $1432
ADDRLP4 948
INDIRI4
CNSTI4 0
EQI4 $1432
line 2608
;2608:		renderfx |= RF_SHADOW_PLANE;
ADDRLP4 896
ADDRLP4 896
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2609
;2609:	}
LABELV $1432
line 2610
;2610:	renderfx |= RF_LIGHTING_ORIGIN; // use the same origin for all
ADDRLP4 896
ADDRLP4 896
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 2611
;2611:	if (cgs.gametype == GT_HARVESTER) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 7
NEI4 $1435
line 2612
;2612:		CG_PlayerTokens(cent, renderfx);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 896
INDIRI4
ARGI4
ADDRGP4 CG_PlayerTokens
CALLV
pop
line 2613
;2613:	}
LABELV $1435
line 2617
;2614:	//
;2615:	// add the legs
;2616:	//
;2617:	legs.hModel = ci->legsModel;
ADDRLP4 0+8
ADDRLP4 704
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
ASGNI4
line 2618
;2618:	if (!ci->onepiece) {
ADDRLP4 704
INDIRP4
CNSTI4 2116
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1439
line 2620
;2619:		// onepiece uses internal model skins right now until skin loading is fixed later
;2620:		legs.customSkin = ci->legsSkin;
ADDRLP4 0+108
ADDRLP4 704
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ASGNI4
line 2621
;2621:	}
LABELV $1439
line 2623
;2622:
;2623:	VectorCopy(cent->lerpOrigin, legs.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2625
;2624:
;2625:	VectorCopy(cent->lerpOrigin, legs.lightingOrigin);
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2628
;2626:
;2627:	// leilei - chibi mode hack
;2628:	if (chibifactorbody) {
ADDRLP4 884
INDIRF4
CNSTF4 0
EQF4 $1444
line 2629
;2629:		VectorScale(legs.axis[0], chibifactorbody, legs.axis[0]);
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 884
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 884
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 884
INDIRF4
MULF4
ASGNF4
line 2630
;2630:		VectorScale(legs.axis[1], chibifactorbody, legs.axis[1]);
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 884
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 884
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 884
INDIRF4
MULF4
ASGNF4
line 2631
;2631:		VectorScale(legs.axis[2], chibifactorbody, legs.axis[2]);
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 884
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 884
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 884
INDIRF4
MULF4
ASGNF4
line 2632
;2632:	}
LABELV $1444
line 2637
;2633:
;2634:
;2635:	// leilei - q scale hack
;2636:
;2637:	if (cg_enableQ.integer) {
ADDRGP4 cg_enableQ+12
INDIRI4
CNSTI4 0
EQI4 $1488
line 2638
;2638:		VectorScale(legs.axis[0], QUACK_SCALE, legs.axis[0]);
ADDRLP4 0+28
CNSTF4 1062836634
ADDRLP4 0+28
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
CNSTF4 1062836634
ADDRLP4 0+28+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
CNSTF4 1062836634
ADDRLP4 0+28+8
INDIRF4
MULF4
ASGNF4
line 2639
;2639:		VectorScale(legs.axis[1], QUACK_SCALE, legs.axis[1]);
ADDRLP4 0+28+12
CNSTF4 1062836634
ADDRLP4 0+28+12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
CNSTF4 1062836634
ADDRLP4 0+28+12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
CNSTF4 1062836634
ADDRLP4 0+28+12+8
INDIRF4
MULF4
ASGNF4
line 2640
;2640:		VectorScale(legs.axis[2], QUACK_SCALE, legs.axis[2]);
ADDRLP4 0+28+24
CNSTF4 1062836634
ADDRLP4 0+28+24
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
CNSTF4 1062836634
ADDRLP4 0+28+24+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
CNSTF4 1062836634
ADDRLP4 0+28+24+8
INDIRF4
MULF4
ASGNF4
line 2641
;2641:	}
LABELV $1488
line 2644
;2642:
;2643:
;2644:	legs.shadowPlane = shadowPlane;
ADDRLP4 0+24
ADDRLP4 916
INDIRF4
ASGNF4
line 2645
;2645:	legs.renderfx = renderfx;
ADDRLP4 0+4
ADDRLP4 896
INDIRI4
ASGNI4
line 2646
;2646:	VectorCopy(legs.origin, legs.oldorigin); // don't positionally lerp at all
ADDRLP4 0+84
ADDRLP4 0+68
INDIRB
ASGNB 12
line 2648
;2647:
;2648:	if (cg_cameraEyes.integer) {
ADDRGP4 cg_cameraEyes+12
INDIRI4
CNSTI4 0
EQI4 $1537
line 2649
;2649:		legs.renderfx &= RF_FIRST_PERSON;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 4
BANDI4
ASGNI4
line 2650
;2650:	}
LABELV $1537
line 2653
;2651:
;2652:
;2653:	CG_AddRefEntityWithPowerups(&legs, &cent->currentState, ci->team, qfalse);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 704
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2656
;2654:
;2655:	// if the model failed, allow the default nullmodel to be displayed
;2656:	if (!legs.hModel) {
ADDRLP4 0+8
INDIRI4
CNSTI4 0
NEI4 $1541
line 2657
;2657:		return;
ADDRGP4 $1394
JUMPV
LABELV $1541
line 2663
;2658:	}
;2659:
;2660:	//
;2661:	// add the torso
;2662:	//
;2663:	if (ci->onepiece) {
ADDRLP4 704
INDIRP4
CNSTI4 2116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1544
line 2668
;2664:		// skip all the further crap and put a head on the legs
;2665:		//
;2666:		// add the head
;2667:		//
;2668:		head.hModel = ci->headModel;
ADDRLP4 352+8
ADDRLP4 704
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
line 2670
;2669:
;2670:		if (!head.hModel) {
ADDRLP4 352+8
INDIRI4
CNSTI4 0
NEI4 $1547
line 2671
;2671:			return;
ADDRGP4 $1394
JUMPV
LABELV $1547
line 2673
;2672:		}
;2673:		head.customSkin = ci->headSkin;
ADDRLP4 352+108
ADDRLP4 704
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ASGNI4
line 2675
;2674:
;2675:		VectorCopy(cent->lerpOrigin, head.lightingOrigin);
ADDRLP4 352+12
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2677
;2676:
;2677:		CG_PositionRotatedEntityOnTag(&head, &legs, ci->legsModel, "tag_head");
ADDRLP4 352
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 704
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1552
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2685
;2678:
;2679:		// 
;2680:		// add the eyes
;2681:		//
;2682:
;2683:
;2684:
;2685:		if (camereyes) {
ADDRLP4 944
INDIRI4
CNSTI4 0
EQI4 $1553
line 2686
;2686:			cent->eyesOrigin[0] = head.origin[0];
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ADDRLP4 352+68
INDIRF4
ASGNF4
line 2687
;2687:			cent->eyesOrigin[1] = head.origin[1];
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
ADDRLP4 352+68+4
INDIRF4
ASGNF4
line 2688
;2688:			cent->eyesOrigin[2] = head.origin[2];
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRLP4 352+68+8
INDIRF4
ASGNF4
line 2689
;2689:			if (cg_cameraEyes.integer == 3) {
ADDRGP4 cg_cameraEyes+12
INDIRI4
CNSTI4 3
NEI4 $1560
line 2690
;2690:				vectoangles(head.axis[0], headang);
ADDRLP4 352+28
ARGP4
ADDRGP4 headang
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2691
;2691:			} else {
ADDRGP4 $1561
JUMPV
LABELV $1560
line 2692
;2692:				if (cg_cameraEyes.integer == 2) {
ADDRGP4 cg_cameraEyes+12
INDIRI4
CNSTI4 2
NEI4 $1564
line 2693
;2693:					vectoangles(head.axis[0], headang);
ADDRLP4 352+28
ARGP4
ADDRGP4 headang
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2696
;2694:					//VectorCopy(cent->lerpAngles, headang);
;2695:					//headang[0] = cent->lerpAngles[0];
;2696:					headang[1] = cent->lerpAngles[1];
ADDRGP4 headang+4
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRF4
ASGNF4
line 2697
;2697:				} else {
ADDRGP4 $1565
JUMPV
LABELV $1564
line 2698
;2698:					VectorCopy(cent->lerpAngles, headang);
ADDRGP4 headang
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRB
ASGNB 12
line 2699
;2699:				}
LABELV $1565
line 2700
;2700:			}
LABELV $1561
line 2702
;2701:
;2702:			if (cg_cameraEyes.integer) {
ADDRGP4 cg_cameraEyes+12
INDIRI4
CNSTI4 0
EQI4 $1569
line 2703
;2703:				VectorCopy(head.origin, cent->eyesOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ADDRLP4 352+68
INDIRB
ASGNB 12
line 2705
;2704:
;2705:				VectorSubtract(cent->eyesOrigin, cent->lerpOrigin, cent->eyesOrigin);
ADDRLP4 960
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 964
ADDRLP4 960
INDIRP4
CNSTI4 804
ADDP4
ASGNP4
ADDRLP4 964
INDIRP4
ADDRLP4 964
INDIRP4
INDIRF4
ADDRLP4 960
INDIRP4
CNSTI4 776
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 968
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 972
ADDRLP4 968
INDIRP4
CNSTI4 808
ADDP4
ASGNP4
ADDRLP4 972
INDIRP4
ADDRLP4 972
INDIRP4
INDIRF4
ADDRLP4 968
INDIRP4
CNSTI4 780
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 976
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 980
ADDRLP4 976
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 980
INDIRP4
ADDRLP4 980
INDIRP4
INDIRF4
ADDRLP4 976
INDIRP4
CNSTI4 784
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2706
;2706:				VectorCopy(cent->eyesOrigin, headpos);
ADDRGP4 headpos
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRB
ASGNB 12
line 2707
;2707:			}
LABELV $1569
line 2708
;2708:		}
LABELV $1553
line 2710
;2709:
;2710:		VectorCopy(cent->pe.eyepos, head.eyepos[0]); // Copy it to our refdef for the renderer
ADDRLP4 352+140
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRB
ASGNB 12
line 2713
;2711:
;2712:		// HMM
;2713:		{
line 2717
;2714:			vec3_t v, forwaad;
;2715:			vec3_t orrg;
;2716:			trace_t trace;
;2717:			VectorCopy(cent->lerpAngles, v);
ADDRLP4 960
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRB
ASGNB 12
line 2718
;2718:			AngleVectors(v, forwaad, NULL, NULL);
ADDRLP4 960
ARGP4
ADDRLP4 972
ARGP4
ADDRLP4 1052
CNSTP4 0
ASGNP4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2719
;2719:			VectorMA(cent->lerpOrigin, 1024, forwaad, v);
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1060
CNSTF4 1149239296
ASGNF4
ADDRLP4 960
ADDRLP4 1056
INDIRP4
CNSTI4 776
ADDP4
INDIRF4
ADDRLP4 1060
INDIRF4
ADDRLP4 972
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 960+4
ADDRLP4 1056
INDIRP4
CNSTI4 780
ADDP4
INDIRF4
ADDRLP4 1060
INDIRF4
ADDRLP4 972+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 960+8
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRF4
CNSTF4 1149239296
ADDRLP4 972+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2720
;2720:			VectorCopy(head.origin, orrg);
ADDRLP4 1040
ADDRLP4 352+68
INDIRB
ASGNB 12
line 2721
;2721:			CG_Trace(&trace, orrg, NULL, NULL, v, -1, CONTENTS_SOLID);
ADDRLP4 984
ARGP4
ADDRLP4 1040
ARGP4
ADDRLP4 1064
CNSTP4 0
ASGNP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRLP4 960
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 2722
;2722:			if (trace.fraction < 1)
ADDRLP4 984+8
INDIRF4
CNSTF4 1065353216
GEF4 $1579
line 2723
;2723:				VectorCopy(trace.endpos, v); // look closer
ADDRLP4 960
ADDRLP4 984+12
INDIRB
ASGNB 12
LABELV $1579
line 2724
;2724:			VectorCopy(v, head.eyelook); // Copy it to our refdef for the renderer
ADDRLP4 352+164
ADDRLP4 960
INDIRB
ASGNB 12
line 2725
;2725:		}
line 2727
;2726:
;2727:		head.shadowPlane = shadowPlane;
ADDRLP4 352+24
ADDRLP4 916
INDIRF4
ASGNF4
line 2729
;2728:
;2729:		head.renderfx = renderfx;
ADDRLP4 352+4
ADDRLP4 896
INDIRI4
ASGNI4
line 2731
;2730:
;2731:		if ((cg_cameraEyes.integer == 2) || (cg_cameraEyes.integer == 3)) {
ADDRGP4 cg_cameraEyes+12
INDIRI4
CNSTI4 2
EQI4 $1590
ADDRGP4 cg_cameraEyes+12
INDIRI4
CNSTI4 3
NEI4 $1586
LABELV $1590
line 2732
;2732:			head.renderfx &= RF_FIRST_PERSON;
ADDRLP4 352+4
ADDRLP4 352+4
INDIRI4
CNSTI4 4
BANDI4
ASGNI4
line 2733
;2733:		}
LABELV $1586
line 2734
;2734:		CG_AddRefEntityWithPowerups(&head, &cent->currentState, ci->team, qfalse);
ADDRLP4 352
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 704
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2736
;2735:
;2736:		CG_BreathPuffs(cent, &head);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 352
ARGP4
ADDRGP4 CG_BreathPuffs
CALLV
pop
line 2738
;2737:
;2738:		CG_DustTrail(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_DustTrail
CALLV
pop
line 2739
;2739:		return;
ADDRGP4 $1394
JUMPV
LABELV $1544
line 2743
;2740:	}
;2741:
;2742:
;2743:	torso.hModel = ci->torsoModel;
ADDRLP4 176+8
ADDRLP4 704
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
ASGNI4
line 2744
;2744:	if (!torso.hModel) {
ADDRLP4 176+8
INDIRI4
CNSTI4 0
NEI4 $1593
line 2745
;2745:		return;
ADDRGP4 $1394
JUMPV
LABELV $1593
line 2748
;2746:	}
;2747:
;2748:	torso.customSkin = ci->torsoSkin;
ADDRLP4 176+108
ADDRLP4 704
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ASGNI4
line 2750
;2749:
;2750:	VectorCopy(cent->lerpOrigin, torso.lightingOrigin);
ADDRLP4 176+12
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2752
;2751:
;2752:	CG_PositionRotatedEntityOnTag(&torso, &legs, ci->legsModel, "tag_torso");
ADDRLP4 176
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 704
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1598
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2754
;2753:
;2754:	torso.shadowPlane = shadowPlane;
ADDRLP4 176+24
ADDRLP4 916
INDIRF4
ASGNF4
line 2755
;2755:	torso.renderfx = renderfx;
ADDRLP4 176+4
ADDRLP4 896
INDIRI4
ASGNI4
line 2756
;2756:	if (cg_cameraEyes.integer) {
ADDRGP4 cg_cameraEyes+12
INDIRI4
CNSTI4 0
EQI4 $1601
line 2757
;2757:		torso.renderfx &= RF_FIRST_PERSON;
ADDRLP4 176+4
ADDRLP4 176+4
INDIRI4
CNSTI4 4
BANDI4
ASGNI4
line 2758
;2758:	}
LABELV $1601
line 2761
;2759:
;2760:
;2761:	if (chibifactortorso) {
ADDRLP4 888
INDIRF4
CNSTF4 0
EQF4 $1605
line 2762
;2762:		VectorScale(torso.axis[0], chibifactortorso, torso.axis[0]);
ADDRLP4 176+28
ADDRLP4 176+28
INDIRF4
ADDRLP4 888
INDIRF4
MULF4
ASGNF4
ADDRLP4 176+28+4
ADDRLP4 176+28+4
INDIRF4
ADDRLP4 888
INDIRF4
MULF4
ASGNF4
ADDRLP4 176+28+8
ADDRLP4 176+28+8
INDIRF4
ADDRLP4 888
INDIRF4
MULF4
ASGNF4
line 2763
;2763:		VectorScale(torso.axis[1], chibifactortorso, torso.axis[1]);
ADDRLP4 176+28+12
ADDRLP4 176+28+12
INDIRF4
ADDRLP4 888
INDIRF4
MULF4
ASGNF4
ADDRLP4 176+28+12+4
ADDRLP4 176+28+12+4
INDIRF4
ADDRLP4 888
INDIRF4
MULF4
ASGNF4
ADDRLP4 176+28+12+8
ADDRLP4 176+28+12+8
INDIRF4
ADDRLP4 888
INDIRF4
MULF4
ASGNF4
line 2764
;2764:		VectorScale(torso.axis[2], chibifactortorso, torso.axis[2]);
ADDRLP4 176+28+24
ADDRLP4 176+28+24
INDIRF4
ADDRLP4 888
INDIRF4
MULF4
ASGNF4
ADDRLP4 176+28+24+4
ADDRLP4 176+28+24+4
INDIRF4
ADDRLP4 888
INDIRF4
MULF4
ASGNF4
ADDRLP4 176+28+24+8
ADDRLP4 176+28+24+8
INDIRF4
ADDRLP4 888
INDIRF4
MULF4
ASGNF4
line 2765
;2765:	}
LABELV $1605
line 2771
;2766:
;2767:
;2768:
;2769:
;2770:
;2771:	CG_AddRefEntityWithPowerups(&torso, &cent->currentState, ci->team, qfalse);
ADDRLP4 176
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 704
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2773
;2772:
;2773:	if (cent->currentState.eFlags & EF_KAMIKAZE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1649
line 2775
;2774:
;2775:		memset(&skull, 0, sizeof (skull));
ADDRLP4 708
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2777
;2776:
;2777:		VectorCopy(cent->lerpOrigin, skull.lightingOrigin);
ADDRLP4 708+12
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2778
;2778:		skull.shadowPlane = shadowPlane;
ADDRLP4 708+24
ADDRLP4 916
INDIRF4
ASGNF4
line 2779
;2779:		skull.renderfx = renderfx;
ADDRLP4 708+4
ADDRLP4 896
INDIRI4
ASGNI4
line 2781
;2780:
;2781:		if (cent->currentState.eFlags & EF_DEAD) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1654
line 2783
;2782:			// one skull bobbing above the dead body
;2783:			angle = ((cg.time / 7) & 255) * (M_PI * 2) / 255;
ADDRLP4 912
CNSTF4 1086918619
ADDRGP4 cg+107604
INDIRI4
CNSTI4 7
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
ASGNF4
line 2784
;2784:			if (angle > M_PI * 2)
ADDRLP4 912
INDIRF4
CNSTF4 1086918619
LEF4 $1657
line 2785
;2785:				angle -= (float) M_PI * 2;
ADDRLP4 912
ADDRLP4 912
INDIRF4
CNSTF4 1086918619
SUBF4
ASGNF4
LABELV $1657
line 2786
;2786:			dir[0] = sin(angle) * 20;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 960
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 900
CNSTF4 1101004800
ADDRLP4 960
INDIRF4
MULF4
ASGNF4
line 2787
;2787:			dir[1] = cos(angle) * 20;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 964
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 900+4
CNSTF4 1101004800
ADDRLP4 964
INDIRF4
MULF4
ASGNF4
line 2788
;2788:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
ADDRLP4 912
CNSTF4 1086918619
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
ASGNF4
line 2789
;2789:			dir[2] = 15 + sin(angle) * 8;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 968
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 900+8
CNSTF4 1090519040
ADDRLP4 968
INDIRF4
MULF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 2790
;2790:			VectorAdd(torso.origin, dir, skull.origin);
ADDRLP4 708+68
ADDRLP4 176+68
INDIRF4
ADDRLP4 900
INDIRF4
ADDF4
ASGNF4
ADDRLP4 708+68+4
ADDRLP4 176+68+4
INDIRF4
ADDRLP4 900+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 708+68+8
ADDRLP4 176+68+8
INDIRF4
ADDRLP4 900+8
INDIRF4
ADDF4
ASGNF4
line 2792
;2791:
;2792:			dir[2] = 0;
ADDRLP4 900+8
CNSTF4 0
ASGNF4
line 2793
;2793:			VectorCopy(dir, skull.axis[1]);
ADDRLP4 708+28+12
ADDRLP4 900
INDIRB
ASGNB 12
line 2794
;2794:			VectorNormalize(skull.axis[1]);
ADDRLP4 708+28+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2795
;2795:			VectorSet(skull.axis[2], 0, 0, 1);
ADDRLP4 708+28+24
CNSTF4 0
ASGNF4
ADDRLP4 708+28+24+4
CNSTF4 0
ASGNF4
ADDRLP4 708+28+24+8
CNSTF4 1065353216
ASGNF4
line 2796
;2796:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
ADDRLP4 708+28+12
ARGP4
ADDRLP4 708+28+24
ARGP4
ADDRLP4 708+28
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2798
;2797:
;2798:			skull.hModel = cgs.media.kamikazeHeadModel;
ADDRLP4 708+8
ADDRGP4 cgs+180268+656
INDIRI4
ASGNI4
line 2799
;2799:			trap_R_AddRefEntityToScene(&skull);
ADDRLP4 708
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2800
;2800:			skull.hModel = cgs.media.kamikazeHeadTrail;
ADDRLP4 708+8
ADDRGP4 cgs+180268+660
INDIRI4
ASGNI4
line 2801
;2801:			trap_R_AddRefEntityToScene(&skull);
ADDRLP4 708
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2802
;2802:		} else {
ADDRGP4 $1655
JUMPV
LABELV $1654
line 2804
;2803:			// three skulls spinning around the player
;2804:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
ADDRLP4 912
CNSTF4 1086918619
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
ASGNF4
line 2805
;2805:			dir[0] = cos(angle) * 20;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 960
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 900
CNSTF4 1101004800
ADDRLP4 960
INDIRF4
MULF4
ASGNF4
line 2806
;2806:			dir[1] = sin(angle) * 20;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 964
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 900+4
CNSTF4 1101004800
ADDRLP4 964
INDIRF4
MULF4
ASGNF4
line 2807
;2807:			dir[2] = cos(angle) * 20;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 968
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 900+8
CNSTF4 1101004800
ADDRLP4 968
INDIRF4
MULF4
ASGNF4
line 2808
;2808:			VectorAdd(torso.origin, dir, skull.origin);
ADDRLP4 708+68
ADDRLP4 176+68
INDIRF4
ADDRLP4 900
INDIRF4
ADDF4
ASGNF4
ADDRLP4 708+68+4
ADDRLP4 176+68+4
INDIRF4
ADDRLP4 900+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 708+68+8
ADDRLP4 176+68+8
INDIRF4
ADDRLP4 900+8
INDIRF4
ADDF4
ASGNF4
line 2810
;2809:
;2810:			angles[0] = sin(angle) * 30;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 972
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 920
CNSTF4 1106247680
ADDRLP4 972
INDIRF4
MULF4
ASGNF4
line 2811
;2811:			angles[1] = (angle * 180 / M_PI) + 90;
ADDRLP4 920+4
CNSTF4 1127481344
ADDRLP4 912
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 2812
;2812:			if (angles[1] > 360)
ADDRLP4 920+4
INDIRF4
CNSTF4 1135869952
LEF4 $1714
line 2813
;2813:				angles[1] -= 360;
ADDRLP4 920+4
ADDRLP4 920+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1714
line 2814
;2814:			angles[2] = 0;
ADDRLP4 920+8
CNSTF4 0
ASGNF4
line 2815
;2815:			AnglesToAxis(angles, skull.axis);
ADDRLP4 920
ARGP4
ADDRLP4 708+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2826
;2816:
;2817:			/*
;2818:			dir[2] = 0;
;2819:			VectorInverse(dir);
;2820:			VectorCopy(dir, skull.axis[1]);
;2821:			VectorNormalize(skull.axis[1]);
;2822:			VectorSet(skull.axis[2], 0, 0, 1);
;2823:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2824:			 */
;2825:
;2826:			skull.hModel = cgs.media.kamikazeHeadModel;
ADDRLP4 708+8
ADDRGP4 cgs+180268+656
INDIRI4
ASGNI4
line 2827
;2827:			trap_R_AddRefEntityToScene(&skull);
ADDRLP4 708
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2829
;2828:			// flip the trail because this skull is spinning in the other direction
;2829:			VectorInverse(skull.axis[1]);
ADDRLP4 708+28+12
ARGP4
ADDRGP4 VectorInverse
CALLV
pop
line 2830
;2830:			skull.hModel = cgs.media.kamikazeHeadTrail;
ADDRLP4 708+8
ADDRGP4 cgs+180268+660
INDIRI4
ASGNI4
line 2831
;2831:			trap_R_AddRefEntityToScene(&skull);
ADDRLP4 708
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2833
;2832:
;2833:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255 + M_PI;
ADDRLP4 912
CNSTF4 1086918619
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
CNSTF4 1078530011
ADDF4
ASGNF4
line 2834
;2834:			if (angle > M_PI * 2)
ADDRLP4 912
INDIRF4
CNSTF4 1086918619
LEF4 $1729
line 2835
;2835:				angle -= (float) M_PI * 2;
ADDRLP4 912
ADDRLP4 912
INDIRF4
CNSTF4 1086918619
SUBF4
ASGNF4
LABELV $1729
line 2836
;2836:			dir[0] = sin(angle) * 20;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 976
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 900
CNSTF4 1101004800
ADDRLP4 976
INDIRF4
MULF4
ASGNF4
line 2837
;2837:			dir[1] = cos(angle) * 20;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 980
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 900+4
CNSTF4 1101004800
ADDRLP4 980
INDIRF4
MULF4
ASGNF4
line 2838
;2838:			dir[2] = cos(angle) * 20;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 984
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 900+8
CNSTF4 1101004800
ADDRLP4 984
INDIRF4
MULF4
ASGNF4
line 2839
;2839:			VectorAdd(torso.origin, dir, skull.origin);
ADDRLP4 708+68
ADDRLP4 176+68
INDIRF4
ADDRLP4 900
INDIRF4
ADDF4
ASGNF4
ADDRLP4 708+68+4
ADDRLP4 176+68+4
INDIRF4
ADDRLP4 900+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 708+68+8
ADDRLP4 176+68+8
INDIRF4
ADDRLP4 900+8
INDIRF4
ADDF4
ASGNF4
line 2841
;2840:
;2841:			angles[0] = cos(angle - 0.5 * M_PI) * 30;
ADDRLP4 912
INDIRF4
CNSTF4 1070141403
SUBF4
ARGF4
ADDRLP4 988
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 920
CNSTF4 1106247680
ADDRLP4 988
INDIRF4
MULF4
ASGNF4
line 2842
;2842:			angles[1] = 360 - (angle * 180 / M_PI);
ADDRLP4 920+4
CNSTF4 1135869952
CNSTF4 1127481344
ADDRLP4 912
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
SUBF4
ASGNF4
line 2843
;2843:			if (angles[1] > 360)
ADDRLP4 920+4
INDIRF4
CNSTF4 1135869952
LEF4 $1746
line 2844
;2844:				angles[1] -= 360;
ADDRLP4 920+4
ADDRLP4 920+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1746
line 2845
;2845:			angles[2] = 0;
ADDRLP4 920+8
CNSTF4 0
ASGNF4
line 2846
;2846:			AnglesToAxis(angles, skull.axis);
ADDRLP4 920
ARGP4
ADDRLP4 708+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2856
;2847:
;2848:			/*
;2849:			dir[2] = 0;
;2850:			VectorCopy(dir, skull.axis[1]);
;2851:			VectorNormalize(skull.axis[1]);
;2852:			VectorSet(skull.axis[2], 0, 0, 1);
;2853:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2854:			 */
;2855:
;2856:			skull.hModel = cgs.media.kamikazeHeadModel;
ADDRLP4 708+8
ADDRGP4 cgs+180268+656
INDIRI4
ASGNI4
line 2857
;2857:			trap_R_AddRefEntityToScene(&skull);
ADDRLP4 708
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2858
;2858:			skull.hModel = cgs.media.kamikazeHeadTrail;
ADDRLP4 708+8
ADDRGP4 cgs+180268+660
INDIRI4
ASGNI4
line 2859
;2859:			trap_R_AddRefEntityToScene(&skull);
ADDRLP4 708
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2861
;2860:
;2861:			angle = ((cg.time / 3) & 255) * (M_PI * 2) / 255 + 0.5 * M_PI;
ADDRLP4 912
CNSTF4 1086918619
ADDRGP4 cg+107604
INDIRI4
CNSTI4 3
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
CNSTF4 1132396544
DIVF4
CNSTF4 1070141403
ADDF4
ASGNF4
line 2862
;2862:			if (angle > M_PI * 2)
ADDRLP4 912
INDIRF4
CNSTF4 1086918619
LEF4 $1759
line 2863
;2863:				angle -= (float) M_PI * 2;
ADDRLP4 912
ADDRLP4 912
INDIRF4
CNSTF4 1086918619
SUBF4
ASGNF4
LABELV $1759
line 2864
;2864:			dir[0] = sin(angle) * 20;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 992
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 900
CNSTF4 1101004800
ADDRLP4 992
INDIRF4
MULF4
ASGNF4
line 2865
;2865:			dir[1] = cos(angle) * 20;
ADDRLP4 912
INDIRF4
ARGF4
ADDRLP4 996
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 900+4
CNSTF4 1101004800
ADDRLP4 996
INDIRF4
MULF4
ASGNF4
line 2866
;2866:			dir[2] = 0;
ADDRLP4 900+8
CNSTF4 0
ASGNF4
line 2867
;2867:			VectorAdd(torso.origin, dir, skull.origin);
ADDRLP4 708+68
ADDRLP4 176+68
INDIRF4
ADDRLP4 900
INDIRF4
ADDF4
ASGNF4
ADDRLP4 708+68+4
ADDRLP4 176+68+4
INDIRF4
ADDRLP4 900+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 708+68+8
ADDRLP4 176+68+8
INDIRF4
ADDRLP4 900+8
INDIRF4
ADDF4
ASGNF4
line 2869
;2868:
;2869:			VectorCopy(dir, skull.axis[1]);
ADDRLP4 708+28+12
ADDRLP4 900
INDIRB
ASGNB 12
line 2870
;2870:			VectorNormalize(skull.axis[1]);
ADDRLP4 708+28+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2871
;2871:			VectorSet(skull.axis[2], 0, 0, 1);
ADDRLP4 708+28+24
CNSTF4 0
ASGNF4
ADDRLP4 708+28+24+4
CNSTF4 0
ASGNF4
ADDRLP4 708+28+24+8
CNSTF4 1065353216
ASGNF4
line 2872
;2872:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
ADDRLP4 708+28+12
ARGP4
ADDRLP4 708+28+24
ARGP4
ADDRLP4 708+28
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2874
;2873:
;2874:			skull.hModel = cgs.media.kamikazeHeadModel;
ADDRLP4 708+8
ADDRGP4 cgs+180268+656
INDIRI4
ASGNI4
line 2875
;2875:			trap_R_AddRefEntityToScene(&skull);
ADDRLP4 708
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2876
;2876:			skull.hModel = cgs.media.kamikazeHeadTrail;
ADDRLP4 708+8
ADDRGP4 cgs+180268+660
INDIRI4
ASGNI4
line 2877
;2877:			trap_R_AddRefEntityToScene(&skull);
ADDRLP4 708
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2878
;2878:		}
LABELV $1655
line 2879
;2879:	}
LABELV $1649
line 2881
;2880:
;2881:	if (cent->currentState.powerups & (1 << PW_GUARD)) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1798
line 2882
;2882:		memcpy(&powerup, &torso, sizeof (torso));
ADDRLP4 528
ARGP4
ADDRLP4 176
ARGP4
CNSTI4 176
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2883
;2883:		powerup.hModel = cgs.media.guardPowerupModel;
ADDRLP4 528+8
ADDRGP4 cgs+180268+664
INDIRI4
ASGNI4
line 2884
;2884:		powerup.frame = 0;
ADDRLP4 528+80
CNSTI4 0
ASGNI4
line 2885
;2885:		powerup.oldframe = 0;
ADDRLP4 528+96
CNSTI4 0
ASGNI4
line 2886
;2886:		powerup.customSkin = 0;
ADDRLP4 528+108
CNSTI4 0
ASGNI4
line 2887
;2887:		trap_R_AddRefEntityToScene(&powerup);
ADDRLP4 528
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2888
;2888:	}
LABELV $1798
line 2889
;2889:	if (cent->currentState.powerups & (1 << PW_SCOUT)) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1806
line 2890
;2890:		memcpy(&powerup, &torso, sizeof (torso));
ADDRLP4 528
ARGP4
ADDRLP4 176
ARGP4
CNSTI4 176
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2891
;2891:		powerup.hModel = cgs.media.scoutPowerupModel;
ADDRLP4 528+8
ADDRGP4 cgs+180268+668
INDIRI4
ASGNI4
line 2892
;2892:		powerup.frame = 0;
ADDRLP4 528+80
CNSTI4 0
ASGNI4
line 2893
;2893:		powerup.oldframe = 0;
ADDRLP4 528+96
CNSTI4 0
ASGNI4
line 2894
;2894:		powerup.customSkin = 0;
ADDRLP4 528+108
CNSTI4 0
ASGNI4
line 2895
;2895:		trap_R_AddRefEntityToScene(&powerup);
ADDRLP4 528
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2896
;2896:	}
LABELV $1806
line 2897
;2897:	if (cent->currentState.powerups & (1 << PW_DOUBLER)) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1814
line 2898
;2898:		memcpy(&powerup, &torso, sizeof (torso));
ADDRLP4 528
ARGP4
ADDRLP4 176
ARGP4
CNSTI4 176
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2899
;2899:		powerup.hModel = cgs.media.doublerPowerupModel;
ADDRLP4 528+8
ADDRGP4 cgs+180268+672
INDIRI4
ASGNI4
line 2900
;2900:		powerup.frame = 0;
ADDRLP4 528+80
CNSTI4 0
ASGNI4
line 2901
;2901:		powerup.oldframe = 0;
ADDRLP4 528+96
CNSTI4 0
ASGNI4
line 2902
;2902:		powerup.customSkin = 0;
ADDRLP4 528+108
CNSTI4 0
ASGNI4
line 2903
;2903:		trap_R_AddRefEntityToScene(&powerup);
ADDRLP4 528
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2904
;2904:	}
LABELV $1814
line 2905
;2905:	if (cent->currentState.powerups & (1 << PW_AMMOREGEN)) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1822
line 2906
;2906:		memcpy(&powerup, &torso, sizeof (torso));
ADDRLP4 528
ARGP4
ADDRLP4 176
ARGP4
CNSTI4 176
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2907
;2907:		powerup.hModel = cgs.media.ammoRegenPowerupModel;
ADDRLP4 528+8
ADDRGP4 cgs+180268+676
INDIRI4
ASGNI4
line 2908
;2908:		powerup.frame = 0;
ADDRLP4 528+80
CNSTI4 0
ASGNI4
line 2909
;2909:		powerup.oldframe = 0;
ADDRLP4 528+96
CNSTI4 0
ASGNI4
line 2910
;2910:		powerup.customSkin = 0;
ADDRLP4 528+108
CNSTI4 0
ASGNI4
line 2911
;2911:		trap_R_AddRefEntityToScene(&powerup);
ADDRLP4 528
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2912
;2912:	}
LABELV $1822
line 2913
;2913:	if (cent->currentState.powerups & (1 << PW_INVULNERABILITY)) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $1830
line 2914
;2914:		if (!ci->invulnerabilityStartTime) {
ADDRLP4 704
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1832
line 2915
;2915:			ci->invulnerabilityStartTime = cg.time;
ADDRLP4 704
INDIRP4
CNSTI4 148
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2916
;2916:		}
LABELV $1832
line 2917
;2917:		ci->invulnerabilityStopTime = cg.time;
ADDRLP4 704
INDIRP4
CNSTI4 152
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2918
;2918:	} else {
ADDRGP4 $1831
JUMPV
LABELV $1830
line 2919
;2919:		ci->invulnerabilityStartTime = 0;
ADDRLP4 704
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 2920
;2920:	}
LABELV $1831
line 2921
;2921:	if ((cent->currentState.powerups & (1 << PW_INVULNERABILITY)) ||
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
NEI4 $1839
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 704
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
SUBI4
CNSTI4 250
GEI4 $1836
LABELV $1839
line 2922
;2922:			cg.time - ci->invulnerabilityStopTime < 250) {
line 2924
;2923:
;2924:		memcpy(&powerup, &torso, sizeof (torso));
ADDRLP4 528
ARGP4
ADDRLP4 176
ARGP4
CNSTI4 176
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2925
;2925:		powerup.hModel = cgs.media.invulnerabilityPowerupModel;
ADDRLP4 528+8
ADDRGP4 cgs+180268+700
INDIRI4
ASGNI4
line 2926
;2926:		powerup.frame = 0;
ADDRLP4 528+80
CNSTI4 0
ASGNI4
line 2927
;2927:		powerup.oldframe = 0;
ADDRLP4 528+96
CNSTI4 0
ASGNI4
line 2928
;2928:		powerup.customSkin = 0;
ADDRLP4 528+108
CNSTI4 0
ASGNI4
line 2930
;2929:		// always draw
;2930:		powerup.renderfx &= ~RF_THIRD_PERSON;
ADDRLP4 528+4
ADDRLP4 528+4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2931
;2931:		VectorCopy(cent->lerpOrigin, powerup.origin);
ADDRLP4 528+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2933
;2932:
;2933:		if (cg.time - ci->invulnerabilityStartTime < 250) {
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 704
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
SUBI4
CNSTI4 250
GEI4 $1848
line 2934
;2934:			c = (float) (cg.time - ci->invulnerabilityStartTime) / 250;
ADDRLP4 940
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 704
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1132068864
DIVF4
ASGNF4
line 2935
;2935:		} else if (cg.time - ci->invulnerabilityStopTime < 250) {
ADDRGP4 $1849
JUMPV
LABELV $1848
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 704
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
SUBI4
CNSTI4 250
GEI4 $1852
line 2936
;2936:			c = (float) (250 - (cg.time - ci->invulnerabilityStopTime)) / 250;
ADDRLP4 940
CNSTI4 250
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 704
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
SUBI4
SUBI4
CVIF4 4
CNSTF4 1132068864
DIVF4
ASGNF4
line 2937
;2937:		} else {
ADDRGP4 $1853
JUMPV
LABELV $1852
line 2938
;2938:			c = 1;
ADDRLP4 940
CNSTF4 1065353216
ASGNF4
line 2939
;2939:		}
LABELV $1853
LABELV $1849
line 2940
;2940:		VectorSet(powerup.axis[0], c, 0, 0);
ADDRLP4 528+28
ADDRLP4 940
INDIRF4
ASGNF4
ADDRLP4 528+28+4
CNSTF4 0
ASGNF4
ADDRLP4 528+28+8
CNSTF4 0
ASGNF4
line 2941
;2941:		VectorSet(powerup.axis[1], 0, c, 0);
ADDRLP4 528+28+12
CNSTF4 0
ASGNF4
ADDRLP4 528+28+12+4
ADDRLP4 940
INDIRF4
ASGNF4
ADDRLP4 528+28+12+8
CNSTF4 0
ASGNF4
line 2942
;2942:		VectorSet(powerup.axis[2], 0, 0, c);
ADDRLP4 528+28+24
CNSTF4 0
ASGNF4
ADDRLP4 528+28+24+4
CNSTF4 0
ASGNF4
ADDRLP4 528+28+24+8
ADDRLP4 940
INDIRF4
ASGNF4
line 2943
;2943:		trap_R_AddRefEntityToScene(&powerup);
ADDRLP4 528
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2944
;2944:	}
LABELV $1836
line 2946
;2945:
;2946:	t = cg.time - ci->medkitUsageTime;
ADDRLP4 936
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 704
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2947
;2947:	if (ci->medkitUsageTime && t < 500) {
ADDRLP4 704
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1878
ADDRLP4 936
INDIRI4
CNSTI4 500
GEI4 $1878
line 2948
;2948:		memcpy(&powerup, &torso, sizeof (torso));
ADDRLP4 528
ARGP4
ADDRLP4 176
ARGP4
CNSTI4 176
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2949
;2949:		powerup.hModel = cgs.media.medkitUsageModel;
ADDRLP4 528+8
ADDRGP4 cgs+180268+688
INDIRI4
ASGNI4
line 2950
;2950:		powerup.frame = 0;
ADDRLP4 528+80
CNSTI4 0
ASGNI4
line 2951
;2951:		powerup.oldframe = 0;
ADDRLP4 528+96
CNSTI4 0
ASGNI4
line 2952
;2952:		powerup.customSkin = 0;
ADDRLP4 528+108
CNSTI4 0
ASGNI4
line 2954
;2953:		// always draw
;2954:		powerup.renderfx &= ~RF_THIRD_PERSON;
ADDRLP4 528+4
ADDRLP4 528+4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2955
;2955:		VectorClear(angles);
ADDRLP4 960
CNSTF4 0
ASGNF4
ADDRLP4 920+8
ADDRLP4 960
INDIRF4
ASGNF4
ADDRLP4 920+4
ADDRLP4 960
INDIRF4
ASGNF4
ADDRLP4 920
ADDRLP4 960
INDIRF4
ASGNF4
line 2956
;2956:		AnglesToAxis(angles, powerup.axis);
ADDRLP4 920
ARGP4
ADDRLP4 528+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2957
;2957:		VectorCopy(cent->lerpOrigin, powerup.origin);
ADDRLP4 528+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2958
;2958:		powerup.origin[2] += -24 + (float) t * 80 / 500;
ADDRLP4 528+68+8
ADDRLP4 528+68+8
INDIRF4
CNSTF4 1117782016
ADDRLP4 936
INDIRI4
CVIF4 4
MULF4
CNSTF4 1140457472
DIVF4
CNSTF4 3250585600
ADDF4
ADDF4
ASGNF4
line 2959
;2959:		if (t > 400) {
ADDRLP4 936
INDIRI4
CNSTI4 400
LEI4 $1893
line 2960
;2960:			c = (float) (t - 1000) * 0xff / 100;
ADDRLP4 940
CNSTF4 1132396544
ADDRLP4 936
INDIRI4
CNSTI4 1000
SUBI4
CVIF4 4
MULF4
CNSTF4 1120403456
DIVF4
ASGNF4
line 2961
;2961:			powerup.shaderRGBA[0] = 0xff - c;
ADDRLP4 968
CNSTF4 1132396544
ADDRLP4 940
INDIRF4
SUBF4
ASGNF4
ADDRLP4 972
CNSTF4 1325400064
ASGNF4
ADDRLP4 968
INDIRF4
ADDRLP4 972
INDIRF4
LTF4 $1897
ADDRLP4 964
ADDRLP4 968
INDIRF4
ADDRLP4 972
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1898
JUMPV
LABELV $1897
ADDRLP4 964
ADDRLP4 968
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1898
ADDRLP4 528+116
ADDRLP4 964
INDIRU4
CVUU1 4
ASGNU1
line 2962
;2962:			powerup.shaderRGBA[1] = 0xff - c;
ADDRLP4 980
CNSTF4 1132396544
ADDRLP4 940
INDIRF4
SUBF4
ASGNF4
ADDRLP4 984
CNSTF4 1325400064
ASGNF4
ADDRLP4 980
INDIRF4
ADDRLP4 984
INDIRF4
LTF4 $1902
ADDRLP4 976
ADDRLP4 980
INDIRF4
ADDRLP4 984
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1903
JUMPV
LABELV $1902
ADDRLP4 976
ADDRLP4 980
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1903
ADDRLP4 528+116+1
ADDRLP4 976
INDIRU4
CVUU1 4
ASGNU1
line 2963
;2963:			powerup.shaderRGBA[2] = 0xff - c;
ADDRLP4 992
CNSTF4 1132396544
ADDRLP4 940
INDIRF4
SUBF4
ASGNF4
ADDRLP4 996
CNSTF4 1325400064
ASGNF4
ADDRLP4 992
INDIRF4
ADDRLP4 996
INDIRF4
LTF4 $1907
ADDRLP4 988
ADDRLP4 992
INDIRF4
ADDRLP4 996
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1908
JUMPV
LABELV $1907
ADDRLP4 988
ADDRLP4 992
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1908
ADDRLP4 528+116+2
ADDRLP4 988
INDIRU4
CVUU1 4
ASGNU1
line 2964
;2964:			powerup.shaderRGBA[3] = 0xff - c;
ADDRLP4 1004
CNSTF4 1132396544
ADDRLP4 940
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1008
CNSTF4 1325400064
ASGNF4
ADDRLP4 1004
INDIRF4
ADDRLP4 1008
INDIRF4
LTF4 $1912
ADDRLP4 1000
ADDRLP4 1004
INDIRF4
ADDRLP4 1008
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1913
JUMPV
LABELV $1912
ADDRLP4 1000
ADDRLP4 1004
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1913
ADDRLP4 528+116+3
ADDRLP4 1000
INDIRU4
CVUU1 4
ASGNU1
line 2965
;2965:		} else {
ADDRGP4 $1894
JUMPV
LABELV $1893
line 2966
;2966:			powerup.shaderRGBA[0] = 0xff;
ADDRLP4 528+116
CNSTU1 255
ASGNU1
line 2967
;2967:			powerup.shaderRGBA[1] = 0xff;
ADDRLP4 528+116+1
CNSTU1 255
ASGNU1
line 2968
;2968:			powerup.shaderRGBA[2] = 0xff;
ADDRLP4 528+116+2
CNSTU1 255
ASGNU1
line 2969
;2969:			powerup.shaderRGBA[3] = 0xff;
ADDRLP4 528+116+3
CNSTU1 255
ASGNU1
line 2970
;2970:		}
LABELV $1894
line 2971
;2971:		trap_R_AddRefEntityToScene(&powerup);
ADDRLP4 528
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2972
;2972:	}
LABELV $1878
line 2977
;2973:
;2974:	//
;2975:	// add the head
;2976:	//
;2977:	head.hModel = ci->headModel;
ADDRLP4 352+8
ADDRLP4 704
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
line 2978
;2978:	if (!head.hModel) {
ADDRLP4 352+8
INDIRI4
CNSTI4 0
NEI4 $1922
line 2979
;2979:		return;
ADDRGP4 $1394
JUMPV
LABELV $1922
line 2981
;2980:	}
;2981:	head.customSkin = ci->headSkin;
ADDRLP4 352+108
ADDRLP4 704
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ASGNI4
line 2983
;2982:
;2983:	VectorCopy(cent->lerpOrigin, head.lightingOrigin);
ADDRLP4 352+12
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 2985
;2984:
;2985:	CG_PositionRotatedEntityOnTag(&head, &torso, ci->torsoModel, "tag_head");
ADDRLP4 352
ARGP4
ADDRLP4 176
ARGP4
ADDRLP4 704
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1552
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2993
;2986:
;2987:	// 
;2988:	// add the eyes
;2989:	//
;2990:
;2991:
;2992:
;2993:	if (camereyes) {
ADDRLP4 944
INDIRI4
CNSTI4 0
EQI4 $1927
line 2994
;2994:		cent->eyesOrigin[0] = head.origin[0];
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ADDRLP4 352+68
INDIRF4
ASGNF4
line 2995
;2995:		cent->eyesOrigin[1] = head.origin[1];
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
ADDRLP4 352+68+4
INDIRF4
ASGNF4
line 2996
;2996:		cent->eyesOrigin[2] = head.origin[2];
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRLP4 352+68+8
INDIRF4
ASGNF4
line 2997
;2997:		if (cg_cameraEyes.integer == 2) {
ADDRGP4 cg_cameraEyes+12
INDIRI4
CNSTI4 2
NEI4 $1934
line 2998
;2998:			vectoangles(head.axis[0], headang);
ADDRLP4 352+28
ARGP4
ADDRGP4 headang
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2999
;2999:		} else {
ADDRGP4 $1935
JUMPV
LABELV $1934
line 3000
;3000:			VectorCopy(cent->lerpAngles, headang);
ADDRGP4 headang
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRB
ASGNB 12
line 3001
;3001:		}
LABELV $1935
line 3006
;3002:
;3003:
;3004:
;3005:
;3006:		if (cg_cameraEyes.integer) {
ADDRGP4 cg_cameraEyes+12
INDIRI4
CNSTI4 0
EQI4 $1938
line 3007
;3007:			VectorCopy(head.origin, cent->eyesOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ADDRLP4 352+68
INDIRB
ASGNB 12
line 3009
;3008:
;3009:			VectorSubtract(cent->eyesOrigin, cent->lerpOrigin, cent->eyesOrigin);
ADDRLP4 960
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 964
ADDRLP4 960
INDIRP4
CNSTI4 804
ADDP4
ASGNP4
ADDRLP4 964
INDIRP4
ADDRLP4 964
INDIRP4
INDIRF4
ADDRLP4 960
INDIRP4
CNSTI4 776
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 968
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 972
ADDRLP4 968
INDIRP4
CNSTI4 808
ADDP4
ASGNP4
ADDRLP4 972
INDIRP4
ADDRLP4 972
INDIRP4
INDIRF4
ADDRLP4 968
INDIRP4
CNSTI4 780
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 976
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 980
ADDRLP4 976
INDIRP4
CNSTI4 812
ADDP4
ASGNP4
ADDRLP4 980
INDIRP4
ADDRLP4 980
INDIRP4
INDIRF4
ADDRLP4 976
INDIRP4
CNSTI4 784
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3010
;3010:			VectorCopy(cent->eyesOrigin, headpos);
ADDRGP4 headpos
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRB
ASGNB 12
line 3011
;3011:		}
LABELV $1938
line 3012
;3012:	}
LABELV $1927
line 3014
;3013:
;3014:	VectorCopy(cent->pe.eyepos, head.eyepos[0]); // Copy it to our refdef for the renderer
ADDRLP4 352+140
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRB
ASGNB 12
line 3017
;3015:
;3016:	// HMM
;3017:	{
line 3021
;3018:		vec3_t v, forwaad;
;3019:		vec3_t orrg;
;3020:		trace_t trace;
;3021:		VectorCopy(cent->lerpAngles, v);
ADDRLP4 960
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRB
ASGNB 12
line 3022
;3022:		AngleVectors(v, forwaad, NULL, NULL);
ADDRLP4 960
ARGP4
ADDRLP4 972
ARGP4
ADDRLP4 1052
CNSTP4 0
ASGNP4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3023
;3023:		VectorMA(cent->lerpOrigin, 1024, forwaad, v);
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1060
CNSTF4 1149239296
ASGNF4
ADDRLP4 960
ADDRLP4 1056
INDIRP4
CNSTI4 776
ADDP4
INDIRF4
ADDRLP4 1060
INDIRF4
ADDRLP4 972
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 960+4
ADDRLP4 1056
INDIRP4
CNSTI4 780
ADDP4
INDIRF4
ADDRLP4 1060
INDIRF4
ADDRLP4 972+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 960+8
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRF4
CNSTF4 1149239296
ADDRLP4 972+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3024
;3024:		VectorCopy(head.origin, orrg);
ADDRLP4 1040
ADDRLP4 352+68
INDIRB
ASGNB 12
line 3025
;3025:		CG_Trace(&trace, orrg, NULL, NULL, v, -1, CONTENTS_SOLID);
ADDRLP4 984
ARGP4
ADDRLP4 1040
ARGP4
ADDRLP4 1064
CNSTP4 0
ASGNP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRLP4 960
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 3026
;3026:		if (trace.fraction < 1)
ADDRLP4 984+8
INDIRF4
CNSTF4 1065353216
GEF4 $1948
line 3027
;3027:			VectorCopy(trace.endpos, v); // look closer
ADDRLP4 960
ADDRLP4 984+12
INDIRB
ASGNB 12
LABELV $1948
line 3028
;3028:		VectorCopy(v, head.eyelook); // Copy it to our refdef for the renderer
ADDRLP4 352+164
ADDRLP4 960
INDIRB
ASGNB 12
line 3029
;3029:	}
line 3031
;3030:
;3031:	head.shadowPlane = shadowPlane;
ADDRLP4 352+24
ADDRLP4 916
INDIRF4
ASGNF4
line 3032
;3032:	head.renderfx = renderfx;
ADDRLP4 352+4
ADDRLP4 896
INDIRI4
ASGNI4
line 3036
;3033:
;3034:
;3035:	// leilei - chibi mode hack
;3036:	if (chibifactorhead) {
ADDRLP4 892
INDIRF4
CNSTF4 0
EQF4 $1955
line 3037
;3037:		VectorScale(head.axis[0], chibifactorhead, head.axis[0]);
ADDRLP4 352+28
ADDRLP4 352+28
INDIRF4
ADDRLP4 892
INDIRF4
MULF4
ASGNF4
ADDRLP4 352+28+4
ADDRLP4 352+28+4
INDIRF4
ADDRLP4 892
INDIRF4
MULF4
ASGNF4
ADDRLP4 352+28+8
ADDRLP4 352+28+8
INDIRF4
ADDRLP4 892
INDIRF4
MULF4
ASGNF4
line 3038
;3038:		VectorScale(head.axis[1], chibifactorhead, head.axis[1]);
ADDRLP4 352+28+12
ADDRLP4 352+28+12
INDIRF4
ADDRLP4 892
INDIRF4
MULF4
ASGNF4
ADDRLP4 352+28+12+4
ADDRLP4 352+28+12+4
INDIRF4
ADDRLP4 892
INDIRF4
MULF4
ASGNF4
ADDRLP4 352+28+12+8
ADDRLP4 352+28+12+8
INDIRF4
ADDRLP4 892
INDIRF4
MULF4
ASGNF4
line 3039
;3039:		VectorScale(head.axis[2], chibifactorhead, head.axis[2]);
ADDRLP4 352+28+24
ADDRLP4 352+28+24
INDIRF4
ADDRLP4 892
INDIRF4
MULF4
ASGNF4
ADDRLP4 352+28+24+4
ADDRLP4 352+28+24+4
INDIRF4
ADDRLP4 892
INDIRF4
MULF4
ASGNF4
ADDRLP4 352+28+24+8
ADDRLP4 352+28+24+8
INDIRF4
ADDRLP4 892
INDIRF4
MULF4
ASGNF4
line 3040
;3040:	}
LABELV $1955
line 3044
;3041:
;3042:
;3043:
;3044:	CG_AddRefEntityWithPowerups(&head, &cent->currentState, ci->team, qfalse);
ADDRLP4 352
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 704
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 3046
;3045:
;3046:	CG_BreathPuffs(cent, &head);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 352
ARGP4
ADDRGP4 CG_BreathPuffs
CALLV
pop
line 3048
;3047:
;3048:	CG_DustTrail(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_DustTrail
CALLV
pop
line 3053
;3049:
;3050:	//
;3051:	// add the gun / barrel / flash
;3052:	//
;3053:	CG_AddPlayerWeapon(&torso, NULL, cent, ci->team);
ADDRLP4 176
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 704
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddPlayerWeapon
CALLV
pop
line 3056
;3054:
;3055:	// add powerups floating behind the player
;3056:	CG_PlayerPowerups(cent, &torso);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ARGP4
ADDRGP4 CG_PlayerPowerups
CALLV
pop
line 3057
;3057:}
LABELV $1394
endproc CG_Player 1068 28
export CG_ResetPlayerEntity
proc CG_ResetPlayerEntity 48 12
line 3069
;3058:
;3059:
;3060://=====================================================================
;3061:
;3062:/*
;3063:===============
;3064:CG_ResetPlayerEntity
;3065:
;3066:A player just came into view or teleported, so reset all animation info
;3067:===============
;3068: */
;3069:void CG_ResetPlayerEntity(centity_t *cent) {
line 3070
;3070:	cent->errorTime = -99999; // guarantee no error decay added
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
CNSTI4 -99999
ASGNI4
line 3071
;3071:	cent->extrapolated = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 3073
;3072:
;3073:	CG_ClearLerpFrame(&cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.legs, cent->currentState.legsAnim);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 2120
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 3074
;3074:	CG_ClearLerpFrame(&cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.torso, cent->currentState.torsoAnim);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 2120
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 3076
;3075:
;3076:	BG_EvaluateTrajectory(&cent->currentState.pos, cg.time, cent->lerpOrigin);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 3077
;3077:	BG_EvaluateTrajectory(&cent->currentState.apos, cg.time, cent->lerpAngles);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 788
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 3079
;3078:
;3079:	VectorCopy(cent->lerpOrigin, cent->rawOrigin);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 740
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 3080
;3080:	VectorCopy(cent->lerpAngles, cent->rawAngles);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 752
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 788
ADDP4
INDIRB
ASGNB 12
line 3082
;3081:
;3082:	memset(&cent->pe.legs, 0, sizeof ( cent->pe.legs));
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3083
;3083:	cent->pe.legs.yawAngle = cent->rawAngles[YAW];
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 472
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 756
ADDP4
INDIRF4
ASGNF4
line 3084
;3084:	cent->pe.legs.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
CNSTI4 0
ASGNI4
line 3085
;3085:	cent->pe.legs.pitchAngle = 0;
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
CNSTF4 0
ASGNF4
line 3086
;3086:	cent->pe.legs.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 484
ADDP4
CNSTI4 0
ASGNI4
line 3088
;3087:
;3088:	memset(&cent->pe.torso, 0, sizeof ( cent->pe.legs));
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3089
;3089:	cent->pe.torso.yawAngle = cent->rawAngles[YAW];
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 520
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 756
ADDP4
INDIRF4
ASGNF4
line 3090
;3090:	cent->pe.torso.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
CNSTI4 0
ASGNI4
line 3091
;3091:	cent->pe.torso.pitchAngle = cent->rawAngles[PITCH];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 752
ADDP4
INDIRF4
ASGNF4
line 3092
;3092:	cent->pe.torso.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 3094
;3093:
;3094:	memset(&cent->pe.head, 0, sizeof ( cent->pe.head));
ADDRFP4 0
INDIRP4
CNSTI4 660
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3095
;3095:	cent->pe.head.yawAngle = cent->rawAngles[YAW];
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 680
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 756
ADDP4
INDIRF4
ASGNF4
line 3096
;3096:	cent->pe.head.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 684
ADDP4
CNSTI4 0
ASGNI4
line 3097
;3097:	cent->pe.head.pitchAngle = cent->rawAngles[PITCH];
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 688
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 752
ADDP4
INDIRF4
ASGNF4
line 3098
;3098:	cent->pe.head.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 3102
;3099:
;3100:
;3101:
;3102:	if (cg_debugPosition.integer) {
ADDRGP4 cg_debugPosition+12
INDIRI4
CNSTI4 0
EQI4 $2004
line 3103
;3103:		CG_Printf("%i ResetPlayerEntity yaw=%f\n", cent->currentState.number, cent->pe.torso.yawAngle);
ADDRGP4 $2007
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 520
ADDP4
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 3104
;3104:	}
LABELV $2004
line 3105
;3105:}
LABELV $1999
endproc CG_ResetPlayerEntity 48 12
bss
export eyeat
align 4
LABELV eyeat
skip 12
export enableQ
align 4
LABELV enableQ
skip 4
export headang
align 4
LABELV headang
skip 12
export headpos
align 4
LABELV headpos
skip 12
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
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
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
LABELV $2007
byte 1 37
byte 1 105
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 121
byte 1 97
byte 1 119
byte 1 61
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $1598
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $1552
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1413
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
byte 1 78
byte 1 117
byte 1 109
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $821
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $740
byte 1 67
byte 1 108
byte 1 97
byte 1 109
byte 1 112
byte 1 32
byte 1 108
byte 1 102
byte 1 45
byte 1 62
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $706
byte 1 65
byte 1 110
byte 1 105
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $702
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $685
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 119
byte 1 46
byte 1 32
byte 1 85
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $649
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $635
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $599
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $597
byte 1 103
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $595
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $593
byte 1 116
byte 1 108
byte 1 0
align 1
LABELV $591
byte 1 116
byte 1 116
byte 1 0
align 1
LABELV $589
byte 1 116
byte 1 0
align 1
LABELV $587
byte 1 108
byte 1 0
align 1
LABELV $585
byte 1 119
byte 1 0
align 1
LABELV $583
byte 1 104
byte 1 99
byte 1 0
align 1
LABELV $581
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $579
byte 1 99
byte 1 50
byte 1 0
align 1
LABELV $577
byte 1 99
byte 1 49
byte 1 0
align 1
LABELV $574
byte 1 110
byte 1 0
align 1
LABELV $569
byte 1 67
byte 1 71
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 58
byte 1 32
byte 1 110
byte 1 111
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
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $500
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $487
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $482
byte 1 68
byte 1 69
byte 1 70
byte 1 65
byte 1 85
byte 1 76
byte 1 84
byte 1 95
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $479
byte 1 68
byte 1 69
byte 1 70
byte 1 65
byte 1 85
byte 1 76
byte 1 84
byte 1 95
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 95
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 32
byte 1 47
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $478
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $467
byte 1 67
byte 1 71
byte 1 95
byte 1 82
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 40
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $448
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $445
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $440
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 101
byte 1 121
byte 1 101
byte 1 115
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $437
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $434
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $433
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $430
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 102
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $427
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $424
byte 1 86
byte 1 105
byte 1 109
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $423
byte 1 69
byte 1 109
byte 1 97
byte 1 99
byte 1 115
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $422
byte 1 37
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $419
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $410
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $409
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $402
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 114
byte 1 0
align 1
LABELV $401
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 114
byte 1 0
align 1
LABELV $396
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $393
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $390
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 114
byte 1 0
align 1
LABELV $387
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 114
byte 1 0
align 1
LABELV $386
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $383
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $380
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $377
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 114
byte 1 0
align 1
LABELV $374
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 114
byte 1 0
align 1
LABELV $371
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 118
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $370
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 105
byte 1 99
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $363
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 102
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 116
byte 1 114
byte 1 105
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 114
byte 1 0
align 1
LABELV $352
byte 1 72
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $349
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $346
byte 1 84
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $343
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $340
byte 1 76
byte 1 101
byte 1 103
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $337
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $336
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $333
byte 1 79
byte 1 110
byte 1 101
byte 1 112
byte 1 105
byte 1 101
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $330
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 102
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $310
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $309
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $299
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $288
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $278
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $277
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $269
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $268
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $258
byte 1 0
align 1
LABELV $257
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $256
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $226
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $173
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $170
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $167
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $156
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $147
byte 1 101
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $138
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $135
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $134
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 0
align 1
LABELV $131
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $128
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $125
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $121
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $120
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $115
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $101
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $86
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
LABELV $85
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
LABELV $84
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
LABELV $83
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
LABELV $82
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $81
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
LABELV $80
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
LABELV $79
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
LABELV $78
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
LABELV $77
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
LABELV $76
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $75
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $74
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
