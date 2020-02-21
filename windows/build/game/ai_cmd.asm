export BotGetItemTeamGoal
code
proc BotGetItemTeamGoal 12 12
file "../../../code/game/ai_cmd.c"
line 167
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
;25: * name:		ai_cmd.c
;26: *
;27: * desc:		Quake3 bot AI
;28: *
;29: * $Archive: /MissionPack/code/game/ai_cmd.c $
;30: *
;31: *****************************************************************************/
;32:
;33:#include "g_local.h"
;34:#include "../botlib/botlib.h"
;35:#include "../botlib/be_aas.h"
;36:#include "../botlib/be_ea.h"
;37:#include "../botlib/be_ai_char.h"
;38:#include "../botlib/be_ai_chat.h"
;39:#include "../botlib/be_ai_gen.h"
;40:#include "../botlib/be_ai_goal.h"
;41:#include "../botlib/be_ai_move.h"
;42:#include "../botlib/be_ai_weap.h"
;43://
;44:#include "ai_main.h"
;45:#include "ai_dmq3.h"
;46:#include "ai_chat.h"
;47:#include "ai_cmd.h"
;48:#include "ai_dmnet.h"
;49:#include "ai_team.h"
;50://
;51:#include "chars.h"				//characteristics
;52:#include "inv.h"				//indexes into the inventory
;53:#include "syn.h"				//synonyms
;54:#include "match.h"				//string matching types and vars
;55:
;56:// for the voice chats
;57:#include "../../ui/menudef.h"
;58:
;59:int notleader[MAX_CLIENTS];
;60:
;61:#ifdef DEBUG
;62:/*
;63:==================
;64:BotPrintTeamGoal
;65:==================
;66:*/
;67:void BotPrintTeamGoal(bot_state_t *bs) {
;68:	char netname[MAX_NETNAME];
;69:	float t;
;70:
;71:	ClientName(bs->client, netname, sizeof(netname));
;72:	t = bs->teamgoal_time - FloatTime();
;73:	switch(bs->ltgtype) {
;74:		case LTG_TEAMHELP:
;75:		{
;76:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna help a team mate for %1.0f secs\n", netname, t);
;77:			break;
;78:		}
;79:		case LTG_TEAMACCOMPANY:
;80:		{
;81:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna accompany a team mate for %1.0f secs\n", netname, t);
;82:			break;
;83:		}
;84:		case LTG_GETFLAG:
;85:		{
;86:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna get the flag for %1.0f secs\n", netname, t);
;87:			break;
;88:		}
;89:		case LTG_RUSHBASE:
;90:		{
;91:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna rush to the base for %1.0f secs\n", netname, t);
;92:			break;
;93:		}
;94:		case LTG_RETURNFLAG:
;95:		{
;96:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna try to return the flag for %1.0f secs\n", netname, t);
;97:			break;
;98:		}
;99:		case LTG_ATTACKENEMYBASE:
;100:		{
;101:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna attack the enemy base for %1.0f secs\n", netname, t);
;102:			break;
;103:		}
;104:		case LTG_HARVEST:
;105:		{
;106:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna harvest for %1.0f secs\n", netname, t);
;107:			break;
;108:		}
;109:		case LTG_DEFENDKEYAREA:
;110:		{
;111:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna defend a key area for %1.0f secs\n", netname, t);
;112:			break;
;113:		}
;114:		case LTG_GETITEM:
;115:		{
;116:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna get an item for %1.0f secs\n", netname, t);
;117:			break;
;118:		}
;119:		case LTG_KILL:
;120:		{
;121:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna kill someone for %1.0f secs\n", netname, t);
;122:			break;
;123:		}
;124:		case LTG_CAMP:
;125:		case LTG_CAMPORDER:
;126:		{
;127:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna camp for %1.0f secs\n", netname, t);
;128:			break;
;129:		}
;130:		case LTG_PATROL:
;131:		{
;132:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna patrol for %1.0f secs\n", netname, t);
;133:			break;
;134:		}
;135:		case LTG_POINTA:
;136:		{
;137:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna take care of point A for %1.0f secs\n", netname, t);
;138:			break;
;139:		}
;140:		case LTG_POINTB:
;141:		{
;142:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna take care of point B for %1.0f secs\n", netname, t);
;143:			break;
;144:		}
;145:		default:
;146:		{
;147:			if (bs->ctfroam_time > FloatTime()) {
;148:				t = bs->ctfroam_time - FloatTime();
;149:				BotAI_Print(PRT_MESSAGE, "%s: I'm gonna roam for %1.0f secs\n", netname, t);
;150:			}
;151:			else {
;152:				BotAI_Print(PRT_MESSAGE, "%s: I've got a regular goal\n", netname);
;153:			}
;154:		}
;155:	}
;156:}
;157:#endif //DEBUG
;158:
;159:/*
;160:==================
;161:BotGetItemTeamGoal
;162:
;163:FIXME: add stuff like "upper rocket launcher"
;164:"the rl near the railgun", "lower grenade launcher" etc.
;165:==================
;166:*/
;167:int BotGetItemTeamGoal(char *goalname, bot_goal_t *goal) {
line 170
;168:	int i;
;169:
;170:	if (!strlen(goalname)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $62
CNSTI4 0
RETI4
ADDRGP4 $61
JUMPV
LABELV $62
line 171
;171:	i = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
LABELV $64
line 172
;172:	do {
line 173
;173:		i = trap_BotGetLevelItemGoal(i, goalname, goal);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 174
;174:		if (i > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $67
line 176
;175:			//do NOT defend dropped items
;176:			if (goal->flags & GFL_DROPPED)
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $69
line 177
;177:				continue;
ADDRGP4 $65
JUMPV
LABELV $69
line 178
;178:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $61
JUMPV
LABELV $67
line 180
;179:		}
;180:	} while(i > 0);
LABELV $65
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $64
line 181
;181:	return qfalse;
CNSTI4 0
RETI4
LABELV $61
endproc BotGetItemTeamGoal 12 12
export BotGetMessageTeamGoal
proc BotGetMessageTeamGoal 12 12
line 189
;182:}
;183:
;184:/*
;185:==================
;186:BotGetMessageTeamGoal
;187:==================
;188:*/
;189:int BotGetMessageTeamGoal(bot_state_t *bs, char *goalname, bot_goal_t *goal) {
line 192
;190:	bot_waypoint_t *cp;
;191:
;192:	if (BotGetItemTeamGoal(goalname, goal)) return qtrue;
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotGetItemTeamGoal
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $72
CNSTI4 1
RETI4
ADDRGP4 $71
JUMPV
LABELV $72
line 194
;193:
;194:	cp = BotFindWayPoint(bs->checkpoints, goalname);
ADDRFP4 0
INDIRP4
CNSTI4 8932
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotFindWayPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 195
;195:	if (cp) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $74
line 196
;196:		memcpy(goal, &cp->goal, sizeof(bot_goal_t));
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 197
;197:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $71
JUMPV
LABELV $74
line 199
;198:	}
;199:	return qfalse;
CNSTI4 0
RETI4
LABELV $71
endproc BotGetMessageTeamGoal 12 12
export BotGetTime
proc BotGetTime 600 16
line 207
;200:}
;201:
;202:/*
;203:==================
;204:BotGetTime
;205:==================
;206:*/
;207:float BotGetTime(bot_match_t *match) {
line 213
;208:	bot_match_t timematch;
;209:	char timestring[MAX_MESSAGE_SIZE];
;210:	float t;
;211:
;212:	//if the matched string has a time
;213:	if (match->subtype & ST_TIME) {
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $77
line 215
;214:		//get the time string
;215:		trap_BotMatchVariable(match, TIME, timestring, MAX_MESSAGE_SIZE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 217
;216:		//match it to find out if the time is in seconds or minutes
;217:		if (trap_BotFindMatch(timestring, &timematch, MTCONTEXT_TIME)) {
ADDRLP4 0
ARGP4
ADDRLP4 256
ARGP4
CNSTU4 8
ARGU4
ADDRLP4 588
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 588
INDIRI4
CNSTI4 0
EQI4 $79
line 218
;218:			if (timematch.type == MSG_FOREVER) {
ADDRLP4 256+256
INDIRI4
CNSTI4 107
NEI4 $81
line 219
;219:				t = 99999999.0f;
ADDRLP4 584
CNSTF4 1287568416
ASGNF4
line 220
;220:			}
ADDRGP4 $82
JUMPV
LABELV $81
line 221
;221:			else if (timematch.type == MSG_FORAWHILE) {
ADDRLP4 256+256
INDIRI4
CNSTI4 109
NEI4 $84
line 222
;222:				t = 10 * 60; // 10 minutes
ADDRLP4 584
CNSTF4 1142292480
ASGNF4
line 223
;223:			}
ADDRGP4 $85
JUMPV
LABELV $84
line 224
;224:			else if (timematch.type == MSG_FORALONGTIME) {
ADDRLP4 256+256
INDIRI4
CNSTI4 108
NEI4 $87
line 225
;225:				t = 30 * 60; // 30 minutes
ADDRLP4 584
CNSTF4 1155596288
ASGNF4
line 226
;226:			}
ADDRGP4 $88
JUMPV
LABELV $87
line 227
;227:			else {
line 228
;228:				trap_BotMatchVariable(&timematch, TIME, timestring, MAX_MESSAGE_SIZE);
ADDRLP4 256
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 229
;229:				if (timematch.type == MSG_MINUTES) t = atof(timestring) * 60;
ADDRLP4 256+256
INDIRI4
CNSTI4 105
NEI4 $90
ADDRLP4 0
ARGP4
ADDRLP4 592
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 584
CNSTF4 1114636288
ADDRLP4 592
INDIRF4
MULF4
ASGNF4
ADDRGP4 $91
JUMPV
LABELV $90
line 230
;230:				else if (timematch.type == MSG_SECONDS) t = atof(timestring);
ADDRLP4 256+256
INDIRI4
CNSTI4 106
NEI4 $93
ADDRLP4 0
ARGP4
ADDRLP4 596
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 584
ADDRLP4 596
INDIRF4
ASGNF4
ADDRGP4 $94
JUMPV
LABELV $93
line 231
;231:				else t = 0;
ADDRLP4 584
CNSTF4 0
ASGNF4
LABELV $94
LABELV $91
line 232
;232:			}
LABELV $88
LABELV $85
LABELV $82
line 234
;233:			//if there's a valid time
;234:			if (t > 0) return FloatTime() + t;
ADDRLP4 584
INDIRF4
CNSTF4 0
LEF4 $96
ADDRGP4 floattime
INDIRF4
ADDRLP4 584
INDIRF4
ADDF4
RETF4
ADDRGP4 $76
JUMPV
LABELV $96
line 235
;235:		}
LABELV $79
line 236
;236:	}
LABELV $77
line 237
;237:	return 0;
CNSTF4 0
RETF4
LABELV $76
endproc BotGetTime 600 16
export FindClientByName
proc FindClientByName 1032 12
line 245
;238:}
;239:
;240:/*
;241:==================
;242:FindClientByName
;243:==================
;244:*/
;245:int FindClientByName(char *name) {
line 249
;246:	int i;
;247:	char buf[MAX_INFO_STRING];
;248:
;249:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $102
JUMPV
LABELV $99
line 250
;250:		ClientName(i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 251
;251:		if (Q_strequal(buf, name)) return i;
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $104
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $98
JUMPV
LABELV $104
line 252
;252:	}
LABELV $100
line 249
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $102
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $99
line 253
;253:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $109
JUMPV
LABELV $106
line 254
;254:		ClientName(i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 255
;255:		if (stristr(buf, name)) return i;
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $111
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $98
JUMPV
LABELV $111
line 256
;256:	}
LABELV $107
line 253
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $109
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $106
line 257
;257:	return -1;
CNSTI4 -1
RETI4
LABELV $98
endproc FindClientByName 1032 12
export FindEnemyByName
proc FindEnemyByName 1036 12
line 265
;258:}
;259:
;260:/*
;261:==================
;262:FindEnemyByName
;263:==================
;264:*/
;265:int FindEnemyByName(bot_state_t *bs, char *name) {
line 269
;266:	int i;
;267:	char buf[MAX_INFO_STRING];
;268:
;269:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $117
JUMPV
LABELV $114
line 270
;270:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $119
ADDRGP4 $115
JUMPV
LABELV $119
line 271
;271:		ClientName(i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 272
;272:		if (Q_strequal(buf, name)) return i;
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $121
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $113
JUMPV
LABELV $121
line 273
;273:	}
LABELV $115
line 269
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $117
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $114
line 274
;274:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $126
JUMPV
LABELV $123
line 275
;275:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $128
ADDRGP4 $124
JUMPV
LABELV $128
line 276
;276:		ClientName(i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 277
;277:		if (stristr(buf, name)) return i;
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $130
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $113
JUMPV
LABELV $130
line 278
;278:	}
LABELV $124
line 274
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $126
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $123
line 279
;279:	return -1;
CNSTI4 -1
RETI4
LABELV $113
endproc FindEnemyByName 1036 12
export NumPlayersOnSameTeam
proc NumPlayersOnSameTeam 1040 12
line 287
;280:}
;281:
;282:/*
;283:==================
;284:NumPlayersOnSameTeam
;285:==================
;286:*/
;287:int NumPlayersOnSameTeam(bot_state_t *bs) {
line 291
;288:	int i, num;
;289:	char buf[MAX_INFO_STRING];
;290:
;291:	num = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 292
;292:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $136
JUMPV
LABELV $133
line 293
;293:		trap_GetConfigstring(CS_PLAYERS+i, buf, MAX_INFO_STRING);
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
line 294
;294:		if (strlen(buf)) {
ADDRLP4 4
ARGP4
ADDRLP4 1032
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $138
line 295
;295:			if (BotSameTeam(bs, i+1)) num++;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1036
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $140
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $140
line 296
;296:		}
LABELV $138
line 297
;297:	}
LABELV $134
line 292
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $136
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $133
line 298
;298:	return num;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $132
endproc NumPlayersOnSameTeam 1040 12
export BotGetPatrolWaypoints
proc BotGetPatrolWaypoints 676 16
line 306
;299:}
;300:
;301:/*
;302:==================
;303:TeamPlayIsOn
;304:==================
;305:*/
;306:int BotGetPatrolWaypoints(bot_state_t *bs, bot_match_t *match) {
line 313
;307:	char keyarea[MAX_MESSAGE_SIZE];
;308:	int patrolflags;
;309:	bot_waypoint_t *wp, *newwp, *newpatrolpoints;
;310:	bot_match_t keyareamatch;
;311:	bot_goal_t goal;
;312:
;313:	newpatrolpoints = NULL;
ADDRLP4 592
CNSTP4 0
ASGNP4
line 314
;314:	patrolflags = 0;
ADDRLP4 652
CNSTI4 0
ASGNI4
line 316
;315:	//
;316:	trap_BotMatchVariable(match, KEYAREA, keyarea, MAX_MESSAGE_SIZE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
ADDRGP4 $144
JUMPV
LABELV $143
line 318
;317:	//
;318:	while(1) {
line 319
;319:		if (!trap_BotFindMatch(keyarea, &keyareamatch, MTCONTEXT_PATROLKEYAREA)) {
ADDRLP4 8
ARGP4
ADDRLP4 264
ARGP4
CNSTU4 64
ARGU4
ADDRLP4 656
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
NEI4 $146
line 320
;320:                            trap_EA_SayTeam(bs->client, "what do you say?");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $148
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 321
;321:			BotFreeWaypoints(newpatrolpoints);
ADDRLP4 592
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 322
;322:			bs->patrolpoints = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 8936
ADDP4
CNSTP4 0
ASGNP4
line 323
;323:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $142
JUMPV
LABELV $146
line 325
;324:		}
;325:		trap_BotMatchVariable(&keyareamatch, KEYAREA, keyarea, MAX_MESSAGE_SIZE);
ADDRLP4 264
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 326
;326:		if (!BotGetMessageTeamGoal(bs, keyarea, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 596
ARGP4
ADDRLP4 660
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 0
NEI4 $149
line 329
;327:			//BotAI_BotInitialChat(bs, "cannotfind", keyarea, NULL);
;328:			//trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;329:			BotFreeWaypoints(newpatrolpoints);
ADDRLP4 592
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 330
;330:			bs->patrolpoints = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 8936
ADDP4
CNSTP4 0
ASGNP4
line 331
;331:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $142
JUMPV
LABELV $149
line 334
;332:		}
;333:		//create a new waypoint
;334:		newwp = BotCreateWayPoint(keyarea, goal.origin, goal.areanum);
ADDRLP4 8
ARGP4
ADDRLP4 596
ARGP4
ADDRLP4 596+12
INDIRI4
ARGI4
ADDRLP4 664
ADDRGP4 BotCreateWayPoint
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 664
INDIRP4
ASGNP4
line 335
;335:		if (!newwp)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $152
line 336
;336:			break;
ADDRGP4 $145
JUMPV
LABELV $152
line 338
;337:		//add the waypoint to the patrol points
;338:		newwp->next = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
CNSTP4 0
ASGNP4
line 339
;339:		for (wp = newpatrolpoints; wp && wp->next; wp = wp->next);
ADDRLP4 0
ADDRLP4 592
INDIRP4
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $154
LABELV $155
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $157
ADDRLP4 672
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 672
INDIRU4
EQU4 $158
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 672
INDIRU4
NEU4 $154
LABELV $158
line 340
;340:		if (!wp) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $159
line 341
;341:			newpatrolpoints = newwp;
ADDRLP4 592
ADDRLP4 4
INDIRP4
ASGNP4
line 342
;342:			newwp->prev = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 96
ADDP4
CNSTP4 0
ASGNP4
line 343
;343:		}
ADDRGP4 $160
JUMPV
LABELV $159
line 344
;344:		else {
line 345
;345:			wp->next = newwp;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 346
;346:			newwp->prev = wp;
ADDRLP4 4
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 347
;347:		}
LABELV $160
line 349
;348:		//
;349:		if (keyareamatch.subtype & ST_BACK) {
ADDRLP4 264+260
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $161
line 350
;350:			patrolflags = PATROL_LOOP;
ADDRLP4 652
CNSTI4 1
ASGNI4
line 351
;351:			break;
ADDRGP4 $145
JUMPV
LABELV $161
line 353
;352:		}
;353:		else if (keyareamatch.subtype & ST_REVERSE) {
ADDRLP4 264+260
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $164
line 354
;354:			patrolflags = PATROL_REVERSE;
ADDRLP4 652
CNSTI4 2
ASGNI4
line 355
;355:			break;
ADDRGP4 $145
JUMPV
LABELV $164
line 357
;356:		}
;357:		else if (keyareamatch.subtype & ST_MORE) {
ADDRLP4 264+260
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $145
line 358
;358:			trap_BotMatchVariable(&keyareamatch, MORE, keyarea, MAX_MESSAGE_SIZE);
ADDRLP4 264
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 359
;359:		}
line 360
;360:		else {
line 361
;361:			break;
LABELV $168
line 363
;362:		}
;363:	}
LABELV $144
line 318
ADDRGP4 $143
JUMPV
LABELV $145
line 365
;364:	//
;365:	if (!newpatrolpoints || !newpatrolpoints->next) {
ADDRLP4 660
CNSTU4 0
ASGNU4
ADDRLP4 592
INDIRP4
CVPU4 4
ADDRLP4 660
INDIRU4
EQU4 $172
ADDRLP4 592
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 660
INDIRU4
NEU4 $170
LABELV $172
line 366
;366:		trap_EA_SayTeam(bs->client, "I need more key points to patrol\n");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $173
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 367
;367:		BotFreeWaypoints(newpatrolpoints);
ADDRLP4 592
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 368
;368:		newpatrolpoints = NULL;
ADDRLP4 592
CNSTP4 0
ASGNP4
line 369
;369:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $142
JUMPV
LABELV $170
line 372
;370:	}
;371:	//
;372:	BotFreeWaypoints(bs->patrolpoints);
ADDRFP4 0
INDIRP4
CNSTI4 8936
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 373
;373:	bs->patrolpoints = newpatrolpoints;
ADDRFP4 0
INDIRP4
CNSTI4 8936
ADDP4
ADDRLP4 592
INDIRP4
ASGNP4
line 375
;374:	//
;375:	bs->curpatrolpoint = bs->patrolpoints;
ADDRLP4 664
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 664
INDIRP4
CNSTI4 8940
ADDP4
ADDRLP4 664
INDIRP4
CNSTI4 8936
ADDP4
INDIRP4
ASGNP4
line 376
;376:	bs->patrolflags = patrolflags;
ADDRFP4 0
INDIRP4
CNSTI4 8944
ADDP4
ADDRLP4 652
INDIRI4
ASGNI4
line 378
;377:	//
;378:	return qtrue;
CNSTI4 1
RETI4
LABELV $142
endproc BotGetPatrolWaypoints 676 16
export BotAddressedToBot
proc BotAddressedToBot 1572 16
line 386
;379:}
;380:
;381:/*
;382:==================
;383:BotAddressedToBot
;384:==================
;385:*/
;386:int BotAddressedToBot(bot_state_t *bs, bot_match_t *match) {
line 394
;387:	char addressedto[MAX_MESSAGE_SIZE];
;388:	char netname[MAX_MESSAGE_SIZE];
;389:	char name[MAX_MESSAGE_SIZE];
;390:	char botname[128];
;391:	int client;
;392:	bot_match_t addresseematch;
;393:
;394:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 840
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 395
;395:	client = ClientOnSameTeamFromName(bs, netname);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 840
ARGP4
ADDRLP4 1228
ADDRGP4 ClientOnSameTeamFromName
CALLI4
ASGNI4
ADDRLP4 1096
ADDRLP4 1228
INDIRI4
ASGNI4
line 396
;396:	if (client < 0) return qfalse;
ADDRLP4 1096
INDIRI4
CNSTI4 0
GEI4 $175
CNSTI4 0
RETI4
ADDRGP4 $174
JUMPV
LABELV $175
line 398
;397:	//if the message is addressed to someone
;398:	if (match->subtype & ST_ADDRESSED) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $177
line 399
;399:		trap_BotMatchVariable(match, ADDRESSEE, addressedto, sizeof(addressedto));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 584
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 401
;400:		//the name of this bot
;401:		ClientName(bs->client, botname, 128);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1100
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 ClientName
CALLP4
pop
ADDRGP4 $180
JUMPV
LABELV $179
line 403
;402:		//
;403:		while(trap_BotFindMatch(addressedto, &addresseematch, MTCONTEXT_ADDRESSEE)) {
line 404
;404:			if (addresseematch.type == MSG_EVERYONE) {
ADDRLP4 0+256
INDIRI4
CNSTI4 101
NEI4 $182
line 405
;405:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $174
JUMPV
LABELV $182
line 407
;406:			}
;407:			else if (addresseematch.type == MSG_MULTIPLENAMES) {
ADDRLP4 0+256
INDIRI4
CNSTI4 102
NEI4 $185
line 408
;408:				trap_BotMatchVariable(&addresseematch, TEAMMATE, name, sizeof(name));
ADDRLP4 0
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 409
;409:				if (strlen(name)) {
ADDRLP4 328
ARGP4
ADDRLP4 1232
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
EQI4 $188
line 410
;410:					if (stristr(botname, name)) return qtrue;
ADDRLP4 1100
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1236
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $190
CNSTI4 1
RETI4
ADDRGP4 $174
JUMPV
LABELV $190
line 411
;411:					if (stristr(bs->subteam, name)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6840
ADDP4
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1240
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1240
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $192
CNSTI4 1
RETI4
ADDRGP4 $174
JUMPV
LABELV $192
line 412
;412:				}
LABELV $188
line 413
;413:				trap_BotMatchVariable(&addresseematch, MORE, addressedto, MAX_MESSAGE_SIZE);
ADDRLP4 0
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 584
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 414
;414:			}
ADDRGP4 $186
JUMPV
LABELV $185
line 415
;415:			else {
line 416
;416:				trap_BotMatchVariable(&addresseematch, TEAMMATE, name, MAX_MESSAGE_SIZE);
ADDRLP4 0
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 417
;417:				if (strlen(name)) {
ADDRLP4 328
ARGP4
ADDRLP4 1232
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
EQI4 $181
line 418
;418:					if (stristr(botname, name)) return qtrue;
ADDRLP4 1100
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1236
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $196
CNSTI4 1
RETI4
ADDRGP4 $174
JUMPV
LABELV $196
line 419
;419:					if (stristr(bs->subteam, name)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6840
ADDP4
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1240
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1240
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $181
CNSTI4 1
RETI4
ADDRGP4 $174
JUMPV
line 420
;420:				}
line 421
;421:				break;
LABELV $186
line 423
;422:			}
;423:		}
LABELV $180
line 403
ADDRLP4 584
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 32
ARGU4
ADDRLP4 1232
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
NEI4 $179
LABELV $181
line 426
;424:		//Com_sprintf(buf, sizeof(buf), "not addressed to me but %s", addressedto);
;425:		//trap_EA_Say(bs->client, buf);
;426:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $174
JUMPV
LABELV $177
line 428
;427:	}
;428:	else {
line 431
;429:		bot_match_t tellmatch;
;430:
;431:		tellmatch.type = 0;
ADDRLP4 1232+256
CNSTI4 0
ASGNI4
line 433
;432:		//if this message wasn't directed solely to this bot
;433:		if (!trap_BotFindMatch(match->string, &tellmatch, MTCONTEXT_REPLYCHAT) ||
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1232
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 1560
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 1560
INDIRI4
CNSTI4 0
EQI4 $204
ADDRLP4 1232+256
INDIRI4
CNSTI4 202
EQI4 $201
LABELV $204
line 434
;434:				tellmatch.type != MSG_CHATTELL) {
line 436
;435:			//make sure not everyone reacts to this message
;436:			if (random() > (float ) 1.0 / (NumPlayersOnSameTeam(bs)-1)) return qfalse;
ADDRLP4 1564
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1568
ADDRGP4 NumPlayersOnSameTeam
CALLI4
ASGNI4
ADDRLP4 1564
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1065353216
ADDRLP4 1568
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
DIVF4
LEF4 $205
CNSTI4 0
RETI4
ADDRGP4 $174
JUMPV
LABELV $205
line 437
;437:		}
LABELV $201
line 438
;438:	}
line 439
;439:	return qtrue;
CNSTI4 1
RETI4
LABELV $174
endproc BotAddressedToBot 1572 16
export BotGPSToPosition
proc BotGPSToPosition 20 12
line 447
;440:}
;441:
;442:/*
;443:==================
;444:BotGPSToPosition
;445:==================
;446:*/
;447:int BotGPSToPosition(char *buf, vec3_t position) {
line 448
;448:	int i, j = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 451
;449:	int num, sign;
;450:
;451:	for (i = 0; i < 3; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $208
line 452
;452:		num = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $213
JUMPV
LABELV $212
line 453
;453:		while(buf[j] == ' ') j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $213
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $212
line 454
;454:		if (buf[j] == '-') {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $215
line 455
;455:			j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 456
;456:			sign = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 457
;457:		}
ADDRGP4 $218
JUMPV
LABELV $215
line 458
;458:		else {
line 459
;459:			sign = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 460
;460:		}
ADDRGP4 $218
JUMPV
LABELV $217
line 461
;461:		while (buf[j]) {
line 462
;462:			if (buf[j] >= '0' && buf[j] <= '9') {
ADDRLP4 16
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 48
LTI4 $220
ADDRLP4 16
INDIRI4
CNSTI4 57
GTI4 $220
line 463
;463:				num = num * 10 + buf[j] - '0';
ADDRLP4 4
CNSTI4 10
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDI4
CNSTI4 48
SUBI4
ASGNI4
line 464
;464:				j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 465
;465:			}
ADDRGP4 $221
JUMPV
LABELV $220
line 466
;466:			else {
line 467
;467:				j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 468
;468:				break;
ADDRGP4 $219
JUMPV
LABELV $221
line 470
;469:			}
;470:		}
LABELV $218
line 461
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $217
LABELV $219
line 471
;471:		BotAI_Print(PRT_MESSAGE, "%d\n", sign * num);
CNSTI4 1
ARGI4
ADDRGP4 $222
ARGP4
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 472
;472:		position[i] = (float) sign * num;
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 473
;473:	}
LABELV $209
line 451
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 3
LTI4 $208
line 474
;474:	return qtrue;
CNSTI4 1
RETI4
LABELV $207
endproc BotGPSToPosition 20 12
export BotMatch_HelpAccompany
proc BotMatch_HelpAccompany 1272 16
line 482
;475:}
;476:
;477:/*
;478:==================
;479:BotMatch_HelpAccompany
;480:==================
;481:*/
;482:void BotMatch_HelpAccompany(bot_state_t *bs, bot_match_t *match) {
line 490
;483:	int client, other, areanum;
;484:	char teammate[MAX_MESSAGE_SIZE];
;485:	char netname[MAX_MESSAGE_SIZE];
;486:	char itemname[MAX_MESSAGE_SIZE];
;487:	bot_match_t teammatematch;
;488:	aas_entityinfo_t entinfo;
;489:
;490:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 1248
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 1248
INDIRI4
CNSTI4 0
NEI4 $224
ADDRGP4 $223
JUMPV
LABELV $224
line 492
;491:	//if not addressed to this bot
;492:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1252
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 1252
INDIRI4
CNSTI4 0
NEI4 $226
ADDRGP4 $223
JUMPV
LABELV $226
line 494
;493:	//get the team mate name
;494:	trap_BotMatchVariable(match, TEAMMATE, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 496
;495:	//get the client to help
;496:	if (trap_BotFindMatch(teammate, &teammatematch, MTCONTEXT_TEAMMATE) &&
ADDRLP4 260
ARGP4
ADDRLP4 656
ARGP4
CNSTU4 16
ARGU4
ADDRLP4 1256
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 1256
INDIRI4
CNSTI4 0
EQI4 $228
ADDRLP4 656+256
INDIRI4
CNSTI4 100
NEI4 $228
line 498
;497:			//if someone asks for him or herself
;498:			teammatematch.type == MSG_ME) {
line 500
;499:		//get the netname
;500:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 501
;501:		client = ClientFromName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 1260
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1260
INDIRI4
ASGNI4
line 502
;502:		other = qfalse;
ADDRLP4 984
CNSTI4 0
ASGNI4
line 503
;503:	}
ADDRGP4 $229
JUMPV
LABELV $228
line 504
;504:	else {
line 506
;505:		//asked for someone else
;506:		client = FindClientByName(teammate);
ADDRLP4 260
ARGP4
ADDRLP4 1260
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1260
INDIRI4
ASGNI4
line 508
;507:		//if this is the bot self
;508:		if (client == bs->client) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $231
line 509
;509:			other = qfalse;
ADDRLP4 984
CNSTI4 0
ASGNI4
line 510
;510:		}
ADDRGP4 $232
JUMPV
LABELV $231
line 511
;511:		else if (!BotSameTeam(bs, client)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1264
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1264
INDIRI4
CNSTI4 0
NEI4 $233
line 513
;512:			//FIXME: say "I don't help the enemy"
;513:			return;
ADDRGP4 $223
JUMPV
LABELV $233
line 515
;514:		}
;515:		else {
line 516
;516:			other = qtrue;
ADDRLP4 984
CNSTI4 1
ASGNI4
line 517
;517:		}
LABELV $232
line 518
;518:	}
LABELV $229
line 520
;519:	//if the bot doesn't know who to help (FindClientByName returned -1)
;520:	if (client < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $235
line 521
;521:		if (other) BotAI_BotInitialChat(bs, "whois", teammate, NULL);
ADDRLP4 984
INDIRI4
CNSTI4 0
EQI4 $237
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $239
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $238
JUMPV
LABELV $237
line 522
;522:		else BotAI_BotInitialChat(bs, "whois", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $239
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
LABELV $238
line 523
;523:		client = ClientFromName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 1260
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1260
INDIRI4
ASGNI4
line 524
;524:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 525
;525:		return;
ADDRGP4 $223
JUMPV
LABELV $235
line 528
;526:	}
;527:	//don't help or accompany yourself
;528:	if (client == bs->client) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $240
line 529
;529:		return;
ADDRGP4 $223
JUMPV
LABELV $240
line 532
;530:	}
;531:	//
;532:	bs->teamgoal.entitynum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
CNSTI4 -1
ASGNI4
line 533
;533:	BotEntityInfo(client, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 516
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 535
;534:	//if info is valid (in PVS)
;535:	if (entinfo.valid) {
ADDRLP4 516
INDIRI4
CNSTI4 0
EQI4 $242
line 536
;536:		areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 516+24
ARGP4
ADDRLP4 1260
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 988
ADDRLP4 1260
INDIRI4
ASGNI4
line 537
;537:		if (areanum) {// && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 988
INDIRI4
CNSTI4 0
EQI4 $245
line 538
;538:			bs->teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 539
;539:			bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6492
ADDP4
ADDRLP4 988
INDIRI4
ASGNI4
line 540
;540:			VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ADDRLP4 516+24
INDIRB
ASGNB 12
line 541
;541:			VectorSet(bs->teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 6496
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6500
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6504
ADDP4
CNSTF4 3238002688
ASGNF4
line 542
;542:			VectorSet(bs->teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 6508
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6512
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
CNSTF4 1090519040
ASGNF4
line 543
;543:		}
LABELV $245
line 544
;544:	}
LABELV $242
line 546
;545:	//if no teamgoal yet
;546:	if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
CNSTI4 0
GEI4 $248
line 548
;547:		//if near an item
;548:		if (match->subtype & ST_NEARITEM) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $250
line 550
;549:			//get the match variable
;550:			trap_BotMatchVariable(match, ITEM, itemname, sizeof(itemname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 992
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 552
;551:			//
;552:			if (!BotGetMessageTeamGoal(bs, itemname, &bs->teamgoal)) {
ADDRLP4 1260
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1260
INDIRP4
ARGP4
ADDRLP4 992
ARGP4
ADDRLP4 1260
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRLP4 1264
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 1264
INDIRI4
CNSTI4 0
NEI4 $252
line 555
;553:				//BotAI_BotInitialChat(bs, "cannotfind", itemname, NULL);
;554:				//trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
;555:				return;
ADDRGP4 $223
JUMPV
LABELV $252
line 557
;556:			}
;557:		}
LABELV $250
line 558
;558:	}
LABELV $248
line 560
;559:	//
;560:	if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
CNSTI4 0
GEI4 $254
line 561
;561:		if (other) BotAI_BotInitialChat(bs, "whereis", teammate, NULL);
ADDRLP4 984
INDIRI4
CNSTI4 0
EQI4 $256
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $258
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $257
JUMPV
LABELV $256
line 562
;562:		else BotAI_BotInitialChat(bs, "whereareyou", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $259
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
LABELV $257
line 563
;563:		client = ClientFromName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 1260
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1260
INDIRI4
ASGNI4
line 564
;564:		trap_BotEnterChat(bs->cs, client, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 565
;565:		return;
ADDRGP4 $223
JUMPV
LABELV $254
line 568
;566:	}
;567:	//the team mate
;568:	bs->teammate = client;
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 570
;569:	//
;570:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 572
;571:	//
;572:	client = ClientFromName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 1260
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1260
INDIRI4
ASGNI4
line 574
;573:	//the team mate who ordered
;574:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 575
;575:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 576
;576:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 578
;577:	//last time the team mate was assumed visible
;578:	bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 580
;579:	//set the time to send a message to the team mates
;580:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 1264
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 1264
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 582
;581:	//get the team goal time
;582:	bs->teamgoal_time = BotGetTime(match);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1268
ADDRGP4 BotGetTime
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 1268
INDIRF4
ASGNF4
line 584
;583:	//set the ltg type
;584:	if (match->type == MSG_HELP) {
ADDRFP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 3
NEI4 $260
line 585
;585:		bs->ltgtype = LTG_TEAMHELP;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 1
ASGNI4
line 586
;586:		if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + TEAM_HELP_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
CNSTF4 0
NEF4 $261
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 587
;587:	}
ADDRGP4 $261
JUMPV
LABELV $260
line 588
;588:	else {
line 589
;589:		bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 2
ASGNI4
line 590
;590:		if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
CNSTF4 0
NEF4 $264
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
LABELV $264
line 591
;591:		bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 6872
ADDP4
CNSTF4 1121976320
ASGNF4
line 592
;592:		bs->arrive_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTF4 0
ASGNF4
line 594
;593:		//
;594:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 596
;595:		// remember last ordered task
;596:		BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 597
;597:	}
LABELV $261
line 601
;598:#ifdef DEBUG
;599:	BotPrintTeamGoal(bs);
;600:#endif //DEBUG
;601:}
LABELV $223
endproc BotMatch_HelpAccompany 1272 16
export BotMatch_DefendKeyArea
proc BotMatch_DefendKeyArea 544 16
line 608
;602:
;603:/*
;604:==================
;605:BotMatch_DefendKeyArea
;606:==================
;607:*/
;608:void BotMatch_DefendKeyArea(bot_state_t *bs, bot_match_t *match) {
line 613
;609:	char itemname[MAX_MESSAGE_SIZE];
;610:	char netname[MAX_MESSAGE_SIZE];
;611:	int client;
;612:
;613:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 516
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $267
ADDRGP4 $266
JUMPV
LABELV $267
line 615
;614:	//if not addressed to this bot
;615:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 520
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 0
NEI4 $269
ADDRGP4 $266
JUMPV
LABELV $269
line 617
;616:	//get the match variable
;617:	trap_BotMatchVariable(match, KEYAREA, itemname, sizeof(itemname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 619
;618:	//
;619:	if (!BotGetMessageTeamGoal(bs, itemname, &bs->teamgoal)) {
ADDRLP4 524
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 524
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 524
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRLP4 528
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 528
INDIRI4
CNSTI4 0
NEI4 $271
line 622
;620:		//BotAI_BotInitialChat(bs, "cannotfind", itemname, NULL);
;621:		//trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
;622:		return;
ADDRGP4 $266
JUMPV
LABELV $271
line 625
;623:	}
;624:	//
;625:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 627
;626:	//
;627:	client = ClientFromName(netname);
ADDRLP4 256
ARGP4
ADDRLP4 532
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 512
ADDRLP4 532
INDIRI4
ASGNI4
line 629
;628:	//the team mate who ordered
;629:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 512
INDIRI4
ASGNI4
line 630
;630:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 631
;631:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 633
;632:	//set the time to send a message to the team mates
;633:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 536
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 536
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 635
;634:	//set the ltg type
;635:	bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 3
ASGNI4
line 637
;636:	//get the team goal time
;637:	bs->teamgoal_time = BotGetTime(match);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 540
ADDRGP4 BotGetTime
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 540
INDIRF4
ASGNF4
line 639
;638:	//set the team goal time
;639:	if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
CNSTF4 0
NEF4 $273
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
LABELV $273
line 641
;640:	//away from defending
;641:	bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
CNSTF4 0
ASGNF4
line 643
;642:	//
;643:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 645
;644:	// remember last ordered task
;645:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 649
;646:#ifdef DEBUG
;647:	BotPrintTeamGoal(bs);
;648:#endif //DEBUG
;649:}
LABELV $266
endproc BotMatch_DefendKeyArea 544 16
export BotMatch_TakeA
proc BotMatch_TakeA 280 16
line 657
;650:
;651:/*
;652:==================
;653:BotMatch_TakeA
;654:For Double Domination
;655:==================
;656:*/
;657:void BotMatch_TakeA(bot_state_t *bs, bot_match_t *match) {
line 662
;658:// 	char itemname[MAX_MESSAGE_SIZE];
;659:	char netname[MAX_MESSAGE_SIZE];
;660:	int client;
;661:
;662:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $276
ADDRGP4 $275
JUMPV
LABELV $276
line 664
;663:	//if not addressed to this bot
;664:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $278
ADDRGP4 $275
JUMPV
LABELV $278
line 674
;665:	//get the match variable
;666:	/*trap_BotMatchVariable(match, KEYAREA, itemname, sizeof(itemname));
;667:	//
;668:	if (!BotGetMessageTeamGoal(bs, itemname, &bs->teamgoal)) {
;669:		//BotAI_BotInitialChat(bs, "cannotfind", itemname, NULL);
;670:		//trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
;671:		return;
;672:	}*/
;673:	//
;674:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 676
;675:	//
;676:	client = ClientFromName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 268
INDIRI4
ASGNI4
line 678
;677:	//the team mate who ordered
;678:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 679
;679:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 680
;680:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 682
;681:	//set the time to send a message to the team mates
;682:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 272
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 272
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 684
;683:	//set the ltg type
;684:	bs->ltgtype = LTG_POINTA;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 16
ASGNI4
line 686
;685:	//get the team goal time
;686:	bs->teamgoal_time = BotGetTime(match);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 BotGetTime
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 276
INDIRF4
ASGNF4
line 688
;687:	//set the team goal time
;688:	if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + DD_POINTA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
CNSTF4 0
NEF4 $280
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
LABELV $280
line 690
;689:	//away from defending
;690:	bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
CNSTF4 0
ASGNF4
line 692
;691:	//
;692:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 694
;693:	// remember last ordered task
;694:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 698
;695:#ifdef DEBUG
;696:	BotPrintTeamGoal(bs);
;697:#endif //DEBUG
;698:}
LABELV $275
endproc BotMatch_TakeA 280 16
export BotMatch_TakeB
proc BotMatch_TakeB 280 16
line 706
;699:
;700:/*
;701:==================
;702:BotMatch_TakeB
;703:For Double Domination
;704:==================
;705:*/
;706:void BotMatch_TakeB(bot_state_t *bs, bot_match_t *match) {
line 711
;707:// 	char itemname[MAX_MESSAGE_SIZE];
;708:	char netname[MAX_MESSAGE_SIZE];
;709:	int client;
;710:
;711:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $283
ADDRGP4 $282
JUMPV
LABELV $283
line 713
;712:	//if not addressed to this bot
;713:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $285
ADDRGP4 $282
JUMPV
LABELV $285
line 723
;714:	//get the match variable
;715:	/*trap_BotMatchVariable(match, KEYAREA, itemname, sizeof(itemname));
;716:	//
;717:	if (!BotGetMessageTeamGoal(bs, itemname, &bs->teamgoal)) {
;718:		//BotAI_BotInitialChat(bs, "cannotfind", itemname, NULL);
;719:		//trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
;720:		//return;
;721:	}*/
;722:	//
;723:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 725
;724:	//
;725:	client = ClientFromName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 268
INDIRI4
ASGNI4
line 727
;726:	//the team mate who ordered
;727:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 728
;728:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 729
;729:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 731
;730:	//set the time to send a message to the team mates
;731:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 272
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 272
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 733
;732:	//set the ltg type
;733:	bs->ltgtype = LTG_POINTB;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 17
ASGNI4
line 735
;734:	//get the team goal time
;735:	bs->teamgoal_time = BotGetTime(match);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 BotGetTime
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 276
INDIRF4
ASGNF4
line 737
;736:	//set the team goal time
;737:	if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + DD_POINTA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
CNSTF4 0
NEF4 $287
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
LABELV $287
line 739
;738:	//away from defending
;739:	bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
CNSTF4 0
ASGNF4
line 741
;740:	//
;741:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 743
;742:	// remember last ordered task
;743:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 747
;744:#ifdef DEBUG
;745:	BotPrintTeamGoal(bs);
;746:#endif //DEBUG
;747:}
LABELV $282
endproc BotMatch_TakeB 280 16
export BotMatch_GetItem
proc BotMatch_GetItem 540 16
line 754
;748:
;749:/*
;750:==================
;751:BotMatch_GetItem
;752:==================
;753:*/
;754:void BotMatch_GetItem(bot_state_t *bs, bot_match_t *match) {
line 759
;755:	char itemname[MAX_MESSAGE_SIZE];
;756:	char netname[MAX_MESSAGE_SIZE];
;757:	int client;
;758:
;759:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 516
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $290
ADDRGP4 $289
JUMPV
LABELV $290
line 761
;760:	//if not addressed to this bot
;761:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 520
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 0
NEI4 $292
ADDRGP4 $289
JUMPV
LABELV $292
line 763
;762:	//get the match variable
;763:	trap_BotMatchVariable(match, ITEM, itemname, sizeof(itemname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 765
;764:	//
;765:	if (!BotGetMessageTeamGoal(bs, itemname, &bs->teamgoal)) {
ADDRLP4 524
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 524
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 524
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRLP4 528
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 528
INDIRI4
CNSTI4 0
NEI4 $294
line 768
;766:		//BotAI_BotInitialChat(bs, "cannotfind", itemname, NULL);
;767:		//trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
;768:		return;
ADDRGP4 $289
JUMPV
LABELV $294
line 770
;769:	}
;770:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 771
;771:	client = ClientOnSameTeamFromName(bs, netname);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 532
ADDRGP4 ClientOnSameTeamFromName
CALLI4
ASGNI4
ADDRLP4 512
ADDRLP4 532
INDIRI4
ASGNI4
line 773
;772:	//
;773:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 512
INDIRI4
ASGNI4
line 774
;774:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 775
;775:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 777
;776:	//set the time to send a message to the team mates
;777:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 536
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 536
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 779
;778:	//set the ltg type
;779:	bs->ltgtype = LTG_GETITEM;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 10
ASGNI4
line 781
;780:	//set the team goal time
;781:	bs->teamgoal_time = FloatTime() + TEAM_GETITEM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 783
;782:	//
;783:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 787
;784:#ifdef DEBUG
;785:	BotPrintTeamGoal(bs);
;786:#endif //DEBUG
;787:}
LABELV $289
endproc BotMatch_GetItem 540 16
export BotMatch_Camp
proc BotMatch_Camp 688 16
line 794
;788:
;789:/*
;790:==================
;791:BotMatch_Camp
;792:==================
;793:*/
;794:void BotMatch_Camp(bot_state_t *bs, bot_match_t *match) {
line 800
;795:	int client, areanum;
;796:	char netname[MAX_MESSAGE_SIZE];
;797:	char itemname[MAX_MESSAGE_SIZE];
;798:	aas_entityinfo_t entinfo;
;799:
;800:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 660
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 0
NEI4 $297
ADDRGP4 $296
JUMPV
LABELV $297
line 802
;801:	//if not addressed to this bot
;802:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 664
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
NEI4 $299
ADDRGP4 $296
JUMPV
LABELV $299
line 804
;803:	//
;804:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 806
;805:	//asked for someone else
;806:	client = FindClientByName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 668
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 668
INDIRI4
ASGNI4
line 808
;807:	//if there's no valid client with this name
;808:	if (client < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $301
line 809
;809:		BotAI_BotInitialChat(bs, "whois", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $239
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 810
;810:		trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 672
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 811
;811:		return;
ADDRGP4 $296
JUMPV
LABELV $301
line 814
;812:	}
;813:	//get the match variable
;814:	trap_BotMatchVariable(match, KEYAREA, itemname, sizeof(itemname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 816
;815:	//in CTF it could be the base
;816:	if (match->subtype & ST_THERE) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $303
line 818
;817:		//camp at the spot the bot is currently standing
;818:		bs->teamgoal.entitynum = bs->entitynum;
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 672
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 819
;819:		bs->teamgoal.areanum = bs->areanum;
ADDRLP4 676
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 676
INDIRP4
CNSTI4 6492
ADDP4
ADDRLP4 676
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ASGNI4
line 820
;820:		VectorCopy(bs->origin, bs->teamgoal.origin);
ADDRLP4 680
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 680
INDIRP4
CNSTI4 6480
ADDP4
ADDRLP4 680
INDIRP4
CNSTI4 4764
ADDP4
INDIRB
ASGNB 12
line 821
;821:		VectorSet(bs->teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 6496
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6500
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6504
ADDP4
CNSTF4 3238002688
ASGNF4
line 822
;822:		VectorSet(bs->teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 6508
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6512
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
CNSTF4 1090519040
ASGNF4
line 823
;823:	}
ADDRGP4 $304
JUMPV
LABELV $303
line 824
;824:	else if (match->subtype & ST_HERE) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $305
line 826
;825:		//if this is the bot self
;826:		if (client == bs->client) return;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $307
ADDRGP4 $296
JUMPV
LABELV $307
line 828
;827:		//
;828:		bs->teamgoal.entitynum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
CNSTI4 -1
ASGNI4
line 829
;829:		BotEntityInfo(client, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 516
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 831
;830:		//if info is valid (in PVS)
;831:		if (entinfo.valid) {
ADDRLP4 516
INDIRI4
CNSTI4 0
EQI4 $309
line 832
;832:			areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 516+24
ARGP4
ADDRLP4 672
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 656
ADDRLP4 672
INDIRI4
ASGNI4
line 833
;833:			if (areanum) {// && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $312
line 836
;834:				//NOTE: just assume the bot knows where the person is
;835:				//if (BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, client)) {
;836:					bs->teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 837
;837:					bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6492
ADDP4
ADDRLP4 656
INDIRI4
ASGNI4
line 838
;838:					VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ADDRLP4 516+24
INDIRB
ASGNB 12
line 839
;839:					VectorSet(bs->teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 6496
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6500
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6504
ADDP4
CNSTF4 3238002688
ASGNF4
line 840
;840:					VectorSet(bs->teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 6508
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6512
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
CNSTF4 1090519040
ASGNF4
line 842
;841:				//}
;842:			}
LABELV $312
line 843
;843:		}
LABELV $309
line 845
;844:		//if the other is not visible
;845:		if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
CNSTI4 0
GEI4 $306
line 846
;846:			BotAI_BotInitialChat(bs, "whereareyou", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $259
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 847
;847:			client = ClientFromName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 672
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 672
INDIRI4
ASGNI4
line 848
;848:			trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 849
;849:			return;
ADDRGP4 $296
JUMPV
line 851
;850:		}
;851:	}
LABELV $305
line 852
;852:	else if (!BotGetMessageTeamGoal(bs, itemname, &bs->teamgoal)) {
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 672
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRLP4 676
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 676
INDIRI4
CNSTI4 0
NEI4 $317
line 856
;853:		//BotAI_BotInitialChat(bs, "cannotfind", itemname, NULL);
;854:		//client = ClientFromName(netname);
;855:		//trap_BotEnterChat(bs->cs, client, CHAT_TELL);
;856:		return;
ADDRGP4 $296
JUMPV
LABELV $317
LABELV $306
LABELV $304
line 859
;857:	}
;858:	//
;859:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 860
;860:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 861
;861:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 863
;862:	//set the time to send a message to the team mates
;863:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 680
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 680
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 865
;864:	//set the ltg type
;865:	bs->ltgtype = LTG_CAMPORDER;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 8
ASGNI4
line 867
;866:	//get the team goal time
;867:	bs->teamgoal_time = BotGetTime(match);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 684
ADDRGP4 BotGetTime
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 684
INDIRF4
ASGNF4
line 869
;868:	//set the team goal time
;869:	if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + TEAM_CAMP_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
CNSTF4 0
NEF4 $319
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
LABELV $319
line 871
;870:	//not arrived yet
;871:	bs->arrive_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTF4 0
ASGNF4
line 873
;872:	//
;873:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 875
;874:	// remember last ordered task
;875:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 879
;876:#ifdef DEBUG
;877:	BotPrintTeamGoal(bs);
;878:#endif //DEBUG
;879:}
LABELV $296
endproc BotMatch_Camp 688 16
export BotMatch_Patrol
proc BotMatch_Patrol 284 16
line 886
;880:
;881:/*
;882:==================
;883:BotMatch_Patrol
;884:==================
;885:*/
;886:void BotMatch_Patrol(bot_state_t *bs, bot_match_t *match) {
line 890
;887:	char netname[MAX_MESSAGE_SIZE];
;888:	int client;
;889:
;890:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $322
ADDRGP4 $321
JUMPV
LABELV $322
line 892
;891:	//if not addressed to this bot
;892:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $324
ADDRGP4 $321
JUMPV
LABELV $324
line 894
;893:	//get the patrol waypoints
;894:	if (!BotGetPatrolWaypoints(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotGetPatrolWaypoints
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
NEI4 $326
ADDRGP4 $321
JUMPV
LABELV $326
line 896
;895:	//
;896:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 898
;897:	//
;898:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 272
INDIRI4
ASGNI4
line 900
;899:	//
;900:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 901
;901:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 902
;902:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 904
;903:	//set the time to send a message to the team mates
;904:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 276
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 276
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 906
;905:	//set the ltg type
;906:	bs->ltgtype = LTG_PATROL;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 9
ASGNI4
line 908
;907:	//get the team goal time
;908:	bs->teamgoal_time = BotGetTime(match);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 BotGetTime
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 280
INDIRF4
ASGNF4
line 910
;909:	//set the team goal time if not set already
;910:	if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + TEAM_PATROL_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
CNSTF4 0
NEF4 $328
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
LABELV $328
line 912
;911:	//
;912:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 914
;913:	// remember last ordered task
;914:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 918
;915:#ifdef DEBUG
;916:	BotPrintTeamGoal(bs);
;917:#endif //DEBUG
;918:}
LABELV $321
endproc BotMatch_Patrol 284 16
export BotMatch_GetFlag
proc BotMatch_GetFlag 288 16
line 925
;919:
;920:/*
;921:==================
;922:BotMatch_GetFlag
;923:==================
;924:*/
;925:void BotMatch_GetFlag(bot_state_t *bs, bot_match_t *match) {
line 929
;926:	char netname[MAX_MESSAGE_SIZE];
;927:	int client;
;928:
;929:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $331
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 264
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $331
line 930
;930:		if (!ctf_redflag.areanum || !ctf_blueflag.areanum)
ADDRLP4 268
CNSTI4 0
ASGNI4
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 268
INDIRI4
EQI4 $337
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 268
INDIRI4
NEI4 $332
LABELV $337
line 931
;931:			return;
ADDRGP4 $330
JUMPV
line 932
;932:	}
LABELV $331
line 933
;933:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $338
line 934
;934:		if (!ctf_neutralflag.areanum || !ctf_redflag.areanum || !ctf_blueflag.areanum)
ADDRLP4 268
CNSTI4 0
ASGNI4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ADDRLP4 268
INDIRI4
EQI4 $346
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 268
INDIRI4
EQI4 $346
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 268
INDIRI4
NEI4 $339
LABELV $346
line 935
;935:			return;
ADDRGP4 $330
JUMPV
line 936
;936:	}
LABELV $338
line 937
;937:	else if (gametype == GT_POSSESSION) {
ADDRGP4 gametype
INDIRI4
CNSTI4 13
NEI4 $330
line 938
;938:		if (!ctf_neutralflag.areanum)
ADDRGP4 ctf_neutralflag+12
INDIRI4
CNSTI4 0
NEI4 $348
line 939
;939:			return;
ADDRGP4 $330
JUMPV
line 940
;940:	}
line 941
;941:	else {
line 942
;942:		return;
LABELV $348
LABELV $339
LABELV $332
line 945
;943:	}
;944:	//if not addressed to this bot
;945:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
NEI4 $352
ADDRGP4 $330
JUMPV
LABELV $352
line 947
;946:	//
;947:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 949
;948:	//
;949:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 272
INDIRI4
ASGNI4
line 951
;950:	//
;951:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 952
;952:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 953
;953:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 955
;954:	//set the time to send a message to the team mates
;955:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 276
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 276
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 957
;956:	//set the ltg type
;957:	bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 4
ASGNI4
line 959
;958:	//set the team goal time
;959:	bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 961
;960:	// get an alternate route in ctf
;961:	if (G_UsesTeamFlags(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 280
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $354
line 963
;962:		//get an alternative route goal towards the enemy base
;963:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 964
;964:	}
LABELV $354
line 966
;965:	//
;966:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 968
;967:	// remember last ordered task
;968:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 972
;969:#ifdef DEBUG
;970:	BotPrintTeamGoal(bs);
;971:#endif //DEBUG
;972:}
LABELV $330
endproc BotMatch_GetFlag 288 16
export BotMatch_AttackEnemyBase
proc BotMatch_AttackEnemyBase 292 16
line 979
;973:
;974:/*
;975:==================
;976:BotMatch_AttackEnemyBase
;977:==================
;978:*/
;979:void BotMatch_AttackEnemyBase(bot_state_t *bs, bot_match_t *match) {
line 983
;980:	char netname[MAX_MESSAGE_SIZE];
;981:	int client;
;982:
;983:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $357
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 264
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $357
line 984
;984:		BotMatch_GetFlag(bs, match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotMatch_GetFlag
CALLV
pop
line 985
;985:	}
ADDRGP4 $358
JUMPV
LABELV $357
line 986
;986:	else if ((G_UsesTeamFlags(gametype) && G_UsesTheWhiteFlag(gametype)) ||
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 268
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $362
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 272
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $363
LABELV $362
ADDRLP4 276
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 7
EQI4 $363
ADDRLP4 276
INDIRI4
CNSTI4 6
NEI4 $356
LABELV $363
line 987
;987:			gametype == GT_HARVESTER || gametype == GT_OBELISK) {
line 988
;988:		if (!redobelisk.areanum || !blueobelisk.areanum)
ADDRLP4 280
CNSTI4 0
ASGNI4
ADDRGP4 redobelisk+12
INDIRI4
ADDRLP4 280
INDIRI4
EQI4 $368
ADDRGP4 blueobelisk+12
INDIRI4
ADDRLP4 280
INDIRI4
NEI4 $360
LABELV $368
line 989
;989:			return;
ADDRGP4 $356
JUMPV
line 990
;990:	}
line 991
;991:	else {
line 992
;992:		return;
LABELV $360
LABELV $358
line 995
;993:	}
;994:	//if not addressed to this bot
;995:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
NEI4 $369
ADDRGP4 $356
JUMPV
LABELV $369
line 997
;996:	//
;997:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 999
;998:	//
;999:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 284
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 284
INDIRI4
ASGNI4
line 1001
;1000:	//
;1001:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 1002
;1002:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 1003
;1003:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1005
;1004:	//set the time to send a message to the team mates
;1005:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 288
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 288
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1007
;1006:	//set the ltg type
;1007:	bs->ltgtype = LTG_ATTACKENEMYBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 13
ASGNI4
line 1009
;1008:	//set the team goal time
;1009:	bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1010
;1010:	bs->attackaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTF4 0
ASGNF4
line 1012
;1011:	//
;1012:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1014
;1013:	// remember last ordered task
;1014:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 1018
;1015:#ifdef DEBUG
;1016:	BotPrintTeamGoal(bs);
;1017:#endif //DEBUG
;1018:}
LABELV $356
endproc BotMatch_AttackEnemyBase 292 16
export BotMatch_Harvest
proc BotMatch_Harvest 272 16
line 1025
;1019:
;1020:/*
;1021:==================
;1022:BotMatch_Harvest
;1023:==================
;1024:*/
;1025:void BotMatch_Harvest(bot_state_t *bs, bot_match_t *match) {
line 1029
;1026:	char netname[MAX_MESSAGE_SIZE];
;1027:	int client;
;1028:
;1029:	if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $371
line 1030
;1030:		if (!neutralobelisk.areanum || !redobelisk.areanum || !blueobelisk.areanum)
ADDRLP4 260
CNSTI4 0
ASGNI4
ADDRGP4 neutralobelisk+12
INDIRI4
ADDRLP4 260
INDIRI4
EQI4 $380
ADDRGP4 redobelisk+12
INDIRI4
ADDRLP4 260
INDIRI4
EQI4 $380
ADDRGP4 blueobelisk+12
INDIRI4
ADDRLP4 260
INDIRI4
NEI4 $373
LABELV $380
line 1031
;1031:			return;
ADDRGP4 $371
JUMPV
line 1032
;1032:	}
line 1033
;1033:	else {
line 1034
;1034:		return;
LABELV $373
line 1037
;1035:	}
;1036:	//if not addressed to this bot
;1037:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 260
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $381
ADDRGP4 $371
JUMPV
LABELV $381
line 1039
;1038:	//
;1039:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1041
;1040:	//
;1041:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 264
INDIRI4
ASGNI4
line 1043
;1042:	//
;1043:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 1044
;1044:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 1045
;1045:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1047
;1046:	//set the time to send a message to the team mates
;1047:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 268
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 268
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1049
;1048:	//set the ltg type
;1049:	bs->ltgtype = LTG_HARVEST;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 12
ASGNI4
line 1051
;1050:	//set the team goal time
;1051:	bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1052
;1052:	bs->harvestaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTF4 0
ASGNF4
line 1054
;1053:	//
;1054:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1056
;1055:	// remember last ordered task
;1056:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 1060
;1057:#ifdef DEBUG
;1058:	BotPrintTeamGoal(bs);
;1059:#endif //DEBUG
;1060:}
LABELV $371
endproc BotMatch_Harvest 272 16
export BotMatch_RushBase
proc BotMatch_RushBase 284 16
line 1067
;1061:
;1062:/*
;1063:==================
;1064:BotMatch_RushBase
;1065:==================
;1066:*/
;1067:void BotMatch_RushBase(bot_state_t *bs, bot_match_t *match) {
line 1071
;1068:	char netname[MAX_MESSAGE_SIZE];
;1069:	int client;
;1070:
;1071:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $384
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 264
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $384
line 1072
;1072:		if (!ctf_redflag.areanum || !ctf_blueflag.areanum)
ADDRLP4 268
CNSTI4 0
ASGNI4
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 268
INDIRI4
EQI4 $390
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 268
INDIRI4
NEI4 $385
LABELV $390
line 1073
;1073:			return;
ADDRGP4 $383
JUMPV
line 1074
;1074:	}
LABELV $384
line 1075
;1075:	else if (gametype == GT_1FCTF || gametype == GT_HARVESTER) {
ADDRLP4 268
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 5
EQI4 $393
ADDRLP4 268
INDIRI4
CNSTI4 7
NEI4 $383
LABELV $393
line 1076
;1076:		if (!redobelisk.areanum || !blueobelisk.areanum)
ADDRLP4 272
CNSTI4 0
ASGNI4
ADDRGP4 redobelisk+12
INDIRI4
ADDRLP4 272
INDIRI4
EQI4 $398
ADDRGP4 blueobelisk+12
INDIRI4
ADDRLP4 272
INDIRI4
NEI4 $392
LABELV $398
line 1077
;1077:			return;
ADDRGP4 $383
JUMPV
line 1078
;1078:	}
line 1079
;1079:	else {
line 1080
;1080:		return;
LABELV $392
LABELV $385
line 1083
;1081:	}
;1082:	//if not addressed to this bot
;1083:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $399
ADDRGP4 $383
JUMPV
LABELV $399
line 1085
;1084:	//
;1085:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1087
;1086:	//
;1087:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 276
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 276
INDIRI4
ASGNI4
line 1089
;1088:	//
;1089:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 1090
;1090:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 1091
;1091:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1093
;1092:	//set the time to send a message to the team mates
;1093:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 280
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 280
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1095
;1094:	//set the ltg type
;1095:	bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 5
ASGNI4
line 1097
;1096:	//set the team goal time
;1097:	bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1098
;1098:	bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTF4 0
ASGNF4
line 1100
;1099:	//
;1100:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1104
;1101:#ifdef DEBUG
;1102:	BotPrintTeamGoal(bs);
;1103:#endif //DEBUG
;1104:}
LABELV $383
endproc BotMatch_RushBase 284 16
export BotMatch_TaskPreference
proc BotMatch_TaskPreference 320 16
line 1111
;1105:
;1106:/*
;1107:==================
;1108:BotMatch_TaskPreference
;1109:==================
;1110:*/
;1111:void BotMatch_TaskPreference(bot_state_t *bs, bot_match_t *match) {
line 1116
;1112:	char netname[MAX_NETNAME];
;1113:	char teammatename[MAX_MESSAGE_SIZE];
;1114:	int teammate, preference;
;1115:
;1116:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1117
;1117:	if ( !Q_strequal(netname, bs->teamleader)) {
ADDRLP4 260
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 300
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $402
line 1118
;1118:		return;
ADDRGP4 $401
JUMPV
LABELV $402
line 1121
;1119:	}
;1120:
;1121:	trap_BotMatchVariable(match, NETNAME, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1122
;1122:	teammate = ClientFromName(teammatename);
ADDRLP4 4
ARGP4
ADDRLP4 304
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 304
INDIRI4
ASGNI4
line 1123
;1123:	if (teammate < 0) return;
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $404
ADDRGP4 $401
JUMPV
LABELV $404
line 1125
;1124:
;1125:	preference = BotGetTeamMateTaskPreference(bs, teammate);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 308
ADDRGP4 BotGetTeamMateTaskPreference
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 1126
;1126:	switch(match->subtype)
ADDRLP4 312
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $409
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $410
ADDRLP4 312
INDIRI4
CNSTI4 4
EQI4 $411
ADDRGP4 $406
JUMPV
line 1127
;1127:	{
LABELV $409
line 1129
;1128:		case ST_DEFENDER:
;1129:		{
line 1130
;1130:			preference &= ~TEAMTP_ATTACKER;
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 1131
;1131:			preference |= TEAMTP_DEFENDER;
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1132
;1132:			break;
ADDRGP4 $407
JUMPV
LABELV $410
line 1135
;1133:		}
;1134:		case ST_ATTACKER:
;1135:		{
line 1136
;1136:			preference &= ~TEAMTP_DEFENDER;
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 1137
;1137:			preference |= TEAMTP_ATTACKER;
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1138
;1138:			break;
ADDRGP4 $407
JUMPV
LABELV $411
line 1141
;1139:		}
;1140:		case ST_ROAMER:
;1141:		{
line 1142
;1142:			preference &= ~(TEAMTP_ATTACKER|TEAMTP_DEFENDER);
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 -4
BANDI4
ASGNI4
line 1143
;1143:			break;
LABELV $406
LABELV $407
line 1146
;1144:		}
;1145:	}
;1146:	BotSetTeamMateTaskPreference(bs, teammate, preference);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSetTeamMateTaskPreference
CALLV
pop
line 1148
;1147:	//
;1148:	EasyClientName(teammate, teammatename, sizeof(teammatename));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1149
;1149:	BotAI_BotInitialChat(bs, "keepinmind", teammatename, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $412
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1150
;1150:	trap_BotEnterChat(bs->cs, teammate, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1151
;1151:	BotVoiceChatOnly(bs, teammate, VOICECHAT_YES);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $413
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 1152
;1152:	trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1048576
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 1153
;1153:}
LABELV $401
endproc BotMatch_TaskPreference 320 16
export BotMatch_ReturnFlag
proc BotMatch_ReturnFlag 276 16
line 1160
;1154:
;1155:/*
;1156:==================
;1157:BotMatch_ReturnFlag
;1158:==================
;1159:*/
;1160:void BotMatch_ReturnFlag(bot_state_t *bs, bot_match_t *match) {
line 1165
;1161:	char netname[MAX_MESSAGE_SIZE];
;1162:	int client;
;1163:
;1164:	//if not in CTF mode
;1165:	if (G_UsesTeamFlags(gametype))
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $415
line 1166
;1166:		return;
ADDRGP4 $414
JUMPV
LABELV $415
line 1168
;1167:	//if not addressed to this bot
;1168:	if (!BotAddressedToBot(bs, match))
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $417
line 1169
;1169:		return;
ADDRGP4 $414
JUMPV
LABELV $417
line 1171
;1170:	//
;1171:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1173
;1172:	//
;1173:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 268
INDIRI4
ASGNI4
line 1175
;1174:	//
;1175:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 1176
;1176:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 1177
;1177:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1179
;1178:	//set the time to send a message to the team mates
;1179:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 272
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 272
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1181
;1180:	//set the ltg type
;1181:	bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 6
ASGNI4
line 1183
;1182:	//set the team goal time
;1183:	bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 1184
;1184:	bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTF4 0
ASGNF4
line 1186
;1185:	//
;1186:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1190
;1187:#ifdef DEBUG
;1188:	BotPrintTeamGoal(bs);
;1189:#endif //DEBUG
;1190:}
LABELV $414
endproc BotMatch_ReturnFlag 276 16
export BotMatch_JoinSubteam
proc BotMatch_JoinSubteam 528 16
line 1197
;1191:
;1192:/*
;1193:==================
;1194:BotMatch_JoinSubteam
;1195:==================
;1196:*/
;1197:void BotMatch_JoinSubteam(bot_state_t *bs, bot_match_t *match) {
line 1202
;1198:	char teammate[MAX_MESSAGE_SIZE];
;1199:	char netname[MAX_MESSAGE_SIZE];
;1200:	int client;
;1201:
;1202:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 516
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $420
ADDRGP4 $419
JUMPV
LABELV $420
line 1204
;1203:	//if not addressed to this bot
;1204:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 520
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 0
NEI4 $422
ADDRGP4 $419
JUMPV
LABELV $422
line 1206
;1205:	//get the sub team name
;1206:	trap_BotMatchVariable(match, TEAMNAME, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1208
;1207:	//set the sub team name
;1208:	strncpy(bs->subteam, teammate, 32);
ADDRFP4 0
INDIRP4
CNSTI4 6840
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1209
;1209:	bs->subteam[31] = '\0';
ADDRFP4 0
INDIRP4
CNSTI4 6871
ADDP4
CNSTI1 0
ASGNI1
line 1211
;1210:	//
;1211:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1212
;1212:	BotAI_BotInitialChat(bs, "joinedteam", teammate, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $424
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1213
;1213:	client = ClientFromName(netname);
ADDRLP4 256
ARGP4
ADDRLP4 524
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 512
ADDRLP4 524
INDIRI4
ASGNI4
line 1214
;1214:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 512
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1215
;1215:}
LABELV $419
endproc BotMatch_JoinSubteam 528 16
export BotMatch_LeaveSubteam
proc BotMatch_LeaveSubteam 280 16
line 1222
;1216:
;1217:/*
;1218:==================
;1219:BotMatch_LeaveSubteam
;1220:==================
;1221:*/
;1222:void BotMatch_LeaveSubteam(bot_state_t *bs, bot_match_t *match) {
line 1226
;1223:	char netname[MAX_MESSAGE_SIZE];
;1224:	int client;
;1225:
;1226:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $426
ADDRGP4 $425
JUMPV
LABELV $426
line 1228
;1227:	//if not addressed to this bot
;1228:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $428
ADDRGP4 $425
JUMPV
LABELV $428
line 1230
;1229:	//
;1230:	if (strlen(bs->subteam))
ADDRFP4 0
INDIRP4
CNSTI4 6840
ADDP4
ARGP4
ADDRLP4 268
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $430
line 1231
;1231:	{
line 1232
;1232:		BotAI_BotInitialChat(bs, "leftteam", bs->subteam, NULL);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRGP4 $432
ARGP4
ADDRLP4 272
INDIRP4
CNSTI4 6840
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1233
;1233:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1234
;1234:		client = ClientFromName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 276
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 276
INDIRI4
ASGNI4
line 1235
;1235:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1236
;1236:	} //end if
LABELV $430
line 1237
;1237:	strcpy(bs->subteam, "");
ADDRFP4 0
INDIRP4
CNSTI4 6840
ADDP4
ARGP4
ADDRGP4 $433
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1238
;1238:}
LABELV $425
endproc BotMatch_LeaveSubteam 280 16
export BotMatch_WhichTeam
proc BotMatch_WhichTeam 16 16
line 1245
;1239:
;1240:/*
;1241:==================
;1242:BotMatch_LeaveSubteam
;1243:==================
;1244:*/
;1245:void BotMatch_WhichTeam(bot_state_t *bs, bot_match_t *match) {
line 1246
;1246:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $435
ADDRGP4 $434
JUMPV
LABELV $435
line 1248
;1247:	//if not addressed to this bot
;1248:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $437
ADDRGP4 $434
JUMPV
LABELV $437
line 1251
;1249:
;1250:	//
;1251:	if (strlen(bs->subteam)) {
ADDRFP4 0
INDIRP4
CNSTI4 6840
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $439
line 1252
;1252:		BotAI_BotInitialChat(bs, "inteam", bs->subteam, NULL);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $441
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 6840
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1253
;1253:	}
ADDRGP4 $440
JUMPV
LABELV $439
line 1254
;1254:	else {
line 1255
;1255:		BotAI_BotInitialChat(bs, "noteam", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $442
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1256
;1256:	}
LABELV $440
line 1257
;1257:	trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1258
;1258:}
LABELV $434
endproc BotMatch_WhichTeam 16 16
export BotMatch_CheckPoint
proc BotMatch_CheckPoint 572 24
line 1265
;1259:
;1260:/*
;1261:==================
;1262:BotMatch_CheckPoint
;1263:==================
;1264:*/
;1265:void BotMatch_CheckPoint(bot_state_t *bs, bot_match_t *match) {
line 1272
;1266:	int areanum, client;
;1267:	char buf[MAX_MESSAGE_SIZE];
;1268:	char netname[MAX_MESSAGE_SIZE];
;1269:	vec3_t position;
;1270:	bot_waypoint_t *cp;
;1271:
;1272:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 536
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 536
INDIRI4
CNSTI4 0
NEI4 $444
ADDRGP4 $443
JUMPV
LABELV $444
line 1274
;1273:	//
;1274:	trap_BotMatchVariable(match, POSITION, buf, MAX_MESSAGE_SIZE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1275
;1275:	VectorClear(position);
ADDRLP4 540
CNSTF4 0
ASGNF4
ADDRLP4 4+8
ADDRLP4 540
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 540
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 540
INDIRF4
ASGNF4
line 1277
;1276:	//
;1277:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 276
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1278
;1278:	client = ClientFromName(netname);
ADDRLP4 276
ARGP4
ADDRLP4 544
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 532
ADDRLP4 544
INDIRI4
ASGNI4
line 1280
;1279:	//BotGPSToPosition(buf, position);
;1280:	sscanf(buf, "%f %f %f", &position[0], &position[1], &position[2]);
ADDRLP4 16
ARGP4
ADDRGP4 $448
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 4+4
ARGP4
ADDRLP4 4+8
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 1281
;1281:	position[2] += 0.5;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1282
;1282:	areanum = BotPointAreaNum(position);
ADDRLP4 4
ARGP4
ADDRLP4 548
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 272
ADDRLP4 548
INDIRI4
ASGNI4
line 1283
;1283:	if (!areanum) {
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $452
line 1284
;1284:		if (BotAddressedToBot(bs, match)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 552
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $443
line 1285
;1285:			BotAI_BotInitialChat(bs, "checkpoint_invalid", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $456
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1286
;1286:			trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 532
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1287
;1287:		}
line 1288
;1288:		return;
ADDRGP4 $443
JUMPV
LABELV $452
line 1291
;1289:	}
;1290:	//
;1291:	trap_BotMatchVariable(match, NAME, buf, MAX_MESSAGE_SIZE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1293
;1292:	//check if there already exists a checkpoint with this name
;1293:	cp = BotFindWayPoint(bs->checkpoints, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8932
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 552
ADDRGP4 BotFindWayPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 552
INDIRP4
ASGNP4
line 1294
;1294:	if (cp) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $457
line 1295
;1295:		if (cp->next) cp->next->prev = cp->prev;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $459
ADDRLP4 560
CNSTI4 96
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ADDRLP4 560
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 560
INDIRI4
ADDP4
INDIRP4
ASGNP4
LABELV $459
line 1296
;1296:		if (cp->prev) cp->prev->next = cp->next;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $461
ADDRLP4 568
CNSTI4 92
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
ADDRLP4 568
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 568
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $462
JUMPV
LABELV $461
line 1297
;1297:		else bs->checkpoints = cp->next;
ADDRFP4 0
INDIRP4
CNSTI4 8932
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $462
line 1298
;1298:		cp->inuse = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1299
;1299:	}
LABELV $457
line 1301
;1300:	//create a new check point
;1301:	cp = BotCreateWayPoint(buf, position, areanum);
ADDRLP4 16
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRLP4 556
ADDRGP4 BotCreateWayPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 556
INDIRP4
ASGNP4
line 1303
;1302:	//add the check point to the bot's known chech points
;1303:	cp->next = bs->checkpoints;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 8932
ADDP4
INDIRP4
ASGNP4
line 1304
;1304:	if (bs->checkpoints) bs->checkpoints->prev = cp;
ADDRFP4 0
INDIRP4
CNSTI4 8932
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $463
ADDRFP4 0
INDIRP4
CNSTI4 8932
ADDP4
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $463
line 1305
;1305:	bs->checkpoints = cp;
ADDRFP4 0
INDIRP4
CNSTI4 8932
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1307
;1306:	//
;1307:	if (BotAddressedToBot(bs, match)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 560
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 0
EQI4 $465
line 1308
;1308:		Com_sprintf(buf, sizeof(buf), "%1.0f %1.0f %1.0f", cp->goal.origin[0],
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $467
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
line 1312
;1309:													cp->goal.origin[1],
;1310:													cp->goal.origin[2]);
;1311:
;1312:		BotAI_BotInitialChat(bs, "checkpoint_confirm", cp->name, buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $468
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1313
;1313:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 532
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1314
;1314:	}
LABELV $465
line 1315
;1315:}
LABELV $443
endproc BotMatch_CheckPoint 572 24
export BotMatch_FormationSpace
proc BotMatch_FormationSpace 280 16
line 1322
;1316:
;1317:/*
;1318:==================
;1319:BotMatch_FormationSpace
;1320:==================
;1321:*/
;1322:void BotMatch_FormationSpace(bot_state_t *bs, bot_match_t *match) {
line 1326
;1323:	char buf[MAX_MESSAGE_SIZE];
;1324:	float space;
;1325:
;1326:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $470
ADDRGP4 $469
JUMPV
LABELV $470
line 1328
;1327:	//if not addressed to this bot
;1328:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $472
ADDRGP4 $469
JUMPV
LABELV $472
line 1330
;1329:	//
;1330:	trap_BotMatchVariable(match, NUMBER, buf, MAX_MESSAGE_SIZE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1332
;1331:	//if it's the distance in feet
;1332:	if (match->subtype & ST_FEET) space = 0.3048 * 32 * atof(buf);
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $474
ADDRLP4 4
ARGP4
ADDRLP4 268
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1092357823
ADDRLP4 268
INDIRF4
MULF4
ASGNF4
ADDRGP4 $475
JUMPV
LABELV $474
line 1334
;1333:	//else it's in meters
;1334:	else space = 32 * atof(buf);
ADDRLP4 4
ARGP4
ADDRLP4 272
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1107296256
ADDRLP4 272
INDIRF4
MULF4
ASGNF4
LABELV $475
line 1336
;1335:	//check if the formation intervening space is valid
;1336:	if (space < 48 || space > 500) space = 100;
ADDRLP4 0
INDIRF4
CNSTF4 1111490560
LTF4 $478
ADDRLP4 0
INDIRF4
CNSTF4 1140457472
LEF4 $476
LABELV $478
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
LABELV $476
line 1337
;1337:	bs->formation_dist = space;
ADDRFP4 0
INDIRP4
CNSTI4 6872
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
line 1338
;1338:}
LABELV $469
endproc BotMatch_FormationSpace 280 16
export BotMatch_Dismiss
proc BotMatch_Dismiss 272 16
line 1345
;1339:
;1340:/*
;1341:==================
;1342:BotMatch_Dismiss
;1343:==================
;1344:*/
;1345:void BotMatch_Dismiss(bot_state_t *bs, bot_match_t *match) {
line 1349
;1346:	char netname[MAX_MESSAGE_SIZE];
;1347:	int client;
;1348:
;1349:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $480
ADDRGP4 $479
JUMPV
LABELV $480
line 1351
;1350:	//if not addressed to this bot
;1351:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $482
ADDRGP4 $479
JUMPV
LABELV $482
line 1352
;1352:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1353
;1353:	client = ClientFromName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 268
INDIRI4
ASGNI4
line 1355
;1354:	//
;1355:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 1357
;1356:	//
;1357:	bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 1358
;1358:	bs->lead_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 1359
;1359:	bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 1361
;1360:	//
;1361:	BotAI_BotInitialChat(bs, "dismissed", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $484
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1362
;1362:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1363
;1363:}
LABELV $479
endproc BotMatch_Dismiss 272 16
export BotMatch_Suicide
proc BotMatch_Suicide 272 16
line 1370
;1364:
;1365:/*
;1366:==================
;1367:BotMatch_Suicide
;1368:==================
;1369:*/
;1370:void BotMatch_Suicide(bot_state_t *bs, bot_match_t *match) {
line 1374
;1371:	char netname[MAX_MESSAGE_SIZE];
;1372:	int client;
;1373:
;1374:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $486
ADDRGP4 $485
JUMPV
LABELV $486
line 1376
;1375:	//if not addressed to this bot
;1376:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $488
ADDRGP4 $485
JUMPV
LABELV $488
line 1378
;1377:	//
;1378:	trap_EA_Command(bs->client, "kill");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $490
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 1380
;1379:	//
;1380:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1381
;1381:	client = ClientFromName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 268
INDIRI4
ASGNI4
line 1383
;1382:	//
;1383:	BotVoiceChat(bs, client, VOICECHAT_TAUNT);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
ARGI4
ADDRGP4 $491
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1384
;1384:	trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1048576
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 1385
;1385:}
LABELV $485
endproc BotMatch_Suicide 272 16
export BotMatch_StartTeamLeaderShip
proc BotMatch_StartTeamLeaderShip 268 16
line 1392
;1386:
;1387:/*
;1388:==================
;1389:BotMatch_StartTeamLeaderShip
;1390:==================
;1391:*/
;1392:void BotMatch_StartTeamLeaderShip(bot_state_t *bs, bot_match_t *match) {
line 1396
;1393:	int client;
;1394:	char teammate[MAX_MESSAGE_SIZE];
;1395:
;1396:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 260
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $493
ADDRGP4 $492
JUMPV
LABELV $493
line 1398
;1397:	//if chats for him or herself
;1398:	if (match->subtype & ST_I) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $495
line 1400
;1399:		//get the team mate that will be the team leader
;1400:		trap_BotMatchVariable(match, NETNAME, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1401
;1401:		strncpy(bs->teamleader, teammate, sizeof(bs->teamleader));
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1402
;1402:		bs->teamleader[sizeof(bs->teamleader)-1] = '\0';
ADDRFP4 0
INDIRP4
CNSTI4 6756
CNSTU4 35
ADDI4
ADDP4
CNSTI1 0
ASGNI1
line 1403
;1403:	}
ADDRGP4 $496
JUMPV
LABELV $495
line 1405
;1404:	//chats for someone else
;1405:	else {
line 1407
;1406:		//get the team mate that will be the team leader
;1407:		trap_BotMatchVariable(match, TEAMMATE, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1408
;1408:		client = FindClientByName(teammate);
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 264
INDIRI4
ASGNI4
line 1409
;1409:		if (client >= 0) ClientName(client, bs->teamleader, sizeof(bs->teamleader));
ADDRLP4 256
INDIRI4
CNSTI4 0
LTI4 $497
ADDRLP4 256
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
LABELV $497
line 1410
;1410:	}
LABELV $496
line 1411
;1411:}
LABELV $492
endproc BotMatch_StartTeamLeaderShip 268 16
export BotMatch_StopTeamLeaderShip
proc BotMatch_StopTeamLeaderShip 528 16
line 1418
;1412:
;1413:/*
;1414:==================
;1415:BotMatch_StopTeamLeaderShip
;1416:==================
;1417:*/
;1418:void BotMatch_StopTeamLeaderShip(bot_state_t *bs, bot_match_t *match) {
line 1423
;1419:	int client;
;1420:	char teammate[MAX_MESSAGE_SIZE];
;1421:	char netname[MAX_MESSAGE_SIZE];
;1422:
;1423:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 516
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $500
ADDRGP4 $499
JUMPV
LABELV $500
line 1425
;1424:	//get the team mate that stops being the team leader
;1425:	trap_BotMatchVariable(match, TEAMMATE, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1427
;1426:	//if chats for him or herself
;1427:	if (match->subtype & ST_I) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $502
line 1428
;1428:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1429
;1429:		client = FindClientByName(netname);
ADDRLP4 260
ARGP4
ADDRLP4 520
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 520
INDIRI4
ASGNI4
line 1430
;1430:	}
ADDRGP4 $503
JUMPV
LABELV $502
line 1432
;1431:	//chats for someone else
;1432:	else {
line 1433
;1433:		client = FindClientByName(teammate);
ADDRLP4 4
ARGP4
ADDRLP4 520
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 520
INDIRI4
ASGNI4
line 1434
;1434:	} //end else
LABELV $503
line 1435
;1435:	if (client >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $504
line 1436
;1436:		if (Q_strequal(bs->teamleader, ClientName(client, netname, sizeof(netname)))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 520
ADDRGP4 ClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 520
INDIRP4
ARGP4
ADDRLP4 524
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 524
INDIRI4
CNSTI4 0
NEI4 $506
line 1437
;1437:			bs->teamleader[0] = '\0';
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
CNSTI1 0
ASGNI1
line 1438
;1438:			notleader[client] = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 notleader
ADDP4
CNSTI4 1
ASGNI4
line 1439
;1439:		}
LABELV $506
line 1440
;1440:	}
LABELV $504
line 1441
;1441:}
LABELV $499
endproc BotMatch_StopTeamLeaderShip 528 16
export BotMatch_WhoIsTeamLeader
proc BotMatch_WhoIsTeamLeader 264 12
line 1448
;1442:
;1443:/*
;1444:==================
;1445:BotMatch_WhoIsTeamLeader
;1446:==================
;1447:*/
;1448:void BotMatch_WhoIsTeamLeader(bot_state_t *bs, bot_match_t *match) {
line 1451
;1449:	char netname[MAX_MESSAGE_SIZE];
;1450:
;1451:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 256
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
NEI4 $509
ADDRGP4 $508
JUMPV
LABELV $509
line 1453
;1452:
;1453:	ClientName(bs->client, netname, sizeof(netname));
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
line 1455
;1454:	//if this bot IS the team leader
;1455:	if (Q_strequal(netname, bs->teamleader)) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 260
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $511
line 1456
;1456:		trap_EA_SayTeam(bs->client, "I'm the team leader\n");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $513
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 1457
;1457:	}
LABELV $511
line 1458
;1458:}
LABELV $508
endproc BotMatch_WhoIsTeamLeader 264 12
export BotMatch_WhatAreYouDoing
proc BotMatch_WhatAreYouDoing 532 16
line 1465
;1459:
;1460:/*
;1461:==================
;1462:BotMatch_WhatAreYouDoing
;1463:==================
;1464:*/
;1465:void BotMatch_WhatAreYouDoing(bot_state_t *bs, bot_match_t *match) {
line 1471
;1466:	char netname[MAX_MESSAGE_SIZE];
;1467:	char goalname[MAX_MESSAGE_SIZE];
;1468:	int client;
;1469:
;1470:	//if not addressed to this bot
;1471:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 516
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $515
ADDRGP4 $514
JUMPV
LABELV $515
line 1473
;1472:	//
;1473:	switch(bs->ltgtype) {
ADDRLP4 520
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 1
LTI4 $517
ADDRLP4 520
INDIRI4
CNSTI4 17
GTI4 $517
ADDRLP4 520
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $549-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $549
address $520
address $522
address $524
address $534
address $536
address $538
address $530
address $530
address $532
address $526
address $528
address $542
address $540
address $517
address $517
address $544
address $546
code
LABELV $520
line 1475
;1474:		case LTG_TEAMHELP:
;1475:		{
line 1476
;1476:			EasyClientName(bs->teammate, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1477
;1477:			BotAI_BotInitialChat(bs, "helping", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $521
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1478
;1478:			break;
ADDRGP4 $518
JUMPV
LABELV $522
line 1481
;1479:		}
;1480:		case LTG_TEAMACCOMPANY:
;1481:		{
line 1482
;1482:			EasyClientName(bs->teammate, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1483
;1483:			BotAI_BotInitialChat(bs, "accompanying", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $523
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1484
;1484:			break;
ADDRGP4 $518
JUMPV
LABELV $524
line 1487
;1485:		}
;1486:		case LTG_DEFENDKEYAREA:
;1487:		{
line 1488
;1488:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 1489
;1489:			BotAI_BotInitialChat(bs, "defending", goalname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $525
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1490
;1490:			break;
ADDRGP4 $518
JUMPV
LABELV $526
line 1493
;1491:		}
;1492:		case LTG_GETITEM:
;1493:		{
line 1494
;1494:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 1495
;1495:			BotAI_BotInitialChat(bs, "gettingitem", goalname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $527
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1496
;1496:			break;
ADDRGP4 $518
JUMPV
LABELV $528
line 1499
;1497:		}
;1498:		case LTG_KILL:
;1499:		{
line 1500
;1500:			ClientName(bs->teamgoal.entitynum, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 6520
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
line 1501
;1501:			BotAI_BotInitialChat(bs, "killing", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $529
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1502
;1502:			break;
ADDRGP4 $518
JUMPV
LABELV $530
line 1506
;1503:		}
;1504:		case LTG_CAMP:
;1505:		case LTG_CAMPORDER:
;1506:		{
line 1507
;1507:			BotAI_BotInitialChat(bs, "camping", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $531
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1508
;1508:			break;
ADDRGP4 $518
JUMPV
LABELV $532
line 1511
;1509:		}
;1510:		case LTG_PATROL:
;1511:		{
line 1512
;1512:			BotAI_BotInitialChat(bs, "patrolling", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $533
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1513
;1513:			break;
ADDRGP4 $518
JUMPV
LABELV $534
line 1516
;1514:		}
;1515:		case LTG_GETFLAG:
;1516:		{
line 1517
;1517:			BotAI_BotInitialChat(bs, "capturingflag", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $535
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1518
;1518:			break;
ADDRGP4 $518
JUMPV
LABELV $536
line 1521
;1519:		}
;1520:		case LTG_RUSHBASE:
;1521:		{
line 1522
;1522:			BotAI_BotInitialChat(bs, "rushingbase", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $537
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1523
;1523:			break;
ADDRGP4 $518
JUMPV
LABELV $538
line 1526
;1524:		}
;1525:		case LTG_RETURNFLAG:
;1526:		{
line 1527
;1527:			BotAI_BotInitialChat(bs, "returningflag", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $539
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1528
;1528:			break;
ADDRGP4 $518
JUMPV
LABELV $540
line 1531
;1529:		}
;1530:		case LTG_ATTACKENEMYBASE:
;1531:		{
line 1532
;1532:			BotAI_BotInitialChat(bs, "attackingenemybase", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $541
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1533
;1533:			break;
ADDRGP4 $518
JUMPV
LABELV $542
line 1536
;1534:		}
;1535:		case LTG_HARVEST:
;1536:		{
line 1537
;1537:			BotAI_BotInitialChat(bs, "harvesting", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $543
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1538
;1538:			break;
ADDRGP4 $518
JUMPV
LABELV $544
line 1542
;1539:		}
;1540://#endif
;1541:		case LTG_POINTA:
;1542:		{
line 1543
;1543:			BotAI_BotInitialChat(bs, "dd_pointa", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $545
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1544
;1544:			break;
ADDRGP4 $518
JUMPV
LABELV $546
line 1547
;1545:		}
;1546:		case LTG_POINTB:
;1547:		{
line 1548
;1548:			BotAI_BotInitialChat(bs, "dd_pointb", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $547
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1549
;1549:			break;
ADDRGP4 $518
JUMPV
LABELV $517
line 1552
;1550:		}
;1551:		default:
;1552:		{
line 1553
;1553:			BotAI_BotInitialChat(bs, "roaming", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $548
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1554
;1554:			break;
LABELV $518
line 1558
;1555:		}
;1556:	}
;1557:	//chat what the bot is doing
;1558:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1559
;1559:	client = ClientFromName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 528
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 528
INDIRI4
ASGNI4
line 1560
;1560:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1561
;1561:}
LABELV $514
endproc BotMatch_WhatAreYouDoing 532 16
export BotMatch_WhatIsMyCommand
proc BotMatch_WhatIsMyCommand 40 12
line 1568
;1562:
;1563:/*
;1564:==================
;1565:BotMatch_WhatIsMyCommand
;1566:==================
;1567:*/
;1568:void BotMatch_WhatIsMyCommand(bot_state_t *bs, bot_match_t *match) {
line 1571
;1569:	char netname[MAX_NETNAME];
;1570:
;1571:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1572
;1572:	if ( !Q_strequal(netname, bs->teamleader) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $552
line 1573
;1573:		return;
ADDRGP4 $551
JUMPV
LABELV $552
line 1575
;1574:	}
;1575:	bs->forceorders = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6828
ADDP4
CNSTI4 1
ASGNI4
line 1576
;1576:}
LABELV $551
endproc BotMatch_WhatIsMyCommand 40 12
export BotNearestVisibleItem
proc BotNearestVisibleItem 252 28
line 1583
;1577:
;1578:/*
;1579:==================
;1580:BotNearestVisibleItem
;1581:==================
;1582:*/
;1583:float BotNearestVisibleItem(bot_state_t *bs, char *itemname, bot_goal_t *goal) {
line 1591
;1584:	int i;
;1585:	char name[64];
;1586:	bot_goal_t tmpgoal;
;1587:	float dist, bestdist;
;1588:	vec3_t dir;
;1589:	bsp_trace_t trace;
;1590:
;1591:	bestdist = 999999;
ADDRLP4 140
CNSTF4 1232348144
ASGNF4
line 1592
;1592:	i = -1;
ADDRLP4 68
CNSTI4 -1
ASGNI4
LABELV $555
line 1593
;1593:	do {
line 1594
;1594:		i = trap_BotGetLevelItemGoal(i, itemname, &tmpgoal);
ADDRLP4 68
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 228
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 228
INDIRI4
ASGNI4
line 1595
;1595:		trap_BotGoalName(tmpgoal.number, name, sizeof(name));
ADDRLP4 0+44
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 1596
;1596:		if ( !Q_strequal(itemname, name) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 232
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
EQI4 $559
line 1597
;1597:			continue;
ADDRGP4 $556
JUMPV
LABELV $559
line 1599
;1598:		}
;1599:		VectorSubtract(tmpgoal.origin, bs->origin, dir);
ADDRLP4 236
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 0
INDIRF4
ADDRLP4 236
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 236
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1600
;1600:		dist = VectorLength(dir);
ADDRLP4 56
ARGP4
ADDRLP4 240
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 136
ADDRLP4 240
INDIRF4
ASGNF4
line 1601
;1601:		if (dist < bestdist) {
ADDRLP4 136
INDIRF4
ADDRLP4 140
INDIRF4
GEF4 $565
line 1603
;1602:			//trace from start to end
;1603:			BotAI_Trace(&trace, bs->eye, NULL, NULL, tmpgoal.origin, bs->client, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
ADDRLP4 144
ARGP4
ADDRLP4 244
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 244
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 248
CNSTP4 0
ASGNP4
ADDRLP4 248
INDIRP4
ARGP4
ADDRLP4 248
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 244
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 1604
;1604:			if (trace.fraction >= 1.0) {
ADDRLP4 144+8
INDIRF4
CNSTF4 1065353216
LTF4 $567
line 1605
;1605:				bestdist = dist;
ADDRLP4 140
ADDRLP4 136
INDIRF4
ASGNF4
line 1606
;1606:				memcpy(goal, &tmpgoal, sizeof(bot_goal_t));
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1607
;1607:			}
LABELV $567
line 1608
;1608:		}
LABELV $565
line 1609
;1609:	} while(i > 0);
LABELV $556
ADDRLP4 68
INDIRI4
CNSTI4 0
GTI4 $555
line 1610
;1610:	return bestdist;
ADDRLP4 140
INDIRF4
RETF4
LABELV $554
endproc BotNearestVisibleItem 252 28
lit
align 4
LABELV $571
address $572
address $573
address $574
address $575
address $576
address $577
address $578
address $579
address $580
address $581
address $582
address $583
address $584
address $585
address $586
address $587
address $588
address $589
address $590
address $591
address $592
address $593
address $594
address $595
address $596
address $597
address $598
address $599
byte 4 0
export BotMatch_WhereAreYou
code
proc BotMatch_WhereAreYou 496 20
line 1618
;1611:}
;1612:
;1613:/*
;1614:==================
;1615:BotMatch_WhereAreYou
;1616:==================
;1617:*/
;1618:void BotMatch_WhereAreYou(bot_state_t *bs, bot_match_t *match) {
line 1623
;1619:	float dist, bestdist;
;1620:	int i, bestitem, redtt, bluett, client;
;1621:	bot_goal_t goal;
;1622:	char netname[MAX_MESSAGE_SIZE];
;1623:	char *nearbyitems[] = {
ADDRLP4 8
ADDRGP4 $571
INDIRB
ASGNB 116
line 1655
;1624:		"Shotgun",
;1625:		"Grenade Launcher",
;1626:		"Rocket Launcher",
;1627:		"Plasmagun",
;1628:		"Railgun",
;1629:		"Lightning Gun",
;1630:		"BFG10K",
;1631:		"Quad Damage",
;1632:		"Regeneration",
;1633:		"Battle Suit",
;1634:		"Speed",
;1635:		"Invisibility",
;1636:		"Flight",
;1637:		"Armor",
;1638:		"Heavy Armor",
;1639:		"Red Flag",
;1640:		"Blue Flag",
;1641:		"Nailgun",
;1642:		"Prox Launcher",
;1643:		"Chaingun",
;1644:		"Scout",
;1645:		"Guard",
;1646:		"Doubler",
;1647:		"Ammo Regen",
;1648:		"Neutral Flag",
;1649:		"Red Obelisk",
;1650:		"Blue Obelisk",
;1651:		"Neutral Obelisk",
;1652:		NULL
;1653:	};
;1654:	//
;1655:	if (!G_IsATeamGametype(gametype))
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 456
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 456
INDIRI4
CNSTI4 0
NEI4 $600
line 1656
;1656:		return;
ADDRGP4 $570
JUMPV
LABELV $600
line 1659
;1657:
;1658:	//if not addressed to this bot
;1659:	if (!BotAddressedToBot(bs, match))
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 460
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
NEI4 $602
line 1660
;1660:		return;
ADDRGP4 $570
JUMPV
LABELV $602
line 1662
;1661:
;1662:	bestitem = -1;
ADDRLP4 184
CNSTI4 -1
ASGNI4
line 1663
;1663:	bestdist = 999999;
ADDRLP4 124
CNSTF4 1232348144
ASGNF4
line 1664
;1664:	for (i = 0; nearbyitems[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $607
JUMPV
LABELV $604
line 1665
;1665:		dist = BotNearestVisibleItem(bs, nearbyitems[i], &goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 128
ARGP4
ADDRLP4 464
ADDRGP4 BotNearestVisibleItem
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 464
INDIRF4
ASGNF4
line 1666
;1666:		if (dist < bestdist) {
ADDRLP4 4
INDIRF4
ADDRLP4 124
INDIRF4
GEF4 $608
line 1667
;1667:			bestdist = dist;
ADDRLP4 124
ADDRLP4 4
INDIRF4
ASGNF4
line 1668
;1668:			bestitem = i;
ADDRLP4 184
ADDRLP4 0
INDIRI4
ASGNI4
line 1669
;1669:		}
LABELV $608
line 1670
;1670:	}
LABELV $605
line 1664
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $607
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $604
line 1671
;1671:	if (bestitem != -1) {
ADDRLP4 184
INDIRI4
CNSTI4 -1
EQI4 $610
line 1672
;1672:		if (G_UsesTeamFlags(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 464
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 464
INDIRI4
CNSTI4 0
EQI4 $612
line 1673
;1673:			redtt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, ctf_redflag.areanum, TFL_DEFAULT);
ADDRLP4 468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 468
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 468
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRGP4 ctf_redflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 472
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 444
ADDRLP4 472
INDIRI4
ASGNI4
line 1674
;1674:			bluett = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, ctf_blueflag.areanum, TFL_DEFAULT);
ADDRLP4 476
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 476
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 476
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRGP4 ctf_blueflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 480
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 448
ADDRLP4 480
INDIRI4
ASGNI4
line 1675
;1675:			if (redtt < (redtt + bluett) * 0.4) {
ADDRLP4 484
ADDRLP4 444
INDIRI4
ASGNI4
ADDRLP4 484
INDIRI4
CVIF4 4
CNSTF4 1053609165
ADDRLP4 484
INDIRI4
ADDRLP4 448
INDIRI4
ADDI4
CVIF4 4
MULF4
GEF4 $616
line 1676
;1676:				BotAI_BotInitialChat(bs, "teamlocation", nearbyitems[bestitem], "red", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $618
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1677
;1677:			}
ADDRGP4 $613
JUMPV
LABELV $616
line 1678
;1678:			else if (bluett < (redtt + bluett) * 0.4) {
ADDRLP4 488
ADDRLP4 448
INDIRI4
ASGNI4
ADDRLP4 488
INDIRI4
CVIF4 4
CNSTF4 1053609165
ADDRLP4 444
INDIRI4
ADDRLP4 488
INDIRI4
ADDI4
CVIF4 4
MULF4
GEF4 $620
line 1679
;1679:				BotAI_BotInitialChat(bs, "teamlocation", nearbyitems[bestitem], "blue", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $618
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 $622
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1680
;1680:			}
ADDRGP4 $613
JUMPV
LABELV $620
line 1681
;1681:			else {
line 1682
;1682:				BotAI_BotInitialChat(bs, "location", nearbyitems[bestitem], NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $623
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1683
;1683:			}
line 1684
;1684:		}
ADDRGP4 $613
JUMPV
LABELV $612
line 1685
;1685:		else if (gametype == GT_HARVESTER || gametype == GT_OBELISK) {
ADDRLP4 468
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 468
INDIRI4
CNSTI4 7
EQI4 $626
ADDRLP4 468
INDIRI4
CNSTI4 6
NEI4 $624
LABELV $626
line 1686
;1686:			redtt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, redobelisk.areanum, TFL_DEFAULT);
ADDRLP4 472
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 472
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 472
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRGP4 redobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 476
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 444
ADDRLP4 476
INDIRI4
ASGNI4
line 1687
;1687:			bluett = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, blueobelisk.areanum, TFL_DEFAULT);
ADDRLP4 480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 480
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 480
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRGP4 blueobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 484
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 448
ADDRLP4 484
INDIRI4
ASGNI4
line 1688
;1688:			if (redtt < (redtt + bluett) * 0.4) {
ADDRLP4 488
ADDRLP4 444
INDIRI4
ASGNI4
ADDRLP4 488
INDIRI4
CVIF4 4
CNSTF4 1053609165
ADDRLP4 488
INDIRI4
ADDRLP4 448
INDIRI4
ADDI4
CVIF4 4
MULF4
GEF4 $629
line 1689
;1689:				BotAI_BotInitialChat(bs, "teamlocation", nearbyitems[bestitem], "red", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $618
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1690
;1690:			}
ADDRGP4 $625
JUMPV
LABELV $629
line 1691
;1691:			else if (bluett < (redtt + bluett) * 0.4) {
ADDRLP4 492
ADDRLP4 448
INDIRI4
ASGNI4
ADDRLP4 492
INDIRI4
CVIF4 4
CNSTF4 1053609165
ADDRLP4 444
INDIRI4
ADDRLP4 492
INDIRI4
ADDI4
CVIF4 4
MULF4
GEF4 $631
line 1692
;1692:				BotAI_BotInitialChat(bs, "teamlocation", nearbyitems[bestitem], "blue", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $618
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 $622
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1693
;1693:			}
ADDRGP4 $625
JUMPV
LABELV $631
line 1694
;1694:			else {
line 1695
;1695:				BotAI_BotInitialChat(bs, "location", nearbyitems[bestitem], NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $623
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1696
;1696:			}
line 1697
;1697:		}
ADDRGP4 $625
JUMPV
LABELV $624
line 1698
;1698:		else {
line 1699
;1699:			BotAI_BotInitialChat(bs, "location", nearbyitems[bestitem], NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $623
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1700
;1700:		}
LABELV $625
LABELV $613
line 1701
;1701:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 188
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1702
;1702:		client = ClientFromName(netname);
ADDRLP4 188
ARGP4
ADDRLP4 472
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 452
ADDRLP4 472
INDIRI4
ASGNI4
line 1703
;1703:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 452
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1704
;1704:	}
LABELV $610
line 1705
;1705:}
LABELV $570
endproc BotMatch_WhereAreYou 496 20
export BotMatch_LeadTheWay
proc BotMatch_LeadTheWay 680 16
line 1712
;1706:
;1707:/*
;1708:==================
;1709:BotMatch_LeadTheWay
;1710:==================
;1711:*/
;1712:void BotMatch_LeadTheWay(bot_state_t *bs, bot_match_t *match) {
line 1717
;1713:	aas_entityinfo_t entinfo;
;1714:	char netname[MAX_MESSAGE_SIZE], teammate[MAX_MESSAGE_SIZE];
;1715:	int client, areanum, other;
;1716:
;1717:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 664
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
NEI4 $634
ADDRGP4 $633
JUMPV
LABELV $634
line 1719
;1718:	//if not addressed to this bot
;1719:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 668
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 668
INDIRI4
CNSTI4 0
NEI4 $636
ADDRGP4 $633
JUMPV
LABELV $636
line 1721
;1720:	//if someone asks for someone else
;1721:	if (match->subtype & ST_SOMEONE) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $638
line 1723
;1722:		//get the team mate name
;1723:		trap_BotMatchVariable(match, TEAMMATE, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 400
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1724
;1724:		client = FindClientByName(teammate);
ADDRLP4 400
ARGP4
ADDRLP4 672
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 672
INDIRI4
ASGNI4
line 1726
;1725:		//if this is the bot self
;1726:		if (client == bs->client) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $640
line 1727
;1727:			other = qfalse;
ADDRLP4 656
CNSTI4 0
ASGNI4
line 1728
;1728:		}
ADDRGP4 $639
JUMPV
LABELV $640
line 1729
;1729:		else if (!BotSameTeam(bs, client)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 676
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 676
INDIRI4
CNSTI4 0
NEI4 $642
line 1731
;1730:			//FIXME: say "I don't help the enemy"
;1731:			return;
ADDRGP4 $633
JUMPV
LABELV $642
line 1733
;1732:		}
;1733:		else {
line 1734
;1734:			other = qtrue;
ADDRLP4 656
CNSTI4 1
ASGNI4
line 1735
;1735:		}
line 1736
;1736:	}
ADDRGP4 $639
JUMPV
LABELV $638
line 1737
;1737:	else {
line 1739
;1738:		//get the netname
;1739:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 144
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1740
;1740:		client = ClientFromName(netname);
ADDRLP4 144
ARGP4
ADDRLP4 672
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 672
INDIRI4
ASGNI4
line 1741
;1741:		other = qfalse;
ADDRLP4 656
CNSTI4 0
ASGNI4
line 1742
;1742:	}
LABELV $639
line 1744
;1743:	//if the bot doesn't know who to help (FindClientByName returned -1)
;1744:	if (client < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $644
line 1745
;1745:		BotAI_BotInitialChat(bs, "whois", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $239
ARGP4
ADDRLP4 144
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1746
;1746:		trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 672
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1747
;1747:		return;
ADDRGP4 $633
JUMPV
LABELV $644
line 1750
;1748:	}
;1749:	//
;1750:	bs->lead_teamgoal.entitynum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6724
ADDP4
CNSTI4 -1
ASGNI4
line 1751
;1751:	BotEntityInfo(client, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1753
;1752:	//if info is valid (in PVS)
;1753:	if (entinfo.valid) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $646
line 1754
;1754:		areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 4+24
ARGP4
ADDRLP4 672
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 660
ADDRLP4 672
INDIRI4
ASGNI4
line 1755
;1755:		if (areanum) { // && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 660
INDIRI4
CNSTI4 0
EQI4 $649
line 1756
;1756:			bs->lead_teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 6724
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1757
;1757:			bs->lead_teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6696
ADDP4
ADDRLP4 660
INDIRI4
ASGNI4
line 1758
;1758:			VectorCopy(entinfo.origin, bs->lead_teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6684
ADDP4
ADDRLP4 4+24
INDIRB
ASGNB 12
line 1759
;1759:			VectorSet(bs->lead_teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 6700
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6704
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6708
ADDP4
CNSTF4 3238002688
ASGNF4
line 1760
;1760:			VectorSet(bs->lead_teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 6712
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6716
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6720
ADDP4
CNSTF4 1090519040
ASGNF4
line 1761
;1761:		}
LABELV $649
line 1762
;1762:	}
LABELV $646
line 1764
;1763:
;1764:	if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
CNSTI4 0
GEI4 $652
line 1765
;1765:		if (other) BotAI_BotInitialChat(bs, "whereis", teammate, NULL);
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $654
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $258
ARGP4
ADDRLP4 400
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $655
JUMPV
LABELV $654
line 1766
;1766:		else BotAI_BotInitialChat(bs, "whereareyou", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $259
ARGP4
ADDRLP4 144
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
LABELV $655
line 1767
;1767:		trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 672
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1768
;1768:		return;
ADDRGP4 $633
JUMPV
LABELV $652
line 1770
;1769:	}
;1770:	bs->lead_teammate = client;
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1771
;1771:	bs->lead_time = FloatTime() + TEAM_LEAD_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1772
;1772:	bs->leadvisible_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
CNSTF4 0
ASGNF4
line 1773
;1773:	bs->leadmessage_time = -(FloatTime() + 2 * random());
ADDRLP4 672
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 672
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
NEGF4
ASGNF4
line 1774
;1774:}
LABELV $633
endproc BotMatch_LeadTheWay 680 16
export BotMatch_Kill
proc BotMatch_Kill 532 16
line 1781
;1775:
;1776:/*
;1777:==================
;1778:BotMatch_Kill
;1779:==================
;1780:*/
;1781:void BotMatch_Kill(bot_state_t *bs, bot_match_t *match) {
line 1786
;1782:	char enemy[MAX_MESSAGE_SIZE];
;1783:	char netname[MAX_MESSAGE_SIZE];
;1784:	int client;
;1785:
;1786:	if (!G_IsATeamGametype(gametype)) return;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 516
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $657
ADDRGP4 $656
JUMPV
LABELV $657
line 1788
;1787:	//if not addressed to this bot
;1788:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 520
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 0
NEI4 $659
ADDRGP4 $656
JUMPV
LABELV $659
line 1790
;1789:
;1790:	trap_BotMatchVariable(match, ENEMY, enemy, sizeof(enemy));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1792
;1791:	//
;1792:	client = FindEnemyByName(bs, enemy);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 524
ADDRGP4 FindEnemyByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 524
INDIRI4
ASGNI4
line 1793
;1793:	if (client < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $661
line 1794
;1794:		BotAI_BotInitialChat(bs, "whois", enemy, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $239
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1795
;1795:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1796
;1796:		client = ClientFromName(netname);
ADDRLP4 260
ARGP4
ADDRLP4 528
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 528
INDIRI4
ASGNI4
line 1797
;1797:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1798
;1798:		return;
ADDRGP4 $656
JUMPV
LABELV $661
line 1800
;1799:	}
;1800:	bs->teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1802
;1801:	//set the time to send a message to the team mates
;1802:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 528
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDRLP4 528
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1804
;1803:	//set the ltg type
;1804:	bs->ltgtype = LTG_KILL;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 11
ASGNI4
line 1806
;1805:	//set the team goal time
;1806:	bs->teamgoal_time = FloatTime() + TEAM_KILL_SOMEONE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 1808
;1807:	//
;1808:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1812
;1809:#ifdef DEBUG
;1810:	BotPrintTeamGoal(bs);
;1811:#endif //DEBUG
;1812:}
LABELV $656
endproc BotMatch_Kill 532 16
export BotMatch_CTF
proc BotMatch_CTF 184 16
line 1819
;1813:
;1814:/*
;1815:==================
;1816:BotMatch_CTF
;1817:==================
;1818:*/
;1819:void BotMatch_CTF(bot_state_t *bs, bot_match_t *match) {
line 1823
;1820:
;1821:	char flag[128], netname[MAX_NETNAME];
;1822:
;1823:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 164
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $664
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 168
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $664
line 1824
;1824:		trap_BotMatchVariable(match, FLAG, flag, sizeof(flag));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1825
;1825:		if (match->subtype & ST_GOTFLAG) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $666
line 1826
;1826:			if (Q_strequal(flag, "red")) {
ADDRLP4 0
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $668
line 1827
;1827:				bs->redflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6812
ADDP4
CNSTI4 1
ASGNI4
line 1828
;1828:				if (BotTeam(bs) == TEAM_BLUE) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 2
NEI4 $669
line 1829
;1829:					trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 128
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1830
;1830:					bs->flagcarrier = ClientFromName(netname);
ADDRLP4 128
ARGP4
ADDRLP4 180
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
ADDRLP4 180
INDIRI4
ASGNI4
line 1831
;1831:				}
line 1832
;1832:			}
ADDRGP4 $669
JUMPV
LABELV $668
line 1833
;1833:			else {
line 1834
;1834:				bs->blueflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6816
ADDP4
CNSTI4 1
ASGNI4
line 1835
;1835:				if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 1
NEI4 $672
line 1836
;1836:					trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 128
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1837
;1837:					bs->flagcarrier = ClientFromName(netname);
ADDRLP4 128
ARGP4
ADDRLP4 180
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
ADDRLP4 180
INDIRI4
ASGNI4
line 1838
;1838:				}
LABELV $672
line 1839
;1839:			}
LABELV $669
line 1840
;1840:			bs->flagstatuschanged = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 1841
;1841:			bs->lastflagcapture_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6804
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1842
;1842:		}
ADDRGP4 $665
JUMPV
LABELV $666
line 1843
;1843:		else if (match->subtype & ST_CAPTUREDFLAG) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $674
line 1844
;1844:			bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6812
ADDP4
CNSTI4 0
ASGNI4
line 1845
;1845:			bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6816
ADDP4
CNSTI4 0
ASGNI4
line 1846
;1846:			bs->flagcarrier = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
CNSTI4 0
ASGNI4
line 1847
;1847:			bs->flagstatuschanged = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 1848
;1848:		}
ADDRGP4 $665
JUMPV
LABELV $674
line 1849
;1849:		else if (match->subtype & ST_RETURNEDFLAG) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $665
line 1850
;1850:			if (Q_strequal(flag, "red")) bs->redflagstatus = 0;
ADDRLP4 0
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $678
ADDRFP4 0
INDIRP4
CNSTI4 6812
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $679
JUMPV
LABELV $678
line 1851
;1851:			else bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6816
ADDP4
CNSTI4 0
ASGNI4
LABELV $679
line 1852
;1852:			bs->flagstatuschanged = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 1853
;1853:		}
line 1854
;1854:	}
ADDRGP4 $665
JUMPV
LABELV $664
line 1855
;1855:	else if (G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $680
line 1856
;1856:		if (match->subtype & ST_1FCTFGOTFLAG) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 65535
BANDI4
CNSTI4 0
EQI4 $682
line 1857
;1857:			trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 128
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1858
;1858:			bs->flagcarrier = ClientFromName(netname);
ADDRLP4 128
ARGP4
ADDRLP4 176
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
ADDRLP4 176
INDIRI4
ASGNI4
line 1859
;1859:		}
LABELV $682
line 1860
;1860:	}
LABELV $680
LABELV $665
line 1861
;1861:}
LABELV $663
endproc BotMatch_CTF 184 16
export BotMatch_EnterGame
proc BotMatch_EnterGame 44 16
line 1863
;1862:
;1863:void BotMatch_EnterGame(bot_state_t *bs, bot_match_t *match) {
line 1867
;1864:	int client;
;1865:	char netname[MAX_NETNAME];
;1866:
;1867:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1868
;1868:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
line 1869
;1869:	if (client >= 0) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $685
line 1870
;1870:		notleader[client] = qfalse;
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 notleader
ADDP4
CNSTI4 0
ASGNI4
line 1871
;1871:	}
LABELV $685
line 1875
;1872:	//NOTE: eliza chats will catch this
;1873:	//Com_sprintf(buf, sizeof(buf), "heya %s", netname);
;1874:	//EA_Say(bs->client, buf);
;1875:}
LABELV $684
endproc BotMatch_EnterGame 44 16
export BotMatch_NewLeader
proc BotMatch_NewLeader 48 16
line 1877
;1876:
;1877:void BotMatch_NewLeader(bot_state_t *bs, bot_match_t *match) {
line 1881
;1878:	int client;
;1879:	char netname[MAX_NETNAME];
;1880:
;1881:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1882
;1882:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
line 1883
;1883:	if (!BotSameTeam(bs, client))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $688
line 1884
;1884:		return;
ADDRGP4 $687
JUMPV
LABELV $688
line 1885
;1885:	Q_strncpyz(bs->teamleader, netname, sizeof(bs->teamleader));
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1886
;1886:}
LABELV $687
endproc BotMatch_NewLeader 48 16
export BotMatchMessage
proc BotMatchMessage 344 12
line 1893
;1887:
;1888:/*
;1889:==================
;1890:BotMatchMessage
;1891:==================
;1892:*/
;1893:int BotMatchMessage(bot_state_t *bs, char *message) {
line 1896
;1894:	bot_match_t match;
;1895:
;1896:	match.type = 0;
ADDRLP4 0+256
CNSTI4 0
ASGNI4
line 1898
;1897:	//if it is an unknown message
;1898:	if (!trap_BotFindMatch(message, &match, MTCONTEXT_MISC
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 774
ARGU4
ADDRLP4 328
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
NEI4 $692
line 1901
;1899:	|MTCONTEXT_INITIALTEAMCHAT
;1900:	|MTCONTEXT_CTF
;1901:	|MTCONTEXT_DD)) {
line 1902
;1902:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $690
JUMPV
LABELV $692
line 1905
;1903:	}
;1904:	//react to the found message
;1905:	switch(match.type)
ADDRLP4 332
ADDRLP4 0+256
INDIRI4
ASGNI4
ADDRLP4 332
INDIRI4
CNSTI4 90
EQI4 $731
ADDRLP4 336
CNSTI4 91
ASGNI4
ADDRLP4 332
INDIRI4
ADDRLP4 336
INDIRI4
EQI4 $732
ADDRLP4 332
INDIRI4
ADDRLP4 336
INDIRI4
GTI4 $735
LABELV $734
ADDRLP4 340
ADDRLP4 0+256
INDIRI4
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 1
LTI4 $694
ADDRLP4 340
INDIRI4
CNSTI4 33
GTI4 $694
ADDRLP4 340
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $736-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $736
address $728
address $727
address $697
address $697
address $698
address $704
address $701
address $719
address $720
address $721
address $695
address $722
address $709
address $710
address $713
address $715
address $716
address $695
address $718
address $699
address $712
address $700
address $725
address $708
address $726
address $724
address $705
address $723
address $711
address $706
address $702
address $703
address $730
code
LABELV $735
ADDRLP4 0+256
INDIRI4
CNSTI4 300
EQI4 $707
ADDRGP4 $694
JUMPV
line 1906
;1906:	{
LABELV $697
line 1909
;1907:		case MSG_HELP:					//someone calling for help
;1908:		case MSG_ACCOMPANY:				//someone calling for company
;1909:		{
line 1910
;1910:			BotMatch_HelpAccompany(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_HelpAccompany
CALLV
pop
line 1911
;1911:			break;
ADDRGP4 $695
JUMPV
LABELV $698
line 1914
;1912:		}
;1913:		case MSG_DEFENDKEYAREA:			//teamplay defend a key area
;1914:		{
line 1915
;1915:			BotMatch_DefendKeyArea(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_DefendKeyArea
CALLV
pop
line 1916
;1916:			break;
ADDRGP4 $695
JUMPV
LABELV $699
line 1919
;1917:		}
;1918:		case MSG_CAMP:					//camp somewhere
;1919:		{
line 1920
;1920:			BotMatch_Camp(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Camp
CALLV
pop
line 1921
;1921:			break;
ADDRGP4 $695
JUMPV
LABELV $700
line 1924
;1922:		}
;1923:		case MSG_PATROL:				//patrol between several key areas
;1924:		{
line 1925
;1925:			BotMatch_Patrol(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Patrol
CALLV
pop
line 1926
;1926:			break;
ADDRGP4 $695
JUMPV
LABELV $701
line 1930
;1927:		}
;1928:		//CTF & 1FCTF
;1929:		case MSG_GETFLAG:				//ctf get the enemy flag
;1930:		{
line 1931
;1931:			BotMatch_GetFlag(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_GetFlag
CALLV
pop
line 1932
;1932:			break;
ADDRGP4 $695
JUMPV
LABELV $702
line 1936
;1933:		}
;1934:		//CTF & 1FCTF & Obelisk & Harvester
;1935:		case MSG_ATTACKENEMYBASE:
;1936:		{
line 1937
;1937:			BotMatch_AttackEnemyBase(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_AttackEnemyBase
CALLV
pop
line 1938
;1938:			break;
ADDRGP4 $695
JUMPV
LABELV $703
line 1942
;1939:		}
;1940:		//Harvester
;1941:		case MSG_HARVEST:
;1942:		{
line 1943
;1943:			BotMatch_Harvest(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Harvest
CALLV
pop
line 1944
;1944:			break;
ADDRGP4 $695
JUMPV
LABELV $704
line 1948
;1945:		}
;1946:		//CTF & 1FCTF & Harvester
;1947:		case MSG_RUSHBASE:				//ctf rush to the base
;1948:		{
line 1949
;1949:			BotMatch_RushBase(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_RushBase
CALLV
pop
line 1950
;1950:			break;
ADDRGP4 $695
JUMPV
LABELV $705
line 1954
;1951:		}
;1952:		//CTF & 1FCTF
;1953:		case MSG_RETURNFLAG:
;1954:		{
line 1955
;1955:			BotMatch_ReturnFlag(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_ReturnFlag
CALLV
pop
line 1956
;1956:			break;
ADDRGP4 $695
JUMPV
LABELV $706
line 1960
;1957:		}
;1958:		//CTF & 1FCTF & Obelisk & Harvester
;1959:		case MSG_TASKPREFERENCE:
;1960:		{
line 1961
;1961:			BotMatch_TaskPreference(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_TaskPreference
CALLV
pop
line 1962
;1962:			break;
ADDRGP4 $695
JUMPV
LABELV $707
line 1966
;1963:		}
;1964:		//CTF & 1FCTF
;1965:		case MSG_CTF:
;1966:		{
line 1967
;1967:			BotMatch_CTF(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_CTF
CALLV
pop
line 1968
;1968:			break;
ADDRGP4 $695
JUMPV
LABELV $708
line 1971
;1969:		}
;1970:		case MSG_GETITEM:
;1971:		{
line 1972
;1972:			BotMatch_GetItem(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_GetItem
CALLV
pop
line 1973
;1973:			break;
ADDRGP4 $695
JUMPV
LABELV $709
line 1976
;1974:		}
;1975:		case MSG_JOINSUBTEAM:			//join a sub team
;1976:		{
line 1977
;1977:			BotMatch_JoinSubteam(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_JoinSubteam
CALLV
pop
line 1978
;1978:			break;
ADDRGP4 $695
JUMPV
LABELV $710
line 1981
;1979:		}
;1980:		case MSG_LEAVESUBTEAM:			//leave a sub team
;1981:		{
line 1982
;1982:			BotMatch_LeaveSubteam(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_LeaveSubteam
CALLV
pop
line 1983
;1983:			break;
ADDRGP4 $695
JUMPV
LABELV $711
line 1986
;1984:		}
;1985:		case MSG_WHICHTEAM:
;1986:		{
line 1987
;1987:			BotMatch_WhichTeam(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_WhichTeam
CALLV
pop
line 1988
;1988:			break;
ADDRGP4 $695
JUMPV
LABELV $712
line 1991
;1989:		}
;1990:		case MSG_CHECKPOINT:			//remember a check point
;1991:		{
line 1992
;1992:			BotMatch_CheckPoint(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_CheckPoint
CALLV
pop
line 1993
;1993:			break;
ADDRGP4 $695
JUMPV
LABELV $713
line 1996
;1994:		}
;1995:		case MSG_CREATENEWFORMATION:	//start the creation of a new formation
;1996:		{
line 1997
;1997:			trap_EA_SayTeam(bs->client, "the part of my brain to create formations has been damaged");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $714
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 1998
;1998:			break;
ADDRGP4 $695
JUMPV
LABELV $715
line 2001
;1999:		}
;2000:		case MSG_FORMATIONPOSITION:		//tell someone his/her position in the formation
;2001:		{
line 2002
;2002:			trap_EA_SayTeam(bs->client, "the part of my brain to create formations has been damaged");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $714
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 2003
;2003:			break;
ADDRGP4 $695
JUMPV
LABELV $716
line 2006
;2004:		}
;2005:		case MSG_FORMATIONSPACE:		//set the formation space
;2006:		{
line 2007
;2007:			BotMatch_FormationSpace(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_FormationSpace
CALLV
pop
line 2008
;2008:			break;
ADDRGP4 $695
JUMPV
line 2011
;2009:		}
;2010:		case MSG_DOFORMATION:			//form a certain formation
;2011:		{
line 2012
;2012:			break;
LABELV $718
line 2015
;2013:		}
;2014:		case MSG_DISMISS:				//dismiss someone
;2015:		{
line 2016
;2016:			BotMatch_Dismiss(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Dismiss
CALLV
pop
line 2017
;2017:			break;
ADDRGP4 $695
JUMPV
LABELV $719
line 2020
;2018:		}
;2019:		case MSG_STARTTEAMLEADERSHIP:	//someone will become the team leader
;2020:		{
line 2021
;2021:			BotMatch_StartTeamLeaderShip(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_StartTeamLeaderShip
CALLV
pop
line 2022
;2022:			break;
ADDRGP4 $695
JUMPV
LABELV $720
line 2025
;2023:		}
;2024:		case MSG_STOPTEAMLEADERSHIP:	//someone will stop being the team leader
;2025:		{
line 2026
;2026:			BotMatch_StopTeamLeaderShip(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_StopTeamLeaderShip
CALLV
pop
line 2027
;2027:			break;
ADDRGP4 $695
JUMPV
LABELV $721
line 2030
;2028:		}
;2029:		case MSG_WHOISTEAMLAEDER:
;2030:		{
line 2031
;2031:			BotMatch_WhoIsTeamLeader(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_WhoIsTeamLeader
CALLV
pop
line 2032
;2032:			break;
ADDRGP4 $695
JUMPV
LABELV $722
line 2035
;2033:		}
;2034:		case MSG_WHATAREYOUDOING:		//ask a bot what he/she is doing
;2035:		{
line 2036
;2036:			BotMatch_WhatAreYouDoing(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_WhatAreYouDoing
CALLV
pop
line 2037
;2037:			break;
ADDRGP4 $695
JUMPV
LABELV $723
line 2040
;2038:		}
;2039:		case MSG_WHATISMYCOMMAND:
;2040:		{
line 2041
;2041:			BotMatch_WhatIsMyCommand(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_WhatIsMyCommand
CALLV
pop
line 2042
;2042:			break;
ADDRGP4 $695
JUMPV
LABELV $724
line 2045
;2043:		}
;2044:		case MSG_WHEREAREYOU:
;2045:		{
line 2046
;2046:			BotMatch_WhereAreYou(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_WhereAreYou
CALLV
pop
line 2047
;2047:			break;
ADDRGP4 $695
JUMPV
LABELV $725
line 2050
;2048:		}
;2049:		case MSG_LEADTHEWAY:
;2050:		{
line 2051
;2051:			BotMatch_LeadTheWay(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_LeadTheWay
CALLV
pop
line 2052
;2052:			break;
ADDRGP4 $695
JUMPV
LABELV $726
line 2055
;2053:		}
;2054:		case MSG_KILL:
;2055:		{
line 2056
;2056:			BotMatch_Kill(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Kill
CALLV
pop
line 2057
;2057:			break;
ADDRGP4 $695
JUMPV
LABELV $727
line 2060
;2058:		}
;2059:		case MSG_ENTERGAME:				//someone entered the game
;2060:		{
line 2061
;2061:			BotMatch_EnterGame(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_EnterGame
CALLV
pop
line 2062
;2062:			break;
ADDRGP4 $695
JUMPV
LABELV $728
line 2065
;2063:		}
;2064:		case MSG_NEWLEADER:
;2065:		{
line 2066
;2066:			BotMatch_NewLeader(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_NewLeader
CALLV
pop
line 2067
;2067:			break;
ADDRGP4 $695
JUMPV
line 2070
;2068:		}
;2069:		case MSG_WAIT:
;2070:		{
line 2071
;2071:			break;
LABELV $730
line 2074
;2072:		}
;2073:		case MSG_SUICIDE:
;2074:		{
line 2075
;2075:			BotMatch_Suicide(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Suicide
CALLV
pop
line 2076
;2076:			break;
ADDRGP4 $695
JUMPV
LABELV $731
line 2079
;2077:		}
;2078:		case MSG_TAKEA:
;2079:		{
line 2080
;2080:			BotMatch_TakeA(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_TakeA
CALLV
pop
line 2081
;2081:			break;
ADDRGP4 $695
JUMPV
LABELV $732
line 2084
;2082:		}
;2083:		case MSG_TAKEB:
;2084:		{
line 2085
;2085:			BotMatch_TakeB(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_TakeB
CALLV
pop
line 2086
;2086:			break;
ADDRGP4 $695
JUMPV
LABELV $694
line 2089
;2087:		}
;2088:		default:
;2089:		{
line 2090
;2090:			BotAI_Print(PRT_MESSAGE, "unknown match type\n");
CNSTI4 1
ARGI4
ADDRGP4 $733
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 2091
;2091:			break;
LABELV $695
line 2094
;2092:		}
;2093:	}
;2094:	return qtrue;
CNSTI4 1
RETI4
LABELV $690
endproc BotMatchMessage 344 12
import BotVoiceChatOnly
import BotVoiceChat
import BotSetTeamMateTaskPreference
import BotGetTeamMateTaskPreference
import BotTeamAI
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
bss
export notleader
align 4
LABELV notleader
skip 256
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
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import floattime
import BotEntityInfo
import NumBots
import BotResetState
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
LABELV $733
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $714
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $623
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $622
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $619
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $618
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $599
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $598
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $597
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $596
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $595
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $594
byte 1 68
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $593
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $592
byte 1 83
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $591
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
LABELV $590
byte 1 80
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $589
byte 1 78
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $588
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $587
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $586
byte 1 72
byte 1 101
byte 1 97
byte 1 118
byte 1 121
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $585
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $584
byte 1 70
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $583
byte 1 73
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $582
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $581
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $580
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $579
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $578
byte 1 66
byte 1 70
byte 1 71
byte 1 49
byte 1 48
byte 1 75
byte 1 0
align 1
LABELV $577
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $576
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $575
byte 1 80
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
LABELV $574
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $573
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $572
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $548
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $547
byte 1 100
byte 1 100
byte 1 95
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 98
byte 1 0
align 1
LABELV $545
byte 1 100
byte 1 100
byte 1 95
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 97
byte 1 0
align 1
LABELV $543
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
LABELV $541
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $539
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $537
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $535
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $533
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
LABELV $531
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $529
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $527
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 0
align 1
LABELV $525
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $523
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
byte 1 0
align 1
LABELV $521
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $513
byte 1 73
byte 1 39
byte 1 109
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $491
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $490
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $484
byte 1 100
byte 1 105
byte 1 115
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $468
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 95
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 114
byte 1 109
byte 1 0
align 1
LABELV $467
byte 1 37
byte 1 49
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 48
byte 1 102
byte 1 0
align 1
LABELV $456
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $448
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
LABELV $442
byte 1 110
byte 1 111
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $441
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $433
byte 1 0
align 1
LABELV $432
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $424
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $413
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $412
byte 1 107
byte 1 101
byte 1 101
byte 1 112
byte 1 105
byte 1 110
byte 1 109
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $259
byte 1 119
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 114
byte 1 101
byte 1 121
byte 1 111
byte 1 117
byte 1 0
align 1
LABELV $258
byte 1 119
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 105
byte 1 115
byte 1 0
align 1
LABELV $239
byte 1 119
byte 1 104
byte 1 111
byte 1 105
byte 1 115
byte 1 0
align 1
LABELV $222
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $173
byte 1 73
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $148
byte 1 119
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 97
byte 1 121
byte 1 63
byte 1 0
