data
export forceModelModificationCount
align 4
LABELV forceModelModificationCount
byte 4 -1
export vmMain
code
proc vmMain 16 12
file "../../../code/cgame/cg_main.c"
line 49
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
;23:// cg_main.c -- initialization and primary entry point for cgame
;24:#include "cg_local.h"
;25:
;26:#ifdef MISSIONPACK
;27:#include "../ui/ui_shared.h"
;28:// display context for new ui stuff
;29:displayContextDef_t cgDC;
;30:#endif
;31:
;32:int forceModelModificationCount = -1;
;33:
;34:void CG_Init(int serverMessageNum, int serverCommandSequence, int clientNum);
;35:void CG_Shutdown(void);
;36:
;37:
;38:int realVidWidth;
;39:int realVidHeight; // leilei - global video hack
;40:
;41:/*
;42:================
;43:vmMain
;44:
;45:This is the only way control passes into the module.
;46:This must be the very first function compiled into the .q3vm file
;47:================
;48: */
;49:Q_EXPORT intptr_t vmMain(int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11) {
line 51
;50:
;51:	switch (command) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $75
ADDRLP4 0
INDIRI4
CNSTI4 8
GTI4 $75
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $87
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $87
address $77
address $78
address $79
address $80
address $81
address $82
address $83
address $84
address $85
code
LABELV $77
line 53
;52:		case CG_INIT:
;53:			CG_Init(arg0, arg1, arg2);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Init
CALLV
pop
line 54
;54:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $74
JUMPV
LABELV $78
line 56
;55:		case CG_SHUTDOWN:
;56:			CG_Shutdown();
ADDRGP4 CG_Shutdown
CALLV
pop
line 57
;57:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $74
JUMPV
LABELV $79
line 59
;58:		case CG_CONSOLE_COMMAND:
;59:			return CG_ConsoleCommand();
ADDRLP4 4
ADDRGP4 CG_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $74
JUMPV
LABELV $80
line 61
;60:		case CG_DRAW_ACTIVE_FRAME:
;61:			CG_DrawActiveFrame(arg0, arg1, arg2);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawActiveFrame
CALLV
pop
line 62
;62:			CG_FairCvars();
ADDRGP4 CG_FairCvars
CALLV
pop
line 63
;63:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $74
JUMPV
LABELV $81
line 65
;64:		case CG_CROSSHAIR_PLAYER:
;65:			return CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $74
JUMPV
LABELV $82
line 67
;66:		case CG_LAST_ATTACKER:
;67:			return CG_LastAttacker();
ADDRLP4 12
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $74
JUMPV
LABELV $83
line 69
;68:		case CG_KEY_EVENT:
;69:			CG_KeyEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_KeyEvent
CALLV
pop
line 70
;70:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $74
JUMPV
LABELV $84
line 76
;71:		case CG_MOUSE_EVENT:
;72:#ifdef MISSIONPACK
;73:			cgDC.cursorx = cgs.cursorX;
;74:			cgDC.cursory = cgs.cursorY;
;75:#endif
;76:			CG_MouseEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_MouseEvent
CALLV
pop
line 77
;77:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $74
JUMPV
LABELV $85
line 79
;78:		case CG_EVENT_HANDLING:
;79:			CG_EventHandling(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_EventHandling
CALLV
pop
line 80
;80:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $74
JUMPV
LABELV $75
line 82
;81:		default:
;82:			CG_Error("vmMain: unknown command %i", command);
ADDRGP4 $86
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 83
;83:			break;
LABELV $76
line 85
;84:	}
;85:	return -1;
CNSTI4 -1
RETI4
LABELV $74
endproc vmMain 16 12
data
align 4
LABELV cvarTable
address cg_ignore
address $89
address $90
byte 4 0
address cg_autoswitch
address $91
address $92
byte 4 1
address cg_drawGun
address $93
address $92
byte 4 1
address cg_zoomFov
address $94
address $95
byte 4 1
address cg_fov
address $96
address $97
byte 4 1
address cg_viewsize
address $98
address $99
byte 4 1
address cg_viewnudge
address $100
address $90
byte 4 1
address cg_shadows
address $101
address $92
byte 4 1
address cg_gibs
address $102
address $92
byte 4 1
address cg_draw2D
address $103
address $92
byte 4 1
address cg_drawStatus
address $104
address $92
byte 4 1
address cg_drawTimer
address $105
address $90
byte 4 1
address cg_drawFPS
address $106
address $90
byte 4 1
address cg_drawSnapshot
address $107
address $90
byte 4 1
address cg_draw3dIcons
address $108
address $92
byte 4 1
address cg_drawIcons
address $109
address $92
byte 4 1
address cg_drawAmmoWarning
address $110
address $92
byte 4 1
address cg_drawAttacker
address $111
address $92
byte 4 1
address cg_drawSpeed
address $112
address $90
byte 4 1
address cg_drawCrosshair
address $113
address $114
byte 4 1
address cg_drawCrosshairNames
address $115
address $92
byte 4 1
address cg_drawRewards
address $116
address $92
byte 4 1
address cg_crosshairSize
address $117
address $118
byte 4 1
address cg_crosshairHealth
address $119
address $92
byte 4 1
address cg_crosshairX
address $120
address $90
byte 4 1
address cg_crosshairY
address $121
address $90
byte 4 1
address cg_brassTime
address $122
address $123
byte 4 1
address cg_simpleItems
address $124
address $90
byte 4 1
address cg_addMarks
address $125
address $92
byte 4 1
address cg_lagometer
address $126
address $92
byte 4 1
address cg_railTrailTime
address $127
address $128
byte 4 1
address cg_gun_x
address $129
address $90
byte 4 512
address cg_gun_y
address $130
address $90
byte 4 512
address cg_gun_z
address $131
address $90
byte 4 512
address cg_centertime
address $132
address $133
byte 4 512
address cg_runpitch
address $134
address $135
byte 4 1
address cg_runroll
address $136
address $137
byte 4 1
address cg_bob
address $138
address $92
byte 4 1
address cg_bobup
address $139
address $137
byte 4 512
address cg_bobpitch
address $140
address $135
byte 4 1
address cg_bobroll
address $141
address $135
byte 4 1
address cg_bobmodel
address $142
address $90
byte 4 1
address cg_kickScale
address $143
address $144
byte 4 1
address cg_swingSpeed
address $145
address $146
byte 4 512
address cg_animSpeed
address $147
address $92
byte 4 512
address cg_debugAnim
address $148
address $90
byte 4 512
address cg_debugPosition
address $149
address $90
byte 4 512
address cg_debugEvents
address $150
address $90
byte 4 512
address cg_errorDecay
address $151
address $99
byte 4 0
address cg_nopredict
address $152
address $90
byte 4 0
address cg_noPlayerAnims
address $153
address $90
byte 4 512
address cg_showmiss
address $154
address $90
byte 4 0
address cg_footsteps
address $155
address $92
byte 4 512
address cg_tracerChance
address $156
address $157
byte 4 512
address cg_tracerWidth
address $158
address $92
byte 4 512
address cg_tracerLength
address $159
address $99
byte 4 512
address cg_thirdPersonRange
address $160
address $161
byte 4 512
address cg_thirdPersonAngle
address $162
address $90
byte 4 512
address cg_thirdPerson
address $163
address $90
byte 4 0
address cg_teamChatTime
address $164
address $165
byte 4 1
address cg_teamChatHeight
address $166
address $90
byte 4 1
address cg_forceModel
address $167
address $90
byte 4 1
address cg_predictItems
address $168
address $92
byte 4 1
address cg_deferPlayers
address $169
address $92
byte 4 1
address cg_drawTeamOverlay
address $170
address $90
byte 4 1
address cg_teamOverlayUserinfo
address $171
address $90
byte 4 66
address cg_stats
address $172
address $90
byte 4 0
address cg_drawFriend
address $173
address $92
byte 4 1
address cg_teamChatsOnly
address $174
address $90
byte 4 1
address cg_noVoiceChats
address $175
address $90
byte 4 1
address cg_noVoiceText
address $176
address $90
byte 4 1
address cg_buildScript
address $177
address $90
byte 4 0
address cg_paused
address $178
address $90
byte 4 64
address cg_blood
address $179
address $92
byte 4 1
address cg_alwaysWeaponBar
address $180
address $90
byte 4 1
address cg_hitsound
address $181
address $90
byte 4 1
address cg_voip_teamonly
address $182
address $92
byte 4 1
address cg_voteflags
address $183
address $184
byte 4 64
address cg_cyclegrapple
address $185
address $92
byte 4 1
address cg_vote_custom_commands
address $186
address $187
byte 4 64
address cg_synchronousClients
address $188
address $90
byte 4 8
address cg_autovertex
address $189
address $90
byte 4 1
address cg_enableFS
address $190
address $90
byte 4 4
address cg_enableQ
address $191
address $90
byte 4 4
address cg_enableDust
address $192
address $90
byte 4 4
address cg_enableBreath
address $193
address $90
byte 4 4
address cg_obeliskRespawnDelay
address $194
address $195
byte 4 4
address cg_cameraOrbit
address $196
address $90
byte 4 512
address cg_cameraOrbitDelay
address $197
address $198
byte 4 1
address cg_timescaleFadeEnd
address $199
address $92
byte 4 0
address cg_timescaleFadeSpeed
address $200
address $90
byte 4 0
address cg_timescale
address $201
address $92
byte 4 0
address cg_scorePlum
address $202
address $92
byte 4 3
address cg_obituaryOutput
address $203
address $133
byte 4 1
address pmove_fixed
address $204
address $90
byte 4 8
address pmove_msec
address $205
address $206
byte 4 8
address pmove_float
address $207
address $92
byte 4 8
address cg_noTaunt
address $208
address $90
byte 4 1
address cg_noProjectileTrail
address $209
address $90
byte 4 1
address cg_smallFont
address $210
address $211
byte 4 1
address cg_bigFont
address $212
address $157
byte 4 1
address cg_oldRail
address $213
address $90
byte 4 1
address cg_oldRocket
address $214
address $92
byte 4 1
address cg_leiEnhancement
address $215
address $90
byte 4 1
address cg_leiGoreNoise
address $216
address $90
byte 4 1
address cg_leiBrassNoise
address $217
address $90
byte 4 1
address cg_leiSuperGoreyAwesome
address $218
address $90
byte 4 1
address cg_leiDebug
address $219
address $90
byte 4 1
address cg_leiChibi
address $220
address $90
byte 4 512
address cg_leiWidescreen
address $221
address $92
byte 4 1
address cg_deathcam
address $222
address $92
byte 4 1
address cg_cameramode
address $223
address $90
byte 4 1
address cg_cameraEyes
address $224
address $90
byte 4 1
address cg_cameraEyes_Fwd
address $225
address $133
byte 4 512
address cg_cameraEyes_Up
address $226
address $133
byte 4 512
address cg_modelEyes_Up
address $227
address $133
byte 4 1
address cg_modelEyes_Right
address $228
address $133
byte 4 1
address cg_modelEyes_Fwd
address $229
address $133
byte 4 1
address cg_oldPlasma
address $230
address $92
byte 4 1
address cg_delag
address $231
address $92
byte 4 3
address cg_cmdTimeNudge
address $232
address $90
byte 4 3
address sv_fps
address $233
address $234
byte 4 8
address cg_projectileNudge
address $235
address $90
byte 4 1
address cg_optimizePrediction
address $236
address $92
byte 4 1
address cl_timeNudge
address $237
address $90
byte 4 1
address cg_trueLightning
address $238
address $239
byte 4 1
address cg_music
address $240
address $187
byte 4 1
address cg_fragmsgsize
address $241
address $144
byte 4 1
address cg_crosshairPulse
address $242
address $92
byte 4 1
address cg_differentCrosshairs
address $243
address $90
byte 4 1
address cg_ch1
address $244
address $92
byte 4 1
address cg_ch1size
address $245
address $118
byte 4 1
address cg_ch2
address $246
address $92
byte 4 1
address cg_ch2size
address $247
address $118
byte 4 1
address cg_ch3
address $248
address $92
byte 4 1
address cg_ch3size
address $249
address $118
byte 4 1
address cg_ch4
address $250
address $92
byte 4 1
address cg_ch4size
address $251
address $118
byte 4 1
address cg_ch5
address $252
address $92
byte 4 1
address cg_ch5size
address $253
address $118
byte 4 1
address cg_ch6
address $254
address $92
byte 4 1
address cg_ch6size
address $255
address $118
byte 4 1
address cg_ch7
address $256
address $92
byte 4 1
address cg_ch7size
address $257
address $118
byte 4 1
address cg_ch8
address $258
address $92
byte 4 1
address cg_ch8size
address $259
address $118
byte 4 1
address cg_ch9
address $260
address $92
byte 4 1
address cg_ch9size
address $261
address $118
byte 4 1
address cg_ch10
address $262
address $92
byte 4 1
address cg_ch10size
address $263
address $118
byte 4 1
address cg_ch11
address $264
address $92
byte 4 1
address cg_ch11size
address $265
address $118
byte 4 1
address cg_ch12
address $266
address $92
byte 4 1
address cg_ch12size
address $267
address $118
byte 4 1
address cg_ch13
address $268
address $92
byte 4 1
address cg_ch13size
address $269
address $118
byte 4 1
address cg_crosshairColorRed
address $270
address $144
byte 4 1
address cg_crosshairColorGreen
address $271
address $144
byte 4 1
address cg_crosshairColorBlue
address $272
address $144
byte 4 1
address cg_weaponBarStyle
address $273
address $90
byte 4 1
address cg_weaponOrder
address $274
address $275
byte 4 1
address cg_chatBeep
address $276
address $92
byte 4 1
address cg_teamChatBeep
address $277
address $92
byte 4 1
address cg_muzzleflashStyle
address $278
address $92
byte 4 1
address cg_missionpackChecks
address $279
address $92
byte 4 1
address cg_developer
address $280
address $90
byte 4 512
align 4
LABELV cvarTableSize
byte 4 166
export CG_RegisterCvars
code
proc CG_RegisterCvars 1036 16
line 561
;86:}
;87:
;88:
;89:cg_t cg;
;90:cgs_t cgs;
;91:centity_t cg_entities[MAX_GENTITIES];
;92:weaponInfo_t cg_weapons[MAX_WEAPONS];
;93:itemInfo_t cg_items[MAX_ITEMS];
;94:
;95:vmCvar_t g_ammolimit;
;96:vmCvar_t cg_railTrailTime;
;97:vmCvar_t cg_centertime;
;98:vmCvar_t cg_runpitch;
;99:vmCvar_t cg_runroll;
;100:vmCvar_t cg_bob;
;101:vmCvar_t cg_bobup;
;102:vmCvar_t cg_bobpitch;
;103:vmCvar_t cg_bobroll;
;104:vmCvar_t cg_bobmodel; // leilei
;105:vmCvar_t cg_kickScale;
;106:vmCvar_t cg_swingSpeed;
;107:vmCvar_t cg_shadows;
;108:vmCvar_t cg_gibs;
;109:vmCvar_t cg_drawTimer;
;110:vmCvar_t cg_drawFPS;
;111:vmCvar_t cg_drawSnapshot;
;112:vmCvar_t cg_draw3dIcons;
;113:vmCvar_t cg_drawIcons;
;114:vmCvar_t cg_drawAmmoWarning;
;115:vmCvar_t cg_drawCrosshair;
;116:vmCvar_t cg_drawCrosshairNames;
;117:vmCvar_t cg_drawRewards;
;118:vmCvar_t cg_crosshairSize;
;119:vmCvar_t cg_crosshairX;
;120:vmCvar_t cg_crosshairY;
;121:vmCvar_t cg_crosshairHealth;
;122:vmCvar_t cg_draw2D;
;123:vmCvar_t cg_drawStatus;
;124:vmCvar_t cg_animSpeed;
;125:vmCvar_t cg_debugAnim;
;126:vmCvar_t cg_debugPosition;
;127:vmCvar_t cg_debugEvents;
;128:vmCvar_t cg_errorDecay;
;129:vmCvar_t cg_nopredict;
;130:vmCvar_t cg_noPlayerAnims;
;131:vmCvar_t cg_showmiss;
;132:vmCvar_t cg_footsteps;
;133:vmCvar_t cg_addMarks;
;134:vmCvar_t cg_brassTime;
;135:vmCvar_t cg_viewsize;
;136:vmCvar_t cg_viewnudge; // leilei
;137:vmCvar_t cg_muzzleflashStyle;
;138:vmCvar_t cg_drawGun;
;139:vmCvar_t cg_gun_frame;
;140:vmCvar_t cg_gun_x;
;141:vmCvar_t cg_gun_y;
;142:vmCvar_t cg_gun_z;
;143:vmCvar_t cg_tracerChance;
;144:vmCvar_t cg_tracerWidth;
;145:vmCvar_t cg_tracerLength;
;146:vmCvar_t cg_autoswitch;
;147:vmCvar_t cg_ignore;
;148:vmCvar_t cg_simpleItems;
;149:vmCvar_t cg_fov;
;150:vmCvar_t cg_zoomFov;
;151:vmCvar_t cg_thirdPerson;
;152:vmCvar_t cg_thirdPersonRange;
;153:vmCvar_t cg_thirdPersonAngle;
;154:vmCvar_t cg_lagometer;
;155:vmCvar_t cg_drawAttacker;
;156:vmCvar_t cg_drawSpeed;
;157:vmCvar_t cg_synchronousClients;
;158:vmCvar_t cg_teamChatTime;
;159:vmCvar_t cg_teamChatHeight;
;160:vmCvar_t cg_stats;
;161:vmCvar_t cg_buildScript;
;162:vmCvar_t cg_forceModel;
;163:vmCvar_t cg_paused;
;164:vmCvar_t cg_blood;
;165:vmCvar_t cg_predictItems;
;166:vmCvar_t cg_deferPlayers;
;167:vmCvar_t cg_drawTeamOverlay;
;168:vmCvar_t cg_teamOverlayUserinfo;
;169:vmCvar_t cg_drawFriend;
;170:vmCvar_t cg_teamChatsOnly;
;171:vmCvar_t cg_noVoiceChats;
;172:vmCvar_t cg_noVoiceText;
;173:vmCvar_t cg_hudFiles;
;174:vmCvar_t cg_scorePlum;
;175:vmCvar_t cg_obituaryOutput;
;176://unlagged - smooth clients #2
;177:// this is done server-side now
;178://vmCvar_t cg_smoothClients;
;179://unlagged - smooth clients #2
;180:vmCvar_t pmove_fixed;
;181://vmCvar_t cg_pmove_fixed;
;182:vmCvar_t pmove_msec;
;183:vmCvar_t pmove_float;
;184:vmCvar_t cg_pmove_msec;
;185:
;186:vmCvar_t cg_cameraEyes;
;187:vmCvar_t cg_cameraEyes_Fwd;
;188:vmCvar_t cg_cameraEyes_Up;
;189:
;190:vmCvar_t cg_modelEyes_Up;
;191:vmCvar_t cg_modelEyes_Right;
;192:vmCvar_t cg_modelEyes_Fwd;
;193:vmCvar_t cg_cameraOrbit;
;194:vmCvar_t cg_cameraOrbitDelay;
;195:vmCvar_t cg_timescaleFadeEnd;
;196:vmCvar_t cg_timescaleFadeSpeed;
;197:vmCvar_t cg_timescale;
;198:vmCvar_t cg_smallFont;
;199:vmCvar_t cg_bigFont;
;200:vmCvar_t cg_noTaunt;
;201:vmCvar_t cg_noProjectileTrail;
;202:vmCvar_t cg_oldRail;
;203:vmCvar_t cg_oldRocket;
;204:vmCvar_t cg_leiEnhancement; // ANOTHER LEILEI LINE!!!
;205:vmCvar_t cg_leiBrassNoise; // ANOTHER LEILEI LINE!!!
;206:vmCvar_t cg_leiGoreNoise; // ANOTHER LEILEI LINE!!!
;207:vmCvar_t cg_leiSuperGoreyAwesome; // ANOTHER LEILEI LINE!!!
;208:vmCvar_t cg_leiDebug; // ANOTHER LEILEI LINE!!!
;209:vmCvar_t cg_leiChibi; // ANOTHER LEILEI LINE!!!
;210:vmCvar_t cg_oldPlasma;
;211:vmCvar_t cg_trueLightning;
;212:vmCvar_t cg_music;
;213:vmCvar_t cg_weaponOrder;
;214:
;215:vmCvar_t cg_leiWidescreen; // ANOTHER LEILEI LINE!!!
;216:vmCvar_t cg_deathcam; // ANOTHER LEILEI LINE!!!
;217:vmCvar_t cg_cameramode; // ANOTHER LEILEI LINE!!!
;218:vmCvar_t cg_cameraEyes; // ANOTHER LEILEI LINE!!!
;219:
;220:
;221:
;222:#ifdef MISSIONPACK
;223:vmCvar_t cg_redTeamName;
;224:vmCvar_t cg_blueTeamName;
;225:vmCvar_t cg_currentSelectedPlayer;
;226:vmCvar_t cg_currentSelectedPlayerName;
;227:vmCvar_t cg_singlePlayer;
;228:vmCvar_t cg_singlePlayerActive;
;229:vmCvar_t cg_recordSPDemo;
;230:vmCvar_t cg_recordSPDemoName;
;231:#endif
;232:vmCvar_t cg_obeliskRespawnDelay;
;233:vmCvar_t cg_enableDust;
;234:vmCvar_t cg_enableBreath;
;235:vmCvar_t cg_enableFS;
;236:vmCvar_t cg_enableQ;
;237:
;238://unlagged - client options
;239:vmCvar_t cg_delag;
;240://vmCvar_t cg_debugDelag;
;241://vmCvar_t cg_drawBBox;
;242:vmCvar_t cg_cmdTimeNudge;
;243:vmCvar_t sv_fps;
;244:vmCvar_t cg_projectileNudge;
;245:vmCvar_t cg_optimizePrediction;
;246:vmCvar_t cl_timeNudge;
;247://vmCvar_t cg_latentSnaps;
;248://vmCvar_t cg_latentCmds;
;249://vmCvar_t cg_plOut;
;250://unlagged - client options
;251:
;252://elimination addition
;253:vmCvar_t cg_alwaysWeaponBar;
;254:vmCvar_t cg_hitsound;
;255:vmCvar_t cg_voip_teamonly;
;256:vmCvar_t cg_voteflags;
;257:vmCvar_t cg_cyclegrapple;
;258:vmCvar_t cg_vote_custom_commands;
;259:
;260:vmCvar_t cg_autovertex;
;261:
;262:vmCvar_t cg_fragmsgsize;
;263:
;264:vmCvar_t cg_crosshairPulse;
;265:vmCvar_t cg_differentCrosshairs;
;266:vmCvar_t cg_ch1;
;267:vmCvar_t cg_ch1size;
;268:vmCvar_t cg_ch2;
;269:vmCvar_t cg_ch2size;
;270:vmCvar_t cg_ch3;
;271:vmCvar_t cg_ch3size;
;272:vmCvar_t cg_ch4;
;273:vmCvar_t cg_ch4size;
;274:vmCvar_t cg_ch5;
;275:vmCvar_t cg_ch5size;
;276:vmCvar_t cg_ch6;
;277:vmCvar_t cg_ch6size;
;278:vmCvar_t cg_ch7;
;279:vmCvar_t cg_ch7size;
;280:vmCvar_t cg_ch8;
;281:vmCvar_t cg_ch8size;
;282:vmCvar_t cg_ch9;
;283:vmCvar_t cg_ch9size;
;284:vmCvar_t cg_ch10;
;285:vmCvar_t cg_ch10size;
;286:vmCvar_t cg_ch11;
;287:vmCvar_t cg_ch11size;
;288:vmCvar_t cg_ch12;
;289:vmCvar_t cg_ch12size;
;290:vmCvar_t cg_ch13;
;291:vmCvar_t cg_ch13size;
;292:
;293:vmCvar_t cg_crosshairColorRed;
;294:vmCvar_t cg_crosshairColorGreen;
;295:vmCvar_t cg_crosshairColorBlue;
;296:
;297:vmCvar_t cg_weaponBarStyle;
;298:vmCvar_t cg_chatBeep;
;299:vmCvar_t cg_teamChatBeep;
;300:
;301:/* Neon_Knight: Missionpack checks toggle. Just because. */
;302:vmCvar_t cg_missionpackChecks;
;303:/* /Neon_Knight */
;304:/* Neon_Knight: Developer mode. */
;305:vmCvar_t cg_developer;
;306:/* /Neon_Knight */
;307:
;308:int mod_jumpheight;
;309:int mod_ammolimit;
;310:int	mod_ghtimeout;
;311:int	mod_gdelay;
;312:int	mod_mgdelay;
;313:int	mod_mgspread;
;314:int	mod_sgdelay;
;315:int	mod_sgspread;
;316:int mod_sgcount;
;317:int	mod_gldelay;
;318:int	mod_rldelay;
;319:int	mod_lgdelay;
;320:int mod_lgrange;
;321:int	mod_pgdelay;
;322:int	mod_rgdelay;
;323:int	mod_bfgdelay;
;324:int	mod_ngdelay;
;325:int	mod_pldelay;
;326:int	mod_cgdelay;
;327:int	mod_cgspread;
;328:int	mod_vampire_max_health;
;329:int mod_hastefirespeed;
;330:int mod_ammoregenfirespeed;
;331:int mod_scoutfirespeed;
;332:int	mod_poweruptime;
;333:
;334:typedef struct {
;335:	vmCvar_t *vmCvar;
;336:	char *cvarName;
;337:	char *defaultString;
;338:	int cvarFlags;
;339:} cvarTable_t;
;340:
;341:static cvarTable_t cvarTable[] = {// bk001129
;342:	{ &cg_ignore, "cg_ignore", "0", 0}, // used for debugging
;343:	{ &cg_autoswitch, "cg_autoswitch", "1", CVAR_ARCHIVE},
;344:	{ &cg_drawGun, "cg_drawGun", "1", CVAR_ARCHIVE},
;345:	{ &cg_zoomFov, "cg_zoomfov", "22.5", CVAR_ARCHIVE},
;346:	{ &cg_fov, "cg_fov", "90", CVAR_ARCHIVE},
;347:	{ &cg_viewsize, "cg_viewsize", "100", CVAR_ARCHIVE},
;348:	{ &cg_viewnudge, "cg_viewnudge", "0", CVAR_ARCHIVE},
;349:	{ &cg_shadows, "cg_shadows", "1", CVAR_ARCHIVE},
;350:	{ &cg_gibs, "cg_gibs", "1", CVAR_ARCHIVE},
;351:	{ &cg_draw2D, "cg_draw2D", "1", CVAR_ARCHIVE},
;352:	{ &cg_drawStatus, "cg_drawStatus", "1", CVAR_ARCHIVE},
;353:	{ &cg_drawTimer, "cg_drawTimer", "0", CVAR_ARCHIVE},
;354:	{ &cg_drawFPS, "cg_drawFPS", "0", CVAR_ARCHIVE},
;355:	{ &cg_drawSnapshot, "cg_drawSnapshot", "0", CVAR_ARCHIVE},
;356:	{ &cg_draw3dIcons, "cg_draw3dIcons", "1", CVAR_ARCHIVE},
;357:	{ &cg_drawIcons, "cg_drawIcons", "1", CVAR_ARCHIVE},
;358:	{ &cg_drawAmmoWarning, "cg_drawAmmoWarning", "1", CVAR_ARCHIVE},
;359:	{ &cg_drawAttacker, "cg_drawAttacker", "1", CVAR_ARCHIVE},
;360:	{ &cg_drawSpeed, "cg_drawSpeed", "0", CVAR_ARCHIVE},
;361:	{ &cg_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE},
;362:	{ &cg_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE},
;363:	{ &cg_drawRewards, "cg_drawRewards", "1", CVAR_ARCHIVE},
;364:	{ &cg_crosshairSize, "cg_crosshairSize", "24", CVAR_ARCHIVE},
;365:	{ &cg_crosshairHealth, "cg_crosshairHealth", "1", CVAR_ARCHIVE},
;366:	{ &cg_crosshairX, "cg_crosshairX", "0", CVAR_ARCHIVE},
;367:	{ &cg_crosshairY, "cg_crosshairY", "0", CVAR_ARCHIVE},
;368:	{ &cg_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE},
;369:	{ &cg_simpleItems, "cg_simpleItems", "0", CVAR_ARCHIVE},
;370:	{ &cg_addMarks, "cg_marks", "1", CVAR_ARCHIVE},
;371:	{ &cg_lagometer, "cg_lagometer", "1", CVAR_ARCHIVE},
;372:	{ &cg_railTrailTime, "cg_railTrailTime", "600", CVAR_ARCHIVE},
;373:	{ &cg_gun_x, "cg_gunX", "0", CVAR_CHEAT},
;374:	{ &cg_gun_y, "cg_gunY", "0", CVAR_CHEAT},
;375:	{ &cg_gun_z, "cg_gunZ", "0", CVAR_CHEAT},
;376:	{ &cg_centertime, "cg_centertime", "3", CVAR_CHEAT},
;377:	{ &cg_runpitch, "cg_runpitch", "0.002", CVAR_ARCHIVE},
;378:	{ &cg_runroll, "cg_runroll", "0.005", CVAR_ARCHIVE},
;379:	{ &cg_bob, "cg_bob", "1", CVAR_ARCHIVE},
;380:	{ &cg_bobup, "cg_bobup", "0.005", CVAR_CHEAT},
;381:	{ &cg_bobpitch, "cg_bobpitch", "0.002", CVAR_ARCHIVE},
;382:	{ &cg_bobroll, "cg_bobroll", "0.002", CVAR_ARCHIVE},
;383:	{ &cg_bobmodel, "cg_bobmodel", "0", CVAR_ARCHIVE}, // leilei
;384:	{ &cg_kickScale, "cg_kickScale", "1.0", CVAR_ARCHIVE},
;385:	{ &cg_swingSpeed, "cg_swingSpeed", "0.3", CVAR_CHEAT},
;386:	{ &cg_animSpeed, "cg_animspeed", "1", CVAR_CHEAT},
;387:	{ &cg_debugAnim, "cg_debuganim", "0", CVAR_CHEAT},
;388:	{ &cg_debugPosition, "cg_debugposition", "0", CVAR_CHEAT},
;389:	{ &cg_debugEvents, "cg_debugevents", "0", CVAR_CHEAT},
;390:	{ &cg_errorDecay, "cg_errordecay", "100", 0},
;391:	{ &cg_nopredict, "cg_nopredict", "0", 0},
;392:	{ &cg_noPlayerAnims, "cg_noplayeranims", "0", CVAR_CHEAT},
;393:	{ &cg_showmiss, "cg_showmiss", "0", 0},
;394:	{ &cg_footsteps, "cg_footsteps", "1", CVAR_CHEAT},
;395:	{ &cg_tracerChance, "cg_tracerchance", "0.4", CVAR_CHEAT},
;396:	{ &cg_tracerWidth, "cg_tracerwidth", "1", CVAR_CHEAT},
;397:	{ &cg_tracerLength, "cg_tracerlength", "100", CVAR_CHEAT},
;398:	{ &cg_thirdPersonRange, "cg_thirdPersonRange", "40", CVAR_CHEAT},
;399:	{ &cg_thirdPersonAngle, "cg_thirdPersonAngle", "0", CVAR_CHEAT},
;400:	{ &cg_thirdPerson, "cg_thirdPerson", "0", 0},
;401:	{ &cg_teamChatTime, "cg_teamChatTime", "3000", CVAR_ARCHIVE},
;402:	{ &cg_teamChatHeight, "cg_teamChatHeight", "0", CVAR_ARCHIVE},
;403:	{ &cg_forceModel, "cg_forceModel", "0", CVAR_ARCHIVE},
;404:	{ &cg_predictItems, "cg_predictItems", "1", CVAR_ARCHIVE},
;405:#ifdef MISSIONPACK
;406:	{ &cg_deferPlayers, "cg_deferPlayers", "0", CVAR_ARCHIVE},
;407:#else
;408:	{ &cg_deferPlayers, "cg_deferPlayers", "1", CVAR_ARCHIVE},
;409:#endif
;410:	{ &cg_drawTeamOverlay, "cg_drawTeamOverlay", "0", CVAR_ARCHIVE},
;411:	{ &cg_teamOverlayUserinfo, "teamoverlay", "0", CVAR_ROM | CVAR_USERINFO},
;412:	{ &cg_stats, "cg_stats", "0", 0},
;413:	{ &cg_drawFriend, "cg_drawFriend", "1", CVAR_ARCHIVE},
;414:	{ &cg_teamChatsOnly, "cg_teamChatsOnly", "0", CVAR_ARCHIVE},
;415:	{ &cg_noVoiceChats, "cg_noVoiceChats", "0", CVAR_ARCHIVE},
;416:	{ &cg_noVoiceText, "cg_noVoiceText", "0", CVAR_ARCHIVE},
;417:	// the following variables are created in other parts of the system,
;418:	// but we also reference them here
;419:	{ &cg_buildScript, "com_buildScript", "0", 0}, // force loading of all possible data amd error on failures
;420:	{ &cg_paused, "cl_paused", "0", CVAR_ROM},
;421:	{ &cg_blood, "com_blood", "1", CVAR_ARCHIVE},
;422:	{ &cg_alwaysWeaponBar, "cg_alwaysWeaponBar", "0", CVAR_ARCHIVE}, //Elimination
;423:	{ &cg_hitsound, "cg_hitsound", "0", CVAR_ARCHIVE},
;424:	{ &cg_voip_teamonly, "cg_voipTeamOnly", "1", CVAR_ARCHIVE},
;425:	{ &cg_voteflags, "cg_voteflags", "*", CVAR_ROM},
;426:	{ &cg_cyclegrapple, "cg_cyclegrapple", "1", CVAR_ARCHIVE},
;427:	{ &cg_vote_custom_commands, "cg_vote_custom_commands", "", CVAR_ROM},
;428:	{ &cg_synchronousClients, "g_synchronousClients", "0", CVAR_SYSTEMINFO}, // communicated by systeminfo
;429:
;430:	{ &cg_autovertex, "cg_autovertex", "0", CVAR_ARCHIVE},
;431:#ifdef MISSIONPACK
;432:	{ &cg_redTeamName, "g_redteam", DEFAULT_REDTEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO},
;433:	{ &cg_blueTeamName, "g_blueteam", DEFAULT_BLUETEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO},
;434:	{ &cg_currentSelectedPlayer, "cg_currentSelectedPlayer", "0", CVAR_ARCHIVE},
;435:	{ &cg_currentSelectedPlayerName, "cg_currentSelectedPlayerName", "", CVAR_ARCHIVE},
;436:	{ &cg_singlePlayer, "ui_singlePlayerActive", "0", CVAR_USERINFO},
;437:	{ &cg_singlePlayerActive, "ui_singlePlayerActive", "0", CVAR_USERINFO},
;438:	{ &cg_recordSPDemo, "ui_recordSPDemo", "0", CVAR_ARCHIVE},
;439:	{ &cg_recordSPDemoName, "ui_recordSPDemoName", "", CVAR_ARCHIVE},
;440:	{ &cg_hudFiles, "cg_hudFiles", "ui/hud.txt", CVAR_ARCHIVE},
;441:#endif
;442:	{ &cg_enableFS, "g_enableFS", "0", CVAR_SERVERINFO},
;443:	{ &cg_enableQ, "g_enableQ", "0", CVAR_SERVERINFO},
;444:	{ &cg_enableDust, "g_enableDust", "0", CVAR_SERVERINFO},
;445:	{ &cg_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO},
;446:	{ &cg_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO},
;447:
;448:	{ &cg_cameraOrbit, "cg_cameraOrbit", "0", CVAR_CHEAT},
;449:	{ &cg_cameraOrbitDelay, "cg_cameraOrbitDelay", "50", CVAR_ARCHIVE},
;450:	{ &cg_timescaleFadeEnd, "cg_timescaleFadeEnd", "1", 0},
;451:	{ &cg_timescaleFadeSpeed, "cg_timescaleFadeSpeed", "0", 0},
;452:	{ &cg_timescale, "timescale", "1", 0},
;453:	{ &cg_scorePlum, "cg_scorePlums", "1", CVAR_USERINFO | CVAR_ARCHIVE},
;454:	{ &cg_obituaryOutput, "cg_obituaryOutput", "3", CVAR_ARCHIVE},
;455:	//unlagged - smooth clients #2
;456:	// this is done server-side now
;457:	//	{ &cg_smoothClients, "cg_smoothClients", "0", CVAR_USERINFO | CVAR_ARCHIVE},
;458:	//unlagged - smooth clients #2
;459:	//	{ &cg_cameraMode, "com_cameraMode", "0", CVAR_CHEAT},
;460:
;461:	{ &pmove_fixed, "pmove_fixed", "0", CVAR_SYSTEMINFO},
;462:	{ &pmove_msec, "pmove_msec", "11", CVAR_SYSTEMINFO},
;463:	{ &pmove_float, "pmove_float", "1", CVAR_SYSTEMINFO},
;464:	{ &cg_noTaunt, "cg_noTaunt", "0", CVAR_ARCHIVE},
;465:	{ &cg_noProjectileTrail, "cg_noProjectileTrail", "0", CVAR_ARCHIVE},
;466:	{ &cg_smallFont, "ui_smallFont", "0.25", CVAR_ARCHIVE},
;467:	{ &cg_bigFont, "ui_bigFont", "0.4", CVAR_ARCHIVE},
;468:	{ &cg_oldRail, "cg_oldRail", "0", CVAR_ARCHIVE},
;469:	{ &cg_oldRocket, "cg_oldRocket", "1", CVAR_ARCHIVE},
;470:	{ &cg_leiEnhancement, "cg_leiEnhancement", "0", CVAR_ARCHIVE}, // LEILEI default off (in case of whiner)
;471:	{ &cg_leiGoreNoise, "cg_leiGoreNoise", "0", CVAR_ARCHIVE}, // LEILEI 
;472:	{ &cg_leiBrassNoise, "cg_leiBrassNoise", "0", CVAR_ARCHIVE}, // LEILEI 
;473:	{ &cg_leiSuperGoreyAwesome, "cg_leiSuperGoreyAwesome", "0", CVAR_ARCHIVE}, // LEILEI 
;474:	{ &cg_leiDebug, "cg_leiDebug", "0", CVAR_ARCHIVE}, // LEILEI 
;475:	{ &cg_leiChibi, "cg_leiChibi", "0", CVAR_CHEAT}, // LEILEI 
;476:	{ &cg_leiWidescreen, "cg_leiWidescreen", "1", CVAR_ARCHIVE}, // LEILEI 
;477:	{ &cg_deathcam, "cg_deathcam", "1", CVAR_ARCHIVE}, // LEILEI 
;478:	{ &cg_cameramode, "cg_cameramode", "0", CVAR_ARCHIVE}, // LEILEI 
;479:	{ &cg_cameraEyes, "cg_cameraEyes", "0", CVAR_ARCHIVE}, // LEILEI 
;480:	{ &cg_cameraEyes_Fwd, "cg_cameraEyes_Fwd", "3", CVAR_CHEAT}, // LEILEI 
;481:	{ &cg_cameraEyes_Up, "cg_cameraEyes_Up", "3", CVAR_CHEAT}, // LEILEI 
;482:
;483:	{ &cg_modelEyes_Up, "cg_modelEyes_Up", "3", CVAR_ARCHIVE}, // LEILEI 
;484:	{ &cg_modelEyes_Right, "cg_modelEyes_Right", "3", CVAR_ARCHIVE}, // LEILEI 
;485:	{ &cg_modelEyes_Fwd, "cg_modelEyes_Fwd", "3", CVAR_ARCHIVE}, // LEILEI 
;486:
;487:	{ &cg_oldPlasma, "cg_oldPlasma", "1", CVAR_ARCHIVE},
;488:	//unlagged - client options
;489:	{ &cg_delag, "cg_delag", "1", CVAR_ARCHIVE | CVAR_USERINFO},
;490:	//	{ &cg_debugDelag, "cg_debugDelag", "0", CVAR_USERINFO | CVAR_CHEAT },
;491:	//	{ &cg_drawBBox, "cg_drawBBox", "0", CVAR_CHEAT },
;492:	{ &cg_cmdTimeNudge, "cg_cmdTimeNudge", "0", CVAR_ARCHIVE | CVAR_USERINFO},
;493:	// this will be automagically copied from the server
;494:	{ &sv_fps, "sv_fps", "20", CVAR_SYSTEMINFO},
;495:	{ &cg_projectileNudge, "cg_projectileNudge", "0", CVAR_ARCHIVE},
;496:	{ &cg_optimizePrediction, "cg_optimizePrediction", "1", CVAR_ARCHIVE},
;497:	{ &cl_timeNudge, "cl_timeNudge", "0", CVAR_ARCHIVE},
;498:	//	{ &cg_latentSnaps, "cg_latentSnaps", "0", CVAR_USERINFO | CVAR_CHEAT },
;499:	//	{ &cg_latentCmds, "cg_latentCmds", "0", CVAR_USERINFO | CVAR_CHEAT },
;500:	//	{ &cg_plOut, "cg_plOut", "0", CVAR_USERINFO | CVAR_CHEAT },
;501:	//unlagged - client options
;502:	{ &cg_trueLightning, "cg_trueLightning", "0.0", CVAR_ARCHIVE},
;503:	{ &cg_music, "cg_music", "", CVAR_ARCHIVE},
;504:	//	{ &cg_pmove_fixed, "cg_pmove_fixed", "0", CVAR_USERINFO | CVAR_ARCHIVE }
;505:
;506:	{ &cg_fragmsgsize, "cg_fragmsgsize", "1.0", CVAR_ARCHIVE},
;507:	{ &cg_crosshairPulse, "cg_crosshairPulse", "1", CVAR_ARCHIVE},
;508:
;509:	{ &cg_differentCrosshairs, "cg_differentCrosshairs", "0", CVAR_ARCHIVE},
;510:	{ &cg_ch1, "cg_ch1", "1", CVAR_ARCHIVE},
;511:	{ &cg_ch1size, "cg_ch1size", "24", CVAR_ARCHIVE},
;512:	{ &cg_ch2, "cg_ch2", "1", CVAR_ARCHIVE},
;513:	{ &cg_ch2size, "cg_ch2size", "24", CVAR_ARCHIVE},
;514:	{ &cg_ch3, "cg_ch3", "1", CVAR_ARCHIVE},
;515:	{ &cg_ch3size, "cg_ch3size", "24", CVAR_ARCHIVE},
;516:	{ &cg_ch4, "cg_ch4", "1", CVAR_ARCHIVE},
;517:	{ &cg_ch4size, "cg_ch4size", "24", CVAR_ARCHIVE},
;518:	{ &cg_ch5, "cg_ch5", "1", CVAR_ARCHIVE},
;519:	{ &cg_ch5size, "cg_ch5size", "24", CVAR_ARCHIVE},
;520:	{ &cg_ch6, "cg_ch6", "1", CVAR_ARCHIVE},
;521:	{ &cg_ch6size, "cg_ch6size", "24", CVAR_ARCHIVE},
;522:	{ &cg_ch7, "cg_ch7", "1", CVAR_ARCHIVE},
;523:	{ &cg_ch7size, "cg_ch7size", "24", CVAR_ARCHIVE},
;524:	{ &cg_ch8, "cg_ch8", "1", CVAR_ARCHIVE},
;525:	{ &cg_ch8size, "cg_ch8size", "24", CVAR_ARCHIVE},
;526:	{ &cg_ch9, "cg_ch9", "1", CVAR_ARCHIVE},
;527:	{ &cg_ch9size, "cg_ch9size", "24", CVAR_ARCHIVE},
;528:	{ &cg_ch10, "cg_ch10", "1", CVAR_ARCHIVE},
;529:	{ &cg_ch10size, "cg_ch10size", "24", CVAR_ARCHIVE},
;530:	{ &cg_ch11, "cg_ch11", "1", CVAR_ARCHIVE},
;531:	{ &cg_ch11size, "cg_ch11size", "24", CVAR_ARCHIVE},
;532:	{ &cg_ch12, "cg_ch12", "1", CVAR_ARCHIVE},
;533:	{ &cg_ch12size, "cg_ch12size", "24", CVAR_ARCHIVE},
;534:	{ &cg_ch13, "cg_ch13", "1", CVAR_ARCHIVE},
;535:	{ &cg_ch13size, "cg_ch13size", "24", CVAR_ARCHIVE},
;536:
;537:	{ &cg_crosshairColorRed, "cg_crosshairColorRed", "1.0", CVAR_ARCHIVE},
;538:	{ &cg_crosshairColorGreen, "cg_crosshairColorGreen", "1.0", CVAR_ARCHIVE},
;539:	{ &cg_crosshairColorBlue, "cg_crosshairColorBlue", "1.0", CVAR_ARCHIVE},
;540:
;541:	{ &cg_weaponBarStyle, "cg_weaponBarStyle", "0", CVAR_ARCHIVE},
;542:	{ &cg_weaponOrder, "cg_weaponOrder", "/1/2/4/3/6/7/8/5/9/", CVAR_ARCHIVE},
;543:	{&cg_chatBeep, "cg_chatBeep", "1", CVAR_ARCHIVE},
;544:	{&cg_teamChatBeep, "cg_teamChatBeep", "1", CVAR_ARCHIVE},
;545:	{ &cg_muzzleflashStyle, "cg_muzzleflashStyle", "1", CVAR_ARCHIVE},
;546:/* Neon_Knight: Enables MP checks. */
;547:	{ &cg_missionpackChecks, "missionpackChecks", "1", CVAR_ARCHIVE},
;548:/* /Neon_Knight */
;549:/* Neon_Knight: Enables MP checks. */
;550:	{ &cg_developer, "developer", "0", CVAR_CHEAT}
;551:/* /Neon_Knight */
;552:};
;553:
;554:static int cvarTableSize = sizeof ( cvarTable) / sizeof ( cvarTable[0]);
;555:
;556:/*
;557:=================
;558:CG_RegisterCvars
;559:=================
;560: */
;561:void CG_RegisterCvars(void) {
line 566
;562:	int i;
;563:	cvarTable_t *cv;
;564:	char var[MAX_TOKEN_CHARS];
;565:
;566:	for (i = 0, cv = cvarTable; i < cvarTableSize; i++, cv++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $285
JUMPV
LABELV $282
line 567
;567:		trap_Cvar_Register(cv->vmCvar, cv->cvarName,
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 569
;568:				cv->defaultString, cv->cvarFlags);
;569:	}
LABELV $283
line 566
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $285
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $282
line 572
;570:
;571:	// see if we are also running the server on this machine
;572:	trap_Cvar_VariableStringBuffer("sv_running", var, sizeof ( var));
ADDRGP4 $286
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 573
;573:	cgs.localServer = atoi(var);
ADDRLP4 8
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31452
ADDRLP4 1032
INDIRI4
ASGNI4
line 575
;574:
;575:	forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 577
;576:
;577:	trap_Cvar_Register(NULL, "model", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE);
CNSTP4 0
ARGP4
ADDRGP4 $289
ARGP4
ADDRGP4 $290
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 578
;578:	trap_Cvar_Register(NULL, "headmodel", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE);
CNSTP4 0
ARGP4
ADDRGP4 $291
ARGP4
ADDRGP4 $290
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 580
;579:	/* Neon_Knight: Missionpack checks, if != 0, enables this. */
;580:	if (cg_missionpackChecks.integer) {
ADDRGP4 cg_missionpackChecks+12
INDIRI4
CNSTI4 0
EQI4 $292
line 581
;581:		trap_Cvar_Register(NULL, "team_model", DEFAULT_TEAM_MODEL, CVAR_USERINFO | CVAR_ARCHIVE);
CNSTP4 0
ARGP4
ADDRGP4 $295
ARGP4
ADDRGP4 $290
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 582
;582:		trap_Cvar_Register(NULL, "team_headmodel", DEFAULT_TEAM_HEAD, CVAR_USERINFO | CVAR_ARCHIVE);
CNSTP4 0
ARGP4
ADDRGP4 $296
ARGP4
ADDRGP4 $290
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 583
;583:	}
LABELV $292
line 584
;584:}
LABELV $281
endproc CG_RegisterCvars 1036 16
proc CG_ForceModelChange 12 4
line 591
;585:
;586:/*																																			
;587:===================
;588:CG_ForceModelChange
;589:===================
;590: */
;591:static void CG_ForceModelChange(void) {
line 594
;592:	int i;
;593:
;594:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $298
line 597
;595:		const char *clientInfo;
;596:
;597:		clientInfo = CG_ConfigString(CS_PLAYERS + i);
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 598
;598:		if (!clientInfo[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $302
line 599
;599:			continue;
ADDRGP4 $299
JUMPV
LABELV $302
line 601
;600:		}
;601:		CG_NewClientInfo(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 602
;602:	}
LABELV $299
line 594
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $298
line 603
;603:}
LABELV $297
endproc CG_ForceModelChange 12 4
export CG_UpdateCvars
proc CG_UpdateCvars 12 16
line 610
;604:
;605:/*
;606:=================
;607:CG_UpdateCvars
;608:=================
;609: */
;610:void CG_UpdateCvars(void) {
line 614
;611:	int i;
;612:	cvarTable_t *cv;
;613:
;614:	for (i = 0, cv = cvarTable; i < cvarTableSize; i++, cv++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $308
JUMPV
LABELV $305
line 619
;615:		//unlagged - client options
;616:		// clamp the value between 0 and 999
;617:		// negative values would suck - people could conceivably shoot other
;618:		// players *long* after they had left the area, on purpose
;619:		if (cv->vmCvar == &cg_cmdTimeNudge) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 cg_cmdTimeNudge
CVPU4 4
NEU4 $309
line 620
;620:			CG_Cvar_ClampInt(cv->cvarName, cv->vmCvar, 0, 999);
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 999
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 621
;621:		}			// cl_timenudge less than -50 or greater than 50 doesn't actually
ADDRGP4 $310
JUMPV
LABELV $309
line 625
;622:			// do anything more than -50 or 50 (actually the numbers are probably
;623:			// closer to -30 and 30, but 50 is nice and round-ish)
;624:			// might as well not feed the myth, eh?
;625:		else if (cv->vmCvar == &cl_timeNudge) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 cl_timeNudge
CVPU4 4
NEU4 $311
line 626
;626:			CG_Cvar_ClampInt(cv->cvarName, cv->vmCvar, -50, 50);
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
CNSTI4 -50
ARGI4
CNSTI4 50
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 627
;627:		}			// don't let this go too high - no point
ADDRGP4 $312
JUMPV
LABELV $311
line 640
;628:			/*else if ( cv->vmCvar == &cg_latentSnaps ) {
;629:				CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, 0, 10 );
;630:			}*/
;631:			// don't let this get too large
;632:			/*else if ( cv->vmCvar == &cg_latentCmds ) {
;633:				CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, 0, MAX_LATENT_CMDS - 1 );
;634:			}*/
;635:			// no more than 100% packet loss
;636:			/*else if ( cv->vmCvar == &cg_plOut ) {
;637:				CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, 0, 100 );
;638:			}*/
;639:			//unlagged - client options
;640:		else if (cv->vmCvar == &cg_errorDecay) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 cg_errorDecay
CVPU4 4
NEU4 $313
line 641
;641:			CG_Cvar_ClampInt(cv->cvarName, cv->vmCvar, 0, 250);
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 250
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 642
;642:		}
LABELV $313
LABELV $312
LABELV $310
line 643
;643:		trap_Cvar_Update(cv->vmCvar);
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 644
;644:	}
LABELV $306
line 614
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $308
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $305
line 650
;645:
;646:	// check for modications here
;647:
;648:	// If team overlay is on, ask for updates from the server.  If its off,
;649:	// let the server know so we don't receive it
;650:	if (drawTeamOverlayModificationCount != cg_drawTeamOverlay.modificationCount) {
ADDRGP4 drawTeamOverlayModificationCount
INDIRI4
ADDRGP4 cg_drawTeamOverlay+4
INDIRI4
EQI4 $315
line 651
;651:		drawTeamOverlayModificationCount = cg_drawTeamOverlay.modificationCount;
ADDRGP4 drawTeamOverlayModificationCount
ADDRGP4 cg_drawTeamOverlay+4
INDIRI4
ASGNI4
line 653
;652:
;653:		if (cg_drawTeamOverlay.integer > 0) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
LEI4 $319
line 654
;654:			trap_Cvar_Set("teamoverlay", "1");
ADDRGP4 $171
ARGP4
ADDRGP4 $92
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 655
;655:		} else {
ADDRGP4 $320
JUMPV
LABELV $319
line 656
;656:			trap_Cvar_Set("teamoverlay", "0");
ADDRGP4 $171
ARGP4
ADDRGP4 $90
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 657
;657:		}
LABELV $320
line 658
;658:	}
LABELV $315
line 661
;659:
;660:	// if force model changed
;661:	if (forceModelModificationCount != cg_forceModel.modificationCount) {
ADDRGP4 forceModelModificationCount
INDIRI4
ADDRGP4 cg_forceModel+4
INDIRI4
EQI4 $322
line 662
;662:		forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 663
;663:		CG_ForceModelChange();
ADDRGP4 CG_ForceModelChange
CALLV
pop
line 664
;664:	}
LABELV $322
line 665
;665:}
LABELV $304
endproc CG_UpdateCvars 12 16
export CG_CrosshairPlayer
proc CG_CrosshairPlayer 0 0
line 667
;666:
;667:int CG_CrosshairPlayer(void) {
line 668
;668:	if (cg.time > (cg.crosshairClientTime + 1000)) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124996
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $327
line 669
;669:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $326
JUMPV
LABELV $327
line 671
;670:	}
;671:	return cg.crosshairClientNum;
ADDRGP4 cg+124992
INDIRI4
RETI4
LABELV $326
endproc CG_CrosshairPlayer 0 0
export CG_LastAttacker
proc CG_LastAttacker 0 0
line 674
;672:}
;673:
;674:int CG_LastAttacker(void) {
line 675
;675:	if (!cg.attackerTime) {
ADDRGP4 cg+125008
INDIRI4
CNSTI4 0
NEI4 $333
line 676
;676:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $332
JUMPV
LABELV $333
line 678
;677:	}
;678:	return cg.snap->ps.persistant[PERS_ATTACKER];
ADDRGP4 cg+36
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
RETI4
LABELV $332
endproc CG_LastAttacker 0 0
export CG_Printf
proc CG_Printf 1028 16
line 681
;679:}
;680:
;681:void QDECL CG_Printf(const char *msg, ...) {
line 685
;682:	va_list argptr;
;683:	char text[1024];
;684:
;685:	va_start(argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 686
;686:	Q_vsnprintf(text, sizeof (text), msg, argptr);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_vsnprintf
CALLI4
pop
line 687
;687:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 689
;688:
;689:	trap_Print(text);
ADDRLP4 4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 690
;690:}
LABELV $337
endproc CG_Printf 1028 16
export CG_Error
proc CG_Error 1028 16
line 692
;691:
;692:void QDECL CG_Error(const char *msg, ...) {
line 696
;693:	va_list argptr;
;694:	char text[1024];
;695:
;696:	va_start(argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 697
;697:	Q_vsnprintf(text, sizeof (text), msg, argptr);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_vsnprintf
CALLI4
pop
line 698
;698:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 700
;699:
;700:	trap_Error(text);
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 701
;701:}
LABELV $339
endproc CG_Error 1028 16
export Com_Error
proc Com_Error 1028 16
line 703
;702:
;703:void QDECL Com_Error(int level, const char *error, ...) {
line 707
;704:	va_list argptr;
;705:	char text[1024];
;706:
;707:	va_start(argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 708
;708:	Q_vsnprintf(text, sizeof (text), error, argptr);
ADDRLP4 4
ARGP4
CNSTI4 1024
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
line 709
;709:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 711
;710:
;711:	CG_Error("%s", text);
ADDRGP4 $343
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 712
;712:}
LABELV $341
endproc Com_Error 1028 16
export Com_Printf
proc Com_Printf 1028 16
line 714
;713:
;714:void QDECL Com_Printf(const char *msg, ...) {
line 718
;715:	va_list argptr;
;716:	char text[1024];
;717:
;718:	va_start(argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 719
;719:	Q_vsnprintf(text, sizeof (text), msg, argptr);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_vsnprintf
CALLI4
pop
line 720
;720:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 722
;721:
;722:	CG_Printf("%s", text);
ADDRGP4 $343
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 723
;723:}
LABELV $344
endproc Com_Printf 1028 16
bss
align 1
LABELV $347
skip 1024
export CG_Argv
code
proc CG_Argv 0 12
line 730
;724:
;725:/*
;726:================
;727:CG_Argv
;728:================
;729: */
;730:const char *CG_Argv(int arg) {
line 733
;731:	static char buffer[MAX_STRING_CHARS];
;732:
;733:	trap_Argv(arg, buffer, sizeof ( buffer));
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $347
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 735
;734:
;735:	return buffer;
ADDRGP4 $347
RETP4
LABELV $346
endproc CG_Argv 0 12
proc CG_RegisterItemSounds 96 12
line 748
;736:}
;737:
;738:
;739://========================================================================
;740:
;741:/*
;742:=================
;743:CG_RegisterItemSounds
;744:
;745:The server says this item is used on this level
;746:=================
;747: */
;748:static void CG_RegisterItemSounds(int itemNum) {
line 754
;749:	gitem_t *item;
;750:	char data[MAX_QPATH];
;751:	char *s, *start;
;752:	int len;
;753:
;754:	item = &bg_itemlist[ itemNum ];
ADDRLP4 76
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 756
;755:
;756:	if (item->pickup_sound) {
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $349
line 757
;757:		trap_S_RegisterSound(item->pickup_sound, qfalse);
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 758
;758:	}
LABELV $349
line 761
;759:
;760:	// parse the space seperated precache string for other media
;761:	s = item->sounds;
ADDRLP4 0
ADDRLP4 76
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
ASGNP4
line 762
;762:	if (!s || !s[0])
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $353
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $355
LABELV $353
line 763
;763:		return;
ADDRGP4 $348
JUMPV
LABELV $354
line 765
;764:
;765:	while (*s) {
line 766
;766:		start = s;
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $358
JUMPV
LABELV $357
line 767
;767:		while (*s && *s != ' ') {
line 768
;768:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 769
;769:		}
LABELV $358
line 767
ADDRLP4 84
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $360
ADDRLP4 84
INDIRI4
CNSTI4 32
NEI4 $357
LABELV $360
line 771
;770:
;771:		len = s - start;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 772
;772:		if (len >= MAX_QPATH || len < 5) {
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $363
ADDRLP4 4
INDIRI4
CNSTI4 5
GEI4 $361
LABELV $363
line 773
;773:			CG_Error("PrecacheItem: %s has bad precache string",
ADDRGP4 $364
ARGP4
ADDRLP4 76
INDIRP4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 775
;774:					item->classname);
;775:			return;
ADDRGP4 $348
JUMPV
LABELV $361
line 777
;776:		}
;777:		memcpy(data, start, len);
ADDRLP4 8
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 778
;778:		data[len] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 779
;779:		if (*s) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $365
line 780
;780:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 781
;781:		}
LABELV $365
line 783
;782:
;783:		if (strequals(data + len - 3, "wav")) {
ADDRLP4 4
INDIRI4
ADDRLP4 8-3
ADDP4
ARGP4
ADDRGP4 $370
ARGP4
ADDRLP4 92
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $367
line 784
;784:			trap_S_RegisterSound(data, qfalse);
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 785
;785:		}
LABELV $367
line 786
;786:	}
LABELV $355
line 765
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $354
line 787
;787:}
LABELV $348
endproc CG_RegisterItemSounds 96 12
proc CG_RegisterSounds 724 16
line 796
;788:
;789:/*
;790:=================
;791:CG_RegisterSounds
;792:
;793:called during a precache command
;794:=================
;795: */
;796:static void CG_RegisterSounds(void) {
line 807
;797:	int i;
;798:	char items[MAX_ITEMS + 1];
;799:	char name[MAX_QPATH];
;800:	const char *soundName;
;801:
;802:	// voice commands
;803:#ifdef MISSIONPACK
;804:	CG_LoadVoiceChats();
;805:#endif
;806:
;807:	cgs.media.oneMinuteSound = trap_S_RegisterSound("sound/feedback/1_minute.wav", qtrue);
ADDRGP4 $374
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 332
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1144
ADDRLP4 332
INDIRI4
ASGNI4
line 808
;808:	cgs.media.fiveMinuteSound = trap_S_RegisterSound("sound/feedback/5_minute.wav", qtrue);
ADDRGP4 $377
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 336
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1148
ADDRLP4 336
INDIRI4
ASGNI4
line 809
;809:	cgs.media.suddenDeathSound = trap_S_RegisterSound("sound/feedback/sudden_death.wav", qtrue);
ADDRGP4 $380
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 340
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1152
ADDRLP4 340
INDIRI4
ASGNI4
line 810
;810:	cgs.media.oneFragSound = trap_S_RegisterSound("sound/feedback/1_frag.wav", qtrue);
ADDRGP4 $383
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 344
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1164
ADDRLP4 344
INDIRI4
ASGNI4
line 811
;811:	cgs.media.twoFragSound = trap_S_RegisterSound("sound/feedback/2_frags.wav", qtrue);
ADDRGP4 $386
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 348
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1160
ADDRLP4 348
INDIRI4
ASGNI4
line 812
;812:	cgs.media.threeFragSound = trap_S_RegisterSound("sound/feedback/3_frags.wav", qtrue);
ADDRGP4 $389
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 352
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1156
ADDRLP4 352
INDIRI4
ASGNI4
line 813
;813:	cgs.media.count3Sound = trap_S_RegisterSound("sound/feedback/three.wav", qtrue);
ADDRGP4 $392
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1356
ADDRLP4 356
INDIRI4
ASGNI4
line 814
;814:	cgs.media.count2Sound = trap_S_RegisterSound("sound/feedback/two.wav", qtrue);
ADDRGP4 $395
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 360
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1360
ADDRLP4 360
INDIRI4
ASGNI4
line 815
;815:	cgs.media.count1Sound = trap_S_RegisterSound("sound/feedback/one.wav", qtrue);
ADDRGP4 $398
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 364
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1364
ADDRLP4 364
INDIRI4
ASGNI4
line 816
;816:	cgs.media.countFightSound = trap_S_RegisterSound("sound/feedback/fight.wav", qtrue);
ADDRGP4 $401
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 368
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1368
ADDRLP4 368
INDIRI4
ASGNI4
line 817
;817:	cgs.media.countPrepareSound = trap_S_RegisterSound("sound/feedback/prepare.wav", qtrue);
ADDRGP4 $404
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 372
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1372
ADDRLP4 372
INDIRI4
ASGNI4
line 832
;818:#ifdef MISSIONPACK
;819:	cgs.media.countPrepareTeamSound = trap_S_RegisterSound("sound/feedback/prepare_team.wav", qtrue);
;820:#endif
;821:
;822:	// loadingscreen
;823:#ifdef SCRIPTHUD
;824:	CG_UpdateSoundFraction(0.33f);
;825:	CG_UpdateMediaFraction(0.20f);
;826:#endif
;827:	// end loadingscreen
;828:
;829:	// N_G: Another condition that makes no sense to me, see for
;830:	// yourself if you really meant this
;831:	// Sago: Makes perfect sense: Load team game stuff if the gametype is a teamgame and not an exception (like GT_LMS)
;832:	if (CG_IsATeamGametype(cgs.gametype) || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 376
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 380
CNSTI4 0
ASGNI4
ADDRLP4 376
INDIRI4
ADDRLP4 380
INDIRI4
NEI4 $409
ADDRGP4 cg_buildScript+12
INDIRI4
ADDRLP4 380
INDIRI4
EQI4 $405
LABELV $409
line 834
;833:
;834:		cgs.media.captureAwardSound = trap_S_RegisterSound("sound/teamplay/flagcapture_yourteam.wav", qtrue);
ADDRGP4 $412
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1268
ADDRLP4 384
INDIRI4
ASGNI4
line 835
;835:		cgs.media.redLeadsSound = trap_S_RegisterSound("sound/feedback/redleads.wav", qtrue);
ADDRGP4 $415
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1280
ADDRLP4 388
INDIRI4
ASGNI4
line 836
;836:		cgs.media.blueLeadsSound = trap_S_RegisterSound("sound/feedback/blueleads.wav", qtrue);
ADDRGP4 $418
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1284
ADDRLP4 392
INDIRI4
ASGNI4
line 837
;837:		cgs.media.teamsTiedSound = trap_S_RegisterSound("sound/feedback/teamstied.wav", qtrue);
ADDRGP4 $421
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1288
ADDRLP4 396
INDIRI4
ASGNI4
line 838
;838:		cgs.media.hitTeamSound = trap_S_RegisterSound("sound/feedback/hit_teammate.wav", qtrue);
ADDRGP4 $424
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1180
ADDRLP4 400
INDIRI4
ASGNI4
line 840
;839:
;840:		cgs.media.redScoredSound = trap_S_RegisterSound("sound/teamplay/voc_red_scores.wav", qtrue);
ADDRGP4 $427
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1272
ADDRLP4 404
INDIRI4
ASGNI4
line 841
;841:		cgs.media.blueScoredSound = trap_S_RegisterSound("sound/teamplay/voc_blue_scores.wav", qtrue);
ADDRGP4 $430
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1276
ADDRLP4 408
INDIRI4
ASGNI4
line 843
;842:
;843:		cgs.media.captureYourTeamSound = trap_S_RegisterSound("sound/teamplay/flagcapture_yourteam.wav", qtrue);
ADDRGP4 $412
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1292
ADDRLP4 412
INDIRI4
ASGNI4
line 844
;844:		cgs.media.captureOpponentSound = trap_S_RegisterSound("sound/teamplay/flagcapture_opponent.wav", qtrue);
ADDRGP4 $435
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1296
ADDRLP4 416
INDIRI4
ASGNI4
line 846
;845:
;846:		cgs.media.returnYourTeamSound = trap_S_RegisterSound("sound/teamplay/flagreturn_yourteam.wav", qtrue);
ADDRGP4 $438
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1300
ADDRLP4 420
INDIRI4
ASGNI4
line 847
;847:		cgs.media.returnOpponentSound = trap_S_RegisterSound("sound/teamplay/flagreturn_opponent.wav", qtrue);
ADDRGP4 $441
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1304
ADDRLP4 424
INDIRI4
ASGNI4
line 849
;848:
;849:		cgs.media.takenYourTeamSound = trap_S_RegisterSound("sound/teamplay/flagtaken_yourteam.wav", qtrue);
ADDRGP4 $444
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1308
ADDRLP4 428
INDIRI4
ASGNI4
line 850
;850:		cgs.media.takenOpponentSound = trap_S_RegisterSound("sound/teamplay/flagtaken_opponent.wav", qtrue);
ADDRGP4 $447
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1312
ADDRLP4 432
INDIRI4
ASGNI4
line 852
;851:
;852:		if ((CG_UsesTeamFlags(cgs.gametype) && !CG_UsesTheWhiteFlag(cgs.gametype)) || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 436
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 436
INDIRI4
CNSTI4 0
EQI4 $454
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 440
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 440
INDIRI4
CNSTI4 0
EQI4 $453
LABELV $454
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $448
LABELV $453
line 853
;853:			cgs.media.redFlagReturnedSound = trap_S_RegisterSound("sound/teamplay/voc_red_returned.wav", qtrue);
ADDRGP4 $457
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1316
ADDRLP4 444
INDIRI4
ASGNI4
line 854
;854:			cgs.media.blueFlagReturnedSound = trap_S_RegisterSound("sound/teamplay/voc_blue_returned.wav", qtrue);
ADDRGP4 $460
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1320
ADDRLP4 448
INDIRI4
ASGNI4
line 855
;855:			cgs.media.enemyTookYourFlagSound = trap_S_RegisterSound("sound/teamplay/voc_enemy_flag.wav", qtrue);
ADDRGP4 $463
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 452
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1328
ADDRLP4 452
INDIRI4
ASGNI4
line 856
;856:			cgs.media.yourTeamTookEnemyFlagSound = trap_S_RegisterSound("sound/teamplay/voc_team_flag.wav", qtrue);
ADDRGP4 $466
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 456
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1336
ADDRLP4 456
INDIRI4
ASGNI4
line 857
;857:		}
LABELV $448
line 859
;858:
;859:		if (CG_UsesTheWhiteFlag(cgs.gametype) || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 444
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 448
CNSTI4 0
ASGNI4
ADDRLP4 444
INDIRI4
ADDRLP4 448
INDIRI4
NEI4 $471
ADDRGP4 cg_buildScript+12
INDIRI4
ADDRLP4 448
INDIRI4
EQI4 $467
LABELV $471
line 861
;860:			// FIXME: get a replacement for this sound ?
;861:			cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound("sound/teamplay/flagreturn_opponent.wav", qtrue);
ADDRGP4 $441
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 452
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1324
ADDRLP4 452
INDIRI4
ASGNI4
line 862
;862:			cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound("sound/teamplay/voc_team_1flag.wav", qtrue);
ADDRGP4 $476
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 456
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1340
ADDRLP4 456
INDIRI4
ASGNI4
line 863
;863:			cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound("sound/teamplay/voc_enemy_1flag.wav", qtrue);
ADDRGP4 $479
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 460
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1332
ADDRLP4 460
INDIRI4
ASGNI4
line 864
;864:		}
LABELV $467
line 866
;865:
;866:		if (cgs.gametype == GT_OBELISK || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 6
EQI4 $484
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $480
LABELV $484
line 867
;867:			cgs.media.yourBaseIsUnderAttackSound = trap_S_RegisterSound("sound/teamplay/voc_base_attack.wav", qtrue);
ADDRGP4 $487
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 452
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1348
ADDRLP4 452
INDIRI4
ASGNI4
line 874
;868:			// loadingscreen
;869:#ifdef SCRIPTHUD
;870:			CG_UpdateSoundFraction(0.60f);
;871:			CG_UpdateMediaFraction(0.30f);
;872:#endif
;873:			// end loadingscreen
;874:		}
LABELV $480
line 875
;875:	}
LABELV $405
line 878
;876:
;877:
;878:	if (CG_UsesTeamFlags(cgs.gametype) || CG_UsesTheWhiteFlag(cgs.gametype) || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 384
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
NEI4 $494
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 388
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 392
CNSTI4 0
ASGNI4
ADDRLP4 388
INDIRI4
ADDRLP4 392
INDIRI4
NEI4 $494
ADDRGP4 cg_buildScript+12
INDIRI4
ADDRLP4 392
INDIRI4
EQI4 $488
LABELV $494
line 879
;879:		cgs.media.youHaveFlagSound = trap_S_RegisterSound("sound/teamplay/voc_you_flag.wav", qtrue);
ADDRGP4 $497
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1344
ADDRLP4 396
INDIRI4
ASGNI4
line 880
;880:		cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
ADDRGP4 $500
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1352
ADDRLP4 400
INDIRI4
ASGNI4
line 881
;881:	}
LABELV $488
line 883
;882:
;883:	cgs.media.tracerSound = trap_S_RegisterSound("sound/weapons/machinegun/buletby1.wav", qfalse);
ADDRGP4 $503
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+808
ADDRLP4 396
INDIRI4
ASGNI4
line 884
;884:	cgs.media.selectSound = trap_S_RegisterSound("sound/weapons/change.wav", qfalse);
ADDRGP4 $506
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+812
ADDRLP4 400
INDIRI4
ASGNI4
line 885
;885:	cgs.media.wearOffSound = trap_S_RegisterSound("sound/items/wearoff.wav", qfalse);
ADDRGP4 $509
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+820
ADDRLP4 404
INDIRI4
ASGNI4
line 886
;886:	cgs.media.useNothingSound = trap_S_RegisterSound("sound/items/use_nothing.wav", qfalse);
ADDRGP4 $512
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+816
ADDRLP4 408
INDIRI4
ASGNI4
line 887
;887:	cgs.media.gibSound = trap_S_RegisterSound("sound/player/gibsplt1.wav", qfalse);
ADDRGP4 $515
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1060
ADDRLP4 412
INDIRI4
ASGNI4
line 888
;888:	cgs.media.gibBounce1Sound = trap_S_RegisterSound("sound/player/gibimp1.wav", qfalse);
ADDRGP4 $518
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1064
ADDRLP4 416
INDIRI4
ASGNI4
line 889
;889:	cgs.media.gibBounce2Sound = trap_S_RegisterSound("sound/player/gibimp2.wav", qfalse);
ADDRGP4 $521
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1068
ADDRLP4 420
INDIRI4
ASGNI4
line 890
;890:	cgs.media.gibBounce3Sound = trap_S_RegisterSound("sound/player/gibimp3.wav", qfalse);
ADDRGP4 $524
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1072
ADDRLP4 424
INDIRI4
ASGNI4
line 895
;891:
;892:
;893:	// LEILEI
;894:
;895:	cgs.media.lspl1Sound = trap_S_RegisterSound("sound/le/splat1.wav", qfalse);
ADDRGP4 $527
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1108
ADDRLP4 428
INDIRI4
ASGNI4
line 896
;896:	cgs.media.lspl2Sound = trap_S_RegisterSound("sound/le/splat2.wav", qfalse);
ADDRGP4 $530
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1112
ADDRLP4 432
INDIRI4
ASGNI4
line 897
;897:	cgs.media.lspl3Sound = trap_S_RegisterSound("sound/le/splat3.wav", qfalse);
ADDRGP4 $533
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1116
ADDRLP4 436
INDIRI4
ASGNI4
line 899
;898:
;899:	cgs.media.lbul1Sound = trap_S_RegisterSound("sound/le/bullet1.wav", qfalse);
ADDRGP4 $536
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1120
ADDRLP4 440
INDIRI4
ASGNI4
line 900
;900:	cgs.media.lbul2Sound = trap_S_RegisterSound("sound/le/bullet2.wav", qfalse);
ADDRGP4 $539
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1124
ADDRLP4 444
INDIRI4
ASGNI4
line 901
;901:	cgs.media.lbul3Sound = trap_S_RegisterSound("sound/le/bullet3.wav", qfalse);
ADDRGP4 $542
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1128
ADDRLP4 448
INDIRI4
ASGNI4
line 903
;902:
;903:	cgs.media.lshl1Sound = trap_S_RegisterSound("sound/le/shell1.wav", qfalse);
ADDRGP4 $545
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 452
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1132
ADDRLP4 452
INDIRI4
ASGNI4
line 904
;904:	cgs.media.lshl2Sound = trap_S_RegisterSound("sound/le/shell2.wav", qfalse);
ADDRGP4 $548
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 456
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1136
ADDRLP4 456
INDIRI4
ASGNI4
line 905
;905:	cgs.media.lshl3Sound = trap_S_RegisterSound("sound/le/shell3.wav", qfalse);
ADDRGP4 $551
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 460
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1140
ADDRLP4 460
INDIRI4
ASGNI4
line 907
;906:
;907:	cgs.media.useInvulnerabilitySound = trap_S_RegisterSound("sound/items/invul_activate.wav", qfalse);
ADDRGP4 $554
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 464
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1012
ADDRLP4 464
INDIRI4
ASGNI4
line 908
;908:	cgs.media.invulnerabilityImpactSound1 = trap_S_RegisterSound("sound/items/invul_impact_01.wav", qfalse);
ADDRGP4 $557
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 468
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1016
ADDRLP4 468
INDIRI4
ASGNI4
line 909
;909:	cgs.media.invulnerabilityImpactSound2 = trap_S_RegisterSound("sound/items/invul_impact_02.wav", qfalse);
ADDRGP4 $560
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 472
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1020
ADDRLP4 472
INDIRI4
ASGNI4
line 910
;910:	cgs.media.invulnerabilityImpactSound3 = trap_S_RegisterSound("sound/items/invul_impact_03.wav", qfalse);
ADDRGP4 $563
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 476
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1024
ADDRLP4 476
INDIRI4
ASGNI4
line 911
;911:	cgs.media.invulnerabilityJuicedSound = trap_S_RegisterSound("sound/items/invul_juiced.wav", qfalse);
ADDRGP4 $566
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 480
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1028
ADDRLP4 480
INDIRI4
ASGNI4
line 913
;912:
;913:	cgs.media.ammoregenSound = trap_S_RegisterSound("sound/items/cl_ammoregen.wav", qfalse);
ADDRGP4 $569
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 484
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1376
ADDRLP4 484
INDIRI4
ASGNI4
line 914
;914:	cgs.media.doublerSound = trap_S_RegisterSound("sound/items/cl_doubler.wav", qfalse);
ADDRGP4 $572
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 488
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1380
ADDRLP4 488
INDIRI4
ASGNI4
line 915
;915:	cgs.media.guardSound = trap_S_RegisterSound("sound/items/cl_guard.wav", qfalse);
ADDRGP4 $575
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 492
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1384
ADDRLP4 492
INDIRI4
ASGNI4
line 916
;916:	cgs.media.scoutSound = trap_S_RegisterSound("sound/items/cl_scout.wav", qfalse);
ADDRGP4 $578
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 496
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1388
ADDRLP4 496
INDIRI4
ASGNI4
line 917
;917:	cgs.media.obeliskHitSound1 = trap_S_RegisterSound("sound/items/obelisk_hit_01.wav", qfalse);
ADDRGP4 $581
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 500
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1032
ADDRLP4 500
INDIRI4
ASGNI4
line 918
;918:	cgs.media.obeliskHitSound2 = trap_S_RegisterSound("sound/items/obelisk_hit_02.wav", qfalse);
ADDRGP4 $584
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 504
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1036
ADDRLP4 504
INDIRI4
ASGNI4
line 919
;919:	cgs.media.obeliskHitSound3 = trap_S_RegisterSound("sound/items/obelisk_hit_03.wav", qfalse);
ADDRGP4 $587
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 508
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1040
ADDRLP4 508
INDIRI4
ASGNI4
line 920
;920:	cgs.media.obeliskRespawnSound = trap_S_RegisterSound("sound/items/obelisk_respawn.wav", qfalse);
ADDRGP4 $590
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 512
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1044
ADDRLP4 512
INDIRI4
ASGNI4
line 922
;921:
;922:	cgs.media.teleInSound = trap_S_RegisterSound("sound/world/telein.wav", qfalse);
ADDRGP4 $593
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 516
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1076
ADDRLP4 516
INDIRI4
ASGNI4
line 923
;923:	cgs.media.teleOutSound = trap_S_RegisterSound("sound/world/teleout.wav", qfalse);
ADDRGP4 $596
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 520
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1080
ADDRLP4 520
INDIRI4
ASGNI4
line 924
;924:	cgs.media.respawnSound = trap_S_RegisterSound("sound/items/respawn1.wav", qfalse);
ADDRGP4 $599
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 524
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1088
ADDRLP4 524
INDIRI4
ASGNI4
line 926
;925:
;926:	cgs.media.noAmmoSound = trap_S_RegisterSound("sound/weapons/noammo.wav", qfalse);
ADDRGP4 $602
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 528
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1084
ADDRLP4 528
INDIRI4
ASGNI4
line 928
;927:
;928:	cgs.media.talkSound = trap_S_RegisterSound("sound/player/talk.wav", qfalse);
ADDRGP4 $605
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 532
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1092
ADDRLP4 532
INDIRI4
ASGNI4
line 929
;929:	cgs.media.landSound = trap_S_RegisterSound("sound/player/land1.wav", qfalse);
ADDRGP4 $608
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 536
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1096
ADDRLP4 536
INDIRI4
ASGNI4
line 931
;930:
;931:	switch (cg_hitsound.integer) {
ADDRGP4 cg_hitsound+12
INDIRI4
CNSTI4 0
EQI4 $612
ADDRGP4 $609
JUMPV
LABELV $612
LABELV $609
line 935
;932:
;933:		case 0:
;934:		default:
;935:			cgs.media.hitSound = trap_S_RegisterSound("sound/feedback/hit.wav", qfalse);
ADDRGP4 $615
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 540
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1168
ADDRLP4 540
INDIRI4
ASGNI4
line 936
;936:	};
line 943
;937:
;938:#ifdef MISSIONPACK
;939:	cgs.media.hitSoundHighArmor = trap_S_RegisterSound("sound/feedback/hithi.wav", qfalse);
;940:	cgs.media.hitSoundLowArmor = trap_S_RegisterSound("sound/feedback/hitlo.wav", qfalse);
;941:#endif
;942:
;943:	cgs.media.impressiveSound = trap_S_RegisterSound("sound/feedback/impressive.wav", qtrue);
ADDRGP4 $618
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 540
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1184
ADDRLP4 540
INDIRI4
ASGNI4
line 944
;944:	cgs.media.excellentSound = trap_S_RegisterSound("sound/feedback/excellent.wav", qtrue);
ADDRGP4 $621
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 544
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1188
ADDRLP4 544
INDIRI4
ASGNI4
line 945
;945:	cgs.media.deniedSound = trap_S_RegisterSound("sound/feedback/denied.wav", qtrue);
ADDRGP4 $624
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 548
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1192
ADDRLP4 548
INDIRI4
ASGNI4
line 946
;946:	cgs.media.humiliationSound = trap_S_RegisterSound("sound/feedback/humiliation.wav", qtrue);
ADDRGP4 $627
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 552
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1196
ADDRLP4 552
INDIRI4
ASGNI4
line 947
;947:	cgs.media.assistSound = trap_S_RegisterSound("sound/feedback/assist.wav", qtrue);
ADDRGP4 $630
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 556
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1200
ADDRLP4 556
INDIRI4
ASGNI4
line 948
;948:	cgs.media.defendSound = trap_S_RegisterSound("sound/feedback/defense.wav", qtrue);
ADDRGP4 $633
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 560
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1204
ADDRLP4 560
INDIRI4
ASGNI4
line 955
;949:#ifdef MISSIONPACK
;950:	cgs.media.firstImpressiveSound = trap_S_RegisterSound("sound/feedback/first_impressive.wav", qtrue);
;951:	cgs.media.firstExcellentSound = trap_S_RegisterSound("sound/feedback/first_excellent.wav", qtrue);
;952:	cgs.media.firstHumiliationSound = trap_S_RegisterSound("sound/feedback/first_gauntlet.wav", qtrue);
;953:#endif
;954:
;955:	cgs.media.takenLeadSound = trap_S_RegisterSound("sound/feedback/takenlead.wav", qtrue);
ADDRGP4 $636
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 564
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1220
ADDRLP4 564
INDIRI4
ASGNI4
line 956
;956:	cgs.media.tiedLeadSound = trap_S_RegisterSound("sound/feedback/tiedlead.wav", qtrue);
ADDRGP4 $639
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 568
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1224
ADDRLP4 568
INDIRI4
ASGNI4
line 957
;957:	cgs.media.lostLeadSound = trap_S_RegisterSound("sound/feedback/lostlead.wav", qtrue);
ADDRGP4 $642
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 572
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1228
ADDRLP4 572
INDIRI4
ASGNI4
line 965
;958:
;959:#ifdef MISSIONPACK
;960:	cgs.media.voteNow = trap_S_RegisterSound("sound/feedback/vote_now.wav", qtrue);
;961:	cgs.media.votePassed = trap_S_RegisterSound("sound/feedback/vote_passed.wav", qtrue);
;962:	cgs.media.voteFailed = trap_S_RegisterSound("sound/feedback/vote_failed.wav", qtrue);
;963:#endif
;964:
;965:	cgs.media.watrInSound = trap_S_RegisterSound("sound/player/watr_in.wav", qfalse);
ADDRGP4 $645
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 576
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1244
ADDRLP4 576
INDIRI4
ASGNI4
line 966
;966:	cgs.media.watrOutSound = trap_S_RegisterSound("sound/player/watr_out.wav", qfalse);
ADDRGP4 $648
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 580
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1248
ADDRLP4 580
INDIRI4
ASGNI4
line 967
;967:	cgs.media.watrUnSound = trap_S_RegisterSound("sound/player/watr_un.wav", qfalse);
ADDRGP4 $651
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 584
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1252
ADDRLP4 584
INDIRI4
ASGNI4
line 969
;968:
;969:	cgs.media.jumpPadSound = trap_S_RegisterSound("sound/world/jumppad.wav", qfalse);
ADDRGP4 $654
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 588
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1104
ADDRLP4 588
INDIRI4
ASGNI4
line 971
;970:
;971:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $655
line 972
;972:		Com_sprintf(name, sizeof (name), "sound/player/footsteps/step%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $659
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 973
;973:		cgs.media.footsteps[FOOTSTEP_NORMAL][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 592
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824
ADDP4
ADDRLP4 592
INDIRI4
ASGNI4
line 975
;974:
;975:		Com_sprintf(name, sizeof (name), "sound/player/footsteps/boot%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $662
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 976
;976:		cgs.media.footsteps[FOOTSTEP_BOOT][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 596
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824+16
ADDP4
ADDRLP4 596
INDIRI4
ASGNI4
line 978
;977:
;978:		Com_sprintf(name, sizeof (name), "sound/player/footsteps/flesh%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $666
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 979
;979:		cgs.media.footsteps[FOOTSTEP_FLESH][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 600
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824+32
ADDP4
ADDRLP4 600
INDIRI4
ASGNI4
line 981
;980:
;981:		Com_sprintf(name, sizeof (name), "sound/player/footsteps/mech%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $670
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 982
;982:		cgs.media.footsteps[FOOTSTEP_MECH][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 604
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824+48
ADDP4
ADDRLP4 604
INDIRI4
ASGNI4
line 984
;983:
;984:		Com_sprintf(name, sizeof (name), "sound/player/footsteps/energy%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $674
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 985
;985:		cgs.media.footsteps[FOOTSTEP_ENERGY][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 608
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824+64
ADDP4
ADDRLP4 608
INDIRI4
ASGNI4
line 987
;986:
;987:		Com_sprintf(name, sizeof (name), "sound/player/footsteps/splash%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $678
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 988
;988:		cgs.media.footsteps[FOOTSTEP_SPLASH][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 612
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824+96
ADDP4
ADDRLP4 612
INDIRI4
ASGNI4
line 990
;989:
;990:		Com_sprintf(name, sizeof (name), "sound/player/footsteps/clank%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $682
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 991
;991:		cgs.media.footsteps[FOOTSTEP_METAL][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 616
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+824+80
ADDP4
ADDRLP4 616
INDIRI4
ASGNI4
line 992
;992:	}
LABELV $656
line 971
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $655
line 995
;993:
;994:	// only register the items that the server says we need
;995:	Q_strncpyz(items, CG_ConfigString(CS_ITEMS), sizeof (items));
CNSTI4 27
ARGI4
ADDRLP4 592
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 72
ARGP4
ADDRLP4 592
INDIRP4
ARGP4
CNSTI4 257
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 997
;996:
;997:	for (i = 1; i < bg_numItems; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $689
JUMPV
LABELV $686
line 999
;998:		//		if ( items[ i ] == '1' || cg_buildScript.integer ) {
;999:		CG_RegisterItemSounds(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemSounds
CALLV
pop
line 1001
;1000:		//		}
;1001:	}
LABELV $687
line 997
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $689
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $686
line 1003
;1002:
;1003:	for (i = 1; i < MAX_SOUNDS; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $690
line 1004
;1004:		soundName = CG_ConfigString(CS_SOUNDS + i);
ADDRLP4 0
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 596
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 596
INDIRP4
ASGNP4
line 1005
;1005:		if (!soundName[0]) {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $694
line 1006
;1006:			break;
ADDRGP4 $692
JUMPV
LABELV $694
line 1008
;1007:		}
;1008:		if (soundName[0] == '*') {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $696
line 1009
;1009:			continue; // custom sound
ADDRGP4 $691
JUMPV
LABELV $696
line 1011
;1010:		}
;1011:		cgs.gameSounds[i] = trap_S_RegisterSound(soundName, qfalse);
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 600
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36028
ADDP4
ADDRLP4 600
INDIRI4
ASGNI4
line 1012
;1012:	}
LABELV $691
line 1003
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $690
LABELV $692
line 1022
;1013:
;1014:	// FIXME: only needed with item
;1015:
;1016:	// loadingscreen
;1017:#ifdef SCRIPTHUD
;1018:	CG_UpdateSoundFraction(0.85f);
;1019:	CG_UpdateMediaFraction(0.50f);
;1020:#endif
;1021:	// end loadingscreen
;1022:	cgs.media.flightSound = trap_S_RegisterSound("sound/items/flight.wav", qfalse);
ADDRGP4 $701
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 596
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1256
ADDRLP4 596
INDIRI4
ASGNI4
line 1023
;1023:	cgs.media.medkitSound = trap_S_RegisterSound("sound/items/use_medkit.wav", qfalse);
ADDRGP4 $704
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 600
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1260
ADDRLP4 600
INDIRI4
ASGNI4
line 1024
;1024:	cgs.media.quadSound = trap_S_RegisterSound("sound/items/damage3.wav", qfalse);
ADDRGP4 $707
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 604
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+804
ADDRLP4 604
INDIRI4
ASGNI4
line 1025
;1025:	cgs.media.sfx_ric1 = trap_S_RegisterSound("sound/weapons/machinegun/ric1.wav", qfalse);
ADDRGP4 $710
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 608
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+948
ADDRLP4 608
INDIRI4
ASGNI4
line 1026
;1026:	cgs.media.sfx_ric2 = trap_S_RegisterSound("sound/weapons/machinegun/ric2.wav", qfalse);
ADDRGP4 $713
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 612
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+952
ADDRLP4 612
INDIRI4
ASGNI4
line 1027
;1027:	cgs.media.sfx_ric3 = trap_S_RegisterSound("sound/weapons/machinegun/ric3.wav", qfalse);
ADDRGP4 $716
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 616
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+956
ADDRLP4 616
INDIRI4
ASGNI4
line 1028
;1028:	cgs.media.sfx_railg = trap_S_RegisterSound("sound/weapons/railgun/railgf1a.wav", qfalse);
ADDRGP4 $719
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 620
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+960
ADDRLP4 620
INDIRI4
ASGNI4
line 1029
;1029:	cgs.media.sfx_rockexp = trap_S_RegisterSound("sound/weapons/rocket/rocklx1a.wav", qfalse);
ADDRGP4 $722
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 624
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+964
ADDRLP4 624
INDIRI4
ASGNI4
line 1030
;1030:	cgs.media.sfx_plasmaexp = trap_S_RegisterSound("sound/weapons/plasma/plasmx1a.wav", qfalse);
ADDRGP4 $725
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 628
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+968
ADDRLP4 628
INDIRI4
ASGNI4
line 1031
;1031:	cgs.media.sfx_proxexp = trap_S_RegisterSound("sound/weapons/proxmine/wstbexpl.wav", qfalse);
ADDRGP4 $728
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 632
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+972
ADDRLP4 632
INDIRI4
ASGNI4
line 1032
;1032:	cgs.media.sfx_nghit = trap_S_RegisterSound("sound/weapons/nailgun/wnalimpd.wav", qfalse);
ADDRGP4 $731
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 636
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+976
ADDRLP4 636
INDIRI4
ASGNI4
line 1033
;1033:	cgs.media.sfx_nghitflesh = trap_S_RegisterSound("sound/weapons/nailgun/wnalimpl.wav", qfalse);
ADDRGP4 $734
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 640
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+980
ADDRLP4 640
INDIRI4
ASGNI4
line 1034
;1034:	cgs.media.sfx_nghitmetal = trap_S_RegisterSound("sound/weapons/nailgun/wnalimpm.wav", qfalse);
ADDRGP4 $737
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 644
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+984
ADDRLP4 644
INDIRI4
ASGNI4
line 1035
;1035:	cgs.media.sfx_chghit = trap_S_RegisterSound("sound/weapons/vulcan/wvulimpd.wav", qfalse);
ADDRGP4 $740
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 648
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+988
ADDRLP4 648
INDIRI4
ASGNI4
line 1036
;1036:	cgs.media.sfx_chghitflesh = trap_S_RegisterSound("sound/weapons/vulcan/wvulimpl.wav", qfalse);
ADDRGP4 $743
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 652
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+992
ADDRLP4 652
INDIRI4
ASGNI4
line 1037
;1037:	cgs.media.sfx_chghitmetal = trap_S_RegisterSound("sound/weapons/vulcan/wvulimpm.wav", qfalse);
ADDRGP4 $746
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 656
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+996
ADDRLP4 656
INDIRI4
ASGNI4
line 1038
;1038:	cgs.media.weaponHoverSound = trap_S_RegisterSound("sound/weapons/weapon_hover.wav", qfalse);
ADDRGP4 $749
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 660
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1264
ADDRLP4 660
INDIRI4
ASGNI4
line 1039
;1039:	cgs.media.kamikazeExplodeSound = trap_S_RegisterSound("sound/items/kam_explode.wav", qfalse);
ADDRGP4 $752
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 664
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1000
ADDRLP4 664
INDIRI4
ASGNI4
line 1040
;1040:	cgs.media.kamikazeImplodeSound = trap_S_RegisterSound("sound/items/kam_implode.wav", qfalse);
ADDRGP4 $755
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 668
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1004
ADDRLP4 668
INDIRI4
ASGNI4
line 1041
;1041:	cgs.media.kamikazeFarSound = trap_S_RegisterSound("sound/items/kam_explode_far.wav", qfalse);
ADDRGP4 $758
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 672
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1008
ADDRLP4 672
INDIRI4
ASGNI4
line 1042
;1042:	cgs.media.winnerSound = trap_S_RegisterSound("sound/feedback/voc_youwin.wav", qfalse);
ADDRGP4 $761
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 676
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1048
ADDRLP4 676
INDIRI4
ASGNI4
line 1043
;1043:	cgs.media.loserSound = trap_S_RegisterSound("sound/feedback/voc_youlose.wav", qfalse);
ADDRGP4 $764
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 680
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1052
ADDRLP4 680
INDIRI4
ASGNI4
line 1044
;1044:	cgs.media.youSuckSound = trap_S_RegisterSound("sound/misc/yousuck.wav", qfalse);
ADDRGP4 $767
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 684
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1056
ADDRLP4 684
INDIRI4
ASGNI4
line 1046
;1045:
;1046:	cgs.media.wstbimplSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpl.wav", qfalse);
ADDRGP4 $770
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 688
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1424
ADDRLP4 688
INDIRI4
ASGNI4
line 1047
;1047:	cgs.media.wstbimpmSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpm.wav", qfalse);
ADDRGP4 $773
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 692
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1428
ADDRLP4 692
INDIRI4
ASGNI4
line 1048
;1048:	cgs.media.wstbimpdSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpd.wav", qfalse);
ADDRGP4 $776
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 696
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1432
ADDRLP4 696
INDIRI4
ASGNI4
line 1049
;1049:	cgs.media.wstbactvSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbactv.wav", qfalse);
ADDRGP4 $779
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 700
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1436
ADDRLP4 700
INDIRI4
ASGNI4
line 1051
;1050:
;1051:	cgs.media.regenSound = trap_S_RegisterSound("sound/items/regen.wav", qfalse);
ADDRGP4 $782
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 704
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1404
ADDRLP4 704
INDIRI4
ASGNI4
line 1052
;1052:	cgs.media.protectSound = trap_S_RegisterSound("sound/items/protect3.wav", qfalse);
ADDRGP4 $785
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 708
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1408
ADDRLP4 708
INDIRI4
ASGNI4
line 1053
;1053:	cgs.media.n_healthSound = trap_S_RegisterSound("sound/items/n_health.wav", qfalse);
ADDRGP4 $788
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 712
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1412
ADDRLP4 712
INDIRI4
ASGNI4
line 1054
;1054:	cgs.media.hgrenb1aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb1a.wav", qfalse);
ADDRGP4 $791
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 716
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1416
ADDRLP4 716
INDIRI4
ASGNI4
line 1055
;1055:	cgs.media.hgrenb2aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb2a.wav", qfalse);
ADDRGP4 $794
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 720
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+180268+1420
ADDRLP4 720
INDIRI4
ASGNI4
line 1085
;1056:
;1057:#ifdef MISSIONPACK
;1058:	trap_S_RegisterSound("sound/player/sergei/death1.wav", qfalse);
;1059:	trap_S_RegisterSound("sound/player/sergei/death2.wav", qfalse);
;1060:	trap_S_RegisterSound("sound/player/sergei/death3.wav", qfalse);
;1061:	trap_S_RegisterSound("sound/player/sergei/jump1.wav", qfalse);
;1062:	trap_S_RegisterSound("sound/player/sergei/pain25_1.wav", qfalse);
;1063:	trap_S_RegisterSound("sound/player/sergei/pain75_1.wav", qfalse);
;1064:	trap_S_RegisterSound("sound/player/sergei/pain100_1.wav", qfalse);
;1065:	trap_S_RegisterSound("sound/player/sergei/falling1.wav", qfalse);
;1066:	trap_S_RegisterSound("sound/player/sergei/gasp.wav", qfalse);
;1067:	trap_S_RegisterSound("sound/player/sergei/drown.wav", qfalse);
;1068:	trap_S_RegisterSound("sound/player/sergei/fall1.wav", qfalse);
;1069:	trap_S_RegisterSound("sound/player/sergei/taunt.wav", qfalse);
;1070:
;1071:	trap_S_RegisterSound("sound/player/kyonshi/death1.wav", qfalse);
;1072:	trap_S_RegisterSound("sound/player/kyonshi/death2.wav", qfalse);
;1073:	trap_S_RegisterSound("sound/player/kyonshi/death3.wav", qfalse);
;1074:	trap_S_RegisterSound("sound/player/kyonshi/jump1.wav", qfalse);
;1075:	trap_S_RegisterSound("sound/player/kyonshi/pain25_1.wav", qfalse);
;1076:	trap_S_RegisterSound("sound/player/kyonshi/pain75_1.wav", qfalse);
;1077:	trap_S_RegisterSound("sound/player/kyonshi/pain100_1.wav", qfalse);
;1078:	trap_S_RegisterSound("sound/player/kyonshi/falling1.wav", qfalse);
;1079:	trap_S_RegisterSound("sound/player/kyonshi/gasp.wav", qfalse);
;1080:	trap_S_RegisterSound("sound/player/kyonshi/drown.wav", qfalse);
;1081:	trap_S_RegisterSound("sound/player/kyonshi/fall1.wav", qfalse);
;1082:	trap_S_RegisterSound("sound/player/kyonshi/taunt.wav", qfalse);
;1083:#endif
;1084:
;1085:}
LABELV $371
endproc CG_RegisterSounds 724 16
data
align 4
LABELV $796
address $797
address $798
address $799
address $800
address $801
address $802
address $803
address $804
address $805
address $806
address $807
code
proc CG_RegisterGraphics 832 16
line 1097
;1086:
;1087:
;1088://===================================================================================
;1089:
;1090:/*
;1091:=================
;1092:CG_RegisterGraphics
;1093:
;1094:This function may execute for a couple of minutes with a slow disk.
;1095:=================
;1096: */
;1097:static void CG_RegisterGraphics(void) {
line 1115
;1098:	int i;
;1099:	char items[MAX_ITEMS + 1];
;1100:	static char *sb_nums[11] = {
;1101:		"gfx/2d/numbers/zero_32b",
;1102:		"gfx/2d/numbers/one_32b",
;1103:		"gfx/2d/numbers/two_32b",
;1104:		"gfx/2d/numbers/three_32b",
;1105:		"gfx/2d/numbers/four_32b",
;1106:		"gfx/2d/numbers/five_32b",
;1107:		"gfx/2d/numbers/six_32b",
;1108:		"gfx/2d/numbers/seven_32b",
;1109:		"gfx/2d/numbers/eight_32b",
;1110:		"gfx/2d/numbers/nine_32b",
;1111:		"gfx/2d/numbers/minus_32b",
;1112:	};
;1113:
;1114:	// clear any references to old media
;1115:	memset(&cg.refdef, 0, sizeof ( cg.refdef));
ADDRGP4 cg+109252
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1116
;1116:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 1118
;1117:
;1118:	CG_LoadingString(cgs.mapname);
ADDRGP4 cgs+31492
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1120
;1119:
;1120:	trap_R_LoadWorldMap(cgs.mapname);
ADDRGP4 cgs+31492
ARGP4
ADDRGP4 trap_R_LoadWorldMap
CALLV
pop
line 1123
;1121:
;1122:	// precache status bar pics
;1123:	CG_LoadingString("game media");
ADDRGP4 $812
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1125
;1124:
;1125:	for (i = 0; i < 11; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $813
line 1126
;1126:		cgs.media.numberShaders[i] = trap_R_RegisterShader(sb_nums[i]);
ADDRLP4 264
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 264
INDIRI4
ADDRGP4 $796
ADDP4
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
ADDRGP4 cgs+180268+452
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 1127
;1127:	}
LABELV $814
line 1125
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $813
line 1129
;1128:
;1129:	cgs.media.botSkillShaders[0] = trap_R_RegisterShader("menu/art/skill1.tga");
ADDRGP4 $821
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+500
ADDRLP4 264
INDIRI4
ASGNI4
line 1130
;1130:	cgs.media.botSkillShaders[1] = trap_R_RegisterShader("menu/art/skill2.tga");
ADDRGP4 $825
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+500+4
ADDRLP4 268
INDIRI4
ASGNI4
line 1131
;1131:	cgs.media.botSkillShaders[2] = trap_R_RegisterShader("menu/art/skill3.tga");
ADDRGP4 $829
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+500+8
ADDRLP4 272
INDIRI4
ASGNI4
line 1132
;1132:	cgs.media.botSkillShaders[3] = trap_R_RegisterShader("menu/art/skill4.tga");
ADDRGP4 $833
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+500+12
ADDRLP4 276
INDIRI4
ASGNI4
line 1133
;1133:	cgs.media.botSkillShaders[4] = trap_R_RegisterShader("menu/art/skill5.tga");
ADDRGP4 $837
ARGP4
ADDRLP4 280
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+500+16
ADDRLP4 280
INDIRI4
ASGNI4
line 1135
;1134:
;1135:	cgs.media.viewBloodShader = trap_R_RegisterShader("viewBloodBlend");
ADDRGP4 $840
ARGP4
ADDRLP4 284
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+280
ADDRLP4 284
INDIRI4
ASGNI4
line 1137
;1136:
;1137:	cgs.media.deferShader = trap_R_RegisterShaderNoMip("gfx/2d/defer.tga");
ADDRGP4 $843
ARGP4
ADDRLP4 288
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+196
ADDRLP4 288
INDIRI4
ASGNI4
line 1139
;1138:
;1139:	cgs.media.scoreboardName = trap_R_RegisterShaderNoMip("menu/tab/name.tga");
ADDRGP4 $846
ARGP4
ADDRLP4 292
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+704
ADDRLP4 292
INDIRI4
ASGNI4
line 1140
;1140:	cgs.media.scoreboardPing = trap_R_RegisterShaderNoMip("menu/tab/ping.tga");
ADDRGP4 $849
ARGP4
ADDRLP4 296
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+708
ADDRLP4 296
INDIRI4
ASGNI4
line 1141
;1141:	cgs.media.scoreboardScore = trap_R_RegisterShaderNoMip("menu/tab/score.tga");
ADDRGP4 $852
ARGP4
ADDRLP4 300
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+712
ADDRLP4 300
INDIRI4
ASGNI4
line 1142
;1142:	cgs.media.scoreboardTime = trap_R_RegisterShaderNoMip("menu/tab/time.tga");
ADDRGP4 $855
ARGP4
ADDRLP4 304
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+716
ADDRLP4 304
INDIRI4
ASGNI4
line 1144
;1143:
;1144:	cgs.media.smokePuffShader = trap_R_RegisterShader("smokePuff");
ADDRGP4 $858
ARGP4
ADDRLP4 308
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+340
ADDRLP4 308
INDIRI4
ASGNI4
line 1145
;1145:	cgs.media.smokePuffRageProShader = trap_R_RegisterShader("smokePuffRagePro");
ADDRGP4 $861
ARGP4
ADDRLP4 312
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+344
ADDRLP4 312
INDIRI4
ASGNI4
line 1146
;1146:	cgs.media.shotgunSmokePuffShader = trap_R_RegisterShader("shotgunSmokePuff");
ADDRGP4 $864
ARGP4
ADDRLP4 316
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+348
ADDRLP4 316
INDIRI4
ASGNI4
line 1147
;1147:	cgs.media.nailPuffShader = trap_R_RegisterShader("nailtrail");
ADDRGP4 $867
ARGP4
ADDRLP4 320
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+444
ADDRLP4 320
INDIRI4
ASGNI4
line 1148
;1148:	cgs.media.blueProxMine = trap_R_RegisterModel("models/weaphits/proxmineb.md3");
ADDRGP4 $870
ARGP4
ADDRLP4 324
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+448
ADDRLP4 324
INDIRI4
ASGNI4
line 1149
;1149:	cgs.media.plasmaBallShader = trap_R_RegisterShader("sprites/plasma1");
ADDRGP4 $873
ARGP4
ADDRLP4 328
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+352
ADDRLP4 328
INDIRI4
ASGNI4
line 1150
;1150:	cgs.media.bloodTrailShader = trap_R_RegisterShader("bloodTrail");
ADDRGP4 $876
ARGP4
ADDRLP4 332
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+360
ADDRLP4 332
INDIRI4
ASGNI4
line 1151
;1151:	cgs.media.lagometerShader = trap_R_RegisterShader("lagometer");
ADDRGP4 $879
ARGP4
ADDRLP4 336
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+328
ADDRLP4 336
INDIRI4
ASGNI4
line 1152
;1152:	cgs.media.connectionShader = trap_R_RegisterShader("disconnected");
ADDRGP4 $882
ARGP4
ADDRLP4 340
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+272
ADDRLP4 340
INDIRI4
ASGNI4
line 1154
;1153:
;1154:	cgs.media.waterBubbleShader = trap_R_RegisterShader("waterBubble");
ADDRGP4 $885
ARGP4
ADDRLP4 344
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+356
ADDRLP4 344
INDIRI4
ASGNI4
line 1156
;1155:
;1156:	cgs.media.tracerShader = trap_R_RegisterShader("gfx/misc/tracer");
ADDRGP4 $888
ARGP4
ADDRLP4 348
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+284
ADDRLP4 348
INDIRI4
ASGNI4
line 1157
;1157:	cgs.media.selectShader = trap_R_RegisterShader("gfx/2d/select");
ADDRGP4 $891
ARGP4
ADDRLP4 352
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+276
ADDRLP4 352
INDIRI4
ASGNI4
line 1159
;1158:
;1159:	cgs.media.bfgShader = trap_R_RegisterShader("icons/iconw_bfg");
ADDRGP4 $894
ARGP4
ADDRLP4 356
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+744
ADDRLP4 356
INDIRI4
ASGNI4
line 1160
;1160:	cgs.media.chaingunShader = trap_R_RegisterShader("icons/iconw_chaingun");
ADDRGP4 $897
ARGP4
ADDRLP4 360
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+748
ADDRLP4 360
INDIRI4
ASGNI4
line 1161
;1161:	cgs.media.gauntletShader = trap_R_RegisterShader("icons/iconw_gauntlet");
ADDRGP4 $900
ARGP4
ADDRLP4 364
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+752
ADDRLP4 364
INDIRI4
ASGNI4
line 1162
;1162:	cgs.media.grapplehookShader = trap_R_RegisterShader("icons/iconw_grapple");
ADDRGP4 $903
ARGP4
ADDRLP4 368
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+756
ADDRLP4 368
INDIRI4
ASGNI4
line 1163
;1163:	cgs.media.grenadeShader = trap_R_RegisterShader("icons/iconw_grenade");
ADDRGP4 $906
ARGP4
ADDRLP4 372
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+760
ADDRLP4 372
INDIRI4
ASGNI4
line 1164
;1164:	cgs.media.kamikazeShader = trap_R_RegisterShader("icons/iconw_kamikaze");
ADDRGP4 $909
ARGP4
ADDRLP4 376
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+764
ADDRLP4 376
INDIRI4
ASGNI4
line 1165
;1165:	cgs.media.lightninggunShader = trap_R_RegisterShader("icons/iconw_lightning");
ADDRGP4 $912
ARGP4
ADDRLP4 380
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+768
ADDRLP4 380
INDIRI4
ASGNI4
line 1166
;1166:	cgs.media.machinegunShader = trap_R_RegisterShader("icons/iconw_machinegun");
ADDRGP4 $915
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+772
ADDRLP4 384
INDIRI4
ASGNI4
line 1167
;1167:	cgs.media.nailgunShader = trap_R_RegisterShader("icons/iconw_nailgun");
ADDRGP4 $918
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+776
ADDRLP4 388
INDIRI4
ASGNI4
line 1168
;1168:	cgs.media.plasmaShader = trap_R_RegisterShader("icons/iconw_plasma");
ADDRGP4 $921
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+780
ADDRLP4 392
INDIRI4
ASGNI4
line 1169
;1169:	cgs.media.proxlauncherShader = trap_R_RegisterShader("icons/iconw_proxlauncher");
ADDRGP4 $924
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+784
ADDRLP4 396
INDIRI4
ASGNI4
line 1170
;1170:	cgs.media.railgunShader = trap_R_RegisterShader("icons/iconw_railgun");
ADDRGP4 $927
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+788
ADDRLP4 400
INDIRI4
ASGNI4
line 1171
;1171:	cgs.media.rocketShader = trap_R_RegisterShader("icons/iconw_rocket");
ADDRGP4 $930
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+792
ADDRLP4 404
INDIRI4
ASGNI4
line 1172
;1172:	cgs.media.shotgunShader = trap_R_RegisterShader("icons/iconw_shotgun");
ADDRGP4 $933
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+796
ADDRLP4 408
INDIRI4
ASGNI4
line 1173
;1173:	cgs.media.skullShader = trap_R_RegisterShader("icons/skull_red");
ADDRGP4 $936
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+800
ADDRLP4 412
INDIRI4
ASGNI4
line 1175
;1174:
;1175:	for (i = 0; i < NUM_CROSSHAIRS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $937
line 1176
;1176:		if (i < 10)
ADDRLP4 0
INDIRI4
CNSTI4 10
GEI4 $941
line 1177
;1177:			cgs.media.crosshairShader[i] = trap_R_RegisterShader(va("gfx/2d/crosshair%c", 'a' + i));
ADDRGP4 $945
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 97
ADDI4
ARGI4
ADDRLP4 420
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 420
INDIRP4
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+288
ADDP4
ADDRLP4 424
INDIRI4
ASGNI4
ADDRGP4 $942
JUMPV
LABELV $941
line 1179
;1178:		else
;1179:			cgs.media.crosshairShader[i] = trap_R_RegisterShader(va("gfx/2d/crosshair%02d", i - 10));
ADDRGP4 $948
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
SUBI4
ARGI4
ADDRLP4 432
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 432
INDIRP4
ARGP4
ADDRLP4 436
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+288
ADDP4
ADDRLP4 436
INDIRI4
ASGNI4
LABELV $942
line 1180
;1180:	}
LABELV $938
line 1175
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $937
line 1182
;1181:
;1182:	cgs.media.backTileShader = trap_R_RegisterShader("gfx/2d/backtile");
ADDRGP4 $951
ARGP4
ADDRLP4 416
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+332
ADDRLP4 416
INDIRI4
ASGNI4
line 1183
;1183:	cgs.media.noammoShader = trap_R_RegisterShader("icons/noammo");
ADDRGP4 $954
ARGP4
ADDRLP4 420
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+336
ADDRLP4 420
INDIRI4
ASGNI4
line 1186
;1184:
;1185:	// powerup shaders
;1186:	cgs.media.quadShader = trap_R_RegisterShader("powerups/quad");
ADDRGP4 $957
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+544
ADDRLP4 424
INDIRI4
ASGNI4
line 1187
;1187:	cgs.media.quadWeaponShader = trap_R_RegisterShader("powerups/quadWeapon");
ADDRGP4 $960
ARGP4
ADDRLP4 428
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+552
ADDRLP4 428
INDIRI4
ASGNI4
line 1188
;1188:	cgs.media.battleSuitShader = trap_R_RegisterShader("powerups/battleSuit");
ADDRGP4 $963
ARGP4
ADDRLP4 432
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+564
ADDRLP4 432
INDIRI4
ASGNI4
line 1189
;1189:	cgs.media.battleWeaponShader = trap_R_RegisterShader("powerups/battleWeapon");
ADDRGP4 $966
ARGP4
ADDRLP4 436
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+568
ADDRLP4 436
INDIRI4
ASGNI4
line 1190
;1190:	cgs.media.invisShader = trap_R_RegisterShader("powerups/invisibility");
ADDRGP4 $969
ARGP4
ADDRLP4 440
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+556
ADDRLP4 440
INDIRI4
ASGNI4
line 1191
;1191:	cgs.media.regenShader = trap_R_RegisterShader("powerups/regen");
ADDRGP4 $972
ARGP4
ADDRLP4 444
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+560
ADDRLP4 444
INDIRI4
ASGNI4
line 1192
;1192:	cgs.media.hastePuffShader = trap_R_RegisterShader("hasteSmokePuff");
ADDRGP4 $975
ARGP4
ADDRLP4 448
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+572
ADDRLP4 448
INDIRI4
ASGNI4
line 1194
;1193:
;1194:	if (CG_UsesTeamFlags(cgs.gametype) || cgs.gametype == GT_HARVESTER || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 452
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 456
CNSTI4 0
ASGNI4
ADDRLP4 452
INDIRI4
ADDRLP4 456
INDIRI4
NEI4 $982
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 7
EQI4 $982
ADDRGP4 cg_buildScript+12
INDIRI4
ADDRLP4 456
INDIRI4
EQI4 $976
LABELV $982
line 1195
;1195:		cgs.media.redCubeModel = trap_R_RegisterModel("models/powerups/orb/r_orb.md3");
ADDRGP4 $985
ARGP4
ADDRLP4 460
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+20
ADDRLP4 460
INDIRI4
ASGNI4
line 1196
;1196:		cgs.media.blueCubeModel = trap_R_RegisterModel("models/powerups/orb/b_orb.md3");
ADDRGP4 $988
ARGP4
ADDRLP4 464
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+24
ADDRLP4 464
INDIRI4
ASGNI4
line 1197
;1197:		cgs.media.redCubeIcon = trap_R_RegisterShader("icons/skull_red");
ADDRGP4 $936
ARGP4
ADDRLP4 468
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+28
ADDRLP4 468
INDIRI4
ASGNI4
line 1198
;1198:		cgs.media.blueCubeIcon = trap_R_RegisterShader("icons/skull_blue");
ADDRGP4 $993
ARGP4
ADDRLP4 472
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+32
ADDRLP4 472
INDIRI4
ASGNI4
line 1199
;1199:	}
LABELV $976
line 1201
;1200:
;1201:	if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
EQI4 $994
line 1202
;1202:		cgs.media.redOverlay = trap_R_RegisterShader("playeroverlays/playerSuit1_Red");
ADDRGP4 $999
ARGP4
ADDRLP4 464
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+588
ADDRLP4 464
INDIRI4
ASGNI4
line 1203
;1203:		cgs.media.blueOverlay = trap_R_RegisterShader("playeroverlays/playerSuit1_Blue");
ADDRGP4 $1002
ARGP4
ADDRLP4 468
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+592
ADDRLP4 468
INDIRI4
ASGNI4
line 1204
;1204:	} else {
ADDRGP4 $995
JUMPV
LABELV $994
line 1205
;1205:		cgs.media.neutralOverlay = trap_R_RegisterShader("playeroverlays/playerSuit1_Neutral");
ADDRGP4 $1005
ARGP4
ADDRLP4 464
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+584
ADDRLP4 464
INDIRI4
ASGNI4
line 1206
;1206:	}
LABELV $995
line 1209
;1207:
;1208:	//For Double Domination:
;1209:	if (cgs.gametype == GT_DOUBLE_D) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
NEI4 $1006
line 1210
;1210:		cgs.media.ddPointSkinA[TEAM_RED] = trap_R_RegisterShaderNoMip("icons/icona_red");
ADDRGP4 $1012
ARGP4
ADDRLP4 464
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+88+4
ADDRLP4 464
INDIRI4
ASGNI4
line 1211
;1211:		cgs.media.ddPointSkinA[TEAM_BLUE] = trap_R_RegisterShaderNoMip("icons/icona_blue");
ADDRGP4 $1016
ARGP4
ADDRLP4 468
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+88+8
ADDRLP4 468
INDIRI4
ASGNI4
line 1212
;1212:		cgs.media.ddPointSkinA[TEAM_FREE] = trap_R_RegisterShaderNoMip("icons/icona_white");
ADDRGP4 $1019
ARGP4
ADDRLP4 472
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+88
ADDRLP4 472
INDIRI4
ASGNI4
line 1213
;1213:		cgs.media.ddPointSkinA[TEAM_NONE] = trap_R_RegisterShaderNoMip("icons/noammo");
ADDRGP4 $954
ARGP4
ADDRLP4 476
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+88+12
ADDRLP4 476
INDIRI4
ASGNI4
line 1215
;1214:
;1215:		cgs.media.ddPointSkinB[TEAM_RED] = trap_R_RegisterShaderNoMip("icons/iconb_red");
ADDRGP4 $1026
ARGP4
ADDRLP4 480
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+104+4
ADDRLP4 480
INDIRI4
ASGNI4
line 1216
;1216:		cgs.media.ddPointSkinB[TEAM_BLUE] = trap_R_RegisterShaderNoMip("icons/iconb_blue");
ADDRGP4 $1030
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+104+8
ADDRLP4 484
INDIRI4
ASGNI4
line 1217
;1217:		cgs.media.ddPointSkinB[TEAM_FREE] = trap_R_RegisterShaderNoMip("icons/iconb_white");
ADDRGP4 $1033
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+104
ADDRLP4 488
INDIRI4
ASGNI4
line 1218
;1218:		cgs.media.ddPointSkinB[TEAM_NONE] = trap_R_RegisterShaderNoMip("icons/noammo");
ADDRGP4 $954
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+104+12
ADDRLP4 492
INDIRI4
ASGNI4
line 1219
;1219:	}
LABELV $1006
line 1221
;1220:
;1221:	if (CG_UsesTeamFlags(cgs.gametype) || CG_UsesTheWhiteFlag(cgs.gametype) || cgs.gametype == GT_HARVESTER || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 464
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 464
INDIRI4
CNSTI4 0
NEI4 $1045
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 468
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 472
CNSTI4 0
ASGNI4
ADDRLP4 468
INDIRI4
ADDRLP4 472
INDIRI4
NEI4 $1045
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 7
EQI4 $1045
ADDRGP4 cg_buildScript+12
INDIRI4
ADDRLP4 472
INDIRI4
EQI4 $1037
LABELV $1045
line 1222
;1222:		cgs.media.redFlagModel = trap_R_RegisterModel("models/flags/r_flag.md3");
ADDRGP4 $1048
ARGP4
ADDRLP4 476
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+36
ADDRLP4 476
INDIRI4
ASGNI4
line 1223
;1223:		cgs.media.blueFlagModel = trap_R_RegisterModel("models/flags/b_flag.md3");
ADDRGP4 $1051
ARGP4
ADDRLP4 480
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+40
ADDRLP4 480
INDIRI4
ASGNI4
line 1224
;1224:		cgs.media.neutralFlagModel = trap_R_RegisterModel("models/flags/n_flag.md3");
ADDRGP4 $1054
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+44
ADDRLP4 484
INDIRI4
ASGNI4
line 1225
;1225:		cgs.media.redFlagShader[0] = trap_R_RegisterShaderNoMip("icons/iconf_red1");
ADDRGP4 $1057
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+48
ADDRLP4 488
INDIRI4
ASGNI4
line 1226
;1226:		cgs.media.redFlagShader[1] = trap_R_RegisterShaderNoMip("icons/iconf_red2");
ADDRGP4 $1061
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+48+4
ADDRLP4 492
INDIRI4
ASGNI4
line 1227
;1227:		cgs.media.redFlagShader[2] = trap_R_RegisterShaderNoMip("icons/iconf_red3");
ADDRGP4 $1065
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+48+8
ADDRLP4 496
INDIRI4
ASGNI4
line 1228
;1228:		cgs.media.blueFlagShader[0] = trap_R_RegisterShaderNoMip("icons/iconf_blu1");
ADDRGP4 $1068
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+60
ADDRLP4 500
INDIRI4
ASGNI4
line 1229
;1229:		cgs.media.blueFlagShader[1] = trap_R_RegisterShaderNoMip("icons/iconf_blu2");
ADDRGP4 $1072
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+60+4
ADDRLP4 504
INDIRI4
ASGNI4
line 1230
;1230:		cgs.media.blueFlagShader[2] = trap_R_RegisterShaderNoMip("icons/iconf_blu3");
ADDRGP4 $1076
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+60+8
ADDRLP4 508
INDIRI4
ASGNI4
line 1231
;1231:		cgs.media.flagPoleModel = trap_R_RegisterModel("models/flag2/flagpole.md3");
ADDRGP4 $1079
ARGP4
ADDRLP4 512
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+120
ADDRLP4 512
INDIRI4
ASGNI4
line 1232
;1232:		cgs.media.flagFlapModel = trap_R_RegisterModel("models/flag2/flagflap3.md3");
ADDRGP4 $1082
ARGP4
ADDRLP4 516
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+124
ADDRLP4 516
INDIRI4
ASGNI4
line 1234
;1233:
;1234:		cgs.media.redFlagFlapSkin = trap_R_RegisterSkin("models/flag2/red.skin");
ADDRGP4 $1085
ARGP4
ADDRLP4 520
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+180268+128
ADDRLP4 520
INDIRI4
ASGNI4
line 1235
;1235:		cgs.media.blueFlagFlapSkin = trap_R_RegisterSkin("models/flag2/blue.skin");
ADDRGP4 $1088
ARGP4
ADDRLP4 524
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+180268+132
ADDRLP4 524
INDIRI4
ASGNI4
line 1236
;1236:		cgs.media.neutralFlagFlapSkin = trap_R_RegisterSkin("models/flag2/white.skin");
ADDRGP4 $1091
ARGP4
ADDRLP4 528
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+180268+136
ADDRLP4 528
INDIRI4
ASGNI4
line 1238
;1237:
;1238:		cgs.media.redFlagBaseModel = trap_R_RegisterModel("models/mapobjects/flagbase/red_base.md3");
ADDRGP4 $1094
ARGP4
ADDRLP4 532
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+140
ADDRLP4 532
INDIRI4
ASGNI4
line 1239
;1239:		cgs.media.blueFlagBaseModel = trap_R_RegisterModel("models/mapobjects/flagbase/blue_base.md3");
ADDRGP4 $1097
ARGP4
ADDRLP4 536
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+144
ADDRLP4 536
INDIRI4
ASGNI4
line 1240
;1240:		cgs.media.neutralFlagBaseModel = trap_R_RegisterModel("models/mapobjects/flagbase/ntrl_base.md3");
ADDRGP4 $1100
ARGP4
ADDRLP4 540
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+148
ADDRLP4 540
INDIRI4
ASGNI4
line 1241
;1241:	}
LABELV $1037
line 1243
;1242:
;1243:	if (CG_UsesTheWhiteFlag(cgs.gametype) || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 476
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 480
CNSTI4 0
ASGNI4
ADDRLP4 476
INDIRI4
ADDRLP4 480
INDIRI4
NEI4 $1105
ADDRGP4 cg_buildScript+12
INDIRI4
ADDRLP4 480
INDIRI4
EQI4 $1101
LABELV $1105
line 1244
;1244:		cgs.media.neutralFlagModel = trap_R_RegisterModel("models/flags/n_flag.md3");
ADDRGP4 $1054
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+44
ADDRLP4 484
INDIRI4
ASGNI4
line 1245
;1245:		cgs.media.flagShader[0] = trap_R_RegisterShaderNoMip("icons/iconf_neutral1");
ADDRGP4 $1110
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+72
ADDRLP4 488
INDIRI4
ASGNI4
line 1246
;1246:		cgs.media.flagShader[1] = trap_R_RegisterShaderNoMip("icons/iconf_red2");
ADDRGP4 $1061
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+72+4
ADDRLP4 492
INDIRI4
ASGNI4
line 1247
;1247:		cgs.media.flagShader[2] = trap_R_RegisterShaderNoMip("icons/iconf_blu2");
ADDRGP4 $1072
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+72+8
ADDRLP4 496
INDIRI4
ASGNI4
line 1248
;1248:		cgs.media.flagShader[3] = trap_R_RegisterShaderNoMip("icons/iconf_neutral3");
ADDRGP4 $1120
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+72+12
ADDRLP4 500
INDIRI4
ASGNI4
line 1249
;1249:	}
LABELV $1101
line 1251
;1250:
;1251:	if (cgs.gametype == GT_OBELISK || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 6
EQI4 $1125
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1121
LABELV $1125
line 1252
;1252:		cgs.media.rocketExplosionShader = trap_R_RegisterShader("rocketExplosion");
ADDRGP4 $1128
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+624
ADDRLP4 484
INDIRI4
ASGNI4
line 1253
;1253:		cgs.media.overloadBaseModel = trap_R_RegisterModel("models/powerups/overload_base.md3");
ADDRGP4 $1131
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+152
ADDRLP4 488
INDIRI4
ASGNI4
line 1254
;1254:		cgs.media.overloadTargetModel = trap_R_RegisterModel("models/powerups/overload_target.md3");
ADDRGP4 $1134
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+156
ADDRLP4 492
INDIRI4
ASGNI4
line 1255
;1255:		cgs.media.overloadLightsModel = trap_R_RegisterModel("models/powerups/overload_lights.md3");
ADDRGP4 $1137
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+160
ADDRLP4 496
INDIRI4
ASGNI4
line 1256
;1256:		cgs.media.overloadEnergyModel = trap_R_RegisterModel("models/powerups/overload_energy.md3");
ADDRGP4 $1140
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+164
ADDRLP4 500
INDIRI4
ASGNI4
line 1257
;1257:	}
LABELV $1121
line 1259
;1258:
;1259:	if (cgs.gametype == GT_HARVESTER || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 7
EQI4 $1145
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1141
LABELV $1145
line 1260
;1260:		cgs.media.harvesterModel = trap_R_RegisterModel("models/powerups/harvester/harvester.md3");
ADDRGP4 $1148
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+168
ADDRLP4 484
INDIRI4
ASGNI4
line 1261
;1261:		cgs.media.harvesterRedSkin = trap_R_RegisterSkin("models/powerups/harvester/red.skin");
ADDRGP4 $1151
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+180268+172
ADDRLP4 488
INDIRI4
ASGNI4
line 1262
;1262:		cgs.media.harvesterBlueSkin = trap_R_RegisterSkin("models/powerups/harvester/blue.skin");
ADDRGP4 $1154
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+180268+176
ADDRLP4 492
INDIRI4
ASGNI4
line 1263
;1263:		cgs.media.harvesterNeutralModel = trap_R_RegisterModel("models/powerups/obelisk/obelisk.md3");
ADDRGP4 $1157
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+180
ADDRLP4 496
INDIRI4
ASGNI4
line 1264
;1264:	}
LABELV $1141
line 1266
;1265:
;1266:	cgs.media.redKamikazeShader = trap_R_RegisterShader("models/weaphits/kamikred");
ADDRGP4 $1160
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+576
ADDRLP4 484
INDIRI4
ASGNI4
line 1267
;1267:	cgs.media.dustPuffShader = trap_R_RegisterShader("hasteSmokePuff");
ADDRGP4 $975
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+692
ADDRLP4 488
INDIRI4
ASGNI4
line 1269
;1268:
;1269:	if (CG_IsATeamGametype(cgs.gametype) || cg_buildScript.integer) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 492
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 496
CNSTI4 0
ASGNI4
ADDRLP4 492
INDIRI4
ADDRLP4 496
INDIRI4
NEI4 $1167
ADDRGP4 cg_buildScript+12
INDIRI4
ADDRLP4 496
INDIRI4
EQI4 $1163
LABELV $1167
line 1271
;1270:
;1271:		cgs.media.friendShader = trap_R_RegisterShader("sprites/foe");
ADDRGP4 $1170
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+264
ADDRLP4 500
INDIRI4
ASGNI4
line 1272
;1272:		cgs.media.redQuadShader = trap_R_RegisterShader("powerups/blueflag");
ADDRGP4 $1173
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+548
ADDRLP4 504
INDIRI4
ASGNI4
line 1274
;1273:		//cgs.media.teamStatusBar = trap_R_RegisterShader( "gfx/2d/colorbar.tga" ); - moved outside, used by accuracy
;1274:		cgs.media.blueKamikazeShader = trap_R_RegisterShader("models/weaphits/kamikblu");
ADDRGP4 $1176
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+580
ADDRLP4 508
INDIRI4
ASGNI4
line 1275
;1275:	}
LABELV $1163
line 1276
;1276:	cgs.media.teamStatusBar = trap_R_RegisterShader("gfx/2d/colorbar.tga");
ADDRGP4 $1179
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+192
ADDRLP4 500
INDIRI4
ASGNI4
line 1278
;1277:
;1278:	cgs.media.armorModel = trap_R_RegisterModel("models/powerups/armor/armor_yel.md3");
ADDRGP4 $1182
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+184
ADDRLP4 504
INDIRI4
ASGNI4
line 1279
;1279:	cgs.media.armorIcon = trap_R_RegisterShaderNoMip("icons/iconr_yellow");
ADDRGP4 $1185
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+188
ADDRLP4 508
INDIRI4
ASGNI4
line 1281
;1280:
;1281:	cgs.media.machinegunBrassModel = trap_R_RegisterModel("models/weapons2/shells/m_shell.md3");
ADDRGP4 $1188
ARGP4
ADDRLP4 512
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+244
ADDRLP4 512
INDIRI4
ASGNI4
line 1282
;1282:	cgs.media.shotgunBrassModel = trap_R_RegisterModel("models/weapons2/shells/s_shell.md3");
ADDRGP4 $1191
ARGP4
ADDRLP4 516
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+248
ADDRLP4 516
INDIRI4
ASGNI4
line 1284
;1283:
;1284:	cgs.media.gibAbdomen = trap_R_RegisterModel("models/gibs/abdomen.md3");
ADDRGP4 $1194
ARGP4
ADDRLP4 520
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+200
ADDRLP4 520
INDIRI4
ASGNI4
line 1285
;1285:	cgs.media.gibArm = trap_R_RegisterModel("models/gibs/arm.md3");
ADDRGP4 $1197
ARGP4
ADDRLP4 524
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+204
ADDRLP4 524
INDIRI4
ASGNI4
line 1286
;1286:	cgs.media.gibChest = trap_R_RegisterModel("models/gibs/chest.md3");
ADDRGP4 $1200
ARGP4
ADDRLP4 528
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+208
ADDRLP4 528
INDIRI4
ASGNI4
line 1287
;1287:	cgs.media.gibFist = trap_R_RegisterModel("models/gibs/fist.md3");
ADDRGP4 $1203
ARGP4
ADDRLP4 532
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+212
ADDRLP4 532
INDIRI4
ASGNI4
line 1288
;1288:	cgs.media.gibFoot = trap_R_RegisterModel("models/gibs/foot.md3");
ADDRGP4 $1206
ARGP4
ADDRLP4 536
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+216
ADDRLP4 536
INDIRI4
ASGNI4
line 1289
;1289:	cgs.media.gibForearm = trap_R_RegisterModel("models/gibs/forearm.md3");
ADDRGP4 $1209
ARGP4
ADDRLP4 540
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+220
ADDRLP4 540
INDIRI4
ASGNI4
line 1290
;1290:	cgs.media.gibIntestine = trap_R_RegisterModel("models/gibs/intestine.md3");
ADDRGP4 $1212
ARGP4
ADDRLP4 544
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+224
ADDRLP4 544
INDIRI4
ASGNI4
line 1291
;1291:	cgs.media.gibLeg = trap_R_RegisterModel("models/gibs/leg.md3");
ADDRGP4 $1215
ARGP4
ADDRLP4 548
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+228
ADDRLP4 548
INDIRI4
ASGNI4
line 1292
;1292:	cgs.media.gibSkull = trap_R_RegisterModel("models/gibs/skull.md3");
ADDRGP4 $1218
ARGP4
ADDRLP4 552
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+232
ADDRLP4 552
INDIRI4
ASGNI4
line 1293
;1293:	cgs.media.gibBrain = trap_R_RegisterModel("models/gibs/brain.md3");
ADDRGP4 $1221
ARGP4
ADDRLP4 556
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+236
ADDRLP4 556
INDIRI4
ASGNI4
line 1295
;1294:
;1295:	cgs.media.smoke2 = trap_R_RegisterModel("models/weapons2/shells/s_shell.md3");
ADDRGP4 $1191
ARGP4
ADDRLP4 560
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+240
ADDRLP4 560
INDIRI4
ASGNI4
line 1297
;1296:
;1297:	cgs.media.balloonShader = trap_R_RegisterShader("sprites/balloon3");
ADDRGP4 $1226
ARGP4
ADDRLP4 564
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+268
ADDRLP4 564
INDIRI4
ASGNI4
line 1299
;1298:
;1299:	cgs.media.bloodExplosionShader = trap_R_RegisterShader("bloodExplosion");
ADDRGP4 $1229
ARGP4
ADDRLP4 568
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+636
ADDRLP4 568
INDIRI4
ASGNI4
line 1301
;1300:
;1301:	cgs.media.bulletFlashModel = trap_R_RegisterModel("models/weaphits/bullet.md3");
ADDRGP4 $1232
ARGP4
ADDRLP4 572
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+596
ADDRLP4 572
INDIRI4
ASGNI4
line 1302
;1302:	cgs.media.ringFlashModel = trap_R_RegisterModel("models/weaphits/ring02.md3");
ADDRGP4 $1235
ARGP4
ADDRLP4 576
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+600
ADDRLP4 576
INDIRI4
ASGNI4
line 1303
;1303:	cgs.media.dishFlashModel = trap_R_RegisterModel("models/weaphits/boom01.md3");
ADDRGP4 $1238
ARGP4
ADDRLP4 580
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+604
ADDRLP4 580
INDIRI4
ASGNI4
line 1307
;1304:#ifdef MISSIONPACK
;1305:	cgs.media.teleportEffectModel = trap_R_RegisterModel("models/powerups/pop.md3");
;1306:#else
;1307:	cgs.media.teleportEffectModel = trap_R_RegisterModel("models/misc/telep.md3");
ADDRGP4 $1241
ARGP4
ADDRLP4 584
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+640
ADDRLP4 584
INDIRI4
ASGNI4
line 1308
;1308:	cgs.media.teleportEffectShader = trap_R_RegisterShader("teleportEffect");
ADDRGP4 $1244
ARGP4
ADDRLP4 588
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+644
ADDRLP4 588
INDIRI4
ASGNI4
line 1316
;1309:#endif
;1310:	// loadingscreen
;1311:#ifdef SCRIPTHUD
;1312:	CG_UpdateGraphicFraction(0.20f);
;1313:	CG_UpdateMediaFraction(0.66f);
;1314:#endif
;1315:	// end loadingscreen
;1316:	cgs.media.kamikazeEffectModel = trap_R_RegisterModel("models/weaphits/kamboom2.md3");
ADDRGP4 $1247
ARGP4
ADDRLP4 592
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+648
ADDRLP4 592
INDIRI4
ASGNI4
line 1317
;1317:	cgs.media.kamikazeShockWave = trap_R_RegisterModel("models/weaphits/kamwave.md3");
ADDRGP4 $1250
ARGP4
ADDRLP4 596
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+652
ADDRLP4 596
INDIRI4
ASGNI4
line 1318
;1318:	cgs.media.kamikazeHeadModel = trap_R_RegisterModel("models/powerups/kamikazi.md3");
ADDRGP4 $1253
ARGP4
ADDRLP4 600
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+656
ADDRLP4 600
INDIRI4
ASGNI4
line 1319
;1319:	cgs.media.kamikazeHeadTrail = trap_R_RegisterModel("models/powerups/trailtest.md3");
ADDRGP4 $1256
ARGP4
ADDRLP4 604
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+660
ADDRLP4 604
INDIRI4
ASGNI4
line 1320
;1320:	cgs.media.guardPowerupModel = trap_R_RegisterModel("models/powerups/guard_player.md3");
ADDRGP4 $1259
ARGP4
ADDRLP4 608
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+664
ADDRLP4 608
INDIRI4
ASGNI4
line 1321
;1321:	cgs.media.scoutPowerupModel = trap_R_RegisterModel("models/powerups/scout_player.md3");
ADDRGP4 $1262
ARGP4
ADDRLP4 612
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+668
ADDRLP4 612
INDIRI4
ASGNI4
line 1322
;1322:	cgs.media.doublerPowerupModel = trap_R_RegisterModel("models/powerups/doubler_player.md3");
ADDRGP4 $1265
ARGP4
ADDRLP4 616
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+672
ADDRLP4 616
INDIRI4
ASGNI4
line 1323
;1323:	cgs.media.ammoRegenPowerupModel = trap_R_RegisterModel("models/powerups/ammo_player.md3");
ADDRGP4 $1268
ARGP4
ADDRLP4 620
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+676
ADDRLP4 620
INDIRI4
ASGNI4
line 1324
;1324:	cgs.media.invulnerabilityImpactModel = trap_R_RegisterModel("models/powerups/shield/impact.md3");
ADDRGP4 $1271
ARGP4
ADDRLP4 624
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+680
ADDRLP4 624
INDIRI4
ASGNI4
line 1325
;1325:	cgs.media.invulnerabilityJuicedModel = trap_R_RegisterModel("models/powerups/shield/juicer.md3");
ADDRGP4 $1274
ARGP4
ADDRLP4 628
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+684
ADDRLP4 628
INDIRI4
ASGNI4
line 1326
;1326:	cgs.media.medkitUsageModel = trap_R_RegisterModel("models/powerups/regen.md3");
ADDRGP4 $1277
ARGP4
ADDRLP4 632
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+688
ADDRLP4 632
INDIRI4
ASGNI4
line 1327
;1327:	cgs.media.heartShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/selectedhealth.tga");
ADDRGP4 $1280
ARGP4
ADDRLP4 636
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+696
ADDRLP4 636
INDIRI4
ASGNI4
line 1336
;1328:
;1329:	// loadingscreen
;1330:#ifdef SCRIPTHUD
;1331:	CG_UpdateGraphicFraction(0.70f);
;1332:	CG_UpdateMediaFraction(0.85f);
;1333:#endif
;1334:	// end loadingscreen
;1335:
;1336:	cgs.media.invulnerabilityPowerupModel = trap_R_RegisterModel("models/powerups/shield/shield.md3");
ADDRGP4 $1283
ARGP4
ADDRLP4 640
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+180268+700
ADDRLP4 640
INDIRI4
ASGNI4
line 1337
;1337:	cgs.media.medalImpressive = trap_R_RegisterShaderNoMip("medal_impressive");
ADDRGP4 $1286
ARGP4
ADDRLP4 644
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+720
ADDRLP4 644
INDIRI4
ASGNI4
line 1338
;1338:	cgs.media.medalExcellent = trap_R_RegisterShaderNoMip("medal_excellent");
ADDRGP4 $1289
ARGP4
ADDRLP4 648
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+724
ADDRLP4 648
INDIRI4
ASGNI4
line 1339
;1339:	cgs.media.medalGauntlet = trap_R_RegisterShaderNoMip("medal_gauntlet");
ADDRGP4 $1292
ARGP4
ADDRLP4 652
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+728
ADDRLP4 652
INDIRI4
ASGNI4
line 1340
;1340:	cgs.media.medalDefend = trap_R_RegisterShaderNoMip("medal_defend");
ADDRGP4 $1295
ARGP4
ADDRLP4 656
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+732
ADDRLP4 656
INDIRI4
ASGNI4
line 1341
;1341:	cgs.media.medalAssist = trap_R_RegisterShaderNoMip("medal_assist");
ADDRGP4 $1298
ARGP4
ADDRLP4 660
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+736
ADDRLP4 660
INDIRI4
ASGNI4
line 1342
;1342:	cgs.media.medalCapture = trap_R_RegisterShaderNoMip("medal_capture");
ADDRGP4 $1301
ARGP4
ADDRLP4 664
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+740
ADDRLP4 664
INDIRI4
ASGNI4
line 1345
;1343:
;1344:	// LEILEI SHADERS
;1345:	cgs.media.lsmkShader1 = trap_R_RegisterShader("leismoke1");
ADDRGP4 $1304
ARGP4
ADDRLP4 668
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+364
ADDRLP4 668
INDIRI4
ASGNI4
line 1346
;1346:	cgs.media.lsmkShader2 = trap_R_RegisterShader("leismoke2");
ADDRGP4 $1307
ARGP4
ADDRLP4 672
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+368
ADDRLP4 672
INDIRI4
ASGNI4
line 1347
;1347:	cgs.media.lsmkShader3 = trap_R_RegisterShader("leismoke3");
ADDRGP4 $1310
ARGP4
ADDRLP4 676
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+372
ADDRLP4 676
INDIRI4
ASGNI4
line 1348
;1348:	cgs.media.lsmkShader4 = trap_R_RegisterShader("leismoke4");
ADDRGP4 $1313
ARGP4
ADDRLP4 680
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+376
ADDRLP4 680
INDIRI4
ASGNI4
line 1350
;1349:
;1350:	cgs.media.lsplShader = trap_R_RegisterShader("leisplash");
ADDRGP4 $1316
ARGP4
ADDRLP4 684
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+388
ADDRLP4 684
INDIRI4
ASGNI4
line 1351
;1351:	cgs.media.lspkShader1 = trap_R_RegisterShader("leispark");
ADDRGP4 $1319
ARGP4
ADDRLP4 688
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+392
ADDRLP4 688
INDIRI4
ASGNI4
line 1352
;1352:	cgs.media.lspkShader2 = trap_R_RegisterShader("leispark2");
ADDRGP4 $1322
ARGP4
ADDRLP4 692
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+396
ADDRLP4 692
INDIRI4
ASGNI4
line 1353
;1353:	cgs.media.lbumShader1 = trap_R_RegisterShader("leiboom1");
ADDRGP4 $1325
ARGP4
ADDRLP4 696
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+380
ADDRLP4 696
INDIRI4
ASGNI4
line 1354
;1354:	cgs.media.lfblShader1 = trap_R_RegisterShader("leifball");
ADDRGP4 $1328
ARGP4
ADDRLP4 700
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+384
ADDRLP4 700
INDIRI4
ASGNI4
line 1356
;1355:
;1356:	cgs.media.lbldShader1 = trap_R_RegisterShader("leiblood1");
ADDRGP4 $1331
ARGP4
ADDRLP4 704
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+400
ADDRLP4 704
INDIRI4
ASGNI4
line 1357
;1357:	cgs.media.lbldShader2 = trap_R_RegisterShader("leiblood2"); // this is a mark, by the way
ADDRGP4 $1334
ARGP4
ADDRLP4 708
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+404
ADDRLP4 708
INDIRI4
ASGNI4
line 1360
;1358:
;1359:	// New Bullet Marks
;1360:	cgs.media.lmarkmetal1 = trap_R_RegisterShader("leimetalmark1");
ADDRGP4 $1337
ARGP4
ADDRLP4 712
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+412
ADDRLP4 712
INDIRI4
ASGNI4
line 1361
;1361:	cgs.media.lmarkmetal2 = trap_R_RegisterShader("leimetalmark2");
ADDRGP4 $1340
ARGP4
ADDRLP4 716
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+416
ADDRLP4 716
INDIRI4
ASGNI4
line 1362
;1362:	cgs.media.lmarkmetal3 = trap_R_RegisterShader("leimetalmark3");
ADDRGP4 $1343
ARGP4
ADDRLP4 720
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+420
ADDRLP4 720
INDIRI4
ASGNI4
line 1363
;1363:	cgs.media.lmarkmetal4 = trap_R_RegisterShader("leimetalmark4");
ADDRGP4 $1346
ARGP4
ADDRLP4 724
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+424
ADDRLP4 724
INDIRI4
ASGNI4
line 1364
;1364:	cgs.media.lmarkbullet1 = trap_R_RegisterShader("leibulletmark1");
ADDRGP4 $1349
ARGP4
ADDRLP4 728
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+428
ADDRLP4 728
INDIRI4
ASGNI4
line 1365
;1365:	cgs.media.lmarkbullet2 = trap_R_RegisterShader("leibulletmark2");
ADDRGP4 $1352
ARGP4
ADDRLP4 732
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+432
ADDRLP4 732
INDIRI4
ASGNI4
line 1366
;1366:	cgs.media.lmarkbullet3 = trap_R_RegisterShader("leibulletmark3");
ADDRGP4 $1355
ARGP4
ADDRLP4 736
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+436
ADDRLP4 736
INDIRI4
ASGNI4
line 1367
;1367:	cgs.media.lmarkbullet4 = trap_R_RegisterShader("leibulletmark4");
ADDRGP4 $1358
ARGP4
ADDRLP4 740
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+440
ADDRLP4 740
INDIRI4
ASGNI4
line 1370
;1368:
;1369:
;1370:	memset(cg_items, 0, sizeof ( cg_items));
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 6144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1371
;1371:	memset(cg_weapons, 0, sizeof ( cg_weapons));
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2752
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1374
;1372:
;1373:	// only register the items that the server says we need
;1374:	Q_strncpyz(items, CG_ConfigString(CS_ITEMS), sizeof (items));
CNSTI4 27
ARGI4
ADDRLP4 744
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 744
INDIRP4
ARGP4
CNSTI4 257
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1376
;1375:
;1376:	for (i = 1; i < bg_numItems; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1362
JUMPV
LABELV $1359
line 1377
;1377:		if (items[ i ] == '1' || cg_buildScript.integer) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 49
EQI4 $1366
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1363
LABELV $1366
line 1378
;1378:			CG_LoadingItem(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingItem
CALLV
pop
line 1379
;1379:			CG_RegisterItemVisuals(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1380
;1380:		}
LABELV $1363
line 1381
;1381:	}
LABELV $1360
line 1376
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1362
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $1359
line 1384
;1382:
;1383:	// wall marks
;1384:	cgs.media.bulletMarkShader = trap_R_RegisterShader("gfx/damage/bullet_mrk");
ADDRGP4 $1369
ARGP4
ADDRLP4 748
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+528
ADDRLP4 748
INDIRI4
ASGNI4
line 1385
;1385:	cgs.media.burnMarkShader = trap_R_RegisterShader("gfx/damage/burn_med_mrk");
ADDRGP4 $1372
ARGP4
ADDRLP4 752
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+532
ADDRLP4 752
INDIRI4
ASGNI4
line 1386
;1386:	cgs.media.holeMarkShader = trap_R_RegisterShader("gfx/damage/hole_lg_mrk");
ADDRGP4 $1375
ARGP4
ADDRLP4 756
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+536
ADDRLP4 756
INDIRI4
ASGNI4
line 1387
;1387:	cgs.media.energyMarkShader = trap_R_RegisterShader("gfx/damage/plasma_mrk");
ADDRGP4 $1378
ARGP4
ADDRLP4 760
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+540
ADDRLP4 760
INDIRI4
ASGNI4
line 1388
;1388:	cgs.media.shadowMarkShader = trap_R_RegisterShader("markShadow");
ADDRGP4 $1381
ARGP4
ADDRLP4 764
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+496
ADDRLP4 764
INDIRI4
ASGNI4
line 1389
;1389:	cgs.media.wakeMarkShader = trap_R_RegisterShader("wake");
ADDRGP4 $1384
ARGP4
ADDRLP4 768
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+520
ADDRLP4 768
INDIRI4
ASGNI4
line 1390
;1390:	cgs.media.bloodMarkShader = trap_R_RegisterShader("bloodMark");
ADDRGP4 $1387
ARGP4
ADDRLP4 772
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+524
ADDRLP4 772
INDIRI4
ASGNI4
line 1393
;1391:
;1392:	// register the inline models
;1393:	cgs.numInlineModels = trap_CM_NumInlineModels();
ADDRLP4 776
ADDRGP4 trap_CM_NumInlineModels
CALLI4
ASGNI4
ADDRGP4 cgs+37052
ADDRLP4 776
INDIRI4
ASGNI4
line 1394
;1394:	for (i = 1; i < cgs.numInlineModels; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1392
JUMPV
LABELV $1389
line 1399
;1395:		char name[10];
;1396:		vec3_t mins, maxs;
;1397:		int j;
;1398:
;1399:		Com_sprintf(name, sizeof (name), "*%i", i);
ADDRLP4 808
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $1394
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1400
;1400:		cgs.inlineDrawModel[i] = trap_R_RegisterModel(name);
ADDRLP4 808
ARGP4
ADDRLP4 820
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37056
ADDP4
ADDRLP4 820
INDIRI4
ASGNI4
line 1401
;1401:		trap_R_ModelBounds(cgs.inlineDrawModel[i], mins, maxs);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37056
ADDP4
INDIRI4
ARGI4
ADDRLP4 784
ARGP4
ADDRLP4 796
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 1402
;1402:		for (j = 0; j < 3; j++) {
ADDRLP4 780
CNSTI4 0
ASGNI4
LABELV $1397
line 1403
;1403:			cgs.inlineModelMidpoints[i][j] = mins[j] + 0.5 * (maxs[j] - mins[j]);
ADDRLP4 824
ADDRLP4 780
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 828
ADDRLP4 824
INDIRI4
ADDRLP4 784
ADDP4
INDIRF4
ASGNF4
ADDRLP4 824
INDIRI4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+38080
ADDP4
ADDP4
ADDRLP4 828
INDIRF4
CNSTF4 1056964608
ADDRLP4 824
INDIRI4
ADDRLP4 796
ADDP4
INDIRF4
ADDRLP4 828
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1404
;1404:		}
LABELV $1398
line 1402
ADDRLP4 780
ADDRLP4 780
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 780
INDIRI4
CNSTI4 3
LTI4 $1397
line 1405
;1405:	}
LABELV $1390
line 1394
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1392
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+37052
INDIRI4
LTI4 $1389
line 1408
;1406:
;1407:	// register all the server specified models
;1408:	for (i = 1; i < MAX_MODELS; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $1402
line 1411
;1409:		const char *modelName;
;1410:
;1411:		modelName = CG_ConfigString(CS_MODELS + i);
ADDRLP4 0
INDIRI4
CNSTI4 32
ADDI4
ARGI4
ADDRLP4 784
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 780
ADDRLP4 784
INDIRP4
ASGNP4
line 1412
;1412:		if (!modelName[0]) {
ADDRLP4 780
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1406
line 1413
;1413:			break;
ADDRGP4 $1404
JUMPV
LABELV $1406
line 1415
;1414:		}
;1415:		cgs.gameModels[i] = trap_R_RegisterModel(modelName);
ADDRLP4 780
INDIRP4
ARGP4
ADDRLP4 788
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35004
ADDP4
ADDRLP4 788
INDIRI4
ASGNI4
line 1416
;1416:	}
LABELV $1403
line 1408
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $1402
LABELV $1404
line 1455
;1417:
;1418:#ifdef MISSIONPACK
;1419:	// new stuff
;1420:	cgs.media.patrolShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/patrol.tga");
;1421:	cgs.media.assaultShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/assault.tga");
;1422:	cgs.media.campShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/camp.tga");
;1423:	cgs.media.followShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/follow.tga");
;1424:	cgs.media.defendShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/defend.tga");
;1425:	cgs.media.teamLeaderShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/team_leader.tga");
;1426:	cgs.media.retrieveShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/retrieve.tga");
;1427:	cgs.media.escortShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/escort.tga");
;1428:	cgs.media.deathShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/death.tga");
;1429:
;1430:	cgs.media.cursor = trap_R_RegisterShaderNoMip("menu/art/3_cursor2");
;1431:	cgs.media.sizeCursor = trap_R_RegisterShaderNoMip("ui/assets/sizecursor.tga");
;1432:	cgs.media.selectCursor = trap_R_RegisterShaderNoMip("ui/assets/selectcursor.tga");
;1433:	cgs.media.flagShaders[0] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_in_base.tga");
;1434:	cgs.media.flagShaders[1] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_capture.tga");
;1435:	cgs.media.flagShaders[2] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_missing.tga");
;1436:
;1437:	trap_R_RegisterModel("models/players/sorceress/lower.mdr");
;1438:	trap_R_RegisterModel("models/players/sorceress/upper.mdr");
;1439:	trap_R_RegisterModel("models/players/sorceress/head.md3");
;1440:
;1441:#endif
;1442:	//	CG_ClearParticles ();
;1443:	/*
;1444:		for (i=1; i<MAX_PARTICLES_AREAS; i++)
;1445:		{
;1446:			{
;1447:				int rval;
;1448:
;1449:				rval = CG_NewParticleArea ( CS_PARTICLES + i);
;1450:				if (!rval)
;1451:					break;
;1452:			}
;1453:		}
;1454:	 */
;1455:}
LABELV $795
endproc CG_RegisterGraphics 832 16
export CG_BuildSpectatorString
proc CG_BuildSpectatorString 12 12
line 1463
;1456:
;1457:/*																																			
;1458:=======================
;1459:CG_BuildSpectatorString
;1460:
;1461:=======================
;1462: */
;1463:void CG_BuildSpectatorString(void) {
line 1465
;1464:	int i;
;1465:	cg.spectatorList[0] = 0;
ADDRGP4 cg+114956
CNSTI1 0
ASGNI1
line 1466
;1466:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1411
line 1467
;1467:		if (cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_SPECTATOR) {
ADDRLP4 4
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+41152
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1415
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+41152+68
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1415
line 1468
;1468:			Q_strcat(cg.spectatorList, sizeof (cg.spectatorList), va("%s     ", cgs.clientinfo[i].name));
ADDRGP4 $1422
ARGP4
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152+4
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 cg+114956
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1469
;1469:		}
LABELV $1415
line 1470
;1470:	}
LABELV $1412
line 1466
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1411
line 1471
;1471:	i = strlen(cg.spectatorList);
ADDRGP4 cg+114956
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1472
;1472:	if (i != cg.spectatorLen) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+115980
INDIRI4
EQI4 $1426
line 1473
;1473:		cg.spectatorLen = i;
ADDRGP4 cg+115980
ADDRLP4 0
INDIRI4
ASGNI4
line 1474
;1474:		cg.spectatorWidth = -1;
ADDRGP4 cg+115984
CNSTF4 3212836864
ASGNF4
line 1475
;1475:	}
LABELV $1426
line 1476
;1476:}
LABELV $1409
endproc CG_BuildSpectatorString 12 12
proc CG_RegisterClients 12 4
line 1483
;1477:
;1478:/*																																			
;1479:===================
;1480:CG_RegisterClients
;1481:===================
;1482: */
;1483:static void CG_RegisterClients(void) {
line 1486
;1484:	int i;
;1485:
;1486:	CG_LoadingClient(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 1487
;1487:	CG_NewClientInfo(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 1489
;1488:
;1489:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1434
line 1492
;1490:		const char *clientInfo;
;1491:
;1492:		if (cg.clientNum == i) {
ADDRGP4 cg+4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1438
line 1493
;1493:			continue;
ADDRGP4 $1435
JUMPV
LABELV $1438
line 1496
;1494:		}
;1495:
;1496:		clientInfo = CG_ConfigString(CS_PLAYERS + i);
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1497
;1497:		if (!clientInfo[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1441
line 1498
;1498:			continue;
ADDRGP4 $1435
JUMPV
LABELV $1441
line 1500
;1499:		}
;1500:		CG_LoadingClient(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 1501
;1501:		CG_NewClientInfo(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 1502
;1502:	}
LABELV $1435
line 1489
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1434
line 1503
;1503:	CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 1504
;1504:}
LABELV $1431
endproc CG_RegisterClients 12 4
export CG_ConfigString
proc CG_ConfigString 4 8
line 1513
;1505:
;1506://===========================================================================
;1507:
;1508:/*
;1509:=================
;1510:CG_ConfigString
;1511:=================
;1512: */
;1513:const char *CG_ConfigString(int index) {
line 1514
;1514:	if (index < 0 || index >= MAX_CONFIGSTRINGS) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1446
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $1444
LABELV $1446
line 1515
;1515:		CG_Error("CG_ConfigString: bad index: %i", index);
ADDRGP4 $1447
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1516
;1516:	}
LABELV $1444
line 1517
;1517:	return cgs.gameState.stringData + cgs.gameState.stringOffsets[ index ];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs
ADDP4
INDIRI4
ADDRGP4 cgs+4096
ADDP4
RETP4
LABELV $1443
endproc CG_ConfigString 4 8
export CG_StartMusic
proc CG_StartMusic 148 12
line 1528
;1518:}
;1519:
;1520://==================================================================
;1521:
;1522:/*
;1523:======================
;1524:CG_StartMusic
;1525:
;1526:======================
;1527: */
;1528:void CG_StartMusic(void) {
line 1533
;1529:	char *s;
;1530:	char parm1[MAX_QPATH], parm2[MAX_QPATH];
;1531:
;1532:	// start the background music
;1533:	if (*cg_music.string && !Q_strequal(cg_music.string, "none")) {
ADDRGP4 cg_music+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1450
ADDRGP4 cg_music+16
ARGP4
ADDRGP4 $1454
ARGP4
ADDRLP4 132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $1450
line 1534
;1534:		s = (char *) cg_music.string;
ADDRLP4 0
ADDRGP4 cg_music+16
ASGNP4
line 1535
;1535:	} else {
ADDRGP4 $1451
JUMPV
LABELV $1450
line 1536
;1536:		s = (char *) CG_ConfigString(CS_MUSIC);
CNSTI4 2
ARGI4
ADDRLP4 136
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 136
INDIRP4
ASGNP4
line 1537
;1537:		Q_strncpyz(parm1, COM_Parse(&s), sizeof ( parm1));
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1538
;1538:		Q_strncpyz(parm2, COM_Parse(&s), sizeof ( parm2));
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 68
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1540
;1539:
;1540:		trap_S_StartBackgroundTrack(parm1, parm2);
ADDRLP4 4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 trap_S_StartBackgroundTrack
CALLV
pop
line 1541
;1541:	}
LABELV $1451
line 1542
;1542:}
LABELV $1449
endproc CG_StartMusic 148 12
export CG_GetCVar
proc CG_GetCVar 132 12
line 2218
;1543:#ifdef MISSIONPACK
;1544:
;1545:char *CG_GetMenuBuffer(const char *filename) {
;1546:	int len;
;1547:	fileHandle_t f;
;1548:	static char buf[MAX_MENUFILE];
;1549:
;1550:	len = trap_FS_FOpenFile(filename, &f, FS_READ);
;1551:	if (!f) {
;1552:		trap_Print(va(S_COLOR_RED "menu file not found: %s, using default\n", filename));
;1553:		return NULL;
;1554:	}
;1555:	if (len >= MAX_MENUFILE) {
;1556:		trap_Print(va(S_COLOR_RED "menu file too large: %s is %i, max allowed is %i\n", filename, len, MAX_MENUFILE));
;1557:		trap_FS_FCloseFile(f);
;1558:		return NULL;
;1559:	}
;1560:
;1561:	trap_FS_Read(buf, len, f);
;1562:	buf[len] = 0;
;1563:	trap_FS_FCloseFile(f);
;1564:
;1565:	return buf;
;1566:}
;1567:
;1568://
;1569:// ==============================
;1570:// new hud stuff ( mission pack )
;1571:// ==============================
;1572://
;1573:
;1574:qboolean CG_Asset_Parse(int handle) {
;1575:	pc_token_t token;
;1576:	const char *tempStr;
;1577:
;1578:	if (!trap_PC_ReadToken(handle, &token))
;1579:		return qfalse;
;1580:	if (Q_stricmp(token.string, "{") != 0) {
;1581:		return qfalse;
;1582:	}
;1583:
;1584:	while (1) {
;1585:		if (!trap_PC_ReadToken(handle, &token))
;1586:			return qfalse;
;1587:
;1588:		if (Q_stricmp(token.string, "}") == 0) {
;1589:			return qtrue;
;1590:		}
;1591:
;1592:		// font
;1593:		if (Q_stricmp(token.string, "font") == 0) {
;1594:			int pointSize;
;1595:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1596:				return qfalse;
;1597:			}
;1598:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.textFont);
;1599:			continue;
;1600:		}
;1601:
;1602:		// smallFont
;1603:		if (Q_stricmp(token.string, "smallFont") == 0) {
;1604:			int pointSize;
;1605:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1606:				return qfalse;
;1607:			}
;1608:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.smallFont);
;1609:			continue;
;1610:		}
;1611:
;1612:		// font
;1613:		if (Q_stricmp(token.string, "bigfont") == 0) {
;1614:			int pointSize;
;1615:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1616:				return qfalse;
;1617:			}
;1618:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.bigFont);
;1619:			continue;
;1620:		}
;1621:
;1622:		// gradientbar
;1623:		if (Q_stricmp(token.string, "gradientbar") == 0) {
;1624:			if (!PC_String_Parse(handle, &tempStr)) {
;1625:				return qfalse;
;1626:			}
;1627:			cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
;1628:			continue;
;1629:		}
;1630:
;1631:		// enterMenuSound
;1632:		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
;1633:			if (!PC_String_Parse(handle, &tempStr)) {
;1634:				return qfalse;
;1635:			}
;1636:			cgDC.Assets.menuEnterSound = trap_S_RegisterSound(tempStr, qfalse);
;1637:			continue;
;1638:		}
;1639:
;1640:		// exitMenuSound
;1641:		if (Q_stricmp(token.string, "menuExitSound") == 0) {
;1642:			if (!PC_String_Parse(handle, &tempStr)) {
;1643:				return qfalse;
;1644:			}
;1645:			cgDC.Assets.menuExitSound = trap_S_RegisterSound(tempStr, qfalse);
;1646:			continue;
;1647:		}
;1648:
;1649:		// itemFocusSound
;1650:		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
;1651:			if (!PC_String_Parse(handle, &tempStr)) {
;1652:				return qfalse;
;1653:			}
;1654:			cgDC.Assets.itemFocusSound = trap_S_RegisterSound(tempStr, qfalse);
;1655:			continue;
;1656:		}
;1657:
;1658:		// menuBuzzSound
;1659:		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
;1660:			if (!PC_String_Parse(handle, &tempStr)) {
;1661:				return qfalse;
;1662:			}
;1663:			cgDC.Assets.menuBuzzSound = trap_S_RegisterSound(tempStr, qfalse);
;1664:			continue;
;1665:		}
;1666:
;1667:		if (Q_stricmp(token.string, "cursor") == 0) {
;1668:			if (!PC_String_Parse(handle, &cgDC.Assets.cursorStr)) {
;1669:				return qfalse;
;1670:			}
;1671:			cgDC.Assets.cursor = trap_R_RegisterShaderNoMip(cgDC.Assets.cursorStr);
;1672:			continue;
;1673:		}
;1674:
;1675:		if (Q_stricmp(token.string, "fadeClamp") == 0) {
;1676:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeClamp)) {
;1677:				return qfalse;
;1678:			}
;1679:			continue;
;1680:		}
;1681:
;1682:		if (Q_stricmp(token.string, "fadeCycle") == 0) {
;1683:			if (!PC_Int_Parse(handle, &cgDC.Assets.fadeCycle)) {
;1684:				return qfalse;
;1685:			}
;1686:			continue;
;1687:		}
;1688:
;1689:		if (Q_stricmp(token.string, "fadeAmount") == 0) {
;1690:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeAmount)) {
;1691:				return qfalse;
;1692:			}
;1693:			continue;
;1694:		}
;1695:
;1696:		if (Q_stricmp(token.string, "shadowX") == 0) {
;1697:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowX)) {
;1698:				return qfalse;
;1699:			}
;1700:			continue;
;1701:		}
;1702:
;1703:		if (Q_stricmp(token.string, "shadowY") == 0) {
;1704:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowY)) {
;1705:				return qfalse;
;1706:			}
;1707:			continue;
;1708:		}
;1709:
;1710:		if (Q_stricmp(token.string, "shadowColor") == 0) {
;1711:			if (!PC_Color_Parse(handle, &cgDC.Assets.shadowColor)) {
;1712:				return qfalse;
;1713:			}
;1714:			cgDC.Assets.shadowFadeClamp = cgDC.Assets.shadowColor[3];
;1715:			continue;
;1716:		}
;1717:		// Changed RD SCRIPTHUD
;1718:		if (Q_stricmp(token.string, "scrollbarSize") == 0) {
;1719:			if (!PC_Float_Parse(handle, &cgDC.Assets.scrollbarsize)) {
;1720:				return qfalse;
;1721:			}
;1722:			continue;
;1723:		}
;1724:
;1725:		if (Q_stricmp(token.string, "sliderWidth") == 0) {
;1726:			if (!PC_Float_Parse(handle, &cgDC.Assets.sliderwidth)) {
;1727:				return qfalse;
;1728:			}
;1729:			continue;
;1730:		}
;1731:
;1732:		if (Q_stricmp(token.string, "sliderHeight") == 0) {
;1733:			if (!PC_Float_Parse(handle, &cgDC.Assets.sliderheight)) {
;1734:				return qfalse;
;1735:			}
;1736:			continue;
;1737:		}
;1738:
;1739:		if (Q_stricmp(token.string, "sliderthumbWidth") == 0) {
;1740:			if (!PC_Float_Parse(handle, &cgDC.Assets.sliderthumbwidth)) {
;1741:				return qfalse;
;1742:			}
;1743:			continue;
;1744:		}
;1745:
;1746:		if (Q_stricmp(token.string, "sliderthumbHeight") == 0) {
;1747:			if (!PC_Float_Parse(handle, &cgDC.Assets.sliderthumbheight)) {
;1748:				return qfalse;
;1749:			}
;1750:			continue;
;1751:		}
;1752:
;1753:		if (Q_stricmp(token.string, "sliderBar") == 0) {
;1754:			if (!PC_String_Parse(handle, &tempStr)) {
;1755:				return qfalse;
;1756:			}
;1757:			cgDC.Assets.sliderBar = trap_R_RegisterShaderNoMip(tempStr);
;1758:			continue;
;1759:		}
;1760:
;1761:		if (Q_stricmp(token.string, "sliderThumb") == 0) {
;1762:			if (!PC_String_Parse(handle, &tempStr)) {
;1763:				return qfalse;
;1764:			}
;1765:			cgDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip(tempStr);
;1766:			continue;
;1767:		}
;1768:
;1769:		if (Q_stricmp(token.string, "sliderThumbSel") == 0) {
;1770:			if (!PC_String_Parse(handle, &tempStr)) {
;1771:				return qfalse;
;1772:			}
;1773:			cgDC.Assets.sliderThumb_sel = trap_R_RegisterShaderNoMip(tempStr);
;1774:			continue;
;1775:		}
;1776:
;1777:		if (Q_stricmp(token.string, "scrollBarHorz") == 0) {
;1778:			if (!PC_String_Parse(handle, &tempStr)) {
;1779:				return qfalse;
;1780:			}
;1781:			cgDC.Assets.scrollBarHorz = trap_R_RegisterShaderNoMip(tempStr);
;1782:			continue;
;1783:		}
;1784:
;1785:		if (Q_stricmp(token.string, "scrollBarVert") == 0) {
;1786:			if (!PC_String_Parse(handle, &tempStr)) {
;1787:				return qfalse;
;1788:			}
;1789:			cgDC.Assets.scrollBarVert = trap_R_RegisterShaderNoMip(tempStr);
;1790:			continue;
;1791:		}
;1792:
;1793:		if (Q_stricmp(token.string, "scrollBarThumb") == 0) {
;1794:			if (!PC_String_Parse(handle, &tempStr)) {
;1795:				return qfalse;
;1796:			}
;1797:			cgDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip(tempStr);
;1798:			continue;
;1799:		}
;1800:
;1801:		if (Q_stricmp(token.string, "scrollBarArrowUp") == 0) {
;1802:			if (!PC_String_Parse(handle, &tempStr)) {
;1803:				return qfalse;
;1804:			}
;1805:			cgDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip(tempStr);
;1806:			continue;
;1807:		}
;1808:
;1809:		if (Q_stricmp(token.string, "scrollBarArrowDown") == 0) {
;1810:			if (!PC_String_Parse(handle, &tempStr)) {
;1811:				return qfalse;
;1812:			}
;1813:			cgDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip(tempStr);
;1814:			continue;
;1815:		}
;1816:
;1817:		if (Q_stricmp(token.string, "scrollBarArrowLeft") == 0) {
;1818:			if (!PC_String_Parse(handle, &tempStr)) {
;1819:				return qfalse;
;1820:			}
;1821:			cgDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip(tempStr);
;1822:			continue;
;1823:		}
;1824:
;1825:		if (Q_stricmp(token.string, "scrollBarArrowRight") == 0) {
;1826:			if (!PC_String_Parse(handle, &tempStr)) {
;1827:				return qfalse;
;1828:			}
;1829:			cgDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip(tempStr);
;1830:			continue;
;1831:		}
;1832:
;1833:		if (Q_stricmp(token.string, "fxBase") == 0) {
;1834:			if (!PC_String_Parse(handle, &tempStr)) {
;1835:				return qfalse;
;1836:			}
;1837:			cgDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip(tempStr);
;1838:			continue;
;1839:		}
;1840:
;1841:		if (Q_stricmp(token.string, "fxRed") == 0) {
;1842:			if (!PC_String_Parse(handle, &tempStr)) {
;1843:				return qfalse;
;1844:			}
;1845:			cgDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip(tempStr);
;1846:			continue;
;1847:		}
;1848:
;1849:		if (Q_stricmp(token.string, "fxYellow") == 0) {
;1850:			if (!PC_String_Parse(handle, &tempStr)) {
;1851:				return qfalse;
;1852:			}
;1853:			cgDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip(tempStr);
;1854:			continue;
;1855:		}
;1856:
;1857:		if (Q_stricmp(token.string, "fxGreen") == 0) {
;1858:			if (!PC_String_Parse(handle, &tempStr)) {
;1859:				return qfalse;
;1860:			}
;1861:			cgDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip(tempStr);
;1862:			continue;
;1863:		}
;1864:
;1865:		if (Q_stricmp(token.string, "fxTeal") == 0) {
;1866:			if (!PC_String_Parse(handle, &tempStr)) {
;1867:				return qfalse;
;1868:			}
;1869:			cgDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip(tempStr);
;1870:			continue;
;1871:		}
;1872:
;1873:		if (Q_stricmp(token.string, "fxBlue") == 0) {
;1874:			if (!PC_String_Parse(handle, &tempStr)) {
;1875:				return qfalse;
;1876:			}
;1877:			cgDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip(tempStr);
;1878:			continue;
;1879:		}
;1880:
;1881:		if (Q_stricmp(token.string, "fxCyan") == 0) {
;1882:			if (!PC_String_Parse(handle, &tempStr)) {
;1883:				return qfalse;
;1884:			}
;1885:			cgDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip(tempStr);
;1886:			continue;
;1887:		}
;1888:
;1889:		if (Q_stricmp(token.string, "fxWhite") == 0) {
;1890:			if (!PC_String_Parse(handle, &tempStr)) {
;1891:				return qfalse;
;1892:			}
;1893:			cgDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip(tempStr);
;1894:			continue;
;1895:		}
;1896:		// end changed RD SCRIPTHUD
;1897:	}
;1898:	return qfalse; // bk001204 - why not?
;1899:}
;1900:
;1901:void CG_ParseMenu(const char *menuFile) {
;1902:	pc_token_t token;
;1903:	int handle;
;1904:
;1905:	handle = trap_PC_LoadSource(menuFile);
;1906:	if (!handle)
;1907:		handle = trap_PC_LoadSource("ui/testhud.menu");
;1908:	if (!handle)
;1909:		return;
;1910:
;1911:	while (1) {
;1912:		if (!trap_PC_ReadToken(handle, &token)) {
;1913:			break;
;1914:		}
;1915:
;1916:		//if ( !Q_strequal( token, "{" ) ) {
;1917:		//	Com_Printf( "Missing { in menu file\n" );
;1918:		//	break;
;1919:		//}
;1920:
;1921:		//if ( menuCount == MAX_MENUS ) {
;1922:		//	Com_Printf( "Too many menus!\n" );
;1923:		//	break;
;1924:		//}
;1925:
;1926:		if (token.string[0] == '}') {
;1927:			break;
;1928:		}
;1929:
;1930:		if (Q_strequal(token.string, "assetGlobalDef")) {
;1931:			if (CG_Asset_Parse(handle)) {
;1932:				continue;
;1933:			} else {
;1934:				break;
;1935:			}
;1936:		}
;1937:
;1938:
;1939:		if (Q_strequal(token.string, "menudef")) {
;1940:			// start a new menu
;1941:			Menu_New(handle);
;1942:		}
;1943:	}
;1944:	trap_PC_FreeSource(handle);
;1945:}
;1946:
;1947:qboolean CG_Load_Menu(char **p) {
;1948:	char *token;
;1949:
;1950:	token = COM_ParseExt(p, qtrue);
;1951:
;1952:	if (token[0] != '{') {
;1953:		return qfalse;
;1954:	}
;1955:
;1956:	while (1) {
;1957:
;1958:		token = COM_ParseExt(p, qtrue);
;1959:
;1960:		if (Q_strequal(token, "}")) {
;1961:			return qtrue;
;1962:		}
;1963:
;1964:		if (!token[0]) {
;1965:			return qfalse;
;1966:		}
;1967:
;1968:		CG_ParseMenu(token);
;1969:	}
;1970:	return qfalse;
;1971:}
;1972:
;1973:void CG_LoadMenus(const char *menuFile) {
;1974:	char *token;
;1975:	char *p;
;1976:	int len, start;
;1977:	fileHandle_t f;
;1978:	static char buf[MAX_MENUDEFFILE];
;1979:
;1980:	start = trap_Milliseconds();
;1981:
;1982:	len = trap_FS_FOpenFile(menuFile, &f, FS_READ);
;1983:	if (!f) {
;1984:		trap_Error(va(S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile));
;1985:		len = trap_FS_FOpenFile("ui/hud.txt", &f, FS_READ);
;1986:		if (!f) {
;1987:			trap_Error(va(S_COLOR_RED "default menu file not found: ui/hud.txt, unable to continue!\n"));
;1988:		}
;1989:	}
;1990:
;1991:	if (len >= MAX_MENUDEFFILE) {
;1992:		trap_Error(va(S_COLOR_RED "menu file too large: %s is %i, max allowed is %i\n", menuFile, len, MAX_MENUDEFFILE));
;1993:		trap_FS_FCloseFile(f);
;1994:		return;
;1995:	}
;1996:
;1997:	trap_FS_Read(buf, len, f);
;1998:	buf[len] = 0;
;1999:	trap_FS_FCloseFile(f);
;2000:
;2001:	COM_Compress(buf);
;2002:
;2003:	Menu_Reset();
;2004:
;2005:	p = buf;
;2006:
;2007:	while (1) {
;2008:		token = COM_ParseExt(&p, qtrue);
;2009:		if (!token[0]) {
;2010:			break;
;2011:		}
;2012:
;2013:		if (Q_strequal(token, "}")) {
;2014:			break;
;2015:		}
;2016:
;2017:		if (Q_strequal(token, "loadmenu")) {
;2018:			if (CG_Load_Menu(&p)) {
;2019:				continue;
;2020:			} else {
;2021:				break;
;2022:			}
;2023:		}
;2024:	}
;2025:
;2026:	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);
;2027:
;2028:}
;2029:
;2030:static qboolean CG_OwnerDrawHandleKey(int ownerDraw, int flags, float *special, int key) {
;2031:	return qfalse;
;2032:}
;2033:
;2034:static int CG_FeederCount(float feederID) {
;2035:	int i, count;
;2036:	count = 0;
;2037:	if (feederID == FEEDER_REDTEAM_LIST) {
;2038:		for (i = 0; i < cg.numScores; i++) {
;2039:			if (cg.scores[i].team == TEAM_RED) {
;2040:				count++;
;2041:			}
;2042:		}
;2043:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
;2044:		for (i = 0; i < cg.numScores; i++) {
;2045:			if (cg.scores[i].team == TEAM_BLUE) {
;2046:				count++;
;2047:			}
;2048:		}
;2049:	} else if (feederID == FEEDER_SCOREBOARD) {
;2050:		return cg.numScores;
;2051:	}
;2052:	return count;
;2053:}
;2054:
;2055:void CG_SetScoreSelection(void *p) {
;2056:	menuDef_t *menu = (menuDef_t*) p;
;2057:	playerState_t *ps = &cg.snap->ps;
;2058:	int i, red, blue;
;2059:	red = blue = 0;
;2060:	for (i = 0; i < cg.numScores; i++) {
;2061:		if (cg.scores[i].team == TEAM_RED) {
;2062:			red++;
;2063:		} else if (cg.scores[i].team == TEAM_BLUE) {
;2064:			blue++;
;2065:		}
;2066:		if (ps->clientNum == cg.scores[i].client) {
;2067:			cg.selectedScore = i;
;2068:		}
;2069:	}
;2070:
;2071:	if (menu == NULL) {
;2072:		// just interested in setting the selected score
;2073:		return;
;2074:	}
;2075:
;2076:	if (CG_IsATeamGametype(cgs.gametype)) {
;2077:		int feeder = FEEDER_REDTEAM_LIST;
;2078:		i = red;
;2079:		if (cg.scores[cg.selectedScore].team == TEAM_BLUE) {
;2080:			feeder = FEEDER_BLUETEAM_LIST;
;2081:			i = blue;
;2082:		}
;2083:		Menu_SetFeederSelection(menu, feeder, i, NULL);
;2084:	} else {
;2085:		Menu_SetFeederSelection(menu, FEEDER_SCOREBOARD, cg.selectedScore, NULL);
;2086:	}
;2087:}
;2088:
;2089:// FIXME: might need to cache this info
;2090:
;2091:static clientInfo_t * CG_InfoFromScoreIndex(int index, int team, int *scoreIndex) {
;2092:	int i, count;
;2093:	if (CG_IsATeamGametype(cgs.gametype)) {
;2094:		count = 0;
;2095:		for (i = 0; i < cg.numScores; i++) {
;2096:			if (cg.scores[i].team == team) {
;2097:				if (count == index) {
;2098:					*scoreIndex = i;
;2099:					return &cgs.clientinfo[cg.scores[i].client];
;2100:				}
;2101:				count++;
;2102:			}
;2103:		}
;2104:	}
;2105:	*scoreIndex = index;
;2106:	return &cgs.clientinfo[ cg.scores[index].client ];
;2107:}
;2108:
;2109:static const char *CG_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
;2110:	gitem_t *item;
;2111:	int scoreIndex = 0;
;2112:	clientInfo_t *info = NULL;
;2113:	int team = -1;
;2114:	score_t *sp = NULL;
;2115:
;2116:	*handle = -1;
;2117:
;2118:	if (feederID == FEEDER_REDTEAM_LIST) {
;2119:		team = TEAM_RED;
;2120:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
;2121:		team = TEAM_BLUE;
;2122:	}
;2123:
;2124:	info = CG_InfoFromScoreIndex(index, team, &scoreIndex);
;2125:	sp = &cg.scores[scoreIndex];
;2126:
;2127:	if (info && info->infoValid) {
;2128:		switch (column) {
;2129:			case 0:
;2130:				if (info->powerups & (1 << PW_NEUTRALFLAG)) {
;2131:					item = BG_FindItemForPowerup(PW_NEUTRALFLAG);
;2132:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;2133:				} else if (info->powerups & (1 << PW_REDFLAG)) {
;2134:					item = BG_FindItemForPowerup(PW_REDFLAG);
;2135:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;2136:				} else if (info->powerups & (1 << PW_BLUEFLAG)) {
;2137:					item = BG_FindItemForPowerup(PW_BLUEFLAG);
;2138:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;2139:				} else {
;2140:					if (info->botSkill > 0 && info->botSkill <= 5) {
;2141:						*handle = cgs.media.botSkillShaders[ info->botSkill - 1 ];
;2142:					} else if (info->handicap < 100) {
;2143:						return va("%i", info->handicap);
;2144:					}
;2145:				}
;2146:				break;
;2147:			case 1:
;2148:				if (team == -1) {
;2149:					return "";
;2150:				} else if (info->isDead) {
;2151:					*handle = cgs.media.deathShader;
;2152:				} else {
;2153:					*handle = CG_StatusHandle(info->teamTask);
;2154:				}
;2155:				break;
;2156:			case 2:
;2157:				if (cg.snap->ps.stats[ STAT_CLIENTS_READY ] & (1 << sp->client)) {
;2158:					return "Ready";
;2159:				}
;2160:				if (team == -1) {
;2161:					if (cgs.gametype == GT_TOURNAMENT) {
;2162:						return va("%i/%i", info->wins, info->losses);
;2163:					} else if (info->infoValid && info->team == TEAM_SPECTATOR) {
;2164:						return "Spectator";
;2165:					} else {
;2166:						return "";
;2167:					}
;2168:				} else {
;2169:					if (info->teamLeader) {
;2170:						return "Leader";
;2171:					}
;2172:				}
;2173:				break;
;2174:			case 3:
;2175:				return info->name;
;2176:				break;
;2177:			case 4:
;2178:				return va("%i", info->score);
;2179:				break;
;2180:			case 5:
;2181:				return va("%4i", sp->time);
;2182:				break;
;2183:			case 6:
;2184:				if (sp->ping == -1) {
;2185:					return "connecting";
;2186:				}
;2187:				return va("%4i", sp->ping);
;2188:				break;
;2189:		}
;2190:	}
;2191:
;2192:	return "";
;2193:}
;2194:
;2195:static qhandle_t CG_FeederItemImage(float feederID, int index) {
;2196:	return 0;
;2197:}
;2198:
;2199:static void CG_FeederSelection(float feederID, int index) {
;2200:	if (CG_IsATeamGametype(cgs.gametype)) {
;2201:		int i, count;
;2202:		int team = (feederID == FEEDER_REDTEAM_LIST) ? TEAM_RED : TEAM_BLUE;
;2203:		count = 0;
;2204:		for (i = 0; i < cg.numScores; i++) {
;2205:			if (cg.scores[i].team == team) {
;2206:				if (index == count) {
;2207:					cg.selectedScore = i;
;2208:				}
;2209:				count++;
;2210:			}
;2211:		}
;2212:	} else {
;2213:		cg.selectedScore = index;
;2214:	}
;2215:}
;2216:#endif
;2217:
;2218:float CG_GetCVar(const char *cvar) {
line 2220
;2219:	char value[128];
;2220:	memset(value, 0, sizeof (value));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 128
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2221
;2221:	trap_Cvar_VariableStringBuffer(cvar, value, sizeof(value));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2222
;2222:	return atof(value);
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
RETF4
LABELV $1456
endproc CG_GetCVar 132 12
export CG_Init
proc CG_Init 48 12
line 2408
;2223:}
;2224:#ifdef MISSIONPACK
;2225:
;2226:void CG_Text_PaintWithCursor(float x, float y, float scale, vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style) {
;2227:	CG_Text_Paint(x, y, scale, color, text, 0, limit, style);
;2228:}
;2229:
;2230:static int CG_OwnerDrawWidth(int ownerDraw, float scale) {
;2231:	switch (ownerDraw) {
;2232:		case CG_GAME_TYPE:
;2233:			return CG_Text_Width(CG_GameTypeString(), scale, 0);
;2234:		case CG_GAME_STATUS:
;2235:			return CG_Text_Width(CG_GetGameStatusText(), scale, 0);
;2236:			break;
;2237:		case CG_KILLER:
;2238:			return CG_Text_Width(CG_GetKillerText(), scale, 0);
;2239:			break;
;2240:		case CG_RED_NAME:
;2241:			return CG_Text_Width(cg_redTeamName.string, scale, 0);
;2242:			break;
;2243:		case CG_BLUE_NAME:
;2244:			return CG_Text_Width(cg_blueTeamName.string, scale, 0);
;2245:			break;
;2246:
;2247:
;2248:	}
;2249:	return 0;
;2250:}
;2251:
;2252:static int CG_PlayCinematic(const char *name, float x, float y, float w, float h) {
;2253:	return trap_CIN_PlayCinematic(name, x, y, w, h, CIN_loop);
;2254:}
;2255:
;2256:static void CG_StopCinematic(int handle) {
;2257:	trap_CIN_StopCinematic(handle);
;2258:}
;2259:
;2260:static void CG_DrawCinematic(int handle, float x, float y, float w, float h) {
;2261:	trap_CIN_SetExtents(handle, x, y, w, h);
;2262:	trap_CIN_DrawCinematic(handle);
;2263:}
;2264:
;2265:static void CG_RunCinematicFrame(int handle) {
;2266:	trap_CIN_RunCinematic(handle);
;2267:}
;2268:
;2269:/*
;2270:=================
;2271:CG_LoadHudMenu();
;2272:
;2273:=================
;2274: */
;2275:void CG_LoadHudMenu(void) {
;2276:	char buff[1024];
;2277:	const char *hudSet;
;2278:
;2279:	cgDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
;2280:	cgDC.setColor = &trap_R_SetColor;
;2281:	cgDC.drawHandlePic = &CG_DrawPic;
;2282:	cgDC.drawStretchPic = &trap_R_DrawStretchPic;
;2283:	cgDC.drawText = &CG_Text_Paint;
;2284:	cgDC.textWidth = &CG_Text_Width;
;2285:	cgDC.textHeight = &CG_Text_Height;
;2286:	cgDC.registerModel = &trap_R_RegisterModel;
;2287:	cgDC.modelBounds = &trap_R_ModelBounds;
;2288:	cgDC.fillRect = &CG_FillRect;
;2289:	cgDC.drawRect = &CG_DrawRect;
;2290:	cgDC.drawSides = &CG_DrawSides;
;2291:	cgDC.drawTopBottom = &CG_DrawTopBottom;
;2292:	cgDC.clearScene = &trap_R_ClearScene;
;2293:	cgDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
;2294:	cgDC.renderScene = &trap_R_RenderScene;
;2295:	cgDC.registerFont = &trap_R_RegisterFont;
;2296:	cgDC.ownerDrawItem = &CG_OwnerDraw;
;2297:	cgDC.getValue = &CG_GetValue;
;2298:	cgDC.ownerDrawVisible = &CG_OwnerDrawVisible;
;2299:	cgDC.runScript = &CG_RunMenuScript;
;2300:	cgDC.getTeamColor = &CG_GetTeamColor;
;2301:	cgDC.setCVar = trap_Cvar_Set;
;2302:	cgDC.getCVarString = trap_Cvar_VariableStringBuffer;
;2303:	cgDC.getCVarValue = CG_GetCVar;
;2304:	cgDC.drawTextWithCursor = &CG_Text_PaintWithCursor;
;2305:	//cgDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
;2306:	//cgDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
;2307:	cgDC.startLocalSound = &trap_S_StartLocalSound;
;2308:	cgDC.ownerDrawHandleKey = &CG_OwnerDrawHandleKey;
;2309:	cgDC.feederCount = &CG_FeederCount;
;2310:	cgDC.feederItemImage = &CG_FeederItemImage;
;2311:	cgDC.feederItemText = &CG_FeederItemText;
;2312:	cgDC.feederSelection = &CG_FeederSelection;
;2313:	//cgDC.setBinding = &trap_Key_SetBinding;
;2314:	//cgDC.getBindingBuf = &trap_Key_GetBindingBuf;
;2315:	//cgDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
;2316:	//cgDC.executeText = &trap_Cmd_ExecuteText;
;2317:	cgDC.Error = &Com_Error;
;2318:	cgDC.Print = &Com_Printf;
;2319:	cgDC.ownerDrawWidth = &CG_OwnerDrawWidth;
;2320:	//cgDC.Pause = &CG_Pause;
;2321:	cgDC.registerSound = &trap_S_RegisterSound;
;2322:	cgDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
;2323:	cgDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
;2324:	cgDC.playCinematic = &CG_PlayCinematic;
;2325:	cgDC.stopCinematic = &CG_StopCinematic;
;2326:	cgDC.drawCinematic = &CG_DrawCinematic;
;2327:	cgDC.runCinematicFrame = &CG_RunCinematicFrame;
;2328:
;2329:	Init_Display(&cgDC);
;2330:
;2331:	Menu_Reset();
;2332:
;2333:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof (buff));
;2334:	hudSet = buff;
;2335:	if (hudSet[0] == '\0') {
;2336:		hudSet = "ui/hud.txt";
;2337:	}
;2338:
;2339:	CG_LoadMenus(hudSet);
;2340:}
;2341:
;2342:void CG_AssetCache(void) {
;2343:	//if (Assets.textFont == NULL) {
;2344:	//  trap_R_RegisterFont("fonts/arial.ttf", 72, &Assets.textFont);
;2345:	//}
;2346:	//Assets.background = trap_R_RegisterShaderNoMip( ASSET_BACKGROUND );
;2347:	//Com_Printf("Menu Size: %i bytes\n", sizeof(Menus));
;2348:	/*
;2349:		cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip( ASSET_GRADIENTBAR );
;2350:		cgDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip( ART_FX_BASE );
;2351:		cgDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip( ART_FX_RED );
;2352:		cgDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip( ART_FX_YELLOW );
;2353:		cgDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip( ART_FX_GREEN );
;2354:		cgDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip( ART_FX_TEAL );
;2355:		cgDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip( ART_FX_BLUE );
;2356:		cgDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip( ART_FX_CYAN );
;2357:		cgDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip( ART_FX_WHITE );
;2358:		cgDC.Assets.scrollBar = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR );
;2359:		cgDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWDOWN );
;2360:		cgDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWUP );
;2361:		cgDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWLEFT );
;2362:		cgDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWRIGHT );
;2363:		cgDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip( ASSET_SCROLL_THUMB );
;2364:		cgDC.Assets.sliderBar = trap_R_RegisterShaderNoMip( ASSET_SLIDER_BAR );
;2365:		cgDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip( ASSET_SLIDER_THUMB );
;2366:	 */
;2367:
;2368:	// Changed RD SCRIPTHUD
;2369:	cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(ASSET_GRADIENTBAR);
;2370:	cgDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip(ART_FX_BASE);
;2371:	cgDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip(ART_FX_RED);
;2372:	cgDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip(ART_FX_YELLOW);
;2373:	cgDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip(ART_FX_GREEN);
;2374:	cgDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip(ART_FX_TEAL);
;2375:	cgDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip(ART_FX_BLUE);
;2376:	cgDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip(ART_FX_CYAN);
;2377:	cgDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip(ART_FX_WHITE);
;2378:	cgDC.Assets.scrollBarHorz = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR);
;2379:	cgDC.Assets.scrollBarVert = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR);
;2380:	cgDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWDOWN);
;2381:	cgDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWUP);
;2382:	cgDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWLEFT);
;2383:	cgDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWRIGHT);
;2384:	cgDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip(ASSET_SCROLL_THUMB);
;2385:	cgDC.Assets.sliderBar = trap_R_RegisterShaderNoMip(ASSET_SLIDER_BAR);
;2386:	cgDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip(ASSET_SLIDER_THUMB);
;2387:	cgDC.Assets.sliderThumb_sel = trap_R_RegisterShaderNoMip(ASSET_SLIDER_THUMB_SEL);
;2388:	cgDC.Assets.scrollbarsize = SCROLLBAR_SIZE;
;2389:	cgDC.Assets.sliderwidth = SLIDER_WIDTH;
;2390:	cgDC.Assets.sliderheight = SLIDER_HEIGHT;
;2391:	cgDC.Assets.sliderthumbwidth = SLIDER_THUMB_WIDTH;
;2392:	cgDC.Assets.sliderthumbheight = SLIDER_THUMB_HEIGHT;
;2393:	// end changed RD SCRIPTHUD
;2394:
;2395:}
;2396:#endif
;2397:
;2398:int wideAdjustX; // leilei - dirty widescreen hack
;2399:
;2400:/*
;2401:=================
;2402:CG_Init
;2403:
;2404:Called after every level change or subsystem restart
;2405:Will perform callbacks to make the loading info screen update.
;2406:=================
;2407: */
;2408:void CG_Init(int serverMessageNum, int serverCommandSequence, int clientNum) {
line 2412
;2409:	const char *s;
;2410:
;2411:	// clear everything
;2412:	memset(&cgs, 0, sizeof ( cgs));
ADDRGP4 cgs
ARGP4
CNSTI4 0
ARGI4
CNSTI4 181716
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2413
;2413:	memset(&cg, 0, sizeof ( cg));
ADDRGP4 cg
ARGP4
CNSTI4 0
ARGI4
CNSTI4 156552
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2414
;2414:	memset(cg_entities, 0, sizeof (cg_entities));
ADDRGP4 cg_entities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 958464
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2415
;2415:	memset(cg_weapons, 0, sizeof (cg_weapons));
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2752
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2416
;2416:	memset(cg_items, 0, sizeof (cg_items));
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 6144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2418
;2417:
;2418:	cg.clientNum = clientNum;
ADDRGP4 cg+4
ADDRFP4 8
INDIRI4
ASGNI4
line 2420
;2419:
;2420:	cgs.processedSnapshotNum = serverMessageNum;
ADDRGP4 cgs+31448
ADDRFP4 0
INDIRI4
ASGNI4
line 2421
;2421:	cgs.serverCommandSequence = serverCommandSequence;
ADDRGP4 cgs+31444
ADDRFP4 4
INDIRI4
ASGNI4
line 2424
;2422:
;2423:	// load a few needed things before we do any screen updates
;2424:	cgs.media.charsetShader = trap_R_RegisterShader("gfx/2d/bigchars");
ADDRGP4 $1462
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268
ADDRLP4 4
INDIRI4
ASGNI4
line 2425
;2425:	cgs.media.whiteShader = trap_R_RegisterShader("white");
ADDRGP4 $1465
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+180268+16
ADDRLP4 8
INDIRI4
ASGNI4
line 2426
;2426:	cgs.media.charsetProp = trap_R_RegisterShaderNoMip("menu/art/font1_prop.tga");
ADDRGP4 $1468
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+4
ADDRLP4 12
INDIRI4
ASGNI4
line 2427
;2427:	cgs.media.charsetPropGlow = trap_R_RegisterShaderNoMip("menu/art/font1_prop_glo.tga");
ADDRGP4 $1471
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+8
ADDRLP4 16
INDIRI4
ASGNI4
line 2428
;2428:	cgs.media.charsetPropB = trap_R_RegisterShaderNoMip("menu/art/font2_prop.tga");
ADDRGP4 $1474
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+180268+12
ADDRLP4 20
INDIRI4
ASGNI4
line 2430
;2429:
;2430:	CG_RegisterCvars();
ADDRGP4 CG_RegisterCvars
CALLV
pop
line 2432
;2431:
;2432:	CG_InitConsoleCommands();
ADDRGP4 CG_InitConsoleCommands
CALLV
pop
line 2440
;2433:	// loadingscreen
;2434:#ifdef SCRIPTHUD
;2435:	String_Init();
;2436:	CG_AssetCache();
;2437:	CG_LoadHudMenu(); // load new hud stuff
;2438:	trap_Cvar_Set("ui_loading", "1");
;2439:#endif
;2440:	cg.weaponSelect = WP_MACHINEGUN;
ADDRGP4 cg+109152
CNSTI4 2
ASGNI4
line 2442
;2441:
;2442:	cgs.redflag = cgs.blueflag = -1; // For compatibily, default to unset for
ADDRLP4 24
CNSTI4 -1
ASGNI4
ADDRGP4 cgs+34992
ADDRLP4 24
INDIRI4
ASGNI4
ADDRGP4 cgs+34988
ADDRLP4 24
INDIRI4
ASGNI4
line 2443
;2443:	cgs.flagStatus = -1;
ADDRGP4 cgs+34996
CNSTI4 -1
ASGNI4
line 2447
;2444:	// old servers
;2445:
;2446:	// get the rendering configuration from the client system
;2447:	trap_GetGlconfig(&cgs.glconfig);
ADDRGP4 cgs+20100
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 2448
;2448:	cgs.screenXScale = cgs.glconfig.vidWidth / 640.0;
ADDRGP4 cgs+31432
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
CNSTF4 1142947840
DIVF4
ASGNF4
line 2449
;2449:	cgs.screenYScale = cgs.glconfig.vidHeight / 480.0;
ADDRGP4 cgs+31436
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
CNSTF4 1139802112
DIVF4
ASGNF4
line 2451
;2450:
;2451:	realVidWidth = cgs.glconfig.vidWidth;
ADDRGP4 realVidWidth
ADDRGP4 cgs+20100+11304
INDIRI4
ASGNI4
line 2452
;2452:	realVidHeight = cgs.glconfig.vidHeight;
ADDRGP4 realVidHeight
ADDRGP4 cgs+20100+11308
INDIRI4
ASGNI4
line 2456
;2453:
;2454:	// leilei - widescreen correction
;2455:
;2456:	{
line 2461
;2457:		float resbias;
;2458:		float rex, rey;
;2459:		int newresx, newresy;
;2460:
;2461:		rex = 640.0f / realVidWidth;
ADDRLP4 44
CNSTF4 1142947840
ADDRGP4 realVidWidth
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 2462
;2462:		rey = 480.0f / realVidHeight;
ADDRLP4 28
CNSTF4 1139802112
ADDRGP4 realVidHeight
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 2464
;2463:
;2464:		newresx = 640.0f * (rex);
ADDRLP4 32
CNSTF4 1142947840
ADDRLP4 44
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 2465
;2465:		newresy = 480.0f * (rey);
ADDRLP4 36
CNSTF4 1139802112
ADDRLP4 28
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 2467
;2466:
;2467:		newresx = realVidWidth * rey;
ADDRLP4 32
ADDRGP4 realVidWidth
INDIRI4
CVIF4 4
ADDRLP4 28
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 2468
;2468:		newresy = realVidHeight * rey;
ADDRLP4 36
ADDRGP4 realVidHeight
INDIRI4
CVIF4 4
ADDRLP4 28
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 2470
;2469:
;2470:		resbias = 0.5 * (newresx - (newresy * (640.0 / 480.0)));
ADDRLP4 40
CNSTF4 1056964608
ADDRLP4 32
INDIRI4
CVIF4 4
CNSTF4 1068149419
ADDRLP4 36
INDIRI4
CVIF4 4
MULF4
SUBF4
MULF4
ASGNF4
line 2473
;2471:
;2472:
;2473:		wideAdjustX = resbias;
ADDRGP4 wideAdjustX
ADDRLP4 40
INDIRF4
CVFI4 4
ASGNI4
line 2475
;2474:
;2475:	}
line 2476
;2476:	if (cgs.glconfig.vidWidth * 480 > cgs.glconfig.vidHeight * 640) {
CNSTI4 480
ADDRGP4 cgs+20100+11304
INDIRI4
MULI4
CNSTI4 640
ADDRGP4 cgs+20100+11308
INDIRI4
MULI4
LEI4 $1490
line 2478
;2477:		// wide screen
;2478:		cgs.screenXBias = 0.5 * (cgs.glconfig.vidWidth - (cgs.glconfig.vidHeight * (640.0 / 480.0)));
ADDRGP4 cgs+31440
CNSTF4 1056964608
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
CNSTF4 1068149419
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
MULF4
SUBF4
MULF4
ASGNF4
line 2479
;2479:		cgs.screenXScale = cgs.screenYScale;
ADDRGP4 cgs+31432
ADDRGP4 cgs+31436
INDIRF4
ASGNF4
line 2480
;2480:	} else {
ADDRGP4 $1491
JUMPV
LABELV $1490
line 2482
;2481:		// no wide screen
;2482:		cgs.screenXBias = 0;
ADDRGP4 cgs+31440
CNSTF4 0
ASGNF4
line 2483
;2483:	}
LABELV $1491
line 2488
;2484:
;2485:
;2486:
;2487:	// get the gamestate from the client system
;2488:	trap_GetGameState(&cgs.gameState);
ADDRGP4 cgs
ARGP4
ADDRGP4 trap_GetGameState
CALLV
pop
line 2491
;2489:
;2490:	// check version
;2491:	s = CG_ConfigString(CS_GAME_VERSION);
CNSTI4 20
ARGI4
ADDRLP4 28
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 2492
;2492:	if (!strequals(s, GAME_VERSION)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1506
ARGP4
ADDRLP4 32
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $1504
line 2493
;2493:		CG_Error("Client/Server game mismatch: %s/%s", GAME_VERSION, s);
ADDRGP4 $1507
ARGP4
ADDRGP4 $1506
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2494
;2494:	}
LABELV $1504
line 2496
;2495:
;2496:	s = CG_ConfigString(CS_LEVEL_START_TIME);
CNSTI4 21
ARGI4
ADDRLP4 36
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 2497
;2497:	cgs.levelStartTime = atoi(s);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34804
ADDRLP4 40
INDIRI4
ASGNI4
line 2499
;2498:
;2499:	CG_ParseServerinfo();
ADDRGP4 CG_ParseServerinfo
CALLV
pop
line 2504
;2500:
;2501:	// load the new map
;2502:	// load the new map
;2503:#ifndef SCRIPTHUD
;2504:	CG_LoadingString("collision map");
ADDRGP4 $1509
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2506
;2505:#endif
;2506:	trap_CM_LoadMap(cgs.mapname);
ADDRGP4 cgs+31492
ARGP4
ADDRGP4 trap_CM_LoadMap
CALLV
pop
line 2513
;2507:
;2508:#ifdef MISSIONPACK
;2509:	String_Init();
;2510:	CG_LoadHudMenu(); // load new hud stuff
;2511:#endif
;2512:
;2513:	cg.loading = qtrue; // force players to load instead of defer
ADDRGP4 cg+20
CNSTI4 1
ASGNI4
line 2524
;2514:#ifdef SCRIPTHUD
;2515:	CG_RegisterSounds();
;2516:	CG_UpdateSoundFraction(1.0f);
;2517:	CG_UpdateMediaFraction(0.60f);
;2518:	CG_RegisterGraphics();
;2519:	CG_UpdateGraphicFraction(1.0f);
;2520:	CG_UpdateMediaFraction(0.90f);
;2521:	CG_RegisterClients(); // if low on memory, some clients will be deferred
;2522:	CG_UpdateMediaFraction(1.0f);
;2523:#else
;2524:	CG_LoadingString("sounds");
ADDRGP4 $1512
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2526
;2525:
;2526:	CG_RegisterSounds();
ADDRGP4 CG_RegisterSounds
CALLV
pop
line 2528
;2527:
;2528:	CG_LoadingString("graphics");
ADDRGP4 $1513
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2530
;2529:
;2530:	CG_RegisterGraphics();
ADDRGP4 CG_RegisterGraphics
CALLV
pop
line 2532
;2531:
;2532:	CG_LoadingString("clients");
ADDRGP4 $1514
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2534
;2533:
;2534:	CG_RegisterClients(); // if low on memory, some clients will be deferred
ADDRGP4 CG_RegisterClients
CALLV
pop
line 2542
;2535:#endif
;2536:
;2537:#ifdef MISSIONPACK
;2538:	CG_AssetCache();
;2539:	CG_LoadHudMenu(); // load new hud stuff
;2540:#endif
;2541:
;2542:	cg.loading = qfalse; // future players will be deferred
ADDRGP4 cg+20
CNSTI4 0
ASGNI4
line 2544
;2543:
;2544:	CG_InitLocalEntities();
ADDRGP4 CG_InitLocalEntities
CALLV
pop
line 2546
;2545:
;2546:	CG_InitMarkPolys();
ADDRGP4 CG_InitMarkPolys
CALLV
pop
line 2549
;2547:
;2548:	// remove the last loading update
;2549:	cg.infoScreenText[0] = 0;
ADDRGP4 cg+109644
CNSTI1 0
ASGNI1
line 2552
;2550:
;2551:	// Make sure we have update values (scores)
;2552:	CG_SetConfigValues();
ADDRGP4 CG_SetConfigValues
CALLV
pop
line 2554
;2553:
;2554:	CG_StartMusic();
ADDRGP4 CG_StartMusic
CALLV
pop
line 2558
;2555:	
;2556:
;2557:
;2558:	CG_LoadingString("");
ADDRGP4 $187
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2564
;2559:
;2560:#ifdef MISSIONPACK
;2561:	CG_InitTeamChat();
;2562:#endif
;2563:
;2564:	CG_ShaderStateChanged();
ADDRGP4 CG_ShaderStateChanged
CALLV
pop
line 2567
;2565:
;2566:	//Init challenge system
;2567:	challenges_init();
ADDRGP4 challenges_init
CALLV
pop
line 2569
;2568:
;2569:	addChallenge(GENERAL_TEST);
CNSTI4 0
ARGI4
ADDRGP4 addChallenge
CALLV
pop
line 2571
;2570:
;2571:	trap_S_ClearLoopingSounds(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 2577
;2572:#ifdef SCRIPTHUD
;2573:	trap_Cvar_Set("ui_loading", "0");
;2574:	cg.consoleValid = qtrue;
;2575:#endif
;2576:	// end loadingscreen
;2577:}
LABELV $1457
endproc CG_Init 48 12
export CG_Shutdown
proc CG_Shutdown 0 0
line 2586
;2578:
;2579:/*
;2580:=================
;2581:CG_Shutdown
;2582:
;2583:Called before every level change or subsystem restart
;2584:=================
;2585: */
;2586:void CG_Shutdown(void) {
line 2589
;2587:	// some mods may need to do cleanup work here,
;2588:	// like closing files or archiving session data
;2589:	challenges_save();
ADDRGP4 challenges_save
CALLV
pop
line 2590
;2590:}
LABELV $1517
endproc CG_Shutdown 0 0
export CG_EventHandling
proc CG_EventHandling 0 0
line 2604
;2591:
;2592:
;2593:/*
;2594:==================
;2595:CG_EventHandling
;2596:==================
;2597: type 0 - no event handling
;2598:	  1 - team menu
;2599:	  2 - hud editor
;2600:
;2601: */
;2602:#ifndef MISSIONPACK
;2603:
;2604:void CG_EventHandling(int type) {
line 2605
;2605:}
LABELV $1518
endproc CG_EventHandling 0 0
export CG_KeyEvent
proc CG_KeyEvent 0 0
line 2607
;2606:
;2607:void CG_KeyEvent(int key, qboolean down) {
line 2608
;2608:}
LABELV $1519
endproc CG_KeyEvent 0 0
export CG_MouseEvent
proc CG_MouseEvent 0 0
line 2610
;2609:
;2610:void CG_MouseEvent(int x, int y) {
line 2611
;2611:}
LABELV $1520
endproc CG_MouseEvent 0 0
export SnapVectorTowards
proc SnapVectorTowards 12 0
line 2627
;2612:#endif
;2613:
;2614://unlagged - attack prediction #3
;2615:// moved from g_weapon.c
;2616:
;2617:/*
;2618:======================
;2619:SnapVectorTowards
;2620:
;2621:Round a vector to integers for more efficient network
;2622:transmission, but make sure that it rounds towards a given point
;2623:rather than blindly truncating.  This prevents it from truncating 
;2624:into a wall.
;2625:======================
;2626: */
;2627:void SnapVectorTowards(vec3_t v, vec3_t to) {
line 2630
;2628:	int i;
;2629:
;2630:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1522
line 2631
;2631:		if (to[i] <= v[i]) {
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
GTF4 $1526
line 2632
;2632:			v[i] = (int) v[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 2633
;2633:		} else {
ADDRGP4 $1527
JUMPV
LABELV $1526
line 2634
;2634:			v[i] = (int) v[i] + 1;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 1
ADDI4
CVIF4 4
ASGNF4
line 2635
;2635:		}
LABELV $1527
line 2636
;2636:	}
LABELV $1523
line 2630
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1522
line 2637
;2637:}
LABELV $1521
endproc SnapVectorTowards 12 0
data
align 4
LABELV do_vid_restart
byte 4 0
export CG_FairCvars
code
proc CG_FairCvars 168 12
line 2642
;2638://unlagged - attack prediction #3
;2639:
;2640:static qboolean do_vid_restart = qfalse;
;2641:
;2642:void CG_FairCvars() {
line 2643
;2643:	qboolean vid_restart_required = qfalse;
ADDRLP4 128
CNSTI4 0
ASGNI4
line 2646
;2644:	char rendererinfos[128];
;2645:
;2646:	if (cgs.gametype == GT_SINGLE_PLAYER) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $1529
line 2647
;2647:		trap_Cvar_VariableStringBuffer("r_vertexlight", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1532
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2648
;2648:		if (cg_autovertex.integer && atoi(rendererinfos) == 0) {
ADDRGP4 cg_autovertex+12
INDIRI4
CNSTI4 0
EQI4 $1528
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $1528
line 2649
;2649:			trap_Cvar_Set("r_vertexlight", "1");
ADDRGP4 $1532
ARGP4
ADDRGP4 $92
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2650
;2650:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2651
;2651:		}
line 2652
;2652:		return; //Don't do anything in single player
ADDRGP4 $1528
JUMPV
LABELV $1529
line 2655
;2653:	}
;2654:
;2655:	if (cgs.videoflags & VF_LOCK_CVARS_BASIC) {
ADDRGP4 cgs+31464
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1536
line 2657
;2656:		//Lock basic cvars.
;2657:		trap_Cvar_VariableStringBuffer("r_subdivisions", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1539
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2658
;2658:		if (atoi(rendererinfos) > 80) {
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 80
LEI4 $1540
line 2659
;2659:			trap_Cvar_Set("r_subdivisions", "80");
ADDRGP4 $1539
ARGP4
ADDRGP4 $1542
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2660
;2660:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2661
;2661:		}
LABELV $1540
line 2663
;2662:
;2663:		trap_Cvar_VariableStringBuffer("cg_shadows", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $101
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2664
;2664:		if (atoi(rendererinfos) != 0 && atoi(rendererinfos) != 1) {
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $1543
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 1
EQI4 $1543
line 2665
;2665:			trap_Cvar_Set("cg_shadows", "1");
ADDRGP4 $101
ARGP4
ADDRGP4 $92
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2666
;2666:		}
LABELV $1543
line 2667
;2667:	}
LABELV $1536
line 2669
;2668:
;2669:	if (cgs.videoflags & VF_LOCK_CVARS_EXTENDED) {
ADDRGP4 cgs+31464
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1545
line 2671
;2670:		//Lock extended cvars.
;2671:		trap_Cvar_VariableStringBuffer("r_subdivisions", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1539
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2672
;2672:		if (atoi(rendererinfos) > 20) {
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 20
LEI4 $1548
line 2673
;2673:			trap_Cvar_Set("r_subdivisions", "20");
ADDRGP4 $1539
ARGP4
ADDRGP4 $234
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2674
;2674:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2675
;2675:		}
LABELV $1548
line 2677
;2676:
;2677:		trap_Cvar_VariableStringBuffer("r_picmip", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1550
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2678
;2678:		if (atoi(rendererinfos) > 3) {
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 3
LEI4 $1551
line 2679
;2679:			trap_Cvar_Set("r_picmip", "3");
ADDRGP4 $1550
ARGP4
ADDRGP4 $133
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2680
;2680:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2681
;2681:		} else if (atoi(rendererinfos) < 0) {
ADDRGP4 $1552
JUMPV
LABELV $1551
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $1553
line 2682
;2682:			trap_Cvar_Set("r_picmip", "0");
ADDRGP4 $1550
ARGP4
ADDRGP4 $90
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2683
;2683:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2684
;2684:		}
LABELV $1553
LABELV $1552
line 2686
;2685:
;2686:		trap_Cvar_VariableStringBuffer("r_intensity", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1555
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2687
;2687:		if (atoi(rendererinfos) > 2) {
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LEI4 $1556
line 2688
;2688:			trap_Cvar_Set("r_intensity", "2");
ADDRGP4 $1555
ARGP4
ADDRGP4 $1558
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2689
;2689:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2690
;2690:		} else if (atoi(rendererinfos) < 0) {
ADDRGP4 $1557
JUMPV
LABELV $1556
ADDRLP4 0
ARGP4
ADDRLP4 148
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
GEI4 $1559
line 2691
;2691:			trap_Cvar_Set("r_intensity", "0");
ADDRGP4 $1555
ARGP4
ADDRGP4 $90
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2692
;2692:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2693
;2693:		}
LABELV $1559
LABELV $1557
line 2695
;2694:
;2695:		trap_Cvar_VariableStringBuffer("r_mapoverbrightbits", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1561
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2696
;2696:		if (atoi(rendererinfos) > 2) {
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 2
LEI4 $1562
line 2697
;2697:			trap_Cvar_Set("r_mapoverbrightbits", "2");
ADDRGP4 $1561
ARGP4
ADDRGP4 $1558
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2698
;2698:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2699
;2699:		} else if (atoi(rendererinfos) < 0) {
ADDRGP4 $1563
JUMPV
LABELV $1562
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
GEI4 $1564
line 2700
;2700:			trap_Cvar_Set("r_mapoverbrightbits", "0");
ADDRGP4 $1561
ARGP4
ADDRGP4 $90
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2701
;2701:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2702
;2702:		}
LABELV $1564
LABELV $1563
line 2704
;2703:
;2704:		trap_Cvar_VariableStringBuffer("r_overbrightbits", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1566
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2705
;2705:		if (atoi(rendererinfos) > 2) {
ADDRLP4 0
ARGP4
ADDRLP4 160
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 2
LEI4 $1567
line 2706
;2706:			trap_Cvar_Set("r_overbrightbits", "2");
ADDRGP4 $1566
ARGP4
ADDRGP4 $1558
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2707
;2707:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2708
;2708:		} else if (atoi(rendererinfos) < 0) {
ADDRGP4 $1568
JUMPV
LABELV $1567
ADDRLP4 0
ARGP4
ADDRLP4 164
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
GEI4 $1569
line 2709
;2709:			trap_Cvar_Set("r_overbrightbits", "0");
ADDRGP4 $1566
ARGP4
ADDRGP4 $90
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2710
;2710:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2711
;2711:		}
LABELV $1569
LABELV $1568
line 2712
;2712:	}
LABELV $1545
line 2714
;2713:
;2714:	if (cgs.videoflags & VF_LOCK_VERTEX) {
ADDRGP4 cgs+31464
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1571
line 2715
;2715:		trap_Cvar_VariableStringBuffer("r_vertexlight", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1532
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2716
;2716:		if (atoi(rendererinfos) != 0) {
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $1572
line 2717
;2717:			trap_Cvar_Set("r_vertexlight", "0");
ADDRGP4 $1532
ARGP4
ADDRGP4 $90
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2718
;2718:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2719
;2719:		}
line 2720
;2720:	} else if (cg_autovertex.integer) {
ADDRGP4 $1572
JUMPV
LABELV $1571
ADDRGP4 cg_autovertex+12
INDIRI4
CNSTI4 0
EQI4 $1576
line 2721
;2721:		trap_Cvar_VariableStringBuffer("r_vertexlight", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1532
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2722
;2722:		if (atoi(rendererinfos) == 0) {
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $1579
line 2723
;2723:			trap_Cvar_Set("r_vertexlight", "1");
ADDRGP4 $1532
ARGP4
ADDRGP4 $92
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2724
;2724:			vid_restart_required = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
line 2725
;2725:		}
LABELV $1579
line 2726
;2726:	}
LABELV $1576
LABELV $1572
line 2728
;2727:
;2728:	if (vid_restart_required && do_vid_restart)
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ADDRLP4 132
INDIRI4
EQI4 $1581
ADDRGP4 do_vid_restart
INDIRI4
ADDRLP4 132
INDIRI4
EQI4 $1581
line 2729
;2729:		trap_SendConsoleCommand("vid_restart");
ADDRGP4 $1583
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
LABELV $1581
line 2731
;2730:
;2731:	do_vid_restart = qtrue;
ADDRGP4 do_vid_restart
CNSTI4 1
ASGNI4
line 2732
;2732:}
LABELV $1528
endproc CG_FairCvars 168 12
export CG_IsATeamGametype
proc CG_IsATeamGametype 8 0
line 2744
;2733:
;2734:
;2735:
;2736:/* Neon_Knight: Useful check in order to have code consistency. */
;2737:/*
;2738:===================
;2739:CG_IsATeamGametype
;2740:
;2741:Checks if the gametype is a team-based game.
;2742:===================
;2743: */
;2744:qboolean CG_IsATeamGametype(int gametype) {
line 2745
;2745:	return GAMETYPE_IS_A_TEAM_GAME(gametype);
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1586
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $1586
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $1586
ADDRLP4 4
INDIRI4
CNSTI4 10
EQI4 $1586
ADDRLP4 4
INDIRI4
CNSTI4 13
EQI4 $1586
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1587
JUMPV
LABELV $1586
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1587
ADDRLP4 0
INDIRI4
RETI4
LABELV $1584
endproc CG_IsATeamGametype 8 0
export CG_UsesTeamFlags
proc CG_UsesTeamFlags 8 0
line 2754
;2746:}
;2747:/*
;2748:===================
;2749:CG_UsesTeamFlags
;2750:
;2751:Checks if the gametype makes use of the red and blue flags.
;2752:===================
;2753: */
;2754:qboolean CG_UsesTeamFlags(int check) {
line 2755
;2755:	return GAMETYPE_USES_RED_AND_BLUE_FLAG(check);
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
EQI4 $1593
ADDRLP4 4
INDIRI4
CNSTI4 5
EQI4 $1593
ADDRLP4 4
INDIRI4
CNSTI4 9
NEI4 $1590
LABELV $1593
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1591
JUMPV
LABELV $1590
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1591
ADDRLP4 0
INDIRI4
RETI4
LABELV $1588
endproc CG_UsesTeamFlags 8 0
export CG_UsesTheWhiteFlag
proc CG_UsesTheWhiteFlag 8 0
line 2764
;2756:}
;2757:/*
;2758:===================
;2759:CG_UsesTheWhiteFlag
;2760:
;2761:Checks if the gametype makes use of the neutral flag.
;2762:===================
;2763: */
;2764:qboolean CG_UsesTheWhiteFlag(int check) {
line 2765
;2765:	return GAMETYPE_USES_WHITE_FLAG(check);
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 5
EQI4 $1598
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $1596
LABELV $1598
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1597
JUMPV
LABELV $1596
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1597
ADDRLP4 0
INDIRI4
RETI4
LABELV $1594
endproc CG_UsesTheWhiteFlag 8 0
export CG_IsARoundBasedGametype
proc CG_IsARoundBasedGametype 8 0
line 2774
;2766:}
;2767:/*
;2768:===================
;2769:CG_IsARoundBasedGametype
;2770:
;2771:Checks if the gametype has a round-based system.
;2772:===================
;2773: */
;2774:qboolean CG_IsARoundBasedGametype(int check) {
line 2775
;2775:	return GAMETYPE_IS_ROUND_BASED(check);
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
EQI4 $1604
ADDRLP4 4
INDIRI4
CNSTI4 9
EQI4 $1604
ADDRLP4 4
INDIRI4
CNSTI4 10
NEI4 $1601
LABELV $1604
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1602
JUMPV
LABELV $1601
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1602
ADDRLP4 0
INDIRI4
RETI4
LABELV $1599
endproc CG_IsARoundBasedGametype 8 0
export CG_SetDefaultWeaponProperties
proc CG_SetDefaultWeaponProperties 0 0
line 2778
;2776:}
;2777:/* /Neon_Knight */
;2778:void CG_SetDefaultWeaponProperties(void) {
line 2779
;2779:	mod_sgspread = 700;
ADDRGP4 mod_sgspread
CNSTI4 700
ASGNI4
line 2780
;2780:	mod_sgcount = 11;
ADDRGP4 mod_sgcount
CNSTI4 11
ASGNI4
line 2781
;2781:	mod_lgrange = 768;
ADDRGP4 mod_lgrange
CNSTI4 768
ASGNI4
line 2782
;2782:	mod_mgspread = 200;
ADDRGP4 mod_mgspread
CNSTI4 200
ASGNI4
line 2783
;2783:	mod_cgspread = 600;
ADDRGP4 mod_cgspread
CNSTI4 600
ASGNI4
line 2784
;2784:}
LABELV $1605
endproc CG_SetDefaultWeaponProperties 0 0
bss
export mod_poweruptime
align 4
LABELV mod_poweruptime
skip 4
export mod_scoutfirespeed
align 4
LABELV mod_scoutfirespeed
skip 4
export mod_ammoregenfirespeed
align 4
LABELV mod_ammoregenfirespeed
skip 4
export mod_hastefirespeed
align 4
LABELV mod_hastefirespeed
skip 4
export mod_vampire_max_health
align 4
LABELV mod_vampire_max_health
skip 4
export mod_cgdelay
align 4
LABELV mod_cgdelay
skip 4
export mod_pldelay
align 4
LABELV mod_pldelay
skip 4
export mod_ngdelay
align 4
LABELV mod_ngdelay
skip 4
export mod_bfgdelay
align 4
LABELV mod_bfgdelay
skip 4
export mod_rgdelay
align 4
LABELV mod_rgdelay
skip 4
export mod_pgdelay
align 4
LABELV mod_pgdelay
skip 4
export mod_lgdelay
align 4
LABELV mod_lgdelay
skip 4
export mod_rldelay
align 4
LABELV mod_rldelay
skip 4
export mod_gldelay
align 4
LABELV mod_gldelay
skip 4
export mod_sgdelay
align 4
LABELV mod_sgdelay
skip 4
export mod_mgdelay
align 4
LABELV mod_mgdelay
skip 4
export mod_gdelay
align 4
LABELV mod_gdelay
skip 4
export mod_ghtimeout
align 4
LABELV mod_ghtimeout
skip 4
export mod_ammolimit
align 4
LABELV mod_ammolimit
skip 4
export mod_jumpheight
align 4
LABELV mod_jumpheight
skip 4
export cg_leiWidescreen
align 4
LABELV cg_leiWidescreen
skip 272
export cg_pmove_msec
align 4
LABELV cg_pmove_msec
skip 272
export cg_hudFiles
align 4
LABELV cg_hudFiles
skip 272
export g_ammolimit
align 4
LABELV g_ammolimit
skip 272
export realVidHeight
align 4
LABELV realVidHeight
skip 4
export realVidWidth
align 4
LABELV realVidWidth
skip 4
import trap_R_LFX_ParticleEffect
export wideAdjustX
align 4
LABELV wideAdjustX
skip 4
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
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_LoadMenus
import CG_Cvar_ClampInt
import CG_PredictWeaponEffects
export cg_developer
align 4
LABELV cg_developer
skip 272
export cg_leiChibi
align 4
LABELV cg_leiChibi
skip 272
export cg_missionpackChecks
align 4
LABELV cg_missionpackChecks
skip 272
export cg_teamChatBeep
align 4
LABELV cg_teamChatBeep
skip 272
export cg_chatBeep
align 4
LABELV cg_chatBeep
skip 272
export cg_weaponOrder
align 4
LABELV cg_weaponOrder
skip 272
export cg_weaponBarStyle
align 4
LABELV cg_weaponBarStyle
skip 272
export cg_crosshairColorBlue
align 4
LABELV cg_crosshairColorBlue
skip 272
export cg_crosshairColorGreen
align 4
LABELV cg_crosshairColorGreen
skip 272
export cg_crosshairColorRed
align 4
LABELV cg_crosshairColorRed
skip 272
export cg_ch13size
align 4
LABELV cg_ch13size
skip 272
export cg_ch13
align 4
LABELV cg_ch13
skip 272
export cg_ch12size
align 4
LABELV cg_ch12size
skip 272
export cg_ch12
align 4
LABELV cg_ch12
skip 272
export cg_ch11size
align 4
LABELV cg_ch11size
skip 272
export cg_ch11
align 4
LABELV cg_ch11
skip 272
export cg_ch10size
align 4
LABELV cg_ch10size
skip 272
export cg_ch10
align 4
LABELV cg_ch10
skip 272
export cg_ch9size
align 4
LABELV cg_ch9size
skip 272
export cg_ch9
align 4
LABELV cg_ch9
skip 272
export cg_ch8size
align 4
LABELV cg_ch8size
skip 272
export cg_ch8
align 4
LABELV cg_ch8
skip 272
export cg_ch7size
align 4
LABELV cg_ch7size
skip 272
export cg_ch7
align 4
LABELV cg_ch7
skip 272
export cg_ch6size
align 4
LABELV cg_ch6size
skip 272
export cg_ch6
align 4
LABELV cg_ch6
skip 272
export cg_ch5size
align 4
LABELV cg_ch5size
skip 272
export cg_ch5
align 4
LABELV cg_ch5
skip 272
export cg_ch4size
align 4
LABELV cg_ch4size
skip 272
export cg_ch4
align 4
LABELV cg_ch4
skip 272
export cg_ch3size
align 4
LABELV cg_ch3size
skip 272
export cg_ch3
align 4
LABELV cg_ch3
skip 272
export cg_ch2size
align 4
LABELV cg_ch2size
skip 272
export cg_ch2
align 4
LABELV cg_ch2
skip 272
export cg_ch1size
align 4
LABELV cg_ch1size
skip 272
export cg_ch1
align 4
LABELV cg_ch1
skip 272
export cg_differentCrosshairs
align 4
LABELV cg_differentCrosshairs
skip 272
export cg_crosshairPulse
align 4
LABELV cg_crosshairPulse
skip 272
export cg_fragmsgsize
align 4
LABELV cg_fragmsgsize
skip 272
export cg_autovertex
align 4
LABELV cg_autovertex
skip 272
export cg_vote_custom_commands
align 4
LABELV cg_vote_custom_commands
skip 272
export cg_cyclegrapple
align 4
LABELV cg_cyclegrapple
skip 272
export cg_voteflags
align 4
LABELV cg_voteflags
skip 272
export cg_voip_teamonly
align 4
LABELV cg_voip_teamonly
skip 272
export cg_hitsound
align 4
LABELV cg_hitsound
skip 272
export cg_alwaysWeaponBar
align 4
LABELV cg_alwaysWeaponBar
skip 272
export cl_timeNudge
align 4
LABELV cl_timeNudge
skip 272
export cg_optimizePrediction
align 4
LABELV cg_optimizePrediction
skip 272
export cg_projectileNudge
align 4
LABELV cg_projectileNudge
skip 272
export sv_fps
align 4
LABELV sv_fps
skip 272
export cg_cmdTimeNudge
align 4
LABELV cg_cmdTimeNudge
skip 272
export cg_delag
align 4
LABELV cg_delag
skip 272
export cg_enableFS
align 4
LABELV cg_enableFS
skip 272
export cg_enableQ
align 4
LABELV cg_enableQ
skip 272
export cg_enableBreath
align 4
LABELV cg_enableBreath
skip 272
export cg_enableDust
align 4
LABELV cg_enableDust
skip 272
export cg_obeliskRespawnDelay
align 4
LABELV cg_obeliskRespawnDelay
skip 272
export cg_music
align 4
LABELV cg_music
skip 272
export cg_trueLightning
align 4
LABELV cg_trueLightning
skip 272
export cg_oldPlasma
align 4
LABELV cg_oldPlasma
skip 272
export cg_modelEyes_Fwd
align 4
LABELV cg_modelEyes_Fwd
skip 272
export cg_modelEyes_Right
align 4
LABELV cg_modelEyes_Right
skip 272
export cg_modelEyes_Up
align 4
LABELV cg_modelEyes_Up
skip 272
export cg_cameraEyes_Up
align 4
LABELV cg_cameraEyes_Up
skip 272
export cg_cameraEyes_Fwd
align 4
LABELV cg_cameraEyes_Fwd
skip 272
export cg_cameraEyes
align 4
LABELV cg_cameraEyes
skip 272
export cg_cameramode
align 4
LABELV cg_cameramode
skip 272
export cg_deathcam
align 4
LABELV cg_deathcam
skip 272
export cg_leiDebug
align 4
LABELV cg_leiDebug
skip 272
export cg_muzzleflashStyle
align 4
LABELV cg_muzzleflashStyle
skip 272
export cg_leiSuperGoreyAwesome
align 4
LABELV cg_leiSuperGoreyAwesome
skip 272
export cg_leiBrassNoise
align 4
LABELV cg_leiBrassNoise
skip 272
export cg_leiGoreNoise
align 4
LABELV cg_leiGoreNoise
skip 272
export cg_leiEnhancement
align 4
LABELV cg_leiEnhancement
skip 272
export cg_oldRocket
align 4
LABELV cg_oldRocket
skip 272
export cg_oldRail
align 4
LABELV cg_oldRail
skip 272
export cg_noProjectileTrail
align 4
LABELV cg_noProjectileTrail
skip 272
export cg_noTaunt
align 4
LABELV cg_noTaunt
skip 272
export cg_bigFont
align 4
LABELV cg_bigFont
skip 272
export cg_smallFont
align 4
LABELV cg_smallFont
skip 272
export cg_timescale
align 4
LABELV cg_timescale
skip 272
export cg_timescaleFadeSpeed
align 4
LABELV cg_timescaleFadeSpeed
skip 272
export cg_timescaleFadeEnd
align 4
LABELV cg_timescaleFadeEnd
skip 272
export cg_cameraOrbitDelay
align 4
LABELV cg_cameraOrbitDelay
skip 272
export cg_cameraOrbit
align 4
LABELV cg_cameraOrbit
skip 272
export pmove_float
align 4
LABELV pmove_float
skip 272
export pmove_msec
align 4
LABELV pmove_msec
skip 272
export pmove_fixed
align 4
LABELV pmove_fixed
skip 272
export cg_obituaryOutput
align 4
LABELV cg_obituaryOutput
skip 272
export cg_scorePlum
align 4
LABELV cg_scorePlum
skip 272
export cg_noVoiceText
align 4
LABELV cg_noVoiceText
skip 272
export cg_noVoiceChats
align 4
LABELV cg_noVoiceChats
skip 272
export cg_teamChatsOnly
align 4
LABELV cg_teamChatsOnly
skip 272
export cg_drawFriend
align 4
LABELV cg_drawFriend
skip 272
export cg_deferPlayers
align 4
LABELV cg_deferPlayers
skip 272
export cg_predictItems
align 4
LABELV cg_predictItems
skip 272
export cg_blood
align 4
LABELV cg_blood
skip 272
export cg_paused
align 4
LABELV cg_paused
skip 272
export cg_buildScript
align 4
LABELV cg_buildScript
skip 272
export cg_forceModel
align 4
LABELV cg_forceModel
skip 272
export cg_stats
align 4
LABELV cg_stats
skip 272
export cg_teamChatHeight
align 4
LABELV cg_teamChatHeight
skip 272
export cg_teamChatTime
align 4
LABELV cg_teamChatTime
skip 272
export cg_synchronousClients
align 4
LABELV cg_synchronousClients
skip 272
export cg_drawSpeed
align 4
LABELV cg_drawSpeed
skip 272
export cg_drawAttacker
align 4
LABELV cg_drawAttacker
skip 272
export cg_lagometer
align 4
LABELV cg_lagometer
skip 272
export cg_thirdPerson
align 4
LABELV cg_thirdPerson
skip 272
export cg_thirdPersonAngle
align 4
LABELV cg_thirdPersonAngle
skip 272
export cg_thirdPersonRange
align 4
LABELV cg_thirdPersonRange
skip 272
export cg_zoomFov
align 4
LABELV cg_zoomFov
skip 272
export cg_fov
align 4
LABELV cg_fov
skip 272
export cg_simpleItems
align 4
LABELV cg_simpleItems
skip 272
export cg_ignore
align 4
LABELV cg_ignore
skip 272
export cg_autoswitch
align 4
LABELV cg_autoswitch
skip 272
export cg_tracerLength
align 4
LABELV cg_tracerLength
skip 272
export cg_tracerWidth
align 4
LABELV cg_tracerWidth
skip 272
export cg_tracerChance
align 4
LABELV cg_tracerChance
skip 272
export cg_viewnudge
align 4
LABELV cg_viewnudge
skip 272
export cg_viewsize
align 4
LABELV cg_viewsize
skip 272
export cg_drawGun
align 4
LABELV cg_drawGun
skip 272
export cg_gun_z
align 4
LABELV cg_gun_z
skip 272
export cg_gun_y
align 4
LABELV cg_gun_y
skip 272
export cg_gun_x
align 4
LABELV cg_gun_x
skip 272
export cg_gun_frame
align 4
LABELV cg_gun_frame
skip 272
export cg_brassTime
align 4
LABELV cg_brassTime
skip 272
export cg_addMarks
align 4
LABELV cg_addMarks
skip 272
export cg_footsteps
align 4
LABELV cg_footsteps
skip 272
export cg_showmiss
align 4
LABELV cg_showmiss
skip 272
export cg_noPlayerAnims
align 4
LABELV cg_noPlayerAnims
skip 272
export cg_nopredict
align 4
LABELV cg_nopredict
skip 272
export cg_errorDecay
align 4
LABELV cg_errorDecay
skip 272
export cg_railTrailTime
align 4
LABELV cg_railTrailTime
skip 272
export cg_debugEvents
align 4
LABELV cg_debugEvents
skip 272
export cg_debugPosition
align 4
LABELV cg_debugPosition
skip 272
export cg_debugAnim
align 4
LABELV cg_debugAnim
skip 272
export cg_animSpeed
align 4
LABELV cg_animSpeed
skip 272
export cg_draw2D
align 4
LABELV cg_draw2D
skip 272
export cg_drawStatus
align 4
LABELV cg_drawStatus
skip 272
export cg_crosshairHealth
align 4
LABELV cg_crosshairHealth
skip 272
export cg_crosshairSize
align 4
LABELV cg_crosshairSize
skip 272
export cg_crosshairY
align 4
LABELV cg_crosshairY
skip 272
export cg_crosshairX
align 4
LABELV cg_crosshairX
skip 272
export cg_teamOverlayUserinfo
align 4
LABELV cg_teamOverlayUserinfo
skip 272
export cg_drawTeamOverlay
align 4
LABELV cg_drawTeamOverlay
skip 272
export cg_drawRewards
align 4
LABELV cg_drawRewards
skip 272
export cg_drawCrosshairNames
align 4
LABELV cg_drawCrosshairNames
skip 272
export cg_drawCrosshair
align 4
LABELV cg_drawCrosshair
skip 272
export cg_drawAmmoWarning
align 4
LABELV cg_drawAmmoWarning
skip 272
export cg_drawIcons
align 4
LABELV cg_drawIcons
skip 272
export cg_draw3dIcons
align 4
LABELV cg_draw3dIcons
skip 272
export cg_drawSnapshot
align 4
LABELV cg_drawSnapshot
skip 272
export cg_drawFPS
align 4
LABELV cg_drawFPS
skip 272
export cg_drawTimer
align 4
LABELV cg_drawTimer
skip 272
export cg_gibs
align 4
LABELV cg_gibs
skip 272
export cg_shadows
align 4
LABELV cg_shadows
skip 272
export cg_swingSpeed
align 4
LABELV cg_swingSpeed
skip 272
export cg_kickScale
align 4
LABELV cg_kickScale
skip 272
export cg_bobmodel
align 4
LABELV cg_bobmodel
skip 272
export cg_bobroll
align 4
LABELV cg_bobroll
skip 272
export cg_bobpitch
align 4
LABELV cg_bobpitch
skip 272
export cg_bobup
align 4
LABELV cg_bobup
skip 272
export cg_bob
align 4
LABELV cg_bob
skip 272
export cg_runroll
align 4
LABELV cg_runroll
skip 272
export cg_runpitch
align 4
LABELV cg_runpitch
skip 272
export cg_centertime
align 4
LABELV cg_centertime
skip 272
export mod_sgspread
align 4
LABELV mod_sgspread
skip 4
export mod_sgcount
align 4
LABELV mod_sgcount
skip 4
export mod_lgrange
align 4
LABELV mod_lgrange
skip 4
export mod_cgspread
align 4
LABELV mod_cgspread
skip 4
export mod_mgspread
align 4
LABELV mod_mgspread
skip 4
import cg_markPolys
export cg_items
align 4
LABELV cg_items
skip 6144
export cg_weapons
align 4
LABELV cg_weapons
skip 2752
export cg_entities
align 4
LABELV cg_entities
skip 958464
export cg
align 4
LABELV cg
skip 156552
export cgs
align 4
LABELV cgs
skip 181716
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
LABELV $1583
byte 1 118
byte 1 105
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $1566
byte 1 114
byte 1 95
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1561
byte 1 114
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1558
byte 1 50
byte 1 0
align 1
LABELV $1555
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1550
byte 1 114
byte 1 95
byte 1 112
byte 1 105
byte 1 99
byte 1 109
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $1542
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $1539
byte 1 114
byte 1 95
byte 1 115
byte 1 117
byte 1 98
byte 1 100
byte 1 105
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $1532
byte 1 114
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 101
byte 1 120
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1514
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1513
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $1512
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $1509
byte 1 99
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $1507
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 47
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1506
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 111
byte 1 97
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $1474
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 50
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1471
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 95
byte 1 103
byte 1 108
byte 1 111
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1468
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1465
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1462
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1454
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $1447
byte 1 67
byte 1 71
byte 1 95
byte 1 67
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1422
byte 1 37
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $1394
byte 1 42
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1387
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1384
byte 1 119
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $1381
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1378
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1375
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 95
byte 1 108
byte 1 103
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1372
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1369
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1358
byte 1 108
byte 1 101
byte 1 105
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 52
byte 1 0
align 1
LABELV $1355
byte 1 108
byte 1 101
byte 1 105
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 51
byte 1 0
align 1
LABELV $1352
byte 1 108
byte 1 101
byte 1 105
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 50
byte 1 0
align 1
LABELV $1349
byte 1 108
byte 1 101
byte 1 105
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 49
byte 1 0
align 1
LABELV $1346
byte 1 108
byte 1 101
byte 1 105
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 52
byte 1 0
align 1
LABELV $1343
byte 1 108
byte 1 101
byte 1 105
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 51
byte 1 0
align 1
LABELV $1340
byte 1 108
byte 1 101
byte 1 105
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 50
byte 1 0
align 1
LABELV $1337
byte 1 108
byte 1 101
byte 1 105
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 49
byte 1 0
align 1
LABELV $1334
byte 1 108
byte 1 101
byte 1 105
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 50
byte 1 0
align 1
LABELV $1331
byte 1 108
byte 1 101
byte 1 105
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 49
byte 1 0
align 1
LABELV $1328
byte 1 108
byte 1 101
byte 1 105
byte 1 102
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1325
byte 1 108
byte 1 101
byte 1 105
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 49
byte 1 0
align 1
LABELV $1322
byte 1 108
byte 1 101
byte 1 105
byte 1 115
byte 1 112
byte 1 97
byte 1 114
byte 1 107
byte 1 50
byte 1 0
align 1
LABELV $1319
byte 1 108
byte 1 101
byte 1 105
byte 1 115
byte 1 112
byte 1 97
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1316
byte 1 108
byte 1 101
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $1313
byte 1 108
byte 1 101
byte 1 105
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 52
byte 1 0
align 1
LABELV $1310
byte 1 108
byte 1 101
byte 1 105
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 51
byte 1 0
align 1
LABELV $1307
byte 1 108
byte 1 101
byte 1 105
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $1304
byte 1 108
byte 1 101
byte 1 105
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 49
byte 1 0
align 1
LABELV $1301
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $1298
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $1295
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $1292
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1289
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1286
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1283
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1280
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1277
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1274
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 47
byte 1 106
byte 1 117
byte 1 105
byte 1 99
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1271
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 47
byte 1 105
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1268
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1265
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1262
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1259
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1256
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1253
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 105
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1250
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 119
byte 1 97
byte 1 118
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1247
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1244
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 69
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $1241
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1238
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 48
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1235
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 48
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1232
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1229
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1226
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 111
byte 1 110
byte 1 51
byte 1 0
align 1
LABELV $1221
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 98
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1218
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1215
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 108
byte 1 101
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1212
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1209
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1206
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1203
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1200
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1197
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1194
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 98
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1191
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1188
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1185
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1182
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1179
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 98
byte 1 97
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1176
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 98
byte 1 108
byte 1 117
byte 1 0
align 1
LABELV $1173
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
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
LABELV $1170
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 101
byte 1 0
align 1
LABELV $1160
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1157
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 47
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1154
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1151
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1148
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 47
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1140
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1137
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1134
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1131
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1128
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1120
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 51
byte 1 0
align 1
LABELV $1110
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 49
byte 1 0
align 1
LABELV $1100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 111
byte 1 98
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 47
byte 1 110
byte 1 116
byte 1 114
byte 1 108
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1097
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 111
byte 1 98
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1094
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 111
byte 1 98
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1091
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1088
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1085
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1082
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 102
byte 1 108
byte 1 97
byte 1 112
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1079
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 112
byte 1 111
byte 1 108
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1076
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 51
byte 1 0
align 1
LABELV $1072
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 50
byte 1 0
align 1
LABELV $1068
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 49
byte 1 0
align 1
LABELV $1065
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1061
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 50
byte 1 0
align 1
LABELV $1057
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 49
byte 1 0
align 1
LABELV $1054
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 110
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1051
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1048
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1033
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 98
byte 1 95
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1030
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 98
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $1026
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 98
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1019
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 97
byte 1 95
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1016
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 97
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $1012
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 97
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1005
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 49
byte 1 95
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1002
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 49
byte 1 95
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $999
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 49
byte 1 95
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $993
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $988
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 98
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $985
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 114
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $975
byte 1 104
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $972
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $969
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 105
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
LABELV $966
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $963
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $960
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $957
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $954
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $951
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $948
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 37
byte 1 48
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $945
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $936
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $933
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $930
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $927
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $924
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $921
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $918
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $915
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
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
byte 1 0
align 1
LABELV $912
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $909
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $906
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $903
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
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
LABELV $900
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $897
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 105
byte 1 110
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $894
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 119
byte 1 95
byte 1 98
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $891
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $888
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $885
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $882
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $879
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $876
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $873
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 49
byte 1 0
align 1
LABELV $870
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $867
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $864
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $861
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 82
byte 1 97
byte 1 103
byte 1 101
byte 1 80
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $858
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $855
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $852
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $849
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $846
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $843
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $840
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 66
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 66
byte 1 108
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $837
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 53
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $833
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 52
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $829
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 51
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $825
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $821
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $812
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 97
byte 1 0
align 1
LABELV $807
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 115
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $806
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 110
byte 1 105
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $805
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $804
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $803
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 105
byte 1 120
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $802
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 118
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $801
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 117
byte 1 114
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $800
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $799
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $798
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $797
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 122
byte 1 101
byte 1 114
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $794
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 50
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $791
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $788
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
byte 1 110
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $785
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
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $782
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
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $779
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 99
byte 1 116
byte 1 118
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $776
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $773
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $770
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $767
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 121
byte 1 111
byte 1 117
byte 1 115
byte 1 117
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $764
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $761
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 119
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $758
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
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 95
byte 1 102
byte 1 97
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $755
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
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $752
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
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $749
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 104
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $746
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 118
byte 1 117
byte 1 108
byte 1 99
byte 1 97
byte 1 110
byte 1 47
byte 1 119
byte 1 118
byte 1 117
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $743
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 118
byte 1 117
byte 1 108
byte 1 99
byte 1 97
byte 1 110
byte 1 47
byte 1 119
byte 1 118
byte 1 117
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $740
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 118
byte 1 117
byte 1 108
byte 1 99
byte 1 97
byte 1 110
byte 1 47
byte 1 119
byte 1 118
byte 1 117
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $737
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 119
byte 1 110
byte 1 97
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $734
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 119
byte 1 110
byte 1 97
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $731
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 119
byte 1 110
byte 1 97
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $728
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $725
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $722
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 108
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $719
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 102
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $716
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
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
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $713
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
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
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $710
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
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
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $707
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
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $704
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
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 107
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $701
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
byte 1 102
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $682
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 97
byte 1 110
byte 1 107
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $678
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $674
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $670
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $666
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $662
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $659
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $654
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $651
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
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 117
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $648
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
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $645
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
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $642
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 108
byte 1 111
byte 1 115
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $639
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $636
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $633
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $630
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $627
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 117
byte 1 109
byte 1 105
byte 1 108
byte 1 105
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $624
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 100
byte 1 101
byte 1 110
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $621
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $618
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $615
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $608
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
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $605
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
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $602
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $599
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
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $596
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $593
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $590
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
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 95
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
LABELV $587
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
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 48
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $584
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
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 48
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $581
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
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 48
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $578
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
byte 1 99
byte 1 108
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $575
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
byte 1 99
byte 1 108
byte 1 95
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $572
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
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $569
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
byte 1 99
byte 1 108
byte 1 95
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $566
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
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 95
byte 1 106
byte 1 117
byte 1 105
byte 1 99
byte 1 101
byte 1 100
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
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 48
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $560
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
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 48
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $557
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
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 48
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $554
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
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $551
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 108
byte 1 101
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $548
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 108
byte 1 101
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $545
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 108
byte 1 101
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $542
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 108
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $539
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 108
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $536
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 108
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $533
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 108
byte 1 101
byte 1 47
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $530
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 108
byte 1 101
byte 1 47
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $527
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 108
byte 1 101
byte 1 47
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $524
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
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $521
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
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $518
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
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $515
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
byte 1 105
byte 1 98
byte 1 115
byte 1 112
byte 1 108
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $512
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
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $509
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
byte 1 119
byte 1 101
byte 1 97
byte 1 114
byte 1 111
byte 1 102
byte 1 102
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $506
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $503
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
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
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 101
byte 1 116
byte 1 98
byte 1 121
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $500
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 104
byte 1 111
byte 1 108
byte 1 121
byte 1 115
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $497
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $487
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $479
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $476
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $466
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $463
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $460
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $457
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $447
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $444
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $441
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $438
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $435
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $430
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $427
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $424
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $421
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $418
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $415
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $412
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $404
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 112
byte 1 114
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $401
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $398
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $395
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $392
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $389
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 51
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $386
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 50
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $383
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 49
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $380
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 115
byte 1 117
byte 1 100
byte 1 100
byte 1 101
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $377
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 53
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $374
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 49
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $370
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $364
byte 1 80
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $343
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $296
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
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
LABELV $295
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $291
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
LABELV $290
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $289
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $286
byte 1 115
byte 1 118
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $280
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
LABELV $279
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $278
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 117
byte 1 122
byte 1 122
byte 1 108
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $277
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 66
byte 1 101
byte 1 101
byte 1 112
byte 1 0
align 1
LABELV $276
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 66
byte 1 101
byte 1 101
byte 1 112
byte 1 0
align 1
LABELV $275
byte 1 47
byte 1 49
byte 1 47
byte 1 50
byte 1 47
byte 1 52
byte 1 47
byte 1 51
byte 1 47
byte 1 54
byte 1 47
byte 1 55
byte 1 47
byte 1 56
byte 1 47
byte 1 53
byte 1 47
byte 1 57
byte 1 47
byte 1 0
align 1
LABELV $274
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $273
byte 1 99
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 66
byte 1 97
byte 1 114
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $272
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $271
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 71
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $270
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $269
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 49
byte 1 51
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $268
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 49
byte 1 51
byte 1 0
align 1
LABELV $267
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 49
byte 1 50
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $266
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 49
byte 1 50
byte 1 0
align 1
LABELV $265
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 49
byte 1 49
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $264
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 49
byte 1 49
byte 1 0
align 1
LABELV $263
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 49
byte 1 48
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $262
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $261
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 57
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $260
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 57
byte 1 0
align 1
LABELV $259
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 56
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $258
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 56
byte 1 0
align 1
LABELV $257
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 55
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $256
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 55
byte 1 0
align 1
LABELV $255
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 54
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $254
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 54
byte 1 0
align 1
LABELV $253
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 53
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $252
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 53
byte 1 0
align 1
LABELV $251
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 52
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $250
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 52
byte 1 0
align 1
LABELV $249
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 51
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $248
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 51
byte 1 0
align 1
LABELV $247
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 50
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $246
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 50
byte 1 0
align 1
LABELV $245
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 49
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $244
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 104
byte 1 49
byte 1 0
align 1
LABELV $243
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 105
byte 1 102
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $242
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 80
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $241
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 109
byte 1 115
byte 1 103
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $240
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $239
byte 1 48
byte 1 46
byte 1 48
byte 1 0
align 1
LABELV $238
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 117
byte 1 101
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $237
byte 1 99
byte 1 108
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 78
byte 1 117
byte 1 100
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $236
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $235
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 78
byte 1 117
byte 1 100
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $234
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $233
byte 1 115
byte 1 118
byte 1 95
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $232
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 109
byte 1 100
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 78
byte 1 117
byte 1 100
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $231
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $230
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $229
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 69
byte 1 121
byte 1 101
byte 1 115
byte 1 95
byte 1 70
byte 1 119
byte 1 100
byte 1 0
align 1
LABELV $228
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 69
byte 1 121
byte 1 101
byte 1 115
byte 1 95
byte 1 82
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $227
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 69
byte 1 121
byte 1 101
byte 1 115
byte 1 95
byte 1 85
byte 1 112
byte 1 0
align 1
LABELV $226
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 69
byte 1 121
byte 1 101
byte 1 115
byte 1 95
byte 1 85
byte 1 112
byte 1 0
align 1
LABELV $225
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 69
byte 1 121
byte 1 101
byte 1 115
byte 1 95
byte 1 70
byte 1 119
byte 1 100
byte 1 0
align 1
LABELV $224
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 69
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $223
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $222
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 99
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $221
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 101
byte 1 105
byte 1 87
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $220
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 101
byte 1 105
byte 1 67
byte 1 104
byte 1 105
byte 1 98
byte 1 105
byte 1 0
align 1
LABELV $219
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 101
byte 1 105
byte 1 68
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 0
align 1
LABELV $218
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 101
byte 1 105
byte 1 83
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 71
byte 1 111
byte 1 114
byte 1 101
byte 1 121
byte 1 65
byte 1 119
byte 1 101
byte 1 115
byte 1 111
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $217
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 101
byte 1 105
byte 1 66
byte 1 114
byte 1 97
byte 1 115
byte 1 115
byte 1 78
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $216
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 101
byte 1 105
byte 1 71
byte 1 111
byte 1 114
byte 1 101
byte 1 78
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $215
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 101
byte 1 105
byte 1 69
byte 1 110
byte 1 104
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $214
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $213
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $212
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 105
byte 1 103
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $211
byte 1 48
byte 1 46
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $210
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $209
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 80
byte 1 114
byte 1 111
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $208
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $207
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $206
byte 1 49
byte 1 49
byte 1 0
align 1
LABELV $205
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $204
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $203
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 79
byte 1 117
byte 1 116
byte 1 112
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $202
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 80
byte 1 108
byte 1 117
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $201
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $200
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $199
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 69
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $198
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $197
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
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $196
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
LABELV $195
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $194
byte 1 103
byte 1 95
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $193
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 66
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $192
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 68
byte 1 117
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $191
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 81
byte 1 0
align 1
LABELV $190
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 70
byte 1 83
byte 1 0
align 1
LABELV $189
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $188
byte 1 103
byte 1 95
byte 1 115
byte 1 121
byte 1 110
byte 1 99
byte 1 104
byte 1 114
byte 1 111
byte 1 110
byte 1 111
byte 1 117
byte 1 115
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $187
byte 1 0
align 1
LABELV $186
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 95
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 95
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $185
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $184
byte 1 42
byte 1 0
align 1
LABELV $183
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $182
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 111
byte 1 105
byte 1 112
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 110
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $181
byte 1 99
byte 1 103
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $180
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 108
byte 1 119
byte 1 97
byte 1 121
byte 1 115
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 66
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $179
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $178
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $177
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $176
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 86
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $175
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 86
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $174
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 79
byte 1 110
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $173
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $172
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $171
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $170
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $169
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $168
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $167
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $166
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 72
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $165
byte 1 51
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $164
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $163
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
LABELV $162
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
LABELV $161
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $160
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
LABELV $159
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $158
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $157
byte 1 48
byte 1 46
byte 1 52
byte 1 0
align 1
LABELV $156
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $155
byte 1 99
byte 1 103
byte 1 95
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
LABELV $154
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $153
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $152
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $151
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $150
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $149
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
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
LABELV $148
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 0
align 1
LABELV $147
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $146
byte 1 48
byte 1 46
byte 1 51
byte 1 0
align 1
LABELV $145
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $144
byte 1 49
byte 1 46
byte 1 48
byte 1 0
align 1
LABELV $143
byte 1 99
byte 1 103
byte 1 95
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 83
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $142
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $141
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $140
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $139
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $138
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 0
align 1
LABELV $137
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 53
byte 1 0
align 1
LABELV $136
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $135
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 50
byte 1 0
align 1
LABELV $134
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $133
byte 1 51
byte 1 0
align 1
LABELV $132
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $131
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 90
byte 1 0
align 1
LABELV $130
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 89
byte 1 0
align 1
LABELV $129
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 88
byte 1 0
align 1
LABELV $128
byte 1 54
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $127
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $126
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $125
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $124
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $123
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $122
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 114
byte 1 97
byte 1 115
byte 1 115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $121
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 89
byte 1 0
align 1
LABELV $120
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 88
byte 1 0
align 1
LABELV $119
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $118
byte 1 50
byte 1 52
byte 1 0
align 1
LABELV $117
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $116
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 82
byte 1 101
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $115
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $114
byte 1 52
byte 1 0
align 1
LABELV $113
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $112
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $111
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $110
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $109
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $108
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 51
byte 1 100
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $106
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 80
byte 1 83
byte 1 0
align 1
LABELV $105
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $104
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $103
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 50
byte 1 68
byte 1 0
align 1
LABELV $102
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 0
align 1
LABELV $101
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 115
byte 1 0
align 1
LABELV $100
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 110
byte 1 117
byte 1 100
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $99
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $98
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
LABELV $97
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $96
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $95
byte 1 50
byte 1 50
byte 1 46
byte 1 53
byte 1 0
align 1
LABELV $94
byte 1 99
byte 1 103
byte 1 95
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $93
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $92
byte 1 49
byte 1 0
align 1
LABELV $91
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $90
byte 1 48
byte 1 0
align 1
LABELV $89
byte 1 99
byte 1 103
byte 1 95
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $86
byte 1 118
byte 1 109
byte 1 77
byte 1 97
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 0
