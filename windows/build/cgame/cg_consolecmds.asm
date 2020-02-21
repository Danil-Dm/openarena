export CG_PrintClientNumbers
code
proc CG_PrintClientNumbers 4 8
file "../../../code/cgame/cg_consolecmds.c"
line 32
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
;23:// cg_consolecmds.c -- text commands typed in at the local console, or
;24:// executed by a key binding
;25:
;26:#include "cg_local.h"
;27:#include "../ui/ui_shared.h"
;28:#ifdef MISSIONPACK
;29:extern menuDef_t *menuScoreboard;
;30:#endif
;31:
;32:void CG_PrintClientNumbers(void) {
line 35
;33:	int i;
;34:
;35:	CG_Printf("slot score ping name\n");
ADDRGP4 $84
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 36
;36:	CG_Printf("---- ----- ---- ----\n");
ADDRGP4 $85
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 38
;37:
;38:	for (i = 0; i < cg.numScores; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $89
JUMPV
LABELV $86
line 39
;39:		CG_Printf("%-4d", cg.scores[i].client);
ADDRGP4 $91
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 41
;40:
;41:		CG_Printf(" %-5d", cg.scores[i].score);
ADDRGP4 $93
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 43
;42:
;43:		CG_Printf(" %-4d", cg.scores[i].ping);
ADDRGP4 $96
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+8
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 45
;44:
;45:		CG_Printf(" %s\n", cgs.clientinfo[cg.scores[i].client].name);
ADDRGP4 $99
ARGP4
CNSTI4 2120
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152+4
ADDP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 46
;46:	}
LABELV $87
line 38
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $89
ADDRLP4 0
INDIRI4
ADDRGP4 cg+110672
INDIRI4
LTI4 $86
line 47
;47:}
LABELV $83
endproc CG_PrintClientNumbers 4 8
export CG_TargetCommand_f
proc CG_TargetCommand_f 20 12
line 49
;48:
;49:void CG_TargetCommand_f(void) {
line 53
;50:	int targetNum;
;51:	char test[4];
;52:
;53:	targetNum = CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 54
;54:	if (targetNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $104
line 55
;55:		return;
ADDRGP4 $103
JUMPV
LABELV $104
line 58
;56:	}
;57:
;58:	trap_Argv(1, test, 4);
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 59
;59:	trap_SendClientCommand(va("gc %i %i", targetNum, atoi(test)));
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $106
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 60
;60:}
LABELV $103
endproc CG_TargetCommand_f 20 12
proc CG_SizeUp_f 4 8
line 69
;61:
;62:/*
;63:=================
;64:CG_SizeUp_f
;65:
;66:Keybinding command
;67:=================
;68: */
;69:static void CG_SizeUp_f(void) {
line 70
;70:	trap_Cvar_Set("cg_viewsize", va("%i", (int) (cg_viewsize.integer + 10)));
ADDRGP4 $109
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
ADDI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $108
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 71
;71:}
LABELV $107
endproc CG_SizeUp_f 4 8
proc CG_SizeDown_f 4 8
line 80
;72:
;73:/*
;74:=================
;75:CG_SizeDown_f
;76:
;77:Keybinding command
;78:=================
;79: */
;80:static void CG_SizeDown_f(void) {
line 81
;81:	trap_Cvar_Set("cg_viewsize", va("%i", (int) (cg_viewsize.integer - 10)));
ADDRGP4 $109
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
SUBI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $108
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 82
;82:}
LABELV $111
endproc CG_SizeDown_f 4 8
proc CG_Viewpos_f 0 20
line 91
;83:
;84:/*
;85:=============
;86:CG_Viewpos_f
;87:
;88:Debugging command to print the current position
;89:=============
;90: */
;91:static void CG_Viewpos_f(void) {
line 92
;92:	CG_Printf("(%i %i %i) : %i\n", (int) cg.refdef.vieworg[0],
ADDRGP4 $114
ARGP4
ADDRGP4 cg+109252+24
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109252+24+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109252+24+8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109620+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 95
;93:			(int) cg.refdef.vieworg[1], (int) cg.refdef.vieworg[2],
;94:			(int) cg.refdefViewAngles[YAW]);
;95:}
LABELV $113
endproc CG_Viewpos_f 0 20
proc CG_ScoresDown_f 0 4
line 97
;96:
;97:static void CG_ScoresDown_f(void) {
line 102
;98:
;99:#ifdef MISSIONPACK
;100:	CG_BuildSpectatorString();
;101:#endif
;102:	if (cg.scoresRequestTime + 2000 < cg.time) {
ADDRGP4 cg+110668
INDIRI4
CNSTI4 2000
ADDI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $126
line 105
;103:		// the scores are more than two seconds out of data,
;104:		// so request new ones
;105:		cg.scoresRequestTime = cg.time;
ADDRGP4 cg+110668
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 106
;106:		trap_SendClientCommand("score");
ADDRGP4 $132
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 110
;107:
;108:		// leave the current scores up if they were already
;109:		// displayed, but if this is the first hit, clear them out
;110:		if (!cg.showScores) {
ADDRGP4 cg+114784
INDIRI4
CNSTI4 0
NEI4 $127
line 111
;111:			cg.showScores = qtrue;
ADDRGP4 cg+114784
CNSTI4 1
ASGNI4
line 112
;112:			cg.numScores = 0;
ADDRGP4 cg+110672
CNSTI4 0
ASGNI4
line 113
;113:		}
line 114
;114:	} else {
ADDRGP4 $127
JUMPV
LABELV $126
line 117
;115:		// show the cached contents even if they just pressed if it
;116:		// is within two seconds
;117:		cg.showScores = qtrue;
ADDRGP4 cg+114784
CNSTI4 1
ASGNI4
line 118
;118:	}
LABELV $127
line 119
;119:}
LABELV $125
endproc CG_ScoresDown_f 0 4
proc CG_ScoresUp_f 0 0
line 121
;120:
;121:static void CG_ScoresUp_f(void) {
line 122
;122:	if (cg.showScores) {
ADDRGP4 cg+114784
INDIRI4
CNSTI4 0
EQI4 $140
line 123
;123:		cg.showScores = qfalse;
ADDRGP4 cg+114784
CNSTI4 0
ASGNI4
line 124
;124:		cg.scoreFadeTime = cg.time;
ADDRGP4 cg+114792
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 125
;125:	}
LABELV $140
line 126
;126:}
LABELV $139
endproc CG_ScoresUp_f 0 0
proc CG_AccDown_f 0 4
line 128
;127:
;128:static void CG_AccDown_f(void) {
line 130
;129:
;130:	if (cg.accRequestTime + 2000 < cg.time) {
ADDRGP4 cg+114908
INDIRI4
CNSTI4 2000
ADDI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $147
line 132
;131:
;132:		cg.accRequestTime = cg.time;
ADDRGP4 cg+114908
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 133
;133:		trap_SendClientCommand("acc");
ADDRGP4 $153
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 135
;134:
;135:		if (!cg.showAcc) {
ADDRGP4 cg+114912
INDIRI4
CNSTI4 0
NEI4 $148
line 136
;136:			cg.showAcc = qtrue;
ADDRGP4 cg+114912
CNSTI4 1
ASGNI4
line 137
;137:		}
line 139
;138:
;139:	} else {
ADDRGP4 $148
JUMPV
LABELV $147
line 140
;140:		cg.showAcc = qtrue;
ADDRGP4 cg+114912
CNSTI4 1
ASGNI4
line 141
;141:	}
LABELV $148
line 142
;142:}
LABELV $146
endproc CG_AccDown_f 0 4
proc CG_AccUp_f 0 0
line 144
;143:
;144:static void CG_AccUp_f(void) {
line 145
;145:	if (cg.showAcc) {
ADDRGP4 cg+114912
INDIRI4
CNSTI4 0
EQI4 $160
line 146
;146:		cg.showAcc = qfalse;
ADDRGP4 cg+114912
CNSTI4 0
ASGNI4
line 147
;147:		cg.accFadeTime = cg.time;
ADDRGP4 cg+114920
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 148
;148:	}
LABELV $160
line 149
;149:}
LABELV $159
endproc CG_AccUp_f 0 0
proc CG_TellTarget_f 264 20
line 276
;150:
;151:
;152:#ifdef MISSIONPACK
;153:extern menuDef_t *menuScoreboard;
;154:void Menu_Reset(void); // FIXME: add to right include file
;155:
;156:static void CG_LoadHud_f(void) {
;157:	char buff[1024];
;158:	const char *hudSet;
;159:	memset(buff, 0, sizeof (buff));
;160:
;161:	String_Init();
;162:	Menu_Reset();
;163:
;164:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof (buff));
;165:	hudSet = buff;
;166:	if (hudSet[0] == '\0') {
;167:		hudSet = "ui/hud.txt";
;168:	}
;169:
;170:	CG_LoadMenus(hudSet);
;171:	menuScoreboard = NULL;
;172:}
;173:
;174:static void CG_scrollScoresDown_f(void) {
;175:	if (menuScoreboard && cg.scoreBoardShowing) {
;176:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qtrue);
;177:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qtrue);
;178:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qtrue);
;179:	}
;180:}
;181:
;182:static void CG_scrollScoresUp_f(void) {
;183:	if (menuScoreboard && cg.scoreBoardShowing) {
;184:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qfalse);
;185:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qfalse);
;186:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qfalse);
;187:	}
;188:}
;189:
;190:static void CG_spWin_f(void) {
;191:	trap_Cvar_Set("cg_cameraOrbit", "2");
;192:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
;193:	trap_Cvar_Set("cg_thirdPerson", "1");
;194:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
;195:	trap_Cvar_Set("cg_thirdPersonRange", "100");
;196:	CG_AddBufferedSound(cgs.media.winnerSound);
;197:	//trap_S_StartLocalSound(cgs.media.winnerSound, CHAN_ANNOUNCER);
;198:	CG_CenterPrint("YOU WIN!", SCREEN_HEIGHT * .30, 0);
;199:
;200:	// leilei - Unlock stuff!!! Trophies crap.
;201:	{
;202:		char berf[4];
;203:		//const char	*info;
;204:		int trophyearn;
;205:		int trophyhad;
;206:
;207:		// trophyearn = 1 = GOLD!!!
;208:		// trophyearn = 2 = silver!!
;209:		// trophyearn = 3 = bronze...
;210:		// trophyearn = 5 = PLATINUM!!!!!!!!!!!!!!!!!!!!
;211:
;212:
;213:		trophyearn = 1; // gold... if we're good
;214:
;215:
;216:		//info = CG_ConfigString( CS_SERVERINFO );
;217:		//s = Info_ValueForKey( info, "mapname" );
;218:		trap_Cvar_VariableStringBuffer("ui_currentMap", berf, sizeof (berf)); // get map number instead for list consistency
;219:
;220:		trophyhad = CG_GetCVar(va("ui_sp_unlock_%s", berf));
;221:
;222:		if (trophyhad > trophyearn) {
;223:			trophyearn = 0;
;224:		}
;225:
;226:		// leilei - unlocking maps (for the SP UI) by setting a cvar
;227:		if (trophyearn) {
;228:			if (trophyearn == 1) {
;229:				CG_CenterPrint("Here the player\nhave a gold trophy!", SCREEN_HEIGHT * .40, 0);
;230:			} else if (trophyearn == 2) {
;231:				CG_CenterPrint("Here the player\nhave a silver trophy", SCREEN_HEIGHT * .40, 0);
;232:			} else if (trophyearn == 3) {
;233:				CG_CenterPrint("You earned bronze.\nNOT GOOD ENOUGH DAMMIT\nNOT GOOD ENOUGH", SCREEN_HEIGHT * .40, 0);
;234:			}
;235:			trap_Cvar_Set(va("ui_sp_unlock_%s", berf), va("%i", trophyearn)); // YA YUO DID IT!!!1
;236:		}
;237:
;238:		// leilei - get all the total trophies. Should really be done in the single player ui scripts, but
;239:		// 		doing it here could make a nice verifier for legitimacy :)
;240:		{
;241:			int tropees = 0;
;242:			int tropgold = 0;
;243:			int tropsilv = 0;
;244:			int tropbrnz = 0;
;245:
;246:			for (tropees = 0; tropees < 42; tropees++) {
;247:				int yeah;
;248:				yeah = CG_GetCVar(va("ui_sp_unlock_%i", tropees));
;249:				if (yeah == 1)
;250:					tropgold++;
;251:				if (yeah == 2)
;252:					tropsilv++;
;253:				if (yeah == 3)
;254:					tropbrnz++;
;255:			}
;256:			trap_Cvar_Set("ui_sp_trophies_gold", va("%i", tropgold));
;257:			trap_Cvar_Set("ui_sp_trophies_silver", va("%i", tropsilv));
;258:			trap_Cvar_Set("ui_sp_trophies_bronze", va("%i", tropbrnz));
;259:		}
;260:	}
;261:}
;262:
;263:static void CG_spLose_f(void) {
;264:	trap_Cvar_Set("cg_cameraOrbit", "2");
;265:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
;266:	trap_Cvar_Set("cg_thirdPerson", "1");
;267:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
;268:	trap_Cvar_Set("cg_thirdPersonRange", "100");
;269:	CG_AddBufferedSound(cgs.media.loserSound);
;270:	//trap_S_StartLocalSound(cgs.media.loserSound, CHAN_ANNOUNCER);
;271:	CG_CenterPrint("YOU LOSE...", SCREEN_HEIGHT * .30, 0);
;272:}
;273:
;274:#endif
;275:
;276:static void CG_TellTarget_f(void) {
line 281
;277:	int clientNum;
;278:	char command[128];
;279:	char message[128];
;280:
;281:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 282
;282:	if (clientNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $167
line 283
;283:		return;
ADDRGP4 $166
JUMPV
LABELV $167
line 286
;284:	}
;285:
;286:	trap_Args(message, 128);
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 287
;287:	Com_sprintf(command, 128, "tell %i %s", clientNum, message);
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $169
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 288
;288:	trap_SendClientCommand(command);
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 289
;289:}
LABELV $166
endproc CG_TellTarget_f 264 20
proc CG_TellAttacker_f 264 20
line 291
;290:
;291:static void CG_TellAttacker_f(void) {
line 296
;292:	int clientNum;
;293:	char command[128];
;294:	char message[128];
;295:
;296:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 297
;297:	if (clientNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $171
line 298
;298:		return;
ADDRGP4 $170
JUMPV
LABELV $171
line 301
;299:	}
;300:
;301:	trap_Args(message, 128);
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 302
;302:	Com_sprintf(command, 128, "tell %i %s", clientNum, message);
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $169
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 303
;303:	trap_SendClientCommand(command);
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 304
;304:}
LABELV $170
endproc CG_TellAttacker_f 264 20
proc CG_VoiceTellTarget_f 264 20
line 306
;305:
;306:static void CG_VoiceTellTarget_f(void) {
line 311
;307:	int clientNum;
;308:	char command[128];
;309:	char message[128];
;310:
;311:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 312
;312:	if (clientNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $174
line 313
;313:		return;
ADDRGP4 $173
JUMPV
LABELV $174
line 316
;314:	}
;315:
;316:	trap_Args(message, 128);
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 317
;317:	Com_sprintf(command, 128, "vtell %i %s", clientNum, message);
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $176
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 318
;318:	trap_SendClientCommand(command);
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 319
;319:}
LABELV $173
endproc CG_VoiceTellTarget_f 264 20
proc CG_VoiceTellAttacker_f 264 20
line 321
;320:
;321:static void CG_VoiceTellAttacker_f(void) {
line 326
;322:	int clientNum;
;323:	char command[128];
;324:	char message[128];
;325:
;326:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 327
;327:	if (clientNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $178
line 328
;328:		return;
ADDRGP4 $177
JUMPV
LABELV $178
line 331
;329:	}
;330:
;331:	trap_Args(message, 128);
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 332
;332:	Com_sprintf(command, 128, "vtell %i %s", clientNum, message);
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $176
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 333
;333:	trap_SendClientCommand(command);
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 334
;334:}
LABELV $177
endproc CG_VoiceTellAttacker_f 264 20
proc CG_StartOrbit_f 0 8
line 510
;335:
;336:#ifdef MISSIONPACK
;337:
;338:static void CG_NextTeamMember_f(void) {
;339:	CG_SelectNextPlayer();
;340:}
;341:
;342:static void CG_PrevTeamMember_f(void) {
;343:	CG_SelectPrevPlayer();
;344:}
;345:
;346:// ASS U ME's enumeration order as far as task specific orders, OFFENSE is zero, CAMP is last
;347://
;348:
;349:static void CG_NextOrder_f(void) {
;350:	clientInfo_t *ci = cgs.clientinfo + cg.snap->ps.clientNum;
;351:	if (ci) {
;352:		if (!ci->teamLeader && sortedTeamPlayers[cg_currentSelectedPlayer.integer] != cg.snap->ps.clientNum) {
;353:			return;
;354:		}
;355:	}
;356:	if (cgs.currentOrder < TEAMTASK_CAMP) {
;357:		cgs.currentOrder++;
;358:
;359:		if (cgs.currentOrder == TEAMTASK_RETRIEVE) {
;360:			if (!CG_OtherTeamHasFlag()) {
;361:				cgs.currentOrder++;
;362:			}
;363:		}
;364:
;365:		if (cgs.currentOrder == TEAMTASK_ESCORT) {
;366:			if (!CG_YourTeamHasFlag()) {
;367:				cgs.currentOrder++;
;368:			}
;369:		}
;370:
;371:	} else {
;372:		cgs.currentOrder = TEAMTASK_OFFENSE;
;373:	}
;374:	cgs.orderPending = qtrue;
;375:	cgs.orderTime = cg.time + 3000;
;376:}
;377:
;378:static void CG_ConfirmOrder_f(void) {
;379:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_YES));
;380:	trap_SendConsoleCommand("+button5; wait; -button5");
;381:	if (cg.time < cgs.acceptOrderTime) {
;382:		trap_SendClientCommand(va("teamtask %d\n", cgs.acceptTask));
;383:		cgs.acceptOrderTime = 0;
;384:	}
;385:}
;386:
;387:static void CG_DenyOrder_f(void) {
;388:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_NO));
;389:	trap_SendConsoleCommand("+button6; wait; -button6");
;390:	if (cg.time < cgs.acceptOrderTime) {
;391:		cgs.acceptOrderTime = 0;
;392:	}
;393:}
;394:
;395:static void CG_TaskOffense_f(void) {
;396:	if (CG_UsesTeamFlags(cgs.gametype)) {
;397:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONGETFLAG));
;398:	} else {
;399:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONOFFENSE));
;400:	}
;401:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_OFFENSE));
;402:}
;403:
;404:static void CG_TaskDefense_f(void) {
;405:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONDEFENSE));
;406:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_DEFENSE));
;407:}
;408:
;409:static void CG_TaskPatrol_f(void) {
;410:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONPATROL));
;411:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_PATROL));
;412:}
;413:
;414:static void CG_TaskCamp_f(void) {
;415:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONCAMPING));
;416:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_CAMP));
;417:}
;418:
;419:static void CG_TaskFollow_f(void) {
;420:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOW));
;421:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_FOLLOW));
;422:}
;423:
;424:static void CG_TaskRetrieve_f(void) {
;425:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONRETURNFLAG));
;426:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_RETRIEVE));
;427:}
;428:
;429:static void CG_TaskEscort_f(void) {
;430:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOWCARRIER));
;431:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_ESCORT));
;432:}
;433:
;434:static void CG_TaskOwnFlag_f(void) {
;435:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_IHAVEFLAG));
;436:}
;437:
;438:static void CG_TauntKillInsult_f(void) {
;439:	trap_SendConsoleCommand("cmd vsay kill_insult\n");
;440:}
;441:
;442:static void CG_TauntPraise_f(void) {
;443:	trap_SendConsoleCommand("cmd vsay praise\n");
;444:}
;445:
;446:static void CG_TauntTaunt_f(void) {
;447:	trap_SendConsoleCommand("cmd vtaunt\n");
;448:}
;449:
;450:static void CG_TauntDeathInsult_f(void) {
;451:	trap_SendConsoleCommand("cmd vsay death_insult\n");
;452:}
;453:
;454:static void CG_TauntGauntlet_f(void) {
;455:	trap_SendConsoleCommand("cmd vsay kill_gauntlet\n");
;456:}
;457:
;458:static void CG_TaskSuicide_f(void) {
;459:	int clientNum;
;460:	char command[128];
;461:
;462:	clientNum = CG_CrosshairPlayer();
;463:	if (clientNum == -1) {
;464:		return;
;465:	}
;466:
;467:	Com_sprintf(command, 128, "tell %i suicide", clientNum);
;468:	trap_SendClientCommand(command);
;469:}
;470:
;471:
;472:
;473:/*
;474:==================
;475:CG_TeamMenu_f
;476:==================
;477: */
;478:/*
;479:static void CG_TeamMenu_f( void ) {
;480:	if (trap_Key_GetCatcher() & KEYCATCH_CGAME) {
;481:		CG_EventHandling(CGAME_EVENT_NONE);
;482:		trap_Key_SetCatcher(0);
;483:	} else {
;484:		CG_EventHandling(CGAME_EVENT_TEAMMENU);
;485:		//trap_Key_SetCatcher(KEYCATCH_CGAME);
;486:	}
;487:}
;488: */
;489:
;490:/*
;491:==================
;492:CG_EditHud_f
;493:==================
;494: */
;495:/*
;496:static void CG_EditHud_f( void ) {
;497:	//cls.keyCatchers ^= KEYCATCH_CGAME;
;498:	//VM_Call (cgvm, CG_EVENT_HANDLING, (cls.keyCatchers & KEYCATCH_CGAME) ? CGAME_EVENT_EDITHUD : CGAME_EVENT_NONE);
;499:}
;500: */
;501:
;502:#endif
;503:
;504:/*
;505:==================
;506:CG_StartOrbit_f
;507:==================
;508: */
;509:
;510:static void CG_StartOrbit_f(void) {
line 511
;511:	if (!cg_developer.integer) {
ADDRGP4 cg_developer+12
INDIRI4
CNSTI4 0
NEI4 $181
line 512
;512:		return;
ADDRGP4 $180
JUMPV
LABELV $181
line 514
;513:	}
;514:	if (cg_cameraOrbit.value != 0) {
ADDRGP4 cg_cameraOrbit+8
INDIRF4
CNSTF4 0
EQF4 $184
line 515
;515:		trap_Cvar_Set("cg_cameraOrbit", "0");
ADDRGP4 $187
ARGP4
ADDRGP4 $188
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 516
;516:		trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $189
ARGP4
ADDRGP4 $188
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 517
;517:	} else {
ADDRGP4 $185
JUMPV
LABELV $184
line 518
;518:		trap_Cvar_Set("cg_cameraOrbit", "5");
ADDRGP4 $187
ARGP4
ADDRGP4 $190
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 519
;519:		trap_Cvar_Set("cg_thirdPerson", "1");
ADDRGP4 $189
ARGP4
ADDRGP4 $191
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 520
;520:		trap_Cvar_Set("cg_thirdPersonAngle", "0");
ADDRGP4 $192
ARGP4
ADDRGP4 $188
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 521
;521:		trap_Cvar_Set("cg_thirdPersonRange", "100");
ADDRGP4 $193
ARGP4
ADDRGP4 $194
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 522
;522:	}
LABELV $185
line 523
;523:}
LABELV $180
endproc CG_StartOrbit_f 0 8
data
align 4
LABELV commands
address $196
address CG_TestGun_f
address $197
address CG_TestModel_f
address $198
address CG_TestModelNextFrame_f
address $199
address CG_TestModelPrevFrame_f
address $200
address CG_TestModelNextSkin_f
address $201
address CG_TestModelPrevSkin_f
address $202
address CG_Viewpos_f
address $203
address CG_ScoresDown_f
address $204
address CG_ScoresUp_f
address $205
address CG_ZoomDown_f
address $206
address CG_ZoomUp_f
address $207
address CG_SizeUp_f
address $208
address CG_SizeDown_f
address $209
address CG_BestWeapon_f
address $210
address CG_NextWeapon_f
address $211
address CG_PrevWeapon_f
address $212
address CG_Weapon_f
address $213
address CG_TellTarget_f
address $214
address CG_TellAttacker_f
address $215
address CG_VoiceTellTarget_f
address $216
address CG_VoiceTellAttacker_f
address $217
address CG_TargetCommand_f
address $218
address CG_StartOrbit_f
address $219
address CG_LoadDeferredPlayers
address $220
address CG_AccDown_f
address $221
address CG_AccUp_f
address $222
address CG_PrintClientNumbers
export CG_ConsoleCommand
code
proc CG_ConsoleCommand 16 8
line 609
;524:
;525:/*
;526:static void CG_Camera_f( void ) {
;527:	char name[1024];
;528:	trap_Argv( 1, name, sizeof(name));
;529:	if (trap_loadCamera(name)) {
;530:		cg.cameraMode = qtrue;
;531:		trap_startCamera(cg.time);
;532:	} else {
;533:		CG_Printf ("Unable to load camera %s\n",name);
;534:	}
;535:}
;536: */
;537:
;538:
;539:typedef struct {
;540:	char *cmd;
;541:	void (*function)(void);
;542:} consoleCommand_t;
;543:
;544:static consoleCommand_t commands[] = {
;545:	{ "testgun", CG_TestGun_f},
;546:	{ "testmodel", CG_TestModel_f},
;547:	{ "nextframe", CG_TestModelNextFrame_f},
;548:	{ "prevframe", CG_TestModelPrevFrame_f},
;549:	{ "nextskin", CG_TestModelNextSkin_f},
;550:	{ "prevskin", CG_TestModelPrevSkin_f},
;551:	{ "viewpos", CG_Viewpos_f},
;552:	{ "+scores", CG_ScoresDown_f},
;553:	{ "-scores", CG_ScoresUp_f},
;554:	{ "+zoom", CG_ZoomDown_f},
;555:	{ "-zoom", CG_ZoomUp_f},
;556:	{ "sizeup", CG_SizeUp_f},
;557:	{ "sizedown", CG_SizeDown_f},
;558:	{ "weapbest", CG_BestWeapon_f},
;559:	{ "weapnext", CG_NextWeapon_f},
;560:	{ "weapprev", CG_PrevWeapon_f},
;561:	{ "weapon", CG_Weapon_f},
;562:	{ "tell_target", CG_TellTarget_f},
;563:	{ "tell_attacker", CG_TellAttacker_f},
;564:	{ "vtell_target", CG_VoiceTellTarget_f},
;565:	{ "vtell_attacker", CG_VoiceTellAttacker_f},
;566:	{ "tcmd", CG_TargetCommand_f},
;567:#ifdef MISSIONPACK
;568:	{ "loadhud", CG_LoadHud_f},
;569:	{ "nextTeamMember", CG_NextTeamMember_f},
;570:	{ "prevTeamMember", CG_PrevTeamMember_f},
;571:	{ "nextOrder", CG_NextOrder_f},
;572:	{ "confirmOrder", CG_ConfirmOrder_f},
;573:	{ "denyOrder", CG_DenyOrder_f},
;574:	{ "taskOffense", CG_TaskOffense_f},
;575:	{ "taskDefense", CG_TaskDefense_f},
;576:	{ "taskPatrol", CG_TaskPatrol_f},
;577:	{ "taskCamp", CG_TaskCamp_f},
;578:	{ "taskFollow", CG_TaskFollow_f},
;579:	{ "taskRetrieve", CG_TaskRetrieve_f},
;580:	{ "taskEscort", CG_TaskEscort_f},
;581:	{ "taskSuicide", CG_TaskSuicide_f},
;582:	{ "taskOwnFlag", CG_TaskOwnFlag_f},
;583:	{ "tauntKillInsult", CG_TauntKillInsult_f},
;584:	{ "tauntPraise", CG_TauntPraise_f},
;585:	{ "tauntTaunt", CG_TauntTaunt_f},
;586:	{ "tauntDeathInsult", CG_TauntDeathInsult_f},
;587:	{ "tauntGauntlet", CG_TauntGauntlet_f},
;588:	{ "spWin", CG_spWin_f},
;589:	{ "spLose", CG_spLose_f},
;590:	{ "scoresDown", CG_scrollScoresDown_f},
;591:	{ "scoresUp", CG_scrollScoresUp_f},
;592:#endif
;593:	{ "startOrbit", CG_StartOrbit_f},
;594:	//	{ "camera", CG_Camera_f },
;595:	{ "loaddeferred", CG_LoadDeferredPlayers},
;596:	{ "+acc", CG_AccDown_f},
;597:	{ "-acc", CG_AccUp_f},
;598:	{ "clients", CG_PrintClientNumbers}
;599:};
;600:
;601:/*
;602:=================
;603:CG_ConsoleCommand
;604:
;605:The string has been tokenized and can be retrieved with
;606:Cmd_Argc() / Cmd_Argv()
;607:=================
;608: */
;609:qboolean CG_ConsoleCommand(void) {
line 613
;610:	const char *cmd;
;611:	int i;
;612:
;613:	cmd = CG_Argv(0);
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 615
;614:
;615:	for (i = 0; i < sizeof ( commands) / sizeof ( commands[0]); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $227
JUMPV
LABELV $224
line 616
;616:		if (Q_strequal(cmd, commands[i].cmd)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $228
line 617
;617:			commands[i].function();
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands+4
ADDP4
INDIRP4
CALLV
pop
line 618
;618:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $223
JUMPV
LABELV $228
line 620
;619:		}
;620:	}
LABELV $225
line 615
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $227
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 27
LTU4 $224
line 622
;621:
;622:	return qfalse;
CNSTI4 0
RETI4
LABELV $223
endproc CG_ConsoleCommand 16 8
export CG_InitConsoleCommands
proc CG_InitConsoleCommands 4 4
line 633
;623:}
;624:
;625:/*
;626:=================
;627:CG_InitConsoleCommands
;628:
;629:Let the client system know about all of our commands
;630:so it can perform tab completion
;631:=================
;632: */
;633:void CG_InitConsoleCommands(void) {
line 636
;634:	int i;
;635:
;636:	for (i = 0; i < sizeof ( commands) / sizeof ( commands[0]); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $235
JUMPV
LABELV $232
line 637
;637:		trap_AddCommand(commands[i].cmd);
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 638
;638:	}
LABELV $233
line 636
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $235
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 27
LTU4 $232
line 644
;639:
;640:	//
;641:	// the game server will interpret these commands, which will be automatically
;642:	// forwarded to the server after they are not recognized locally
;643:	//
;644:	trap_AddCommand("kill");
ADDRGP4 $236
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 645
;645:	trap_AddCommand("say");
ADDRGP4 $237
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 646
;646:	trap_AddCommand("say_team");
ADDRGP4 $238
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 647
;647:	trap_AddCommand("tell");
ADDRGP4 $239
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 648
;648:	trap_AddCommand("vsay");
ADDRGP4 $240
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 649
;649:	trap_AddCommand("vsay_team");
ADDRGP4 $241
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 650
;650:	trap_AddCommand("vtell");
ADDRGP4 $242
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 651
;651:	trap_AddCommand("vtaunt");
ADDRGP4 $243
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 652
;652:	trap_AddCommand("vosay");
ADDRGP4 $244
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 653
;653:	trap_AddCommand("vosay_team");
ADDRGP4 $245
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 654
;654:	trap_AddCommand("votell");
ADDRGP4 $246
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 655
;655:	trap_AddCommand("give");
ADDRGP4 $247
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 656
;656:	trap_AddCommand("god");
ADDRGP4 $248
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 657
;657:	trap_AddCommand("notarget");
ADDRGP4 $249
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 658
;658:	trap_AddCommand("noclip");
ADDRGP4 $250
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 659
;659:	trap_AddCommand("team");
ADDRGP4 $251
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 660
;660:	trap_AddCommand("follow");
ADDRGP4 $252
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 661
;661:	trap_AddCommand("levelshot");
ADDRGP4 $253
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 662
;662:	trap_AddCommand("addbot");
ADDRGP4 $254
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 663
;663:	trap_AddCommand("setviewpos");
ADDRGP4 $255
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 664
;664:	trap_AddCommand("callvote");
ADDRGP4 $256
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 665
;665:	trap_AddCommand("getmappage");
ADDRGP4 $257
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 666
;666:	trap_AddCommand("vote");
ADDRGP4 $258
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 667
;667:	trap_AddCommand("callteamvote");
ADDRGP4 $259
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 668
;668:	trap_AddCommand("teamvote");
ADDRGP4 $260
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 669
;669:	trap_AddCommand("stats");
ADDRGP4 $261
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 670
;670:	trap_AddCommand("teamtask");
ADDRGP4 $262
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 671
;671:	trap_AddCommand("loaddefered"); // spelled wrong, but not changing for demo
ADDRGP4 $263
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 672
;672:}
LABELV $231
endproc CG_InitConsoleCommands 4 4
import Item_Text_AutoWrapped_Paint
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Controls_SetDefaults
import Controls_SetConfig
import Controls_GetConfig
import UI_OutOfMemory
import UI_InitMemory
import UI_Alloc
import Display_CacheAll
import Menu_SetFeederSelection
import Menu_Paint
import Menus_CloseAll
import LerpColor
import Display_HandleKey
import Menus_CloseByName
import Menus_ShowByName
import Menus_FindByName
import Menus_OpenByName
import Display_KeyBindPending
import Display_CursorType
import Display_MouseMove
import Display_CaptureItem
import Display_GetContext
import UI_SelectForKey
import Menus_Activate
import Menus_AnyFullScreenVisible
import Menu_Reset
import Menus_ActivateByName
import Item_EnableShowViaCvar
import Menu_PaintEnd
import Menu_PaintAll
import Menu_New
import Menu_Count
import PC_Script_Parse
import PC_String_Parse
import PC_Rect_Parse
import PC_Int_Parse
import PC_Color_Parse
import PC_Float_Parse
import Script_Parse
import String_Parse
import Rect_Parse
import Int_Parse
import Color_Parse
import Float_Parse
import Menu_ScrollFeeder
import Menu_HandleMouseMove
import Menu_HandleKey
import Menu_GetFocused
import Menu_PostParse
import Item_Init
import Menu_Init
import Display_ExpandMacros
import Init_Display
import String_Report
import String_Init
import String_Alloc
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
LABELV $263
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $262
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
LABELV $261
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $260
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $259
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $258
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $257
byte 1 103
byte 1 101
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 112
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $256
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $255
byte 1 115
byte 1 101
byte 1 116
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $254
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $253
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $252
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $251
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $250
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $249
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $248
byte 1 103
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $247
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $246
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $245
byte 1 118
byte 1 111
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
LABELV $244
byte 1 118
byte 1 111
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $243
byte 1 118
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $242
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $241
byte 1 118
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
LABELV $240
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $239
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $238
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
LABELV $237
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $236
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $222
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $221
byte 1 45
byte 1 97
byte 1 99
byte 1 99
byte 1 0
align 1
LABELV $220
byte 1 43
byte 1 97
byte 1 99
byte 1 99
byte 1 0
align 1
LABELV $219
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $218
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $217
byte 1 116
byte 1 99
byte 1 109
byte 1 100
byte 1 0
align 1
LABELV $216
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $215
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $214
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $213
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $212
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $211
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $210
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $209
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 98
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $208
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $207
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $206
byte 1 45
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $205
byte 1 43
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $204
byte 1 45
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $203
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $202
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $201
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $200
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $199
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $198
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $197
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $196
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $194
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $193
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $192
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $191
byte 1 49
byte 1 0
align 1
LABELV $190
byte 1 53
byte 1 0
align 1
LABELV $189
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $188
byte 1 48
byte 1 0
align 1
LABELV $187
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $176
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $169
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $153
byte 1 97
byte 1 99
byte 1 99
byte 1 0
align 1
LABELV $132
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $114
byte 1 40
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 41
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $109
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $108
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $106
byte 1 103
byte 1 99
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $99
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $96
byte 1 32
byte 1 37
byte 1 45
byte 1 52
byte 1 100
byte 1 0
align 1
LABELV $93
byte 1 32
byte 1 37
byte 1 45
byte 1 53
byte 1 100
byte 1 0
align 1
LABELV $91
byte 1 37
byte 1 45
byte 1 52
byte 1 100
byte 1 0
align 1
LABELV $85
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $84
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
