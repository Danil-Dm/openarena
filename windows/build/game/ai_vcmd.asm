export BotVoiceChat_GetFlag
code
proc BotVoiceChat_GetFlag 24 8
file "../../../code/game/ai_vcmd.c"
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
;25: * name:		ai_vcmd.c
;26: *
;27: * desc:		Quake3 bot AI
;28: *
;29: * $Archive: /MissionPack/code/game/ai_vcmd.c $
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
;51://
;52:#include "chars.h"				//characteristics
;53:#include "inv.h"				//indexes into the inventory
;54:#include "syn.h"				//synonyms
;55:#include "match.h"				//string matching types and vars
;56:
;57:// for the voice chats
;58:#include "../../ui/menudef.h"
;59:
;60:
;61:typedef struct voiceCommand_s
;62:{
;63:	char *cmd;
;64:	void (*func)(bot_state_t *bs, int client, int mode);
;65:} voiceCommand_t;
;66:
;67:/*
;68:==================
;69:BotVoiceChat_GetFlag
;70:==================
;71:*/
;72:void BotVoiceChat_GetFlag(bot_state_t *bs, int client, int mode) {
line 74
;73:	//
;74:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
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
EQI4 $62
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
NEI4 $62
line 75
;75:		if (!ctf_redflag.areanum || !ctf_blueflag.areanum)
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $68
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $63
LABELV $68
line 76
;76:			return;
ADDRGP4 $61
JUMPV
line 77
;77:	}
LABELV $62
line 78
;78:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $61
line 79
;79:		if (!ctf_neutralflag.areanum || !ctf_redflag.areanum || !ctf_blueflag.areanum)
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $77
ADDRGP4 ctf_redflag+12
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $77
ADDRGP4 ctf_blueflag+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $70
LABELV $77
line 80
;80:			return;
ADDRGP4 $61
JUMPV
line 81
;81:	}
line 82
;82:	else {
line 83
;83:		return;
LABELV $70
LABELV $63
line 86
;84:	}
;85:	//
;86:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 87
;87:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 88
;88:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 90
;89:	//set the time to send a message to the team mates
;90:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 8
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
ADDRLP4 8
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 92
;91:	//set the ltg type
;92:	bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 4
ASGNI4
line 94
;93:	//set the team goal time
;94:	bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 96
;95:	// get an alternate route in ctf
;96:	if (G_UsesTeamFlags(gametype) && !G_UsesTheWhiteFlag(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $78
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $78
line 98
;97:		//get an alternative route goal towards the enemy base
;98:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 99
;99:	}
LABELV $78
line 101
;100:	//
;101:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 103
;102:	// remember last ordered task
;103:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 107
;104:#ifdef DEBUG
;105:	BotPrintTeamGoal(bs);
;106:#endif //DEBUG
;107:}
LABELV $61
endproc BotVoiceChat_GetFlag 24 8
export BotVoiceChat_Offense
proc BotVoiceChat_Offense 8 12
line 114
;108:
;109:/*
;110:==================
;111:BotVoiceChat_Offense
;112:==================
;113:*/
;114:void BotVoiceChat_Offense(bot_state_t *bs, int client, int mode) {
line 115
;115:	if (G_UsesTeamFlags(gametype)) {
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
EQI4 $81
line 116
;116:		BotVoiceChat_GetFlag(bs, client, mode);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotVoiceChat_GetFlag
CALLV
pop
line 117
;117:		return;
ADDRGP4 $80
JUMPV
LABELV $81
line 119
;118:	}
;119:	if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $83
line 121
;120:		//
;121:		bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 122
;122:		bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 123
;123:		bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 125
;124:		//set the time to send a message to the team mates
;125:		bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 4
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
ADDRLP4 4
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 127
;126:		//set the ltg type
;127:		bs->ltgtype = LTG_HARVEST;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 12
ASGNI4
line 129
;128:		//set the team goal time
;129:		bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 130
;130:		bs->harvestaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTF4 0
ASGNF4
line 132
;131:		//
;132:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 134
;133:		// remember last ordered task
;134:		BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 135
;135:	}
ADDRGP4 $84
JUMPV
LABELV $83
line 137
;136:	else
;137:	{
line 139
;138:		//
;139:		bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 140
;140:		bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 141
;141:		bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 143
;142:		//set the time to send a message to the team mates
;143:		bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 4
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
ADDRLP4 4
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 145
;144:		//set the ltg type
;145:		bs->ltgtype = LTG_ATTACKENEMYBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 13
ASGNI4
line 147
;146:		//set the team goal time
;147:		bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 148
;148:		bs->attackaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTF4 0
ASGNF4
line 150
;149:		//
;150:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 152
;151:		// remember last ordered task
;152:		BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 153
;153:	}
LABELV $84
line 157
;154:#ifdef DEBUG
;155:	BotPrintTeamGoal(bs);
;156:#endif //DEBUG
;157:}
LABELV $80
endproc BotVoiceChat_Offense 8 12
export BotVoiceChat_Defend
proc BotVoiceChat_Defend 20 12
line 164
;158:
;159:/*
;160:==================
;161:BotVoiceChat_Defend
;162:==================
;163:*/
;164:void BotVoiceChat_Defend(bot_state_t *bs, int client, int mode) {
line 165
;165:	if (gametype == GT_HARVESTER || gametype == GT_OBELISK) {
ADDRLP4 0
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 7
EQI4 $88
ADDRLP4 0
INDIRI4
CNSTI4 6
NEI4 $86
LABELV $88
line 167
;166:		//
;167:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $92
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $93
ADDRGP4 $85
JUMPV
LABELV $92
line 168
;168:			case TEAM_RED: memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t)); break;
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
ADDRGP4 $87
JUMPV
LABELV $93
line 169
;169:			case TEAM_BLUE: memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t)); break;
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
line 170
;170:			default: return;
line 172
;171:		}
;172:	}
ADDRGP4 $87
JUMPV
LABELV $86
line 174
;173:	else
;174:		if (G_UsesTeamFlags(gametype)) {
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
EQI4 $85
line 176
;175:                    //
;176:                    switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $99
ADDRLP4 8
INDIRI4
CNSTI4 2
EQI4 $100
ADDRGP4 $85
JUMPV
LABELV $99
line 177
;177:			case TEAM_RED: memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t)); break;
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
ADDRGP4 $95
JUMPV
LABELV $100
line 178
;178:			case TEAM_BLUE: memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t)); break;
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
line 179
;179:			default: return;
line 181
;180:		}
;181:	}
line 182
;182:	else {
line 183
;183:		return;
LABELV $95
LABELV $87
line 186
;184:	}
;185:	//
;186:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 187
;187:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 188
;188:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 190
;189:	//set the time to send a message to the team mates
;190:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 8
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
ADDRLP4 8
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 192
;191:	//set the ltg type
;192:	bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 3
ASGNI4
line 194
;193:	//get the team goal time
;194:	bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 196
;195:	//away from defending
;196:	bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
CNSTF4 0
ASGNF4
line 198
;197:	//
;198:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 200
;199:	// remember last ordered task
;200:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 204
;201:#ifdef DEBUG
;202:	BotPrintTeamGoal(bs);
;203:#endif //DEBUG
;204:}
LABELV $85
endproc BotVoiceChat_Defend 20 12
export BotVoiceChat_DefendFlag
proc BotVoiceChat_DefendFlag 0 12
line 211
;205:
;206:/*
;207:==================
;208:BotVoiceChat_DefendFlag
;209:==================
;210:*/
;211:void BotVoiceChat_DefendFlag(bot_state_t *bs, int client, int mode) {
line 212
;212:	BotVoiceChat_Defend(bs, client, mode);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotVoiceChat_Defend
CALLV
pop
line 213
;213:}
LABELV $101
endproc BotVoiceChat_DefendFlag 0 12
export BotVoiceChat_Patrol
proc BotVoiceChat_Patrol 0 12
line 220
;214:
;215:/*
;216:==================
;217:BotVoiceChat_Patrol
;218:==================
;219:*/
;220:void BotVoiceChat_Patrol(bot_state_t *bs, int client, int mode) {
line 222
;221:	//
;222:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 224
;223:	//
;224:	bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 0
ASGNI4
line 225
;225:	bs->lead_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 226
;226:	bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTI4 0
ASGNI4
line 228
;227:	//
;228:	BotAI_BotInitialChat(bs, "dismissed", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $103
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 229
;229:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
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
line 230
;230:	BotVoiceChatOnly(bs, -1, VOICECHAT_ONPATROL);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $104
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 232
;231:	//
;232:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 236
;233:#ifdef DEBUG
;234:	BotPrintTeamGoal(bs);
;235:#endif //DEBUG
;236:}
LABELV $102
endproc BotVoiceChat_Patrol 0 12
export BotVoiceChat_Camp
proc BotVoiceChat_Camp 184 16
line 243
;237:
;238:/*
;239:==================
;240:BotVoiceChat_Camp
;241:==================
;242:*/
;243:void BotVoiceChat_Camp(bot_state_t *bs, int client, int mode) {
line 249
;244:	int areanum;
;245:	aas_entityinfo_t entinfo;
;246:	char netname[MAX_NETNAME];
;247:
;248:	//
;249:	bs->teamgoal.entitynum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
CNSTI4 -1
ASGNI4
line 250
;250:	BotEntityInfo(client, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 252
;251:	//if info is valid (in PVS)
;252:	if (entinfo.valid) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $106
line 253
;253:		areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 0+24
ARGP4
ADDRLP4 180
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 180
INDIRI4
ASGNI4
line 254
;254:		if (areanum) { // && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $109
line 257
;255:			//NOTE: just assume the bot knows where the person is
;256:			//if (BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, client)) {
;257:				bs->teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 258
;258:				bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6492
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 259
;259:				VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 260
;260:				VectorSet(bs->teamgoal.mins, -8, -8, -8);
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
line 261
;261:				VectorSet(bs->teamgoal.maxs, 8, 8, 8);
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
line 263
;262:			//}
;263:		}
LABELV $109
line 264
;264:	}
LABELV $106
line 266
;265:	//if the other is not visible
;266:	if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
CNSTI4 0
GEI4 $112
line 267
;267:		BotAI_BotInitialChat(bs, "whereareyou", EasyClientName(client, netname, sizeof(netname)), NULL);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 144
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 180
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $114
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 268
;268:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
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
line 269
;269:		return;
ADDRGP4 $105
JUMPV
LABELV $112
line 272
;270:	}
;271:	//
;272:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 273
;273:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 274
;274:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 276
;275:	//set the time to send a message to the team mates
;276:	bs->teammessage_time = FloatTime() + 2 * random();
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
line 278
;277:	//set the ltg type
;278:	bs->ltgtype = LTG_CAMPORDER;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 8
ASGNI4
line 280
;279:	//get the team goal time
;280:	bs->teamgoal_time = FloatTime() + TEAM_CAMP_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 282
;281:	//the teammate that requested the camping
;282:	bs->teammate = client;
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 284
;283:	//not arrived yet
;284:	bs->arrive_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTF4 0
ASGNF4
line 286
;285:	//
;286:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 288
;287:	// remember last ordered task
;288:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 292
;289:#ifdef DEBUG
;290:	BotPrintTeamGoal(bs);
;291:#endif //DEBUG
;292:}
LABELV $105
endproc BotVoiceChat_Camp 184 16
export BotVoiceChat_FollowMe
proc BotVoiceChat_FollowMe 184 16
line 299
;293:
;294:/*
;295:==================
;296:BotVoiceChat_FollowMe
;297:==================
;298:*/
;299:void BotVoiceChat_FollowMe(bot_state_t *bs, int client, int mode) {
line 304
;300:	int areanum;
;301:	aas_entityinfo_t entinfo;
;302:	char netname[MAX_NETNAME];
;303:
;304:	bs->teamgoal.entitynum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
CNSTI4 -1
ASGNI4
line 305
;305:	BotEntityInfo(client, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 307
;306:	//if info is valid (in PVS)
;307:	if (entinfo.valid) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $116
line 308
;308:		areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 0+24
ARGP4
ADDRLP4 180
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 180
INDIRI4
ASGNI4
line 309
;309:		if (areanum) { // && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $119
line 310
;310:			bs->teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 311
;311:			bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6492
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 312
;312:			VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6480
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 313
;313:			VectorSet(bs->teamgoal.mins, -8, -8, -8);
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
line 314
;314:			VectorSet(bs->teamgoal.maxs, 8, 8, 8);
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
line 315
;315:		}
LABELV $119
line 316
;316:	}
LABELV $116
line 318
;317:	//if the other is not visible
;318:	if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
CNSTI4 0
GEI4 $122
line 319
;319:		BotAI_BotInitialChat(bs, "whereareyou", EasyClientName(client, netname, sizeof(netname)), NULL);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 144
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 180
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $114
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 320
;320:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
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
;321:		return;
ADDRGP4 $115
JUMPV
LABELV $122
line 324
;322:	}
;323:	//
;324:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 325
;325:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 326
;326:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 328
;327:	//the team mate
;328:	bs->teammate = client;
ADDRFP4 0
INDIRP4
CNSTI4 6460
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 330
;329:	//last time the team mate was assumed visible
;330:	bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 332
;331:	//set the time to send a message to the team mates
;332:	bs->teammessage_time = FloatTime() + 2 * random();
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
line 334
;333:	//get the team goal time
;334:	bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 336
;335:	//set the ltg type
;336:	bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 2
ASGNI4
line 337
;337:	bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 6872
ADDP4
CNSTF4 1121976320
ASGNF4
line 338
;338:	bs->arrive_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
CNSTF4 0
ASGNF4
line 340
;339:	//
;340:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 342
;341:	// remember last ordered task
;342:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 346
;343:#ifdef DEBUG
;344:	BotPrintTeamGoal(bs);
;345:#endif //DEBUG
;346:}
LABELV $115
endproc BotVoiceChat_FollowMe 184 16
export BotVoiceChat_FollowFlagCarrier
proc BotVoiceChat_FollowFlagCarrier 8 12
line 353
;347:
;348:/*
;349:==================
;350:BotVoiceChat_FollowFlagCarrier
;351:==================
;352:*/
;353:void BotVoiceChat_FollowFlagCarrier(bot_state_t *bs, int client, int mode) {
line 356
;354:	int carrier;
;355:
;356:	carrier = BotTeamFlagCarrier(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeamFlagCarrier
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 357
;357:	if (carrier >= 0)
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $125
line 358
;358:		BotVoiceChat_FollowMe(bs, carrier, mode);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotVoiceChat_FollowMe
CALLV
pop
LABELV $125
line 362
;359:#ifdef DEBUG
;360:	BotPrintTeamGoal(bs);
;361:#endif //DEBUG
;362:}
LABELV $124
endproc BotVoiceChat_FollowFlagCarrier 8 12
export BotVoiceChat_ReturnFlag
proc BotVoiceChat_ReturnFlag 8 4
line 369
;363:
;364:/*
;365:==================
;366:BotVoiceChat_ReturnFlag
;367:==================
;368:*/
;369:void BotVoiceChat_ReturnFlag(bot_state_t *bs, int client, int mode) {
line 371
;370:	//if not in CTF mode
;371:	if (!G_UsesTeamFlags(gametype)) {
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
NEI4 $128
line 372
;372:		return;
ADDRGP4 $127
JUMPV
LABELV $128
line 375
;373:	}
;374:	//
;375:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6464
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 376
;376:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6468
ADDP4
CNSTI4 1
ASGNI4
line 377
;377:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6472
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 379
;378:	//set the time to send a message to the team mates
;379:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 4
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
ADDRLP4 4
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 381
;380:	//set the ltg type
;381:	bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6456
ADDP4
CNSTI4 6
ASGNI4
line 383
;382:	//set the team goal time
;383:	bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 384
;384:	bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTF4 0
ASGNF4
line 385
;385:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 389
;386:#ifdef DEBUG
;387:	BotPrintTeamGoal(bs);
;388:#endif //DEBUG
;389:}
LABELV $127
endproc BotVoiceChat_ReturnFlag 8 4
export BotVoiceChat_StartLeader
proc BotVoiceChat_StartLeader 0 12
line 396
;390:
;391:/*
;392:==================
;393:BotVoiceChat_StartLeader
;394:==================
;395:*/
;396:void BotVoiceChat_StartLeader(bot_state_t *bs, int client, int mode) {
line 397
;397:	ClientName(client, bs->teamleader, sizeof(bs->teamleader));
ADDRFP4 4
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
line 398
;398:}
LABELV $130
endproc BotVoiceChat_StartLeader 0 12
export BotVoiceChat_StopLeader
proc BotVoiceChat_StopLeader 264 12
line 405
;399:
;400:/*
;401:==================
;402:BotVoiceChat_StopLeader
;403:==================
;404:*/
;405:void BotVoiceChat_StopLeader(bot_state_t *bs, int client, int mode) {
line 408
;406:	char netname[MAX_MESSAGE_SIZE];
;407:
;408:	if (Q_strequal(bs->teamleader, ClientName(client, netname, sizeof(netname)))) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 256
ADDRGP4 ClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $132
line 409
;409:		bs->teamleader[0] = '\0';
ADDRFP4 0
INDIRP4
CNSTI4 6756
ADDP4
CNSTI1 0
ASGNI1
line 410
;410:		notleader[client] = qtrue;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 notleader
ADDP4
CNSTI4 1
ASGNI4
line 411
;411:	}
LABELV $132
line 412
;412:}
LABELV $131
endproc BotVoiceChat_StopLeader 264 12
export BotVoiceChat_WhoIsLeader
proc BotVoiceChat_WhoIsLeader 264 12
line 419
;413:
;414:/*
;415:==================
;416:BotVoiceChat_WhoIsLeader
;417:==================
;418:*/
;419:void BotVoiceChat_WhoIsLeader(bot_state_t *bs, int client, int mode) {
line 422
;420:	char netname[MAX_MESSAGE_SIZE];
;421:
;422:	if (!G_IsATeamGametype(gametype)) return;
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
NEI4 $135
ADDRGP4 $134
JUMPV
LABELV $135
line 424
;423:
;424:	ClientName(bs->client, netname, sizeof(netname));
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
line 426
;425:	//if this bot IS the team leader
;426:	if (Q_strequal(netname, bs->teamleader)) {
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
NEI4 $137
line 427
;427:		BotAI_BotInitialChat(bs, "iamteamleader", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $139
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 428
;428:		trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
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
line 429
;429:		BotVoiceChatOnly(bs, -1, VOICECHAT_STARTLEADER);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $140
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 430
;430:	}
LABELV $137
line 431
;431:}
LABELV $134
endproc BotVoiceChat_WhoIsLeader 264 12
export BotVoiceChat_WantOnDefense
proc BotVoiceChat_WantOnDefense 44 16
line 438
;432:
;433:/*
;434:==================
;435:BotVoiceChat_WantOnDefense
;436:==================
;437:*/
;438:void BotVoiceChat_WantOnDefense(bot_state_t *bs, int client, int mode) {
line 442
;439:	char netname[MAX_NETNAME];
;440:	int preference;
;441:
;442:	preference = BotGetTeamMateTaskPreference(bs, client);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 BotGetTeamMateTaskPreference
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 40
INDIRI4
ASGNI4
line 443
;443:	preference &= ~TEAMTP_ATTACKER;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 444
;444:	preference |= TEAMTP_DEFENDER;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 445
;445:	BotSetTeamMateTaskPreference(bs, client, preference);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSetTeamMateTaskPreference
CALLV
pop
line 447
;446:	//
;447:	EasyClientName(client, netname, sizeof(netname));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 448
;448:	BotAI_BotInitialChat(bs, "keepinmind", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 449
;449:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
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
line 450
;450:	BotVoiceChatOnly(bs, client, VOICECHAT_YES);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $143
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 451
;451:	trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
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
line 452
;452:}
LABELV $141
endproc BotVoiceChat_WantOnDefense 44 16
export BotVoiceChat_WantOnOffense
proc BotVoiceChat_WantOnOffense 44 16
line 459
;453:
;454:/*
;455:==================
;456:BotVoiceChat_WantOnOffense
;457:==================
;458:*/
;459:void BotVoiceChat_WantOnOffense(bot_state_t *bs, int client, int mode) {
line 463
;460:	char netname[MAX_NETNAME];
;461:	int preference;
;462:
;463:	preference = BotGetTeamMateTaskPreference(bs, client);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 BotGetTeamMateTaskPreference
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 40
INDIRI4
ASGNI4
line 464
;464:	preference &= ~TEAMTP_DEFENDER;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 465
;465:	preference |= TEAMTP_ATTACKER;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 466
;466:	BotSetTeamMateTaskPreference(bs, client, preference);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSetTeamMateTaskPreference
CALLV
pop
line 468
;467:	//
;468:	EasyClientName(client, netname, sizeof(netname));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 469
;469:	BotAI_BotInitialChat(bs, "keepinmind", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 470
;470:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
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
line 471
;471:	BotVoiceChatOnly(bs, client, VOICECHAT_YES);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $143
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 472
;472:	trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
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
line 473
;473:}
LABELV $144
endproc BotVoiceChat_WantOnOffense 44 16
export BotVoiceChat_Dummy
proc BotVoiceChat_Dummy 0 0
line 475
;474:
;475:void BotVoiceChat_Dummy(bot_state_t *bs, int client, int mode) {
line 476
;476:}
LABELV $145
endproc BotVoiceChat_Dummy 0 0
data
export voiceCommands
align 4
LABELV voiceCommands
address $146
address BotVoiceChat_GetFlag
address $147
address BotVoiceChat_Offense
address $148
address BotVoiceChat_Defend
address $149
address BotVoiceChat_DefendFlag
address $150
address BotVoiceChat_Patrol
address $151
address BotVoiceChat_Camp
address $152
address BotVoiceChat_FollowMe
address $153
address BotVoiceChat_FollowFlagCarrier
address $154
address BotVoiceChat_ReturnFlag
address $140
address BotVoiceChat_StartLeader
address $155
address BotVoiceChat_StopLeader
address $156
address BotVoiceChat_WhoIsLeader
address $157
address BotVoiceChat_WantOnDefense
address $158
address BotVoiceChat_WantOnOffense
byte 4 0
address BotVoiceChat_Dummy
export BotVoiceChatCommand
code
proc BotVoiceChatCommand 324 12
line 496
;477:
;478:voiceCommand_t voiceCommands[] = {
;479:	{VOICECHAT_GETFLAG, BotVoiceChat_GetFlag},
;480:	{VOICECHAT_OFFENSE, BotVoiceChat_Offense },
;481:	{VOICECHAT_DEFEND, BotVoiceChat_Defend },
;482:	{VOICECHAT_DEFENDFLAG, BotVoiceChat_DefendFlag },
;483:	{VOICECHAT_PATROL, BotVoiceChat_Patrol },
;484:	{VOICECHAT_CAMP, BotVoiceChat_Camp },
;485:	{VOICECHAT_FOLLOWME, BotVoiceChat_FollowMe },
;486:	{VOICECHAT_FOLLOWFLAGCARRIER, BotVoiceChat_FollowFlagCarrier },
;487:	{VOICECHAT_RETURNFLAG, BotVoiceChat_ReturnFlag },
;488:	{VOICECHAT_STARTLEADER, BotVoiceChat_StartLeader },
;489:	{VOICECHAT_STOPLEADER, BotVoiceChat_StopLeader },
;490:	{VOICECHAT_WHOISLEADER, BotVoiceChat_WhoIsLeader },
;491:	{VOICECHAT_WANTONDEFENSE, BotVoiceChat_WantOnDefense },
;492:	{VOICECHAT_WANTONOFFENSE, BotVoiceChat_WantOnOffense },
;493:	{NULL, BotVoiceChat_Dummy}
;494:};
;495:
;496:int BotVoiceChatCommand(bot_state_t *bs, int mode, char *voiceChat) {
line 500
;497:	int i, clientNum;
;498:	char *ptr, buf[MAX_MESSAGE_SIZE], *cmd;
;499:
;500:	if (!G_IsATeamGametype(gametype)) {
ADDRGP4 gametype
INDIRI4
ARGI4
ADDRLP4 272
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $160
line 501
;501:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $159
JUMPV
LABELV $160
line 504
;502:	}
;503:
;504:	if ( mode == SAY_ALL ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $162
line 505
;505:		return qfalse;	// don't do anything with voice chats to everyone
CNSTI4 0
RETI4
ADDRGP4 $159
JUMPV
LABELV $162
line 508
;506:	}
;507:
;508:	Q_strncpyz(buf, voiceChat, sizeof(buf));
ADDRLP4 16
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 509
;509:	cmd = buf;
ADDRLP4 0
ADDRLP4 16
ASGNP4
line 510
;510:	for (ptr = cmd; *cmd && *cmd > ' '; cmd++);
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $167
JUMPV
LABELV $164
LABELV $165
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $167
ADDRLP4 276
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
EQI4 $168
ADDRLP4 276
INDIRI4
CNSTI4 32
GTI4 $164
LABELV $168
ADDRGP4 $170
JUMPV
LABELV $169
line 511
;511:	while (*cmd && *cmd <= ' ') *cmd++ = '\0';
ADDRLP4 280
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 280
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
CNSTI1 0
ASGNI1
LABELV $170
ADDRLP4 284
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
EQI4 $172
ADDRLP4 284
INDIRI4
CNSTI4 32
LEI4 $169
LABELV $172
line 512
;512:	for (ptr = cmd; *cmd && *cmd > ' '; cmd++);
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $176
JUMPV
LABELV $173
LABELV $174
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $176
ADDRLP4 288
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $177
ADDRLP4 288
INDIRI4
CNSTI4 32
GTI4 $173
LABELV $177
ADDRGP4 $179
JUMPV
LABELV $178
line 513
;513:	while (*cmd && *cmd <= ' ') *cmd++ = '\0';
ADDRLP4 292
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 292
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI1 0
ASGNI1
LABELV $179
ADDRLP4 296
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
EQI4 $181
ADDRLP4 296
INDIRI4
CNSTI4 32
LEI4 $178
LABELV $181
line 514
;514:	clientNum = atoi(ptr);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 300
INDIRI4
ASGNI4
line 515
;515:	for (ptr = cmd; *cmd && *cmd > ' '; cmd++);
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $185
JUMPV
LABELV $182
LABELV $183
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $185
ADDRLP4 304
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $186
ADDRLP4 304
INDIRI4
CNSTI4 32
GTI4 $182
LABELV $186
ADDRGP4 $188
JUMPV
LABELV $187
line 516
;516:	while (*cmd && *cmd <= ' ') *cmd++ = '\0';
ADDRLP4 308
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 308
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 308
INDIRP4
CNSTI1 0
ASGNI1
LABELV $188
ADDRLP4 312
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $190
ADDRLP4 312
INDIRI4
CNSTI4 32
LEI4 $187
LABELV $190
line 518
;517:
;518:	if (!BotSameTeam(bs, clientNum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 316
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 0
NEI4 $191
line 519
;519:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $159
JUMPV
LABELV $191
line 522
;520:	}
;521:
;522:	for (i = 0; voiceCommands[i].cmd; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $196
JUMPV
LABELV $193
line 523
;523:		if (Q_strequal(cmd, voiceCommands[i].cmd)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 voiceCommands
ADDP4
INDIRP4
ARGP4
ADDRLP4 320
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 0
NEI4 $197
line 524
;524:			voiceCommands[i].func(bs, clientNum, mode);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 voiceCommands+4
ADDP4
INDIRP4
CALLV
pop
line 525
;525:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $159
JUMPV
LABELV $197
line 527
;526:		}
;527:	}
LABELV $194
line 522
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $196
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 voiceCommands
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $193
line 528
;528:	return qfalse;
CNSTI4 0
RETI4
LABELV $159
endproc BotVoiceChatCommand 324 12
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
LABELV $158
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
LABELV $157
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
LABELV $156
byte 1 119
byte 1 104
byte 1 111
byte 1 105
byte 1 115
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $155
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $154
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
LABELV $153
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
LABELV $152
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
LABELV $151
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $150
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $149
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $148
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $147
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $146
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $143
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $142
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
LABELV $140
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
LABELV $139
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
LABELV $114
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
LABELV $104
byte 1 111
byte 1 110
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $103
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
