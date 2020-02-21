export BotValidTeamLeader
code
proc BotValidTeamLeader 8 4
file "../../../code/game/ai_team.c"
line 72
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
;25: * name:		ai_team.c
;26: *
;27: * desc:		Quake3 bot AI
;28: *
;29: * $Archive: /MissionPack/code/game/ai_team.c $
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
;50:#include "ai_vcmd.h"
;51:
;52:#include "match.h"
;53:
;54:// for the voice chats
;55:#include "../../ui/menudef.h"
;56:
;57://ctf task preferences for a client
;58:typedef struct bot_ctftaskpreference_s
;59:{
;60:	char		name[36];
;61:	int			preference;
;62:} bot_ctftaskpreference_t;
;63:
;64:bot_ctftaskpreference_t ctftaskpreferences[MAX_CLIENTS];
;65:
;66:
;67:/*
;68:==================
;69:BotValidTeamLeader
;70:==================
;71:*/
;72:int BotValidTeamLeader(bot_state_t *bs) {
line 73
;73:	if (!strlen(bs->teamleader)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $62
CNSTI4 0
RETI4
ADDRGP4 $61
JUMPV
LABELV $62
line 74
;74:	if (ClientFromName(bs->teamleader) == -1) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $64
CNSTI4 0
RETI4
ADDRGP4 $61
JUMPV
LABELV $64
line 75
;75:	return qtrue;
CNSTI4 1
RETI4
LABELV $61
endproc BotValidTeamLeader 8 4
bss
align 4
LABELV $67
skip 4
export BotNumTeamMates
code
proc BotNumTeamMates 1060 12
line 83
;76:}
;77:
;78:/*
;79:==================
;80:BotNumTeamMates
;81:==================
;82:*/
;83:int BotNumTeamMates(bot_state_t *bs) {
line 88
;84:	int i, numplayers;
;85:	char buf[MAX_INFO_STRING];
;86:	static int maxclients;
;87:
;88:	if (!maxclients)
ADDRGP4 $67
INDIRI4
CNSTI4 0
NEI4 $68
line 89
;89:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $70
ARGP4
ADDRLP4 1032
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $67
ADDRLP4 1032
INDIRI4
ASGNI4
LABELV $68
line 91
;90:
;91:	numplayers = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 92
;92:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $74
JUMPV
LABELV $71
line 93
;93:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 95
;94:		//if no config string or no name
;95:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 0
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $79
ADDRLP4 0
ARGP4
ADDRGP4 $78
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $76
LABELV $79
ADDRGP4 $72
JUMPV
LABELV $76
line 97
;96:		//skip spectators
;97:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 0
ARGP4
ADDRGP4 $82
ARGP4
ADDRLP4 1048
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 3
NEI4 $80
ADDRGP4 $72
JUMPV
LABELV $80
line 99
;98:		//
;99:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 1056
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $83
line 100
;100:			numplayers++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 101
;101:		}
LABELV $83
line 102
;102:	}
LABELV $72
line 92
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $74
ADDRLP4 1024
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $71
line 103
;103:	return numplayers;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $66
endproc BotNumTeamMates 1060 12
export BotClientTravelTimeToGoal
proc BotClientTravelTimeToGoal 480 16
line 111
;104:}
;105:
;106:/*
;107:==================
;108:BotClientTravelTimeToGoal
;109:==================
;110:*/
;111:int BotClientTravelTimeToGoal(int client, bot_goal_t *goal) {
line 115
;112:	playerState_t ps;
;113:	int areanum;
;114:
;115:	if (BotAI_GetClientState(client, &ps)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 472
ADDRGP4 BotAI_GetClientState
CALLI4
ASGNI4
ADDRLP4 472
INDIRI4
CNSTI4 0
EQI4 $86
line 116
;116:		areanum = BotPointAreaNum(ps.origin);
ADDRLP4 4+20
ARGP4
ADDRLP4 476
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 476
INDIRI4
ASGNI4
line 117
;117:	} else {
ADDRGP4 $87
JUMPV
LABELV $86
line 118
;118:		areanum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 119
;119:	}
LABELV $87
line 120
;120:	if (!areanum) return 1;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $89
CNSTI4 1
RETI4
ADDRGP4 $85
JUMPV
LABELV $89
line 121
;121:	return trap_AAS_AreaTravelTimeToGoalArea(areanum, ps.origin, goal->areanum, TFL_DEFAULT);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4+20
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 476
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 476
INDIRI4
RETI4
LABELV $85
endproc BotClientTravelTimeToGoal 480 16
export BotSortTeamMatesByBaseTravelTime
proc BotSortTeamMatesByBaseTravelTime 1348 12
line 129
;122:}
;123:
;124:/*
;125:==================
;126:BotSortTeamMatesByBaseTravelTime
;127:==================
;128:*/
;129:int BotSortTeamMatesByBaseTravelTime(bot_state_t *bs, int *teammates, int maxteammates) {
line 134
;130:
;131:	int i, j, k, numteammates, traveltime;
;132:	char buf[MAX_INFO_STRING];
;133:	int traveltimes[MAX_CLIENTS];
;134:	bot_goal_t *goal = NULL;
ADDRLP4 1300
CNSTP4 0
ASGNP4
line 136
;135:
;136:	if (G_UsesTeamFlags(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 1304
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 1304
INDIRI4
CNSTI4 0
EQI4 $93
line 137
;137:		if (BotTeam(bs) == TEAM_RED)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1308
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 1308
INDIRI4
CNSTI4 1
NEI4 $95
line 138
;138:			goal = &ctf_redflag;
ADDRLP4 1300
ADDRGP4 ctf_redflag
ASGNP4
ADDRGP4 $94
JUMPV
LABELV $95
line 140
;139:		else
;140:			goal = &ctf_blueflag;
ADDRLP4 1300
ADDRGP4 ctf_blueflag
ASGNP4
line 141
;141:	}
ADDRGP4 $94
JUMPV
LABELV $93
line 142
;142:	else {
line 143
;143:		if (BotTeam(bs) == TEAM_RED)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1308
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 1308
INDIRI4
CNSTI4 1
NEI4 $97
line 144
;144:			goal = &redobelisk;
ADDRLP4 1300
ADDRGP4 redobelisk
ASGNP4
ADDRGP4 $98
JUMPV
LABELV $97
line 146
;145:		else
;146:			goal = &blueobelisk;
ADDRLP4 1300
ADDRGP4 blueobelisk
ASGNP4
LABELV $98
line 147
;147:	}
LABELV $94
line 148
;148:	numteammates = 0;
ADDRLP4 264
CNSTI4 0
ASGNI4
line 149
;149:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 272
CNSTI4 0
ASGNI4
ADDRGP4 $102
JUMPV
LABELV $99
line 150
;150:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 272
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 276
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 152
;151:		//if no config string or no name
;152:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 276
ARGP4
ADDRLP4 1308
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1308
INDIRI4
CNSTI4 0
EQI4 $106
ADDRLP4 276
ARGP4
ADDRGP4 $78
ARGP4
ADDRLP4 1312
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1312
INDIRP4
ARGP4
ADDRLP4 1316
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1316
INDIRI4
CNSTI4 0
NEI4 $104
LABELV $106
ADDRGP4 $100
JUMPV
LABELV $104
line 154
;153:		//skip spectators
;154:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 276
ARGP4
ADDRGP4 $82
ARGP4
ADDRLP4 1320
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1320
INDIRP4
ARGP4
ADDRLP4 1324
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 3
NEI4 $107
ADDRGP4 $100
JUMPV
LABELV $107
line 156
;155:		//
;156:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRLP4 1328
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 0
EQI4 $109
line 158
;157:			//
;158:			traveltime = BotClientTravelTimeToGoal(i, goal);
ADDRLP4 272
INDIRI4
ARGI4
ADDRLP4 1300
INDIRP4
ARGP4
ADDRLP4 1332
ADDRGP4 BotClientTravelTimeToGoal
CALLI4
ASGNI4
ADDRLP4 268
ADDRLP4 1332
INDIRI4
ASGNI4
line 160
;159:			//
;160:			for (j = 0; j < numteammates; j++) {
ADDRLP4 260
CNSTI4 0
ASGNI4
ADDRGP4 $114
JUMPV
LABELV $111
line 161
;161:				if (traveltime < traveltimes[j]) {
ADDRLP4 268
INDIRI4
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
GEI4 $115
line 162
;162:					for (k = numteammates; k > j; k--) {
ADDRLP4 0
ADDRLP4 264
INDIRI4
ASGNI4
ADDRGP4 $120
JUMPV
LABELV $117
line 163
;163:						traveltimes[k] = traveltimes[k-1];
ADDRLP4 1336
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1336
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 1336
INDIRI4
ADDRLP4 4-4
ADDP4
INDIRI4
ASGNI4
line 164
;164:						teammates[k] = teammates[k-1];
ADDRLP4 1340
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1344
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1340
INDIRI4
ADDRLP4 1344
INDIRP4
ADDP4
ADDRLP4 1340
INDIRI4
CNSTI4 4
SUBI4
ADDRLP4 1344
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 165
;165:					}
LABELV $118
line 162
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $120
ADDRLP4 0
INDIRI4
ADDRLP4 260
INDIRI4
GTI4 $117
line 166
;166:					break;
ADDRGP4 $113
JUMPV
LABELV $115
line 168
;167:				}
;168:			}
LABELV $112
line 160
ADDRLP4 260
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $114
ADDRLP4 260
INDIRI4
ADDRLP4 264
INDIRI4
LTI4 $111
LABELV $113
line 169
;169:			traveltimes[j] = traveltime;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 170
;170:			teammates[j] = i;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 171
;171:			numteammates++;
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 172
;172:			if (numteammates >= maxteammates) break;
ADDRLP4 264
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $122
ADDRGP4 $101
JUMPV
LABELV $122
line 173
;173:		}
LABELV $109
line 174
;174:	}
LABELV $100
line 149
ADDRLP4 272
ADDRLP4 272
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $102
ADDRLP4 272
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $99
LABELV $101
line 175
;175:	return numteammates;
ADDRLP4 264
INDIRI4
RETI4
LABELV $92
endproc BotSortTeamMatesByBaseTravelTime 1348 12
bss
align 4
LABELV $125
skip 4
export BotSortTeamMatesByRelativeTravelTime2ddA
code
proc BotSortTeamMatesByRelativeTravelTime2ddA 1360 12
line 184
;176:}
;177:
;178:/*
;179:==================
;180:BotSortTeamMatesByReletiveTravelTime2ddA
;181:For Double Domination
;182:==================
;183:*/
;184:int BotSortTeamMatesByRelativeTravelTime2ddA(bot_state_t *bs, int *teammates, int maxteammates) {
line 191
;185:	int i, j, k, numteammates;
;186:	double traveltime, traveltime2b;
;187:	char buf[MAX_INFO_STRING];
;188:	static int maxclients;
;189:	double traveltimes[MAX_CLIENTS];
;190:	//int traveltimes2b[MAX_CLIENTS];
;191:	bot_goal_t *goalA = &ctf_redflag;
ADDRLP4 1304
ADDRGP4 ctf_redflag
ASGNP4
line 192
;192:	bot_goal_t *goalB = &ctf_blueflag;
ADDRLP4 1308
ADDRGP4 ctf_blueflag
ASGNP4
line 194
;193:
;194:	if (!maxclients)
ADDRGP4 $125
INDIRI4
CNSTI4 0
NEI4 $126
line 195
;195:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $70
ARGP4
ADDRLP4 1312
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $125
ADDRLP4 1312
INDIRI4
ASGNI4
LABELV $126
line 197
;196:
;197:	numteammates = 0;
ADDRLP4 264
CNSTI4 0
ASGNI4
line 199
;198:
;199:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 272
CNSTI4 0
ASGNI4
ADDRGP4 $131
JUMPV
LABELV $128
line 200
;200:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 272
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 276
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 202
;201:		//if no config string or no name
;202:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 276
ARGP4
ADDRLP4 1316
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1316
INDIRI4
CNSTI4 0
EQI4 $134
ADDRLP4 276
ARGP4
ADDRGP4 $78
ARGP4
ADDRLP4 1320
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1320
INDIRP4
ARGP4
ADDRLP4 1324
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
NEI4 $132
LABELV $134
ADDRGP4 $129
JUMPV
LABELV $132
line 204
;203:		//skip spectators
;204:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 276
ARGP4
ADDRGP4 $82
ARGP4
ADDRLP4 1328
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1328
INDIRP4
ARGP4
ADDRLP4 1332
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 3
NEI4 $135
ADDRGP4 $129
JUMPV
LABELV $135
line 205
;205:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRLP4 1336
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1336
INDIRI4
CNSTI4 0
EQI4 $137
line 206
;206:			traveltime = (double)BotClientTravelTimeToGoal(i, goalA);
ADDRLP4 272
INDIRI4
ARGI4
ADDRLP4 1304
INDIRP4
ARGP4
ADDRLP4 1340
ADDRGP4 BotClientTravelTimeToGoal
CALLI4
ASGNI4
ADDRLP4 268
ADDRLP4 1340
INDIRI4
CVIF4 4
ASGNF4
line 207
;207:			traveltime2b = (double)BotClientTravelTimeToGoal(i, goalB);
ADDRLP4 272
INDIRI4
ARGI4
ADDRLP4 1308
INDIRP4
ARGP4
ADDRLP4 1344
ADDRGP4 BotClientTravelTimeToGoal
CALLI4
ASGNI4
ADDRLP4 1300
ADDRLP4 1344
INDIRI4
CVIF4 4
ASGNF4
line 208
;208:			traveltime = traveltime/traveltime2b;
ADDRLP4 268
ADDRLP4 268
INDIRF4
ADDRLP4 1300
INDIRF4
DIVF4
ASGNF4
line 210
;209:
;210:			for (j = 0; j < numteammates; j++) {
ADDRLP4 260
CNSTI4 0
ASGNI4
ADDRGP4 $142
JUMPV
LABELV $139
line 211
;211:				if (traveltime < traveltimes[j]) {
ADDRLP4 268
INDIRF4
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
GEF4 $143
line 212
;212:					for (k = numteammates; k > j; k--) {
ADDRLP4 0
ADDRLP4 264
INDIRI4
ASGNI4
ADDRGP4 $148
JUMPV
LABELV $145
line 213
;213:						traveltimes[k] = traveltimes[k-1];
ADDRLP4 1348
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1348
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 1348
INDIRI4
ADDRLP4 4-4
ADDP4
INDIRF4
ASGNF4
line 214
;214:						teammates[k] = teammates[k-1];
ADDRLP4 1352
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1356
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1352
INDIRI4
ADDRLP4 1356
INDIRP4
ADDP4
ADDRLP4 1352
INDIRI4
CNSTI4 4
SUBI4
ADDRLP4 1356
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 215
;215:					}
LABELV $146
line 212
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $148
ADDRLP4 0
INDIRI4
ADDRLP4 260
INDIRI4
GTI4 $145
line 216
;216:					break;
ADDRGP4 $141
JUMPV
LABELV $143
line 218
;217:				}
;218:			}
LABELV $140
line 210
ADDRLP4 260
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $142
ADDRLP4 260
INDIRI4
ADDRLP4 264
INDIRI4
LTI4 $139
LABELV $141
line 219
;219:			traveltimes[j] = traveltime;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 268
INDIRF4
ASGNF4
line 220
;220:			teammates[j] = i;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 221
;221:			numteammates++;
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 222
;222:			if (numteammates >= maxteammates) break;
ADDRLP4 264
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $150
ADDRGP4 $130
JUMPV
LABELV $150
line 223
;223:		}
LABELV $137
line 224
;224:	}
LABELV $129
line 199
ADDRLP4 272
ADDRLP4 272
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $131
ADDRLP4 272
INDIRI4
ADDRGP4 $125
INDIRI4
GEI4 $152
ADDRLP4 272
INDIRI4
CNSTI4 64
LTI4 $128
LABELV $152
LABELV $130
line 226
;225:
;226:	return numteammates;
ADDRLP4 264
INDIRI4
RETI4
LABELV $124
endproc BotSortTeamMatesByRelativeTravelTime2ddA 1360 12
export BotSetTeamMateTaskPreference
proc BotSetTeamMateTaskPreference 36 12
line 234
;227:}
;228:
;229:/*
;230:==================
;231:BotSetTeamMateTaskPreference
;232:==================
;233:*/
;234:void BotSetTeamMateTaskPreference(bot_state_t *bs, int teammate, int preference) {
line 237
;235:	char teammatename[MAX_NETNAME];
;236:
;237:	ctftaskpreferences[teammate].preference = preference;
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 238
;238:	ClientName(teammate, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 239
;239:	strcpy(ctftaskpreferences[teammate].name, teammatename);
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 240
;240:}
LABELV $153
endproc BotSetTeamMateTaskPreference 36 12
export BotGetTeamMateTaskPreference
proc BotGetTeamMateTaskPreference 40 12
line 247
;241:
;242:/*
;243:==================
;244:BotGetTeamMateTaskPreference
;245:==================
;246:*/
;247:int BotGetTeamMateTaskPreference(bot_state_t *bs, int teammate) {
line 249
;248:	char teammatename[MAX_NETNAME];
;249:	if ( !ctftaskpreferences[teammate].preference) {
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $156
line 250
;250:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $155
JUMPV
LABELV $156
line 252
;251:	}
;252:	ClientName(teammate, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 253
;253:	if ( !Q_strequal(teammatename, ctftaskpreferences[teammate].name)) {
ADDRLP4 0
ARGP4
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $159
line 254
;254:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $155
JUMPV
LABELV $159
line 256
;255:	}
;256:	return ctftaskpreferences[teammate].preference;
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
INDIRI4
RETI4
LABELV $155
endproc BotGetTeamMateTaskPreference 40 12
export BotSortTeamMatesByTaskPreference
proc BotSortTeamMatesByTaskPreference 804 12
line 264
;257:}
;258:
;259:/*
;260:==================
;261:BotSortTeamMatesByTaskPreference
;262:==================
;263:*/
;264:int BotSortTeamMatesByTaskPreference(bot_state_t *bs, int *teammates, int numteammates) {
line 270
;265:	int defenders[MAX_CLIENTS], numdefenders;
;266:	int attackers[MAX_CLIENTS], numattackers;
;267:	int roamers[MAX_CLIENTS], numroamers;
;268:	int i, preference;
;269:
;270:	numdefenders = numattackers = numroamers = 0;
ADDRLP4 788
CNSTI4 0
ASGNI4
ADDRLP4 272
ADDRLP4 788
INDIRI4
ASGNI4
ADDRLP4 268
ADDRLP4 788
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 788
INDIRI4
ASGNI4
line 271
;271:	for (i = 0; i < numteammates; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $166
JUMPV
LABELV $163
line 272
;272:		preference = BotGetTeamMateTaskPreference(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 792
ADDRGP4 BotGetTeamMateTaskPreference
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 792
INDIRI4
ASGNI4
line 273
;273:		if (preference & TEAMTP_DEFENDER) {
ADDRLP4 4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $167
line 274
;274:			defenders[numdefenders++] = teammates[i];
ADDRLP4 796
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRLP4 796
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 275
;275:		}
ADDRGP4 $168
JUMPV
LABELV $167
line 276
;276:		else if (preference & TEAMTP_ATTACKER) {
ADDRLP4 4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $169
line 277
;277:			attackers[numattackers++] = teammates[i];
ADDRLP4 796
ADDRLP4 268
INDIRI4
ASGNI4
ADDRLP4 268
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRLP4 796
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRLP4 276
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 278
;278:		}
ADDRGP4 $170
JUMPV
LABELV $169
line 279
;279:		else {
line 280
;280:			roamers[numroamers++] = teammates[i];
ADDRLP4 796
ADDRLP4 272
INDIRI4
ASGNI4
ADDRLP4 272
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRLP4 796
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRLP4 532
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 281
;281:		}
LABELV $170
LABELV $168
line 282
;282:	}
LABELV $164
line 271
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $166
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $163
line 283
;283:	numteammates = 0;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 285
;284:	//defenders at the front of the list
;285:	memcpy(&teammates[numteammates], defenders, numdefenders * sizeof(int));
ADDRLP4 792
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 792
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRI4
CVIU4 4
ADDRLP4 792
INDIRI4
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 286
;286:	numteammates += numdefenders;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 288
;287:	//roamers in the middle
;288:	memcpy(&teammates[numteammates], roamers, numroamers * sizeof(int));
ADDRLP4 796
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 796
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 532
ARGP4
ADDRLP4 272
INDIRI4
CVIU4 4
ADDRLP4 796
INDIRI4
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 289
;289:	numteammates += numroamers;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 272
INDIRI4
ADDI4
ASGNI4
line 291
;290:	//attacker in the back of the list
;291:	memcpy(&teammates[numteammates], attackers, numattackers * sizeof(int));
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 276
ARGP4
ADDRLP4 268
INDIRI4
CVIU4 4
ADDRLP4 800
INDIRI4
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 292
;292:	numteammates += numattackers;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 268
INDIRI4
ADDI4
ASGNI4
line 294
;293:
;294:	return numteammates;
ADDRFP4 8
INDIRI4
RETI4
LABELV $162
endproc BotSortTeamMatesByTaskPreference 804 12
export BotSayTeamOrderAlways
proc BotSayTeamOrderAlways 548 20
line 302
;295:}
;296:
;297:/*
;298:==================
;299:BotSayTeamOrders
;300:==================
;301:*/
;302:void BotSayTeamOrderAlways(bot_state_t *bs, int toclient) {
line 307
;303:	char teamchat[MAX_MESSAGE_SIZE];
;304:	char buf[MAX_MESSAGE_SIZE];
;305:	char name[MAX_NETNAME];
;306:
;307:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $172
line 308
;308:		return;
ADDRGP4 $171
JUMPV
LABELV $172
line 312
;309:	}
;310:
;311:	//if the bot is talking to itself
;312:	if (bs->client == toclient) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $175
line 314
;313:		//don't show the message just put it in the console message queue
;314:		trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGetChatMessage
CALLV
pop
line 315
;315:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 512
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 316
;316:		Com_sprintf(teamchat, sizeof(teamchat), EC"(%s"EC")"EC": %s", name, buf);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $177
ARGP4
ADDRLP4 512
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 317
;317:		trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, teamchat);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 318
;318:	}
ADDRGP4 $176
JUMPV
LABELV $175
line 319
;319:	else {
line 320
;320:		trap_BotEnterChat(bs->cs, toclient, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6388
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 321
;321:	}
LABELV $176
line 322
;322:}
LABELV $171
endproc BotSayTeamOrderAlways 548 20
export BotSayTeamOrder
proc BotSayTeamOrder 0 8
line 329
;323:
;324:/*
;325:==================
;326:BotSayTeamOrders
;327:==================
;328:*/
;329:void BotSayTeamOrder(bot_state_t *bs, int toclient) {
line 336
;330:#ifdef MISSIONPACK
;331:	// voice chats only
;332:	char buf[MAX_MESSAGE_SIZE];
;333:
;334:	trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
;335:#else
;336:	BotSayTeamOrderAlways(bs, toclient);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrderAlways
CALLV
pop
line 338
;337:#endif
;338:}
LABELV $178
endproc BotSayTeamOrder 0 8
export BotVoiceChat
proc BotVoiceChat 0 0
line 345
;339:
;340:/*
;341:==================
;342:BotVoiceChat
;343:==================
;344:*/
;345:void BotVoiceChat(bot_state_t *bs, int toclient, char *voicechat) {
line 356
;346:#ifdef MISSIONPACK
;347:	if (toclient == -1) {
;348:		// voice only say team
;349:		trap_EA_Command(bs->client, va("vsay_team %s", voicechat));
;350:	}
;351:	else {
;352:		// voice only tell single player
;353:		trap_EA_Command(bs->client, va("vtell %d %s", toclient, voicechat));
;354:	}
;355:#endif
;356:}
LABELV $179
endproc BotVoiceChat 0 0
export BotVoiceChatOnly
proc BotVoiceChatOnly 0 0
line 363
;357:
;358:/*
;359:==================
;360:BotVoiceChatOnly
;361:==================
;362:*/
;363:void BotVoiceChatOnly(bot_state_t *bs, int toclient, char *voicechat) {
line 375
;364:
;365:#ifdef MISSIONPACK
;366:	if (toclient == -1) {
;367:		// voice only say team
;368:		trap_EA_Command(bs->client, va("vosay_team %s", voicechat));
;369:	}
;370:	else {
;371:		// voice only tell single player
;372:		trap_EA_Command(bs->client, va("votell %d %s", toclient, voicechat));
;373:	}
;374:#endif
;375:}
LABELV $180
endproc BotVoiceChatOnly 0 0
export BotSayVoiceTeamOrder
proc BotSayVoiceTeamOrder 0 0
line 382
;376:
;377:/*
;378:==================
;379:BotSayVoiceTeamOrder
;380:==================
;381:*/
;382:void BotSayVoiceTeamOrder(bot_state_t *bs, int toclient, char *voicechat) {
line 387
;383:
;384:#ifdef MISSIONPACK
;385:	BotVoiceChat(bs, toclient, voicechat);
;386:#endif
;387:}
LABELV $181
endproc BotSayVoiceTeamOrder 0 0
export BotCTFOrders_BothFlagsNotAtBase
proc BotCTFOrders_BothFlagsNotAtBase 368 20
line 394
;388:
;389:/*
;390:==================
;391:BotCTFOrders
;392:==================
;393:*/
;394:void BotCTFOrders_BothFlagsNotAtBase(bot_state_t *bs) {
line 399
;395:	int numteammates, defenders, attackers, i, other;
;396:	int teammates[MAX_CLIENTS];
;397:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;398:
;399:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 348
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 348
INDIRI4
ASGNI4
line 400
;400:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 402
;401:	//different orders based on the number of team mates
;402:	switch(bs->numteammates) {
ADDRLP4 352
ADDRFP4 0
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 1
EQI4 $184
ADDRLP4 352
INDIRI4
CNSTI4 2
EQI4 $187
ADDRLP4 352
INDIRI4
CNSTI4 3
EQI4 $196
ADDRGP4 $183
JUMPV
line 403
;403:		case 1: break;
LABELV $187
line 405
;404:		case 2:
;405:		{
line 407
;406:			//tell the one not carrying the flag to attack the enemy base
;407:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
EQI4 $188
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $189
JUMPV
LABELV $188
line 408
;408:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $189
line 409
;409:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 410
;410:			if (bot_nochat.integer<3) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 3
GEI4 $191
line 411
;411:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 412
;412:			}
LABELV $191
line 413
;413:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 414
;414:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 415
;415:			break;
ADDRGP4 $184
JUMPV
LABELV $196
line 418
;416:		}
;417:		case 3:
;418:		{
line 420
;419:			//tell the one closest to the base not carrying the flag to accompany the flag carrier
;420:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
EQI4 $197
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $198
JUMPV
LABELV $197
line 421
;421:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $198
line 422
;422:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 423
;423:			if ( bs->flagcarrier != -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $200
line 424
;424:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 425
;425:				if (bot_nochat.integer<3) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 3
GEI4 $201
line 426
;426:					if (bs->flagcarrier == bs->client) {
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ADDRLP4 360
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $205
line 427
;427:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 428
;428:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $208
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 429
;429:					}
ADDRGP4 $201
JUMPV
LABELV $205
line 430
;430:					else {
line 431
;431:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 432
;432:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $210
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 433
;433:					}
line 434
;434:				}
line 435
;435:			}
ADDRGP4 $201
JUMPV
LABELV $200
line 436
;436:			else {
line 438
;437:				//
;438:				if (bot_nochat.integer<3) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 3
GEI4 $211
line 439
;439:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 440
;440:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 441
;441:				}
LABELV $211
line 442
;442:			}
LABELV $201
line 443
;443:			if (bot_nochat.integer<3) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 3
GEI4 $214
line 444
;444:				BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 445
;445:			}
LABELV $214
line 447
;446:			//tell the one furthest from the the base not carrying the flag to get the enemy flag
;447:			if (teammates[2] != bs->flagcarrier) other = teammates[2];
ADDRLP4 4+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
EQI4 $217
ADDRLP4 308
ADDRLP4 4+8
INDIRI4
ASGNI4
ADDRGP4 $218
JUMPV
LABELV $217
line 448
;448:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $218
line 449
;449:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 450
;450:			if (bot_nochat.integer<3) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 3
GEI4 $184
line 451
;451:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 452
;452:				BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 453
;453:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_RETURNFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $225
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 454
;454:			}
line 455
;455:			break;
ADDRGP4 $184
JUMPV
LABELV $183
line 458
;456:		}
;457:		default:
;458:		{
line 459
;459:			defenders = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 300
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 460
;460:			if (defenders > 4) defenders = 4;
ADDRLP4 300
INDIRI4
CNSTI4 4
LEI4 $226
ADDRLP4 300
CNSTI4 4
ASGNI4
LABELV $226
line 461
;461:			attackers = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 360
CNSTF4 1056964608
ASGNF4
ADDRLP4 304
ADDRLP4 360
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 360
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 462
;462:			if (attackers > 5) attackers = 5;
ADDRLP4 304
INDIRI4
CNSTI4 5
LEI4 $228
ADDRLP4 304
CNSTI4 5
ASGNI4
LABELV $228
line 463
;463:			if (bs->flagcarrier != -1) {
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $230
line 464
;464:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 465
;465:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $235
JUMPV
LABELV $232
line 467
;466:					//
;467:					if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $236
line 468
;468:						continue;
ADDRGP4 $233
JUMPV
LABELV $236
line 471
;469:					}
;470:					//
;471:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 472
;472:					if (bot_nochat.integer<3) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 3
GEI4 $238
line 473
;473:						if (bs->flagcarrier == bs->client) {
ADDRLP4 364
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 364
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ADDRLP4 364
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $241
line 474
;474:							BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 475
;475:							BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $208
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 476
;476:						}
ADDRGP4 $242
JUMPV
LABELV $241
line 477
;477:						else {
line 478
;478:							BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 479
;479:							BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $210
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 480
;480:						}
LABELV $242
line 481
;481:						BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 482
;482:					}
LABELV $238
line 483
;483:				}
LABELV $233
line 465
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $235
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $232
line 484
;484:			}
ADDRGP4 $231
JUMPV
LABELV $230
line 485
;485:			else {
line 486
;486:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $246
JUMPV
LABELV $243
line 488
;487:					//
;488:					if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $247
line 489
;489:						continue;
ADDRGP4 $244
JUMPV
LABELV $247
line 492
;490:					}
;491:					//
;492:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 493
;493:					if (bot_nochat.integer<3) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 3
GEI4 $249
line 494
;494:						BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 495
;495:						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 496
;496:						BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 497
;497:					}
LABELV $249
line 498
;498:				}
LABELV $244
line 486
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $246
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $243
line 499
;499:			}
LABELV $231
line 500
;500:			for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $255
JUMPV
LABELV $252
line 502
;501:				//
;502:				if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $256
line 503
;503:					continue;
ADDRGP4 $253
JUMPV
LABELV $256
line 506
;504:				}
;505:				//
;506:				ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
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
line 507
;507:				if (bot_nochat.integer<3) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 3
GEI4 $260
line 508
;508:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 509
;509:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 510
;510:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_RETURNFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $225
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 511
;511:				}
LABELV $260
line 512
;512:			}
LABELV $253
line 500
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $255
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $252
line 514
;513:			//
;514:			break;
LABELV $184
line 517
;515:		}
;516:	}
;517:}
LABELV $182
endproc BotCTFOrders_BothFlagsNotAtBase 368 20
export BotCTFOrders_FlagNotAtBase
proc BotCTFOrders_FlagNotAtBase 320 16
line 524
;518:
;519:/*
;520:==================
;521:BotCTFOrders
;522:==================
;523:*/
;524:void BotCTFOrders_FlagNotAtBase(bot_state_t *bs) {
line 529
;525:	int numteammates, defenders, attackers, i;
;526:	int teammates[MAX_CLIENTS];
;527:	char name[MAX_NETNAME];
;528:
;529:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $266
line 530
;530:		return;
ADDRGP4 $265
JUMPV
LABELV $266
line 533
;531:	}
;532:
;533:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 534
;534:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 537
;535:	//In oneway ctf we must all move out of the base (only one strategi, maybe we can also send some to the enemy base  to meet the flag carier?)
;536:	//We must be defending
;537:	if(g_elimination_ctf_oneway.integer > 0) {
ADDRGP4 g_elimination_ctf_oneway+12
INDIRI4
CNSTI4 0
LEI4 $269
line 538
;538:		for (i = 0; i < numteammates; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $275
JUMPV
LABELV $272
line 540
;539:			//
;540:			ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 541
;541:			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 542
;542:			BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 543
;543:			BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 544
;544:		}
LABELV $273
line 538
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $275
ADDRLP4 0
INDIRI4
ADDRLP4 296
INDIRI4
LTI4 $272
line 545
;545:		return;
ADDRGP4 $265
JUMPV
LABELV $269
line 549
;546:	}
;547:
;548:	//passive strategy
;549:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $276
line 551
;550:		//different orders based on the number of team mates
;551:		switch(bs->numteammates) {
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $277
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $282
ADDRLP4 312
INDIRI4
CNSTI4 3
EQI4 $288
ADDRGP4 $278
JUMPV
line 552
;552:			case 1: break;
LABELV $282
line 554
;553:			case 2:
;554:			{
line 556
;555:				// keep one near the base for when the flag is returned
;556:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 557
;557:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 558
;558:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 559
;559:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 561
;560:				//
;561:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 562
;562:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 563
;563:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 564
;564:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 565
;565:				break;
ADDRGP4 $277
JUMPV
LABELV $288
line 568
;566:			}
;567:			case 3:
;568:			{
line 570
;569:				//keep one near the base for when the flag is returned
;570:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 571
;571:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 572
;572:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 573
;573:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 575
;574:				//the other two get the flag
;575:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 576
;576:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 577
;577:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 578
;578:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 580
;579:				//
;580:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 581
;581:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 582
;582:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 583
;583:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 584
;584:				break;
ADDRGP4 $277
JUMPV
LABELV $278
line 587
;585:			}
;586:			default:
;587:			{
line 589
;588:				//keep some people near the base for when the flag is returned
;589:				defenders = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 300
CNSTF4 1050253722
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 590
;590:				if (defenders > 3) defenders = 3;
ADDRLP4 300
INDIRI4
CNSTI4 3
LEI4 $295
ADDRLP4 300
CNSTI4 3
ASGNI4
LABELV $295
line 591
;591:				attackers = (int) (float) numteammates * 0.6 + 0.5;
ADDRLP4 304
CNSTF4 1058642330
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 592
;592:				if (attackers > 6) attackers = 6;
ADDRLP4 304
INDIRI4
CNSTI4 6
LEI4 $297
ADDRLP4 304
CNSTI4 6
ASGNI4
LABELV $297
line 593
;593:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $302
JUMPV
LABELV $299
line 595
;594:					//
;595:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 596
;596:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 597
;597:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 598
;598:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 599
;599:				}
LABELV $300
line 593
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $302
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $299
line 600
;600:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $306
JUMPV
LABELV $303
line 602
;601:					//
;602:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
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
line 603
;603:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 604
;604:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 605
;605:					BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 606
;606:				}
LABELV $304
line 600
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $306
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $303
line 608
;607:				//
;608:				break;
line 611
;609:			}
;610:		}
;611:	}
ADDRGP4 $277
JUMPV
LABELV $276
line 612
;612:	else {
line 614
;613:		//different orders based on the number of team mates
;614:		switch(bs->numteammates) {
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $310
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $313
ADDRLP4 312
INDIRI4
CNSTI4 3
EQI4 $317
ADDRGP4 $309
JUMPV
line 615
;615:			case 1: break;
LABELV $313
line 617
;616:			case 2:
;617:			{
line 619
;618:				//both will go for the enemy flag
;619:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 620
;620:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 621
;621:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 622
;622:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 624
;623:				//
;624:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 625
;625:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 626
;626:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 627
;627:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 628
;628:				break;
ADDRGP4 $310
JUMPV
LABELV $317
line 631
;629:			}
;630:			case 3:
;631:			{
line 633
;632:				//everyone go for the flag
;633:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 634
;634:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 635
;635:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 636
;636:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 638
;637:				//
;638:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 639
;639:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 640
;640:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 641
;641:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 643
;642:				//
;643:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 644
;644:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 645
;645:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 646
;646:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 647
;647:				break;
ADDRGP4 $310
JUMPV
LABELV $309
line 650
;648:			}
;649:			default:
;650:			{
line 652
;651:				//keep some people near the base for when the flag is returned
;652:				defenders = (int) (float) numteammates * 0.2 + 0.5;
ADDRLP4 300
CNSTF4 1045220557
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 653
;653:				if (defenders > 2) defenders = 2;
ADDRLP4 300
INDIRI4
CNSTI4 2
LEI4 $324
ADDRLP4 300
CNSTI4 2
ASGNI4
LABELV $324
line 654
;654:				attackers = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 304
CNSTF4 1060320051
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 655
;655:				if (attackers > 7) attackers = 7;
ADDRLP4 304
INDIRI4
CNSTI4 7
LEI4 $326
ADDRLP4 304
CNSTI4 7
ASGNI4
LABELV $326
line 656
;656:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $331
JUMPV
LABELV $328
line 658
;657:					//
;658:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 659
;659:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 660
;660:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 661
;661:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 662
;662:				}
LABELV $329
line 656
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $331
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $328
line 663
;663:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $335
JUMPV
LABELV $332
line 665
;664:					//
;665:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
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
line 666
;666:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 667
;667:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 668
;668:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 669
;669:				}
LABELV $333
line 663
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $335
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $332
line 671
;670:				//
;671:				break;
LABELV $310
line 674
;672:			}
;673:		}
;674:	}
LABELV $277
line 675
;675:}
LABELV $265
endproc BotCTFOrders_FlagNotAtBase 320 16
export BotCTFOrders_EnemyFlagNotAtBase
proc BotCTFOrders_EnemyFlagNotAtBase 360 20
line 682
;676:
;677:/*
;678:==================
;679:BotCTFOrders
;680:==================
;681:*/
;682:void BotCTFOrders_EnemyFlagNotAtBase(bot_state_t *bs) {
line 687
;683:	int numteammates, defenders, attackers, i, other;
;684:	int teammates[MAX_CLIENTS];
;685:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;686:
;687:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $340
line 688
;688:		return;
ADDRGP4 $339
JUMPV
LABELV $340
line 691
;689:	}
;690:
;691:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 348
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 260
ADDRLP4 348
INDIRI4
ASGNI4
line 692
;692:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 694
;693:	//different orders based on the number of team mates
;694:	switch(numteammates) {
ADDRLP4 260
INDIRI4
CNSTI4 1
EQI4 $344
ADDRLP4 260
INDIRI4
CNSTI4 2
EQI4 $346
ADDRLP4 260
INDIRI4
CNSTI4 3
EQI4 $350
ADDRGP4 $343
JUMPV
line 695
;695:		case 1: break;
LABELV $346
line 697
;696:		case 2:
;697:		{
line 699
;698:			//tell the one not carrying the flag to defend the base
;699:			if (teammates[0] == bs->flagcarrier) other = teammates[1];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $347
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
ADDRGP4 $348
JUMPV
LABELV $347
line 700
;700:			else other = teammates[0];
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $348
line 701
;701:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 702
;702:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 703
;703:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 704
;704:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 705
;705:			break;
ADDRGP4 $344
JUMPV
LABELV $350
line 708
;706:		}
;707:		case 3:
;708:		{
line 710
;709:			//tell the one closest to the base not carrying the flag to defend the base
;710:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
EQI4 $351
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $352
JUMPV
LABELV $351
line 711
;711:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $352
line 712
;712:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 713
;713:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 714
;714:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 715
;715:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 717
;716:			//tell the other also to defend the base
;717:			if (teammates[2] != bs->flagcarrier) other = teammates[2];
ADDRLP4 4+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
EQI4 $354
ADDRLP4 308
ADDRLP4 4+8
INDIRI4
ASGNI4
ADDRGP4 $355
JUMPV
LABELV $354
line 718
;718:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $355
line 719
;719:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 720
;720:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 721
;721:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 722
;722:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 723
;723:			break;
ADDRGP4 $344
JUMPV
LABELV $343
line 726
;724:		}
;725:		default:
;726:		{
line 728
;727:			//60% will defend the base
;728:			defenders = (int) (float) numteammates * 0.6 + 0.5;
ADDRLP4 300
CNSTF4 1058642330
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 729
;729:			if (defenders > 6) defenders = 6;
ADDRLP4 300
INDIRI4
CNSTI4 6
LEI4 $359
ADDRLP4 300
CNSTI4 6
ASGNI4
LABELV $359
line 731
;730:			//30% accompanies the flag carrier
;731:			attackers = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 304
CNSTF4 1050253722
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 732
;732:			if (attackers > 3) attackers = 3;
ADDRLP4 304
INDIRI4
CNSTI4 3
LEI4 $361
ADDRLP4 304
CNSTI4 3
ASGNI4
LABELV $361
line 733
;733:			for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $366
JUMPV
LABELV $363
line 735
;734:				//
;735:				if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $367
line 736
;736:					continue;
ADDRGP4 $364
JUMPV
LABELV $367
line 738
;737:				}
;738:				ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 739
;739:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 740
;740:				BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 741
;741:				BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 742
;742:			}
LABELV $364
line 733
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $366
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $363
line 744
;743:			// if we have a flag carrier
;744:			if ( bs->flagcarrier != -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $369
line 745
;745:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 746
;746:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $374
JUMPV
LABELV $371
line 748
;747:					//
;748:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $375
line 749
;749:						continue;
ADDRGP4 $372
JUMPV
LABELV $375
line 752
;750:					}
;751:					//
;752:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 753
;753:					if (bs->flagcarrier == bs->client) {
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $379
line 754
;754:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 755
;755:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $208
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 756
;756:					}
ADDRGP4 $380
JUMPV
LABELV $379
line 757
;757:					else {
line 758
;758:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 759
;759:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $210
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 760
;760:					}
LABELV $380
line 761
;761:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 762
;762:				}
LABELV $372
line 746
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $374
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $371
line 763
;763:			}
ADDRGP4 $344
JUMPV
LABELV $369
line 764
;764:			else {
line 765
;765:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $387
JUMPV
LABELV $384
line 767
;766:					//
;767:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $388
line 768
;768:						continue;
ADDRGP4 $385
JUMPV
LABELV $388
line 771
;769:					}
;770:					//
;771:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 772
;772:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 773
;773:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 774
;774:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 775
;775:				}
LABELV $385
line 765
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $387
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $384
line 776
;776:			}
line 778
;777:			//
;778:			break;
LABELV $344
line 781
;779:		}
;780:	}
;781:}
LABELV $339
endproc BotCTFOrders_EnemyFlagNotAtBase 360 20
export BotDDorders_Standard
proc BotDDorders_Standard 304 16
line 789
;782:
;783:/*
;784:==================
;785:BotDDorders
;786:==================
;787:*/
;788:
;789:void BotDDorders_Standard(bot_state_t *bs) {
line 794
;790:	int numteammates, i;
;791:	int teammates[MAX_CLIENTS];
;792:	char name[MAX_NETNAME];
;793:
;794:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $395
line 795
;795:		return;
ADDRGP4 $394
JUMPV
LABELV $395
line 799
;796:	}
;797:
;798:	//sort team mates by travel time to base
;799:	numteammates = BotSortTeamMatesByRelativeTravelTime2ddA(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 300
ADDRGP4 BotSortTeamMatesByRelativeTravelTime2ddA
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 300
INDIRI4
ASGNI4
line 801
;800:
;801:	switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $399
ADDRGP4 $398
JUMPV
line 802
;802:		case 1: break;
LABELV $398
line 818
;803:		/*case 2: 
;804:		{
;805:			//the one closest to point A will take that
;806:			ClientName(teammates[0], name, sizeof(name));
;807:			BotAI_BotInitialChat(bs, "cmd_takea", name, NULL);
;808:			BotSayTeamOrder(bs, teammates[0]);
;809:			//BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_TAKEA);
;810:			//the other goes for point B
;811:			ClientName(teammates[1], name, sizeof(name));
;812:			BotAI_BotInitialChat(bs, "cmd_takeb", name, NULL);
;813:			BotSayTeamOrder(bs, teammates[1]);
;814:			//BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_TAKEB);
;815:			break;
;816:		}*/
;817:		default:
;818:		{
line 819
;819:			for(i=0;i<numteammates/2;i++) { //Half take point A
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $404
JUMPV
LABELV $401
line 820
;820:				ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 821
;821:				BotAI_BotInitialChat(bs, "cmd_takea", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $405
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 822
;822:				BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 824
;823:				//BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_TAKEA);
;824:			}
LABELV $402
line 819
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $404
ADDRLP4 0
INDIRI4
ADDRLP4 296
INDIRI4
CNSTI4 2
DIVI4
LTI4 $401
line 825
;825:			for(i=numteammates/2+1;i<numteammates;i++) { //Rest takes point B
ADDRLP4 0
ADDRLP4 296
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $409
JUMPV
LABELV $406
line 826
;826:				ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 827
;827:				BotAI_BotInitialChat(bs, "cmd_takeb", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $410
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 828
;828:				BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 830
;829:				//BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_TAKEB);
;830:			}
LABELV $407
line 825
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $409
ADDRLP4 0
INDIRI4
ADDRLP4 296
INDIRI4
LTI4 $406
line 831
;831:			break;
LABELV $399
line 834
;832:		}
;833:	}
;834:}
LABELV $394
endproc BotDDorders_Standard 304 16
export BotCTFOrders_BothFlagsAtBase
proc BotCTFOrders_BothFlagsAtBase 324 16
line 841
;835:
;836:/*
;837:==================
;838:BotCTFOrders
;839:==================
;840:*/
;841:void BotCTFOrders_BothFlagsAtBase(bot_state_t *bs) {
line 847
;842:	int numteammates, defenders, attackers, i;
;843:	int teammates[MAX_CLIENTS];
;844:	char name[MAX_NETNAME];
;845:	qboolean weAreAttacking;
;846:
;847:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $412
line 848
;848:		return;
ADDRGP4 $411
JUMPV
LABELV $412
line 852
;849:	}
;850:
;851:	//sort team mates by travel time to base
;852:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 312
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 312
INDIRI4
ASGNI4
line 854
;853:	//sort team mates by CTF preference
;854:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 856
;855:
;856:	weAreAttacking = qfalse;
ADDRLP4 300
CNSTI4 0
ASGNI4
line 858
;857:
;858:	if(g_elimination_ctf_oneway.integer > 0) {
ADDRGP4 g_elimination_ctf_oneway+12
INDIRI4
CNSTI4 0
LEI4 $415
line 860
;859:		//See if we are attacking:
;860:		if( ( (level.eliminationSides+level.roundNumber)%2 == 0 ) && (BotTeam(bs) == TEAM_RED))
ADDRGP4 level+9256
INDIRI4
ADDRGP4 level+9236
INDIRI4
ADDI4
CNSTI4 2
MODI4
CNSTI4 0
NEI4 $418
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 316
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 1
NEI4 $418
line 861
;861:			weAreAttacking = qtrue;
ADDRLP4 300
CNSTI4 1
ASGNI4
LABELV $418
line 863
;862:		
;863:		if(weAreAttacking) {
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $422
line 864
;864:			for (i = 0; i < numteammates; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $427
JUMPV
LABELV $424
line 866
;865:				//
;866:				ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 867
;867:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 868
;868:				BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 869
;869:				BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 870
;870:			}
LABELV $425
line 864
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $427
ADDRLP4 0
INDIRI4
ADDRLP4 296
INDIRI4
LTI4 $424
line 871
;871:		} else {
ADDRGP4 $411
JUMPV
LABELV $422
line 872
;872:			for (i = 0; i < numteammates; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $431
JUMPV
LABELV $428
line 874
;873:				//
;874:				ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 875
;875:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 876
;876:				BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 877
;877:				BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 878
;878:			}
LABELV $429
line 872
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $431
ADDRLP4 0
INDIRI4
ADDRLP4 296
INDIRI4
LTI4 $428
line 879
;879:		}
line 880
;880:		return; //Sago: Or the leader will make a counter order.
ADDRGP4 $411
JUMPV
LABELV $415
line 884
;881:	}
;882:
;883:	//passive strategy
;884:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $432
line 886
;885:		//different orders based on the number of team mates
;886:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $433
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $437
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $441
ADDRGP4 $434
JUMPV
line 887
;887:			case 1: break;
LABELV $437
line 889
;888:			case 2:
;889:			{
line 891
;890:				//the one closest to the base will defend the base
;891:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 892
;892:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 893
;893:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 894
;894:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 896
;895:				//the other will get the flag
;896:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 897
;897:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 898
;898:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 899
;899:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 900
;900:				break;
ADDRGP4 $433
JUMPV
LABELV $441
line 903
;901:			}
;902:			case 3:
;903:			{
line 905
;904:				//the one closest to the base will defend the base
;905:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 906
;906:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 907
;907:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 908
;908:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 910
;909:				//the second one closest to the base will defend the base
;910:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 911
;911:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 912
;912:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 913
;913:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 915
;914:				//the other will get the flag
;915:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 916
;916:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 917
;917:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 918
;918:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 919
;919:				break;
ADDRGP4 $433
JUMPV
LABELV $434
line 922
;920:			}
;921:			default:
;922:			{
line 923
;923:				defenders = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 320
CNSTF4 1056964608
ASGNF4
ADDRLP4 304
ADDRLP4 320
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 320
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 924
;924:				if (defenders > 5) defenders = 5;
ADDRLP4 304
INDIRI4
CNSTI4 5
LEI4 $448
ADDRLP4 304
CNSTI4 5
ASGNI4
LABELV $448
line 925
;925:				attackers = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 308
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 926
;926:				if (attackers > 4) attackers = 4;
ADDRLP4 308
INDIRI4
CNSTI4 4
LEI4 $450
ADDRLP4 308
CNSTI4 4
ASGNI4
LABELV $450
line 927
;927:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $455
JUMPV
LABELV $452
line 929
;928:					//
;929:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 930
;930:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 931
;931:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 932
;932:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 933
;933:				}
LABELV $453
line 927
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $455
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $452
line 934
;934:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $459
JUMPV
LABELV $456
line 936
;935:					//
;936:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
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
line 937
;937:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 938
;938:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 939
;939:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 940
;940:				}
LABELV $457
line 934
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $459
ADDRLP4 0
INDIRI4
ADDRLP4 308
INDIRI4
LTI4 $456
line 942
;941:				//
;942:				break;
line 945
;943:			}
;944:		}
;945:	}
ADDRGP4 $433
JUMPV
LABELV $432
line 946
;946:	else {
line 948
;947:		//different orders based on the number of team mates
;948:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $464
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $466
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $470
ADDRGP4 $463
JUMPV
line 949
;949:			case 1: break;
LABELV $466
line 951
;950:			case 2:
;951:			{
line 953
;952:				//the one closest to the base will defend the base
;953:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 954
;954:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 955
;955:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 956
;956:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 958
;957:				//the other will get the flag
;958:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 959
;959:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 960
;960:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 961
;961:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 962
;962:				break;
ADDRGP4 $464
JUMPV
LABELV $470
line 965
;963:			}
;964:			case 3:
;965:			{
line 967
;966:				//the one closest to the base will defend the base
;967:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 968
;968:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 969
;969:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 970
;970:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 972
;971:				//the others should go for the enemy flag
;972:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 973
;973:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 974
;974:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 975
;975:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 977
;976:				//
;977:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 978
;978:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 979
;979:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 980
;980:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4+8
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 981
;981:				break;
ADDRGP4 $464
JUMPV
LABELV $463
line 984
;982:			}
;983:			default:
;984:			{
line 985
;985:				defenders = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 304
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 986
;986:				if (defenders > 4) defenders = 4;
ADDRLP4 304
INDIRI4
CNSTI4 4
LEI4 $477
ADDRLP4 304
CNSTI4 4
ASGNI4
LABELV $477
line 987
;987:				attackers = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 320
CNSTF4 1056964608
ASGNF4
ADDRLP4 308
ADDRLP4 320
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 320
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 988
;988:				if (attackers > 5) attackers = 5;
ADDRLP4 308
INDIRI4
CNSTI4 5
LEI4 $479
ADDRLP4 308
CNSTI4 5
ASGNI4
LABELV $479
line 989
;989:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $484
JUMPV
LABELV $481
line 991
;990:					//
;991:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
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
line 992
;992:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 993
;993:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 994
;994:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 995
;995:				}
LABELV $482
line 989
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $484
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $481
line 996
;996:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $488
JUMPV
LABELV $485
line 998
;997:					//
;998:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
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
line 999
;999:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1000
;1000:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1001
;1001:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1002
;1002:				}
LABELV $486
line 996
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $488
ADDRLP4 0
INDIRI4
ADDRLP4 308
INDIRI4
LTI4 $485
line 1004
;1003:				//
;1004:				break;
LABELV $464
line 1007
;1005:			}
;1006:		}
;1007:	}
LABELV $433
line 1008
;1008:}
LABELV $411
endproc BotCTFOrders_BothFlagsAtBase 324 16
export BotCTFOrders
proc BotCTFOrders 20 4
line 1015
;1009:
;1010:/*
;1011:==================
;1012:BotCTFOrders
;1013:==================
;1014:*/
;1015:void BotCTFOrders(bot_state_t *bs) {
line 1019
;1016:	int flagstatus;
;1017:
;1018:	//
;1019:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $493
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $494
JUMPV
LABELV $493
line 1020
;1020:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $494
line 1022
;1021:	//
;1022:	switch(flagstatus) {
ADDRLP4 16
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $495
ADDRLP4 16
INDIRI4
CNSTI4 3
GTI4 $495
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $501
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $501
address $497
address $498
address $499
address $500
code
LABELV $497
line 1023
;1023:		case 0: BotCTFOrders_BothFlagsAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_BothFlagsAtBase
CALLV
pop
ADDRGP4 $496
JUMPV
LABELV $498
line 1024
;1024:		case 1: BotCTFOrders_EnemyFlagNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_EnemyFlagNotAtBase
CALLV
pop
ADDRGP4 $496
JUMPV
LABELV $499
line 1025
;1025:		case 2: BotCTFOrders_FlagNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_FlagNotAtBase
CALLV
pop
ADDRGP4 $496
JUMPV
LABELV $500
line 1026
;1026:		case 3: BotCTFOrders_BothFlagsNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_BothFlagsNotAtBase
CALLV
pop
LABELV $495
LABELV $496
line 1028
;1027:	}
;1028:}
LABELV $492
endproc BotCTFOrders 20 4
export BotDDorders
proc BotDDorders 0 4
line 1035
;1029:
;1030:/*
;1031:==================
;1032:BotDDorders
;1033:==================
;1034:*/
;1035:void BotDDorders(bot_state_t *bs) {
line 1036
;1036:	BotDDorders_Standard(bs);	
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDDorders_Standard
CALLV
pop
line 1037
;1037:}
LABELV $502
endproc BotDDorders 0 4
export BotCreateGroup
proc BotCreateGroup 76 20
line 1045
;1038:
;1039:
;1040:/*
;1041:==================
;1042:BotCreateGroup
;1043:==================
;1044:*/
;1045:void BotCreateGroup(bot_state_t *bs, int *teammates, int groupsize) {
line 1049
;1046:	char name[MAX_NETNAME], leadername[MAX_NETNAME];
;1047:	int i;
;1048:
;1049:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $504
line 1050
;1050:		return;
ADDRGP4 $503
JUMPV
LABELV $504
line 1054
;1051:	}
;1052:
;1053:	// the others in the group will follow the teammates[0]
;1054:	ClientName(teammates[0], leadername, sizeof(leadername));
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1055
;1055:	for (i = 1; i < groupsize; i++)
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $510
JUMPV
LABELV $507
line 1056
;1056:	{
line 1057
;1057:		ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
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
line 1058
;1058:		if (teammates[0] == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $511
line 1059
;1059:			BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1060
;1060:		}
ADDRGP4 $512
JUMPV
LABELV $511
line 1061
;1061:		else {
line 1062
;1062:			BotAI_BotInitialChat(bs, "cmd_accompany", name, leadername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 40
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1063
;1063:		}
LABELV $512
line 1064
;1064:		BotSayTeamOrderAlways(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrderAlways
CALLV
pop
line 1065
;1065:	}
LABELV $508
line 1055
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $510
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $507
line 1066
;1066:}
LABELV $503
endproc BotCreateGroup 76 20
export BotTeamOrders
proc BotTeamOrders 1312 12
line 1075
;1067:
;1068:/*
;1069:==================
;1070:BotTeamOrders
;1071:
;1072:  FIXME: defend key areas?
;1073:==================
;1074:*/
;1075:void BotTeamOrders(bot_state_t *bs) {
line 1080
;1076:	int teammates[MAX_CLIENTS];
;1077:	int numteammates, i;
;1078:	char buf[MAX_INFO_STRING];
;1079:
;1080:	numteammates = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 1081
;1081:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $517
JUMPV
LABELV $514
line 1082
;1082:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 1084
;1083:		//if no config string or no name
;1084:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 0
ARGP4
ADDRLP4 1288
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1288
INDIRI4
CNSTI4 0
EQI4 $521
ADDRLP4 0
ARGP4
ADDRGP4 $78
ARGP4
ADDRLP4 1292
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1292
INDIRP4
ARGP4
ADDRLP4 1296
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1296
INDIRI4
CNSTI4 0
NEI4 $519
LABELV $521
ADDRGP4 $515
JUMPV
LABELV $519
line 1086
;1085:		//skip spectators
;1086:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 0
ARGP4
ADDRGP4 $82
ARGP4
ADDRLP4 1300
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1300
INDIRP4
ARGP4
ADDRLP4 1304
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1304
INDIRI4
CNSTI4 3
NEI4 $522
ADDRGP4 $515
JUMPV
LABELV $522
line 1088
;1087:		//
;1088:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 1308
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1308
INDIRI4
CNSTI4 0
EQI4 $524
line 1089
;1089:			teammates[numteammates] = i;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
ADDP4
ADDRLP4 1024
INDIRI4
ASGNI4
line 1090
;1090:			numteammates++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1091
;1091:		}
LABELV $524
line 1092
;1092:	}
LABELV $515
line 1081
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $517
ADDRLP4 1024
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $514
line 1094
;1093:	//
;1094:	switch(numteammates) {
ADDRLP4 1028
INDIRI4
CNSTI4 1
LTI4 $526
ADDRLP4 1028
INDIRI4
CNSTI4 5
GTI4 $526
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $541-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $541
address $527
address $527
address $530
address $531
address $533
code
line 1095
;1095:		case 1: break;
line 1097
;1096:		case 2:
;1097:		{
line 1099
;1098:			//nothing special
;1099:			break;
LABELV $530
line 1102
;1100:		}
;1101:		case 3:
;1102:		{
line 1104
;1103:			//have one follow another and one free roaming
;1104:			BotCreateGroup(bs, teammates, 2);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 1105
;1105:			break;
ADDRGP4 $527
JUMPV
LABELV $531
line 1108
;1106:		}
;1107:		case 4:
;1108:		{
line 1109
;1109:			BotCreateGroup(bs, teammates, 2);		//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 1110
;1110:			BotCreateGroup(bs, &teammates[2], 2);	//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032+8
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 1111
;1111:			break;
ADDRGP4 $527
JUMPV
LABELV $533
line 1114
;1112:		}
;1113:		case 5:
;1114:		{
line 1115
;1115:			BotCreateGroup(bs, teammates, 2);		//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 1116
;1116:			BotCreateGroup(bs, &teammates[2], 3);	//a group of 3
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032+8
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 1117
;1117:			break;
ADDRGP4 $527
JUMPV
LABELV $526
line 1120
;1118:		}
;1119:		default:
;1120:		{
line 1121
;1121:			if (numteammates <= 10) {
ADDRLP4 1028
INDIRI4
CNSTI4 10
GTI4 $527
line 1122
;1122:				for (i = 0; i < numteammates / 2; i++) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $540
JUMPV
LABELV $537
line 1123
;1123:					BotCreateGroup(bs, &teammates[i*2], 2);	//groups of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1292
CNSTI4 2
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 1292
INDIRI4
LSHI4
ADDRLP4 1032
ADDP4
ARGP4
ADDRLP4 1292
INDIRI4
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 1124
;1124:				}
LABELV $538
line 1122
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $540
ADDRLP4 1024
INDIRI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
DIVI4
LTI4 $537
line 1125
;1125:			}
line 1126
;1126:			break;
LABELV $527
line 1129
;1127:		}
;1128:	}
;1129:}
LABELV $513
endproc BotTeamOrders 1312 12
export Bot1FCTFOrders_FlagAtCenter
proc Bot1FCTFOrders_FlagAtCenter 320 16
line 1138
;1130:
;1131:/*
;1132:==================
;1133:Bot1FCTFOrders_FlagAtCenter
;1134:
;1135:  X% defend the base, Y% get the flag
;1136:==================
;1137:*/
;1138:void Bot1FCTFOrders_FlagAtCenter(bot_state_t *bs) {
line 1143
;1139:	int numteammates, defenders, attackers, i;
;1140:	int teammates[MAX_CLIENTS];
;1141:	char name[MAX_NETNAME];
;1142:
;1143:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $544
line 1144
;1144:		return;
ADDRGP4 $543
JUMPV
LABELV $544
line 1148
;1145:	}
;1146:
;1147:	//sort team mates by travel time to base
;1148:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 1150
;1149:	//sort team mates by CTF preference
;1150:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 1152
;1151:	//passive strategy
;1152:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $547
line 1154
;1153:		//different orders based on the number of team mates
;1154:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $548
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $552
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $556
ADDRGP4 $549
JUMPV
line 1155
;1155:			case 1: break;
LABELV $552
line 1157
;1156:			case 2:
;1157:			{
line 1159
;1158:				//the one closest to the base will defend the base
;1159:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1160
;1160:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1161
;1161:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1162
;1162:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1164
;1163:				//the other will get the flag
;1164:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1165
;1165:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1166
;1166:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1167
;1167:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1168
;1168:				break;
ADDRGP4 $548
JUMPV
LABELV $556
line 1171
;1169:			}
;1170:			case 3:
;1171:			{
line 1173
;1172:				//the one closest to the base will defend the base
;1173:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1174
;1174:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1175
;1175:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1176
;1176:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1178
;1177:				//the second one closest to the base will defend the base
;1178:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1179
;1179:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1180
;1180:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1181
;1181:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1183
;1182:				//the other will get the flag
;1183:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1184
;1184:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1185
;1185:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1186
;1186:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1187
;1187:				break;
ADDRGP4 $548
JUMPV
LABELV $549
line 1190
;1188:			}
;1189:			default:
;1190:			{
line 1192
;1191:				//50% defend the base
;1192:				defenders = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 316
CNSTF4 1056964608
ASGNF4
ADDRLP4 300
ADDRLP4 316
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 316
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 1193
;1193:				if (defenders > 5) defenders = 5;
ADDRLP4 300
INDIRI4
CNSTI4 5
LEI4 $562
ADDRLP4 300
CNSTI4 5
ASGNI4
LABELV $562
line 1195
;1194:				//40% get the flag
;1195:				attackers = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 304
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1196
;1196:				if (attackers > 4) attackers = 4;
ADDRLP4 304
INDIRI4
CNSTI4 4
LEI4 $564
ADDRLP4 304
CNSTI4 4
ASGNI4
LABELV $564
line 1197
;1197:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $569
JUMPV
LABELV $566
line 1199
;1198:					//
;1199:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
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
line 1200
;1200:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1201
;1201:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1202
;1202:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1203
;1203:				}
LABELV $567
line 1197
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $569
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $566
line 1204
;1204:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $573
JUMPV
LABELV $570
line 1206
;1205:					//
;1206:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
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
line 1207
;1207:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1208
;1208:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1209
;1209:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1210
;1210:				}
LABELV $571
line 1204
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $573
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $570
line 1212
;1211:				//
;1212:				break;
line 1215
;1213:			}
;1214:		}
;1215:	}
ADDRGP4 $548
JUMPV
LABELV $547
line 1216
;1216:	else { //agressive
line 1218
;1217:		//different orders based on the number of team mates
;1218:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $578
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $580
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $584
ADDRGP4 $577
JUMPV
line 1219
;1219:			case 1: break;
LABELV $580
line 1221
;1220:			case 2:
;1221:			{
line 1223
;1222:				//the one closest to the base will defend the base
;1223:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1224
;1224:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1225
;1225:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1226
;1226:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1228
;1227:				//the other will get the flag
;1228:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1229
;1229:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1230
;1230:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1231
;1231:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1232
;1232:				break;
ADDRGP4 $578
JUMPV
LABELV $584
line 1235
;1233:			}
;1234:			case 3:
;1235:			{
line 1237
;1236:				//the one closest to the base will defend the base
;1237:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1238
;1238:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1239
;1239:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1240
;1240:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1242
;1241:				//the others should go for the enemy flag
;1242:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1243
;1243:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1244
;1244:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1245
;1245:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1247
;1246:				//
;1247:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1248
;1248:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1249
;1249:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1250
;1250:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1251
;1251:				break;
ADDRGP4 $578
JUMPV
LABELV $577
line 1254
;1252:			}
;1253:			default:
;1254:			{
line 1256
;1255:				//30% defend the base
;1256:				defenders = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 300
CNSTF4 1050253722
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1257
;1257:				if (defenders > 3) defenders = 3;
ADDRLP4 300
INDIRI4
CNSTI4 3
LEI4 $591
ADDRLP4 300
CNSTI4 3
ASGNI4
LABELV $591
line 1259
;1258:				//60% get the flag
;1259:				attackers = (int) (float) numteammates * 0.6 + 0.5;
ADDRLP4 304
CNSTF4 1058642330
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1260
;1260:				if (attackers > 6) attackers = 6;
ADDRLP4 304
INDIRI4
CNSTI4 6
LEI4 $593
ADDRLP4 304
CNSTI4 6
ASGNI4
LABELV $593
line 1261
;1261:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $598
JUMPV
LABELV $595
line 1263
;1262:					//
;1263:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
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
line 1264
;1264:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1265
;1265:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1266
;1266:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1267
;1267:				}
LABELV $596
line 1261
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $598
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $595
line 1268
;1268:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $602
JUMPV
LABELV $599
line 1270
;1269:					//
;1270:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
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
line 1271
;1271:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1272
;1272:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1273
;1273:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1274
;1274:				}
LABELV $600
line 1268
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $602
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $599
line 1276
;1275:				//
;1276:				break;
LABELV $578
line 1279
;1277:			}
;1278:		}
;1279:	}
LABELV $548
line 1280
;1280:}
LABELV $543
endproc Bot1FCTFOrders_FlagAtCenter 320 16
export Bot1FCTFOrders_TeamHasFlag
proc Bot1FCTFOrders_TeamHasFlag 360 20
line 1289
;1281:
;1282:/*
;1283:==================
;1284:Bot1FCTFOrders_TeamHasFlag
;1285:
;1286:  X% towards neutral flag, Y% go towards enemy base and accompany flag carrier if visible
;1287:==================
;1288:*/
;1289:void Bot1FCTFOrders_TeamHasFlag(bot_state_t *bs) {
line 1294
;1290:	int numteammates, defenders, attackers, i, other;
;1291:	int teammates[MAX_CLIENTS];
;1292:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;1293:
;1294:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $607
line 1295
;1295:		return;
ADDRGP4 $606
JUMPV
LABELV $607
line 1299
;1296:	}
;1297:
;1298:	//sort team mates by travel time to base
;1299:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 348
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 260
ADDRLP4 348
INDIRI4
ASGNI4
line 1301
;1300:	//sort team mates by CTF preference
;1301:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 1303
;1302:	//passive strategy
;1303:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $610
line 1305
;1304:		//different orders based on the number of team mates
;1305:		switch(numteammates) {
ADDRLP4 260
INDIRI4
CNSTI4 1
EQI4 $611
ADDRLP4 260
INDIRI4
CNSTI4 2
EQI4 $615
ADDRLP4 260
INDIRI4
CNSTI4 3
EQI4 $621
ADDRGP4 $612
JUMPV
line 1306
;1306:			case 1: break;
LABELV $615
line 1308
;1307:			case 2:
;1308:			{
line 1310
;1309:				//tell the one not carrying the flag to attack the enemy base
;1310:				if (teammates[0] == bs->flagcarrier) other = teammates[1];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $616
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
ADDRGP4 $617
JUMPV
LABELV $616
line 1311
;1311:				else other = teammates[0];
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $617
line 1312
;1312:				ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1313
;1313:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1314
;1314:				BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1315
;1315:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1316
;1316:				break;
ADDRGP4 $611
JUMPV
LABELV $621
line 1319
;1317:			}
;1318:			case 3:
;1319:			{
line 1321
;1320:				//tell the one closest to the base not carrying the flag to defend the base
;1321:				if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
EQI4 $622
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $623
JUMPV
LABELV $622
line 1322
;1322:				else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $623
line 1323
;1323:				ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1324
;1324:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1325
;1325:				BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1326
;1326:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1328
;1327:				//tell the one furthest from the base not carrying the flag to accompany the flag carrier
;1328:				if (teammates[2] != bs->flagcarrier) other = teammates[2];
ADDRLP4 4+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
EQI4 $625
ADDRLP4 308
ADDRLP4 4+8
INDIRI4
ASGNI4
ADDRGP4 $626
JUMPV
LABELV $625
line 1329
;1329:				else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $626
line 1330
;1330:				ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1331
;1331:				if ( bs->flagcarrier != -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $630
line 1332
;1332:					ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1333
;1333:					if (bs->flagcarrier == bs->client) {
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $632
line 1334
;1334:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1335
;1335:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $208
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1336
;1336:					}
ADDRGP4 $631
JUMPV
LABELV $632
line 1337
;1337:					else {
line 1338
;1338:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1339
;1339:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $210
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1340
;1340:					}
line 1341
;1341:				}
ADDRGP4 $631
JUMPV
LABELV $630
line 1342
;1342:				else {
line 1344
;1343:					//
;1344:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1345
;1345:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1346
;1346:				}
LABELV $631
line 1347
;1347:				BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1348
;1348:				break;
ADDRGP4 $611
JUMPV
LABELV $612
line 1351
;1349:			}
;1350:			default:
;1351:			{
line 1353
;1352:				//30% will defend the base
;1353:				defenders = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 300
CNSTF4 1050253722
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1354
;1354:				if (defenders > 3) defenders = 3;
ADDRLP4 300
INDIRI4
CNSTI4 3
LEI4 $634
ADDRLP4 300
CNSTI4 3
ASGNI4
LABELV $634
line 1356
;1355:				//70% accompanies the flag carrier
;1356:				attackers = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 304
CNSTF4 1060320051
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1357
;1357:				if (attackers > 7) attackers = 7;
ADDRLP4 304
INDIRI4
CNSTI4 7
LEI4 $636
ADDRLP4 304
CNSTI4 7
ASGNI4
LABELV $636
line 1358
;1358:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $641
JUMPV
LABELV $638
line 1360
;1359:					//
;1360:					if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $642
line 1361
;1361:						continue;
ADDRGP4 $639
JUMPV
LABELV $642
line 1363
;1362:					}
;1363:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1364
;1364:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1365
;1365:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1366
;1366:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1367
;1367:				}
LABELV $639
line 1358
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $641
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $638
line 1368
;1368:				if (bs->flagcarrier != -1) {
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $644
line 1369
;1369:					ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1370
;1370:					for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $649
JUMPV
LABELV $646
line 1372
;1371:						//
;1372:						if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $650
line 1373
;1373:							continue;
ADDRGP4 $647
JUMPV
LABELV $650
line 1376
;1374:						}
;1375:						//
;1376:						ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1377
;1377:						if (bs->flagcarrier == bs->client) {
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $654
line 1378
;1378:							BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1379
;1379:							BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $208
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1380
;1380:						}
ADDRGP4 $655
JUMPV
LABELV $654
line 1381
;1381:						else {
line 1382
;1382:							BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1383
;1383:							BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $210
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1384
;1384:						}
LABELV $655
line 1385
;1385:						BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1386
;1386:					}
LABELV $647
line 1370
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $649
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $646
line 1387
;1387:				}
ADDRGP4 $611
JUMPV
LABELV $644
line 1388
;1388:				else {
line 1389
;1389:					for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $662
JUMPV
LABELV $659
line 1391
;1390:						//
;1391:						if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $663
line 1392
;1392:							continue;
ADDRGP4 $660
JUMPV
LABELV $663
line 1395
;1393:						}
;1394:						//
;1395:						ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1396
;1396:						BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1397
;1397:						BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1398
;1398:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1399
;1399:					}
LABELV $660
line 1389
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $662
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $659
line 1400
;1400:				}
line 1402
;1401:				//
;1402:				break;
line 1405
;1403:			}
;1404:		}
;1405:	}
ADDRGP4 $611
JUMPV
LABELV $610
line 1406
;1406:	else { //agressive
line 1408
;1407:		//different orders based on the number of team mates
;1408:		switch(numteammates) {
ADDRLP4 260
INDIRI4
CNSTI4 1
EQI4 $670
ADDRLP4 260
INDIRI4
CNSTI4 2
EQI4 $672
ADDRLP4 260
INDIRI4
CNSTI4 3
EQI4 $676
ADDRGP4 $669
JUMPV
line 1409
;1409:			case 1: break;
LABELV $672
line 1411
;1410:			case 2:
;1411:			{
line 1413
;1412:				//tell the one not carrying the flag to defend the base
;1413:				if (teammates[0] == bs->flagcarrier) other = teammates[1];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $673
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
ADDRGP4 $674
JUMPV
LABELV $673
line 1414
;1414:				else other = teammates[0];
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $674
line 1415
;1415:				ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1416
;1416:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1417
;1417:				BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1418
;1418:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1419
;1419:				break;
ADDRGP4 $670
JUMPV
LABELV $676
line 1422
;1420:			}
;1421:			case 3:
;1422:			{
line 1424
;1423:				//tell the one closest to the base not carrying the flag to defend the base
;1424:				if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
EQI4 $677
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $678
JUMPV
LABELV $677
line 1425
;1425:				else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $678
line 1426
;1426:				ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1427
;1427:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1428
;1428:				BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1429
;1429:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1431
;1430:				//tell the one furthest from the base not carrying the flag to accompany the flag carrier
;1431:				if (teammates[2] != bs->flagcarrier) other = teammates[2];
ADDRLP4 4+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
EQI4 $680
ADDRLP4 308
ADDRLP4 4+8
INDIRI4
ASGNI4
ADDRGP4 $681
JUMPV
LABELV $680
line 1432
;1432:				else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $681
line 1433
;1433:				ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1434
;1434:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1435
;1435:				if (bs->flagcarrier == bs->client) {
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $685
line 1436
;1436:					BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1437
;1437:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $208
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1438
;1438:				}
ADDRGP4 $686
JUMPV
LABELV $685
line 1439
;1439:				else {
line 1440
;1440:					BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1441
;1441:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $210
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1442
;1442:				}
LABELV $686
line 1443
;1443:				BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1444
;1444:				break;
ADDRGP4 $670
JUMPV
LABELV $669
line 1447
;1445:			}
;1446:			default:
;1447:			{
line 1449
;1448:				//20% will defend the base
;1449:				defenders = (int) (float) numteammates * 0.2 + 0.5;
ADDRLP4 300
CNSTF4 1045220557
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1450
;1450:				if (defenders > 2) defenders = 2;
ADDRLP4 300
INDIRI4
CNSTI4 2
LEI4 $687
ADDRLP4 300
CNSTI4 2
ASGNI4
LABELV $687
line 1452
;1451:				//80% accompanies the flag carrier
;1452:				attackers = (int) (float) numteammates * 0.8 + 0.5;
ADDRLP4 304
CNSTF4 1061997773
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1453
;1453:				if (attackers > 8) attackers = 8;
ADDRLP4 304
INDIRI4
CNSTI4 8
LEI4 $689
ADDRLP4 304
CNSTI4 8
ASGNI4
LABELV $689
line 1454
;1454:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $694
JUMPV
LABELV $691
line 1456
;1455:					//
;1456:					if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $695
line 1457
;1457:						continue;
ADDRGP4 $692
JUMPV
LABELV $695
line 1459
;1458:					}
;1459:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1460
;1460:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1461
;1461:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1462
;1462:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1463
;1463:				}
LABELV $692
line 1454
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $694
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $691
line 1464
;1464:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1465
;1465:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $700
JUMPV
LABELV $697
line 1467
;1466:					//
;1467:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
NEI4 $701
line 1468
;1468:						continue;
ADDRGP4 $698
JUMPV
LABELV $701
line 1471
;1469:					}
;1470:					//
;1471:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1472
;1472:					if (bs->flagcarrier == bs->client) {
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 6832
ADDP4
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $705
line 1473
;1473:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1474
;1474:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $208
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1475
;1475:					}
ADDRGP4 $706
JUMPV
LABELV $705
line 1476
;1476:					else {
line 1477
;1477:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1478
;1478:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $210
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1479
;1479:					}
LABELV $706
line 1480
;1480:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1481
;1481:				}
LABELV $698
line 1465
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $700
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $697
line 1483
;1482:				//
;1483:				break;
LABELV $670
line 1486
;1484:			}
;1485:		}
;1486:	}
LABELV $611
line 1487
;1487:}
LABELV $606
endproc Bot1FCTFOrders_TeamHasFlag 360 20
export Bot1FCTFOrders_EnemyHasFlag
proc Bot1FCTFOrders_EnemyHasFlag 316 16
line 1496
;1488:
;1489:/*
;1490:==================
;1491:Bot1FCTFOrders_EnemyHasFlag
;1492:
;1493:  X% defend the base, Y% towards neutral flag
;1494:==================
;1495:*/
;1496:void Bot1FCTFOrders_EnemyHasFlag(bot_state_t *bs) {
line 1501
;1497:	int numteammates, defenders, attackers, i;
;1498:	int teammates[MAX_CLIENTS];
;1499:	char name[MAX_NETNAME];
;1500:
;1501:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $711
line 1502
;1502:		return;
ADDRGP4 $710
JUMPV
LABELV $711
line 1506
;1503:	}
;1504:
;1505:	//sort team mates by travel time to base
;1506:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 1508
;1507:	//sort team mates by CTF preference
;1508:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 1510
;1509:	//passive strategy
;1510:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $714
line 1512
;1511:		//different orders based on the number of team mates
;1512:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $715
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $719
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $723
ADDRGP4 $716
JUMPV
line 1513
;1513:			case 1: break;
LABELV $719
line 1515
;1514:			case 2:
;1515:			{
line 1517
;1516:				//both defend the base
;1517:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1518
;1518:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1519
;1519:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1520
;1520:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1522
;1521:				//
;1522:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1523
;1523:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1524
;1524:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1525
;1525:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1526
;1526:				break;
ADDRGP4 $715
JUMPV
LABELV $723
line 1529
;1527:			}
;1528:			case 3:
;1529:			{
line 1531
;1530:				//the one closest to the base will defend the base
;1531:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1532
;1532:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1533
;1533:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1534
;1534:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1536
;1535:				//the second one closest to the base will defend the base
;1536:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1537
;1537:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1538
;1538:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1539
;1539:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1541
;1540:				//the other will also defend the base
;1541:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1542
;1542:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1543
;1543:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1544
;1544:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1545
;1545:				break;
ADDRGP4 $715
JUMPV
LABELV $716
line 1548
;1546:			}
;1547:			default:
;1548:			{
line 1550
;1549:				//80% will defend the base
;1550:				defenders = (int) (float) numteammates * 0.8 + 0.5;
ADDRLP4 300
CNSTF4 1061997773
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1551
;1551:				if (defenders > 8) defenders = 8;
ADDRLP4 300
INDIRI4
CNSTI4 8
LEI4 $730
ADDRLP4 300
CNSTI4 8
ASGNI4
LABELV $730
line 1553
;1552:				//10% will try to return the flag
;1553:				attackers = (int) (float) numteammates * 0.1 + 0.5;
ADDRLP4 304
CNSTF4 1036831949
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1554
;1554:				if (attackers > 1) attackers = 1;
ADDRLP4 304
INDIRI4
CNSTI4 1
LEI4 $732
ADDRLP4 304
CNSTI4 1
ASGNI4
LABELV $732
line 1555
;1555:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $737
JUMPV
LABELV $734
line 1557
;1556:					//
;1557:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
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
line 1558
;1558:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1559
;1559:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1560
;1560:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1561
;1561:				}
LABELV $735
line 1555
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $737
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $734
line 1562
;1562:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $741
JUMPV
LABELV $738
line 1564
;1563:					//
;1564:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
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
line 1565
;1565:					BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $743
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1566
;1566:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1567
;1567:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1568
;1568:				}
LABELV $739
line 1562
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $741
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $738
line 1570
;1569:				//
;1570:				break;
line 1573
;1571:			}
;1572:		}
;1573:	}
ADDRGP4 $715
JUMPV
LABELV $714
line 1574
;1574:	else { //agressive
line 1576
;1575:		//different orders based on the number of team mates
;1576:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $747
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $749
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $753
ADDRGP4 $746
JUMPV
line 1577
;1577:			case 1: break;
LABELV $749
line 1579
;1578:			case 2:
;1579:			{
line 1581
;1580:				//the one closest to the base will defend the base
;1581:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1582
;1582:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1583
;1583:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1584
;1584:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1586
;1585:				//the other will get the flag
;1586:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1587
;1587:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1588
;1588:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1589
;1589:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1590
;1590:				break;
ADDRGP4 $747
JUMPV
LABELV $753
line 1593
;1591:			}
;1592:			case 3:
;1593:			{
line 1595
;1594:				//the one closest to the base will defend the base
;1595:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1596
;1596:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1597
;1597:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1598
;1598:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1600
;1599:				//the others should go for the enemy flag
;1600:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1601
;1601:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1602
;1602:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1603
;1603:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1605
;1604:				//
;1605:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1606
;1606:				BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $743
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1607
;1607:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1608
;1608:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1609
;1609:				break;
ADDRGP4 $747
JUMPV
LABELV $746
line 1612
;1610:			}
;1611:			default:
;1612:			{
line 1614
;1613:				//70% defend the base
;1614:				defenders = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 300
CNSTF4 1060320051
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1615
;1615:				if (defenders > 7) defenders = 7;
ADDRLP4 300
INDIRI4
CNSTI4 7
LEI4 $760
ADDRLP4 300
CNSTI4 7
ASGNI4
LABELV $760
line 1617
;1616:				//20% try to return the flag
;1617:				attackers = (int) (float) numteammates * 0.2 + 0.5;
ADDRLP4 304
CNSTF4 1045220557
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1618
;1618:				if (attackers > 2) attackers = 2;
ADDRLP4 304
INDIRI4
CNSTI4 2
LEI4 $762
ADDRLP4 304
CNSTI4 2
ASGNI4
LABELV $762
line 1619
;1619:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $767
JUMPV
LABELV $764
line 1621
;1620:					//
;1621:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
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
line 1622
;1622:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1623
;1623:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1624
;1624:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1625
;1625:				}
LABELV $765
line 1619
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $767
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $764
line 1626
;1626:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $771
JUMPV
LABELV $768
line 1628
;1627:					//
;1628:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
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
line 1629
;1629:					BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $743
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1630
;1630:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1631
;1631:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1632
;1632:				}
LABELV $769
line 1626
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $771
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $768
line 1634
;1633:				//
;1634:				break;
LABELV $747
line 1637
;1635:			}
;1636:		}
;1637:	}
LABELV $715
line 1638
;1638:}
LABELV $710
endproc Bot1FCTFOrders_EnemyHasFlag 316 16
export Bot1FCTFOrders_EnemyDroppedFlag
proc Bot1FCTFOrders_EnemyDroppedFlag 320 16
line 1647
;1639:
;1640:/*
;1641:==================
;1642:Bot1FCTFOrders_EnemyDroppedFlag
;1643:
;1644:  X% defend the base, Y% get the flag
;1645:==================
;1646:*/
;1647:void Bot1FCTFOrders_EnemyDroppedFlag(bot_state_t *bs) {
line 1652
;1648:	int numteammates, defenders, attackers, i;
;1649:	int teammates[MAX_CLIENTS];
;1650:	char name[MAX_NETNAME];
;1651:
;1652:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $776
line 1653
;1653:		return;
ADDRGP4 $775
JUMPV
LABELV $776
line 1657
;1654:	}
;1655:
;1656:	//sort team mates by travel time to base
;1657:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 1659
;1658:	//sort team mates by CTF preference
;1659:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 1661
;1660:	//passive strategy
;1661:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $779
line 1663
;1662:		//different orders based on the number of team mates
;1663:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $780
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $784
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $788
ADDRGP4 $781
JUMPV
line 1664
;1664:			case 1: break;
LABELV $784
line 1666
;1665:			case 2:
;1666:			{
line 1668
;1667:				//the one closest to the base will defend the base
;1668:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1669
;1669:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1670
;1670:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1671
;1671:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1673
;1672:				//the other will get the flag
;1673:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1674
;1674:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1675
;1675:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1676
;1676:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1677
;1677:				break;
ADDRGP4 $780
JUMPV
LABELV $788
line 1680
;1678:			}
;1679:			case 3:
;1680:			{
line 1682
;1681:				//the one closest to the base will defend the base
;1682:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1683
;1683:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1684
;1684:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1685
;1685:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1687
;1686:				//the second one closest to the base will defend the base
;1687:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1688
;1688:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1689
;1689:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1690
;1690:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1692
;1691:				//the other will get the flag
;1692:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1693
;1693:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1694
;1694:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1695
;1695:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1696
;1696:				break;
ADDRGP4 $780
JUMPV
LABELV $781
line 1699
;1697:			}
;1698:			default:
;1699:			{
line 1701
;1700:				//50% defend the base
;1701:				defenders = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 316
CNSTF4 1056964608
ASGNF4
ADDRLP4 300
ADDRLP4 316
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 316
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 1702
;1702:				if (defenders > 5) defenders = 5;
ADDRLP4 300
INDIRI4
CNSTI4 5
LEI4 $795
ADDRLP4 300
CNSTI4 5
ASGNI4
LABELV $795
line 1704
;1703:				//40% get the flag
;1704:				attackers = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 304
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1705
;1705:				if (attackers > 4) attackers = 4;
ADDRLP4 304
INDIRI4
CNSTI4 4
LEI4 $797
ADDRLP4 304
CNSTI4 4
ASGNI4
LABELV $797
line 1706
;1706:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $802
JUMPV
LABELV $799
line 1708
;1707:					//
;1708:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
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
line 1709
;1709:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1710
;1710:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1711
;1711:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1712
;1712:				}
LABELV $800
line 1706
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $802
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $799
line 1713
;1713:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $806
JUMPV
LABELV $803
line 1715
;1714:					//
;1715:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
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
line 1716
;1716:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1717
;1717:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1718
;1718:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1719
;1719:				}
LABELV $804
line 1713
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $806
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $803
line 1721
;1720:				//
;1721:				break;
line 1724
;1722:			}
;1723:		}
;1724:	}
ADDRGP4 $780
JUMPV
LABELV $779
line 1725
;1725:	else { //agressive
line 1727
;1726:		//different orders based on the number of team mates
;1727:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $811
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $813
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $817
ADDRGP4 $810
JUMPV
line 1728
;1728:			case 1: break;
LABELV $813
line 1730
;1729:			case 2:
;1730:			{
line 1732
;1731:				//the one closest to the base will defend the base
;1732:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1733
;1733:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1734
;1734:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1735
;1735:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1737
;1736:				//the other will get the flag
;1737:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1738
;1738:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1739
;1739:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1740
;1740:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1741
;1741:				break;
ADDRGP4 $811
JUMPV
LABELV $817
line 1744
;1742:			}
;1743:			case 3:
;1744:			{
line 1746
;1745:				//the one closest to the base will defend the base
;1746:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1747
;1747:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1748
;1748:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1749
;1749:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1751
;1750:				//the others should go for the enemy flag
;1751:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1752
;1752:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1753
;1753:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1754
;1754:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1756
;1755:				//
;1756:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1757
;1757:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1758
;1758:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1759
;1759:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1760
;1760:				break;
ADDRGP4 $811
JUMPV
LABELV $810
line 1763
;1761:			}
;1762:			default:
;1763:			{
line 1765
;1764:				//30% defend the base
;1765:				defenders = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 300
CNSTF4 1050253722
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1766
;1766:				if (defenders > 3) defenders = 3;
ADDRLP4 300
INDIRI4
CNSTI4 3
LEI4 $824
ADDRLP4 300
CNSTI4 3
ASGNI4
LABELV $824
line 1768
;1767:				//60% get the flag
;1768:				attackers = (int) (float) numteammates * 0.6 + 0.5;
ADDRLP4 304
CNSTF4 1058642330
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1769
;1769:				if (attackers > 6) attackers = 6;
ADDRLP4 304
INDIRI4
CNSTI4 6
LEI4 $826
ADDRLP4 304
CNSTI4 6
ASGNI4
LABELV $826
line 1770
;1770:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $831
JUMPV
LABELV $828
line 1772
;1771:					//
;1772:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
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
line 1773
;1773:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1774
;1774:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1775
;1775:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1776
;1776:				}
LABELV $829
line 1770
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $831
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $828
line 1777
;1777:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $835
JUMPV
LABELV $832
line 1779
;1778:					//
;1779:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
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
line 1780
;1780:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1781
;1781:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1782
;1782:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1783
;1783:				}
LABELV $833
line 1777
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $835
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $832
line 1785
;1784:				//
;1785:				break;
LABELV $811
line 1788
;1786:			}
;1787:		}
;1788:	}
LABELV $780
line 1789
;1789:}
LABELV $775
endproc Bot1FCTFOrders_EnemyDroppedFlag 320 16
export Bot1FCTFOrders
proc Bot1FCTFOrders 8 4
line 1796
;1790:
;1791:/*
;1792:==================
;1793:Bot1FCTFOrders
;1794:==================
;1795:*/
;1796:void Bot1FCTFOrders(bot_state_t *bs) {
line 1797
;1797:	switch(bs->neutralflagstatus) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $840
ADDRLP4 0
INDIRI4
CNSTI4 3
GTI4 $840
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $847
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $847
address $843
address $844
address $845
address $846
code
LABELV $843
line 1798
;1798:		case 0: Bot1FCTFOrders_FlagAtCenter(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFOrders_FlagAtCenter
CALLV
pop
ADDRGP4 $841
JUMPV
LABELV $844
line 1799
;1799:		case 1: Bot1FCTFOrders_TeamHasFlag(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFOrders_TeamHasFlag
CALLV
pop
ADDRGP4 $841
JUMPV
LABELV $845
line 1800
;1800:		case 2: Bot1FCTFOrders_EnemyHasFlag(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFOrders_EnemyHasFlag
CALLV
pop
ADDRGP4 $841
JUMPV
LABELV $846
line 1801
;1801:		case 3: Bot1FCTFOrders_EnemyDroppedFlag(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFOrders_EnemyDroppedFlag
CALLV
pop
LABELV $840
LABELV $841
line 1803
;1802:	}
;1803:}
LABELV $839
endproc Bot1FCTFOrders 8 4
export BotObeliskOrders
proc BotObeliskOrders 320 16
line 1812
;1804:
;1805:/*
;1806:==================
;1807:BotObeliskOrders
;1808:
;1809:  X% in defence Y% in offence
;1810:==================
;1811:*/
;1812:void BotObeliskOrders(bot_state_t *bs) {
line 1817
;1813:	int numteammates, defenders, attackers, i;
;1814:	int teammates[MAX_CLIENTS];
;1815:	char name[MAX_NETNAME];
;1816:
;1817:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $849
line 1818
;1818:		return;
ADDRGP4 $848
JUMPV
LABELV $849
line 1822
;1819:	}
;1820:
;1821:	//sort team mates by travel time to base
;1822:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 1824
;1823:	//sort team mates by CTF preference
;1824:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 1826
;1825:	//passive strategy
;1826:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $852
line 1828
;1827:		//different orders based on the number of team mates
;1828:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $853
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $857
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $861
ADDRGP4 $854
JUMPV
line 1829
;1829:			case 1: break;
LABELV $857
line 1831
;1830:			case 2:
;1831:			{
line 1833
;1832:				//the one closest to the base will defend the base
;1833:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1834
;1834:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1835
;1835:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1836
;1836:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1838
;1837:				//the other will attack the enemy base
;1838:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1839
;1839:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1840
;1840:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1841
;1841:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1842
;1842:				break;
ADDRGP4 $853
JUMPV
LABELV $861
line 1845
;1843:			}
;1844:			case 3:
;1845:			{
line 1847
;1846:				//the one closest to the base will defend the base
;1847:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1848
;1848:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1849
;1849:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1850
;1850:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1852
;1851:				//the one second closest to the base also defends the base
;1852:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1853
;1853:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1854
;1854:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1855
;1855:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1857
;1856:				//the other one attacks the enemy base
;1857:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1858
;1858:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1859
;1859:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1860
;1860:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1861
;1861:				break;
ADDRGP4 $853
JUMPV
LABELV $854
line 1864
;1862:			}
;1863:			default:
;1864:			{
line 1866
;1865:				//50% defend the base
;1866:				defenders = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 316
CNSTF4 1056964608
ASGNF4
ADDRLP4 300
ADDRLP4 316
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 316
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 1867
;1867:				if (defenders > 5) defenders = 5;
ADDRLP4 300
INDIRI4
CNSTI4 5
LEI4 $868
ADDRLP4 300
CNSTI4 5
ASGNI4
LABELV $868
line 1869
;1868:				//40% attack the enemy base
;1869:				attackers = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 304
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1870
;1870:				if (attackers > 4) attackers = 4;
ADDRLP4 304
INDIRI4
CNSTI4 4
LEI4 $870
ADDRLP4 304
CNSTI4 4
ASGNI4
LABELV $870
line 1871
;1871:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $875
JUMPV
LABELV $872
line 1873
;1872:					//
;1873:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
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
line 1874
;1874:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1875
;1875:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1876
;1876:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1877
;1877:				}
LABELV $873
line 1871
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $875
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $872
line 1878
;1878:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $879
JUMPV
LABELV $876
line 1880
;1879:					//
;1880:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
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
line 1881
;1881:					BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1882
;1882:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1883
;1883:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1884
;1884:				}
LABELV $877
line 1878
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $879
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $876
line 1886
;1885:				//
;1886:				break;
line 1889
;1887:			}
;1888:		}
;1889:	}
ADDRGP4 $853
JUMPV
LABELV $852
line 1890
;1890:	else {
line 1892
;1891:		//different orders based on the number of team mates
;1892:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $884
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $886
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $890
ADDRGP4 $883
JUMPV
line 1893
;1893:			case 1: break;
LABELV $886
line 1895
;1894:			case 2:
;1895:			{
line 1897
;1896:				//the one closest to the base will defend the base
;1897:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1898
;1898:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1899
;1899:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1900
;1900:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1902
;1901:				//the other will attack the enemy base
;1902:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1903
;1903:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1904
;1904:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1905
;1905:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1906
;1906:				break;
ADDRGP4 $884
JUMPV
LABELV $890
line 1909
;1907:			}
;1908:			case 3:
;1909:			{
line 1911
;1910:				//the one closest to the base will defend the base
;1911:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1912
;1912:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1913
;1913:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1914
;1914:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1916
;1915:				//the others attack the enemy base
;1916:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1917
;1917:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1918
;1918:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1919
;1919:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1921
;1920:				//
;1921:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1922
;1922:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1923
;1923:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1924
;1924:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1925
;1925:				break;
ADDRGP4 $884
JUMPV
LABELV $883
line 1928
;1926:			}
;1927:			default:
;1928:			{
line 1930
;1929:				//30% defend the base
;1930:				defenders = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 300
CNSTF4 1050253722
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1931
;1931:				if (defenders > 3) defenders = 3;
ADDRLP4 300
INDIRI4
CNSTI4 3
LEI4 $897
ADDRLP4 300
CNSTI4 3
ASGNI4
LABELV $897
line 1933
;1932:				//70% attack the enemy base
;1933:				attackers = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 304
CNSTF4 1060320051
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 1934
;1934:				if (attackers > 7) attackers = 7;
ADDRLP4 304
INDIRI4
CNSTI4 7
LEI4 $899
ADDRLP4 304
CNSTI4 7
ASGNI4
LABELV $899
line 1935
;1935:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $904
JUMPV
LABELV $901
line 1937
;1936:					//
;1937:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
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
line 1938
;1938:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1939
;1939:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1940
;1940:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1941
;1941:				}
LABELV $902
line 1935
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $904
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $901
line 1942
;1942:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $908
JUMPV
LABELV $905
line 1944
;1943:					//
;1944:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
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
line 1945
;1945:					BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1946
;1946:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1947
;1947:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1948
;1948:				}
LABELV $906
line 1942
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $908
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $905
line 1950
;1949:				//
;1950:				break;
LABELV $884
line 1953
;1951:			}
;1952:		}
;1953:	}
LABELV $853
line 1954
;1954:}
LABELV $848
endproc BotObeliskOrders 320 16
export BotHarvesterOrders
proc BotHarvesterOrders 320 16
line 1963
;1955:
;1956:/*
;1957:==================
;1958:BotHarvesterOrders
;1959:
;1960:  X% defend the base, Y% harvest
;1961:==================
;1962:*/
;1963:void BotHarvesterOrders(bot_state_t *bs) {
line 1968
;1964:	int numteammates, defenders, attackers, i;
;1965:	int teammates[MAX_CLIENTS];
;1966:	char name[MAX_NETNAME];
;1967:
;1968:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $913
line 1969
;1969:		return;
ADDRGP4 $912
JUMPV
LABELV $913
line 1973
;1970:	}
;1971:
;1972:	//sort team mates by travel time to base
;1973:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 1975
;1974:	//sort team mates by CTF preference
;1975:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 1977
;1976:	//passive strategy
;1977:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $916
line 1979
;1978:		//different orders based on the number of team mates
;1979:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $917
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $921
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $926
ADDRGP4 $918
JUMPV
line 1980
;1980:			case 1: break;
LABELV $921
line 1982
;1981:			case 2:
;1982:			{
line 1984
;1983:				//the one closest to the base will defend the base
;1984:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1985
;1985:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1986
;1986:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1987
;1987:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1989
;1988:				//the other will harvest
;1989:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1990
;1990:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $923
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1991
;1991:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 1992
;1992:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1993
;1993:				break;
ADDRGP4 $917
JUMPV
LABELV $926
line 1996
;1994:			}
;1995:			case 3:
;1996:			{
line 1998
;1997:				//the one closest to the base will defend the base
;1998:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1999
;1999:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2000
;2000:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2001
;2001:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2003
;2002:				//the one second closest to the base also defends the base
;2003:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 2004
;2004:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2005
;2005:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2006
;2006:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2008
;2007:				//the other one goes harvesting
;2008:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 2009
;2009:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $923
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2010
;2010:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2011
;2011:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2012
;2012:				break;
ADDRGP4 $917
JUMPV
LABELV $918
line 2015
;2013:			}
;2014:			default:
;2015:			{
line 2017
;2016:				//50% defend the base
;2017:				defenders = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 316
CNSTF4 1056964608
ASGNF4
ADDRLP4 300
ADDRLP4 316
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 316
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 2018
;2018:				if (defenders > 5) defenders = 5;
ADDRLP4 300
INDIRI4
CNSTI4 5
LEI4 $933
ADDRLP4 300
CNSTI4 5
ASGNI4
LABELV $933
line 2020
;2019:				//40% goes harvesting
;2020:				attackers = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 304
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 2021
;2021:				if (attackers > 4) attackers = 4;
ADDRLP4 304
INDIRI4
CNSTI4 4
LEI4 $935
ADDRLP4 304
CNSTI4 4
ASGNI4
LABELV $935
line 2022
;2022:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $940
JUMPV
LABELV $937
line 2024
;2023:					//
;2024:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
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
line 2025
;2025:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2026
;2026:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2027
;2027:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2028
;2028:				}
LABELV $938
line 2022
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $940
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $937
line 2029
;2029:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $944
JUMPV
LABELV $941
line 2031
;2030:					//
;2031:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
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
line 2032
;2032:					BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $923
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2033
;2033:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2034
;2034:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2035
;2035:				}
LABELV $942
line 2029
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $944
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $941
line 2037
;2036:				//
;2037:				break;
line 2040
;2038:			}
;2039:		}
;2040:	}
ADDRGP4 $917
JUMPV
LABELV $916
line 2041
;2041:	else {
line 2043
;2042:		//different orders based on the number of team mates
;2043:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $949
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $951
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $955
ADDRGP4 $948
JUMPV
line 2044
;2044:			case 1: break;
LABELV $951
line 2046
;2045:			case 2:
;2046:			{
line 2048
;2047:				//the one closest to the base will defend the base
;2048:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 2049
;2049:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2050
;2050:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2051
;2051:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2053
;2052:				//the other will harvest
;2053:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 2054
;2054:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $923
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2055
;2055:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2056
;2056:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2057
;2057:				break;
ADDRGP4 $949
JUMPV
LABELV $955
line 2060
;2058:			}
;2059:			case 3:
;2060:			{
line 2062
;2061:				//the one closest to the base will defend the base
;2062:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 2063
;2063:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2064
;2064:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2065
;2065:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2067
;2066:				//the others go harvesting
;2067:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 2068
;2068:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $923
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2069
;2069:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2070
;2070:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2072
;2071:				//
;2072:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 2073
;2073:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $923
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2074
;2074:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2075
;2075:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2076
;2076:				break;
ADDRGP4 $949
JUMPV
LABELV $948
line 2079
;2077:			}
;2078:			default:
;2079:			{
line 2081
;2080:				//30% defend the base
;2081:				defenders = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 300
CNSTF4 1050253722
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 2082
;2082:				if (defenders > 3) defenders = 3;
ADDRLP4 300
INDIRI4
CNSTI4 3
LEI4 $962
ADDRLP4 300
CNSTI4 3
ASGNI4
LABELV $962
line 2084
;2083:				//70% go harvesting
;2084:				attackers = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 304
CNSTF4 1060320051
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 2085
;2085:				if (attackers > 7) attackers = 7;
ADDRLP4 304
INDIRI4
CNSTI4 7
LEI4 $964
ADDRLP4 304
CNSTI4 7
ASGNI4
LABELV $964
line 2086
;2086:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $969
JUMPV
LABELV $966
line 2088
;2087:					//
;2088:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
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
line 2089
;2089:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2090
;2090:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2091
;2091:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $284
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2092
;2092:				}
LABELV $967
line 2086
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $969
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $966
line 2093
;2093:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $973
JUMPV
LABELV $970
line 2095
;2094:					//
;2095:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
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
line 2096
;2096:					BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $923
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2097
;2097:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 2098
;2098:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $620
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2099
;2099:				}
LABELV $971
line 2093
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $973
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $970
line 2101
;2100:				//
;2101:				break;
LABELV $949
line 2104
;2102:			}
;2103:		}
;2104:	}
LABELV $917
line 2105
;2105:}
LABELV $912
endproc BotHarvesterOrders 320 16
export FindHumanTeamLeader
proc FindHumanTeamLeader 12 12
line 2112
;2106:
;2107:/*
;2108:==================
;2109:FindHumanTeamLeader
;2110:==================
;2111:*/
;2112:int FindHumanTeamLeader(bot_state_t *bs) {
line 2115
;2113:	int i;
;2114:
;2115:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $978
line 2116
;2116:		if ( g_entities[i].inuse ) {
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $982
line 2118
;2117:			// if this player is not a bot
;2118:			if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $985
line 2120
;2119:				// if this player is ok with being the leader
;2120:				if (!notleader[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 notleader
ADDP4
INDIRI4
CNSTI4 0
NEI4 $989
line 2122
;2121:					// if this player is on the same team
;2122:					if ( BotSameTeam(bs, i) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $991
line 2123
;2123:						ClientName(i, bs->teamleader, sizeof(bs->teamleader));
ADDRLP4 0
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
line 2125
;2124:						// if not yet ordered to do anything
;2125:						if ( !BotSetLastOrderedTask(bs) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $993
line 2127
;2126:							// go on defense by default
;2127:							if (bot_nochat.integer<3) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 3
GEI4 $995
line 2128
;2128:								BotVoiceChat_Defend(bs, i, SAY_TELL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 BotVoiceChat_Defend
CALLV
pop
line 2129
;2129:							}
LABELV $995
line 2130
;2130:						}
LABELV $993
line 2131
;2131:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $977
JUMPV
LABELV $991
line 2133
;2132:					}
;2133:				}
LABELV $989
line 2134
;2134:			}
LABELV $985
line 2135
;2135:		}
LABELV $982
line 2136
;2136:	}
LABELV $979
line 2115
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $978
line 2137
;2137:	return qfalse;
CNSTI4 0
RETI4
LABELV $977
endproc FindHumanTeamLeader 12 12
export BotTeamAI
proc BotTeamAI 76 12
line 2147
;2138:}
;2139:
;2140:int lastRoundNumber; //used to give new orders every round
;2141:
;2142:/*
;2143:==================
;2144:BotTeamAI
;2145:==================
;2146:*/
;2147:void BotTeamAI(bot_state_t *bs) {
line 2151
;2148:	int numteammates;
;2149:	char netname[MAX_NETNAME];
;2150:
;2151:	if (bot_nochat.integer>2) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 2
LEI4 $999
line 2152
;2152:		return;
ADDRGP4 $998
JUMPV
LABELV $999
line 2156
;2153:	}
;2154:
;2155:	//
;2156:	if (!G_IsATeamGametype(gametype))
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $1002
line 2157
;2157:		return;
ADDRGP4 $998
JUMPV
LABELV $1002
line 2159
;2158:	// make sure we've got a valid team leader
;2159:	if (!BotValidTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 BotValidTeamLeader
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $1004
line 2161
;2160:		//
;2161:		if (!FindHumanTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 FindHumanTeamLeader
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $1006
line 2163
;2162:			//
;2163:			if (!bs->askteamleader_time && !bs->becometeamleader_time) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 52
INDIRP4
CNSTI4 6792
ADDP4
INDIRF4
ADDRLP4 56
INDIRF4
NEF4 $1008
ADDRLP4 52
INDIRP4
CNSTI4 6796
ADDP4
INDIRF4
ADDRLP4 56
INDIRF4
NEF4 $1008
line 2164
;2164:				if (bs->entergame_time + 10 > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 5920
ADDP4
INDIRF4
CNSTF4 1092616192
ADDF4
ADDRGP4 floattime
INDIRF4
LEF4 $1010
line 2165
;2165:					bs->askteamleader_time = FloatTime() + 5 + random() * 10;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6792
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CNSTF4 1092616192
ADDRLP4 60
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 2166
;2166:				}
ADDRGP4 $1011
JUMPV
LABELV $1010
line 2167
;2167:				else {
line 2168
;2168:					bs->becometeamleader_time = FloatTime() + 5 + random() * 10;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6796
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CNSTF4 1092616192
ADDRLP4 60
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 2169
;2169:				}
LABELV $1011
line 2170
;2170:			}
LABELV $1008
line 2171
;2171:			if (bs->askteamleader_time && bs->askteamleader_time < FloatTime()) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 6792
ADDP4
INDIRF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 0
EQF4 $1012
ADDRLP4 60
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1012
line 2173
;2172:				// if asked for a team leader and no response
;2173:				BotAI_BotInitialChat(bs, "whoisteamleader", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1014
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2174
;2174:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
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
line 2175
;2175:				bs->askteamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6792
ADDP4
CNSTF4 0
ASGNF4
line 2176
;2176:				bs->becometeamleader_time = FloatTime() + 8 + random() * 10;
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6796
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
ADDF4
CNSTF4 1092616192
ADDRLP4 64
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 2177
;2177:			}
LABELV $1012
line 2178
;2178:			if (bs->becometeamleader_time && bs->becometeamleader_time < FloatTime()) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 6796
ADDP4
INDIRF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 0
EQF4 $998
ADDRLP4 64
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $998
line 2179
;2179:				BotAI_BotInitialChat(bs, "iamteamleader", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1017
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2180
;2180:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
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
line 2181
;2181:				BotSayVoiceTeamOrder(bs, -1, VOICECHAT_STARTLEADER);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $1018
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2182
;2182:				ClientName(bs->client, netname, sizeof(netname));
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
line 2183
;2183:				strncpy(bs->teamleader, netname, sizeof(bs->teamleader));
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
line 2184
;2184:				bs->teamleader[sizeof(bs->teamleader)-1] = '\0';
ADDRFP4 0
INDIRP4
CNSTI4 6756
CNSTU4 35
ADDI4
ADDP4
CNSTI1 0
ASGNI1
line 2185
;2185:				bs->becometeamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6796
ADDP4
CNSTF4 0
ASGNF4
line 2186
;2186:			}
line 2187
;2187:			return;
ADDRGP4 $998
JUMPV
LABELV $1006
line 2189
;2188:		}
;2189:	}
LABELV $1004
line 2190
;2190:	bs->askteamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6792
ADDP4
CNSTF4 0
ASGNF4
line 2191
;2191:	bs->becometeamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6796
ADDP4
CNSTF4 0
ASGNF4
line 2194
;2192:
;2193:	//return if this bot is NOT the team leader
;2194:	ClientName(bs->client, netname, sizeof(netname));
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
line 2195
;2195:	if ( !Q_strequal(netname, bs->teamleader) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $1019
line 2196
;2196:		return;
ADDRGP4 $998
JUMPV
LABELV $1019
line 2199
;2197:	}
;2198:	//
;2199:	numteammates = BotNumTeamMates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotNumTeamMates
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 52
INDIRI4
ASGNI4
line 2201
;2200:	//give orders
;2201:	switch(gametype) {
ADDRLP4 56
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 3
LTI4 $1021
ADDRLP4 56
INDIRI4
CNSTI4 11
GTI4 $1021
ADDRLP4 56
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1073-12
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1073
address $1023
address $1029
address $1050
address $1061
address $1067
address $1021
address $1029
address $1021
address $1043
code
LABELV $1023
line 2203
;2202:		case GT_TEAM:
;2203:		{
line 2204
;2204:			if (bs->numteammates != numteammates || bs->forceorders) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1026
ADDRLP4 60
INDIRP4
CNSTI4 6828
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1024
LABELV $1026
line 2205
;2205:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2206
;2206:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6808
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2207
;2207:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6828
ADDP4
CNSTI4 0
ASGNI4
line 2208
;2208:			}
LABELV $1024
line 2210
;2209:			//if it's time to give orders
;2210:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
INDIRF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 0
EQF4 $1022
ADDRLP4 64
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
GEF4 $1022
line 2211
;2211:				BotTeamOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamOrders
CALLV
pop
line 2213
;2212:				//give orders again after 120 seconds
;2213:				bs->teamgiveorders_time = FloatTime() + 120;
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 2214
;2214:			}
line 2215
;2215:			break;
ADDRGP4 $1022
JUMPV
LABELV $1029
line 2219
;2216:		}
;2217:		case GT_CTF:
;2218:		case GT_CTF_ELIMINATION:
;2219:		{
line 2222
;2220:			//if the number of team mates changed or the flag status changed
;2221:			//or someone wants to know what to do
;2222:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders || lastRoundNumber != level.roundNumber) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1035
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 6824
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $1035
ADDRLP4 60
INDIRP4
CNSTI4 6828
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $1035
ADDRGP4 lastRoundNumber
INDIRI4
ADDRGP4 level+9236
INDIRI4
EQI4 $1030
LABELV $1035
line 2223
;2223:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2224
;2224:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6808
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2225
;2225:				bs->flagstatuschanged = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 0
ASGNI4
line 2226
;2226:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6828
ADDP4
CNSTI4 0
ASGNI4
line 2227
;2227:				lastRoundNumber = level.roundNumber;
ADDRGP4 lastRoundNumber
ADDRGP4 level+9236
INDIRI4
ASGNI4
line 2228
;2228:			}
LABELV $1030
line 2230
;2229:			//if there were no flag captures the last 3 minutes
;2230:			if (bs->lastflagcapture_time < FloatTime() - 240) {
ADDRFP4 0
INDIRP4
CNSTI4 6804
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1131413504
SUBF4
GEF4 $1037
line 2231
;2231:				bs->lastflagcapture_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6804
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2233
;2232:				//randomly change the CTF strategy
;2233:				if (random() < 0.4) {
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1053609165
GEF4 $1039
line 2234
;2234:					bs->ctfstrategy ^= CTFS_AGRESSIVE;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 6836
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2235
;2235:					bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2236
;2236:				}
LABELV $1039
line 2237
;2237:			}
LABELV $1037
line 2239
;2238:			//if it's time to give orders
;2239:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 3) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
INDIRF4
ASGNF4
ADDRLP4 68
INDIRF4
CNSTF4 0
EQF4 $1022
ADDRLP4 68
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
GEF4 $1022
line 2240
;2240:				BotCTFOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders
CALLV
pop
line 2242
;2241:				//
;2242:				bs->teamgiveorders_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
CNSTF4 0
ASGNF4
line 2243
;2243:			}
line 2244
;2244:			break;
ADDRGP4 $1022
JUMPV
LABELV $1043
line 2247
;2245:		}
;2246:		case GT_DOUBLE_D:
;2247:		{
line 2250
;2248:			//if the number of team mates changed or the domination point status changed
;2249:			//or someone wants to know what to do
;2250:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1047
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 6824
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $1047
ADDRLP4 60
INDIRP4
CNSTI4 6828
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $1044
LABELV $1047
line 2251
;2251:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2252
;2252:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6808
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2253
;2253:				bs->flagstatuschanged = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 0
ASGNI4
line 2254
;2254:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6828
ADDP4
CNSTI4 0
ASGNI4
line 2255
;2255:			}
LABELV $1044
line 2257
;2256:			//if it's time to give orders
;2257:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 3) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
INDIRF4
ASGNF4
ADDRLP4 68
INDIRF4
CNSTF4 0
EQF4 $1022
ADDRLP4 68
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
GEF4 $1022
line 2258
;2258:				BotDDorders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDDorders
CALLV
pop
line 2260
;2259:				//
;2260:				bs->teamgiveorders_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
CNSTF4 0
ASGNF4
line 2261
;2261:			}
line 2262
;2262:			break;
ADDRGP4 $1022
JUMPV
LABELV $1050
line 2265
;2263:		}
;2264:		case GT_1FCTF:
;2265:		{
line 2266
;2266:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1054
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 6824
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $1054
ADDRLP4 60
INDIRP4
CNSTI4 6828
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $1051
LABELV $1054
line 2267
;2267:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2268
;2268:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6808
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2269
;2269:				bs->flagstatuschanged = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
CNSTI4 0
ASGNI4
line 2270
;2270:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6828
ADDP4
CNSTI4 0
ASGNI4
line 2271
;2271:			}
LABELV $1051
line 2273
;2272:			//if there were no flag captures the last 4 minutes
;2273:			if (bs->lastflagcapture_time < FloatTime() - 240) {
ADDRFP4 0
INDIRP4
CNSTI4 6804
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1131413504
SUBF4
GEF4 $1055
line 2274
;2274:				bs->lastflagcapture_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6804
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2276
;2275:				//randomly change the CTF strategy
;2276:				if (random() < 0.4) {
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1053609165
GEF4 $1057
line 2277
;2277:					bs->ctfstrategy ^= CTFS_AGRESSIVE;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 6836
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2278
;2278:					bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2279
;2279:				}
LABELV $1057
line 2280
;2280:			}
LABELV $1055
line 2282
;2281:			//if it's time to give orders
;2282:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 2) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
INDIRF4
ASGNF4
ADDRLP4 68
INDIRF4
CNSTF4 0
EQF4 $1022
ADDRLP4 68
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $1022
line 2283
;2283:				Bot1FCTFOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFOrders
CALLV
pop
line 2285
;2284:				//
;2285:				bs->teamgiveorders_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
CNSTF4 0
ASGNF4
line 2286
;2286:			}
line 2287
;2287:			break;
ADDRGP4 $1022
JUMPV
LABELV $1061
line 2290
;2288:		}
;2289:		case GT_OBELISK:
;2290:		{
line 2291
;2291:			if (bs->numteammates != numteammates || bs->forceorders) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1064
ADDRLP4 60
INDIRP4
CNSTI4 6828
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1062
LABELV $1064
line 2292
;2292:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2293
;2293:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6808
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2294
;2294:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6828
ADDP4
CNSTI4 0
ASGNI4
line 2295
;2295:			}
LABELV $1062
line 2297
;2296:			//if it's time to give orders
;2297:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
INDIRF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 0
EQF4 $1022
ADDRLP4 64
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
GEF4 $1022
line 2298
;2298:				BotObeliskOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotObeliskOrders
CALLV
pop
line 2300
;2299:				//give orders again after 30 seconds
;2300:				bs->teamgiveorders_time = FloatTime() + 30;
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 2301
;2301:			}
line 2302
;2302:			break;
ADDRGP4 $1022
JUMPV
LABELV $1067
line 2305
;2303:		}
;2304:		case GT_HARVESTER:
;2305:		{
line 2306
;2306:			if (bs->numteammates != numteammates || bs->forceorders) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1070
ADDRLP4 60
INDIRP4
CNSTI4 6828
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1068
LABELV $1070
line 2307
;2307:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2308
;2308:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6808
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2309
;2309:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6828
ADDP4
CNSTI4 0
ASGNI4
line 2310
;2310:			}
LABELV $1068
line 2312
;2311:			//if it's time to give orders
;2312:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
INDIRF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 0
EQF4 $1022
ADDRLP4 64
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
GEF4 $1022
line 2313
;2313:				BotHarvesterOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotHarvesterOrders
CALLV
pop
line 2315
;2314:				//give orders again after 30 seconds
;2315:				bs->teamgiveorders_time = FloatTime() + 30;
ADDRFP4 0
INDIRP4
CNSTI4 6800
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 2316
;2316:			}
line 2317
;2317:			break;
LABELV $1021
LABELV $1022
line 2320
;2318:		}
;2319:	}
;2320:}
LABELV $998
endproc BotTeamAI 76 12
bss
export lastRoundNumber
align 4
LABELV lastRoundNumber
skip 4
export ctftaskpreferences
align 4
LABELV ctftaskpreferences
skip 2560
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
LABELV $1018
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1017
byte 1 105
byte 1 97
byte 1 109
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1014
byte 1 119
byte 1 104
byte 1 111
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $923
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $743
byte 1 99
byte 1 109
byte 1 100
byte 1 95
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
LABELV $620
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $619
byte 1 99
byte 1 109
byte 1 100
byte 1 95
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
byte 1 0
align 1
LABELV $410
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 98
byte 1 0
align 1
LABELV $405
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $284
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $283
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $225
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
LABELV $210
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $209
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 0
align 1
LABELV $208
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
LABELV $207
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $195
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $194
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $177
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 25
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $82
byte 1 116
byte 1 0
align 1
LABELV $78
byte 1 110
byte 1 0
align 1
LABELV $70
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
