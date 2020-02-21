data
align 4
LABELV $62
address $63
address $64
address $65
address $66
address $67
address $68
address $69
address $70
address $71
address $67
address $72
address $73
address $74
address $75
export untrap_BotGetLevelItemGoal
code
proc untrap_BotGetLevelItemGoal 148 16
file "../../../code/game/ai_dmq3.c"
line 117
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
;23:
;24:/*****************************************************************************
;25: * name:		ai_dmq3.c
;26: *
;27: * desc:		Quake3 bot AI
;28: *
;29: * $Archive: /MissionPack/code/game/ai_dmq3.c $
;30: *
;31: *****************************************************************************/
;32:
;33:
;34:#include "g_local.h"
;35:#include "../botlib/botlib.h"
;36:#include "../botlib/be_aas.h"
;37:#include "../botlib/be_ea.h"
;38:#include "../botlib/be_ai_char.h"
;39:#include "../botlib/be_ai_chat.h"
;40:#include "../botlib/be_ai_gen.h"
;41:#include "../botlib/be_ai_goal.h"
;42:#include "../botlib/be_ai_move.h"
;43:#include "../botlib/be_ai_weap.h"
;44://
;45:#include "ai_main.h"
;46:#include "ai_dmq3.h"
;47:#include "ai_chat.h"
;48:#include "ai_cmd.h"
;49:#include "ai_dmnet.h"
;50:#include "ai_team.h"
;51://
;52:#include "chars.h"    //characteristics
;53:#include "inv.h"    //indexes into the inventory
;54:#include "syn.h"    //synonyms
;55:#include "match.h"    //string matching types and vars
;56:
;57:// for the voice chats
;58:#include "../../ui/menudef.h" // sos001205 - for q3_ui also
;59:
;60:// from aasfile.h
;61:#define AREACONTENTS_MOVER    1024
;62:#define AREACONTENTS_MODELNUMSHIFT  24
;63:#define AREACONTENTS_MAXMODELNUM  0xFF
;64:#define AREACONTENTS_MODELNUM   (AREACONTENTS_MAXMODELNUM << AREACONTENTS_MODELNUMSHIFT)
;65:
;66:#define IDEAL_ATTACKDIST   140
;67:
;68:#define MAX_WAYPOINTS  128
;69:
;70:#define MAX_EPAIRKEY  128
;71://
;72:bot_waypoint_t botai_waypoints[MAX_WAYPOINTS];
;73:bot_waypoint_t *botai_freewaypoints;
;74:
;75://NOTE: not using a cvars which can be updated because the game should be reloaded anyway
;76:int gametype; //game type
;77:
;78:vmCvar_t bot_grapple;
;79:vmCvar_t bot_rocketjump;
;80:vmCvar_t bot_fastchat;
;81:vmCvar_t bot_nochat;
;82:vmCvar_t bot_testrchat;
;83:vmCvar_t bot_challenge;
;84:vmCvar_t bot_predictobstacles;
;85:vmCvar_t bot_spSkill;
;86:
;87:extern vmCvar_t bot_developer;
;88:
;89:vec3_t lastteleport_origin; //last teleport event origin
;90:float lastteleport_time; //last teleport event time
;91:int max_bspmodelindex; //maximum BSP model index
;92:
;93://CTF flag goals
;94:bot_goal_t ctf_redflag;
;95:bot_goal_t ctf_blueflag;
;96://Domination goals:
;97:bot_goal_t dom_points_bot[MAX_DOMINATION_POINTS];
;98:bot_goal_t ctf_neutralflag;
;99:bot_goal_t redobelisk;
;100:bot_goal_t blueobelisk;
;101:bot_goal_t neutralobelisk;
;102:
;103:#define MAX_ALTROUTEGOALS  32
;104:
;105:int altroutegoals_setup;
;106:aas_altroutegoal_t red_altroutegoals[MAX_ALTROUTEGOALS];
;107:int red_numaltroutegoals;
;108:aas_altroutegoal_t blue_altroutegoals[MAX_ALTROUTEGOALS];
;109:int blue_numaltroutegoals;
;110:
;111:/*
;112:==================
;113:untrap_BotGetLevelItemGoal
;114: *same as trap_BotGetLevelItemGoal, but respects the gametype flag!
;115:==================
;116: */
;117:int untrap_BotGetLevelItemGoal(int start, char *classname, void /* struct bot_goal_s */ *goal) {
line 123
;118:	static char *gametypeNames[] = {"ffa", "tournament", "single", "team", "ctf", "oneflag", "obelisk", "harvester", "elimination",
;119:		"ctf", "lms", "dd", "dom", "pos"};
;120:	char allowedGametypes[MAX_EPAIRKEY];
;121:	char *gametypeName;
;122:
;123:	start = trap_BotGetLevelItemGoal(start, classname, goal);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRFP4 0
ADDRLP4 132
INDIRI4
ASGNI4
ADDRGP4 $77
JUMPV
LABELV $76
line 124
;124:	while (start>-1) {
line 125
;125:		if (!trap_AAS_ValueForBSPEpairKey(start, "gametype", allowedGametypes, MAX_EPAIRKEY))
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $81
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 136
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $79
line 126
;126:			return start; //No gametype flag
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $61
JUMPV
LABELV $79
line 127
;127:		if (gametype >= GT_FFA && gametype < ARRAY_LEN(gametypeNames)) {
ADDRLP4 140
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
LTI4 $82
ADDRLP4 140
INDIRI4
CVIU4 4
CNSTU4 14
GEU4 $82
line 128
;128:			gametypeName = gametypeNames[gametype];
ADDRLP4 128
ADDRGP4 gametype
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $62
ADDP4
INDIRP4
ASGNP4
line 129
;129:			if (strstr(allowedGametypes, gametypeName)) {
ADDRLP4 0
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $83
line 131
;130:				//In gametype strig
;131:				return start;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $61
JUMPV
line 133
;132:			}
;133:		} else
LABELV $82
line 134
;134:			return start;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $61
JUMPV
LABELV $83
line 135
;135:		start = trap_BotGetLevelItemGoal(start, classname, goal);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRFP4 0
ADDRLP4 144
INDIRI4
ASGNI4
line 136
;136:	}
LABELV $77
line 124
ADDRFP4 0
INDIRI4
CNSTI4 -1
GTI4 $76
line 137
;137:	return -1;
CNSTI4 -1
RETI4
LABELV $61
endproc untrap_BotGetLevelItemGoal 148 16
export BotSetUserInfo
proc BotSetUserInfo 1024 12
line 145
;138:}
;139:
;140:/*
;141:==================
;142:BotSetUserInfo
;143:==================
;144: */
;145:void BotSetUserInfo(bot_state_t *bs, char *key, char *value) {
line 148
;146:	char userinfo[MAX_INFO_STRING];
;147:
;148:	trap_GetUserinfo(bs->client, userinfo, sizeof (userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 149
;149:	Info_SetValueForKey(userinfo, key, value);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 150
;150:	trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 151
;151:	ClientUserinfoChanged(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 152
;152:}
LABELV $86
endproc BotSetUserInfo 1024 12
export BotCTFCarryingFlag
proc BotCTFCarryingFlag 8 4
line 159
;153:
;154:/*
;155:==================
;156:BotCTFCarryingFlag
;157:==================
;158: */
;159:int BotCTFCarryingFlag(bot_state_t *bs) {
line 160
;160:	if (!G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) return CTF_FLAG_NONE;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $88
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $88
CNSTI4 0
RETI4
ADDRGP4 $87
JUMPV
LABELV $88
line 162
;161:
;162:	if (bs->inventory[INVENTORY_REDFLAG] > 0) return CTF_FLAG_RED;
ADDRFP4 0
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $90
CNSTI4 1
RETI4
ADDRGP4 $87
JUMPV
LABELV $90
line 163
;163:	else if (bs->inventory[INVENTORY_BLUEFLAG] > 0) return CTF_FLAG_BLUE;
ADDRFP4 0
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $92
CNSTI4 2
RETI4
ADDRGP4 $87
JUMPV
LABELV $92
line 164
;164:	return CTF_FLAG_NONE;
CNSTI4 0
RETI4
LABELV $87
endproc BotCTFCarryingFlag 8 4
export BotTeam
proc BotTeam 4 0
line 172
;165:}
;166:
;167:/*
;168:==================
;169:BotTeam
;170:==================
;171: */
;172:int BotTeam(bot_state_t *bs) {
line 173
;173:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $97
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $95
LABELV $97
line 174
;174:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $94
JUMPV
LABELV $95
line 177
;175:	}
;176:
;177:	if (level.clients[bs->client].sess.sessionTeam == TEAM_RED) {
CNSTI4 2116
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 1
NEI4 $98
line 178
;178:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $94
JUMPV
LABELV $98
line 179
;179:	} else if (level.clients[bs->client].sess.sessionTeam == TEAM_BLUE) {
CNSTI4 2116
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 2
NEI4 $100
line 180
;180:		return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $94
JUMPV
LABELV $100
line 183
;181:	}
;182:
;183:	return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $94
endproc BotTeam 4 0
export BotOppositeTeam
proc BotOppositeTeam 12 4
line 191
;184:}
;185:
;186:/*
;187:==================
;188:BotOppositeTeam
;189:==================
;190: */
;191:int BotOppositeTeam(bot_state_t *bs) {
line 192
;192:	switch (BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $106
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $107
ADDRGP4 $103
JUMPV
LABELV $106
line 193
;193:		case TEAM_RED: return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $102
JUMPV
LABELV $107
line 194
;194:		case TEAM_BLUE: return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $102
JUMPV
LABELV $103
line 195
;195:		default: return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $102
endproc BotOppositeTeam 12 4
export BotEnemyFlag
proc BotEnemyFlag 4 4
line 204
;196:	}
;197:}
;198:
;199:/*
;200:==================
;201:BotEnemyFlag
;202:==================
;203: */
;204:bot_goal_t *BotEnemyFlag(bot_state_t *bs) {
line 205
;205:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $109
line 206
;206:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
ADDRGP4 $108
JUMPV
LABELV $109
line 207
;207:	} else {
line 208
;208:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
LABELV $108
endproc BotEnemyFlag 4 4
export BotTeamFlag
proc BotTeamFlag 4 4
line 217
;209:	}
;210:}
;211:
;212:/*
;213:==================
;214:BotTeamFlag
;215:==================
;216: */
;217:bot_goal_t *BotTeamFlag(bot_state_t *bs) {
line 218
;218:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $112
line 219
;219:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
ADDRGP4 $111
JUMPV
LABELV $112
line 220
;220:	} else {
line 221
;221:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
LABELV $111
endproc BotTeamFlag 4 4
export EntityIsDead
proc EntityIsDead 476 8
line 230
;222:	}
;223:}
;224:
;225:/*
;226:==================
;227:EntityIsDead
;228:==================
;229: */
;230:qboolean EntityIsDead(aas_entityinfo_t *entinfo) {
line 233
;231:	playerState_t ps;
;232:
;233:	if (entinfo->number >= 0 && entinfo->number < MAX_CLIENTS) {
ADDRLP4 468
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 468
INDIRI4
CNSTI4 0
LTI4 $115
ADDRLP4 468
INDIRI4
CNSTI4 64
GEI4 $115
line 235
;234:		//retrieve the current client state
;235:		if (!BotAI_GetClientState(entinfo->number, &ps)) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 472
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 472
INDIRI4
CNSTI4 0
NEI4 $117
line 236
;236:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $114
JUMPV
LABELV $117
line 239
;237:		}
;238:
;239:		if (ps.pm_type != PM_NORMAL) return qtrue;
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $119
CNSTI4 1
RETI4
ADDRGP4 $114
JUMPV
LABELV $119
line 240
;240:	}
LABELV $115
line 241
;241:	return qfalse;
CNSTI4 0
RETI4
LABELV $114
endproc EntityIsDead 476 8
export EntityCarriesFlag
proc EntityCarriesFlag 0 0
line 249
;242:}
;243:
;244:/*
;245:==================
;246:EntityCarriesFlag
;247:==================
;248: */
;249:qboolean EntityCarriesFlag(aas_entityinfo_t *entinfo) {
line 250
;250:	if (entinfo->powerups & (1 << PW_REDFLAG))
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $123
line 251
;251:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $122
JUMPV
LABELV $123
line 252
;252:	if (entinfo->powerups & (1 << PW_BLUEFLAG))
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $125
line 253
;253:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $122
JUMPV
LABELV $125
line 254
;254:	if (entinfo->powerups & (1 << PW_NEUTRALFLAG))
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $127
line 255
;255:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $122
JUMPV
LABELV $127
line 256
;256:	return qfalse;
CNSTI4 0
RETI4
LABELV $122
endproc EntityCarriesFlag 0 0
export EntityIsInvisible
proc EntityIsInvisible 4 4
line 264
;257:}
;258:
;259:/*
;260:==================
;261:EntityIsInvisible
;262:==================
;263: */
;264:qboolean EntityIsInvisible(aas_entityinfo_t *entinfo) {
line 266
;265:	// the flag is always visible
;266:	if (EntityCarriesFlag(entinfo)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $130
line 267
;267:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $129
JUMPV
LABELV $130
line 269
;268:	}
;269:	if (entinfo->powerups & (1 << PW_INVIS)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $132
line 270
;270:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $129
JUMPV
LABELV $132
line 272
;271:	}
;272:	return qfalse;
CNSTI4 0
RETI4
LABELV $129
endproc EntityIsInvisible 4 4
export EntityIsShooting
proc EntityIsShooting 0 0
line 280
;273:}
;274:
;275:/*
;276:==================
;277:EntityIsShooting
;278:==================
;279: */
;280:qboolean EntityIsShooting(aas_entityinfo_t *entinfo) {
line 281
;281:	if (entinfo->flags & EF_FIRING) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $135
line 282
;282:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $134
JUMPV
LABELV $135
line 284
;283:	}
;284:	return qfalse;
CNSTI4 0
RETI4
LABELV $134
endproc EntityIsShooting 0 0
export EntityIsChatting
proc EntityIsChatting 0 0
line 292
;285:}
;286:
;287:/*
;288:==================
;289:EntityIsChatting
;290:==================
;291: */
;292:qboolean EntityIsChatting(aas_entityinfo_t *entinfo) {
line 293
;293:	if (entinfo->flags & EF_TALK) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $138
line 294
;294:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $137
JUMPV
LABELV $138
line 296
;295:	}
;296:	return qfalse;
CNSTI4 0
RETI4
LABELV $137
endproc EntityIsChatting 0 0
export EntityHasQuad
proc EntityHasQuad 0 0
line 304
;297:}
;298:
;299:/*
;300:==================
;301:EntityHasQuad
;302:==================
;303: */
;304:qboolean EntityHasQuad(aas_entityinfo_t *entinfo) {
line 305
;305:	if (entinfo->powerups & (1 << PW_QUAD)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $141
line 306
;306:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $140
JUMPV
LABELV $141
line 308
;307:	}
;308:	return qfalse;
CNSTI4 0
RETI4
LABELV $140
endproc EntityHasQuad 0 0
export EntityHasKamikaze
proc EntityHasKamikaze 0 0
line 316
;309:}
;310:
;311:/*
;312:==================
;313:EntityHasKamikze
;314:==================
;315: */
;316:qboolean EntityHasKamikaze(aas_entityinfo_t *entinfo) {
line 317
;317:	if (entinfo->flags & EF_KAMIKAZE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $144
line 318
;318:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $143
JUMPV
LABELV $144
line 320
;319:	}
;320:	return qfalse;
CNSTI4 0
RETI4
LABELV $143
endproc EntityHasKamikaze 0 0
export EntityCarriesCubes
proc EntityCarriesCubes 208 8
line 328
;321:}
;322:
;323:/*
;324:==================
;325:EntityCarriesCubes
;326:==================
;327: */
;328:qboolean EntityCarriesCubes(aas_entityinfo_t *entinfo) {
line 331
;329:	entityState_t state;
;330:
;331:	if (gametype != GT_HARVESTER)
ADDRGP4 gametype
INDIRI4
CNSTI4 7
EQI4 $147
line 332
;332:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $146
JUMPV
LABELV $147
line 334
;333:	//FIXME: get this info from the aas_entityinfo_t ?
;334:	BotAI_GetEntityState(entinfo->number, &state);
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 335
;335:	if (state.generic1 > 0)
ADDRLP4 0+204
INDIRI4
CNSTI4 0
LEI4 $149
line 336
;336:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $146
JUMPV
LABELV $149
line 337
;337:	return qfalse;
CNSTI4 0
RETI4
LABELV $146
endproc EntityCarriesCubes 208 8
export Bot1FCTFCarryingFlag
proc Bot1FCTFCarryingFlag 4 4
line 345
;338:}
;339:
;340:/*
;341:==================
;342:Bot1FCTFCarryingFlag
;343:==================
;344: */
;345:int Bot1FCTFCarryingFlag(bot_state_t *bs) {
line 346
;346:	if (!G_UsesTheWhiteFlag(gametype)) return qfalse;
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $153
CNSTI4 0
RETI4
ADDRGP4 $152
JUMPV
LABELV $153
line 348
;347:
;348:	if (bs->inventory[INVENTORY_NEUTRALFLAG] > 0) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $155
CNSTI4 1
RETI4
ADDRGP4 $152
JUMPV
LABELV $155
line 349
;349:	return qfalse;
CNSTI4 0
RETI4
LABELV $152
endproc Bot1FCTFCarryingFlag 4 4
export BotHarvesterCarryingCubes
proc BotHarvesterCarryingCubes 0 0
line 357
;350:}
;351:
;352:/*
;353:==================
;354:BotHarvesterCarryingCubes
;355:==================
;356: */
;357:int BotHarvesterCarryingCubes(bot_state_t *bs) {
line 358
;358:	if (gametype != GT_HARVESTER) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 7
EQI4 $158
CNSTI4 0
RETI4
ADDRGP4 $157
JUMPV
LABELV $158
line 360
;359:
;360:	if (bs->inventory[INVENTORY_REDCUBE] > 0) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5000
ADDP4
INDIRI4
CNSTI4 0
LEI4 $160
CNSTI4 1
RETI4
ADDRGP4 $157
JUMPV
LABELV $160
line 361
;361:	if (bs->inventory[INVENTORY_BLUECUBE] > 0) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $162
CNSTI4 1
RETI4
ADDRGP4 $157
JUMPV
LABELV $162
line 362
;362:	return qfalse;
CNSTI4 0
RETI4
LABELV $157
endproc BotHarvesterCarryingCubes 0 0
export BotRememberLastOrderedTask
proc BotRememberLastOrderedTask 16 12
line 371
;363:}
;364://#endif
;365:
;366:/*
;367:==================
;368:BotRememberLastOrderedTask
;369:==================
;370: */
;371:void BotRememberLastOrderedTask(bot_state_t *bs) {
line 372
;372:	if (!bs->ordered) {
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $165
line 373
;373:		return;
ADDRGP4 $164
JUMPV
LABELV $165
line 375
;374:	}
;375:	bs->lastgoal_decisionmaker = bs->decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6612
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ASGNI4
line 376
;376:	bs->lastgoal_ltgtype = bs->ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6616
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
line 377
;377:	memcpy(&bs->lastgoal_teamgoal, &bs->teamgoal, sizeof (bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 378
;378:	bs->lastgoal_teammate = bs->teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6620
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ASGNI4
line 379
;379:}
LABELV $164
endproc BotRememberLastOrderedTask 16 12
export BotSetTeamStatus
proc BotSetTeamStatus 172 12
line 386
;380:
;381:/*
;382:==================
;383:BotSetTeamStatus
;384:==================
;385: */
;386:void BotSetTeamStatus(bot_state_t *bs) {
line 390
;387:	int teamtask;
;388:	aas_entityinfo_t entinfo;
;389:
;390:	teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 392
;391:
;392:	switch (bs->ltgtype) {
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 1
LTI4 $168
ADDRLP4 144
INDIRI4
CNSTI4 17
GTI4 $168
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $193-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $193
address $169
address $172
address $177
address $178
address $179
address $180
address $181
address $181
address $182
address $183
address $184
address $185
address $186
address $168
address $168
address $187
address $190
code
line 394
;393:		case LTG_TEAMHELP:
;394:			break;
LABELV $172
line 396
;395:		case LTG_TEAMACCOMPANY:
;396:			BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 397
;397:			if ((G_UsesTeamFlags(gametype) && EntityCarriesFlag(&entinfo)) ||
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $176
ADDRLP4 4
ARGP4
ADDRLP4 156
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $175
LABELV $176
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $173
ADDRLP4 4
ARGP4
ADDRLP4 160
ADDRGP4 EntityCarriesCubes
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $173
LABELV $175
line 398
;398:				(gametype == GT_HARVESTER && EntityCarriesCubes(&entinfo))) {
line 399
;399:				teamtask = TEAMTASK_ESCORT;
ADDRLP4 0
CNSTI4 6
ASGNI4
line 400
;400:			} else {
ADDRGP4 $169
JUMPV
LABELV $173
line 401
;401:				teamtask = TEAMTASK_FOLLOW;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 402
;402:			}
line 403
;403:			break;
ADDRGP4 $169
JUMPV
LABELV $177
line 405
;404:		case LTG_DEFENDKEYAREA:
;405:			teamtask = TEAMTASK_DEFENSE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 406
;406:			break;
ADDRGP4 $169
JUMPV
LABELV $178
line 408
;407:		case LTG_GETFLAG:
;408:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 409
;409:			break;
ADDRGP4 $169
JUMPV
LABELV $179
line 411
;410:		case LTG_RUSHBASE:
;411:			teamtask = TEAMTASK_DEFENSE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 412
;412:			break;
ADDRGP4 $169
JUMPV
LABELV $180
line 414
;413:		case LTG_RETURNFLAG:
;414:			teamtask = TEAMTASK_RETRIEVE;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 415
;415:			break;
ADDRGP4 $169
JUMPV
LABELV $181
line 418
;416:		case LTG_CAMP:
;417:		case LTG_CAMPORDER:
;418:			teamtask = TEAMTASK_CAMP;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 419
;419:			break;
ADDRGP4 $169
JUMPV
LABELV $182
line 421
;420:		case LTG_PATROL:
;421:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 422
;422:			break;
ADDRGP4 $169
JUMPV
LABELV $183
line 424
;423:		case LTG_GETITEM:
;424:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 425
;425:			break;
ADDRGP4 $169
JUMPV
LABELV $184
line 427
;426:		case LTG_KILL:
;427:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 428
;428:			break;
ADDRGP4 $169
JUMPV
LABELV $185
line 430
;429:		case LTG_HARVEST:
;430:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 431
;431:			break;
ADDRGP4 $169
JUMPV
LABELV $186
line 433
;432:		case LTG_ATTACKENEMYBASE:
;433:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 434
;434:			break;
ADDRGP4 $169
JUMPV
LABELV $187
line 436
;435:		case LTG_POINTA:
;436:			if (BotTeam(bs) == TEAM_BLUE)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 2
NEI4 $188
line 437
;437:				teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $169
JUMPV
LABELV $188
line 439
;438:			else
;439:				teamtask = TEAMTASK_DEFENSE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 440
;440:			break;
ADDRGP4 $169
JUMPV
LABELV $190
line 442
;441:		case LTG_POINTB:
;442:			if (BotTeam(bs) == TEAM_RED)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 1
NEI4 $191
line 443
;443:				teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $169
JUMPV
LABELV $191
line 445
;444:			else
;445:				teamtask = TEAMTASK_DEFENSE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 446
;446:			break;
ADDRGP4 $169
JUMPV
LABELV $168
line 448
;447:		default:
;448:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 449
;449:			break;
LABELV $169
line 451
;450:	}
;451:	BotSetUserInfo(bs, "teamtask", va("%d", teamtask));
ADDRGP4 $196
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $195
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 452
;452:}
LABELV $167
endproc BotSetTeamStatus 172 12
export BotSetLastOrderedTask
proc BotSetLastOrderedTask 76 16
line 459
;453:
;454:/*
;455:==================
;456:BotSetLastOrderedTask
;457:==================
;458: */
;459:int BotSetLastOrderedTask(bot_state_t *bs) {
line 461
;460:
;461:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $198
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $198
line 463
;462:		// don't go back to returning the flag if it's at the base
;463:		if (bs->lastgoal_ltgtype == LTG_RETURNFLAG) {
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
CNSTI4 6
NEI4 $200
line 464
;464:			if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $202
line 465
;465:				if (bs->redflagstatus == 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
CNSTI4 0
NEI4 $203
line 466
;466:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 467
;467:				}
line 468
;468:			} else {
ADDRGP4 $203
JUMPV
LABELV $202
line 469
;469:				if (bs->blueflagstatus == 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
CNSTI4 0
NEI4 $206
line 470
;470:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 471
;471:				}
LABELV $206
line 472
;472:			}
LABELV $203
line 473
;473:		}
LABELV $200
line 474
;474:	}
LABELV $198
line 476
;475:
;476:	if (bs->lastgoal_ltgtype) {
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
CNSTI4 0
EQI4 $208
line 477
;477:		bs->decisionmaker = bs->lastgoal_decisionmaker;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
ASGNI4
line 478
;478:		bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 479
;479:		bs->ltgtype = bs->lastgoal_ltgtype;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6456
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
ASGNI4
line 480
;480:		memcpy(&bs->teamgoal, &bs->lastgoal_teamgoal, sizeof (bot_goal_t));
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 481
;481:		bs->teammate = bs->lastgoal_teammate;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 6460
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
ASGNI4
line 482
;482:		bs->teamgoal_time = FloatTime() + 300;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1133903872
ADDF4
ASGNF4
line 483
;483:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 485
;484:		//
;485:		if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $210
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $210
line 486
;486:			if (bs->ltgtype == LTG_GETFLAG) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 4
NEI4 $212
line 490
;487:				bot_goal_t *tb, *eb;
;488:				int tt, et;
;489:
;490:				tb = BotTeamFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotTeamFlag
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 48
INDIRP4
ASGNP4
line 491
;491:				eb = BotEnemyFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotEnemyFlag
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 52
INDIRP4
ASGNP4
line 492
;492:				tt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, tb->areanum, TFL_DEFAULT);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 60
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 60
INDIRI4
ASGNI4
line 493
;493:				et = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, eb->areanum, TFL_DEFAULT);
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 68
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 68
INDIRI4
ASGNI4
line 495
;494:				// if the travel time towards the enemy base is larger than towards our base
;495:				if (et > tt) {
ADDRLP4 44
INDIRI4
ADDRLP4 40
INDIRI4
LEI4 $214
line 497
;496:					//get an alternative route goal towards the enemy base
;497:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 498
;498:				}
LABELV $214
line 499
;499:			}
LABELV $212
line 500
;500:		}
LABELV $210
line 501
;501:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $197
JUMPV
LABELV $208
line 503
;502:	}
;503:	return qfalse;
CNSTI4 0
RETI4
LABELV $197
endproc BotSetLastOrderedTask 76 16
export BotRefuseOrder
proc BotRefuseOrder 8 12
line 511
;504:}
;505:
;506:/*
;507:==================
;508:BotRefuseOrder
;509:==================
;510: */
;511:void BotRefuseOrder(bot_state_t *bs) {
line 512
;512:	if (!bs->ordered)
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $217
line 513
;513:		return;
ADDRGP4 $216
JUMPV
LABELV $217
line 515
;514:	// if the bot was ordered to do something
;515:	if (bs->order_time && bs->order_time > FloatTime() - 10) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $219
ADDRLP4 0
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
SUBF4
LEF4 $219
line 516
;516:		trap_EA_Action(bs->client, ACTION_NEGATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 2097152
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 517
;517:		BotVoiceChat(bs, bs->decisionmaker, VOICECHAT_NO);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
ADDRGP4 $221
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 518
;518:		bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
CNSTF4 0
ASGNF4
line 519
;519:	}
LABELV $219
line 520
;520:}
LABELV $216
endproc BotRefuseOrder 8 12
export BotCTFSeekGoals
proc BotCTFSeekGoals 240 12
line 527
;521:
;522:/*
;523:==================
;524:BotCTFSeekGoals
;525:==================
;526: */
;527:void BotCTFSeekGoals(bot_state_t *bs) {
line 534
;528:	float rnd, l1, l2;
;529:	int flagstatus, c;
;530:	vec3_t dir;
;531:	aas_entityinfo_t entinfo;
;532:
;533:	//when carrying a flag in ctf the bot should rush to the base
;534:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $223
line 536
;535:		//if not already rushing to the base
;536:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 5
EQI4 $225
line 537
;537:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 538
;538:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 5
ASGNI4
line 539
;539:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 540
;540:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTF4 0
ASGNF4
line 541
;541:			bs->decisionmaker = bs->client;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 176
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 542
;542:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 544
;543:			//
;544:			switch (BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
ADDRLP4 184
INDIRI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
EQI4 $230
ADDRLP4 180
INDIRI4
CNSTI4 2
EQI4 $235
ADDRGP4 $227
JUMPV
LABELV $230
line 545
;545:				case TEAM_RED: VectorSubtract(bs->origin, ctf_blueflag.origin, dir);
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 192
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 192
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+8
INDIRF4
SUBF4
ASGNF4
line 546
;546:					break;
ADDRGP4 $228
JUMPV
LABELV $235
line 547
;547:				case TEAM_BLUE: VectorSubtract(bs->origin, ctf_redflag.origin, dir);
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 196
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRGP4 ctf_redflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 196
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+8
INDIRF4
SUBF4
ASGNF4
line 548
;548:					break;
ADDRGP4 $228
JUMPV
LABELV $227
line 549
;549:				default: VectorSet(dir, 999, 999, 999);
ADDRLP4 200
CNSTF4 1148829696
ASGNF4
ADDRLP4 160
ADDRLP4 200
INDIRF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 200
INDIRF4
ASGNF4
ADDRLP4 160+8
CNSTF4 1148829696
ASGNF4
line 550
;550:					break;
LABELV $228
line 553
;551:			}
;552:			// if the bot picked up the flag very close to the enemy base
;553:			if (VectorLength(dir) < 128) {
ADDRLP4 160
ARGP4
ADDRLP4 192
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 192
INDIRF4
CNSTF4 1124073472
GEF4 $242
line 555
;554:				// get an alternative route goal through the enemy base
;555:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 556
;556:			} else {
ADDRGP4 $243
JUMPV
LABELV $242
line 558
;557:				// don't use any alt route goal, just get the hell out of the base
;558:				bs->altroutegoal.areanum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6548
ADDP4
CNSTI4 0
ASGNI4
line 559
;559:			}
LABELV $243
line 560
;560:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_OFFENSE));
ADDRGP4 $196
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 196
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $195
ARGP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 561
;561:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $244
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 562
;562:		} else if (bs->rushbaseaway_time > FloatTime()) {
ADDRGP4 $222
JUMPV
LABELV $225
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $222
line 563
;563:			if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus;
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
NEI4 $247
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $248
JUMPV
LABELV $247
line 564
;564:			else flagstatus = bs->blueflagstatus;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
ASGNI4
LABELV $248
line 566
;565:			//if the flag is back
;566:			if (flagstatus == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $222
line 567
;567:				bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTF4 0
ASGNF4
line 568
;568:			}
line 569
;569:		}
line 570
;570:		return;
ADDRGP4 $222
JUMPV
LABELV $223
line 573
;571:	}
;572:	// if the bot decided to follow someone
;573:	if (bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered) {
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 2
NEI4 $251
ADDRLP4 176
INDIRP4
CNSTI4 6468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $251
line 575
;574:		// if the team mate being accompanied no longer carries the flag
;575:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 576
;576:		if (!EntityCarriesFlag(&entinfo)) {
ADDRLP4 16
ARGP4
ADDRLP4 180
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $253
line 577
;577:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 578
;578:		}
LABELV $253
line 579
;579:	}
LABELV $251
line 581
;580:	//
;581:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
NEI4 $255
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 184
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 184
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $256
JUMPV
LABELV $255
line 582
;582:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 188
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 188
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $256
line 584
;583:	//if our team has the enemy flag and our flag is at the base
;584:	if (flagstatus == 1) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $257
line 586
;585:		//
;586:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $222
line 588
;587:			//if Not defending the base already
;588:			if (!(bs->ltgtype == LTG_DEFENDKEYAREA &&
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 3
NEI4 $265
ADDRLP4 196
ADDRLP4 192
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ASGNI4
ADDRLP4 196
INDIRI4
ADDRGP4 ctf_redflag+44
INDIRI4
EQI4 $222
ADDRLP4 196
INDIRI4
ADDRGP4 ctf_blueflag+44
INDIRI4
EQI4 $222
LABELV $265
line 590
;589:					(bs->teamgoal.number == ctf_redflag.number ||
;590:					bs->teamgoal.number == ctf_blueflag.number))) {
line 592
;591:				//if there is a visible team mate flag carrier
;592:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 200
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 200
INDIRI4
ASGNI4
line 593
;593:				if (c >= 0 &&
ADDRLP4 204
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
LTI4 $222
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 2
NEI4 $268
ADDRLP4 208
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ADDRLP4 204
INDIRI4
EQI4 $222
LABELV $268
line 595
;594:						// and not already following the team mate flag carrier
;595:						(bs->ltgtype != LTG_TEAMACCOMPANY || bs->teammate != c)) {
line 597
;596:					//
;597:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 599
;598:					//follow the flag carrier
;599:					bs->decisionmaker = bs->client;
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 212
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 600
;600:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 602
;601:					//the team mate
;602:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 604
;603:					//last time the team mate was visible
;604:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 606
;605:					//no message
;606:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 608
;607:					//no arrive message
;608:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTF4 1065353216
ASGNF4
line 610
;609:					//
;610:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRGP4 $269
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 612
;611:					//get the team goal time
;612:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 613
;613:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 2
ASGNI4
line 614
;614:					bs->formation_dist = 3.5 * 32; //3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 6872
ADDP4
CNSTF4 1121976320
ASGNF4
line 615
;615:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 616
;616:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 617
;617:				}
line 618
;618:			}
line 619
;619:		}
line 620
;620:		return;
ADDRGP4 $222
JUMPV
LABELV $257
line 622
;621:	}		//if the enemy has our flag
;622:	else if (flagstatus == 2) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $270
line 624
;623:		//
;624:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $222
line 626
;625:			//if enemy flag carrier is visible
;626:			c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 192
INDIRI4
ASGNI4
line 627
;627:			if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $274
line 629
;628:				//FIXME: fight enemy flag carrier
;629:			}
LABELV $274
line 631
;630:			//if not already doing something important
;631:			if (bs->ltgtype != LTG_GETFLAG &&
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 4
EQI4 $222
ADDRLP4 196
INDIRI4
CNSTI4 6
EQI4 $222
ADDRLP4 196
INDIRI4
CNSTI4 1
EQI4 $222
ADDRLP4 196
INDIRI4
CNSTI4 2
EQI4 $222
ADDRLP4 196
INDIRI4
CNSTI4 8
EQI4 $222
ADDRLP4 196
INDIRI4
CNSTI4 9
EQI4 $222
ADDRLP4 196
INDIRI4
CNSTI4 10
EQI4 $222
line 637
;632:					bs->ltgtype != LTG_RETURNFLAG &&
;633:					bs->ltgtype != LTG_TEAMHELP &&
;634:					bs->ltgtype != LTG_TEAMACCOMPANY &&
;635:					bs->ltgtype != LTG_CAMPORDER &&
;636:					bs->ltgtype != LTG_PATROL &&
;637:					bs->ltgtype != LTG_GETITEM) {
line 639
;638:
;639:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 640
;640:				bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 641
;641:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 643
;642:				//
;643:				if (random() < 0.5) {
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $278
line 645
;644:					//go for the enemy flag
;645:					bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 4
ASGNI4
line 646
;646:				} else {
ADDRGP4 $279
JUMPV
LABELV $278
line 647
;647:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 6
ASGNI4
line 648
;648:				}
LABELV $279
line 650
;649:				//no team message
;650:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 652
;651:				//set the time the bot will stop getting the flag
;652:				bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 654
;653:				//get an alternative route goal towards the enemy base
;654:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 656
;655:				//
;656:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 657
;657:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 658
;658:			}
line 659
;659:		}
line 660
;660:		return;
ADDRGP4 $222
JUMPV
LABELV $270
line 662
;661:	}		//if both flags Not at their bases
;662:	else if (flagstatus == 3) {
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $280
line 664
;663:		//
;664:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $222
line 666
;665:			// if not trying to return the flag and not following the team flag carrier
;666:			if (bs->ltgtype != LTG_RETURNFLAG && bs->ltgtype != LTG_TEAMACCOMPANY) {
ADDRLP4 192
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 6
EQI4 $222
ADDRLP4 192
INDIRI4
CNSTI4 2
EQI4 $222
line 668
;667:				//
;668:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 196
INDIRI4
ASGNI4
line 670
;669:				// if there is a visible team mate flag carrier
;670:				if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $286
line 671
;671:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 673
;672:					//follow the flag carrier
;673:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 674
;674:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 676
;675:					//the team mate
;676:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 678
;677:					//last time the team mate was visible
;678:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 680
;679:					//no message
;680:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 682
;681:					//no arrive message
;682:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTF4 1065353216
ASGNF4
line 684
;683:					//
;684:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 204
INDIRP4
ARGP4
ADDRLP4 204
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRGP4 $269
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 686
;685:					//get the team goal time
;686:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 687
;687:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 2
ASGNI4
line 688
;688:					bs->formation_dist = 3.5 * 32; //3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 6872
ADDP4
CNSTF4 1121976320
ASGNF4
line 690
;689:					//
;690:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 691
;691:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 692
;692:				} else {
ADDRGP4 $222
JUMPV
LABELV $286
line 693
;693:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 694
;694:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 695
;695:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 697
;696:					//get the enemy flag
;697:					bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 204
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
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 699
;698:					//get the flag
;699:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 6
ASGNI4
line 701
;700:					//set the time the bot will stop getting the flag
;701:					bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 703
;702:					//get an alternative route goal towards the enemy base
;703:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 705
;704:					//
;705:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 706
;706:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 707
;707:				}
line 708
;708:			}
line 709
;709:		}
line 710
;710:		return;
ADDRGP4 $222
JUMPV
LABELV $280
line 713
;711:	}
;712:	// don't just do something wait for the bot team leader to give orders
;713:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $288
line 714
;714:		return;
ADDRGP4 $222
JUMPV
LABELV $288
line 717
;715:	}
;716:	// if the bot is ordered to do something
;717:	if (bs->lastgoal_ltgtype) {
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
CNSTI4 0
EQI4 $290
line 718
;718:		bs->teamgoal_time += 60;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 719
;719:	}
LABELV $290
line 721
;720:	// if the bot decided to do something on it's own and has a last ordered goal
;721:	if (!bs->ordered && bs->lastgoal_ltgtype) {
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
CNSTI4 0
ASGNI4
ADDRLP4 196
INDIRP4
CNSTI4 6468
ADDP4
INDIRI4
ADDRLP4 200
INDIRI4
NEI4 $292
ADDRLP4 196
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
ADDRLP4 200
INDIRI4
EQI4 $292
line 722
;722:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 723
;723:	}
LABELV $292
line 725
;724:	//if already a CTF or team goal
;725:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 204
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 1
EQI4 $305
ADDRLP4 204
INDIRI4
CNSTI4 2
EQI4 $305
ADDRLP4 204
INDIRI4
CNSTI4 3
EQI4 $305
ADDRLP4 204
INDIRI4
CNSTI4 4
EQI4 $305
ADDRLP4 204
INDIRI4
CNSTI4 5
EQI4 $305
ADDRLP4 204
INDIRI4
CNSTI4 6
EQI4 $305
ADDRLP4 204
INDIRI4
CNSTI4 8
EQI4 $305
ADDRLP4 204
INDIRI4
CNSTI4 9
EQI4 $305
ADDRLP4 204
INDIRI4
CNSTI4 10
EQI4 $305
ADDRLP4 204
INDIRI4
CNSTI4 14
EQI4 $305
ADDRLP4 204
INDIRI4
CNSTI4 15
NEI4 $294
LABELV $305
line 735
;726:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;727:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;728:			bs->ltgtype == LTG_GETFLAG ||
;729:			bs->ltgtype == LTG_RUSHBASE ||
;730:			bs->ltgtype == LTG_RETURNFLAG ||
;731:			bs->ltgtype == LTG_CAMPORDER ||
;732:			bs->ltgtype == LTG_PATROL ||
;733:			bs->ltgtype == LTG_GETITEM ||
;734:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;735:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 736
;736:		return;
ADDRGP4 $222
JUMPV
LABELV $294
line 739
;737:	}
;738:	//
;739:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $306
line 740
;740:		return;
ADDRGP4 $222
JUMPV
LABELV $306
line 742
;741:	//
;742:	if (bs->owndecision_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
LEF4 $308
line 743
;743:		return;
ADDRGP4 $222
JUMPV
LABELV $308
line 744
;744:	;
line 746
;745:	//if the bot is roaming
;746:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $310
line 747
;747:		return;
ADDRGP4 $222
JUMPV
LABELV $310
line 749
;748:	//if the bot has anough aggression to decide what to do
;749:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 212
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 212
INDIRF4
CNSTF4 1112014848
GEF4 $312
line 750
;750:		return;
ADDRGP4 $222
JUMPV
LABELV $312
line 752
;751:	//set the time to send a message to the team mates
;752:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 216
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
ADDRLP4 216
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 754
;753:	//
;754:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER | TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $314
line 755
;755:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $316
line 756
;756:			l1 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 757
;757:		} else {
ADDRGP4 $317
JUMPV
LABELV $316
line 758
;758:			l1 = 0.2f;
ADDRLP4 8
CNSTF4 1045220557
ASGNF4
line 759
;759:		}
LABELV $317
line 760
;760:		l2 = 0.9f;
ADDRLP4 12
CNSTF4 1063675494
ASGNF4
line 761
;761:	} else {
ADDRGP4 $315
JUMPV
LABELV $314
line 762
;762:		l1 = 0.4f;
ADDRLP4 8
CNSTF4 1053609165
ASGNF4
line 763
;763:		l2 = 0.7f;
ADDRLP4 12
CNSTF4 1060320051
ASGNF4
line 764
;764:	}
LABELV $315
line 766
;765:	//get the flag or defend the base
;766:	rnd = random();
ADDRLP4 220
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 220
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ASGNF4
line 767
;767:	if (rnd < l1 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $318
ADDRLP4 224
CNSTI4 0
ASGNI4
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 224
INDIRI4
EQI4 $318
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 224
INDIRI4
EQI4 $318
line 768
;768:		bs->decisionmaker = bs->client;
ADDRLP4 228
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 228
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 228
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 769
;769:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 770
;770:		bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 4
ASGNI4
line 772
;771:		//set the time the bot will stop getting the flag
;772:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 774
;773:		//get an alternative route goal towards the enemy base
;774:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 232
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 232
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 775
;775:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 776
;776:	} else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRGP4 $319
JUMPV
LABELV $318
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $322
ADDRLP4 228
CNSTI4 0
ASGNI4
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 228
INDIRI4
EQI4 $322
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 228
INDIRI4
EQI4 $322
line 777
;777:		bs->decisionmaker = bs->client;
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 232
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 232
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 778
;778:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 780
;779:		//
;780:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 236
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 1
NEI4 $326
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $327
JUMPV
LABELV $326
line 781
;781:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $327
line 783
;782:		//set the ltg type
;783:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 3
ASGNI4
line 785
;784:		//set the time the bot stops defending the base
;785:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 786
;786:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
CNSTF4 0
ASGNF4
line 787
;787:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 788
;788:	} else {
ADDRGP4 $323
JUMPV
LABELV $322
line 789
;789:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 791
;790:		//set the time the bot will stop roaming
;791:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 792
;792:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 793
;793:	}
LABELV $323
LABELV $319
line 794
;794:	bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 798
;795:#ifdef DEBUG
;796:	BotPrintTeamGoal(bs);
;797:#endif //DEBUG
;798:}
LABELV $222
endproc BotCTFSeekGoals 240 12
export BotCTFRetreatGoals
proc BotCTFRetreatGoals 8 4
line 805
;799:
;800:/*
;801:==================
;802:BotCTFRetreatGoals
;803:==================
;804: */
;805:void BotCTFRetreatGoals(bot_state_t *bs) {
line 807
;806:	//when carrying a flag in ctf the bot should rush to the base
;807:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $329
line 809
;808:		//if not already rushing to the base
;809:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 5
EQI4 $331
line 810
;810:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 811
;811:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 5
ASGNI4
line 812
;812:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 813
;813:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTF4 0
ASGNF4
line 814
;814:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 815
;815:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 816
;816:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 817
;817:		}
LABELV $331
line 818
;818:	}
LABELV $329
line 819
;819:}
LABELV $328
endproc BotCTFRetreatGoals 8 4
export BotDDSeekGoals
proc BotDDSeekGoals 20 12
line 856
;820:
;821:/*
;822:==================
;823:BotDomSeekGoals
;824:==================
;825: */
;826:
;827:/*void BotDomSeekGoals(bot_state_t *bs) {
;828:	int index;
;829:	bs->ltgtype = LTG_DOMHOLD; //For debugging we are forcing roam
;830:    
;831:	index=0;
;832:	//dom_points_bot[i]
;833:    
;834:	if(bs->ltgtype == LTG_DOMHOLD) {
;835:		//index = 0;
;836:		index = ((rand()) % (level.domination_points_count));
;837:	}
;838:    
;839:	//if(bs->ltgtype == LTG_DOMROAM) {
;840:        
;841:	//}
;842:        
;843:	memcpy(&bs->teamgoal, &dom_points_bot[index], sizeof(bot_goal_t));
;844:
;845:	BotAlternateRoute(bs, &bs->teamgoal);
;846:
;847:	BotSetTeamStatus(bs);
;848:}*/
;849:
;850:/*
;851:==================
;852:BotDDSeekGoals
;853:==================
;854: */
;855:
;856:void BotDDSeekGoals(bot_state_t *bs) {
line 866
;857:
;858:	/*if (bs->ltgtype == LTG_TEAMHELP ||
;859:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;860:			bs->ltgtype == LTG_CAMPORDER ||
;861:			bs->ltgtype == LTG_PATROL ||
;862:			bs->ltgtype == LTG_GETITEM) {
;863:		return;
;864:	}*/
;865:
;866:	if (bs->ltgtype == LTG_POINTA)
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 16
NEI4 $334
line 867
;867:		memcpy(&bs->teamgoal, &ctf_redflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $334
line 868
;868:	if (bs->ltgtype == LTG_POINTB)
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 17
NEI4 $336
line 869
;869:		memcpy(&bs->teamgoal, &ctf_blueflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $336
line 871
;870:
;871:	if (bs->ltgtype == LTG_POINTA || bs->ltgtype == LTG_POINTB)
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
EQI4 $340
ADDRLP4 0
INDIRI4
CNSTI4 17
NEI4 $338
LABELV $340
line 872
;872:		return;
ADDRGP4 $333
JUMPV
LABELV $338
line 874
;873:
;874:	if (rand() % 2 == 0)
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
MODI4
CNSTI4 0
NEI4 $341
line 875
;875:		bs->ltgtype = LTG_POINTA;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 16
ASGNI4
ADDRGP4 $342
JUMPV
LABELV $341
line 877
;876:	else
;877:		bs->ltgtype = LTG_POINTB;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 17
ASGNI4
LABELV $342
line 879
;878:
;879:	if (bs->ltgtype == LTG_POINTA) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 16
NEI4 $343
line 880
;880:		memcpy(&bs->teamgoal, &ctf_redflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 881
;881:		if (BotTeam(bs) == TEAM_BLUE)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
NEI4 $345
line 882
;882:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_OFFENSE));
ADDRGP4 $196
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $195
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
ADDRGP4 $344
JUMPV
LABELV $345
line 884
;883:		else
;884:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_DEFENSE));
ADDRGP4 $196
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $195
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 885
;885:	} else
ADDRGP4 $344
JUMPV
LABELV $343
line 886
;886:		if (bs->ltgtype == LTG_POINTB) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 17
NEI4 $347
line 887
;887:		memcpy(&bs->teamgoal, &ctf_blueflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 888
;888:		if (BotTeam(bs) == TEAM_RED)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $349
line 889
;889:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_OFFENSE));
ADDRGP4 $196
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $195
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
ADDRGP4 $350
JUMPV
LABELV $349
line 891
;890:		else
;891:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_DEFENSE));
ADDRGP4 $196
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $195
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
LABELV $350
line 892
;892:	}
LABELV $347
LABELV $344
line 895
;893:
;894:
;895:}
LABELV $333
endproc BotDDSeekGoals 20 12
export Bot1FCTFSeekGoals
proc Bot1FCTFSeekGoals 208 12
line 902
;896:
;897:/*
;898:==================
;899:Bot1FCTFSeekGoals
;900:==================
;901: */
;902:void Bot1FCTFSeekGoals(bot_state_t *bs) {
line 908
;903:	aas_entityinfo_t entinfo;
;904:	float rnd, l1, l2;
;905:	int c;
;906:
;907:	//when carrying a flag in ctf the bot should rush to the base
;908:	if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $352
line 910
;909:		//if not already rushing to the base
;910:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 5
EQI4 $351
line 911
;911:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 912
;912:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 5
ASGNI4
line 913
;913:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 914
;914:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTF4 0
ASGNF4
line 915
;915:			bs->decisionmaker = bs->client;
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 160
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 916
;916:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 918
;917:			//get an alternative route goal towards the enemy base
;918:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 920
;919:			//
;920:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 921
;921:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $244
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 922
;922:		}
line 923
;923:		return;
ADDRGP4 $351
JUMPV
LABELV $352
line 926
;924:	}
;925:	// if the bot decided to follow someone
;926:	if (bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered) {
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 2
NEI4 $356
ADDRLP4 160
INDIRP4
CNSTI4 6468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $356
line 928
;927:		// if the team mate being accompanied no longer carries the flag
;928:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 929
;929:		if (!EntityCarriesFlag(&entinfo)) {
ADDRLP4 12
ARGP4
ADDRLP4 164
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $358
line 930
;930:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 931
;931:		}
LABELV $358
line 932
;932:	}
LABELV $356
line 934
;933:	//our team has the flag
;934:	if (bs->neutralflagstatus == 1) {
ADDRFP4 0
INDIRP4
CNSTI4 6820
ADDP4
INDIRI4
CNSTI4 1
NEI4 $360
line 935
;935:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $351
line 937
;936:			// if not already following someone
;937:			if (bs->ltgtype != LTG_TEAMACCOMPANY) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 2
EQI4 $364
line 939
;938:				//if there is a visible team mate flag carrier
;939:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 152
ADDRLP4 164
INDIRI4
ASGNI4
line 940
;940:				if (c >= 0) {
ADDRLP4 152
INDIRI4
CNSTI4 0
LTI4 $366
line 941
;941:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 943
;942:					//follow the flag carrier
;943:					bs->decisionmaker = bs->client;
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 168
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 944
;944:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 946
;945:					//the team mate
;946:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 948
;947:					//last time the team mate was visible
;948:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 950
;949:					//no message
;950:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 952
;951:					//no arrive message
;952:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTF4 1065353216
ASGNF4
line 954
;953:					//
;954:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRGP4 $269
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 956
;955:					//get the team goal time
;956:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 957
;957:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 2
ASGNI4
line 958
;958:					bs->formation_dist = 3.5 * 32; //3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 6872
ADDP4
CNSTF4 1121976320
ASGNF4
line 959
;959:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 960
;960:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 961
;961:					return;
ADDRGP4 $351
JUMPV
LABELV $366
line 963
;962:				}
;963:			}
LABELV $364
line 965
;964:			//if already a CTF or team goal
;965:			if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 1
EQI4 $379
ADDRLP4 164
INDIRI4
CNSTI4 2
EQI4 $379
ADDRLP4 164
INDIRI4
CNSTI4 3
EQI4 $379
ADDRLP4 164
INDIRI4
CNSTI4 4
EQI4 $379
ADDRLP4 164
INDIRI4
CNSTI4 5
EQI4 $379
ADDRLP4 164
INDIRI4
CNSTI4 8
EQI4 $379
ADDRLP4 164
INDIRI4
CNSTI4 9
EQI4 $379
ADDRLP4 164
INDIRI4
CNSTI4 13
EQI4 $379
ADDRLP4 164
INDIRI4
CNSTI4 10
EQI4 $379
ADDRLP4 164
INDIRI4
CNSTI4 14
EQI4 $379
ADDRLP4 164
INDIRI4
CNSTI4 15
NEI4 $368
LABELV $379
line 975
;966:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;967:					bs->ltgtype == LTG_DEFENDKEYAREA ||
;968:					bs->ltgtype == LTG_GETFLAG ||
;969:					bs->ltgtype == LTG_RUSHBASE ||
;970:					bs->ltgtype == LTG_CAMPORDER ||
;971:					bs->ltgtype == LTG_PATROL ||
;972:					bs->ltgtype == LTG_ATTACKENEMYBASE ||
;973:					bs->ltgtype == LTG_GETITEM ||
;974:					bs->ltgtype == LTG_MAKELOVE_UNDER ||
;975:					bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 976
;976:				return;
ADDRGP4 $351
JUMPV
LABELV $368
line 979
;977:			}
;978:			//if not already attacking the enemy base
;979:			if (bs->ltgtype != LTG_ATTACKENEMYBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 13
EQI4 $351
line 980
;980:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 981
;981:				bs->decisionmaker = bs->client;
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 168
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 982
;982:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 984
;983:				//
;984:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_blueflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 1
NEI4 $382
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $383
JUMPV
LABELV $382
line 985
;985:				else memcpy(&bs->teamgoal, &ctf_redflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $383
line 987
;986:				//set the ltg type
;987:				bs->ltgtype = LTG_ATTACKENEMYBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 13
ASGNI4
line 989
;988:				//set the time the bot will stop getting the flag
;989:				bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 990
;990:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 991
;991:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 992
;992:			}
line 993
;993:		}
line 994
;994:		return;
ADDRGP4 $351
JUMPV
LABELV $360
line 996
;995:	}		//enemy team has the flag
;996:	else if (bs->neutralflagstatus == 2) {
ADDRFP4 0
INDIRP4
CNSTI4 6820
ADDP4
INDIRI4
CNSTI4 2
NEI4 $384
line 997
;997:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $351
line 998
;998:			c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 152
ADDRLP4 164
INDIRI4
ASGNI4
line 999
;999:			if (c >= 0) {
ADDRLP4 152
INDIRI4
CNSTI4 0
LTI4 $388
line 1001
;1000:				//FIXME: attack enemy flag carrier
;1001:			}
LABELV $388
line 1003
;1002:			//if already a CTF or team goal
;1003:			if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 1
EQI4 $395
ADDRLP4 168
INDIRI4
CNSTI4 2
EQI4 $395
ADDRLP4 168
INDIRI4
CNSTI4 8
EQI4 $395
ADDRLP4 168
INDIRI4
CNSTI4 9
EQI4 $395
ADDRLP4 168
INDIRI4
CNSTI4 10
NEI4 $390
LABELV $395
line 1007
;1004:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;1005:					bs->ltgtype == LTG_CAMPORDER ||
;1006:					bs->ltgtype == LTG_PATROL ||
;1007:					bs->ltgtype == LTG_GETITEM) {
line 1008
;1008:				return;
ADDRGP4 $351
JUMPV
LABELV $390
line 1011
;1009:			}
;1010:			// if not already defending the base
;1011:			if (bs->ltgtype != LTG_DEFENDKEYAREA) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 3
EQI4 $351
line 1012
;1012:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 1013
;1013:				bs->decisionmaker = bs->client;
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 172
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1014
;1014:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1016
;1015:				//
;1016:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof (bot_goal_t));
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
NEI4 $398
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $399
JUMPV
LABELV $398
line 1017
;1017:				else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $399
line 1019
;1018:				//set the ltg type
;1019:				bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 3
ASGNI4
line 1021
;1020:				//set the time the bot stops defending the base
;1021:				bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1022
;1022:				bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
CNSTF4 0
ASGNF4
line 1023
;1023:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1024
;1024:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 1025
;1025:			}
line 1026
;1026:		}
line 1027
;1027:		return;
ADDRGP4 $351
JUMPV
LABELV $384
line 1030
;1028:	}
;1029:	// don't just do something wait for the bot team leader to give orders
;1030:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $400
line 1031
;1031:		return;
ADDRGP4 $351
JUMPV
LABELV $400
line 1034
;1032:	}
;1033:	// if the bot is ordered to do something
;1034:	if (bs->lastgoal_ltgtype) {
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
CNSTI4 0
EQI4 $402
line 1035
;1035:		bs->teamgoal_time += 60;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1036
;1036:	}
LABELV $402
line 1038
;1037:	// if the bot decided to do something on it's own and has a last ordered goal
;1038:	if (!bs->ordered && bs->lastgoal_ltgtype) {
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
CNSTI4 0
ASGNI4
ADDRLP4 168
INDIRP4
CNSTI4 6468
ADDP4
INDIRI4
ADDRLP4 172
INDIRI4
NEI4 $404
ADDRLP4 168
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
ADDRLP4 172
INDIRI4
EQI4 $404
line 1039
;1039:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 1040
;1040:	}
LABELV $404
line 1042
;1041:	//if already a CTF or team goal
;1042:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 1
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 2
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 3
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 4
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 5
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 6
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 8
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 9
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 13
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 10
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 14
EQI4 $418
ADDRLP4 176
INDIRI4
CNSTI4 15
NEI4 $406
LABELV $418
line 1053
;1043:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1044:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1045:			bs->ltgtype == LTG_GETFLAG ||
;1046:			bs->ltgtype == LTG_RUSHBASE ||
;1047:			bs->ltgtype == LTG_RETURNFLAG ||
;1048:			bs->ltgtype == LTG_CAMPORDER ||
;1049:			bs->ltgtype == LTG_PATROL ||
;1050:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1051:			bs->ltgtype == LTG_GETITEM ||
;1052:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1053:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 1054
;1054:		return;
ADDRGP4 $351
JUMPV
LABELV $406
line 1057
;1055:	}
;1056:	//
;1057:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $419
line 1058
;1058:		return;
ADDRGP4 $351
JUMPV
LABELV $419
line 1060
;1059:	//
;1060:	if (bs->owndecision_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
LEF4 $421
line 1061
;1061:		return;
ADDRGP4 $351
JUMPV
LABELV $421
line 1062
;1062:	;
line 1064
;1063:	//if the bot is roaming
;1064:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $423
line 1065
;1065:		return;
ADDRGP4 $351
JUMPV
LABELV $423
line 1067
;1066:	//if the bot has anough aggression to decide what to do
;1067:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 184
INDIRF4
CNSTF4 1112014848
GEF4 $425
line 1068
;1068:		return;
ADDRGP4 $351
JUMPV
LABELV $425
line 1070
;1069:	//set the time to send a message to the team mates
;1070:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 188
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
ADDRLP4 188
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1072
;1071:	//
;1072:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER | TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $427
line 1073
;1073:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $429
line 1074
;1074:			l1 = 0.7f;
ADDRLP4 4
CNSTF4 1060320051
ASGNF4
line 1075
;1075:		} else {
ADDRGP4 $430
JUMPV
LABELV $429
line 1076
;1076:			l1 = 0.2f;
ADDRLP4 4
CNSTF4 1045220557
ASGNF4
line 1077
;1077:		}
LABELV $430
line 1078
;1078:		l2 = 0.9f;
ADDRLP4 8
CNSTF4 1063675494
ASGNF4
line 1079
;1079:	} else {
ADDRGP4 $428
JUMPV
LABELV $427
line 1080
;1080:		l1 = 0.4f;
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 1081
;1081:		l2 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 1082
;1082:	}
LABELV $428
line 1084
;1083:	//get the flag or defend the base
;1084:	rnd = random();
ADDRLP4 192
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 192
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ASGNF4
line 1085
;1085:	if (rnd < l1 && ctf_neutralflag.areanum) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $431
ADDRGP4 ctf_neutralflag+12
INDIRI4
CNSTI4 0
EQI4 $431
line 1086
;1086:		bs->decisionmaker = bs->client;
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 196
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1087
;1087:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1088
;1088:		bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 4
ASGNI4
line 1090
;1089:		//set the time the bot will stop getting the flag
;1090:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1091
;1091:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1092
;1092:	} else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRGP4 $432
JUMPV
LABELV $431
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $434
ADDRLP4 196
CNSTI4 0
ASGNI4
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 196
INDIRI4
EQI4 $434
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 196
INDIRI4
EQI4 $434
line 1093
;1093:		bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1094
;1094:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1096
;1095:		//
;1096:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 1
NEI4 $438
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $439
JUMPV
LABELV $438
line 1097
;1097:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $439
line 1099
;1098:		//set the ltg type
;1099:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 3
ASGNI4
line 1101
;1100:		//set the time the bot stops defending the base
;1101:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1102
;1102:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
CNSTF4 0
ASGNF4
line 1103
;1103:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1104
;1104:	} else {
ADDRGP4 $435
JUMPV
LABELV $434
line 1105
;1105:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 1107
;1106:		//set the time the bot will stop roaming
;1107:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1108
;1108:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1109
;1109:	}
LABELV $435
LABELV $432
line 1110
;1110:	bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6476
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 1114
;1111:#ifdef DEBUG
;1112:	BotPrintTeamGoal(bs);
;1113:#endif //DEBUG
;1114:}
LABELV $351
endproc Bot1FCTFSeekGoals 208 12
export Bot1FCTFRetreatGoals
proc Bot1FCTFRetreatGoals 12 8
line 1121
;1115:
;1116:/*
;1117:==================
;1118:Bot1FCTFRetreatGoals
;1119:==================
;1120: */
;1121:void Bot1FCTFRetreatGoals(bot_state_t *bs) {
line 1123
;1122:	//when carrying a flag in ctf the bot should rush to the enemy base
;1123:	if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $441
line 1125
;1124:		//if not already rushing to the base
;1125:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 5
EQI4 $443
line 1126
;1126:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 1127
;1127:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 5
ASGNI4
line 1128
;1128:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1129
;1129:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTF4 0
ASGNF4
line 1130
;1130:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1131
;1131:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1133
;1132:			//get an alternative route goal towards the enemy base
;1133:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 1134
;1134:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1135
;1135:		}
LABELV $443
line 1136
;1136:	}
LABELV $441
line 1137
;1137:}
LABELV $440
endproc Bot1FCTFRetreatGoals 12 8
export BotObeliskSeekGoals
proc BotObeliskSeekGoals 52 12
line 1144
;1138:
;1139:/*
;1140:==================
;1141:BotObeliskSeekGoals
;1142:==================
;1143: */
;1144:void BotObeliskSeekGoals(bot_state_t *bs) {
line 1148
;1145:	float rnd, l1, l2;
;1146:
;1147:	// don't just do something wait for the bot team leader to give orders
;1148:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $446
line 1149
;1149:		return;
ADDRGP4 $445
JUMPV
LABELV $446
line 1152
;1150:	}
;1151:	// if the bot is ordered to do something
;1152:	if (bs->lastgoal_ltgtype) {
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
CNSTI4 0
EQI4 $448
line 1153
;1153:		bs->teamgoal_time += 60;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1154
;1154:	}
LABELV $448
line 1156
;1155:	//if already a team goal
;1156:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 3
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 4
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 5
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 6
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 8
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 9
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 10
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 14
EQI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 15
NEI4 $450
LABELV $462
line 1167
;1157:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1158:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1159:			bs->ltgtype == LTG_GETFLAG ||
;1160:			bs->ltgtype == LTG_RUSHBASE ||
;1161:			bs->ltgtype == LTG_RETURNFLAG ||
;1162:			bs->ltgtype == LTG_CAMPORDER ||
;1163:			bs->ltgtype == LTG_PATROL ||
;1164:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1165:			bs->ltgtype == LTG_GETITEM ||
;1166:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1167:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 1168
;1168:		return;
ADDRGP4 $445
JUMPV
LABELV $450
line 1171
;1169:	}
;1170:	//
;1171:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $463
line 1172
;1172:		return;
ADDRGP4 $445
JUMPV
LABELV $463
line 1174
;1173:	//if the bot is roaming
;1174:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $465
line 1175
;1175:		return;
ADDRGP4 $445
JUMPV
LABELV $465
line 1177
;1176:	//if the bot has anough aggression to decide what to do
;1177:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 1112014848
GEF4 $467
line 1178
;1178:		return;
ADDRGP4 $445
JUMPV
LABELV $467
line 1180
;1179:	//set the time to send a message to the team mates
;1180:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 28
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
ADDRLP4 28
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1182
;1181:	//
;1182:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER | TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $469
line 1183
;1183:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $471
line 1184
;1184:			l1 = 0.7f;
ADDRLP4 4
CNSTF4 1060320051
ASGNF4
line 1185
;1185:		} else {
ADDRGP4 $472
JUMPV
LABELV $471
line 1186
;1186:			l1 = 0.2f;
ADDRLP4 4
CNSTF4 1045220557
ASGNF4
line 1187
;1187:		}
LABELV $472
line 1188
;1188:		l2 = 0.9f;
ADDRLP4 8
CNSTF4 1063675494
ASGNF4
line 1189
;1189:	} else {
ADDRGP4 $470
JUMPV
LABELV $469
line 1190
;1190:		l1 = 0.4f;
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 1191
;1191:		l2 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 1192
;1192:	}
LABELV $470
line 1194
;1193:	//get the flag or defend the base
;1194:	rnd = random();
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ASGNF4
line 1195
;1195:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $473
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 redobelisk+12
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $473
ADDRGP4 blueobelisk+12
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $473
line 1196
;1196:		bs->decisionmaker = bs->client;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1197
;1197:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1199
;1198:		//
;1199:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
NEI4 $477
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $478
JUMPV
LABELV $477
line 1200
;1200:		else memcpy(&bs->teamgoal, &redobelisk, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $478
line 1202
;1201:		//set the ltg type
;1202:		bs->ltgtype = LTG_ATTACKENEMYBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 13
ASGNI4
line 1204
;1203:		//set the time the bot will stop attacking the enemy base
;1204:		bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1206
;1205:		//get an alternate route goal towards the enemy base
;1206:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 1207
;1207:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1208
;1208:	} else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
ADDRGP4 $474
JUMPV
LABELV $473
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $479
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 redobelisk+12
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $479
ADDRGP4 blueobelisk+12
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $479
line 1209
;1209:		bs->decisionmaker = bs->client;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1210
;1210:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1212
;1211:		//
;1212:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 1
NEI4 $483
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $484
JUMPV
LABELV $483
line 1213
;1213:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $484
line 1215
;1214:		//set the ltg type
;1215:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 3
ASGNI4
line 1217
;1216:		//set the time the bot stops defending the base
;1217:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1218
;1218:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
CNSTF4 0
ASGNF4
line 1219
;1219:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1220
;1220:	} else {
ADDRGP4 $480
JUMPV
LABELV $479
line 1221
;1221:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 1223
;1222:		//set the time the bot will stop roaming
;1223:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1224
;1224:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1225
;1225:	}
LABELV $480
LABELV $474
line 1226
;1226:}
LABELV $445
endproc BotObeliskSeekGoals 52 12
export BotGoHarvest
proc BotGoHarvest 4 12
line 1233
;1227:
;1228:/*
;1229:==================
;1230:BotGoHarvest
;1231:==================
;1232: */
;1233:void BotGoHarvest(bot_state_t *bs) {
line 1235
;1234:	//
;1235:	if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $486
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $487
JUMPV
LABELV $486
line 1236
;1236:	else memcpy(&bs->teamgoal, &redobelisk, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $487
line 1238
;1237:	//set the ltg type
;1238:	bs->ltgtype = LTG_HARVEST;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 12
ASGNI4
line 1240
;1239:	//set the time the bot will stop harvesting
;1240:	bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1241
;1241:	bs->harvestaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTF4 0
ASGNF4
line 1242
;1242:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1243
;1243:}
LABELV $485
endproc BotGoHarvest 4 12
export BotObeliskRetreatGoals
proc BotObeliskRetreatGoals 0 0
line 1250
;1244:
;1245:/*
;1246:==================
;1247:BotObeliskRetreatGoals
;1248:==================
;1249: */
;1250:void BotObeliskRetreatGoals(bot_state_t *bs) {
line 1252
;1251:	//nothing special
;1252:}
LABELV $488
endproc BotObeliskRetreatGoals 0 0
export BotHarvesterSeekGoals
proc BotHarvesterSeekGoals 208 12
line 1259
;1253:
;1254:/*
;1255:==================
;1256:BotHarvesterSeekGoals
;1257:==================
;1258: */
;1259:void BotHarvesterSeekGoals(bot_state_t *bs) {
line 1265
;1260:	aas_entityinfo_t entinfo;
;1261:	float rnd, l1, l2;
;1262:	int c;
;1263:
;1264:	//when carrying cubes in harvester the bot should rush to the base
;1265:	if (BotHarvesterCarryingCubes(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $490
line 1267
;1266:		//if not already rushing to the base
;1267:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 5
EQI4 $489
line 1268
;1268:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 1269
;1269:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 5
ASGNI4
line 1270
;1270:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1271
;1271:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTF4 0
ASGNF4
line 1272
;1272:			bs->decisionmaker = bs->client;
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 160
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1273
;1273:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1275
;1274:			//get an alternative route goal towards the enemy base
;1275:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 1277
;1276:			//
;1277:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1278
;1278:		}
line 1279
;1279:		return;
ADDRGP4 $489
JUMPV
LABELV $490
line 1282
;1280:	}
;1281:	// don't just do something wait for the bot team leader to give orders
;1282:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $494
line 1283
;1283:		return;
ADDRGP4 $489
JUMPV
LABELV $494
line 1286
;1284:	}
;1285:	// if the bot decided to follow someone
;1286:	if (bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered) {
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 2
NEI4 $496
ADDRLP4 164
INDIRP4
CNSTI4 6468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $496
line 1288
;1287:		// if the team mate being accompanied no longer carries the flag
;1288:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1289
;1289:		if (!EntityCarriesCubes(&entinfo)) {
ADDRLP4 16
ARGP4
ADDRLP4 168
ADDRGP4 EntityCarriesCubes
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $498
line 1290
;1290:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 1291
;1291:		}
LABELV $498
line 1292
;1292:	}
LABELV $496
line 1294
;1293:	// if the bot is ordered to do something
;1294:	if (bs->lastgoal_ltgtype) {
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
CNSTI4 0
EQI4 $500
line 1295
;1295:		bs->teamgoal_time += 60;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1296
;1296:	}
LABELV $500
line 1298
;1297:	//if not yet doing something
;1298:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 1
EQI4 $513
ADDRLP4 168
INDIRI4
CNSTI4 2
EQI4 $513
ADDRLP4 168
INDIRI4
CNSTI4 3
EQI4 $513
ADDRLP4 168
INDIRI4
CNSTI4 4
EQI4 $513
ADDRLP4 168
INDIRI4
CNSTI4 8
EQI4 $513
ADDRLP4 168
INDIRI4
CNSTI4 9
EQI4 $513
ADDRLP4 168
INDIRI4
CNSTI4 13
EQI4 $513
ADDRLP4 168
INDIRI4
CNSTI4 12
EQI4 $513
ADDRLP4 168
INDIRI4
CNSTI4 10
EQI4 $513
ADDRLP4 168
INDIRI4
CNSTI4 14
EQI4 $513
ADDRLP4 168
INDIRI4
CNSTI4 15
NEI4 $502
LABELV $513
line 1308
;1299:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1300:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1301:			bs->ltgtype == LTG_GETFLAG ||
;1302:			bs->ltgtype == LTG_CAMPORDER ||
;1303:			bs->ltgtype == LTG_PATROL ||
;1304:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1305:			bs->ltgtype == LTG_HARVEST ||
;1306:			bs->ltgtype == LTG_GETITEM ||
;1307:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1308:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 1309
;1309:		return;
ADDRGP4 $489
JUMPV
LABELV $502
line 1312
;1310:	}
;1311:	//
;1312:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $514
line 1313
;1313:		return;
ADDRGP4 $489
JUMPV
LABELV $514
line 1315
;1314:	//if the bot is roaming
;1315:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $516
line 1316
;1316:		return;
ADDRGP4 $489
JUMPV
LABELV $516
line 1318
;1317:	//if the bot has anough aggression to decide what to do
;1318:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 176
INDIRF4
CNSTF4 1112014848
GEF4 $518
line 1319
;1319:		return;
ADDRGP4 $489
JUMPV
LABELV $518
line 1321
;1320:	//set the time to send a message to the team mates
;1321:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 180
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
ADDRLP4 180
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1323
;1322:	//
;1323:	c = BotEnemyCubeCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotEnemyCubeCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 184
INDIRI4
ASGNI4
line 1324
;1324:	if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $520
line 1326
;1325:		//FIXME: attack enemy cube carrier
;1326:	}
LABELV $520
line 1327
;1327:	if (bs->ltgtype != LTG_TEAMACCOMPANY) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 2
EQI4 $522
line 1329
;1328:		//if there is a visible team mate carrying cubes
;1329:		c = BotTeamCubeCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 BotTeamCubeCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 188
INDIRI4
ASGNI4
line 1330
;1330:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $524
line 1332
;1331:			//follow the team mate carrying cubes
;1332:			bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1333
;1333:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1335
;1334:			//the team mate
;1335:			bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1337
;1336:			//last time the team mate was visible
;1337:			bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1339
;1338:			//no message
;1339:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 1341
;1340:			//no arrive message
;1341:			bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTF4 1065353216
ASGNF4
line 1343
;1342:			//
;1343:			BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRLP4 196
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRGP4 $269
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1345
;1344:			//get the team goal time
;1345:			bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1346
;1346:			bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 2
ASGNI4
line 1347
;1347:			bs->formation_dist = 3.5 * 32; //3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 6872
ADDP4
CNSTF4 1121976320
ASGNF4
line 1348
;1348:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1349
;1349:			return;
ADDRGP4 $489
JUMPV
LABELV $524
line 1351
;1350:		}
;1351:	}
LABELV $522
line 1353
;1352:	//
;1353:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER | TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $526
line 1354
;1354:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $528
line 1355
;1355:			l1 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 1356
;1356:		} else {
ADDRGP4 $529
JUMPV
LABELV $528
line 1357
;1357:			l1 = 0.2f;
ADDRLP4 8
CNSTF4 1045220557
ASGNF4
line 1358
;1358:		}
LABELV $529
line 1359
;1359:		l2 = 0.9f;
ADDRLP4 12
CNSTF4 1063675494
ASGNF4
line 1360
;1360:	} else {
ADDRGP4 $527
JUMPV
LABELV $526
line 1361
;1361:		l1 = 0.4f;
ADDRLP4 8
CNSTF4 1053609165
ASGNF4
line 1362
;1362:		l2 = 0.7f;
ADDRLP4 12
CNSTF4 1060320051
ASGNF4
line 1363
;1363:	}
LABELV $527
line 1365
;1364:	//
;1365:	rnd = random();
ADDRLP4 188
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 188
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ASGNF4
line 1366
;1366:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $530
ADDRLP4 192
CNSTI4 0
ASGNI4
ADDRGP4 redobelisk+12
INDIRI4
ADDRLP4 192
INDIRI4
EQI4 $530
ADDRGP4 blueobelisk+12
INDIRI4
ADDRLP4 192
INDIRI4
EQI4 $530
line 1367
;1367:		bs->decisionmaker = bs->client;
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 196
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1368
;1368:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1369
;1369:		BotGoHarvest(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoHarvest
CALLV
pop
line 1370
;1370:	} else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
ADDRGP4 $531
JUMPV
LABELV $530
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $534
ADDRLP4 196
CNSTI4 0
ASGNI4
ADDRGP4 redobelisk+12
INDIRI4
ADDRLP4 196
INDIRI4
EQI4 $534
ADDRGP4 blueobelisk+12
INDIRI4
ADDRLP4 196
INDIRI4
EQI4 $534
line 1371
;1371:		bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1372
;1372:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1374
;1373:		//
;1374:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 1
NEI4 $538
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $539
JUMPV
LABELV $538
line 1375
;1375:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $539
line 1377
;1376:		//set the ltg type
;1377:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 3
ASGNI4
line 1379
;1378:		//set the time the bot stops defending the base
;1379:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1380
;1380:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
CNSTF4 0
ASGNF4
line 1381
;1381:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1382
;1382:	} else {
ADDRGP4 $535
JUMPV
LABELV $534
line 1383
;1383:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 1385
;1384:		//set the time the bot will stop roaming
;1385:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1386
;1386:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1387
;1387:	}
LABELV $535
LABELV $531
line 1388
;1388:}
LABELV $489
endproc BotHarvesterSeekGoals 208 12
export BotHarvesterRetreatGoals
proc BotHarvesterRetreatGoals 8 4
line 1395
;1389:
;1390:/*
;1391:==================
;1392:BotHarvesterRetreatGoals
;1393:==================
;1394: */
;1395:void BotHarvesterRetreatGoals(bot_state_t *bs) {
line 1397
;1396:	//when carrying cubes in harvester the bot should rush to the base
;1397:	if (BotHarvesterCarryingCubes(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $541
line 1399
;1398:		//if not already rushing to the base
;1399:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 5
EQI4 $540
line 1400
;1400:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 1401
;1401:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 5
ASGNI4
line 1402
;1402:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1403
;1403:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTF4 0
ASGNF4
line 1404
;1404:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1405
;1405:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 1406
;1406:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1407
;1407:		}
line 1408
;1408:		return;
LABELV $541
line 1410
;1409:	}
;1410:}
LABELV $540
endproc BotHarvesterRetreatGoals 8 4
export BotTeamGoals
proc BotTeamGoals 12 4
line 1418
;1411://#endif
;1412:
;1413:/*
;1414:==================
;1415:BotTeamGoals
;1416:==================
;1417: */
;1418:void BotTeamGoals(bot_state_t *bs, int retreat) {
line 1420
;1419:
;1420:	if (retreat) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $546
line 1421
;1421:		if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $548
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $548
line 1422
;1422:			BotCTFRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFRetreatGoals
CALLV
pop
line 1423
;1423:		} else if (G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 $547
JUMPV
LABELV $548
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $550
line 1424
;1424:			Bot1FCTFRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFRetreatGoals
CALLV
pop
line 1425
;1425:		} else if (gametype == GT_OBELISK) {
ADDRGP4 $547
JUMPV
LABELV $550
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $552
line 1426
;1426:			BotObeliskRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotObeliskRetreatGoals
CALLV
pop
line 1427
;1427:		} else if (gametype == GT_HARVESTER) {
ADDRGP4 $547
JUMPV
LABELV $552
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $547
line 1428
;1428:			BotHarvesterRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotHarvesterRetreatGoals
CALLV
pop
line 1429
;1429:		}
line 1430
;1430:	} else {
ADDRGP4 $547
JUMPV
LABELV $546
line 1431
;1431:		if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $556
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $556
line 1433
;1432:			//decide what to do in CTF mode
;1433:			BotCTFSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFSeekGoals
CALLV
pop
line 1434
;1434:		} else if (G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 $557
JUMPV
LABELV $556
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $558
line 1435
;1435:			Bot1FCTFSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFSeekGoals
CALLV
pop
line 1436
;1436:		} else if (gametype == GT_OBELISK) {
ADDRGP4 $559
JUMPV
LABELV $558
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $560
line 1437
;1437:			BotObeliskSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotObeliskSeekGoals
CALLV
pop
line 1438
;1438:		} else if (gametype == GT_HARVESTER) {
ADDRGP4 $561
JUMPV
LABELV $560
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $562
line 1439
;1439:			BotHarvesterSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotHarvesterSeekGoals
CALLV
pop
line 1440
;1440:		}
LABELV $562
LABELV $561
LABELV $559
LABELV $557
line 1441
;1441:	}
LABELV $547
line 1443
;1442:
;1443:	if (gametype == GT_DOUBLE_D) //Don't care about retreat
ADDRGP4 gametype
INDIRI4
CNSTI4 11
NEI4 $564
line 1444
;1444:		BotDDSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDDSeekGoals
CALLV
pop
LABELV $564
line 1451
;1445:
;1446:	//if(gametype == GT_DOMINATION) //Don't care about retreat
;1447:	//	BotDomSeekGoals(bs);
;1448:
;1449:	// reset the order time which is used to see if
;1450:	// we decided to refuse an order
;1451:	bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
CNSTF4 0
ASGNF4
line 1452
;1452:}
LABELV $545
endproc BotTeamGoals 12 4
export BotPointAreaNum
proc BotPointAreaNum 68 20
line 1459
;1453:
;1454:/*
;1455:==================
;1456:BotPointAreaNum
;1457:==================
;1458: */
;1459:int BotPointAreaNum(vec3_t origin) {
line 1463
;1460:	int areanum, numareas, areas[10];
;1461:	vec3_t end;
;1462:
;1463:	areanum = trap_AAS_PointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 trap_AAS_PointAreaNum
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 1464
;1464:	if (areanum) return areanum;
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $567
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $566
JUMPV
LABELV $567
line 1465
;1465:	VectorCopy(origin, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1466
;1466:	end[2] += 10;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1467
;1467:	numareas = trap_AAS_TraceAreas(origin, end, areas, NULL, 10);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 64
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
ASGNI4
line 1468
;1468:	if (numareas > 0) return areas[0];
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $570
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $566
JUMPV
LABELV $570
line 1469
;1469:	return 0;
CNSTI4 0
RETI4
LABELV $566
endproc BotPointAreaNum 68 20
export ClientName
proc ClientName 1032 12
line 1477
;1470:}
;1471:
;1472:/*
;1473:==================
;1474:ClientName
;1475:==================
;1476: */
;1477:char *ClientName(int client, char *name, int size) {
line 1480
;1478:	char buf[MAX_INFO_STRING];
;1479:
;1480:	if (client < 0 || client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $575
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $573
LABELV $575
line 1481
;1481:		BotAI_Print(PRT_ERROR, "ClientName: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $576
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1482
;1482:		return "[client out of range]";
ADDRGP4 $577
RETP4
ADDRGP4 $572
JUMPV
LABELV $573
line 1484
;1483:	}
;1484:	trap_GetConfigstring(CS_PLAYERS + client, buf, sizeof (buf));
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1485
;1485:	strncpy(name, Info_ValueForKey(buf, "n"), size - 1);
ADDRLP4 0
ARGP4
ADDRGP4 $578
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1486
;1486:	name[size - 1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1487
;1487:	Q_CleanStr(name);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1488
;1488:	return name;
ADDRFP4 4
INDIRP4
RETP4
LABELV $572
endproc ClientName 1032 12
export ClientSkin
proc ClientSkin 1032 12
line 1496
;1489:}
;1490:
;1491:/*
;1492:==================
;1493:ClientSkin
;1494:==================
;1495: */
;1496:char *ClientSkin(int client, char *skin, int size) {
line 1499
;1497:	char buf[MAX_INFO_STRING];
;1498:
;1499:	if (client < 0 || client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
LTI4 $582
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $580
LABELV $582
line 1500
;1500:		BotAI_Print(PRT_ERROR, "ClientSkin: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $583
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1501
;1501:		return "[client out of range]";
ADDRGP4 $577
RETP4
ADDRGP4 $579
JUMPV
LABELV $580
line 1503
;1502:	}
;1503:	trap_GetConfigstring(CS_PLAYERS + client, buf, sizeof (buf));
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1504
;1504:	strncpy(skin, Info_ValueForKey(buf, "model"), size - 1);
ADDRLP4 0
ARGP4
ADDRGP4 $584
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1505
;1505:	skin[size - 1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1506
;1506:	return skin;
ADDRFP4 4
INDIRP4
RETP4
LABELV $579
endproc ClientSkin 1032 12
export ClientFromName
proc ClientFromName 1036 12
line 1514
;1507:}
;1508:
;1509:/*
;1510:==================
;1511:ClientFromName
;1512:==================
;1513: */
;1514:int ClientFromName(char *name) {
line 1518
;1515:	int i;
;1516:	char buf[MAX_INFO_STRING];
;1517:
;1518:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $589
JUMPV
LABELV $586
line 1519
;1519:		trap_GetConfigstring(CS_PLAYERS + i, buf, sizeof (buf));
ADDRLP4 1024
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1520
;1520:		Q_CleanStr(buf);
ADDRLP4 0
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1521
;1521:		if (Q_strequal(Info_ValueForKey(buf, "n"), name)) return i;
ADDRLP4 0
ARGP4
ADDRGP4 $578
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $591
ADDRLP4 1024
INDIRI4
RETI4
ADDRGP4 $585
JUMPV
LABELV $591
line 1522
;1522:	}
LABELV $587
line 1518
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $589
ADDRLP4 1024
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $586
line 1523
;1523:	return -1;
CNSTI4 -1
RETI4
LABELV $585
endproc ClientFromName 1036 12
bss
align 4
LABELV $594
skip 4
export ClientOnSameTeamFromName
code
proc ClientOnSameTeamFromName 1044 12
line 1531
;1524:}
;1525:
;1526:/*
;1527:==================
;1528:ClientOnSameTeamFromName
;1529:==================
;1530: */
;1531:int ClientOnSameTeamFromName(bot_state_t *bs, char *name) {
line 1536
;1532:	int i;
;1533:	char buf[MAX_INFO_STRING];
;1534:	static int maxclients;
;1535:
;1536:	if (!maxclients)
ADDRGP4 $594
INDIRI4
CNSTI4 0
NEI4 $595
line 1537
;1537:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $597
ARGP4
ADDRLP4 1028
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $594
ADDRLP4 1028
INDIRI4
ASGNI4
LABELV $595
line 1538
;1538:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $601
JUMPV
LABELV $598
line 1539
;1539:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1032
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $602
line 1540
;1540:			continue;
ADDRGP4 $599
JUMPV
LABELV $602
line 1541
;1541:		trap_GetConfigstring(CS_PLAYERS + i, buf, sizeof (buf));
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
line 1542
;1542:		Q_CleanStr(buf);
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1543
;1543:		if (Q_strequal(Info_ValueForKey(buf, "n"), name)) return i;
ADDRLP4 4
ARGP4
ADDRGP4 $578
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $604
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $593
JUMPV
LABELV $604
line 1544
;1544:	}
LABELV $599
line 1538
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $601
ADDRLP4 0
INDIRI4
ADDRGP4 $594
INDIRI4
GEI4 $606
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $598
LABELV $606
line 1545
;1545:	return -1;
CNSTI4 -1
RETI4
LABELV $593
endproc ClientOnSameTeamFromName 1044 12
export stristr
proc stristr 12 4
line 1553
;1546:}
;1547:
;1548:/*
;1549:==================
;1550:stristr
;1551:==================
;1552: */
;1553:char *stristr(char *str, char *charset) {
ADDRGP4 $609
JUMPV
LABELV $608
line 1556
;1554:	int i;
;1555:
;1556:	while (*str) {
line 1557
;1557:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $614
JUMPV
LABELV $611
line 1558
;1558:			if (toupper(charset[i]) != toupper(str[i])) break;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $615
ADDRGP4 $613
JUMPV
LABELV $615
line 1559
;1559:		}
LABELV $612
line 1557
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $614
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
EQI4 $617
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
NEI4 $611
LABELV $617
LABELV $613
line 1560
;1560:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $618
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $607
JUMPV
LABELV $618
line 1561
;1561:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1562
;1562:	}
LABELV $609
line 1556
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $608
line 1563
;1563:	return NULL;
CNSTP4 0
RETP4
LABELV $607
endproc stristr 12 4
export EasyClientName
proc EasyClientName 200 12
line 1571
;1564:}
;1565:
;1566:/*
;1567:==================
;1568:EasyClientName
;1569:==================
;1570: */
;1571:char *EasyClientName(int client, char *buf, int size) {
line 1576
;1572:	int i;
;1573:	char *str1, *str2, *ptr, c;
;1574:	char name[128];
;1575:
;1576:	ClientName(client, name, sizeof (name));
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 5
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1577
;1577:	for (i = 0; name[i]; i++) name[i] &= 127;
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $624
JUMPV
LABELV $621
ADDRLP4 148
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVII1 4
ASGNI1
LABELV $622
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $624
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $621
line 1579
;1578:	//remove all spaces
;1579:	for (ptr = strstr(name, " "); ptr; ptr = strstr(name, " ")) {
ADDRLP4 5
ARGP4
ADDRGP4 $629
ARGP4
ADDRLP4 152
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 152
INDIRP4
ASGNP4
ADDRGP4 $628
JUMPV
LABELV $625
line 1580
;1580:		memmove(ptr, ptr + 1, strlen(ptr + 1) + 1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 164
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
ARGP4
ADDRLP4 156
INDIRI4
ADDRLP4 164
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1581
;1581:	}
LABELV $626
line 1579
ADDRLP4 5
ARGP4
ADDRGP4 $629
ARGP4
ADDRLP4 156
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
LABELV $628
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $625
line 1583
;1582:	//check for [x] and ]x[ clan names
;1583:	str1 = strstr(name, "[");
ADDRLP4 5
ARGP4
ADDRGP4 $630
ARGP4
ADDRLP4 160
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 140
ADDRLP4 160
INDIRP4
ASGNP4
line 1584
;1584:	str2 = strstr(name, "]");
ADDRLP4 5
ARGP4
ADDRGP4 $631
ARGP4
ADDRLP4 164
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 144
ADDRLP4 164
INDIRP4
ASGNP4
line 1585
;1585:	if (str1 && str2) {
ADDRLP4 168
CNSTU4 0
ASGNU4
ADDRLP4 140
INDIRP4
CVPU4 4
ADDRLP4 168
INDIRU4
EQU4 $632
ADDRLP4 144
INDIRP4
CVPU4 4
ADDRLP4 168
INDIRU4
EQU4 $632
line 1586
;1586:		if (str2 > str1) memmove(str1, str2 + 1, strlen(str2 + 1) + 1);
ADDRLP4 144
INDIRP4
CVPU4 4
ADDRLP4 140
INDIRP4
CVPU4 4
LEU4 $634
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 176
CNSTI4 1
ASGNI4
ADDRLP4 144
INDIRP4
ADDRLP4 176
INDIRI4
ADDP4
ARGP4
ADDRLP4 172
INDIRI4
ADDRLP4 176
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
ADDRGP4 $635
JUMPV
LABELV $634
line 1587
;1587:		else memmove(str2, str1 + 1, strlen(str1 + 1) + 1);
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 180
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 184
CNSTI4 1
ASGNI4
ADDRLP4 140
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
ARGP4
ADDRLP4 180
INDIRI4
ADDRLP4 184
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
LABELV $635
line 1588
;1588:	}
LABELV $632
line 1590
;1589:	//remove Mr prefix
;1590:	if ((name[0] == 'm' || name[0] == 'M') &&
ADDRLP4 172
ADDRLP4 5
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 109
EQI4 $640
ADDRLP4 172
INDIRI4
CNSTI4 77
NEI4 $636
LABELV $640
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 114
EQI4 $641
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 82
NEI4 $636
LABELV $641
line 1591
;1591:			(name[1] == 'r' || name[1] == 'R')) {
line 1592
;1592:		memmove(name, name + 2, strlen(name + 2) + 1);
ADDRLP4 5+2
ARGP4
ADDRLP4 176
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 5
ARGP4
ADDRLP4 5+2
ARGP4
ADDRLP4 176
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1593
;1593:	}
LABELV $636
line 1595
;1594:	//only allow lower case alphabet characters
;1595:	ptr = name;
ADDRLP4 0
ADDRLP4 5
ASGNP4
ADDRGP4 $645
JUMPV
LABELV $644
line 1596
;1596:	while (*ptr) {
line 1597
;1597:		c = *ptr;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 1598
;1598:		if ((c >= 'a' && c <= 'z') ||
ADDRLP4 176
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 97
LTI4 $650
ADDRLP4 176
INDIRI4
CNSTI4 122
LEI4 $651
LABELV $650
ADDRLP4 180
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 48
LTI4 $652
ADDRLP4 180
INDIRI4
CNSTI4 57
LEI4 $651
LABELV $652
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 95
NEI4 $647
LABELV $651
line 1599
;1599:				(c >= '0' && c <= '9') || c == '_') {
line 1600
;1600:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1601
;1601:		} else if (c >= 'A' && c <= 'Z') {
ADDRGP4 $648
JUMPV
LABELV $647
ADDRLP4 184
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 65
LTI4 $653
ADDRLP4 184
INDIRI4
CNSTI4 90
GTI4 $653
line 1602
;1602:			*ptr += 'a' - 'A';
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
CVII1 4
ASGNI1
line 1603
;1603:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1604
;1604:		} else {
ADDRGP4 $654
JUMPV
LABELV $653
line 1605
;1605:			memmove(ptr, ptr + 1, strlen(ptr + 1) + 1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 188
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 196
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
ARGP4
ADDRLP4 188
INDIRI4
ADDRLP4 196
INDIRI4
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1606
;1606:		}
LABELV $654
LABELV $648
line 1607
;1607:	}
LABELV $645
line 1596
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $644
line 1608
;1608:	strncpy(buf, name, size - 1);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 5
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1609
;1609:	buf[size - 1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1610
;1610:	return buf;
ADDRFP4 4
INDIRP4
RETP4
LABELV $620
endproc EasyClientName 200 12
export BotSynonymContext
proc BotSynonymContext 12 4
line 1618
;1611:}
;1612:
;1613:/*
;1614:==================
;1615:BotSynonymContext
;1616:==================
;1617: */
;1618:int BotSynonymContext(bot_state_t *bs) {
line 1621
;1619:	int context;
;1620:
;1621:	context = CONTEXT_NORMAL | CONTEXT_NEARBYITEM | CONTEXT_NAMES;
ADDRLP4 0
CNSTI4 1027
ASGNI4
line 1623
;1622:	//
;1623:	if (G_UsesTeamFlags(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $656
line 1624
;1624:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_CTFREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $658
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 4
BORI4
ASGNI4
ADDRGP4 $657
JUMPV
LABELV $658
line 1625
;1625:		else context |= CONTEXT_CTFBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1626
;1626:	} else if (gametype == GT_OBELISK) {
ADDRGP4 $657
JUMPV
LABELV $656
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $660
line 1627
;1627:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_OBELISKREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $662
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 32
BORI4
ASGNI4
ADDRGP4 $661
JUMPV
LABELV $662
line 1628
;1628:		else context |= CONTEXT_OBELISKBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1629
;1629:	} else if (gametype == GT_HARVESTER) {
ADDRGP4 $661
JUMPV
LABELV $660
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $664
line 1630
;1630:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_HARVESTERREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $666
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 128
BORI4
ASGNI4
ADDRGP4 $667
JUMPV
LABELV $666
line 1631
;1631:		else context |= CONTEXT_HARVESTERBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
LABELV $667
line 1632
;1632:	}
LABELV $664
LABELV $661
LABELV $657
line 1633
;1633:	return context;
ADDRLP4 0
INDIRI4
RETI4
LABELV $655
endproc BotSynonymContext 12 4
export BotChooseWeapon
proc BotChooseWeapon 20 8
line 1641
;1634:}
;1635:
;1636:/*
;1637:==================
;1638:BotChooseWeapon
;1639:==================
;1640: */
;1641:void BotChooseWeapon(bot_state_t *bs) {
line 1644
;1642:	int newweaponnum;
;1643:
;1644:	if (bs->cur_ps.weaponstate == WEAPON_RAISING ||
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $671
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $669
LABELV $671
line 1645
;1645:			bs->cur_ps.weaponstate == WEAPON_DROPPING) {
line 1646
;1646:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6416
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1647
;1647:	} else {
ADDRGP4 $670
JUMPV
LABELV $669
line 1648
;1648:		if (g_instantgib.integer)
ADDRGP4 g_instantgib+12
INDIRI4
CNSTI4 0
EQI4 $672
line 1649
;1649:			newweaponnum = WP_RAILGUN;
ADDRLP4 0
CNSTI4 7
ASGNI4
ADDRGP4 $673
JUMPV
LABELV $672
line 1650
;1650:		else if (g_rockets.integer)
ADDRGP4 g_rockets+12
INDIRI4
CNSTI4 0
EQI4 $675
line 1651
;1651:			newweaponnum = WP_ROCKET_LAUNCHER;
ADDRLP4 0
CNSTI4 5
ASGNI4
ADDRGP4 $676
JUMPV
LABELV $675
line 1653
;1652:		else
;1653:			newweaponnum = trap_BotChooseBestFightWeapon(bs->ws, bs->inventory);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6392
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4808
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_BotChooseBestFightWeapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
LABELV $676
LABELV $673
line 1654
;1654:		if (bs->weaponnum != newweaponnum) bs->weaponchange_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $678
ADDRFP4 0
INDIRP4
CNSTI4 6048
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $678
line 1655
;1655:		bs->weaponnum = newweaponnum;
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1657
;1656:		//BotAI_Print(PRT_MESSAGE, "bs->weaponnum = %d\n", bs->weaponnum);
;1657:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 6416
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1658
;1658:	}
LABELV $670
line 1659
;1659:}
LABELV $668
endproc BotChooseWeapon 20 8
export BotSetupForMovement
proc BotSetupForMovement 88 12
line 1666
;1660:
;1661:/*
;1662:==================
;1663:BotSetupForMovement
;1664:==================
;1665: */
;1666:void BotSetupForMovement(bot_state_t *bs) {
line 1669
;1667:	bot_initmove_t initmove;
;1668:
;1669:	memset(&initmove, 0, sizeof (bot_initmove_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 68
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1670
;1670:	VectorCopy(bs->cur_ps.origin, initmove.origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1671
;1671:	VectorCopy(bs->cur_ps.velocity, initmove.velocity);
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRB
ASGNB 12
line 1672
;1672:	VectorClear(initmove.viewoffset);
ADDRLP4 68
CNSTF4 0
ASGNF4
ADDRLP4 0+24+8
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 0+24+4
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 0+24
ADDRLP4 68
INDIRF4
ASGNF4
line 1673
;1673:	initmove.viewoffset[2] += bs->cur_ps.viewheight;
ADDRLP4 0+24+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1674
;1674:	initmove.entitynum = bs->entitynum;
ADDRLP4 0+36
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1675
;1675:	initmove.client = bs->client;
ADDRLP4 0+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1676
;1676:	initmove.thinktime = bs->thinktime;
ADDRLP4 0+44
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
ASGNF4
line 1678
;1677:	//set the onground flag
;1678:	if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) initmove.or_moveflags |= MFL_ONGROUND;
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $692
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $692
line 1680
;1679:	//set the teleported flag
;1680:	if ((bs->cur_ps.pm_flags & PMF_TIME_KNOCKBACK) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 76
INDIRI4
EQI4 $695
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
LEI4 $695
line 1681
;1681:		initmove.or_moveflags |= MFL_TELEPORTED;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1682
;1682:	}
LABELV $695
line 1684
;1683:	//set the waterjump flag
;1684:	if ((bs->cur_ps.pm_flags & PMF_TIME_WATERJUMP) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 256
BANDI4
ADDRLP4 84
INDIRI4
EQI4 $698
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
LEI4 $698
line 1685
;1685:		initmove.or_moveflags |= MFL_WATERJUMP;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1686
;1686:	}
LABELV $698
line 1688
;1687:	//set presence type
;1688:	if (bs->cur_ps.pm_flags & PMF_DUCKED) initmove.presencetype = PRESENCE_CROUCH;
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $701
ADDRLP4 0+48
CNSTI4 4
ASGNI4
ADDRGP4 $702
JUMPV
LABELV $701
line 1689
;1689:	else initmove.presencetype = PRESENCE_NORMAL;
ADDRLP4 0+48
CNSTI4 2
ASGNI4
LABELV $702
line 1691
;1690:	//
;1691:	if (bs->walker > 0.5) initmove.or_moveflags |= MFL_WALK;
ADDRFP4 0
INDIRP4
CNSTI4 5912
ADDP4
INDIRF4
CNSTF4 1056964608
LEF4 $705
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $705
line 1693
;1692:	//
;1693:	VectorCopy(bs->viewangles, initmove.viewangles);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
INDIRB
ASGNB 12
line 1695
;1694:	//
;1695:	trap_BotInitMoveState(bs->ms, &initmove);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotInitMoveState
CALLV
pop
line 1696
;1696:}
LABELV $680
endproc BotSetupForMovement 88 12
export BotCheckItemPickup
proc BotCheckItemPickup 60 12
line 1703
;1697:
;1698:/*
;1699:==================
;1700:BotCheckItemPickup
;1701:==================
;1702: */
;1703:void BotCheckItemPickup(bot_state_t *bs, int *oldinventory) {
line 1706
;1704:	int offence, leader;
;1705:
;1706:	if (!G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype) &&
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $710
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $710
ADDRLP4 16
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 7
EQI4 $710
ADDRLP4 16
INDIRI4
CNSTI4 6
EQI4 $710
ADDRLP4 16
INDIRI4
CNSTI4 11
EQI4 $710
ADDRLP4 16
INDIRI4
CNSTI4 12
EQI4 $710
line 1709
;1707:			gametype != GT_HARVESTER && gametype != GT_OBELISK &&
;1708:			gametype != GT_DOUBLE_D && gametype != GT_DOMINATION)
;1709:		return;
ADDRGP4 $709
JUMPV
LABELV $710
line 1711
;1710:
;1711:	offence = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
line 1713
;1712:	// go into offence if picked up the kamikaze or invulnerability
;1713:	if (!oldinventory[INVENTORY_KAMIKAZE] && bs->inventory[INVENTORY_KAMIKAZE] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
CNSTI4 0
NEI4 $712
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
INDIRI4
CNSTI4 1
LTI4 $712
line 1714
;1714:		offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1715
;1715:	}
LABELV $712
line 1716
;1716:	if (!oldinventory[INVENTORY_INVULNERABILITY] && bs->inventory[INVENTORY_INVULNERABILITY] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
CNSTI4 0
NEI4 $714
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRI4
CNSTI4 1
LTI4 $714
line 1717
;1717:		offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1718
;1718:	}
LABELV $714
line 1720
;1719:	// if not already wearing the kamikaze or invulnerability
;1720:	if (!bs->inventory[INVENTORY_KAMIKAZE] && !bs->inventory[INVENTORY_INVULNERABILITY]) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 4936
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $716
ADDRLP4 20
INDIRP4
CNSTI4 4944
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $716
line 1721
;1721:		if (!oldinventory[INVENTORY_SCOUT] && bs->inventory[INVENTORY_SCOUT] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $718
ADDRFP4 0
INDIRP4
CNSTI4 4972
ADDP4
INDIRI4
CNSTI4 1
LTI4 $718
line 1722
;1722:			offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1723
;1723:		}
LABELV $718
line 1724
;1724:		if (!oldinventory[INVENTORY_GUARD] && bs->inventory[INVENTORY_GUARD] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 0
NEI4 $720
ADDRFP4 0
INDIRP4
CNSTI4 4976
ADDP4
INDIRI4
CNSTI4 1
LTI4 $720
line 1725
;1725:			offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1726
;1726:		}
LABELV $720
line 1727
;1727:		if (!oldinventory[INVENTORY_DOUBLER] && bs->inventory[INVENTORY_DOUBLER] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 0
NEI4 $722
ADDRFP4 0
INDIRP4
CNSTI4 4980
ADDP4
INDIRI4
CNSTI4 1
LTI4 $722
line 1728
;1728:			offence = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1729
;1729:		}
LABELV $722
line 1730
;1730:		if (!oldinventory[INVENTORY_AMMOREGEN] && bs->inventory[INVENTORY_AMMOREGEN] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
NEI4 $724
ADDRFP4 0
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 1
LTI4 $724
line 1731
;1731:			offence = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1732
;1732:		}
LABELV $724
line 1733
;1733:	}
LABELV $716
line 1735
;1734:
;1735:	if (offence >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $726
line 1736
;1736:		leader = ClientFromName(bs->teamleader);
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
ASGNI4
line 1737
;1737:		if (offence) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $728
line 1738
;1738:			if (!(bs->teamtaskpreference & TEAMTP_ATTACKER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $730
line 1740
;1739:				// if we have a bot team leader
;1740:				if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $732
line 1742
;1741:					// tell the leader we want to be on offence
;1742:					BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $734
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1745
;1743:					//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1744:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1745:				} else if (bot_spSkill.integer <= 3) {
ADDRGP4 $733
JUMPV
LABELV $732
ADDRGP4 bot_spSkill+12
INDIRI4
CNSTI4 3
GTI4 $735
line 1746
;1746:					if ((bs->ltgtype != LTG_GETFLAG) &&
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 4
EQI4 $738
ADDRLP4 36
INDIRI4
CNSTI4 13
EQI4 $738
ADDRLP4 36
INDIRI4
CNSTI4 12
EQI4 $738
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $740
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $740
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $738
ADDRLP4 52
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $738
LABELV $740
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $741
ADDRFP4 0
INDIRP4
CNSTI4 6820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $738
LABELV $741
line 1753
;1747:							(bs->ltgtype != LTG_ATTACKENEMYBASE) &&
;1748:							(bs->ltgtype != LTG_HARVEST) &&
;1749:							((!(G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype))) ||
;1750:							((bs->redflagstatus == 0) &&
;1751:							(bs->blueflagstatus == 0))) &&
;1752:							((gametype != GT_1FCTF) ||
;1753:							(bs->neutralflagstatus == 0))) {
line 1755
;1754:						// tell the leader we want to be on offence
;1755:						BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $734
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1758
;1756:						//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1757:						//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1758:					}
LABELV $738
line 1759
;1759:					bs->teamtaskpreference |= TEAMTP_ATTACKER;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1760
;1760:				}
LABELV $735
LABELV $733
line 1761
;1761:			}
LABELV $730
line 1762
;1762:			bs->teamtaskpreference &= ~TEAMTP_DEFENDER;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 1763
;1763:		} else {
ADDRGP4 $729
JUMPV
LABELV $728
line 1764
;1764:			if (!(bs->teamtaskpreference & TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $742
line 1766
;1765:				// if we have a bot team leader
;1766:				if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $744
line 1768
;1767:					// tell the leader we want to be on defense
;1768:					BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $746
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1771
;1769:					//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1770:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1771:				} else if ((bot_spSkill.integer <= 3) &&
ADDRGP4 $745
JUMPV
LABELV $744
ADDRLP4 36
CNSTI4 3
ASGNI4
ADDRGP4 bot_spSkill+12
INDIRI4
ADDRLP4 36
INDIRI4
GTI4 $747
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $747
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $750
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $750
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $747
ADDRLP4 52
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $747
LABELV $750
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $751
ADDRFP4 0
INDIRP4
CNSTI4 6820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $747
LABELV $751
line 1777
;1772:						(bs->ltgtype != LTG_DEFENDKEYAREA) &&
;1773:						((!(G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype))) ||
;1774:						((bs->redflagstatus == 0) &&
;1775:						(bs->blueflagstatus == 0))) &&
;1776:						((gametype != GT_1FCTF) ||
;1777:						(bs->neutralflagstatus == 0))) {
line 1780
;1778:
;1779:					// tell the leader we want to be on defense
;1780:					BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $746
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1783
;1781:					//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1782:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1783:				}
LABELV $747
LABELV $745
line 1784
;1784:				bs->teamtaskpreference |= TEAMTP_DEFENDER;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1785
;1785:			}
LABELV $742
line 1786
;1786:			bs->teamtaskpreference &= ~TEAMTP_ATTACKER;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 1787
;1787:		}
LABELV $729
line 1788
;1788:	}
LABELV $726
line 1790
;1789:	//#endif
;1790:}
LABELV $709
endproc BotCheckItemPickup 60 12
export BotUpdateInventory
proc BotUpdateInventory 1332 12
line 1797
;1791:
;1792:/*
;1793:==================
;1794:BotUpdateInventory
;1795:==================
;1796: */
;1797:void BotUpdateInventory(bot_state_t *bs) {
line 1800
;1798:	int oldinventory[MAX_ITEMS];
;1799:
;1800:	memcpy(oldinventory, bs->inventory, sizeof (oldinventory));
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4808
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1802
;1801:	//armor
;1802:	bs->inventory[INVENTORY_ARMOR] = bs->cur_ps.stats[STAT_ARMOR];
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 4812
ADDP4
ADDRLP4 1024
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 1804
;1803:	//weapons
;1804:	bs->inventory[INVENTORY_GAUNTLET] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GAUNTLET)) != 0;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $754
ADDRLP4 1028
CNSTI4 1
ASGNI4
ADDRGP4 $755
JUMPV
LABELV $754
ADDRLP4 1028
CNSTI4 0
ASGNI4
LABELV $755
ADDRLP4 1032
INDIRP4
CNSTI4 4824
ADDP4
ADDRLP4 1028
INDIRI4
ASGNI4
line 1805
;1805:	bs->inventory[INVENTORY_SHOTGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_SHOTGUN)) != 0;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $757
ADDRLP4 1036
CNSTI4 1
ASGNI4
ADDRGP4 $758
JUMPV
LABELV $757
ADDRLP4 1036
CNSTI4 0
ASGNI4
LABELV $758
ADDRLP4 1040
INDIRP4
CNSTI4 4828
ADDP4
ADDRLP4 1036
INDIRI4
ASGNI4
line 1806
;1806:	bs->inventory[INVENTORY_MACHINEGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_MACHINEGUN)) != 0;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $760
ADDRLP4 1044
CNSTI4 1
ASGNI4
ADDRGP4 $761
JUMPV
LABELV $760
ADDRLP4 1044
CNSTI4 0
ASGNI4
LABELV $761
ADDRLP4 1048
INDIRP4
CNSTI4 4832
ADDP4
ADDRLP4 1044
INDIRI4
ASGNI4
line 1807
;1807:	bs->inventory[INVENTORY_GRENADELAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRENADE_LAUNCHER)) != 0;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $763
ADDRLP4 1052
CNSTI4 1
ASGNI4
ADDRGP4 $764
JUMPV
LABELV $763
ADDRLP4 1052
CNSTI4 0
ASGNI4
LABELV $764
ADDRLP4 1056
INDIRP4
CNSTI4 4836
ADDP4
ADDRLP4 1052
INDIRI4
ASGNI4
line 1808
;1808:	bs->inventory[INVENTORY_ROCKETLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_ROCKET_LAUNCHER)) != 0;
ADDRLP4 1064
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $766
ADDRLP4 1060
CNSTI4 1
ASGNI4
ADDRGP4 $767
JUMPV
LABELV $766
ADDRLP4 1060
CNSTI4 0
ASGNI4
LABELV $767
ADDRLP4 1064
INDIRP4
CNSTI4 4840
ADDP4
ADDRLP4 1060
INDIRI4
ASGNI4
line 1809
;1809:	bs->inventory[INVENTORY_LIGHTNING] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_LIGHTNING)) != 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $769
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $770
JUMPV
LABELV $769
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $770
ADDRLP4 1072
INDIRP4
CNSTI4 4844
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 1810
;1810:	bs->inventory[INVENTORY_RAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_RAILGUN)) != 0;
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $772
ADDRLP4 1076
CNSTI4 1
ASGNI4
ADDRGP4 $773
JUMPV
LABELV $772
ADDRLP4 1076
CNSTI4 0
ASGNI4
LABELV $773
ADDRLP4 1080
INDIRP4
CNSTI4 4848
ADDP4
ADDRLP4 1076
INDIRI4
ASGNI4
line 1811
;1811:	bs->inventory[INVENTORY_PLASMAGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PLASMAGUN)) != 0;
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $775
ADDRLP4 1084
CNSTI4 1
ASGNI4
ADDRGP4 $776
JUMPV
LABELV $775
ADDRLP4 1084
CNSTI4 0
ASGNI4
LABELV $776
ADDRLP4 1088
INDIRP4
CNSTI4 4852
ADDP4
ADDRLP4 1084
INDIRI4
ASGNI4
line 1812
;1812:	bs->inventory[INVENTORY_BFG10K] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_BFG)) != 0;
ADDRLP4 1096
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1096
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $778
ADDRLP4 1092
CNSTI4 1
ASGNI4
ADDRGP4 $779
JUMPV
LABELV $778
ADDRLP4 1092
CNSTI4 0
ASGNI4
LABELV $779
ADDRLP4 1096
INDIRP4
CNSTI4 4860
ADDP4
ADDRLP4 1092
INDIRI4
ASGNI4
line 1813
;1813:	bs->inventory[INVENTORY_GRAPPLINGHOOK] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRAPPLING_HOOK)) != 0;
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $781
ADDRLP4 1100
CNSTI4 1
ASGNI4
ADDRGP4 $782
JUMPV
LABELV $781
ADDRLP4 1100
CNSTI4 0
ASGNI4
LABELV $782
ADDRLP4 1104
INDIRP4
CNSTI4 4864
ADDP4
ADDRLP4 1100
INDIRI4
ASGNI4
line 1814
;1814:	bs->inventory[INVENTORY_NAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_NAILGUN)) != 0;
ADDRLP4 1112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1112
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $784
ADDRLP4 1108
CNSTI4 1
ASGNI4
ADDRGP4 $785
JUMPV
LABELV $784
ADDRLP4 1108
CNSTI4 0
ASGNI4
LABELV $785
ADDRLP4 1112
INDIRP4
CNSTI4 4868
ADDP4
ADDRLP4 1108
INDIRI4
ASGNI4
line 1815
;1815:	;
line 1816
;1816:	bs->inventory[INVENTORY_PROXLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PROX_LAUNCHER)) != 0;
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1120
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $787
ADDRLP4 1116
CNSTI4 1
ASGNI4
ADDRGP4 $788
JUMPV
LABELV $787
ADDRLP4 1116
CNSTI4 0
ASGNI4
LABELV $788
ADDRLP4 1120
INDIRP4
CNSTI4 4872
ADDP4
ADDRLP4 1116
INDIRI4
ASGNI4
line 1817
;1817:	;
line 1818
;1818:	bs->inventory[INVENTORY_CHAINGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_CHAINGUN)) != 0;
ADDRLP4 1128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1128
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $790
ADDRLP4 1124
CNSTI4 1
ASGNI4
ADDRGP4 $791
JUMPV
LABELV $790
ADDRLP4 1124
CNSTI4 0
ASGNI4
LABELV $791
ADDRLP4 1128
INDIRP4
CNSTI4 4876
ADDP4
ADDRLP4 1124
INDIRI4
ASGNI4
line 1819
;1819:	;
line 1821
;1820:	//ammo
;1821:	bs->inventory[INVENTORY_SHELLS] = bs->cur_ps.ammo[WP_SHOTGUN];
ADDRLP4 1132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1132
INDIRP4
CNSTI4 4880
ADDP4
ADDRLP4 1132
INDIRP4
CNSTI4 404
ADDP4
INDIRI4
ASGNI4
line 1822
;1822:	bs->inventory[INVENTORY_BULLETS] = bs->cur_ps.ammo[WP_MACHINEGUN];
ADDRLP4 1136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1136
INDIRP4
CNSTI4 4884
ADDP4
ADDRLP4 1136
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ASGNI4
line 1823
;1823:	bs->inventory[INVENTORY_GRENADES] = bs->cur_ps.ammo[WP_GRENADE_LAUNCHER];
ADDRLP4 1140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
INDIRP4
CNSTI4 4888
ADDP4
ADDRLP4 1140
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
ASGNI4
line 1824
;1824:	bs->inventory[INVENTORY_CELLS] = bs->cur_ps.ammo[WP_PLASMAGUN];
ADDRLP4 1144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1144
INDIRP4
CNSTI4 4892
ADDP4
ADDRLP4 1144
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 1825
;1825:	bs->inventory[INVENTORY_LIGHTNINGAMMO] = bs->cur_ps.ammo[WP_LIGHTNING];
ADDRLP4 1148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1148
INDIRP4
CNSTI4 4896
ADDP4
ADDRLP4 1148
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 1826
;1826:	bs->inventory[INVENTORY_ROCKETS] = bs->cur_ps.ammo[WP_ROCKET_LAUNCHER];
ADDRLP4 1152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1152
INDIRP4
CNSTI4 4900
ADDP4
ADDRLP4 1152
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ASGNI4
line 1827
;1827:	bs->inventory[INVENTORY_SLUGS] = bs->cur_ps.ammo[WP_RAILGUN];
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1156
INDIRP4
CNSTI4 4904
ADDP4
ADDRLP4 1156
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 1828
;1828:	bs->inventory[INVENTORY_BFGAMMO] = bs->cur_ps.ammo[WP_BFG];
ADDRLP4 1160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1160
INDIRP4
CNSTI4 4908
ADDP4
ADDRLP4 1160
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ASGNI4
line 1829
;1829:	bs->inventory[INVENTORY_NAILS] = bs->cur_ps.ammo[WP_NAILGUN];
ADDRLP4 1164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1164
INDIRP4
CNSTI4 4912
ADDP4
ADDRLP4 1164
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 1830
;1830:	bs->inventory[INVENTORY_MINES] = bs->cur_ps.ammo[WP_PROX_LAUNCHER];
ADDRLP4 1168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1168
INDIRP4
CNSTI4 4916
ADDP4
ADDRLP4 1168
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 1831
;1831:	bs->inventory[INVENTORY_BELT] = bs->cur_ps.ammo[WP_CHAINGUN];
ADDRLP4 1172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1172
INDIRP4
CNSTI4 4920
ADDP4
ADDRLP4 1172
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ASGNI4
line 1833
;1832:	//powerups
;1833:	bs->inventory[INVENTORY_HEALTH] = bs->cur_ps.stats[STAT_HEALTH];
ADDRLP4 1176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1176
INDIRP4
CNSTI4 4924
ADDP4
ADDRLP4 1176
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1834
;1834:	bs->inventory[INVENTORY_TELEPORTER] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_TELEPORTER;
ADDRLP4 1184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1184
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 26
NEI4 $793
ADDRLP4 1180
CNSTI4 1
ASGNI4
ADDRGP4 $794
JUMPV
LABELV $793
ADDRLP4 1180
CNSTI4 0
ASGNI4
LABELV $794
ADDRLP4 1184
INDIRP4
CNSTI4 4928
ADDP4
ADDRLP4 1180
INDIRI4
ASGNI4
line 1835
;1835:	bs->inventory[INVENTORY_MEDKIT] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_MEDKIT;
ADDRLP4 1192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1192
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 27
NEI4 $796
ADDRLP4 1188
CNSTI4 1
ASGNI4
ADDRGP4 $797
JUMPV
LABELV $796
ADDRLP4 1188
CNSTI4 0
ASGNI4
LABELV $797
ADDRLP4 1192
INDIRP4
CNSTI4 4932
ADDP4
ADDRLP4 1188
INDIRI4
ASGNI4
line 1836
;1836:	bs->inventory[INVENTORY_KAMIKAZE] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_KAMIKAZE;
ADDRLP4 1200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1200
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 36
NEI4 $799
ADDRLP4 1196
CNSTI4 1
ASGNI4
ADDRGP4 $800
JUMPV
LABELV $799
ADDRLP4 1196
CNSTI4 0
ASGNI4
LABELV $800
ADDRLP4 1200
INDIRP4
CNSTI4 4936
ADDP4
ADDRLP4 1196
INDIRI4
ASGNI4
line 1837
;1837:	bs->inventory[INVENTORY_PORTAL] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_PORTAL;
ADDRLP4 1208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1208
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 37
NEI4 $802
ADDRLP4 1204
CNSTI4 1
ASGNI4
ADDRGP4 $803
JUMPV
LABELV $802
ADDRLP4 1204
CNSTI4 0
ASGNI4
LABELV $803
ADDRLP4 1208
INDIRP4
CNSTI4 4940
ADDP4
ADDRLP4 1204
INDIRI4
ASGNI4
line 1838
;1838:	bs->inventory[INVENTORY_INVULNERABILITY] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_INVULNERABILITY;
ADDRLP4 1216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1216
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 38
NEI4 $805
ADDRLP4 1212
CNSTI4 1
ASGNI4
ADDRGP4 $806
JUMPV
LABELV $805
ADDRLP4 1212
CNSTI4 0
ASGNI4
LABELV $806
ADDRLP4 1216
INDIRP4
CNSTI4 4944
ADDP4
ADDRLP4 1212
INDIRI4
ASGNI4
line 1839
;1839:	bs->inventory[INVENTORY_QUAD] = bs->cur_ps.powerups[PW_QUAD] != 0;
ADDRLP4 1224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1224
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $808
ADDRLP4 1220
CNSTI4 1
ASGNI4
ADDRGP4 $809
JUMPV
LABELV $808
ADDRLP4 1220
CNSTI4 0
ASGNI4
LABELV $809
ADDRLP4 1224
INDIRP4
CNSTI4 4948
ADDP4
ADDRLP4 1220
INDIRI4
ASGNI4
line 1840
;1840:	bs->inventory[INVENTORY_ENVIRONMENTSUIT] = bs->cur_ps.powerups[PW_BATTLESUIT] != 0;
ADDRLP4 1232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1232
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $811
ADDRLP4 1228
CNSTI4 1
ASGNI4
ADDRGP4 $812
JUMPV
LABELV $811
ADDRLP4 1228
CNSTI4 0
ASGNI4
LABELV $812
ADDRLP4 1232
INDIRP4
CNSTI4 4952
ADDP4
ADDRLP4 1228
INDIRI4
ASGNI4
line 1841
;1841:	bs->inventory[INVENTORY_HASTE] = bs->cur_ps.powerups[PW_HASTE] != 0;
ADDRLP4 1240
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1240
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $814
ADDRLP4 1236
CNSTI4 1
ASGNI4
ADDRGP4 $815
JUMPV
LABELV $814
ADDRLP4 1236
CNSTI4 0
ASGNI4
LABELV $815
ADDRLP4 1240
INDIRP4
CNSTI4 4956
ADDP4
ADDRLP4 1236
INDIRI4
ASGNI4
line 1842
;1842:	bs->inventory[INVENTORY_INVISIBILITY] = bs->cur_ps.powerups[PW_INVIS] != 0;
ADDRLP4 1248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1248
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $817
ADDRLP4 1244
CNSTI4 1
ASGNI4
ADDRGP4 $818
JUMPV
LABELV $817
ADDRLP4 1244
CNSTI4 0
ASGNI4
LABELV $818
ADDRLP4 1248
INDIRP4
CNSTI4 4960
ADDP4
ADDRLP4 1244
INDIRI4
ASGNI4
line 1843
;1843:	bs->inventory[INVENTORY_REGEN] = bs->cur_ps.powerups[PW_REGEN] != 0;
ADDRLP4 1256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1256
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $820
ADDRLP4 1252
CNSTI4 1
ASGNI4
ADDRGP4 $821
JUMPV
LABELV $820
ADDRLP4 1252
CNSTI4 0
ASGNI4
LABELV $821
ADDRLP4 1256
INDIRP4
CNSTI4 4964
ADDP4
ADDRLP4 1252
INDIRI4
ASGNI4
line 1844
;1844:	bs->inventory[INVENTORY_FLIGHT] = bs->cur_ps.powerups[PW_FLIGHT] != 0;
ADDRLP4 1264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1264
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $823
ADDRLP4 1260
CNSTI4 1
ASGNI4
ADDRGP4 $824
JUMPV
LABELV $823
ADDRLP4 1260
CNSTI4 0
ASGNI4
LABELV $824
ADDRLP4 1264
INDIRP4
CNSTI4 4968
ADDP4
ADDRLP4 1260
INDIRI4
ASGNI4
line 1845
;1845:	bs->inventory[INVENTORY_SCOUT] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_SCOUT;
ADDRLP4 1272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1272
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 42
NEI4 $826
ADDRLP4 1268
CNSTI4 1
ASGNI4
ADDRGP4 $827
JUMPV
LABELV $826
ADDRLP4 1268
CNSTI4 0
ASGNI4
LABELV $827
ADDRLP4 1272
INDIRP4
CNSTI4 4972
ADDP4
ADDRLP4 1268
INDIRI4
ASGNI4
line 1846
;1846:	bs->inventory[INVENTORY_GUARD] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_GUARD;
ADDRLP4 1280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1280
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 43
NEI4 $829
ADDRLP4 1276
CNSTI4 1
ASGNI4
ADDRGP4 $830
JUMPV
LABELV $829
ADDRLP4 1276
CNSTI4 0
ASGNI4
LABELV $830
ADDRLP4 1280
INDIRP4
CNSTI4 4976
ADDP4
ADDRLP4 1276
INDIRI4
ASGNI4
line 1847
;1847:	bs->inventory[INVENTORY_DOUBLER] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_DOUBLER;
ADDRLP4 1288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1288
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 44
NEI4 $832
ADDRLP4 1284
CNSTI4 1
ASGNI4
ADDRGP4 $833
JUMPV
LABELV $832
ADDRLP4 1284
CNSTI4 0
ASGNI4
LABELV $833
ADDRLP4 1288
INDIRP4
CNSTI4 4980
ADDP4
ADDRLP4 1284
INDIRI4
ASGNI4
line 1848
;1848:	bs->inventory[INVENTORY_AMMOREGEN] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_AMMOREGEN;
ADDRLP4 1296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1296
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 45
NEI4 $835
ADDRLP4 1292
CNSTI4 1
ASGNI4
ADDRGP4 $836
JUMPV
LABELV $835
ADDRLP4 1292
CNSTI4 0
ASGNI4
LABELV $836
ADDRLP4 1296
INDIRP4
CNSTI4 4984
ADDP4
ADDRLP4 1292
INDIRI4
ASGNI4
line 1849
;1849:	bs->inventory[INVENTORY_REDFLAG] = bs->cur_ps.powerups[PW_REDFLAG] != 0;
ADDRLP4 1304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1304
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $838
ADDRLP4 1300
CNSTI4 1
ASGNI4
ADDRGP4 $839
JUMPV
LABELV $838
ADDRLP4 1300
CNSTI4 0
ASGNI4
LABELV $839
ADDRLP4 1304
INDIRP4
CNSTI4 4988
ADDP4
ADDRLP4 1300
INDIRI4
ASGNI4
line 1850
;1850:	bs->inventory[INVENTORY_BLUEFLAG] = bs->cur_ps.powerups[PW_BLUEFLAG] != 0;
ADDRLP4 1312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1312
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $841
ADDRLP4 1308
CNSTI4 1
ASGNI4
ADDRGP4 $842
JUMPV
LABELV $841
ADDRLP4 1308
CNSTI4 0
ASGNI4
LABELV $842
ADDRLP4 1312
INDIRP4
CNSTI4 4992
ADDP4
ADDRLP4 1308
INDIRI4
ASGNI4
line 1851
;1851:	bs->inventory[INVENTORY_NEUTRALFLAG] = bs->cur_ps.powerups[PW_NEUTRALFLAG] != 0;
ADDRLP4 1320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1320
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
CNSTI4 0
EQI4 $844
ADDRLP4 1316
CNSTI4 1
ASGNI4
ADDRGP4 $845
JUMPV
LABELV $844
ADDRLP4 1316
CNSTI4 0
ASGNI4
LABELV $845
ADDRLP4 1320
INDIRP4
CNSTI4 4996
ADDP4
ADDRLP4 1316
INDIRI4
ASGNI4
line 1852
;1852:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1324
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 1
NEI4 $846
line 1853
;1853:		bs->inventory[INVENTORY_REDCUBE] = bs->cur_ps.generic1;
ADDRLP4 1328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1328
INDIRP4
CNSTI4 5000
ADDP4
ADDRLP4 1328
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
ASGNI4
line 1854
;1854:		bs->inventory[INVENTORY_BLUECUBE] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5004
ADDP4
CNSTI4 0
ASGNI4
line 1855
;1855:	} else {
ADDRGP4 $847
JUMPV
LABELV $846
line 1856
;1856:		bs->inventory[INVENTORY_REDCUBE] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5000
ADDP4
CNSTI4 0
ASGNI4
line 1857
;1857:		bs->inventory[INVENTORY_BLUECUBE] = bs->cur_ps.generic1;
ADDRLP4 1328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1328
INDIRP4
CNSTI4 5004
ADDP4
ADDRLP4 1328
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
ASGNI4
line 1858
;1858:	}
LABELV $847
line 1859
;1859:	BotCheckItemPickup(bs, oldinventory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckItemPickup
CALLV
pop
line 1860
;1860:}
LABELV $752
endproc BotUpdateInventory 1332 12
export BotUpdateBattleInventory
proc BotUpdateBattleInventory 160 8
line 1867
;1861:
;1862:/*
;1863:==================
;1864:BotUpdateBattleInventory
;1865:==================
;1866: */
;1867:void BotUpdateBattleInventory(bot_state_t *bs, int enemy) {
line 1871
;1868:	vec3_t dir;
;1869:	aas_entityinfo_t entinfo;
;1870:
;1871:	BotEntityInfo(enemy, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1872
;1872:	VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12+24
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+24+4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1873
;1873:	bs->inventory[ENEMY_HEIGHT] = (int) dir[2];
ADDRFP4 0
INDIRP4
CNSTI4 5612
ADDP4
ADDRLP4 0+8
INDIRF4
CVFI4 4
ASGNI4
line 1874
;1874:	dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1875
;1875:	bs->inventory[ENEMY_HORIZONTAL_DIST] = (int) VectorLength(dir);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 5608
ADDP4
ADDRLP4 156
INDIRF4
CVFI4 4
ASGNI4
line 1877
;1876:	//FIXME: add num visible enemies and num visible team mates to the inventory
;1877:}
LABELV $848
endproc BotUpdateBattleInventory 160 8
export BotUseKamikaze
proc BotUseKamikaze 296 28
line 1886
;1878:
;1879:/*
;1880:==================
;1881:BotUseKamikaze
;1882:==================
;1883: */
;1884:#define KAMIKAZE_DIST  1024
;1885:
;1886:void BotUseKamikaze(bot_state_t *bs) {
line 1894
;1887:	int c, teammates, enemies;
;1888:	aas_entityinfo_t entinfo;
;1889:	vec3_t dir, target;
;1890:	bot_goal_t *goal;
;1891:	bsp_trace_t trace;
;1892:
;1893:	//if the bot has no kamikaze
;1894:	if (bs->inventory[INVENTORY_KAMIKAZE] <= 0)
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
INDIRI4
CNSTI4 0
GTI4 $859
line 1895
;1895:		return;
ADDRGP4 $858
JUMPV
LABELV $859
line 1896
;1896:	if (bs->kamikaze_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 5960
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $861
line 1897
;1897:		return;
ADDRGP4 $858
JUMPV
LABELV $861
line 1898
;1898:	bs->kamikaze_time = FloatTime() + 0.2;
ADDRFP4 0
INDIRP4
CNSTI4 5960
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 1899
;1899:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 264
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $863
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 268
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
NEI4 $863
line 1901
;1900:		//never use kamikaze if the team flag carrier is visible
;1901:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $865
line 1902
;1902:			return;
ADDRGP4 $858
JUMPV
LABELV $865
line 1903
;1903:		c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 276
INDIRI4
ASGNI4
line 1904
;1904:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $867
line 1905
;1905:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1906
;1906:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1907
;1907:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
ADDRLP4 4
ARGP4
ADDRLP4 284
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 284
INDIRF4
CNSTF4 1233125376
GEF4 $876
line 1908
;1908:				return;
ADDRGP4 $858
JUMPV
LABELV $876
line 1909
;1909:		}
LABELV $867
line 1910
;1910:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 280
INDIRI4
ASGNI4
line 1911
;1911:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $864
line 1912
;1912:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1913
;1913:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 284
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 284
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1914
;1914:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
ADDRLP4 4
ARGP4
ADDRLP4 288
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 288
INDIRF4
CNSTF4 1233125376
GEF4 $864
line 1915
;1915:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1916
;1916:				return;
ADDRGP4 $858
JUMPV
line 1918
;1917:			}
;1918:		}
line 1919
;1919:	} else if (gametype == GT_1FCTF) {
LABELV $863
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $889
line 1921
;1920:		//never use kamikaze if the team flag carrier is visible
;1921:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $891
line 1922
;1922:			return;
ADDRGP4 $858
JUMPV
LABELV $891
line 1923
;1923:		c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 276
INDIRI4
ASGNI4
line 1924
;1924:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $893
line 1925
;1925:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1926
;1926:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1927
;1927:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
ADDRLP4 4
ARGP4
ADDRLP4 284
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 284
INDIRF4
CNSTF4 1233125376
GEF4 $902
line 1928
;1928:				return;
ADDRGP4 $858
JUMPV
LABELV $902
line 1929
;1929:		}
LABELV $893
line 1930
;1930:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 280
INDIRI4
ASGNI4
line 1931
;1931:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $890
line 1932
;1932:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1933
;1933:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 284
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 284
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1934
;1934:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
ADDRLP4 4
ARGP4
ADDRLP4 288
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 288
INDIRF4
CNSTF4 1233125376
GEF4 $890
line 1935
;1935:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1936
;1936:				return;
ADDRGP4 $858
JUMPV
line 1938
;1937:			}
;1938:		}
line 1939
;1939:	} else if (gametype == GT_OBELISK) {
LABELV $889
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $915
line 1940
;1940:		switch (BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 272
ADDRLP4 276
INDIRI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 1
EQI4 $920
ADDRGP4 $917
JUMPV
LABELV $920
line 1941
;1941:			case TEAM_RED: goal = &blueobelisk;
ADDRLP4 176
ADDRGP4 blueobelisk
ASGNP4
line 1942
;1942:				break;
ADDRGP4 $918
JUMPV
LABELV $917
line 1943
;1943:			default: goal = &redobelisk;
ADDRLP4 176
ADDRGP4 redobelisk
ASGNP4
line 1944
;1944:				break;
LABELV $918
line 1947
;1945:		}
;1946:		//if the obelisk is visible
;1947:		VectorCopy(goal->origin, target);
ADDRLP4 164
ADDRLP4 176
INDIRP4
INDIRB
ASGNB 12
line 1948
;1948:		target[2] += 1;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1949
;1949:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 280
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRLP4 164
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 280
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRLP4 164+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRLP4 164+8
INDIRF4
SUBF4
ASGNF4
line 1950
;1950:		if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST * 0.9)) {
ADDRLP4 4
ARGP4
ADDRLP4 284
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 284
INDIRF4
CNSTF4 1229937705
GEF4 $916
line 1951
;1951:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 180
ARGP4
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 288
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 292
CNSTP4 0
ASGNP4
ADDRLP4 292
INDIRP4
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
ADDRLP4 164
ARGP4
ADDRLP4 288
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 1952
;1952:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 180+8
INDIRF4
CNSTF4 1065353216
GEF4 $932
ADDRLP4 180+80
INDIRI4
ADDRLP4 176
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $916
LABELV $932
line 1953
;1953:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1954
;1954:				return;
ADDRGP4 $858
JUMPV
line 1956
;1955:			}
;1956:		}
line 1957
;1957:	} else if (gametype == GT_HARVESTER) {
LABELV $915
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $933
line 1959
;1958:		//
;1959:		if (BotHarvesterCarryingCubes(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $935
line 1960
;1960:			return;
ADDRGP4 $858
JUMPV
LABELV $935
line 1962
;1961:		//never use kamikaze if a team mate carrying cubes is visible
;1962:		c = BotTeamCubeCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 BotTeamCubeCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 276
INDIRI4
ASGNI4
line 1963
;1963:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $937
line 1964
;1964:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1965
;1965:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1966
;1966:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
ADDRLP4 4
ARGP4
ADDRLP4 284
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 284
INDIRF4
CNSTF4 1233125376
GEF4 $946
line 1967
;1967:				return;
ADDRGP4 $858
JUMPV
LABELV $946
line 1968
;1968:		}
LABELV $937
line 1969
;1969:		c = BotEnemyCubeCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 BotEnemyCubeCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 280
INDIRI4
ASGNI4
line 1970
;1970:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $948
line 1971
;1971:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1972
;1972:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 284
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 284
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1973
;1973:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
ADDRLP4 4
ARGP4
ADDRLP4 288
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 288
INDIRF4
CNSTF4 1233125376
GEF4 $957
line 1974
;1974:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1975
;1975:				return;
ADDRGP4 $858
JUMPV
LABELV $957
line 1977
;1976:			}
;1977:		}
LABELV $948
line 1978
;1978:	}
LABELV $933
LABELV $916
LABELV $890
LABELV $864
line 1980
;1979:	//
;1980:	BotVisibleTeamMatesAndEnemies(bs, &teammates, &enemies, KAMIKAZE_DIST);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 160
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 1149239296
ARGF4
ADDRGP4 BotVisibleTeamMatesAndEnemies
CALLV
pop
line 1982
;1981:	//
;1982:	if (enemies > 2 && enemies > teammates + 1) {
ADDRLP4 272
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 2
LEI4 $959
ADDRLP4 272
INDIRI4
ADDRLP4 160
INDIRI4
CNSTI4 1
ADDI4
LEI4 $959
line 1983
;1983:		trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1984
;1984:		return;
LABELV $959
line 1986
;1985:	}
;1986:}
LABELV $858
endproc BotUseKamikaze 296 28
export BotUseInvulnerability
proc BotUseInvulnerability 156 28
line 1993
;1987:
;1988:/*
;1989:==================
;1990:BotUseInvulnerability
;1991:==================
;1992: */
;1993:void BotUseInvulnerability(bot_state_t *bs) {
line 2000
;1994:	int c;
;1995:	vec3_t dir, target;
;1996:	bot_goal_t *goal;
;1997:	bsp_trace_t trace;
;1998:
;1999:	//if the bot has no invulnerability
;2000:	if (bs->inventory[INVENTORY_INVULNERABILITY] <= 0)
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRI4
CNSTI4 0
GTI4 $962
line 2001
;2001:		return;
ADDRGP4 $961
JUMPV
LABELV $962
line 2002
;2002:	if (bs->invulnerability_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 5964
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $964
line 2003
;2003:		return;
ADDRGP4 $961
JUMPV
LABELV $964
line 2004
;2004:	bs->invulnerability_time = FloatTime() + 0.2;
ADDRFP4 0
INDIRP4
CNSTI4 5964
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2005
;2005:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 116
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $966
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 120
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $966
line 2007
;2006:		//never use kamikaze if the team flag carrier is visible
;2007:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $968
line 2008
;2008:			return;
ADDRGP4 $961
JUMPV
LABELV $968
line 2009
;2009:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 128
INDIRI4
ASGNI4
line 2010
;2010:		if (c >= 0)
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $970
line 2011
;2011:			return;
ADDRGP4 $961
JUMPV
LABELV $970
line 2013
;2012:		//if near enemy flag and the flag is visible
;2013:		switch (BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 136
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 1
EQI4 $975
ADDRGP4 $972
JUMPV
LABELV $975
line 2014
;2014:			case TEAM_RED: goal = &ctf_blueflag;
ADDRLP4 28
ADDRGP4 ctf_blueflag
ASGNP4
line 2015
;2015:				break;
ADDRGP4 $973
JUMPV
LABELV $972
line 2016
;2016:			default: goal = &ctf_redflag;
ADDRLP4 28
ADDRGP4 ctf_redflag
ASGNP4
line 2017
;2017:				break;
LABELV $973
line 2020
;2018:		}
;2019:		//if the obelisk is visible
;2020:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 2021
;2021:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2022
;2022:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 140
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 140
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2023
;2023:		if (VectorLengthSquared(dir) < Square(200)) {
ADDRLP4 12
ARGP4
ADDRLP4 144
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 144
INDIRF4
CNSTF4 1193033728
GEF4 $967
line 2024
;2024:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 152
CNSTP4 0
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2025
;2025:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $987
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $967
LABELV $987
line 2026
;2026:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2027
;2027:				return;
ADDRGP4 $961
JUMPV
line 2029
;2028:			}
;2029:		}
line 2030
;2030:	} else if (gametype == GT_1FCTF) {
LABELV $966
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $988
line 2032
;2031:		//never use kamikaze if the team flag carrier is visible
;2032:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $990
line 2033
;2033:			return;
ADDRGP4 $961
JUMPV
LABELV $990
line 2034
;2034:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 128
INDIRI4
ASGNI4
line 2035
;2035:		if (c >= 0)
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $992
line 2036
;2036:			return;
ADDRGP4 $961
JUMPV
LABELV $992
line 2038
;2037:		//if near enemy flag and the flag is visible
;2038:		switch (BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 136
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 1
EQI4 $997
ADDRGP4 $994
JUMPV
LABELV $997
line 2039
;2039:			case TEAM_RED: goal = &ctf_blueflag;
ADDRLP4 28
ADDRGP4 ctf_blueflag
ASGNP4
line 2040
;2040:				break;
ADDRGP4 $995
JUMPV
LABELV $994
line 2041
;2041:			default: goal = &ctf_redflag;
ADDRLP4 28
ADDRGP4 ctf_redflag
ASGNP4
line 2042
;2042:				break;
LABELV $995
line 2045
;2043:		}
;2044:		//if the obelisk is visible
;2045:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 2046
;2046:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2047
;2047:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 140
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 140
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2048
;2048:		if (VectorLengthSquared(dir) < Square(200)) {
ADDRLP4 12
ARGP4
ADDRLP4 144
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 144
INDIRF4
CNSTF4 1193033728
GEF4 $989
line 2049
;2049:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 152
CNSTP4 0
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2050
;2050:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $1009
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $989
LABELV $1009
line 2051
;2051:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2052
;2052:				return;
ADDRGP4 $961
JUMPV
line 2054
;2053:			}
;2054:		}
line 2055
;2055:	} else if (gametype == GT_OBELISK) {
LABELV $988
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $1010
line 2056
;2056:		switch (BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 124
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 1
EQI4 $1015
ADDRGP4 $1012
JUMPV
LABELV $1015
line 2057
;2057:			case TEAM_RED: goal = &blueobelisk;
ADDRLP4 28
ADDRGP4 blueobelisk
ASGNP4
line 2058
;2058:				break;
ADDRGP4 $1013
JUMPV
LABELV $1012
line 2059
;2059:			default: goal = &redobelisk;
ADDRLP4 28
ADDRGP4 redobelisk
ASGNP4
line 2060
;2060:				break;
LABELV $1013
line 2063
;2061:		}
;2062:		//if the obelisk is visible
;2063:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 2064
;2064:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2065
;2065:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 132
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 132
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2066
;2066:		if (VectorLengthSquared(dir) < Square(300)) {
ADDRLP4 12
ARGP4
ADDRLP4 136
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 136
INDIRF4
CNSTF4 1202702336
GEF4 $1011
line 2067
;2067:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 144
CNSTP4 0
ASGNP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2068
;2068:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $1027
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $1011
LABELV $1027
line 2069
;2069:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2070
;2070:				return;
ADDRGP4 $961
JUMPV
line 2072
;2071:			}
;2072:		}
line 2073
;2073:	} else if (gametype == GT_HARVESTER) {
LABELV $1010
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $1028
line 2075
;2074:		//
;2075:		if (BotHarvesterCarryingCubes(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $1030
line 2076
;2076:			return;
ADDRGP4 $961
JUMPV
LABELV $1030
line 2077
;2077:		c = BotEnemyCubeCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotEnemyCubeCarrierVisible
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 128
INDIRI4
ASGNI4
line 2078
;2078:		if (c >= 0)
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $1032
line 2079
;2079:			return;
ADDRGP4 $961
JUMPV
LABELV $1032
line 2081
;2080:		//if near enemy base and enemy base is visible
;2081:		switch (BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 136
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 1
EQI4 $1037
ADDRGP4 $1034
JUMPV
LABELV $1037
line 2082
;2082:			case TEAM_RED: goal = &blueobelisk;
ADDRLP4 28
ADDRGP4 blueobelisk
ASGNP4
line 2083
;2083:				break;
ADDRGP4 $1035
JUMPV
LABELV $1034
line 2084
;2084:			default: goal = &redobelisk;
ADDRLP4 28
ADDRGP4 redobelisk
ASGNP4
line 2085
;2085:				break;
LABELV $1035
line 2088
;2086:		}
;2087:		//if the obelisk is visible
;2088:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 2089
;2089:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2090
;2090:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 140
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 140
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2091
;2091:		if (VectorLengthSquared(dir) < Square(200)) {
ADDRLP4 12
ARGP4
ADDRLP4 144
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 144
INDIRF4
CNSTF4 1193033728
GEF4 $1043
line 2092
;2092:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 152
CNSTP4 0
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2093
;2093:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $1049
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $1045
LABELV $1049
line 2094
;2094:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2095
;2095:				return;
LABELV $1045
line 2097
;2096:			}
;2097:		}
LABELV $1043
line 2098
;2098:	}
LABELV $1028
LABELV $1011
LABELV $989
LABELV $967
line 2099
;2099:}
LABELV $961
endproc BotUseInvulnerability 156 28
export BotBattleUseItems
proc BotBattleUseItems 12 4
line 2106
;2100:
;2101:/*
;2102:==================
;2103:BotBattleUseItems
;2104:==================
;2105: */
;2106:void BotBattleUseItems(bot_state_t *bs) {
line 2107
;2107:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1051
line 2108
;2108:		if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 4928
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1053
line 2109
;2109:			if (!BotCTFCarryingFlag(bs)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1055
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1055
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1055
line 2112
;2110:					&& !Bot1FCTFCarryingFlag(bs)
;2111:					&& !BotHarvesterCarryingCubes(bs)
;2112:					) {
line 2113
;2113:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2114
;2114:			}
LABELV $1055
line 2115
;2115:		}
LABELV $1053
line 2116
;2116:	}
LABELV $1051
line 2117
;2117:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1057
line 2118
;2118:		if (bs->inventory[INVENTORY_MEDKIT] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 4932
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1059
line 2119
;2119:			trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2120
;2120:		}
LABELV $1059
line 2121
;2121:	}
LABELV $1057
line 2122
;2122:	BotUseKamikaze(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUseKamikaze
CALLV
pop
line 2123
;2123:	BotUseInvulnerability(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUseInvulnerability
CALLV
pop
line 2124
;2124:}
LABELV $1050
endproc BotBattleUseItems 12 4
export BotSetTeleportTime
proc BotSetTeleportTime 8 0
line 2131
;2125:
;2126:/*
;2127:==================
;2128:BotSetTeleportTime
;2129:==================
;2130: */
;2131:void BotSetTeleportTime(bot_state_t *bs) {
line 2132
;2132:	if ((bs->cur_ps.eFlags ^ bs->last_eFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1062
line 2133
;2133:		bs->teleport_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6036
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2134
;2134:	}
LABELV $1062
line 2135
;2135:	bs->last_eFlags = bs->cur_ps.eFlags;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ASGNI4
line 2136
;2136:}
LABELV $1061
endproc BotSetTeleportTime 8 0
export BotIsDead
proc BotIsDead 4 0
line 2143
;2137:
;2138:/*
;2139:==================
;2140:BotIsDead
;2141:==================
;2142: */
;2143:qboolean BotIsDead(bot_state_t *bs) {
line 2144
;2144:	return (bs->cur_ps.pm_type == PM_DEAD);
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1066
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1067
JUMPV
LABELV $1066
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1067
ADDRLP4 0
INDIRI4
RETI4
LABELV $1064
endproc BotIsDead 4 0
export BotIsObserver
proc BotIsObserver 1032 12
line 2152
;2145:}
;2146:
;2147:/*
;2148:==================
;2149:BotIsObserver
;2150:==================
;2151: */
;2152:qboolean BotIsObserver(bot_state_t *bs) {
line 2154
;2153:	char buf[MAX_INFO_STRING];
;2154:	if (bs->cur_ps.pm_type == PM_SPECTATOR) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1069
CNSTI4 1
RETI4
ADDRGP4 $1068
JUMPV
LABELV $1069
line 2155
;2155:	trap_GetConfigstring(CS_PLAYERS + bs->client, buf, sizeof (buf));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 2156
;2156:	if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) return qtrue;
ADDRLP4 0
ARGP4
ADDRGP4 $1073
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 3
NEI4 $1071
CNSTI4 1
RETI4
ADDRGP4 $1068
JUMPV
LABELV $1071
line 2157
;2157:	return qfalse;
CNSTI4 0
RETI4
LABELV $1068
endproc BotIsObserver 1032 12
export BotIntermission
proc BotIntermission 8 0
line 2165
;2158:}
;2159:
;2160:/*
;2161:==================
;2162:BotIntermission
;2163:==================
;2164: */
;2165:qboolean BotIntermission(bot_state_t *bs) {
line 2167
;2166:	//NOTE: we shouldn't be looking at the game code...
;2167:	if (level.intermissiontime) return qtrue;
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $1075
CNSTI4 1
RETI4
ADDRGP4 $1074
JUMPV
LABELV $1075
line 2168
;2168:	return (bs->cur_ps.pm_type == PM_FREEZE || bs->cur_ps.pm_type == PM_INTERMISSION);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
EQI4 $1081
ADDRLP4 4
INDIRI4
CNSTI4 5
NEI4 $1079
LABELV $1081
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1080
JUMPV
LABELV $1079
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1080
ADDRLP4 0
INDIRI4
RETI4
LABELV $1074
endproc BotIntermission 8 0
export BotInLavaOrSlime
proc BotInLavaOrSlime 16 4
line 2176
;2169:}
;2170:
;2171:/*
;2172:==================
;2173:BotInLavaOrSlime
;2174:==================
;2175: */
;2176:qboolean BotInLavaOrSlime(bot_state_t *bs) {
line 2179
;2177:	vec3_t feet;
;2178:
;2179:	VectorCopy(bs->origin, feet);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
INDIRB
ASGNB 12
line 2180
;2180:	feet[2] -= 23;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1102577664
SUBF4
ASGNF4
line 2181
;2181:	return (trap_AAS_PointContents(feet) & (CONTENTS_LAVA | CONTENTS_SLIME));
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 24
BANDI4
RETI4
LABELV $1082
endproc BotInLavaOrSlime 16 4
lit
align 4
LABELV $1085
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $1086
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCreateWayPoint
code
proc BotCreateWayPoint 32 12
line 2189
;2182:}
;2183:
;2184:/*
;2185:==================
;2186:BotCreateWayPoint
;2187:==================
;2188: */
;2189:bot_waypoint_t *BotCreateWayPoint(char *name, vec3_t origin, int areanum) {
line 2191
;2190:	bot_waypoint_t *wp;
;2191:	vec3_t waypointmins = {-8, -8, -8}, waypointmaxs = {8, 8, 8};
ADDRLP4 4
ADDRGP4 $1085
INDIRB
ASGNB 12
ADDRLP4 16
ADDRGP4 $1086
INDIRB
ASGNB 12
line 2193
;2192:
;2193:	wp = botai_freewaypoints;
ADDRLP4 0
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2194
;2194:	if (!wp) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1087
line 2195
;2195:		BotAI_Print(PRT_WARNING, "BotCreateWayPoint: Out of waypoints\n");
CNSTI4 2
ARGI4
ADDRGP4 $1089
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 2196
;2196:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $1084
JUMPV
LABELV $1087
line 2198
;2197:	}
;2198:	botai_freewaypoints = botai_freewaypoints->next;
ADDRLP4 28
ADDRGP4 botai_freewaypoints
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2200
;2199:
;2200:	Q_strncpyz(wp->name, name, sizeof (wp->name));
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2201
;2201:	VectorCopy(origin, wp->goal.origin);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2202
;2202:	VectorCopy(waypointmins, wp->goal.mins);
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2203
;2203:	VectorCopy(waypointmaxs, wp->goal.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 2204
;2204:	wp->goal.areanum = areanum;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 2205
;2205:	wp->next = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTP4 0
ASGNP4
line 2206
;2206:	wp->prev = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTP4 0
ASGNP4
line 2207
;2207:	return wp;
ADDRLP4 0
INDIRP4
RETP4
LABELV $1084
endproc BotCreateWayPoint 32 12
export BotFindWayPoint
proc BotFindWayPoint 8 8
line 2215
;2208:}
;2209:
;2210:/*
;2211:==================
;2212:BotFindWayPoint
;2213:==================
;2214: */
;2215:bot_waypoint_t *BotFindWayPoint(bot_waypoint_t *waypoints, char *name) {
line 2218
;2216:	bot_waypoint_t *wp;
;2217:
;2218:	for (wp = waypoints; wp; wp = wp->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $1094
JUMPV
LABELV $1091
line 2219
;2219:		if (Q_strequal(wp->name, name)) return wp;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1095
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $1090
JUMPV
LABELV $1095
line 2220
;2220:	}
LABELV $1092
line 2218
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $1094
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1091
line 2221
;2221:	return NULL;
CNSTP4 0
RETP4
LABELV $1090
endproc BotFindWayPoint 8 8
export BotFreeWaypoints
proc BotFreeWaypoints 4 0
line 2229
;2222:}
;2223:
;2224:/*
;2225:==================
;2226:BotFreeWaypoints
;2227:==================
;2228: */
;2229:void BotFreeWaypoints(bot_waypoint_t *wp) {
line 2232
;2230:	bot_waypoint_t *nextwp;
;2231:
;2232:	for (; wp; wp = nextwp) {
ADDRGP4 $1101
JUMPV
LABELV $1098
line 2233
;2233:		nextwp = wp->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2234
;2234:		wp->next = botai_freewaypoints;
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2235
;2235:		botai_freewaypoints = wp;
ADDRGP4 botai_freewaypoints
ADDRFP4 0
INDIRP4
ASGNP4
line 2236
;2236:	}
LABELV $1099
line 2232
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $1101
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1098
line 2237
;2237:}
LABELV $1097
endproc BotFreeWaypoints 4 0
export BotInitWaypoints
proc BotInitWaypoints 4 0
line 2244
;2238:
;2239:/*
;2240:==================
;2241:BotInitWaypoints
;2242:==================
;2243: */
;2244:void BotInitWaypoints(void) {
line 2247
;2245:	int i;
;2246:
;2247:	botai_freewaypoints = NULL;
ADDRGP4 botai_freewaypoints
CNSTP4 0
ASGNP4
line 2248
;2248:	for (i = 0; i < MAX_WAYPOINTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1103
line 2249
;2249:		botai_waypoints[i].next = botai_freewaypoints;
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 botai_waypoints+92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2250
;2250:		botai_freewaypoints = &botai_waypoints[i];
ADDRGP4 botai_freewaypoints
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 botai_waypoints
ADDP4
ASGNP4
line 2251
;2251:	}
LABELV $1104
line 2248
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $1103
line 2252
;2252:}
LABELV $1102
endproc BotInitWaypoints 4 0
export BotAggression
proc BotAggression 28 0
line 2259
;2253:
;2254:/*
;2255:==================
;2256:BotAggression
;2257:==================
;2258: */
;2259:float BotAggression(bot_state_t *bs) {
line 2261
;2260:	//if the bot has quad
;2261:	if (bs->inventory[INVENTORY_QUAD]) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1109
line 2263
;2262:		//if the bot is not holding the gauntlet or the enemy is really nearby
;2263:		if (bs->weaponnum != WP_GAUNTLET ||
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6416
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1113
ADDRLP4 0
INDIRP4
CNSTI4 5608
ADDP4
INDIRI4
CNSTI4 80
GEI4 $1111
LABELV $1113
line 2264
;2264:				bs->inventory[ENEMY_HORIZONTAL_DIST] < 80) {
line 2265
;2265:			return 70;
CNSTF4 1116471296
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1111
line 2267
;2266:		}
;2267:	}
LABELV $1109
line 2269
;2268:	//if the enemy is located way higher than the bot
;2269:	if (bs->inventory[ENEMY_HEIGHT] > 200) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5612
ADDP4
INDIRI4
CNSTI4 200
LEI4 $1114
CNSTF4 0
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1114
line 2271
;2270:	//if the bot is very low on health
;2271:	if (bs->inventory[INVENTORY_HEALTH] < 60) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1116
CNSTF4 0
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1116
line 2273
;2272:	//if the bot is low on health
;2273:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
CNSTI4 80
GEI4 $1118
line 2275
;2274:		//if the bot has insufficient armor
;2275:		if (bs->inventory[INVENTORY_ARMOR] < 40) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 4812
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1120
CNSTF4 0
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1120
line 2276
;2276:	}
LABELV $1118
line 2278
;2277:	//if the bot can use the bfg
;2278:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4860
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1122
ADDRLP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRI4
CNSTI4 7
LEI4 $1122
line 2279
;2279:			bs->inventory[INVENTORY_BFGAMMO] > 7) return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1122
line 2281
;2280:	//if the bot can use the railgun
;2281:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4848
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1124
ADDRLP4 4
INDIRP4
CNSTI4 4904
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1124
line 2282
;2282:			bs->inventory[INVENTORY_SLUGS] > 5) return 95;
CNSTF4 1119748096
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1124
line 2284
;2283:	//if the bot can use the lightning gun
;2284:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4844
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1126
ADDRLP4 8
INDIRP4
CNSTI4 4896
ADDP4
INDIRI4
CNSTI4 50
LEI4 $1126
line 2285
;2285:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1126
line 2287
;2286:	//if the bot can use the rocketlauncher
;2287:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4840
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1128
ADDRLP4 12
INDIRP4
CNSTI4 4900
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1128
line 2288
;2288:			bs->inventory[INVENTORY_ROCKETS] > 5) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1128
line 2290
;2289:	//if the bot can use the plasmagun
;2290:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4852
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1130
ADDRLP4 16
INDIRP4
CNSTI4 4892
ADDP4
INDIRI4
CNSTI4 40
LEI4 $1130
line 2291
;2291:			bs->inventory[INVENTORY_CELLS] > 40) return 85;
CNSTF4 1118437376
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1130
line 2293
;2292:	//if the bot can use the grenade launcher
;2293:	if (bs->inventory[INVENTORY_GRENADELAUNCHER] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4836
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1132
ADDRLP4 20
INDIRP4
CNSTI4 4888
ADDP4
INDIRI4
CNSTI4 10
LEI4 $1132
line 2294
;2294:			bs->inventory[INVENTORY_GRENADES] > 10) return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1132
line 2296
;2295:	//if the bot can use the shotgun
;2296:	if (bs->inventory[INVENTORY_SHOTGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 4828
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1134
ADDRLP4 24
INDIRP4
CNSTI4 4880
ADDP4
INDIRI4
CNSTI4 10
LEI4 $1134
line 2297
;2297:			bs->inventory[INVENTORY_SHELLS] > 10) return 50;
CNSTF4 1112014848
RETF4
ADDRGP4 $1108
JUMPV
LABELV $1134
line 2299
;2298:	//otherwise the bot is not feeling too good
;2299:	return 0;
CNSTF4 0
RETF4
LABELV $1108
endproc BotAggression 28 0
export BotFeelingBad
proc BotFeelingBad 0 0
line 2307
;2300:}
;2301:
;2302:/*
;2303:==================
;2304:BotFeelingBad
;2305:==================
;2306: */
;2307:float BotFeelingBad(bot_state_t *bs) {
line 2308
;2308:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1137
line 2309
;2309:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $1136
JUMPV
LABELV $1137
line 2311
;2310:	}
;2311:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1139
line 2312
;2312:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $1136
JUMPV
LABELV $1139
line 2314
;2313:	}
;2314:	if (bs->weaponnum == WP_MACHINEGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1141
line 2315
;2315:		return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $1136
JUMPV
LABELV $1141
line 2317
;2316:	}
;2317:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1143
line 2318
;2318:		return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $1136
JUMPV
LABELV $1143
line 2320
;2319:	}
;2320:	return 0;
CNSTF4 0
RETF4
LABELV $1136
endproc BotFeelingBad 0 0
export BotWantsToRetreat
proc BotWantsToRetreat 156 8
line 2328
;2321:}
;2322:
;2323:/*
;2324:==================
;2325:BotWantsToRetreat
;2326:==================
;2327: */
;2328:int BotWantsToRetreat(bot_state_t *bs) {
line 2331
;2329:	aas_entityinfo_t entinfo;
;2330:
;2331:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 140
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1146
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 144
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1146
line 2333
;2332:		//always retreat when carrying a CTF flag
;2333:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1147
line 2334
;2334:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1145
JUMPV
line 2335
;2335:	} else if (G_UsesTheWhiteFlag(gametype)) {
LABELV $1146
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1150
line 2337
;2336:		//if carrying the flag then always retreat
;2337:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1151
line 2338
;2338:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1145
JUMPV
line 2339
;2339:	} else if (gametype == GT_OBELISK) {
LABELV $1150
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $1154
line 2341
;2340:		//the bots should be dedicated to attacking the enemy obelisk
;2341:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 13
NEI4 $1156
line 2342
;2342:			if (bs->enemy != redobelisk.entitynum &&
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ASGNI4
ADDRLP4 152
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1158
ADDRLP4 152
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
EQI4 $1158
line 2343
;2343:					bs->enemy != blueobelisk.entitynum) {
line 2344
;2344:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1145
JUMPV
LABELV $1158
line 2346
;2345:			}
;2346:		}
LABELV $1156
line 2347
;2347:		if (BotFeelingBad(bs) > 50) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 BotFeelingBad
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 1112014848
LEF4 $1162
line 2348
;2348:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1145
JUMPV
LABELV $1162
line 2350
;2349:		}
;2350:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1145
JUMPV
LABELV $1154
line 2351
;2351:	} else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $1164
line 2353
;2352:		//if carrying cubes then always retreat
;2353:		if (BotHarvesterCarryingCubes(bs)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1166
CNSTI4 1
RETI4
ADDRGP4 $1145
JUMPV
LABELV $1166
line 2354
;2354:	}
LABELV $1164
LABELV $1151
LABELV $1147
line 2356
;2355:	//
;2356:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1168
line 2358
;2357:		//if the enemy is carrying a flag
;2358:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2360
;2359:		// if the enemy is carrying a flag
;2360:		if (EntityCarriesFlag(&entinfo)) return qfalse;
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1170
CNSTI4 0
RETI4
ADDRGP4 $1145
JUMPV
LABELV $1170
line 2365
;2361:#ifdef MISSIONPACK
;2362:		// if the enemy is carrying cubes
;2363:		if (EntityCarriesCubes(&entinfo)) return qfalse;
;2364:#endif
;2365:	}
LABELV $1168
line 2367
;2366:	//if the bot is getting the flag
;2367:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1172
line 2368
;2368:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1145
JUMPV
LABELV $1172
line 2370
;2369:	//
;2370:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 1112014848
GEF4 $1174
line 2371
;2371:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1145
JUMPV
LABELV $1174
line 2372
;2372:	return qfalse;
CNSTI4 0
RETI4
LABELV $1145
endproc BotWantsToRetreat 156 8
export BotWantsToChase
proc BotWantsToChase 156 8
line 2380
;2373:}
;2374:
;2375:/*
;2376:==================
;2377:BotWantsToChase
;2378:==================
;2379: */
;2380:int BotWantsToChase(bot_state_t *bs) {
line 2383
;2381:	aas_entityinfo_t entinfo;
;2382:
;2383:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 140
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1177
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 144
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1177
line 2385
;2384:		//never chase when carrying a CTF flag
;2385:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1179
line 2386
;2386:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1176
JUMPV
LABELV $1179
line 2388
;2387:		//always chase if the enemy is carrying a flag
;2388:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2389
;2389:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1178
line 2390
;2390:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1176
JUMPV
line 2391
;2391:	} else if (gametype == GT_1FCTF) {
LABELV $1177
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $1183
line 2393
;2392:		//never chase if carrying the flag
;2393:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1185
line 2394
;2394:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1176
JUMPV
LABELV $1185
line 2396
;2395:		//always chase if the enemy is carrying a flag
;2396:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2397
;2397:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1184
line 2398
;2398:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1176
JUMPV
line 2399
;2399:	} else if (gametype == GT_OBELISK) {
LABELV $1183
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $1189
line 2401
;2400:		//the bots should be dedicated to attacking the enemy obelisk
;2401:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 13
NEI4 $1190
line 2402
;2402:			if (bs->enemy != redobelisk.entitynum &&
ADDRLP4 148
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ASGNI4
ADDRLP4 148
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1190
ADDRLP4 148
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
EQI4 $1190
line 2403
;2403:					bs->enemy != blueobelisk.entitynum) {
line 2404
;2404:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1176
JUMPV
line 2406
;2405:			}
;2406:		}
line 2407
;2407:	} else if (gametype == GT_HARVESTER) {
LABELV $1189
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $1197
line 2409
;2408:		//never chase if carrying cubes
;2409:		if (BotHarvesterCarryingCubes(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1199
CNSTI4 0
RETI4
ADDRGP4 $1176
JUMPV
LABELV $1199
line 2411
;2410:
;2411:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2413
;2412:		// always chase if the enemy is carrying cubes
;2413:		if (EntityCarriesCubes(&entinfo)) return qtrue;
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 EntityCarriesCubes
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1198
CNSTI4 1
RETI4
ADDRGP4 $1176
JUMPV
line 2414
;2414:	} else if (gametype == GT_POSSESSION) {
LABELV $1197
ADDRGP4 gametype
INDIRI4
CNSTI4 13
NEI4 $1203
line 2416
;2415:		//always chase if the enemy is carrying a flag
;2416:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2417
;2417:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1205
line 2418
;2418:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1176
JUMPV
LABELV $1205
line 2419
;2419:	}
LABELV $1203
LABELV $1198
LABELV $1190
LABELV $1184
LABELV $1178
line 2421
;2420:	//if the bot is getting the flag
;2421:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1207
line 2422
;2422:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1176
JUMPV
LABELV $1207
line 2424
;2423:	//
;2424:	if (BotAggression(bs) > 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 148
INDIRF4
CNSTF4 1112014848
LEF4 $1209
line 2425
;2425:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1176
JUMPV
LABELV $1209
line 2426
;2426:	return qfalse;
CNSTI4 0
RETI4
LABELV $1176
endproc BotWantsToChase 156 8
export BotWantsToHelp
proc BotWantsToHelp 0 0
line 2434
;2427:}
;2428:
;2429:/*
;2430:==================
;2431:BotWantsToHelp
;2432:==================
;2433: */
;2434:int BotWantsToHelp(bot_state_t *bs) {
line 2435
;2435:	return qtrue;
CNSTI4 1
RETI4
LABELV $1211
endproc BotWantsToHelp 0 0
export BotCanAndWantsToRocketJump
proc BotCanAndWantsToRocketJump 16 16
line 2443
;2436:}
;2437:
;2438:/*
;2439:==================
;2440:BotCanAndWantsToRocketJump
;2441:==================
;2442: */
;2443:int BotCanAndWantsToRocketJump(bot_state_t *bs) {
line 2447
;2444:	float rocketjumper;
;2445:
;2446:	//if rocket jumping is disabled
;2447:	if (!bot_rocketjump.integer) return qfalse;
ADDRGP4 bot_rocketjump+12
INDIRI4
CNSTI4 0
NEI4 $1213
CNSTI4 0
RETI4
ADDRGP4 $1212
JUMPV
LABELV $1213
line 2449
;2448:	//if no rocket launcher
;2449:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4840
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1216
CNSTI4 0
RETI4
ADDRGP4 $1212
JUMPV
LABELV $1216
line 2451
;2450:	//if low on rockets
;2451:	if (bs->inventory[INVENTORY_ROCKETS] < 3) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRI4
CNSTI4 3
GEI4 $1218
CNSTI4 0
RETI4
ADDRGP4 $1212
JUMPV
LABELV $1218
line 2453
;2452:	//Sago: Special rule - always happy to rocket jump in elimination, eCTF end LMS if
;2453:	if (G_IsARoundBasedGametype(g_gametype.integer) && g_elimination_selfdamage.integer == 0) {
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
EQI4 $1220
ADDRGP4 g_elimination_selfdamage+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $1220
line 2454
;2454:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1212
JUMPV
LABELV $1220
line 2457
;2455:	}
;2456:	//never rocket jump with the Quad
;2457:	if (bs->inventory[INVENTORY_QUAD]) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1224
CNSTI4 0
RETI4
ADDRGP4 $1212
JUMPV
LABELV $1224
line 2459
;2458:	//if low on health
;2459:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1226
CNSTI4 0
RETI4
ADDRGP4 $1212
JUMPV
LABELV $1226
line 2461
;2460:	//if not full health
;2461:	if (bs->inventory[INVENTORY_HEALTH] < 90) {
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
CNSTI4 90
GEI4 $1228
line 2463
;2462:		//if the bot has insufficient armor
;2463:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4812
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1230
CNSTI4 0
RETI4
ADDRGP4 $1212
JUMPV
LABELV $1230
line 2464
;2464:	}
LABELV $1228
line 2465
;2465:	rocketjumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WEAPONJUMPING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 38
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 12
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 2466
;2466:	if (rocketjumper < 0.5) return qfalse;
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $1232
CNSTI4 0
RETI4
ADDRGP4 $1212
JUMPV
LABELV $1232
line 2467
;2467:	return qtrue;
CNSTI4 1
RETI4
LABELV $1212
endproc BotCanAndWantsToRocketJump 16 16
export BotHasPersistantPowerupAndWeapon
proc BotHasPersistantPowerupAndWeapon 32 0
line 2475
;2468:}
;2469:
;2470:/*
;2471:==================
;2472:BotHasPersistantPowerupAndWeapon
;2473:==================
;2474: */
;2475:int BotHasPersistantPowerupAndWeapon(bot_state_t *bs) {
line 2485
;2476:	// if the bot does not have a persistant powerup
;2477:	//Sago - FIXME - This causes problems if there are no persistant powerups
;2478:	/*	if (!bs->inventory[INVENTORY_SCOUT] &&
;2479:			!bs->inventory[INVENTORY_GUARD] &&
;2480:			!bs->inventory[INVENTORY_DOUBLER] &&
;2481:			!bs->inventory[INVENTORY_AMMOREGEN] ) {
;2482:			return qfalse;
;2483:		}*/
;2484:	//if the bot is very low on health
;2485:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1235
CNSTI4 0
RETI4
ADDRGP4 $1234
JUMPV
LABELV $1235
line 2487
;2486:	//if the bot is low on health
;2487:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
CNSTI4 80
GEI4 $1237
line 2489
;2488:		//if the bot has insufficient armor
;2489:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4812
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1239
CNSTI4 0
RETI4
ADDRGP4 $1234
JUMPV
LABELV $1239
line 2490
;2490:	}
LABELV $1237
line 2492
;2491:	//if the bot can use the bfg
;2492:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4860
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1241
ADDRLP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRI4
CNSTI4 7
LEI4 $1241
line 2493
;2493:			bs->inventory[INVENTORY_BFGAMMO] > 7) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1234
JUMPV
LABELV $1241
line 2495
;2494:	//if the bot can use the railgun
;2495:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4848
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1243
ADDRLP4 4
INDIRP4
CNSTI4 4904
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1243
line 2496
;2496:			bs->inventory[INVENTORY_SLUGS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1234
JUMPV
LABELV $1243
line 2498
;2497:	//if the bot can use the lightning gun
;2498:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4844
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1245
ADDRLP4 8
INDIRP4
CNSTI4 4896
ADDP4
INDIRI4
CNSTI4 50
LEI4 $1245
line 2499
;2499:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1234
JUMPV
LABELV $1245
line 2501
;2500:	//if the bot can use the rocketlauncher
;2501:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4840
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1247
ADDRLP4 12
INDIRP4
CNSTI4 4900
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1247
line 2502
;2502:			bs->inventory[INVENTORY_ROCKETS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1234
JUMPV
LABELV $1247
line 2504
;2503:	//
;2504:	if (bs->inventory[INVENTORY_NAILGUN] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4868
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1249
ADDRLP4 16
INDIRP4
CNSTI4 4912
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1249
line 2505
;2505:			bs->inventory[INVENTORY_NAILS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1234
JUMPV
LABELV $1249
line 2507
;2506:	//
;2507:	if (bs->inventory[INVENTORY_PROXLAUNCHER] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4872
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1251
ADDRLP4 20
INDIRP4
CNSTI4 4916
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1251
line 2508
;2508:			bs->inventory[INVENTORY_MINES] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1234
JUMPV
LABELV $1251
line 2510
;2509:	//
;2510:	if (bs->inventory[INVENTORY_CHAINGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 4876
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1253
ADDRLP4 24
INDIRP4
CNSTI4 4920
ADDP4
INDIRI4
CNSTI4 40
LEI4 $1253
line 2511
;2511:			bs->inventory[INVENTORY_BELT] > 40) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1234
JUMPV
LABELV $1253
line 2513
;2512:	//if the bot can use the plasmagun
;2513:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 4852
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1255
ADDRLP4 28
INDIRP4
CNSTI4 4892
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1255
line 2514
;2514:			bs->inventory[INVENTORY_CELLS] > 20) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1234
JUMPV
LABELV $1255
line 2515
;2515:	return qfalse;
CNSTI4 0
RETI4
LABELV $1234
endproc BotHasPersistantPowerupAndWeapon 32 0
export BotGoCamp
proc BotGoCamp 16 16
line 2523
;2516:}
;2517:
;2518:/*
;2519:==================
;2520:BotGoCamp
;2521:==================
;2522: */
;2523:void BotGoCamp(bot_state_t *bs, bot_goal_t *goal) {
line 2526
;2524:	float camper;
;2525:
;2526:	bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6464
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 2528
;2527:	//set message time to zero so bot will NOT show any message
;2528:	bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 2530
;2529:	//set the ltg type
;2530:	bs->ltgtype = LTG_CAMP;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 7
ASGNI4
line 2532
;2531:	//set the team goal
;2532:	memcpy(&bs->teamgoal, goal, sizeof (bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2534
;2533:	//get the team goal time
;2534:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 8
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 2535
;2535:	if (camper > 0.99) bs->teamgoal_time = FloatTime() + 99999;
ADDRLP4 0
INDIRF4
CNSTF4 1065185444
LEF4 $1258
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1203982208
ADDF4
ASGNF4
ADDRGP4 $1259
JUMPV
LABELV $1258
line 2536
;2536:	else bs->teamgoal_time = FloatTime() + 120 + 180 * camper + random() * 15;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
CNSTF4 1127481344
ADDRLP4 0
INDIRF4
MULF4
ADDF4
CNSTF4 1097859072
ADDRLP4 12
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
LABELV $1259
line 2538
;2537:	//set the last time the bot started camping
;2538:	bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6040
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2540
;2539:	//the teammate that requested the camping
;2540:	bs->teammate = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
CNSTI4 0
ASGNI4
line 2542
;2541:	//do NOT type arrive message
;2542:	bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTF4 1065353216
ASGNF4
line 2543
;2543:}
LABELV $1257
endproc BotGoCamp 16 16
export BotWantsToCamp
proc BotWantsToCamp 172 16
line 2550
;2544:
;2545:/*
;2546:==================
;2547:BotWantsToCamp
;2548:==================
;2549: */
;2550:int BotWantsToCamp(bot_state_t *bs) {
line 2555
;2551:	float camper;
;2552:	int cs, traveltime, besttraveltime;
;2553:	bot_goal_t goal, bestgoal;
;2554:
;2555:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 128
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 128
INDIRF4
ASGNF4
line 2556
;2556:	if (camper < 0.1) return qfalse;
ADDRLP4 124
INDIRF4
CNSTF4 1036831949
GEF4 $1261
CNSTI4 0
RETI4
ADDRGP4 $1260
JUMPV
LABELV $1261
line 2558
;2557:	//if the bot has a team goal
;2558:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 132
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 1
EQI4 $1271
ADDRLP4 132
INDIRI4
CNSTI4 2
EQI4 $1271
ADDRLP4 132
INDIRI4
CNSTI4 3
EQI4 $1271
ADDRLP4 132
INDIRI4
CNSTI4 4
EQI4 $1271
ADDRLP4 132
INDIRI4
CNSTI4 5
EQI4 $1271
ADDRLP4 132
INDIRI4
CNSTI4 7
EQI4 $1271
ADDRLP4 132
INDIRI4
CNSTI4 8
EQI4 $1271
ADDRLP4 132
INDIRI4
CNSTI4 9
NEI4 $1263
LABELV $1271
line 2565
;2559:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;2560:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;2561:			bs->ltgtype == LTG_GETFLAG ||
;2562:			bs->ltgtype == LTG_RUSHBASE ||
;2563:			bs->ltgtype == LTG_CAMP ||
;2564:			bs->ltgtype == LTG_CAMPORDER ||
;2565:			bs->ltgtype == LTG_PATROL) {
line 2566
;2566:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1260
JUMPV
LABELV $1263
line 2569
;2567:	}
;2568:	//if camped recently
;2569:	if (bs->camp_time > FloatTime() - 60 + 300 * (1 - camper)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6040
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
SUBF4
CNSTF4 1133903872
CNSTF4 1065353216
ADDRLP4 124
INDIRF4
SUBF4
MULF4
ADDF4
LEF4 $1272
CNSTI4 0
RETI4
ADDRGP4 $1260
JUMPV
LABELV $1272
line 2571
;2570:	//
;2571:	if (random() > camper) {
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 124
INDIRF4
LEF4 $1274
line 2572
;2572:		bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6040
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2573
;2573:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1260
JUMPV
LABELV $1274
line 2576
;2574:	}
;2575:	//if the bot isn't healthy anough
;2576:	if (BotAggression(bs) < 50) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $1276
CNSTI4 0
RETI4
ADDRGP4 $1260
JUMPV
LABELV $1276
line 2578
;2577:	//the bot should have at least have the rocket launcher, the railgun or the bfg10k with some ammo
;2578:	if ((bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0 || bs->inventory[INVENTORY_ROCKETS] < 10) &&
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 4840
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1280
ADDRLP4 144
INDIRP4
CNSTI4 4900
ADDP4
INDIRI4
CNSTI4 10
GEI4 $1278
LABELV $1280
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 4848
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1281
ADDRLP4 148
INDIRP4
CNSTI4 4904
ADDP4
INDIRI4
CNSTI4 10
GEI4 $1278
LABELV $1281
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 4860
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1282
ADDRLP4 152
INDIRP4
CNSTI4 4908
ADDP4
INDIRI4
CNSTI4 10
GEI4 $1278
LABELV $1282
line 2580
;2579:			(bs->inventory[INVENTORY_RAILGUN] <= 0 || bs->inventory[INVENTORY_SLUGS] < 10) &&
;2580:			(bs->inventory[INVENTORY_BFG10K] <= 0 || bs->inventory[INVENTORY_BFGAMMO] < 10)) {
line 2581
;2581:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1260
JUMPV
LABELV $1278
line 2584
;2582:	}
;2583:	//find the closest camp spot
;2584:	besttraveltime = 99999;
ADDRLP4 64
CNSTI4 99999
ASGNI4
line 2585
;2585:	for (cs = trap_BotGetNextCampSpotGoal(0, &goal); cs; cs = trap_BotGetNextCampSpotGoal(cs, &goal)) {
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 156
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 156
INDIRI4
ASGNI4
ADDRGP4 $1286
JUMPV
LABELV $1283
line 2586
;2586:		traveltime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal.areanum, TFL_DEFAULT);
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 8+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 164
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 164
INDIRI4
ASGNI4
line 2587
;2587:		if (traveltime && traveltime < besttraveltime) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1288
ADDRLP4 0
INDIRI4
ADDRLP4 64
INDIRI4
GEI4 $1288
line 2588
;2588:			besttraveltime = traveltime;
ADDRLP4 64
ADDRLP4 0
INDIRI4
ASGNI4
line 2589
;2589:			memcpy(&bestgoal, &goal, sizeof (bot_goal_t));
ADDRLP4 68
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2590
;2590:		}
LABELV $1288
line 2591
;2591:	}
LABELV $1284
line 2585
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 160
INDIRI4
ASGNI4
LABELV $1286
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1283
line 2592
;2592:	if (besttraveltime > 150) return qfalse;
ADDRLP4 64
INDIRI4
CNSTI4 150
LEI4 $1290
CNSTI4 0
RETI4
ADDRGP4 $1260
JUMPV
LABELV $1290
line 2594
;2593:	//ok found a camp spot, go camp there
;2594:	BotGoCamp(bs, &bestgoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 BotGoCamp
CALLV
pop
line 2595
;2595:	bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 0
ASGNI4
line 2597
;2596:	//
;2597:	return qtrue;
CNSTI4 1
RETI4
LABELV $1260
endproc BotWantsToCamp 172 16
export BotDontAvoid
proc BotDontAvoid 68 12
line 2605
;2598:}
;2599:
;2600:/*
;2601:==================
;2602:BotDontAvoid
;2603:==================
;2604: */
;2605:void BotDontAvoid(bot_state_t *bs, char *itemname) {
line 2609
;2606:	bot_goal_t goal;
;2607:	int num;
;2608:
;2609:	num = trap_BotGetLevelItemGoal(-1, itemname, &goal);
CNSTI4 -1
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 60
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
ADDRGP4 $1294
JUMPV
LABELV $1293
line 2610
;2610:	while (num >= 0) {
line 2611
;2611:		trap_BotRemoveFromAvoidGoals(bs->gs, goal.number);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 4+44
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveFromAvoidGoals
CALLV
pop
line 2612
;2612:		num = trap_BotGetLevelItemGoal(num, itemname, &goal);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 64
INDIRI4
ASGNI4
line 2613
;2613:	}
LABELV $1294
line 2610
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1293
line 2614
;2614:}
LABELV $1292
endproc BotDontAvoid 68 12
export BotGoForPowerups
proc BotGoForPowerups 0 8
line 2621
;2615:
;2616:/*
;2617:==================
;2618:BotGoForPowerups
;2619:==================
;2620: */
;2621:void BotGoForPowerups(bot_state_t *bs) {
line 2624
;2622:
;2623:	//don't avoid any of the powerups anymore
;2624:	BotDontAvoid(bs, "Quad Damage");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1298
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2625
;2625:	BotDontAvoid(bs, "Regeneration");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1299
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2626
;2626:	BotDontAvoid(bs, "Battle Suit");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1300
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2627
;2627:	BotDontAvoid(bs, "Speed");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1301
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2628
;2628:	BotDontAvoid(bs, "Invisibility");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1302
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2632
;2629:	//BotDontAvoid(bs, "Flight");
;2630:	//reset the long term goal time so the bot will go for the powerup
;2631:	//NOTE: the long term goal type doesn't change
;2632:	bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
CNSTF4 0
ASGNF4
line 2633
;2633:}
LABELV $1297
endproc BotGoForPowerups 0 8
export BotRoamGoal
proc BotRoamGoal 180 28
line 2640
;2634:
;2635:/*
;2636:==================
;2637:BotRoamGoal
;2638:==================
;2639: */
;2640:void BotRoamGoal(bot_state_t *bs, vec3_t goal) {
line 2646
;2641:	int pc, i;
;2642:	float len, rnd;
;2643:	vec3_t dir, bestorg, belowbestorg;
;2644:	bsp_trace_t trace;
;2645:
;2646:	for (i = 0; i < 10; i++) {
ADDRLP4 116
CNSTI4 0
ASGNI4
LABELV $1304
line 2648
;2647:		//start at the bot origin
;2648:		VectorCopy(bs->origin, bestorg);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
INDIRB
ASGNB 12
line 2649
;2649:		rnd = random();
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 112
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ASGNF4
line 2650
;2650:		if (rnd > 0.25) {
ADDRLP4 112
INDIRF4
CNSTF4 1048576000
LEF4 $1308
line 2652
;2651:			//add a random value to the x-coordinate
;2652:			if (random() < 0.5) bestorg[0] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $1310
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1145569280
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $1311
JUMPV
LABELV $1310
line 2653
;2653:			else bestorg[0] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1145569280
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $1311
line 2654
;2654:		}
LABELV $1308
line 2655
;2655:		if (rnd < 0.75) {
ADDRLP4 112
INDIRF4
CNSTF4 1061158912
GEF4 $1312
line 2657
;2656:			//add a random value to the y-coordinate
;2657:			if (random() < 0.5) bestorg[1] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $1314
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1145569280
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $1315
JUMPV
LABELV $1314
line 2658
;2658:			else bestorg[1] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1145569280
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $1315
line 2659
;2659:		}
LABELV $1312
line 2661
;2660:		//add a random value to the z-coordinate (NOTE: 48 = maxjump?)
;2661:		bestorg[2] += 2 * 48 * crandom();
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1119879168
CNSTF4 1073741824
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
line 2663
;2662:		//trace a line from the origin to the roam target
;2663:		BotAI_Trace(&trace, bs->origin, NULL, NULL, bestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 148
CNSTP4 0
ASGNP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2665
;2664:		//direction and length towards the roam target
;2665:		VectorSubtract(trace.endpos, bs->origin, dir);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24+12
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24+12+4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24+12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2666
;2666:		len = VectorNormalize(dir);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 108
ADDRLP4 156
INDIRF4
ASGNF4
line 2668
;2667:		//if the roam target is far away anough
;2668:		if (len > 200) {
ADDRLP4 108
INDIRF4
CNSTF4 1128792064
LEF4 $1326
line 2670
;2669:			//the roam target is in the given direction before walls
;2670:			VectorScale(dir, len * trace.fraction - 40, dir);
ADDRLP4 164
CNSTF4 1109393408
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDRLP4 164
INDIRF4
SUBF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDRLP4 164
INDIRF4
SUBF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
line 2671
;2671:			VectorAdd(bs->origin, dir, bestorg);
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 168
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 168
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 2673
;2672:			//get the coordinates of the floor below the roam target
;2673:			belowbestorg[0] = bestorg[0];
ADDRLP4 120
ADDRLP4 12
INDIRF4
ASGNF4
line 2674
;2674:			belowbestorg[1] = bestorg[1];
ADDRLP4 120+4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 2675
;2675:			belowbestorg[2] = bestorg[2] - 800;
ADDRLP4 120+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1145569280
SUBF4
ASGNF4
line 2676
;2676:			BotAI_Trace(&trace, bestorg, NULL, NULL, belowbestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 172
CNSTP4 0
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2678
;2677:			//
;2678:			if (!trace.startsolid) {
ADDRLP4 24+4
INDIRI4
CNSTI4 0
NEI4 $1343
line 2679
;2679:				trace.endpos[2]++;
ADDRLP4 24+12+8
ADDRLP4 24+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2680
;2680:				pc = trap_PointContents(trace.endpos, bs->entitynum);
ADDRLP4 24+12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 176
INDIRI4
ASGNI4
line 2681
;2681:				if (!(pc & (CONTENTS_LAVA | CONTENTS_SLIME))) {
ADDRLP4 132
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
NEI4 $1349
line 2682
;2682:					VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2683
;2683:					return;
ADDRGP4 $1303
JUMPV
LABELV $1349
line 2685
;2684:				}
;2685:			}
LABELV $1343
line 2686
;2686:		}
LABELV $1326
line 2687
;2687:	}
LABELV $1305
line 2646
ADDRLP4 116
ADDRLP4 116
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 10
LTI4 $1304
line 2688
;2688:	VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2689
;2689:}
LABELV $1303
endproc BotRoamGoal 180 28
lit
align 4
LABELV $1353
byte 4 0
byte 4 0
byte 4 1065353216
export BotAttackMove
code
proc BotAttackMove 392 16
line 2696
;2690:
;2691:/*
;2692:==================
;2693:BotAttackMove
;2694:==================
;2695: */
;2696:bot_moveresult_t BotAttackMove(bot_state_t *bs, int tfl) {
line 2700
;2697:	int movetype, i, attackentity;
;2698:	float attack_skill, jumper, croucher, dist, strafechange_time;
;2699:	float attack_dist, attack_range;
;2700:	vec3_t forward, backward, sideward, hordir, up = {0, 0, 1};
ADDRLP4 56
ADDRGP4 $1353
INDIRB
ASGNB 12
line 2705
;2701:	aas_entityinfo_t entinfo;
;2702:	bot_moveresult_t moveresult;
;2703:	bot_goal_t goal;
;2704:
;2705:	attackentity = bs->enemy;
ADDRLP4 332
ADDRFP4 4
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ASGNI4
line 2707
;2706:	//
;2707:	if (bs->attackchase_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1354
line 2709
;2708:		//create the chase goal
;2709:		goal.entitynum = attackentity;
ADDRLP4 136+40
ADDRLP4 332
INDIRI4
ASGNI4
line 2710
;2710:		goal.areanum = bs->lastenemyareanum;
ADDRLP4 136+12
ADDRFP4 4
INDIRP4
CNSTI4 6400
ADDP4
INDIRI4
ASGNI4
line 2711
;2711:		VectorCopy(bs->lastenemyorigin, goal.origin);
ADDRLP4 136
ADDRFP4 4
INDIRP4
CNSTI4 6404
ADDP4
INDIRB
ASGNB 12
line 2712
;2712:		VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 136+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+8
CNSTF4 3238002688
ASGNF4
line 2713
;2713:		VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 136+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+8
CNSTF4 1090519040
ASGNF4
line 2715
;2714:		//initialize the movement state
;2715:		BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2717
;2716:		//move towards the goal
;2717:		trap_BotMoveToGoal(&moveresult, bs->ms, &goal, tfl);
ADDRLP4 80
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2718
;2718:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1351
JUMPV
LABELV $1354
line 2721
;2719:	}
;2720:	//
;2721:	memset(&moveresult, 0, sizeof (bot_moveresult_t));
ADDRLP4 80
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2723
;2722:	//
;2723:	attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 348
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 132
ADDRLP4 348
INDIRF4
ASGNF4
line 2724
;2724:	jumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_JUMPER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 37
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 352
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 340
ADDRLP4 352
INDIRF4
ASGNF4
line 2725
;2725:	croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 36
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 356
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 344
ADDRLP4 356
INDIRF4
ASGNF4
line 2727
;2726:	//if the bot is really stupid
;2727:	if (attack_skill < 0.2) return moveresult;
ADDRLP4 132
INDIRF4
CNSTF4 1045220557
GEF4 $1368
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1351
JUMPV
LABELV $1368
line 2729
;2728:	//initialize the movement state
;2729:	BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2731
;2730:	//get the enemy entity info
;2731:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 332
INDIRI4
ARGI4
ADDRLP4 192
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2733
;2732:	//direction towards the enemy
;2733:	VectorSubtract(entinfo.origin, bs->origin, forward);
ADDRLP4 360
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 192+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 192+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 192+24+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2735
;2734:	//the distance towards the enemy
;2735:	dist = VectorNormalize(forward);
ADDRLP4 24
ARGP4
ADDRLP4 364
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 364
INDIRF4
ASGNF4
line 2736
;2736:	VectorNegate(forward, backward);
ADDRLP4 36
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
NEGF4
ASGNF4
line 2738
;2737:	//walk, crouch or jump
;2738:	movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2740
;2739:	//
;2740:	if (bs->attackcrouch_time < FloatTime() - 1) {
ADDRFP4 4
INDIRP4
CNSTI4 5976
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1381
line 2741
;2741:		if (random() < jumper) {
ADDRLP4 368
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 340
INDIRF4
GEF4 $1383
line 2742
;2742:			movetype = MOVE_JUMP;
ADDRLP4 52
CNSTI4 4
ASGNI4
line 2743
;2743:		}			//wait at least one second before crouching again
ADDRGP4 $1384
JUMPV
LABELV $1383
line 2744
;2744:		else if (bs->attackcrouch_time < FloatTime() - 1 && random() < croucher) {
ADDRFP4 4
INDIRP4
CNSTI4 5976
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1385
ADDRLP4 372
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 344
INDIRF4
GEF4 $1385
line 2745
;2745:			bs->attackcrouch_time = FloatTime() + croucher * 5;
ADDRFP4 4
INDIRP4
CNSTI4 5976
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDRLP4 344
INDIRF4
MULF4
ADDF4
ASGNF4
line 2746
;2746:		}
LABELV $1385
LABELV $1384
line 2747
;2747:	}
LABELV $1381
line 2748
;2748:	if (bs->attackcrouch_time > FloatTime()) movetype = MOVE_CROUCH;
ADDRFP4 4
INDIRP4
CNSTI4 5976
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1387
ADDRLP4 52
CNSTI4 2
ASGNI4
LABELV $1387
line 2750
;2749:	//if the bot should jump
;2750:	if (movetype == MOVE_JUMP) {
ADDRLP4 52
INDIRI4
CNSTI4 4
NEI4 $1389
line 2752
;2751:		//if jumped last frame
;2752:		if (bs->attackjump_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 5984
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1391
line 2753
;2753:			movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2754
;2754:		} else {
ADDRGP4 $1392
JUMPV
LABELV $1391
line 2755
;2755:			bs->attackjump_time = FloatTime() + 1;
ADDRFP4 4
INDIRP4
CNSTI4 5984
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2756
;2756:		}
LABELV $1392
line 2757
;2757:	}
LABELV $1389
line 2758
;2758:	if (bs->cur_ps.weapon == WP_GAUNTLET) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1393
line 2759
;2759:		attack_dist = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
line 2760
;2760:		attack_range = 0;
ADDRLP4 76
CNSTF4 0
ASGNF4
line 2761
;2761:	} else {
ADDRGP4 $1394
JUMPV
LABELV $1393
line 2762
;2762:		attack_dist = IDEAL_ATTACKDIST;
ADDRLP4 72
CNSTF4 1124859904
ASGNF4
line 2763
;2763:		attack_range = 40;
ADDRLP4 76
CNSTF4 1109393408
ASGNF4
line 2764
;2764:	}
LABELV $1394
line 2766
;2765:	//if the bot is stupid
;2766:	if (attack_skill <= 0.4) {
ADDRLP4 132
INDIRF4
CNSTF4 1053609165
GTF4 $1395
line 2768
;2767:		//just walk to or away from the enemy
;2768:		if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $1397
line 2769
;2769:			if (trap_BotMoveInDirection(bs->ms, forward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1399
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1351
JUMPV
LABELV $1399
line 2770
;2770:		}
LABELV $1397
line 2771
;2771:		if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $1401
line 2772
;2772:			if (trap_BotMoveInDirection(bs->ms, backward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1403
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1351
JUMPV
LABELV $1403
line 2773
;2773:		}
LABELV $1401
line 2774
;2774:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1351
JUMPV
LABELV $1395
line 2777
;2775:	}
;2776:	//increase the strafe time
;2777:	bs->attackstrafe_time += bs->thinktime;
ADDRLP4 368
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 372
ADDRLP4 368
INDIRP4
CNSTI4 5972
ADDP4
ASGNP4
ADDRLP4 372
INDIRP4
ADDRLP4 372
INDIRP4
INDIRF4
ADDRLP4 368
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2779
;2778:	//get the strafe change time
;2779:	strafechange_time = 0.4 + (1 - attack_skill) * 0.2;
ADDRLP4 336
CNSTF4 1045220557
CNSTF4 1065353216
ADDRLP4 132
INDIRF4
SUBF4
MULF4
CNSTF4 1053609165
ADDF4
ASGNF4
line 2780
;2780:	if (attack_skill > 0.7) strafechange_time += crandom() * 0.2;
ADDRLP4 132
INDIRF4
CNSTF4 1060320051
LEF4 $1405
ADDRLP4 376
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 336
ADDRLP4 336
INDIRF4
CNSTF4 1045220557
CNSTF4 1073741824
ADDRLP4 376
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
LABELV $1405
line 2782
;2781:	//if the strafe direction should be changed
;2782:	if (bs->attackstrafe_time > strafechange_time) {
ADDRFP4 4
INDIRP4
CNSTI4 5972
ADDP4
INDIRF4
ADDRLP4 336
INDIRF4
LEF4 $1407
line 2784
;2783:		//some magic number :)
;2784:		if (random() > 0.935) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1064262697
LEF4 $1409
line 2786
;2785:			//flip the strafe direction
;2786:			bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 384
ADDRFP4 4
INDIRP4
CNSTI4 5836
ADDP4
ASGNP4
ADDRLP4 384
INDIRP4
ADDRLP4 384
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2787
;2787:			bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 5972
ADDP4
CNSTF4 0
ASGNF4
line 2788
;2788:		}
LABELV $1409
line 2789
;2789:	}
LABELV $1407
line 2791
;2790:	//
;2791:	for (i = 0; i < 2; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
LABELV $1411
line 2792
;2792:		hordir[0] = forward[0];
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 2793
;2793:		hordir[1] = forward[1];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ASGNF4
line 2794
;2794:		hordir[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2795
;2795:		VectorNormalize(hordir);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2797
;2796:		//get the sideward vector
;2797:		CrossProduct(hordir, up, sideward);
ADDRLP4 12
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2799
;2798:		//reverse the vector depending on the strafe direction
;2799:		if (bs->flags & BFL_STRAFERIGHT) VectorNegate(sideward, sideward);
ADDRFP4 4
INDIRP4
CNSTI4 5836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1418
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
NEGF4
ASGNF4
LABELV $1418
line 2801
;2800:		//randomly go back a little
;2801:		if (random() > 0.9) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1063675494
LEF4 $1424
line 2802
;2802:			VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2803
;2803:		} else {
ADDRGP4 $1425
JUMPV
LABELV $1424
line 2805
;2804:			//walk forward or backward to get at the ideal attack distance
;2805:			if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $1432
line 2806
;2806:				VectorAdd(sideward, forward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 2807
;2807:			} else if (dist < attack_dist - attack_range) {
ADDRGP4 $1433
JUMPV
LABELV $1432
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $1440
line 2808
;2808:				VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2809
;2809:			}
LABELV $1440
LABELV $1433
line 2810
;2810:		}
LABELV $1425
line 2812
;2811:		//perform the movement
;2812:		if (trap_BotMoveInDirection(bs->ms, sideward, 400, movetype))
ADDRFP4 4
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 384
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $1448
line 2813
;2813:			return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1351
JUMPV
LABELV $1448
line 2815
;2814:		//movement failed, flip the strafe direction
;2815:		bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 388
ADDRFP4 4
INDIRP4
CNSTI4 5836
ADDP4
ASGNP4
ADDRLP4 388
INDIRP4
ADDRLP4 388
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2816
;2816:		bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 5972
ADDP4
CNSTF4 0
ASGNF4
line 2817
;2817:	}
LABELV $1412
line 2791
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 2
LTI4 $1411
line 2820
;2818:	//bot couldn't do any usefull movement
;2819:	//	bs->attackchase_time = AAS_Time() + 6;
;2820:	return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
LABELV $1351
endproc BotAttackMove 392 16
export BotSameTeam
proc BotSameTeam 24 4
line 2828
;2821:}
;2822:
;2823:/*
;2824:==================
;2825:BotSameTeam
;2826:==================
;2827: */
;2828:int BotSameTeam(bot_state_t *bs, int entnum) {
line 2829
;2829:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1453
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1451
LABELV $1453
line 2831
;2830:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2831:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1450
JUMPV
LABELV $1451
line 2833
;2832:	}
;2833:	if (entnum < 0 || entnum >= MAX_CLIENTS) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1456
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $1454
LABELV $1456
line 2835
;2834:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2835:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1450
JUMPV
LABELV $1454
line 2837
;2836:	}
;2837:	if (G_IsATeamGametype(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1457
line 2841
;2838:		/*Sago: I don't know why they decided to check the configstring instead of the real value.
;2839:		 For some reason bots sometimes gets a wrong config string when chaning gametypes.
;2840:		 Now we check the real value: */
;2841:		if (level.clients[bs->client].sess.sessionTeam == level.clients[entnum].sess.sessionTeam) return qtrue;
ADDRLP4 12
CNSTI4 2116
ASGNI4
ADDRLP4 16
ADDRGP4 level
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 1024
ASGNI4
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRLP4 16
INDIRP4
ADDP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDRFP4 4
INDIRI4
MULI4
ADDRLP4 16
INDIRP4
ADDP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
NEI4 $1459
CNSTI4 1
RETI4
ADDRGP4 $1450
JUMPV
LABELV $1459
line 2842
;2842:	}
LABELV $1457
line 2843
;2843:	return qfalse;
CNSTI4 0
RETI4
LABELV $1450
endproc BotSameTeam 24 4
export InFieldOfVision
proc InFieldOfVision 24 4
line 2851
;2844:}
;2845:
;2846:/*
;2847:==================
;2848:InFieldOfVision
;2849:==================
;2850: */
;2851:qboolean InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles) {
line 2855
;2852:	int i;
;2853:	float diff, angle;
;2854:
;2855:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1462
line 2856
;2856:		angle = AngleMod(viewangles[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
ASGNF4
line 2857
;2857:		angles[i] = AngleMod(angles[i]);
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRF4
ASGNF4
line 2858
;2858:		diff = angles[i] - angle;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 2859
;2859:		if (angles[i] > angle) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $1466
line 2860
;2860:			if (diff > 180.0) diff -= 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 1127481344
LEF4 $1467
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 2861
;2861:		} else {
ADDRGP4 $1467
JUMPV
LABELV $1466
line 2862
;2862:			if (diff < -180.0) diff += 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 3274964992
GEF4 $1470
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $1470
line 2863
;2863:		}
LABELV $1467
line 2864
;2864:		if (diff > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $1472
line 2865
;2865:			if (diff > fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
MULF4
LEF4 $1473
CNSTI4 0
RETI4
ADDRGP4 $1461
JUMPV
line 2866
;2866:		} else {
LABELV $1472
line 2867
;2867:			if (diff < -fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
NEGF4
MULF4
GEF4 $1476
CNSTI4 0
RETI4
ADDRGP4 $1461
JUMPV
LABELV $1476
line 2868
;2868:		}
LABELV $1473
line 2869
;2869:	}
LABELV $1463
line 2855
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $1462
line 2870
;2870:	return qtrue;
CNSTI4 1
RETI4
LABELV $1461
endproc InFieldOfVision 24 4
export BotEntityVisible
proc BotEntityVisible 376 28
line 2880
;2871:}
;2872:
;2873:/*
;2874:==================
;2875:BotEntityVisible
;2876:
;2877:returns visibility in the range [0, 1] taking fog and water surfaces into account
;2878:==================
;2879: */
;2880:float BotEntityVisible(int viewer, vec3_t eye, vec3_t viewangles, float fov, int ent) {
line 2887
;2881:	int i, contents_mask, passent, hitent, infog, inwater, otherinfog, pc;
;2882:	float squaredfogdist, waterfactor, vis, bestvis;
;2883:	bsp_trace_t trace;
;2884:	aas_entityinfo_t entinfo;
;2885:	vec3_t dir, entangles, start, end, middle;
;2886:
;2887:	BotEntityInfo(ent, &entinfo);
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2888
;2888:	if (!entinfo.valid) {
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1479
line 2889
;2889:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $1478
JUMPV
LABELV $1479
line 2894
;2890:	}
;2891:
;2892:	//calculate middle of bounding box
;2893:	//calculate middle of bounding box
;2894:	VectorAdd(entinfo.mins, entinfo.maxs, middle);
ADDRLP4 84
ADDRLP4 148+72
INDIRF4
ADDRLP4 148+84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+72+4
INDIRF4
ADDRLP4 148+84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+72+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDF4
ASGNF4
line 2895
;2895:	VectorScale(middle, 0.5, middle);
ADDRLP4 332
CNSTF4 1056964608
ASGNF4
ADDRLP4 84
ADDRLP4 332
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 332
INDIRF4
ADDRLP4 84+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 84+8
CNSTF4 1056964608
ADDRLP4 84+8
INDIRF4
MULF4
ASGNF4
line 2896
;2896:	VectorAdd(entinfo.origin, middle, middle);
ADDRLP4 84
ADDRLP4 148+24
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+24+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+24+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 2898
;2897:	//check if entity is within field of vision
;2898:	VectorSubtract(middle, eye, dir);
ADDRLP4 336
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 84
INDIRF4
ADDRLP4 336
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 336
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 84+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2899
;2899:	vectoangles(dir, entangles);
ADDRLP4 136
ARGP4
ADDRLP4 320
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2900
;2900:	if (!InFieldOfVision(viewangles, fov, entangles)) return 0;
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 320
ARGP4
ADDRLP4 340
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 0
NEI4 $1510
CNSTF4 0
RETF4
ADDRGP4 $1478
JUMPV
LABELV $1510
line 2902
;2901:	//
;2902:	pc = trap_AAS_PointContents(eye);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 344
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 316
ADDRLP4 344
INDIRI4
ASGNI4
line 2903
;2903:	infog = (pc & CONTENTS_FOG);
ADDRLP4 312
ADDRLP4 316
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2904
;2904:	inwater = (pc & (CONTENTS_LAVA | CONTENTS_SLIME | CONTENTS_WATER));
ADDRLP4 308
ADDRLP4 316
INDIRI4
CNSTI4 56
BANDI4
ASGNI4
line 2906
;2905:	//
;2906:	bestvis = 0;
ADDRLP4 296
CNSTF4 0
ASGNF4
line 2907
;2907:	for (i = 0; i < 3; i++) {
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $1512
line 2911
;2908:		//if the point is not in potential visible sight
;2909:		//if (!AAS_inPVS(eye, middle)) continue;
;2910:		//
;2911:		contents_mask = CONTENTS_SOLID | CONTENTS_PLAYERCLIP;
ADDRLP4 96
CNSTI4 65537
ASGNI4
line 2912
;2912:		passent = viewer;
ADDRLP4 116
ADDRFP4 0
INDIRI4
ASGNI4
line 2913
;2913:		hitent = ent;
ADDRLP4 132
ADDRFP4 16
INDIRI4
ASGNI4
line 2914
;2914:		VectorCopy(eye, start);
ADDRLP4 120
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2915
;2915:		VectorCopy(middle, end);
ADDRLP4 104
ADDRLP4 84
INDIRB
ASGNB 12
line 2917
;2916:		//if the entity is in water, lava or slime
;2917:		if (trap_AAS_PointContents(middle) & (CONTENTS_LAVA | CONTENTS_SLIME | CONTENTS_WATER)) {
ADDRLP4 84
ARGP4
ADDRLP4 348
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $1516
line 2918
;2918:			contents_mask |= (CONTENTS_LAVA | CONTENTS_SLIME | CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BORI4
ASGNI4
line 2919
;2919:		}
LABELV $1516
line 2921
;2920:		//if eye is in water, lava or slime
;2921:		if (inwater) {
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $1518
line 2922
;2922:			if (!(contents_mask & (CONTENTS_LAVA | CONTENTS_SLIME | CONTENTS_WATER))) {
ADDRLP4 96
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $1520
line 2923
;2923:				passent = ent;
ADDRLP4 116
ADDRFP4 16
INDIRI4
ASGNI4
line 2924
;2924:				hitent = viewer;
ADDRLP4 132
ADDRFP4 0
INDIRI4
ASGNI4
line 2925
;2925:				VectorCopy(middle, start);
ADDRLP4 120
ADDRLP4 84
INDIRB
ASGNB 12
line 2926
;2926:				VectorCopy(eye, end);
ADDRLP4 104
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2927
;2927:			}
LABELV $1520
line 2928
;2928:			contents_mask ^= (CONTENTS_LAVA | CONTENTS_SLIME | CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BXORI4
ASGNI4
line 2929
;2929:		}
LABELV $1518
line 2931
;2930:		//trace from start to end
;2931:		BotAI_Trace(&trace, start, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 352
CNSTP4 0
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2933
;2932:		//if water was hit
;2933:		waterfactor = 1.0;
ADDRLP4 288
CNSTF4 1065353216
ASGNF4
line 2934
;2934:		if (trace.contents & (CONTENTS_LAVA | CONTENTS_SLIME | CONTENTS_WATER)) {
ADDRLP4 0+76
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $1522
line 2936
;2935:			//if the water surface is translucent
;2936:			if (1) {
line 2938
;2937:				//trace through the water
;2938:				contents_mask &= ~(CONTENTS_LAVA | CONTENTS_SLIME | CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 -57
BANDI4
ASGNI4
line 2939
;2939:				BotAI_Trace(&trace, trace.endpos, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 356
CNSTP4 0
ASGNP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2940
;2940:				waterfactor = 0.5;
ADDRLP4 288
CNSTF4 1056964608
ASGNF4
line 2941
;2941:			}
LABELV $1525
line 2942
;2942:		}
LABELV $1522
line 2944
;2943:		//if a full trace or the hitent was hit
;2944:		if (trace.fraction >= 1 || trace.ent == hitent) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $1532
ADDRLP4 0+80
INDIRI4
ADDRLP4 132
INDIRI4
NEI4 $1528
LABELV $1532
line 2947
;2945:			//check for fog, assuming there's only one fog brush where
;2946:			//either the viewer or the entity is in or both are in
;2947:			otherinfog = (trap_AAS_PointContents(middle) & CONTENTS_FOG);
ADDRLP4 84
ARGP4
ADDRLP4 356
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 304
ADDRLP4 356
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2948
;2948:			if (infog && otherinfog) {
ADDRLP4 360
CNSTI4 0
ASGNI4
ADDRLP4 312
INDIRI4
ADDRLP4 360
INDIRI4
EQI4 $1533
ADDRLP4 304
INDIRI4
ADDRLP4 360
INDIRI4
EQI4 $1533
line 2949
;2949:				VectorSubtract(trace.endpos, eye, dir);
ADDRLP4 364
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 0+12
INDIRF4
ADDRLP4 364
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 0+12+4
INDIRF4
ADDRLP4 364
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 0+12+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2950
;2950:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 368
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 368
INDIRF4
ASGNF4
line 2951
;2951:			} else if (infog) {
ADDRGP4 $1534
JUMPV
LABELV $1533
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $1542
line 2952
;2952:				VectorCopy(trace.endpos, start);
ADDRLP4 120
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2953
;2953:				BotAI_Trace(&trace, start, NULL, NULL, eye, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 364
CNSTP4 0
ASGNP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2954
;2954:				VectorSubtract(eye, trace.endpos, dir);
ADDRLP4 368
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 368
INDIRP4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 368
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 2955
;2955:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 372
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 372
INDIRF4
ASGNF4
line 2956
;2956:			} else if (otherinfog) {
ADDRGP4 $1543
JUMPV
LABELV $1542
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $1552
line 2957
;2957:				VectorCopy(trace.endpos, end);
ADDRLP4 104
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2958
;2958:				BotAI_Trace(&trace, eye, NULL, NULL, end, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 364
CNSTP4 0
ASGNP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRLP4 104
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2959
;2959:				VectorSubtract(end, trace.endpos, dir);
ADDRLP4 136
ADDRLP4 104
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 104+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 104+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 2960
;2960:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 368
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 368
INDIRF4
ASGNF4
line 2961
;2961:			} else {
ADDRGP4 $1553
JUMPV
LABELV $1552
line 2963
;2962:				//if the entity and the viewer are not in fog assume there's no fog in between
;2963:				squaredfogdist = 0;
ADDRLP4 300
CNSTF4 0
ASGNF4
line 2964
;2964:			}
LABELV $1553
LABELV $1543
LABELV $1534
line 2966
;2965:			//decrease visibility with the view distance through fog
;2966:			vis = 1 / ((squaredfogdist * 0.001) < 1 ? 1 : (squaredfogdist * 0.001));
ADDRLP4 368
CNSTF4 1065353216
ASGNF4
CNSTF4 981668463
ADDRLP4 300
INDIRF4
MULF4
ADDRLP4 368
INDIRF4
GEF4 $1565
ADDRLP4 364
CNSTF4 1065353216
ASGNF4
ADDRGP4 $1566
JUMPV
LABELV $1565
ADDRLP4 364
CNSTF4 981668463
ADDRLP4 300
INDIRF4
MULF4
ASGNF4
LABELV $1566
ADDRLP4 292
ADDRLP4 368
INDIRF4
ADDRLP4 364
INDIRF4
DIVF4
ASGNF4
line 2968
;2967:			//if entering water visibility is reduced
;2968:			vis *= waterfactor;
ADDRLP4 292
ADDRLP4 292
INDIRF4
ADDRLP4 288
INDIRF4
MULF4
ASGNF4
line 2970
;2969:			//
;2970:			if (vis > bestvis) bestvis = vis;
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
LEF4 $1567
ADDRLP4 296
ADDRLP4 292
INDIRF4
ASGNF4
LABELV $1567
line 2972
;2971:			//if pretty much no fog
;2972:			if (bestvis >= 0.95) return bestvis;
ADDRLP4 296
INDIRF4
CNSTF4 1064514355
LTF4 $1569
ADDRLP4 296
INDIRF4
RETF4
ADDRGP4 $1478
JUMPV
LABELV $1569
line 2973
;2973:		}
LABELV $1528
line 2975
;2974:		//check bottom and top of bounding box as well
;2975:		if (i == 0) middle[2] += entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $1571
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
ADDF4
ASGNF4
ADDRGP4 $1572
JUMPV
LABELV $1571
line 2976
;2976:		else if (i == 1) middle[2] += entinfo.maxs[2] - entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $1576
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
SUBF4
ADDF4
ASGNF4
LABELV $1576
LABELV $1572
line 2977
;2977:	}
LABELV $1513
line 2907
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 3
LTI4 $1512
line 2978
;2978:	return bestvis;
ADDRLP4 296
INDIRF4
RETF4
LABELV $1478
endproc BotEntityVisible 376 28
export BotFindEnemy
proc BotFindEnemy 468 28
line 2986
;2979:}
;2980:
;2981:/*
;2982:==================
;2983:BotFindEnemy
;2984:==================
;2985: */
;2986:int BotFindEnemy(bot_state_t *bs, int curenemy) {
line 2993
;2987:	int i, healthdecrease;
;2988:	float f, alertness, easyfragger, vis;
;2989:	float squaredist, cursquaredist;
;2990:	aas_entityinfo_t entinfo, curenemyinfo;
;2991:	vec3_t dir, angles;
;2992:
;2993:	alertness = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ALERTNESS, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 46
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 336
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 336
INDIRF4
ASGNF4
line 2994
;2994:	easyfragger = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_EASY_FRAGGER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 45
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 340
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 340
INDIRF4
ASGNF4
line 2996
;2995:	//check if the health decreased
;2996:	healthdecrease = bs->lasthealth > bs->inventory[INVENTORY_HEALTH];
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 5844
ADDP4
INDIRI4
ADDRLP4 348
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
LEI4 $1585
ADDRLP4 344
CNSTI4 1
ASGNI4
ADDRGP4 $1586
JUMPV
LABELV $1585
ADDRLP4 344
CNSTI4 0
ASGNI4
LABELV $1586
ADDRLP4 160
ADDRLP4 344
INDIRI4
ASGNI4
line 2998
;2997:	//remember the current health value
;2998:	bs->lasthealth = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 5844
ADDP4
ADDRLP4 352
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
ASGNI4
line 3000
;2999:	//
;3000:	if (curenemy >= 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1587
line 3001
;3001:		BotEntityInfo(curenemy, &curenemyinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 196
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3002
;3002:		if (EntityCarriesFlag(&curenemyinfo)) return qfalse;
ADDRLP4 196
ARGP4
ADDRLP4 356
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $1589
CNSTI4 0
RETI4
ADDRGP4 $1583
JUMPV
LABELV $1589
line 3003
;3003:		VectorSubtract(curenemyinfo.origin, bs->origin, dir);
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 196+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 196+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 196+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3004
;3004:		cursquaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 364
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 192
ADDRLP4 364
INDIRF4
ASGNF4
line 3005
;3005:	} else {
ADDRGP4 $1588
JUMPV
LABELV $1587
line 3006
;3006:		cursquaredist = 0;
ADDRLP4 192
CNSTF4 0
ASGNF4
line 3007
;3007:	}
LABELV $1588
line 3008
;3008:	if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $1598
line 3013
;3009:		vec3_t target;
;3010:		bot_goal_t *goal;
;3011:		bsp_trace_t trace;
;3012:
;3013:		if (BotTeam(bs) == TEAM_RED)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 456
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 456
INDIRI4
CNSTI4 1
NEI4 $1600
line 3014
;3014:			goal = &blueobelisk;
ADDRLP4 356
ADDRGP4 blueobelisk
ASGNP4
ADDRGP4 $1601
JUMPV
LABELV $1600
line 3016
;3015:		else
;3016:			goal = &redobelisk;
ADDRLP4 356
ADDRGP4 redobelisk
ASGNP4
LABELV $1601
line 3018
;3017:		//if the obelisk is visible
;3018:		VectorCopy(goal->origin, target);
ADDRLP4 360
ADDRLP4 356
INDIRP4
INDIRB
ASGNB 12
line 3019
;3019:		target[2] += 1;
ADDRLP4 360+8
ADDRLP4 360+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3020
;3020:		BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 372
ARGP4
ADDRLP4 460
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 460
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 464
CNSTP4 0
ASGNP4
ADDRLP4 464
INDIRP4
ARGP4
ADDRLP4 464
INDIRP4
ARGP4
ADDRLP4 360
ARGP4
ADDRLP4 460
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3021
;3021:		if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 372+8
INDIRF4
CNSTF4 1065353216
GEF4 $1607
ADDRLP4 372+80
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $1603
LABELV $1607
line 3022
;3022:			if (goal->entitynum == bs->enemy) {
ADDRLP4 356
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
NEI4 $1608
line 3023
;3023:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1583
JUMPV
LABELV $1608
line 3025
;3024:			}
;3025:			bs->enemy = goal->entitynum;
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
ADDRLP4 356
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
line 3026
;3026:			bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 5988
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3027
;3027:			bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5868
ADDP4
CNSTI4 0
ASGNI4
line 3028
;3028:			bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
CNSTF4 0
ASGNF4
line 3029
;3029:			bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 5944
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3030
;3030:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1583
JUMPV
LABELV $1603
line 3032
;3031:		}
;3032:	}
LABELV $1598
line 3034
;3033:	//
;3034:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $1613
JUMPV
LABELV $1610
line 3036
;3035:
;3036:		if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1615
ADDRGP4 $1611
JUMPV
LABELV $1615
line 3038
;3037:		//if it's the current enemy
;3038:		if (i == curenemy) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1617
ADDRGP4 $1611
JUMPV
LABELV $1617
line 3040
;3039:		//if the enemy has targeting disabled
;3040:		if (g_entities[i].flags & FL_NOTARGET) {
CNSTI4 816
ADDRLP4 140
INDIRI4
MULI4
ADDRGP4 g_entities+536
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1619
line 3041
;3041:			continue;
ADDRGP4 $1611
JUMPV
LABELV $1619
line 3044
;3042:		}
;3043:		//
;3044:		BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3046
;3045:		//
;3046:		if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1622
ADDRGP4 $1611
JUMPV
LABELV $1622
line 3048
;3047:		//if the enemy isn't dead and the enemy isn't the bot self
;3048:		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 356
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
NEI4 $1627
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $1624
LABELV $1627
ADDRGP4 $1611
JUMPV
LABELV $1624
line 3050
;3049:		//if the enemy is invisible and not shooting
;3050:		if (EntityIsInvisible(&entinfo) && !EntityIsShooting(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 360
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
EQI4 $1628
ADDRLP4 0
ARGP4
ADDRLP4 364
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 0
NEI4 $1628
line 3051
;3051:			continue;
ADDRGP4 $1611
JUMPV
LABELV $1628
line 3056
;3052:		}
;3053:		//Neil Torontos unlagged
;3054:		//unlagged - misc
;3055:		// this has nothing to do with lag compensation, but it's great for testing
;3056:		if (g_entities[i].flags & FL_NOTARGET) continue;
CNSTI4 816
ADDRLP4 140
INDIRI4
MULI4
ADDRGP4 g_entities+536
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1630
ADDRGP4 $1611
JUMPV
LABELV $1630
line 3059
;3057:		//unlagged - misc
;3058:		//if not an easy fragger don't shoot at chatting players
;3059:		if (easyfragger < 0.5 && EntityIsChatting(&entinfo)) continue;
ADDRLP4 176
INDIRF4
CNSTF4 1056964608
GEF4 $1633
ADDRLP4 0
ARGP4
ADDRLP4 368
ADDRGP4 EntityIsChatting
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1633
ADDRGP4 $1611
JUMPV
LABELV $1633
line 3061
;3060:		//
;3061:		if (lastteleport_time > FloatTime() - 3) {
ADDRGP4 lastteleport_time
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
LEF4 $1635
line 3062
;3062:			VectorSubtract(entinfo.origin, lastteleport_origin, dir);
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRGP4 lastteleport_origin
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRGP4 lastteleport_origin+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRGP4 lastteleport_origin+8
INDIRF4
SUBF4
ASGNF4
line 3063
;3063:			if (VectorLengthSquared(dir) < Square(70)) continue;
ADDRLP4 144
ARGP4
ADDRLP4 372
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 372
INDIRF4
CNSTF4 1167663104
GEF4 $1646
ADDRGP4 $1611
JUMPV
LABELV $1646
line 3064
;3064:		}
LABELV $1635
line 3066
;3065:		//calculate the distance towards the enemy
;3066:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 372
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3067
;3067:		squaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 376
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 376
INDIRF4
ASGNF4
line 3069
;3068:		//if this entity is not carrying a flag
;3069:		if (!EntityCarriesFlag(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 380
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 0
NEI4 $1655
line 3071
;3070:			//if this enemy is further away than the current one
;3071:			if (curenemy >= 0 && squaredist > cursquaredist) continue;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1657
ADDRLP4 156
INDIRF4
ADDRLP4 192
INDIRF4
LEF4 $1657
ADDRGP4 $1611
JUMPV
LABELV $1657
line 3072
;3072:		} //end if
LABELV $1655
line 3074
;3073:		//if the bot has no
;3074:		if (squaredist > Square(900.0 + alertness * 4000.0)) continue;
ADDRLP4 384
CNSTF4 1165623296
ADDRLP4 164
INDIRF4
MULF4
CNSTF4 1147207680
ADDF4
ASGNF4
ADDRLP4 156
INDIRF4
ADDRLP4 384
INDIRF4
ADDRLP4 384
INDIRF4
MULF4
LEF4 $1659
ADDRGP4 $1611
JUMPV
LABELV $1659
line 3076
;3075:		//if on the same team
;3076:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 388
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 388
INDIRI4
CNSTI4 0
EQI4 $1661
ADDRGP4 $1611
JUMPV
LABELV $1661
line 3078
;3077:		//if the bot's health decreased or the enemy is shooting
;3078:		if (curenemy < 0 && (healthdecrease || EntityIsShooting(&entinfo)))
ADDRLP4 392
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 392
INDIRI4
GEI4 $1663
ADDRLP4 160
INDIRI4
ADDRLP4 392
INDIRI4
NEI4 $1665
ADDRLP4 0
ARGP4
ADDRLP4 396
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 396
INDIRI4
CNSTI4 0
EQI4 $1663
LABELV $1665
line 3079
;3079:			f = 360;
ADDRLP4 168
CNSTF4 1135869952
ASGNF4
ADDRGP4 $1664
JUMPV
LABELV $1663
line 3081
;3080:		else
;3081:			f = 90 + 90 - (90 - (squaredist > Square(810) ? Square(810) : squaredist) / (810 * 9));
ADDRLP4 156
INDIRF4
CNSTF4 1226845760
LEF4 $1667
ADDRLP4 400
CNSTF4 1226845760
ASGNF4
ADDRGP4 $1668
JUMPV
LABELV $1667
ADDRLP4 400
ADDRLP4 156
INDIRF4
ASGNF4
LABELV $1668
ADDRLP4 168
CNSTF4 1127481344
CNSTF4 1119092736
ADDRLP4 400
INDIRF4
CNSTF4 1172557824
DIVF4
SUBF4
SUBF4
ASGNF4
LABELV $1664
line 3083
;3082:		//check if the enemy is visible
;3083:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, f, i);
ADDRLP4 404
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 404
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 404
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 404
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
ADDRLP4 168
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 408
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 172
ADDRLP4 408
INDIRF4
ASGNF4
line 3084
;3084:		if (vis <= 0) continue;
ADDRLP4 172
INDIRF4
CNSTF4 0
GTF4 $1669
ADDRGP4 $1611
JUMPV
LABELV $1669
line 3086
;3085:		//if the enemy is quite far away, not shooting and the bot is not damaged
;3086:		if (curenemy < 0 && squaredist > Square(100) && !healthdecrease && !EntityIsShooting(&entinfo)) {
ADDRLP4 412
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 412
INDIRI4
GEI4 $1671
ADDRLP4 156
INDIRF4
CNSTF4 1176256512
LEF4 $1671
ADDRLP4 160
INDIRI4
ADDRLP4 412
INDIRI4
NEI4 $1671
ADDRLP4 0
ARGP4
ADDRLP4 416
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 416
INDIRI4
CNSTI4 0
NEI4 $1671
line 3088
;3087:			//check if we can avoid this enemy
;3088:			VectorSubtract(bs->origin, entinfo.origin, dir);
ADDRLP4 420
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 420
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 420
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRLP4 0+24+8
INDIRF4
SUBF4
ASGNF4
line 3089
;3089:			vectoangles(dir, angles);
ADDRLP4 144
ARGP4
ADDRLP4 180
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3091
;3090:			//if the bot isn't in the fov of the enemy
;3091:			if (!InFieldOfVision(entinfo.angles, 90, angles)) {
ADDRLP4 0+36
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 180
ARGP4
ADDRLP4 424
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 424
INDIRI4
CNSTI4 0
NEI4 $1680
line 3093
;3092:				//update some stuff for this enemy
;3093:				BotUpdateBattleInventory(bs, i);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 3095
;3094:				//if the bot doesn't really want to fight
;3095:				if (BotWantsToRetreat(bs)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 428
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 428
INDIRI4
CNSTI4 0
EQI4 $1683
ADDRGP4 $1611
JUMPV
LABELV $1683
line 3096
;3096:			}
LABELV $1680
line 3097
;3097:		}
LABELV $1671
line 3099
;3098:		//found an enemy
;3099:		bs->enemy = entinfo.number;
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
ADDRLP4 0+20
INDIRI4
ASGNI4
line 3100
;3100:		if (curenemy >= 0) bs->enemysight_time = FloatTime() - 2;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1686
ADDRFP4 0
INDIRP4
CNSTI4 5988
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
ADDRGP4 $1687
JUMPV
LABELV $1686
line 3101
;3101:		else bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 5988
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $1687
line 3102
;3102:		bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5868
ADDP4
CNSTI4 0
ASGNI4
line 3103
;3103:		bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
CNSTF4 0
ASGNF4
line 3104
;3104:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 5944
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3105
;3105:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1583
JUMPV
LABELV $1611
line 3034
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1613
ADDRLP4 140
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1610
line 3107
;3106:	}
;3107:	return qfalse;
CNSTI4 0
RETI4
LABELV $1583
endproc BotFindEnemy 468 28
export BotTeamFlagCarrierVisible
proc BotTeamFlagCarrierVisible 164 20
line 3115
;3108:}
;3109:
;3110:/*
;3111:==================
;3112:BotTeamFlagCarrierVisible
;3113:==================
;3114: */
;3115:int BotTeamFlagCarrierVisible(bot_state_t *bs) {
line 3120
;3116:	int i;
;3117:	float vis;
;3118:	aas_entityinfo_t entinfo;
;3119:
;3120:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1692
JUMPV
LABELV $1689
line 3121
;3121:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1694
line 3122
;3122:			continue;
ADDRGP4 $1690
JUMPV
LABELV $1694
line 3124
;3123:		//
;3124:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3126
;3125:		//if this player is active
;3126:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1696
line 3127
;3127:			continue;
ADDRGP4 $1690
JUMPV
LABELV $1696
line 3129
;3128:		//if this player is carrying a flag
;3129:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1698
line 3130
;3130:			continue;
ADDRGP4 $1690
JUMPV
LABELV $1698
line 3132
;3131:		//if the flag carrier is not on the same team
;3132:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1700
line 3133
;3133:			continue;
ADDRGP4 $1690
JUMPV
LABELV $1700
line 3135
;3134:		//if the flag carrier is not visible
;3135:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3136
;3136:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1702
line 3137
;3137:			continue;
ADDRGP4 $1690
JUMPV
LABELV $1702
line 3139
;3138:		//
;3139:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1688
JUMPV
LABELV $1690
line 3120
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1692
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1689
line 3141
;3140:	}
;3141:	return -1;
CNSTI4 -1
RETI4
LABELV $1688
endproc BotTeamFlagCarrierVisible 164 20
export BotTeamFlagCarrier
proc BotTeamFlagCarrier 152 8
line 3149
;3142:}
;3143:
;3144:/*
;3145:==================
;3146:BotTeamFlagCarrier
;3147:==================
;3148: */
;3149:int BotTeamFlagCarrier(bot_state_t *bs) {
line 3153
;3150:	int i;
;3151:	aas_entityinfo_t entinfo;
;3152:
;3153:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1708
JUMPV
LABELV $1705
line 3154
;3154:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1710
line 3155
;3155:			continue;
ADDRGP4 $1706
JUMPV
LABELV $1710
line 3157
;3156:		//
;3157:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3159
;3158:		//if this player is active
;3159:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1712
line 3160
;3160:			continue;
ADDRGP4 $1706
JUMPV
LABELV $1712
line 3162
;3161:		//if this player is carrying a flag
;3162:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1714
line 3163
;3163:			continue;
ADDRGP4 $1706
JUMPV
LABELV $1714
line 3165
;3164:		//if the flag carrier is not on the same team
;3165:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1716
line 3166
;3166:			continue;
ADDRGP4 $1706
JUMPV
LABELV $1716
line 3168
;3167:		//
;3168:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1704
JUMPV
LABELV $1706
line 3153
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1708
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1705
line 3170
;3169:	}
;3170:	return -1;
CNSTI4 -1
RETI4
LABELV $1704
endproc BotTeamFlagCarrier 152 8
export BotEnemyFlagCarrierVisible
proc BotEnemyFlagCarrierVisible 164 20
line 3178
;3171:}
;3172:
;3173:/*
;3174:==================
;3175:BotEnemyFlagCarrierVisible
;3176:==================
;3177: */
;3178:int BotEnemyFlagCarrierVisible(bot_state_t *bs) {
line 3183
;3179:	int i;
;3180:	float vis;
;3181:	aas_entityinfo_t entinfo;
;3182:
;3183:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1722
JUMPV
LABELV $1719
line 3184
;3184:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1724
line 3185
;3185:			continue;
ADDRGP4 $1720
JUMPV
LABELV $1724
line 3187
;3186:		//
;3187:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3189
;3188:		//if this player is active
;3189:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1726
line 3190
;3190:			continue;
ADDRGP4 $1720
JUMPV
LABELV $1726
line 3192
;3191:		//if this player is carrying a flag
;3192:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1728
line 3193
;3193:			continue;
ADDRGP4 $1720
JUMPV
LABELV $1728
line 3195
;3194:		//if the flag carrier is on the same team
;3195:		if (BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1730
line 3196
;3196:			continue;
ADDRGP4 $1720
JUMPV
LABELV $1730
line 3198
;3197:		//if the flag carrier is not visible
;3198:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3199
;3199:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1732
line 3200
;3200:			continue;
ADDRGP4 $1720
JUMPV
LABELV $1732
line 3202
;3201:		//
;3202:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1718
JUMPV
LABELV $1720
line 3183
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1722
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1719
line 3204
;3203:	}
;3204:	return -1;
CNSTI4 -1
RETI4
LABELV $1718
endproc BotEnemyFlagCarrierVisible 164 20
export BotVisibleTeamMatesAndEnemies
proc BotVisibleTeamMatesAndEnemies 192 20
line 3212
;3205:}
;3206:
;3207:/*
;3208:==================
;3209:BotVisibleTeamMatesAndEnemies
;3210:==================
;3211: */
;3212:void BotVisibleTeamMatesAndEnemies(bot_state_t *bs, int *teammates, int *enemies, float range) {
line 3218
;3213:	int i;
;3214:	float vis;
;3215:	aas_entityinfo_t entinfo;
;3216:	vec3_t dir;
;3217:
;3218:	if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1735
line 3219
;3219:		*teammates = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1735
line 3220
;3220:	if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1737
line 3221
;3221:		*enemies = 0;
ADDRFP4 8
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1737
line 3222
;3222:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1742
JUMPV
LABELV $1739
line 3223
;3223:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1744
line 3224
;3224:			continue;
ADDRGP4 $1740
JUMPV
LABELV $1744
line 3226
;3225:		//
;3226:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3228
;3227:		//if this player is active
;3228:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1746
line 3229
;3229:			continue;
ADDRGP4 $1740
JUMPV
LABELV $1746
line 3231
;3230:		//if this player is carrying a flag
;3231:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 160
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1748
line 3232
;3232:			continue;
ADDRGP4 $1740
JUMPV
LABELV $1748
line 3234
;3233:		//if not within range
;3234:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 4+24
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 4+24+4
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 4+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3235
;3235:		if (VectorLengthSquared(dir) > Square(range))
ADDRLP4 144
ARGP4
ADDRLP4 168
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 172
ADDRFP4 12
INDIRF4
ASGNF4
ADDRLP4 168
INDIRF4
ADDRLP4 172
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
LEF4 $1757
line 3236
;3236:			continue;
ADDRGP4 $1740
JUMPV
LABELV $1757
line 3238
;3237:		//if the flag carrier is not visible
;3238:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 176
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 180
INDIRF4
ASGNF4
line 3239
;3239:		if (vis <= 0)
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1759
line 3240
;3240:			continue;
ADDRGP4 $1740
JUMPV
LABELV $1759
line 3242
;3241:		//if the flag carrier is on the same team
;3242:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 184
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $1761
line 3243
;3243:			if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1762
line 3244
;3244:				(*teammates)++;
ADDRLP4 188
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3245
;3245:		} else {
ADDRGP4 $1762
JUMPV
LABELV $1761
line 3246
;3246:			if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1765
line 3247
;3247:				(*enemies)++;
ADDRLP4 188
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1765
line 3248
;3248:		}
LABELV $1762
line 3249
;3249:	}
LABELV $1740
line 3222
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1742
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1739
line 3250
;3250:}
LABELV $1734
endproc BotVisibleTeamMatesAndEnemies 192 20
export BotTeamCubeCarrierVisible
proc BotTeamCubeCarrierVisible 164 20
line 3257
;3251:
;3252:/*
;3253:==================
;3254:BotTeamCubeCarrierVisible
;3255:==================
;3256: */
;3257:int BotTeamCubeCarrierVisible(bot_state_t *bs) {
line 3262
;3258:	int i;
;3259:	float vis;
;3260:	aas_entityinfo_t entinfo;
;3261:
;3262:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1771
JUMPV
LABELV $1768
line 3263
;3263:		if (i == bs->client) continue;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1773
ADDRGP4 $1769
JUMPV
LABELV $1773
line 3265
;3264:		//
;3265:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3267
;3266:		//if this player is active
;3267:		if (!entinfo.valid) continue;
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1775
ADDRGP4 $1769
JUMPV
LABELV $1775
line 3269
;3268:		//if this player is carrying a flag
;3269:		if (!EntityCarriesCubes(&entinfo)) continue;
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesCubes
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1777
ADDRGP4 $1769
JUMPV
LABELV $1777
line 3271
;3270:		//if the flag carrier is not on the same team
;3271:		if (!BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1779
ADDRGP4 $1769
JUMPV
LABELV $1779
line 3273
;3272:		//if the flag carrier is not visible
;3273:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3274
;3274:		if (vis <= 0) continue;
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1781
ADDRGP4 $1769
JUMPV
LABELV $1781
line 3276
;3275:		//
;3276:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1767
JUMPV
LABELV $1769
line 3262
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1771
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1768
line 3278
;3277:	}
;3278:	return -1;
CNSTI4 -1
RETI4
LABELV $1767
endproc BotTeamCubeCarrierVisible 164 20
export BotEnemyCubeCarrierVisible
proc BotEnemyCubeCarrierVisible 164 20
line 3286
;3279:}
;3280:
;3281:/*
;3282:==================
;3283:BotEnemyCubeCarrierVisible
;3284:==================
;3285: */
;3286:int BotEnemyCubeCarrierVisible(bot_state_t *bs) {
line 3291
;3287:	int i;
;3288:	float vis;
;3289:	aas_entityinfo_t entinfo;
;3290:
;3291:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1787
JUMPV
LABELV $1784
line 3292
;3292:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1789
line 3293
;3293:			continue;
ADDRGP4 $1785
JUMPV
LABELV $1789
line 3295
;3294:		//
;3295:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3297
;3296:		//if this player is active
;3297:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1791
line 3298
;3298:			continue;
ADDRGP4 $1785
JUMPV
LABELV $1791
line 3300
;3299:		//if this player is carrying a flag
;3300:		if (!EntityCarriesCubes(&entinfo)) continue;
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesCubes
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1793
ADDRGP4 $1785
JUMPV
LABELV $1793
line 3302
;3301:		//if the flag carrier is on the same team
;3302:		if (BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1795
line 3303
;3303:			continue;
ADDRGP4 $1785
JUMPV
LABELV $1795
line 3305
;3304:		//if the flag carrier is not visible
;3305:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3306
;3306:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1797
line 3307
;3307:			continue;
ADDRGP4 $1785
JUMPV
LABELV $1797
line 3309
;3308:		//
;3309:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1783
JUMPV
LABELV $1785
line 3291
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1787
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1784
line 3311
;3310:	}
;3311:	return -1;
CNSTI4 -1
RETI4
LABELV $1783
endproc BotEnemyCubeCarrierVisible 164 20
lit
align 4
LABELV $1800
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV $1801
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
export BotAimAtEnemy
code
proc BotAimAtEnemy 1144 52
line 3320
;3312:}
;3313://#endif
;3314:
;3315:/*
;3316:==================
;3317:BotAimAtEnemy
;3318:==================
;3319: */
;3320:void BotAimAtEnemy(bot_state_t *bs) {
line 3324
;3321:	int i, enemyvisible;
;3322:	float dist, f, aim_skill, aim_accuracy, speed, reactiontime;
;3323:	vec3_t dir, bestorigin, end, start, groundtarget, cmdmove, enemyvelocity;
;3324:	vec3_t mins = {-4, -4, -4}, maxs = {4, 4, 4};
ADDRLP4 860
ADDRGP4 $1800
INDIRB
ASGNB 12
ADDRLP4 872
ADDRGP4 $1801
INDIRB
ASGNB 12
line 3332
;3325:	weaponinfo_t wi;
;3326:	aas_entityinfo_t entinfo;
;3327:	bot_goal_t goal;
;3328:	bsp_trace_t trace;
;3329:	vec3_t target;
;3330:
;3331:	//if the bot has no enemy
;3332:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1802
line 3333
;3333:		return;
ADDRGP4 $1799
JUMPV
LABELV $1802
line 3336
;3334:	}
;3335:	//get the enemy entity information
;3336:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3338
;3337:	//if this is not a player (should be an obelisk)
;3338:	if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1804
line 3340
;3339:		//if the obelisk is visible
;3340:		VectorCopy(entinfo.origin, target);
ADDRLP4 824
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3342
;3341:		// if attacking an obelisk
;3342:		if (bs->enemy == redobelisk.entitynum ||
ADDRLP4 984
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ASGNI4
ADDRLP4 984
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1811
ADDRLP4 984
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
NEI4 $1807
LABELV $1811
line 3343
;3343:				bs->enemy == blueobelisk.entitynum) {
line 3344
;3344:			target[2] += 32;
ADDRLP4 824+8
ADDRLP4 824+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 3345
;3345:		}
LABELV $1807
line 3347
;3346:		//aim at the obelisk
;3347:		VectorSubtract(target, bs->eye, dir);
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 824
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4792
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 824+4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4796
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 824+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4800
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3348
;3348:		vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3350
;3349:		//set the aim target before trying to attack
;3350:		VectorCopy(target, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6076
ADDP4
ADDRLP4 824
INDIRB
ASGNB 12
line 3351
;3351:		return;
ADDRGP4 $1799
JUMPV
LABELV $1804
line 3356
;3352:	}
;3353:	//
;3354:	//BotAI_Print(PRT_MESSAGE, "client %d: aiming at client %d\n", bs->entitynum, bs->enemy);
;3355:	//
;3356:	aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 984
INDIRF4
ASGNF4
line 3357
;3357:	aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 988
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 988
INDIRF4
ASGNF4
line 3359
;3358:	//
;3359:	if (aim_skill > 0.95) {
ADDRLP4 736
INDIRF4
CNSTF4 1064514355
LEF4 $1817
line 3361
;3360:		//don't aim too early
;3361:		reactiontime = 0.5 * trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 992
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 856
CNSTF4 1056964608
ADDRLP4 992
INDIRF4
MULF4
ASGNF4
line 3362
;3362:		if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 5988
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1819
ADDRGP4 $1799
JUMPV
LABELV $1819
line 3363
;3363:		if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6036
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1821
ADDRGP4 $1799
JUMPV
LABELV $1821
line 3364
;3364:	}
LABELV $1817
line 3367
;3365:
;3366:	//get the weapon information
;3367:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 992
INDIRP4
CNSTI4 6392
ADDP4
INDIRI4
ARGI4
ADDRLP4 992
INDIRP4
CNSTI4 6416
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3369
;3368:	//get the weapon specific aim accuracy and or aim skill
;3369:	if (wi.number == WP_MACHINEGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 2
NEI4 $1823
line 3370
;3370:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_MACHINEGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3371
;3371:	} else if (wi.number == WP_SHOTGUN) {
ADDRGP4 $1824
JUMPV
LABELV $1823
ADDRLP4 160+4
INDIRI4
CNSTI4 3
NEI4 $1826
line 3372
;3372:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_SHOTGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 9
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3373
;3373:	} else if (wi.number == WP_GRENADE_LAUNCHER) {
ADDRGP4 $1827
JUMPV
LABELV $1826
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1829
line 3374
;3374:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 11
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3375
;3375:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 18
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3376
;3376:	} else if (wi.number == WP_ROCKET_LAUNCHER) {
ADDRGP4 $1830
JUMPV
LABELV $1829
ADDRLP4 160+4
INDIRI4
CNSTI4 5
NEI4 $1832
line 3377
;3377:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 10
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3378
;3378:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3379
;3379:	} else if (wi.number == WP_LIGHTNING) {
ADDRGP4 $1833
JUMPV
LABELV $1832
ADDRLP4 160+4
INDIRI4
CNSTI4 6
NEI4 $1835
line 3380
;3380:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_LIGHTNING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3381
;3381:	} else if (wi.number == WP_RAILGUN) {
ADDRGP4 $1836
JUMPV
LABELV $1835
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $1838
line 3382
;3382:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_RAILGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 14
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3383
;3383:	} else if (wi.number == WP_PLASMAGUN) {
ADDRGP4 $1839
JUMPV
LABELV $1838
ADDRLP4 160+4
INDIRI4
CNSTI4 8
NEI4 $1841
line 3384
;3384:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3385
;3385:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 19
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3386
;3386:	} else if (wi.number == WP_BFG) {
ADDRGP4 $1842
JUMPV
LABELV $1841
ADDRLP4 160+4
INDIRI4
CNSTI4 9
NEI4 $1844
line 3387
;3387:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 15
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3388
;3388:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 20
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3389
;3389:	}
LABELV $1844
LABELV $1842
LABELV $1839
LABELV $1836
LABELV $1833
LABELV $1830
LABELV $1827
LABELV $1824
line 3391
;3390:	//
;3391:	if (aim_accuracy <= 0) aim_accuracy = 0.0001f;
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1847
ADDRLP4 156
CNSTF4 953267991
ASGNF4
LABELV $1847
line 3393
;3392:	//get the enemy entity information
;3393:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3395
;3394:	//if the enemy is invisible then shoot crappy most of the time
;3395:	if (EntityIsInvisible(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 996
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
EQI4 $1849
line 3396
;3396:		if (random() > 0.1) aim_accuracy *= 0.4f;
ADDRLP4 1000
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1036831949
LEF4 $1851
ADDRLP4 156
CNSTF4 1053609165
ADDRLP4 156
INDIRF4
MULF4
ASGNF4
LABELV $1851
line 3397
;3397:	}
LABELV $1849
line 3399
;3398:	//
;3399:	VectorSubtract(entinfo.origin, entinfo.lastvisorigin, enemyvelocity);
ADDRLP4 712
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3400
;3400:	VectorScale(enemyvelocity, 1 / entinfo.update_time, enemyvelocity);
ADDRLP4 1000
CNSTF4 1065353216
ASGNF4
ADDRLP4 712
ADDRLP4 712
INDIRF4
ADDRLP4 1000
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 712+4
INDIRF4
ADDRLP4 1000
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 712+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3402
;3401:	//enemy origin and velocity is remembered every 0.5 seconds
;3402:	if (bs->enemyposition_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1872
line 3404
;3403:		//
;3404:		bs->enemyposition_time = FloatTime() + 0.5;
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 3405
;3405:		VectorCopy(enemyvelocity, bs->enemyvelocity);
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
ADDRLP4 712
INDIRB
ASGNB 12
line 3406
;3406:		VectorCopy(entinfo.origin, bs->enemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3407
;3407:	}
LABELV $1872
line 3409
;3408:	//if not extremely skilled
;3409:	if (aim_skill < 0.9) {
ADDRLP4 736
INDIRF4
CNSTF4 1063675494
GEF4 $1875
line 3410
;3410:		VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1004
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1004
INDIRP4
CNSTI4 6104
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6108
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3412
;3411:		//if the enemy moved a bit
;3412:		if (VectorLengthSquared(dir) > Square(48)) {
ADDRLP4 140
ARGP4
ADDRLP4 1008
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1008
INDIRF4
CNSTF4 1158676480
LEF4 $1884
line 3414
;3413:			//if the enemy changed direction
;3414:			if (DotProduct(bs->enemyvelocity, enemyvelocity) < 0) {
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
INDIRP4
CNSTI4 6088
ADDP4
INDIRF4
ADDRLP4 712
INDIRF4
MULF4
ADDRLP4 1012
INDIRP4
CNSTI4 6092
ADDP4
INDIRF4
ADDRLP4 712+4
INDIRF4
MULF4
ADDF4
ADDRLP4 1012
INDIRP4
CNSTI4 6096
ADDP4
INDIRF4
ADDRLP4 712+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $1886
line 3416
;3415:				//aim accuracy should be worse now
;3416:				aim_accuracy *= 0.7f;
ADDRLP4 156
CNSTF4 1060320051
ADDRLP4 156
INDIRF4
MULF4
ASGNF4
line 3417
;3417:			}
LABELV $1886
line 3418
;3418:		}
LABELV $1884
line 3419
;3419:	}
LABELV $1875
line 3421
;3420:	//check visibility of enemy
;3421:	enemyvisible = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 1004
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 1004
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 1004
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 1008
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 836
ADDRLP4 1008
INDIRF4
CVFI4 4
ASGNI4
line 3423
;3422:	//if the enemy is visible
;3423:	if (enemyvisible) {
ADDRLP4 836
INDIRI4
CNSTI4 0
EQI4 $1890
line 3425
;3424:		//
;3425:		VectorCopy(entinfo.origin, bestorigin);
ADDRLP4 724
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3426
;3426:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3429
;3427:		//get the start point shooting from
;3428:		//NOTE: the x and y projectile start offsets are ignored
;3429:		VectorCopy(bs->origin, start);
ADDRLP4 844
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
INDIRB
ASGNB 12
line 3430
;3430:		start[2] += bs->cur_ps.viewheight;
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3431
;3431:		start[2] += wi.offset[2];
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRLP4 160+292+8
INDIRF4
ADDF4
ASGNF4
line 3433
;3432:		//
;3433:		BotAI_Trace(&trace, start, mins, maxs, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
ADDRLP4 860
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 724
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3435
;3434:		//if the enemy is NOT hit
;3435:		if (trace.fraction <= 1 && trace.ent != entinfo.number) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
GTF4 $1898
ADDRLP4 740+80
INDIRI4
ADDRLP4 0+20
INDIRI4
EQI4 $1898
line 3436
;3436:			bestorigin[2] += 16;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 3437
;3437:		}
LABELV $1898
line 3439
;3438:		//if it is not an instant hit weapon the bot might want to predict the enemy
;3439:		if (wi.speed) {
ADDRLP4 160+272
INDIRF4
CNSTF4 0
EQF4 $1904
line 3441
;3440:			//
;3441:			VectorSubtract(bestorigin, bs->origin, dir);
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3442
;3442:			dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1016
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1016
INDIRF4
ASGNF4
line 3443
;3443:			VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 6104
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6108
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3445
;3444:			//if the enemy is NOT pretty far away and strafing just small steps left and right
;3445:			if (!(dist > 100 && VectorLengthSquared(dir) < Square(32))) {
ADDRLP4 840
INDIRF4
CNSTF4 1120403456
LEF4 $1920
ADDRLP4 140
ARGP4
ADDRLP4 1024
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1024
INDIRF4
CNSTF4 1149239296
LTF4 $1918
LABELV $1920
line 3447
;3446:				//if skilled anough do exact prediction
;3447:				if (aim_skill > 0.8 &&
ADDRLP4 736
INDIRF4
CNSTF4 1061997773
LEF4 $1921
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1921
line 3449
;3448:						//if the weapon is ready to fire
;3449:						bs->cur_ps.weaponstate == WEAPON_READY) {
line 3453
;3450:					aas_clientmove_t move;
;3451:					vec3_t origin;
;3452:
;3453:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1124
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1124
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3455
;3454:					//distance towards the enemy
;3455:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1128
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1128
INDIRF4
ASGNF4
line 3457
;3456:					//direction the enemy is moving in
;3457:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3459
;3458:					//
;3459:					VectorScale(dir, 1 / entinfo.update_time, dir);
ADDRLP4 1132
CNSTF4 1065353216
ASGNF4
ADDRLP4 140
ADDRLP4 140
INDIRF4
ADDRLP4 1132
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
ADDRLP4 1132
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 140+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3461
;3460:					//
;3461:					VectorCopy(entinfo.origin, origin);
ADDRLP4 1028
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3462
;3462:					origin[2] += 1;
ADDRLP4 1028+8
ADDRLP4 1028+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3464
;3463:					//
;3464:					VectorClear(cmdmove);
ADDRLP4 1136
CNSTF4 0
ASGNF4
ADDRLP4 968+8
ADDRLP4 1136
INDIRF4
ASGNF4
ADDRLP4 968+4
ADDRLP4 1136
INDIRF4
ASGNF4
ADDRLP4 968
ADDRLP4 1136
INDIRF4
ASGNF4
line 3466
;3465:					//AAS_ClearShownDebugLines();
;3466:					trap_AAS_PredictClientMovement(&move, bs->enemy, origin,
ADDRLP4 1040
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 1140
CNSTI4 0
ASGNI4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRLP4 140
ARGP4
ADDRLP4 968
ARGP4
ADDRLP4 1140
INDIRI4
ARGI4
CNSTF4 1092616192
ADDRLP4 840
INDIRF4
MULF4
ADDRLP4 160+272
INDIRF4
DIVF4
CVFI4 4
ARGI4
CNSTF4 1036831949
ARGF4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRLP4 1140
INDIRI4
ARGI4
ADDRGP4 trap_AAS_PredictClientMovement
CALLI4
pop
line 3470
;3467:							PRESENCE_CROUCH, qfalse,
;3468:							dir, cmdmove, 0,
;3469:							dist * 10 / wi.speed, 0.1f, 0, 0, qfalse);
;3470:					VectorCopy(move.endpos, bestorigin);
ADDRLP4 724
ADDRLP4 1040
INDIRB
ASGNB 12
line 3472
;3471:					//BotAI_Print(PRT_MESSAGE, "%1.1f predicted speed = %f, frames = %f\n", FloatTime(), VectorLength(dir), dist * 10 / wi.speed);
;3472:				}					//if not that skilled do linear prediction
ADDRGP4 $1922
JUMPV
LABELV $1921
line 3473
;3473:				else if (aim_skill > 0.4) {
ADDRLP4 736
INDIRF4
CNSTF4 1053609165
LEF4 $1954
line 3474
;3474:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1028
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1028
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3476
;3475:					//distance towards the enemy
;3476:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1032
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1032
INDIRF4
ASGNF4
line 3478
;3477:					//direction the enemy is moving in
;3478:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3479
;3479:					dir[2] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 3481
;3480:					//
;3481:					speed = VectorNormalize(dir) / entinfo.update_time;
ADDRLP4 140
ARGP4
ADDRLP4 1036
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 980
ADDRLP4 1036
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
ASGNF4
line 3484
;3482:					//botimport.Print(PRT_MESSAGE, "speed = %f, wi->speed = %f\n", speed, wi->speed);
;3483:					//best spot to aim at
;3484:					VectorMA(entinfo.origin, (dist / wi.speed) * speed, dir, bestorigin);
ADDRLP4 1040
ADDRLP4 840
INDIRF4
ASGNF4
ADDRLP4 1044
ADDRLP4 980
INDIRF4
ASGNF4
ADDRLP4 724
ADDRLP4 0+24
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 1040
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1044
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 140+4
INDIRF4
ADDRLP4 1040
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1044
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 140+8
INDIRF4
ADDRLP4 840
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 980
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 3485
;3485:				}
LABELV $1954
LABELV $1922
line 3486
;3486:			}
LABELV $1918
line 3487
;3487:		}
LABELV $1904
line 3489
;3488:		//if the projectile does radial damage
;3489:		if (aim_skill > 0.6 && wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 736
INDIRF4
CNSTF4 1058642330
LEF4 $1989
ADDRLP4 160+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1989
line 3491
;3490:			//if the enemy isn't standing significantly higher than the bot
;3491:			if (entinfo.origin[2] < bs->origin[2] + 16) {
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
GEF4 $1993
line 3493
;3492:				//try to aim at the ground in front of the enemy
;3493:				VectorCopy(entinfo.origin, end);
ADDRLP4 956
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3494
;3494:				end[2] -= 64;
ADDRLP4 956+8
ADDRLP4 956+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 3495
;3495:				BotAI_Trace(&trace, entinfo.origin, NULL, NULL, end, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 1012
CNSTP4 0
ASGNP4
ADDRLP4 1012
INDIRP4
ARGP4
ADDRLP4 1012
INDIRP4
ARGP4
ADDRLP4 956
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3497
;3496:				//
;3497:				VectorCopy(bestorigin, groundtarget);
ADDRLP4 944
ADDRLP4 724
INDIRB
ASGNB 12
line 3498
;3498:				if (trace.startsolid) groundtarget[2] = entinfo.origin[2] - 16;
ADDRLP4 740+4
INDIRI4
CNSTI4 0
EQI4 $2001
ADDRLP4 944+8
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
ADDRGP4 $2002
JUMPV
LABELV $2001
line 3499
;3499:				else groundtarget[2] = trace.endpos[2] - 8;
ADDRLP4 944+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
LABELV $2002
line 3501
;3500:				//trace a line from projectile start to ground target
;3501:				BotAI_Trace(&trace, start, NULL, NULL, groundtarget, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
ADDRLP4 1016
CNSTP4 0
ASGNP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 944
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3503
;3502:				//if hitpoint is not vertically too far from the ground target
;3503:				if (fabs(trace.endpos[2] - groundtarget[2]) < 50) {
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ARGF4
ADDRLP4 1020
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 1020
INDIRF4
CNSTF4 1112014848
GEF4 $2010
line 3504
;3504:					VectorSubtract(trace.endpos, groundtarget, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 944
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 944+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ASGNF4
line 3506
;3505:					//if the hitpoint is near anough the ground target
;3506:					if (VectorLengthSquared(dir) < Square(60)) {
ADDRLP4 140
ARGP4
ADDRLP4 1024
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1024
INDIRF4
CNSTF4 1163984896
GEF4 $2024
line 3507
;3507:						VectorSubtract(trace.endpos, start, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 844
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 844+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 844+8
INDIRF4
SUBF4
ASGNF4
line 3509
;3508:						//if the hitpoint is far anough from the bot
;3509:						if (VectorLengthSquared(dir) > Square(100)) {
ADDRLP4 140
ARGP4
ADDRLP4 1028
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1028
INDIRF4
CNSTF4 1176256512
LEF4 $2035
line 3511
;3510:							//check if the bot is visible from the ground target
;3511:							trace.endpos[2] += 1;
ADDRLP4 740+12+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3512
;3512:							BotAI_Trace(&trace, trace.endpos, NULL, NULL, entinfo.origin, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 740+12
ARGP4
ADDRLP4 1032
CNSTP4 0
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3513
;3513:							if (trace.fraction >= 1) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
LTF4 $2042
line 3515
;3514:								//botimport.Print(PRT_MESSAGE, "%1.1f aiming at ground\n", AAS_Time());
;3515:								VectorCopy(groundtarget, bestorigin);
ADDRLP4 724
ADDRLP4 944
INDIRB
ASGNB 12
line 3516
;3516:							}
LABELV $2042
line 3517
;3517:						}
LABELV $2035
line 3518
;3518:					}
LABELV $2024
line 3519
;3519:				}
LABELV $2010
line 3520
;3520:			}
LABELV $1993
line 3521
;3521:		}
LABELV $1989
line 3522
;3522:		bestorigin[0] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724
ADDRLP4 724
INDIRF4
CNSTF4 1101004800
CNSTF4 1073741824
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3523
;3523:		bestorigin[1] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+4
ADDRLP4 724+4
INDIRF4
CNSTF4 1101004800
CNSTF4 1073741824
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3524
;3524:		bestorigin[2] += 10 * crandom() * (1 - aim_accuracy);
ADDRLP4 1020
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1092616192
CNSTF4 1073741824
ADDRLP4 1020
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3525
;3525:	} else {
ADDRGP4 $1891
JUMPV
LABELV $1890
line 3527
;3526:		//
;3527:		VectorCopy(bs->lastenemyorigin, bestorigin);
ADDRLP4 724
ADDRFP4 0
INDIRP4
CNSTI4 6404
ADDP4
INDIRB
ASGNB 12
line 3528
;3528:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3530
;3529:		//if the bot is skilled anough
;3530:		if (aim_skill > 0.5) {
ADDRLP4 736
INDIRF4
CNSTF4 1056964608
LEF4 $2048
line 3532
;3531:			//do prediction shots around corners
;3532:			if (wi.number == WP_BFG ||
ADDRLP4 160+4
INDIRI4
CNSTI4 9
EQI4 $2056
ADDRLP4 160+4
INDIRI4
CNSTI4 5
EQI4 $2056
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $2050
LABELV $2056
line 3534
;3533:					wi.number == WP_ROCKET_LAUNCHER ||
;3534:					wi.number == WP_GRENADE_LAUNCHER) {
line 3536
;3535:				//create the chase goal
;3536:				goal.entitynum = bs->client;
ADDRLP4 884+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 3537
;3537:				goal.areanum = bs->areanum;
ADDRLP4 884+12
ADDRFP4 0
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ASGNI4
line 3538
;3538:				VectorCopy(bs->eye, goal.origin);
ADDRLP4 884
ADDRFP4 0
INDIRP4
CNSTI4 4792
ADDP4
INDIRB
ASGNB 12
line 3539
;3539:				VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 884+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+8
CNSTF4 3238002688
ASGNF4
line 3540
;3540:				VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 884+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+8
CNSTF4 1090519040
ASGNF4
line 3542
;3541:				//
;3542:				if (trap_BotPredictVisiblePosition(bs->lastenemyorigin, bs->lastenemyareanum, &goal, TFL_DEFAULT, target)) {
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
INDIRP4
CNSTI4 6404
ADDP4
ARGP4
ADDRLP4 1012
INDIRP4
CNSTI4 6400
ADDP4
INDIRI4
ARGI4
ADDRLP4 884
ARGP4
CNSTI4 18616254
ARGI4
ADDRLP4 824
ARGP4
ADDRLP4 1016
ADDRGP4 trap_BotPredictVisiblePosition
CALLI4
ASGNI4
ADDRLP4 1016
INDIRI4
CNSTI4 0
EQI4 $2069
line 3543
;3543:					VectorSubtract(target, bs->eye, dir);
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 824
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 4792
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 824+4
INDIRF4
ADDRLP4 1020
INDIRP4
CNSTI4 4796
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 824+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4800
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3544
;3544:					if (VectorLengthSquared(dir) > Square(80)) {
ADDRLP4 140
ARGP4
ADDRLP4 1024
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1024
INDIRF4
CNSTF4 1170735104
LEF4 $2075
line 3545
;3545:						VectorCopy(target, bestorigin);
ADDRLP4 724
ADDRLP4 824
INDIRB
ASGNB 12
line 3546
;3546:						bestorigin[2] -= 20;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 3547
;3547:					}
LABELV $2075
line 3548
;3548:				}
LABELV $2069
line 3549
;3549:				aim_accuracy = 1;
ADDRLP4 156
CNSTF4 1065353216
ASGNF4
line 3550
;3550:			}
LABELV $2050
line 3551
;3551:		}
LABELV $2048
line 3552
;3552:	}
LABELV $1891
line 3554
;3553:	//
;3554:	if (enemyvisible) {
ADDRLP4 836
INDIRI4
CNSTI4 0
EQI4 $2078
line 3555
;3555:		BotAI_Trace(&trace, bs->eye, NULL, NULL, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1012
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 1016
CNSTP4 0
ASGNP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 1016
INDIRP4
ARGP4
ADDRLP4 724
ARGP4
ADDRLP4 1012
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3556
;3556:		VectorCopy(trace.endpos, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6076
ADDP4
ADDRLP4 740+12
INDIRB
ASGNB 12
line 3557
;3557:	} else {
ADDRGP4 $2079
JUMPV
LABELV $2078
line 3558
;3558:		VectorCopy(bestorigin, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6076
ADDP4
ADDRLP4 724
INDIRB
ASGNB 12
line 3559
;3559:	}
LABELV $2079
line 3561
;3560:	//get aim direction
;3561:	VectorSubtract(bestorigin, bs->eye, dir);
ADDRLP4 1012
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4792
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1012
INDIRP4
CNSTI4 4796
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4800
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3563
;3562:	//
;3563:	if (wi.number == WP_MACHINEGUN ||
ADDRLP4 160+4
INDIRI4
CNSTI4 2
EQI4 $2093
ADDRLP4 160+4
INDIRI4
CNSTI4 3
EQI4 $2093
ADDRLP4 160+4
INDIRI4
CNSTI4 6
EQI4 $2093
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $2085
LABELV $2093
line 3566
;3564:			wi.number == WP_SHOTGUN ||
;3565:			wi.number == WP_LIGHTNING ||
;3566:			wi.number == WP_RAILGUN) {
line 3568
;3567:		//distance towards the enemy
;3568:		dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1016
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1016
INDIRF4
ASGNF4
line 3569
;3569:		if (dist > 150) dist = 150;
ADDRLP4 840
INDIRF4
CNSTF4 1125515264
LEF4 $2094
ADDRLP4 840
CNSTF4 1125515264
ASGNF4
LABELV $2094
line 3570
;3570:		f = 0.6 + dist / 150 * 0.4;
ADDRLP4 940
CNSTF4 1053609165
ADDRLP4 840
INDIRF4
CNSTF4 1125515264
DIVF4
MULF4
CNSTF4 1058642330
ADDF4
ASGNF4
line 3571
;3571:		aim_accuracy *= f;
ADDRLP4 156
ADDRLP4 156
INDIRF4
ADDRLP4 940
INDIRF4
MULF4
ASGNF4
line 3572
;3572:	}
LABELV $2085
line 3574
;3573:	//add some random stuff to the aim direction depending on the aim accuracy
;3574:	if (aim_accuracy < 0.8) {
ADDRLP4 156
INDIRF4
CNSTF4 1061997773
GEF4 $2096
line 3575
;3575:		VectorNormalize(dir);
ADDRLP4 140
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 3576
;3576:		for (i = 0; i < 3; i++) dir[i] += 0.3 * crandom() * (1 - aim_accuracy);
ADDRLP4 152
CNSTI4 0
ASGNI4
LABELV $2098
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1020
ADDRLP4 152
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
ADDP4
ASGNP4
ADDRLP4 1020
INDIRP4
ADDRLP4 1020
INDIRP4
INDIRF4
CNSTF4 1050253722
CNSTF4 1073741824
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
LABELV $2099
ADDRLP4 152
ADDRLP4 152
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 3
LTI4 $2098
line 3577
;3577:	}
LABELV $2096
line 3579
;3578:	//set the ideal view angles
;3579:	vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3581
;3580:	//take the weapon spread into account for lower skilled bots
;3581:	bs->ideal_viewangles[PITCH] += 6 * wi.vspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1020
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ASGNP4
ADDRLP4 1020
INDIRP4
ADDRLP4 1020
INDIRP4
INDIRF4
CNSTF4 1086324736
ADDRLP4 160+268
INDIRF4
MULF4
CNSTF4 1073741824
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3582
;3582:	bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ASGNP4
ADDRLP4 1024
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1028
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1024
INDIRP4
ADDRLP4 1028
INDIRF4
ASGNF4
line 3583
;3583:	bs->ideal_viewangles[YAW] += 6 * wi.hspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1032
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 6436
ADDP4
ASGNP4
ADDRLP4 1036
INDIRP4
ADDRLP4 1036
INDIRP4
INDIRF4
CNSTF4 1086324736
ADDRLP4 160+264
INDIRF4
MULF4
CNSTF4 1073741824
ADDRLP4 1032
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3584
;3584:	bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CNSTI4 6436
ADDP4
ASGNP4
ADDRLP4 1040
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1044
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1040
INDIRP4
ADDRLP4 1044
INDIRF4
ASGNF4
line 3586
;3585:	//if the bots should be really challenging
;3586:	if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $2104
line 3588
;3587:		//if the bot is really accurate and has the enemy in view for some time
;3588:		if (aim_accuracy > 0.9 && bs->enemysight_time < FloatTime() - 1) {
ADDRLP4 156
INDIRF4
CNSTF4 1063675494
LEF4 $2107
ADDRFP4 0
INDIRP4
CNSTI4 5988
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $2107
line 3590
;3589:			//set the view angles directly
;3590:			if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $2109
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $2109
line 3591
;3591:			VectorCopy(bs->ideal_viewangles, bs->viewangles);
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 6420
ADDP4
ADDRLP4 1052
INDIRP4
CNSTI4 6432
ADDP4
INDIRB
ASGNB 12
line 3592
;3592:			trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1056
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 3593
;3593:		}
LABELV $2107
line 3594
;3594:	}
LABELV $2104
line 3595
;3595:}
LABELV $1799
endproc BotAimAtEnemy 1144 52
lit
align 4
LABELV $2112
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $2113
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCheckAttack
code
proc BotCheckAttack 1028 28
line 3602
;3596:
;3597:/*
;3598:==================
;3599:BotCheckAttack
;3600:==================
;3601: */
;3602:void BotCheckAttack(bot_state_t *bs) {
line 3611
;3603:	float points, reactiontime, fov, firethrottle;
;3604:	int attackentity;
;3605:	bsp_trace_t bsptrace;
;3606:	//float selfpreservation;
;3607:	vec3_t forward, right, start, end, dir, angles;
;3608:	weaponinfo_t wi;
;3609:	bsp_trace_t trace;
;3610:	aas_entityinfo_t entinfo;
;3611:	vec3_t mins = {-8, -8, -8}, maxs = {8, 8, 8};
ADDRLP4 948
ADDRGP4 $2112
INDIRB
ASGNB 12
ADDRLP4 960
ADDRGP4 $2113
INDIRB
ASGNB 12
line 3613
;3612:
;3613:	attackentity = bs->enemy;
ADDRLP4 576
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ASGNI4
line 3615
;3614:	//
;3615:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 576
INDIRI4
ARGI4
ADDRLP4 788
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3617
;3616:	// if not attacking a player
;3617:	if (attackentity >= MAX_CLIENTS) {
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $2114
line 3619
;3618:		// if attacking an obelisk
;3619:		if (entinfo.number == redobelisk.entitynum ||
ADDRLP4 788+20
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $2122
ADDRLP4 788+20
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
NEI4 $2116
LABELV $2122
line 3620
;3620:				entinfo.number == blueobelisk.entitynum) {
line 3622
;3621:			// if obelisk is respawning return
;3622:			if (g_entities[entinfo.number].activator &&
ADDRLP4 976
CNSTI4 816
ASGNI4
ADDRLP4 976
INDIRI4
ADDRLP4 788+20
INDIRI4
MULI4
ADDRGP4 g_entities+772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2123
ADDRLP4 976
INDIRI4
ADDRLP4 788+20
INDIRI4
MULI4
ADDRGP4 g_entities+772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2123
line 3623
;3623:					g_entities[entinfo.number].activator->s.frame == 2) {
line 3624
;3624:				return;
ADDRGP4 $2111
JUMPV
LABELV $2123
line 3626
;3625:			}
;3626:		}
LABELV $2116
line 3627
;3627:	}
LABELV $2114
line 3629
;3628:	//
;3629:	reactiontime = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 976
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 700
ADDRLP4 976
INDIRF4
ASGNF4
line 3630
;3630:	if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 5988
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 700
INDIRF4
SUBF4
LEF4 $2129
ADDRGP4 $2111
JUMPV
LABELV $2129
line 3631
;3631:	if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6036
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 700
INDIRF4
SUBF4
LEF4 $2131
ADDRGP4 $2111
JUMPV
LABELV $2131
line 3633
;3632:	//if changing weapons
;3633:	if (bs->weaponchange_time > FloatTime() - 0.1) return;
ADDRFP4 0
INDIRP4
CNSTI4 6048
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1036831949
SUBF4
LEF4 $2133
ADDRGP4 $2111
JUMPV
LABELV $2133
line 3635
;3634:	//check fire throttle characteristic
;3635:	if (bs->firethrottlewait_time > FloatTime()) return;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $2135
ADDRGP4 $2111
JUMPV
LABELV $2135
line 3636
;3636:	firethrottle = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_FIRETHROTTLE, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 47
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 932
ADDRLP4 980
INDIRF4
ASGNF4
line 3637
;3637:	if (bs->firethrottleshoot_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6056
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $2137
line 3638
;3638:		if (random() > firethrottle) {
ADDRLP4 984
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 984
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 932
INDIRF4
LEF4 $2139
line 3639
;3639:			bs->firethrottlewait_time = FloatTime() + firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 932
INDIRF4
ADDF4
ASGNF4
line 3640
;3640:			bs->firethrottleshoot_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6056
ADDP4
CNSTF4 0
ASGNF4
line 3641
;3641:		} else {
ADDRGP4 $2140
JUMPV
LABELV $2139
line 3642
;3642:			bs->firethrottleshoot_time = FloatTime() + 1 - firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6056
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 932
INDIRF4
SUBF4
ASGNF4
line 3643
;3643:			bs->firethrottlewait_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTF4 0
ASGNF4
line 3644
;3644:		}
LABELV $2140
line 3645
;3645:	}
LABELV $2137
line 3648
;3646:	//
;3647:	//
;3648:	VectorSubtract(bs->aimtarget, bs->eye, dir);
ADDRLP4 984
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580
ADDRLP4 984
INDIRP4
CNSTI4 6076
ADDP4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4792
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 580+4
ADDRLP4 984
INDIRP4
CNSTI4 6080
ADDP4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4796
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580+8
ADDRLP4 988
INDIRP4
CNSTI4 6084
ADDP4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4800
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3650
;3649:	//
;3650:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2143
line 3651
;3651:		if (VectorLengthSquared(dir) > Square(60)) {
ADDRLP4 580
ARGP4
ADDRLP4 992
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 992
INDIRF4
CNSTF4 1163984896
LEF4 $2145
line 3652
;3652:			return;
ADDRGP4 $2111
JUMPV
LABELV $2145
line 3654
;3653:		}
;3654:	}
LABELV $2143
line 3655
;3655:	if (VectorLengthSquared(dir) < Square(100))
ADDRLP4 580
ARGP4
ADDRLP4 992
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 992
INDIRF4
CNSTF4 1176256512
GEF4 $2147
line 3656
;3656:		fov = 120;
ADDRLP4 928
CNSTF4 1123024896
ASGNF4
ADDRGP4 $2148
JUMPV
LABELV $2147
line 3658
;3657:	else
;3658:		fov = 50;
ADDRLP4 928
CNSTF4 1112014848
ASGNF4
LABELV $2148
line 3660
;3659:	//
;3660:	vectoangles(dir, angles);
ADDRLP4 580
ARGP4
ADDRLP4 936
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3661
;3661:	if (!InFieldOfVision(bs->viewangles, fov, angles))
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
ADDRLP4 928
INDIRF4
ARGF4
ADDRLP4 936
ARGP4
ADDRLP4 996
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
NEI4 $2149
line 3662
;3662:		return;
ADDRGP4 $2111
JUMPV
LABELV $2149
line 3663
;3663:	BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->aimtarget, bs->client, CONTENTS_SOLID | CONTENTS_PLAYERCLIP);
ADDRLP4 704
ARGP4
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 1004
CNSTP4 0
ASGNP4
ADDRLP4 1004
INDIRP4
ARGP4
ADDRLP4 1004
INDIRP4
ARGP4
ADDRLP4 1000
INDIRP4
CNSTI4 6076
ADDP4
ARGP4
ADDRLP4 1000
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
line 3664
;3664:	if (bsptrace.fraction < 1 && bsptrace.ent != attackentity)
ADDRLP4 704+8
INDIRF4
CNSTF4 1065353216
GEF4 $2151
ADDRLP4 704+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $2151
line 3665
;3665:		return;
ADDRGP4 $2111
JUMPV
LABELV $2151
line 3668
;3666:
;3667:	//get the weapon info
;3668:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6392
ADDP4
INDIRI4
ARGI4
ADDRLP4 1008
INDIRP4
CNSTI4 6416
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3670
;3669:	//get the start point shooting from
;3670:	VectorCopy(bs->origin, start);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
INDIRB
ASGNB 12
line 3671
;3671:	start[2] += bs->cur_ps.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3672
;3672:	AngleVectors(bs->viewangles, forward, right, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 676
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3673
;3673:	start[0] += forward[0] * wi.offset[0] + right[0] * wi.offset[1];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3674
;3674:	start[1] += forward[1] * wi.offset[0] + right[1] * wi.offset[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+4
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3675
;3675:	start[2] += forward[2] * wi.offset[0] + right[2] * wi.offset[1] + wi.offset[2];
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+8
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 24+292+8
INDIRF4
ADDF4
ADDF4
ASGNF4
line 3677
;3676:	//end point aiming at
;3677:	VectorMA(start, 1000, forward, end);
ADDRLP4 1012
CNSTF4 1148846080
ASGNF4
ADDRLP4 688
ADDRLP4 0
INDIRF4
ADDRLP4 1012
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 688+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 1012
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 688+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1148846080
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3679
;3678:	//a little back to make sure not inside a very close enemy
;3679:	VectorMA(start, -12, forward, start);
ADDRLP4 1016
CNSTF4 3242196992
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 1016
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 1016
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 3242196992
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3680
;3680:	BotAI_Trace(&trace, start, mins, maxs, end, bs->entitynum, MASK_SHOT);
ADDRLP4 592
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 948
ARGP4
ADDRLP4 960
ARGP4
ADDRLP4 688
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3682
;3681:	//if the entity is a client
;3682:	if (trace.ent >= 0 && trace.ent < MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
CNSTI4 0
LTI4 $2185
ADDRLP4 592+80
INDIRI4
CNSTI4 64
GEI4 $2185
line 3683
;3683:		if (trace.ent != attackentity) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $2189
line 3685
;3684:			//if a teammate is hit
;3685:			if (BotSameTeam(bs, trace.ent))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 592+80
INDIRI4
ARGI4
ADDRLP4 1020
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1020
INDIRI4
CNSTI4 0
EQI4 $2192
line 3686
;3686:				return;
ADDRGP4 $2111
JUMPV
LABELV $2192
line 3687
;3687:		}
LABELV $2189
line 3688
;3688:	}
LABELV $2185
line 3690
;3689:	//if won't hit the enemy or not attacking a player (obelisk)
;3690:	if (trace.ent != attackentity || attackentity >= MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
NEI4 $2198
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $2195
LABELV $2198
line 3692
;3691:		//if the projectile does radial damage
;3692:		if (wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 24+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2199
line 3693
;3693:			if (trace.fraction * 1000 < wi.proj.radius) {
CNSTF4 1148846080
ADDRLP4 592+8
INDIRF4
MULF4
ADDRLP4 24+344+172
INDIRF4
GEF4 $2203
line 3694
;3694:				points = (wi.proj.damage - 0.5 * trace.fraction * 1000) * 0.5;
ADDRLP4 1024
CNSTF4 1056964608
ASGNF4
ADDRLP4 972
ADDRLP4 1024
INDIRF4
ADDRLP4 24+344+168
INDIRI4
CVIF4 4
CNSTF4 1148846080
ADDRLP4 1024
INDIRF4
ADDRLP4 592+8
INDIRF4
MULF4
MULF4
SUBF4
MULF4
ASGNF4
line 3695
;3695:				if (points > 0) {
ADDRLP4 972
INDIRF4
CNSTF4 0
LEF4 $2211
line 3696
;3696:					return;
ADDRGP4 $2111
JUMPV
LABELV $2211
line 3698
;3697:				}
;3698:			}
LABELV $2203
line 3700
;3699:			//FIXME: check if a teammate gets radial damage
;3700:		}
LABELV $2199
line 3701
;3701:	}
LABELV $2195
line 3703
;3702:	//if fire has to be release to activate weapon
;3703:	if (wi.flags & WFL_FIRERELEASED) {
ADDRLP4 24+176
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2213
line 3704
;3704:		if (bs->flags & BFL_ATTACKED) {
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2214
line 3705
;3705:			trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3706
;3706:		}
line 3707
;3707:	} else {
ADDRGP4 $2214
JUMPV
LABELV $2213
line 3708
;3708:		trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3709
;3709:	}
LABELV $2214
line 3710
;3710:	bs->flags ^= BFL_ATTACKED;
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
ASGNP4
ADDRLP4 1024
INDIRP4
ADDRLP4 1024
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 3711
;3711:}
LABELV $2111
endproc BotCheckAttack 1028 28
lit
align 4
LABELV $2228
byte 4 1143832576
byte 4 1128792064
byte 4 1139802112
align 4
LABELV $2229
byte 4 1148321792
byte 4 1139539968
byte 4 1143603200
align 4
LABELV $2230
byte 4 1134034944
byte 4 1135607808
byte 4 1147535360
export BotMapScripts
code
proc BotMapScripts 1432 16
line 3718
;3712:
;3713:/*
;3714:==================
;3715:BotMapScripts
;3716:==================
;3717: */
;3718:void BotMapScripts(bot_state_t *bs) {
line 3726
;3719:	char info[1024];
;3720:	char mapname[128];
;3721:	int i, shootbutton;
;3722:	float aim_accuracy;
;3723:	aas_entityinfo_t entinfo;
;3724:	vec3_t dir;
;3725:
;3726:	trap_GetServerinfo(info, sizeof (info));
ADDRLP4 272
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 3728
;3727:
;3728:	strncpy(mapname, Info_ValueForKey(info, "mapname"), sizeof (mapname) - 1);
ADDRLP4 272
ARGP4
ADDRGP4 $2219
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 144
ARGP4
ADDRLP4 1316
INDIRP4
ARGP4
CNSTI4 127
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 3729
;3729:	mapname[sizeof (mapname) - 1] = '\0';
ADDRLP4 144+127
CNSTI1 0
ASGNI1
line 3731
;3730:
;3731:	if (Q_strequal(mapname, "q3tourney6") || Q_strequal(mapname, "q3tourney6_ctf") || Q_strequal(mapname, "mpq3tourney6")) {
ADDRLP4 144
ARGP4
ADDRGP4 $2223
ARGP4
ADDRLP4 1320
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1320
INDIRI4
CNSTI4 0
EQI4 $2227
ADDRLP4 144
ARGP4
ADDRGP4 $2224
ARGP4
ADDRLP4 1324
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
EQI4 $2227
ADDRLP4 144
ARGP4
ADDRGP4 $2225
ARGP4
ADDRLP4 1328
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 0
NEI4 $2221
LABELV $2227
line 3732
;3732:		vec3_t mins = {694, 200, 480}, maxs = {968, 472, 680};
ADDRLP4 1332
ADDRGP4 $2228
INDIRB
ASGNB 12
ADDRLP4 1344
ADDRGP4 $2229
INDIRB
ASGNB 12
line 3733
;3733:		vec3_t buttonorg = {304, 352, 920};
ADDRLP4 1356
ADDRGP4 $2230
INDIRB
ASGNB 12
line 3735
;3734:		//NOTE: NEVER use the func_bobbing in q3tourney6
;3735:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 1368
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 1368
INDIRP4
ADDRLP4 1368
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3737
;3736:		//crush area is higher in mpq3tourney6
;3737:		if (Q_strequal(mapname, "mpq3tourney6")) {
ADDRLP4 144
ARGP4
ADDRGP4 $2225
ARGP4
ADDRLP4 1372
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1372
INDIRI4
CNSTI4 0
NEI4 $2231
line 3738
;3738:			mins[2] += 64;
ADDRLP4 1332+8
ADDRLP4 1332+8
INDIRF4
CNSTF4 1115684864
ADDF4
ASGNF4
line 3739
;3739:			maxs[2] += 64;
ADDRLP4 1344+8
ADDRLP4 1344+8
INDIRF4
CNSTF4 1115684864
ADDF4
ASGNF4
line 3740
;3740:		}
LABELV $2231
line 3742
;3741:		//if the bot is in the bounding box of the crush area
;3742:		if (bs->origin[0] > mins[0] && bs->origin[0] < maxs[0]) {
ADDRLP4 1376
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1376
INDIRF4
ADDRLP4 1332
INDIRF4
LEF4 $2235
ADDRLP4 1376
INDIRF4
ADDRLP4 1344
INDIRF4
GEF4 $2235
line 3743
;3743:			if (bs->origin[1] > mins[1] && bs->origin[1] < maxs[1]) {
ADDRLP4 1380
ADDRFP4 0
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1380
INDIRF4
ADDRLP4 1332+4
INDIRF4
LEF4 $2237
ADDRLP4 1380
INDIRF4
ADDRLP4 1344+4
INDIRF4
GEF4 $2237
line 3744
;3744:				if (bs->origin[2] > mins[2] && bs->origin[2] < maxs[2]) {
ADDRLP4 1384
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ASGNF4
ADDRLP4 1384
INDIRF4
ADDRLP4 1332+8
INDIRF4
LEF4 $2241
ADDRLP4 1384
INDIRF4
ADDRLP4 1344+8
INDIRF4
GEF4 $2241
line 3745
;3745:					return;
ADDRGP4 $2218
JUMPV
LABELV $2241
line 3747
;3746:				}
;3747:			}
LABELV $2237
line 3748
;3748:		}
LABELV $2235
line 3749
;3749:		shootbutton = qfalse;
ADDRLP4 1296
CNSTI4 0
ASGNI4
line 3751
;3750:		//if an enemy is in the bounding box then shoot the button
;3751:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $2248
JUMPV
LABELV $2245
line 3753
;3752:
;3753:			if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2250
ADDRGP4 $2246
JUMPV
LABELV $2250
line 3755
;3754:			//
;3755:			BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3757
;3756:			//
;3757:			if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2252
ADDRGP4 $2246
JUMPV
LABELV $2252
line 3759
;3758:			//if the enemy isn't dead and the enemy isn't the bot self
;3759:			if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 1380
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 1380
INDIRI4
CNSTI4 0
NEI4 $2257
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2254
LABELV $2257
ADDRGP4 $2246
JUMPV
LABELV $2254
line 3761
;3760:			//
;3761:			if (entinfo.origin[0] > mins[0] && entinfo.origin[0] < maxs[0]) {
ADDRLP4 0+24
INDIRF4
ADDRLP4 1332
INDIRF4
LEF4 $2258
ADDRLP4 0+24
INDIRF4
ADDRLP4 1344
INDIRF4
GEF4 $2258
line 3762
;3762:				if (entinfo.origin[1] > mins[1] && entinfo.origin[1] < maxs[1]) {
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1332+4
INDIRF4
LEF4 $2262
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1344+4
INDIRF4
GEF4 $2262
line 3763
;3763:					if (entinfo.origin[2] > mins[2] && entinfo.origin[2] < maxs[2]) {
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 1332+8
INDIRF4
LEF4 $2270
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 1344+8
INDIRF4
GEF4 $2270
line 3765
;3764:						//if there's a team mate below the crusher
;3765:						if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 1384
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1384
INDIRI4
CNSTI4 0
EQI4 $2278
line 3766
;3766:							shootbutton = qfalse;
ADDRLP4 1296
CNSTI4 0
ASGNI4
line 3767
;3767:							break;
ADDRGP4 $2247
JUMPV
LABELV $2278
line 3768
;3768:						} else if (bs->enemy == i) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
NEI4 $2280
line 3769
;3769:							shootbutton = qtrue;
ADDRLP4 1296
CNSTI4 1
ASGNI4
line 3770
;3770:						}
LABELV $2280
line 3771
;3771:					}
LABELV $2270
line 3772
;3772:				}
LABELV $2262
line 3773
;3773:			}
LABELV $2258
line 3774
;3774:		}
LABELV $2246
line 3751
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2248
ADDRLP4 140
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $2245
LABELV $2247
line 3775
;3775:		if (shootbutton) {
ADDRLP4 1296
INDIRI4
CNSTI4 0
EQI4 $2282
line 3776
;3776:			bs->flags |= BFL_IDEALVIEWSET;
ADDRLP4 1380
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
ASGNP4
ADDRLP4 1380
INDIRP4
ADDRLP4 1380
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 3777
;3777:			VectorSubtract(buttonorg, bs->eye, dir);
ADDRLP4 1384
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1300
ADDRLP4 1356
INDIRF4
ADDRLP4 1384
INDIRP4
CNSTI4 4792
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1300+4
ADDRLP4 1356+4
INDIRF4
ADDRLP4 1384
INDIRP4
CNSTI4 4796
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1300+8
ADDRLP4 1356+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4800
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3778
;3778:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 1300
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3779
;3779:			aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1388
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 1312
ADDRLP4 1388
INDIRF4
ASGNF4
line 3780
;3780:			bs->ideal_viewangles[PITCH] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 1392
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1396
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ASGNP4
ADDRLP4 1396
INDIRP4
ADDRLP4 1396
INDIRP4
INDIRF4
CNSTF4 1090519040
CNSTF4 1073741824
ADDRLP4 1392
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 1312
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3781
;3781:			bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1400
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ASGNP4
ADDRLP4 1400
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1404
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1400
INDIRP4
ADDRLP4 1404
INDIRF4
ASGNF4
line 3782
;3782:			bs->ideal_viewangles[YAW] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 1408
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1412
ADDRFP4 0
INDIRP4
CNSTI4 6436
ADDP4
ASGNP4
ADDRLP4 1412
INDIRP4
ADDRLP4 1412
INDIRP4
INDIRF4
CNSTF4 1090519040
CNSTF4 1073741824
ADDRLP4 1408
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 1312
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3783
;3783:			bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1416
ADDRFP4 0
INDIRP4
CNSTI4 6436
ADDP4
ASGNP4
ADDRLP4 1416
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1420
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1416
INDIRP4
ADDRLP4 1420
INDIRF4
ASGNF4
line 3785
;3784:			//
;3785:			if (InFieldOfVision(bs->viewangles, 20, bs->ideal_viewangles)) {
ADDRLP4 1424
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1424
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 1424
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRLP4 1428
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 1428
INDIRI4
CNSTI4 0
EQI4 $2288
line 3786
;3786:				trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3787
;3787:			}
LABELV $2288
line 3788
;3788:		}
LABELV $2282
line 3789
;3789:	}
LABELV $2221
line 3790
;3790:}
LABELV $2218
endproc BotMapScripts 1432 16
data
align 4
LABELV VEC_UP
byte 4 0
byte 4 3212836864
byte 4 0
align 4
LABELV MOVEDIR_UP
byte 4 0
byte 4 0
byte 4 1065353216
align 4
LABELV VEC_DOWN
byte 4 0
byte 4 3221225472
byte 4 0
align 4
LABELV MOVEDIR_DOWN
byte 4 0
byte 4 0
byte 4 3212836864
export BotSetMovedir
code
proc BotSetMovedir 12 16
line 3803
;3791:
;3792:/*
;3793:==================
;3794:BotSetMovedir
;3795:==================
;3796: */
;3797:// bk001205 - made these static
;3798:static vec3_t VEC_UP = {0, -1, 0};
;3799:static vec3_t MOVEDIR_UP = {0, 0, 1};
;3800:static vec3_t VEC_DOWN = {0, -2, 0};
;3801:static vec3_t MOVEDIR_DOWN = {0, 0, -1};
;3802:
;3803:void BotSetMovedir(vec3_t angles, vec3_t movedir) {
line 3804
;3804:	if (VectorCompare(angles, VEC_UP)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_UP
ARGP4
ADDRLP4 0
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2291
line 3805
;3805:		VectorCopy(MOVEDIR_UP, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_UP
INDIRB
ASGNB 12
line 3806
;3806:	} else if (VectorCompare(angles, VEC_DOWN)) {
ADDRGP4 $2292
JUMPV
LABELV $2291
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_DOWN
ARGP4
ADDRLP4 4
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2293
line 3807
;3807:		VectorCopy(MOVEDIR_DOWN, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_DOWN
INDIRB
ASGNB 12
line 3808
;3808:	} else {
ADDRGP4 $2294
JUMPV
LABELV $2293
line 3809
;3809:		AngleVectors(angles, movedir, NULL, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
CNSTP4 0
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3810
;3810:	}
LABELV $2294
LABELV $2292
line 3811
;3811:}
LABELV $2290
endproc BotSetMovedir 12 16
export BotModelMinsMaxs
proc BotModelMinsMaxs 40 0
line 3820
;3812:
;3813:/*
;3814:==================
;3815:BotModelMinsMaxs
;3816:
;3817:this is ugly
;3818:==================
;3819: */
;3820:int BotModelMinsMaxs(int modelindex, int eType, int contents, vec3_t mins, vec3_t maxs) {
line 3824
;3821:	gentity_t *ent;
;3822:	int i;
;3823:
;3824:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 3825
;3825:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2299
JUMPV
LABELV $2296
line 3826
;3826:		if (!ent->inuse) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2301
line 3827
;3827:			continue;
ADDRGP4 $2297
JUMPV
LABELV $2301
line 3829
;3828:		}
;3829:		if (eType && ent->s.eType != eType) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2303
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2303
line 3830
;3830:			continue;
ADDRGP4 $2297
JUMPV
LABELV $2303
line 3832
;3831:		}
;3832:		if (contents && ent->r.contents != contents) {
ADDRLP4 12
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2305
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $2305
line 3833
;3833:			continue;
ADDRGP4 $2297
JUMPV
LABELV $2305
line 3835
;3834:		}
;3835:		if (ent->s.modelindex == modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2307
line 3836
;3836:			if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2309
line 3837
;3837:				VectorAdd(ent->r.currentOrigin, ent->r.mins, mins);
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $2309
line 3838
;3838:			if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2311
line 3839
;3839:				VectorAdd(ent->r.currentOrigin, ent->r.maxs, maxs);
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $2311
line 3840
;3840:			return i;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $2295
JUMPV
LABELV $2307
line 3842
;3841:		}
;3842:	}
LABELV $2297
line 3825
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
LABELV $2299
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2296
line 3843
;3843:	if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2313
line 3844
;3844:		VectorClear(mins);
ADDRLP4 8
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
LABELV $2313
line 3845
;3845:	if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2315
line 3846
;3846:		VectorClear(maxs);
ADDRLP4 16
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRF4
ASGNF4
LABELV $2315
line 3847
;3847:	return 0;
CNSTI4 0
RETI4
LABELV $2295
endproc BotModelMinsMaxs 40 0
lit
align 4
LABELV $2318
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $2319
byte 4 3212836864
byte 4 3212836864
byte 4 3212836864
export BotFuncButtonActivateGoal
code
proc BotFuncButtonActivateGoal 644 28
line 3855
;3848:}
;3849:
;3850:/*
;3851:==================
;3852:BotFuncButtonGoal
;3853:==================
;3854: */
;3855:int BotFuncButtonActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 3861
;3856:	int i, areas[10], numareas, modelindex, entitynum;
;3857:	char model[128];
;3858:	float lip, dist, health, angle;
;3859:	vec3_t size, start, end, mins, maxs, angles, points[10];
;3860:	vec3_t movedir, origin, goalorigin, bboxmins, bboxmaxs;
;3861:	vec3_t extramins = {1, 1, 1}, extramaxs = {-1, -1, -1};
ADDRLP4 304
ADDRGP4 $2318
INDIRB
ASGNB 12
ADDRLP4 316
ADDRGP4 $2319
INDIRB
ASGNB 12
line 3864
;3862:	bsp_trace_t bsptrace;
;3863:
;3864:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 3865
;3865:	VectorClear(activategoal->target);
ADDRLP4 560
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 564
CNSTF4 0
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
ADDRLP4 560
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 564
INDIRF4
ASGNF4
line 3867
;3866:	//create a bot goal towards the button
;3867:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof (model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $584
ARGP4
ADDRLP4 148
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 3868
;3868:	if (!*model)
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2320
line 3869
;3869:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2317
JUMPV
LABELV $2320
line 3870
;3870:	modelindex = atoi(model + 1);
ADDRLP4 148+1
ARGP4
ADDRLP4 568
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 288
ADDRLP4 568
INDIRI4
ASGNI4
line 3871
;3871:	if (!modelindex)
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2323
line 3872
;3872:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2317
JUMPV
LABELV $2323
line 3873
;3873:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 288
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 572
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 344
ADDRLP4 572
INDIRI4
ASGNI4
line 3875
;3874:	//get the lip of the button
;3875:	trap_AAS_FloatForBSPEpairKey(bspent, "lip", &lip);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2325
ARGP4
ADDRLP4 328
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3876
;3876:	if (!lip) lip = 4;
ADDRLP4 328
INDIRF4
CNSTF4 0
NEF4 $2326
ADDRLP4 328
CNSTF4 1082130432
ASGNF4
LABELV $2326
line 3878
;3877:	//get the move direction from the angle
;3878:	trap_AAS_FloatForBSPEpairKey(bspent, "angle", &angle);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2328
ARGP4
ADDRLP4 352
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3879
;3879:	VectorSet(angles, 0, angle, 0);
ADDRLP4 276
CNSTF4 0
ASGNF4
ADDRLP4 276+4
ADDRLP4 352
INDIRF4
ASGNF4
ADDRLP4 276+8
CNSTF4 0
ASGNF4
line 3880
;3880:	BotSetMovedir(angles, movedir);
ADDRLP4 276
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 BotSetMovedir
CALLV
pop
line 3882
;3881:	//button size
;3882:	VectorSubtract(maxs, mins, size);
ADDRLP4 100
ADDRLP4 84
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
ASGNF4
ADDRLP4 100+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 72+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 100+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 72+8
INDIRF4
SUBF4
ASGNF4
line 3884
;3883:	//button origin
;3884:	VectorAdd(mins, maxs, origin);
ADDRLP4 16
ADDRLP4 72
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 72+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 72+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 3885
;3885:	VectorScale(origin, 0.5, origin);
ADDRLP4 576
CNSTF4 1056964608
ASGNF4
ADDRLP4 16
ADDRLP4 576
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 576
INDIRF4
ADDRLP4 16+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 16+8
CNSTF4 1056964608
ADDRLP4 16+8
INDIRF4
MULF4
ASGNF4
line 3887
;3886:	//touch distance of the button
;3887:	dist = fabs(movedir[0]) * size[0] + fabs(movedir[1]) * size[1] + fabs(movedir[2]) * size[2];
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 580
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 584
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 580
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ADDRLP4 584
INDIRF4
ADDRLP4 100+4
INDIRF4
MULF4
ADDF4
ADDRLP4 588
INDIRF4
ADDRLP4 100+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3888
;3888:	dist *= 0.5;
ADDRLP4 28
CNSTF4 1056964608
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 3890
;3889:	//
;3890:	trap_AAS_FloatForBSPEpairKey(bspent, "health", &health);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2351
ARGP4
ADDRLP4 348
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3892
;3891:	//if the button is shootable
;3892:	if (health) {
ADDRLP4 348
INDIRF4
CNSTF4 0
EQF4 $2352
line 3894
;3893:		//calculate the shoot target
;3894:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 592
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 112
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 112+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 112+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3896
;3895:		//
;3896:		VectorCopy(goalorigin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 112
INDIRB
ASGNB 12
line 3897
;3897:		activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 3899
;3898:		//
;3899:		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, goalorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 356
ARGP4
ADDRLP4 596
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 596
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 600
CNSTP4 0
ASGNP4
ADDRLP4 600
INDIRP4
ARGP4
ADDRLP4 600
INDIRP4
ARGP4
ADDRLP4 112
ARGP4
ADDRLP4 596
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3901
;3900:		// if the button is visible from the current position
;3901:		if (bsptrace.fraction >= 1.0 || bsptrace.ent == entitynum) {
ADDRLP4 356+8
INDIRF4
CNSTF4 1065353216
GEF4 $2364
ADDRLP4 356+80
INDIRI4
ADDRLP4 344
INDIRI4
NEI4 $2360
LABELV $2364
line 3903
;3902:			//
;3903:			activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable button
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3904
;3904:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3905
;3905:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3906
;3906:			VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
INDIRB
ASGNB 12
line 3907
;3907:			activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ASGNI4
line 3908
;3908:			VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 3909
;3909:			VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 3911
;3910:			//
;3911:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2317
JUMPV
LABELV $2360
line 3912
;3912:		} else {
line 3915
;3913:			//create a goal from where the button is visible and shoot at the button from there
;3914:			//add bounding box size to the dist
;3915:			trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 124
ARGP4
ADDRLP4 136
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 3916
;3916:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2365
line 3917
;3917:				if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2369
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 604
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2370
JUMPV
LABELV $2369
line 3918
;3918:				else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 124
ADDP4
INDIRF4
ARGF4
ADDRLP4 616
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 612
INDIRF4
ADDRLP4 616
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2370
line 3919
;3919:			}
LABELV $2366
line 3916
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2365
line 3921
;3920:			//calculate the goal origin
;3921:			VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 604
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 112
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 112+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 112+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3923
;3922:			//
;3923:			VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 112
INDIRB
ASGNB 12
line 3924
;3924:			start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3925
;3925:			VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 3926
;3926:			end[2] -= 512;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1140850688
SUBF4
ASGNF4
line 3927
;3927:			numareas = trap_AAS_TraceAreas(start, end, areas, points, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 440
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 608
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 608
INDIRI4
ASGNI4
line 3929
;3928:			//
;3929:			for (i = numareas - 1; i >= 0; i--) {
ADDRLP4 0
ADDRLP4 96
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $2382
JUMPV
LABELV $2379
line 3930
;3930:				if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 612
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 612
INDIRI4
CNSTI4 0
EQI4 $2383
line 3931
;3931:					break;
ADDRGP4 $2381
JUMPV
LABELV $2383
line 3933
;3932:				}
;3933:			}
LABELV $2380
line 3929
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2382
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2379
LABELV $2381
line 3934
;3934:			if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2385
line 3936
;3935:				// FIXME: trace forward and maybe in other directions to find a valid area
;3936:			}
LABELV $2385
line 3937
;3937:			if (i >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $2387
line 3939
;3938:				//
;3939:				VectorCopy(points[i], activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 440
ADDP4
INDIRB
ASGNB 12
line 3940
;3940:				activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 3941
;3941:				VectorSet(activategoal->goal.mins, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
line 3942
;3942:				VectorSet(activategoal->goal.maxs, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 3238002688
ASGNF4
line 3944
;3943:				//
;3944:				for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2389
line 3945
;3945:					if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2393
ADDRLP4 612
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 612
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 616
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 624
ADDRLP4 612
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 624
INDIRP4
ADDRLP4 624
INDIRP4
INDIRF4
ADDRLP4 616
INDIRF4
ADDRLP4 620
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2394
JUMPV
LABELV $2393
line 3946
;3946:					else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 628
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 628
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 632
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 636
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 640
ADDRLP4 628
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 640
INDIRP4
ADDRLP4 640
INDIRP4
INDIRF4
ADDRLP4 632
INDIRF4
ADDRLP4 636
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2394
line 3947
;3947:				} //end for
LABELV $2390
line 3944
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2389
line 3949
;3948:				//
;3949:				activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3950
;3950:				activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3951
;3951:				activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3952
;3952:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2317
JUMPV
LABELV $2387
line 3954
;3953:			}
;3954:		}
line 3955
;3955:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2317
JUMPV
LABELV $2352
line 3956
;3956:	} else {
line 3958
;3957:		//add bounding box size to the dist
;3958:		trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 124
ARGP4
ADDRLP4 136
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 3959
;3959:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2395
line 3960
;3960:			if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2399
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 596
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 592
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2400
JUMPV
LABELV $2399
line 3961
;3961:			else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 124
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 600
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2400
line 3962
;3962:		}
LABELV $2396
line 3959
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2395
line 3964
;3963:		//calculate the goal origin
;3964:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 592
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 112
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 112+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 112+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3966
;3965:		//
;3966:		VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 112
INDIRB
ASGNB 12
line 3967
;3967:		start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3968
;3968:		VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 3969
;3969:		end[2] -= 100;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 3970
;3970:		numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 596
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 596
INDIRI4
ASGNI4
line 3972
;3971:		//
;3972:		for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2412
JUMPV
LABELV $2409
line 3973
;3973:			if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 600
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 600
INDIRI4
CNSTI4 0
EQI4 $2413
line 3974
;3974:				break;
ADDRGP4 $2411
JUMPV
LABELV $2413
line 3976
;3975:			}
;3976:		}
LABELV $2410
line 3972
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2412
ADDRLP4 0
INDIRI4
ADDRLP4 96
INDIRI4
LTI4 $2409
LABELV $2411
line 3977
;3977:		if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 96
INDIRI4
GEI4 $2415
line 3979
;3978:			//
;3979:			VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 3980
;3980:			activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 3981
;3981:			VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 3982
;3982:			VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 84
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 84+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 3984
;3983:			//
;3984:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2425
line 3985
;3985:				if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2429
ADDRLP4 600
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 600
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 612
ADDRLP4 600
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 612
INDIRP4
ADDRLP4 612
INDIRP4
INDIRF4
ADDRLP4 604
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2430
JUMPV
LABELV $2429
line 3986
;3986:				else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 616
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 616
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 624
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 628
ADDRLP4 616
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 628
INDIRP4
ADDRLP4 628
INDIRP4
INDIRF4
ADDRLP4 620
INDIRF4
ADDRLP4 624
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2430
line 3987
;3987:			} //end for
LABELV $2426
line 3984
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2425
line 3989
;3988:			//
;3989:			activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3990
;3990:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3991
;3991:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3992
;3992:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2317
JUMPV
LABELV $2415
line 3994
;3993:		}
;3994:	}
line 3995
;3995:	return qfalse;
CNSTI4 0
RETI4
LABELV $2317
endproc BotFuncButtonActivateGoal 644 28
export BotFuncDoorActivateGoal
proc BotFuncDoorActivateGoal 1080 20
line 4003
;3996:}
;3997:
;3998:/*
;3999:==================
;4000:BotFuncDoorGoal
;4001:==================
;4002: */
;4003:int BotFuncDoorActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 4009
;4004:	int modelindex, entitynum;
;4005:	char model[MAX_INFO_STRING];
;4006:	vec3_t mins, maxs, origin;
;4007:
;4008:	//shoot at the shootable door
;4009:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof (model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $584
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4010
;4010:	if (!*model)
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2432
line 4011
;4011:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2431
JUMPV
LABELV $2432
line 4012
;4012:	modelindex = atoi(model + 1);
ADDRLP4 12+1
ARGP4
ADDRLP4 1068
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1068
INDIRI4
ASGNI4
line 4013
;4013:	if (!modelindex)
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $2435
line 4014
;4014:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2431
JUMPV
LABELV $2435
line 4015
;4015:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 1060
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1072
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1072
INDIRI4
ASGNI4
line 4017
;4016:	//door origin
;4017:	VectorAdd(mins, maxs, origin);
ADDRLP4 0
ADDRLP4 1036
INDIRF4
ADDRLP4 1048
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1036+4
INDIRF4
ADDRLP4 1048+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 1036+8
INDIRF4
ADDRLP4 1048+8
INDIRF4
ADDF4
ASGNF4
line 4018
;4018:	VectorScale(origin, 0.5, origin);
ADDRLP4 1076
CNSTF4 1056964608
ASGNF4
ADDRLP4 0
ADDRLP4 1076
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1076
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1056964608
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
line 4019
;4019:	VectorCopy(origin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 4020
;4020:	activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 4022
;4021:	//
;4022:	activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable door
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 1064
INDIRI4
ASGNI4
line 4023
;4023:	activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4024
;4024:	activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4025
;4025:	VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
INDIRB
ASGNB 12
line 4026
;4026:	activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ASGNI4
line 4027
;4027:	VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 4028
;4028:	VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 4029
;4029:	return qtrue;
CNSTI4 1
RETI4
LABELV $2431
endproc BotFuncDoorActivateGoal 1080 20
export BotTriggerMultipleActivateGoal
proc BotTriggerMultipleActivateGoal 284 20
line 4037
;4030:}
;4031:
;4032:/*
;4033:==================
;4034:BotTriggerMultipleActivateGoal
;4035:==================
;4036: */
;4037:int BotTriggerMultipleActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 4043
;4038:	int i, areas[10], numareas, modelindex, entitynum;
;4039:	char model[128];
;4040:	vec3_t start, end, mins, maxs;
;4041:	vec3_t origin, goalorigin;
;4042:
;4043:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 4044
;4044:	VectorClear(activategoal->target);
ADDRLP4 256
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 260
CNSTF4 0
ASGNF4
ADDRLP4 256
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 260
INDIRF4
ASGNF4
ADDRLP4 256
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 260
INDIRF4
ASGNF4
ADDRLP4 256
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 260
INDIRF4
ASGNF4
line 4046
;4045:	//create a bot goal towards the trigger
;4046:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof (model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $584
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4047
;4047:	if (!*model)
ADDRLP4 84
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2448
line 4048
;4048:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2447
JUMPV
LABELV $2448
line 4049
;4049:	modelindex = atoi(model + 1);
ADDRLP4 84+1
ARGP4
ADDRLP4 264
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 224
ADDRLP4 264
INDIRI4
ASGNI4
line 4050
;4050:	if (!modelindex)
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $2451
line 4051
;4051:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2447
JUMPV
LABELV $2451
line 4052
;4052:	entitynum = BotModelMinsMaxs(modelindex, 0, CONTENTS_TRIGGER, mins, maxs);
ADDRLP4 224
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1073741824
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 268
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 252
ADDRLP4 268
INDIRI4
ASGNI4
line 4054
;4053:	//trigger origin
;4054:	VectorAdd(mins, maxs, origin);
ADDRLP4 4
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 60+8
INDIRF4
ADDRLP4 72+8
INDIRF4
ADDF4
ASGNF4
line 4055
;4055:	VectorScale(origin, 0.5, origin);
ADDRLP4 272
CNSTF4 1056964608
ASGNF4
ADDRLP4 4
ADDRLP4 272
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 272
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+8
CNSTF4 1056964608
ADDRLP4 4+8
INDIRF4
MULF4
ASGNF4
line 4056
;4056:	VectorCopy(origin, goalorigin);
ADDRLP4 240
ADDRLP4 4
INDIRB
ASGNB 12
line 4058
;4057:	//
;4058:	VectorCopy(goalorigin, start);
ADDRLP4 212
ADDRLP4 240
INDIRB
ASGNB 12
line 4059
;4059:	start[2] += 24;
ADDRLP4 212+8
ADDRLP4 212+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 4060
;4060:	VectorCopy(start, end);
ADDRLP4 228
ADDRLP4 212
INDIRB
ASGNB 12
line 4061
;4061:	end[2] -= 100;
ADDRLP4 228+8
ADDRLP4 228+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 4062
;4062:	numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 212
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 276
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 276
INDIRI4
ASGNI4
line 4064
;4063:	//
;4064:	for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2468
JUMPV
LABELV $2465
line 4065
;4065:		if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $2469
line 4066
;4066:			break;
ADDRGP4 $2467
JUMPV
LABELV $2469
line 4068
;4067:		}
;4068:	}
LABELV $2466
line 4064
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2468
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $2465
LABELV $2467
line 4069
;4069:	if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
GEI4 $2471
line 4070
;4070:		VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 4071
;4071:		activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ASGNI4
line 4072
;4072:		VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 60+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 60+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 4073
;4073:		VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 4075
;4074:		//
;4075:		activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 252
INDIRI4
ASGNI4
line 4076
;4076:		activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4077
;4077:		activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4078
;4078:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2447
JUMPV
LABELV $2471
line 4080
;4079:	}
;4080:	return qfalse;
CNSTI4 0
RETI4
LABELV $2447
endproc BotTriggerMultipleActivateGoal 284 20
export BotPopFromActivateGoalStack
proc BotPopFromActivateGoalStack 4 8
line 4088
;4081:}
;4082:
;4083:/*
;4084:==================
;4085:BotPopFromActivateGoalStack
;4086:==================
;4087: */
;4088:int BotPopFromActivateGoalStack(bot_state_t *bs) {
line 4089
;4089:	if (!bs->activatestack)
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2482
line 4090
;4090:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2481
JUMPV
LABELV $2482
line 4091
;4091:	BotEnableActivateGoalAreas(bs->activatestack, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4092
;4092:	bs->activatestack->inuse = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 0
ASGNI4
line 4093
;4093:	bs->activatestack->justused_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4094
;4094:	bs->activatestack = bs->activatestack->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4095
;4095:	return qtrue;
CNSTI4 1
RETI4
LABELV $2481
endproc BotPopFromActivateGoalStack 4 8
export BotPushOntoActivateGoalStack
proc BotPushOntoActivateGoalStack 24 12
line 4103
;4096:}
;4097:
;4098:/*
;4099:==================
;4100:BotPushOntoActivateGoalStack
;4101:==================
;4102: */
;4103:int BotPushOntoActivateGoalStack(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4107
;4104:	int i, best;
;4105:	float besttime;
;4106:
;4107:	best = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 4108
;4108:	besttime = FloatTime() + 9999;
ADDRLP4 4
ADDRGP4 floattime
INDIRF4
CNSTF4 1176255488
ADDF4
ASGNF4
line 4110
;4109:	//
;4110:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2485
line 4111
;4111:		if (!bs->activategoalheap[i].inuse) {
CNSTI4 244
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2489
line 4112
;4112:			if (bs->activategoalheap[i].justused_time < besttime) {
CNSTI4 244
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $2491
line 4113
;4113:				besttime = bs->activategoalheap[i].justused_time;
ADDRLP4 4
CNSTI4 244
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ASGNF4
line 4114
;4114:				best = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 4115
;4115:			}
LABELV $2491
line 4116
;4116:		}
LABELV $2489
line 4117
;4117:	}
LABELV $2486
line 4110
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $2485
line 4118
;4118:	if (best != -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $2493
line 4119
;4119:		memcpy(&bs->activategoalheap[best], activategoal, sizeof (bot_activategoal_t));
ADDRLP4 12
CNSTI4 244
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4120
;4120:		bs->activategoalheap[best].inuse = qtrue;
CNSTI4 244
ADDRLP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 4121
;4121:		bs->activategoalheap[best].next = bs->activatestack;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 244
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 6980
ADDP4
ADDP4
CNSTI4 240
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
ASGNP4
line 4122
;4122:		bs->activatestack = &bs->activategoalheap[best];
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 6976
ADDP4
CNSTI4 244
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 20
INDIRP4
CNSTI4 6980
ADDP4
ADDP4
ASGNP4
line 4123
;4123:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2484
JUMPV
LABELV $2493
line 4125
;4124:	}
;4125:	return qfalse;
CNSTI4 0
RETI4
LABELV $2484
endproc BotPushOntoActivateGoalStack 24 12
export BotClearActivateGoalStack
proc BotClearActivateGoalStack 0 4
line 4133
;4126:}
;4127:
;4128:/*
;4129:==================
;4130:BotClearActivateGoalStack
;4131:==================
;4132: */
;4133:void BotClearActivateGoalStack(bot_state_t *bs) {
ADDRGP4 $2497
JUMPV
LABELV $2496
line 4135
;4134:	while (bs->activatestack)
;4135:		BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
LABELV $2497
line 4134
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2496
line 4136
;4136:}
LABELV $2495
endproc BotClearActivateGoalStack 0 4
export BotEnableActivateGoalAreas
proc BotEnableActivateGoalAreas 12 8
line 4143
;4137:
;4138:/*
;4139:==================
;4140:BotEnableActivateGoalAreas
;4141:==================
;4142: */
;4143:void BotEnableActivateGoalAreas(bot_activategoal_t *activategoal, int enable) {
line 4146
;4144:	int i;
;4145:
;4146:	if (activategoal->areasdisabled == !enable)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2503
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $2504
JUMPV
LABELV $2503
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $2504
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $2500
line 4147
;4147:		return;
ADDRGP4 $2499
JUMPV
LABELV $2500
line 4148
;4148:	for (i = 0; i < activategoal->numareas; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2508
JUMPV
LABELV $2505
line 4149
;4149:		trap_AAS_EnableRoutingArea(activategoal->areas[i], enable);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 trap_AAS_EnableRoutingArea
CALLI4
pop
LABELV $2506
line 4148
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2508
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
LTI4 $2505
line 4150
;4150:	activategoal->areasdisabled = !enable;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2510
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $2511
JUMPV
LABELV $2510
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2511
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4151
;4151:}
LABELV $2499
endproc BotEnableActivateGoalAreas 12 8
export BotIsGoingToActivateEntity
proc BotIsGoingToActivateEntity 8 0
line 4158
;4152:
;4153:/*
;4154:==================
;4155:BotIsGoingToActivateEntity
;4156:==================
;4157: */
;4158:int BotIsGoingToActivateEntity(bot_state_t *bs, int entitynum) {
line 4162
;4159:	bot_activategoal_t *a;
;4160:	int i;
;4161:
;4162:	for (a = bs->activatestack; a; a = a->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $2516
JUMPV
LABELV $2513
line 4163
;4163:		if (a->time < FloatTime())
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $2517
line 4164
;4164:			continue;
ADDRGP4 $2514
JUMPV
LABELV $2517
line 4165
;4165:		if (a->goal.entitynum == entitynum)
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $2519
line 4166
;4166:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2512
JUMPV
LABELV $2519
line 4167
;4167:	}
LABELV $2514
line 4162
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
LABELV $2516
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2513
line 4168
;4168:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $2521
line 4169
;4169:		if (bs->activategoalheap[i].inuse)
CNSTI4 244
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2525
line 4170
;4170:			continue;
ADDRGP4 $2522
JUMPV
LABELV $2525
line 4172
;4171:		//
;4172:		if (bs->activategoalheap[i].goal.entitynum == entitynum) {
CNSTI4 244
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
ADDP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $2527
line 4174
;4173:			// if the bot went for this goal less than 2 seconds ago
;4174:			if (bs->activategoalheap[i].justused_time > FloatTime() - 2)
CNSTI4 244
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $2529
line 4175
;4175:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2512
JUMPV
LABELV $2529
line 4176
;4176:		}
LABELV $2527
line 4177
;4177:	}
LABELV $2522
line 4168
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $2521
line 4178
;4178:	return qfalse;
CNSTI4 0
RETI4
LABELV $2512
endproc BotIsGoingToActivateEntity 8 0
export BotGetActivateGoal
proc BotGetActivateGoal 3308 20
line 4191
;4179:}
;4180:
;4181:/*
;4182:==================
;4183:BotGetActivateGoal
;4184:
;4185:  returns the number of the bsp entity to activate
;4186:  goal->entitynum will be set to the game entity to activate
;4187:==================
;4188: */
;4189://#define OBSTACLEDEBUG
;4190:
;4191:int BotGetActivateGoal(bot_state_t *bs, int entitynum, bot_activategoal_t *activategoal) {
line 4201
;4192:	int i, ent, cur_entities[10], spawnflags, modelindex, areas[MAX_ACTIVATEAREAS * 2], numareas, t;
;4193:	char model[MAX_INFO_STRING], tmpmodel[128];
;4194:	char target[128], classname[128];
;4195:	float health;
;4196:	char targetname[10][128];
;4197:	aas_entityinfo_t entinfo;
;4198:	aas_areainfo_t areainfo;
;4199:	vec3_t origin, absmins, absmaxs;
;4200:
;4201:	memset(activategoal, 0, sizeof (bot_activategoal_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4202
;4202:	BotEntityInfo(entitynum, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 3052
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4203
;4203:	Com_sprintf(model, sizeof ( model), "*%d", entinfo.modelindex);
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2532
ARGP4
ADDRLP4 3052+104
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4204
;4204:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 3240
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3240
INDIRI4
ASGNI4
ADDRGP4 $2537
JUMPV
LABELV $2534
line 4205
;4205:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", tmpmodel, sizeof (tmpmodel))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $584
ARGP4
ADDRLP4 1584
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3244
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3244
INDIRI4
CNSTI4 0
NEI4 $2538
ADDRGP4 $2535
JUMPV
LABELV $2538
line 4206
;4206:		if (strequals(model, tmpmodel)) break;
ADDRLP4 1712
ARGP4
ADDRLP4 1584
ARGP4
ADDRLP4 3248
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3248
INDIRI4
CNSTI4 0
NEI4 $2540
ADDRGP4 $2536
JUMPV
LABELV $2540
line 4207
;4207:	}
LABELV $2535
line 4204
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3244
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3244
INDIRI4
ASGNI4
LABELV $2537
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2534
LABELV $2536
line 4208
;4208:	if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2542
line 4209
;4209:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity found with model %s\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2544
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4210
;4210:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2531
JUMPV
LABELV $2542
line 4212
;4211:	}
;4212:	trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof (classname));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2545
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4213
;4213:	if (!*classname) {
ADDRLP4 1456
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2546
line 4214
;4214:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model %s has no classname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2548
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4215
;4215:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2531
JUMPV
LABELV $2546
line 4218
;4216:	}
;4217:	//if it is a door
;4218:	if (strequals(classname, "func_door")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2551
ARGP4
ADDRLP4 3248
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3248
INDIRI4
CNSTI4 0
NEI4 $2549
line 4219
;4219:		if (trap_AAS_FloatForBSPEpairKey(ent, "health", &health)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2351
ARGP4
ADDRLP4 3208
ARGP4
ADDRLP4 3252
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3252
INDIRI4
CNSTI4 0
EQI4 $2552
line 4221
;4220:			//if the door has health then the door must be shot to open
;4221:			if (health) {
ADDRLP4 3208
INDIRF4
CNSTF4 0
EQF4 $2554
line 4222
;4222:				BotFuncDoorActivateGoal(bs, ent, activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotFuncDoorActivateGoal
CALLI4
pop
line 4223
;4223:				return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2531
JUMPV
LABELV $2554
line 4225
;4224:			}
;4225:		}
LABELV $2552
line 4227
;4226:		//
;4227:		trap_AAS_IntForBSPEpairKey(ent, "spawnflags", &spawnflags);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2556
ARGP4
ADDRLP4 3204
ARGP4
ADDRGP4 trap_AAS_IntForBSPEpairKey
CALLI4
pop
line 4229
;4228:		// if the door starts open then just wait for the door to return
;4229:		if (spawnflags & 1)
ADDRLP4 3204
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2557
line 4230
;4230:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $2531
JUMPV
LABELV $2557
line 4232
;4231:		//get the door origin
;4232:		if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2561
ARGP4
ADDRLP4 3192
ARGP4
ADDRLP4 3256
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $2559
line 4233
;4233:			VectorClear(origin);
ADDRLP4 3260
CNSTF4 0
ASGNF4
ADDRLP4 3192+8
ADDRLP4 3260
INDIRF4
ASGNF4
ADDRLP4 3192+4
ADDRLP4 3260
INDIRF4
ASGNF4
ADDRLP4 3192
ADDRLP4 3260
INDIRF4
ASGNF4
line 4234
;4234:		}
LABELV $2559
line 4236
;4235:		//if the door is open or opening already
;4236:		if (!VectorCompare(origin, entinfo.origin))
ADDRLP4 3192
ARGP4
ADDRLP4 3052+24
ARGP4
ADDRLP4 3260
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 3260
INDIRI4
CNSTI4 0
NEI4 $2564
line 4237
;4237:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $2531
JUMPV
LABELV $2564
line 4239
;4238:		// store all the areas the door is in
;4239:		trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof (model));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $584
ARGP4
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4240
;4240:		if (*model) {
ADDRLP4 1712
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2567
line 4241
;4241:			modelindex = atoi(model + 1);
ADDRLP4 1712+1
ARGP4
ADDRLP4 3264
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3212
ADDRLP4 3264
INDIRI4
ASGNI4
line 4242
;4242:			if (modelindex) {
ADDRLP4 3212
INDIRI4
CNSTI4 0
EQI4 $2570
line 4243
;4243:				BotModelMinsMaxs(modelindex, ET_MOVER, 0, absmins, absmaxs);
ADDRLP4 3212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 3216
ARGP4
ADDRLP4 3228
ARGP4
ADDRGP4 BotModelMinsMaxs
CALLI4
pop
line 4245
;4244:				//
;4245:				numareas = trap_AAS_BBoxAreas(absmins, absmaxs, areas, MAX_ACTIVATEAREAS * 2);
ADDRLP4 3216
ARGP4
ADDRLP4 3228
ARGP4
ADDRLP4 2740
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_BBoxAreas
CALLI4
ASGNI4
ADDRLP4 3048
ADDRLP4 3268
INDIRI4
ASGNI4
line 4247
;4246:				// store the areas with reachabilities first
;4247:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2575
JUMPV
LABELV $2572
line 4248
;4248:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2576
line 4249
;4249:						break;
ADDRGP4 $2574
JUMPV
LABELV $2576
line 4250
;4250:					if (!trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $2578
line 4251
;4251:						continue;
ADDRGP4 $2573
JUMPV
LABELV $2578
line 4253
;4252:					}
;4253:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4254
;4254:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2580
line 4255
;4255:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3280
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3276
ADDRLP4 3280
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3280
INDIRP4
ADDRLP4 3276
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3284
CNSTI4 2
ASGNI4
ADDRLP4 3276
INDIRI4
ADDRLP4 3284
INDIRI4
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
ADDRLP4 3284
INDIRI4
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4256
;4256:					}
LABELV $2580
line 4257
;4257:				}
LABELV $2573
line 4247
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2575
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $2572
LABELV $2574
line 4259
;4258:				// store any remaining areas
;4259:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2585
JUMPV
LABELV $2582
line 4260
;4260:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2586
line 4261
;4261:						break;
ADDRGP4 $2584
JUMPV
LABELV $2586
line 4262
;4262:					if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
EQI4 $2588
line 4263
;4263:						continue;
ADDRGP4 $2583
JUMPV
LABELV $2588
line 4265
;4264:					}
;4265:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4266
;4266:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2590
line 4267
;4267:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3280
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3276
ADDRLP4 3280
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3280
INDIRP4
ADDRLP4 3276
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3284
CNSTI4 2
ASGNI4
ADDRLP4 3276
INDIRI4
ADDRLP4 3284
INDIRI4
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
ADDRLP4 3284
INDIRI4
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4268
;4268:					}
LABELV $2590
line 4269
;4269:				}
LABELV $2583
line 4259
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2585
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $2582
LABELV $2584
line 4270
;4270:			}
LABELV $2570
line 4271
;4271:		}
LABELV $2567
line 4272
;4272:	}
LABELV $2549
line 4274
;4273:	// if the bot is blocked by or standing on top of a button
;4274:	if (strequals(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2594
ARGP4
ADDRLP4 3252
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3252
INDIRI4
CNSTI4 0
NEI4 $2592
line 4275
;4275:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2531
JUMPV
LABELV $2592
line 4278
;4276:	}
;4277:	// get the targetname so we can find an entity with a matching target
;4278:	if (!trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[0], sizeof (targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2597
ARGP4
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3256
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $2595
line 4279
;4279:		if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2598
line 4280
;4280:			BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model \"%s\" has no targetname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2601
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4281
;4281:		}
LABELV $2598
line 4282
;4282:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2531
JUMPV
LABELV $2595
line 4285
;4283:	}
;4284:	// allow tree-like activation
;4285:	cur_entities[0] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3260
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 1416
ADDRLP4 3260
INDIRI4
ASGNI4
line 4286
;4286:	for (i = 0; i >= 0 && i < 10;) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2605
JUMPV
LABELV $2602
line 4287
;4287:		for (ent = cur_entities[i]; ent; ent = trap_AAS_NextBSPEntity(ent)) {
ADDRLP4 0
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $2609
JUMPV
LABELV $2606
line 4288
;4288:			if (!trap_AAS_ValueForBSPEpairKey(ent, "target", target, sizeof (target))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2612
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3264
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3264
INDIRI4
CNSTI4 0
NEI4 $2610
ADDRGP4 $2607
JUMPV
LABELV $2610
line 4289
;4289:			if (strequals(targetname[i], target)) {
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 3268
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $2613
line 4290
;4290:				cur_entities[i] = trap_AAS_NextBSPEntity(ent);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3272
INDIRI4
ASGNI4
line 4291
;4291:				break;
ADDRGP4 $2608
JUMPV
LABELV $2613
line 4293
;4292:			}
;4293:		}
LABELV $2607
line 4287
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3264
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3264
INDIRI4
ASGNI4
LABELV $2609
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2606
LABELV $2608
line 4294
;4294:		if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2615
line 4295
;4295:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2617
line 4296
;4296:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity with target \"%s\"\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $2620
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4297
;4297:			}
LABELV $2617
line 4298
;4298:			i--;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4299
;4299:			continue;
ADDRGP4 $2603
JUMPV
LABELV $2615
line 4301
;4300:		}
;4301:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof (classname))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2545
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $2621
line 4302
;4302:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2603
line 4303
;4303:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with target \"%s\" has no classname\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $2626
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4304
;4304:			}
line 4305
;4305:			continue;
ADDRGP4 $2603
JUMPV
LABELV $2621
line 4308
;4306:		}
;4307:		// BSP button model
;4308:		if (strequals(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2594
ARGP4
ADDRLP4 3272
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $2627
line 4310
;4309:			//
;4310:			if (!BotFuncButtonActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3276
ADDRGP4 BotFuncButtonActivateGoal
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $2629
line 4311
;4311:				continue;
ADDRGP4 $2603
JUMPV
LABELV $2629
line 4313
;4312:			// if the bot tries to activate this button already
;4313:			if (bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3280
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 3280
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2631
ADDRLP4 3280
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2631
ADDRLP4 3284
CNSTI4 44
ASGNI4
ADDRLP4 3280
INDIRP4
ADDRLP4 3284
INDIRI4
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
ADDRLP4 3284
INDIRI4
ADDP4
INDIRI4
NEI4 $2631
ADDRLP4 3288
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3280
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3288
INDIRF4
LEF4 $2631
ADDRLP4 3280
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3288
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2631
line 4317
;4314:					bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4315:					bs->activatestack->time > FloatTime() &&
;4316:					bs->activatestack->start_time < FloatTime() - 2)
;4317:				continue;
ADDRGP4 $2603
JUMPV
LABELV $2631
line 4319
;4318:			// if the bot is in a reachability area
;4319:			if (trap_AAS_AreaReachability(bs->areanum)) {
ADDRFP4 0
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
EQI4 $2633
line 4321
;4320:				// disable all areas the blocking entity is in
;4321:				BotEnableActivateGoalAreas(activategoal, qfalse);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4323
;4322:				//
;4323:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3296
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRLP4 3300
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3300
INDIRI4
ASGNI4
line 4325
;4324:				// if the button is not reachable
;4325:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $2635
line 4326
;4326:					continue;
ADDRGP4 $2603
JUMPV
LABELV $2635
line 4328
;4327:				}
;4328:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1008981770
ADDRLP4 2736
INDIRI4
CVIF4 4
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4329
;4329:			}
LABELV $2633
line 4330
;4330:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2531
JUMPV
LABELV $2627
line 4332
;4331:		}			// invisible trigger multiple box
;4332:		else if (strequals(classname, "trigger_multiple")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2639
ARGP4
ADDRLP4 3276
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $2637
line 4334
;4333:			//
;4334:			if (!BotTriggerMultipleActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3280
ADDRGP4 BotTriggerMultipleActivateGoal
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $2640
line 4335
;4335:				continue;
ADDRGP4 $2603
JUMPV
LABELV $2640
line 4337
;4336:			// if the bot tries to activate this trigger already
;4337:			if (bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3284
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 3284
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2642
ADDRLP4 3284
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2642
ADDRLP4 3288
CNSTI4 44
ASGNI4
ADDRLP4 3284
INDIRP4
ADDRLP4 3288
INDIRI4
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
ADDRLP4 3288
INDIRI4
ADDP4
INDIRI4
NEI4 $2642
ADDRLP4 3292
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3284
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3292
INDIRF4
LEF4 $2642
ADDRLP4 3284
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3292
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2642
line 4341
;4338:					bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4339:					bs->activatestack->time > FloatTime() &&
;4340:					bs->activatestack->start_time < FloatTime() - 2)
;4341:				continue;
ADDRGP4 $2603
JUMPV
LABELV $2642
line 4343
;4342:			// if the bot is in a reachability area
;4343:			if (trap_AAS_AreaReachability(bs->areanum)) {
ADDRFP4 0
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3296
INDIRI4
CNSTI4 0
EQI4 $2644
line 4345
;4344:				// disable all areas the blocking entity is in
;4345:				BotEnableActivateGoalAreas(activategoal, qfalse);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4347
;4346:				//
;4347:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3300
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3300
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 3300
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3300
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRLP4 3304
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3304
INDIRI4
ASGNI4
line 4349
;4348:				// if the trigger is not reachable
;4349:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $2646
line 4350
;4350:					continue;
ADDRGP4 $2603
JUMPV
LABELV $2646
line 4352
;4351:				}
;4352:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1008981770
ADDRLP4 2736
INDIRI4
CVIF4 4
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4353
;4353:			}
LABELV $2644
line 4354
;4354:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2531
JUMPV
LABELV $2637
line 4355
;4355:		} else if (strequals(classname, "func_timer")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2650
ARGP4
ADDRLP4 3280
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $2648
line 4357
;4356:			// just skip the func_timer
;4357:			continue;
ADDRGP4 $2603
JUMPV
LABELV $2648
line 4359
;4358:		}			// the actual button or trigger might be linked through a target_relay or target_delay
;4359:		else if (strequals(classname, "target_relay") || strequals(classname, "target_delay")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2653
ARGP4
ADDRLP4 3284
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3284
INDIRI4
CNSTI4 0
EQI4 $2655
ADDRLP4 1456
ARGP4
ADDRGP4 $2654
ARGP4
ADDRLP4 3288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $2651
LABELV $2655
line 4360
;4360:			if (trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[i + 1], sizeof (targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2597
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136+128
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3292
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
EQI4 $2656
line 4361
;4361:				i++;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4362
;4362:				cur_entities[i] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3296
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3296
INDIRI4
ASGNI4
line 4363
;4363:			}
LABELV $2656
line 4364
;4364:		}
LABELV $2651
line 4365
;4365:	}
LABELV $2603
line 4286
LABELV $2605
ADDRLP4 132
INDIRI4
CNSTI4 0
LTI4 $2659
ADDRLP4 132
INDIRI4
CNSTI4 10
LTI4 $2602
LABELV $2659
line 4369
;4366:#ifdef OBSTACLEDEBUG
;4367:	BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no valid activator for entity with target \"%s\"\n", targetname[0]);
;4368:#endif
;4369:	return 0;
CNSTI4 0
RETI4
LABELV $2531
endproc BotGetActivateGoal 3308 20
export BotGoForActivateGoal
proc BotGoForActivateGoal 144 8
line 4377
;4370:}
;4371:
;4372:/*
;4373:==================
;4374:BotGoForActivateGoal
;4375:==================
;4376: */
;4377:int BotGoForActivateGoal(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4380
;4378:	aas_entityinfo_t activateinfo;
;4379:
;4380:	activategoal->inuse = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 4381
;4381:	if (!activategoal->time)
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
CNSTF4 0
NEF4 $2661
line 4382
;4382:		activategoal->time = FloatTime() + 10;
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
LABELV $2661
line 4383
;4383:	activategoal->start_time = FloatTime();
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4384
;4384:	BotEntityInfo(activategoal->goal.entitynum, &activateinfo);
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4385
;4385:	VectorCopy(activateinfo.origin, activategoal->origin);
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 4387
;4386:	//
;4387:	if (BotPushOntoActivateGoalStack(bs, activategoal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotPushOntoActivateGoalStack
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $2664
line 4389
;4388:		// enter the activate entity AI node
;4389:		AIEnter_Seek_ActivateEntity(bs, "BotGoForActivateGoal");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2666
ARGP4
ADDRGP4 AIEnter_Seek_ActivateEntity
CALLV
pop
line 4390
;4390:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2660
JUMPV
LABELV $2664
line 4391
;4391:	} else {
line 4393
;4392:		// enable any routing areas that were disabled
;4393:		BotEnableActivateGoalAreas(activategoal, qtrue);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4394
;4394:		return qfalse;
CNSTI4 0
RETI4
LABELV $2660
endproc BotGoForActivateGoal 144 8
export BotPrintActivateGoalInfo
proc BotPrintActivateGoalInfo 296 36
line 4403
;4395:	}
;4396:}
;4397:
;4398:/*
;4399:==================
;4400:BotPrintActivateGoalInfo
;4401:==================
;4402: */
;4403:void BotPrintActivateGoalInfo(bot_state_t *bs, bot_activategoal_t *activategoal, int bspent) {
line 4408
;4404:	char netname[MAX_NETNAME];
;4405:	char classname[128];
;4406:	char buf[128];
;4407:
;4408:	ClientName(bs->client, netname, sizeof (netname));
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
line 4409
;4409:	trap_AAS_ValueForBSPEpairKey(bspent, "classname", classname, sizeof (classname));
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $2545
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4410
;4410:	if (activategoal->shoot) {
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2668
line 4411
;4411:		Com_sprintf(buf, sizeof (buf), "%s: I have to shoot at a %s from %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $2670
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4417
;4412:				netname, classname,
;4413:				activategoal->goal.origin[0],
;4414:				activategoal->goal.origin[1],
;4415:				activategoal->goal.origin[2],
;4416:				activategoal->goal.areanum);
;4417:	} else {
ADDRGP4 $2669
JUMPV
LABELV $2668
line 4418
;4418:		Com_sprintf(buf, sizeof (buf), "%s: I have to activate a %s at %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $2671
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4424
;4419:				netname, classname,
;4420:				activategoal->goal.origin[0],
;4421:				activategoal->goal.origin[1],
;4422:				activategoal->goal.origin[2],
;4423:				activategoal->goal.areanum);
;4424:	}
LABELV $2669
line 4425
;4425:	trap_EA_Say(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ARGP4
ADDRGP4 trap_EA_Say
CALLV
pop
line 4426
;4426:}
LABELV $2667
endproc BotPrintActivateGoalInfo 296 36
export BotRandomMove
proc BotRandomMove 32 16
line 4433
;4427:
;4428:/*
;4429:==================
;4430:BotRandomMove
;4431:==================
;4432: */
;4433:void BotRandomMove(bot_state_t *bs, bot_moveresult_t *moveresult) {
line 4436
;4434:	vec3_t dir, angles;
;4435:
;4436:	angles[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4437
;4437:	angles[1] = random() * 360;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1135869952
ADDRLP4 24
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
line 4438
;4438:	angles[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4439
;4439:	AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
CNSTP4 0
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4441
;4440:
;4441:	trap_BotMoveInDirection(bs->ms, dir, 400, MOVE_WALK);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4443
;4442:
;4443:	moveresult->failure = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4444
;4444:	VectorCopy(dir, moveresult->movedir);
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4445
;4445:}
LABELV $2672
endproc BotRandomMove 32 16
lit
align 4
LABELV $2676
byte 4 0
byte 4 0
byte 4 1065353216
export BotAIBlocked
code
proc BotAIBlocked 480 16
line 4458
;4446:
;4447:/*
;4448:==================
;4449:BotAIBlocked
;4450:
;4451:Very basic handling of bots being blocked by other entities.
;4452:Check what kind of entity is blocking the bot and try to activate
;4453:it. If that's not an option then try to walk around or over the entity.
;4454:Before the bot ends in this part of the AI it should predict which doors to
;4455:open, which buttons to activate etc.
;4456:==================
;4457: */
;4458:void BotAIBlocked(bot_state_t *bs, bot_moveresult_t *moveresult, int activate) {
line 4463
;4459:#ifdef OBSTACLEDEBUG
;4460:	char netname[MAX_NETNAME];
;4461:#endif
;4462:	int movetype, bspent;
;4463:	vec3_t hordir, start, sideward, angles, up = {0, 0, 1};
ADDRLP4 192
ADDRGP4 $2676
INDIRB
ASGNB 12
line 4468
;4464:	aas_entityinfo_t entinfo;
;4465:	bot_activategoal_t activategoal;
;4466:
;4467:	// if the bot is not blocked by anything
;4468:	if (!moveresult->blocked) {
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2677
line 4469
;4469:		bs->notblocked_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6060
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4470
;4470:		return;
ADDRGP4 $2675
JUMPV
LABELV $2677
line 4473
;4471:	}
;4472:	// if stuck in a solid area
;4473:	if (moveresult->type == RESULTTYPE_INSOLIDAREA) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $2679
line 4475
;4474:		// move in a random direction in the hope to get out
;4475:		BotRandomMove(bs, moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRandomMove
CALLV
pop
line 4477
;4476:		//
;4477:		return;
ADDRGP4 $2675
JUMPV
LABELV $2679
line 4480
;4478:	}
;4479:	// get info for the entity that is blocking the bot
;4480:	BotEntityInfo(moveresult->blockentity, &entinfo);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4486
;4481:#ifdef OBSTACLEDEBUG
;4482:	ClientName(bs->client, netname, sizeof (netname));
;4483:	BotAI_Print(PRT_MESSAGE, "%s: I'm blocked by model %d\n", netname, entinfo.modelindex);
;4484:#endif // OBSTACLEDEBUG
;4485:	// if blocked by a bsp model and the bot wants to activate it
;4486:	if (activate && entinfo.modelindex > 0 && entinfo.modelindex <= max_bspmodelindex) {
ADDRLP4 452
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 452
INDIRI4
EQI4 $2681
ADDRLP4 28+104
INDIRI4
ADDRLP4 452
INDIRI4
LEI4 $2681
ADDRLP4 28+104
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
GTI4 $2681
line 4488
;4487:		// find the bsp entity which should be activated in order to get the blocking entity out of the way
;4488:		bspent = BotGetActivateGoal(bs, entinfo.number, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28+20
INDIRI4
ARGI4
ADDRLP4 204
ARGP4
ADDRLP4 456
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 448
ADDRLP4 456
INDIRI4
ASGNI4
line 4489
;4489:		if (bspent) {
ADDRLP4 448
INDIRI4
CNSTI4 0
EQI4 $2686
line 4491
;4490:			//
;4491:			if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 460
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 460
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2688
ADDRLP4 460
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2688
line 4492
;4492:				bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
CNSTP4 0
ASGNP4
LABELV $2688
line 4494
;4493:			// if not already trying to activate this entity
;4494:			if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204+4+40
INDIRI4
ARGI4
ADDRLP4 464
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 464
INDIRI4
CNSTI4 0
NEI4 $2690
line 4496
;4495:				//
;4496:				BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4497
;4497:			}
LABELV $2690
line 4501
;4498:			// if ontop of an obstacle or
;4499:			// if the bot is not in a reachability area it'll still
;4500:			// need some dynamic obstacle avoidance, otherwise return
;4501:			if (!(moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) &&
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $2687
ADDRFP4 0
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 468
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 468
INDIRI4
CNSTI4 0
EQI4 $2687
line 4503
;4502:					trap_AAS_AreaReachability(bs->areanum))
;4503:				return;
ADDRGP4 $2675
JUMPV
line 4504
;4504:		} else {
LABELV $2686
line 4506
;4505:			// enable any routing areas that were disabled
;4506:			BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 204
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4507
;4507:		}
LABELV $2687
line 4508
;4508:	}
LABELV $2681
line 4510
;4509:	// just some basic dynamic obstacle avoidance code
;4510:	hordir[0] = moveresult->movedir[0];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 4511
;4511:	hordir[1] = moveresult->movedir[1];
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
line 4512
;4512:	hordir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4514
;4513:	// if no direction just take a random direction
;4514:	if (VectorNormalize(hordir) < 0.1) {
ADDRLP4 0
ARGP4
ADDRLP4 456
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 456
INDIRF4
CNSTF4 1036831949
GEF4 $2698
line 4515
;4515:		VectorSet(angles, 0, 360 * random(), 0);
ADDRLP4 180
CNSTF4 0
ASGNF4
ADDRLP4 460
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 180+4
CNSTF4 1135869952
ADDRLP4 460
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
ADDRLP4 180+8
CNSTF4 0
ASGNF4
line 4516
;4516:		AngleVectors(angles, hordir, NULL, NULL);
ADDRLP4 180
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 464
CNSTP4 0
ASGNP4
ADDRLP4 464
INDIRP4
ARGP4
ADDRLP4 464
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4517
;4517:	}
LABELV $2698
line 4521
;4518:	//
;4519:	//if (moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) movetype = MOVE_JUMP;
;4520:	//else
;4521:	movetype = MOVE_WALK;
ADDRLP4 24
CNSTI4 1
ASGNI4
line 4524
;4522:	// if there's an obstacle at the bot's feet and head then
;4523:	// the bot might be able to crouch through
;4524:	VectorCopy(bs->origin, start);
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
INDIRB
ASGNB 12
line 4525
;4525:	start[2] += 18;
ADDRLP4 168+8
ADDRLP4 168+8
INDIRF4
CNSTF4 1099956224
ADDF4
ASGNF4
line 4530
;4526:	//
;4527:	//bsptrace = AAS_Trace(start, mins, maxs, end, bs->entitynum, MASK_PLAYERSOLID);
;4528:	//if (bsptrace.fraction >= 1) movetype = MOVE_CROUCH;
;4529:	// get the sideward vector
;4530:	CrossProduct(hordir, up, sideward);
ADDRLP4 0
ARGP4
ADDRLP4 192
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 4532
;4531:	//
;4532:	if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2703
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
LABELV $2703
line 4534
;4533:	// try to crouch straight forward?
;4534:	if (movetype != MOVE_CROUCH || !trap_BotMoveInDirection(bs->ms, hordir, 400, movetype)) {
ADDRLP4 24
INDIRI4
CNSTI4 2
NEI4 $2711
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 464
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 464
INDIRI4
CNSTI4 0
NEI4 $2709
LABELV $2711
line 4536
;4535:		// perform the movement
;4536:		if (!trap_BotMoveInDirection(bs->ms, sideward, 400, movetype)) {
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 468
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 468
INDIRI4
CNSTI4 0
NEI4 $2712
line 4538
;4537:			// flip the avoid direction flag
;4538:			bs->flags ^= BFL_AVOIDRIGHT;
ADDRLP4 472
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
ASGNP4
ADDRLP4 472
INDIRP4
ADDRLP4 472
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 4541
;4539:			// flip the direction
;4540:			// VectorNegate(sideward, sideward);
;4541:			VectorMA(sideward, -1, hordir, sideward);
ADDRLP4 476
CNSTF4 3212836864
ASGNF4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 476
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 476
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 3212836864
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 4543
;4542:			// move in the other direction
;4543:			trap_BotMoveInDirection(bs->ms, sideward, 400, movetype);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4544
;4544:		}
LABELV $2712
line 4545
;4545:	}
LABELV $2709
line 4547
;4546:	//
;4547:	if (bs->notblocked_time < FloatTime() - 0.4) {
ADDRFP4 0
INDIRP4
CNSTI4 6060
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1053609165
SUBF4
GEF4 $2720
line 4550
;4548:		// just reset goals and hope the bot will go into another direction?
;4549:		// is this still needed??
;4550:		if (bs->ainode == AINode_Seek_NBG) bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_NBG
CVPU4 4
NEU4 $2722
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $2723
JUMPV
LABELV $2722
line 4551
;4551:		else if (bs->ainode == AINode_Seek_LTG) bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_LTG
CVPU4 4
NEU4 $2724
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
CNSTF4 0
ASGNF4
LABELV $2724
LABELV $2723
line 4552
;4552:	}
LABELV $2720
line 4553
;4553:}
LABELV $2675
endproc BotAIBlocked 480 16
export BotAIPredictObstacles
proc BotAIPredictObstacles 324 44
line 4565
;4554:
;4555:/*
;4556:==================
;4557:BotAIPredictObstacles
;4558:
;4559:Predict the route towards the goal and check if the bot
;4560:will be blocked by certain obstacles. When the bot has obstacles
;4561:on it's path the bot should figure out if they can be removed
;4562:by activating certain entities.
;4563:==================
;4564: */
;4565:int BotAIPredictObstacles(bot_state_t *bs, bot_goal_t *goal) {
line 4570
;4566:	int modelnum, entitynum, bspent;
;4567:	bot_activategoal_t activategoal;
;4568:	aas_predictroute_t route;
;4569:
;4570:	if (!bot_predictobstacles.integer)
ADDRGP4 bot_predictobstacles+12
INDIRI4
CNSTI4 0
NEI4 $2727
line 4571
;4571:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2726
JUMPV
LABELV $2727
line 4574
;4572:
;4573:	// always predict when the goal change or at regular intervals
;4574:	if (bs->predictobstacles_goalareanum == goal->areanum &&
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 6072
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2730
ADDRLP4 292
INDIRP4
CNSTI4 6068
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1086324736
SUBF4
LEF4 $2730
line 4575
;4575:			bs->predictobstacles_time > FloatTime() - 6) {
line 4576
;4576:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2726
JUMPV
LABELV $2730
line 4578
;4577:	}
;4578:	bs->predictobstacles_goalareanum = goal->areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 4579
;4579:	bs->predictobstacles_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4582
;4580:
;4581:	// predict at most 100 areas or 1 second ahead
;4582:	trap_AAS_PredictRoute(&route, bs->areanum, bs->origin,
ADDRLP4 0
ARGP4
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
CNSTI4 1000
ARGI4
CNSTI4 6
ARGI4
CNSTI4 1024
ARGI4
CNSTI4 67108864
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictRoute
CALLI4
pop
line 4587
;4583:			goal->areanum, bs->tfl, 100, 1000,
;4584:			RSE_USETRAVELTYPE | RSE_ENTERCONTENTS,
;4585:			AREACONTENTS_MOVER, TFL_BRIDGE, 0);
;4586:	// if bot has to travel through an area with a mover
;4587:	if (route.stopevent & RSE_ENTERCONTENTS) {
ADDRLP4 0+16
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2732
line 4589
;4588:		// if the bot will run into a mover
;4589:		if (route.endcontents & AREACONTENTS_MOVER) {
ADDRLP4 0+20
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2733
line 4591
;4590:			//NOTE: this only works with bspc 2.1 or higher
;4591:			modelnum = (route.endcontents & AREACONTENTS_MODELNUM) >> AREACONTENTS_MODELNUMSHIFT;
ADDRLP4 300
CNSTI4 24
ASGNI4
ADDRLP4 36
ADDRLP4 0+20
INDIRI4
CNSTI4 255
ADDRLP4 300
INDIRI4
LSHI4
BANDI4
ADDRLP4 300
INDIRI4
RSHI4
ASGNI4
line 4592
;4592:			if (modelnum) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2733
line 4594
;4593:				//
;4594:				entitynum = BotModelMinsMaxs(modelnum, ET_MOVER, 0, NULL, NULL);
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 304
CNSTP4 0
ASGNP4
ADDRLP4 304
INDIRP4
ARGP4
ADDRLP4 304
INDIRP4
ARGP4
ADDRLP4 308
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 308
INDIRI4
ASGNI4
line 4595
;4595:				if (entitynum) {
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $2733
line 4597
;4596:					//NOTE: BotGetActivateGoal already checks if the door is open or not
;4597:					bspent = BotGetActivateGoal(bs, entitynum, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 312
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 312
INDIRI4
ASGNI4
line 4598
;4598:					if (bspent) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $2733
line 4600
;4599:						//
;4600:						if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 316
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 316
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2745
ADDRLP4 316
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2745
line 4601
;4601:							bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
CNSTP4 0
ASGNP4
LABELV $2745
line 4603
;4602:						// if not already trying to activate this entity
;4603:						if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48+4+40
INDIRI4
ARGI4
ADDRLP4 320
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 0
NEI4 $2747
line 4607
;4604:							//
;4605:							//BotAI_Print(PRT_MESSAGE, "blocked by mover model %d, entity %d ?\n", modelnum, entitynum);
;4606:							//
;4607:							BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4608
;4608:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2726
JUMPV
LABELV $2747
line 4609
;4609:						} else {
line 4611
;4610:							// enable any routing areas that were disabled
;4611:							BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 48
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4612
;4612:						}
line 4613
;4613:					}
line 4614
;4614:				}
line 4615
;4615:			}
line 4616
;4616:		}
line 4617
;4617:	} else if (route.stopevent & RSE_USETRAVELTYPE) {
ADDRGP4 $2733
JUMPV
LABELV $2732
ADDRLP4 0+16
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2751
line 4618
;4618:		if (route.endtravelflags & TFL_BRIDGE) {
ADDRLP4 0+24
INDIRI4
CNSTI4 67108864
BANDI4
CNSTI4 0
EQI4 $2754
line 4620
;4619:			//FIXME: check if the bridge is available to travel over
;4620:		}
LABELV $2754
line 4621
;4621:	}
LABELV $2751
LABELV $2733
line 4622
;4622:	return qfalse;
CNSTI4 0
RETI4
LABELV $2726
endproc BotAIPredictObstacles 324 44
export BotCheckConsoleMessages
proc BotCheckConsoleMessages 1012 48
line 4630
;4623:}
;4624:
;4625:/*
;4626:==================
;4627:BotCheckConsoleMessages
;4628:==================
;4629: */
;4630:void BotCheckConsoleMessages(bot_state_t *bs) {
line 4638
;4631:	char botname[MAX_NETNAME], message[MAX_MESSAGE_SIZE], netname[MAX_NETNAME], *ptr;
;4632:	float chat_reply;
;4633:	int context, handle;
;4634:	bot_consolemessage_t m;
;4635:	bot_match_t match;
;4636:
;4637:	//the name of this bot
;4638:	ClientName(bs->client, botname, sizeof (botname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 908
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
ADDRGP4 $2759
JUMPV
LABELV $2758
line 4640
;4639:	//
;4640:	while ((handle = trap_BotNextConsoleMessage(bs->cs, &m)) != 0) {
line 4642
;4641:		//if the chat state is flooded with messages the bot will read them quickly
;4642:		if (trap_BotNumConsoleMessages(bs->cs) < 10) {
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 948
ADDRGP4 trap_BotNumConsoleMessages
CALLI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 10
GEI4 $2761
line 4644
;4643:			//if it is a chat message the bot needs some time to read it
;4644:			if (m.type == CMS_CHAT && m.time > FloatTime() - (1 + random())) break;
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2763
ADDRLP4 952
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 952
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1065353216
ADDF4
SUBF4
LEF4 $2763
ADDRGP4 $2760
JUMPV
LABELV $2763
line 4645
;4645:		}
LABELV $2761
line 4647
;4646:		//
;4647:		ptr = m.message;
ADDRLP4 276
ADDRLP4 0+12
ASGNP4
line 4650
;4648:		//if it is a chat message then don't unify white spaces and don't
;4649:		//replace synonyms in the netname
;4650:		if (m.type == CMS_CHAT) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2768
line 4652
;4651:			//
;4652:			if (trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 952
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 952
INDIRI4
CNSTI4 0
EQI4 $2771
line 4653
;4653:				ptr = m.message + match.variables[MESSAGE].offset;
ADDRLP4 276
ADDRLP4 288+264+16
INDIRI1
CVII4 1
ADDRLP4 0+12
ADDP4
ASGNP4
line 4654
;4654:			}
LABELV $2771
line 4655
;4655:		}
LABELV $2768
line 4657
;4656:		//unify the white spaces in the message
;4657:		trap_UnifyWhiteSpaces(ptr);
ADDRLP4 276
INDIRP4
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4659
;4658:		//replace synonyms in the right context
;4659:		context = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 952
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 284
ADDRLP4 952
INDIRI4
ASGNI4
line 4660
;4660:		trap_BotReplaceSynonyms(ptr, context);
ADDRLP4 276
INDIRP4
ARGP4
ADDRLP4 284
INDIRI4
CVIU4 4
ARGU4
ADDRGP4 trap_BotReplaceSynonyms
CALLV
pop
line 4662
;4661:		//if there's no match
;4662:		if (!BotMatchMessage(bs, m.message)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 956
ADDRGP4 BotMatchMessage
CALLI4
ASGNI4
ADDRLP4 956
INDIRI4
CNSTI4 0
NEI4 $2777
line 4664
;4663:			//if it is a chat message
;4664:			if (m.type == CMS_CHAT && !bot_nochat.integer) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2780
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
NEI4 $2780
line 4666
;4665:				//
;4666:				if (!trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 960
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 960
INDIRI4
CNSTI4 0
NEI4 $2784
line 4667
;4667:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4668
;4668:					continue;
ADDRGP4 $2759
JUMPV
LABELV $2784
line 4671
;4669:				}
;4670:				//don't use eliza chats with team messages
;4671:				if (match.subtype & ST_TEAM) {
ADDRLP4 288+260
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $2787
line 4672
;4672:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4673
;4673:					continue;
ADDRGP4 $2759
JUMPV
LABELV $2787
line 4676
;4674:				}
;4675:				//
;4676:				trap_BotMatchVariable(&match, NETNAME, netname, sizeof (netname));
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 872
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4677
;4677:				trap_BotMatchVariable(&match, MESSAGE, message, sizeof (message));
ADDRLP4 288
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 616
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4679
;4678:				//if this is a message from the bot self
;4679:				if (bs->client == ClientFromName(netname)) {
ADDRLP4 872
ARGP4
ADDRLP4 964
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 964
INDIRI4
NEI4 $2790
line 4680
;4680:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4681
;4681:					continue;
ADDRGP4 $2759
JUMPV
LABELV $2790
line 4684
;4682:				}
;4683:				//unify the message
;4684:				trap_UnifyWhiteSpaces(message);
ADDRLP4 616
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4686
;4685:				//
;4686:				trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 4687
;4687:				if (bot_testrchat.integer) {
ADDRGP4 bot_testrchat+12
INDIRI4
CNSTI4 0
EQI4 $2792
line 4689
;4688:					//
;4689:					trap_BotLibVarSet("bot_testrchat", "1");
ADDRGP4 $2795
ARGP4
ADDRGP4 $2796
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 4691
;4690:					//if bot replies with a chat message
;4691:					if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 968
CNSTP4 0
ASGNP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 972
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 972
INDIRI4
CNSTI4 0
EQI4 $2797
line 4695
;4692:							NULL, NULL,
;4693:							NULL, NULL,
;4694:							NULL, NULL,
;4695:							botname, netname)) {
line 4696
;4696:						BotAI_Print(PRT_MESSAGE, "------------------------\n");
CNSTI4 1
ARGI4
ADDRGP4 $2799
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4697
;4697:					} else {
ADDRGP4 $2793
JUMPV
LABELV $2797
line 4698
;4698:						BotAI_Print(PRT_MESSAGE, "**** no valid reply ****\n");
CNSTI4 1
ARGI4
ADDRGP4 $2800
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4699
;4699:					}
line 4700
;4700:				}					//if at a valid chat position and not chatting already and not in teamplay
ADDRGP4 $2793
JUMPV
LABELV $2792
line 4701
;4701:				else if (bs->ainode != AINode_Stand && BotValidChatPosition(bs) &&
ADDRLP4 968
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 968
INDIRP4
CNSTI4 4756
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Stand
CVPU4 4
EQU4 $2801
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 972
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 972
INDIRI4
CNSTI4 0
EQI4 $2801
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 976
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 976
INDIRI4
CNSTI4 0
NEI4 $2801
line 4702
;4702:						!G_IsATeamGametype(gametype)) {
line 4703
;4703:					chat_reply = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_REPLY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 35
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 944
ADDRLP4 980
INDIRF4
ASGNF4
line 4704
;4704:					if (random() < 1.5 / (NumBots() + 1) && random() < chat_reply) {
ADDRLP4 984
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 988
ADDRGP4 NumBots
CALLI4
ASGNI4
ADDRLP4 984
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1069547520
ADDRLP4 988
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
GEF4 $2803
ADDRLP4 992
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 992
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 944
INDIRF4
GEF4 $2803
line 4706
;4705:						//if bot replies with a chat message
;4706:						if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 996
CNSTP4 0
ASGNP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 996
INDIRP4
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 1000
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 0
EQI4 $2805
line 4710
;4707:								NULL, NULL,
;4708:								NULL, NULL,
;4709:								NULL, NULL,
;4710:								botname, netname)) {
line 4712
;4711:							//remove the console message
;4712:							trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4713
;4713:							bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
ARGP4
ADDRLP4 1008
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1004
INDIRP4
CNSTI4 5952
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1008
INDIRF4
ADDF4
ASGNF4
line 4714
;4714:							AIEnter_Stand(bs, "BotCheckConsoleMessages: reply chat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2807
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 4716
;4715:							//EA_Say(bs->client, bs->cs.chatmessage);
;4716:							break;
ADDRGP4 $2760
JUMPV
LABELV $2805
line 4718
;4717:						}
;4718:					}
LABELV $2803
line 4719
;4719:				}
LABELV $2801
LABELV $2793
line 4720
;4720:			}
LABELV $2780
line 4721
;4721:		}
LABELV $2777
line 4723
;4722:		//remove the console message
;4723:		trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4724
;4724:	}
LABELV $2759
line 4640
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 948
ADDRGP4 trap_BotNextConsoleMessage
CALLI4
ASGNI4
ADDRLP4 280
ADDRLP4 948
INDIRI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 0
NEI4 $2758
LABELV $2760
line 4725
;4725:}
LABELV $2757
endproc BotCheckConsoleMessages 1012 48
export BotCheckForGrenades
proc BotCheckForGrenades 8 16
line 4732
;4726:
;4727:/*
;4728:==================
;4729:BotCheckEvents
;4730:==================
;4731: */
;4732:void BotCheckForGrenades(bot_state_t *bs, entityState_t *state) {
line 4734
;4733:	// if this is not a grenade
;4734:	if (state->eType != ET_MISSILE || state->weapon != WP_GRENADE_LAUNCHER)
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2811
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $2809
LABELV $2811
line 4735
;4735:		return;
ADDRGP4 $2808
JUMPV
LABELV $2809
line 4737
;4736:	// try to avoid the grenade
;4737:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1126170624
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 4738
;4738:}
LABELV $2808
endproc BotCheckForGrenades 8 16
export BotCheckForProxMines
proc BotCheckForProxMines 40 16
line 4745
;4739:
;4740:/*
;4741:==================
;4742:BotCheckForProxMines
;4743:==================
;4744: */
;4745:void BotCheckForProxMines(bot_state_t *bs, entityState_t *state) {
line 4747
;4746:	// if this is not a prox mine
;4747:	if (state->eType != ET_MISSILE || state->weapon != WP_PROX_LAUNCHER)
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2815
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
EQI4 $2813
LABELV $2815
line 4748
;4748:		return;
ADDRGP4 $2812
JUMPV
LABELV $2813
line 4750
;4749:	// if this prox mine is from someone on our own team
;4750:	if (state->generic1 == BotTeam(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $2816
line 4751
;4751:		return;
ADDRGP4 $2812
JUMPV
LABELV $2816
line 4753
;4752:	// if the bot doesn't have a weapon to deactivate the mine
;4753:	if (!(bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0) &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 4852
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $2820
ADDRLP4 8
INDIRP4
CNSTI4 4892
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
GTI4 $2818
LABELV $2820
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 4840
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
LEI4 $2821
ADDRLP4 16
INDIRP4
CNSTI4 4900
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
GTI4 $2818
LABELV $2821
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 4860
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $2822
ADDRLP4 24
INDIRP4
CNSTI4 4908
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
GTI4 $2818
LABELV $2822
line 4755
;4754:			!(bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0) &&
;4755:			!(bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0)) {
line 4756
;4756:		return;
ADDRGP4 $2812
JUMPV
LABELV $2818
line 4759
;4757:	}
;4758:	// try to avoid the prox mine
;4759:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1126170624
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 4761
;4760:	//
;4761:	if (bs->numproxmines >= MAX_PROXMINES)
ADDRFP4 0
INDIRP4
CNSTI4 6372
ADDP4
INDIRI4
CNSTI4 64
LTI4 $2823
line 4762
;4762:		return;
ADDRGP4 $2812
JUMPV
LABELV $2823
line 4763
;4763:	bs->proxmines[bs->numproxmines] = state->number;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 6372
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 6116
ADDP4
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 4764
;4764:	bs->numproxmines++;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 6372
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4765
;4765:}
LABELV $2812
endproc BotCheckForProxMines 40 16
export BotCheckForKamikazeBody
proc BotCheckForKamikazeBody 0 0
line 4772
;4766:
;4767:/*
;4768:==================
;4769:BotCheckForKamikazeBody
;4770:==================
;4771: */
;4772:void BotCheckForKamikazeBody(bot_state_t *bs, entityState_t *state) {
line 4774
;4773:	// if this entity is not wearing the kamikaze
;4774:	if (!(state->eFlags & EF_KAMIKAZE))
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $2826
line 4775
;4775:		return;
ADDRGP4 $2825
JUMPV
LABELV $2826
line 4777
;4776:	// if this entity isn't dead
;4777:	if (!(state->eFlags & EF_DEAD))
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $2828
line 4778
;4778:		return;
ADDRGP4 $2825
JUMPV
LABELV $2828
line 4780
;4779:	//remember this kamikaze body
;4780:	bs->kamikazebody = state->number;
ADDRFP4 0
INDIRP4
CNSTI4 6112
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 4781
;4781:}
LABELV $2825
endproc BotCheckForKamikazeBody 0 0
export BotCheckEvents
proc BotCheckEvents 324 12
line 4788
;4782:
;4783:/*
;4784:==================
;4785:BotCheckEvents
;4786:==================
;4787: */
;4788:void BotCheckEvents(bot_state_t *bs, entityState_t *state) {
line 4795
;4789:	int event;
;4790:	char buf[128];
;4791:	aas_entityinfo_t entinfo;
;4792:
;4793:	//NOTE: this sucks, we're accessing the gentity_t directly
;4794:	//but there's no other fast way to do it right now
;4795:	if (bs->entityeventTime[state->number] == g_entities[state->number].eventTime) {
ADDRLP4 272
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
INDIRI4
CNSTI4 816
ADDRLP4 272
INDIRI4
MULI4
ADDRGP4 g_entities+552
ADDP4
INDIRI4
NEI4 $2831
line 4796
;4796:		return;
ADDRGP4 $2830
JUMPV
LABELV $2831
line 4798
;4797:	}
;4798:	bs->entityeventTime[state->number] = g_entities[state->number].eventTime;
ADDRLP4 276
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
CNSTI4 816
ADDRLP4 276
INDIRI4
MULI4
ADDRGP4 g_entities+552
ADDP4
INDIRI4
ASGNI4
line 4800
;4799:	//if it's an event only entity
;4800:	if (state->eType > ET_EVENTS) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $2835
line 4801
;4801:		event = (state->eType - ET_EVENTS) & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
CNSTI4 -769
BANDI4
ASGNI4
line 4802
;4802:	} else {
ADDRGP4 $2836
JUMPV
LABELV $2835
line 4803
;4803:		event = state->event & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 4804
;4804:	}
LABELV $2836
line 4806
;4805:	//
;4806:	switch (event) {
ADDRLP4 280
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 1
LTI4 $2837
ADDRLP4 280
INDIRI4
CNSTI4 76
GTI4 $2837
ADDRLP4 280
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2915-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2915
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2838
address $2837
address $2837
address $2900
address $2837
address $2837
address $2901
address $2857
address $2869
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2839
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2837
address $2838
code
LABELV $2839
line 4809
;4807:			//client obituary event
;4808:		case EV_OBITUARY:
;4809:		{
line 4812
;4810:			int target, attacker, mod;
;4811:
;4812:			target = state->otherEntityNum;
ADDRLP4 284
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 4813
;4813:			attacker = state->otherEntityNum2;
ADDRLP4 288
ADDRFP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 4814
;4814:			mod = state->eventParm;
ADDRLP4 292
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 4816
;4815:			//
;4816:			if (target == bs->client) {
ADDRLP4 284
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2840
line 4817
;4817:				bs->botdeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 5856
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 4818
;4818:				bs->lastkilledby = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 5852
ADDP4
ADDRLP4 288
INDIRI4
ASGNI4
line 4820
;4819:				//
;4820:				if (target == attacker ||
ADDRLP4 296
ADDRLP4 284
INDIRI4
ASGNI4
ADDRLP4 296
INDIRI4
ADDRLP4 288
INDIRI4
EQI4 $2845
ADDRLP4 296
INDIRI4
CNSTI4 1023
EQI4 $2845
ADDRLP4 296
INDIRI4
CNSTI4 1022
NEI4 $2842
LABELV $2845
line 4822
;4821:						target == ENTITYNUM_NONE ||
;4822:						target == ENTITYNUM_WORLD) bs->botsuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5864
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $2843
JUMPV
LABELV $2842
line 4823
;4823:				else bs->botsuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5864
ADDP4
CNSTI4 0
ASGNI4
LABELV $2843
line 4825
;4824:				//
;4825:				bs->num_deaths++;
ADDRLP4 300
ADDRFP4 0
INDIRP4
CNSTI4 5884
ADDP4
ASGNP4
ADDRLP4 300
INDIRP4
ADDRLP4 300
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4826
;4826:			}				//else if this client was killed by the bot
ADDRGP4 $2841
JUMPV
LABELV $2840
line 4827
;4827:			else if (attacker == bs->client) {
ADDRLP4 288
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2846
line 4828
;4828:				bs->enemydeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 5860
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 4829
;4829:				bs->lastkilledplayer = target;
ADDRFP4 0
INDIRP4
CNSTI4 5848
ADDP4
ADDRLP4 284
INDIRI4
ASGNI4
line 4830
;4830:				bs->killedenemy_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4832
;4831:				//
;4832:				bs->num_kills++;
ADDRLP4 296
ADDRFP4 0
INDIRP4
CNSTI4 5888
ADDP4
ASGNP4
ADDRLP4 296
INDIRP4
ADDRLP4 296
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4833
;4833:			} else if (attacker == bs->enemy && target == attacker) {
ADDRGP4 $2847
JUMPV
LABELV $2846
ADDRLP4 296
ADDRLP4 288
INDIRI4
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
NEI4 $2848
ADDRLP4 284
INDIRI4
ADDRLP4 296
INDIRI4
NEI4 $2848
line 4834
;4834:				bs->enemysuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5868
ADDP4
CNSTI4 1
ASGNI4
line 4835
;4835:			}
LABELV $2848
LABELV $2847
LABELV $2841
line 4837
;4836:			//	
;4837:			if (G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 300
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $2838
line 4839
;4838:				//
;4839:				BotEntityInfo(target, &entinfo);
ADDRLP4 284
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4840
;4840:				if (entinfo.powerups & (1 << PW_NEUTRALFLAG)) {
ADDRLP4 132+124
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $2838
line 4841
;4841:					if (!BotSameTeam(bs, target)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
ADDRLP4 304
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 0
NEI4 $2838
line 4842
;4842:						bs->neutralflagstatus = 3; //enemy dropped the flag
ADDRFP4 0
INDIRP4
CNSTI4 6820
ADDP4
CNSTI4 3
ASGNI4
line 4843
;4843:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4844
;4844:					}
line 4845
;4845:				}
line 4846
;4846:			}
line 4847
;4847:			break;
ADDRGP4 $2838
JUMPV
LABELV $2857
line 4850
;4848:		}
;4849:		case EV_GLOBAL_SOUND:
;4850:		{
line 4851
;4851:			if (state->eventParm < 0 || state->eventParm > MAX_SOUNDS) {
ADDRLP4 284
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
LTI4 $2860
ADDRLP4 284
INDIRI4
CNSTI4 256
LEI4 $2858
LABELV $2860
line 4852
;4852:				BotAI_Print(PRT_ERROR, "EV_GLOBAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2861
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 4853
;4853:				break;
ADDRGP4 $2838
JUMPV
LABELV $2858
line 4855
;4854:			}
;4855:			trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof (buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 4868
;4856:			/*
;4857:			if (strequals(buf, "sound/teamplay/flagret_red.wav")) {
;4858:				//red flag is returned
;4859:				bs->redflagstatus = 0;
;4860:				bs->flagstatuschanged = qtrue;
;4861:			}
;4862:			else if (strequals(buf, "sound/teamplay/flagret_blu.wav")) {
;4863:				//blue flag is returned
;4864:				bs->blueflagstatus = 0;
;4865:				bs->flagstatuschanged = qtrue;
;4866:			}
;4867:			else*/
;4868:			if (strequals(buf, "sound/items/kamikazerespawn.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2864
ARGP4
ADDRLP4 288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2862
line 4870
;4869:				//the kamikaze respawned so dont avoid it
;4870:				BotDontAvoid(bs, "Kamikaze");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2865
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 4871
;4871:			} else
ADDRGP4 $2838
JUMPV
LABELV $2862
line 4872
;4872:				if (strequals(buf, "sound/items/poweruprespawn.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2868
ARGP4
ADDRLP4 292
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
NEI4 $2838
line 4874
;4873:				//powerup respawned... go get it
;4874:				BotGoForPowerups(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoForPowerups
CALLV
pop
line 4875
;4875:			}
line 4876
;4876:			break;
ADDRGP4 $2838
JUMPV
LABELV $2869
line 4879
;4877:		}
;4878:		case EV_GLOBAL_TEAM_SOUND:
;4879:		{
line 4880
;4880:			if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 284
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
EQI4 $2870
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 288
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2870
line 4881
;4881:				switch (state->eventParm) {
ADDRLP4 292
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
LTI4 $2838
ADDRLP4 292
INDIRI4
CNSTI4 5
GTI4 $2838
ADDRLP4 292
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2881
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2881
address $2875
address $2876
address $2877
address $2878
address $2879
address $2880
code
LABELV $2875
line 4883
;4882:					case GTS_RED_CAPTURE:
;4883:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6816
ADDP4
CNSTI4 0
ASGNI4
line 4884
;4884:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6812
ADDP4
CNSTI4 0
ASGNI4
line 4885
;4885:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4886
;4886:						break; //see BotMatch_CTF
ADDRGP4 $2838
JUMPV
LABELV $2876
line 4888
;4887:					case GTS_BLUE_CAPTURE:
;4888:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6816
ADDP4
CNSTI4 0
ASGNI4
line 4889
;4889:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6812
ADDP4
CNSTI4 0
ASGNI4
line 4890
;4890:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4891
;4891:						break; //see BotMatch_CTF
ADDRGP4 $2838
JUMPV
LABELV $2877
line 4894
;4892:					case GTS_RED_RETURN:
;4893:						//blue flag is returned
;4894:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6816
ADDP4
CNSTI4 0
ASGNI4
line 4895
;4895:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4896
;4896:						break;
ADDRGP4 $2838
JUMPV
LABELV $2878
line 4899
;4897:					case GTS_BLUE_RETURN:
;4898:						//red flag is returned
;4899:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6812
ADDP4
CNSTI4 0
ASGNI4
line 4900
;4900:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4901
;4901:						break;
ADDRGP4 $2838
JUMPV
LABELV $2879
line 4904
;4902:					case GTS_RED_TAKEN:
;4903:						//blue flag is taken
;4904:						bs->blueflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6816
ADDP4
CNSTI4 1
ASGNI4
line 4905
;4905:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4906
;4906:						break; //see BotMatch_CTF
ADDRGP4 $2838
JUMPV
LABELV $2880
line 4909
;4907:					case GTS_BLUE_TAKEN:
;4908:						//red flag is taken
;4909:						bs->redflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6812
ADDP4
CNSTI4 1
ASGNI4
line 4910
;4910:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4911
;4911:						break; //see BotMatch_CTF
line 4913
;4912:				}
;4913:			} else if (gametype == GT_1FCTF) {
ADDRGP4 $2838
JUMPV
LABELV $2870
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $2838
line 4914
;4914:				switch (state->eventParm) {
ADDRLP4 292
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
LTI4 $2838
ADDRLP4 292
INDIRI4
CNSTI4 5
GTI4 $2838
ADDRLP4 292
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2899
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2899
address $2887
address $2888
address $2889
address $2890
address $2891
address $2895
code
LABELV $2887
line 4916
;4915:					case GTS_RED_CAPTURE:
;4916:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6820
ADDP4
CNSTI4 0
ASGNI4
line 4917
;4917:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4918
;4918:						break;
ADDRGP4 $2838
JUMPV
LABELV $2888
line 4920
;4919:					case GTS_BLUE_CAPTURE:
;4920:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6820
ADDP4
CNSTI4 0
ASGNI4
line 4921
;4921:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4922
;4922:						break;
ADDRGP4 $2838
JUMPV
LABELV $2889
line 4925
;4923:					case GTS_RED_RETURN:
;4924:						//flag has returned
;4925:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6820
ADDP4
CNSTI4 0
ASGNI4
line 4926
;4926:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4927
;4927:						break;
ADDRGP4 $2838
JUMPV
LABELV $2890
line 4930
;4928:					case GTS_BLUE_RETURN:
;4929:						//flag has returned
;4930:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6820
ADDP4
CNSTI4 0
ASGNI4
line 4931
;4931:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4932
;4932:						break;
ADDRGP4 $2838
JUMPV
LABELV $2891
line 4934
;4933:					case GTS_RED_TAKEN:
;4934:						bs->neutralflagstatus = BotTeam(bs) == TEAM_RED ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
ADDRLP4 304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 304
INDIRP4
ARGP4
ADDRLP4 308
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 1
NEI4 $2893
ADDRLP4 300
CNSTI4 2
ASGNI4
ADDRGP4 $2894
JUMPV
LABELV $2893
ADDRLP4 300
CNSTI4 1
ASGNI4
LABELV $2894
ADDRLP4 304
INDIRP4
CNSTI4 6820
ADDP4
ADDRLP4 300
INDIRI4
ASGNI4
line 4935
;4935:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4936
;4936:						break;
ADDRGP4 $2838
JUMPV
LABELV $2895
line 4938
;4937:					case GTS_BLUE_TAKEN:
;4938:						bs->neutralflagstatus = BotTeam(bs) == TEAM_BLUE ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
ADDRLP4 316
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 316
INDIRP4
ARGP4
ADDRLP4 320
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 2
NEI4 $2897
ADDRLP4 312
CNSTI4 2
ASGNI4
ADDRGP4 $2898
JUMPV
LABELV $2897
ADDRLP4 312
CNSTI4 1
ASGNI4
LABELV $2898
ADDRLP4 316
INDIRP4
CNSTI4 6820
ADDP4
ADDRLP4 312
INDIRI4
ASGNI4
line 4939
;4939:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 1
ASGNI4
line 4940
;4940:						break;
line 4942
;4941:				}
;4942:			}
line 4943
;4943:			break;
ADDRGP4 $2838
JUMPV
LABELV $2900
line 4946
;4944:		}
;4945:		case EV_PLAYER_TELEPORT_IN:
;4946:		{
line 4947
;4947:			VectorCopy(state->origin, lastteleport_origin);
ADDRGP4 lastteleport_origin
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 4948
;4948:			lastteleport_time = FloatTime();
ADDRGP4 lastteleport_time
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4949
;4949:			break;
ADDRGP4 $2838
JUMPV
LABELV $2901
line 4952
;4950:		}
;4951:		case EV_GENERAL_SOUND:
;4952:		{
line 4954
;4953:			//if this sound is played on the bot
;4954:			if (state->number == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2838
line 4955
;4955:				if (state->eventParm < 0 || state->eventParm > MAX_SOUNDS) {
ADDRLP4 284
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
LTI4 $2906
ADDRLP4 284
INDIRI4
CNSTI4 256
LEI4 $2904
LABELV $2906
line 4956
;4956:					BotAI_Print(PRT_ERROR, "EV_GENERAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2907
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 4957
;4957:					break;
ADDRGP4 $2838
JUMPV
LABELV $2904
line 4960
;4958:				}
;4959:				//check out the sound
;4960:				trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof (buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 4962
;4961:				//if falling into a death pit
;4962:				if (strequals(buf, "*falling1.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2910
ARGP4
ADDRLP4 288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2838
line 4964
;4963:					//if the bot has a personal teleporter
;4964:					if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 4928
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2838
line 4966
;4965:						//use the holdable item
;4966:						trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 4967
;4967:					}
line 4968
;4968:				}
line 4969
;4969:			}
line 4970
;4970:			break;
line 4997
;4971:		}
;4972:		case EV_FOOTSTEP:
;4973:		case EV_FOOTSTEP_METAL:
;4974:		case EV_FOOTSPLASH:
;4975:		case EV_FOOTWADE:
;4976:		case EV_SWIM:
;4977:		case EV_FALL_SHORT:
;4978:		case EV_FALL_MEDIUM:
;4979:		case EV_FALL_FAR:
;4980:		case EV_STEP_4:
;4981:		case EV_STEP_8:
;4982:		case EV_STEP_12:
;4983:		case EV_STEP_16:
;4984:		case EV_JUMP_PAD:
;4985:		case EV_JUMP:
;4986:		case EV_TAUNT:
;4987:		case EV_WATER_TOUCH:
;4988:		case EV_WATER_LEAVE:
;4989:		case EV_WATER_UNDER:
;4990:		case EV_WATER_CLEAR:
;4991:		case EV_ITEM_PICKUP:
;4992:		case EV_GLOBAL_ITEM_PICKUP:
;4993:		case EV_NOAMMO:
;4994:		case EV_CHANGE_WEAPON:
;4995:		case EV_FIRE_WEAPON:
;4996:			//FIXME: either add to sound queue or mark player as someone making noise
;4997:			break;
line 5014
;4998:		case EV_USE_ITEM0:
;4999:		case EV_USE_ITEM1:
;5000:		case EV_USE_ITEM2:
;5001:		case EV_USE_ITEM3:
;5002:		case EV_USE_ITEM4:
;5003:		case EV_USE_ITEM5:
;5004:		case EV_USE_ITEM6:
;5005:		case EV_USE_ITEM7:
;5006:		case EV_USE_ITEM8:
;5007:		case EV_USE_ITEM9:
;5008:		case EV_USE_ITEM10:
;5009:		case EV_USE_ITEM11:
;5010:		case EV_USE_ITEM12:
;5011:		case EV_USE_ITEM13:
;5012:		case EV_USE_ITEM14:
;5013:		case EV_USE_ITEM15:
;5014:			break;
LABELV $2837
LABELV $2838
line 5016
;5015:	}
;5016:}
LABELV $2830
endproc BotCheckEvents 324 12
export BotCheckSnapshot
proc BotCheckSnapshot 216 16
line 5023
;5017:
;5018:/*
;5019:==================
;5020:BotCheckSnapshot
;5021:==================
;5022: */
;5023:void BotCheckSnapshot(bot_state_t *bs) {
line 5028
;5024:	int ent;
;5025:	entityState_t state;
;5026:
;5027:	//remove all avoid spots
;5028:	trap_BotAddAvoidSpot(bs->ms, vec3_origin, 0, AVOID_CLEAR);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 5030
;5029:	//reset kamikaze body
;5030:	bs->kamikazebody = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6112
ADDP4
CNSTI4 0
ASGNI4
line 5032
;5031:	//reset number of proxmines
;5032:	bs->numproxmines = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6372
ADDP4
CNSTI4 0
ASGNI4
line 5034
;5033:	//
;5034:	ent = 0;
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRGP4 $2919
JUMPV
LABELV $2918
line 5035
;5035:	while ((ent = BotAI_GetSnapshotEntity(bs->client, ent, &state)) != -1) {
line 5037
;5036:		//check the entity state for events
;5037:		BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 5039
;5038:		//check for grenades the bot should avoid
;5039:		BotCheckForGrenades(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForGrenades
CALLV
pop
line 5043
;5040:		//
;5041:
;5042:		//check for proximity mines which the bot should deactivate
;5043:		BotCheckForProxMines(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForProxMines
CALLV
pop
line 5045
;5044:		//check for dead bodies with the kamikaze effect which should be gibbed
;5045:		BotCheckForKamikazeBody(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForKamikazeBody
CALLV
pop
line 5046
;5046:	}
LABELV $2919
line 5035
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 208
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 212
ADDRGP4 BotAI_GetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 208
ADDRLP4 212
INDIRI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 -1
NEI4 $2918
line 5048
;5047:	//check the player state for events
;5048:	BotAI_GetEntityState(bs->client, &state);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 5050
;5049:	//copy the player state events to the entity state
;5050:	state.event = bs->cur_ps.externalEvent;
ADDRLP4 0+180
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 5051
;5051:	state.eventParm = bs->cur_ps.externalEventParm;
ADDRLP4 0+184
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 5053
;5052:	//
;5053:	BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 5054
;5054:}
LABELV $2917
endproc BotCheckSnapshot 216 16
export BotCheckAir
proc BotCheckAir 4 4
line 5061
;5055:
;5056:/*
;5057:==================
;5058:BotCheckAir
;5059:==================
;5060: */
;5061:void BotCheckAir(bot_state_t *bs) {
line 5062
;5062:	if (bs->inventory[INVENTORY_ENVIRONMENTSUIT] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2924
line 5063
;5063:		if (trap_AAS_PointContents(bs->eye) & (CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA)) {
ADDRFP4 0
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $2926
line 5064
;5064:			return;
ADDRGP4 $2923
JUMPV
LABELV $2926
line 5066
;5065:		}
;5066:	}
LABELV $2924
line 5067
;5067:	bs->lastair_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5068
;5068:}
LABELV $2923
endproc BotCheckAir 4 4
export BotAlternateRoute
proc BotAlternateRoute 16 16
line 5075
;5069:
;5070:/*
;5071:==================
;5072:BotAlternateRoute
;5073:==================
;5074: */
;5075:bot_goal_t *BotAlternateRoute(bot_state_t *bs, bot_goal_t *goal) {
line 5079
;5076:	int t;
;5077:
;5078:	// if the bot has an alternative route goal
;5079:	if (bs->altroutegoal.areanum) {
ADDRFP4 0
INDIRP4
CNSTI4 6548
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2929
line 5081
;5080:		//
;5081:		if (bs->reachedaltroutegoal_time)
ADDRFP4 0
INDIRP4
CNSTI4 6592
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2931
line 5082
;5082:			return goal;
ADDRFP4 4
INDIRP4
RETP4
ADDRGP4 $2928
JUMPV
LABELV $2931
line 5084
;5083:		// travel time towards alternative route goal
;5084:		t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, bs->altroutegoal.areanum, bs->tfl);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6548
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 5085
;5085:		if (t && t < 20) {
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2933
ADDRLP4 12
INDIRI4
CNSTI4 20
GEI4 $2933
line 5087
;5086:			//BotAI_Print(PRT_MESSAGE, "reached alternate route goal\n");
;5087:			bs->reachedaltroutegoal_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6592
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5088
;5088:		}
LABELV $2933
line 5089
;5089:		memcpy(goal, &bs->altroutegoal, sizeof (bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 5090
;5090:		return &bs->altroutegoal;
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
RETP4
ADDRGP4 $2928
JUMPV
LABELV $2929
line 5092
;5091:	}
;5092:	return goal;
ADDRFP4 4
INDIRP4
RETP4
LABELV $2928
endproc BotAlternateRoute 16 16
export BotGetAlternateRouteGoal
proc BotGetAlternateRouteGoal 24 0
line 5100
;5093:}
;5094:
;5095:/*
;5096:==================
;5097:BotGetAlternateRouteGoal
;5098:==================
;5099: */
;5100:int BotGetAlternateRouteGoal(bot_state_t *bs, int base) {
line 5105
;5101:	aas_altroutegoal_t *altroutegoals;
;5102:	bot_goal_t *goal;
;5103:	int numaltroutegoals, rnd;
;5104:
;5105:	if (base == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $2936
line 5106
;5106:		altroutegoals = red_altroutegoals;
ADDRLP4 12
ADDRGP4 red_altroutegoals
ASGNP4
line 5107
;5107:		numaltroutegoals = red_numaltroutegoals;
ADDRLP4 4
ADDRGP4 red_numaltroutegoals
INDIRI4
ASGNI4
line 5108
;5108:	} else {
ADDRGP4 $2937
JUMPV
LABELV $2936
line 5109
;5109:		altroutegoals = blue_altroutegoals;
ADDRLP4 12
ADDRGP4 blue_altroutegoals
ASGNP4
line 5110
;5110:		numaltroutegoals = blue_numaltroutegoals;
ADDRLP4 4
ADDRGP4 blue_numaltroutegoals
INDIRI4
ASGNI4
line 5111
;5111:	}
LABELV $2937
line 5112
;5112:	if (!numaltroutegoals)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2938
line 5113
;5113:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2935
JUMPV
LABELV $2938
line 5114
;5114:	rnd = (float) random() * numaltroutegoals;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 5115
;5115:	if (rnd >= numaltroutegoals)
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $2940
line 5116
;5116:		rnd = numaltroutegoals - 1;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2940
line 5117
;5117:	goal = &bs->altroutegoal;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
ASGNP4
line 5118
;5118:	goal->areanum = altroutegoals[rnd].areanum;
ADDRLP4 20
CNSTI4 12
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
CNSTI4 24
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
ADDP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 5119
;5119:	VectorCopy(altroutegoals[rnd].origin, goal->origin);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 5120
;5120:	VectorSet(goal->mins, -8, -8, -8);
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
line 5121
;5121:	VectorSet(goal->maxs, 8, 8, 8);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
line 5122
;5122:	goal->entitynum = 0;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 5123
;5123:	goal->iteminfo = 0;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 5124
;5124:	goal->number = 0;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 5125
;5125:	goal->flags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 5127
;5126:	//
;5127:	bs->reachedaltroutegoal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6592
ADDP4
CNSTF4 0
ASGNF4
line 5128
;5128:	return qtrue;
CNSTI4 1
RETI4
LABELV $2935
endproc BotGetAlternateRouteGoal 24 0
export BotSetupAlternativeRouteGoals
proc BotSetupAlternativeRouteGoals 20 32
line 5136
;5129:}
;5130:
;5131:/*
;5132:==================
;5133:BotSetupAlternateRouteGoals
;5134:==================
;5135: */
;5136:void BotSetupAlternativeRouteGoals(void) {
line 5138
;5137:
;5138:	if (altroutegoals_setup)
ADDRGP4 altroutegoals_setup
INDIRI4
CNSTI4 0
EQI4 $2943
line 5139
;5139:		return;
ADDRGP4 $2942
JUMPV
LABELV $2943
line 5140
;5140:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2945
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2945
line 5141
;5141:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2949
ARGP4
ADDRGP4 ctf_neutralflag
ARGP4
ADDRLP4 8
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $2947
line 5142
;5142:			BotAI_Print(PRT_WARNING, "No alt routes without Neutral Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2950
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2947
line 5143
;5143:		if (ctf_neutralflag.areanum) {
ADDRGP4 ctf_neutralflag+12
INDIRI4
CNSTI4 0
EQI4 $2946
line 5145
;5144:			//
;5145:			red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_redflag
ARGP4
ADDRGP4 ctf_redflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 12
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 12
INDIRI4
ASGNI4
line 5151
;5146:					ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5147:					ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5148:					red_altroutegoals, MAX_ALTROUTEGOALS,
;5149:					ALTROUTEGOAL_CLUSTERPORTALS |
;5150:					ALTROUTEGOAL_VIEWPORTALS);
;5151:			blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_blueflag
ARGP4
ADDRGP4 ctf_blueflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 16
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 16
INDIRI4
ASGNI4
line 5157
;5152:					ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5153:					ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5154:					blue_altroutegoals, MAX_ALTROUTEGOALS,
;5155:					ALTROUTEGOAL_CLUSTERPORTALS |
;5156:					ALTROUTEGOAL_VIEWPORTALS);
;5157:		}
line 5158
;5158:	} else if (gametype == GT_1FCTF) {
ADDRGP4 $2946
JUMPV
LABELV $2945
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $2958
line 5159
;5159:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2962
ARGP4
ADDRGP4 neutralobelisk
ARGP4
ADDRLP4 8
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $2960
line 5160
;5160:			BotAI_Print(PRT_WARNING, "One Flag CTF without Neutral Obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $2963
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2960
line 5161
;5161:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_redflag
ARGP4
ADDRGP4 ctf_redflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 12
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 12
INDIRI4
ASGNI4
line 5167
;5162:				ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5163:				ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5164:				red_altroutegoals, MAX_ALTROUTEGOALS,
;5165:				ALTROUTEGOAL_CLUSTERPORTALS |
;5166:				ALTROUTEGOAL_VIEWPORTALS);
;5167:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_blueflag
ARGP4
ADDRGP4 ctf_blueflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 16
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 16
INDIRI4
ASGNI4
line 5173
;5168:				ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5169:				ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5170:				blue_altroutegoals, MAX_ALTROUTEGOALS,
;5171:				ALTROUTEGOAL_CLUSTERPORTALS |
;5172:				ALTROUTEGOAL_VIEWPORTALS);
;5173:	} else if (gametype == GT_OBELISK) {
ADDRGP4 $2959
JUMPV
LABELV $2958
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $2968
line 5174
;5174:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2962
ARGP4
ADDRGP4 neutralobelisk
ARGP4
ADDRLP4 8
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $2970
line 5175
;5175:			BotAI_Print(PRT_WARNING, "Obelisk without neutral obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $2972
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2970
line 5177
;5176:		//
;5177:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 redobelisk
ARGP4
ADDRGP4 redobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 12
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 12
INDIRI4
ASGNI4
line 5183
;5178:				neutralobelisk.origin, neutralobelisk.areanum,
;5179:				redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5180:				red_altroutegoals, MAX_ALTROUTEGOALS,
;5181:				ALTROUTEGOAL_CLUSTERPORTALS |
;5182:				ALTROUTEGOAL_VIEWPORTALS);
;5183:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 blueobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 16
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 16
INDIRI4
ASGNI4
line 5189
;5184:				neutralobelisk.origin, neutralobelisk.areanum,
;5185:				blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5186:				blue_altroutegoals, MAX_ALTROUTEGOALS,
;5187:				ALTROUTEGOAL_CLUSTERPORTALS |
;5188:				ALTROUTEGOAL_VIEWPORTALS);
;5189:	} else if (gametype == GT_HARVESTER) {
ADDRGP4 $2969
JUMPV
LABELV $2968
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $2977
line 5190
;5190:		if (untrap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2962
ARGP4
ADDRGP4 neutralobelisk
ARGP4
ADDRLP4 8
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $2979
line 5191
;5191:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $2981
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2979
line 5193
;5192:		//
;5193:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 redobelisk
ARGP4
ADDRGP4 redobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 12
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 12
INDIRI4
ASGNI4
line 5199
;5194:				neutralobelisk.origin, neutralobelisk.areanum,
;5195:				redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5196:				red_altroutegoals, MAX_ALTROUTEGOALS,
;5197:				ALTROUTEGOAL_CLUSTERPORTALS |
;5198:				ALTROUTEGOAL_VIEWPORTALS);
;5199:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 blueobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 16
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 16
INDIRI4
ASGNI4
line 5205
;5200:				neutralobelisk.origin, neutralobelisk.areanum,
;5201:				blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5202:				blue_altroutegoals, MAX_ALTROUTEGOALS,
;5203:				ALTROUTEGOAL_CLUSTERPORTALS |
;5204:				ALTROUTEGOAL_VIEWPORTALS);
;5205:	}
LABELV $2977
LABELV $2969
LABELV $2959
LABELV $2946
line 5206
;5206:	altroutegoals_setup = qtrue;
ADDRGP4 altroutegoals_setup
CNSTI4 1
ASGNI4
line 5207
;5207:}
LABELV $2942
endproc BotSetupAlternativeRouteGoals 20 32
export BotDeathmatchAI
proc BotDeathmatchAI 1348 16
line 5214
;5208:
;5209:/*
;5210:==================
;5211:BotDeathmatchAI
;5212:==================
;5213: */
;5214:void BotDeathmatchAI(bot_state_t *bs, float thinktime) {
line 5220
;5215:	char gender[144], name[144];
;5216:	char userinfo[MAX_INFO_STRING];
;5217:	int i;
;5218:
;5219:	//if the bot has just been setup
;5220:	if (bs->setupcount > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5872
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2987
line 5221
;5221:		bs->setupcount--;
ADDRLP4 1316
ADDRFP4 0
INDIRP4
CNSTI4 5872
ADDP4
ASGNP4
ADDRLP4 1316
INDIRP4
ADDRLP4 1316
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5222
;5222:		if (bs->setupcount > 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 5872
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2989
ADDRGP4 $2986
JUMPV
LABELV $2989
line 5224
;5223:		//get the gender characteristic
;5224:		trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, sizeof (gender));
ADDRFP4 0
INDIRP4
CNSTI4 6376
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 5226
;5225:		//set the bot gender
;5226:		trap_GetUserinfo(bs->client, userinfo, sizeof (userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 5227
;5227:		Info_SetValueForKey(userinfo, "sex", gender);
ADDRLP4 148
ARGP4
ADDRGP4 $2991
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 5228
;5228:		trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 5230
;5229:		//set the chat gender
;5230:		if (gender[0] == 'm') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 109
NEI4 $2992
ADDRFP4 0
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
ADDRGP4 $2993
JUMPV
LABELV $2992
line 5231
;5231:		else if (gender[0] == 'f') trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 102
NEI4 $2994
ADDRFP4 0
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
ADDRGP4 $2995
JUMPV
LABELV $2994
line 5232
;5232:		else trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRFP4 0
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
LABELV $2995
LABELV $2993
line 5234
;5233:		//set the chat name
;5234:		ClientName(bs->client, name, sizeof (name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1172
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5235
;5235:		trap_BotSetChatName(bs->cs, name, bs->client);
ADDRLP4 1320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1320
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 1172
ARGP4
ADDRLP4 1320
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotSetChatName
CALLV
pop
line 5237
;5236:		//
;5237:		bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1324
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1324
INDIRP4
CNSTI4 5900
ADDP4
ADDRLP4 1324
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
ASGNI4
line 5238
;5238:		bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1328
INDIRP4
CNSTI4 5904
ADDP4
ADDRLP4 1328
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5240
;5239:		//
;5240:		bs->setupcount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5872
ADDP4
CNSTI4 0
ASGNI4
line 5242
;5241:		//
;5242:		BotSetupAlternativeRouteGoals();
ADDRGP4 BotSetupAlternativeRouteGoals
CALLV
pop
line 5243
;5243:	}
LABELV $2987
line 5245
;5244:	//no ideal view set
;5245:	bs->flags &= ~BFL_IDEALVIEWSET;
ADDRLP4 1316
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
ASGNP4
ADDRLP4 1316
INDIRP4
ADDRLP4 1316
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 5247
;5246:	//
;5247:	if (!BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1320
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1320
INDIRI4
CNSTI4 0
NEI4 $2996
line 5249
;5248:		//set the teleport time
;5249:		BotSetTeleportTime(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeleportTime
CALLV
pop
line 5251
;5250:		//update some inventory values
;5251:		BotUpdateInventory(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUpdateInventory
CALLV
pop
line 5253
;5252:		//check out the snapshot
;5253:		BotCheckSnapshot(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckSnapshot
CALLV
pop
line 5255
;5254:		//check for air
;5255:		BotCheckAir(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAir
CALLV
pop
line 5256
;5256:	}
LABELV $2996
line 5258
;5257:	//check the console messages
;5258:	BotCheckConsoleMessages(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckConsoleMessages
CALLV
pop
line 5260
;5259:	//if not in the intermission and not in observer mode
;5260:	if (!BotIntermission(bs) && !BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1324
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
NEI4 $2998
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1328
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 0
NEI4 $2998
line 5262
;5261:		//do team AI
;5262:		BotTeamAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamAI
CALLV
pop
line 5263
;5263:	}
LABELV $2998
line 5265
;5264:	//if the bot has no ai node
;5265:	if (!bs->ainode) {
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3000
line 5266
;5266:		AIEnter_Seek_LTG(bs, "BotDeathmatchAI: no ai node");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $3002
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 5267
;5267:	}
LABELV $3000
line 5269
;5268:	//if the bot entered the game less than 8 seconds ago
;5269:	if (!bs->entergamechat && bs->entergame_time > FloatTime() - 8) {
ADDRLP4 1332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1332
INDIRP4
CNSTI4 5880
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3003
ADDRLP4 1332
INDIRP4
CNSTI4 5920
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
SUBF4
LEF4 $3003
line 5270
;5270:		if (BotChat_EnterGame(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1336
ADDRGP4 BotChat_EnterGame
CALLI4
ASGNI4
ADDRLP4 1336
INDIRI4
CNSTI4 0
EQI4 $3005
line 5271
;5271:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1340
INDIRP4
ARGP4
ADDRLP4 1344
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1340
INDIRP4
CNSTI4 5952
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1344
INDIRF4
ADDF4
ASGNF4
line 5272
;5272:			AIEnter_Stand(bs, "BotDeathmatchAI: chat enter game");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $3007
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 5273
;5273:		}
LABELV $3005
line 5274
;5274:		bs->entergamechat = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5880
ADDP4
CNSTI4 1
ASGNI4
line 5275
;5275:	}
LABELV $3003
line 5277
;5276:	//reset the node switches from the previous frame
;5277:	BotResetNodeSwitches();
ADDRGP4 BotResetNodeSwitches
CALLV
pop
line 5279
;5278:	//execute AI nodes
;5279:	for (i = 0; i < MAX_NODESWITCHES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3008
line 5280
;5280:		if (bs->ainode(bs)) break;
ADDRLP4 1336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1336
INDIRP4
ARGP4
ADDRLP4 1340
ADDRLP4 1336
INDIRP4
CNSTI4 4756
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1340
INDIRI4
CNSTI4 0
EQI4 $3012
ADDRGP4 $3010
JUMPV
LABELV $3012
line 5281
;5281:	}
LABELV $3009
line 5279
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $3008
LABELV $3010
line 5283
;5282:	//if the bot removed itself :)
;5283:	if (!bs->inuse) return;
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $3014
ADDRGP4 $2986
JUMPV
LABELV $3014
line 5296
;5284:	//if the bot executed too many AI nodes
;5285:	//Sago: FIXME - Outcommented this test... this is wrong
;5286:#ifdef DEBUG
;5287:	if (i >= MAX_NODESWITCHES) {
;5288:		trap_BotDumpGoalStack(bs->gs);
;5289:		trap_BotDumpAvoidGoals(bs->gs);
;5290:		BotDumpNodeSwitches(bs);
;5291:		ClientName(bs->client, name, sizeof (name));
;5292:		BotAI_Print(PRT_ERROR, "%s at %1.1f switched more than %d AI nodes\n", name, FloatTime(), MAX_NODESWITCHES);
;5293:	}
;5294:#endif
;5295:	//
;5296:	bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1336
INDIRP4
CNSTI4 5900
ADDP4
ADDRLP4 1336
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
ASGNI4
line 5297
;5297:	bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1340
INDIRP4
CNSTI4 5904
ADDP4
ADDRLP4 1340
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5298
;5298:}
LABELV $2986
endproc BotDeathmatchAI 1348 16
export BotSetEntityNumForGoalWithModel
proc BotSetEntityNumForGoalWithModel 44 4
line 5305
;5299:
;5300:/*
;5301:==================
;5302:BotSetEntityNumForGoalWithModel
;5303:==================
;5304: */
;5305:void BotSetEntityNumForGoalWithModel(bot_goal_t *goal, int eType, char *modelname) {
line 5310
;5306:	gentity_t *ent;
;5307:	int i, modelindex;
;5308:	vec3_t dir;
;5309:
;5310:	modelindex = G_ModelIndex(modelname);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 5311
;5311:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5312
;5312:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $3020
JUMPV
LABELV $3017
line 5313
;5313:		if (!ent->inuse) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3022
line 5314
;5314:			continue;
ADDRGP4 $3018
JUMPV
LABELV $3022
line 5316
;5315:		}
;5316:		if (eType && ent->s.eType != eType) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $3024
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $3024
line 5317
;5317:			continue;
ADDRGP4 $3018
JUMPV
LABELV $3024
line 5319
;5318:		}
;5319:		if (ent->s.modelindex != modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $3026
line 5320
;5320:			continue;
ADDRGP4 $3018
JUMPV
LABELV $3026
line 5322
;5321:		}
;5322:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5323
;5323:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 40
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1120403456
GEF4 $3030
line 5324
;5324:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5325
;5325:			return;
ADDRGP4 $3016
JUMPV
LABELV $3030
line 5327
;5326:		}
;5327:	}
LABELV $3018
line 5312
ADDRLP4 16
ADDRLP4 16
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
LABELV $3020
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $3017
line 5328
;5328:}
LABELV $3016
endproc BotSetEntityNumForGoalWithModel 44 4
export BotSetEntityNumForGoal
proc BotSetEntityNumForGoal 36 8
line 5335
;5329:
;5330:/*
;5331:==================
;5332:BotSetEntityNumForGoal
;5333:==================
;5334: */
;5335:void BotSetEntityNumForGoal(bot_goal_t *goal, char *classname) {
line 5340
;5336:	gentity_t *ent;
;5337:	int i;
;5338:	vec3_t dir;
;5339:
;5340:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5341
;5341:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $3036
JUMPV
LABELV $3033
line 5342
;5342:		if (!ent->inuse) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3038
line 5343
;5343:			continue;
ADDRGP4 $3034
JUMPV
LABELV $3038
line 5345
;5344:		}
;5345:		if ( !Q_strequal(ent->classname, classname) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3040
line 5346
;5346:			continue;
ADDRGP4 $3034
JUMPV
LABELV $3040
line 5348
;5347:		}
;5348:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5349
;5349:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $3044
line 5350
;5350:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5351
;5351:			return;
ADDRGP4 $3032
JUMPV
LABELV $3044
line 5353
;5352:		}
;5353:	}
LABELV $3034
line 5341
ADDRLP4 16
ADDRLP4 16
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
LABELV $3036
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $3033
line 5354
;5354:}
LABELV $3032
endproc BotSetEntityNumForGoal 36 8
export BotSetEntityNumForGoalWithActivator
proc BotSetEntityNumForGoalWithActivator 40 8
line 5361
;5355:
;5356:/*
;5357:==================
;5358:BotSetEntityNumForGoalWithActivator
;5359:==================
;5360:*/
;5361:void BotSetEntityNumForGoalWithActivator(bot_goal_t *goal, char *classname) {
line 5366
;5362:	gentity_t *ent;
;5363:	int i;
;5364:	vec3_t dir;
;5365:
;5366:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5367
;5367:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $3050
JUMPV
LABELV $3047
line 5368
;5368:		if ( !ent->inuse || !ent->activator ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3054
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3052
LABELV $3054
line 5369
;5369:			continue;
ADDRGP4 $3048
JUMPV
LABELV $3052
line 5371
;5370:		}
;5371:		if ( !Q_strequal(ent->activator->classname, classname) ) {
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3055
line 5372
;5372:			continue;
ADDRGP4 $3048
JUMPV
LABELV $3055
line 5374
;5373:		}
;5374:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5375
;5375:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 1120403456
GEF4 $3059
line 5376
;5376:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5377
;5377:			return;
ADDRGP4 $3046
JUMPV
LABELV $3059
line 5379
;5378:		}
;5379:	}
LABELV $3048
line 5367
ADDRLP4 16
ADDRLP4 16
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
LABELV $3050
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $3047
line 5380
;5380:}
LABELV $3046
endproc BotSetEntityNumForGoalWithActivator 40 8
export BotGoalForBSPEntity
proc BotGoalForBSPEntity 1128 20
line 5387
;5381:
;5382:/*
;5383:==================
;5384:BotGoalForBSPEntity
;5385:==================
;5386: */
;5387:int BotGoalForBSPEntity(char *classname, bot_goal_t *goal) {
line 5392
;5388:	char value[MAX_INFO_STRING];
;5389:	vec3_t origin, start, end;
;5390:	int ent, numareas, areas[10];
;5391:
;5392:	memset(goal, 0, sizeof (bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5393
;5393:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 1108
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1108
INDIRI4
ASGNI4
ADDRGP4 $3065
JUMPV
LABELV $3062
line 5394
;5394:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", value, sizeof (value)))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2545
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $3066
line 5395
;5395:			continue;
ADDRGP4 $3063
JUMPV
LABELV $3066
line 5396
;5396:		if (strequals(value, classname)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $3068
line 5397
;5397:			if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2561
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1120
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $3070
line 5398
;5398:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3061
JUMPV
LABELV $3070
line 5399
;5399:			VectorCopy(origin, goal->origin);
ADDRFP4 4
INDIRP4
ADDRLP4 1028
INDIRB
ASGNB 12
line 5400
;5400:			VectorCopy(origin, start);
ADDRLP4 1040
ADDRLP4 1028
INDIRB
ASGNB 12
line 5401
;5401:			start[2] -= 32;
ADDRLP4 1040+8
ADDRLP4 1040+8
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 5402
;5402:			VectorCopy(origin, end);
ADDRLP4 1052
ADDRLP4 1028
INDIRB
ASGNB 12
line 5403
;5403:			end[2] += 32;
ADDRLP4 1052+8
ADDRLP4 1052+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 5404
;5404:			numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 1040
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1068
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 1124
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1124
INDIRI4
ASGNI4
line 5405
;5405:			if (!numareas)
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $3074
line 5406
;5406:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3061
JUMPV
LABELV $3074
line 5407
;5407:			goal->areanum = areas[0];
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 5408
;5408:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3061
JUMPV
LABELV $3068
line 5410
;5409:		}
;5410:	}
LABELV $3063
line 5393
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1112
INDIRI4
ASGNI4
LABELV $3065
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $3062
line 5411
;5411:	return qfalse;
CNSTI4 0
RETI4
LABELV $3061
endproc BotGoalForBSPEntity 1128 20
export BotSetupDeathmatchAI
proc BotSetupDeathmatchAI 168 16
line 5419
;5412:}
;5413:
;5414:/*
;5415:==================
;5416:BotSetupDeathmatchAI
;5417:==================
;5418: */
;5419:void BotSetupDeathmatchAI(void) {
line 5423
;5420:	int ent, modelnum, i;
;5421:	char model[128];
;5422:
;5423:	gametype = trap_Cvar_VariableIntegerValue("g_gametype");
ADDRGP4 $3077
ARGP4
ADDRLP4 140
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 gametype
ADDRLP4 140
INDIRI4
ASGNI4
line 5425
;5424:
;5425:	trap_Cvar_Register(&bot_rocketjump, "bot_rocketjump", "1", 0);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 $3078
ARGP4
ADDRGP4 $2796
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5426
;5426:	trap_Cvar_Register(&bot_grapple, "bot_grapple", "0", 0);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 $3079
ARGP4
ADDRGP4 $3080
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5427
;5427:	trap_Cvar_Register(&bot_fastchat, "bot_fastchat", "0", 0);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 $3081
ARGP4
ADDRGP4 $3080
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5428
;5428:	trap_Cvar_Register(&bot_nochat, "bot_nochat", "0", 0);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 $3082
ARGP4
ADDRGP4 $3080
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5429
;5429:	trap_Cvar_Register(&bot_testrchat, "bot_testrchat", "0", 0);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 $2795
ARGP4
ADDRGP4 $3080
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5430
;5430:	trap_Cvar_Register(&bot_challenge, "bot_challenge", "0", 0);
ADDRGP4 bot_challenge
ARGP4
ADDRGP4 $3083
ARGP4
ADDRGP4 $3080
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5431
;5431:	trap_Cvar_Register(&bot_predictobstacles, "bot_predictobstacles", "1", 0);
ADDRGP4 bot_predictobstacles
ARGP4
ADDRGP4 $3084
ARGP4
ADDRGP4 $2796
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5432
;5432:	trap_Cvar_Register(&bot_spSkill, "g_spSkill", "2", 0);
ADDRGP4 bot_spSkill
ARGP4
ADDRGP4 $3085
ARGP4
ADDRGP4 $3086
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5434
;5433:	//
;5434:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 144
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $3087
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $3087
line 5435
;5435:		if (untrap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3091
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 152
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
GEI4 $3089
line 5436
;5436:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3092
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3089
line 5437
;5437:		if (untrap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3095
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 156
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
GEI4 $3088
line 5438
;5438:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3096
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 5439
;5439:	} else if (gametype == GT_DOUBLE_D) {
ADDRGP4 $3088
JUMPV
LABELV $3087
ADDRGP4 gametype
INDIRI4
CNSTI4 11
NEI4 $3097
line 5440
;5440:		if (untrap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3091
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 152
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
GEI4 $3099
line 5441
;5441:			BotAI_Print(PRT_WARNING, "DD without Point A\n");
CNSTI4 2
ARGI4
ADDRGP4 $3101
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3099
line 5442
;5442:		if (untrap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3095
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 156
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
GEI4 $3098
line 5443
;5443:			BotAI_Print(PRT_WARNING, "DD without Point B\n");
CNSTI4 2
ARGI4
ADDRGP4 $3104
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 5444
;5444:	} else if (gametype == GT_DOMINATION) {
ADDRGP4 $3098
JUMPV
LABELV $3097
ADDRGP4 gametype
INDIRI4
CNSTI4 12
NEI4 $3105
line 5445
;5445:		ent = untrap_BotGetLevelItemGoal(-1, "Domination point", &dom_points_bot[0]);
CNSTI4 -1
ARGI4
ADDRGP4 $3107
ARGP4
ADDRGP4 dom_points_bot
ARGP4
ADDRLP4 152
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 152
INDIRI4
ASGNI4
line 5446
;5446:		if (ent < 0)
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $3108
line 5447
;5447:			BotAI_Print(PRT_WARNING, "Domination without a single domination point\n");
CNSTI4 2
ARGI4
ADDRGP4 $3110
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $3109
JUMPV
LABELV $3108
line 5449
;5448:		else
;5449:			BotSetEntityNumForGoal(&dom_points_bot[0], va("domination_point%i", 0));
ADDRGP4 $3111
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 156
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 dom_points_bot
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
LABELV $3109
line 5450
;5450:		for (i = 1; i < level.domination_points_count; i++) {
ADDRLP4 136
CNSTI4 1
ASGNI4
ADDRGP4 $3115
JUMPV
LABELV $3112
line 5452
;5451:			//Find next from the privius found entity
;5452:			ent = untrap_BotGetLevelItemGoal(ent, "Domination point", &dom_points_bot[i]);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $3107
ARGP4
CNSTI4 56
ADDRLP4 136
INDIRI4
MULI4
ADDRGP4 dom_points_bot
ADDP4
ARGP4
ADDRLP4 160
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 160
INDIRI4
ASGNI4
line 5453
;5453:			if (ent < 0)
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $3117
line 5454
;5454:				BotAI_Print(PRT_WARNING, "Domination point %i not found!\n", i);
CNSTI4 2
ARGI4
ADDRGP4 $3119
ARGP4
ADDRLP4 136
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $3118
JUMPV
LABELV $3117
line 5456
;5455:			else
;5456:				BotSetEntityNumForGoal(&dom_points_bot[0], va("domination_point%i", i));
ADDRGP4 $3111
ARGP4
ADDRLP4 136
INDIRI4
ARGI4
ADDRLP4 164
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 dom_points_bot
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
LABELV $3118
line 5457
;5457:		}
LABELV $3113
line 5450
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3115
ADDRLP4 136
INDIRI4
ADDRGP4 level+9312
INDIRI4
LTI4 $3112
line 5459
;5458:		//MAX_DOMINATION_POINTS
;5459:	} else if (gametype == GT_1FCTF) {
ADDRGP4 $3106
JUMPV
LABELV $3105
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $3120
line 5460
;5460:		if (untrap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2949
ARGP4
ADDRGP4 ctf_neutralflag
ARGP4
ADDRLP4 152
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
GEI4 $3122
line 5461
;5461:			BotAI_Print(PRT_WARNING, "One Flag CTF without Neutral Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3124
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3122
line 5462
;5462:		if (untrap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3091
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 156
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
GEI4 $3125
line 5463
;5463:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3092
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3125
line 5464
;5464:		if (untrap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3095
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 160
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
GEI4 $3121
line 5465
;5465:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3096
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 5466
;5466:	} else if (gametype == GT_OBELISK) {
ADDRGP4 $3121
JUMPV
LABELV $3120
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $3129
line 5467
;5467:		if (untrap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3133
ARGP4
ADDRGP4 redobelisk
ARGP4
ADDRLP4 152
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
GEI4 $3131
line 5468
;5468:			BotAI_Print(PRT_WARNING, "Overload without red obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3134
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3131
line 5469
;5469:		BotSetEntityNumForGoalWithActivator(&redobelisk, "team_redobelisk");
ADDRGP4 redobelisk
ARGP4
ADDRGP4 $3135
ARGP4
ADDRGP4 BotSetEntityNumForGoalWithActivator
CALLV
pop
line 5470
;5470:		if (untrap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3138
ARGP4
ADDRGP4 blueobelisk
ARGP4
ADDRLP4 156
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
GEI4 $3136
line 5471
;5471:			BotAI_Print(PRT_WARNING, "Overload without blue obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3139
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3136
line 5472
;5472:		BotSetEntityNumForGoalWithActivator(&blueobelisk, "team_blueobelisk");
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 $3140
ARGP4
ADDRGP4 BotSetEntityNumForGoalWithActivator
CALLV
pop
line 5473
;5473:	} else if (gametype == GT_HARVESTER) {
ADDRGP4 $3130
JUMPV
LABELV $3129
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $3141
line 5474
;5474:		if (untrap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3133
ARGP4
ADDRGP4 redobelisk
ARGP4
ADDRLP4 152
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
GEI4 $3143
line 5475
;5475:			BotAI_Print(PRT_WARNING, "Harvester without red obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3145
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3143
line 5476
;5476:		BotSetEntityNumForGoalWithActivator(&redobelisk, "team_redobelisk");
ADDRGP4 redobelisk
ARGP4
ADDRGP4 $3135
ARGP4
ADDRGP4 BotSetEntityNumForGoalWithActivator
CALLV
pop
line 5477
;5477:		if (untrap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3138
ARGP4
ADDRGP4 blueobelisk
ARGP4
ADDRLP4 156
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
GEI4 $3146
line 5478
;5478:			BotAI_Print(PRT_WARNING, "Harvester without blue obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3148
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3146
line 5479
;5479:		BotSetEntityNumForGoalWithActivator(&blueobelisk, "team_blueobelisk");
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 $3140
ARGP4
ADDRGP4 BotSetEntityNumForGoalWithActivator
CALLV
pop
line 5480
;5480:		if (untrap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2962
ARGP4
ADDRGP4 neutralobelisk
ARGP4
ADDRLP4 160
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
GEI4 $3149
line 5481
;5481:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $2981
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3149
line 5482
;5482:		BotSetEntityNumForGoalWithActivator(&neutralobelisk, "team_neutralobelisk");
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 $3151
ARGP4
ADDRGP4 BotSetEntityNumForGoalWithActivator
CALLV
pop
line 5483
;5483:	} else if (gametype == GT_POSSESSION) {
ADDRGP4 $3142
JUMPV
LABELV $3141
ADDRGP4 gametype
INDIRI4
CNSTI4 13
NEI4 $3152
line 5484
;5484:		if (untrap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2949
ARGP4
ADDRGP4 ctf_neutralflag
ARGP4
ADDRLP4 152
ADDRGP4 untrap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
GEI4 $3154
line 5485
;5485:			BotAI_Print(PRT_WARNING, "Possession without Neutral Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3156
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3154
line 5486
;5486:	}
LABELV $3152
LABELV $3142
LABELV $3130
LABELV $3121
LABELV $3106
LABELV $3098
LABELV $3088
line 5488
;5487:
;5488:	max_bspmodelindex = 0;
ADDRGP4 max_bspmodelindex
CNSTI4 0
ASGNI4
line 5489
;5489:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 152
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 152
INDIRI4
ASGNI4
ADDRGP4 $3160
JUMPV
LABELV $3157
line 5490
;5490:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof (model))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $584
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 156
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $3161
ADDRGP4 $3158
JUMPV
LABELV $3161
line 5491
;5491:		if (model[0] == '*') {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $3163
line 5492
;5492:			modelnum = atoi(model + 1);
ADDRLP4 4+1
ARGP4
ADDRLP4 160
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 160
INDIRI4
ASGNI4
line 5493
;5493:			if (modelnum > max_bspmodelindex)
ADDRLP4 132
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
LEI4 $3166
line 5494
;5494:				max_bspmodelindex = modelnum;
ADDRGP4 max_bspmodelindex
ADDRLP4 132
INDIRI4
ASGNI4
LABELV $3166
line 5495
;5495:		}
LABELV $3163
line 5496
;5496:	}
LABELV $3158
line 5489
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 156
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 156
INDIRI4
ASGNI4
LABELV $3160
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $3157
line 5498
;5497:	//initialize the waypoint heap
;5498:	BotInitWaypoints();
ADDRGP4 BotInitWaypoints
CALLV
pop
line 5499
;5499:}
LABELV $3076
endproc BotSetupDeathmatchAI 168 16
export BotShutdownDeathmatchAI
proc BotShutdownDeathmatchAI 0 0
line 5506
;5500:
;5501:/*
;5502:==================
;5503:BotShutdownDeathmatchAI
;5504:==================
;5505: */
;5506:void BotShutdownDeathmatchAI(void) {
line 5507
;5507:	altroutegoals_setup = qfalse;
ADDRGP4 altroutegoals_setup
CNSTI4 0
ASGNI4
line 5508
;5508:}
LABELV $3168
endproc BotShutdownDeathmatchAI 0 0
bss
export blue_numaltroutegoals
align 4
LABELV blue_numaltroutegoals
skip 4
export blue_altroutegoals
align 4
LABELV blue_altroutegoals
skip 768
export red_numaltroutegoals
align 4
LABELV red_numaltroutegoals
skip 4
export red_altroutegoals
align 4
LABELV red_altroutegoals
skip 768
export altroutegoals_setup
align 4
LABELV altroutegoals_setup
skip 4
export dom_points_bot
align 4
LABELV dom_points_bot
skip 336
export max_bspmodelindex
align 4
LABELV max_bspmodelindex
skip 4
export lastteleport_time
align 4
LABELV lastteleport_time
skip 4
export lastteleport_origin
align 4
LABELV lastteleport_origin
skip 12
import bot_developer
export bot_spSkill
align 4
LABELV bot_spSkill
skip 272
export bot_predictobstacles
align 4
LABELV bot_predictobstacles
skip 272
export botai_freewaypoints
align 4
LABELV botai_freewaypoints
skip 4
export botai_waypoints
align 4
LABELV botai_waypoints
skip 12800
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
export neutralobelisk
align 4
LABELV neutralobelisk
skip 56
export blueobelisk
align 4
LABELV blueobelisk
skip 56
export redobelisk
align 4
LABELV redobelisk
skip 56
export ctf_neutralflag
align 4
LABELV ctf_neutralflag
skip 56
export ctf_blueflag
align 4
LABELV ctf_blueflag
skip 56
export ctf_redflag
align 4
LABELV ctf_redflag
skip 56
export bot_challenge
align 4
LABELV bot_challenge
skip 272
export bot_testrchat
align 4
LABELV bot_testrchat
skip 272
export bot_nochat
align 4
LABELV bot_nochat
skip 272
export bot_fastchat
align 4
LABELV bot_fastchat
skip 272
export bot_rocketjump
align 4
LABELV bot_rocketjump
skip 272
export bot_grapple
align 4
LABELV bot_grapple
skip 272
import maxclients
export gametype
align 4
LABELV gametype
skip 4
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
LABELV $3156
byte 1 80
byte 1 111
byte 1 115
byte 1 115
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $3151
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
LABELV $3148
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3145
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3140
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
LABELV $3139
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3138
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
LABELV $3135
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
LABELV $3134
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3133
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
LABELV $3124
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $3119
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
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3111
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
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $3110
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
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
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
byte 1 10
byte 1 0
align 1
LABELV $3107
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
byte 1 0
align 1
LABELV $3104
byte 1 68
byte 1 68
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 66
byte 1 10
byte 1 0
align 1
LABELV $3101
byte 1 68
byte 1 68
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 10
byte 1 0
align 1
LABELV $3096
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $3095
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
LABELV $3092
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $3091
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
LABELV $3086
byte 1 50
byte 1 0
align 1
LABELV $3085
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $3084
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 98
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3083
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $3082
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
LABELV $3081
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $3080
byte 1 48
byte 1 0
align 1
LABELV $3079
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3078
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $3077
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
LABELV $3007
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3002
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2991
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $2981
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $2972
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $2963
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $2962
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
LABELV $2950
byte 1 78
byte 1 111
byte 1 32
byte 1 97
byte 1 108
byte 1 116
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $2949
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
LABELV $2910
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
LABELV $2907
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
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
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
byte 1 10
byte 1 0
align 1
LABELV $2868
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2865
byte 1 75
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $2864
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2861
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
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
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
byte 1 10
byte 1 0
align 1
LABELV $2807
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2800
byte 1 42
byte 1 42
byte 1 42
byte 1 42
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
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 10
byte 1 0
align 1
LABELV $2799
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $2796
byte 1 49
byte 1 0
align 1
LABELV $2795
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2671
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2670
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2666
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 111
byte 1 70
byte 1 111
byte 1 114
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $2654
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $2653
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $2650
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2639
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2626
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2620
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $2612
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $2601
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2597
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2594
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2561
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2556
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $2551
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2548
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2545
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2544
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2532
byte 1 42
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2351
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $2328
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2325
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $2225
byte 1 109
byte 1 112
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $2224
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $2223
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $2219
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1302
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
LABELV $1301
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1300
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
LABELV $1299
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
LABELV $1298
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
LABELV $1089
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1073
byte 1 116
byte 1 0
align 1
LABELV $746
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 111
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $734
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 111
byte 1 110
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $631
byte 1 93
byte 1 0
align 1
LABELV $630
byte 1 91
byte 1 0
align 1
LABELV $629
byte 1 32
byte 1 0
align 1
LABELV $597
byte 1 115
byte 1 118
byte 1 95
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
LABELV $584
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $583
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
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
byte 1 10
byte 1 0
align 1
LABELV $578
byte 1 110
byte 1 0
align 1
LABELV $577
byte 1 91
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
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
byte 1 93
byte 1 0
align 1
LABELV $576
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
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
byte 1 10
byte 1 0
align 1
LABELV $269
byte 1 111
byte 1 110
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $244
byte 1 105
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $221
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $196
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $195
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $81
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
LABELV $75
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $74
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $73
byte 1 100
byte 1 100
byte 1 0
align 1
LABELV $72
byte 1 108
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $71
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $70
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $69
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $68
byte 1 111
byte 1 110
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $67
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $66
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $65
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $64
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $63
byte 1 102
byte 1 102
byte 1 97
byte 1 0
