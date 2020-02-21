code
proc CG_ParseScores 248 12
file "../../../code/cgame/cg_servercmds.c"
line 68
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
;23:// cg_servercmds.c -- reliably sequenced text commands sent by the server
;24:// these are processed at snapshot transition time, so there will definately
;25:// be a valid snapshot this frame
;26:
;27:#include "cg_local.h"
;28:#include "../../ui/menudef.h"
;29:
;30:typedef struct {
;31:	const char *order;
;32:	int taskNum;
;33:} orderTask_t;
;34:
;35:#ifdef MISSIONPACK // bk001204
;36:
;37:static const orderTask_t validOrders[] = {
;38:	{ VOICECHAT_GETFLAG,						TEAMTASK_OFFENSE },
;39:	{ VOICECHAT_OFFENSE,						TEAMTASK_OFFENSE },
;40:	{ VOICECHAT_DEFEND,							TEAMTASK_DEFENSE },
;41:	{ VOICECHAT_DEFENDFLAG,					TEAMTASK_DEFENSE },
;42:	{ VOICECHAT_PATROL,							TEAMTASK_PATROL },
;43:	{ VOICECHAT_CAMP,								TEAMTASK_CAMP },
;44:	{ VOICECHAT_FOLLOWME,						TEAMTASK_FOLLOW },
;45:	{ VOICECHAT_RETURNFLAG,					TEAMTASK_RETRIEVE },
;46:	{ VOICECHAT_FOLLOWFLAGCARRIER,	TEAMTASK_ESCORT }
;47:};
;48:
;49:static const int numValidOrders = sizeof(validOrders) / sizeof(orderTask_t);
;50:
;51:static int CG_ValidOrder(const char *p) {
;52:	int i;
;53:	for (i = 0; i < numValidOrders; i++) {
;54:		if (Q_strequal(p, validOrders[i].order) ) {
;55:			return validOrders[i].taskNum;
;56:		}
;57:	}
;58:	return -1;
;59:}
;60:#endif
;61:
;62:/*
;63:=================
;64:CG_ParseScores
;65:
;66:=================
;67:*/
;68:static void CG_ParseScores( void ) {
line 71
;69:	int		i, powerups;
;70:
;71:	cg.numScores = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+110672
ADDRLP4 12
INDIRI4
ASGNI4
line 72
;72:	if ( cg.numScores > MAX_CLIENTS ) {
ADDRGP4 cg+110672
INDIRI4
CNSTI4 64
LEI4 $77
line 73
;73:		cg.numScores = MAX_CLIENTS;
ADDRGP4 cg+110672
CNSTI4 64
ASGNI4
line 74
;74:	}
LABELV $77
line 76
;75:
;76:	cg.teamScores[0] = atoi( CG_Argv( 2 ) );
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+110680
ADDRLP4 20
INDIRI4
ASGNI4
line 77
;77:	cg.teamScores[1] = atoi( CG_Argv( 3 ) );
CNSTI4 3
ARGI4
ADDRLP4 24
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+110680+4
ADDRLP4 28
INDIRI4
ASGNI4
line 79
;78:
;79:	cgs.roundStartTime = atoi( CG_Argv( 4 ) );
CNSTI4 4
ARGI4
ADDRLP4 32
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34808
ADDRLP4 36
INDIRI4
ASGNI4
line 82
;80:
;81:	//Update thing in lower-right corner
;82:	if(CG_IsARoundBasedGametype(cgs.gametype) && CG_IsATeamGametype(cgs.gametype))
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $85
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $85
line 83
;83:	{
line 84
;84:		cgs.scores1 = cg.teamScores[0];
ADDRGP4 cgs+34980
ADDRGP4 cg+110680
INDIRI4
ASGNI4
line 85
;85:		cgs.scores2 = cg.teamScores[1];
ADDRGP4 cgs+34984
ADDRGP4 cg+110680+4
INDIRI4
ASGNI4
line 86
;86:	}
LABELV $85
line 88
;87:
;88:	memset( cg.scores, 0, sizeof( cg.scores ) );
ADDRGP4 cg+110688
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4096
ARGI4
ADDRGP4 memset
CALLP4
pop
line 93
;89:
;90:#define NUM_DATA 15
;91:#define FIRST_DATA 4
;92:
;93:	for ( i = 0 ; i < cg.numScores ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $99
JUMPV
LABELV $96
line 95
;94:		//
;95:		cg.scores[i].client = atoi( CG_Argv( i * NUM_DATA + FIRST_DATA + 1 ) );
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 52
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688
ADDP4
ADDRLP4 56
INDIRI4
ASGNI4
line 96
;96:		cg.scores[i].score = atoi( CG_Argv( i * NUM_DATA + FIRST_DATA + 2 ) );
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 64
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+4
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 97
;97:		cg.scores[i].ping = atoi( CG_Argv( i * NUM_DATA + FIRST_DATA + 3 ) );
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 3
ADDI4
ARGI4
ADDRLP4 76
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+8
ADDP4
ADDRLP4 80
INDIRI4
ASGNI4
line 98
;98:		cg.scores[i].time = atoi( CG_Argv( i * NUM_DATA + FIRST_DATA + 4 ) );
ADDRLP4 88
CNSTI4 4
ASGNI4
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 88
INDIRI4
ADDI4
ADDRLP4 88
INDIRI4
ADDI4
ARGI4
ADDRLP4 92
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+12
ADDP4
ADDRLP4 96
INDIRI4
ASGNI4
line 99
;99:		cg.scores[i].scoreFlags = atoi( CG_Argv( i * NUM_DATA + FIRST_DATA + 5 ) );
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 5
ADDI4
ARGI4
ADDRLP4 104
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+16
ADDP4
ADDRLP4 108
INDIRI4
ASGNI4
line 100
;100:		powerups = atoi( CG_Argv( i * NUM_DATA + FIRST_DATA + 6 ) );
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 6
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 116
INDIRI4
ASGNI4
line 101
;101:		cg.scores[i].accuracy = atoi(CG_Argv(i * NUM_DATA + FIRST_DATA + 7));
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 7
ADDI4
ARGI4
ADDRLP4 124
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+24
ADDP4
ADDRLP4 128
INDIRI4
ASGNI4
line 102
;102:		cg.scores[i].impressiveCount = atoi(CG_Argv(i * NUM_DATA + FIRST_DATA + 8));
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 8
ADDI4
ARGI4
ADDRLP4 136
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+28
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 103
;103:		cg.scores[i].excellentCount = atoi(CG_Argv(i * NUM_DATA + FIRST_DATA + 9));
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 9
ADDI4
ARGI4
ADDRLP4 148
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+32
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 104
;104:		cg.scores[i].guantletCount = atoi(CG_Argv(i * NUM_DATA + FIRST_DATA + 10));
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 10
ADDI4
ARGI4
ADDRLP4 160
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+36
ADDP4
ADDRLP4 164
INDIRI4
ASGNI4
line 105
;105:		cg.scores[i].defendCount = atoi(CG_Argv(i * NUM_DATA + FIRST_DATA + 11));
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 11
ADDI4
ARGI4
ADDRLP4 172
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+40
ADDP4
ADDRLP4 176
INDIRI4
ASGNI4
line 106
;106:		cg.scores[i].assistCount = atoi(CG_Argv(i * NUM_DATA + FIRST_DATA + 12));
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 12
ADDI4
ARGI4
ADDRLP4 184
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 184
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+44
ADDP4
ADDRLP4 188
INDIRI4
ASGNI4
line 107
;107:		cg.scores[i].perfect = atoi(CG_Argv(i * NUM_DATA + FIRST_DATA + 13));
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 13
ADDI4
ARGI4
ADDRLP4 196
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRLP4 200
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+52
ADDP4
ADDRLP4 200
INDIRI4
ASGNI4
line 108
;108:		cg.scores[i].captures = atoi(CG_Argv(i * NUM_DATA + FIRST_DATA + 14));
CNSTI4 15
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
CNSTI4 14
ADDI4
ARGI4
ADDRLP4 208
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 208
INDIRP4
ARGP4
ADDRLP4 212
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+48
ADDP4
ADDRLP4 212
INDIRI4
ASGNI4
line 109
;109:		cg.scores[i].isDead = atoi(CG_Argv(i * NUM_DATA + FIRST_DATA + 15));
ADDRLP4 216
CNSTI4 15
ASGNI4
ADDRLP4 216
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 4
ADDI4
ADDRLP4 216
INDIRI4
ADDI4
ARGI4
ADDRLP4 224
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 224
INDIRP4
ARGP4
ADDRLP4 228
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688+60
ADDP4
ADDRLP4 228
INDIRI4
ASGNI4
line 112
;110:		//cgs.roundStartTime = 
;111:
;112:		if ( cg.scores[i].client < 0 || cg.scores[i].client >= MAX_CLIENTS ) {
ADDRLP4 232
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ASGNI4
ADDRLP4 232
INDIRI4
ADDRGP4 cg+110688
ADDP4
INDIRI4
CNSTI4 0
LTI4 $132
ADDRLP4 232
INDIRI4
ADDRGP4 cg+110688
ADDP4
INDIRI4
CNSTI4 64
LTI4 $128
LABELV $132
line 113
;113:			cg.scores[i].client = 0;
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688
ADDP4
CNSTI4 0
ASGNI4
line 114
;114:		}
LABELV $128
line 115
;115:		cgs.clientinfo[ cg.scores[i].client ].score = cg.scores[i].score;
ADDRLP4 236
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ASGNI4
CNSTI4 2120
ADDRLP4 236
INDIRI4
ADDRGP4 cg+110688
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152+100
ADDP4
ADDRLP4 236
INDIRI4
ADDRGP4 cg+110688+4
ADDP4
INDIRI4
ASGNI4
line 116
;116:		cgs.clientinfo[ cg.scores[i].client ].powerups = powerups;
CNSTI4 2120
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 cg+110688
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152+140
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 117
;117:		cgs.clientinfo[ cg.scores[i].client ].isDead = cg.scores[i].isDead;
ADDRLP4 240
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ASGNI4
CNSTI4 2120
ADDRLP4 240
INDIRI4
ADDRGP4 cg+110688
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152+2100
ADDP4
ADDRLP4 240
INDIRI4
ADDRGP4 cg+110688+60
ADDP4
INDIRI4
ASGNI4
line 119
;118:
;119:		cg.scores[i].team = cgs.clientinfo[cg.scores[i].client].team;
ADDRLP4 244
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ASGNI4
ADDRLP4 244
INDIRI4
ADDRGP4 cg+110688+56
ADDP4
CNSTI4 2120
ADDRLP4 244
INDIRI4
ADDRGP4 cg+110688
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152+68
ADDP4
INDIRI4
ASGNI4
line 120
;120:	}
LABELV $97
line 93
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $99
ADDRLP4 0
INDIRI4
ADDRGP4 cg+110672
INDIRI4
LTI4 $96
line 125
;121:#ifdef MISSIONPACK
;122:	CG_SetScoreSelection(NULL);
;123:#endif
;124:
;125:}
LABELV $75
endproc CG_ParseScores 248 12
proc CG_ParseAccuracy 32 4
line 127
;126:
;127:static void CG_ParseAccuracy( void ) {
line 130
;128:	int		i;
;129:
;130:	for ( i = WP_MACHINEGUN ; i < WP_NUM_WEAPONS ; i++ ) {
ADDRLP4 0
CNSTI4 2
ASGNI4
LABELV $153
line 131
;131:		cg.accuracys[i-WP_MACHINEGUN][0] = atoi( CG_Argv( (i-WP_MACHINEGUN)*2 + 1 ) );
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LSHI4
CNSTI4 4
SUBI4
ADDRLP4 8
INDIRI4
ADDI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 cg+114796-16
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 132
;132:		cg.accuracys[i-WP_MACHINEGUN][1] = atoi( CG_Argv( (i-WP_MACHINEGUN)*2 + 2 ) );
ADDRLP4 0
INDIRI4
CNSTI4 1
LSHI4
CNSTI4 4
SUBI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 24
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 cg+114796-16+4
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 136
;133:#if DEBUG
;134:		CG_Printf("W: %i   shots: %i   Hits: %i\n", i,cg.accuracys[i][0], cg.accuracys[i][1]);
;135:#endif
;136:	}
LABELV $154
line 130
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $153
line 138
;137:
;138:}
LABELV $152
endproc CG_ParseAccuracy 32 4
proc CG_ParseElimination 24 4
line 147
;139:
;140:
;141:/*
;142:=================
;143:CG_ParseElimination
;144:
;145:=================
;146:*/
;147:static void CG_ParseElimination( void ) {
line 148
;148:	if(CG_IsARoundBasedGametype(cgs.gametype) && CG_IsATeamGametype(cgs.gametype))
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $163
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $163
line 149
;149:	{
line 150
;150:		cgs.scores1 = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34980
ADDRLP4 12
INDIRI4
ASGNI4
line 151
;151:		cgs.scores2 = atoi( CG_Argv( 2 ) );
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34984
ADDRLP4 20
INDIRI4
ASGNI4
line 152
;152:	}
LABELV $163
line 153
;153:	cgs.roundStartTime = atoi( CG_Argv( 3 ) );
CNSTI4 3
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34808
ADDRLP4 12
INDIRI4
ASGNI4
line 154
;154:}
LABELV $162
endproc CG_ParseElimination 24 4
proc CG_ParseMappage 1060 12
line 163
;155:
;156:/*
;157:=================
;158:CG_ParseMappage
;159:Sago: This parses values from the server rather directly. Some checks are performed, but beware if you change it or new
;160:security holes are found
;161:=================
;162:*/
;163:static void CG_ParseMappage( void ) {
line 169
;164:	char command[1024];
;165:	const char *temp;
;166:	const char*	c;
;167:	int i;
;168:
;169:	temp = CG_Argv( 1 );
CNSTI4 1
ARGI4
ADDRLP4 1036
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1036
INDIRP4
ASGNP4
line 170
;170:for( c = temp; *c; ++c) {
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $174
JUMPV
LABELV $171
line 171
;171:		switch(*c) {
ADDRLP4 1040
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1048
CNSTI4 10
ASGNI4
ADDRLP4 1040
INDIRI4
ADDRLP4 1048
INDIRI4
EQI4 $170
ADDRLP4 1040
INDIRI4
CNSTI4 13
EQI4 $170
ADDRLP4 1040
INDIRI4
ADDRLP4 1048
INDIRI4
LTI4 $175
LABELV $179
ADDRLP4 1040
INDIRI4
CNSTI4 59
EQI4 $170
ADDRGP4 $175
JUMPV
line 176
;172:			case '\n':
;173:			case '\r':
;174:			case ';':
;175:				//The server tried something bad!
;176:				return;
line 177
;177:			break;
LABELV $175
line 179
;178:		}
;179:	}
LABELV $172
line 170
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $174
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $171
line 180
;180:	Q_strncpyz(command,va("ui_mappage %s",temp),1024);
ADDRGP4 $180
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 181
;181:	for(i=2;i<12;i++) {
ADDRLP4 8
CNSTI4 2
ASGNI4
LABELV $181
line 182
;182:		temp = CG_Argv( i );
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1044
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1044
INDIRP4
ASGNP4
line 183
;183:		for( c = temp; *c; ++c) {
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $188
JUMPV
LABELV $185
line 184
;184:				switch(*c) {
ADDRLP4 1048
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1056
CNSTI4 10
ASGNI4
ADDRLP4 1048
INDIRI4
ADDRLP4 1056
INDIRI4
EQI4 $170
ADDRLP4 1048
INDIRI4
CNSTI4 13
EQI4 $170
ADDRLP4 1048
INDIRI4
ADDRLP4 1056
INDIRI4
LTI4 $189
LABELV $193
ADDRLP4 1048
INDIRI4
CNSTI4 59
EQI4 $170
ADDRGP4 $189
JUMPV
line 189
;185:					case '\n':
;186:					case '\r':
;187:					case ';':
;188:						//The server tried something bad!
;189:						return;
line 190
;190:					break;
LABELV $189
line 192
;191:				}
;192:			}
LABELV $186
line 183
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $188
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $185
line 193
;193:		if(strlen(temp)<1) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 1
GEI4 $194
line 194
;194:			temp = "---";
ADDRLP4 4
ADDRGP4 $196
ASGNP4
line 195
;195:		}
LABELV $194
line 196
;196:		Q_strcat(command,1024,va(" %s ",temp));
ADDRGP4 $197
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 197
;197:	}
LABELV $182
line 181
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 12
LTI4 $181
line 198
;198:	trap_SendConsoleCommand(command);
ADDRLP4 12
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 200
;199:
;200:}
LABELV $170
endproc CG_ParseMappage 1060 12
proc CG_ParseDDtimetakeAt 8 4
line 208
;201:
;202:/*
;203:=================
;204:CG_ParseDDtimetaken
;205:
;206:=================
;207:*/
;208:static void CG_ParseDDtimetakeAt( void ) {
line 209
;209:	cgs.takeAt = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34828
ADDRLP4 4
INDIRI4
ASGNI4
line 210
;210:}
LABELV $198
endproc CG_ParseDDtimetakeAt 8 4
proc CG_ParseDomPointNames 24 12
line 218
;211:
;212:/*
;213:=================
;214:CG_ParseDomPointNames
;215:=================
;216:*/
;217:
;218:static void CG_ParseDomPointNames( void ) {
line 220
;219:	int i,j;
;220:	cgs.domination_points_count = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34832
ADDRLP4 12
INDIRI4
ASGNI4
line 221
;221:	if(cgs.domination_points_count>=MAX_DOMINATION_POINTS) {
ADDRGP4 cgs+34832
INDIRI4
CNSTI4 6
LTI4 $202
line 222
;222:		cgs.domination_points_count = MAX_DOMINATION_POINTS;
ADDRGP4 cgs+34832
CNSTI4 6
ASGNI4
line 223
;223:	}
LABELV $202
line 224
;224:	for(i = 0;i<cgs.domination_points_count;i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $209
JUMPV
LABELV $206
line 225
;225:		Q_strncpyz(cgs.domination_points_names[i],CG_Argv(2)+i*MAX_DOMINATION_POINTS_NAMES,MAX_DOMINATION_POINTS_NAMES-1);
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
CNSTI4 20
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+34836
ADDP4
ARGP4
CNSTI4 20
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 16
INDIRP4
ADDP4
ARGP4
CNSTI4 19
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 226
;226:		for(j=MAX_DOMINATION_POINTS_NAMES-1; cgs.domination_points_names[i][j] < '0' && j>0; j--) {
ADDRLP4 0
CNSTI4 19
ASGNI4
ADDRGP4 $215
JUMPV
LABELV $212
line 227
;227:			cgs.domination_points_names[i][j] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 20
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+34836
ADDP4
ADDP4
CNSTI1 0
ASGNI1
line 228
;228:		}
LABELV $213
line 226
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $215
ADDRLP4 0
INDIRI4
CNSTI4 20
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+34836
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
GEI4 $218
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $212
LABELV $218
line 229
;229:	}
LABELV $207
line 224
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $209
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+34832
INDIRI4
LTI4 $206
line 230
;230:}
LABELV $200
endproc CG_ParseDomPointNames 24 12
proc CG_ParseDomStatus 28 4
line 238
;231:
;232:/*
;233:=================
;234:CG_ParseDomScores
;235:=================
;236:*/
;237:
;238:static void CG_ParseDomStatus( void ) {
line 240
;239:	int i;
;240:	if( cgs.domination_points_count!=atoi( CG_Argv(1) ) ) {
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34832
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $220
line 241
;241:		cgs.domination_points_count = 0;
ADDRGP4 cgs+34832
CNSTI4 0
ASGNI4
line 242
;242:		return;
ADDRGP4 $219
JUMPV
LABELV $220
line 244
;243:	}
;244:	for(i = 0;i<cgs.domination_points_count;i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $227
JUMPV
LABELV $224
line 245
;245:		cgs.domination_points_status[i] = atoi( CG_Argv(2+i) );
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
ADDI4
ARGI4
ADDRLP4 20
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRGP4 cgs+34956
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 246
;246:	}
LABELV $225
line 244
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $227
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+34832
INDIRI4
LTI4 $224
line 247
;247:}
LABELV $219
endproc CG_ParseDomStatus 28 4
proc CG_ParseChallenge 8 4
line 255
;248:
;249:/*
;250:=================
;251:CG_ParseChallenge
;252:=================
;253:*/
;254:
;255:static void CG_ParseChallenge( void ) {
line 256
;256:	addChallenge(atoi( CG_Argv(1) ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 addChallenge
CALLV
pop
line 257
;257:}
LABELV $230
endproc CG_ParseChallenge 8 4
proc CG_ParseObeliskHealth 16 4
line 259
;258:
;259:static void CG_ParseObeliskHealth( void ) {
line 260
;260:	cg.redObeliskHealth = atoi( CG_Argv(1) );
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+156536
ADDRLP4 4
INDIRI4
ASGNI4
line 261
;261:cg.blueObeliskHealth = atoi( CG_Argv(2) );
CNSTI4 2
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+156540
ADDRLP4 12
INDIRI4
ASGNI4
line 262
;262:}
LABELV $231
endproc CG_ParseObeliskHealth 16 4
proc CG_ParseRespawnTime 8 4
line 267
;263:
;264:/**
;265: * Sets the respawn counter for the client.
;266: */
;267:static void CG_ParseRespawnTime( void ) {
line 268
;268:	cg.respawnTime = atoi( CG_Argv(1) );
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+156532
ADDRLP4 4
INDIRI4
ASGNI4
line 269
;269:}
LABELV $234
endproc CG_ParseRespawnTime 8 4
proc CG_ParseTeam 4 8
line 277
;270:
;271:/*
;272:=================
;273:CG_ParseTeam
;274:=================
;275:*/
;276:
;277:static void CG_ParseTeam( void ) {
line 279
;278:	//TODO: Add code here
;279:	if(cg_voip_teamonly.integer) {
ADDRGP4 cg_voip_teamonly+12
INDIRI4
CNSTI4 0
EQI4 $237
line 280
;280:		trap_Cvar_Set("cl_voipSendTarget",CG_Argv(1));
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRGP4 $240
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 281
;281:	}
LABELV $237
line 282
;282:}
LABELV $236
endproc CG_ParseTeam 4 8
proc CG_ParseAttackingTeam 12 4
line 290
;283:
;284:/*
;285:=================
;286:CG_ParseAttackingTeam
;287:
;288:=================
;289:*/
;290:static void CG_ParseAttackingTeam( void ) {
line 292
;291:	int temp;
;292:	temp = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 293
;293:	if(temp==TEAM_RED) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $242
line 294
;294:		cgs.attackingTeam = TEAM_RED;
ADDRGP4 cgs+34816
CNSTI4 1
ASGNI4
line 295
;295:	}
ADDRGP4 $243
JUMPV
LABELV $242
line 296
;296:	else if (temp==TEAM_BLUE) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $245
line 297
;297:		cgs.attackingTeam = TEAM_BLUE;
ADDRGP4 cgs+34816
CNSTI4 2
ASGNI4
line 298
;298:	}
ADDRGP4 $246
JUMPV
LABELV $245
line 299
;299:	else {
line 300
;300:		cgs.attackingTeam = TEAM_NONE; //Should never happen.
ADDRGP4 cgs+34816
CNSTI4 3
ASGNI4
line 301
;301:	}
LABELV $246
LABELV $243
line 302
;302:}
LABELV $241
endproc CG_ParseAttackingTeam 12 4
proc CG_ParseTeamInfo 76 8
line 310
;303:
;304:/*
;305:=================
;306:CG_ParseTeamInfo
;307:
;308:=================
;309:*/
;310:static void CG_ParseTeamInfo( void ) {
line 314
;311:	int		i;
;312:	int		client;
;313:
;314:	numSortedTeamPlayers = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 numSortedTeamPlayers
ADDRLP4 12
INDIRI4
ASGNI4
line 315
;315:	if( numSortedTeamPlayers < 0 || numSortedTeamPlayers > TEAM_MAXOVERLAY )
ADDRLP4 16
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $252
ADDRLP4 16
INDIRI4
CNSTI4 32
LEI4 $250
LABELV $252
line 316
;316:	{
line 317
;317:		CG_Error( "CG_ParseTeamInfo: numSortedTeamPlayers out of range (%d)",
ADDRGP4 $253
ARGP4
ADDRGP4 numSortedTeamPlayers
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 319
;318:				numSortedTeamPlayers );
;319:		return;
ADDRGP4 $249
JUMPV
LABELV $250
line 322
;320:	}
;321:
;322:	for ( i = 0 ; i < numSortedTeamPlayers ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $257
JUMPV
LABELV $254
line 323
;323:		client = atoi( CG_Argv( i * 6 + 2 ) );
CNSTI4 6
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 20
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 324
;324:		if( client < 0 || client >= MAX_CLIENTS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $260
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $258
LABELV $260
line 325
;325:			CG_Error( "CG_ParseTeamInfo: bad client number: %d", client );
ADDRGP4 $261
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 326
;326:			return;
ADDRGP4 $249
JUMPV
LABELV $258
line 330
;327:		}
;328:
;329:
;330:		sortedTeamPlayers[i] = client;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 332
;331:
;332:		cgs.clientinfo[ client ].location = atoi( CG_Argv( i * 6 + 3 ) );
CNSTI4 6
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 3
ADDI4
ARGI4
ADDRLP4 32
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152+104
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 333
;333:		cgs.clientinfo[ client ].health = atoi( CG_Argv( i * 6 + 4 ) );
CNSTI4 6
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 4
ADDI4
ARGI4
ADDRLP4 40
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152+108
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 334
;334:		cgs.clientinfo[ client ].armor = atoi( CG_Argv( i * 6 + 5 ) );
CNSTI4 6
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 5
ADDI4
ARGI4
ADDRLP4 48
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152+112
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 335
;335:		cgs.clientinfo[ client ].curWeapon = atoi( CG_Argv( i * 6 + 6 ) );
ADDRLP4 56
CNSTI4 6
ASGNI4
ADDRLP4 56
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 56
INDIRI4
ADDI4
ARGI4
ADDRLP4 60
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152+116
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 336
;336:		cgs.clientinfo[ client ].powerups = atoi( CG_Argv( i * 6 + 7 ) );
CNSTI4 6
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 7
ADDI4
ARGI4
ADDRLP4 68
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152+140
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 337
;337:	}
LABELV $255
line 322
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $257
ADDRLP4 4
INDIRI4
ADDRGP4 numSortedTeamPlayers
INDIRI4
LTI4 $254
line 338
;338:}
LABELV $249
endproc CG_ParseTeamInfo 76 8
proc CG_ParseWeaponProperties 40 4
line 340
;339:
;340:static void CG_ParseWeaponProperties(void) {
line 341
;341:	mod_sgspread     = atoi(CG_Argv(1));
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 mod_sgspread
ADDRLP4 4
INDIRI4
ASGNI4
line 342
;342:	mod_sgcount     = atoi(CG_Argv(2));
CNSTI4 2
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 mod_sgcount
ADDRLP4 12
INDIRI4
ASGNI4
line 343
;343:	mod_lgrange     = atoi(CG_Argv(3));
CNSTI4 3
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 mod_lgrange
ADDRLP4 20
INDIRI4
ASGNI4
line 344
;344:	mod_mgspread     = atoi(CG_Argv(4));
CNSTI4 4
ARGI4
ADDRLP4 24
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 mod_mgspread
ADDRLP4 28
INDIRI4
ASGNI4
line 345
;345:	mod_cgspread     = atoi(CG_Argv(5));
CNSTI4 5
ARGI4
ADDRLP4 32
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 mod_cgspread
ADDRLP4 36
INDIRI4
ASGNI4
line 346
;346:}
LABELV $272
endproc CG_ParseWeaponProperties 40 4
export CG_ParseServerinfo
proc CG_ParseServerinfo 164 16
line 357
;347:
;348:
;349:/*
;350:================
;351:CG_ParseServerinfo
;352:
;353:This is called explicitly when the gamestate is first received,
;354:and whenever the server updates any serverinfo flagged cvars
;355:================
;356:*/
;357:void CG_ParseServerinfo( void ) {
line 361
;358:	const char	*info;
;359:	char	*mapname;
;360:
;361:	info = CG_ConfigString( CS_SERVERINFO );
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 362
;362:	cgs.gametype = atoi( Info_ValueForKey( info, "g_gametype" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $275
ARGP4
ADDRLP4 12
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31456
ADDRLP4 16
INDIRI4
ASGNI4
line 363
;363:	trap_Cvar_Set("g_gametype", va("%i", cgs.gametype));
ADDRGP4 $276
ARGP4
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $275
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 364
;364:	cgs.dmflags = atoi( Info_ValueForKey( info, "dmflags" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $279
ARGP4
ADDRLP4 24
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31460
ADDRLP4 28
INDIRI4
ASGNI4
line 365
;365:	cgs.videoflags = atoi( Info_ValueForKey( info, "videoflags" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $281
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31464
ADDRLP4 36
INDIRI4
ASGNI4
line 366
;366:	cgs.elimflags = atoi( Info_ValueForKey( info, "elimflags" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 40
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31468
ADDRLP4 44
INDIRI4
ASGNI4
line 367
;367:	cgs.teamflags = atoi( Info_ValueForKey( info, "teamflags" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $285
ARGP4
ADDRLP4 48
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31472
ADDRLP4 52
INDIRI4
ASGNI4
line 368
;368:	cgs.fraglimit = atoi( Info_ValueForKey( info, "fraglimit" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $287
ARGP4
ADDRLP4 56
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31476
ADDRLP4 60
INDIRI4
ASGNI4
line 369
;369:	cgs.capturelimit = atoi( Info_ValueForKey( info, "capturelimit" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $289
ARGP4
ADDRLP4 64
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31480
ADDRLP4 68
INDIRI4
ASGNI4
line 370
;370:	cgs.timelimit = atoi( Info_ValueForKey( info, "timelimit" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $291
ARGP4
ADDRLP4 72
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31484
ADDRLP4 76
INDIRI4
ASGNI4
line 371
;371:	cgs.maxclients = atoi( Info_ValueForKey( info, "sv_maxclients" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $293
ARGP4
ADDRLP4 80
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31488
ADDRLP4 84
INDIRI4
ASGNI4
line 372
;372:	cgs.roundtime = atoi( Info_ValueForKey( info, "elimination_roundtime" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRLP4 88
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34812
ADDRLP4 92
INDIRI4
ASGNI4
line 373
;373:	cgs.nopickup = atoi( Info_ValueForKey( info, "g_rockets" ) ) + atoi( Info_ValueForKey( info, "g_instantgib" ) ) + atoi( Info_ValueForKey( info, "g_elimination" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $297
ARGP4
ADDRLP4 96
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $298
ARGP4
ADDRLP4 104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $299
ARGP4
ADDRLP4 112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34824
ADDRLP4 100
INDIRI4
ADDRLP4 108
INDIRI4
ADDI4
ADDRLP4 116
INDIRI4
ADDI4
ASGNI4
line 374
;374:	cgs.lms_mode = atoi( Info_ValueForKey( info, "g_lms_mode" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $301
ARGP4
ADDRLP4 120
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34820
ADDRLP4 124
INDIRI4
ASGNI4
line 375
;375:	cgs.altExcellent = atoi( Info_ValueForKey( info, "g_altExcellent" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $303
ARGP4
ADDRLP4 128
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+181712
ADDRLP4 132
INDIRI4
ASGNI4
line 376
;376:	mapname = Info_ValueForKey( info, "mapname" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $304
ARGP4
ADDRLP4 136
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 136
INDIRP4
ASGNP4
line 377
;377:	Com_sprintf( cgs.mapname, sizeof( cgs.mapname ), "maps/%s.bsp", mapname );
ADDRGP4 cgs+31492
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $307
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 378
;378:	Q_strncpyz( cgs.redTeam, Info_ValueForKey( info, "g_redTeam" ), sizeof(cgs.redTeam) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $309
ARGP4
ADDRLP4 140
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 cgs+31556
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 379
;379:	trap_Cvar_Set("g_redTeam", cgs.redTeam);
ADDRGP4 $309
ARGP4
ADDRGP4 cgs+31556
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 380
;380:	Q_strncpyz( cgs.blueTeam, Info_ValueForKey( info, "g_blueTeam" ), sizeof(cgs.blueTeam) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $313
ARGP4
ADDRLP4 144
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 cgs+31620
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 381
;381:	trap_Cvar_Set("g_blueTeam", cgs.blueTeam);
ADDRGP4 $313
ARGP4
ADDRGP4 cgs+31620
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 385
;382:
;383://unlagged - server options
;384:	// we'll need this for deciding whether or not to predict weapon effects
;385:	cgs.delagHitscan = atoi( Info_ValueForKey( info, "g_delagHitscan" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $317
ARGP4
ADDRLP4 148
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+181708
ADDRLP4 152
INDIRI4
ASGNI4
line 386
;386:	trap_Cvar_Set("g_delagHitscan", va("%i", cgs.delagHitscan));
ADDRGP4 $276
ARGP4
ADDRGP4 cgs+181708
INDIRI4
ARGI4
ADDRLP4 156
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $317
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 390
;387://unlagged - server options
;388:
;389:	//Copy allowed votes directly to the client:
;390:	trap_Cvar_Set("cg_voteflags",Info_ValueForKey( info, "voteflags" ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $320
ARGP4
ADDRLP4 160
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $319
ARGP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 391
;391:}
LABELV $273
endproc CG_ParseServerinfo 164 16
proc CG_ParseWarmup 24 8
line 398
;392:
;393:/*
;394:==================
;395:CG_ParseWarmup
;396:==================
;397:*/
;398:static void CG_ParseWarmup( void ) {
line 402
;399:	const char	*info;
;400:	int			warmup;
;401:
;402:	info = CG_ConfigString( CS_WARMUP );
CNSTI4 5
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 404
;403:
;404:	warmup = atoi( info );
ADDRLP4 4
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
line 405
;405:	cg.warmupCount = -1;
ADDRGP4 cg+125252
CNSTI4 -1
ASGNI4
line 407
;406:
;407:	if ( warmup == 0 && cg.warmup ) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $323
ADDRGP4 cg+125248
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $323
line 409
;408:
;409:	} else if ( warmup > 0 && cg.warmup <= 0 ) {
ADDRGP4 $324
JUMPV
LABELV $323
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
LEI4 $326
ADDRGP4 cg+125248
INDIRI4
ADDRLP4 20
INDIRI4
GTI4 $326
line 415
;410:#ifdef MISSIONPACK
;411:		if (CG_IsATeamGametype(cgs.gametype)) {
;412:			trap_S_StartLocalSound( cgs.media.countPrepareTeamSound, CHAN_ANNOUNCER );
;413:		} else
;414:#endif
;415:		{
line 416
;416:			trap_S_StartLocalSound( cgs.media.countPrepareSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1372
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 417
;417:		}
line 418
;418:	}
LABELV $326
LABELV $324
line 420
;419:
;420:	cg.warmup = warmup;
ADDRGP4 cg+125248
ADDRLP4 0
INDIRI4
ASGNI4
line 421
;421:}
LABELV $321
endproc CG_ParseWarmup 24 8
export CG_SetConfigValues
proc CG_SetConfigValues 48 4
line 430
;422:
;423:/*
;424:================
;425:CG_SetConfigValues
;426:
;427:Called on load to set the initial values from configure strings
;428:================
;429:*/
;430:void CG_SetConfigValues( void ) {
line 433
;431:	const char *s;
;432:
;433:	cgs.scores1 = atoi( CG_ConfigString( CS_SCORES1 ) );
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34980
ADDRLP4 8
INDIRI4
ASGNI4
line 434
;434:	cgs.scores2 = atoi( CG_ConfigString( CS_SCORES2 ) );
CNSTI4 7
ARGI4
ADDRLP4 12
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34984
ADDRLP4 16
INDIRI4
ASGNI4
line 435
;435:	cgs.levelStartTime = atoi( CG_ConfigString( CS_LEVEL_START_TIME ) );
CNSTI4 21
ARGI4
ADDRLP4 20
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34804
ADDRLP4 24
INDIRI4
ASGNI4
line 436
;436:	if((CG_UsesTeamFlags(cgs.gametype) && !CG_UsesTheWhiteFlag(cgs.gametype)) || cgs.gametype == GT_DOUBLE_D) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $342
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $341
LABELV $342
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
NEI4 $336
LABELV $341
line 437
;437:		s = CG_ConfigString( CS_FLAGSTATUS );
CNSTI4 23
ARGI4
ADDRLP4 36
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 438
;438:		cgs.redflag = s[0] - '0';
ADDRGP4 cgs+34988
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 439
;439:		cgs.blueflag = s[1] - '0';
ADDRGP4 cgs+34992
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 440
;440:	}
ADDRGP4 $337
JUMPV
LABELV $336
line 442
;441://#ifdef MISSIONPACK
;442:	else if( CG_UsesTheWhiteFlag(cgs.gametype) ) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $345
line 443
;443:		s = CG_ConfigString( CS_FLAGSTATUS );
CNSTI4 23
ARGI4
ADDRLP4 40
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 444
;444:		cgs.flagStatus = s[0] - '0';
ADDRGP4 cgs+34996
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 445
;445:	}
LABELV $345
LABELV $337
line 447
;446://#endif
;447:	cg.warmup = atoi( CG_ConfigString( CS_WARMUP ) );
CNSTI4 5
ARGI4
ADDRLP4 40
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+125248
ADDRLP4 44
INDIRI4
ASGNI4
line 448
;448:}
LABELV $332
endproc CG_SetConfigValues 48 4
export CG_ShaderStateChanged
proc CG_ShaderStateChanged 188 12
line 455
;449:
;450:/*
;451:=====================
;452:CG_ShaderStateChanged
;453:=====================
;454:*/
;455:void CG_ShaderStateChanged(void) {
line 462
;456:	char originalShader[MAX_QPATH];
;457:	char newShader[MAX_QPATH];
;458:	char timeOffset[16];
;459:	const char *o;
;460:	char *n,*t;
;461:
;462:	o = CG_ConfigString( CS_SHADERSTATE );
CNSTI4 24
ARGI4
ADDRLP4 156
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
ADDRGP4 $352
JUMPV
LABELV $351
line 463
;463:	while (o && *o) {
line 464
;464:		n = strstr(o, "=");
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $354
ARGP4
ADDRLP4 160
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 160
INDIRP4
ASGNP4
line 465
;465:		if (n && *n) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $353
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $353
line 466
;466:			strncpy(originalShader, o, n-o);
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 467
;467:			originalShader[n-o] = 0;
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 12
ADDP4
CNSTI1 0
ASGNI1
line 468
;468:			n++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 469
;469:			t = strstr(n, ":");
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $357
ARGP4
ADDRLP4 172
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 172
INDIRP4
ASGNP4
line 470
;470:			if (t && *t) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $353
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $353
line 471
;471:				strncpy(newShader, n, t-n);
ADDRLP4 76
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 472
;472:				newShader[t-n] = 0;
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 76
ADDP4
CNSTI1 0
ASGNI1
line 473
;473:			} else {
line 474
;474:				break;
LABELV $359
line 476
;475:			}
;476:			t++;
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 477
;477:			o = strstr(t, "@");
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $360
ARGP4
ADDRLP4 180
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 180
INDIRP4
ASGNP4
line 478
;478:			if (o) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $356
line 479
;479:				strncpy(timeOffset, t, o-t);
ADDRLP4 140
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 480
;480:				timeOffset[o-t] = 0;
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 140
ADDP4
CNSTI1 0
ASGNI1
line 481
;481:				o++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 482
;482:				trap_R_RemapShader( originalShader, newShader, timeOffset );
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_RemapShader
CALLV
pop
line 483
;483:			}
line 484
;484:		} else {
line 485
;485:			break;
LABELV $356
line 487
;486:		}
;487:	}
LABELV $352
line 463
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $363
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $351
LABELV $363
LABELV $353
line 488
;488:}
LABELV $350
endproc CG_ShaderStateChanged 188 12
proc CG_ConfigStringModified 60 12
line 496
;489:
;490:/*
;491:================
;492:CG_ConfigStringModified
;493:
;494:================
;495:*/
;496:static void CG_ConfigStringModified( void ) {
line 500
;497:	const char	*str;
;498:	int		num;
;499:
;500:	num = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 8
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
line 504
;501:
;502:	// get the gamestate from the client system, which will have the
;503:	// new configstring already integrated
;504:	trap_GetGameState( &cgs.gameState );
ADDRGP4 cgs
ARGP4
ADDRGP4 trap_GetGameState
CALLV
pop
line 507
;505:
;506:	// look up the individual string that was modified
;507:	str = CG_ConfigString( num );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 510
;508:
;509:	// do something with it if necessary
;510:	if ( num == CS_MUSIC ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $365
line 511
;511:		CG_StartMusic();	
ADDRGP4 CG_StartMusic
CALLV
pop
line 512
;512:	} else if ( num == CS_SERVERINFO ) {
ADDRGP4 $366
JUMPV
LABELV $365
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $367
line 513
;513:		CG_ParseServerinfo();
ADDRGP4 CG_ParseServerinfo
CALLV
pop
line 514
;514:	} else if ( num == CS_WARMUP ) {
ADDRGP4 $368
JUMPV
LABELV $367
ADDRLP4 0
INDIRI4
CNSTI4 5
NEI4 $369
line 515
;515:		CG_ParseWarmup();
ADDRGP4 CG_ParseWarmup
CALLV
pop
line 516
;516:	} else if ( num == CS_SCORES1 ) {
ADDRGP4 $370
JUMPV
LABELV $369
ADDRLP4 0
INDIRI4
CNSTI4 6
NEI4 $371
line 517
;517:		cgs.scores1 = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34980
ADDRLP4 20
INDIRI4
ASGNI4
line 518
;518:	} else if ( num == CS_SCORES2 ) {
ADDRGP4 $372
JUMPV
LABELV $371
ADDRLP4 0
INDIRI4
CNSTI4 7
NEI4 $374
line 519
;519:		cgs.scores2 = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34984
ADDRLP4 20
INDIRI4
ASGNI4
line 520
;520:	} else if ( num == CS_LEVEL_START_TIME ) {
ADDRGP4 $375
JUMPV
LABELV $374
ADDRLP4 0
INDIRI4
CNSTI4 21
NEI4 $377
line 521
;521:		cgs.levelStartTime = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34804
ADDRLP4 20
INDIRI4
ASGNI4
line 522
;522:	} else if ( num == CS_VOTE_TIME ) {
ADDRGP4 $378
JUMPV
LABELV $377
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $380
line 523
;523:		cgs.voteTime = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31684
ADDRLP4 20
INDIRI4
ASGNI4
line 524
;524:		cgs.voteModified = qtrue;
ADDRGP4 cgs+31696
CNSTI4 1
ASGNI4
line 525
;525:	} else if ( num == CS_VOTE_YES ) {
ADDRGP4 $381
JUMPV
LABELV $380
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $384
line 526
;526:		cgs.voteYes = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31688
ADDRLP4 20
INDIRI4
ASGNI4
line 527
;527:		cgs.voteModified = qtrue;
ADDRGP4 cgs+31696
CNSTI4 1
ASGNI4
line 528
;528:	} else if ( num == CS_VOTE_NO ) {
ADDRGP4 $385
JUMPV
LABELV $384
ADDRLP4 0
INDIRI4
CNSTI4 11
NEI4 $388
line 529
;529:		cgs.voteNo = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31692
ADDRLP4 20
INDIRI4
ASGNI4
line 530
;530:		cgs.voteModified = qtrue;
ADDRGP4 cgs+31696
CNSTI4 1
ASGNI4
line 531
;531:	} else if ( num == CS_VOTE_STRING ) {
ADDRGP4 $389
JUMPV
LABELV $388
ADDRLP4 0
INDIRI4
CNSTI4 9
NEI4 $392
line 532
;532:		Q_strncpyz( cgs.voteString, str, sizeof( cgs.voteString ) );
ADDRGP4 cgs+31700
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 536
;533:#ifdef MISSIONPACK
;534:		trap_S_StartLocalSound( cgs.media.voteNow, CHAN_ANNOUNCER );
;535:#endif //MISSIONPACK
;536:	} else if ( num >= CS_TEAMVOTE_TIME && num <= CS_TEAMVOTE_TIME + 1) {
ADDRGP4 $393
JUMPV
LABELV $392
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $396
ADDRLP4 0
INDIRI4
CNSTI4 13
GTI4 $396
line 537
;537:		cgs.teamVoteTime[num-CS_TEAMVOTE_TIME] = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32724-48
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 538
;538:		cgs.teamVoteModified[num-CS_TEAMVOTE_TIME] = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32748-48
ADDP4
CNSTI4 1
ASGNI4
line 539
;539:	} else if ( num >= CS_TEAMVOTE_YES && num <= CS_TEAMVOTE_YES + 1) {
ADDRGP4 $397
JUMPV
LABELV $396
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $402
ADDRLP4 0
INDIRI4
CNSTI4 17
GTI4 $402
line 540
;540:		cgs.teamVoteYes[num-CS_TEAMVOTE_YES] = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32732-64
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 541
;541:		cgs.teamVoteModified[num-CS_TEAMVOTE_YES] = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32748-64
ADDP4
CNSTI4 1
ASGNI4
line 542
;542:	} else if ( num >= CS_TEAMVOTE_NO && num <= CS_TEAMVOTE_NO + 1) {
ADDRGP4 $403
JUMPV
LABELV $402
ADDRLP4 0
INDIRI4
CNSTI4 18
LTI4 $408
ADDRLP4 0
INDIRI4
CNSTI4 19
GTI4 $408
line 543
;543:		cgs.teamVoteNo[num-CS_TEAMVOTE_NO] = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32740-72
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 544
;544:		cgs.teamVoteModified[num-CS_TEAMVOTE_NO] = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32748-72
ADDP4
CNSTI4 1
ASGNI4
line 545
;545:	} else if ( num >= CS_TEAMVOTE_STRING && num <= CS_TEAMVOTE_STRING + 1) {
ADDRGP4 $409
JUMPV
LABELV $408
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $414
ADDRLP4 0
INDIRI4
CNSTI4 15
GTI4 $414
line 546
;546:		Q_strncpyz( cgs.teamVoteString[num-CS_TEAMVOTE_STRING], str, sizeof( cgs.teamVoteString[0] ) );
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+32756-14336
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 550
;547:#ifdef MISSIONPACK
;548:		trap_S_StartLocalSound( cgs.media.voteNow, CHAN_ANNOUNCER );
;549:#endif	
;550:	} else if ( num == CS_INTERMISSION ) {
ADDRGP4 $415
JUMPV
LABELV $414
ADDRLP4 0
INDIRI4
CNSTI4 22
NEI4 $419
line 551
;551:		cg.intermissionStarted = atoi( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+24
ADDRLP4 36
INDIRI4
ASGNI4
line 552
;552:	} else if ( num >= CS_MODELS && num < CS_MODELS+MAX_MODELS ) {
ADDRGP4 $420
JUMPV
LABELV $419
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $422
ADDRLP4 0
INDIRI4
CNSTI4 288
GEI4 $422
line 553
;553:		cgs.gameModels[ num-CS_MODELS ] = trap_R_RegisterModel( str );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35004-128
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 554
;554:	} else if ( num >= CS_SOUNDS && num < CS_SOUNDS+MAX_SOUNDS ) {
ADDRGP4 $423
JUMPV
LABELV $422
ADDRLP4 0
INDIRI4
CNSTI4 288
LTI4 $426
ADDRLP4 0
INDIRI4
CNSTI4 544
GEI4 $426
line 555
;555:		if ( str[0] != '*' ) {	// player specific sounds don't register here
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $427
line 556
;556:			cgs.gameSounds[ num-CS_SOUNDS] = trap_S_RegisterSound( str, qfalse );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 44
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36028-1152
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 557
;557:		}
line 558
;558:	} else if ( num >= CS_PLAYERS && num < CS_PLAYERS+MAX_CLIENTS ) {
ADDRGP4 $427
JUMPV
LABELV $426
ADDRLP4 0
INDIRI4
CNSTI4 544
LTI4 $432
ADDRLP4 0
INDIRI4
CNSTI4 608
GEI4 $432
line 559
;559:		CG_NewClientInfo( num - CS_PLAYERS );
ADDRLP4 0
INDIRI4
CNSTI4 544
SUBI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 560
;560:		CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 561
;561:	} else if ( num == CS_FLAGSTATUS ) {
ADDRGP4 $433
JUMPV
LABELV $432
ADDRLP4 0
INDIRI4
CNSTI4 23
NEI4 $434
line 562
;562:		if((CG_UsesTeamFlags(cgs.gametype) && CG_UsesTheWhiteFlag(cgs.gametype)) || cgs.gametype == GT_DOUBLE_D) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $442
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $441
LABELV $442
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
NEI4 $436
LABELV $441
line 564
;563:			// format is rb where its red/blue, 0 is at base, 1 is taken, 2 is dropped
;564:			cgs.redflag = str[0] - '0';
ADDRGP4 cgs+34988
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 565
;565:			cgs.blueflag = str[1] - '0';
ADDRGP4 cgs+34992
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 566
;566:		}
ADDRGP4 $435
JUMPV
LABELV $436
line 567
;567:		else if( CG_UsesTheWhiteFlag(cgs.gametype) ) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $435
line 568
;568:			cgs.flagStatus = str[0] - '0';
ADDRGP4 cgs+34996
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 569
;569:		}
line 570
;570:	}
ADDRGP4 $435
JUMPV
LABELV $434
line 571
;571:	else if ( num == CS_SHADERSTATE ) {
ADDRLP4 0
INDIRI4
CNSTI4 24
NEI4 $449
line 572
;572:		CG_ShaderStateChanged();
ADDRGP4 CG_ShaderStateChanged
CALLV
pop
line 573
;573:	}
LABELV $449
LABELV $435
LABELV $433
LABELV $427
LABELV $423
LABELV $420
LABELV $415
LABELV $409
LABELV $403
LABELV $397
LABELV $393
LABELV $389
LABELV $385
LABELV $381
LABELV $378
LABELV $375
LABELV $372
LABELV $370
LABELV $368
LABELV $366
line 575
;574:		
;575:}
LABELV $364
endproc CG_ConfigStringModified 60 12
proc CG_AddToTeamChat 56 0
line 584
;576:
;577:
;578:/*
;579:=======================
;580:CG_AddToTeamChat
;581:
;582:=======================
;583:*/
;584:static void CG_AddToTeamChat( const char *str ) {
line 590
;585:	int len;
;586:	char *p, *ls;
;587:	int lastcolor;
;588:	int chatHeight;
;589:
;590:	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT) {
ADDRGP4 cg_teamChatHeight+12
INDIRI4
CNSTI4 8
GEI4 $452
line 591
;591:		chatHeight = cg_teamChatHeight.integer;
ADDRLP4 12
ADDRGP4 cg_teamChatHeight+12
INDIRI4
ASGNI4
line 592
;592:	} else {
ADDRGP4 $453
JUMPV
LABELV $452
line 593
;593:		chatHeight = TEAMCHAT_HEIGHT;
ADDRLP4 12
CNSTI4 8
ASGNI4
line 594
;594:	}
LABELV $453
line 596
;595:
;596:	if (chatHeight <= 0 || cg_teamChatTime.integer <= 0) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 20
INDIRI4
LEI4 $459
ADDRGP4 cg_teamChatTime+12
INDIRI4
ADDRLP4 20
INDIRI4
GTI4 $456
LABELV $459
line 598
;597:		// team chat disabled, dump into normal chat
;598:		cgs.teamChatPos = cgs.teamLastChatPos = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 cgs+178796
ADDRLP4 24
INDIRI4
ASGNI4
ADDRGP4 cgs+178792
ADDRLP4 24
INDIRI4
ASGNI4
line 599
;599:		return;
ADDRGP4 $451
JUMPV
LABELV $456
line 602
;600:	}
;601:
;602:	len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 604
;603:
;604:	p = cgs.teamChatMsgs[cgs.teamChatPos % chatHeight];
ADDRLP4 0
CNSTI4 241
ADDRGP4 cgs+178792
INDIRI4
ADDRLP4 12
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+176832
ADDP4
ASGNP4
line 605
;605:	*p = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 607
;606:
;607:	lastcolor = '7';
ADDRLP4 16
CNSTI4 55
ASGNI4
line 609
;608:
;609:	ls = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
ADDRGP4 $465
JUMPV
LABELV $464
line 610
;610:	while (*str) {
line 611
;611:		if (len > TEAMCHAT_WIDTH - 1) {
ADDRLP4 4
INDIRI4
CNSTI4 79
LEI4 $467
line 612
;612:			if (ls) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $469
line 613
;613:				str -= (p - ls);
ADDRFP4 0
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
SUBP4
ASGNP4
line 614
;614:				str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 615
;615:				p -= (p - ls);
ADDRLP4 0
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
SUBP4
ASGNP4
line 616
;616:			}
LABELV $469
line 617
;617:			*p = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 619
;618:
;619:			cgs.teamChatMsgTimes[cgs.teamChatPos % chatHeight] = cg.time;
ADDRGP4 cgs+178792
INDIRI4
ADDRLP4 12
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+178760
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 621
;620:
;621:			cgs.teamChatPos++;
ADDRLP4 24
ADDRGP4 cgs+178792
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 622
;622:			p = cgs.teamChatMsgs[cgs.teamChatPos % chatHeight];
ADDRLP4 0
CNSTI4 241
ADDRGP4 cgs+178792
INDIRI4
ADDRLP4 12
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+176832
ADDP4
ASGNP4
line 623
;623:			*p = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 624
;624:			*p++ = Q_COLOR_ESCAPE;
ADDRLP4 28
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI1 94
ASGNI1
line 625
;625:			*p++ = lastcolor;
ADDRLP4 32
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 16
INDIRI4
CVII1 4
ASGNI1
line 626
;626:			len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 627
;627:			ls = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 628
;628:		}
LABELV $467
line 630
;629:
;630:		if ( Q_IsColorString( str ) ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $477
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $477
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $477
ADDRLP4 28
INDIRI4
CNSTI4 48
LTI4 $477
ADDRLP4 28
INDIRI4
CNSTI4 56
GTI4 $477
line 631
;631:			*p++ = *str++;
ADDRLP4 32
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 40
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ASGNP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI1
ASGNI1
line 632
;632:			lastcolor = *str;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 633
;633:			*p++ = *str++;
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 44
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ASGNP4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 48
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI1
ASGNI1
line 634
;634:			continue;
ADDRGP4 $465
JUMPV
LABELV $477
line 636
;635:		}
;636:		if (*str == ' ') {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $479
line 637
;637:			ls = p;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
line 638
;638:		}
LABELV $479
line 639
;639:		*p++ = *str++;
ADDRLP4 32
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 40
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ASGNP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI1
ASGNI1
line 640
;640:		len++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 641
;641:	}
LABELV $465
line 610
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $464
line 642
;642:	*p = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 644
;643:
;644:	cgs.teamChatMsgTimes[cgs.teamChatPos % chatHeight] = cg.time;
ADDRGP4 cgs+178792
INDIRI4
ADDRLP4 12
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+178760
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 645
;645:	cgs.teamChatPos++;
ADDRLP4 24
ADDRGP4 cgs+178792
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 647
;646:
;647:	if (cgs.teamChatPos - cgs.teamLastChatPos > chatHeight) {
ADDRGP4 cgs+178792
INDIRI4
ADDRGP4 cgs+178796
INDIRI4
SUBI4
ADDRLP4 12
INDIRI4
LEI4 $485
line 648
;648:		cgs.teamLastChatPos = cgs.teamChatPos - chatHeight;
ADDRGP4 cgs+178796
ADDRGP4 cgs+178792
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
ASGNI4
line 649
;649:	}
LABELV $485
line 650
;650:}
LABELV $451
endproc CG_AddToTeamChat 56 0
proc CG_MapRestart 0 12
line 663
;651:
;652:/*
;653:===============
;654:CG_MapRestart
;655:
;656:The server has issued a map_restart, so the next snapshot
;657:is completely new and should not be interpolated to.
;658:
;659:A tournement restart will clear everything, but doesn't
;660:require a reload of all the media
;661:===============
;662:*/
;663:static void CG_MapRestart( void ) {
line 664
;664:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $492
line 665
;665:		CG_Printf( "CG_MapRestart\n" );
ADDRGP4 $495
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 666
;666:	}
LABELV $492
line 668
;667:
;668:	CG_InitLocalEntities();
ADDRGP4 CG_InitLocalEntities
CALLV
pop
line 669
;669:	CG_InitMarkPolys();
ADDRGP4 CG_InitMarkPolys
CALLV
pop
line 672
;670:
;671:	// make sure the "3 frags left" warnings play again
;672:	cg.fraglimitWarnings = 0;
ADDRGP4 cg+107620
CNSTI4 0
ASGNI4
line 674
;673:
;674:	cg.timelimitWarnings = 0;
ADDRGP4 cg+107616
CNSTI4 0
ASGNI4
line 676
;675:
;676:	cg.intermissionStarted = qfalse;
ADDRGP4 cg+24
CNSTI4 0
ASGNI4
line 678
;677:
;678:	cgs.voteTime = 0;
ADDRGP4 cgs+31684
CNSTI4 0
ASGNI4
line 680
;679:
;680:	cg.mapRestart = qtrue;
ADDRGP4 cg+107624
CNSTI4 1
ASGNI4
line 682
;681:
;682:	CG_StartMusic();
ADDRGP4 CG_StartMusic
CALLV
pop
line 684
;683:
;684:	trap_S_ClearLoopingSounds(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 689
;685:
;686:	// we really should clear more parts of cg here and stop sounds
;687:
;688:	// play the "fight" sound if this is a restart without warmup
;689:	if ( cg.warmup == 0 /* && cgs.gametype == GT_TOURNAMENT */) {
ADDRGP4 cg+125248
INDIRI4
CNSTI4 0
NEI4 $501
line 690
;690:		trap_S_StartLocalSound( cgs.media.countFightSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1368
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 691
;691:		CG_CenterPrint( "FIGHT!", 120, GIANTCHAR_WIDTH*2 );
ADDRGP4 $506
ARGP4
CNSTI4 120
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 692
;692:	}
LABELV $501
line 701
;693:#ifdef MISSIONPACK
;694:	if (cg_singlePlayerActive.integer) {
;695:		trap_Cvar_Set("ui_matchStartTime", va("%i", cg.time));
;696:		if (cg_recordSPDemo.integer && cg_recordSPDemoName.string[0] ) {
;697:			trap_SendConsoleCommand(va("set g_synchronousclients 1 ; record %s \n", cg_recordSPDemoName.string));
;698:		}
;699:	}
;700:#endif
;701:	trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $507
ARGP4
ADDRGP4 $508
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 702
;702:}
LABELV $491
endproc CG_MapRestart 0 12
export CG_ParseVoiceChats
proc CG_ParseVoiceChats 16492 16
line 741
;703:
;704:#define MAX_VOICEFILESIZE	16384
;705:#define MAX_VOICEFILES		8
;706:#define MAX_VOICECHATS		64
;707:#define MAX_VOICESOUNDS		64
;708:#define MAX_CHATSIZE		64
;709:#define MAX_HEADMODELS		64
;710:
;711:typedef struct voiceChat_s
;712:{
;713:	char id[64];
;714:	int numSounds;
;715:	sfxHandle_t sounds[MAX_VOICESOUNDS];
;716:	char chats[MAX_VOICESOUNDS][MAX_CHATSIZE];
;717:} voiceChat_t;
;718:
;719:typedef struct voiceChatList_s
;720:{
;721:	char name[64];
;722:	int gender;
;723:	int numVoiceChats;
;724:	voiceChat_t voiceChats[MAX_VOICECHATS];
;725:} voiceChatList_t;
;726:
;727:typedef struct headModelVoiceChat_s
;728:{
;729:	char headmodel[64];
;730:	int voiceChatNum;
;731:} headModelVoiceChat_t;
;732:
;733:voiceChatList_t voiceChatLists[MAX_VOICEFILES];
;734:headModelVoiceChat_t headModelVoiceChat[MAX_HEADMODELS];
;735:
;736:/*
;737:=================
;738:CG_ParseVoiceChats
;739:=================
;740:*/
;741:int CG_ParseVoiceChats( const char *filename, voiceChatList_t *voiceChatList, int maxVoiceChats ) {
line 751
;742:	int	len, i;
;743:	fileHandle_t f;
;744:	char buf[MAX_VOICEFILESIZE];
;745:	char **p, *ptr;
;746:	char *token;
;747:	voiceChat_t *voiceChats;
;748:	qboolean compress;
;749:	sfxHandle_t sound;
;750:
;751:	compress = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 752
;752:	if (cg_buildScript.integer) {
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $510
line 753
;753:		compress = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 754
;754:	}
LABELV $510
line 756
;755:
;756:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 16420
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 16420
INDIRI4
ASGNI4
line 757
;757:	if ( !f ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $513
line 758
;758:		trap_Print( va( S_COLOR_RED "voice chat file not found: %s\n", filename ) );
ADDRGP4 $515
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16424
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16424
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 759
;759:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $513
line 761
;760:	}
;761:	if ( len >= MAX_VOICEFILESIZE ) {
ADDRLP4 24
INDIRI4
CNSTI4 16384
LTI4 $516
line 762
;762:		trap_Print( va( S_COLOR_RED "voice chat file too large: %s is %i, max allowed is %i\n", filename, len, MAX_VOICEFILESIZE ) );
ADDRGP4 $518
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
CNSTI4 16384
ARGI4
ADDRLP4 16424
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16424
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 763
;763:		trap_FS_FCloseFile( f );
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 764
;764:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $516
line 767
;765:	}
;766:
;767:	trap_FS_Read( buf, len, f );
ADDRLP4 32
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 768
;768:	buf[len] = 0;
ADDRLP4 24
INDIRI4
ADDRLP4 32
ADDP4
CNSTI1 0
ASGNI1
line 769
;769:	trap_FS_FCloseFile( f );
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 771
;770:
;771:	ptr = buf;
ADDRLP4 16416
ADDRLP4 32
ASGNP4
line 772
;772:	p = &ptr;
ADDRLP4 12
ADDRLP4 16416
ASGNP4
line 774
;773:
;774:	Com_sprintf(voiceChatList->name, sizeof(voiceChatList->name), "%s", filename);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $519
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 775
;775:	voiceChats = voiceChatList->voiceChats;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
line 776
;776:	for ( i = 0; i < maxVoiceChats; i++ ) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $523
JUMPV
LABELV $520
line 777
;777:		voiceChats[i].id[0] = 0;
CNSTI4 4420
ADDRLP4 20
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 778
;778:	}
LABELV $521
line 776
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $523
ADDRLP4 20
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $520
line 779
;779:	token = COM_ParseExt(p, qtrue);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16424
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16424
INDIRP4
ASGNP4
line 780
;780:	if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $524
line 781
;781:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $509
JUMPV
LABELV $524
line 783
;782:	}
;783:	if (Q_strequal(token, "female")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $528
ARGP4
ADDRLP4 16428
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16428
INDIRI4
CNSTI4 0
NEI4 $526
line 784
;784:		voiceChatList->gender = GENDER_FEMALE;
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 1
ASGNI4
line 785
;785:	}
ADDRGP4 $527
JUMPV
LABELV $526
line 786
;786:	else if (Q_strequal(token, "male")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $531
ARGP4
ADDRLP4 16432
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16432
INDIRI4
CNSTI4 0
NEI4 $529
line 787
;787:		voiceChatList->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
line 788
;788:	}
ADDRGP4 $530
JUMPV
LABELV $529
line 789
;789:	else if (Q_strequal(token, "neuter")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $534
ARGP4
ADDRLP4 16436
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16436
INDIRI4
CNSTI4 0
NEI4 $532
line 790
;790:		voiceChatList->gender = GENDER_NEUTER;
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 2
ASGNI4
line 791
;791:	}
ADDRGP4 $533
JUMPV
LABELV $532
line 792
;792:	else {
line 793
;793:		trap_Print( va( S_COLOR_RED "expected gender not found in voice chat file: %s\n", filename ) );
ADDRGP4 $535
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16440
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16440
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 794
;794:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $533
LABELV $530
LABELV $527
line 797
;795:	}
;796:
;797:	voiceChatList->numVoiceChats = 0;
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $537
JUMPV
LABELV $536
line 798
;798:	while ( 1 ) {
line 799
;799:		token = COM_ParseExt(p, qtrue);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16440
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16440
INDIRP4
ASGNP4
line 800
;800:		if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $539
line 801
;801:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $509
JUMPV
LABELV $539
line 803
;802:		}
;803:		Com_sprintf(voiceChats[voiceChatList->numVoiceChats].id, sizeof( voiceChats[voiceChatList->numVoiceChats].id ), "%s", token);
CNSTI4 4420
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $519
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 804
;804:		token = COM_ParseExt(p, qtrue);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16444
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16444
INDIRP4
ASGNP4
line 805
;805:		if ( !Q_strequal(token, "{")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 16448
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16448
INDIRI4
CNSTI4 0
EQI4 $541
line 806
;806:			trap_Print( va( S_COLOR_RED "expected { found %s in voice chat file: %s\n", token, filename ) );
ADDRGP4 $544
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16452
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16452
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 807
;807:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $541
line 809
;808:		}
;809:		voiceChats[voiceChatList->numVoiceChats].numSounds = 0;
CNSTI4 4420
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $546
JUMPV
LABELV $545
line 810
;810:		while(1) {
line 811
;811:			token = COM_ParseExt(p, qtrue);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16452
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16452
INDIRP4
ASGNP4
line 812
;812:			if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $548
line 813
;813:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $509
JUMPV
LABELV $548
line 815
;814:			}
;815:			if (Q_strequal(token, "}"))
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $552
ARGP4
ADDRLP4 16456
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16456
INDIRI4
CNSTI4 0
NEI4 $550
line 816
;816:				break;
ADDRGP4 $547
JUMPV
LABELV $550
line 817
;817:			sound = trap_S_RegisterSound( token, compress );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16460
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16460
INDIRI4
ASGNI4
line 818
;818:			voiceChats[voiceChatList->numVoiceChats].sounds[voiceChats[voiceChatList->numVoiceChats].numSounds] = sound;
ADDRLP4 16464
CNSTI4 68
ASGNI4
ADDRLP4 16468
CNSTI4 4420
ADDRFP4 4
INDIRP4
ADDRLP4 16464
INDIRI4
ADDP4
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
ADDRLP4 16468
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16468
INDIRP4
ADDRLP4 16464
INDIRI4
ADDP4
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 819
;819:			token = COM_ParseExt(p, qtrue);
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16472
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16472
INDIRP4
ASGNP4
line 820
;820:			if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $553
line 821
;821:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $509
JUMPV
LABELV $553
line 823
;822:			}
;823:			Com_sprintf(voiceChats[voiceChatList->numVoiceChats].chats[
ADDRLP4 16476
CNSTI4 4420
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
ADDRLP4 16480
CNSTI4 64
ASGNI4
ADDRLP4 16476
INDIRP4
ADDRLP4 16480
INDIRI4
ADDP4
INDIRI4
CNSTI4 6
LSHI4
ADDRLP4 16476
INDIRP4
CNSTI4 324
ADDP4
ADDP4
ARGP4
ADDRLP4 16480
INDIRI4
ARGI4
ADDRGP4 $519
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 825
;824:							voiceChats[voiceChatList->numVoiceChats].numSounds], MAX_CHATSIZE, "%s", token);
;825:			if (sound)
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $555
line 826
;826:				voiceChats[voiceChatList->numVoiceChats].numSounds++;
ADDRLP4 16484
CNSTI4 4420
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 16484
INDIRP4
ADDRLP4 16484
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $555
line 827
;827:			if (voiceChats[voiceChatList->numVoiceChats].numSounds >= MAX_VOICESOUNDS)
ADDRLP4 16488
CNSTI4 64
ASGNI4
CNSTI4 4420
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 16488
INDIRI4
ADDP4
INDIRI4
ADDRLP4 16488
INDIRI4
LTI4 $557
line 828
;828:				break;
ADDRGP4 $547
JUMPV
LABELV $557
line 829
;829:		}
LABELV $546
line 810
ADDRGP4 $545
JUMPV
LABELV $547
line 830
;830:		voiceChatList->numVoiceChats++;
ADDRLP4 16452
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16452
INDIRP4
ADDRLP4 16452
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 831
;831:		if (voiceChatList->numVoiceChats >= maxVoiceChats)
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $559
line 832
;832:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $509
JUMPV
LABELV $559
line 833
;833:	}
LABELV $537
line 798
ADDRGP4 $536
JUMPV
line 834
;834:	return qtrue;
CNSTI4 1
RETI4
LABELV $509
endproc CG_ParseVoiceChats 16492 16
export CG_LoadVoiceChats
proc CG_LoadVoiceChats 12 12
line 842
;835:}
;836:
;837:/*
;838:=================
;839:CG_LoadVoiceChats
;840:=================
;841:*/
;842:void CG_LoadVoiceChats( void ) {
line 845
;843:	int size;
;844:
;845:	size = trap_MemoryRemaining();
ADDRLP4 4
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 846
;846:	CG_ParseVoiceChats( "scripts/female1.voice", &voiceChatLists[0], MAX_VOICECHATS );
ADDRGP4 $562
ARGP4
ADDRGP4 voiceChatLists
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 847
;847:	CG_ParseVoiceChats( "scripts/female2.voice", &voiceChatLists[1], MAX_VOICECHATS );
ADDRGP4 $563
ARGP4
ADDRGP4 voiceChatLists+282952
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 848
;848:	CG_ParseVoiceChats( "scripts/female3.voice", &voiceChatLists[2], MAX_VOICECHATS );
ADDRGP4 $565
ARGP4
ADDRGP4 voiceChatLists+565904
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 849
;849:	CG_ParseVoiceChats( "scripts/male1.voice", &voiceChatLists[3], MAX_VOICECHATS );
ADDRGP4 $567
ARGP4
ADDRGP4 voiceChatLists+848856
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 850
;850:	CG_ParseVoiceChats( "scripts/male2.voice", &voiceChatLists[4], MAX_VOICECHATS );
ADDRGP4 $569
ARGP4
ADDRGP4 voiceChatLists+1131808
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 851
;851:	CG_ParseVoiceChats( "scripts/male3.voice", &voiceChatLists[5], MAX_VOICECHATS );
ADDRGP4 $571
ARGP4
ADDRGP4 voiceChatLists+1414760
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 852
;852:	CG_ParseVoiceChats( "scripts/male4.voice", &voiceChatLists[6], MAX_VOICECHATS );
ADDRGP4 $573
ARGP4
ADDRGP4 voiceChatLists+1697712
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 853
;853:	CG_ParseVoiceChats( "scripts/male5.voice", &voiceChatLists[7], MAX_VOICECHATS );
ADDRGP4 $575
ARGP4
ADDRGP4 voiceChatLists+1980664
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_ParseVoiceChats
CALLI4
pop
line 854
;854:	CG_Printf("voice chat memory size = %d\n", size - trap_MemoryRemaining());
ADDRLP4 8
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRGP4 $577
ARGP4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 855
;855:}
LABELV $561
endproc CG_LoadVoiceChats 12 12
export CG_HeadModelVoiceChats
proc CG_HeadModelVoiceChats 16420 16
line 862
;856:
;857:/*
;858:=================
;859:CG_HeadModelVoiceChats
;860:=================
;861:*/
;862:int CG_HeadModelVoiceChats( char *filename ) {
line 869
;863:	int	len, i;
;864:	fileHandle_t f;
;865:	char buf[MAX_VOICEFILESIZE];
;866:	char **p, *ptr;
;867:	char *token;
;868:
;869:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 16408
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16408
INDIRI4
ASGNI4
line 870
;870:	if ( !f ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $579
line 872
;871:		//trap_Print( va( "voice chat file not found: %s\n", filename ) );
;872:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $578
JUMPV
LABELV $579
line 874
;873:	}
;874:	if ( len >= MAX_VOICEFILESIZE ) {
ADDRLP4 8
INDIRI4
CNSTI4 16384
LTI4 $581
line 875
;875:		trap_Print( va( S_COLOR_RED "voice chat file too large: %s is %i, max allowed is %i\n", filename, len, MAX_VOICEFILESIZE ) );
ADDRGP4 $518
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 16384
ARGI4
ADDRLP4 16412
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16412
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 876
;876:		trap_FS_FCloseFile( f );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 877
;877:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $578
JUMPV
LABELV $581
line 880
;878:	}
;879:
;880:	trap_FS_Read( buf, len, f );
ADDRLP4 16
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 881
;881:	buf[len] = 0;
ADDRLP4 8
INDIRI4
ADDRLP4 16
ADDP4
CNSTI1 0
ASGNI1
line 882
;882:	trap_FS_FCloseFile( f );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 884
;883:
;884:	ptr = buf;
ADDRLP4 16404
ADDRLP4 16
ASGNP4
line 885
;885:	p = &ptr;
ADDRLP4 16400
ADDRLP4 16404
ASGNP4
line 887
;886:
;887:	token = COM_ParseExt(p, qtrue);
ADDRLP4 16400
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16412
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16412
INDIRP4
ASGNP4
line 888
;888:	if (!token[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $583
line 889
;889:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $578
JUMPV
LABELV $583
line 892
;890:	}
;891:
;892:	for ( i = 0; i < MAX_VOICEFILES; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $585
line 893
;893:		if ( Q_strequal(token, voiceChatLists[i].name) ) {
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 282952
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 voiceChatLists
ADDP4
ARGP4
ADDRLP4 16416
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16416
INDIRI4
CNSTI4 0
NEI4 $589
line 894
;894:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $578
JUMPV
LABELV $589
line 896
;895:		}
;896:	}
LABELV $586
line 892
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $585
line 900
;897:
;898:	//FIXME: maybe try to load the .voice file which name is stored in token?
;899:
;900:	return -1;
CNSTI4 -1
RETI4
LABELV $578
endproc CG_HeadModelVoiceChats 16420 16
export CG_GetVoiceChat
proc CG_GetVoiceChat 16 8
line 909
;901:}
;902:
;903:
;904:/*
;905:=================
;906:CG_GetVoiceChat
;907:=================
;908:*/
;909:int CG_GetVoiceChat( voiceChatList_t *voiceChatList, const char *id, sfxHandle_t *snd, char **chat) {
line 912
;910:	int i, rnd;
;911:
;912:	for ( i = 0; i < voiceChatList->numVoiceChats; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $595
JUMPV
LABELV $592
line 913
;913:		if ( Q_strequal( id, voiceChatList->voiceChats[i].id ) ) {
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4420
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $596
line 914
;914:			rnd = random() * voiceChatList->voiceChats[i].numSounds;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTI4 4420
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDP4
CNSTI4 64
ADDP4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 915
;915:			*snd = voiceChatList->voiceChats[i].sounds[rnd];
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 4420
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDP4
CNSTI4 68
ADDP4
ADDP4
INDIRI4
ASGNI4
line 916
;916:			*chat = voiceChatList->voiceChats[i].chats[rnd];
ADDRFP4 12
INDIRP4
ADDRLP4 4
INDIRI4
CNSTI4 6
LSHI4
CNSTI4 4420
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDP4
CNSTI4 324
ADDP4
ADDP4
ASGNP4
line 917
;917:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $591
JUMPV
LABELV $596
line 919
;918:		}
;919:	}
LABELV $593
line 912
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $595
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
LTI4 $592
line 920
;920:	return qfalse;
CNSTI4 0
RETI4
LABELV $591
endproc CG_GetVoiceChat 16 8
export CG_VoiceChatListForClient
proc CG_VoiceChatListForClient 164 20
line 928
;921:}
;922:
;923:/*
;924:=================
;925:CG_VoiceChatListForClient
;926:=================
;927:*/
;928:voiceChatList_t *CG_VoiceChatListForClient( int clientNum ) {
line 933
;929:	clientInfo_t *ci;
;930:	int voiceChatNum, i, j, k, gender;
;931:	char filename[MAX_QPATH], headModelName[MAX_QPATH];
;932:
;933:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 152
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
LTI4 $601
ADDRLP4 152
INDIRI4
CNSTI4 64
LTI4 $599
LABELV $601
line 934
;934:		clientNum = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 935
;935:	}
LABELV $599
line 936
;936:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 148
CNSTI4 2120
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 938
;937:
;938:	for ( k = 0; k < 2; k++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $603
line 939
;939:		if ( k == 0 ) {
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $607
line 940
;940:			if (ci->headModelName[0] == '*') {
ADDRLP4 148
INDIRP4
CNSTI4 288
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $609
line 941
;941:				Com_sprintf( headModelName, sizeof(headModelName), "%s/%s", ci->headModelName+1, ci->headSkinName );
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $611
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 289
ADDP4
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 352
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 942
;942:			}
ADDRGP4 $608
JUMPV
LABELV $609
line 943
;943:			else {
line 944
;944:				Com_sprintf( headModelName, sizeof(headModelName), "%s/%s", ci->headModelName, ci->headSkinName );
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $611
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 288
ADDP4
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 352
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 945
;945:			}
line 946
;946:		}
ADDRGP4 $608
JUMPV
LABELV $607
line 947
;947:		else {
line 948
;948:			if (ci->headModelName[0] == '*') {
ADDRLP4 148
INDIRP4
CNSTI4 288
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $612
line 949
;949:				Com_sprintf( headModelName, sizeof(headModelName), "%s", ci->headModelName+1 );
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $519
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 289
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 950
;950:			}
ADDRGP4 $613
JUMPV
LABELV $612
line 951
;951:			else {
line 952
;952:				Com_sprintf( headModelName, sizeof(headModelName), "%s", ci->headModelName );
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $519
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 288
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 953
;953:			}
LABELV $613
line 954
;954:		}
LABELV $608
line 956
;955:		// find the voice file for the head model the client uses
;956:		for ( i = 0; i < MAX_HEADMODELS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $614
line 957
;957:			if (Q_strequal(headModelVoiceChat[i].headmodel, headModelName)) {
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $618
line 958
;958:				break;
ADDRGP4 $616
JUMPV
LABELV $618
line 960
;959:			}
;960:		}
LABELV $615
line 956
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $614
LABELV $616
line 961
;961:		if (i < MAX_HEADMODELS) {
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $620
line 962
;962:			return &voiceChatLists[headModelVoiceChat[i].voiceChatNum];
CNSTI4 282952
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat+64
ADDP4
INDIRI4
MULI4
ADDRGP4 voiceChatLists
ADDP4
RETP4
ADDRGP4 $598
JUMPV
LABELV $620
line 965
;963:		}
;964:		// find a <headmodelname>.vc file
;965:		for ( i = 0; i < MAX_HEADMODELS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $623
line 966
;966:			if (!strlen(headModelVoiceChat[i].headmodel)) {
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $627
line 967
;967:				Com_sprintf(filename, sizeof(filename), "scripts/%s.vc", headModelName);
ADDRLP4 76
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $629
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 968
;968:				voiceChatNum = CG_HeadModelVoiceChats(filename);
ADDRLP4 76
ARGP4
ADDRLP4 160
ADDRGP4 CG_HeadModelVoiceChats
CALLI4
ASGNI4
ADDRLP4 72
ADDRLP4 160
INDIRI4
ASGNI4
line 969
;969:				if (voiceChatNum == -1)
ADDRLP4 72
INDIRI4
CNSTI4 -1
NEI4 $630
line 970
;970:					break;
ADDRGP4 $625
JUMPV
LABELV $630
line 971
;971:				Com_sprintf(headModelVoiceChat[i].headmodel, sizeof ( headModelVoiceChat[i].headmodel ),
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $519
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 973
;972:							"%s", headModelName);
;973:				headModelVoiceChat[i].voiceChatNum = voiceChatNum;
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat+64
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 974
;974:				return &voiceChatLists[headModelVoiceChat[i].voiceChatNum];
CNSTI4 282952
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat+64
ADDP4
INDIRI4
MULI4
ADDRGP4 voiceChatLists
ADDP4
RETP4
ADDRGP4 $598
JUMPV
LABELV $627
line 976
;975:			}
;976:		}
LABELV $624
line 965
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $623
LABELV $625
line 977
;977:	}
LABELV $604
line 938
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LTI4 $603
line 978
;978:	gender = ci->gender;
ADDRLP4 140
ADDRLP4 148
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 979
;979:	for (k = 0; k < 2; k++) {
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $634
line 981
;980:		// just pick the first with the right gender
;981:		for ( i = 0; i < MAX_VOICEFILES; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $638
line 982
;982:			if (strlen(voiceChatLists[i].name)) {
CNSTI4 282952
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 voiceChatLists
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $642
line 983
;983:				if (voiceChatLists[i].gender == gender) {
CNSTI4 282952
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 voiceChatLists+64
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
NEI4 $644
line 985
;984:					// store this head model with voice chat for future reference
;985:					for ( j = 0; j < MAX_HEADMODELS; j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $647
line 986
;986:						if (!strlen(headModelVoiceChat[j].headmodel)) {
CNSTI4 68
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
ADDRLP4 160
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $651
line 987
;987:							Com_sprintf(headModelVoiceChat[j].headmodel, sizeof ( headModelVoiceChat[j].headmodel ),
CNSTI4 68
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $519
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 989
;988:									"%s", headModelName);
;989:							headModelVoiceChat[j].voiceChatNum = i;
CNSTI4 68
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat+64
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 990
;990:							break;
ADDRGP4 $649
JUMPV
LABELV $651
line 992
;991:						}
;992:					}
LABELV $648
line 985
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $647
LABELV $649
line 993
;993:					return &voiceChatLists[i];
CNSTI4 282952
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 voiceChatLists
ADDP4
RETP4
ADDRGP4 $598
JUMPV
LABELV $644
line 995
;994:				}
;995:			}
LABELV $642
line 996
;996:		}
LABELV $639
line 981
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $638
line 998
;997:		// fall back to male gender because we don't have neuter in the mission pack
;998:		if (gender == GENDER_MALE)
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $654
line 999
;999:			break;
ADDRGP4 $636
JUMPV
LABELV $654
line 1000
;1000:		gender = GENDER_MALE;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 1001
;1001:	}
LABELV $635
line 979
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LTI4 $634
LABELV $636
line 1003
;1002:	// store this head model with voice chat for future reference
;1003:	for ( j = 0; j < MAX_HEADMODELS; j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $656
line 1004
;1004:		if (!strlen(headModelVoiceChat[j].headmodel)) {
CNSTI4 68
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $660
line 1005
;1005:			Com_sprintf(headModelVoiceChat[j].headmodel, sizeof ( headModelVoiceChat[j].headmodel ),
CNSTI4 68
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $519
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1007
;1006:					"%s", headModelName);
;1007:			headModelVoiceChat[j].voiceChatNum = 0;
CNSTI4 68
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 headModelVoiceChat+64
ADDP4
CNSTI4 0
ASGNI4
line 1008
;1008:			break;
ADDRGP4 $658
JUMPV
LABELV $660
line 1010
;1009:		}
;1010:	}
LABELV $657
line 1003
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $656
LABELV $658
line 1012
;1011:	// just return the first voice chat list
;1012:	return &voiceChatLists[0];
ADDRGP4 voiceChatLists
RETP4
LABELV $598
endproc CG_VoiceChatListForClient 164 20
export CG_PlayVoiceChat
proc CG_PlayVoiceChat 0 0
line 1033
;1013:}
;1014:
;1015:#define MAX_VOICECHATBUFFER		32
;1016:
;1017:typedef struct bufferedVoiceChat_s
;1018:{
;1019:	int clientNum;
;1020:	sfxHandle_t snd;
;1021:	int voiceOnly;
;1022:	char cmd[MAX_SAY_TEXT];
;1023:	char message[MAX_SAY_TEXT];
;1024:} bufferedVoiceChat_t;
;1025:
;1026:bufferedVoiceChat_t voiceChatBuffer[MAX_VOICECHATBUFFER];
;1027:
;1028:/*
;1029:=================
;1030:CG_PlayVoiceChat
;1031:=================
;1032:*/
;1033:void CG_PlayVoiceChat( bufferedVoiceChat_t *vchat ) {
line 1060
;1034:#ifdef MISSIONPACK
;1035:	// if we are going into the intermission, don't start any voices
;1036:	if ( cg.intermissionStarted ) {
;1037:		return;
;1038:	}
;1039:
;1040:	if ( !cg_noVoiceChats.integer ) {
;1041:		trap_S_StartLocalSound( vchat->snd, CHAN_VOICE);
;1042:		if (vchat->clientNum != cg.snap->ps.clientNum) {
;1043:			int orderTask = CG_ValidOrder(vchat->cmd);
;1044:			if (orderTask > 0) {
;1045:				cgs.acceptOrderTime = cg.time + 5000;
;1046:				Q_strncpyz(cgs.acceptVoice, vchat->cmd, sizeof(cgs.acceptVoice));
;1047:				cgs.acceptTask = orderTask;
;1048:				cgs.acceptLeader = vchat->clientNum;
;1049:			}
;1050:			// see if this was an order
;1051:			CG_ShowResponseHead();
;1052:		}
;1053:	}
;1054:	if (!vchat->voiceOnly && !cg_noVoiceText.integer) {
;1055:		CG_AddToTeamChat( vchat->message );
;1056:		CG_Printf( "%s\n", vchat->message );
;1057:	}
;1058:	voiceChatBuffer[cg.voiceChatBufferOut].snd = 0;
;1059:#endif
;1060:}
LABELV $663
endproc CG_PlayVoiceChat 0 0
export CG_PlayBufferedVoiceChats
proc CG_PlayBufferedVoiceChats 0 0
line 1067
;1061:
;1062:/*
;1063:=====================
;1064:CG_PlayBufferedVoieChats
;1065:=====================
;1066:*/
;1067:void CG_PlayBufferedVoiceChats( void ) {
line 1079
;1068:#ifdef MISSIONPACK
;1069:	if ( cg.voiceChatTime < cg.time ) {
;1070:		if (cg.voiceChatBufferOut != cg.voiceChatBufferIn && voiceChatBuffer[cg.voiceChatBufferOut].snd) {
;1071:			//
;1072:			CG_PlayVoiceChat(&voiceChatBuffer[cg.voiceChatBufferOut]);
;1073:			//
;1074:			cg.voiceChatBufferOut = (cg.voiceChatBufferOut + 1) % MAX_VOICECHATBUFFER;
;1075:			cg.voiceChatTime = cg.time + 1000;
;1076:		}
;1077:	}
;1078:#endif
;1079:}
LABELV $664
endproc CG_PlayBufferedVoiceChats 0 0
export CG_AddBufferedVoiceChat
proc CG_AddBufferedVoiceChat 0 0
line 1086
;1080:
;1081:/*
;1082:=====================
;1083:CG_AddBufferedVoiceChat
;1084:=====================
;1085:*/
;1086:void CG_AddBufferedVoiceChat( bufferedVoiceChat_t *vchat ) {
line 1100
;1087:#ifdef MISSIONPACK
;1088:	// if we are going into the intermission, don't start any voices
;1089:	if ( cg.intermissionStarted ) {
;1090:		return;
;1091:	}
;1092:
;1093:	memcpy(&voiceChatBuffer[cg.voiceChatBufferIn], vchat, sizeof(bufferedVoiceChat_t));
;1094:	cg.voiceChatBufferIn = (cg.voiceChatBufferIn + 1) % MAX_VOICECHATBUFFER;
;1095:	if (cg.voiceChatBufferIn == cg.voiceChatBufferOut) {
;1096:		CG_PlayVoiceChat( &voiceChatBuffer[cg.voiceChatBufferOut] );
;1097:		cg.voiceChatBufferOut++;
;1098:	}
;1099:#endif
;1100:}
LABELV $665
endproc CG_AddBufferedVoiceChat 0 0
export CG_VoiceChatLocal
proc CG_VoiceChatLocal 0 0
line 1107
;1101:
;1102:/*
;1103:=================
;1104:CG_VoiceChatLocal
;1105:=================
;1106:*/
;1107:void CG_VoiceChatLocal( int mode, qboolean voiceOnly, int clientNum, int color, const char *cmd ) {
line 1148
;1108:#ifdef MISSIONPACK
;1109:	char *chat;
;1110:	voiceChatList_t *voiceChatList;
;1111:	clientInfo_t *ci;
;1112:	sfxHandle_t snd;
;1113:	bufferedVoiceChat_t vchat;
;1114:
;1115:	// if we are going into the intermission, don't start any voices
;1116:	if ( cg.intermissionStarted ) {
;1117:		return;
;1118:	}
;1119:
;1120:	if ( mode == SAY_ALL && CG_IsATeamGametype(cgs.gametype) && cg_teamChatsOnly.integer ) {
;1121:		return;
;1122:	}
;1123:
;1124:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
;1125:		clientNum = 0;
;1126:	}
;1127:	ci = &cgs.clientinfo[ clientNum ];
;1128:
;1129:	cgs.currentVoiceClient = clientNum;
;1130:
;1131:	voiceChatList = CG_VoiceChatListForClient( clientNum );
;1132:
;1133:	if ( CG_GetVoiceChat( voiceChatList, cmd, &snd, &chat ) ) {
;1134:		vchat.clientNum = clientNum;
;1135:		vchat.snd = snd;
;1136:		vchat.voiceOnly = voiceOnly;
;1137:		Q_strncpyz(vchat.cmd, cmd, sizeof(vchat.cmd));
;1138:		if ( mode == SAY_TELL ) {
;1139:			Com_sprintf(vchat.message, sizeof(vchat.message), "[%s]: %c%c%s", ci->name, Q_COLOR_ESCAPE, color, chat);
;1140:		} else if ( mode == SAY_TEAM ) {
;1141:			Com_sprintf(vchat.message, sizeof(vchat.message), "(%s): %c%c%s", ci->name, Q_COLOR_ESCAPE, color, chat);
;1142:		} else {
;1143:			Com_sprintf(vchat.message, sizeof(vchat.message), "%s: %c%c%s", ci->name, Q_COLOR_ESCAPE, color, chat);
;1144:		}
;1145:		CG_AddBufferedVoiceChat(&vchat);
;1146:	}
;1147:#endif
;1148:}
LABELV $666
endproc CG_VoiceChatLocal 0 0
export CG_VoiceChat
proc CG_VoiceChat 0 0
line 1155
;1149:
;1150:/*
;1151:=================
;1152:CG_VoiceChat
;1153:=================
;1154:*/
;1155:void CG_VoiceChat( int mode ) {
line 1176
;1156:#ifdef MISSIONPACK
;1157:	const char *cmd;
;1158:	int clientNum, color;
;1159:	qboolean voiceOnly;
;1160:
;1161:	voiceOnly = atoi(CG_Argv(1));
;1162:	clientNum = atoi(CG_Argv(2));
;1163:	color = atoi(CG_Argv(3));
;1164:	cmd = CG_Argv(4);
;1165:
;1166:	if (cg_noTaunt.integer != 0) {
;1167:		if (strequals(cmd, VOICECHAT_KILLINSULT)  || strequals(cmd, VOICECHAT_TAUNT) || 
;1168:			strequals(cmd, VOICECHAT_DEATHINSULT) || strequals(cmd, VOICECHAT_KILLGAUNTLET) || 
;1169:			strequals(cmd, VOICECHAT_PRAISE)) {
;1170:			return;
;1171:		}
;1172:	}
;1173:
;1174:	CG_VoiceChatLocal( mode, voiceOnly, clientNum, color, cmd );
;1175:#endif
;1176:}
LABELV $667
endproc CG_VoiceChat 0 0
proc CG_RemoveChatEscapeChar 16 0
line 1183
;1177:
;1178:/*
;1179:=================
;1180:CG_RemoveChatEscapeChar
;1181:=================
;1182:*/
;1183:static void CG_RemoveChatEscapeChar( char *text ) {
line 1186
;1184:	int i, l;
;1185:
;1186:	l = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1187
;1187:	for ( i = 0; text[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $672
JUMPV
LABELV $669
line 1188
;1188:		if (text[i] == '\x19')
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 25
NEI4 $673
line 1189
;1189:			continue;
ADDRGP4 $670
JUMPV
LABELV $673
line 1190
;1190:		text[l++] = text[i];
ADDRLP4 8
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 1191
;1191:	}
LABELV $670
line 1187
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $672
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $669
line 1192
;1192:	text[l] = '\0';
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1193
;1193:}
LABELV $668
endproc CG_RemoveChatEscapeChar 16 0
proc CG_ServerCommand 1300 12
line 1203
;1194:
;1195:/*
;1196:=================
;1197:CG_ServerCommand
;1198:
;1199:The string has been tokenized and can be retrieved with
;1200:Cmd_Argc() / Cmd_Argv()
;1201:=================
;1202:*/
;1203:static void CG_ServerCommand( void ) {
line 1207
;1204:	const char	*cmd;
;1205:	char		text[MAX_SAY_TEXT];
;1206:
;1207:	cmd = CG_Argv(0);
CNSTI4 0
ARGI4
ADDRLP4 156
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
line 1209
;1208:
;1209:	if ( !cmd[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $676
line 1211
;1210:		// server claimed the command
;1211:		return;
ADDRGP4 $675
JUMPV
LABELV $676
line 1214
;1212:	}
;1213:
;1214:	if ( strequals( cmd, "cp" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $680
ARGP4
ADDRLP4 160
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $678
line 1215
;1215:		CG_CenterPrint( CG_Argv(1), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
CNSTI4 1
ARGI4
ADDRLP4 164
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 164
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 1216
;1216:		return;
ADDRGP4 $675
JUMPV
LABELV $678
line 1219
;1217:	}
;1218:
;1219:	if ( strequals( cmd, "cs" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $683
ARGP4
ADDRLP4 164
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $681
line 1220
;1220:		CG_ConfigStringModified();
ADDRGP4 CG_ConfigStringModified
CALLV
pop
line 1221
;1221:		return;
ADDRGP4 $675
JUMPV
LABELV $681
line 1224
;1222:	}
;1223:
;1224:	if ( strequals( cmd, "print" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $686
ARGP4
ADDRLP4 168
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $684
line 1225
;1225:		CG_Printf( "%s", CG_Argv(1) );
CNSTI4 1
ARGI4
ADDRLP4 172
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRGP4 $519
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1235
;1226:#ifdef MISSIONPACK
;1227:		cmd = CG_Argv(1);			// yes, this is obviously a hack, but so is the way we hear about
;1228:									// votes passing or failing
;1229:		if ( Q_strequaln( cmd, "vote failed", 11 ) || Q_strequaln( cmd, "team vote failed", 16 )) {
;1230:			trap_S_StartLocalSound( cgs.media.voteFailed, CHAN_ANNOUNCER );
;1231:		} else if ( Q_strequaln( cmd, "vote passed", 11 ) || Q_strequaln( cmd, "team vote passed", 16 ) ) {
;1232:			trap_S_StartLocalSound( cgs.media.votePassed, CHAN_ANNOUNCER );
;1233:		}
;1234:#endif
;1235:		return;
ADDRGP4 $675
JUMPV
LABELV $684
line 1238
;1236:	}
;1237:
;1238:	if ( strequals( cmd, "chat" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $689
ARGP4
ADDRLP4 172
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $687
line 1239
;1239:		if ( CG_IsATeamGametype(cgs.gametype) && cg_teamChatsOnly.integer ) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 180
CNSTI4 0
ASGNI4
ADDRLP4 176
INDIRI4
ADDRLP4 180
INDIRI4
EQI4 $690
ADDRGP4 cg_teamChatsOnly+12
INDIRI4
ADDRLP4 180
INDIRI4
EQI4 $690
line 1240
;1240:			return;
ADDRGP4 $675
JUMPV
LABELV $690
line 1242
;1241:		}
;1242:		if( cg_chatBeep.integer ) {
ADDRGP4 cg_chatBeep+12
INDIRI4
CNSTI4 0
EQI4 $694
line 1243
;1243:			trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+180268+1092
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1244
;1244:		}
LABELV $694
line 1245
;1245:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+180268+1092
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1246
;1246:		Q_strncpyz( text, CG_Argv(1), MAX_SAY_TEXT );
CNSTI4 1
ARGI4
ADDRLP4 184
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 184
INDIRP4
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1247
;1247:		CG_RemoveChatEscapeChar( text );
ADDRLP4 4
ARGP4
ADDRGP4 CG_RemoveChatEscapeChar
CALLV
pop
line 1248
;1248:		CG_Printf( "%s\n", text );
ADDRGP4 $701
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1249
;1249:		return;
ADDRGP4 $675
JUMPV
LABELV $687
line 1252
;1250:	}
;1251:
;1252:	if ( strequals( cmd, "tchat" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $704
ARGP4
ADDRLP4 176
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $702
line 1253
;1253:		if( cg_teamChatBeep.integer ) {
ADDRGP4 cg_teamChatBeep+12
INDIRI4
CNSTI4 0
EQI4 $705
line 1254
;1254:			trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+180268+1092
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1255
;1255:		}
LABELV $705
line 1256
;1256:		Q_strncpyz( text, CG_Argv(1), MAX_SAY_TEXT );
CNSTI4 1
ARGI4
ADDRLP4 180
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1257
;1257:		CG_RemoveChatEscapeChar( text );
ADDRLP4 4
ARGP4
ADDRGP4 CG_RemoveChatEscapeChar
CALLV
pop
line 1258
;1258:		CG_AddToTeamChat( text );
ADDRLP4 4
ARGP4
ADDRGP4 CG_AddToTeamChat
CALLV
pop
line 1259
;1259:		CG_Printf( "%s\n", text );
ADDRGP4 $701
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1260
;1260:		return;
ADDRGP4 $675
JUMPV
LABELV $702
line 1262
;1261:	}
;1262:	if ( strequals( cmd, "vchat" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $712
ARGP4
ADDRLP4 180
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $710
line 1263
;1263:		CG_VoiceChat( SAY_ALL );
CNSTI4 0
ARGI4
ADDRGP4 CG_VoiceChat
CALLV
pop
line 1264
;1264:		return;
ADDRGP4 $675
JUMPV
LABELV $710
line 1267
;1265:	}
;1266:
;1267:	if ( strequals( cmd, "vtchat" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $715
ARGP4
ADDRLP4 184
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
NEI4 $713
line 1268
;1268:		CG_VoiceChat( SAY_TEAM );
CNSTI4 1
ARGI4
ADDRGP4 CG_VoiceChat
CALLV
pop
line 1269
;1269:		return;
ADDRGP4 $675
JUMPV
LABELV $713
line 1272
;1270:	}
;1271:
;1272:	if ( strequals( cmd, "vtell" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $718
ARGP4
ADDRLP4 188
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
NEI4 $716
line 1273
;1273:		CG_VoiceChat( SAY_TELL );
CNSTI4 2
ARGI4
ADDRGP4 CG_VoiceChat
CALLV
pop
line 1274
;1274:		return;
ADDRGP4 $675
JUMPV
LABELV $716
line 1277
;1275:	}
;1276:
;1277:	if ( strequals( cmd, "scores" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $721
ARGP4
ADDRLP4 192
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $719
line 1278
;1278:		CG_ParseScores();
ADDRGP4 CG_ParseScores
CALLV
pop
line 1279
;1279:		return;
ADDRGP4 $675
JUMPV
LABELV $719
line 1283
;1280:	}
;1281:
;1282:
;1283:	if ( strequals( cmd, "accs" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $724
ARGP4
ADDRLP4 196
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
NEI4 $722
line 1284
;1284:		CG_ParseAccuracy();
ADDRGP4 CG_ParseAccuracy
CALLV
pop
line 1285
;1285:		return;
ADDRGP4 $675
JUMPV
LABELV $722
line 1289
;1286:	}
;1287:
;1288:
;1289:	if ( strequals( cmd, "ddTakeAt" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $727
ARGP4
ADDRLP4 200
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
NEI4 $725
line 1290
;1290:		CG_ParseDDtimetakeAt();
ADDRGP4 CG_ParseDDtimetakeAt
CALLV
pop
line 1291
;1291:		return;
ADDRGP4 $675
JUMPV
LABELV $725
line 1294
;1292:	}
;1293:
;1294:	if ( strequals( cmd, "dompointnames" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $730
ARGP4
ADDRLP4 204
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
NEI4 $728
line 1295
;1295:		CG_ParseDomPointNames();
ADDRGP4 CG_ParseDomPointNames
CALLV
pop
line 1296
;1296:		return;
ADDRGP4 $675
JUMPV
LABELV $728
line 1299
;1297:	}
;1298:
;1299:	if ( strequals( cmd, "domStatus" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $733
ARGP4
ADDRLP4 208
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
NEI4 $731
line 1300
;1300:		CG_ParseDomStatus();
ADDRGP4 CG_ParseDomStatus
CALLV
pop
line 1301
;1301:		return;
ADDRGP4 $675
JUMPV
LABELV $731
line 1304
;1302:	}
;1303:
;1304:	if ( strequals( cmd, "elimination" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $736
ARGP4
ADDRLP4 212
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
NEI4 $734
line 1305
;1305:		CG_ParseElimination();
ADDRGP4 CG_ParseElimination
CALLV
pop
line 1306
;1306:		return;
ADDRGP4 $675
JUMPV
LABELV $734
line 1309
;1307:	}
;1308:
;1309:	if ( strequals( cmd, "mappage" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $739
ARGP4
ADDRLP4 216
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
NEI4 $737
line 1310
;1310:		CG_ParseMappage();
ADDRGP4 CG_ParseMappage
CALLV
pop
line 1311
;1311:		return;
ADDRGP4 $675
JUMPV
LABELV $737
line 1314
;1312:	}
;1313:
;1314:	if ( strequals( cmd, "attackingteam" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $742
ARGP4
ADDRLP4 220
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 0
NEI4 $740
line 1315
;1315:		CG_ParseAttackingTeam();
ADDRGP4 CG_ParseAttackingTeam
CALLV
pop
line 1316
;1316:		return;
ADDRGP4 $675
JUMPV
LABELV $740
line 1319
;1317:	}
;1318:
;1319:	if ( strequals( cmd, "tinfo" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $745
ARGP4
ADDRLP4 224
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $743
line 1320
;1320:		CG_ParseTeamInfo();
ADDRGP4 CG_ParseTeamInfo
CALLV
pop
line 1321
;1321:		return;
ADDRGP4 $675
JUMPV
LABELV $743
line 1324
;1322:	}
;1323:
;1324:	if ( strequals( cmd, "map_restart" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $748
ARGP4
ADDRLP4 228
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 228
INDIRI4
CNSTI4 0
NEI4 $746
line 1325
;1325:		CG_MapRestart();
ADDRGP4 CG_MapRestart
CALLV
pop
line 1326
;1326:		return;
ADDRGP4 $675
JUMPV
LABELV $746
line 1329
;1327:	}
;1328:
;1329:	if ( Q_strequal (cmd, "remapShader") )
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $751
ARGP4
ADDRLP4 232
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
NEI4 $749
line 1330
;1330:	{
line 1331
;1331:		if (trap_Argc() == 4)
ADDRLP4 236
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 4
NEI4 $675
line 1332
;1332:		{
line 1337
;1333:			char shader1[MAX_QPATH];
;1334:			char shader2[MAX_QPATH];
;1335:			char shader3[MAX_QPATH];
;1336:
;1337:			Q_strncpyz(shader1, CG_Argv(1), sizeof(shader1));
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 240
ARGP4
ADDRLP4 432
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1338
;1338:			Q_strncpyz(shader2, CG_Argv(2), sizeof(shader2));
CNSTI4 2
ARGI4
ADDRLP4 436
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 304
ARGP4
ADDRLP4 436
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1339
;1339:			Q_strncpyz(shader3, CG_Argv(3), sizeof(shader3));
CNSTI4 3
ARGI4
ADDRLP4 440
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 368
ARGP4
ADDRLP4 440
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1341
;1340:
;1341:			trap_R_RemapShader(shader1, shader2, shader3);
ADDRLP4 240
ARGP4
ADDRLP4 304
ARGP4
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_RemapShader
CALLV
pop
line 1342
;1342:		}
line 1344
;1343:		
;1344:		return;
ADDRGP4 $675
JUMPV
LABELV $749
line 1348
;1345:	}
;1346:
;1347:	// loaddeferred can be both a servercmd and a consolecmd
;1348:	if ( strequals( cmd, "loaddefered" ) ) {	// FIXME: spelled wrong, but not changing for demo
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $756
ARGP4
ADDRLP4 236
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 0
NEI4 $754
line 1349
;1349:		CG_LoadDeferredPlayers();
ADDRGP4 CG_LoadDeferredPlayers
CALLV
pop
line 1350
;1350:		return;
ADDRGP4 $675
JUMPV
LABELV $754
line 1355
;1351:	}
;1352:
;1353:	// clientLevelShot is sent before taking a special screenshot for
;1354:	// the menu system during development
;1355:	if ( strequals( cmd, "clientLevelShot" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $759
ARGP4
ADDRLP4 240
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 240
INDIRI4
CNSTI4 0
NEI4 $757
line 1356
;1356:		cg.levelShot = qtrue;
ADDRGP4 cg+12
CNSTI4 1
ASGNI4
line 1357
;1357:		return;
ADDRGP4 $675
JUMPV
LABELV $757
line 1361
;1358:	}
;1359:
;1360:	// challenge completed is determened by the server. A client should consider this message valid:
;1361:	if ( strequals( cmd, "ch" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $763
ARGP4
ADDRLP4 244
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 0
NEI4 $761
line 1362
;1362:		CG_ParseChallenge();
ADDRGP4 CG_ParseChallenge
CALLV
pop
line 1363
;1363:		return;
ADDRGP4 $675
JUMPV
LABELV $761
line 1366
;1364:	}
;1365:
;1366:	if ( strequals (cmd, "oh") ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $766
ARGP4
ADDRLP4 248
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 0
NEI4 $764
line 1367
;1367:		CG_ParseObeliskHealth();
ADDRGP4 CG_ParseObeliskHealth
CALLV
pop
line 1368
;1368:		return;
ADDRGP4 $675
JUMPV
LABELV $764
line 1371
;1369:	}
;1370:
;1371:	if ( strequals( cmd, "respawn" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $769
ARGP4
ADDRLP4 252
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 252
INDIRI4
CNSTI4 0
NEI4 $767
line 1372
;1372:		CG_ParseRespawnTime();
ADDRGP4 CG_ParseRespawnTime
CALLV
pop
line 1373
;1373:		return;
ADDRGP4 $675
JUMPV
LABELV $767
line 1376
;1374:	}
;1375:
;1376:	if ( strequals( cmd, "team" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $772
ARGP4
ADDRLP4 256
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
NEI4 $770
line 1377
;1377:		CG_ParseTeam();
ADDRGP4 CG_ParseTeam
CALLV
pop
line 1378
;1378:		return;
ADDRGP4 $675
JUMPV
LABELV $770
line 1381
;1379:	}
;1380:	
;1381:		if ( strequals ( cmd, "weaponProperties" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $775
ARGP4
ADDRLP4 260
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $773
line 1382
;1382:        CG_ParseWeaponProperties();
ADDRGP4 CG_ParseWeaponProperties
CALLV
pop
line 1383
;1383:        return;
ADDRGP4 $675
JUMPV
LABELV $773
line 1386
;1384:    }
;1385:
;1386:	if ( strequals( cmd, "customvotes" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $778
ARGP4
ADDRLP4 264
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $776
line 1390
;1387:		char infoString[1024];
;1388:		int i;
;1389:		//TODO: Create a ParseCustomvotes function
;1390:		memset(&infoString,0,sizeof(infoString));
ADDRLP4 268
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1391
;1391:		for(i=1;i<=12;i++) {
ADDRLP4 1292
CNSTI4 1
ASGNI4
LABELV $779
line 1392
;1392:			Q_strcat(infoString,sizeof(infoString),CG_Argv( i ));
ADDRLP4 1292
INDIRI4
ARGI4
ADDRLP4 1296
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 268
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1296
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1393
;1393:			Q_strcat(infoString,sizeof(infoString)," ");
ADDRLP4 268
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $783
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1394
;1394:		}
LABELV $780
line 1391
ADDRLP4 1292
ADDRLP4 1292
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1292
INDIRI4
CNSTI4 12
LEI4 $779
line 1395
;1395:		trap_Cvar_Set("cg_vote_custom_commands",infoString);
ADDRGP4 $784
ARGP4
ADDRLP4 268
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1396
;1396:		return;
ADDRGP4 $675
JUMPV
LABELV $776
line 1399
;1397:	}
;1398:
;1399:	CG_Printf( "Unknown client game command: %s\n", cmd );
ADDRGP4 $785
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1400
;1400:}
LABELV $675
endproc CG_ServerCommand 1300 12
export CG_ExecuteNewServerCommands
proc CG_ExecuteNewServerCommands 12 4
line 1411
;1401:
;1402:
;1403:/*
;1404:====================
;1405:CG_ExecuteNewServerCommands
;1406:
;1407:Execute all of the server commands that were received along
;1408:with this this snapshot.
;1409:====================
;1410:*/
;1411:void CG_ExecuteNewServerCommands( int latestSequence ) {
ADDRGP4 $788
JUMPV
LABELV $787
line 1412
;1412:	while ( cgs.serverCommandSequence < latestSequence ) {
line 1413
;1413:		if ( trap_GetServerCommand( ++cgs.serverCommandSequence ) ) {
ADDRLP4 0
ADDRGP4 cgs+31444
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_GetServerCommand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $791
line 1414
;1414:			CG_ServerCommand();
ADDRGP4 CG_ServerCommand
CALLV
pop
line 1415
;1415:		}
LABELV $791
line 1416
;1416:	}
LABELV $788
line 1412
ADDRGP4 cgs+31444
INDIRI4
ADDRFP4 0
INDIRI4
LTI4 $787
line 1417
;1417:}
LABELV $786
endproc CG_ExecuteNewServerCommands 12 4
bss
export voiceChatBuffer
align 4
LABELV voiceChatBuffer
skip 9984
export headModelVoiceChat
align 4
LABELV headModelVoiceChat
skip 4352
export voiceChatLists
align 4
LABELV voiceChatLists
skip 2263616
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
LABELV $785
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $784
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
LABELV $783
byte 1 32
byte 1 0
align 1
LABELV $778
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $775
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 80
byte 1 114
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $772
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $769
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $766
byte 1 111
byte 1 104
byte 1 0
align 1
LABELV $763
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $759
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
LABELV $756
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
LABELV $751
byte 1 114
byte 1 101
byte 1 109
byte 1 97
byte 1 112
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $748
byte 1 109
byte 1 97
byte 1 112
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
LABELV $745
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 0
align 1
LABELV $742
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $739
byte 1 109
byte 1 97
byte 1 112
byte 1 112
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $736
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
LABELV $733
byte 1 100
byte 1 111
byte 1 109
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $730
byte 1 100
byte 1 111
byte 1 109
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $727
byte 1 100
byte 1 100
byte 1 84
byte 1 97
byte 1 107
byte 1 101
byte 1 65
byte 1 116
byte 1 0
align 1
LABELV $724
byte 1 97
byte 1 99
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $721
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $718
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $715
byte 1 118
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $712
byte 1 118
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $704
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $701
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $689
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $686
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $683
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $680
byte 1 99
byte 1 112
byte 1 0
align 1
LABELV $629
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 118
byte 1 99
byte 1 0
align 1
LABELV $611
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $577
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $575
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 53
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $573
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 52
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $571
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 51
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $569
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 50
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $567
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 49
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $565
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 51
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $563
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 50
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $562
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 49
byte 1 46
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $552
byte 1 125
byte 1 0
align 1
LABELV $544
byte 1 94
byte 1 49
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 123
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
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
LABELV $543
byte 1 123
byte 1 0
align 1
LABELV $535
byte 1 94
byte 1 49
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 103
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 114
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
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
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
LABELV $534
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $531
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $528
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $519
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $518
byte 1 94
byte 1 49
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $515
byte 1 94
byte 1 49
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
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
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $508
byte 1 48
byte 1 0
align 1
LABELV $507
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
LABELV $506
byte 1 70
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 33
byte 1 0
align 1
LABELV $495
byte 1 67
byte 1 71
byte 1 95
byte 1 77
byte 1 97
byte 1 112
byte 1 82
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $360
byte 1 64
byte 1 0
align 1
LABELV $357
byte 1 58
byte 1 0
align 1
LABELV $354
byte 1 61
byte 1 0
align 1
LABELV $320
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
LABELV $319
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
LABELV $317
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 103
byte 1 72
byte 1 105
byte 1 116
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $313
byte 1 103
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $309
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $307
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $304
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $303
byte 1 103
byte 1 95
byte 1 97
byte 1 108
byte 1 116
byte 1 69
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
LABELV $301
byte 1 103
byte 1 95
byte 1 108
byte 1 109
byte 1 115
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $299
byte 1 103
byte 1 95
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
LABELV $298
byte 1 103
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 116
byte 1 103
byte 1 105
byte 1 98
byte 1 0
align 1
LABELV $297
byte 1 103
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $295
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
byte 1 95
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $293
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
LABELV $291
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $289
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $287
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $285
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $283
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $281
byte 1 118
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $279
byte 1 100
byte 1 109
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $276
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $275
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
LABELV $261
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
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
byte 1 100
byte 1 0
align 1
LABELV $253
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 58
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
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
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $240
byte 1 99
byte 1 108
byte 1 95
byte 1 118
byte 1 111
byte 1 105
byte 1 112
byte 1 83
byte 1 101
byte 1 110
byte 1 100
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $197
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $196
byte 1 45
byte 1 45
byte 1 45
byte 1 0
align 1
LABELV $180
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 112
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 0
