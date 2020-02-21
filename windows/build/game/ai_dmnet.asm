export BotResetNodeSwitches
code
proc BotResetNodeSwitches 0 0
file "../../../code/game/ai_dmnet.c"
line 74
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
;25: * name:		ai_dmnet.c
;26: *
;27: * desc:		Quake3 bot AI
;28: *
;29: * $Archive: /MissionPack/code/game/ai_dmnet.c $
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
;50://data file headers
;51:#include "chars.h"			//characteristics
;52:#include "inv.h"			//indexes into the inventory
;53:#include "syn.h"			//synonyms
;54:#include "match.h"			//string matching types and vars
;55:
;56:// for the voice chats
;57:#include "../../ui/menudef.h"
;58:
;59://goal flag, see ../botlib/be_ai_goal.h for the other GFL_*
;60:#define GFL_AIR			128
;61:
;62:int numnodeswitches;
;63:char nodeswitch[MAX_NODESWITCHES+1][144];
;64:
;65:#define LOOKAHEAD_DISTANCE			300
;66:
;67:extern bot_goal_t dom_points_bot[MAX_DOMINATION_POINTS];
;68:
;69:/*
;70:==================
;71:BotResetNodeSwitches
;72:==================
;73:*/
;74:void BotResetNodeSwitches(void) {
line 75
;75:	numnodeswitches = 0;
ADDRGP4 numnodeswitches
CNSTI4 0
ASGNI4
line 76
;76:}
LABELV $61
endproc BotResetNodeSwitches 0 0
export BotDumpNodeSwitches
proc BotDumpNodeSwitches 40 20
line 83
;77:
;78:/*
;79:==================
;80:BotDumpNodeSwitches
;81:==================
;82:*/
;83:void BotDumpNodeSwitches(bot_state_t *bs) {
line 87
;84:	int i;
;85:	char netname[MAX_NETNAME];
;86:
;87:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 88
;88:	BotAI_Print(PRT_MESSAGE, "%s at %1.1f switched more than %d AI nodes\n", netname, FloatTime(), MAX_NODESWITCHES);
CNSTI4 1
ARGI4
ADDRGP4 $63
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 floattime
INDIRF4
ARGF4
CNSTI4 50
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 89
;89:	for (i = 0; i < numnodeswitches; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $67
JUMPV
LABELV $64
line 90
;90:		BotAI_Print(PRT_MESSAGE, "%s", nodeswitch[i]);
CNSTI4 1
ARGI4
ADDRGP4 $68
ARGP4
CNSTI4 144
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 nodeswitch
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 91
;91:	}
LABELV $65
line 89
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $67
ADDRLP4 0
INDIRI4
ADDRGP4 numnodeswitches
INDIRI4
LTI4 $64
line 92
;92:	BotAI_Print(PRT_FATAL, "");
CNSTI4 4
ARGI4
ADDRGP4 $69
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 93
;93:}
LABELV $62
endproc BotDumpNodeSwitches 40 20
export BotRecordNodeSwitch
proc BotRecordNodeSwitch 44 32
line 100
;94:
;95:/*
;96:==================
;97:BotRecordNodeSwitch
;98:==================
;99:*/
;100:void BotRecordNodeSwitch(bot_state_t *bs, char *node, char *str, char *s) {
line 103
;101:	char netname[MAX_NETNAME];
;102:
;103:	ClientName(bs->client, netname, sizeof(netname));
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
line 104
;104:	Com_sprintf(nodeswitch[numnodeswitches], 144, "%s at %2.1f entered %s: %s from %s\n", netname, FloatTime(), node, str, s);
ADDRLP4 36
CNSTI4 144
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 numnodeswitches
INDIRI4
MULI4
ADDRGP4 nodeswitch
ADDP4
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 $71
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 floattime
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 110
;105:#ifdef DEBUG
;106:	if (0) {
;107:		BotAI_Print(PRT_MESSAGE, "%s", nodeswitch[numnodeswitches]);
;108:	}
;109:#endif //DEBUG
;110:	numnodeswitches++;
ADDRLP4 40
ADDRGP4 numnodeswitches
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 111
;111:}
LABELV $70
endproc BotRecordNodeSwitch 44 32
lit
align 4
LABELV $73
byte 4 3245342720
byte 4 3245342720
byte 4 3221225472
align 4
LABELV $74
byte 4 1097859072
byte 4 1097859072
byte 4 1073741824
export BotGetAirGoal
code
proc BotGetAirGoal 140 28
line 118
;112:
;113:/*
;114:==================
;115:BotGetAirGoal
;116:==================
;117:*/
;118:int BotGetAirGoal(bot_state_t *bs, bot_goal_t *goal) {
line 120
;119:	bsp_trace_t bsptrace;
;120:	vec3_t end, mins = {-15, -15, -2}, maxs = {15, 15, 2};
ADDRLP4 96
ADDRGP4 $73
INDIRB
ASGNB 12
ADDRLP4 108
ADDRGP4 $74
INDIRB
ASGNB 12
line 124
;121:	int areanum;
;122:
;123:	//trace up until we hit solid
;124:	VectorCopy(bs->origin, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
INDIRB
ASGNB 12
line 125
;125:	end[2] += 1000;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1148846080
ADDF4
ASGNF4
line 126
;126:	BotAI_Trace(&bsptrace, bs->origin, mins, maxs, end, bs->entitynum, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
ADDRLP4 12
ARGP4
ADDRLP4 124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 124
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 128
;127:	//trace down until we hit water
;128:	VectorCopy(bsptrace.endpos, end);
ADDRLP4 0
ADDRLP4 12+12
INDIRB
ASGNB 12
line 129
;129:	BotAI_Trace(&bsptrace, end, mins, maxs, bs->origin, bs->entitynum, CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA);
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 128
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 131
;130:	//if we found the water surface
;131:	if (bsptrace.fraction > 0) {
ADDRLP4 12+8
INDIRF4
CNSTF4 0
LEF4 $77
line 132
;132:		areanum = BotPointAreaNum(bsptrace.endpos);
ADDRLP4 12+12
ARGP4
ADDRLP4 132
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 120
ADDRLP4 132
INDIRI4
ASGNI4
line 133
;133:		if (areanum) {
ADDRLP4 120
INDIRI4
CNSTI4 0
EQI4 $81
line 134
;134:			VectorCopy(bsptrace.endpos, goal->origin);
ADDRFP4 4
INDIRP4
ADDRLP4 12+12
INDIRB
ASGNB 12
line 135
;135:			goal->origin[2] -= 2;
ADDRLP4 136
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 136
INDIRP4
ADDRLP4 136
INDIRP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 136
;136:			goal->areanum = areanum;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 120
INDIRI4
ASGNI4
line 137
;137:			goal->mins[0] = -15;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3245342720
ASGNF4
line 138
;138:			goal->mins[1] = -15;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3245342720
ASGNF4
line 139
;139:			goal->mins[2] = -1;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3212836864
ASGNF4
line 140
;140:			goal->maxs[0] = 15;
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1097859072
ASGNF4
line 141
;141:			goal->maxs[1] = 15;
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1097859072
ASGNF4
line 142
;142:			goal->maxs[2] = 1;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1065353216
ASGNF4
line 143
;143:			goal->flags = GFL_AIR;
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 128
ASGNI4
line 144
;144:			goal->number = 0;
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 145
;145:			goal->iteminfo = 0;
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 146
;146:			goal->entitynum = 0;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 147
;147:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $72
JUMPV
LABELV $81
line 149
;148:		}
;149:	}
LABELV $77
line 150
;150:	return qfalse;
CNSTI4 0
RETI4
LABELV $72
endproc BotGetAirGoal 140 28
export BotGoForAir
proc BotGoForAir 68 24
line 158
;151:}
;152:
;153:/*
;154:==================
;155:BotGoForAir
;156:==================
;157:*/
;158:int BotGoForAir(bot_state_t *bs, int tfl, bot_goal_t *ltg, float range) {
line 162
;159:	bot_goal_t goal;
;160:
;161:	//if the bot needs air
;162:	if (bs->lastair_time < FloatTime() - 6) {
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1086324736
SUBF4
GEF4 $85
line 168
;163:		//
;164:#ifdef DEBUG
;165:		//BotAI_Print(PRT_MESSAGE, "going for air\n");
;166:#endif //DEBUG
;167:		//if we can find an air goal
;168:		if (BotGetAirGoal(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 56
ADDRGP4 BotGetAirGoal
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $90
line 169
;169:			trap_BotPushGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotPushGoal
CALLV
pop
line 170
;170:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $84
JUMPV
line 172
;171:		}
;172:		else {
LABELV $89
line 174
;173:			//get a nearby goal outside the water
;174:			while(trap_BotChooseNBGItem(bs->gs, bs->origin, bs->inventory, tfl, ltg, range)) {
line 175
;175:				trap_BotGetTopGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotGetTopGoal
CALLI4
pop
line 177
;176:				//if the goal is not in water
;177:				if (!(trap_AAS_PointContents(goal.origin) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA))) {
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $92
line 178
;178:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $84
JUMPV
LABELV $92
line 180
;179:				}
;180:				trap_BotPopGoal(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotPopGoal
CALLV
pop
line 181
;181:			}
LABELV $90
line 174
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 4808
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 trap_BotChooseNBGItem
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $89
line 182
;182:			trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
line 183
;183:		}
line 184
;184:	}
LABELV $85
line 185
;185:	return qfalse;
CNSTI4 0
RETI4
LABELV $84
endproc BotGoForAir 68 24
export BotNearbyGoal
proc BotNearbyGoal 20 24
line 193
;186:}
;187:
;188:/*
;189:==================
;190:BotNearbyGoal
;191:==================
;192:*/
;193:int BotNearbyGoal(bot_state_t *bs, int tfl, bot_goal_t *ltg, float range) {
line 197
;194:	int ret;
;195:
;196:	//check if the bot should go for air
;197:	if (BotGoForAir(bs, tfl, ltg, range)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 BotGoForAir
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $95
CNSTI4 1
RETI4
ADDRGP4 $94
JUMPV
LABELV $95
line 199
;198:	// if the bot is carrying a flag or cubes
;199:	if (BotCTFCarryingFlag(bs)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $97
line 203
;200:#ifdef MISSIONPACK
;201:		|| Bot1FCTFCarryingFlag(bs) || BotHarvesterCarryingCubes(bs)
;202:#endif
;203:		) {
line 205
;204:		//if the bot is just a few secs away from the base 
;205:		if (trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin,
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 6492
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 16
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 300
GEI4 $99
line 206
;206:				bs->teamgoal.areanum, TFL_DEFAULT) < 300) {
line 208
;207:			//make the range really small
;208:			range = 50;
ADDRFP4 12
CNSTF4 1112014848
ASGNF4
line 209
;209:		}
LABELV $99
line 210
;210:	}
LABELV $97
line 212
;211:	//
;212:	ret = trap_BotChooseNBGItem(bs->gs, bs->origin, bs->inventory, tfl, ltg, range);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 4808
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 trap_BotChooseNBGItem
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 223
;213:	/*
;214:	if (ret)
;215:	{
;216:		char buf[128];
;217:		//get the goal at the top of the stack
;218:		trap_BotGetTopGoal(bs->gs, &goal);
;219:		trap_BotGoalName(goal.number, buf, sizeof(buf));
;220:		BotAI_Print(PRT_MESSAGE, "%1.1f: new nearby goal %s\n", FloatTime(), buf);
;221:	}
;222:    */
;223:	return ret;
ADDRLP4 0
INDIRI4
RETI4
LABELV $94
endproc BotNearbyGoal 20 24
export BotReachedGoal
proc BotReachedGoal 40 16
line 231
;224:}
;225:
;226:/*
;227:==================
;228:BotReachedGoal
;229:==================
;230:*/
;231:int BotReachedGoal(bot_state_t *bs, bot_goal_t *goal) {
line 232
;232:	if (goal->flags & GFL_ITEM) {
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $102
line 234
;233:		//if touching the goal
;234:		if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $104
line 235
;235:			if (!(goal->flags & GFL_DROPPED)) {
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $106
line 236
;236:				trap_BotSetAvoidGoalTime(bs->gs, goal->number, -1);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
CNSTF4 3212836864
ARGF4
ADDRGP4 trap_BotSetAvoidGoalTime
CALLV
pop
line 237
;237:			}
LABELV $106
line 238
;238:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $101
JUMPV
LABELV $104
line 241
;239:		}
;240:		//if the goal isn't there
;241:		if (trap_BotItemGoalInVisButNotVisible(bs->entitynum, bs->eye, bs->viewangles, goal)) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 trap_BotItemGoalInVisButNotVisible
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $108
line 253
;242:			/*
;243:			float avoidtime;
;244:			int t;
;245:
;246:			avoidtime = trap_BotAvoidGoalTime(bs->gs, goal->number);
;247:			if (avoidtime > 0) {
;248:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal->areanum, bs->tfl);
;249:				if ((float) t * 0.009 < avoidtime)
;250:					return qtrue;
;251:			}
;252:			*/
;253:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $101
JUMPV
LABELV $108
line 256
;254:		}
;255:		//if in the goal area and below or above the goal and not swimming
;256:		if (bs->areanum == goal->areanum) {
ADDRFP4 0
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $103
line 257
;257:			if (bs->origin[0] > goal->origin[0] + goal->mins[0] && bs->origin[0] < goal->origin[0] + goal->maxs[0]) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDF4
LEF4 $103
ADDRLP4 12
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
GEF4 $103
line 258
;258:				if (bs->origin[1] > goal->origin[1] + goal->mins[1] && bs->origin[1] < goal->origin[1] + goal->maxs[1]) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
LEF4 $103
ADDRLP4 24
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDF4
GEF4 $103
line 259
;259:					if (!trap_AAS_Swimming(bs->origin)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 trap_AAS_Swimming
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $103
line 260
;260:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $101
JUMPV
line 262
;261:					}
;262:				}
line 263
;263:			}
line 264
;264:		}
line 265
;265:	}
LABELV $102
line 266
;266:	else if (goal->flags & GFL_AIR) {
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $118
line 268
;267:		//if touching the goal
;268:		if (trap_BotTouchingGoal(bs->origin, goal)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $120
CNSTI4 1
RETI4
ADDRGP4 $101
JUMPV
LABELV $120
line 270
;269:		//if the bot got air
;270:		if (bs->lastair_time > FloatTime() - 1) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
LEF4 $119
CNSTI4 1
RETI4
ADDRGP4 $101
JUMPV
line 271
;271:	}
LABELV $118
line 272
;272:	else {
line 274
;273:		//if touching the goal
;274:		if (trap_BotTouchingGoal(bs->origin, goal)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $124
CNSTI4 1
RETI4
ADDRGP4 $101
JUMPV
LABELV $124
line 275
;275:	}
LABELV $119
LABELV $103
line 276
;276:	return qfalse;
CNSTI4 0
RETI4
LABELV $101
endproc BotReachedGoal 40 16
export BotGetItemLongTermGoal
proc BotGetItemLongTermGoal 20 16
line 284
;277:}
;278:
;279:/*
;280:==================
;281:BotGetItemLongTermGoal
;282:==================
;283:*/
;284:int BotGetItemLongTermGoal(bot_state_t *bs, int tfl, bot_goal_t *goal) {
line 286
;285:	//if the bot has no goal
;286:	if (!trap_BotGetTopGoal(bs->gs, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $127
line 288
;287:		//BotAI_Print(PRT_MESSAGE, "no ltg on stack\n");
;288:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
CNSTF4 0
ASGNF4
line 289
;289:	}
ADDRGP4 $128
JUMPV
LABELV $127
line 291
;290:	//if the bot touches the current goal
;291:	else if (BotReachedGoal(bs, goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotReachedGoal
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $129
line 292
;292:		BotChooseWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
line 293
;293:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
CNSTF4 0
ASGNF4
line 294
;294:	}
LABELV $129
LABELV $128
line 296
;295:	//if it is time to find a new long term goal
;296:	if (bs->ltg_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $131
line 298
;297:		//pop the current goal from the stack
;298:		trap_BotPopGoal(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotPopGoal
CALLV
pop
line 302
;299:		//BotAI_Print(PRT_MESSAGE, "%s: choosing new ltg\n", ClientName(bs->client, netname, sizeof(netname)));
;300:		//choose a new goal
;301:		//BotAI_Print(PRT_MESSAGE, "%6.1f client %d: BotChooseLTGItem\n", FloatTime(), bs->client);
;302:		if (trap_BotChooseLTGItem(bs->gs, bs->origin, bs->inventory, tfl)) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 4808
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 trap_BotChooseLTGItem
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $133
line 310
;303:			/*
;304:			char buf[128];
;305:			//get the goal at the top of the stack
;306:			trap_BotGetTopGoal(bs->gs, goal);
;307:			trap_BotGoalName(goal->number, buf, sizeof(buf));
;308:			BotAI_Print(PRT_MESSAGE, "%1.1f: new long term goal %s\n", FloatTime(), buf);
;309:            */
;310:			bs->ltg_time = FloatTime() + 20;
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 311
;311:		}
ADDRGP4 $134
JUMPV
LABELV $133
line 312
;312:		else {//the bot gets sorta stuck with all the avoid timings, shouldn't happen though
line 321
;313:			//
;314:#ifdef DEBUG
;315:			char netname[128];
;316:
;317:			BotAI_Print(PRT_MESSAGE, "%s: no valid ltg (probably stuck)\n", ClientName(bs->client, netname, sizeof(netname)));
;318:#endif
;319:			//trap_BotDumpAvoidGoals(bs->gs);
;320:			//reset the avoid goals and the avoid reach
;321:			trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
line 322
;322:			trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 323
;323:		}
LABELV $134
line 325
;324:		//get the goal at the top of the stack
;325:		return trap_BotGetTopGoal(bs->gs, goal);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $126
JUMPV
LABELV $131
line 327
;326:	}
;327:	return qtrue;
CNSTI4 1
RETI4
LABELV $126
endproc BotGetItemLongTermGoal 20 16
export BotGetLongTermGoal
proc BotGetLongTermGoal 688 20
line 338
;328:}
;329:
;330:/*
;331:==================
;332:BotGetLongTermGoal
;333:
;334:we could also create a seperate AI node for every long term goal type
;335:however this saves us a lot of code
;336:==================
;337:*/
;338:int BotGetLongTermGoal(bot_state_t *bs, int tfl, int retreat, bot_goal_t *goal) {
line 347
;339:	vec3_t target, dir, dir2;
;340:	char netname[MAX_NETNAME];
;341:	char buf[MAX_MESSAGE_SIZE];
;342:	int areanum;
;343:	float croucher;
;344:	aas_entityinfo_t entinfo, botinfo;
;345:	bot_waypoint_t *wp;
;346:
;347:	if (bs->ltgtype == LTG_TEAMHELP && !retreat) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 1
NEI4 $136
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $136
line 349
;348:		//check for bot typing status message
;349:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 620
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 620
INDIRF4
CNSTF4 0
EQF4 $138
ADDRLP4 620
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $138
line 350
;350:			BotAI_BotInitialChat(bs, "help_start", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 412
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 624
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $140
ARGP4
ADDRLP4 624
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 351
;351:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 628
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 352
;352:			BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
ADDRLP4 632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 632
INDIRP4
ARGP4
ADDRLP4 632
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
ADDRGP4 $141
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 353
;353:			trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
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
line 354
;354:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 355
;355:		}
LABELV $138
line 357
;356:		//if trying to help the team mate for more than a minute
;357:		if (bs->teamgoal_time < FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $142
line 358
;358:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
LABELV $142
line 360
;359:		//if the team mate IS visible for quite some time
;360:		if (bs->teammatevisible_time < FloatTime() - 10) bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
SUBF4
GEF4 $144
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
LABELV $144
line 362
;361:		//get entity information of the companion
;362:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 272
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 364
;363:		//if the team mate is visible
;364:		if (BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->teammate)) {
ADDRLP4 624
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 624
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 624
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 624
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 624
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 628
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 628
INDIRF4
CNSTF4 0
EQF4 $146
line 366
;365:			//if close just stand still there
;366:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 272+24
INDIRF4
ADDRLP4 632
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 272+24+4
INDIRF4
ADDRLP4 632
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 272+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 367
;367:			if (VectorLengthSquared(dir) < Square(100)) {
ADDRLP4 4
ARGP4
ADDRLP4 636
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 636
INDIRF4
CNSTF4 1176256512
GEF4 $147
line 368
;368:				trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 369
;369:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
line 371
;370:			}
;371:		}
LABELV $146
line 372
;372:		else {
line 374
;373:			//last time the bot was NOT visible
;374:			bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 375
;375:		}
LABELV $147
line 377
;376:		//if the entity information is valid (entity in PVS)
;377:		if (entinfo.valid) {
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $157
line 378
;378:			areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 272+24
ARGP4
ADDRLP4 632
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 448
ADDRLP4 632
INDIRI4
ASGNI4
line 379
;379:			if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 636
ADDRLP4 448
INDIRI4
ASGNI4
ADDRLP4 636
INDIRI4
CNSTI4 0
EQI4 $160
ADDRLP4 636
INDIRI4
ARGI4
ADDRLP4 640
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 640
INDIRI4
CNSTI4 0
EQI4 $160
line 381
;380:				//update team goal
;381:				bs->teamgoal.entitynum = bs->teammate;
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 644
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ASGNI4
line 382
;382:				bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6492
ADDP4
ADDRLP4 448
INDIRI4
ASGNI4
line 383
;383:				VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ADDRLP4 272+24
INDIRB
ASGNB 12
line 384
;384:				VectorSet(bs->teamgoal.mins, -8, -8, -8);
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
line 385
;385:				VectorSet(bs->teamgoal.maxs, 8, 8, 8);
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
line 386
;386:			}
LABELV $160
line 387
;387:		}
LABELV $157
line 388
;388:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 389
;389:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $136
line 392
;390:	}
;391:	//if the bot accompanies someone
;392:	if (bs->ltgtype == LTG_TEAMACCOMPANY && !retreat) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 2
NEI4 $163
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $163
line 394
;393:		//check for bot typing status message
;394:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 620
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 620
INDIRF4
CNSTF4 0
EQF4 $165
ADDRLP4 620
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $165
line 395
;395:			BotAI_BotInitialChat(bs, "accompany_start", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 412
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 624
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $167
ARGP4
ADDRLP4 624
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 396
;396:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 628
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 397
;397:			BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
ADDRLP4 632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 632
INDIRP4
ARGP4
ADDRLP4 632
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
ADDRGP4 $141
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 398
;398:			trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
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
line 399
;399:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 400
;400:		}
LABELV $165
line 402
;401:		//if accompanying the companion for 3 minutes
;402:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $168
line 403
;403:			BotAI_BotInitialChat(bs, "accompany_stop", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 412
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 624
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 624
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 404
;404:			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 628
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 405
;405:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 406
;406:		}
LABELV $168
line 408
;407:		//get entity information of the companion
;408:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 272
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 410
;409:		//if the companion is visible
;410:		if (BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->teammate)) {
ADDRLP4 624
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 624
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 624
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 624
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 624
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 628
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 628
INDIRF4
CNSTF4 0
EQF4 $171
line 412
;411:			//update visible time
;412:			bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 413
;413:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 272+24
INDIRF4
ADDRLP4 632
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 272+24+4
INDIRF4
ADDRLP4 632
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 272+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 414
;414:			if (VectorLengthSquared(dir) < Square(bs->formation_dist)) {
ADDRLP4 4
ARGP4
ADDRLP4 636
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 640
ADDRFP4 0
INDIRP4
CNSTI4 6872
ADDP4
INDIRF4
ASGNF4
ADDRLP4 636
INDIRF4
ADDRLP4 640
INDIRF4
ADDRLP4 640
INDIRF4
MULF4
GEF4 $180
line 418
;415:				//
;416:				// if the client being followed bumps into this bot then
;417:				// the bot should back up
;418:				BotEntityInfo(bs->entitynum, &botinfo);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 452
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 420
;419:				// if the followed client is not standing ontop of the bot
;420:				if (botinfo.origin[2] + botinfo.maxs[2] > entinfo.origin[2] + entinfo.mins[2]) {
ADDRLP4 452+24+8
INDIRF4
ADDRLP4 452+84+8
INDIRF4
ADDF4
ADDRLP4 272+24+8
INDIRF4
ADDRLP4 272+72+8
INDIRF4
ADDF4
LEF4 $182
line 422
;421:					// if the bounding boxes touch each other
;422:					if (botinfo.origin[0] + botinfo.maxs[0] > entinfo.origin[0] + entinfo.mins[0] - 4&&
ADDRLP4 644
CNSTF4 1082130432
ASGNF4
ADDRLP4 452+24
INDIRF4
ADDRLP4 452+84
INDIRF4
ADDF4
ADDRLP4 272+24
INDIRF4
ADDRLP4 272+72
INDIRF4
ADDF4
ADDRLP4 644
INDIRF4
SUBF4
LEF4 $192
ADDRLP4 452+24
INDIRF4
ADDRLP4 452+72
INDIRF4
ADDF4
ADDRLP4 272+24
INDIRF4
ADDRLP4 272+84
INDIRF4
ADDF4
ADDRLP4 644
INDIRF4
ADDF4
GEF4 $192
line 423
;423:						botinfo.origin[0] + botinfo.mins[0] < entinfo.origin[0] + entinfo.maxs[0] + 4) {
line 424
;424:						if (botinfo.origin[1] + botinfo.maxs[1] > entinfo.origin[1] + entinfo.mins[1] - 4 &&
ADDRLP4 648
CNSTF4 1082130432
ASGNF4
ADDRLP4 452+24+4
INDIRF4
ADDRLP4 452+84+4
INDIRF4
ADDF4
ADDRLP4 272+24+4
INDIRF4
ADDRLP4 272+72+4
INDIRF4
ADDF4
ADDRLP4 648
INDIRF4
SUBF4
LEF4 $202
ADDRLP4 452+24+4
INDIRF4
ADDRLP4 452+72+4
INDIRF4
ADDF4
ADDRLP4 272+24+4
INDIRF4
ADDRLP4 272+84+4
INDIRF4
ADDF4
ADDRLP4 648
INDIRF4
ADDF4
GEF4 $202
line 425
;425:							botinfo.origin[1] + botinfo.mins[1] < entinfo.origin[1] + entinfo.maxs[1] + 4) {
line 426
;426:							if (botinfo.origin[2] + botinfo.maxs[2] > entinfo.origin[2] + entinfo.mins[2] - 4 &&
ADDRLP4 652
CNSTF4 1082130432
ASGNF4
ADDRLP4 452+24+8
INDIRF4
ADDRLP4 452+84+8
INDIRF4
ADDF4
ADDRLP4 272+24+8
INDIRF4
ADDRLP4 272+72+8
INDIRF4
ADDF4
ADDRLP4 652
INDIRF4
SUBF4
LEF4 $220
ADDRLP4 452+24+8
INDIRF4
ADDRLP4 452+72+8
INDIRF4
ADDF4
ADDRLP4 272+24+8
INDIRF4
ADDRLP4 272+84+8
INDIRF4
ADDF4
ADDRLP4 652
INDIRF4
ADDF4
GEF4 $220
line 427
;427:								botinfo.origin[2] + botinfo.mins[2] < entinfo.origin[2] + entinfo.maxs[2] + 4) {
line 429
;428:								// if the followed client looks in the direction of this bot
;429:								AngleVectors(entinfo.angles, dir, NULL, NULL);
ADDRLP4 272+36
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 656
CNSTP4 0
ASGNP4
ADDRLP4 656
INDIRP4
ARGP4
ADDRLP4 656
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 430
;430:								dir[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 431
;431:								VectorNormalize(dir);
ADDRLP4 4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 433
;432:								//VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
;433:								VectorSubtract(bs->origin, entinfo.origin, dir2);
ADDRLP4 660
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 608
ADDRLP4 660
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRLP4 272+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 608+4
ADDRLP4 660
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRLP4 272+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 608+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRLP4 272+24+8
INDIRF4
SUBF4
ASGNF4
line 434
;434:								VectorNormalize(dir2);
ADDRLP4 608
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 435
;435:								if (DotProduct(dir, dir2) > 0.7) {
ADDRLP4 4
INDIRF4
ADDRLP4 608
INDIRF4
MULF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 608+4
INDIRF4
MULF4
ADDF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 608+8
INDIRF4
MULF4
ADDF4
CNSTF4 1060320051
LEF4 $247
line 437
;436:									// back up
;437:									BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 438
;438:									trap_BotMoveInDirection(bs->ms, dir2, 400, MOVE_WALK);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 608
ARGP4
CNSTF4 1137180672
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 439
;439:								}
LABELV $247
line 440
;440:							}
LABELV $220
line 441
;441:						}
LABELV $202
line 442
;442:					}
LABELV $192
line 443
;443:				}
LABELV $182
line 446
;444:				//check if the bot wants to crouch
;445:				//don't crouch if crouched less than 5 seconds ago
;446:				if (bs->attackcrouch_time < FloatTime() - 5) {
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
GEF4 $253
line 447
;447:					croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 0
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
ADDRLP4 644
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 604
ADDRLP4 644
INDIRF4
ASGNF4
line 448
;448:					if (random() < bs->thinktime * croucher) {
ADDRLP4 648
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 648
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
GEF4 $255
line 449
;449:						bs->attackcrouch_time = FloatTime() + 5 + croucher * 15;
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CNSTF4 1097859072
ADDRLP4 604
INDIRF4
MULF4
ADDF4
ASGNF4
line 450
;450:					}
LABELV $255
line 451
;451:				}
LABELV $253
line 453
;452:				//don't crouch when swimming
;453:				if (trap_AAS_Swimming(bs->origin)) bs->attackcrouch_time = FloatTime() - 1;
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 644
ADDRGP4 trap_AAS_Swimming
CALLI4
ASGNI4
ADDRLP4 644
INDIRI4
CNSTI4 0
EQI4 $257
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
LABELV $257
line 455
;454:				//if not arrived yet or arived some time ago
;455:				if (bs->arrive_time < FloatTime() - 2) {
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $259
line 457
;456:					//if not arrived yet
;457:					if (!bs->arrive_time) {
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
INDIRF4
CNSTF4 0
NEF4 $261
line 458
;458:						trap_EA_Gesture(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Gesture
CALLV
pop
line 459
;459:						BotAI_BotInitialChat(bs, "accompany_arrive", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 412
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 648
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $263
ARGP4
ADDRLP4 648
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 460
;460:						trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 652
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 652
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 652
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 461
;461:						bs->arrive_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 462
;462:					}
ADDRGP4 $262
JUMPV
LABELV $261
line 464
;463:					//if the bot wants to crouch
;464:					else if (bs->attackcrouch_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $264
line 465
;465:						trap_EA_Crouch(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Crouch
CALLV
pop
line 466
;466:					}
ADDRGP4 $265
JUMPV
LABELV $264
line 468
;467:					//else do some model taunts
;468:					else if (random() < bs->thinktime * 0.05) {
ADDRLP4 648
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 648
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1028443341
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
MULF4
GEF4 $266
line 470
;469:						//do a gesture :)
;470:						trap_EA_Gesture(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Gesture
CALLV
pop
line 471
;471:					}
LABELV $266
LABELV $265
LABELV $262
line 472
;472:				}
LABELV $259
line 474
;473:				//if just arrived look at the companion
;474:				if (bs->arrive_time > FloatTime() - 2) {
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $268
line 475
;475:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 648
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 272+24
INDIRF4
ADDRLP4 648
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 272+24+4
INDIRF4
ADDRLP4 648
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 272+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 476
;476:					vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 477
;477:					bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 652
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 652
INDIRP4
CNSTF4 1056964608
ADDRLP4 652
INDIRP4
INDIRF4
MULF4
ASGNF4
line 478
;478:				}
ADDRGP4 $269
JUMPV
LABELV $268
line 480
;479:				//else look strategically around for enemies
;480:				else if (random() < bs->thinktime * 0.8) {
ADDRLP4 648
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 648
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
MULF4
GEF4 $277
line 481
;481:					BotRoamGoal(bs, target);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 592
ARGP4
ADDRGP4 BotRoamGoal
CALLV
pop
line 482
;482:					VectorSubtract(target, bs->origin, dir);
ADDRLP4 652
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 592
INDIRF4
ADDRLP4 652
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 592+4
INDIRF4
ADDRLP4 652
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 592+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 483
;483:					vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 484
;484:					bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 656
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 656
INDIRP4
CNSTF4 1056964608
ADDRLP4 656
INDIRP4
INDIRF4
MULF4
ASGNF4
line 485
;485:				}
LABELV $277
LABELV $269
line 487
;486:				//check if the bot wants to go for air
;487:				if (BotGoForAir(bs, bs->tfl, &bs->teamgoal, 400)) {
ADDRLP4 652
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 652
INDIRP4
ARGP4
ADDRLP4 652
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRLP4 652
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 656
ADDRGP4 BotGoForAir
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $283
line 488
;488:					trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 494
;489:					//get the goal at the top of the stack
;490:					//trap_BotGetTopGoal(bs->gs, &tmpgoal);
;491:					//trap_BotGoalName(tmpgoal.number, buf, 144);
;492:					//BotAI_Print(PRT_MESSAGE, "new nearby goal %s\n", buf);
;493:					//time the bot gets to pick up the nearby goal item
;494:					bs->nbg_time = FloatTime() + 8;
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 495
;495:					AIEnter_Seek_NBG(bs, "BotLongTermGoal: go for air");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $285
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 496
;496:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $283
line 499
;497:				}
;498:				//
;499:				trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 500
;500:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $180
line 502
;501:			}
;502:		}
LABELV $171
line 504
;503:		//if the entity information is valid (entity in PVS)
;504:		if (entinfo.valid) {
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $286
line 505
;505:			areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 272+24
ARGP4
ADDRLP4 632
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 448
ADDRLP4 632
INDIRI4
ASGNI4
line 506
;506:			if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 636
ADDRLP4 448
INDIRI4
ASGNI4
ADDRLP4 636
INDIRI4
CNSTI4 0
EQI4 $289
ADDRLP4 636
INDIRI4
ARGI4
ADDRLP4 640
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 640
INDIRI4
CNSTI4 0
EQI4 $289
line 508
;507:				//update team goal
;508:				bs->teamgoal.entitynum = bs->teammate;
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 644
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ASGNI4
line 509
;509:				bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6492
ADDP4
ADDRLP4 448
INDIRI4
ASGNI4
line 510
;510:				VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ADDRLP4 272+24
INDIRB
ASGNB 12
line 511
;511:				VectorSet(bs->teamgoal.mins, -8, -8, -8);
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
line 512
;512:				VectorSet(bs->teamgoal.maxs, 8, 8, 8);
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
line 513
;513:			}
LABELV $289
line 514
;514:		}
LABELV $286
line 516
;515:		//the goal the bot should go for
;516:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 518
;517:		//if the companion is NOT visible for too long
;518:		if (bs->teammatevisible_time < FloatTime() - 60) {
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
SUBF4
GEF4 $292
line 519
;519:			BotAI_BotInitialChat(bs, "accompany_cannotfind", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 412
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 632
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $294
ARGP4
ADDRLP4 632
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 520
;520:			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 636
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 636
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 521
;521:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 523
;522:			// just to make sure the bot won't spam this message
;523:			bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 524
;524:		}
LABELV $292
line 525
;525:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $163
line 528
;526:	}
;527:	//
;528:	if (bs->ltgtype == LTG_DEFENDKEYAREA) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 3
NEI4 $295
line 529
;529:		if (trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin,
ADDRLP4 620
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 620
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ARGI4
ADDRLP4 620
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 620
INDIRP4
CNSTI4 6492
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 624
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 624
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
INDIRF4
LEF4 $297
line 530
;530:				bs->teamgoal.areanum, TFL_DEFAULT) > bs->defendaway_range) {
line 531
;531:			bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
CNSTF4 0
ASGNF4
line 532
;532:		}
LABELV $297
line 533
;533:	}
LABELV $295
line 535
;534:	//For double domination
;535:	if (bs->ltgtype == LTG_POINTA &&
ADDRLP4 620
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 620
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 16
NEI4 $299
ADDRLP4 620
INDIRP4
CNSTI4 6000
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $299
line 536
;536:				bs->defendaway_time < FloatTime()) {
line 538
;537:		//check for bot typing status message
;538:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 624
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 624
INDIRF4
CNSTF4 0
EQF4 $301
ADDRLP4 624
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $301
line 539
;539:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 540
;540:			BotAI_BotInitialChat(bs, "dd_start_pointa", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $303
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 541
;541:			trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 543
;542:			//BotVoiceChatOnly(bs, -1, VOICECHAT_ONDEFENSE);
;543:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 544
;544:		}
LABELV $301
line 546
;545:		//set the bot goal
;546:		memcpy(goal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 548
;547:		//if very close... go away for some time
;548:		VectorSubtract(goal->origin, bs->origin, dir);
ADDRLP4 628
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 632
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 628
INDIRP4
INDIRF4
ADDRLP4 632
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 628
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 632
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 549
;549:		if (VectorLengthSquared(dir) < Square(70)) {
ADDRLP4 4
ARGP4
ADDRLP4 636
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 636
INDIRF4
CNSTF4 1167663104
GEF4 $306
line 550
;550:			trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 551
;551:			bs->defendaway_time = FloatTime() + 3 + 3 * random();
ADDRLP4 640
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 644
CNSTF4 1077936128
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 644
INDIRF4
ADDF4
ADDRLP4 644
INDIRF4
ADDRLP4 640
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 552
;552:			if (BotHasPersistantPowerupAndWeapon(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 648
ADDRGP4 BotHasPersistantPowerupAndWeapon
CALLI4
ASGNI4
ADDRLP4 648
INDIRI4
CNSTI4 0
EQI4 $308
line 553
;553:				bs->defendaway_range = 100;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
CNSTF4 1120403456
ASGNF4
line 554
;554:			}
ADDRGP4 $309
JUMPV
LABELV $308
line 555
;555:			else {
line 556
;556:				bs->defendaway_range = 350;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
CNSTF4 1135542272
ASGNF4
line 557
;557:			}
LABELV $309
line 558
;558:		}
LABELV $306
line 559
;559:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $299
line 561
;560:	}
;561:	if (bs->ltgtype == LTG_POINTB &&
ADDRLP4 624
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 624
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 17
NEI4 $310
ADDRLP4 624
INDIRP4
CNSTI4 6000
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $310
line 562
;562:				bs->defendaway_time < FloatTime()) {
line 564
;563:		//check for bot typing status message
;564:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 628
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 628
INDIRF4
CNSTF4 0
EQF4 $312
ADDRLP4 628
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $312
line 565
;565:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 566
;566:			BotAI_BotInitialChat(bs, "dd_start_pointb", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $314
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 567
;567:			trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 569
;568:			//BotVoiceChatOnly(bs, -1, VOICECHAT_ONDEFENSE);
;569:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 570
;570:		}
LABELV $312
line 572
;571:		//set the bot goal
;572:		memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 574
;573:		//if very close... go away for some time
;574:		VectorSubtract(goal->origin, bs->origin, dir);
ADDRLP4 632
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 632
INDIRP4
INDIRF4
ADDRLP4 636
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 632
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 636
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 575
;575:		if (VectorLengthSquared(dir) < Square(70)) {
ADDRLP4 4
ARGP4
ADDRLP4 640
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 640
INDIRF4
CNSTF4 1167663104
GEF4 $317
line 576
;576:			trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 577
;577:			bs->defendaway_time = FloatTime() + 3 + 3 * random();
ADDRLP4 644
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 648
CNSTF4 1077936128
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 648
INDIRF4
ADDF4
ADDRLP4 648
INDIRF4
ADDRLP4 644
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 578
;578:			if (BotHasPersistantPowerupAndWeapon(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 652
ADDRGP4 BotHasPersistantPowerupAndWeapon
CALLI4
ASGNI4
ADDRLP4 652
INDIRI4
CNSTI4 0
EQI4 $319
line 579
;579:				bs->defendaway_range = 100;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
CNSTF4 1120403456
ASGNF4
line 580
;580:			}
ADDRGP4 $320
JUMPV
LABELV $319
line 581
;581:			else {
line 582
;582:				bs->defendaway_range = 350;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
CNSTF4 1135542272
ASGNF4
line 583
;583:			}
LABELV $320
line 584
;584:		}
LABELV $317
line 585
;585:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $310
line 619
;586:	}
;587:        //if (bs->ltgtype == LTG_DOMHOLD &&
;588:	//			bs->defendaway_time < FloatTime()) {
;589:            //check for bot typing status message
;590:		/*if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
;591:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
;592:			BotAI_BotInitialChat(bs, "dd_start_pointb", buf, NULL);
;593:			trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;594:			//BotVoiceChatOnly(bs, -1, VOICECHAT_ONDEFENSE);
;595:			bs->teammessage_time = 0;
;596:		}*/
;597:		//set the bot goal
;598:	//	memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
;599:		//if very close... go away for some time
;600:	//	VectorSubtract(goal->origin, bs->origin, dir);
;601:	//	if (VectorLengthSquared(dir) < Square(30)) {
;602:			/*trap_BotResetAvoidReach(bs->ms);
;603:			bs->defendaway_time = FloatTime() + 3 + 3 * random();
;604:			if (BotHasPersistantPowerupAndWeapon(bs)) {
;605:				bs->defendaway_range = 100;
;606:			}
;607:			else {
;608:				bs->defendaway_range = 350;
;609:			}*/
;610:          //              memcpy(&bs->teamgoal, &dom_points_bot[((rand()) % (level.domination_points_count))], sizeof(bot_goal_t));
;611:            //            BotAlternateRoute(bs, &bs->teamgoal);
;612:              //          BotSetTeamStatus(bs);
;613:
;614:		//}
;615:		//return qtrue;
;616:
;617:       // }
;618:	//if defending a key area
;619:	if (bs->ltgtype == LTG_DEFENDKEYAREA && !retreat &&
ADDRLP4 628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 628
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 3
NEI4 $321
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $321
ADDRLP4 628
INDIRP4
CNSTI4 6000
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $321
line 620
;620:				bs->defendaway_time < FloatTime()) {
line 622
;621:		//check for bot typing status message
;622:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 632
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 632
INDIRF4
CNSTF4 0
EQF4 $323
ADDRLP4 632
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $323
line 623
;623:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 624
;624:			BotAI_BotInitialChat(bs, "defend_start", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $325
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 625
;625:			trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 626
;626:			BotVoiceChatOnly(bs, -1, VOICECHAT_ONDEFENSE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $326
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 627
;627:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 628
;628:		}
LABELV $323
line 630
;629:		//set the bot goal
;630:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 632
;631:		//stop after 2 minutes
;632:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $327
line 633
;633:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 634
;634:			BotAI_BotInitialChat(bs, "defend_stop", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $329
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 635
;635:			trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 636
;636:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 637
;637:		}
LABELV $327
line 639
;638:		//if very close... go away for some time
;639:		VectorSubtract(goal->origin, bs->origin, dir);
ADDRLP4 636
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 636
INDIRP4
INDIRF4
ADDRLP4 640
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 636
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 640
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 640
;640:		if (VectorLengthSquared(dir) < Square(70)) {
ADDRLP4 4
ARGP4
ADDRLP4 644
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 644
INDIRF4
CNSTF4 1167663104
GEF4 $332
line 641
;641:			trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 642
;642:			bs->defendaway_time = FloatTime() + 3 + 3 * random();
ADDRLP4 648
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 652
CNSTF4 1077936128
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 652
INDIRF4
ADDF4
ADDRLP4 652
INDIRF4
ADDRLP4 648
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 643
;643:			if (BotHasPersistantPowerupAndWeapon(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 656
ADDRGP4 BotHasPersistantPowerupAndWeapon
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $334
line 644
;644:				bs->defendaway_range = 100;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
CNSTF4 1120403456
ASGNF4
line 645
;645:			}
ADDRGP4 $335
JUMPV
LABELV $334
line 646
;646:			else {
line 647
;647:				bs->defendaway_range = 350;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
CNSTF4 1135542272
ASGNF4
line 648
;648:			}
LABELV $335
line 649
;649:		}
LABELV $332
line 650
;650:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $321
line 653
;651:	}
;652:	//going to kill someone
;653:	if (bs->ltgtype == LTG_KILL && !retreat) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 11
NEI4 $336
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $336
line 655
;654:		//check for bot typing status message
;655:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 632
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 632
INDIRF4
CNSTF4 0
EQF4 $338
ADDRLP4 632
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $338
line 656
;656:			EasyClientName(bs->teamgoal.entitynum, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 657
;657:			BotAI_BotInitialChat(bs, "kill_start", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $340
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 658
;658:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 636
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 636
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 659
;659:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 660
;660:		}
LABELV $338
line 662
;661:		//
;662:		if (bs->killedenemy_time > bs->teamgoal_time - TEAM_KILL_SOMEONE && bs->lastkilledplayer == bs->teamgoal.entitynum) {
ADDRLP4 636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 636
INDIRP4
CNSTI4 6024
ADDP4
INDIRF4
ADDRLP4 636
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
CNSTF4 1127481344
SUBF4
LEF4 $341
ADDRLP4 636
INDIRP4
CNSTI4 5848
ADDP4
INDIRI4
ADDRLP4 636
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
NEI4 $341
line 663
;663:			EasyClientName(bs->teamgoal.entitynum, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 664
;664:			BotAI_BotInitialChat(bs, "kill_done", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $343
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 665
;665:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 640
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 640
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 666
;666:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 667
;667:		}
LABELV $341
line 669
;668:		//
;669:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $344
line 670
;670:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 671
;671:		}
LABELV $344
line 673
;672:		//just roam around
;673:		return BotGetItemLongTermGoal(bs, tfl, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 640
ADDRGP4 BotGetItemLongTermGoal
CALLI4
ASGNI4
ADDRLP4 640
INDIRI4
RETI4
ADDRGP4 $135
JUMPV
LABELV $336
line 676
;674:	}
;675:	//get an item
;676:	if (bs->ltgtype == LTG_GETITEM && !retreat) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 10
NEI4 $346
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $346
line 678
;677:		//check for bot typing status message
;678:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 632
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 632
INDIRF4
CNSTF4 0
EQF4 $348
ADDRLP4 632
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $348
line 679
;679:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 680
;680:			BotAI_BotInitialChat(bs, "getitem_start", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $350
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 681
;681:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 636
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 636
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 682
;682:			BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 640
INDIRP4
ARGP4
ADDRLP4 640
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
ADDRGP4 $141
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 683
;683:			trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
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
line 684
;684:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 685
;685:		}
LABELV $348
line 687
;686:		//set the bot goal
;687:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 689
;688:		//stop after some time
;689:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $351
line 690
;690:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 691
;691:		}
LABELV $351
line 693
;692:		//
;693:		if (trap_BotItemGoalInVisButNotVisible(bs->entitynum, bs->eye, bs->viewangles, goal)) {
ADDRLP4 636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 636
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 636
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 636
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 640
ADDRGP4 trap_BotItemGoalInVisButNotVisible
CALLI4
ASGNI4
ADDRLP4 640
INDIRI4
CNSTI4 0
EQI4 $353
line 694
;694:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 695
;695:			BotAI_BotInitialChat(bs, "getitem_notthere", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $355
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 696
;696:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 644
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 697
;697:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 698
;698:		}
ADDRGP4 $354
JUMPV
LABELV $353
line 699
;699:		else if (BotReachedGoal(bs, goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 644
ADDRGP4 BotReachedGoal
CALLI4
ASGNI4
ADDRLP4 644
INDIRI4
CNSTI4 0
EQI4 $356
line 700
;700:			trap_BotGoalName(bs->teamgoal.number, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 701
;701:			BotAI_BotInitialChat(bs, "getitem_gotit", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $358
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 702
;702:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 648
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 648
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 648
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 703
;703:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 704
;704:		}
LABELV $356
LABELV $354
line 705
;705:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $346
line 708
;706:	}
;707:	//if camping somewhere
;708:	if ((bs->ltgtype == LTG_CAMP || bs->ltgtype == LTG_CAMPORDER) && !retreat) {
ADDRLP4 632
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
ASGNI4
ADDRLP4 632
INDIRI4
CNSTI4 7
EQI4 $361
ADDRLP4 632
INDIRI4
CNSTI4 8
NEI4 $359
LABELV $361
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $359
line 710
;709:		//check for bot typing status message
;710:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 636
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 636
INDIRF4
CNSTF4 0
EQF4 $362
ADDRLP4 636
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $362
line 711
;711:			if (bs->ltgtype == LTG_CAMPORDER) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 8
NEI4 $364
line 712
;712:				BotAI_BotInitialChat(bs, "camp_start", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 412
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 640
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $366
ARGP4
ADDRLP4 640
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 713
;713:				trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 644
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 714
;714:				BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
ADDRLP4 648
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 648
INDIRP4
ARGP4
ADDRLP4 648
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
ADDRGP4 $141
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 715
;715:				trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
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
line 716
;716:			}
LABELV $364
line 717
;717:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 718
;718:		}
LABELV $362
line 720
;719:		//set the bot goal
;720:		memcpy(goal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 722
;721:		//
;722:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $367
line 723
;723:			if (bs->ltgtype == LTG_CAMPORDER) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 8
NEI4 $369
line 724
;724:				BotAI_BotInitialChat(bs, "camp_stop", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $371
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 725
;725:				trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 640
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 640
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 726
;726:			}
LABELV $369
line 727
;727:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 728
;728:		}
LABELV $367
line 730
;729:		//if really near the camp spot
;730:		VectorSubtract(goal->origin, bs->origin, dir);
ADDRLP4 640
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 640
INDIRP4
INDIRF4
ADDRLP4 644
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 640
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 644
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 731
;731:		if (VectorLengthSquared(dir) < Square(60))
ADDRLP4 4
ARGP4
ADDRLP4 648
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 648
INDIRF4
CNSTF4 1163984896
GEF4 $374
line 732
;732:		{
line 734
;733:			//if not arrived yet
;734:			if (!bs->arrive_time) {
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
INDIRF4
CNSTF4 0
NEF4 $376
line 735
;735:				if (bs->ltgtype == LTG_CAMPORDER) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 8
NEI4 $378
line 736
;736:					BotAI_BotInitialChat(bs, "camp_arrive", EasyClientName(bs->teammate, netname, sizeof(netname)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
ADDRLP4 412
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 652
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRLP4 652
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 737
;737:					trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 656
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 656
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 656
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 738
;738:					BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_INPOSITION);
ADDRLP4 660
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 660
INDIRP4
ARGP4
ADDRLP4 660
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
ADDRGP4 $381
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 739
;739:				}
LABELV $378
line 740
;740:				bs->arrive_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 741
;741:			}
LABELV $376
line 743
;742:			//look strategically around for enemies
;743:			if (random() < bs->thinktime * 0.8) {
ADDRLP4 652
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 652
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
MULF4
GEF4 $382
line 744
;744:				BotRoamGoal(bs, target);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 592
ARGP4
ADDRGP4 BotRoamGoal
CALLV
pop
line 745
;745:				VectorSubtract(target, bs->origin, dir);
ADDRLP4 656
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 592
INDIRF4
ADDRLP4 656
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 592+4
INDIRF4
ADDRLP4 656
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 592+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 746
;746:				vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 747
;747:				bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 660
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 660
INDIRP4
CNSTF4 1056964608
ADDRLP4 660
INDIRP4
INDIRF4
MULF4
ASGNF4
line 748
;748:			}
LABELV $382
line 751
;749:			//check if the bot wants to crouch
;750:			//don't crouch if crouched less than 5 seconds ago
;751:			if (bs->attackcrouch_time < FloatTime() - 5) {
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
GEF4 $388
line 752
;752:				croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 0
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
ADDRLP4 656
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 604
ADDRLP4 656
INDIRF4
ASGNF4
line 753
;753:				if (random() < bs->thinktime * croucher) {
ADDRLP4 660
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
GEF4 $390
line 754
;754:					bs->attackcrouch_time = FloatTime() + 5 + croucher * 15;
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CNSTF4 1097859072
ADDRLP4 604
INDIRF4
MULF4
ADDF4
ASGNF4
line 755
;755:				}
LABELV $390
line 756
;756:			}
LABELV $388
line 758
;757:			//if the bot wants to crouch
;758:			if (bs->attackcrouch_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $392
line 759
;759:				trap_EA_Crouch(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Crouch
CALLV
pop
line 760
;760:			}
LABELV $392
line 762
;761:			//don't crouch when swimming
;762:			if (trap_AAS_Swimming(bs->origin)) bs->attackcrouch_time = FloatTime() - 1;
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 656
ADDRGP4 trap_AAS_Swimming
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $394
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
LABELV $394
line 764
;763:			//make sure the bot is not gonna drown
;764:			if (trap_PointContents(bs->eye,bs->entitynum) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
ADDRLP4 660
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 660
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 660
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 664
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $396
line 765
;765:				if (bs->ltgtype == LTG_CAMPORDER) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 8
NEI4 $398
line 766
;766:					BotAI_BotInitialChat(bs, "camp_stop", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $371
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 767
;767:					trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 668
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 668
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 668
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 769
;768:					//
;769:					if (bs->lastgoal_ltgtype == LTG_CAMPORDER) {
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRI4
CNSTI4 8
NEI4 $400
line 770
;770:						bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 771
;771:					}
LABELV $400
line 772
;772:				}
LABELV $398
line 773
;773:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 774
;774:			}
LABELV $396
line 776
;775:			//
;776:			if (bs->camp_range > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6044
ADDP4
INDIRF4
CNSTF4 0
LEF4 $402
line 778
;777:				//FIXME: move around a bit
;778:			}
LABELV $402
line 780
;779:			//
;780:			trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 781
;781:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $374
line 783
;782:		}
;783:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $359
line 786
;784:	}
;785:	//patrolling along several waypoints
;786:	if (bs->ltgtype == LTG_PATROL && !retreat) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 9
NEI4 $404
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $404
line 788
;787:		//check for bot typing status message
;788:		if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 636
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 636
INDIRF4
CNSTF4 0
EQF4 $406
ADDRLP4 636
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $406
line 789
;789:			strcpy(buf, "");
ADDRLP4 16
ARGP4
ADDRGP4 $69
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 790
;790:			for (wp = bs->patrolpoints; wp; wp = wp->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8936
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $411
JUMPV
LABELV $408
line 791
;791:				strcat(buf, wp->name);
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 792
;792:				if (wp->next) strcat(buf, " to ");
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $412
ADDRLP4 16
ARGP4
ADDRGP4 $414
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $412
line 793
;793:			}
LABELV $409
line 790
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $411
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $408
line 794
;794:			BotAI_BotInitialChat(bs, "patrol_start", buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $415
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 795
;795:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 640
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 640
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 796
;796:			BotVoiceChatOnly(bs, bs->decisionmaker, VOICECHAT_YES);
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
ARGP4
ADDRLP4 644
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
ADDRGP4 $141
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 797
;797:			trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
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
line 798
;798:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 799
;799:		}
LABELV $406
line 801
;800:		//
;801:		if (!bs->curpatrolpoint) {
ADDRFP4 0
INDIRP4
CNSTI4 8940
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $416
line 802
;802:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 803
;803:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $416
line 806
;804:		}
;805:		//if the bot touches the current goal
;806:		if (trap_BotTouchingGoal(bs->origin, &bs->curpatrolpoint->goal)) {
ADDRLP4 640
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 640
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 640
INDIRP4
CNSTI4 8940
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 644
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 644
INDIRI4
CNSTI4 0
EQI4 $418
line 807
;807:			if (bs->patrolflags & PATROL_BACK) {
ADDRFP4 0
INDIRP4
CNSTI4 8944
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $420
line 808
;808:				if (bs->curpatrolpoint->prev) {
ADDRFP4 0
INDIRP4
CNSTI4 8940
ADDP4
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $422
line 809
;809:					bs->curpatrolpoint = bs->curpatrolpoint->prev;
ADDRLP4 648
ADDRFP4 0
INDIRP4
CNSTI4 8940
ADDP4
ASGNP4
ADDRLP4 648
INDIRP4
ADDRLP4 648
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
ASGNP4
line 810
;810:				}
ADDRGP4 $421
JUMPV
LABELV $422
line 811
;811:				else {
line 812
;812:					bs->curpatrolpoint = bs->curpatrolpoint->next;
ADDRLP4 648
ADDRFP4 0
INDIRP4
CNSTI4 8940
ADDP4
ASGNP4
ADDRLP4 648
INDIRP4
ADDRLP4 648
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 813
;813:					bs->patrolflags &= ~PATROL_BACK;
ADDRLP4 652
ADDRFP4 0
INDIRP4
CNSTI4 8944
ADDP4
ASGNP4
ADDRLP4 652
INDIRP4
ADDRLP4 652
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 814
;814:				}
line 815
;815:			}
ADDRGP4 $421
JUMPV
LABELV $420
line 816
;816:			else {
line 817
;817:				if (bs->curpatrolpoint->next) {
ADDRFP4 0
INDIRP4
CNSTI4 8940
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $424
line 818
;818:					bs->curpatrolpoint = bs->curpatrolpoint->next;
ADDRLP4 648
ADDRFP4 0
INDIRP4
CNSTI4 8940
ADDP4
ASGNP4
ADDRLP4 648
INDIRP4
ADDRLP4 648
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 819
;819:				}
ADDRGP4 $425
JUMPV
LABELV $424
line 820
;820:				else {
line 821
;821:					bs->curpatrolpoint = bs->curpatrolpoint->prev;
ADDRLP4 648
ADDRFP4 0
INDIRP4
CNSTI4 8940
ADDP4
ASGNP4
ADDRLP4 648
INDIRP4
ADDRLP4 648
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
ASGNP4
line 822
;822:					bs->patrolflags |= PATROL_BACK;
ADDRLP4 652
ADDRFP4 0
INDIRP4
CNSTI4 8944
ADDP4
ASGNP4
ADDRLP4 652
INDIRP4
ADDRLP4 652
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 823
;823:				}
LABELV $425
line 824
;824:			}
LABELV $421
line 825
;825:		}
LABELV $418
line 827
;826:		//stop after 5 minutes
;827:		if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $426
line 828
;828:			BotAI_BotInitialChat(bs, "patrol_stop", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $428
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 829
;829:			trap_BotEnterChat(bs->cs, bs->decisionmaker, CHAT_TELL);
ADDRLP4 648
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 648
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 648
INDIRP4
CNSTI4 6464
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 830
;830:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 831
;831:		}
LABELV $426
line 832
;832:		if (!bs->curpatrolpoint) {
ADDRFP4 0
INDIRP4
CNSTI4 8940
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $429
line 833
;833:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 834
;834:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $429
line 836
;835:		}
;836:		memcpy(goal, &bs->curpatrolpoint->goal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8940
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 837
;837:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $404
line 840
;838:	}
;839:#ifdef CTF
;840:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 636
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 636
INDIRI4
CNSTI4 0
EQI4 $431
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 640
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 640
INDIRI4
CNSTI4 0
NEI4 $431
line 842
;841:		//if going for enemy flag
;842:		if (bs->ltgtype == LTG_GETFLAG) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 4
NEI4 $433
line 844
;843:			//check for bot typing status message
;844:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 644
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 644
INDIRF4
CNSTF4 0
EQF4 $435
ADDRLP4 644
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $435
line 845
;845:				BotAI_BotInitialChat(bs, "captureflag_start", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $437
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 846
;846:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 847
;847:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONGETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $438
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 848
;848:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 849
;849:			}
LABELV $435
line 851
;850:			//
;851:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 652
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 648
ADDRLP4 652
INDIRI4
ASGNI4
ADDRLP4 648
INDIRI4
CNSTI4 1
EQI4 $442
ADDRLP4 648
INDIRI4
CNSTI4 2
EQI4 $443
ADDRGP4 $439
JUMPV
LABELV $442
line 852
;852:				case TEAM_RED: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $440
JUMPV
LABELV $443
line 853
;853:				case TEAM_BLUE: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $440
JUMPV
LABELV $439
line 854
;854:				default: bs->ltgtype = 0; return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $440
line 857
;855:			}
;856:			//if touching the flag
;857:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 660
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 0
EQI4 $444
line 859
;858:				// make sure the bot knows the flag isn't there anymore
;859:				switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 668
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 664
ADDRLP4 668
INDIRI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 1
EQI4 $449
ADDRLP4 664
INDIRI4
CNSTI4 2
EQI4 $450
ADDRGP4 $446
JUMPV
LABELV $449
line 860
;860:					case TEAM_RED: bs->blueflagstatus = 1; break;
ADDRFP4 0
INDIRP4
CNSTI4 6816
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $447
JUMPV
LABELV $450
line 861
;861:					case TEAM_BLUE: bs->redflagstatus = 1; break;
ADDRFP4 0
INDIRP4
CNSTI4 6812
ADDP4
CNSTI4 1
ASGNI4
LABELV $446
LABELV $447
line 863
;862:				}
;863:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 864
;864:			}
LABELV $444
line 866
;865:			//stop after 3 minutes
;866:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $451
line 867
;867:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 868
;868:			}
LABELV $451
line 869
;869:			BotAlternateRoute(bs, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 BotAlternateRoute
CALLP4
pop
line 870
;870:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $433
line 873
;871:		}
;872:		//if rushing to the base
;873:		if (bs->ltgtype == LTG_RUSHBASE && bs->rushbaseaway_time < FloatTime()) {
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 5
NEI4 $453
ADDRLP4 644
INDIRP4
CNSTI4 6008
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $453
line 874
;874:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 652
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 648
ADDRLP4 652
INDIRI4
ASGNI4
ADDRLP4 648
INDIRI4
CNSTI4 1
EQI4 $458
ADDRLP4 648
INDIRI4
CNSTI4 2
EQI4 $459
ADDRGP4 $455
JUMPV
LABELV $458
line 875
;875:				case TEAM_RED: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $456
JUMPV
LABELV $459
line 876
;876:				case TEAM_BLUE: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $456
JUMPV
LABELV $455
line 877
;877:				default: bs->ltgtype = 0; return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $456
line 880
;878:			}
;879:			//if not carrying the flag anymore
;880:			if (!BotCTFCarryingFlag(bs)) bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 660
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 0
NEI4 $460
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
LABELV $460
line 882
;881:			//quit rushing after 2 minutes
;882:			if (bs->teamgoal_time < FloatTime()) bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $462
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
LABELV $462
line 884
;883:			//if touching the base flag the bot should loose the enemy flag
;884:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 664
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
EQI4 $464
line 887
;885:				//if the bot is still carrying the enemy flag then the
;886:				//base flag is gone, now just walk near the base a bit
;887:				if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 668
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 668
INDIRI4
CNSTI4 0
EQI4 $466
line 888
;888:					trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 889
;889:					bs->rushbaseaway_time = FloatTime() + 5 + 10 * random();
ADDRLP4 672
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CNSTF4 1092616192
ADDRLP4 672
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 891
;890:					//FIXME: add chat to tell the others to get back the flag
;891:				}
ADDRGP4 $467
JUMPV
LABELV $466
line 892
;892:				else {
line 893
;893:					bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 894
;894:				}
LABELV $467
line 895
;895:			}
LABELV $464
line 896
;896:			BotAlternateRoute(bs, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 BotAlternateRoute
CALLP4
pop
line 897
;897:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $453
line 900
;898:		}
;899:		//returning flag
;900:		if (bs->ltgtype == LTG_RETURNFLAG) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 6
NEI4 $432
line 902
;901:			//check for bot typing status message
;902:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 648
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 648
INDIRF4
CNSTF4 0
EQF4 $470
ADDRLP4 648
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $470
line 903
;903:				BotAI_BotInitialChat(bs, "returnflag_start", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $472
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 904
;904:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 905
;905:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONRETURNFLAG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $473
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 906
;906:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 907
;907:			}
LABELV $470
line 909
;908:			//
;909:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 656
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 652
ADDRLP4 656
INDIRI4
ASGNI4
ADDRLP4 652
INDIRI4
CNSTI4 1
EQI4 $477
ADDRLP4 652
INDIRI4
CNSTI4 2
EQI4 $478
ADDRGP4 $474
JUMPV
LABELV $477
line 910
;910:				case TEAM_RED: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $475
JUMPV
LABELV $478
line 911
;911:				case TEAM_BLUE: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $475
JUMPV
LABELV $474
line 912
;912:				default: bs->ltgtype = 0; return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $475
line 915
;913:			}
;914:			//if touching the flag
;915:			if (trap_BotTouchingGoal(bs->origin, goal)) bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 664
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
EQI4 $479
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
LABELV $479
line 917
;916:			//stop after 3 minutes
;917:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $481
line 918
;918:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 919
;919:			}
LABELV $481
line 920
;920:			BotAlternateRoute(bs, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 BotAlternateRoute
CALLP4
pop
line 921
;921:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
line 923
;922:		}
;923:	}
LABELV $431
line 925
;924:#endif //CTF
;925:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $483
line 926
;926:		if (bs->ltgtype == LTG_GETFLAG) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 4
NEI4 $485
line 928
;927:			//check for bot typing status message
;928:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 644
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 644
INDIRF4
CNSTF4 0
EQF4 $487
ADDRLP4 644
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $487
line 929
;929:				BotAI_BotInitialChat(bs, "captureflag_start", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $437
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 930
;930:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 931
;931:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONGETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $438
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 932
;932:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 933
;933:			}
LABELV $487
line 934
;934:			memcpy(goal, &ctf_neutralflag, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_neutralflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 936
;935:			//if touching the flag
;936:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 648
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 648
INDIRI4
CNSTI4 0
EQI4 $489
line 937
;937:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 938
;938:			}
LABELV $489
line 940
;939:			//stop after 3 minutes
;940:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $491
line 941
;941:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 942
;942:			}
LABELV $491
line 943
;943:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $485
line 946
;944:		}
;945:		//if rushing to the base
;946:		if (bs->ltgtype == LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 5
NEI4 $493
line 947
;947:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 648
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 644
ADDRLP4 648
INDIRI4
ASGNI4
ADDRLP4 644
INDIRI4
CNSTI4 1
EQI4 $498
ADDRLP4 644
INDIRI4
CNSTI4 2
EQI4 $499
ADDRGP4 $495
JUMPV
LABELV $498
line 948
;948:				case TEAM_RED: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $496
JUMPV
LABELV $499
line 949
;949:				case TEAM_BLUE: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $496
JUMPV
LABELV $495
line 950
;950:				default: bs->ltgtype = 0; return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $496
line 953
;951:			}
;952:			//if not carrying the flag anymore
;953:			if (!Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 656
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
NEI4 $500
line 954
;954:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 955
;955:			}
LABELV $500
line 957
;956:			//quit rushing after 2 minutes
;957:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $502
line 958
;958:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 959
;959:			}
LABELV $502
line 961
;960:			//if touching the base flag the bot should loose the enemy flag
;961:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 660
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 0
EQI4 $504
line 962
;962:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 963
;963:			}
LABELV $504
line 964
;964:			BotAlternateRoute(bs, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 BotAlternateRoute
CALLP4
pop
line 965
;965:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $493
line 968
;966:		}
;967:		//attack the enemy base
;968:		if (bs->ltgtype == LTG_ATTACKENEMYBASE &&
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 13
NEI4 $506
ADDRLP4 644
INDIRP4
CNSTI4 6012
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $506
line 969
;969:				bs->attackaway_time < FloatTime()) {
line 971
;970:			//check for bot typing status message
;971:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 648
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 648
INDIRF4
CNSTF4 0
EQF4 $508
ADDRLP4 648
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $508
line 972
;972:				BotAI_BotInitialChat(bs, "attackenemybase_start", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $510
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 973
;973:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 974
;974:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONOFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $511
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 975
;975:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 976
;976:			}
LABELV $508
line 977
;977:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 656
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 652
ADDRLP4 656
INDIRI4
ASGNI4
ADDRLP4 652
INDIRI4
CNSTI4 1
EQI4 $515
ADDRLP4 652
INDIRI4
CNSTI4 2
EQI4 $516
ADDRGP4 $512
JUMPV
LABELV $515
line 978
;978:				case TEAM_RED: memcpy(goal, &ctf_blueflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $513
JUMPV
LABELV $516
line 979
;979:				case TEAM_BLUE: memcpy(goal, &ctf_redflag, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $513
JUMPV
LABELV $512
line 980
;980:				default: bs->ltgtype = 0; return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $513
line 983
;981:			}
;982:			//quit rushing after 2 minutes
;983:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $517
line 984
;984:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 985
;985:			}
LABELV $517
line 987
;986:			//if touching the base flag the bot should loose the enemy flag
;987:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 664
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
EQI4 $519
line 988
;988:				bs->attackaway_time = FloatTime() + 2 + 5 * random();
ADDRLP4 668
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDF4
CNSTF4 1084227584
ADDRLP4 668
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 989
;989:			}
LABELV $519
line 990
;990:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $506
line 993
;991:		}
;992:		//returning flag
;993:		if (bs->ltgtype == LTG_RETURNFLAG) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 6
NEI4 $484
line 995
;994:			//check for bot typing status message
;995:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 648
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 648
INDIRF4
CNSTF4 0
EQF4 $523
ADDRLP4 648
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $523
line 996
;996:				BotAI_BotInitialChat(bs, "returnflag_start", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $472
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 997
;997:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 998
;998:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONRETURNFLAG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $473
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 999
;999:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 1000
;1000:			}
LABELV $523
line 1002
;1001:			//
;1002:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $525
line 1003
;1003:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 1004
;1004:			}
LABELV $525
line 1006
;1005:			//just roam around
;1006:			return BotGetItemLongTermGoal(bs, tfl, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 652
ADDRGP4 BotGetItemLongTermGoal
CALLI4
ASGNI4
ADDRLP4 652
INDIRI4
RETI4
ADDRGP4 $135
JUMPV
line 1008
;1007:		}
;1008:	}
LABELV $483
line 1009
;1009:	else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $527
line 1010
;1010:		if (bs->ltgtype == LTG_ATTACKENEMYBASE &&
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 13
NEI4 $528
ADDRLP4 644
INDIRP4
CNSTI4 6012
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $528
line 1011
;1011:				bs->attackaway_time < FloatTime()) {
line 1014
;1012:
;1013:			//check for bot typing status message
;1014:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 648
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 648
INDIRF4
CNSTF4 0
EQF4 $531
ADDRLP4 648
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $531
line 1015
;1015:				BotAI_BotInitialChat(bs, "attackenemybase_start", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $510
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1016
;1016:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1017
;1017:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONOFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $511
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 1018
;1018:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 1019
;1019:			}
LABELV $531
line 1020
;1020:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 656
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 652
ADDRLP4 656
INDIRI4
ASGNI4
ADDRLP4 652
INDIRI4
CNSTI4 1
EQI4 $536
ADDRLP4 652
INDIRI4
CNSTI4 2
EQI4 $537
ADDRGP4 $533
JUMPV
LABELV $536
line 1021
;1021:				case TEAM_RED: memcpy(goal, &blueobelisk, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $534
JUMPV
LABELV $537
line 1022
;1022:				case TEAM_BLUE: memcpy(goal, &redobelisk, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $534
JUMPV
LABELV $533
line 1023
;1023:				default: bs->ltgtype = 0; return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $534
line 1026
;1024:			}
;1025:			//if the bot no longer wants to attack the obelisk
;1026:			if (BotFeelingBad(bs) > 50) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 664
ADDRGP4 BotFeelingBad
CALLF4
ASGNF4
ADDRLP4 664
INDIRF4
CNSTF4 1112014848
LEF4 $538
line 1027
;1027:				return BotGetItemLongTermGoal(bs, tfl, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 668
ADDRGP4 BotGetItemLongTermGoal
CALLI4
ASGNI4
ADDRLP4 668
INDIRI4
RETI4
ADDRGP4 $135
JUMPV
LABELV $538
line 1030
;1028:			}
;1029:			//if touching the obelisk
;1030:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 668
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 668
INDIRI4
CNSTI4 0
EQI4 $540
line 1031
;1031:				bs->attackaway_time = FloatTime() + 3 + 5 * random();
ADDRLP4 672
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
ADDF4
CNSTF4 1084227584
ADDRLP4 672
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1032
;1032:			}
LABELV $540
line 1034
;1033:			// or very close to the obelisk
;1034:			VectorSubtract(bs->origin, goal->origin, dir);
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 676
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 672
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRLP4 676
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 672
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRLP4 676
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1035
;1035:			if (VectorLengthSquared(dir) < Square(60)) {
ADDRLP4 4
ARGP4
ADDRLP4 680
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 680
INDIRF4
CNSTF4 1163984896
GEF4 $544
line 1036
;1036:				bs->attackaway_time = FloatTime() + 3 + 5 * random();
ADDRLP4 684
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
ADDF4
CNSTF4 1084227584
ADDRLP4 684
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1037
;1037:			}
LABELV $544
line 1039
;1038:			//quit rushing after 2 minutes
;1039:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $546
line 1040
;1040:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 1041
;1041:			}
LABELV $546
line 1042
;1042:			BotAlternateRoute(bs, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 BotAlternateRoute
CALLP4
pop
line 1044
;1043:			//just move towards the obelisk
;1044:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
line 1046
;1045:		}
;1046:	}
LABELV $527
line 1047
;1047:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $548
line 1049
;1048:		//if rushing to the base
;1049:		if (bs->ltgtype == LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 5
NEI4 $550
line 1050
;1050:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 648
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 644
ADDRLP4 648
INDIRI4
ASGNI4
ADDRLP4 644
INDIRI4
CNSTI4 1
EQI4 $555
ADDRLP4 644
INDIRI4
CNSTI4 2
EQI4 $556
ADDRGP4 $552
JUMPV
LABELV $555
line 1051
;1051:				case TEAM_RED: memcpy(goal, &blueobelisk, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $553
JUMPV
LABELV $556
line 1052
;1052:				case TEAM_BLUE: memcpy(goal, &redobelisk, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $553
JUMPV
LABELV $552
line 1053
;1053:				default: BotGoHarvest(bs); return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoHarvest
CALLV
pop
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $553
line 1056
;1054:			}
;1055:			//if not carrying any cubes
;1056:			if (!BotHarvesterCarryingCubes(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 656
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
NEI4 $557
line 1057
;1057:				BotGoHarvest(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoHarvest
CALLV
pop
line 1058
;1058:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $557
line 1061
;1059:			}
;1060:			//quit rushing after 2 minutes
;1061:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $559
line 1062
;1062:				BotGoHarvest(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoHarvest
CALLV
pop
line 1063
;1063:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $559
line 1066
;1064:			}
;1065:			//if touching the base flag the bot should loose the enemy flag
;1066:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 660
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 0
EQI4 $561
line 1067
;1067:				BotGoHarvest(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoHarvest
CALLV
pop
line 1068
;1068:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $561
line 1070
;1069:			}
;1070:			BotAlternateRoute(bs, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 BotAlternateRoute
CALLP4
pop
line 1071
;1071:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $550
line 1074
;1072:		}
;1073:		//attack the enemy base
;1074:		if (bs->ltgtype == LTG_ATTACKENEMYBASE &&
ADDRLP4 644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 644
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 13
NEI4 $563
ADDRLP4 644
INDIRP4
CNSTI4 6012
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $563
line 1075
;1075:				bs->attackaway_time < FloatTime()) {
line 1077
;1076:			//check for bot typing status message
;1077:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 648
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 648
INDIRF4
CNSTF4 0
EQF4 $565
ADDRLP4 648
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $565
line 1078
;1078:				BotAI_BotInitialChat(bs, "attackenemybase_start", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $510
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1079
;1079:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1080
;1080:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONOFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $511
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 1081
;1081:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 1082
;1082:			}
LABELV $565
line 1083
;1083:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 656
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 652
ADDRLP4 656
INDIRI4
ASGNI4
ADDRLP4 652
INDIRI4
CNSTI4 1
EQI4 $570
ADDRLP4 652
INDIRI4
CNSTI4 2
EQI4 $571
ADDRGP4 $567
JUMPV
LABELV $570
line 1084
;1084:				case TEAM_RED: memcpy(goal, &blueobelisk, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $568
JUMPV
LABELV $571
line 1085
;1085:				case TEAM_BLUE: memcpy(goal, &redobelisk, sizeof(bot_goal_t)); break;
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $568
JUMPV
LABELV $567
line 1086
;1086:				default: bs->ltgtype = 0; return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $568
line 1089
;1087:			}
;1088:			//quit rushing after 2 minutes
;1089:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $572
line 1090
;1090:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 1091
;1091:			}
LABELV $572
line 1093
;1092:			//if touching the base flag the bot should loose the enemy flag
;1093:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 664
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
EQI4 $574
line 1094
;1094:				bs->attackaway_time = FloatTime() + 2 + 5 * random();
ADDRLP4 668
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDF4
CNSTF4 1084227584
ADDRLP4 668
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
;1095:			}
LABELV $574
line 1096
;1096:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $563
line 1099
;1097:		}
;1098:		//harvest cubes
;1099:		if (bs->ltgtype == LTG_HARVEST &&
ADDRLP4 648
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 648
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 12
NEI4 $576
ADDRLP4 648
INDIRP4
CNSTI4 6016
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $576
line 1100
;1100:			bs->harvestaway_time < FloatTime()) {
line 1102
;1101:			//check for bot typing status message
;1102:			if (bs->teammessage_time && bs->teammessage_time < FloatTime()) {
ADDRLP4 652
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
INDIRF4
ASGNF4
ADDRLP4 652
INDIRF4
CNSTF4 0
EQF4 $578
ADDRLP4 652
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $578
line 1103
;1103:				BotAI_BotInitialChat(bs, "harvest_start", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $580
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1104
;1104:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1105
;1105:				BotVoiceChatOnly(bs, -1, VOICECHAT_ONOFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $511
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 1106
;1106:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6596
ADDP4
CNSTF4 0
ASGNF4
line 1107
;1107:			}
LABELV $578
line 1108
;1108:			memcpy(goal, &neutralobelisk, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 neutralobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1110
;1109:			//
;1110:			if (bs->teamgoal_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $581
line 1111
;1111:				bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 1112
;1112:			}
LABELV $581
line 1114
;1113:			//
;1114:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 656
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $583
line 1115
;1115:				bs->harvestaway_time = FloatTime() + 4 + 3 * random();
ADDRLP4 660
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1082130432
ADDF4
CNSTF4 1077936128
ADDRLP4 660
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1116
;1116:			}
LABELV $583
line 1117
;1117:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $135
JUMPV
LABELV $576
line 1119
;1118:		}
;1119:	}
LABELV $548
LABELV $528
LABELV $484
LABELV $432
line 1122
;1120://#endif
;1121:	//normal goal stuff
;1122:	return BotGetItemLongTermGoal(bs, tfl, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 644
ADDRGP4 BotGetItemLongTermGoal
CALLI4
ASGNI4
ADDRLP4 644
INDIRI4
RETI4
LABELV $135
endproc BotGetLongTermGoal 688 20
export BotLongTermGoal
proc BotLongTermGoal 448 20
line 1130
;1123:}
;1124:
;1125:/*
;1126:==================
;1127:BotLongTermGoal
;1128:==================
;1129:*/
;1130:int BotLongTermGoal(bot_state_t *bs, int tfl, int retreat, bot_goal_t *goal) {
line 1140
;1131:	aas_entityinfo_t entinfo;
;1132:	char teammate[MAX_MESSAGE_SIZE];
;1133:	float squaredist;
;1134:	int areanum;
;1135:	vec3_t dir;
;1136:
;1137:	//FIXME: also have air long term goals?
;1138:	//
;1139:	//if the bot is leading someone and not retreating
;1140:	if (bs->lead_time > 0 && !retreat) {
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
INDIRF4
CNSTF4 0
LEF4 $586
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $586
line 1141
;1141:		if (bs->lead_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $588
line 1142
;1142:			BotAI_BotInitialChat(bs, "lead_stop", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 416
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $590
ARGP4
ADDRLP4 416
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1143
;1143:			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 420
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 420
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 420
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1144
;1144:			bs->lead_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 1145
;1145:			return BotGetLongTermGoal(bs, tfl, retreat, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 424
ADDRGP4 BotGetLongTermGoal
CALLI4
ASGNI4
ADDRLP4 424
INDIRI4
RETI4
ADDRGP4 $585
JUMPV
LABELV $588
line 1148
;1146:		}
;1147:		//
;1148:		if (bs->leadmessage_time < 0 && -bs->leadmessage_time < FloatTime()) {
ADDRLP4 416
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
INDIRF4
ASGNF4
ADDRLP4 416
INDIRF4
CNSTF4 0
GEF4 $591
ADDRLP4 416
INDIRF4
NEGF4
ADDRGP4 floattime
INDIRF4
GEF4 $591
line 1149
;1149:			BotAI_BotInitialChat(bs, "followme", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 420
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $593
ARGP4
ADDRLP4 420
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1150
;1150:			trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 424
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 424
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 424
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1151
;1151:			bs->leadmessage_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1152
;1152:		}
LABELV $591
line 1154
;1153:		//get entity information of the companion
;1154:		BotEntityInfo(bs->lead_teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1156
;1155:		//
;1156:		if (entinfo.valid) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $594
line 1157
;1157:			areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 12+24
ARGP4
ADDRLP4 420
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 412
ADDRLP4 420
INDIRI4
ASGNI4
line 1158
;1158:			if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 424
ADDRLP4 412
INDIRI4
ASGNI4
ADDRLP4 424
INDIRI4
CNSTI4 0
EQI4 $597
ADDRLP4 424
INDIRI4
ARGI4
ADDRLP4 428
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 428
INDIRI4
CNSTI4 0
EQI4 $597
line 1160
;1159:				//update team goal
;1160:				bs->lead_teamgoal.entitynum = bs->lead_teammate;
ADDRLP4 432
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 432
INDIRP4
CNSTI4 6724
ADDP4
ADDRLP4 432
INDIRP4
CNSTI4 6680
ADDP4
INDIRI4
ASGNI4
line 1161
;1161:				bs->lead_teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6696
ADDP4
ADDRLP4 412
INDIRI4
ASGNI4
line 1162
;1162:				VectorCopy(entinfo.origin, bs->lead_teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6684
ADDP4
ADDRLP4 12+24
INDIRB
ASGNB 12
line 1163
;1163:				VectorSet(bs->lead_teamgoal.mins, -8, -8, -8);
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
line 1164
;1164:				VectorSet(bs->lead_teamgoal.maxs, 8, 8, 8);
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
line 1165
;1165:			}
LABELV $597
line 1166
;1166:		}
LABELV $594
line 1168
;1167:		//if the team mate is visible
;1168:		if (BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->lead_teammate)) {
ADDRLP4 420
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 420
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 420
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 420
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 420
INDIRP4
CNSTI4 6680
ADDP4
INDIRI4
ARGI4
ADDRLP4 424
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 424
INDIRF4
CNSTF4 0
EQF4 $600
line 1169
;1169:			bs->leadvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1170
;1170:		}
LABELV $600
line 1172
;1171:		//if the team mate is not visible for 1 seconds
;1172:		if (bs->leadvisible_time < FloatTime() - 1) {
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $602
line 1173
;1173:			bs->leadbackup_time = FloatTime() + 2;
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 1174
;1174:		}
LABELV $602
line 1176
;1175:		//distance towards the team mate
;1176:		VectorSubtract(bs->origin, bs->lead_teamgoal.origin, dir);
ADDRLP4 428
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 428
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
ADDRLP4 428
INDIRP4
CNSTI4 6684
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 428
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
ADDRLP4 428
INDIRP4
CNSTI4 6688
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 432
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 432
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
ADDRLP4 432
INDIRP4
CNSTI4 6692
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1177
;1177:		squaredist = VectorLengthSquared(dir);
ADDRLP4 0
ARGP4
ADDRLP4 436
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 408
ADDRLP4 436
INDIRF4
ASGNF4
line 1179
;1178:		//if backing up towards the team mate
;1179:		if (bs->leadbackup_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $606
line 1180
;1180:			if (bs->leadmessage_time < FloatTime() - 20) {
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1101004800
SUBF4
GEF4 $608
line 1181
;1181:				BotAI_BotInitialChat(bs, "followme", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 440
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $593
ARGP4
ADDRLP4 440
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1182
;1182:				trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 444
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 444
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 444
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1183
;1183:				bs->leadmessage_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1184
;1184:			}
LABELV $608
line 1186
;1185:			//if very close to the team mate
;1186:			if (squaredist < Square(100)) {
ADDRLP4 408
INDIRF4
CNSTF4 1176256512
GEF4 $610
line 1187
;1187:				bs->leadbackup_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
CNSTF4 0
ASGNF4
line 1188
;1188:			}
LABELV $610
line 1190
;1189:			//the bot should go back to the team mate
;1190:			memcpy(goal, &bs->lead_teamgoal, sizeof(bot_goal_t));
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6684
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1191
;1191:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $585
JUMPV
LABELV $606
line 1193
;1192:		}
;1193:		else {
line 1195
;1194:			//if quite distant from the team mate
;1195:			if (squaredist > Square(500)) {
ADDRLP4 408
INDIRF4
CNSTF4 1215570944
LEF4 $612
line 1196
;1196:				if (bs->leadmessage_time < FloatTime() - 20) {
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1101004800
SUBF4
GEF4 $614
line 1197
;1197:					BotAI_BotInitialChat(bs, "followme", EasyClientName(bs->lead_teammate, teammate, sizeof(teammate)), NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 440
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $593
ARGP4
ADDRLP4 440
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1198
;1198:					trap_BotEnterChat(bs->cs, bs->teammate, CHAT_TELL);
ADDRLP4 444
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 444
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 444
INDIRP4
CNSTI4 6460
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1199
;1199:					bs->leadmessage_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1200
;1200:				}
LABELV $614
line 1202
;1201:				//look at the team mate
;1202:				VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 440
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12+24
INDIRF4
ADDRLP4 440
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+24+4
INDIRF4
ADDRLP4 440
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
line 1203
;1203:				vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1204
;1204:				bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 444
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 444
INDIRP4
CNSTF4 1056964608
ADDRLP4 444
INDIRP4
INDIRF4
MULF4
ASGNF4
line 1206
;1205:				//just wait for the team mate
;1206:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $585
JUMPV
LABELV $612
line 1208
;1207:			}
;1208:		}
line 1209
;1209:	}
LABELV $586
line 1210
;1210:	return BotGetLongTermGoal(bs, tfl, retreat, goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 416
ADDRGP4 BotGetLongTermGoal
CALLI4
ASGNI4
ADDRLP4 416
INDIRI4
RETI4
LABELV $585
endproc BotLongTermGoal 448 20
export AIEnter_Intermission
proc AIEnter_Intermission 8 16
line 1218
;1211:}
;1212:
;1213:/*
;1214:==================
;1215:AIEnter_Intermission
;1216:==================
;1217:*/
;1218:void AIEnter_Intermission(bot_state_t *bs, char *s) {
line 1219
;1219:	BotRecordNodeSwitch(bs, "intermission", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $624
ARGP4
ADDRGP4 $69
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 1221
;1220:	//reset the bot state
;1221:	BotResetState(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotResetState
CALLV
pop
line 1223
;1222:	//check for end level chat
;1223:	if (BotChat_EndLevel(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotChat_EndLevel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $625
line 1224
;1224:		trap_BotEnterChat(bs->cs, 0, bs->chatto);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 5908
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1225
;1225:	}
LABELV $625
line 1226
;1226:	bs->ainode = AINode_Intermission;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Intermission
ASGNP4
line 1227
;1227:}
LABELV $623
endproc AIEnter_Intermission 8 16
export AINode_Intermission
proc AINode_Intermission 16 8
line 1234
;1228:
;1229:/*
;1230:==================
;1231:AINode_Intermission
;1232:==================
;1233:*/
;1234:int AINode_Intermission(bot_state_t *bs) {
line 1236
;1235:	//if the intermission ended
;1236:	if (!BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $628
line 1237
;1237:		if (BotChat_StartLevel(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotChat_StartLevel
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $630
line 1238
;1238:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 5952
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
line 1239
;1239:		}
ADDRGP4 $631
JUMPV
LABELV $630
line 1240
;1240:		else {
line 1241
;1241:			bs->stand_time = FloatTime() + 2;
ADDRFP4 0
INDIRP4
CNSTI4 5952
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 1242
;1242:		}
LABELV $631
line 1243
;1243:		AIEnter_Stand(bs, "intermission: chat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $632
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 1244
;1244:	}
LABELV $628
line 1245
;1245:	return qtrue;
CNSTI4 1
RETI4
LABELV $627
endproc AINode_Intermission 16 8
export AIEnter_Observer
proc AIEnter_Observer 0 16
line 1253
;1246:}
;1247:
;1248:/*
;1249:==================
;1250:AIEnter_Observer
;1251:==================
;1252:*/
;1253:void AIEnter_Observer(bot_state_t *bs, char *s) {
line 1254
;1254:	BotRecordNodeSwitch(bs, "observer", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $634
ARGP4
ADDRGP4 $69
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 1256
;1255:	//reset the bot state
;1256:	BotResetState(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotResetState
CALLV
pop
line 1257
;1257:	bs->ainode = AINode_Observer;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Observer
ASGNP4
line 1258
;1258:}
LABELV $633
endproc AIEnter_Observer 0 16
export AINode_Observer
proc AINode_Observer 4 8
line 1265
;1259:
;1260:/*
;1261:==================
;1262:AINode_Observer
;1263:==================
;1264:*/
;1265:int AINode_Observer(bot_state_t *bs) {
line 1267
;1266:	//if the bot left observer mode
;1267:	if (!BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $636
line 1268
;1268:		AIEnter_Stand(bs, "observer: left observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $638
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 1269
;1269:	}
LABELV $636
line 1270
;1270:	return qtrue;
CNSTI4 1
RETI4
LABELV $635
endproc AINode_Observer 4 8
export AIEnter_Stand
proc AIEnter_Stand 0 16
line 1278
;1271:}
;1272:
;1273:/*
;1274:==================
;1275:AIEnter_Stand
;1276:==================
;1277:*/
;1278:void AIEnter_Stand(bot_state_t *bs, char *s) {
line 1279
;1279:	BotRecordNodeSwitch(bs, "stand", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $640
ARGP4
ADDRGP4 $69
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 1280
;1280:	bs->standfindenemy_time = FloatTime() + 1;
ADDRFP4 0
INDIRP4
CNSTI4 5968
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1281
;1281:	bs->ainode = AINode_Stand;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Stand
ASGNP4
line 1282
;1282:}
LABELV $639
endproc AIEnter_Stand 0 16
export AINode_Stand
proc AINode_Stand 24 12
line 1289
;1283:
;1284:/*
;1285:==================
;1286:AINode_Stand
;1287:==================
;1288:*/
;1289:int AINode_Stand(bot_state_t *bs) {
line 1292
;1290:
;1291:	//if the bot's health decreased
;1292:	if (bs->lastframe_health > bs->inventory[INVENTORY_HEALTH]) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5900
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
LEI4 $642
line 1293
;1293:		if (BotChat_HitTalking(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotChat_HitTalking
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $644
line 1294
;1294:			bs->standfindenemy_time = FloatTime() + BotChatTime(bs) + 0.1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 5968
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1295
;1295:			bs->stand_time = FloatTime() + BotChatTime(bs) + 0.1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 5952
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 20
INDIRF4
ADDF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1296
;1296:		}
LABELV $644
line 1297
;1297:	}
LABELV $642
line 1298
;1298:	if (bs->standfindenemy_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5968
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $646
line 1299
;1299:		if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 4
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $648
line 1300
;1300:			AIEnter_Battle_Fight(bs, "stand: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $650
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 1301
;1301:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $641
JUMPV
LABELV $648
line 1303
;1302:		}
;1303:		bs->standfindenemy_time = FloatTime() + 1;
ADDRFP4 0
INDIRP4
CNSTI4 5968
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1304
;1304:	}
LABELV $646
line 1306
;1305:	// put up chat icon
;1306:	trap_EA_Talk(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Talk
CALLV
pop
line 1308
;1307:	// when done standing
;1308:	if (bs->stand_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5952
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $651
line 1309
;1309:		trap_BotEnterChat(bs->cs, 0, bs->chatto);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 5908
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1310
;1310:		AIEnter_Seek_LTG(bs, "stand: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $653
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 1311
;1311:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $641
JUMPV
LABELV $651
line 1314
;1312:	}
;1313:	//
;1314:	return qtrue;
CNSTI4 1
RETI4
LABELV $641
endproc AINode_Stand 24 12
export AIEnter_Respawn
proc AIEnter_Respawn 12 16
line 1322
;1315:}
;1316:
;1317:/*
;1318:==================
;1319:AIEnter_Respawn
;1320:==================
;1321:*/
;1322:void AIEnter_Respawn(bot_state_t *bs, char *s) {
line 1323
;1323:	BotRecordNodeSwitch(bs, "respawn", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $655
ARGP4
ADDRGP4 $69
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 1325
;1324:	//reset some states
;1325:	trap_BotResetMoveState(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetMoveState
CALLV
pop
line 1326
;1326:	trap_BotResetGoalState(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetGoalState
CALLV
pop
line 1327
;1327:	trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
line 1328
;1328:	trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 1330
;1329:	//if the bot wants to chat
;1330:	if (BotChat_Death(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotChat_Death
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $656
line 1331
;1331:		bs->respawn_time = FloatTime() + BotChatTime(bs);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 5932
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ASGNF4
line 1332
;1332:		bs->respawnchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 5936
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1333
;1333:	}
ADDRGP4 $657
JUMPV
LABELV $656
line 1334
;1334:	else {
line 1335
;1335:		bs->respawn_time = FloatTime() + 1 + random();
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 5932
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 4
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDF4
ASGNF4
line 1336
;1336:		bs->respawnchat_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5936
ADDP4
CNSTF4 0
ASGNF4
line 1337
;1337:	}
LABELV $657
line 1339
;1338:	//set respawn state
;1339:	bs->respawn_wait = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5840
ADDP4
CNSTI4 0
ASGNI4
line 1340
;1340:	bs->ainode = AINode_Respawn;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Respawn
ASGNP4
line 1341
;1341:}
LABELV $654
endproc AIEnter_Respawn 12 16
export AINode_Respawn
proc AINode_Respawn 4 12
line 1348
;1342:
;1343:/*
;1344:==================
;1345:AINode_Respawn
;1346:==================
;1347:*/
;1348:int AINode_Respawn(bot_state_t *bs) {
line 1350
;1349:	// if waiting for the actual respawn
;1350:	if (bs->respawn_wait) {
ADDRFP4 0
INDIRP4
CNSTI4 5840
ADDP4
INDIRI4
CNSTI4 0
EQI4 $659
line 1351
;1351:		if (!BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $661
line 1352
;1352:			AIEnter_Seek_LTG(bs, "respawn: respawned");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $663
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 1353
;1353:		}
ADDRGP4 $660
JUMPV
LABELV $661
line 1354
;1354:		else {
line 1355
;1355:			trap_EA_Respawn(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Respawn
CALLV
pop
line 1356
;1356:		}
line 1357
;1357:	}
ADDRGP4 $660
JUMPV
LABELV $659
line 1358
;1358:	else if (bs->respawn_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5932
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $664
line 1360
;1359:		// wait until respawned
;1360:		bs->respawn_wait = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5840
ADDP4
CNSTI4 1
ASGNI4
line 1362
;1361:		// elementary action respawn
;1362:		trap_EA_Respawn(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Respawn
CALLV
pop
line 1364
;1363:		//
;1364:		if (bs->respawnchat_time) {
ADDRFP4 0
INDIRP4
CNSTI4 5936
ADDP4
INDIRF4
CNSTF4 0
EQF4 $666
line 1365
;1365:			trap_BotEnterChat(bs->cs, 0, bs->chatto);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 5908
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1366
;1366:			bs->enemy = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
CNSTI4 -1
ASGNI4
line 1367
;1367:		}
LABELV $666
line 1368
;1368:	}
LABELV $664
LABELV $660
line 1369
;1369:	if (bs->respawnchat_time && bs->respawnchat_time < FloatTime() - 0.5) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 5936
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $668
ADDRLP4 0
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
SUBF4
GEF4 $668
line 1370
;1370:		trap_EA_Talk(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Talk
CALLV
pop
line 1371
;1371:	}
LABELV $668
line 1373
;1372:	//
;1373:	return qtrue;
CNSTI4 1
RETI4
LABELV $658
endproc AINode_Respawn 4 12
export BotSelectActivateWeapon
proc BotSelectActivateWeapon 88 0
line 1381
;1374:}
;1375:
;1376:/*
;1377:==================
;1378:BotSelectActivateWeapon
;1379:==================
;1380:*/
;1381:int BotSelectActivateWeapon(bot_state_t *bs) {
line 1383
;1382:	//
;1383:	if (bs->inventory[INVENTORY_MACHINEGUN] > 0 && bs->inventory[INVENTORY_BULLETS] > 0)
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4832
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $671
ADDRLP4 0
INDIRP4
CNSTI4 4884
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $671
line 1384
;1384:		return WEAPONINDEX_MACHINEGUN;
CNSTI4 2
RETI4
ADDRGP4 $670
JUMPV
LABELV $671
line 1385
;1385:	else if (bs->inventory[INVENTORY_SHOTGUN] > 0 && bs->inventory[INVENTORY_SHELLS] > 0)
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 4828
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $673
ADDRLP4 8
INDIRP4
CNSTI4 4880
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $673
line 1386
;1386:		return WEAPONINDEX_SHOTGUN;
CNSTI4 3
RETI4
ADDRGP4 $670
JUMPV
LABELV $673
line 1387
;1387:	else if (bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0)
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 4852
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
LEI4 $675
ADDRLP4 16
INDIRP4
CNSTI4 4892
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
LEI4 $675
line 1388
;1388:		return WEAPONINDEX_PLASMAGUN;
CNSTI4 8
RETI4
ADDRGP4 $670
JUMPV
LABELV $675
line 1389
;1389:	else if (bs->inventory[INVENTORY_LIGHTNING] > 0 && bs->inventory[INVENTORY_LIGHTNINGAMMO] > 0)
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 4844
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $677
ADDRLP4 24
INDIRP4
CNSTI4 4896
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $677
line 1390
;1390:		return WEAPONINDEX_LIGHTNING;
CNSTI4 6
RETI4
ADDRGP4 $670
JUMPV
LABELV $677
line 1391
;1391:	else if (bs->inventory[INVENTORY_CHAINGUN] > 0 && bs->inventory[INVENTORY_BELT] > 0)
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 4876
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
LEI4 $679
ADDRLP4 32
INDIRP4
CNSTI4 4920
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
LEI4 $679
line 1392
;1392:		return WEAPONINDEX_CHAINGUN;
CNSTI4 13
RETI4
ADDRGP4 $670
JUMPV
LABELV $679
line 1393
;1393:	else if (bs->inventory[INVENTORY_NAILGUN] > 0 && bs->inventory[INVENTORY_NAILS] > 0)
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 4868
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $681
ADDRLP4 40
INDIRP4
CNSTI4 4912
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $681
line 1394
;1394:		return WEAPONINDEX_NAILGUN;
CNSTI4 11
RETI4
ADDRGP4 $670
JUMPV
LABELV $681
line 1395
;1395:	else if (bs->inventory[INVENTORY_PROXLAUNCHER] > 0 && bs->inventory[INVENTORY_MINES] > 0)
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRP4
CNSTI4 4872
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
LEI4 $683
ADDRLP4 48
INDIRP4
CNSTI4 4916
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
LEI4 $683
line 1396
;1396:		return WEAPONINDEX_PROXLAUNCHER;
CNSTI4 12
RETI4
ADDRGP4 $670
JUMPV
LABELV $683
line 1397
;1397:	else if (bs->inventory[INVENTORY_GRENADELAUNCHER] > 0 && bs->inventory[INVENTORY_GRENADES] > 0)
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 4836
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
LEI4 $685
ADDRLP4 56
INDIRP4
CNSTI4 4888
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
LEI4 $685
line 1398
;1398:		return WEAPONINDEX_GRENADE_LAUNCHER;
CNSTI4 4
RETI4
ADDRGP4 $670
JUMPV
LABELV $685
line 1399
;1399:	else if (bs->inventory[INVENTORY_RAILGUN] > 0 && bs->inventory[INVENTORY_SLUGS] > 0)
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 4848
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
LEI4 $687
ADDRLP4 64
INDIRP4
CNSTI4 4904
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
LEI4 $687
line 1400
;1400:		return WEAPONINDEX_RAILGUN;
CNSTI4 7
RETI4
ADDRGP4 $670
JUMPV
LABELV $687
line 1401
;1401:	else if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0)
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 4840
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
LEI4 $689
ADDRLP4 72
INDIRP4
CNSTI4 4900
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
LEI4 $689
line 1402
;1402:		return WEAPONINDEX_ROCKET_LAUNCHER;
CNSTI4 5
RETI4
ADDRGP4 $670
JUMPV
LABELV $689
line 1403
;1403:	else if (bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0)
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRP4
CNSTI4 4860
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
LEI4 $691
ADDRLP4 80
INDIRP4
CNSTI4 4908
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
LEI4 $691
line 1404
;1404:		return WEAPONINDEX_BFG;
CNSTI4 9
RETI4
ADDRGP4 $670
JUMPV
LABELV $691
line 1405
;1405:	else {
line 1406
;1406:		return -1;
CNSTI4 -1
RETI4
LABELV $670
endproc BotSelectActivateWeapon 88 0
export BotClearPath
proc BotClearPath 376 28
line 1417
;1407:	}
;1408:}
;1409:
;1410:/*
;1411:==================
;1412:BotClearPath
;1413:
;1414: try to deactivate obstacles like proximity mines on the bot's path
;1415:==================
;1416:*/
;1417:void BotClearPath(bot_state_t *bs, bot_moveresult_t *moveresult) {
line 1425
;1418:	int i, bestmine;
;1419:	float dist, bestdist;
;1420:	vec3_t target, dir;
;1421:	bsp_trace_t bsptrace;
;1422:	entityState_t state;
;1423:
;1424:	// if there is a dead body wearing kamikze nearby
;1425:	if (bs->kamikazebody) {
ADDRFP4 0
INDIRP4
CNSTI4 6112
ADDP4
INDIRI4
CNSTI4 0
EQI4 $694
line 1427
;1426:		// if the bot's view angles and weapon are not used for movement
;1427:		if ( !(moveresult->flags & (MOVERESULT_MOVEMENTVIEW | MOVERESULT_MOVEMENTWEAPON)) ) {
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 17
BANDI4
CNSTI4 0
NEI4 $696
line 1429
;1428:			//
;1429:			BotAI_GetEntityState(bs->kamikazebody, &state);
ADDRFP4 0
INDIRP4
CNSTI4 6112
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 1430
;1430:			VectorCopy(state.pos.trBase, target);
ADDRLP4 236
ADDRLP4 12+12+12
INDIRB
ASGNB 12
line 1431
;1431:			target[2] += 8;
ADDRLP4 236+8
ADDRLP4 236+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1432
;1432:			VectorSubtract(target, bs->eye, dir);
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 236
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4792
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 236+4
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4796
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 236+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4800
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1433
;1433:			vectoangles(dir, moveresult->ideal_viewangles);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1435
;1434:			//
;1435:			moveresult->weapon = BotSelectActivateWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 336
ADDRGP4 BotSelectActivateWeapon
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 336
INDIRI4
ASGNI4
line 1436
;1436:			if (moveresult->weapon == -1) {
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $705
line 1438
;1437:				// FIXME: run away!
;1438:				moveresult->weapon = 0;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 1439
;1439:			}
LABELV $705
line 1440
;1440:			if (moveresult->weapon) {
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $707
line 1442
;1441:				//
;1442:				moveresult->flags |= MOVERESULT_MOVEMENTWEAPON | MOVERESULT_MOVEMENTVIEW;
ADDRLP4 340
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 340
INDIRP4
ADDRLP4 340
INDIRP4
INDIRI4
CNSTI4 17
BORI4
ASGNI4
line 1444
;1443:				// if holding the right weapon
;1444:				if (bs->cur_ps.weapon == moveresult->weapon) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
NEI4 $709
line 1446
;1445:					// if the bot is pretty close with it's aim
;1446:					if (InFieldOfVision(bs->viewangles, 20, moveresult->ideal_viewangles)) {
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 344
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $711
line 1448
;1447:						//
;1448:						BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, target, bs->entitynum, MASK_SHOT);
ADDRLP4 248
ARGP4
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 4792
ADDP4
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
ADDRLP4 236
ARGP4
ADDRLP4 348
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
line 1450
;1449:						// if the mine is visible from the current position
;1450:						if (bsptrace.fraction >= 1.0 || bsptrace.ent == state.number) {
ADDRLP4 248+8
INDIRF4
CNSTF4 1065353216
GEF4 $717
ADDRLP4 248+80
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $713
LABELV $717
line 1452
;1451:							// shoot at the mine
;1452:							trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 1453
;1453:						}
LABELV $713
line 1454
;1454:					}
LABELV $711
line 1455
;1455:				}
LABELV $709
line 1456
;1456:			}
LABELV $707
line 1457
;1457:		}
LABELV $696
line 1458
;1458:	}
LABELV $694
line 1459
;1459:	if (moveresult->flags & MOVERESULT_BLOCKEDBYAVOIDSPOT) {
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $718
line 1460
;1460:		bs->blockedbyavoidspot_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 1461
;1461:	}
LABELV $718
line 1463
;1462:	// if blocked by an avoid spot and the view angles and weapon are used for movement
;1463:	if (bs->blockedbyavoidspot_time > FloatTime() &&
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $720
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 17
BANDI4
CNSTI4 0
NEI4 $720
line 1464
;1464:		!(moveresult->flags & (MOVERESULT_MOVEMENTVIEW | MOVERESULT_MOVEMENTWEAPON)) ) {
line 1465
;1465:		bestdist = 300;
ADDRLP4 228
CNSTF4 1133903872
ASGNF4
line 1466
;1466:		bestmine = -1;
ADDRLP4 232
CNSTI4 -1
ASGNI4
line 1467
;1467:		for (i = 0; i < bs->numproxmines; i++) {
ADDRLP4 220
CNSTI4 0
ASGNI4
ADDRGP4 $725
JUMPV
LABELV $722
line 1468
;1468:			BotAI_GetEntityState(bs->proxmines[i], &state);
ADDRLP4 220
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6116
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 1469
;1469:			VectorSubtract(state.pos.trBase, bs->origin, dir);
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12+12+12
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+12+12+4
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+12+12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1470
;1470:			dist = VectorLength(dir);
ADDRLP4 0
ARGP4
ADDRLP4 336
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 224
ADDRLP4 336
INDIRF4
ASGNF4
line 1471
;1471:			if (dist < bestdist) {
ADDRLP4 224
INDIRF4
ADDRLP4 228
INDIRF4
GEF4 $736
line 1472
;1472:				bestdist = dist;
ADDRLP4 228
ADDRLP4 224
INDIRF4
ASGNF4
line 1473
;1473:				bestmine = i;
ADDRLP4 232
ADDRLP4 220
INDIRI4
ASGNI4
line 1474
;1474:			}
LABELV $736
line 1475
;1475:		}
LABELV $723
line 1467
ADDRLP4 220
ADDRLP4 220
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $725
ADDRLP4 220
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6372
ADDP4
INDIRI4
LTI4 $722
line 1476
;1476:		if (bestmine != -1) {
ADDRLP4 232
INDIRI4
CNSTI4 -1
EQI4 $738
line 1482
;1477:			//
;1478:			// state->generic1 == TEAM_RED || state->generic1 == TEAM_BLUE
;1479:			//
;1480:			// deactivate prox mines in the bot's path by shooting
;1481:			// rockets or plasma cells etc. at them
;1482:			BotAI_GetEntityState(bs->proxmines[bestmine], &state);
ADDRLP4 232
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6116
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 1483
;1483:			VectorCopy(state.pos.trBase, target);
ADDRLP4 236
ADDRLP4 12+12+12
INDIRB
ASGNB 12
line 1484
;1484:			target[2] += 2;
ADDRLP4 236+8
ADDRLP4 236+8
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 1485
;1485:			VectorSubtract(target, bs->eye, dir);
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 236
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4792
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 236+4
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4796
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 236+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4800
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1486
;1486:			vectoangles(dir, moveresult->ideal_viewangles);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1488
;1487:			// if the bot has a weapon that does splash damage
;1488:			if (bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0)
ADDRLP4 336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 340
CNSTI4 0
ASGNI4
ADDRLP4 336
INDIRP4
CNSTI4 4852
ADDP4
INDIRI4
ADDRLP4 340
INDIRI4
LEI4 $747
ADDRLP4 336
INDIRP4
CNSTI4 4892
ADDP4
INDIRI4
ADDRLP4 340
INDIRI4
LEI4 $747
line 1489
;1489:				moveresult->weapon = WEAPONINDEX_PLASMAGUN;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 8
ASGNI4
ADDRGP4 $748
JUMPV
LABELV $747
line 1490
;1490:			else if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0)
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
CNSTI4 0
ASGNI4
ADDRLP4 344
INDIRP4
CNSTI4 4840
ADDP4
INDIRI4
ADDRLP4 348
INDIRI4
LEI4 $749
ADDRLP4 344
INDIRP4
CNSTI4 4900
ADDP4
INDIRI4
ADDRLP4 348
INDIRI4
LEI4 $749
line 1491
;1491:				moveresult->weapon = WEAPONINDEX_ROCKET_LAUNCHER;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 5
ASGNI4
ADDRGP4 $750
JUMPV
LABELV $749
line 1492
;1492:			else if (bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0)
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
CNSTI4 0
ASGNI4
ADDRLP4 352
INDIRP4
CNSTI4 4860
ADDP4
INDIRI4
ADDRLP4 356
INDIRI4
LEI4 $751
ADDRLP4 352
INDIRP4
CNSTI4 4908
ADDP4
INDIRI4
ADDRLP4 356
INDIRI4
LEI4 $751
line 1493
;1493:				moveresult->weapon = WEAPONINDEX_BFG;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 9
ASGNI4
ADDRGP4 $752
JUMPV
LABELV $751
line 1494
;1494:			else {
line 1495
;1495:				moveresult->weapon = 0;
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 1496
;1496:			}
LABELV $752
LABELV $750
LABELV $748
line 1497
;1497:			if (moveresult->weapon) {
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $753
line 1499
;1498:				//
;1499:				moveresult->flags |= MOVERESULT_MOVEMENTWEAPON | MOVERESULT_MOVEMENTVIEW;
ADDRLP4 360
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 360
INDIRP4
ADDRLP4 360
INDIRP4
INDIRI4
CNSTI4 17
BORI4
ASGNI4
line 1501
;1500:				// if holding the right weapon
;1501:				if (bs->cur_ps.weapon == moveresult->weapon) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
NEI4 $755
line 1503
;1502:					// if the bot is pretty close with it's aim
;1503:					if (InFieldOfVision(bs->viewangles, 20, moveresult->ideal_viewangles)) {
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 364
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 0
EQI4 $757
line 1505
;1504:						//
;1505:						BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, target, bs->entitynum, MASK_SHOT);
ADDRLP4 248
ARGP4
ADDRLP4 368
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 368
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 372
CNSTP4 0
ASGNP4
ADDRLP4 372
INDIRP4
ARGP4
ADDRLP4 372
INDIRP4
ARGP4
ADDRLP4 236
ARGP4
ADDRLP4 368
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
line 1507
;1506:						// if the mine is visible from the current position
;1507:						if (bsptrace.fraction >= 1.0 || bsptrace.ent == state.number) {
ADDRLP4 248+8
INDIRF4
CNSTF4 1065353216
GEF4 $763
ADDRLP4 248+80
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $759
LABELV $763
line 1509
;1508:							// shoot at the mine
;1509:							trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 1510
;1510:						}
LABELV $759
line 1511
;1511:					}
LABELV $757
line 1512
;1512:				}
LABELV $755
line 1513
;1513:			}
LABELV $753
line 1514
;1514:		}
LABELV $738
line 1515
;1515:	}
LABELV $720
line 1516
;1516:}
LABELV $693
endproc BotClearPath 376 28
export AIEnter_Seek_ActivateEntity
proc AIEnter_Seek_ActivateEntity 0 16
line 1523
;1517:
;1518:/*
;1519:==================
;1520:AIEnter_Seek_ActivateEntity
;1521:==================
;1522:*/
;1523:void AIEnter_Seek_ActivateEntity(bot_state_t *bs, char *s) {
line 1524
;1524:	BotRecordNodeSwitch(bs, "activate entity", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $765
ARGP4
ADDRGP4 $69
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 1525
;1525:	bs->ainode = AINode_Seek_ActivateEntity;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Seek_ActivateEntity
ASGNP4
line 1526
;1526:}
LABELV $764
endproc AIEnter_Seek_ActivateEntity 0 16
export AINode_Seek_ActivateEntity
proc AINode_Seek_ActivateEntity 372 28
line 1533
;1527:
;1528:/*
;1529:==================
;1530:AINode_Seek_Activate_Entity
;1531:==================
;1532:*/
;1533:int AINode_Seek_ActivateEntity(bot_state_t *bs) {
line 1541
;1534:	bot_goal_t *goal;
;1535:	vec3_t target, dir, ideal_viewangles;
;1536:	bot_moveresult_t moveresult;
;1537:	int targetvisible;
;1538:	bsp_trace_t bsptrace;
;1539:	aas_entityinfo_t entinfo;
;1540:
;1541:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 320
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 0
EQI4 $767
line 1542
;1542:		BotClearActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 1543
;1543:		AIEnter_Observer(bs, "active entity: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $769
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 1544
;1544:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $766
JUMPV
LABELV $767
line 1547
;1545:	}
;1546:	//if in the intermission
;1547:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 324
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $770
line 1548
;1548:		BotClearActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 1549
;1549:		AIEnter_Intermission(bs, "activate entity: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $772
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 1550
;1550:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $766
JUMPV
LABELV $770
line 1553
;1551:	}
;1552:	//respawn if dead
;1553:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 328
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $773
line 1554
;1554:		BotClearActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 1555
;1555:		AIEnter_Respawn(bs, "activate entity: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $775
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 1556
;1556:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $766
JUMPV
LABELV $773
line 1559
;1557:	}
;1558:	//
;1559:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
CNSTI4 18616254
ASGNI4
line 1560
;1560:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $776
ADDRLP4 332
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 332
INDIRP4
ADDRLP4 332
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $776
line 1562
;1561:	// if in lava or slime the bot should be able to get out
;1562:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 336
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
CNSTI4 0
EQI4 $779
ADDRLP4 340
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 340
INDIRP4
ADDRLP4 340
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $779
line 1564
;1563:	// map specific code
;1564:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 1566
;1565:	// no enemy
;1566:	bs->enemy = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
CNSTI4 -1
ASGNI4
line 1568
;1567:	// if the bot has no activate goal
;1568:	if (!bs->activatestack) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $781
line 1569
;1569:		BotClearActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 1570
;1570:		AIEnter_Seek_NBG(bs, "activate entity: no goal");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $783
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 1571
;1571:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $766
JUMPV
LABELV $781
line 1574
;1572:	}
;1573:	//
;1574:	goal = &bs->activatestack->goal;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
line 1576
;1575:	// initialize target being visible to false
;1576:	targetvisible = qfalse;
ADDRLP4 68
CNSTI4 0
ASGNI4
line 1578
;1577:	// if the bot has to shoot at a target to activate something
;1578:	if (bs->activatestack->shoot) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $784
line 1580
;1579:		//
;1580:		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->activatestack->target, bs->entitynum, MASK_SHOT);
ADDRLP4 72
ARGP4
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 348
CNSTP4 0
ASGNP4
ADDRLP4 348
INDIRP4
ARGP4
ADDRLP4 348
INDIRP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 80
ADDP4
ARGP4
ADDRLP4 344
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
line 1582
;1581:		// if the shootable entity is visible from the current position
;1582:		if (bsptrace.fraction >= 1.0 || bsptrace.ent == goal->entitynum) {
ADDRLP4 72+8
INDIRF4
CNSTF4 1065353216
GEF4 $790
ADDRLP4 72+80
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $786
LABELV $790
line 1583
;1583:			targetvisible = qtrue;
ADDRLP4 68
CNSTI4 1
ASGNI4
line 1585
;1584:			// if holding the right weapon
;1585:			if (bs->cur_ps.weapon == bs->activatestack->weapon) {
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 352
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
NEI4 $791
line 1586
;1586:				VectorSubtract(bs->activatestack->target, bs->eye, dir);
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
ADDRLP4 356
INDIRP4
CNSTI4 6976
ADDP4
ASGNP4
ADDRLP4 56
ADDRLP4 360
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ADDRLP4 356
INDIRP4
CNSTI4 4792
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 360
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ADDRLP4 356
INDIRP4
CNSTI4 4796
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 364
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56+8
ADDRLP4 364
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDRLP4 364
INDIRP4
CNSTI4 4800
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1587
;1587:				vectoangles(dir, ideal_viewangles);
ADDRLP4 56
ARGP4
ADDRLP4 308
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1589
;1588:				// if the bot is pretty close with it's aim
;1589:				if (InFieldOfVision(bs->viewangles, 20, ideal_viewangles)) {
ADDRFP4 0
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 308
ARGP4
ADDRLP4 368
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $795
line 1590
;1590:					trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 1591
;1591:				}
LABELV $795
line 1592
;1592:			}
LABELV $791
line 1593
;1593:		}
LABELV $786
line 1594
;1594:	}
LABELV $784
line 1596
;1595:	// if the shoot target is visible
;1596:	if (targetvisible) {
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $797
line 1598
;1597:		// get the entity info of the entity the bot is shooting at
;1598:		BotEntityInfo(goal->entitynum, &entinfo);
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1600
;1599:		// if the entity the bot shoots at moved
;1600:		if (!VectorCompare(bs->activatestack->origin, entinfo.origin)) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 156+24
ARGP4
ADDRLP4 344
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
NEI4 $799
line 1604
;1601:#ifdef DEBUG
;1602:			BotAI_Print(PRT_MESSAGE, "hit shootable button or trigger\n");
;1603:#endif //DEBUG
;1604:			bs->activatestack->time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1605
;1605:		}
LABELV $799
line 1607
;1606:		// if the activate goal has been activated or the bot takes too long
;1607:		if (bs->activatestack->time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $802
line 1608
;1608:			BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
line 1610
;1609:			// if there are more activate goals on the stack
;1610:			if (bs->activatestack) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $804
line 1611
;1611:				bs->activatestack->time = FloatTime() + 10;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1612
;1612:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $766
JUMPV
LABELV $804
line 1614
;1613:			}
;1614:			AIEnter_Seek_NBG(bs, "activate entity: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $806
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 1615
;1615:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $766
JUMPV
LABELV $802
line 1617
;1616:		}
;1617:		memset(&moveresult, 0, sizeof(bot_moveresult_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1618
;1618:	}
ADDRGP4 $798
JUMPV
LABELV $797
line 1619
;1619:	else {
line 1621
;1620:		// if the bot has no goal
;1621:		if (!goal) {
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $807
line 1622
;1622:			bs->activatestack->time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1623
;1623:		}
ADDRGP4 $808
JUMPV
LABELV $807
line 1625
;1624:		// if the bot does not have a shoot goal
;1625:		else if (!bs->activatestack->shoot) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
NEI4 $809
line 1627
;1626:			//if the bot touches the current goal
;1627:			if (trap_BotTouchingGoal(bs->origin, goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 344
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $811
line 1631
;1628:#ifdef DEBUG
;1629:				BotAI_Print(PRT_MESSAGE, "touched button or trigger\n");
;1630:#endif //DEBUG
;1631:				bs->activatestack->time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1632
;1632:			}
LABELV $811
line 1633
;1633:		}
LABELV $809
LABELV $808
line 1635
;1634:		// if the activate goal has been activated or the bot takes too long
;1635:		if (bs->activatestack->time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $813
line 1636
;1636:			BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
line 1638
;1637:			// if there are more activate goals on the stack
;1638:			if (bs->activatestack) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $815
line 1639
;1639:				bs->activatestack->time = FloatTime() + 10;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1640
;1640:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $766
JUMPV
LABELV $815
line 1642
;1641:			}
;1642:			AIEnter_Seek_NBG(bs, "activate entity: activated");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $817
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 1643
;1643:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $766
JUMPV
LABELV $813
line 1646
;1644:		}
;1645:		//predict obstacles
;1646:		if (BotAIPredictObstacles(bs, goal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 344
ADDRGP4 BotAIPredictObstacles
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $818
line 1647
;1647:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $766
JUMPV
LABELV $818
line 1649
;1648:		//initialize the movement state
;1649:		BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 1651
;1650:		//move towards the goal
;1651:		trap_BotMoveToGoal(&moveresult, bs->ms, goal, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 348
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 1653
;1652:		//if the movement failed
;1653:		if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $820
line 1655
;1654:			//reset the avoid reach, otherwise bot is stuck in current area
;1655:			trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 1657
;1656:			//
;1657:			bs->activatestack->time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1658
;1658:		}
LABELV $820
line 1660
;1659:		//check if the bot is blocked
;1660:		BotAIBlocked(bs, &moveresult, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 1661
;1661:	}
LABELV $798
line 1663
;1662:	//
;1663:	BotClearPath(bs, &moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotClearPath
CALLV
pop
line 1665
;1664:	// if the bot has to shoot to activate
;1665:	if (bs->activatestack->shoot) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $822
line 1667
;1666:		// if the view angles aren't yet used for the movement
;1667:		if (!(moveresult.flags & MOVERESULT_MOVEMENTVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $824
line 1668
;1668:			VectorSubtract(bs->activatestack->target, bs->eye, dir);
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
ADDRLP4 344
INDIRP4
CNSTI4 6976
ADDP4
ASGNP4
ADDRLP4 56
ADDRLP4 348
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ADDRLP4 344
INDIRP4
CNSTI4 4792
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 348
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ADDRLP4 344
INDIRP4
CNSTI4 4796
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56+8
ADDRLP4 352
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4800
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1669
;1669:			vectoangles(dir, moveresult.ideal_viewangles);
ADDRLP4 56
ARGP4
ADDRLP4 0+40
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1670
;1670:			moveresult.flags |= MOVERESULT_MOVEMENTVIEW;
ADDRLP4 0+20
ADDRLP4 0+20
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1671
;1671:		}
LABELV $824
line 1673
;1672:		// if there's no weapon yet used for the movement
;1673:		if (!(moveresult.flags & MOVERESULT_MOVEMENTWEAPON)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $831
line 1674
;1674:			moveresult.flags |= MOVERESULT_MOVEMENTWEAPON;
ADDRLP4 0+20
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1676
;1675:			//
;1676:			bs->activatestack->weapon = BotSelectActivateWeapon(bs);
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
ARGP4
ADDRLP4 348
ADDRGP4 BotSelectActivateWeapon
CALLI4
ASGNI4
ADDRLP4 344
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 348
INDIRI4
ASGNI4
line 1677
;1677:			if (bs->activatestack->weapon == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $835
line 1679
;1678:				//FIXME: find a decent weapon first
;1679:				bs->activatestack->weapon = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 76
ADDP4
CNSTI4 0
ASGNI4
line 1680
;1680:			}
LABELV $835
line 1681
;1681:			moveresult.weapon = bs->activatestack->weapon;
ADDRLP4 0+24
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ASGNI4
line 1682
;1682:		}
LABELV $831
line 1683
;1683:	}
LABELV $822
line 1685
;1684:	// if the ideal view angles are set for movement
;1685:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 11
BANDI4
CNSTI4 0
EQI4 $838
line 1686
;1686:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ADDRLP4 0+40
INDIRB
ASGNB 12
line 1687
;1687:	}
ADDRGP4 $839
JUMPV
LABELV $838
line 1689
;1688:	// if waiting for something
;1689:	else if (moveresult.flags & MOVERESULT_WAITING) {
ADDRLP4 0+20
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $842
line 1690
;1690:		if (random() < bs->thinktime * 0.8) {
ADDRLP4 344
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
MULF4
GEF4 $843
line 1691
;1691:			BotRoamGoal(bs, target);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
ARGP4
ADDRGP4 BotRoamGoal
CALLV
pop
line 1692
;1692:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 296
INDIRF4
ADDRLP4 348
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 296+4
INDIRF4
ADDRLP4 348
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 296+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1693
;1693:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 56
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1694
;1694:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 352
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTF4 1056964608
ADDRLP4 352
INDIRP4
INDIRF4
MULF4
ASGNF4
line 1695
;1695:		}
line 1696
;1696:	}
ADDRGP4 $843
JUMPV
LABELV $842
line 1697
;1697:	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $851
line 1698
;1698:		if (trap_BotMovementViewTarget(bs->ms, goal, bs->tfl, 300, target)) {
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 296
ARGP4
ADDRLP4 348
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
EQI4 $853
line 1699
;1699:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 296
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 296+4
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 296+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1700
;1700:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 56
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1701
;1701:		}
ADDRGP4 $854
JUMPV
LABELV $853
line 1702
;1702:		else {
line 1703
;1703:			vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 0+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1704
;1704:		}
LABELV $854
line 1705
;1705:		bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 352
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTF4 1056964608
ADDRLP4 352
INDIRP4
INDIRF4
MULF4
ASGNF4
line 1706
;1706:	}
LABELV $851
LABELV $843
LABELV $839
line 1708
;1707:	// if the weapon is used for the bot movement
;1708:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON)
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $860
line 1709
;1709:		bs->weaponnum = moveresult.weapon;
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
ADDRLP4 0+24
INDIRI4
ASGNI4
LABELV $860
line 1711
;1710:	// if there is an enemy
;1711:	if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 344
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $864
line 1712
;1712:		if (BotWantsToRetreat(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 348
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
EQI4 $866
line 1714
;1713:			//keep the current long term goal and retreat
;1714:			AIEnter_Battle_NBG(bs, "activate entity: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $868
ARGP4
ADDRGP4 AIEnter_Battle_NBG
CALLV
pop
line 1715
;1715:		}
ADDRGP4 $867
JUMPV
LABELV $866
line 1716
;1716:		else {
line 1717
;1717:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 1719
;1718:			//empty the goal stack
;1719:			trap_BotEmptyGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEmptyGoalStack
CALLV
pop
line 1721
;1720:			//go fight
;1721:			AIEnter_Battle_Fight(bs, "activate entity: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $868
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 1722
;1722:		}
LABELV $867
line 1723
;1723:		BotClearActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 1724
;1724:	}
LABELV $864
line 1725
;1725:	return qtrue;
CNSTI4 1
RETI4
LABELV $766
endproc AINode_Seek_ActivateEntity 372 28
export AIEnter_Seek_NBG
proc AIEnter_Seek_NBG 204 16
line 1733
;1726:}
;1727:
;1728:/*
;1729:==================
;1730:AIEnter_Seek_NBG
;1731:==================
;1732:*/
;1733:void AIEnter_Seek_NBG(bot_state_t *bs, char *s) {
line 1737
;1734:	bot_goal_t goal;
;1735:	char buf[144];
;1736:
;1737:	if (trap_BotGetTopGoal(bs->gs, &goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 200
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $870
line 1738
;1738:		trap_BotGoalName(goal.number, buf, 144);
ADDRLP4 0+44
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 1739
;1739:		BotRecordNodeSwitch(bs, "seek NBG", buf, s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $873
ARGP4
ADDRLP4 56
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 1740
;1740:	}
ADDRGP4 $871
JUMPV
LABELV $870
line 1741
;1741:	else {
line 1742
;1742:		BotRecordNodeSwitch(bs, "seek NBG", "no goal", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $873
ARGP4
ADDRGP4 $874
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 1743
;1743:	}
LABELV $871
line 1744
;1744:	bs->ainode = AINode_Seek_NBG;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Seek_NBG
ASGNP4
line 1745
;1745:}
LABELV $869
endproc AIEnter_Seek_NBG 204 16
export AINode_Seek_NBG
proc AINode_Seek_NBG 192 20
line 1752
;1746:
;1747:/*
;1748:==================
;1749:AINode_Seek_NBG
;1750:==================
;1751:*/
;1752:int AINode_Seek_NBG(bot_state_t *bs) {
line 1757
;1753:	bot_goal_t goal;
;1754:	vec3_t target, dir;
;1755:	bot_moveresult_t moveresult;
;1756:
;1757:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $876
line 1758
;1758:		AIEnter_Observer(bs, "seek nbg: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $878
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 1759
;1759:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $875
JUMPV
LABELV $876
line 1762
;1760:	}
;1761:	//if in the intermission
;1762:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $879
line 1763
;1763:		AIEnter_Intermission(bs, "seek nbg: intermision");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $881
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 1764
;1764:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $875
JUMPV
LABELV $879
line 1767
;1765:	}
;1766:	//respawn if dead
;1767:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $882
line 1768
;1768:		AIEnter_Respawn(bs, "seek nbg: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $884
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 1769
;1769:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $875
JUMPV
LABELV $882
line 1772
;1770:	}
;1771:	//
;1772:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
CNSTI4 18616254
ASGNI4
line 1773
;1773:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $885
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $885
line 1775
;1774:	//if in lava or slime the bot should be able to get out
;1775:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $888
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $888
line 1777
;1776:	//
;1777:	if (BotCanAndWantsToRocketJump(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotCanAndWantsToRocketJump
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $890
line 1778
;1778:		bs->tfl |= TFL_ROCKETJUMP;
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1779
;1779:	}
LABELV $890
line 1781
;1780:	//map specific code
;1781:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 1783
;1782:	//no enemy
;1783:	bs->enemy = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
CNSTI4 -1
ASGNI4
line 1785
;1784:	//if the bot has no goal
;1785:	if (!trap_BotGetTopGoal(bs->gs, &goal)) bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $892
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $893
JUMPV
LABELV $892
line 1787
;1786:	//if the bot touches the current goal
;1787:	else if (BotReachedGoal(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 164
ADDRGP4 BotReachedGoal
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $894
line 1788
;1788:		BotChooseWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
line 1789
;1789:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
CNSTF4 0
ASGNF4
line 1790
;1790:	}
LABELV $894
LABELV $893
line 1792
;1791:	//
;1792:	if (bs->nbg_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $896
line 1794
;1793:		//pop the current goal from the stack
;1794:		trap_BotPopGoal(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotPopGoal
CALLV
pop
line 1797
;1795:		//check for new nearby items right away
;1796:		//NOTE: we canNOT reset the check_time to zero because it would create an endless loop of node switches
;1797:		bs->check_time = FloatTime() + 0.05;
ADDRFP4 0
INDIRP4
CNSTI4 5948
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1028443341
ADDF4
ASGNF4
line 1799
;1798:		//go back to seek ltg
;1799:		AIEnter_Seek_LTG(bs, "seek nbg: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $898
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 1800
;1800:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $875
JUMPV
LABELV $896
line 1803
;1801:	}
;1802:	//predict obstacles
;1803:	if (BotAIPredictObstacles(bs, &goal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 168
ADDRGP4 BotAIPredictObstacles
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $899
line 1804
;1804:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $875
JUMPV
LABELV $899
line 1806
;1805:	//initialize the movement state
;1806:	BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 1808
;1807:	//move towards the goal
;1808:	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 172
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 1810
;1809:	//if the movement failed
;1810:	if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $901
line 1812
;1811:		//reset the avoid reach, otherwise bot is stuck in current area
;1812:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 1813
;1813:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
CNSTF4 0
ASGNF4
line 1814
;1814:	}
LABELV $901
line 1816
;1815:	//check if the bot is blocked
;1816:	BotAIBlocked(bs, &moveresult, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 1818
;1817:	//
;1818:	BotClearPath(bs, &moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotClearPath
CALLV
pop
line 1820
;1819:	//if the viewangles are used for the movement
;1820:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 11
BANDI4
CNSTI4 0
EQI4 $903
line 1821
;1821:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ADDRLP4 0+40
INDIRB
ASGNB 12
line 1822
;1822:	}
ADDRGP4 $904
JUMPV
LABELV $903
line 1824
;1823:	//if waiting for something
;1824:	else if (moveresult.flags & MOVERESULT_WAITING) {
ADDRLP4 0+20
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $907
line 1825
;1825:		if (random() < bs->thinktime * 0.8) {
ADDRLP4 176
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
MULF4
GEF4 $908
line 1826
;1826:			BotRoamGoal(bs, target);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ARGP4
ADDRGP4 BotRoamGoal
CALLV
pop
line 1827
;1827:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
ADDRLP4 108
INDIRF4
ADDRLP4 180
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120+4
ADDRLP4 108+4
INDIRF4
ADDRLP4 180
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120+8
ADDRLP4 108+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1828
;1828:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1829
;1829:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 184
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 184
INDIRP4
CNSTF4 1056964608
ADDRLP4 184
INDIRP4
INDIRF4
MULF4
ASGNF4
line 1830
;1830:		}
line 1831
;1831:	}
ADDRGP4 $908
JUMPV
LABELV $907
line 1832
;1832:	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $916
line 1833
;1833:		if (!trap_BotGetSecondGoal(bs->gs, &goal)) trap_BotGetTopGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 176
ADDRGP4 trap_BotGetSecondGoal
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $918
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRGP4 trap_BotGetTopGoal
CALLI4
pop
LABELV $918
line 1834
;1834:		if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
ADDRLP4 180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 180
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 180
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 108
ARGP4
ADDRLP4 184
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $920
line 1835
;1835:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
ADDRLP4 108
INDIRF4
ADDRLP4 188
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120+4
ADDRLP4 108+4
INDIRF4
ADDRLP4 188
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 120+8
ADDRLP4 108+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1836
;1836:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1837
;1837:		}
ADDRGP4 $921
JUMPV
LABELV $920
line 1839
;1838:		//FIXME: look at cluster portals?
;1839:		else vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 0+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
LABELV $921
line 1840
;1840:		bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 188
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 188
INDIRP4
CNSTF4 1056964608
ADDRLP4 188
INDIRP4
INDIRF4
MULF4
ASGNF4
line 1841
;1841:	}
LABELV $916
LABELV $908
LABELV $904
line 1843
;1842:	//if the weapon is used for the bot movement
;1843:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $927
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
ADDRLP4 0+24
INDIRI4
ASGNI4
LABELV $927
line 1845
;1844:	//if there is an enemy
;1845:	if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 176
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $931
line 1846
;1846:		if (BotWantsToRetreat(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $933
line 1848
;1847:			//keep the current long term goal and retreat
;1848:			AIEnter_Battle_NBG(bs, "seek nbg: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $935
ARGP4
ADDRGP4 AIEnter_Battle_NBG
CALLV
pop
line 1849
;1849:		}
ADDRGP4 $934
JUMPV
LABELV $933
line 1850
;1850:		else {
line 1851
;1851:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 1853
;1852:			//empty the goal stack
;1853:			trap_BotEmptyGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEmptyGoalStack
CALLV
pop
line 1855
;1854:			//go fight
;1855:			AIEnter_Battle_Fight(bs, "seek nbg: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $935
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 1856
;1856:		}
LABELV $934
line 1857
;1857:	}
LABELV $931
line 1858
;1858:	return qtrue;
CNSTI4 1
RETI4
LABELV $875
endproc AINode_Seek_NBG 192 20
export AIEnter_Seek_LTG
proc AIEnter_Seek_LTG 204 16
line 1866
;1859:}
;1860:
;1861:/*
;1862:==================
;1863:AIEnter_Seek_LTG
;1864:==================
;1865:*/
;1866:void AIEnter_Seek_LTG(bot_state_t *bs, char *s) {
line 1870
;1867:	bot_goal_t goal;
;1868:	char buf[144];
;1869:
;1870:	if (trap_BotGetTopGoal(bs->gs, &goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 200
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $937
line 1871
;1871:		trap_BotGoalName(goal.number, buf, 144);
ADDRLP4 0+44
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 1872
;1872:		BotRecordNodeSwitch(bs, "seek LTG", buf, s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $940
ARGP4
ADDRLP4 56
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 1873
;1873:	}
ADDRGP4 $938
JUMPV
LABELV $937
line 1874
;1874:	else {
line 1875
;1875:		BotRecordNodeSwitch(bs, "seek LTG", "no goal", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $940
ARGP4
ADDRGP4 $874
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 1876
;1876:	}
LABELV $938
line 1877
;1877:	bs->ainode = AINode_Seek_LTG;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Seek_LTG
ASGNP4
line 1878
;1878:}
LABELV $936
endproc AIEnter_Seek_LTG 204 16
export AINode_Seek_LTG
proc AINode_Seek_LTG 212 20
line 1886
;1879:
;1880:/*
;1881:==================
;1882:AINode_Seek_LTG
;1883:==================
;1884:*/
;1885:int AINode_Seek_LTG(bot_state_t *bs)
;1886:{
line 1894
;1887:	bot_goal_t goal;
;1888:	vec3_t target, dir;
;1889:	bot_moveresult_t moveresult;
;1890:	int range;
;1891:	//char buf[128];
;1892:	//bot_goal_t tmpgoal;
;1893:
;1894:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $942
line 1895
;1895:		AIEnter_Observer(bs, "seek ltg: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $944
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 1896
;1896:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $941
JUMPV
LABELV $942
line 1899
;1897:	}
;1898:	//if in the intermission
;1899:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $945
line 1900
;1900:		AIEnter_Intermission(bs, "seek ltg: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $947
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 1901
;1901:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $941
JUMPV
LABELV $945
line 1904
;1902:	}
;1903:	//respawn if dead
;1904:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $948
line 1905
;1905:		AIEnter_Respawn(bs, "seek ltg: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $950
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 1906
;1906:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $941
JUMPV
LABELV $948
line 1909
;1907:	}
;1908:	//
;1909:	if (BotChat_Random(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 BotChat_Random
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $951
line 1910
;1910:		bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 152
INDIRP4
CNSTI4 5952
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 156
INDIRF4
ADDF4
ASGNF4
line 1911
;1911:		AIEnter_Stand(bs, "seek ltg: random chat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $953
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 1912
;1912:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $941
JUMPV
LABELV $951
line 1915
;1913:	}
;1914:	//
;1915:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
CNSTI4 18616254
ASGNI4
line 1916
;1916:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $954
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $954
line 1918
;1917:	//if in lava or slime the bot should be able to get out
;1918:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $957
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $957
line 1920
;1919:	//
;1920:	if (BotCanAndWantsToRocketJump(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotCanAndWantsToRocketJump
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $959
line 1921
;1921:		bs->tfl |= TFL_ROCKETJUMP;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1922
;1922:	}
LABELV $959
line 1924
;1923:	//map specific code
;1924:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 1926
;1925:	//no enemy
;1926:	bs->enemy = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
CNSTI4 -1
ASGNI4
line 1928
;1927:	//
;1928:	if (bs->killedenemy_time > FloatTime() - 2) {
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $961
line 1929
;1929:		if (random() < bs->thinktime * 1) {
ADDRLP4 168
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1065353216
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
MULF4
GEF4 $963
line 1930
;1930:			trap_EA_Gesture(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Gesture
CALLV
pop
line 1931
;1931:		}
LABELV $963
line 1932
;1932:	}
LABELV $961
line 1934
;1933:	//if there is an enemy
;1934:	if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 168
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $965
line 1935
;1935:		if (BotWantsToRetreat(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $967
line 1937
;1936:			//keep the current long term goal and retreat
;1937:			AIEnter_Battle_Retreat(bs, "seek ltg: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $969
ARGP4
ADDRGP4 AIEnter_Battle_Retreat
CALLV
pop
line 1938
;1938:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $941
JUMPV
LABELV $967
line 1940
;1939:		}
;1940:		else {
line 1941
;1941:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 1943
;1942:			//empty the goal stack
;1943:			trap_BotEmptyGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEmptyGoalStack
CALLV
pop
line 1945
;1944:			//go fight
;1945:			AIEnter_Battle_Fight(bs, "seek ltg: found enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $969
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 1946
;1946:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $941
JUMPV
LABELV $965
line 1950
;1947:		}
;1948:	}
;1949:	//
;1950:	BotTeamGoals(bs, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotTeamGoals
CALLV
pop
line 1952
;1951:	//get the current long term goal
;1952:	if (!BotLongTermGoal(bs, bs->tfl, qfalse, &goal)) {
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 176
ADDRGP4 BotLongTermGoal
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $970
line 1953
;1953:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $941
JUMPV
LABELV $970
line 1956
;1954:	}
;1955:	//check for nearby goals periodicly
;1956:	if (bs->check_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5948
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $972
line 1957
;1957:		bs->check_time = FloatTime() + 0.5;
ADDRFP4 0
INDIRP4
CNSTI4 5948
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1959
;1958:		//check if the bot wants to camp
;1959:		BotWantsToCamp(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotWantsToCamp
CALLI4
pop
line 1961
;1960:		//
;1961:		if (bs->ltgtype == LTG_DEFENDKEYAREA) range = 400;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
INDIRI4
CNSTI4 3
NEI4 $974
ADDRLP4 108
CNSTI4 400
ASGNI4
ADDRGP4 $975
JUMPV
LABELV $974
line 1962
;1962:		else range = 150;
ADDRLP4 108
CNSTI4 150
ASGNI4
LABELV $975
line 1965
;1963:		//
;1964:#ifdef CTF
;1965:		if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $976
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 184
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
NEI4 $976
line 1967
;1966:			//if carrying a flag the bot shouldn't be distracted too much
;1967:			if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $977
line 1968
;1968:				range = 50;
ADDRLP4 108
CNSTI4 50
ASGNI4
line 1969
;1969:		}
ADDRGP4 $977
JUMPV
LABELV $976
line 1971
;1970:#endif //CTF
;1971:		else if (G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 188
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $980
line 1972
;1972:			if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $981
line 1973
;1973:				range = 50;
ADDRLP4 108
CNSTI4 50
ASGNI4
line 1974
;1974:		}
ADDRGP4 $981
JUMPV
LABELV $980
line 1975
;1975:		else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $984
line 1976
;1976:			if (BotHarvesterCarryingCubes(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $986
line 1977
;1977:				range = 80;
ADDRLP4 108
CNSTI4 80
ASGNI4
LABELV $986
line 1978
;1978:		}
LABELV $984
LABELV $981
LABELV $977
line 1980
;1979:		//
;1980:		if (BotNearbyGoal(bs, bs->tfl, &goal, range)) {
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
ARGP4
ADDRLP4 192
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 108
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 196
ADDRGP4 BotNearbyGoal
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $988
line 1981
;1981:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 1987
;1982:			//get the goal at the top of the stack
;1983:			//trap_BotGetTopGoal(bs->gs, &tmpgoal);
;1984:			//trap_BotGoalName(tmpgoal.number, buf, 144);
;1985:			//BotAI_Print(PRT_MESSAGE, "new nearby goal %s\n", buf);
;1986:			//time the bot gets to pick up the nearby goal item
;1987:			bs->nbg_time = FloatTime() + 4 + range * 0.01;
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1082130432
ADDF4
CNSTF4 1008981770
ADDRLP4 108
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 1988
;1988:			AIEnter_Seek_NBG(bs, "ltg seek: nbg");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $990
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 1989
;1989:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $941
JUMPV
LABELV $988
line 1991
;1990:		}
;1991:	}
LABELV $972
line 1993
;1992:	//predict obstacles
;1993:	if (BotAIPredictObstacles(bs, &goal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 180
ADDRGP4 BotAIPredictObstacles
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $991
line 1994
;1994:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $941
JUMPV
LABELV $991
line 1996
;1995:	//initialize the movement state
;1996:	BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 1998
;1997:	//move towards the goal
;1998:	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 184
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 184
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2000
;1999:	//if the movement failed
;2000:	if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $993
line 2002
;2001:		//reset the avoid reach, otherwise bot is stuck in current area
;2002:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 2004
;2003:		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
;2004:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
CNSTF4 0
ASGNF4
line 2005
;2005:	}
LABELV $993
line 2007
;2006:	//
;2007:	BotAIBlocked(bs, &moveresult, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 2009
;2008:	//
;2009:	BotClearPath(bs, &moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotClearPath
CALLV
pop
line 2011
;2010:	//if the viewangles are used for the movement
;2011:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 11
BANDI4
CNSTI4 0
EQI4 $995
line 2012
;2012:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ADDRLP4 0+40
INDIRB
ASGNB 12
line 2013
;2013:	}
ADDRGP4 $996
JUMPV
LABELV $995
line 2015
;2014:	//if waiting for something
;2015:	else if (moveresult.flags & MOVERESULT_WAITING) {
ADDRLP4 0+20
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $999
line 2016
;2016:		if (random() < bs->thinktime * 0.8) {
ADDRLP4 188
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
MULF4
GEF4 $1000
line 2017
;2017:			BotRoamGoal(bs, target);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ARGP4
ADDRGP4 BotRoamGoal
CALLV
pop
line 2018
;2018:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 112
INDIRF4
ADDRLP4 192
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 112+4
INDIRF4
ADDRLP4 192
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 112+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2019
;2019:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 124
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2020
;2020:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTF4 1056964608
ADDRLP4 196
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2021
;2021:		}
line 2022
;2022:	}
ADDRGP4 $1000
JUMPV
LABELV $999
line 2023
;2023:	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1008
line 2024
;2024:		if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 188
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 112
ARGP4
ADDRLP4 192
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $1010
line 2025
;2025:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 112
INDIRF4
ADDRLP4 196
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 112+4
INDIRF4
ADDRLP4 196
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 112+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2026
;2026:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 124
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2027
;2027:		}
ADDRGP4 $1011
JUMPV
LABELV $1010
line 2029
;2028:		//FIXME: look at cluster portals?
;2029:		else if (VectorLengthSquared(moveresult.movedir)) {
ADDRLP4 0+28
ARGP4
ADDRLP4 196
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 196
INDIRF4
CNSTF4 0
EQF4 $1016
line 2030
;2030:			vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 0+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2031
;2031:		}
ADDRGP4 $1017
JUMPV
LABELV $1016
line 2032
;2032:		else if (random() < bs->thinktime * 0.8) {
ADDRLP4 200
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1061997773
ADDRFP4 0
INDIRP4
CNSTI4 4760
ADDP4
INDIRF4
MULF4
GEF4 $1020
line 2033
;2033:			BotRoamGoal(bs, target);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ARGP4
ADDRGP4 BotRoamGoal
CALLV
pop
line 2034
;2034:			VectorSubtract(target, bs->origin, dir);
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 112
INDIRF4
ADDRLP4 204
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 112+4
INDIRF4
ADDRLP4 204
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 112+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2035
;2035:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 124
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2036
;2036:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 208
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTF4 1056964608
ADDRLP4 208
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2037
;2037:		}
LABELV $1020
LABELV $1017
LABELV $1011
line 2038
;2038:		bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 204
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 204
INDIRP4
CNSTF4 1056964608
ADDRLP4 204
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2039
;2039:	}
LABELV $1008
LABELV $1000
LABELV $996
line 2041
;2040:	//if the weapon is used for the bot movement
;2041:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1026
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
ADDRLP4 0+24
INDIRI4
ASGNI4
LABELV $1026
line 2043
;2042:	//
;2043:	return qtrue;
CNSTI4 1
RETI4
LABELV $941
endproc AINode_Seek_LTG 212 20
export AIEnter_Battle_Fight
proc AIEnter_Battle_Fight 4 16
line 2051
;2044:}
;2045:
;2046:/*
;2047:==================
;2048:AIEnter_Battle_Fight
;2049:==================
;2050:*/
;2051:void AIEnter_Battle_Fight(bot_state_t *bs, char *s) {
line 2052
;2052:	BotRecordNodeSwitch(bs, "battle fight", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1031
ARGP4
ADDRGP4 $69
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2053
;2053:	trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 2054
;2054:	bs->ainode = AINode_Battle_Fight;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Battle_Fight
ASGNP4
line 2055
;2055:	bs->flags &= ~BFL_FIGHTSUICIDAL;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 2056
;2056:}
LABELV $1030
endproc AIEnter_Battle_Fight 4 16
export AIEnter_Battle_SuicidalFight
proc AIEnter_Battle_SuicidalFight 4 16
line 2063
;2057:
;2058:/*
;2059:==================
;2060:AIEnter_Battle_SuicidalFight
;2061:==================
;2062:*/
;2063:void AIEnter_Battle_SuicidalFight(bot_state_t *bs, char *s) {
line 2064
;2064:	BotRecordNodeSwitch(bs, "battle fight", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1031
ARGP4
ADDRGP4 $69
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2065
;2065:	trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 2066
;2066:	bs->ainode = AINode_Battle_Fight;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Battle_Fight
ASGNP4
line 2067
;2067:	bs->flags |= BFL_FIGHTSUICIDAL;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 2068
;2068:}
LABELV $1032
endproc AIEnter_Battle_SuicidalFight 4 16
export AINode_Battle_Fight
proc AINode_Battle_Fight 292 20
line 2075
;2069:
;2070:/*
;2071:==================
;2072:AINode_Battle_Fight
;2073:==================
;2074:*/
;2075:int AINode_Battle_Fight(bot_state_t *bs) {
line 2081
;2076:	int areanum;
;2077:	vec3_t target;
;2078:	aas_entityinfo_t entinfo;
;2079:	bot_moveresult_t moveresult;
;2080:
;2081:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $1034
line 2082
;2082:		AIEnter_Observer(bs, "battle fight: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1036
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 2083
;2083:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1033
JUMPV
LABELV $1034
line 2087
;2084:	}
;2085:
;2086:	//if in the intermission
;2087:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 212
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
EQI4 $1037
line 2088
;2088:		AIEnter_Intermission(bs, "battle fight: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1039
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 2089
;2089:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1033
JUMPV
LABELV $1037
line 2092
;2090:	}
;2091:	//respawn if dead
;2092:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 216
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
EQI4 $1040
line 2093
;2093:		AIEnter_Respawn(bs, "battle fight: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1042
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 2094
;2094:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1033
JUMPV
LABELV $1040
line 2097
;2095:	}
;2096:	//if there is another better enemy
;2097:	if (BotFindEnemy(bs, bs->enemy)) {
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
INDIRP4
ARGP4
ADDRLP4 220
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 224
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 0
EQI4 $1043
line 2101
;2098:#ifdef DEBUG
;2099:		BotAI_Print(PRT_MESSAGE, "found new better enemy\n");
;2100:#endif
;2101:	}
LABELV $1043
line 2103
;2102:	//if no enemy
;2103:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1045
line 2104
;2104:		AIEnter_Seek_LTG(bs, "battle fight: no enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1047
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2105
;2105:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1033
JUMPV
LABELV $1045
line 2108
;2106:	}
;2107:	//
;2108:	BotEntityInfo(bs->enemy, &entinfo);
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
line 2110
;2109:	//if the enemy is dead
;2110:	if (bs->enemydeath_time) {
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1048
line 2111
;2111:		if (bs->enemydeath_time < FloatTime() - 1.0) {
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1049
line 2112
;2112:			bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
CNSTF4 0
ASGNF4
line 2113
;2113:			if (bs->enemysuicide) {
ADDRFP4 0
INDIRP4
CNSTI4 5868
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1052
line 2114
;2114:				BotChat_EnemySuicide(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChat_EnemySuicide
CALLI4
pop
line 2115
;2115:			}
LABELV $1052
line 2116
;2116:			if (bs->lastkilledplayer == bs->enemy && BotChat_Kill(bs)) {
ADDRLP4 228
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 228
INDIRP4
CNSTI4 5848
ADDP4
INDIRI4
ADDRLP4 228
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
NEI4 $1054
ADDRLP4 228
INDIRP4
ARGP4
ADDRLP4 232
ADDRGP4 BotChat_Kill
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
EQI4 $1054
line 2117
;2117:				bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 236
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 236
INDIRP4
ARGP4
ADDRLP4 240
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 236
INDIRP4
CNSTI4 5952
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 240
INDIRF4
ADDF4
ASGNF4
line 2118
;2118:				AIEnter_Stand(bs, "battle fight: enemy dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1056
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 2119
;2119:			}
ADDRGP4 $1055
JUMPV
LABELV $1054
line 2120
;2120:			else {
line 2121
;2121:				bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
CNSTF4 0
ASGNF4
line 2122
;2122:				AIEnter_Seek_LTG(bs, "battle fight: enemy dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1056
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2123
;2123:			}
LABELV $1055
line 2124
;2124:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1033
JUMPV
line 2126
;2125:		}
;2126:	}
LABELV $1048
line 2127
;2127:	else {
line 2128
;2128:		if (EntityIsDead(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 228
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 228
INDIRI4
CNSTI4 0
EQI4 $1057
line 2129
;2129:			bs->enemydeath_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2130
;2130:		}
LABELV $1057
line 2131
;2131:	}
LABELV $1049
line 2133
;2132:	//if the enemy is invisible and not shooting the bot looses track easily
;2133:	if (EntityIsInvisible(&entinfo) && !EntityIsShooting(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 228
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 228
INDIRI4
CNSTI4 0
EQI4 $1059
ADDRLP4 0
ARGP4
ADDRLP4 232
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
NEI4 $1059
line 2134
;2134:		if (random() < 0.2) {
ADDRLP4 236
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1045220557
GEF4 $1061
line 2135
;2135:			AIEnter_Seek_LTG(bs, "battle fight: invisible");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1063
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2136
;2136:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1033
JUMPV
LABELV $1061
line 2138
;2137:		}
;2138:	}
LABELV $1059
line 2140
;2139:	//
;2140:	VectorCopy(entinfo.origin, target);
ADDRLP4 196
ADDRLP4 0+24
INDIRB
ASGNB 12
line 2142
;2141:	// if not a player enemy
;2142:	if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1065
line 2144
;2143:		// if attacking an obelisk
;2144:		if ( bs->enemy == redobelisk.entitynum ||
ADDRLP4 236
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ASGNI4
ADDRLP4 236
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1071
ADDRLP4 236
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
NEI4 $1067
LABELV $1071
line 2145
;2145:			bs->enemy == blueobelisk.entitynum ) {
line 2146
;2146:			target[2] += 16;
ADDRLP4 196+8
ADDRLP4 196+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2147
;2147:		}
LABELV $1067
line 2148
;2148:	}
LABELV $1065
line 2150
;2149:	//update the reachability area and origin if possible
;2150:	areanum = BotPointAreaNum(target);
ADDRLP4 196
ARGP4
ADDRLP4 236
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 192
ADDRLP4 236
INDIRI4
ASGNI4
line 2151
;2151:	if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $1073
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 244
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 0
EQI4 $1073
line 2152
;2152:		VectorCopy(target, bs->lastenemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 6404
ADDP4
ADDRLP4 196
INDIRB
ASGNB 12
line 2153
;2153:		bs->lastenemyareanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6400
ADDP4
ADDRLP4 192
INDIRI4
ASGNI4
line 2154
;2154:	}
LABELV $1073
line 2156
;2155:	//update the attack inventory values
;2156:	BotUpdateBattleInventory(bs, bs->enemy);
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 248
INDIRP4
ARGP4
ADDRLP4 248
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 2158
;2157:	//if the bot's health decreased
;2158:	if (bs->lastframe_health > bs->inventory[INVENTORY_HEALTH]) {
ADDRLP4 252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
INDIRP4
CNSTI4 5900
ADDP4
INDIRI4
ADDRLP4 252
INDIRP4
CNSTI4 4924
ADDP4
INDIRI4
LEI4 $1075
line 2159
;2159:		if (BotChat_HitNoDeath(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
ADDRGP4 BotChat_HitNoDeath
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
EQI4 $1077
line 2160
;2160:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 260
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 260
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 260
INDIRP4
CNSTI4 5952
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 264
INDIRF4
ADDF4
ASGNF4
line 2161
;2161:			AIEnter_Stand(bs, "battle fight: chat health decreased");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1079
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 2162
;2162:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1033
JUMPV
LABELV $1077
line 2164
;2163:		}
;2164:	}
LABELV $1075
line 2166
;2165:	//if the bot hit someone
;2166:	if (bs->cur_ps.persistant[PERS_HITS] > bs->lasthitcount) {
ADDRLP4 256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 256
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ADDRLP4 256
INDIRP4
CNSTI4 5904
ADDP4
INDIRI4
LEI4 $1080
line 2167
;2167:		if (BotChat_HitNoKill(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
ADDRGP4 BotChat_HitNoKill
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $1082
line 2168
;2168:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 264
INDIRP4
CNSTI4 5952
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 268
INDIRF4
ADDF4
ASGNF4
line 2169
;2169:			AIEnter_Stand(bs, "battle fight: chat hit someone");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1084
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 2170
;2170:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1033
JUMPV
LABELV $1082
line 2172
;2171:		}
;2172:	}
LABELV $1080
line 2174
;2173:	//if the enemy is not visible
;2174:	if (!BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy)) {
ADDRLP4 260
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 260
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 260
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 260
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 264
INDIRF4
CNSTF4 0
NEF4 $1085
line 2181
;2175:#ifdef MISSIONPACK
;2176:		if (bs->enemy == redobelisk.entitynum || bs->enemy == blueobelisk.entitynum) {
;2177:			AIEnter_Battle_Chase(bs, "battle fight: obelisk out of sight");
;2178:			return qfalse;
;2179:		}
;2180:#endif
;2181:		if (BotWantsToChase(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotWantsToChase
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $1087
line 2182
;2182:			AIEnter_Battle_Chase(bs, "battle fight: enemy out of sight");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1089
ARGP4
ADDRGP4 AIEnter_Battle_Chase
CALLV
pop
line 2183
;2183:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1033
JUMPV
LABELV $1087
line 2185
;2184:		}
;2185:		else {
line 2186
;2186:			AIEnter_Seek_LTG(bs, "battle fight: enemy out of sight");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1089
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2187
;2187:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1033
JUMPV
LABELV $1085
line 2191
;2188:		}
;2189:	}
;2190:	//use holdable items
;2191:	BotBattleUseItems(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotBattleUseItems
CALLV
pop
line 2193
;2192:	//
;2193:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
CNSTI4 18616254
ASGNI4
line 2194
;2194:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1090
ADDRLP4 268
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ADDRLP4 268
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1090
line 2196
;2195:	//if in lava or slime the bot should be able to get out
;2196:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $1093
ADDRLP4 276
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 276
INDIRP4
ADDRLP4 276
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1093
line 2198
;2197:	//
;2198:	if (BotCanAndWantsToRocketJump(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 BotCanAndWantsToRocketJump
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $1095
line 2199
;2199:		bs->tfl |= TFL_ROCKETJUMP;
ADDRLP4 284
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
ADDRLP4 284
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 2200
;2200:	}
LABELV $1095
line 2202
;2201:	//choose the best weapon to fight with
;2202:	BotChooseWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
line 2204
;2203:	//do attack movements
;2204:	moveresult = BotAttackMove(bs, bs->tfl);
ADDRLP4 140
ARGP4
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
ARGP4
ADDRLP4 284
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAttackMove
CALLV
pop
line 2206
;2205:	//if the movement failed
;2206:	if (moveresult.failure) {
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1097
line 2208
;2207:		//reset the avoid reach, otherwise bot is stuck in current area
;2208:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 2210
;2209:		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
;2210:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
CNSTF4 0
ASGNF4
line 2211
;2211:	}
LABELV $1097
line 2213
;2212:	//
;2213:	BotAIBlocked(bs, &moveresult, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 2215
;2214:	//aim at the enemy
;2215:	BotAimAtEnemy(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotAimAtEnemy
CALLV
pop
line 2217
;2216:	//attack the enemy if possible
;2217:	BotCheckAttack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAttack
CALLV
pop
line 2219
;2218:	//if the bot wants to retreat
;2219:	if (!(bs->flags & BFL_FIGHTSUICIDAL)) {
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $1099
line 2220
;2220:		if (BotWantsToRetreat(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 288
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $1101
line 2221
;2221:			AIEnter_Battle_Retreat(bs, "battle fight: wants to retreat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1103
ARGP4
ADDRGP4 AIEnter_Battle_Retreat
CALLV
pop
line 2222
;2222:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1033
JUMPV
LABELV $1101
line 2224
;2223:		}
;2224:	}
LABELV $1099
line 2225
;2225:	return qtrue;
CNSTI4 1
RETI4
LABELV $1033
endproc AINode_Battle_Fight 292 20
export AIEnter_Battle_Chase
proc AIEnter_Battle_Chase 0 16
line 2233
;2226:}
;2227:
;2228:/*
;2229:==================
;2230:AIEnter_Battle_Chase
;2231:==================
;2232:*/
;2233:void AIEnter_Battle_Chase(bot_state_t *bs, char *s) {
line 2234
;2234:	BotRecordNodeSwitch(bs, "battle chase", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1105
ARGP4
ADDRGP4 $69
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2235
;2235:	bs->chase_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 5940
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2236
;2236:	bs->ainode = AINode_Battle_Chase;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Battle_Chase
ASGNP4
line 2237
;2237:}
LABELV $1104
endproc AIEnter_Battle_Chase 0 16
export AINode_Battle_Chase
proc AINode_Battle_Chase 204 20
line 2245
;2238:
;2239:/*
;2240:==================
;2241:AINode_Battle_Chase
;2242:==================
;2243:*/
;2244:int AINode_Battle_Chase(bot_state_t *bs)
;2245:{
line 2251
;2246:	bot_goal_t goal;
;2247:	vec3_t target, dir;
;2248:	bot_moveresult_t moveresult;
;2249:	float range;
;2250:
;2251:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $1107
line 2252
;2252:		AIEnter_Observer(bs, "battle chase: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1109
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 2253
;2253:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1106
JUMPV
LABELV $1107
line 2256
;2254:	}
;2255:	//if in the intermission
;2256:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1110
line 2257
;2257:		AIEnter_Intermission(bs, "battle chase: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1112
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 2258
;2258:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1106
JUMPV
LABELV $1110
line 2261
;2259:	}
;2260:	//respawn if dead
;2261:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1113
line 2262
;2262:		AIEnter_Respawn(bs, "battle chase: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1115
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 2263
;2263:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1106
JUMPV
LABELV $1113
line 2266
;2264:	}
;2265:	//if no enemy
;2266:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1116
line 2267
;2267:		AIEnter_Seek_LTG(bs, "battle chase: no enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1118
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2268
;2268:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1106
JUMPV
LABELV $1116
line 2271
;2269:	}
;2270:	//if the enemy is visible
;2271:	if (BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy)) {
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 148
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 148
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 0
EQF4 $1119
line 2272
;2272:		AIEnter_Battle_Fight(bs, "battle chase");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1105
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 2273
;2273:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1106
JUMPV
LABELV $1119
line 2276
;2274:	}
;2275:	//if there is another enemy
;2276:	if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 156
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $1121
line 2277
;2277:		AIEnter_Battle_Fight(bs, "battle chase: better enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1123
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 2278
;2278:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1106
JUMPV
LABELV $1121
line 2281
;2279:	}
;2280:	//there is no last enemy area
;2281:	if (!bs->lastenemyareanum) {
ADDRFP4 0
INDIRP4
CNSTI4 6400
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1124
line 2282
;2282:		AIEnter_Seek_LTG(bs, "battle chase: no enemy area");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1126
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2283
;2283:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1106
JUMPV
LABELV $1124
line 2286
;2284:	}
;2285:	//
;2286:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
CNSTI4 18616254
ASGNI4
line 2287
;2287:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1127
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1127
line 2289
;2288:	//if in lava or slime the bot should be able to get out
;2289:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $1130
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1130
line 2291
;2290:	//
;2291:	if (BotCanAndWantsToRocketJump(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotCanAndWantsToRocketJump
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $1132
line 2292
;2292:		bs->tfl |= TFL_ROCKETJUMP;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 2293
;2293:	}
LABELV $1132
line 2295
;2294:	//map specific code
;2295:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 2297
;2296:	//create the chase goal
;2297:	goal.entitynum = bs->enemy;
ADDRLP4 0+40
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ASGNI4
line 2298
;2298:	goal.areanum = bs->lastenemyareanum;
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 6400
ADDP4
INDIRI4
ASGNI4
line 2299
;2299:	VectorCopy(bs->lastenemyorigin, goal.origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6404
ADDP4
INDIRB
ASGNB 12
line 2300
;2300:	VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 0+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 0+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0+16+8
CNSTF4 3238002688
ASGNF4
line 2301
;2301:	VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 0+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 0+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0+28+8
CNSTF4 1090519040
ASGNF4
line 2303
;2302:	//if the last seen enemy spot is reached the enemy could not be found
;2303:	if (trap_BotTouchingGoal(bs->origin, &goal)) bs->chase_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4764
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 176
ADDRGP4 trap_BotTouchingGoal
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $1146
ADDRFP4 0
INDIRP4
CNSTI4 5940
ADDP4
CNSTF4 0
ASGNF4
LABELV $1146
line 2305
;2304:	//if there's no chase time left
;2305:	if (!bs->chase_time || bs->chase_time < FloatTime() - 10) {
ADDRLP4 180
ADDRFP4 0
INDIRP4
CNSTI4 5940
ADDP4
INDIRF4
ASGNF4
ADDRLP4 180
INDIRF4
CNSTF4 0
EQF4 $1150
ADDRLP4 180
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
SUBF4
GEF4 $1148
LABELV $1150
line 2306
;2306:		AIEnter_Seek_LTG(bs, "battle chase: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1151
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2307
;2307:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1106
JUMPV
LABELV $1148
line 2310
;2308:	}
;2309:	//check for nearby goals periodicly
;2310:	if (bs->check_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5948
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1152
line 2311
;2311:		bs->check_time = FloatTime() + 1;
ADDRFP4 0
INDIRP4
CNSTI4 5948
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2312
;2312:		range = 150;
ADDRLP4 108
CNSTF4 1125515264
ASGNF4
line 2314
;2313:		//
;2314:		if (BotNearbyGoal(bs, bs->tfl, &goal, range)) {
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 184
INDIRP4
ARGP4
ADDRLP4 184
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 108
INDIRF4
ARGF4
ADDRLP4 188
ADDRGP4 BotNearbyGoal
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $1154
line 2316
;2315:			//the bot gets 5 seconds to pick up the nearby goal item
;2316:			bs->nbg_time = FloatTime() + 0.1 * range + 1;
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1036831949
ADDRLP4 108
INDIRF4
MULF4
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2317
;2317:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 2318
;2318:			AIEnter_Battle_NBG(bs, "battle chase: nbg");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1156
ARGP4
ADDRGP4 AIEnter_Battle_NBG
CALLV
pop
line 2319
;2319:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1106
JUMPV
LABELV $1154
line 2321
;2320:		}
;2321:	}
LABELV $1152
line 2323
;2322:	//
;2323:	BotUpdateBattleInventory(bs, bs->enemy);
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 184
INDIRP4
ARGP4
ADDRLP4 184
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 2325
;2324:	//initialize the movement state
;2325:	BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2327
;2326:	//move towards the goal
;2327:	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
ADDRLP4 56
ARGP4
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 188
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2329
;2328:	//if the movement failed
;2329:	if (moveresult.failure) {
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $1157
line 2331
;2330:		//reset the avoid reach, otherwise bot is stuck in current area
;2331:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 2333
;2332:		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
;2333:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
CNSTF4 0
ASGNF4
line 2334
;2334:	}
LABELV $1157
line 2336
;2335:	//
;2336:	BotAIBlocked(bs, &moveresult, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 2338
;2337:	//
;2338:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEWSET|MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 56+20
INDIRI4
CNSTI4 11
BANDI4
CNSTI4 0
EQI4 $1159
line 2339
;2339:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ADDRLP4 56+40
INDIRB
ASGNB 12
line 2340
;2340:	}
ADDRGP4 $1160
JUMPV
LABELV $1159
line 2341
;2341:	else if (!(bs->flags & BFL_IDEALVIEWSET)) {
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1163
line 2342
;2342:		if (bs->chase_time > FloatTime() - 2) {
ADDRFP4 0
INDIRP4
CNSTI4 5940
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $1165
line 2343
;2343:			BotAimAtEnemy(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotAimAtEnemy
CALLV
pop
line 2344
;2344:		}
ADDRGP4 $1166
JUMPV
LABELV $1165
line 2345
;2345:		else {
line 2346
;2346:			if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 192
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 112
ARGP4
ADDRLP4 196
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $1167
line 2347
;2347:				VectorSubtract(target, bs->origin, dir);
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 112
INDIRF4
ADDRLP4 200
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 112+4
INDIRF4
ADDRLP4 200
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 112+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2348
;2348:				vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 124
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2349
;2349:			}
ADDRGP4 $1168
JUMPV
LABELV $1167
line 2350
;2350:			else {
line 2351
;2351:				vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 56+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2352
;2352:			}
LABELV $1168
line 2353
;2353:		}
LABELV $1166
line 2354
;2354:		bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 192
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTF4 1056964608
ADDRLP4 192
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2355
;2355:	}
LABELV $1163
LABELV $1160
line 2357
;2356:	//if the weapon is used for the bot movement
;2357:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
ADDRLP4 56+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1174
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
ADDRLP4 56+24
INDIRI4
ASGNI4
LABELV $1174
line 2359
;2358:	//if the bot is in the area the enemy was last seen in
;2359:	if (bs->areanum == bs->lastenemyareanum) bs->chase_time = 0;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 4804
ADDP4
INDIRI4
ADDRLP4 192
INDIRP4
CNSTI4 6400
ADDP4
INDIRI4
NEI4 $1178
ADDRFP4 0
INDIRP4
CNSTI4 5940
ADDP4
CNSTF4 0
ASGNF4
LABELV $1178
line 2361
;2360:	//if the bot wants to retreat (the bot could have been damage during the chase)
;2361:	if (BotWantsToRetreat(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $1180
line 2362
;2362:		AIEnter_Battle_Retreat(bs, "battle chase: wants to retreat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1182
ARGP4
ADDRGP4 AIEnter_Battle_Retreat
CALLV
pop
line 2363
;2363:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1106
JUMPV
LABELV $1180
line 2365
;2364:	}
;2365:	return qtrue;
CNSTI4 1
RETI4
LABELV $1106
endproc AINode_Battle_Chase 204 20
export AIEnter_Battle_Retreat
proc AIEnter_Battle_Retreat 0 16
line 2373
;2366:}
;2367:
;2368:/*
;2369:==================
;2370:AIEnter_Battle_Retreat
;2371:==================
;2372:*/
;2373:void AIEnter_Battle_Retreat(bot_state_t *bs, char *s) {
line 2374
;2374:	BotRecordNodeSwitch(bs, "battle retreat", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1184
ARGP4
ADDRGP4 $69
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2375
;2375:	bs->ainode = AINode_Battle_Retreat;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Battle_Retreat
ASGNP4
line 2376
;2376:}
LABELV $1183
endproc AIEnter_Battle_Retreat 0 16
export AINode_Battle_Retreat
proc AINode_Battle_Retreat 368 20
line 2383
;2377:
;2378:/*
;2379:==================
;2380:AINode_Battle_Retreat
;2381:==================
;2382:*/
;2383:int AINode_Battle_Retreat(bot_state_t *bs) {
line 2391
;2384:	bot_goal_t goal;
;2385:	aas_entityinfo_t entinfo;
;2386:	bot_moveresult_t moveresult;
;2387:	vec3_t target, dir;
;2388:	float attack_skill, range;
;2389:	int areanum;
;2390:
;2391:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
EQI4 $1186
line 2392
;2392:		AIEnter_Observer(bs, "battle retreat: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1188
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 2393
;2393:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1185
JUMPV
LABELV $1186
line 2396
;2394:	}
;2395:	//if in the intermission
;2396:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 288
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $1189
line 2397
;2397:		AIEnter_Intermission(bs, "battle retreat: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1191
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 2398
;2398:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1185
JUMPV
LABELV $1189
line 2401
;2399:	}
;2400:	//respawn if dead
;2401:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 292
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $1192
line 2402
;2402:		AIEnter_Respawn(bs, "battle retreat: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1194
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 2403
;2403:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1185
JUMPV
LABELV $1192
line 2406
;2404:	}
;2405:	//if no enemy
;2406:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1195
line 2407
;2407:		AIEnter_Seek_LTG(bs, "battle retreat: no enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1197
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2408
;2408:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1185
JUMPV
LABELV $1195
line 2411
;2409:	}
;2410:	//
;2411:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2412
;2412:	if (EntityIsDead(&entinfo)) {
ADDRLP4 108
ARGP4
ADDRLP4 296
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
EQI4 $1198
line 2413
;2413:		AIEnter_Seek_LTG(bs, "battle retreat: enemy dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1200
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2414
;2414:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1185
JUMPV
LABELV $1198
line 2417
;2415:	}
;2416:	//if there is another better enemy
;2417:	if (BotFindEnemy(bs, bs->enemy)) {
ADDRLP4 300
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 300
INDIRP4
ARGP4
ADDRLP4 300
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 304
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $1201
line 2421
;2418:#ifdef DEBUG
;2419:		BotAI_Print(PRT_MESSAGE, "found new better enemy\n");
;2420:#endif
;2421:	}
LABELV $1201
line 2423
;2422:	//
;2423:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
CNSTI4 18616254
ASGNI4
line 2424
;2424:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1203
ADDRLP4 308
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 308
INDIRP4
ADDRLP4 308
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1203
line 2426
;2425:	//if in lava or slime the bot should be able to get out
;2426:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 312
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $1206
ADDRLP4 316
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 316
INDIRP4
ADDRLP4 316
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1206
line 2428
;2427:	//map specific code
;2428:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 2430
;2429:	//update the attack inventory values
;2430:	BotUpdateBattleInventory(bs, bs->enemy);
ADDRLP4 320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 320
INDIRP4
ARGP4
ADDRLP4 320
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 2432
;2431:	//if the bot doesn't want to retreat anymore... probably picked up some nice items
;2432:	if (BotWantsToChase(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 324
ADDRGP4 BotWantsToChase
CALLI4
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $1208
line 2434
;2433:		//empty the goal stack, when chasing, only the enemy is the goal
;2434:		trap_BotEmptyGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotEmptyGoalStack
CALLV
pop
line 2436
;2435:		//go chase the enemy
;2436:		AIEnter_Battle_Chase(bs, "battle retreat: wants to chase");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1210
ARGP4
ADDRGP4 AIEnter_Battle_Chase
CALLV
pop
line 2437
;2437:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1185
JUMPV
LABELV $1208
line 2440
;2438:	}
;2439:	//update the last time the enemy was visible
;2440:	if (BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy)) {
ADDRLP4 328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 328
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 328
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 328
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 328
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 332
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 332
INDIRF4
CNSTF4 0
EQF4 $1211
line 2441
;2441:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 5944
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2442
;2442:		VectorCopy(entinfo.origin, target);
ADDRLP4 252
ADDRLP4 108+24
INDIRB
ASGNB 12
line 2444
;2443:		// if not a player enemy
;2444:		if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1214
line 2446
;2445:			// if attacking an obelisk
;2446:			if ( bs->enemy == redobelisk.entitynum ||
ADDRLP4 336
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ASGNI4
ADDRLP4 336
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1220
ADDRLP4 336
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
NEI4 $1216
LABELV $1220
line 2447
;2447:				bs->enemy == blueobelisk.entitynum ) {
line 2448
;2448:				target[2] += 16;
ADDRLP4 252+8
ADDRLP4 252+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2449
;2449:			}
LABELV $1216
line 2450
;2450:		}
LABELV $1214
line 2452
;2451:		//update the reachability area and origin if possible
;2452:		areanum = BotPointAreaNum(target);
ADDRLP4 252
ARGP4
ADDRLP4 336
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 248
ADDRLP4 336
INDIRI4
ASGNI4
line 2453
;2453:		if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 340
ADDRLP4 248
INDIRI4
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 0
EQI4 $1222
ADDRLP4 340
INDIRI4
ARGI4
ADDRLP4 344
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $1222
line 2454
;2454:			VectorCopy(target, bs->lastenemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 6404
ADDP4
ADDRLP4 252
INDIRB
ASGNB 12
line 2455
;2455:			bs->lastenemyareanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6400
ADDP4
ADDRLP4 248
INDIRI4
ASGNI4
line 2456
;2456:		}
LABELV $1222
line 2457
;2457:	}
LABELV $1211
line 2459
;2458:	//if the enemy is NOT visible for 4 seconds
;2459:	if (bs->enemyvisible_time < FloatTime() - 4) {
ADDRFP4 0
INDIRP4
CNSTI4 5944
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1082130432
SUBF4
GEF4 $1224
line 2460
;2460:		AIEnter_Seek_LTG(bs, "battle retreat: lost enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1226
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 2461
;2461:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1185
JUMPV
LABELV $1224
line 2464
;2462:	}
;2463:	//else if the enemy is NOT visible
;2464:	else if (bs->enemyvisible_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5944
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1227
line 2466
;2465:		//if there is another enemy
;2466:		if (BotFindEnemy(bs, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 336
ADDRGP4 BotFindEnemy
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
CNSTI4 0
EQI4 $1229
line 2467
;2467:			AIEnter_Battle_Fight(bs, "battle retreat: another enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1231
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
line 2468
;2468:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1185
JUMPV
LABELV $1229
line 2470
;2469:		}
;2470:	}
LABELV $1227
line 2472
;2471:	//
;2472:	BotTeamGoals(bs, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotTeamGoals
CALLV
pop
line 2474
;2473:	//use holdable items
;2474:	BotBattleUseItems(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotBattleUseItems
CALLV
pop
line 2476
;2475:	//get the current long term goal while retreating
;2476:	if (!BotLongTermGoal(bs, bs->tfl, qtrue, &goal)) {
ADDRLP4 336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 336
INDIRP4
ARGP4
ADDRLP4 336
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 340
ADDRGP4 BotLongTermGoal
CALLI4
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 0
NEI4 $1232
line 2477
;2477:		AIEnter_Battle_SuicidalFight(bs, "battle retreat: no way out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1234
ARGP4
ADDRGP4 AIEnter_Battle_SuicidalFight
CALLV
pop
line 2478
;2478:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1185
JUMPV
LABELV $1232
line 2481
;2479:	}
;2480:	//check for nearby goals periodicly
;2481:	if (bs->check_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5948
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1235
line 2482
;2482:		bs->check_time = FloatTime() + 1;
ADDRFP4 0
INDIRP4
CNSTI4 5948
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2483
;2483:		range = 150;
ADDRLP4 264
CNSTF4 1125515264
ASGNF4
line 2485
;2484:#ifdef CTF
;2485:		if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 344
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $1237
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 348
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
NEI4 $1237
line 2487
;2486:			//if carrying a flag the bot shouldn't be distracted too much
;2487:			if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 352
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 0
EQI4 $1238
line 2488
;2488:				range = 50;
ADDRLP4 264
CNSTF4 1112014848
ASGNF4
line 2489
;2489:		}
ADDRGP4 $1238
JUMPV
LABELV $1237
line 2491
;2490:#endif //CTF
;2491:		else if (G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 352
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 0
EQI4 $1241
line 2492
;2492:			if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 356
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $1242
line 2493
;2493:				range = 50;
ADDRLP4 264
CNSTF4 1112014848
ASGNF4
line 2494
;2494:		}
ADDRGP4 $1242
JUMPV
LABELV $1241
line 2495
;2495:		else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $1245
line 2496
;2496:			if (BotHarvesterCarryingCubes(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 356
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $1247
line 2497
;2497:				range = 80;
ADDRLP4 264
CNSTF4 1117782016
ASGNF4
LABELV $1247
line 2498
;2498:		}
LABELV $1245
LABELV $1242
LABELV $1238
line 2500
;2499:		//
;2500:		if (BotNearbyGoal(bs, bs->tfl, &goal, range)) {
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 356
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 264
INDIRF4
ARGF4
ADDRLP4 360
ADDRGP4 BotNearbyGoal
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
EQI4 $1249
line 2501
;2501:			trap_BotResetLastAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetLastAvoidReach
CALLV
pop
line 2503
;2502:			//time the bot gets to pick up the nearby goal item
;2503:			bs->nbg_time = FloatTime() + range / 100 + 1;
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 264
INDIRF4
CNSTF4 1120403456
DIVF4
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2504
;2504:			AIEnter_Battle_NBG(bs, "battle retreat: nbg");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1251
ARGP4
ADDRGP4 AIEnter_Battle_NBG
CALLV
pop
line 2505
;2505:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1185
JUMPV
LABELV $1249
line 2507
;2506:		}
;2507:	}
LABELV $1235
line 2509
;2508:	//initialize the movement state
;2509:	BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2511
;2510:	//move towards the goal
;2511:	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2513
;2512:	//if the movement failed
;2513:	if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1252
line 2515
;2514:		//reset the avoid reach, otherwise bot is stuck in current area
;2515:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 2517
;2516:		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
;2517:		bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5924
ADDP4
CNSTF4 0
ASGNF4
line 2518
;2518:	}
LABELV $1252
line 2520
;2519:	//
;2520:	BotAIBlocked(bs, &moveresult, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 2522
;2521:	//choose the best weapon to fight with
;2522:	BotChooseWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
line 2524
;2523:	//if the view is fixed for the movement
;2524:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1254
line 2525
;2525:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ADDRLP4 0+40
INDIRB
ASGNB 12
line 2526
;2526:	}
ADDRGP4 $1255
JUMPV
LABELV $1254
line 2527
;2527:	else if (!(moveresult.flags & MOVERESULT_MOVEMENTVIEWSET)
ADDRLP4 348
CNSTI4 0
ASGNI4
ADDRLP4 0+20
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 348
INDIRI4
NEI4 $1258
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
INDIRI4
CNSTI4 32
BANDI4
ADDRLP4 348
INDIRI4
NEI4 $1258
line 2528
;2528:				&& !(bs->flags & BFL_IDEALVIEWSET) ) {
line 2529
;2529:		attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 0
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
ADDRLP4 352
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 268
ADDRLP4 352
INDIRF4
ASGNF4
line 2531
;2530:		//if the bot is skilled anough
;2531:		if (attack_skill > 0.3) {
ADDRLP4 268
INDIRF4
CNSTF4 1050253722
LEF4 $1261
line 2532
;2532:			BotAimAtEnemy(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotAimAtEnemy
CALLV
pop
line 2533
;2533:		}
ADDRGP4 $1262
JUMPV
LABELV $1261
line 2534
;2534:		else {
line 2535
;2535:			if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 356
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 252
ARGP4
ADDRLP4 360
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
EQI4 $1263
line 2536
;2536:				VectorSubtract(target, bs->origin, dir);
ADDRLP4 364
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
ADDRLP4 252
INDIRF4
ADDRLP4 364
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 272+4
ADDRLP4 252+4
INDIRF4
ADDRLP4 364
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 272+8
ADDRLP4 252+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2537
;2537:				vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 272
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2538
;2538:			}
ADDRGP4 $1264
JUMPV
LABELV $1263
line 2539
;2539:			else {
line 2540
;2540:				vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 0+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2541
;2541:			}
LABELV $1264
line 2542
;2542:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 364
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 364
INDIRP4
CNSTF4 1056964608
ADDRLP4 364
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2543
;2543:		}
LABELV $1262
line 2544
;2544:	}
LABELV $1258
LABELV $1255
line 2546
;2545:	//if the weapon is used for the bot movement
;2546:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1270
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
ADDRLP4 0+24
INDIRI4
ASGNI4
LABELV $1270
line 2548
;2547:	//attack the enemy if possible
;2548:	BotCheckAttack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAttack
CALLV
pop
line 2550
;2549:	//
;2550:	return qtrue;
CNSTI4 1
RETI4
LABELV $1185
endproc AINode_Battle_Retreat 368 20
export AIEnter_Battle_NBG
proc AIEnter_Battle_NBG 0 16
line 2558
;2551:}
;2552:
;2553:/*
;2554:==================
;2555:AIEnter_Battle_NBG
;2556:==================
;2557:*/
;2558:void AIEnter_Battle_NBG(bot_state_t *bs, char *s) {
line 2559
;2559:	BotRecordNodeSwitch(bs, "battle NBG", "", s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1275
ARGP4
ADDRGP4 $69
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRecordNodeSwitch
CALLV
pop
line 2560
;2560:	bs->ainode = AINode_Battle_NBG;
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ADDRGP4 AINode_Battle_NBG
ASGNP4
line 2561
;2561:}
LABELV $1274
endproc AIEnter_Battle_NBG 0 16
export AINode_Battle_NBG
proc AINode_Battle_NBG 356 20
line 2568
;2562:
;2563:/*
;2564:==================
;2565:AINode_Battle_NBG
;2566:==================
;2567:*/
;2568:int AINode_Battle_NBG(bot_state_t *bs) {
line 2576
;2569:	int areanum;
;2570:	bot_goal_t goal;
;2571:	aas_entityinfo_t entinfo;
;2572:	bot_moveresult_t moveresult;
;2573:	float attack_skill;
;2574:	vec3_t target, dir;
;2575:
;2576:	if (BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $1277
line 2577
;2577:		AIEnter_Observer(bs, "battle nbg: observer");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1279
ARGP4
ADDRGP4 AIEnter_Observer
CALLV
pop
line 2578
;2578:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1277
line 2581
;2579:	}
;2580:	//if in the intermission
;2581:	if (BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
EQI4 $1280
line 2582
;2582:		AIEnter_Intermission(bs, "battle nbg: intermission");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1282
ARGP4
ADDRGP4 AIEnter_Intermission
CALLV
pop
line 2583
;2583:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1280
line 2586
;2584:	}
;2585:	//respawn if dead
;2586:	if (BotIsDead(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 288
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $1283
line 2587
;2587:		AIEnter_Respawn(bs, "battle nbg: bot dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1285
ARGP4
ADDRGP4 AIEnter_Respawn
CALLV
pop
line 2588
;2588:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1283
line 2591
;2589:	}
;2590:	//if no enemy
;2591:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1286
line 2592
;2592:		AIEnter_Seek_NBG(bs, "battle nbg: no enemy");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1288
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 2593
;2593:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1286
line 2596
;2594:	}
;2595:	//
;2596:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2597
;2597:	if (EntityIsDead(&entinfo)) {
ADDRLP4 108
ARGP4
ADDRLP4 292
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $1289
line 2598
;2598:		AIEnter_Seek_NBG(bs, "battle nbg: enemy dead");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1291
ARGP4
ADDRGP4 AIEnter_Seek_NBG
CALLV
pop
line 2599
;2599:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1289
line 2602
;2600:	}
;2601:	//
;2602:	bs->tfl = TFL_DEFAULT;
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
CNSTI4 18616254
ASGNI4
line 2603
;2603:	if (bot_grapple.integer) bs->tfl |= TFL_GRAPPLEHOOK;
ADDRGP4 bot_grapple+12
INDIRI4
CNSTI4 0
EQI4 $1292
ADDRLP4 296
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 296
INDIRP4
ADDRLP4 296
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
LABELV $1292
line 2605
;2604:	//if in lava or slime the bot should be able to get out
;2605:	if (BotInLavaOrSlime(bs)) bs->tfl |= TFL_LAVA|TFL_SLIME;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 BotInLavaOrSlime
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $1295
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 304
INDIRP4
ADDRLP4 304
INDIRP4
INDIRI4
CNSTI4 6291456
BORI4
ASGNI4
LABELV $1295
line 2607
;2606:	//
;2607:	if (BotCanAndWantsToRocketJump(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
ADDRGP4 BotCanAndWantsToRocketJump
CALLI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $1297
line 2608
;2608:		bs->tfl |= TFL_ROCKETJUMP;
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 5832
ADDP4
ASGNP4
ADDRLP4 312
INDIRP4
ADDRLP4 312
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 2609
;2609:	}
LABELV $1297
line 2611
;2610:	//map specific code
;2611:	BotMapScripts(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotMapScripts
CALLV
pop
line 2613
;2612:	//update the last time the enemy was visible
;2613:	if (BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy)) {
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 312
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
INDIRP4
CNSTI4 4792
ADDP4
ARGP4
ADDRLP4 312
INDIRP4
CNSTI4 6420
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 312
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRLP4 316
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 316
INDIRF4
CNSTF4 0
EQF4 $1299
line 2614
;2614:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 5944
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2615
;2615:		VectorCopy(entinfo.origin, target);
ADDRLP4 252
ADDRLP4 108+24
INDIRB
ASGNB 12
line 2617
;2616:		// if not a player enemy
;2617:		if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1302
line 2619
;2618:			// if attacking an obelisk
;2619:			if ( bs->enemy == redobelisk.entitynum ||
ADDRLP4 320
ADDRFP4 0
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ASGNI4
ADDRLP4 320
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1308
ADDRLP4 320
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
NEI4 $1304
LABELV $1308
line 2620
;2620:				bs->enemy == blueobelisk.entitynum ) {
line 2621
;2621:				target[2] += 16;
ADDRLP4 252+8
ADDRLP4 252+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2622
;2622:			}
LABELV $1304
line 2623
;2623:		}
LABELV $1302
line 2625
;2624:		//update the reachability area and origin if possible
;2625:		areanum = BotPointAreaNum(target);
ADDRLP4 252
ARGP4
ADDRLP4 320
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 248
ADDRLP4 320
INDIRI4
ASGNI4
line 2626
;2626:		if (areanum && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 324
ADDRLP4 248
INDIRI4
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $1310
ADDRLP4 324
INDIRI4
ARGI4
ADDRLP4 328
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $1310
line 2627
;2627:			VectorCopy(target, bs->lastenemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 6404
ADDP4
ADDRLP4 252
INDIRB
ASGNB 12
line 2628
;2628:			bs->lastenemyareanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6400
ADDP4
ADDRLP4 248
INDIRI4
ASGNI4
line 2629
;2629:		}
LABELV $1310
line 2630
;2630:	}
LABELV $1299
line 2632
;2631:	//if the bot has no goal or touches the current goal
;2632:	if (!trap_BotGetTopGoal(bs->gs, &goal)) {
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 320
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 0
NEI4 $1312
line 2633
;2633:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
CNSTF4 0
ASGNF4
line 2634
;2634:	}
ADDRGP4 $1313
JUMPV
LABELV $1312
line 2635
;2635:	else if (BotReachedGoal(bs, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 324
ADDRGP4 BotReachedGoal
CALLI4
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $1314
line 2636
;2636:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
CNSTF4 0
ASGNF4
line 2637
;2637:	}
LABELV $1314
LABELV $1313
line 2639
;2638:	//
;2639:	if (bs->nbg_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1316
line 2641
;2640:		//pop the current goal from the stack
;2641:		trap_BotPopGoal(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotPopGoal
CALLV
pop
line 2643
;2642:		//if the bot still has a goal
;2643:		if (trap_BotGetTopGoal(bs->gs, &goal))
ADDRFP4 0
INDIRP4
CNSTI4 6384
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 328
ADDRGP4 trap_BotGetTopGoal
CALLI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $1318
line 2644
;2644:			AIEnter_Battle_Retreat(bs, "battle nbg: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1320
ARGP4
ADDRGP4 AIEnter_Battle_Retreat
CALLV
pop
ADDRGP4 $1319
JUMPV
LABELV $1318
line 2646
;2645:		else
;2646:			AIEnter_Battle_Fight(bs, "battle nbg: time out");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1320
ARGP4
ADDRGP4 AIEnter_Battle_Fight
CALLV
pop
LABELV $1319
line 2648
;2647:		//
;2648:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1316
line 2651
;2649:	}
;2650:	//initialize the movement state
;2651:	BotSetupForMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2653
;2652:	//move towards the goal
;2653:	trap_BotMoveToGoal(&moveresult, bs->ms, &goal, bs->tfl);
ADDRLP4 0
ARGP4
ADDRLP4 328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 328
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 328
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2655
;2654:	//if the movement failed
;2655:	if (moveresult.failure) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1321
line 2657
;2656:		//reset the avoid reach, otherwise bot is stuck in current area
;2657:		trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
line 2659
;2658:		//BotAI_Print(PRT_MESSAGE, "movement failure %d\n", moveresult.traveltype);
;2659:		bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5928
ADDP4
CNSTF4 0
ASGNF4
line 2660
;2660:	}
LABELV $1321
line 2662
;2661:	//
;2662:	BotAIBlocked(bs, &moveresult, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotAIBlocked
CALLV
pop
line 2664
;2663:	//update the attack inventory values
;2664:	BotUpdateBattleInventory(bs, bs->enemy);
ADDRLP4 332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 332
INDIRP4
ARGP4
ADDRLP4 332
INDIRP4
CNSTI4 6396
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 2666
;2665:	//choose the best weapon to fight with
;2666:	BotChooseWeapon(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotChooseWeapon
CALLV
pop
line 2668
;2667:	//if the view is fixed for the movement
;2668:	if (moveresult.flags & (MOVERESULT_MOVEMENTVIEW|MOVERESULT_SWIMVIEW)) {
ADDRLP4 0+20
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1323
line 2669
;2669:		VectorCopy(moveresult.ideal_viewangles, bs->ideal_viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ADDRLP4 0+40
INDIRB
ASGNB 12
line 2670
;2670:	}
ADDRGP4 $1324
JUMPV
LABELV $1323
line 2671
;2671:	else if (!(moveresult.flags & MOVERESULT_MOVEMENTVIEWSET)
ADDRLP4 336
CNSTI4 0
ASGNI4
ADDRLP4 0+20
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 336
INDIRI4
NEI4 $1327
ADDRFP4 0
INDIRP4
CNSTI4 5836
ADDP4
INDIRI4
CNSTI4 32
BANDI4
ADDRLP4 336
INDIRI4
NEI4 $1327
line 2672
;2672:				&& !(bs->flags & BFL_IDEALVIEWSET)) {
line 2673
;2673:		attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 0
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
ADDRLP4 340
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 264
ADDRLP4 340
INDIRF4
ASGNF4
line 2675
;2674:		//if the bot is skilled anough and the enemy is visible
;2675:		if (attack_skill > 0.3) {
ADDRLP4 264
INDIRF4
CNSTF4 1050253722
LEF4 $1330
line 2677
;2676:			//&& BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy)
;2677:			BotAimAtEnemy(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotAimAtEnemy
CALLV
pop
line 2678
;2678:		}
ADDRGP4 $1331
JUMPV
LABELV $1330
line 2679
;2679:		else {
line 2680
;2680:			if (trap_BotMovementViewTarget(bs->ms, &goal, bs->tfl, 300, target)) {
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
CNSTI4 6380
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 5832
ADDP4
INDIRI4
ARGI4
CNSTF4 1133903872
ARGF4
ADDRLP4 252
ARGP4
ADDRLP4 348
ADDRGP4 trap_BotMovementViewTarget
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
EQI4 $1332
line 2681
;2681:				VectorSubtract(target, bs->origin, dir);
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
ADDRLP4 252
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4764
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 268+4
ADDRLP4 252+4
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4768
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 268+8
ADDRLP4 252+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4772
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2682
;2682:				vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 268
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2683
;2683:			}
ADDRGP4 $1333
JUMPV
LABELV $1332
line 2684
;2684:			else {
line 2685
;2685:				vectoangles(moveresult.movedir, bs->ideal_viewangles);
ADDRLP4 0+28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6432
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2686
;2686:			}
LABELV $1333
line 2687
;2687:			bs->ideal_viewangles[2] *= 0.5;
ADDRLP4 352
ADDRFP4 0
INDIRP4
CNSTI4 6440
ADDP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTF4 1056964608
ADDRLP4 352
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2688
;2688:		}
LABELV $1331
line 2689
;2689:	}
LABELV $1327
LABELV $1324
line 2691
;2690:	//if the weapon is used for the bot movement
;2691:	if (moveresult.flags & MOVERESULT_MOVEMENTWEAPON) bs->weaponnum = moveresult.weapon;
ADDRLP4 0+20
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1339
ADDRFP4 0
INDIRP4
CNSTI4 6416
ADDP4
ADDRLP4 0+24
INDIRI4
ASGNI4
LABELV $1339
line 2693
;2692:	//attack the enemy if possible
;2693:	BotCheckAttack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAttack
CALLV
pop
line 2695
;2694:	//
;2695:	return qtrue;
CNSTI4 1
RETI4
LABELV $1276
endproc AINode_Battle_NBG 356 20
import dom_points_bot
bss
export nodeswitch
align 1
LABELV nodeswitch
skip 7344
export numnodeswitches
align 4
LABELV numnodeswitches
skip 4
import BotVoiceChatOnly
import BotVoiceChat
import BotSetTeamMateTaskPreference
import BotGetTeamMateTaskPreference
import BotTeamAI
import AIEnter_Seek_Camp
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
LABELV $1320
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $1291
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1288
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1285
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1282
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1279
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1275
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 78
byte 1 66
byte 1 71
byte 1 0
align 1
LABELV $1251
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 0
align 1
LABELV $1234
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $1231
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 97
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1226
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 108
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1210
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1200
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1197
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1194
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1191
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1188
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1184
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $1182
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $1156
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 0
align 1
LABELV $1151
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $1126
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $1123
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 98
byte 1 101
byte 1 116
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1118
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1115
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1112
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1109
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1105
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1103
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $1089
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 115
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1084
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 115
byte 1 111
byte 1 109
byte 1 101
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $1079
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 32
byte 1 100
byte 1 101
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1063
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1056
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1047
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $1042
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1039
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1036
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1031
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $990
byte 1 108
byte 1 116
byte 1 103
byte 1 32
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 58
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 0
align 1
LABELV $969
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 108
byte 1 116
byte 1 103
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $953
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 108
byte 1 116
byte 1 103
byte 1 58
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $950
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 108
byte 1 116
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $947
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 108
byte 1 116
byte 1 103
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $944
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 108
byte 1 116
byte 1 103
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $940
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 76
byte 1 84
byte 1 71
byte 1 0
align 1
LABELV $935
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $898
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $884
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $881
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $878
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 110
byte 1 98
byte 1 103
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $874
byte 1 110
byte 1 111
byte 1 32
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $873
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 78
byte 1 66
byte 1 71
byte 1 0
align 1
LABELV $868
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $817
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $806
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $783
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $775
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $772
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $769
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $765
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $663
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $655
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $653
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $650
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $640
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $638
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $634
byte 1 111
byte 1 98
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $632
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $624
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $593
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $590
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 95
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $580
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $511
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
LABELV $510
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $473
byte 1 111
byte 1 110
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $472
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $438
byte 1 111
byte 1 110
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $437
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $428
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 95
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $415
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $414
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 0
align 1
LABELV $381
byte 1 105
byte 1 110
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $380
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $371
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 95
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $366
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $358
byte 1 103
byte 1 101
byte 1 116
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 103
byte 1 111
byte 1 116
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $355
byte 1 103
byte 1 101
byte 1 116
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $350
byte 1 103
byte 1 101
byte 1 116
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $343
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $340
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $329
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $326
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
LABELV $325
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $314
byte 1 100
byte 1 100
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 95
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 98
byte 1 0
align 1
LABELV $303
byte 1 100
byte 1 100
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 95
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 97
byte 1 0
align 1
LABELV $294
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 95
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $285
byte 1 66
byte 1 111
byte 1 116
byte 1 76
byte 1 111
byte 1 110
byte 1 103
byte 1 84
byte 1 101
byte 1 114
byte 1 109
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 103
byte 1 111
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 105
byte 1 114
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
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $170
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 95
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $167
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $141
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $140
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $71
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 50
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 58
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
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $69
byte 1 0
align 1
LABELV $68
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $63
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
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 65
byte 1 73
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
