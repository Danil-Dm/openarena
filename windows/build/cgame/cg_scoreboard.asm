code
proc CG_DrawClientScore 1080 28
file "../../../code/cgame/cg_scoreboard.c"
line 80
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
;23:// cg_scoreboard -- draw the scoreboard on top of the game screen
;24:#include "cg_local.h"
;25:
;26:
;27:#define SCOREBOARD_X  (0)
;28:
;29:#define SB_HEADER   86
;30:#define SB_TOP    (SB_HEADER+32)
;31:
;32:// Where the status bar starts, so we don't overwrite it
;33:#define SB_STATUSBAR  420
;34:
;35:#define SB_NORMAL_HEIGHT 40
;36:#define SB_INTER_HEIGHT  16 // interleaved height
;37:
;38:#define SB_MAXCLIENTS_NORMAL  ((SB_STATUSBAR - SB_TOP) / SB_NORMAL_HEIGHT)
;39:#define SB_MAXCLIENTS_INTER   ((SB_STATUSBAR - SB_TOP) / SB_INTER_HEIGHT - 1)
;40:
;41:// Used when interleaved
;42:
;43:
;44:
;45:#define SB_LEFT_BOTICON_X (SCOREBOARD_X+0)
;46:#define SB_LEFT_HEAD_X  (SCOREBOARD_X+32)
;47:#define SB_RIGHT_BOTICON_X (SCOREBOARD_X+64)
;48:#define SB_RIGHT_HEAD_X  (SCOREBOARD_X+96)
;49:// Normal
;50:#define SB_BOTICON_X  (SCOREBOARD_X+32)
;51:#define SB_HEAD_X   (SCOREBOARD_X+64)
;52:
;53:#define SB_SCORELINE_X  112
;54:
;55:#define SB_RATING_WIDTH     (6 * BIGCHAR_WIDTH) // width 6
;56:#define SB_SCORE_X   (SB_SCORELINE_X + BIGCHAR_WIDTH) // width 6
;57:#define SB_RATING_X   (SB_SCORELINE_X + 6 * BIGCHAR_WIDTH) // width 6
;58:#define SB_PING_X   (SB_SCORELINE_X + 12 * BIGCHAR_WIDTH + 8) // width 5
;59:#define SB_TIME_X   (SB_SCORELINE_X + 17 * BIGCHAR_WIDTH + 8) // width 5
;60:#define SB_NAME_X   (SB_SCORELINE_X + 22 * BIGCHAR_WIDTH) // width 15
;61:
;62:// The new and improved score board
;63://
;64:// In cases where the number of clients is high, the score board heads are interleaved
;65:// here's the layout
;66:
;67://
;68://	0   32   80  112  144   240  320  400   <-- pixel position
;69://  bot head bot head score ping time name
;70://  
;71://  wins/losses are drawn on bot icon now
;72:
;73:static qboolean localClient; // true if local client has been displayed
;74:
;75:/*
;76:=================
;77:CG_DrawScoreboard
;78:=================
;79: */
;80:static void CG_DrawClientScore(int y, score_t *score, float *color, float fade, qboolean largeFormat) {
line 86
;81:	char string[1024];
;82:	vec3_t headAngles;
;83:	clientInfo_t *ci;
;84:	int iconx, headx;
;85:
;86:	if (score->client < 0 || score->client >= cgs.maxclients) {
ADDRLP4 1048
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
LTI4 $78
ADDRLP4 1048
INDIRI4
ADDRGP4 cgs+31488
INDIRI4
LTI4 $75
LABELV $78
line 87
;87:		Com_Printf("Bad score->client: %i\n", score->client);
ADDRGP4 $79
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 88
;88:		return;
ADDRGP4 $74
JUMPV
LABELV $75
line 91
;89:	}
;90:
;91:	ci = &cgs.clientinfo[score->client];
ADDRLP4 0
CNSTI4 2120
ADDRFP4 4
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 93
;92:
;93:	iconx = SB_BOTICON_X + (SB_RATING_WIDTH / 2);
ADDRLP4 1040
CNSTI4 80
ASGNI4
line 94
;94:	headx = SB_HEAD_X + (SB_RATING_WIDTH / 2);
ADDRLP4 1044
CNSTI4 112
ASGNI4
line 97
;95:
;96:	// draw the handicap or bot skill marker (unless player has flag)
;97:	if (ci->powerups & (1 << PW_NEUTRALFLAG)) {
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $81
line 98
;98:		if (largeFormat) {
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $83
line 99
;99:			CG_DrawFlagModel(iconx, y - (32 - BIGCHAR_HEIGHT) / 2, 32, 32, TEAM_FREE, qfalse);
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
CNSTI4 8
SUBI4
CVIF4 4
ARGF4
ADDRLP4 1052
CNSTF4 1107296256
ASGNF4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 100
;100:		} else {
ADDRGP4 $82
JUMPV
LABELV $83
line 101
;101:			CG_DrawFlagModel(iconx, y, 16, 16, TEAM_FREE, qfalse);
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1052
CNSTF4 1098907648
ASGNF4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 102
;102:		}
line 103
;103:	} else if (ci->powerups & (1 << PW_REDFLAG)) {
ADDRGP4 $82
JUMPV
LABELV $81
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $85
line 104
;104:		if (largeFormat) {
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $87
line 105
;105:			CG_DrawFlagModel(iconx, y - (32 - BIGCHAR_HEIGHT) / 2, 32, 32, TEAM_RED, qfalse);
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
CNSTI4 8
SUBI4
CVIF4 4
ARGF4
ADDRLP4 1052
CNSTF4 1107296256
ASGNF4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRLP4 1052
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 106
;106:		} else {
ADDRGP4 $86
JUMPV
LABELV $87
line 107
;107:			CG_DrawFlagModel(iconx, y, 16, 16, TEAM_RED, qfalse);
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1052
CNSTF4 1098907648
ASGNF4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRLP4 1052
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 108
;108:		}
line 109
;109:	} else if (ci->powerups & (1 << PW_BLUEFLAG)) {
ADDRGP4 $86
JUMPV
LABELV $85
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $89
line 110
;110:		if (largeFormat) {
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $91
line 111
;111:			CG_DrawFlagModel(iconx, y - (32 - BIGCHAR_HEIGHT) / 2, 32, 32, TEAM_BLUE, qfalse);
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
CNSTI4 8
SUBI4
CVIF4 4
ARGF4
ADDRLP4 1052
CNSTF4 1107296256
ASGNF4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRLP4 1052
INDIRF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 112
;112:		} else {
ADDRGP4 $90
JUMPV
LABELV $91
line 113
;113:			CG_DrawFlagModel(iconx, y, 16, 16, TEAM_BLUE, qfalse);
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1052
CNSTF4 1098907648
ASGNF4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRLP4 1052
INDIRF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 114
;114:		}
line 115
;115:	} else {
ADDRGP4 $90
JUMPV
LABELV $89
line 116
;116:		if (ci->botSkill > 0 && ci->botSkill <= 5) {
ADDRLP4 1052
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
LEI4 $93
ADDRLP4 1052
INDIRI4
CNSTI4 5
GTI4 $93
line 117
;117:			if (cg_drawIcons.integer) {
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $94
line 118
;118:				if (largeFormat) {
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $98
line 119
;119:					CG_DrawPic(iconx, y - (32 - BIGCHAR_HEIGHT) / 2, 32, 32, cgs.media.botSkillShaders[ ci->botSkill - 1 ]);
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
CNSTI4 8
SUBI4
CVIF4 4
ARGF4
ADDRLP4 1056
CNSTF4 1107296256
ASGNF4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+500-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 120
;120:				} else {
ADDRGP4 $94
JUMPV
LABELV $98
line 121
;121:					CG_DrawPic(iconx, y, 16, 16, cgs.media.botSkillShaders[ ci->botSkill - 1 ]);
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1056
CNSTF4 1098907648
ASGNF4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+500-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 122
;122:				}
line 123
;123:			}
line 124
;124:		} else if (ci->handicap < 100) {
ADDRGP4 $94
JUMPV
LABELV $93
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 100
GEI4 $106
line 125
;125:			Com_sprintf(string, sizeof ( string), "%i", ci->handicap);
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $108
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 126
;126:			if (cgs.gametype == GT_TOURNAMENT)
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $109
line 127
;127:				CG_DrawSmallStringColor(iconx, y - SMALLCHAR_HEIGHT / 2, string, color);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 8
SUBI4
ARGI4
ADDRLP4 16
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
ADDRGP4 $110
JUMPV
LABELV $109
line 129
;128:			else
;129:				CG_DrawSmallStringColor(iconx, y, string, color);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
LABELV $110
line 130
;130:		}
LABELV $106
LABELV $94
line 133
;131:
;132:		// draw the wins / losses
;133:		if (cgs.gametype == GT_TOURNAMENT) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $112
line 134
;134:			Com_sprintf(string, sizeof ( string), "%i/%i", ci->wins, ci->losses);
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $115
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 135
;135:			if (ci->handicap < 100 && !ci->botSkill) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 100
GEI4 $116
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
NEI4 $116
line 136
;136:				CG_DrawSmallStringColor(iconx, y + SMALLCHAR_HEIGHT / 2, string, color);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 8
ADDI4
ARGI4
ADDRLP4 16
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
line 137
;137:			} else {
ADDRGP4 $117
JUMPV
LABELV $116
line 138
;138:				CG_DrawSmallStringColor(iconx, y, string, color);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
line 139
;139:			}
LABELV $117
line 140
;140:		}
LABELV $112
line 141
;141:	}
LABELV $90
LABELV $86
LABELV $82
line 144
;142:
;143:	// draw the face
;144:	VectorClear(headAngles);
ADDRLP4 1052
CNSTF4 0
ASGNF4
ADDRLP4 4+8
ADDRLP4 1052
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 1052
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 1052
INDIRF4
ASGNF4
line 145
;145:	headAngles[YAW] = 180;
ADDRLP4 4+4
CNSTF4 1127481344
ASGNF4
line 146
;146:	if (largeFormat) {
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $121
line 147
;147:		CG_DrawHead(headx, y - (ICON_SIZE - BIGCHAR_HEIGHT) / 2, ICON_SIZE, ICON_SIZE,
ADDRLP4 1044
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
CNSTI4 16
SUBI4
CVIF4 4
ARGF4
ADDRLP4 1056
CNSTF4 1111490560
ASGNF4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 149
;148:				score->client, headAngles);
;149:	} else {
ADDRGP4 $122
JUMPV
LABELV $121
line 150
;150:		CG_DrawHead(headx, y, 16, 16, score->client, headAngles);
ADDRLP4 1044
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1056
CNSTF4 1098907648
ASGNF4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 151
;151:	}
LABELV $122
line 166
;152:
;153:#ifdef MISSIONPACK
;154:	// draw the team task
;155:	if (ci->teamTask != TEAMTASK_NONE) {
;156:		if (ci->isDead) {
;157:			CG_DrawPic(headx + 48, y, 16, 16, cgs.media.deathShader);
;158:		} else if (ci->teamTask == TEAMTASK_OFFENSE) {
;159:			CG_DrawPic(headx + 48, y, 16, 16, cgs.media.assaultShader);
;160:		} else if (ci->teamTask == TEAMTASK_DEFENSE) {
;161:			CG_DrawPic(headx + 48, y, 16, 16, cgs.media.defendShader);
;162:		}
;163:	}
;164:#endif
;165:	// draw the score line
;166:	if (score->ping == -1) {
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $123
line 167
;167:		Com_sprintf(string, sizeof (string),
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $125
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 169
;168:				" connecting    %s", ci->name);
;169:	} else if (ci->team == TEAM_SPECTATOR) {
ADDRGP4 $124
JUMPV
LABELV $123
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 3
NEI4 $126
line 170
;170:		Com_sprintf(string, sizeof (string),
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $128
ARGP4
ADDRLP4 1056
ADDRFP4 4
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
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 172
;171:				" SPECT %3i %4i %s", score->ping, score->time, ci->name);
;172:	} else {
ADDRGP4 $127
JUMPV
LABELV $126
line 181
;173:		/*if(cgs.gametype == GT_LMS)
;174:			Com_sprintf(string, sizeof(string),
;175:				"%5i %4i %4i %s *%i*", score->score, score->ping, score->time, ci->name, ci->isDead);
;176:		else*/
;177:		/*if(ci->isDead)
;178:			Com_sprintf(string, sizeof(string),
;179:				"%5i %4i %4i %s *DEAD*", score->score, score->ping, score->time, ci->name);
;180:		else*/
;181:		Com_sprintf(string, sizeof (string),
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $129
ARGP4
ADDRLP4 1056
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1060
CNSTI4 4
ASGNI4
ADDRLP4 1056
INDIRP4
ADDRLP4 1060
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 1056
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1056
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ADDRLP4 1060
INDIRI4
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 183
;182:				"%5i %4i %4i %s", score->score, score->ping, score->time, ci->name);
;183:	}
LABELV $127
LABELV $124
line 186
;184:
;185:	// highlight your position
;186:	if (score->client == cg.snap->ps.clientNum) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $130
line 190
;187:		float hcolor[4];
;188:		int rank;
;189:
;190:		localClient = qtrue;
ADDRGP4 localClient
CNSTI4 1
ASGNI4
line 192
;191:
;192:		if ((cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) ||
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
EQI4 $137
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 1076
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
EQI4 $133
LABELV $137
line 193
;193:				CG_IsATeamGametype(cgs.gametype)) {
line 195
;194:			// Sago: I think this means that it doesn't matter if two players are tied in team game - only team score counts
;195:			rank = -1;
ADDRLP4 1072
CNSTI4 -1
ASGNI4
line 196
;196:		} else {
ADDRGP4 $134
JUMPV
LABELV $133
line 197
;197:			rank = cg.snap->ps.persistant[PERS_RANK] & ~RANK_TIED_FLAG;
ADDRLP4 1072
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 198
;198:		}
LABELV $134
line 199
;199:		if (rank == 0) {
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $139
line 200
;200:			hcolor[0] = 0;
ADDRLP4 1056
CNSTF4 0
ASGNF4
line 201
;201:			hcolor[1] = 0;
ADDRLP4 1056+4
CNSTF4 0
ASGNF4
line 202
;202:			hcolor[2] = 0.7f;
ADDRLP4 1056+8
CNSTF4 1060320051
ASGNF4
line 203
;203:		} else if (rank == 1) {
ADDRGP4 $140
JUMPV
LABELV $139
ADDRLP4 1072
INDIRI4
CNSTI4 1
NEI4 $143
line 204
;204:			hcolor[0] = 0.7f;
ADDRLP4 1056
CNSTF4 1060320051
ASGNF4
line 205
;205:			hcolor[1] = 0;
ADDRLP4 1056+4
CNSTF4 0
ASGNF4
line 206
;206:			hcolor[2] = 0;
ADDRLP4 1056+8
CNSTF4 0
ASGNF4
line 207
;207:		} else if (rank == 2) {
ADDRGP4 $144
JUMPV
LABELV $143
ADDRLP4 1072
INDIRI4
CNSTI4 2
NEI4 $147
line 208
;208:			hcolor[0] = 0.7f;
ADDRLP4 1056
CNSTF4 1060320051
ASGNF4
line 209
;209:			hcolor[1] = 0.7f;
ADDRLP4 1056+4
CNSTF4 1060320051
ASGNF4
line 210
;210:			hcolor[2] = 0;
ADDRLP4 1056+8
CNSTF4 0
ASGNF4
line 211
;211:		} else {
ADDRGP4 $148
JUMPV
LABELV $147
line 212
;212:			hcolor[0] = 0.7f;
ADDRLP4 1056
CNSTF4 1060320051
ASGNF4
line 213
;213:			hcolor[1] = 0.7f;
ADDRLP4 1056+4
CNSTF4 1060320051
ASGNF4
line 214
;214:			hcolor[2] = 0.7f;
ADDRLP4 1056+8
CNSTF4 1060320051
ASGNF4
line 215
;215:		}
LABELV $148
LABELV $144
LABELV $140
line 217
;216:
;217:		hcolor[3] = fade * 0.7;
ADDRLP4 1056+12
CNSTF4 1060320051
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 218
;218:		CG_FillRect(SB_SCORELINE_X + BIGCHAR_WIDTH + (SB_RATING_WIDTH / 2), y,
CNSTF4 1127219200
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1140850688
ARGF4
CNSTF4 1099431936
ARGF4
ADDRLP4 1056
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 220
;219:				640 - SB_SCORELINE_X - BIGCHAR_WIDTH, BIGCHAR_HEIGHT + 1, hcolor);
;220:	}
LABELV $130
line 222
;221:
;222:	CG_DrawBigString(SB_SCORELINE_X + (SB_RATING_WIDTH / 2), y, string, fade);
CNSTI4 160
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 225
;223:
;224:	// add the "ready" marker for intermission exiting
;225:	if (cg.snap->ps.stats[ STAT_CLIENTS_READY ] & (1 << score->client)) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 4
INDIRP4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $154
line 226
;226:		CG_DrawBigStringColor(iconx, y, "READY", color);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $157
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 227
;227:	} else
ADDRGP4 $155
JUMPV
LABELV $154
line 228
;228:		if (cgs.gametype == GT_LMS) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 10
NEI4 $158
line 229
;229:		CG_DrawBigStringColor(iconx - 50, y, va("*%i*", ci->isDead), color);
ADDRGP4 $161
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 2100
ADDP4
INDIRI4
ARGI4
ADDRLP4 1056
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1040
INDIRI4
CNSTI4 50
SUBI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 230
;230:	} else
ADDRGP4 $159
JUMPV
LABELV $158
line 231
;231:		if (ci->isDead) {
ADDRLP4 0
INDIRP4
CNSTI4 2100
ADDP4
INDIRI4
CNSTI4 0
EQI4 $162
line 232
;232:		CG_DrawBigStringColor(iconx - 60, y, "DEAD", color);
ADDRLP4 1040
INDIRI4
CNSTI4 60
SUBI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $164
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 233
;233:	}
LABELV $162
LABELV $159
LABELV $155
line 234
;234:}
LABELV $74
endproc CG_DrawClientScore 1080 28
proc CG_TeamScoreboard 44 20
line 241
;235:
;236:/*
;237:=================
;238:CG_TeamScoreboard
;239:=================
;240: */
;241:static int CG_TeamScoreboard(int y, team_t team, float fade, int maxClients, int lineHeight) {
line 248
;242:	int i;
;243:	score_t *score;
;244:	float color[4];
;245:	int count;
;246:	clientInfo_t *ci;
;247:
;248:	color[0] = color[1] = color[2] = 1.0;
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 16+8
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 32
INDIRF4
ASGNF4
line 249
;249:	color[3] = fade;
ADDRLP4 16+12
ADDRFP4 8
INDIRF4
ASGNF4
line 251
;250:
;251:	count = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 252
;252:	for (i = 0; i < cg.numScores && count < maxClients; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $172
JUMPV
LABELV $169
line 253
;253:		score = &cg.scores[i];
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688
ADDP4
ASGNP4
line 254
;254:		ci = &cgs.clientinfo[ score->client ];
ADDRLP4 12
CNSTI4 2120
ADDRLP4 8
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 256
;255:
;256:		if (team != ci->team) {
ADDRFP4 4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
EQI4 $176
line 257
;257:			continue;
ADDRGP4 $170
JUMPV
LABELV $176
line 260
;258:		}
;259:
;260:		CG_DrawClientScore(y + lineHeight * count, score, color, fade, lineHeight == SB_NORMAL_HEIGHT);
ADDRLP4 40
ADDRFP4 16
INDIRI4
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 40
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
INDIRI4
CNSTI4 40
NEI4 $179
ADDRLP4 36
CNSTI4 1
ASGNI4
ADDRGP4 $180
JUMPV
LABELV $179
ADDRLP4 36
CNSTI4 0
ASGNI4
LABELV $180
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 CG_DrawClientScore
CALLV
pop
line 262
;261:
;262:		count++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 263
;263:	}
LABELV $170
line 252
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $172
ADDRLP4 4
INDIRI4
ADDRGP4 cg+110672
INDIRI4
GEI4 $181
ADDRLP4 0
INDIRI4
ADDRFP4 12
INDIRI4
LTI4 $169
LABELV $181
line 265
;264:
;265:	return count;
ADDRLP4 0
INDIRI4
RETI4
LABELV $165
endproc CG_TeamScoreboard 44 20
export CG_DrawOldScoreboard
proc CG_DrawOldScoreboard 72 24
line 275
;266:}
;267:
;268:/*
;269:=================
;270:CG_DrawScoreboard
;271:
;272:Draw the normal in-game scoreboard
;273:=================
;274: */
;275:qboolean CG_DrawOldScoreboard(void) {
line 285
;276:	int x, y, w, i, n1, n2;
;277:	float fade;
;278:	float *fadeColor;
;279:	char *s;
;280:	int maxClients;
;281:	int lineHeight;
;282:	int topBorderSize, bottomBorderSize;
;283:
;284:	// don't draw amuthing if the menu or console is up
;285:	if (cg_paused.integer) {
ADDRGP4 cg_paused+12
INDIRI4
CNSTI4 0
EQI4 $183
line 286
;286:		cg.deferredPlayerLoading = 0;
ADDRGP4 cg+16
CNSTI4 0
ASGNI4
line 287
;287:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $183
line 290
;288:	}
;289:
;290:	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $187
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 5
NEI4 $187
line 291
;291:		cg.deferredPlayerLoading = 0;
ADDRGP4 cg+16
CNSTI4 0
ASGNI4
line 292
;292:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $187
line 296
;293:	}
;294:
;295:	// don't draw scoreboard during death while warmup up
;296:	if (cg.warmup && !cg.showScores) {
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRGP4 cg+125248
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $193
ADDRGP4 cg+114784
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $193
line 297
;297:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $193
line 300
;298:	}
;299:
;300:	if (cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD ||
ADDRGP4 cg+114784
INDIRI4
CNSTI4 0
NEI4 $205
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 3
EQI4 $205
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 5
NEI4 $197
LABELV $205
line 301
;301:			cg.predictedPlayerState.pm_type == PM_INTERMISSION) {
line 302
;302:		fade = 1.0;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 303
;303:		fadeColor = colorWhite;
ADDRLP4 20
ADDRGP4 colorWhite
ASGNP4
line 304
;304:	} else {
ADDRGP4 $198
JUMPV
LABELV $197
line 305
;305:		fadeColor = CG_FadeColor(cg.scoreFadeTime, FADE_TIME);
ADDRGP4 cg+114792
INDIRI4
ARGI4
CNSTI4 200
ARGI4
ADDRLP4 56
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 56
INDIRP4
ASGNP4
line 307
;306:
;307:		if (!fadeColor) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $207
line 309
;308:			// next time scoreboard comes up, don't print killer
;309:			cg.deferredPlayerLoading = 0;
ADDRGP4 cg+16
CNSTI4 0
ASGNI4
line 310
;310:			cg.killerName[0] = 0;
ADDRGP4 cg+114924
CNSTI1 0
ASGNI1
line 311
;311:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $207
line 313
;312:		}
;313:		fade = *fadeColor;
ADDRLP4 12
ADDRLP4 20
INDIRP4
INDIRF4
ASGNF4
line 314
;314:	}
LABELV $198
line 318
;315:
;316:
;317:	// fragged by ... line
;318:	if (cg.killerName[0]) {
ADDRGP4 cg+114924
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $211
line 319
;319:		s = va("Fragged by %s", cg.killerName);
ADDRGP4 $214
ARGP4
ADDRGP4 cg+114924
ARGP4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 56
INDIRP4
ASGNP4
line 320
;320:		w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 321
;321:		x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 36
CNSTI4 640
ADDRLP4 40
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 322
;322:		y = 40;
ADDRLP4 4
CNSTI4 40
ASGNI4
line 323
;323:		CG_DrawBigString(x, y, s, fade);
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 324
;324:	}
LABELV $211
line 327
;325:
;326:	// current rank
;327:	if (!CG_IsATeamGametype(cgs.gametype)) {
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
NEI4 $216
line 328
;328:		if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
EQI4 $217
line 329
;329:			s = va("%s place with %i",
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 60
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $222
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 64
INDIRP4
ASGNP4
line 332
;330:					CG_PlaceString(cg.snap->ps.persistant[PERS_RANK] + 1),
;331:					cg.snap->ps.persistant[PERS_SCORE]);
;332:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 68
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 333
;333:			x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 36
CNSTI4 640
ADDRLP4 40
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 334
;334:			y = 60;
ADDRLP4 4
CNSTI4 60
ASGNI4
line 335
;335:			CG_DrawBigString(x, y, s, fade);
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 336
;336:		}
line 337
;337:	} else {
ADDRGP4 $217
JUMPV
LABELV $216
line 338
;338:		if (cg.teamScores[0] == cg.teamScores[1]) {
ADDRGP4 cg+110680
INDIRI4
ADDRGP4 cg+110680+4
INDIRI4
NEI4 $225
line 339
;339:			s = va("Teams are tied at %i", cg.teamScores[0]);
ADDRGP4 $230
ARGP4
ADDRGP4 cg+110680
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 60
INDIRP4
ASGNP4
line 340
;340:		} else if (cg.teamScores[0] >= cg.teamScores[1]) {
ADDRGP4 $226
JUMPV
LABELV $225
ADDRGP4 cg+110680
INDIRI4
ADDRGP4 cg+110680+4
INDIRI4
LTI4 $232
line 341
;341:			s = va("Red leads %i to %i", cg.teamScores[0], cg.teamScores[1]);
ADDRGP4 $237
ARGP4
ADDRGP4 cg+110680
INDIRI4
ARGI4
ADDRGP4 cg+110680+4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 60
INDIRP4
ASGNP4
line 342
;342:		} else {
ADDRGP4 $233
JUMPV
LABELV $232
line 343
;343:			s = va("Blue leads %i to %i", cg.teamScores[1], cg.teamScores[0]);
ADDRGP4 $241
ARGP4
ADDRGP4 cg+110680+4
INDIRI4
ARGI4
ADDRGP4 cg+110680
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 60
INDIRP4
ASGNP4
line 344
;344:		}
LABELV $233
LABELV $226
line 346
;345:
;346:		w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 347
;347:		x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 36
CNSTI4 640
ADDRLP4 40
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 348
;348:		y = 60;
ADDRLP4 4
CNSTI4 60
ASGNI4
line 349
;349:		CG_DrawBigString(x, y, s, fade);
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 350
;350:	}
LABELV $217
line 353
;351:
;352:	// scoreboard
;353:	y = SB_HEADER;
ADDRLP4 4
CNSTI4 86
ASGNI4
line 355
;354:
;355:	CG_DrawPic(SB_SCORE_X + (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardScore);
CNSTF4 1127219200
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1115684864
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 cgs+180268+712
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 356
;356:	CG_DrawPic(SB_PING_X - (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardPing);
CNSTF4 1132724224
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1115684864
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 cgs+180268+708
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 357
;357:	CG_DrawPic(SB_TIME_X - (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardTime);
CNSTF4 1135345664
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1115684864
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 cgs+180268+716
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 358
;358:	CG_DrawPic(SB_NAME_X - (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardName);
CNSTF4 1137704960
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1115684864
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 cgs+180268+704
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 360
;359:
;360:	y = SB_TOP;
ADDRLP4 4
CNSTI4 118
ASGNI4
line 363
;361:
;362:	// If there are more than SB_MAXCLIENTS_NORMAL, use the interleaved scores
;363:	if (cg.numScores > SB_MAXCLIENTS_NORMAL) {
ADDRGP4 cg+110672
INDIRI4
CNSTI4 7
LEI4 $253
line 364
;364:		maxClients = SB_MAXCLIENTS_INTER;
ADDRLP4 24
CNSTI4 17
ASGNI4
line 365
;365:		lineHeight = SB_INTER_HEIGHT;
ADDRLP4 8
CNSTI4 16
ASGNI4
line 366
;366:		topBorderSize = 8;
ADDRLP4 44
CNSTI4 8
ASGNI4
line 367
;367:		bottomBorderSize = 16;
ADDRLP4 48
CNSTI4 16
ASGNI4
line 368
;368:	} else {
ADDRGP4 $254
JUMPV
LABELV $253
line 369
;369:		maxClients = SB_MAXCLIENTS_NORMAL;
ADDRLP4 24
CNSTI4 7
ASGNI4
line 370
;370:		lineHeight = SB_NORMAL_HEIGHT;
ADDRLP4 8
CNSTI4 40
ASGNI4
line 371
;371:		topBorderSize = 16;
ADDRLP4 44
CNSTI4 16
ASGNI4
line 372
;372:		bottomBorderSize = 16;
ADDRLP4 48
CNSTI4 16
ASGNI4
line 373
;373:	}
LABELV $254
line 375
;374:
;375:	localClient = qfalse;
ADDRGP4 localClient
CNSTI4 0
ASGNI4
line 377
;376:
;377:	if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $256
line 381
;378:		//
;379:		// teamplay scoreboard
;380:		//
;381:		y += lineHeight / 2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ASGNI4
line 383
;382:
;383:		if (cg.teamScores[0] >= cg.teamScores[1]) {
ADDRGP4 cg+110680
INDIRI4
ADDRGP4 cg+110680+4
INDIRI4
LTI4 $259
line 384
;384:			n1 = CG_TeamScoreboard(y, TEAM_RED, fade, maxClients, lineHeight);
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 CG_TeamScoreboard
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
ASGNI4
line 385
;385:			CG_DrawTeamBackground(0, y - topBorderSize, 640, n1 * lineHeight + bottomBorderSize, 0.33f, TEAM_RED);
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 44
INDIRI4
SUBI4
ARGI4
CNSTI4 640
ARGI4
ADDRLP4 16
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 48
INDIRI4
ADDI4
ARGI4
CNSTF4 1051260355
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
line 386
;386:			y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
CNSTI4 16
ADDI4
ADDI4
ASGNI4
line 387
;387:			maxClients -= n1;
ADDRLP4 24
ADDRLP4 24
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ASGNI4
line 388
;388:			n2 = CG_TeamScoreboard(y, TEAM_BLUE, fade, maxClients, lineHeight);
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 CG_TeamScoreboard
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 68
INDIRI4
ASGNI4
line 389
;389:			CG_DrawTeamBackground(0, y - topBorderSize, 640, n2 * lineHeight + bottomBorderSize, 0.33f, TEAM_BLUE);
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 44
INDIRI4
SUBI4
ARGI4
CNSTI4 640
ARGI4
ADDRLP4 32
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 48
INDIRI4
ADDI4
ARGI4
CNSTF4 1051260355
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
line 390
;390:			y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
CNSTI4 16
ADDI4
ADDI4
ASGNI4
line 391
;391:			maxClients -= n2;
ADDRLP4 24
ADDRLP4 24
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
ASGNI4
line 392
;392:		} else {
ADDRGP4 $260
JUMPV
LABELV $259
line 393
;393:			n1 = CG_TeamScoreboard(y, TEAM_BLUE, fade, maxClients, lineHeight);
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 CG_TeamScoreboard
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
ASGNI4
line 394
;394:			CG_DrawTeamBackground(0, y - topBorderSize, 640, n1 * lineHeight + bottomBorderSize, 0.33f, TEAM_BLUE);
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 44
INDIRI4
SUBI4
ARGI4
CNSTI4 640
ARGI4
ADDRLP4 16
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 48
INDIRI4
ADDI4
ARGI4
CNSTF4 1051260355
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
line 395
;395:			y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
CNSTI4 16
ADDI4
ADDI4
ASGNI4
line 396
;396:			maxClients -= n1;
ADDRLP4 24
ADDRLP4 24
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ASGNI4
line 397
;397:			n2 = CG_TeamScoreboard(y, TEAM_RED, fade, maxClients, lineHeight);
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 CG_TeamScoreboard
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 68
INDIRI4
ASGNI4
line 398
;398:			CG_DrawTeamBackground(0, y - topBorderSize, 640, n2 * lineHeight + bottomBorderSize, 0.33f, TEAM_RED);
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 44
INDIRI4
SUBI4
ARGI4
CNSTI4 640
ARGI4
ADDRLP4 32
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 48
INDIRI4
ADDI4
ARGI4
CNSTF4 1051260355
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
line 399
;399:			y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
CNSTI4 16
ADDI4
ADDI4
ASGNI4
line 400
;400:			maxClients -= n2;
ADDRLP4 24
ADDRLP4 24
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
ASGNI4
line 401
;401:		}
LABELV $260
line 402
;402:		n1 = CG_TeamScoreboard(y, TEAM_SPECTATOR, fade, maxClients, lineHeight);
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 CG_TeamScoreboard
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
ASGNI4
line 403
;403:		y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
CNSTI4 16
ADDI4
ADDI4
ASGNI4
line 405
;404:
;405:	} else {
ADDRGP4 $257
JUMPV
LABELV $256
line 409
;406:		//
;407:		// free for all scoreboard
;408:		//
;409:		n1 = CG_TeamScoreboard(y, TEAM_FREE, fade, maxClients, lineHeight);
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 CG_TeamScoreboard
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
ASGNI4
line 410
;410:		y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
CNSTI4 16
ADDI4
ADDI4
ASGNI4
line 411
;411:		n2 = CG_TeamScoreboard(y, TEAM_SPECTATOR, fade, maxClients - n1, lineHeight);
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 CG_TeamScoreboard
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 68
INDIRI4
ASGNI4
line 412
;412:		y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
CNSTI4 16
ADDI4
ADDI4
ASGNI4
line 413
;413:	}
LABELV $257
line 415
;414:
;415:	if (!localClient) {
ADDRGP4 localClient
INDIRI4
CNSTI4 0
NEI4 $264
line 417
;416:		// draw local client at the bottom
;417:		for (i = 0; i < cg.numScores; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $269
JUMPV
LABELV $266
line 418
;418:			if (cg.scores[i].client == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $271
line 419
;419:				CG_DrawClientScore(y, &cg.scores[i], fadeColor, fade, lineHeight == SB_NORMAL_HEIGHT);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 40
NEI4 $277
ADDRLP4 64
CNSTI4 1
ASGNI4
ADDRGP4 $278
JUMPV
LABELV $277
ADDRLP4 64
CNSTI4 0
ASGNI4
LABELV $278
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_DrawClientScore
CALLV
pop
line 420
;420:				break;
ADDRGP4 $268
JUMPV
LABELV $271
line 422
;421:			}
;422:		}
LABELV $267
line 417
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $269
ADDRLP4 0
INDIRI4
ADDRGP4 cg+110672
INDIRI4
LTI4 $266
LABELV $268
line 423
;423:	}
LABELV $264
line 426
;424:
;425:	// load any models that have been deferred
;426:	if (++cg.deferredPlayerLoading > 10) {
ADDRLP4 64
ADDRGP4 cg+16
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 64
INDIRP4
ADDRLP4 68
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 10
LEI4 $279
line 427
;427:		CG_LoadDeferredPlayers();
ADDRGP4 CG_LoadDeferredPlayers
CALLV
pop
line 428
;428:	}
LABELV $279
line 430
;429:
;430:	return qtrue;
CNSTI4 1
RETI4
LABELV $182
endproc CG_DrawOldScoreboard 72 24
proc CG_CenterGiantLine 28 36
line 440
;431:}
;432:
;433://================================================================================
;434:
;435:/*
;436:================
;437:CG_CenterGiantLine
;438:================
;439: */
;440:static void CG_CenterGiantLine(float y, const char *string) {
line 444
;441:	float x;
;442:	vec4_t color;
;443:
;444:	color[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 445
;445:	color[1] = 1;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 446
;446:	color[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 447
;447:	color[3] = 1;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 449
;448:
;449:	x = 0.5 * (640 - GIANT_WIDTH * CG_DrawStrlen(string));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
CNSTF4 1056964608
CNSTI4 640
ADDRLP4 20
INDIRI4
CNSTI4 5
LSHI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 451
;450:
;451:	CG_DrawStringExt(x, y, string, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0);
ADDRLP4 16
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 452
;452:}
LABELV $282
endproc CG_CenterGiantLine 28 36
export CG_DrawTourneyScoreboard
proc CG_DrawTourneyScoreboard 96 36
line 461
;453:
;454:/*
;455:=================
;456:CG_DrawTourneyScoreboard
;457:
;458:Draw the oversize scoreboard for tournements
;459:=================
;460: */
;461:void CG_DrawTourneyScoreboard(void) {
line 470
;462:	const char *s;
;463:	vec4_t color;
;464:	int min, tens, ones;
;465:	clientInfo_t *ci;
;466:	int y;
;467:	int i;
;468:
;469:	// request more scores regularly
;470:	if (cg.scoresRequestTime + 2000 < cg.time) {
ADDRGP4 cg+110668
INDIRI4
CNSTI4 2000
ADDI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $287
line 471
;471:		cg.scoresRequestTime = cg.time;
ADDRGP4 cg+110668
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 472
;472:		trap_SendClientCommand("score");
ADDRGP4 $293
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 473
;473:	}
LABELV $287
line 476
;474:
;475:	// draw the dialog background
;476:	color[0] = color[1] = color[2] = 0;
ADDRLP4 44
CNSTF4 0
ASGNF4
ADDRLP4 8+8
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 44
INDIRF4
ASGNF4
line 477
;477:	color[3] = 1;
ADDRLP4 8+12
CNSTF4 1065353216
ASGNF4
line 478
;478:	CG_FillRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color);
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRLP4 8
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 480
;479:
;480:	color[0] = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 481
;481:	color[1] = 1;
ADDRLP4 8+4
CNSTF4 1065353216
ASGNF4
line 482
;482:	color[2] = 1;
ADDRLP4 8+8
CNSTF4 1065353216
ASGNF4
line 483
;483:	color[3] = 1;
ADDRLP4 8+12
CNSTF4 1065353216
ASGNF4
line 486
;484:
;485:	// print the mesage of the day
;486:	s = CG_ConfigString(CS_MOTD);
CNSTI4 4
ARGI4
ADDRLP4 52
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
ASGNP4
line 487
;487:	if (!s[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $300
line 488
;488:		s = "Scoreboard";
ADDRLP4 4
ADDRGP4 $302
ASGNP4
line 489
;489:	}
LABELV $300
line 492
;490:
;491:	// print optional title
;492:	CG_CenterGiantLine(8, s);
CNSTF4 1090519040
ARGF4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CenterGiantLine
CALLV
pop
line 495
;493:
;494:	// print server time
;495:	ones = cg.time / 1000;
ADDRLP4 32
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 496
;496:	min = ones / 60;
ADDRLP4 36
ADDRLP4 32
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 497
;497:	ones %= 60;
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 60
MODI4
ASGNI4
line 498
;498:	tens = ones / 10;
ADDRLP4 40
ADDRLP4 32
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 499
;499:	ones %= 10;
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 10
MODI4
ASGNI4
line 500
;500:	s = va("%i:%i%i", min, tens, ones);
ADDRGP4 $304
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 56
INDIRP4
ASGNP4
line 502
;501:
;502:	CG_CenterGiantLine(64, s);
CNSTF4 1115684864
ARGF4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CenterGiantLine
CALLV
pop
line 507
;503:
;504:
;505:	// print the two scores
;506:
;507:	y = 160;
ADDRLP4 24
CNSTI4 160
ASGNI4
line 508
;508:	if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $305
line 512
;509:		//
;510:		// teamplay scoreboard
;511:		//
;512:		CG_DrawStringExt(8, y, "Red Team", color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0);
CNSTI4 8
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 $308
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 64
CNSTI4 1
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 513
;513:		s = va("%i", cg.teamScores[0]);
ADDRGP4 $108
ARGP4
ADDRGP4 cg+110680
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 68
INDIRP4
ASGNP4
line 514
;514:		CG_DrawStringExt(632 - GIANT_WIDTH * strlen(s), y, s, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 strlen
CALLI4
ASGNI4
CNSTI4 632
ADDRLP4 72
INDIRI4
CNSTI4 5
LSHI4
SUBI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 76
CNSTI4 1
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 516
;515:
;516:		y += 64;
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 518
;517:
;518:		CG_DrawStringExt(8, y, "Blue Team", color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0);
CNSTI4 8
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 $310
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 80
CNSTI4 1
ASGNI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 519
;519:		s = va("%i", cg.teamScores[1]);
ADDRGP4 $108
ARGP4
ADDRGP4 cg+110680+4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 84
INDIRP4
ASGNP4
line 520
;520:		CG_DrawStringExt(632 - GIANT_WIDTH * strlen(s), y, s, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 strlen
CALLI4
ASGNI4
CNSTI4 632
ADDRLP4 88
INDIRI4
CNSTI4 5
LSHI4
SUBI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 92
CNSTI4 1
ASGNI4
ADDRLP4 92
INDIRI4
ARGI4
ADDRLP4 92
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 521
;521:	} else {
ADDRGP4 $306
JUMPV
LABELV $305
line 525
;522:		//
;523:		// free for all scoreboard
;524:		//
;525:		for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 28
CNSTI4 0
ASGNI4
LABELV $313
line 526
;526:			ci = &cgs.clientinfo[i];
ADDRLP4 0
CNSTI4 2120
ADDRLP4 28
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 527
;527:			if (!ci->infoValid) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $318
line 528
;528:				continue;
ADDRGP4 $314
JUMPV
LABELV $318
line 530
;529:			}
;530:			if (ci->team != TEAM_FREE) {
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $320
line 531
;531:				continue;
ADDRGP4 $314
JUMPV
LABELV $320
line 534
;532:			}
;533:
;534:			CG_DrawStringExt(8, y, ci->name, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0);
CNSTI4 8
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 64
CNSTI4 1
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 535
;535:			s = va("%i", ci->score);
ADDRGP4 $108
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 68
INDIRP4
ASGNP4
line 536
;536:			CG_DrawStringExt(632 - GIANT_WIDTH * strlen(s), y, s, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 strlen
CALLI4
ASGNI4
CNSTI4 632
ADDRLP4 72
INDIRI4
CNSTI4 5
LSHI4
SUBI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 76
CNSTI4 1
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 537
;537:			y += 64;
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 538
;538:		}
LABELV $314
line 525
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 64
LTI4 $313
line 539
;539:	}
LABELV $306
line 542
;540:
;541:
;542:}
LABELV $286
endproc CG_DrawTourneyScoreboard 96 36
bss
align 4
LABELV localClient
skip 4
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
LABELV $310
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $308
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $304
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $302
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 98
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $293
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $241
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $237
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $230
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $222
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
LABELV $214
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $164
byte 1 68
byte 1 69
byte 1 65
byte 1 68
byte 1 0
align 1
LABELV $161
byte 1 42
byte 1 37
byte 1 105
byte 1 42
byte 1 0
align 1
LABELV $157
byte 1 82
byte 1 69
byte 1 65
byte 1 68
byte 1 89
byte 1 0
align 1
LABELV $129
byte 1 37
byte 1 53
byte 1 105
byte 1 32
byte 1 37
byte 1 52
byte 1 105
byte 1 32
byte 1 37
byte 1 52
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $128
byte 1 32
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 52
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $125
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $115
byte 1 37
byte 1 105
byte 1 47
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $108
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $79
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 45
byte 1 62
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
