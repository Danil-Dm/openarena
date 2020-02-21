export BotAI_Print
code
proc BotAI_Print 2056 16
file "../../../code/game/ai_main.c"
line 97
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
;24:/*****************************************************************************
;25: * name:		ai_main.c
;26: *
;27: * desc:		Quake3 bot AI
;28: *
;29: * $Archive: /MissionPack/code/game/ai_main.c $
;30: *
;31: *****************************************************************************/
;32:
;33:
;34:#include "g_local.h"
;35:#include "../qcommon/q_shared.h"
;36:#include "../botlib/botlib.h"		//bot lib interface
;37:#include "../botlib/be_aas.h"
;38:#include "../botlib/be_ea.h"
;39:#include "../botlib/be_ai_char.h"
;40:#include "../botlib/be_ai_chat.h"
;41:#include "../botlib/be_ai_gen.h"
;42:#include "../botlib/be_ai_goal.h"
;43:#include "../botlib/be_ai_move.h"
;44:#include "../botlib/be_ai_weap.h"
;45://
;46:#include "ai_main.h"
;47:#include "ai_dmq3.h"
;48:#include "ai_chat.h"
;49:#include "ai_cmd.h"
;50:#include "ai_dmnet.h"
;51:#include "ai_vcmd.h"
;52:
;53://
;54:#include "chars.h"
;55:#include "inv.h"
;56:#include "syn.h"
;57:
;58:#ifndef MAX_PATH
;59:#define MAX_PATH		144
;60:#endif
;61:
;62:
;63://bot states
;64:bot_state_t	*botstates[MAX_CLIENTS];
;65://number of bots
;66:int numbots;
;67://floating point time
;68:float floattime;
;69://time to do a regular update
;70:float regularupdate_time;
;71://
;72:int bot_interbreed;
;73:int bot_interbreedmatchcount;
;74://
;75:vmCvar_t bot_thinktime;
;76:vmCvar_t bot_memorydump;
;77:vmCvar_t bot_saveroutingcache;
;78:vmCvar_t bot_pause;
;79:vmCvar_t bot_report;
;80:vmCvar_t bot_testsolid;
;81:vmCvar_t bot_testclusters;
;82:vmCvar_t bot_developer;
;83:vmCvar_t bot_interbreedchar;
;84:vmCvar_t bot_interbreedbots;
;85:vmCvar_t bot_interbreedcycle;
;86:vmCvar_t bot_interbreedwrite;
;87:
;88:
;89:void ExitLevel( void );
;90:
;91:
;92:/*
;93:==================
;94:BotAI_Print
;95:==================
;96:*/
;97:void QDECL BotAI_Print(int type, const char *fmt, ...) {
line 101
;98:	char str[2048];
;99:	va_list ap;
;100:
;101:	va_start(ap, fmt);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 102
;102:	Q_vsnprintf(str, sizeof(str), fmt, ap);
ADDRLP4 4
ARGP4
CNSTI4 2048
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_vsnprintf
CALLI4
pop
line 103
;103:	va_end(ap);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 105
;104:
;105:	switch(type) {
ADDRLP4 2052
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 1
LTI4 $63
ADDRLP4 2052
INDIRI4
CNSTI4 5
GTI4 $63
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $76-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $76
address $65
address $67
address $69
address $71
address $73
code
LABELV $65
line 106
;106:		case PRT_MESSAGE: {
line 107
;107:			G_Printf("%s", str);
ADDRGP4 $66
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 108
;108:			break;
ADDRGP4 $64
JUMPV
LABELV $67
line 110
;109:		}
;110:		case PRT_WARNING: {
line 111
;111:			G_Printf( S_COLOR_YELLOW "Warning: %s", str );
ADDRGP4 $68
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 112
;112:			break;
ADDRGP4 $64
JUMPV
LABELV $69
line 114
;113:		}
;114:		case PRT_ERROR: {
line 115
;115:			G_Printf( S_COLOR_RED "Error: %s", str );
ADDRGP4 $70
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 116
;116:			break;
ADDRGP4 $64
JUMPV
LABELV $71
line 118
;117:		}
;118:		case PRT_FATAL: {
line 119
;119:			G_Printf( S_COLOR_RED "Fatal: %s", str );
ADDRGP4 $72
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 120
;120:			break;
ADDRGP4 $64
JUMPV
LABELV $73
line 122
;121:		}
;122:		case PRT_EXIT: {
line 123
;123:			G_Error( S_COLOR_RED "Exit: %s", str );
ADDRGP4 $74
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 124
;124:			break;
ADDRGP4 $64
JUMPV
LABELV $63
line 126
;125:		}
;126:		default: {
line 127
;127:			G_Printf( "unknown print type\n" );
ADDRGP4 $75
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 128
;128:			break;
LABELV $64
line 131
;129:		}
;130:	}
;131:}
LABELV $61
endproc BotAI_Print 2056 16
export BotAI_Trace
proc BotAI_Trace 56 28
line 139
;132:
;133:
;134:/*
;135:==================
;136:BotAI_Trace
;137:==================
;138:*/
;139:void BotAI_Trace(bsp_trace_t *bsptrace, vec3_t start, vec3_t mins, vec3_t maxs, vec3_t end, int passent, int contentmask) {
line 142
;140:	trace_t trace;
;141:
;142:	trap_Trace(&trace, start, mins, maxs, end, passent, contentmask);
ADDRLP4 0
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
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 144
;143:	//copy the trace information
;144:	bsptrace->allsolid = trace.allsolid;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 145
;145:	bsptrace->startsolid = trace.startsolid;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0+4
INDIRI4
ASGNI4
line 146
;146:	bsptrace->fraction = trace.fraction;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0+8
INDIRF4
ASGNF4
line 147
;147:	VectorCopy(trace.endpos, bsptrace->endpos);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 148
;148:	bsptrace->plane.dist = trace.plane.dist;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0+24+12
INDIRF4
ASGNF4
line 149
;149:	VectorCopy(trace.plane.normal, bsptrace->plane.normal);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 150
;150:	bsptrace->plane.signbits = trace.plane.signbits;
ADDRFP4 0
INDIRP4
CNSTI4 41
ADDP4
ADDRLP4 0+24+17
INDIRU1
ASGNU1
line 151
;151:	bsptrace->plane.type = trace.plane.type;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+24+16
INDIRU1
ASGNU1
line 152
;152:	bsptrace->surface.value = trace.surfaceFlags;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 0+44
INDIRI4
ASGNI4
line 153
;153:	bsptrace->ent = trace.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 154
;154:	bsptrace->exp_dist = 0;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 0
ASGNF4
line 155
;155:	bsptrace->sidenum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 156
;156:	bsptrace->contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTI4 0
ASGNI4
line 157
;157:}
LABELV $78
endproc BotAI_Trace 56 28
export BotAI_GetClientState
proc BotAI_GetClientState 4 12
line 164
;158:
;159:/*
;160:==================
;161:BotAI_GetClientState
;162:==================
;163:*/
;164:int BotAI_GetClientState( int clientNum, playerState_t *state ) {
line 167
;165:	gentity_t	*ent;
;166:
;167:	ent = &g_entities[clientNum];
ADDRLP4 0
CNSTI4 816
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 168
;168:	if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $92
line 169
;169:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $91
JUMPV
LABELV $92
line 171
;170:	}
;171:	if ( !ent->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $94
line 172
;172:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $91
JUMPV
LABELV $94
line 175
;173:	}
;174:
;175:	memcpy( state, &ent->client->ps, sizeof(playerState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 176
;176:	return qtrue;
CNSTI4 1
RETI4
LABELV $91
endproc BotAI_GetClientState 4 12
export BotAI_GetEntityState
proc BotAI_GetEntityState 12 12
line 184
;177:}
;178:
;179:/*
;180:==================
;181:BotAI_GetEntityState
;182:==================
;183:*/
;184:int BotAI_GetEntityState( int entityNum, entityState_t *state ) {
line 187
;185:	gentity_t	*ent;
;186:
;187:	ent = &g_entities[entityNum];
ADDRLP4 0
CNSTI4 816
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 188
;188:	memset( state, 0, sizeof(entityState_t) );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 189
;189:	if (!ent->inuse) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $97
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $97
line 190
;190:	if (!ent->r.linked) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $99
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $99
line 191
;191:	if ( !(G_IsARoundBasedGametype(g_gametype.integer) ||g_instantgib.integer || g_rockets.integer || g_elimination_allgametypes.integer)
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $101
ADDRGP4 g_instantgib+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $101
ADDRGP4 g_rockets+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $101
ADDRGP4 g_elimination_allgametypes+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $101
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $101
line 192
;192:	       && (ent->r.svFlags & SVF_NOCLIENT) ) {
line 193
;193:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $101
line 195
;194:	}
;195:	memcpy( state, &ent->s, sizeof(entityState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 208
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 196
;196:	return qtrue;
CNSTI4 1
RETI4
LABELV $96
endproc BotAI_GetEntityState 12 12
export BotAI_GetSnapshotEntity
proc BotAI_GetSnapshotEntity 8 12
line 204
;197:}
;198:
;199:/*
;200:==================
;201:BotAI_GetSnapshotEntity
;202:==================
;203:*/
;204:int BotAI_GetSnapshotEntity( int clientNum, int sequence, entityState_t *state ) {
line 207
;205:	int		entNum;
;206:
;207:	entNum = trap_BotGetSnapshotEntity( clientNum, sequence );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_BotGetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 208
;208:	if ( entNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $108
line 209
;209:		memset(state, 0, sizeof(entityState_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 210
;210:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $107
JUMPV
LABELV $108
line 213
;211:	}
;212:
;213:	BotAI_GetEntityState( entNum, state );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 215
;214:
;215:	return sequence + 1;
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
RETI4
LABELV $107
endproc BotAI_GetSnapshotEntity 8 12
export BotAI_BotInitialChat
proc BotAI_BotInitialChat 56 44
line 223
;216:}
;217:
;218:/*
;219:==================
;220:BotAI_BotInitialChat
;221:==================
;222:*/
;223:void QDECL BotAI_BotInitialChat( bot_state_t *bs, char *type, ... ) {
line 229
;224:	int		i, mcontext;
;225:	va_list	ap;
;226:	char	*p;
;227:	char	*vars[MAX_MATCHVARIABLES];
;228:
;229:	memset(vars, 0, sizeof(vars));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 memset
CALLP4
pop
line 230
;230:	va_start(ap, type);
ADDRLP4 40
ADDRFP4 4+4
ASGNP4
line 231
;231:	p = va_arg(ap, char *);
ADDRLP4 48
ADDRLP4 40
INDIRP4
CNSTU4 4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 48
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 48
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
ASGNP4
line 232
;232:	for (i = 0; i < MAX_MATCHVARIABLES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $112
line 233
;233:		if( !p ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $116
line 234
;234:			break;
ADDRGP4 $114
JUMPV
LABELV $116
line 236
;235:		}
;236:		vars[i] = p;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 237
;237:		p = va_arg(ap, char *);
ADDRLP4 52
ADDRLP4 40
INDIRP4
CNSTU4 4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 52
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
ASGNP4
line 238
;238:	}
LABELV $113
line 232
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $112
LABELV $114
line 239
;239:	va_end(ap);
ADDRLP4 40
CNSTP4 0
ASGNP4
line 241
;240:
;241:	mcontext = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 52
INDIRI4
ASGNI4
line 243
;242:
;243:	trap_BotInitialChat( bs->cs, type, mcontext, vars[0], vars[1], vars[2], vars[3], vars[4], vars[5], vars[6], vars[7] );
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8+4
INDIRP4
ARGP4
ADDRLP4 8+8
INDIRP4
ARGP4
ADDRLP4 8+12
INDIRP4
ARGP4
ADDRLP4 8+16
INDIRP4
ARGP4
ADDRLP4 8+20
INDIRP4
ARGP4
ADDRLP4 8+24
INDIRP4
ARGP4
ADDRLP4 8+28
INDIRP4
ARGP4
ADDRGP4 trap_BotInitialChat
CALLV
pop
line 244
;244:}
LABELV $110
endproc BotAI_BotInitialChat 56 44
export BotTestAAS
proc BotTestAAS 64 16
line 252
;245:
;246:
;247:/*
;248:==================
;249:BotTestAAS
;250:==================
;251:*/
;252:void BotTestAAS(vec3_t origin) {
line 256
;253:	int areanum;
;254:	aas_areainfo_t info;
;255:
;256:	trap_Cvar_Update(&bot_testsolid);
ADDRGP4 bot_testsolid
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 257
;257:	trap_Cvar_Update(&bot_testclusters);
ADDRGP4 bot_testclusters
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 258
;258:	if (bot_testsolid.integer) {
ADDRGP4 bot_testsolid+12
INDIRI4
CNSTI4 0
EQI4 $126
line 259
;259:		if (!trap_AAS_Initialized()) return;
ADDRLP4 56
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $129
ADDRGP4 $125
JUMPV
LABELV $129
line 260
;260:		areanum = BotPointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 261
;261:		if (areanum) BotAI_Print(PRT_MESSAGE, "\rempty area");
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $131
CNSTI4 1
ARGI4
ADDRGP4 $133
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $127
JUMPV
LABELV $131
line 262
;262:		else BotAI_Print(PRT_MESSAGE, "\r^1SOLID area");
CNSTI4 1
ARGI4
ADDRGP4 $134
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 263
;263:	}
ADDRGP4 $127
JUMPV
LABELV $126
line 264
;264:	else if (bot_testclusters.integer) {
ADDRGP4 bot_testclusters+12
INDIRI4
CNSTI4 0
EQI4 $135
line 265
;265:		if (!trap_AAS_Initialized()) return;
ADDRLP4 56
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $138
ADDRGP4 $125
JUMPV
LABELV $138
line 266
;266:		areanum = BotPointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 267
;267:		if (!areanum)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $140
line 268
;268:			BotAI_Print(PRT_MESSAGE, "\r^1Solid!                              ");
CNSTI4 1
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $141
JUMPV
LABELV $140
line 269
;269:		else {
line 270
;270:			trap_AAS_AreaInfo(areanum, &info);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 271
;271:			BotAI_Print(PRT_MESSAGE, "\rarea %d, cluster %d       ", areanum, info.cluster);
CNSTI4 1
ARGI4
ADDRGP4 $143
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4+12
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 272
;272:		}
LABELV $141
line 273
;273:	}
LABELV $135
LABELV $127
line 274
;274:}
LABELV $125
endproc BotTestAAS 64 16
export BotReportStatus
proc BotReportStatus 568 24
line 281
;275:
;276:/*
;277:==================
;278:BotReportStatus
;279:==================
;280:*/
;281:void BotReportStatus(bot_state_t *bs) {
line 286
;282:	char goalname[MAX_MESSAGE_SIZE];
;283:	char netname[MAX_MESSAGE_SIZE];
;284:	char *leader, flagstatus[32];
;285:	//
;286:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 287
;287:	if ( Q_strequal(netname, bs->teamleader) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 548
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 0
NEI4 $146
line 288
;288:		leader = "L";
ADDRLP4 288
ADDRGP4 $148
ASGNP4
line 289
;289:	}
ADDRGP4 $147
JUMPV
LABELV $146
line 290
;290:	else {
line 291
;291:		leader = " ";
ADDRLP4 288
ADDRGP4 $149
ASGNP4
line 292
;292:	}
LABELV $147
line 294
;293:
;294:	strcpy(flagstatus, "  ");
ADDRLP4 256
ARGP4
ADDRGP4 $150
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 295
;295:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 552
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $151
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 556
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 556
INDIRI4
CNSTI4 0
NEI4 $151
line 296
;296:		if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 560
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 0
EQI4 $152
line 297
;297:			if (BotTeam(bs) == TEAM_RED) strcpy(flagstatus, S_COLOR_RED"F ");
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 564
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 564
INDIRI4
CNSTI4 1
NEI4 $155
ADDRLP4 256
ARGP4
ADDRGP4 $157
ARGP4
ADDRGP4 strcpy
CALLP4
pop
ADDRGP4 $152
JUMPV
LABELV $155
line 298
;298:			else strcpy(flagstatus, S_COLOR_BLUE"F ");
ADDRLP4 256
ARGP4
ADDRGP4 $158
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 299
;299:		}
line 300
;300:	}
ADDRGP4 $152
JUMPV
LABELV $151
line 301
;301:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $159
line 302
;302:		if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 560
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 0
EQI4 $160
line 303
;303:			if (BotTeam(bs) == TEAM_RED) strcpy(flagstatus, S_COLOR_RED"F ");
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 564
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 564
INDIRI4
CNSTI4 1
NEI4 $163
ADDRLP4 256
ARGP4
ADDRGP4 $157
ARGP4
ADDRGP4 strcpy
CALLP4
pop
ADDRGP4 $160
JUMPV
LABELV $163
line 304
;304:			else strcpy(flagstatus, S_COLOR_BLUE"F ");
ADDRLP4 256
ARGP4
ADDRGP4 $158
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 305
;305:		}
line 306
;306:	}
ADDRGP4 $160
JUMPV
LABELV $159
line 307
;307:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $165
line 308
;308:		if (BotHarvesterCarryingCubes(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 560
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 0
EQI4 $167
line 309
;309:			if (BotTeam(bs) == TEAM_RED) Com_sprintf(flagstatus, sizeof(flagstatus), S_COLOR_RED"%2d", bs->inventory[INVENTORY_REDCUBE]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 564
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 564
INDIRI4
CNSTI4 1
NEI4 $169
ADDRLP4 256
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $171
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5000
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $170
JUMPV
LABELV $169
line 310
;310:			else Com_sprintf(flagstatus, sizeof(flagstatus), S_COLOR_BLUE"%2d", bs->inventory[INVENTORY_BLUECUBE]);
ADDRLP4 256
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $172
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
LABELV $170
line 311
;311:		}
LABELV $167
line 312
;312:	}
LABELV $165
LABELV $160
LABELV $152
line 314
;313:
;314:	switch(bs->ltgtype) {
ADDRLP4 560
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 1
LTI4 $173
ADDRLP4 560
INDIRI4
CNSTI4 17
GTI4 $173
ADDRLP4 560
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $205-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $205
address $176
address $178
address $180
address $190
address $192
address $194
address $186
address $186
address $188
address $182
address $184
address $198
address $196
address $173
address $173
address $200
address $202
code
LABELV $176
line 316
;315:		case LTG_TEAMHELP:
;316:		{
line 317
;317:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 318
;318:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: helping %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $177
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 319
;319:			break;
ADDRGP4 $174
JUMPV
LABELV $178
line 322
;320:		}
;321:		case LTG_TEAMACCOMPANY:
;322:		{
line 323
;323:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 324
;324:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: accompanying %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $179
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 325
;325:			break;
ADDRGP4 $174
JUMPV
LABELV $180
line 328
;326:		}
;327:		case LTG_DEFENDKEYAREA:
;328:		{
line 329
;329:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 330
;330:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: defending %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $181
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 331
;331:			break;
ADDRGP4 $174
JUMPV
LABELV $182
line 334
;332:		}
;333:		case LTG_GETITEM:
;334:		{
line 335
;335:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 336
;336:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: getting item %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $183
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 337
;337:			break;
ADDRGP4 $174
JUMPV
LABELV $184
line 340
;338:		}
;339:		case LTG_KILL:
;340:		{
line 341
;341:			ClientName(bs->teamgoal.entitynum, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 342
;342:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: killing %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $185
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 343
;343:			break;
ADDRGP4 $174
JUMPV
LABELV $186
line 347
;344:		}
;345:		case LTG_CAMP:
;346:		case LTG_CAMPORDER:
;347:		{
line 348
;348:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: camping\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $187
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 349
;349:			break;
ADDRGP4 $174
JUMPV
LABELV $188
line 352
;350:		}
;351:		case LTG_PATROL:
;352:		{
line 353
;353:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: patrolling\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $189
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 354
;354:			break;
ADDRGP4 $174
JUMPV
LABELV $190
line 357
;355:		}
;356:		case LTG_GETFLAG:
;357:		{
line 358
;358:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: capturing flag\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $191
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 359
;359:			break;
ADDRGP4 $174
JUMPV
LABELV $192
line 362
;360:		}
;361:		case LTG_RUSHBASE:
;362:		{
line 363
;363:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: rushing base\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $193
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 364
;364:			break;
ADDRGP4 $174
JUMPV
LABELV $194
line 367
;365:		}
;366:		case LTG_RETURNFLAG:
;367:		{
line 368
;368:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: returning flag\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $195
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 369
;369:			break;
ADDRGP4 $174
JUMPV
LABELV $196
line 372
;370:		}
;371:		case LTG_ATTACKENEMYBASE:
;372:		{
line 373
;373:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: attacking the enemy base\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $197
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 374
;374:			break;
ADDRGP4 $174
JUMPV
LABELV $198
line 377
;375:		}
;376:		case LTG_HARVEST:
;377:		{
line 378
;378:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: harvesting\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $199
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 379
;379:			break;
ADDRGP4 $174
JUMPV
LABELV $200
line 382
;380:		}
;381:		case LTG_POINTA:
;382:		{
line 383
;383:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: going for point A\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $201
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 384
;384:			break;
ADDRGP4 $174
JUMPV
LABELV $202
line 387
;385:		}
;386:		case LTG_POINTB:
;387:		{
line 388
;388:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: going for point B\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $203
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 389
;389:			break;
ADDRGP4 $174
JUMPV
LABELV $173
line 392
;390:		}
;391:		default:
;392:		{
line 393
;393:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: roaming\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $204
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 394
;394:			break;
LABELV $174
line 397
;395:		}
;396:	}
;397:}
LABELV $145
endproc BotReportStatus 568 24
export BotTeamplayReport
proc BotTeamplayReport 1052 12
line 404
;398:
;399:/*
;400:==================
;401:BotTeamplayReport
;402:==================
;403:*/
;404:void BotTeamplayReport(void) {
line 408
;405:	int i;
;406:	char buf[MAX_INFO_STRING];
;407:
;408:	BotAI_Print(PRT_MESSAGE, S_COLOR_RED"RED\n");
CNSTI4 1
ARGI4
ADDRGP4 $208
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 409
;409:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $212
JUMPV
LABELV $209
line 411
;410:		//
;411:		if ( !botstates[i] || !botstates[i]->inuse ) continue;
ADDRLP4 1028
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $216
ADDRLP4 1028
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $214
LABELV $216
ADDRGP4 $210
JUMPV
LABELV $214
line 413
;412:		//
;413:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 415
;414:		//if no config string or no name
;415:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1032
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $220
ADDRLP4 4
ARGP4
ADDRGP4 $219
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $217
LABELV $220
ADDRGP4 $210
JUMPV
LABELV $217
line 417
;416:		//skip spectators
;417:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_RED) {
ADDRLP4 4
ARGP4
ADDRGP4 $223
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 1
NEI4 $221
line 418
;418:			BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 419
;419:		}
LABELV $221
line 420
;420:	}
LABELV $210
line 409
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $212
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $209
line 421
;421:	BotAI_Print(PRT_MESSAGE, S_COLOR_BLUE"BLUE\n");
CNSTI4 1
ARGI4
ADDRGP4 $224
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 422
;422:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $228
JUMPV
LABELV $225
line 424
;423:		//
;424:		if ( !botstates[i] || !botstates[i]->inuse ) continue;
ADDRLP4 1028
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $232
ADDRLP4 1028
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $230
LABELV $232
ADDRGP4 $226
JUMPV
LABELV $230
line 426
;425:		//
;426:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 428
;427:		//if no config string or no name
;428:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1032
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $235
ADDRLP4 4
ARGP4
ADDRGP4 $219
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $233
LABELV $235
ADDRGP4 $226
JUMPV
LABELV $233
line 430
;429:		//skip spectators
;430:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_BLUE) {
ADDRLP4 4
ARGP4
ADDRGP4 $223
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 2
NEI4 $236
line 431
;431:			BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 432
;432:		}
LABELV $236
line 433
;433:	}
LABELV $226
line 422
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $228
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $225
line 434
;434:}
LABELV $207
endproc BotTeamplayReport 1052 12
export BotSetInfoConfigString
proc BotSetInfoConfigString 892 16
line 441
;435:
;436:/*
;437:==================
;438:BotSetInfoConfigString
;439:==================
;440:*/
;441:void BotSetInfoConfigString(bot_state_t *bs) {
line 448
;442:	char goalname[MAX_MESSAGE_SIZE];
;443:	char netname[MAX_MESSAGE_SIZE];
;444:	char action[MAX_MESSAGE_SIZE];
;445:	char *leader, carrying[32], *cs;
;446:	bot_goal_t goal;
;447:	//
;448:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 449
;449:	if ( Q_strequal(netname, bs->teamleader) ) {
ADDRLP4 256
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 864
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 864
INDIRI4
CNSTI4 0
NEI4 $239
line 450
;450:		leader = "L";
ADDRLP4 544
ADDRGP4 $148
ASGNP4
line 451
;451:	}
ADDRGP4 $240
JUMPV
LABELV $239
line 452
;452:	else {
line 453
;453:		leader = " ";
ADDRLP4 544
ADDRGP4 $149
ASGNP4
line 454
;454:	}
LABELV $240
line 456
;455:
;456:	strcpy(carrying, "  ");
ADDRLP4 512
ARGP4
ADDRGP4 $150
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 457
;457:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 868
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 0
EQI4 $241
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 872
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 872
INDIRI4
CNSTI4 0
NEI4 $241
line 458
;458:		if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 876
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 876
INDIRI4
CNSTI4 0
EQI4 $242
line 459
;459:			strcpy(carrying, "F ");
ADDRLP4 512
ARGP4
ADDRGP4 $245
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 460
;460:		}
line 461
;461:	}
ADDRGP4 $242
JUMPV
LABELV $241
line 462
;462:	else if (G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 876
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 876
INDIRI4
CNSTI4 0
EQI4 $246
line 463
;463:		if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 880
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 880
INDIRI4
CNSTI4 0
EQI4 $247
line 464
;464:			strcpy(carrying, "F ");
ADDRLP4 512
ARGP4
ADDRGP4 $245
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 465
;465:		}
line 466
;466:	}
ADDRGP4 $247
JUMPV
LABELV $246
line 467
;467:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $250
line 468
;468:		if (BotHarvesterCarryingCubes(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 880
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 880
INDIRI4
CNSTI4 0
EQI4 $252
line 469
;469:			if (BotTeam(bs) == TEAM_RED) Com_sprintf(carrying, sizeof(carrying), "%2d", bs->inventory[INVENTORY_REDCUBE]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 884
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 884
INDIRI4
CNSTI4 1
NEI4 $254
ADDRLP4 512
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $256
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5000
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $255
JUMPV
LABELV $254
line 470
;470:			else Com_sprintf(carrying, sizeof(carrying), "%2d", bs->inventory[INVENTORY_BLUECUBE]);
ADDRLP4 512
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $256
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
LABELV $255
line 471
;471:		}
LABELV $252
line 472
;472:	}
LABELV $250
LABELV $247
LABELV $242
line 474
;473:
;474:	switch(bs->ltgtype) {
ADDRLP4 880
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 880
INDIRI4
CNSTI4 1
LTI4 $257
ADDRLP4 880
INDIRI4
CNSTI4 17
GTI4 $257
ADDRLP4 880
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $290-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $290
address $260
address $262
address $264
address $274
address $276
address $278
address $270
address $270
address $272
address $266
address $268
address $282
address $280
address $257
address $257
address $284
address $286
code
LABELV $260
line 476
;475:		case LTG_TEAMHELP:
;476:		{
line 477
;477:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 478
;478:			Com_sprintf(action, sizeof(action), "helping %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $261
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 479
;479:			break;
ADDRGP4 $258
JUMPV
LABELV $262
line 482
;480:		}
;481:		case LTG_TEAMACCOMPANY:
;482:		{
line 483
;483:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 484
;484:			Com_sprintf(action, sizeof(action), "accompanying %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $263
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 485
;485:			break;
ADDRGP4 $258
JUMPV
LABELV $264
line 488
;486:		}
;487:		case LTG_DEFENDKEYAREA:
;488:		{
line 489
;489:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 490
;490:			Com_sprintf(action, sizeof(action), "defending %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $265
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 491
;491:			break;
ADDRGP4 $258
JUMPV
LABELV $266
line 494
;492:		}
;493:		case LTG_GETITEM:
;494:		{
line 495
;495:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 496
;496:			Com_sprintf(action, sizeof(action), "getting item %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $267
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 497
;497:			break;
ADDRGP4 $258
JUMPV
LABELV $268
line 500
;498:		}
;499:		case LTG_KILL:
;500:		{
line 501
;501:			ClientName(bs->teamgoal.entitynum, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 502
;502:			Com_sprintf(action, sizeof(action), "killing %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $269
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 503
;503:			break;
ADDRGP4 $258
JUMPV
LABELV $270
line 507
;504:		}
;505:		case LTG_CAMP:
;506:		case LTG_CAMPORDER:
;507:		{
line 508
;508:			Com_sprintf(action, sizeof(action), "camping");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $271
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 509
;509:			break;
ADDRGP4 $258
JUMPV
LABELV $272
line 512
;510:		}
;511:		case LTG_PATROL:
;512:		{
line 513
;513:			Com_sprintf(action, sizeof(action), "patrolling");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $273
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 514
;514:			break;
ADDRGP4 $258
JUMPV
LABELV $274
line 517
;515:		}
;516:		case LTG_GETFLAG:
;517:		{
line 518
;518:			Com_sprintf(action, sizeof(action), "capturing flag");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $275
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 519
;519:			break;
ADDRGP4 $258
JUMPV
LABELV $276
line 522
;520:		}
;521:		case LTG_RUSHBASE:
;522:		{
line 523
;523:			Com_sprintf(action, sizeof(action), "rushing base");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $277
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 524
;524:			break;
ADDRGP4 $258
JUMPV
LABELV $278
line 527
;525:		}
;526:		case LTG_RETURNFLAG:
;527:		{
line 528
;528:			Com_sprintf(action, sizeof(action), "returning flag");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $279
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 529
;529:			break;
ADDRGP4 $258
JUMPV
LABELV $280
line 532
;530:		}
;531:		case LTG_ATTACKENEMYBASE:
;532:		{
line 533
;533:			Com_sprintf(action, sizeof(action), "attacking the enemy base");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $281
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 534
;534:			break;
ADDRGP4 $258
JUMPV
LABELV $282
line 537
;535:		}
;536:		case LTG_HARVEST:
;537:		{
line 538
;538:			Com_sprintf(action, sizeof(action), "harvesting");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $283
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 539
;539:			break;
ADDRGP4 $258
JUMPV
LABELV $284
line 542
;540:		}
;541:		case LTG_POINTA:
;542:		{
line 543
;543:			Com_sprintf(action, sizeof(action), "going for point A");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $285
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 544
;544:			break;
ADDRGP4 $258
JUMPV
LABELV $286
line 547
;545:		}
;546:		case LTG_POINTB:
;547:		{
line 548
;548:			Com_sprintf(action, sizeof(action), "going for point B");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $287
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 549
;549:			break;
ADDRGP4 $258
JUMPV
LABELV $257
line 552
;550:		}
;551:		default:
;552:		{
line 553
;553:			trap_BotGetTopGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 808
ARGP4
ADDRGP4 trap_BotGetTopGoal
CALLI4
pop
line 554
;554:			trap_BotGoalName(goal.number, goalname, sizeof(goalname));
ADDRLP4 808+44
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 555
;555:			Com_sprintf(action, sizeof(action), "roaming %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $289
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 556
;556:			break;
LABELV $258
line 559
;557:		}
;558:	}
;559:	cs = va("l\\%s\\c\\%s\\a\\%s",
ADDRGP4 $292
ARGP4
ADDRLP4 544
INDIRP4
ARGP4
ADDRLP4 512
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 888
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 548
ADDRLP4 888
INDIRP4
ASGNP4
line 563
;560:	            leader,
;561:	            carrying,
;562:	            action);
;563:	trap_SetConfigstring (CS_BOTINFO + bs->client, cs);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ARGI4
ADDRLP4 548
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 564
;564:}
LABELV $238
endproc BotSetInfoConfigString 892 16
export BotUpdateInfoConfigStrings
proc BotUpdateInfoConfigStrings 1044 12
line 571
;565:
;566:/*
;567:==============
;568:BotUpdateInfoConfigStrings
;569:==============
;570:*/
;571:void BotUpdateInfoConfigStrings(void) {
line 575
;572:	int i;
;573:	char buf[MAX_INFO_STRING];
;574:
;575:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $297
JUMPV
LABELV $294
line 577
;576:		//
;577:		if ( !botstates[i] || !botstates[i]->inuse )
ADDRLP4 1028
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $301
ADDRLP4 1028
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $299
LABELV $301
line 578
;578:			continue;
ADDRGP4 $295
JUMPV
LABELV $299
line 580
;579:		//
;580:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 582
;581:		//if no config string or no name
;582:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n")))
ADDRLP4 4
ARGP4
ADDRLP4 1032
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $304
ADDRLP4 4
ARGP4
ADDRGP4 $219
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $302
LABELV $304
line 583
;583:			continue;
ADDRGP4 $295
JUMPV
LABELV $302
line 584
;584:		BotSetInfoConfigString(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotSetInfoConfigString
CALLV
pop
line 585
;585:	}
LABELV $295
line 575
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $297
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $294
line 586
;586:}
LABELV $293
endproc BotUpdateInfoConfigStrings 1044 12
export BotInterbreedBots
proc BotInterbreedBots 288 20
line 593
;587:
;588:/*
;589:==============
;590:BotInterbreedBots
;591:==============
;592:*/
;593:void BotInterbreedBots(void) {
line 599
;594:	float ranks[MAX_CLIENTS];
;595:	int parent1, parent2, child;
;596:	int i;
;597:
;598:	// get rankings for all the bots
;599:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $306
line 600
;600:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 272
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $310
ADDRLP4 272
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $310
line 601
;601:			ranks[i] = botstates[i]->num_kills * 2 - botstates[i]->num_deaths;
ADDRLP4 276
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 280
ADDRLP4 276
INDIRI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 276
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 280
INDIRP4
CNSTI4 5888
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 280
INDIRP4
CNSTI4 5884
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 602
;602:		}
ADDRGP4 $311
JUMPV
LABELV $310
line 603
;603:		else {
line 604
;604:			ranks[i] = -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 3212836864
ASGNF4
line 605
;605:		}
LABELV $311
line 606
;606:	}
LABELV $307
line 599
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $306
line 608
;607:
;608:	if (trap_GeneticParentsAndChildSelection(MAX_CLIENTS, ranks, &parent1, &parent2, &child)) {
CNSTI4 64
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 268
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 272
ADDRGP4 trap_GeneticParentsAndChildSelection
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $312
line 609
;609:		trap_BotInterbreedGoalFuzzyLogic(botstates[parent1]->gs, botstates[parent2]->gs, botstates[child]->gs);
ADDRLP4 276
CNSTI4 2
ASGNI4
ADDRLP4 280
ADDRGP4 botstates
ASGNP4
ADDRLP4 284
CNSTI4 6384
ASGNI4
ADDRLP4 264
INDIRI4
ADDRLP4 276
INDIRI4
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 268
INDIRI4
ADDRLP4 276
INDIRI4
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
INDIRI4
ADDRLP4 276
INDIRI4
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotInterbreedGoalFuzzyLogic
CALLV
pop
line 610
;610:		trap_BotMutateGoalFuzzyLogic(botstates[child]->gs, 1);
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_BotMutateGoalFuzzyLogic
CALLV
pop
line 611
;611:	}
LABELV $312
line 613
;612:	// reset the kills and deaths
;613:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $314
line 614
;614:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 276
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $318
ADDRLP4 276
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $318
line 615
;615:			botstates[i]->num_kills = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 5888
ADDP4
CNSTI4 0
ASGNI4
line 616
;616:			botstates[i]->num_deaths = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 5884
ADDP4
CNSTI4 0
ASGNI4
line 617
;617:		}
LABELV $318
line 618
;618:	}
LABELV $315
line 613
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $314
line 619
;619:}
LABELV $305
endproc BotInterbreedBots 288 20
export BotWriteInterbreeded
proc BotWriteInterbreeded 24 8
line 626
;620:
;621:/*
;622:==============
;623:BotWriteInterbreeded
;624:==============
;625:*/
;626:void BotWriteInterbreeded(char *filename) {
line 630
;627:	float rank, bestrank;
;628:	int i, bestbot;
;629:
;630:	bestrank = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 631
;631:	bestbot = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 633
;632:	// get the best bot
;633:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $321
line 634
;634:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $325
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $325
line 635
;635:			rank = botstates[i]->num_kills * 2 - botstates[i]->num_deaths;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
CNSTI4 5888
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 5884
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 636
;636:		}
ADDRGP4 $326
JUMPV
LABELV $325
line 637
;637:		else {
line 638
;638:			rank = -1;
ADDRLP4 4
CNSTF4 3212836864
ASGNF4
line 639
;639:		}
LABELV $326
line 640
;640:		if (rank > bestrank) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $327
line 641
;641:			bestrank = rank;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ASGNF4
line 642
;642:			bestbot = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 643
;643:		}
LABELV $327
line 644
;644:	}
LABELV $322
line 633
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $321
line 645
;645:	if (bestbot >= 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $329
line 647
;646:		//write out the new goal fuzzy logic
;647:		trap_BotSaveGoalFuzzyLogic(botstates[bestbot]->gs, filename);
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_BotSaveGoalFuzzyLogic
CALLV
pop
line 648
;648:	}
LABELV $329
line 649
;649:}
LABELV $320
endproc BotWriteInterbreeded 24 8
export BotInterbreedEndMatch
proc BotInterbreedEndMatch 8 8
line 658
;650:
;651:/*
;652:==============
;653:BotInterbreedEndMatch
;654:
;655:add link back into ExitLevel?
;656:==============
;657:*/
;658:void BotInterbreedEndMatch(void) {
line 660
;659:
;660:	if (!bot_interbreed) return;
ADDRGP4 bot_interbreed
INDIRI4
CNSTI4 0
NEI4 $332
ADDRGP4 $331
JUMPV
LABELV $332
line 661
;661:	bot_interbreedmatchcount++;
ADDRLP4 0
ADDRGP4 bot_interbreedmatchcount
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 662
;662:	if (bot_interbreedmatchcount >= bot_interbreedcycle.integer) {
ADDRGP4 bot_interbreedmatchcount
INDIRI4
ADDRGP4 bot_interbreedcycle+12
INDIRI4
LTI4 $334
line 663
;663:		bot_interbreedmatchcount = 0;
ADDRGP4 bot_interbreedmatchcount
CNSTI4 0
ASGNI4
line 665
;664:		//
;665:		trap_Cvar_Update(&bot_interbreedwrite);
ADDRGP4 bot_interbreedwrite
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 666
;666:		if (strlen(bot_interbreedwrite.string)) {
ADDRGP4 bot_interbreedwrite+16
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $337
line 667
;667:			BotWriteInterbreeded(bot_interbreedwrite.string);
ADDRGP4 bot_interbreedwrite+16
ARGP4
ADDRGP4 BotWriteInterbreeded
CALLV
pop
line 668
;668:			trap_Cvar_Set("bot_interbreedwrite", "");
ADDRGP4 $341
ARGP4
ADDRGP4 $342
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 669
;669:		}
LABELV $337
line 670
;670:		BotInterbreedBots();
ADDRGP4 BotInterbreedBots
CALLV
pop
line 671
;671:	}
LABELV $334
line 672
;672:}
LABELV $331
endproc BotInterbreedEndMatch 8 8
export BotInterbreeding
proc BotInterbreeding 16 20
line 679
;673:
;674:/*
;675:==============
;676:BotInterbreeding
;677:==============
;678:*/
;679:void BotInterbreeding(void) {
line 682
;680:	int i;
;681:
;682:	trap_Cvar_Update(&bot_interbreedchar);
ADDRGP4 bot_interbreedchar
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 683
;683:	if (!strlen(bot_interbreedchar.string)) return;
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $344
ADDRGP4 $343
JUMPV
LABELV $344
line 685
;684:	//make sure we are in tournament mode
;685:	if (gametype != GT_TOURNAMENT) {
ADDRGP4 gametype
INDIRI4
CNSTI4 1
EQI4 $347
line 686
;686:		trap_Cvar_Set("g_gametype", va("%d", GT_TOURNAMENT));
ADDRGP4 $350
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $349
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 687
;687:		ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 688
;688:		return;
ADDRGP4 $343
JUMPV
LABELV $347
line 691
;689:	}
;690:	//shutdown all the bots
;691:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $351
line 692
;692:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $355
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $355
line 693
;693:			BotAIShutdownClient(botstates[i]->client, qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 694
;694:		}
LABELV $355
line 695
;695:	}
LABELV $352
line 691
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $351
line 697
;696:	//make sure all item weight configs are reloaded and Not shared
;697:	trap_BotLibVarSet("bot_reloadcharacters", "1");
ADDRGP4 $357
ARGP4
ADDRGP4 $358
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 699
;698:	//add a number of bots using the desired bot character
;699:	for (i = 0; i < bot_interbreedbots.integer; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $362
JUMPV
LABELV $359
line 700
;700:		trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s 4 free %i %s%d\n",
ADDRGP4 $364
ARGP4
ADDRGP4 bot_interbreedchar+16
ARGP4
CNSTI4 50
ADDRLP4 0
INDIRI4
MULI4
ARGI4
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 702
;701:						bot_interbreedchar.string, i * 50, bot_interbreedchar.string, i) );
;702:	}
LABELV $360
line 699
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $362
ADDRLP4 0
INDIRI4
ADDRGP4 bot_interbreedbots+12
INDIRI4
LTI4 $359
line 704
;703:	//
;704:	trap_Cvar_Set("bot_interbreedchar", "");
ADDRGP4 $367
ARGP4
ADDRGP4 $342
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 705
;705:	bot_interbreed = qtrue;
ADDRGP4 bot_interbreed
CNSTI4 1
ASGNI4
line 706
;706:}
LABELV $343
endproc BotInterbreeding 16 20
export BotEntityInfo
proc BotEntityInfo 0 8
line 713
;707:
;708:/*
;709:==============
;710:BotEntityInfo
;711:==============
;712:*/
;713:void BotEntityInfo(int entnum, aas_entityinfo_t *info) {
line 714
;714:	trap_AAS_EntityInfo(entnum, info);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_AAS_EntityInfo
CALLV
pop
line 715
;715:}
LABELV $368
endproc BotEntityInfo 0 8
export NumBots
proc NumBots 0 0
line 722
;716:
;717:/*
;718:==============
;719:NumBots
;720:==============
;721:*/
;722:int NumBots(void) {
line 723
;723:	return numbots;
ADDRGP4 numbots
INDIRI4
RETI4
LABELV $369
endproc NumBots 0 0
export BotTeamLeader
proc BotTeamLeader 12 4
line 731
;724:}
;725:
;726:/*
;727:==============
;728:BotTeamLeader
;729:==============
;730:*/
;731:int BotTeamLeader(bot_state_t *bs) {
line 734
;732:	int leader;
;733:
;734:	leader = ClientFromName(bs->teamleader);
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 735
;735:	if (leader < 0) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $371
CNSTI4 0
RETI4
ADDRGP4 $370
JUMPV
LABELV $371
line 736
;736:	if (!botstates[leader] || !botstates[leader]->inuse) return qfalse;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $375
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $373
LABELV $375
CNSTI4 0
RETI4
ADDRGP4 $370
JUMPV
LABELV $373
line 737
;737:	return qtrue;
CNSTI4 1
RETI4
LABELV $370
endproc BotTeamLeader 12 4
export AngleDifference
proc AngleDifference 4 0
line 745
;738:}
;739:
;740:/*
;741:==============
;742:AngleDifference
;743:==============
;744:*/
;745:float AngleDifference(float ang1, float ang2) {
line 748
;746:	float diff;
;747:
;748:	diff = ang1 - ang2;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
SUBF4
ASGNF4
line 749
;749:	if (ang1 > ang2) {
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $377
line 750
;750:		if (diff > 180.0) diff -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $378
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 751
;751:	}
ADDRGP4 $378
JUMPV
LABELV $377
line 752
;752:	else {
line 753
;753:		if (diff < -180.0) diff += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $381
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $381
line 754
;754:	}
LABELV $378
line 755
;755:	return diff;
ADDRLP4 0
INDIRF4
RETF4
LABELV $376
endproc AngleDifference 4 0
export BotChangeViewAngle
proc BotChangeViewAngle 16 4
line 763
;756:}
;757:
;758:/*
;759:==============
;760:BotChangeViewAngle
;761:==============
;762:*/
;763:float BotChangeViewAngle(float angle, float ideal_angle, float speed) {
line 766
;764:	float move;
;765:
;766:	angle = AngleMod(angle);
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 767
;767:	ideal_angle = AngleMod(ideal_angle);
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 768
;768:	if (angle == ideal_angle) return angle;
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
NEF4 $384
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $383
JUMPV
LABELV $384
line 769
;769:	move = ideal_angle - angle;
ADDRLP4 0
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
SUBF4
ASGNF4
line 770
;770:	if (ideal_angle > angle) {
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
LEF4 $386
line 771
;771:		if (move > 180.0) move -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $387
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 772
;772:	}
ADDRGP4 $387
JUMPV
LABELV $386
line 773
;773:	else {
line 774
;774:		if (move < -180.0) move += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $390
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $390
line 775
;775:	}
LABELV $387
line 776
;776:	if (move > 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $392
line 777
;777:		if (move > speed) move = speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $393
ADDRLP4 0
ADDRFP4 8
INDIRF4
ASGNF4
line 778
;778:	}
ADDRGP4 $393
JUMPV
LABELV $392
line 779
;779:	else {
line 780
;780:		if (move < -speed) move = -speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $396
ADDRLP4 0
ADDRFP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $396
line 781
;781:	}
LABELV $393
line 782
;782:	return AngleMod(angle + move);
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
RETF4
LABELV $383
endproc BotChangeViewAngle 16 4
export BotChangeViewAngles
proc BotChangeViewAngles 80 16
line 790
;783:}
;784:
;785:/*
;786:==============
;787:BotChangeViewAngles
;788:==============
;789:*/
;790:void BotChangeViewAngles(bot_state_t *bs, float thinktime) {
line 794
;791:	float diff, factor, maxchange, anglespeed, disired_speed;
;792:	int i;
;793:
;794:	if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $399
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $399
line 796
;795:	//
;796:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 0
LTI4 $401
line 797
;797:		factor = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_FACTOR, 0.01f, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTF4 1008981770
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 28
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 28
INDIRF4
ASGNF4
line 798
;798:		maxchange = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_MAXCHANGE, 1, 1800);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
CNSTF4 1065353216
ARGF4
CNSTF4 1155596288
ARGF4
ADDRLP4 32
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 799
;799:	}
ADDRGP4 $402
JUMPV
LABELV $401
line 800
;800:	else {
line 801
;801:		factor = 0.05f;
ADDRLP4 16
CNSTF4 1028443341
ASGNF4
line 802
;802:		maxchange = 360;
ADDRLP4 8
CNSTF4 1135869952
ASGNF4
line 803
;803:	}
LABELV $402
line 804
;804:	if (maxchange < 240) maxchange = 240;
ADDRLP4 8
INDIRF4
CNSTF4 1131413504
GEF4 $403
ADDRLP4 8
CNSTF4 1131413504
ASGNF4
LABELV $403
line 805
;805:	maxchange *= thinktime;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 806
;806:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $405
line 808
;807:		//
;808:		if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $409
line 810
;809:			//smooth slowdown view model
;810:			diff = fabs(AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]));
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 6420
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 6432
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
line 811
;811:			anglespeed = diff * factor;
ADDRLP4 4
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 812
;812:			if (anglespeed > maxchange) anglespeed = maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $412
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $412
line 813
;813:			bs->viewangles[i] = BotChangeViewAngle(bs->viewangles[i],
ADDRLP4 44
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 6420
ADDP4
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 6432
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 BotChangeViewAngle
CALLF4
ASGNF4
ADDRLP4 52
INDIRP4
ADDRLP4 56
INDIRF4
ASGNF4
line 815
;814:											bs->ideal_viewangles[i], anglespeed);
;815:		}
ADDRGP4 $410
JUMPV
LABELV $409
line 816
;816:		else {
line 818
;817:			//over reaction view model
;818:			bs->viewangles[i] = AngleMod(bs->viewangles[i]);
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRF4
ASGNF4
line 819
;819:			bs->ideal_viewangles[i] = AngleMod(bs->ideal_viewangles[i]);
ADDRLP4 36
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRF4
ASGNF4
line 820
;820:			diff = AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]);
ADDRLP4 44
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 6420
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 6432
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 52
INDIRF4
ASGNF4
line 821
;821:			disired_speed = diff * factor;
ADDRLP4 20
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 822
;822:			bs->viewanglespeed[i] += (bs->viewanglespeed[i] - disired_speed);
ADDRLP4 56
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6444
ADDP4
ADDP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 56
INDIRP4
ADDRLP4 60
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
ADDF4
ASGNF4
line 823
;823:			if (bs->viewanglespeed[i] > 180) bs->viewanglespeed[i] = maxchange;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6444
ADDP4
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $414
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6444
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $414
line 824
;824:			if (bs->viewanglespeed[i] < -180) bs->viewanglespeed[i] = -maxchange;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6444
ADDP4
ADDP4
INDIRF4
CNSTF4 3274964992
GEF4 $416
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6444
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $416
line 825
;825:			anglespeed = bs->viewanglespeed[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6444
ADDP4
ADDP4
INDIRF4
ASGNF4
line 826
;826:			if (anglespeed > maxchange) anglespeed = maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $418
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $418
line 827
;827:			if (anglespeed < -maxchange) anglespeed = -maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
NEGF4
GEF4 $420
ADDRLP4 4
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $420
line 828
;828:			bs->viewangles[i] += anglespeed;
ADDRLP4 64
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 829
;829:			bs->viewangles[i] = AngleMod(bs->viewangles[i]);
ADDRLP4 68
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 68
INDIRP4
ADDRLP4 72
INDIRF4
ASGNF4
line 831
;830:			//demping
;831:			bs->viewanglespeed[i] *= 0.45 * (1 - factor);
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6444
ADDP4
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
CNSTF4 1055286886
CNSTF4 1065353216
ADDRLP4 16
INDIRF4
SUBF4
MULF4
MULF4
ASGNF4
line 832
;832:		}
LABELV $410
line 835
;833:		//BotAI_Print(PRT_MESSAGE, "ideal_angles %f %f\n", bs->ideal_viewangles[0], bs->ideal_viewangles[1], bs->ideal_viewangles[2]);`
;834:		//bs->viewangles[i] = bs->ideal_viewangles[i];
;835:	}
LABELV $406
line 806
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $405
line 837
;836:	//bs->viewangles[PITCH] = 0;
;837:	if (bs->viewangles[PITCH] > 180) bs->viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $422
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $422
line 839
;838:	//elementary action: view
;839:	trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 840
;840:}
LABELV $398
endproc BotChangeViewAngles 80 16
export BotInputToUserCommand
proc BotInputToUserCommand 140 16
line 847
;841:
;842:/*
;843:==============
;844:BotInputToUserCommand
;845:==============
;846:*/
;847:void BotInputToUserCommand(bot_input_t *bi, usercmd_t *ucmd, int delta_angles[3], int time) {
line 854
;848:	vec3_t angles, forward, right;
;849:	short temp;
;850:	int j;
;851:	float f, r, u, m;
;852:
;853:	//clear the whole structure
;854:	memset(ucmd, 0, sizeof(usercmd_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 memset
CALLP4
pop
line 856
;855:	//the duration for the user command in milli seconds
;856:	ucmd->serverTime = time;
ADDRFP4 4
INDIRP4
ADDRFP4 12
INDIRI4
ASGNI4
line 858
;857:	//
;858:	if (bi->actionflags & ACTION_DELAYEDJUMP) {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $425
line 859
;859:		bi->actionflags |= ACTION_JUMP;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 860
;860:		bi->actionflags &= ~ACTION_DELAYEDJUMP;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 861
;861:	}
LABELV $425
line 863
;862:	//set the buttons
;863:	if (bi->actionflags & ACTION_RESPAWN) ucmd->buttons = BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $427
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 1
ASGNI4
LABELV $427
line 864
;864:	if (bi->actionflags & ACTION_ATTACK) ucmd->buttons |= BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $429
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
LABELV $429
line 865
;865:	if (bi->actionflags & ACTION_TALK) ucmd->buttons |= BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $431
ADDRLP4 64
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $431
line 866
;866:	if (bi->actionflags & ACTION_GESTURE) ucmd->buttons |= BUTTON_GESTURE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $433
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
LABELV $433
line 867
;867:	if (bi->actionflags & ACTION_USE) ucmd->buttons |= BUTTON_USE_HOLDABLE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $435
ADDRLP4 72
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
LABELV $435
line 868
;868:	if (bi->actionflags & ACTION_WALK) ucmd->buttons |= BUTTON_WALKING;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $437
ADDRLP4 76
CNSTI4 16
ASGNI4
ADDRLP4 80
ADDRFP4 4
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
ADDRLP4 76
INDIRI4
BORI4
ASGNI4
LABELV $437
line 869
;869:	if (bi->actionflags & ACTION_AFFIRMATIVE) ucmd->buttons |= BUTTON_AFFIRMATIVE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1048576
BANDI4
CNSTI4 0
EQI4 $439
ADDRLP4 84
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
LABELV $439
line 870
;870:	if (bi->actionflags & ACTION_NEGATIVE) ucmd->buttons |= BUTTON_NEGATIVE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $441
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
LABELV $441
line 871
;871:	if (bi->actionflags & ACTION_GETFLAG) ucmd->buttons |= BUTTON_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $443
ADDRLP4 92
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
LABELV $443
line 872
;872:	if (bi->actionflags & ACTION_GUARDBASE) ucmd->buttons |= BUTTON_GUARDBASE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
CNSTI4 0
EQI4 $445
ADDRLP4 96
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
LABELV $445
line 873
;873:	if (bi->actionflags & ACTION_PATROL) ucmd->buttons |= BUTTON_PATROL;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 33554432
BANDI4
CNSTI4 0
EQI4 $447
ADDRLP4 100
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $447
line 874
;874:	if (bi->actionflags & ACTION_FOLLOWME) ucmd->buttons |= BUTTON_FOLLOWME;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 134217728
BANDI4
CNSTI4 0
EQI4 $449
ADDRLP4 104
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
LABELV $449
line 876
;875:	//
;876:	ucmd->weapon = bi->weapon;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 879
;877:	//set the view angles
;878:	//NOTE: the ucmd->angles are the angles WITHOUT the delta angles
;879:	ucmd->angles[PITCH] = ANGLE2SHORT(bi->viewangles[PITCH]);
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1199570944
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 880
;880:	ucmd->angles[YAW] = ANGLE2SHORT(bi->viewangles[YAW]);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1199570944
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 881
;881:	ucmd->angles[ROLL] = ANGLE2SHORT(bi->viewangles[ROLL]);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1199570944
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 883
;882:	//subtract the delta angles
;883:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $451
line 884
;884:		temp = ucmd->angles[j] - delta_angles[j];
ADDRLP4 108
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
ADDRLP4 108
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRI4
SUBI4
CVII2 4
ASGNI2
line 892
;885:		/*NOTE: disabled because temp should be mod first
;886:		if ( j == PITCH ) {
;887:			// don't let the player look up or down more than 90 degrees
;888:			if ( temp > 16000 ) temp = 16000;
;889:			else if ( temp < -16000 ) temp = -16000;
;890:		}
;891:		*/
;892:		ucmd->angles[j] = temp;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ADDRLP4 4
INDIRI2
CVII4 2
ASGNI4
line 893
;893:	}
LABELV $452
line 883
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $451
line 897
;894:	//NOTE: movement is relative to the REAL view angles
;895:	//get the horizontal forward and right vector
;896:	//get the pitch in the range [-180, 180]
;897:	if (bi->dir[2]) angles[PITCH] = bi->viewangles[PITCH];
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 0
EQF4 $455
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $456
JUMPV
LABELV $455
line 898
;898:	else angles[PITCH] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
LABELV $456
line 899
;899:	angles[YAW] = bi->viewangles[YAW];
ADDRLP4 24+4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 900
;900:	angles[ROLL] = 0;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 901
;901:	AngleVectors(angles, forward, right, NULL);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 903
;902:	//bot input speed is in the range [0, 400]
;903:	bi->speed = bi->speed * 127 / 400;
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTF4 1123942400
ADDRLP4 108
INDIRP4
INDIRF4
MULF4
CNSTF4 1137180672
DIVF4
ASGNF4
line 905
;904:	//set the view independent movement
;905:	f = DotProduct(forward, bi->dir);
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 12
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 906
;906:	r = DotProduct(right, bi->dir);
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 36
INDIRF4
ADDRLP4 116
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 36+4
INDIRF4
ADDRLP4 116
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 36+8
INDIRF4
ADDRLP4 116
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 907
;907:	u = fabs(forward[2]) * bi->dir[2];
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 120
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 120
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ASGNF4
line 908
;908:	m = fabs(f);
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 124
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 124
INDIRF4
ASGNF4
line 910
;909:
;910:	if (fabs(r) > m) {
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 128
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $464
line 911
;911:		m = fabs(r);
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 132
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 132
INDIRF4
ASGNF4
line 912
;912:	}
LABELV $464
line 914
;913:
;914:	if (fabs(u) > m) {
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 132
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 132
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $466
line 915
;915:		m = fabs(u);
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 136
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 136
INDIRF4
ASGNF4
line 916
;916:	}
LABELV $466
line 918
;917:
;918:	if (m > 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $468
line 919
;919:		f *= bi->speed / m;
ADDRLP4 56
ADDRLP4 56
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
MULF4
ASGNF4
line 920
;920:		r *= bi->speed / m;
ADDRLP4 48
ADDRLP4 48
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
MULF4
ASGNF4
line 921
;921:		u *= bi->speed / m;
ADDRLP4 52
ADDRLP4 52
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
MULF4
ASGNF4
line 922
;922:	}
LABELV $468
line 924
;923:
;924:	ucmd->forwardmove = f;
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
ADDRLP4 56
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 925
;925:	ucmd->rightmove = r;
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
ADDRLP4 48
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 926
;926:	ucmd->upmove = u;
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
ADDRLP4 52
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 928
;927:
;928:	if (bi->actionflags & ACTION_MOVEFORWARD) ucmd->forwardmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $470
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
CNSTI1 127
ASGNI1
LABELV $470
line 929
;929:	if (bi->actionflags & ACTION_MOVEBACK) ucmd->forwardmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $472
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
CNSTI1 -127
ASGNI1
LABELV $472
line 930
;930:	if (bi->actionflags & ACTION_MOVELEFT) ucmd->rightmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $474
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
CNSTI1 -127
ASGNI1
LABELV $474
line 931
;931:	if (bi->actionflags & ACTION_MOVERIGHT) ucmd->rightmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $476
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
CNSTI1 127
ASGNI1
LABELV $476
line 933
;932:	//jump/moveup
;933:	if (bi->actionflags & ACTION_JUMP) ucmd->upmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $478
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
CNSTI1 127
ASGNI1
LABELV $478
line 935
;934:	//crouch/movedown
;935:	if (bi->actionflags & ACTION_CROUCH) ucmd->upmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $480
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
CNSTI1 -127
ASGNI1
LABELV $480
line 936
;936:}
LABELV $424
endproc BotInputToUserCommand 140 16
export BotUpdateInput
proc BotUpdateInput 64 16
line 943
;937:
;938:/*
;939:==============
;940:BotUpdateInput
;941:==============
;942:*/
;943:void BotUpdateInput(bot_state_t *bs, int time, int elapsed_time) {
line 948
;944:	bot_input_t bi;
;945:	int j;
;946:
;947:	//add the delta angles to the bot's current view angles
;948:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $483
line 949
;949:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 44
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 6420
ADDP4
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ARGF4
ADDRLP4 56
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 52
INDIRP4
ADDRLP4 56
INDIRF4
ASGNF4
line 950
;950:	}
LABELV $484
line 948
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $483
line 952
;951:	//change the bot view angles
;952:	BotChangeViewAngles(bs, (float) elapsed_time / 1000);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRGP4 BotChangeViewAngles
CALLV
pop
line 954
;953:	//retrieve the bot input
;954:	trap_EA_GetInput(bs->client, (float) time / 1000, &bi);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 trap_EA_GetInput
CALLV
pop
line 956
;955:	//respawn hack
;956:	if (bi.actionflags & ACTION_RESPAWN) {
ADDRLP4 4+32
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $487
line 957
;957:		if (bs->lastucmd.buttons & BUTTON_ATTACK) bi.actionflags &= ~(ACTION_RESPAWN|ACTION_ATTACK);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $490
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 -10
BANDI4
ASGNI4
LABELV $490
line 958
;958:	}
LABELV $487
line 960
;959:	//convert the bot input to a usercmd
;960:	BotInputToUserCommand(&bi, &bs->lastucmd, bs->cur_ps.delta_angles, time);
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotInputToUserCommand
CALLV
pop
line 962
;961:	//subtract the delta angles
;962:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $493
line 963
;963:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 48
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 6420
ADDP4
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
SUBF4
ARGF4
ADDRLP4 60
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 56
INDIRP4
ADDRLP4 60
INDIRF4
ASGNF4
line 964
;964:	}
LABELV $494
line 962
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $493
line 965
;965:}
LABELV $482
endproc BotUpdateInput 64 16
export BotAIRegularUpdate
proc BotAIRegularUpdate 0 0
line 972
;966:
;967:/*
;968:==============
;969:BotAIRegularUpdate
;970:==============
;971:*/
;972:void BotAIRegularUpdate(void) {
line 973
;973:	if (regularupdate_time < FloatTime()) {
ADDRGP4 regularupdate_time
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $498
line 974
;974:		trap_BotUpdateEntityItems();
ADDRGP4 trap_BotUpdateEntityItems
CALLV
pop
line 975
;975:		regularupdate_time = FloatTime() + 0.3;
ADDRGP4 regularupdate_time
ADDRGP4 floattime
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 976
;976:	}
LABELV $498
line 977
;977:}
LABELV $497
endproc BotAIRegularUpdate 0 0
export RemoveColorEscapeSequences
proc RemoveColorEscapeSequences 24 0
line 984
;978:
;979:/*
;980:==============
;981:RemoveColorEscapeSequences
;982:==============
;983:*/
;984:void RemoveColorEscapeSequences( char *text ) {
line 987
;985:	int i, l;
;986:
;987:	l = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 988
;988:	for ( i = 0; text[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $504
JUMPV
LABELV $501
line 989
;989:		if (Q_IsColorString(&text[i])) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $505
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $505
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $505
ADDRLP4 12
INDIRI4
CNSTI4 48
LTI4 $505
ADDRLP4 12
INDIRI4
CNSTI4 56
GTI4 $505
line 990
;990:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 991
;991:			continue;
ADDRGP4 $502
JUMPV
LABELV $505
line 993
;992:		}
;993:		if (text[i] > 0x7E)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 126
LEI4 $507
line 994
;994:			continue;
ADDRGP4 $502
JUMPV
LABELV $507
line 995
;995:		text[l++] = text[i];
ADDRLP4 16
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 996
;996:	}
LABELV $502
line 988
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $504
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $501
line 997
;997:	text[l] = '\0';
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 998
;998:}
LABELV $500
endproc RemoveColorEscapeSequences 24 0
export BotAI
proc BotAI 1096 12
line 1005
;999:
;1000:/*
;1001:==============
;1002:BotAI
;1003:==============
;1004:*/
;1005:int BotAI(int client, float thinktime) {
line 1010
;1006:	bot_state_t *bs;
;1007:	char buf[1024], *args;
;1008:	int j;
;1009:
;1010:	trap_EA_ResetInput(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_EA_ResetInput
CALLV
pop
line 1012
;1011:	//
;1012:	bs = botstates[client];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1013
;1013:	if (!bs || !bs->inuse) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $512
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $510
LABELV $512
line 1014
;1014:		BotAI_Print(PRT_FATAL, "BotAI: client %d is not setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $513
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 1015
;1015:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $510
line 1019
;1016:	}
;1017:
;1018:	//retrieve the current client state
;1019:	if (!BotAI_GetClientState(client, &bs->cur_ps)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 1040
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $518
line 1020
;1020:		BotAI_Print(PRT_FATAL, "BotAI: failed to get player state for player %d\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $516
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 1021
;1021:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $517
line 1025
;1022:	}
;1023:
;1024:	//retrieve any waiting server commands
;1025:	while( trap_BotGetServerCommand(client, buf, sizeof(buf)) ) {
line 1027
;1026:		//have buf point to the command and args to the command arguments
;1027:		args = strchr( buf, ' ');
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 1044
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1044
INDIRP4
ASGNP4
line 1028
;1028:		if (!args) continue;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $520
ADDRGP4 $518
JUMPV
LABELV $520
line 1029
;1029:		*args++ = '\0';
ADDRLP4 1048
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 1048
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI1 0
ASGNI1
line 1032
;1030:
;1031:		//remove color espace sequences from the arguments
;1032:		RemoveColorEscapeSequences( args );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RemoveColorEscapeSequences
CALLV
pop
line 1034
;1033:
;1034:		if (Q_strequal(buf, "cp "))
ADDRLP4 12
ARGP4
ADDRGP4 $524
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $522
line 1035
;1035:			{ /*CenterPrintf*/ }
ADDRGP4 $523
JUMPV
LABELV $522
line 1036
;1036:		else if (Q_strequal(buf, "cs"))
ADDRLP4 12
ARGP4
ADDRGP4 $527
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $525
line 1037
;1037:			{ /*ConfigStringModified*/ }
ADDRGP4 $526
JUMPV
LABELV $525
line 1038
;1038:		else if (Q_strequal(buf, "print")) {
ADDRLP4 12
ARGP4
ADDRGP4 $530
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $528
line 1040
;1039:			//remove first and last quote from the chat message
;1040:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1064
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1041
;1041:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1042
;1042:			trap_BotQueueConsoleMessage(bs->cs, CMS_NORMAL, args);
ADDRLP4 4
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1043
;1043:		}
ADDRGP4 $529
JUMPV
LABELV $528
line 1044
;1044:		else if (Q_strequal(buf, "chat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $533
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $531
line 1046
;1045:			//remove first and last quote from the chat message
;1046:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1047
;1047:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1048
;1048:			trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, args);
ADDRLP4 4
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1049
;1049:		}
ADDRGP4 $532
JUMPV
LABELV $531
line 1050
;1050:		else if (Q_strequal(buf, "tchat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $536
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $534
line 1052
;1051:			//remove first and last quote from the chat message
;1052:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1053
;1053:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1080
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1054
;1054:			trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, args);
ADDRLP4 4
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1055
;1055:		}
ADDRGP4 $535
JUMPV
LABELV $534
line 1067
;1056:#ifdef MISSIONPACK
;1057:		else if (Q_strequal(buf, "vchat")) {
;1058:			BotVoiceChatCommand(bs, SAY_ALL, args);
;1059:		}
;1060:		else if (Q_strequal(buf, "vtchat")) {
;1061:			BotVoiceChatCommand(bs, SAY_TEAM, args);
;1062:		}
;1063:		else if (Q_strequal(buf, "vtell")) {
;1064:			BotVoiceChatCommand(bs, SAY_TELL, args);
;1065:		}
;1066:#endif
;1067:		else if (Q_strequal(buf, "scores"))
ADDRLP4 12
ARGP4
ADDRGP4 $539
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $537
line 1068
;1068:			{ /*FIXME: parse scores?*/ }
ADDRGP4 $538
JUMPV
LABELV $537
line 1069
;1069:		else if (Q_strequal(buf, "clientLevelShot"))
ADDRLP4 12
ARGP4
ADDRGP4 $542
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $540
line 1070
;1070:			{ /*ignore*/ }
LABELV $540
LABELV $538
LABELV $535
LABELV $532
LABELV $529
LABELV $526
LABELV $523
line 1071
;1071:	}
LABELV $518
line 1025
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1044
ADDRGP4 trap_BotGetServerCommand
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $517
line 1073
;1072:	//add the delta angles to the bot's current view angles
;1073:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $543
line 1074
;1074:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 1048
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1056
ADDRLP4 1048
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 6420
ADDP4
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 1048
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ARGF4
ADDRLP4 1060
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1056
INDIRP4
ADDRLP4 1060
INDIRF4
ASGNF4
line 1075
;1075:	}
LABELV $544
line 1073
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $543
line 1077
;1076:	//increase the local time of the bot
;1077:	bs->ltime += thinktime;
ADDRLP4 1048
ADDRLP4 4
INDIRP4
CNSTI4 5916
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDF4
ASGNF4
line 1079
;1078:	//
;1079:	bs->thinktime = thinktime;
ADDRLP4 4
INDIRP4
CNSTI4 4760
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 1081
;1080:	//origin of the bot
;1081:	VectorCopy(bs->cur_ps.origin, bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 4764
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1083
;1082:	//eye coordinates of the bot
;1083:	VectorCopy(bs->cur_ps.origin, bs->eye);
ADDRLP4 4
INDIRP4
CNSTI4 4792
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1084
;1084:	bs->eye[2] += bs->cur_ps.viewheight;
ADDRLP4 1064
ADDRLP4 4
INDIRP4
CNSTI4 4800
ADDP4
ASGNP4
ADDRLP4 1064
INDIRP4
ADDRLP4 1064
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1086
;1085:	//get the area the bot is in
;1086:	bs->areanum = BotPointAreaNum(bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 1072
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4804
ADDP4
ADDRLP4 1072
INDIRI4
ASGNI4
line 1088
;1087:	//the real AI
;1088:	BotDeathmatchAI(bs, thinktime);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 BotDeathmatchAI
CALLV
pop
line 1090
;1089:	//set the weapon selection every AI frame
;1090:	trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 6416
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1092
;1091:	//subtract the delta angles
;1092:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $547
line 1093
;1093:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 1080
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1088
ADDRLP4 1080
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 6420
ADDP4
ADDP4
ASGNP4
ADDRLP4 1088
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 1080
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
SUBF4
ARGF4
ADDRLP4 1092
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1088
INDIRP4
ADDRLP4 1092
INDIRF4
ASGNF4
line 1094
;1094:	}
LABELV $548
line 1092
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $547
line 1096
;1095:	//everything was ok
;1096:	return qtrue;
CNSTI4 1
RETI4
LABELV $509
endproc BotAI 1096 12
export BotScheduleBotThink
proc BotScheduleBotThink 12 0
line 1104
;1097:}
;1098:
;1099:/*
;1100:==================
;1101:BotScheduleBotThink
;1102:==================
;1103:*/
;1104:void BotScheduleBotThink(void) {
line 1107
;1105:	int i, botnum;
;1106:
;1107:	botnum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1109
;1108:
;1109:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $552
line 1110
;1110:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $558
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $556
LABELV $558
line 1111
;1111:			continue;
ADDRGP4 $553
JUMPV
LABELV $556
line 1114
;1112:		}
;1113:		//initialize the bot think residual time
;1114:		botstates[i]->botthink_residual = bot_thinktime.integer * botnum / numbots;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 bot_thinktime+12
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 numbots
INDIRI4
DIVI4
ASGNI4
line 1115
;1115:		botnum++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1116
;1116:	}
LABELV $553
line 1109
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $552
line 1117
;1117:}
LABELV $551
endproc BotScheduleBotThink 12 0
export BotWriteSessionData
proc BotWriteSessionData 20 76
line 1124
;1118:
;1119:/*
;1120:==============
;1121:BotWriteSessionData
;1122:==============
;1123:*/
;1124:void BotWriteSessionData(bot_state_t *bs) {
line 1128
;1125:	const char	*s;
;1126:	const char	*var;
;1127:
;1128:	s = va(
ADDRGP4 $561
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6636
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6672
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6676
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6628
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6632
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6640
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6644
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6648
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6652
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6656
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6660
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6872
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1154
;1129:			"%i %i %i %i %i %i %i %i"
;1130:			" %f %f %f"
;1131:			" %f %f %f"
;1132:			" %f %f %f"
;1133:			" %f",
;1134:		bs->lastgoal_decisionmaker,
;1135:		bs->lastgoal_ltgtype,
;1136:		bs->lastgoal_teammate,
;1137:		bs->lastgoal_teamgoal.areanum,
;1138:		bs->lastgoal_teamgoal.entitynum,
;1139:		bs->lastgoal_teamgoal.flags,
;1140:		bs->lastgoal_teamgoal.iteminfo,
;1141:		bs->lastgoal_teamgoal.number,
;1142:		bs->lastgoal_teamgoal.origin[0],
;1143:		bs->lastgoal_teamgoal.origin[1],
;1144:		bs->lastgoal_teamgoal.origin[2],
;1145:		bs->lastgoal_teamgoal.mins[0],
;1146:		bs->lastgoal_teamgoal.mins[1],
;1147:		bs->lastgoal_teamgoal.mins[2],
;1148:		bs->lastgoal_teamgoal.maxs[0],
;1149:		bs->lastgoal_teamgoal.maxs[1],
;1150:		bs->lastgoal_teamgoal.maxs[2],
;1151:		bs->formation_dist
;1152:		);
;1153:
;1154:	var = va( "botsession%i", bs->client );
ADDRGP4 $562
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1156
;1155:
;1156:	trap_Cvar_Set( var, s );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1157
;1157:}
LABELV $560
endproc BotWriteSessionData 20 76
export BotReadSessionData
proc BotReadSessionData 1036 80
line 1164
;1158:
;1159:/*
;1160:==============
;1161:BotReadSessionData
;1162:==============
;1163:*/
;1164:void BotReadSessionData(bot_state_t *bs) {
line 1168
;1165:	char	s[MAX_STRING_CHARS];
;1166:	const char	*var;
;1167:
;1168:	var = va( "botsession%i", bs->client );
ADDRGP4 $562
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1028
INDIRP4
ASGNP4
line 1169
;1169:	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1171
;1170:
;1171:	sscanf(s,
ADDRLP4 0
ARGP4
ADDRGP4 $561
ARGP4
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 6612
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6616
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6620
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6636
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6664
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6672
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6676
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6668
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6628
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6632
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6640
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6644
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6648
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6652
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6656
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6660
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6872
ADDP4
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 1196
;1172:			"%i %i %i %i %i %i %i %i"
;1173:			" %f %f %f"
;1174:			" %f %f %f"
;1175:			" %f %f %f"
;1176:			" %f",
;1177:		&bs->lastgoal_decisionmaker,
;1178:		&bs->lastgoal_ltgtype,
;1179:		&bs->lastgoal_teammate,
;1180:		&bs->lastgoal_teamgoal.areanum,
;1181:		&bs->lastgoal_teamgoal.entitynum,
;1182:		&bs->lastgoal_teamgoal.flags,
;1183:		&bs->lastgoal_teamgoal.iteminfo,
;1184:		&bs->lastgoal_teamgoal.number,
;1185:		&bs->lastgoal_teamgoal.origin[0],
;1186:		&bs->lastgoal_teamgoal.origin[1],
;1187:		&bs->lastgoal_teamgoal.origin[2],
;1188:		&bs->lastgoal_teamgoal.mins[0],
;1189:		&bs->lastgoal_teamgoal.mins[1],
;1190:		&bs->lastgoal_teamgoal.mins[2],
;1191:		&bs->lastgoal_teamgoal.maxs[0],
;1192:		&bs->lastgoal_teamgoal.maxs[1],
;1193:		&bs->lastgoal_teamgoal.maxs[2],
;1194:		&bs->formation_dist
;1195:		);
;1196:}
LABELV $563
endproc BotReadSessionData 1036 80
export BotAISetupClient
proc BotAISetupClient 504 16
line 1203
;1197:
;1198:/*
;1199:==============
;1200:BotAISetupClient
;1201:==============
;1202:*/
;1203:int BotAISetupClient(int client, struct bot_settings_s *settings, qboolean restart) {
line 1208
;1204:	char filename[MAX_PATH], name[MAX_PATH], gender[MAX_PATH];
;1205:	bot_state_t *bs;
;1206:	int errnum;
;1207:	//KK-OAX Changed to Tremulous's BG_Alloc
;1208:	if (!botstates[client]) {
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $565
line 1209
;1209:		if(!BG_CanAlloc(sizeof(bot_state_t))) {
CNSTU4 8948
ARGU4
ADDRLP4 440
ADDRGP4 BG_CanAlloc
CALLI4
ASGNI4
ADDRLP4 440
INDIRI4
CNSTI4 0
NEI4 $567
line 1211
;1210:			//We cannot run BG_Alloc, fail nicely
;1211:			BotAI_Print(PRT_FATAL, "BotAISetupClient: Not enough heap memory\n");
CNSTI4 4
ARGI4
ADDRGP4 $569
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1212
;1212:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $564
JUMPV
LABELV $567
line 1214
;1213:		}
;1214:		botstates[client] = BG_Alloc(sizeof(bot_state_t));
CNSTU4 8948
ARGU4
ADDRLP4 444
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
ADDRLP4 444
INDIRP4
ASGNP4
line 1216
;1215:		//BG_Allow will succed or terminate
;1216:	}
LABELV $565
line 1217
;1217:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1219
;1218:
;1219:	if (bs->inuse) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $570
line 1220
;1220:		BotAI_Print(PRT_FATAL, "BotAISetupClient: client %d already setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $572
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 1221
;1221:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $564
JUMPV
LABELV $570
line 1224
;1222:	}
;1223:
;1224:	if (!trap_AAS_Initialized()) {
ADDRLP4 440
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 440
INDIRI4
CNSTI4 0
NEI4 $573
line 1225
;1225:		BotAI_Print(PRT_FATAL, "AAS not initialized\n");
CNSTI4 4
ARGI4
ADDRGP4 $575
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1226
;1226:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $564
JUMPV
LABELV $573
line 1230
;1227:	}
;1228:
;1229:	//load the bot character
;1230:	bs->character = trap_BotLoadCharacter(settings->characterfile, settings->skill);
ADDRLP4 444
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 444
INDIRP4
ARGP4
ADDRLP4 444
INDIRP4
CNSTI4 144
ADDP4
INDIRF4
ARGF4
ADDRLP4 448
ADDRGP4 trap_BotLoadCharacter
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6376
ADDP4
ADDRLP4 448
INDIRI4
ASGNI4
line 1231
;1231:	if (!bs->character) {
ADDRLP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
CNSTI4 0
NEI4 $576
line 1232
;1232:		BotAI_Print(PRT_FATAL, "couldn't load skill %f from %s\n", settings->skill, settings->characterfile);
CNSTI4 4
ARGI4
ADDRGP4 $578
ARGP4
ADDRLP4 452
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 452
INDIRP4
CNSTI4 144
ADDP4
INDIRF4
ARGF4
ADDRLP4 452
INDIRP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1233
;1233:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $564
JUMPV
LABELV $576
line 1236
;1234:	}
;1235:	//copy the settings
;1236:	memcpy(&bs->settings, settings, sizeof(bot_settings_t));
ADDRLP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 148
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1238
;1237:	//allocate a goal state
;1238:	bs->gs = trap_BotAllocGoalState(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 452
ADDRGP4 trap_BotAllocGoalState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6384
ADDP4
ADDRLP4 452
INDIRI4
ASGNI4
line 1240
;1239:	//load the item weights
;1240:	trap_Characteristic_String(bs->character, CHARACTERISTIC_ITEMWEIGHTS, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1241
;1241:	errnum = trap_BotLoadItemWeights(bs->gs, filename);
ADDRLP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 456
ADDRGP4 trap_BotLoadItemWeights
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 456
INDIRI4
ASGNI4
line 1242
;1242:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $579
line 1243
;1243:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1244
;1244:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $564
JUMPV
LABELV $579
line 1247
;1245:	}
;1246:	//allocate a weapon state
;1247:	bs->ws = trap_BotAllocWeaponState();
ADDRLP4 460
ADDRGP4 trap_BotAllocWeaponState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6392
ADDP4
ADDRLP4 460
INDIRI4
ASGNI4
line 1249
;1248:	//load the weapon weights
;1249:	trap_Characteristic_String(bs->character, CHARACTERISTIC_WEAPONWEIGHTS, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1250
;1250:	errnum = trap_BotLoadWeaponWeights(bs->ws, filename);
ADDRLP4 0
INDIRP4
CNSTI4 6392
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 464
ADDRGP4 trap_BotLoadWeaponWeights
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 464
INDIRI4
ASGNI4
line 1251
;1251:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $581
line 1252
;1252:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1253
;1253:		trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6392
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1254
;1254:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $564
JUMPV
LABELV $581
line 1257
;1255:	}
;1256:	//allocate a chat state
;1257:	bs->cs = trap_BotAllocChatState();
ADDRLP4 468
ADDRGP4 trap_BotAllocChatState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6388
ADDP4
ADDRLP4 468
INDIRI4
ASGNI4
line 1259
;1258:	//load the chat file
;1259:	trap_Characteristic_String(bs->character, CHARACTERISTIC_CHAT_FILE, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 21
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1260
;1260:	trap_Characteristic_String(bs->character, CHARACTERISTIC_CHAT_NAME, name, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 22
ARGI4
ADDRLP4 296
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1261
;1261:	errnum = trap_BotLoadChatFile(bs->cs, filename, name);
ADDRLP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 296
ARGP4
ADDRLP4 472
ADDRGP4 trap_BotLoadChatFile
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 472
INDIRI4
ASGNI4
line 1262
;1262:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $583
line 1263
;1263:		trap_BotFreeChatState(bs->cs);
ADDRLP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeChatState
CALLV
pop
line 1264
;1264:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1265
;1265:		trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6392
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1266
;1266:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $564
JUMPV
LABELV $583
line 1269
;1267:	}
;1268:	//get the gender characteristic
;1269:	trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1271
;1270:	//set the chat gender
;1271:	if (*gender == 'f' || *gender == 'F') trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 476
ADDRLP4 152
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 476
INDIRI4
CNSTI4 102
EQI4 $587
ADDRLP4 476
INDIRI4
CNSTI4 70
NEI4 $585
LABELV $587
ADDRLP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $586
JUMPV
LABELV $585
line 1272
;1272:	else if (*gender == 'm' || *gender == 'M') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 480
ADDRLP4 152
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 480
INDIRI4
CNSTI4 109
EQI4 $590
ADDRLP4 480
INDIRI4
CNSTI4 77
NEI4 $588
LABELV $590
ADDRLP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $589
JUMPV
LABELV $588
line 1273
;1273:	else trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRLP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
LABELV $589
LABELV $586
line 1275
;1274:
;1275:	bs->inuse = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 1
ASGNI4
line 1276
;1276:	bs->client = client;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1277
;1277:	bs->entitynum = client;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1278
;1278:	bs->setupcount = 4;
ADDRLP4 0
INDIRP4
CNSTI4 5872
ADDP4
CNSTI4 4
ASGNI4
line 1279
;1279:	bs->entergame_time = FloatTime();
ADDRLP4 0
INDIRP4
CNSTI4 5920
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1280
;1280:	bs->ms = trap_BotAllocMoveState();
ADDRLP4 484
ADDRGP4 trap_BotAllocMoveState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6380
ADDP4
ADDRLP4 484
INDIRI4
ASGNI4
line 1281
;1281:	bs->walker = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WALKER, 0, 1);
ADDRLP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 48
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 492
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 5912
ADDP4
ADDRLP4 492
INDIRF4
ASGNF4
line 1282
;1282:	numbots++;
ADDRLP4 496
ADDRGP4 numbots
ASGNP4
ADDRLP4 496
INDIRP4
ADDRLP4 496
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1284
;1283:
;1284:	if (trap_Cvar_VariableIntegerValue("bot_testichat")) {
ADDRGP4 $593
ARGP4
ADDRLP4 500
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 500
INDIRI4
CNSTI4 0
EQI4 $591
line 1285
;1285:		trap_BotLibVarSet("bot_testichat", "1");
ADDRGP4 $593
ARGP4
ADDRGP4 $358
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1286
;1286:		BotChatTest(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotChatTest
CALLV
pop
line 1287
;1287:	}
LABELV $591
line 1289
;1288:	//NOTE: reschedule the bot thinking
;1289:	BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 1291
;1290:	//if interbreeding start with a mutation
;1291:	if (bot_interbreed) {
ADDRGP4 bot_interbreed
INDIRI4
CNSTI4 0
EQI4 $594
line 1292
;1292:		trap_BotMutateGoalFuzzyLogic(bs->gs, 1);
ADDRLP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_BotMutateGoalFuzzyLogic
CALLV
pop
line 1293
;1293:	}
LABELV $594
line 1295
;1294:	// if we kept the bot client
;1295:	if (restart) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $596
line 1296
;1296:		BotReadSessionData(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotReadSessionData
CALLV
pop
line 1297
;1297:	}
LABELV $596
line 1299
;1298:	//bot has been setup succesfully
;1299:	return qtrue;
CNSTI4 1
RETI4
LABELV $564
endproc BotAISetupClient 504 16
export BotAIShutdownClient
proc BotAIShutdownClient 16 12
line 1307
;1300:}
;1301:
;1302:/*
;1303:==============
;1304:BotAIShutdownClient
;1305:==============
;1306:*/
;1307:int BotAIShutdownClient(int client, qboolean restart) {
line 1310
;1308:	bot_state_t *bs;
;1309:
;1310:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1311
;1311:	if (!bs || !bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $601
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $599
LABELV $601
line 1313
;1312:		//BotAI_Print(PRT_ERROR, "BotAIShutdownClient: client %d already shutdown\n", client);
;1313:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $598
JUMPV
LABELV $599
line 1316
;1314:	}
;1315:
;1316:	if (restart) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $602
line 1317
;1317:		BotWriteSessionData(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotWriteSessionData
CALLV
pop
line 1318
;1318:	}
LABELV $602
line 1320
;1319:
;1320:	if (BotChat_ExitGame(bs)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotChat_ExitGame
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $604
line 1321
;1321:		trap_BotEnterChat(bs->cs, bs->client, CHAT_ALL);
ADDRLP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1322
;1322:	}
LABELV $604
line 1324
;1323:
;1324:	trap_BotFreeMoveState(bs->ms);
ADDRLP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeMoveState
CALLV
pop
line 1326
;1325:	//free the goal state
;1326:	trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1328
;1327:	//free the chat file
;1328:	trap_BotFreeChatState(bs->cs);
ADDRLP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeChatState
CALLV
pop
line 1330
;1329:	//free the weapon weights
;1330:	trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6392
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1332
;1331:	//free the bot character
;1332:	trap_BotFreeCharacter(bs->character);
ADDRLP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeCharacter
CALLV
pop
line 1334
;1333:	//
;1334:	BotFreeWaypoints(bs->checkpoints);
ADDRLP4 0
INDIRP4
CNSTI4 8932
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1335
;1335:	BotFreeWaypoints(bs->patrolpoints);
ADDRLP4 0
INDIRP4
CNSTI4 8936
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1337
;1336:	//clear activate goal stack
;1337:	BotClearActivateGoalStack(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 1339
;1338:	//clear the bot state
;1339:	memset(bs, 0, sizeof(bot_state_t));
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 8948
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1341
;1340:	//set the inuse flag to qfalse
;1341:	bs->inuse = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1344
;1342:
;1343:	//there's one bot less
;1344:	numbots--;
ADDRLP4 12
ADDRGP4 numbots
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1346
;1345:	//everything went ok
;1346:	return qtrue;
CNSTI4 1
RETI4
LABELV $598
endproc BotAIShutdownClient 16 12
export BotResetState
proc BotResetState 652 12
line 1357
;1347:}
;1348:
;1349:/*
;1350:==============
;1351:BotResetState
;1352:
;1353:called when a bot enters the intermission or observer mode and
;1354:when the level is changed
;1355:==============
;1356:*/
;1357:void BotResetState(bot_state_t *bs) {
line 1366
;1358:	int client, entitynum, inuse;
;1359:	int movestate, goalstate, chatstate, weaponstate;
;1360:	bot_settings_t settings;
;1361:	int character;
;1362:	playerState_t ps;							//current player state
;1363:	float entergame_time;
;1364:
;1365:	//save some things that should not be reset here
;1366:	memcpy(&settings, &bs->settings, sizeof(bot_settings_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
CNSTI4 148
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1367
;1367:	memcpy(&ps, &bs->cur_ps, sizeof(playerState_t));
ADDRLP4 180
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1368
;1368:	inuse = bs->inuse;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1369
;1369:	client = bs->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1370
;1370:	entitynum = bs->entitynum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1371
;1371:	character = bs->character;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ASGNI4
line 1372
;1372:	movestate = bs->ms;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ASGNI4
line 1373
;1373:	goalstate = bs->gs;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ASGNI4
line 1374
;1374:	chatstate = bs->cs;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ASGNI4
line 1375
;1375:	weaponstate = bs->ws;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 6392
ADDP4
INDIRI4
ASGNI4
line 1376
;1376:	entergame_time = bs->entergame_time;
ADDRLP4 648
ADDRFP4 0
INDIRP4
CNSTI4 5920
ADDP4
INDIRF4
ASGNF4
line 1378
;1377:	//free checkpoints and patrol points
;1378:	BotFreeWaypoints(bs->checkpoints);
ADDRFP4 0
INDIRP4
CNSTI4 8932
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1379
;1379:	BotFreeWaypoints(bs->patrolpoints);
ADDRFP4 0
INDIRP4
CNSTI4 8936
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1381
;1380:	//reset the whole state
;1381:	memset(bs, 0, sizeof(bot_state_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 8948
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1383
;1382:	//copy back some state stuff that should not be reset
;1383:	bs->ms = movestate;
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1384
;1384:	bs->gs = goalstate;
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1385
;1385:	bs->cs = chatstate;
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1386
;1386:	bs->ws = weaponstate;
ADDRFP4 0
INDIRP4
CNSTI4 6392
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1387
;1387:	memcpy(&bs->cur_ps, &ps, sizeof(playerState_t));
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 180
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1388
;1388:	memcpy(&bs->settings, &settings, sizeof(bot_settings_t));
ADDRFP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 148
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1389
;1389:	bs->inuse = inuse;
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1390
;1390:	bs->client = client;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1391
;1391:	bs->entitynum = entitynum;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1392
;1392:	bs->character = character;
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
ADDRLP4 176
INDIRI4
ASGNI4
line 1393
;1393:	bs->entergame_time = entergame_time;
ADDRFP4 0
INDIRP4
CNSTI4 5920
ADDP4
ADDRLP4 648
INDIRF4
ASGNF4
line 1395
;1394:	//reset several states
;1395:	if (bs->ms) trap_BotResetMoveState(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
CNSTI4 0
EQI4 $607
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetMoveState
CALLV
pop
LABELV $607
line 1396
;1396:	if (bs->gs) trap_BotResetGoalState(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $609
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetGoalState
CALLV
pop
LABELV $609
line 1397
;1397:	if (bs->ws) trap_BotResetWeaponState(bs->ws);
ADDRFP4 0
INDIRP4
CNSTI4 6392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $611
ADDRFP4 0
INDIRP4
CNSTI4 6392
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetWeaponState
CALLV
pop
LABELV $611
line 1398
;1398:	if (bs->gs) trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $613
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
LABELV $613
line 1399
;1399:	if (bs->ms) trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
CNSTI4 0
EQI4 $615
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
LABELV $615
line 1400
;1400:}
LABELV $606
endproc BotResetState 652 12
export BotAILoadMap
proc BotAILoadMap 280 16
line 1407
;1401:
;1402:/*
;1403:==============
;1404:BotAILoadMap
;1405:==============
;1406:*/
;1407:int BotAILoadMap( int restart ) {
line 1411
;1408:	int			i;
;1409:	vmCvar_t	mapname;
;1410:
;1411:	if (!restart) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $618
line 1412
;1412:		trap_Cvar_Register( &mapname, "mapname", "", CVAR_SERVERINFO | CVAR_ROM );
ADDRLP4 4
ARGP4
ADDRGP4 $620
ARGP4
ADDRGP4 $342
ARGP4
CNSTI4 68
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1413
;1413:		trap_BotLibLoadMap( mapname.string );
ADDRLP4 4+16
ARGP4
ADDRGP4 trap_BotLibLoadMap
CALLI4
pop
line 1414
;1414:	}
LABELV $618
line 1416
;1415:
;1416:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $622
line 1417
;1417:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 276
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $626
ADDRLP4 276
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $626
line 1418
;1418:			BotResetState( botstates[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotResetState
CALLV
pop
line 1419
;1419:			botstates[i]->setupcount = 4;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 5872
ADDP4
CNSTI4 4
ASGNI4
line 1420
;1420:		}
LABELV $626
line 1421
;1421:	}
LABELV $623
line 1416
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $622
line 1423
;1422:
;1423:	BotSetupDeathmatchAI();
ADDRGP4 BotSetupDeathmatchAI
CALLV
pop
line 1425
;1424:
;1425:	return qtrue;
CNSTI4 1
RETI4
LABELV $617
endproc BotAILoadMap 280 16
bss
align 4
LABELV $629
skip 4
align 4
LABELV $630
skip 4
align 4
LABELV $631
skip 4
export BotAIStartFrame
code
proc BotAIStartFrame 152 12
line 1435
;1426:}
;1427:
;1428:void ProximityMine_Trigger( gentity_t *trigger, gentity_t *other, trace_t *trace );
;1429:
;1430:/*
;1431:==================
;1432:BotAIStartFrame
;1433:==================
;1434:*/
;1435:int BotAIStartFrame(int time) {
line 1444
;1436:	int i;
;1437:	gentity_t	*ent;
;1438:	bot_entitystate_t state;
;1439:	int elapsed_time, thinktime;
;1440:	static int local_time;
;1441:	static int botlib_residual;
;1442:	static int lastbotthink_time;
;1443:
;1444:	G_CheckBotSpawn();
ADDRGP4 G_CheckBotSpawn
CALLV
pop
line 1446
;1445:
;1446:	trap_Cvar_Update(&bot_rocketjump);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1447
;1447:	trap_Cvar_Update(&bot_grapple);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1448
;1448:	trap_Cvar_Update(&bot_fastchat);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1449
;1449:	trap_Cvar_Update(&bot_nochat);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1450
;1450:	trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1451
;1451:	trap_Cvar_Update(&bot_thinktime);
ADDRGP4 bot_thinktime
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1452
;1452:	trap_Cvar_Update(&bot_memorydump);
ADDRGP4 bot_memorydump
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1453
;1453:	trap_Cvar_Update(&bot_saveroutingcache);
ADDRGP4 bot_saveroutingcache
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1454
;1454:	trap_Cvar_Update(&bot_pause);
ADDRGP4 bot_pause
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1455
;1455:	trap_Cvar_Update(&bot_report);
ADDRGP4 bot_report
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1457
;1456:
;1457:	if (bot_report.integer) {
ADDRGP4 bot_report+12
INDIRI4
CNSTI4 0
EQI4 $632
line 1460
;1458://		BotTeamplayReport();
;1459://		trap_Cvar_Set("bot_report", "0");
;1460:		BotUpdateInfoConfigStrings();
ADDRGP4 BotUpdateInfoConfigStrings
CALLV
pop
line 1461
;1461:	}
LABELV $632
line 1463
;1462:
;1463:	if (bot_pause.integer) {
ADDRGP4 bot_pause+12
INDIRI4
CNSTI4 0
EQI4 $635
line 1465
;1464:		// execute bot user commands every frame
;1465:		for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $638
line 1466
;1466:			if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 128
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $644
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $642
LABELV $644
line 1467
;1467:				continue;
ADDRGP4 $639
JUMPV
LABELV $642
line 1469
;1468:			}
;1469:			if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $645
line 1470
;1470:				continue;
ADDRGP4 $639
JUMPV
LABELV $645
line 1472
;1471:			}
;1472:			botstates[i]->lastucmd.forwardmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 0
ASGNI1
line 1473
;1473:			botstates[i]->lastucmd.rightmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 510
ADDP4
CNSTI1 0
ASGNI1
line 1474
;1474:			botstates[i]->lastucmd.upmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 0
ASGNI1
line 1475
;1475:			botstates[i]->lastucmd.buttons = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 1476
;1476:			botstates[i]->lastucmd.serverTime = time;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1477
;1477:			trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 132
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 1478
;1478:		}
LABELV $639
line 1465
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $638
line 1479
;1479:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $628
JUMPV
LABELV $635
line 1482
;1480:	}
;1481:
;1482:	if (bot_memorydump.integer) {
ADDRGP4 bot_memorydump+12
INDIRI4
CNSTI4 0
EQI4 $648
line 1483
;1483:		trap_BotLibVarSet("memorydump", "1");
ADDRGP4 $651
ARGP4
ADDRGP4 $358
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1484
;1484:		trap_Cvar_Set("bot_memorydump", "0");
ADDRGP4 $652
ARGP4
ADDRGP4 $653
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1485
;1485:	}
LABELV $648
line 1486
;1486:	if (bot_saveroutingcache.integer) {
ADDRGP4 bot_saveroutingcache+12
INDIRI4
CNSTI4 0
EQI4 $654
line 1487
;1487:		trap_BotLibVarSet("saveroutingcache", "1");
ADDRGP4 $657
ARGP4
ADDRGP4 $358
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1488
;1488:		trap_Cvar_Set("bot_saveroutingcache", "0");
ADDRGP4 $658
ARGP4
ADDRGP4 $653
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1489
;1489:	}
LABELV $654
line 1491
;1490:	//check if bot interbreeding is activated
;1491:	BotInterbreeding();
ADDRGP4 BotInterbreeding
CALLV
pop
line 1493
;1492:	//cap the bot think time
;1493:	if (bot_thinktime.integer > 200) {
ADDRGP4 bot_thinktime+12
INDIRI4
CNSTI4 200
LEI4 $659
line 1494
;1494:		trap_Cvar_Set("bot_thinktime", "200");
ADDRGP4 $662
ARGP4
ADDRGP4 $663
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1495
;1495:	}
LABELV $659
line 1497
;1496:	//if the bot think time changed we should reschedule the bots
;1497:	if (bot_thinktime.integer != lastbotthink_time) {
ADDRGP4 bot_thinktime+12
INDIRI4
ADDRGP4 $631
INDIRI4
EQI4 $664
line 1498
;1498:		lastbotthink_time = bot_thinktime.integer;
ADDRGP4 $631
ADDRGP4 bot_thinktime+12
INDIRI4
ASGNI4
line 1499
;1499:		BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 1500
;1500:	}
LABELV $664
line 1502
;1501:
;1502:	elapsed_time = time - local_time;
ADDRLP4 120
ADDRFP4 0
INDIRI4
ADDRGP4 $629
INDIRI4
SUBI4
ASGNI4
line 1503
;1503:	local_time = time;
ADDRGP4 $629
ADDRFP4 0
INDIRI4
ASGNI4
line 1505
;1504:
;1505:	botlib_residual += elapsed_time;
ADDRLP4 128
ADDRGP4 $630
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ASGNI4
line 1507
;1506:
;1507:	if (elapsed_time > bot_thinktime.integer) thinktime = elapsed_time;
ADDRLP4 120
INDIRI4
ADDRGP4 bot_thinktime+12
INDIRI4
LEI4 $668
ADDRLP4 124
ADDRLP4 120
INDIRI4
ASGNI4
ADDRGP4 $669
JUMPV
LABELV $668
line 1508
;1508:	else thinktime = bot_thinktime.integer;
ADDRLP4 124
ADDRGP4 bot_thinktime+12
INDIRI4
ASGNI4
LABELV $669
line 1511
;1509:
;1510:	// update the bot library
;1511:	if ( botlib_residual >= thinktime ) {
ADDRGP4 $630
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $672
line 1512
;1512:		botlib_residual -= thinktime;
ADDRLP4 132
ADDRGP4 $630
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
ADDRLP4 124
INDIRI4
SUBI4
ASGNI4
line 1514
;1513:
;1514:		trap_BotLibStartFrame((float) time / 1000);
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRGP4 trap_BotLibStartFrame
CALLI4
pop
line 1516
;1515:
;1516:		if (!trap_AAS_Initialized()) return qfalse;
ADDRLP4 136
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $674
CNSTI4 0
RETI4
ADDRGP4 $628
JUMPV
LABELV $674
line 1519
;1517:
;1518:		//update entities in the botlib
;1519:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $676
line 1520
;1520:			ent = &g_entities[i];
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1521
;1521:			if (!ent->inuse) {
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $680
line 1522
;1522:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1523
;1523:				continue;
ADDRGP4 $677
JUMPV
LABELV $680
line 1525
;1524:			}
;1525:			if (!ent->r.linked) {
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $682
line 1526
;1526:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1527
;1527:				continue;
ADDRGP4 $677
JUMPV
LABELV $682
line 1529
;1528:			}
;1529:			if ( !(G_IsARoundBasedGametype(g_gametype.integer) ||g_instantgib.integer || g_rockets.integer || g_elimination_allgametypes.integer)
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 140
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRLP4 140
INDIRI4
ADDRLP4 144
INDIRI4
NEI4 $684
ADDRGP4 g_instantgib+12
INDIRI4
ADDRLP4 144
INDIRI4
NEI4 $684
ADDRGP4 g_rockets+12
INDIRI4
ADDRLP4 144
INDIRI4
NEI4 $684
ADDRGP4 g_elimination_allgametypes+12
INDIRI4
ADDRLP4 144
INDIRI4
NEI4 $684
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 144
INDIRI4
EQI4 $684
line 1530
;1530:				   && ent->r.svFlags & SVF_NOCLIENT) {
line 1531
;1531:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1532
;1532:				continue;
ADDRGP4 $677
JUMPV
LABELV $684
line 1535
;1533:			}
;1534:			// do not update missiles
;1535:			if (ent->s.eType == ET_MISSILE && ent->s.weapon != WP_GRAPPLING_HOOK) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $690
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
EQI4 $690
line 1536
;1536:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1537
;1537:				continue;
ADDRGP4 $677
JUMPV
LABELV $690
line 1540
;1538:			}
;1539:			// do not update event only entities
;1540:			if (ent->s.eType > ET_EVENTS) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $692
line 1541
;1541:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1542
;1542:				continue;
ADDRGP4 $677
JUMPV
LABELV $692
line 1546
;1543:			}
;1544:
;1545:			// never link prox mine triggers
;1546:			if (ent->r.contents == CONTENTS_TRIGGER) {
ADDRLP4 4
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
CNSTI4 1073741824
NEI4 $694
line 1547
;1547:				if (ent->touch == ProximityMine_Trigger) {
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 ProximityMine_Trigger
CVPU4 4
NEU4 $696
line 1548
;1548:					trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1549
;1549:					continue;
ADDRGP4 $677
JUMPV
LABELV $696
line 1551
;1550:				}
;1551:			}
LABELV $694
line 1554
;1552:
;1553:			//
;1554:			memset(&state, 0, sizeof(bot_entitystate_t));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 112
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1556
;1555:			//
;1556:			VectorCopy(ent->r.currentOrigin, state.origin);
ADDRLP4 8+8
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1557
;1557:			if (i < MAX_CLIENTS) {
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $699
line 1558
;1558:				VectorCopy(ent->s.apos.trBase, state.angles);
ADDRLP4 8+20
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 1559
;1559:			} else {
ADDRGP4 $700
JUMPV
LABELV $699
line 1560
;1560:				VectorCopy(ent->r.currentAngles, state.angles);
ADDRLP4 8+20
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
INDIRB
ASGNB 12
line 1561
;1561:			}
LABELV $700
line 1562
;1562:			VectorCopy(ent->s.origin2, state.old_origin);
ADDRLP4 8+32
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 1563
;1563:			VectorCopy(ent->r.mins, state.mins);
ADDRLP4 8+44
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 1564
;1564:			VectorCopy(ent->r.maxs, state.maxs);
ADDRLP4 8+56
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 1565
;1565:			state.type = ent->s.eType;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1566
;1566:			state.flags = ent->s.eFlags;
ADDRLP4 8+4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1567
;1567:			if (ent->r.bmodel) state.solid = SOLID_BSP;
ADDRLP4 4
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
CNSTI4 0
EQI4 $707
ADDRLP4 8+72
CNSTI4 3
ASGNI4
ADDRGP4 $708
JUMPV
LABELV $707
line 1568
;1568:			else state.solid = SOLID_BBOX;
ADDRLP4 8+72
CNSTI4 2
ASGNI4
LABELV $708
line 1569
;1569:			state.groundent = ent->s.groundEntityNum;
ADDRLP4 8+68
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 1570
;1570:			state.modelindex = ent->s.modelindex;
ADDRLP4 8+76
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 1571
;1571:			state.modelindex2 = ent->s.modelindex2;
ADDRLP4 8+80
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
line 1572
;1572:			state.frame = ent->s.frame;
ADDRLP4 8+84
ADDRLP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 1573
;1573:			state.event = ent->s.event;
ADDRLP4 8+88
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1574
;1574:			state.eventParm = ent->s.eventParm;
ADDRLP4 8+92
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 1575
;1575:			state.powerups = ent->s.powerups;
ADDRLP4 8+96
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 1576
;1576:			state.legsAnim = ent->s.legsAnim;
ADDRLP4 8+104
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 1577
;1577:			state.torsoAnim = ent->s.torsoAnim;
ADDRLP4 8+108
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1578
;1578:			state.weapon = ent->s.weapon;
ADDRLP4 8+100
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 1580
;1579:			//
;1580:			trap_BotLibUpdateEntity(i, &state);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1581
;1581:		}
LABELV $677
line 1519
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $676
line 1583
;1582:
;1583:		BotAIRegularUpdate();
ADDRGP4 BotAIRegularUpdate
CALLV
pop
line 1584
;1584:	}
LABELV $672
line 1586
;1585:
;1586:	floattime = trap_AAS_Time();
ADDRLP4 132
ADDRGP4 trap_AAS_Time
CALLF4
ASGNF4
ADDRGP4 floattime
ADDRLP4 132
INDIRF4
ASGNF4
line 1589
;1587:
;1588:	// execute scheduled bot AI
;1589:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $721
line 1590
;1590:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 136
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $727
ADDRLP4 136
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $725
LABELV $727
line 1591
;1591:			continue;
ADDRGP4 $722
JUMPV
LABELV $725
line 1594
;1592:		}
;1593:		//
;1594:		botstates[i]->botthink_residual += elapsed_time;
ADDRLP4 140
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ASGNI4
line 1596
;1595:		//
;1596:		if ( botstates[i]->botthink_residual >= thinktime ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $728
line 1597
;1597:			botstates[i]->botthink_residual -= thinktime;
ADDRLP4 144
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
ADDRLP4 124
INDIRI4
SUBI4
ASGNI4
line 1599
;1598:
;1599:			if (!trap_AAS_Initialized()) return qfalse;
ADDRLP4 148
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $730
CNSTI4 0
RETI4
ADDRGP4 $628
JUMPV
LABELV $730
line 1601
;1600:
;1601:			if (g_entities[i].client->pers.connected == CON_CONNECTED) {
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $732
line 1602
;1602:				BotAI(i, (float) thinktime / 1000);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 124
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRGP4 BotAI
CALLI4
pop
line 1603
;1603:			}
LABELV $732
line 1604
;1604:		}
LABELV $728
line 1605
;1605:	}
LABELV $722
line 1589
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $721
line 1609
;1606:
;1607:
;1608:	// execute bot user commands every frame
;1609:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $735
line 1610
;1610:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 136
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $741
ADDRLP4 136
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $739
LABELV $741
line 1611
;1611:			continue;
ADDRGP4 $736
JUMPV
LABELV $739
line 1613
;1612:		}
;1613:		if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $742
line 1614
;1614:			continue;
ADDRGP4 $736
JUMPV
LABELV $742
line 1617
;1615:		}
;1616:
;1617:		BotUpdateInput(botstates[i], time, elapsed_time);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 BotUpdateInput
CALLV
pop
line 1618
;1618:		trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 140
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 1619
;1619:	}
LABELV $736
line 1609
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $735
line 1621
;1620:
;1621:	return qtrue;
CNSTI4 1
RETI4
LABELV $628
endproc BotAIStartFrame 152 12
export BotInitLibrary
proc BotInitLibrary 208 16
line 1629
;1622:}
;1623:
;1624:/*
;1625:==============
;1626:BotInitLibrary
;1627:==============
;1628:*/
;1629:int BotInitLibrary(void) {
line 1633
;1630:	char buf[144];
;1631:
;1632:	//set the maxclients and maxentities library variables before calling BotSetupLibrary
;1633:	Com_sprintf(buf, sizeof(buf), "%d", level.maxclients);
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $350
ARGP4
ADDRGP4 level+24
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1634
;1634:	trap_BotLibVarSet("maxclients", buf);
ADDRGP4 $747
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1635
;1635:	Com_sprintf(buf, sizeof(buf), "%d", MAX_GENTITIES);
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $350
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1636
;1636:	trap_BotLibVarSet("maxentities", buf);
ADDRGP4 $748
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1638
;1637:	//bsp checksum
;1638:	trap_Cvar_VariableStringBuffer("sv_mapChecksum", buf, sizeof(buf));
ADDRGP4 $749
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1639
;1639:	if (strlen(buf)) trap_BotLibVarSet("sv_mapChecksum", buf);
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $750
ADDRGP4 $749
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $750
line 1641
;1640:	//maximum number of aas links
;1641:	trap_Cvar_VariableStringBuffer("max_aaslinks", buf, sizeof(buf));
ADDRGP4 $752
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1642
;1642:	if (strlen(buf)) trap_BotLibVarSet("max_aaslinks", buf);
ADDRLP4 0
ARGP4
ADDRLP4 148
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $753
ADDRGP4 $752
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $753
line 1644
;1643:	//maximum number of items in a level
;1644:	trap_Cvar_VariableStringBuffer("max_levelitems", buf, sizeof(buf));
ADDRGP4 $755
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1645
;1645:	if (strlen(buf)) trap_BotLibVarSet("max_levelitems", buf);
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $756
ADDRGP4 $755
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $756
line 1647
;1646:	//game type
;1647:	trap_Cvar_VariableStringBuffer("g_gametype", buf, sizeof(buf));
ADDRGP4 $349
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1648
;1648:	if (!strlen(buf)) strcpy(buf, "0");
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $758
ADDRLP4 0
ARGP4
ADDRGP4 $653
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $758
line 1649
;1649:	trap_BotLibVarSet("g_gametype", buf);
ADDRGP4 $349
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1651
;1650:	//bot developer mode and log file
;1651:	trap_BotLibVarSet("bot_developer", bot_developer.string);
ADDRGP4 $760
ARGP4
ADDRGP4 bot_developer+16
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1652
;1652:	trap_Cvar_VariableStringBuffer("logfile", buf, sizeof(buf));
ADDRGP4 $762
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1653
;1653:	trap_BotLibVarSet("log", buf);
ADDRGP4 $763
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1655
;1654:	//no chatting
;1655:	trap_Cvar_VariableStringBuffer("bot_nochat", buf, sizeof(buf));
ADDRGP4 $764
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1656
;1656:	if (strlen(buf)) trap_BotLibVarSet("nochat", buf);
ADDRLP4 0
ARGP4
ADDRLP4 160
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $765
ADDRGP4 $767
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $765
line 1658
;1657:	//visualize jump pads
;1658:	trap_Cvar_VariableStringBuffer("bot_visualizejumppads", buf, sizeof(buf));
ADDRGP4 $768
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1659
;1659:	if (strlen(buf)) trap_BotLibVarSet("bot_visualizejumppads", buf);
ADDRLP4 0
ARGP4
ADDRLP4 164
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $769
ADDRGP4 $768
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $769
line 1661
;1660:	//forced clustering calculations
;1661:	trap_Cvar_VariableStringBuffer("bot_forceclustering", buf, sizeof(buf));
ADDRGP4 $771
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1662
;1662:	if (strlen(buf)) trap_BotLibVarSet("forceclustering", buf);
ADDRLP4 0
ARGP4
ADDRLP4 168
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $772
ADDRGP4 $774
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $772
line 1664
;1663:	//forced reachability calculations
;1664:	trap_Cvar_VariableStringBuffer("bot_forcereachability", buf, sizeof(buf));
ADDRGP4 $775
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1665
;1665:	if (strlen(buf)) trap_BotLibVarSet("forcereachability", buf);
ADDRLP4 0
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $776
ADDRGP4 $778
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $776
line 1667
;1666:	//force writing of AAS to file
;1667:	trap_Cvar_VariableStringBuffer("bot_forcewrite", buf, sizeof(buf));
ADDRGP4 $779
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1668
;1668:	if (strlen(buf)) trap_BotLibVarSet("forcewrite", buf);
ADDRLP4 0
ARGP4
ADDRLP4 176
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $780
ADDRGP4 $782
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $780
line 1670
;1669:	//no AAS optimization
;1670:	trap_Cvar_VariableStringBuffer("bot_aasoptimize", buf, sizeof(buf));
ADDRGP4 $783
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1671
;1671:	if (strlen(buf)) trap_BotLibVarSet("aasoptimize", buf);
ADDRLP4 0
ARGP4
ADDRLP4 180
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $784
ADDRGP4 $786
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $784
line 1673
;1672:	//
;1673:	trap_Cvar_VariableStringBuffer("bot_saveroutingcache", buf, sizeof(buf));
ADDRGP4 $658
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1674
;1674:	if (strlen(buf)) trap_BotLibVarSet("saveroutingcache", buf);
ADDRLP4 0
ARGP4
ADDRLP4 184
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $787
ADDRGP4 $657
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $787
line 1676
;1675:	//reload instead of cache bot character files
;1676:	trap_Cvar_VariableStringBuffer("bot_reloadcharacters", buf, sizeof(buf));
ADDRGP4 $357
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1677
;1677:	if (!strlen(buf)) strcpy(buf, "0");
ADDRLP4 0
ARGP4
ADDRLP4 188
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
NEI4 $789
ADDRLP4 0
ARGP4
ADDRGP4 $653
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $789
line 1678
;1678:	trap_BotLibVarSet("bot_reloadcharacters", buf);
ADDRGP4 $357
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1680
;1679:	//base directory
;1680:	trap_Cvar_VariableStringBuffer("fs_basepath", buf, sizeof(buf));
ADDRGP4 $791
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1681
;1681:	if (strlen(buf)) trap_BotLibVarSet("basedir", buf);
ADDRLP4 0
ARGP4
ADDRLP4 192
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $792
ADDRGP4 $794
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $792
line 1683
;1682:	//game directory
;1683:	trap_Cvar_VariableStringBuffer("fs_game", buf, sizeof(buf));
ADDRGP4 $795
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1684
;1684:	if (strlen(buf)) trap_BotLibVarSet("gamedir", buf);
ADDRLP4 0
ARGP4
ADDRLP4 196
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $796
ADDRGP4 $798
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $796
line 1686
;1685:	//home directory
;1686:	trap_Cvar_VariableStringBuffer("fs_homepath", buf, sizeof(buf));
ADDRGP4 $799
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1687
;1687:	if (strlen(buf)) trap_BotLibVarSet("homedir", buf);
ADDRLP4 0
ARGP4
ADDRLP4 200
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $800
ADDRGP4 $802
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $800
line 1693
;1688:	//
;1689:#ifdef MISSIONPACK
;1690:	trap_BotLibDefine("MISSIONPACK");
;1691:#endif
;1692:	//setup the bot library
;1693:	return trap_BotLibSetup();
ADDRLP4 204
ADDRGP4 trap_BotLibSetup
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
RETI4
LABELV $745
endproc BotInitLibrary 208 16
export BotAISetup
proc BotAISetup 8 16
line 1701
;1694:}
;1695:
;1696:/*
;1697:==============
;1698:BotAISetup
;1699:==============
;1700:*/
;1701:int BotAISetup( int restart ) {
line 1704
;1702:	int			errnum;
;1703:
;1704:	trap_Cvar_Register(&bot_thinktime, "bot_thinktime", "100", CVAR_CHEAT);
ADDRGP4 bot_thinktime
ARGP4
ADDRGP4 $662
ARGP4
ADDRGP4 $804
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1705
;1705:	trap_Cvar_Register(&bot_memorydump, "bot_memorydump", "0", CVAR_CHEAT);
ADDRGP4 bot_memorydump
ARGP4
ADDRGP4 $652
ARGP4
ADDRGP4 $653
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1706
;1706:	trap_Cvar_Register(&bot_saveroutingcache, "bot_saveroutingcache", "0", CVAR_CHEAT);
ADDRGP4 bot_saveroutingcache
ARGP4
ADDRGP4 $658
ARGP4
ADDRGP4 $653
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1707
;1707:	trap_Cvar_Register(&bot_pause, "bot_pause", "0", CVAR_CHEAT);
ADDRGP4 bot_pause
ARGP4
ADDRGP4 $805
ARGP4
ADDRGP4 $653
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1708
;1708:	trap_Cvar_Register(&bot_report, "bot_report", "0", CVAR_CHEAT);
ADDRGP4 bot_report
ARGP4
ADDRGP4 $806
ARGP4
ADDRGP4 $653
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1709
;1709:	trap_Cvar_Register(&bot_testsolid, "bot_testsolid", "0", CVAR_CHEAT);
ADDRGP4 bot_testsolid
ARGP4
ADDRGP4 $807
ARGP4
ADDRGP4 $653
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1710
;1710:	trap_Cvar_Register(&bot_testclusters, "bot_testclusters", "0", CVAR_CHEAT);
ADDRGP4 bot_testclusters
ARGP4
ADDRGP4 $808
ARGP4
ADDRGP4 $653
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1711
;1711:	trap_Cvar_Register(&bot_developer, "bot_developer", "0", CVAR_CHEAT);
ADDRGP4 bot_developer
ARGP4
ADDRGP4 $760
ARGP4
ADDRGP4 $653
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1712
;1712:	trap_Cvar_Register(&bot_interbreedchar, "bot_interbreedchar", "", 0);
ADDRGP4 bot_interbreedchar
ARGP4
ADDRGP4 $367
ARGP4
ADDRGP4 $342
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1713
;1713:	trap_Cvar_Register(&bot_interbreedbots, "bot_interbreedbots", "10", 0);
ADDRGP4 bot_interbreedbots
ARGP4
ADDRGP4 $809
ARGP4
ADDRGP4 $810
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1714
;1714:	trap_Cvar_Register(&bot_interbreedcycle, "bot_interbreedcycle", "20", 0);
ADDRGP4 bot_interbreedcycle
ARGP4
ADDRGP4 $811
ARGP4
ADDRGP4 $812
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1715
;1715:	trap_Cvar_Register(&bot_interbreedwrite, "bot_interbreedwrite", "", 0);
ADDRGP4 bot_interbreedwrite
ARGP4
ADDRGP4 $341
ARGP4
ADDRGP4 $342
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1718
;1716:
;1717:	//if the game is restarted for a tournament
;1718:	if (restart) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $813
line 1719
;1719:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $803
JUMPV
LABELV $813
line 1723
;1720:	}
;1721:
;1722:	//initialize the bot states
;1723:	memset( botstates, 0, sizeof(botstates) );
ADDRGP4 botstates
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1725
;1724:
;1725:	errnum = BotInitLibrary();
ADDRLP4 4
ADDRGP4 BotInitLibrary
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1726
;1726:	if (errnum != BLERR_NOERROR) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $815
CNSTI4 0
RETI4
ADDRGP4 $803
JUMPV
LABELV $815
line 1727
;1727:	return qtrue;
CNSTI4 1
RETI4
LABELV $803
endproc BotAISetup 8 16
export BotAIShutdown
proc BotAIShutdown 8 8
line 1735
;1728:}
;1729:
;1730:/*
;1731:==============
;1732:BotAIShutdown
;1733:==============
;1734:*/
;1735:int BotAIShutdown( int restart ) {
line 1740
;1736:
;1737:	int i;
;1738:
;1739:	//if the game is restarted for a tournament
;1740:	if ( restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $818
line 1742
;1741:		//shutdown all the bots in the botlib
;1742:		for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $820
line 1743
;1743:			if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $824
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $824
line 1744
;1744:				BotAIShutdownClient(botstates[i]->client, restart);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 1745
;1745:			}
LABELV $824
line 1746
;1746:		}
LABELV $821
line 1742
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $820
line 1748
;1747:		//don't shutdown the bot library
;1748:	}
ADDRGP4 $819
JUMPV
LABELV $818
line 1749
;1749:	else {
line 1750
;1750:		trap_BotLibShutdown();
ADDRGP4 trap_BotLibShutdown
CALLI4
pop
line 1751
;1751:	}
LABELV $819
line 1752
;1752:	return qtrue;
CNSTI4 1
RETI4
LABELV $817
endproc BotAIShutdown 8 8
import ProximityMine_Trigger
bss
export bot_interbreedwrite
align 4
LABELV bot_interbreedwrite
skip 272
export bot_interbreedcycle
align 4
LABELV bot_interbreedcycle
skip 272
export bot_interbreedbots
align 4
LABELV bot_interbreedbots
skip 272
export bot_interbreedchar
align 4
LABELV bot_interbreedchar
skip 272
export bot_developer
align 4
LABELV bot_developer
skip 272
export bot_testclusters
align 4
LABELV bot_testclusters
skip 272
export bot_testsolid
align 4
LABELV bot_testsolid
skip 272
export bot_report
align 4
LABELV bot_report
skip 272
export bot_pause
align 4
LABELV bot_pause
skip 272
export bot_saveroutingcache
align 4
LABELV bot_saveroutingcache
skip 272
export bot_memorydump
align 4
LABELV bot_memorydump
skip 272
export bot_thinktime
align 4
LABELV bot_thinktime
skip 272
export bot_interbreedmatchcount
align 4
LABELV bot_interbreedmatchcount
skip 4
export bot_interbreed
align 4
LABELV bot_interbreed
skip 4
export regularupdate_time
align 4
LABELV regularupdate_time
skip 4
export numbots
align 4
LABELV numbots
skip 4
export botstates
align 4
LABELV botstates
skip 256
import BotVoiceChat_Defend
import BotVoiceChatCommand
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import BotChatTest
import BotValidChatPosition
import BotChatTime
import BotChat_Random
import BotChat_EnemySuicide
import BotChat_Kill
import BotChat_Death
import BotChat_HitNoKill
import BotChat_HitNoDeath
import BotChat_HitTalking
import BotChat_EndLevel
import BotChat_StartLevel
import BotChat_ExitGame
import BotChat_EnterGame
import neutralobelisk
import blueobelisk
import redobelisk
import ctf_neutralflag
import ctf_blueflag
import ctf_redflag
import bot_challenge
import bot_testrchat
import bot_nochat
import bot_fastchat
import bot_rocketjump
import bot_grapple
import maxclients
import gametype
import BotMapScripts
import BotPointAreaNum
import ClientOnSameTeamFromName
import ClientFromName
import stristr
import BotFindWayPoint
import BotCreateWayPoint
import BotAlternateRoute
import BotGetAlternateRouteGoal
import BotEnemyCubeCarrierVisible
import BotTeamCubeCarrierVisible
import BotHarvesterRetreatGoals
import BotHarvesterSeekGoals
import BotGoHarvest
import BotObeliskRetreatGoals
import BotObeliskSeekGoals
import Bot1FCTFRetreatGoals
import Bot1FCTFSeekGoals
import BotHarvesterCarryingCubes
import Bot1FCTFCarryingFlag
import BotCTFRetreatGoals
import BotCTFSeekGoals
import BotRememberLastOrderedTask
import BotCTFCarryingFlag
import BotOppositeTeam
import BotTeam
import BotClearActivateGoalStack
import BotPopFromActivateGoalStack
import BotEnableActivateGoalAreas
import BotAIPredictObstacles
import BotAIBlocked
import BotCheckAttack
import BotAimAtEnemy
import BotEntityVisible
import BotRoamGoal
import BotFindEnemy
import InFieldOfVision
import BotVisibleTeamMatesAndEnemies
import BotEnemyFlagCarrierVisible
import BotTeamFlagCarrierVisible
import BotTeamFlagCarrier
import BotSameTeam
import BotAttackMove
import BotWantsToCamp
import BotHasPersistantPowerupAndWeapon
import BotCanAndWantsToRocketJump
import BotWantsToHelp
import BotWantsToChase
import BotWantsToRetreat
import BotFeelingBad
import BotAggression
import BotTeamGoals
import BotSetLastOrderedTask
import BotSynonymContext
import ClientSkin
import EasyClientName
import ClientName
import BotSetTeamStatus
import BotSetUserInfo
import EntityHasKamikaze
import EntityIsShooting
import EntityIsInvisible
import EntityIsDead
import BotInLavaOrSlime
import BotIntermission
import BotIsObserver
import BotIsDead
import BotBattleUseItems
import BotUpdateBattleInventory
import BotUpdateInventory
import BotSetupForMovement
import BotChooseWeapon
import BotFreeWaypoints
import BotDeathmatchAI
import BotShutdownDeathmatchAI
import BotSetupDeathmatchAI
export floattime
align 4
LABELV floattime
skip 4
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
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
LABELV $812
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $811
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $810
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $809
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $808
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $807
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $806
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $805
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $804
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $802
byte 1 104
byte 1 111
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $799
byte 1 102
byte 1 115
byte 1 95
byte 1 104
byte 1 111
byte 1 109
byte 1 101
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $798
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $795
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $794
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $791
byte 1 102
byte 1 115
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $786
byte 1 97
byte 1 97
byte 1 115
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $783
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 97
byte 1 97
byte 1 115
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $782
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $779
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $778
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $775
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $774
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $771
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $768
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 118
byte 1 105
byte 1 115
byte 1 117
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $767
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $764
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $763
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $762
byte 1 108
byte 1 111
byte 1 103
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $760
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $755
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $752
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 97
byte 1 97
byte 1 115
byte 1 108
byte 1 105
byte 1 110
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $749
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $748
byte 1 109
byte 1 97
byte 1 120
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $747
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $663
byte 1 50
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $662
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $658
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $657
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $653
byte 1 48
byte 1 0
align 1
LABELV $652
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $651
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $620
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $593
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $578
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $575
byte 1 65
byte 1 65
byte 1 83
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $572
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 83
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $569
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 83
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 112
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $562
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $561
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
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $542
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $539
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $536
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $533
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $530
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $527
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $524
byte 1 99
byte 1 112
byte 1 32
byte 1 0
align 1
LABELV $516
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 58
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
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $513
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $367
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $364
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 52
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $358
byte 1 49
byte 1 0
align 1
LABELV $357
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
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
byte 1 0
align 1
LABELV $350
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $349
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $342
byte 1 0
align 1
LABELV $341
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $292
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 97
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $289
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $287
byte 1 103
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 66
byte 1 0
align 1
LABELV $285
byte 1 103
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 0
align 1
LABELV $283
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $281
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
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
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $279
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $277
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $275
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $273
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $271
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $269
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $267
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $265
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $263
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $261
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $256
byte 1 37
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $245
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $224
byte 1 94
byte 1 52
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $223
byte 1 116
byte 1 0
align 1
LABELV $219
byte 1 110
byte 1 0
align 1
LABELV $208
byte 1 94
byte 1 49
byte 1 82
byte 1 69
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $204
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $203
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 103
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 66
byte 1 10
byte 1 0
align 1
LABELV $201
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 103
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 10
byte 1 0
align 1
LABELV $199
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $197
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
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
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $195
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $193
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $191
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $189
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $187
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $185
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $183
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $181
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $179
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $177
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $172
byte 1 94
byte 1 52
byte 1 37
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $171
byte 1 94
byte 1 49
byte 1 37
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $158
byte 1 94
byte 1 52
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $157
byte 1 94
byte 1 49
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $150
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $149
byte 1 32
byte 1 0
align 1
LABELV $148
byte 1 76
byte 1 0
align 1
LABELV $143
byte 1 13
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $142
byte 1 13
byte 1 94
byte 1 49
byte 1 83
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 33
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
LABELV $134
byte 1 13
byte 1 94
byte 1 49
byte 1 83
byte 1 79
byte 1 76
byte 1 73
byte 1 68
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $133
byte 1 13
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $75
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $74
byte 1 94
byte 1 49
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $72
byte 1 94
byte 1 49
byte 1 70
byte 1 97
byte 1 116
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $70
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $68
byte 1 94
byte 1 51
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $66
byte 1 37
byte 1 115
byte 1 0
