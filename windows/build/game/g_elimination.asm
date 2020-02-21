code
proc CloseEliminationDoors 16 12
file "../../../code/game/g_elimination.c"
line 26
;1:/*
;2:===========================================================================
;3:Copyright (C) 2008-2016 Poul Sander
;4:
;5:This file is part of Open Arena source code.
;6:
;7:Open Arena source code is free software; you can redistribute it
;8:and/or modify it under the terms of the GNU General Public License as
;9:published by the Free Software Foundation; either version 2 of the License,
;10:or (at your option) any later version.
;11:
;12:Open Arena source code is distributed in the hope that it will be
;13:useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;14:MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;15:GNU General Public License for more details.
;16:
;17:You should have received a copy of the GNU General Public License
;18:along with Open Arena source code; if not, write to the Free Software
;19:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;20:===========================================================================
;21:*/
;22:
;23:#include "g_local.h"
;24:
;25:
;26:static void CloseEliminationDoors( void ) {
line 28
;27:	gentity_t* next;
;28:	next = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 29
;29:	for (next = G_Find(next, FOFS(classname), "func_door"); next ; next = G_Find(next, FOFS(classname), "func_door") ) {
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $65
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $64
JUMPV
LABELV $61
line 30
;30:		if ( strequals(next->targetname, ELIMINATION_ACTIVE_TARGETNAME) ) {
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $66
line 31
;31:			if (next->moverState != MOVER_2TO1 && next->moverState != MOVER_POS1 ) {
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 3
EQI4 $69
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $69
line 32
;32:				MatchTeam(next, MOVER_2TO1, level.time);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRGP4 MatchTeam
CALLV
pop
line 33
;33:			}
LABELV $69
line 34
;34:		}
LABELV $66
line 35
;35:	}
LABELV $62
line 29
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $65
ARGP4
ADDRLP4 8
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
LABELV $64
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $61
line 36
;36:}
LABELV $60
endproc CloseEliminationDoors 16 12
proc CloseEliminationDoorsInstantly 12 12
line 38
;37:
;38:static void CloseEliminationDoorsInstantly( void ) {
line 40
;39:	gentity_t* next;
;40:	next = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 41
;41:	for (next = G_Find(next, FOFS(classname), "func_door"); next ; next = G_Find(next, FOFS(classname), "func_door") ) {
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $65
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $76
JUMPV
LABELV $73
line 42
;42:		if ( strequals(next->targetname, ELIMINATION_ACTIVE_TARGETNAME) ) {
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $77
line 43
;43:			if ( next->moverState != MOVER_POS1 ) {
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
EQI4 $79
line 44
;44:				MatchTeam(next, MOVER_POS1, level.time);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRGP4 MatchTeam
CALLV
pop
line 45
;45:			}
LABELV $79
line 46
;46:		}
LABELV $77
line 47
;47:	}
LABELV $74
line 41
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $65
ARGP4
ADDRLP4 8
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
LABELV $76
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $73
line 48
;48:}
LABELV $72
endproc CloseEliminationDoorsInstantly 12 12
proc OpenEliminationDoors 16 12
line 50
;49:
;50:static void OpenEliminationDoors( void ) {
line 52
;51:	gentity_t* next;
;52:	next = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 53
;53:	for (next = G_Find(next, FOFS(classname), "func_door"); next ; next = G_Find(next, FOFS(classname), "func_door") ) {
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $65
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $86
JUMPV
LABELV $83
line 54
;54:		if ( strequals(next->targetname, ELIMINATION_ACTIVE_TARGETNAME) ) {
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $87
line 55
;55:			if (next->moverState != MOVER_1TO2 && next->moverState != MOVER_POS2 ) {
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $89
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $89
line 56
;56:				MatchTeam(next, MOVER_1TO2, level.time);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRGP4 MatchTeam
CALLV
pop
line 57
;57:			}
LABELV $89
line 58
;58:		}
LABELV $87
line 59
;59:	}
LABELV $84
line 53
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $65
ARGP4
ADDRLP4 8
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
LABELV $86
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $83
line 60
;60:}
LABELV $82
endproc OpenEliminationDoors 16 12
export SendAttackingTeamMessageToAllClients
proc SendAttackingTeamMessageToAllClients 4 4
line 70
;61:
;62:
;63:/*
;64:========================
;65:SendAttackingTeamMessageToAllClients
;66:
;67:Used for CTF Elimination oneway
;68:========================
;69:*/
;70:void SendAttackingTeamMessageToAllClients( void ) {
line 73
;71:	int		i;
;72:
;73:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $96
JUMPV
LABELV $93
line 74
;74:		if ( level.clients[ i ].pers.connected == CON_CONNECTED ) {
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $98
line 75
;75:			AttackingTeamMessage( g_entities + i );
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 AttackingTeamMessage
CALLV
pop
line 76
;76:		}
LABELV $98
line 77
;77:	}
LABELV $94
line 73
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $96
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $93
line 78
;78:}
LABELV $92
endproc SendAttackingTeamMessageToAllClients 4 4
export StartEliminationRound
proc StartEliminationRound 32 24
line 81
;79:
;80://the elimination start function
;81:void StartEliminationRound(void) {
line 84
;82:
;83:	int		countsLiving[TEAM_NUM_TEAMS];
;84:	countsLiving[TEAM_BLUE] = TeamLivingCount( -1, TEAM_BLUE );
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 TeamLivingCount
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
ASGNI4
line 85
;85:	countsLiving[TEAM_RED] = TeamLivingCount( -1, TEAM_RED );
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 TeamLivingCount
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 20
INDIRI4
ASGNI4
line 86
;86:	if((countsLiving[TEAM_BLUE]==0) || (countsLiving[TEAM_RED]==0))
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 0+8
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $107
ADDRLP4 0+4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $103
LABELV $107
line 87
;87:	{
line 88
;88:		trap_SendServerCommand( -1, "print \"Not enough players to start the round\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $108
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 89
;89:		level.roundNumberStarted = level.roundNumber-1;
ADDRGP4 level+9240
ADDRGP4 level+9236
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 90
;90:		level.roundRespawned = qfalse;
ADDRGP4 level+9252
CNSTI4 0
ASGNI4
line 92
;91:		//Remember that one of the teams is empty!
;92:		level.roundRedPlayers = countsLiving[TEAM_RED];
ADDRGP4 level+9244
ADDRLP4 0+4
INDIRI4
ASGNI4
line 93
;93:		level.roundBluePlayers = countsLiving[TEAM_BLUE];
ADDRGP4 level+9248
ADDRLP4 0+8
INDIRI4
ASGNI4
line 94
;94:		level.roundStartTime = level.time+1000*g_elimination_warmup.integer;
ADDRGP4 level+9232
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 95
;95:		return;
ADDRGP4 $100
JUMPV
LABELV $103
line 99
;96:	}
;97:	
;98:	//If we are enough to start a round:
;99:	level.roundNumberStarted = level.roundNumber; //Set numbers
ADDRGP4 level+9240
ADDRGP4 level+9236
INDIRI4
ASGNI4
line 100
;100:	level.roundRedPlayers = countsLiving[TEAM_RED];
ADDRGP4 level+9244
ADDRLP4 0+4
INDIRI4
ASGNI4
line 101
;101:	level.roundBluePlayers = countsLiving[TEAM_BLUE];
ADDRGP4 level+9248
ADDRLP4 0+8
INDIRI4
ASGNI4
line 102
;102:	if(g_gametype.integer == GT_CTF_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $125
line 103
;103:		Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 104
;104:		Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 105
;105:	}
LABELV $125
line 106
;106:	if(g_gametype.integer == GT_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $128
line 107
;107:		G_LogPrintf( "ELIMINATION: %i %i %i: Round %i has started!\n", level.roundNumber, -1, 0, level.roundNumber );
ADDRGP4 $131
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 108
;108:	} else if(g_gametype.integer == GT_CTF_ELIMINATION) {
ADDRGP4 $129
JUMPV
LABELV $128
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $134
line 109
;109:		G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: Round %i has started!\n", level.roundNumber, -1, -1, 4, level.roundNumber );
ADDRGP4 $137
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRLP4 28
CNSTI4 -1
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 110
;110:	}
LABELV $134
LABELV $129
line 111
;111:	SendEliminationMessageToAllClients();
ADDRGP4 SendEliminationMessageToAllClients
CALLV
pop
line 112
;112:	if(g_elimination_ctf_oneway.integer)
ADDRGP4 g_elimination_ctf_oneway+12
INDIRI4
CNSTI4 0
EQI4 $140
line 113
;113:		SendAttackingTeamMessageToAllClients(); //Ensure that evaryone know who should attack.
ADDRGP4 SendAttackingTeamMessageToAllClients
CALLV
pop
LABELV $140
line 114
;114:	EnableWeapons();
ADDRGP4 EnableWeapons
CALLV
pop
line 115
;115:	OpenEliminationDoors();
ADDRGP4 OpenEliminationDoors
CALLV
pop
line 116
;116:}
LABELV $100
endproc StartEliminationRound 32 24
export EndEliminationRound
proc EndEliminationRound 4 0
line 120
;117:
;118://things to do at end of round:
;119:void EndEliminationRound(void)
;120:{
line 121
;121:	DisableWeapons();
ADDRGP4 DisableWeapons
CALLV
pop
line 122
;122:	CloseEliminationDoors();
ADDRGP4 CloseEliminationDoors
CALLV
pop
line 123
;123:	level.roundNumber++;
ADDRLP4 0
ADDRGP4 level+9236
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 124
;124:	level.roundStartTime = level.time+1000*g_elimination_warmup.integer;
ADDRGP4 level+9232
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 125
;125:	SendEliminationMessageToAllClients();
ADDRGP4 SendEliminationMessageToAllClients
CALLV
pop
line 126
;126:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 127
;127:	level.roundRespawned = qfalse;
ADDRGP4 level+9252
CNSTI4 0
ASGNI4
line 128
;128:	if(g_elimination_ctf_oneway.integer)
ADDRGP4 g_elimination_ctf_oneway+12
INDIRI4
CNSTI4 0
EQI4 $149
line 129
;129:		SendAttackingTeamMessageToAllClients();
ADDRGP4 SendAttackingTeamMessageToAllClients
CALLV
pop
LABELV $149
line 130
;130:}
LABELV $143
endproc EndEliminationRound 4 0
export RestartEliminationRound
proc RestartEliminationRound 0 0
line 133
;131:
;132://Things to do if we don't want to move the roundNumber
;133:void RestartEliminationRound(void) {
line 134
;134:	DisableWeapons();
ADDRGP4 DisableWeapons
CALLV
pop
line 135
;135:	CloseEliminationDoors();
ADDRGP4 CloseEliminationDoors
CALLV
pop
line 136
;136:	level.roundNumberStarted = level.roundNumber-1;
ADDRGP4 level+9240
ADDRGP4 level+9236
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 137
;137:	level.roundStartTime = level.time+1000*g_elimination_warmup.integer;
ADDRGP4 level+9232
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 138
;138:	if(!level.intermissiontime)
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
NEI4 $158
line 139
;139:		SendEliminationMessageToAllClients();
ADDRGP4 SendEliminationMessageToAllClients
CALLV
pop
LABELV $158
line 140
;140:	level.roundRespawned = qfalse;
ADDRGP4 level+9252
CNSTI4 0
ASGNI4
line 141
;141:	if(g_elimination_ctf_oneway.integer)
ADDRGP4 g_elimination_ctf_oneway+12
INDIRI4
CNSTI4 0
EQI4 $162
line 142
;142:		SendAttackingTeamMessageToAllClients();
ADDRGP4 SendAttackingTeamMessageToAllClients
CALLV
pop
LABELV $162
line 143
;143:}
LABELV $152
endproc RestartEliminationRound 0 0
export WarmupEliminationRound
proc WarmupEliminationRound 0 0
line 146
;144:
;145://Things to do during match warmup
;146:void WarmupEliminationRound(void) {
line 147
;147:	EnableWeapons();
ADDRGP4 EnableWeapons
CALLV
pop
line 149
;148:	//OpenEliminationDoors();
;149:	level.roundNumberStarted = level.roundNumber-1;
ADDRGP4 level+9240
ADDRGP4 level+9236
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 150
;150:	level.roundStartTime = level.time+1000*g_elimination_warmup.integer;
ADDRGP4 level+9232
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 151
;151:	SendEliminationMessageToAllClients();
ADDRGP4 SendEliminationMessageToAllClients
CALLV
pop
line 152
;152:	level.roundRespawned = qfalse;
ADDRGP4 level+9252
CNSTI4 0
ASGNI4
line 153
;153:	if(g_elimination_ctf_oneway.integer)
ADDRGP4 g_elimination_ctf_oneway+12
INDIRI4
CNSTI4 0
EQI4 $172
line 154
;154:		SendAttackingTeamMessageToAllClients();
ADDRGP4 SendAttackingTeamMessageToAllClients
CALLV
pop
LABELV $172
line 155
;155:}
LABELV $165
endproc WarmupEliminationRound 0 0
export StartLMSRound
proc StartLMSRound 8 20
line 159
;156:
;157:
;158://LMS - Last man Stading functions:
;159:void StartLMSRound(void) {
line 161
;160:	int		countsLiving;
;161:	countsLiving = TeamLivingCount( -1, TEAM_FREE );
CNSTI4 -1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 TeamLivingCount
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 162
;162:	if(countsLiving<2) {
ADDRLP4 0
INDIRI4
CNSTI4 2
GEI4 $176
line 163
;163:		trap_SendServerCommand( -1, "print \"Not enough players to start the round\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $108
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 164
;164:		level.roundNumberStarted = level.roundNumber-1;
ADDRGP4 level+9240
ADDRGP4 level+9236
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 165
;165:		level.roundStartTime = level.time+1000*g_elimination_warmup.integer;
ADDRGP4 level+9232
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 166
;166:		return;
ADDRGP4 $175
JUMPV
LABELV $176
line 170
;167:	}
;168:
;169:	//If we are enough to start a round:
;170:	level.roundNumberStarted = level.roundNumber; //Set numbers
ADDRGP4 level+9240
ADDRGP4 level+9236
INDIRI4
ASGNI4
line 172
;171:
;172:	G_LogPrintf( "LMS: %i %i %i: Round %i has started!\n", level.roundNumber, -1, 0, level.roundNumber );
ADDRGP4 $185
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 174
;173:
;174:	SendEliminationMessageToAllClients();
ADDRGP4 SendEliminationMessageToAllClients
CALLV
pop
line 175
;175:	EnableWeapons();
ADDRGP4 EnableWeapons
CALLV
pop
line 176
;176:}
LABELV $175
endproc StartLMSRound 8 20
export CheckElimination
proc CheckElimination 116 28
line 183
;177:
;178:/*
;179:=============
;180:CheckElimination
;181:=============
;182:*/
;183:void CheckElimination(void) {
line 190
;184:	int counts[TEAM_NUM_TEAMS];
;185:	int countsLiving[TEAM_NUM_TEAMS];
;186:	int countsHealth[TEAM_NUM_TEAMS];
;187:	int countLivingHumans;
;188:	int countHumans;
;189:
;190:	if ( level.numPlayingClients < 1 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 1
GEI4 $189
line 191
;191:		if( G_IsARoundBasedGametype(g_gametype.integer) && G_IsATeamGametype(g_gametype.integer) && ( level.time+1000*g_elimination_warmup.integer-500>level.roundStartTime )) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $188
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $188
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
CNSTI4 500
SUBI4
ADDRGP4 level+9232
INDIRI4
LEI4 $188
line 192
;192:			RestartEliminationRound(); //For spectators
ADDRGP4 RestartEliminationRound
CALLV
pop
line 193
;193:		}
line 194
;194:		return;
ADDRGP4 $188
JUMPV
LABELV $189
line 198
;195:	}	
;196:
;197:	//We don't want to do anything in itnermission
;198:	if(level.intermissiontime) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $199
line 199
;199:		if(level.roundRespawned) {
ADDRGP4 level+9252
INDIRI4
CNSTI4 0
EQI4 $202
line 200
;200:			RestartEliminationRound();
ADDRGP4 RestartEliminationRound
CALLV
pop
line 201
;201:		}
LABELV $202
line 202
;202:		level.roundStartTime = level.time+1000*g_elimination_warmup.integer;
ADDRGP4 level+9232
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 203
;203:		return;
ADDRGP4 $188
JUMPV
LABELV $199
line 206
;204:	}	
;205:	
;206:	if(!(G_IsARoundBasedGametype(g_gametype.integer) && G_IsATeamGametype(g_gametype.integer))) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $212
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $208
LABELV $212
line 207
;207:		return;
ADDRGP4 $188
JUMPV
LABELV $208
line 211
;208:	}
;209:
;210:	
;211:	counts[TEAM_BLUE] = TeamCount( -1, TEAM_BLUE );
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 64
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 16+8
ADDRLP4 64
INDIRI4
ASGNI4
line 212
;212:	counts[TEAM_RED] = TeamCount( -1, TEAM_RED );
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 68
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 16+4
ADDRLP4 68
INDIRI4
ASGNI4
line 214
;213:
;214:	countsLiving[TEAM_BLUE] = TeamLivingCount( -1, TEAM_BLUE );
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 72
ADDRGP4 TeamLivingCount
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 72
INDIRI4
ASGNI4
line 215
;215:	countsLiving[TEAM_RED] = TeamLivingCount( -1, TEAM_RED );
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 76
ADDRGP4 TeamLivingCount
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 76
INDIRI4
ASGNI4
line 217
;216:
;217:	countsHealth[TEAM_BLUE] = TeamHealthCount( -1, TEAM_BLUE );
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 80
ADDRGP4 TeamHealthCount
CALLI4
ASGNI4
ADDRLP4 32+8
ADDRLP4 80
INDIRI4
ASGNI4
line 218
;218:	countsHealth[TEAM_RED] = TeamHealthCount( -1, TEAM_RED );
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 84
ADDRGP4 TeamHealthCount
CALLI4
ASGNI4
ADDRLP4 32+4
ADDRLP4 84
INDIRI4
ASGNI4
line 220
;219:
;220:	countHumans = TeamHumanParticipantsCount(-1);
CNSTI4 -1
ARGI4
ADDRLP4 88
ADDRGP4 TeamHumanParticipantsCount
CALLI4
ASGNI4
ADDRLP4 52
ADDRLP4 88
INDIRI4
ASGNI4
line 221
;221:	countLivingHumans = TeamLivingHumanCount(-1);
CNSTI4 -1
ARGI4
ADDRLP4 92
ADDRGP4 TeamLivingHumanCount
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 92
INDIRI4
ASGNI4
line 223
;222:
;223:	if (countLivingHumans == 0 && countHumans > 0) {
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 96
INDIRI4
NEI4 $219
ADDRLP4 52
INDIRI4
ADDRLP4 96
INDIRI4
LEI4 $219
line 224
;224:		level.humansEliminated = qtrue;
ADDRGP4 level+9260
CNSTI4 1
ASGNI4
line 225
;225:	}
ADDRGP4 $220
JUMPV
LABELV $219
line 226
;226:	else {
line 227
;227:		level.humansEliminated = qfalse;
ADDRGP4 level+9260
CNSTI4 0
ASGNI4
line 228
;228:	}
LABELV $220
line 230
;229:
;230:	if(level.roundBluePlayers != 0 && level.roundRedPlayers != 0) { //Cannot score if one of the team never got any living players
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRGP4 level+9248
INDIRI4
ADDRLP4 100
INDIRI4
EQI4 $223
ADDRGP4 level+9244
INDIRI4
ADDRLP4 100
INDIRI4
EQI4 $223
line 231
;231:		if((countsLiving[TEAM_BLUE]==0)&&(level.roundNumber==level.roundNumberStarted))
ADDRLP4 0+8
INDIRI4
CNSTI4 0
NEI4 $227
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $227
line 232
;232:		{
line 234
;233:			//Blue team has been eliminated!
;234:			trap_SendServerCommand( -1, "print \"Blue Team eliminated!\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $232
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 235
;235:			AddTeamScore(level.intermission_origin,TEAM_RED,1);
ADDRGP4 level+9160
ARGP4
ADDRLP4 104
CNSTI4 1
ASGNI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 236
;236:			if(g_gametype.integer == GT_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $234
line 237
;237:				G_LogPrintf( "ELIMINATION: %i %i %i: %s wins round %i by eleminating the enemy team!\n", level.roundNumber, TEAM_RED, 1, TeamName(TEAM_RED), level.roundNumber );
CNSTI4 1
ARGI4
ADDRLP4 108
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $237
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRLP4 112
CNSTI4 1
ASGNI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 238
;238:			} else {
ADDRGP4 $235
JUMPV
LABELV $234
line 239
;239:				G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s wins round %i by eleminating the enemy team!\n", level.roundNumber, -1, TEAM_RED, 6, TeamName(TEAM_RED), level.roundNumber );
CNSTI4 1
ARGI4
ADDRLP4 108
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $240
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 240
;240:			}
LABELV $235
line 241
;241:			EndEliminationRound();
ADDRGP4 EndEliminationRound
CALLV
pop
line 242
;242:			Team_ForceGesture(TEAM_RED);
CNSTI4 1
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 243
;243:		}
ADDRGP4 $228
JUMPV
LABELV $227
line 244
;244:		else if((countsLiving[TEAM_RED]==0)&&(level.roundNumber==level.roundNumberStarted))
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $243
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $243
line 245
;245:		{
line 247
;246:			//Red team eliminated!
;247:			trap_SendServerCommand( -1, "print \"Red Team eliminated!\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $248
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 248
;248:			AddTeamScore(level.intermission_origin,TEAM_BLUE,1);
ADDRGP4 level+9160
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 249
;249:			if(g_gametype.integer == GT_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $250
line 250
;250:				G_LogPrintf( "ELIMINATION: %i %i %i: %s wins round %i by eleminating the enemy team!\n", level.roundNumber, TEAM_BLUE, 1, TeamName(TEAM_BLUE), level.roundNumber );
CNSTI4 2
ARGI4
ADDRLP4 104
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $237
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 104
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 251
;251:			} else {
ADDRGP4 $251
JUMPV
LABELV $250
line 252
;252:				G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s wins round %i by eleminating the enemy team!\n", level.roundNumber, -1, TEAM_BLUE, 6, TeamName(TEAM_BLUE), level.roundNumber );
CNSTI4 2
ARGI4
ADDRLP4 104
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $240
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 104
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 253
;253:			}
LABELV $251
line 254
;254:			EndEliminationRound();
ADDRGP4 EndEliminationRound
CALLV
pop
line 255
;255:			Team_ForceGesture(TEAM_BLUE);
CNSTI4 2
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 256
;256:		}
LABELV $243
LABELV $228
line 257
;257:	}
LABELV $223
line 260
;258:
;259:	//Time up
;260:	if((level.roundNumber==level.roundNumberStarted)&&(g_elimination_roundtime.integer)&&(level.time>=level.roundStartTime+1000*g_elimination_roundtime.integer))
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $257
ADDRGP4 g_elimination_roundtime+12
INDIRI4
CNSTI4 0
EQI4 $257
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_roundtime+12
INDIRI4
MULI4
ADDI4
LTI4 $257
line 261
;261:	{
line 262
;262:		trap_SendServerCommand( -1, "print \"No teams eliminated.\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $265
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 264
;263:
;264:		if(level.roundBluePlayers != 0 && level.roundRedPlayers != 0) {//We don't want to divide by zero. (should not be possible)
ADDRLP4 104
CNSTI4 0
ASGNI4
ADDRGP4 level+9248
INDIRI4
ADDRLP4 104
INDIRI4
EQI4 $266
ADDRGP4 level+9244
INDIRI4
ADDRLP4 104
INDIRI4
EQI4 $266
line 265
;265:			if(g_gametype.integer == GT_CTF_ELIMINATION && g_elimination_ctf_oneway.integer) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $270
ADDRGP4 g_elimination_ctf_oneway+12
INDIRI4
CNSTI4 0
EQI4 $270
line 267
;266:				//One way CTF, make defensice team the winner.
;267:				if ( (level.eliminationSides+level.roundNumber)%2 == 0 ) { //Red was attacking
ADDRGP4 level+9256
INDIRI4
ADDRGP4 level+9236
INDIRI4
ADDI4
CNSTI4 2
MODI4
CNSTI4 0
NEI4 $274
line 268
;268:					trap_SendServerCommand( -1, "print \"Blue team defended the base\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $278
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 269
;269:					AddTeamScore(level.intermission_origin,TEAM_BLUE,1);
ADDRGP4 level+9160
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 270
;270:					G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s wins round %i by defending the flag!\n", level.roundNumber, -1, TEAM_BLUE, 5, TeamName(TEAM_BLUE), level.roundNumber );
CNSTI4 2
ARGI4
ADDRLP4 108
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $280
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 271
;271:				}
ADDRGP4 $271
JUMPV
LABELV $274
line 272
;272:				else {
line 273
;273:					trap_SendServerCommand( -1, "print \"Red team defended the base\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $283
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 274
;274:					AddTeamScore(level.intermission_origin,TEAM_RED,1);
ADDRGP4 level+9160
ARGP4
ADDRLP4 108
CNSTI4 1
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 275
;275:					G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s wins round %i by defending the flag!\n", level.roundNumber, -1, TEAM_RED, 5, TeamName(TEAM_RED), level.roundNumber );
CNSTI4 1
ARGI4
ADDRLP4 112
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $280
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 276
;276:				}
line 277
;277:			}
ADDRGP4 $271
JUMPV
LABELV $270
line 278
;278:			else if(((double)countsLiving[TEAM_RED])/((double)level.roundRedPlayers)>((double)countsLiving[TEAM_BLUE])/((double)level.roundBluePlayers))
ADDRLP4 0+4
INDIRI4
CVIF4 4
ADDRGP4 level+9244
INDIRI4
CVIF4 4
DIVF4
ADDRLP4 0+8
INDIRI4
CVIF4 4
ADDRGP4 level+9248
INDIRI4
CVIF4 4
DIVF4
LEF4 $287
line 279
;279:			{
line 281
;280:				//Red team has higher procentage survivors
;281:				trap_SendServerCommand( -1, "print \"Red team has most survivers!\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $293
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 282
;282:				AddTeamScore(level.intermission_origin,TEAM_RED,1);
ADDRGP4 level+9160
ARGP4
ADDRLP4 108
CNSTI4 1
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 283
;283:				if(g_gametype.integer == GT_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $295
line 284
;284:					G_LogPrintf( "ELIMINATION: %i %i %i: %s wins round %i due to more survivors!\n", level.roundNumber, TEAM_RED, 2, TeamName(TEAM_RED), level.roundNumber );
CNSTI4 1
ARGI4
ADDRLP4 112
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $298
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 285
;285:				} else {
ADDRGP4 $288
JUMPV
LABELV $295
line 286
;286:					G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s wins round %i due to more survivors!\n", level.roundNumber, -1, TEAM_RED, 7, TeamName(TEAM_RED), level.roundNumber );
CNSTI4 1
ARGI4
ADDRLP4 112
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $301
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
CNSTI4 7
ARGI4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 287
;287:				}
line 288
;288:			}
ADDRGP4 $288
JUMPV
LABELV $287
line 289
;289:			else if(((double)countsLiving[TEAM_RED])/((double)level.roundRedPlayers)<((double)countsLiving[TEAM_BLUE])/((double)level.roundBluePlayers))
ADDRLP4 0+4
INDIRI4
CVIF4 4
ADDRGP4 level+9244
INDIRI4
CVIF4 4
DIVF4
ADDRLP4 0+8
INDIRI4
CVIF4 4
ADDRGP4 level+9248
INDIRI4
CVIF4 4
DIVF4
GEF4 $304
line 290
;290:			{
line 292
;291:				//Blue team has higher procentage survivors
;292:				trap_SendServerCommand( -1, "print \"Blue team has most survivers!\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $310
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 293
;293:				AddTeamScore(level.intermission_origin,TEAM_BLUE,1);	
ADDRGP4 level+9160
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 294
;294:				if(g_gametype.integer == GT_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $312
line 295
;295:					G_LogPrintf( "ELIMINATION: %i %i %i: %s wins round %i due to more survivors!\n", level.roundNumber, TEAM_BLUE, 2, TeamName(TEAM_BLUE), level.roundNumber );
CNSTI4 2
ARGI4
ADDRLP4 108
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $298
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRLP4 112
CNSTI4 2
ASGNI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 296
;296:				} else {
ADDRGP4 $305
JUMPV
LABELV $312
line 297
;297:					G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s wins round %i due to more survivors!\n", level.roundNumber, -1, TEAM_BLUE, 7, TeamName(TEAM_BLUE), level.roundNumber );
CNSTI4 2
ARGI4
ADDRLP4 108
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $301
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
CNSTI4 7
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 298
;298:				}
line 299
;299:			}
ADDRGP4 $305
JUMPV
LABELV $304
line 300
;300:			else if(countsHealth[TEAM_RED]>countsHealth[TEAM_BLUE])
ADDRLP4 32+4
INDIRI4
ADDRLP4 32+8
INDIRI4
LEI4 $319
line 301
;301:			{
line 303
;302:				//Red team has more health
;303:				trap_SendServerCommand( -1, "print \"Red team has more health left!\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $323
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 304
;304:				AddTeamScore(level.intermission_origin,TEAM_RED,1);
ADDRGP4 level+9160
ARGP4
ADDRLP4 108
CNSTI4 1
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 305
;305:				if(g_gametype.integer == GT_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $325
line 306
;306:					G_LogPrintf( "ELIMINATION: %i %i %i: %s wins round %i due to more health left!\n", level.roundNumber, TEAM_RED, 3, TeamName(TEAM_RED), level.roundNumber );
CNSTI4 1
ARGI4
ADDRLP4 112
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $328
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 307
;307:				} else {
ADDRGP4 $320
JUMPV
LABELV $325
line 308
;308:					G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s wins round %i due to more health left!\n", level.roundNumber, -1, TEAM_RED, 8, TeamName(TEAM_RED), level.roundNumber );
CNSTI4 1
ARGI4
ADDRLP4 112
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $331
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
CNSTI4 8
ARGI4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 309
;309:				}
line 310
;310:			}
ADDRGP4 $320
JUMPV
LABELV $319
line 311
;311:			else if(countsHealth[TEAM_RED]<countsHealth[TEAM_BLUE])
ADDRLP4 32+4
INDIRI4
ADDRLP4 32+8
INDIRI4
GEI4 $334
line 312
;312:			{
line 314
;313:				//Blue team has more health
;314:				trap_SendServerCommand( -1, "print \"Blue team has more health left!\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $338
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 315
;315:				AddTeamScore(level.intermission_origin,TEAM_BLUE,1);
ADDRGP4 level+9160
ARGP4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 316
;316:				if(g_gametype.integer == GT_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $340
line 317
;317:					G_LogPrintf( "ELIMINATION: %i %i %i: %s wins round %i due to more health left!\n", level.roundNumber, TEAM_BLUE, 3, TeamName(TEAM_BLUE), level.roundNumber );
CNSTI4 2
ARGI4
ADDRLP4 108
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $328
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 318
;318:				} else {
ADDRGP4 $341
JUMPV
LABELV $340
line 319
;319:					G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: %s wins round %i due to more health left!\n", level.roundNumber, -1, TEAM_BLUE, 8, TeamName(TEAM_BLUE), level.roundNumber );
CNSTI4 2
ARGI4
ADDRLP4 108
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $331
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
CNSTI4 8
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 320
;320:				}
LABELV $341
line 321
;321:			}
LABELV $334
LABELV $320
LABELV $305
LABELV $288
LABELV $271
line 322
;322:		}
LABELV $266
line 324
;323:		//Draw
;324:		if(g_gametype.integer == GT_ELIMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $347
line 325
;325:			G_LogPrintf( "ELIMINATION: %i %i %i: Round %i ended in a draw!\n", level.roundNumber, -1, 4, level.roundNumber );
ADDRGP4 $350
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 326
;326:		} else {
ADDRGP4 $348
JUMPV
LABELV $347
line 327
;327:			G_LogPrintf( "CTF_ELIMINATION: %i %i %i %i: Round %i ended in a draw!\n", level.roundNumber, -1, -1, 9, level.roundNumber );
ADDRGP4 $353
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRLP4 108
CNSTI4 -1
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
CNSTI4 9
ARGI4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 328
;328:		}
LABELV $348
line 329
;329:		EndEliminationRound();
ADDRGP4 EndEliminationRound
CALLV
pop
line 330
;330:	}
LABELV $257
line 333
;331:
;332:	//This might be better placed another place:
;333:	if(g_elimination_activewarmup.integer<1)
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
CNSTI4 1
GEI4 $356
line 334
;334:		g_elimination_activewarmup.integer=1; //We need at least 1 second to spawn all players
ADDRGP4 g_elimination_activewarmup+12
CNSTI4 1
ASGNI4
LABELV $356
line 335
;335:	if(g_elimination_activewarmup.integer >= g_elimination_warmup.integer) //This must not be true
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
ADDRGP4 g_elimination_warmup+12
INDIRI4
LTI4 $360
line 336
;336:		g_elimination_warmup.integer = g_elimination_activewarmup.integer+1; //Increase warmup
ADDRGP4 g_elimination_warmup+12
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $360
line 339
;337:
;338:	//Force respawn
;339:	if(level.roundNumber!=level.roundNumberStarted && level.time>level.roundStartTime-1000*g_elimination_activewarmup.integer && !level.roundRespawned)
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
EQI4 $366
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
MULI4
SUBI4
LEI4 $366
ADDRGP4 level+9252
INDIRI4
CNSTI4 0
NEI4 $366
line 340
;340:	{
line 341
;341:		level.roundRespawned = qtrue;
ADDRGP4 level+9252
CNSTI4 1
ASGNI4
line 342
;342:		RespawnAll();
ADDRGP4 RespawnAll
CALLV
pop
line 343
;343:		CloseEliminationDoorsInstantly();
ADDRGP4 CloseEliminationDoorsInstantly
CALLV
pop
line 344
;344:		SendEliminationMessageToAllClients();
ADDRGP4 SendEliminationMessageToAllClients
CALLV
pop
line 345
;345:	}
LABELV $366
line 347
;346:
;347:	if(level.time<=level.roundStartTime && level.time>level.roundStartTime-1000*g_elimination_activewarmup.integer)
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
GTI4 $375
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
MULI4
SUBI4
LEI4 $375
line 348
;348:	{
line 349
;349:		RespawnDead();
ADDRGP4 RespawnDead
CALLV
pop
line 350
;350:	}
LABELV $375
line 353
;351:
;352:
;353:	if((level.roundNumber>level.roundNumberStarted)&&(level.time>=level.roundStartTime))
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
LEI4 $382
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
LTI4 $382
line 354
;354:		StartEliminationRound();
ADDRGP4 StartEliminationRound
CALLV
pop
LABELV $382
line 356
;355:
;356:	if(level.time+1000*g_elimination_warmup.integer-500>level.roundStartTime) {
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
CNSTI4 500
SUBI4
ADDRGP4 level+9232
INDIRI4
LEI4 $388
line 357
;357:		if(counts[TEAM_BLUE]<1 || counts[TEAM_RED]<1) {
ADDRLP4 104
CNSTI4 1
ASGNI4
ADDRLP4 16+8
INDIRI4
ADDRLP4 104
INDIRI4
LTI4 $397
ADDRLP4 16+4
INDIRI4
ADDRLP4 104
INDIRI4
GEI4 $393
LABELV $397
line 358
;358:			RespawnDead(); //Allow players to run around anyway
ADDRGP4 RespawnDead
CALLV
pop
line 359
;359:			OpenEliminationDoors();
ADDRGP4 OpenEliminationDoors
CALLV
pop
line 360
;360:			WarmupEliminationRound(); //Start over
ADDRGP4 WarmupEliminationRound
CALLV
pop
line 361
;361:			return;
ADDRGP4 $188
JUMPV
LABELV $393
line 363
;362:		}
;363:	}
LABELV $388
line 365
;364:
;365:	if(level.warmupTime != 0) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $398
line 366
;366:		if(level.time+1000*g_elimination_warmup.integer-500>level.roundStartTime)
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
CNSTI4 500
SUBI4
ADDRGP4 level+9232
INDIRI4
LEI4 $401
line 367
;367:		{
line 368
;368:			RespawnDead();
ADDRGP4 RespawnDead
CALLV
pop
line 369
;369:			WarmupEliminationRound();
ADDRGP4 WarmupEliminationRound
CALLV
pop
line 370
;370:		}
LABELV $401
line 371
;371:	}
LABELV $398
line 372
;372:}
LABELV $188
endproc CheckElimination 116 28
export CheckLMS
proc CheckLMS 44 8
line 379
;373:
;374:
;375:/*
;376:CheckLMS
;377:*/
;378:
;379:void CheckLMS(void) {
line 384
;380:	int mode;
;381:	int countsLiving[TEAM_NUM_TEAMS];
;382:	int countHumans;
;383:	int countLivingHumans;
;384:	mode = g_lms_mode.integer;
ADDRLP4 16
ADDRGP4 g_lms_mode+12
INDIRI4
ASGNI4
line 385
;385:	if ( level.numPlayingClients < 1 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 1
GEI4 $408
line 386
;386:		return;
ADDRGP4 $406
JUMPV
LABELV $408
line 390
;387:	}
;388:
;389:	//We don't want to do anything in intermission
;390:	if(level.intermissiontime) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $411
line 391
;391:		if(level.roundRespawned) {
ADDRGP4 level+9252
INDIRI4
CNSTI4 0
EQI4 $414
line 392
;392:			RestartEliminationRound();
ADDRGP4 RestartEliminationRound
CALLV
pop
line 393
;393:		}
LABELV $414
line 394
;394:		level.roundStartTime = level.time; //so that a player might join at any time to fix the bots+no humans+autojoin bug
ADDRGP4 level+9232
ADDRGP4 level+32
INDIRI4
ASGNI4
line 395
;395:		return;
ADDRGP4 $406
JUMPV
LABELV $411
line 398
;396:	}
;397:	
;398:	if (g_gametype.integer != GT_LMS) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
EQI4 $419
line 399
;399:		return;
ADDRGP4 $406
JUMPV
LABELV $419
line 403
;400:	}
;401:	
;402:	//trap_SendServerCommand( -1, "print \"This is LMS!\n\"");
;403:	countsLiving[TEAM_FREE] = TeamLivingCount( -1, TEAM_FREE );
CNSTI4 -1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 28
ADDRGP4 TeamLivingCount
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 28
INDIRI4
ASGNI4
line 405
;404:
;405:	countHumans = TeamHumanParticipantsCount(-1);
CNSTI4 -1
ARGI4
ADDRLP4 32
ADDRGP4 TeamHumanParticipantsCount
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 32
INDIRI4
ASGNI4
line 406
;406:	countLivingHumans = TeamLivingHumanCount(-1);
CNSTI4 -1
ARGI4
ADDRLP4 36
ADDRGP4 TeamLivingHumanCount
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 408
;407:
;408:	if (countLivingHumans == 0 && countHumans > 0) {
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $422
ADDRLP4 20
INDIRI4
ADDRLP4 40
INDIRI4
LEI4 $422
line 409
;409:		level.humansEliminated = qtrue;
ADDRGP4 level+9260
CNSTI4 1
ASGNI4
line 410
;410:	}
ADDRGP4 $423
JUMPV
LABELV $422
line 411
;411:	else {
line 412
;412:		level.humansEliminated = qfalse;
ADDRGP4 level+9260
CNSTI4 0
ASGNI4
line 413
;413:	}
LABELV $423
line 415
;414:
;415:	if(countsLiving[TEAM_FREE]==1 && level.roundNumber==level.roundNumberStarted)
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $426
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $426
line 416
;416:	{
line 417
;417:		if(mode <=1 )
ADDRLP4 16
INDIRI4
CNSTI4 1
GTI4 $430
line 418
;418:		LMSpoint();
ADDRGP4 LMSpoint
CALLV
pop
LABELV $430
line 419
;419:		trap_SendServerCommand( -1, "print \"We have a winner!\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $432
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 420
;420:		EndEliminationRound();
ADDRGP4 EndEliminationRound
CALLV
pop
line 421
;421:		Team_ForceGesture(TEAM_FREE);
CNSTI4 0
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 422
;422:	}
LABELV $426
line 424
;423:
;424:	if(countsLiving[TEAM_FREE]==0 && level.roundNumber==level.roundNumberStarted)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $433
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $433
line 425
;425:	{
line 426
;426:		trap_SendServerCommand( -1, "print \"All death... how sad\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $437
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 427
;427:		EndEliminationRound();
ADDRGP4 EndEliminationRound
CALLV
pop
line 428
;428:	}
LABELV $433
line 430
;429:
;430:	if((g_elimination_roundtime.integer) && (level.roundNumber==level.roundNumberStarted)&&(g_lms_mode.integer == 1 || g_lms_mode.integer==3)&&(level.time>=level.roundStartTime+1000*g_elimination_roundtime.integer))
ADDRGP4 g_elimination_roundtime+12
INDIRI4
CNSTI4 0
EQI4 $438
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $438
ADDRGP4 g_lms_mode+12
INDIRI4
CNSTI4 1
EQI4 $448
ADDRGP4 g_lms_mode+12
INDIRI4
CNSTI4 3
NEI4 $438
LABELV $448
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_roundtime+12
INDIRI4
MULI4
ADDI4
LTI4 $438
line 431
;431:	{
line 432
;432:		trap_SendServerCommand( -1, "print \"Time up - Overtime disabled\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $449
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 433
;433:		if(mode <=1 )
ADDRLP4 16
INDIRI4
CNSTI4 1
GTI4 $450
line 434
;434:		LMSpoint();
ADDRGP4 LMSpoint
CALLV
pop
LABELV $450
line 435
;435:		EndEliminationRound();
ADDRGP4 EndEliminationRound
CALLV
pop
line 436
;436:	}
LABELV $438
line 439
;437:
;438:	//This might be better placed another place:
;439:	if(g_elimination_activewarmup.integer<2)
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
CNSTI4 2
GEI4 $452
line 440
;440:		g_elimination_activewarmup.integer=2; //We need at least 2 seconds to spawn all players
ADDRGP4 g_elimination_activewarmup+12
CNSTI4 2
ASGNI4
LABELV $452
line 441
;441:	if(g_elimination_activewarmup.integer >= g_elimination_warmup.integer) //This must not be true
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
ADDRGP4 g_elimination_warmup+12
INDIRI4
LTI4 $456
line 442
;442:		g_elimination_warmup.integer = g_elimination_activewarmup.integer+1; //Increase warmup
ADDRGP4 g_elimination_warmup+12
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $456
line 445
;443:
;444:	//Force respawn
;445:	if(level.roundNumber != level.roundNumberStarted && level.time>level.roundStartTime-1000*g_elimination_activewarmup.integer && !level.roundRespawned)
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
EQI4 $462
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
MULI4
SUBI4
LEI4 $462
ADDRGP4 level+9252
INDIRI4
CNSTI4 0
NEI4 $462
line 446
;446:	{
line 447
;447:		level.roundRespawned = qtrue;
ADDRGP4 level+9252
CNSTI4 1
ASGNI4
line 448
;448:		RespawnAll();
ADDRGP4 RespawnAll
CALLV
pop
line 449
;449:		DisableWeapons();
ADDRGP4 DisableWeapons
CALLV
pop
line 450
;450:		SendEliminationMessageToAllClients();
ADDRGP4 SendEliminationMessageToAllClients
CALLV
pop
line 451
;451:	}
LABELV $462
line 453
;452:
;453:	if(level.time<=level.roundStartTime && level.time>level.roundStartTime-1000*g_elimination_activewarmup.integer)
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
GTI4 $471
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
MULI4
SUBI4
LEI4 $471
line 454
;454:	{
line 455
;455:		RespawnDead();
ADDRGP4 RespawnDead
CALLV
pop
line 457
;456:		//DisableWeapons();
;457:	}
LABELV $471
line 459
;458:
;459:	if(level.roundNumber == level.roundNumberStarted)
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $478
line 460
;460:	{
line 461
;461:		EnableWeapons();
ADDRGP4 EnableWeapons
CALLV
pop
line 462
;462:	}
LABELV $478
line 464
;463:
;464:	if((level.roundNumber>level.roundNumberStarted)&&(level.time>=level.roundStartTime))
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
LEI4 $482
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
LTI4 $482
line 465
;465:		StartLMSRound();
ADDRGP4 StartLMSRound
CALLV
pop
LABELV $482
line 467
;466:
;467:	if(level.time+1000*g_elimination_warmup.integer-500>level.roundStartTime && level.numPlayingClients < 2)
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
CNSTI4 500
SUBI4
ADDRGP4 level+9232
INDIRI4
LEI4 $488
ADDRGP4 level+80
INDIRI4
CNSTI4 2
GEI4 $488
line 468
;468:	{
line 469
;469:		RespawnDead(); //Allow player to run around anyway
ADDRGP4 RespawnDead
CALLV
pop
line 470
;470:		WarmupEliminationRound(); //Start over
ADDRGP4 WarmupEliminationRound
CALLV
pop
line 471
;471:		return;
ADDRGP4 $406
JUMPV
LABELV $488
line 474
;472:	}
;473:
;474:	if(level.warmupTime != 0) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $494
line 475
;475:		if(level.time+1000*g_elimination_warmup.integer-500>level.roundStartTime)
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_warmup+12
INDIRI4
MULI4
ADDI4
CNSTI4 500
SUBI4
ADDRGP4 level+9232
INDIRI4
LEI4 $497
line 476
;476:		{
line 477
;477:			RespawnDead();
ADDRGP4 RespawnDead
CALLV
pop
line 478
;478:			WarmupEliminationRound();
ADDRGP4 WarmupEliminationRound
CALLV
pop
line 479
;479:		}
LABELV $497
line 480
;480:	}
LABELV $494
line 481
;481:}
LABELV $406
endproc CheckLMS 44 8
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
LABELV $449
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 45
byte 1 32
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $437
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 104
byte 1 111
byte 1 119
byte 1 32
byte 1 115
byte 1 97
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $432
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 87
byte 1 101
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 119
byte 1 105
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $353
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
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
byte 1 58
byte 1 32
byte 1 82
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $350
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 82
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $338
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $331
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
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
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 100
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $328
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 100
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $323
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $310
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $301
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
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
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 100
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 111
byte 1 114
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $298
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 100
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 111
byte 1 114
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $293
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $283
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $280
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
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
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 121
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
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $278
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $265
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 78
byte 1 111
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 32
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $248
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $240
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
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
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
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
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $237
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
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
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $232
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $185
byte 1 76
byte 1 77
byte 1 83
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 82
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $137
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
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
byte 1 58
byte 1 32
byte 1 82
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $131
byte 1 69
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 82
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $108
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
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
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $68
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
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $65
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
