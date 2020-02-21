export DeathmatchScoreboardMessage
code
proc DeathmatchScoreboardMessage 2084 72
file "../../../code/game/g_cmds.c"
line 33
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
;23:#include "g_local.h"
;24:
;25:#include "../../ui/menudef.h"
;26:
;27:/*
;28:==================
;29:DeathmatchScoreboardMessage
;30:
;31:==================
;32:*/
;33:void DeathmatchScoreboardMessage( gentity_t *ent ) {
line 42
;34:	char		entry[1024];
;35:	char		string[1000];
;36:	int			stringlength;
;37:	int			i, j;
;38:	gclient_t	*cl;
;39:	int			numSorted, scoreFlags, accuracy, perfect;
;40:
;41:	// don't send scores to bots, they don't parse it
;42:	if ( ent->r.svFlags & SVF_BOT ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $61
line 43
;43:		return;
ADDRGP4 $60
JUMPV
LABELV $61
line 47
;44:	}
;45:
;46:	// send the latest information on all clients
;47:	string[0] = 0;
ADDRLP4 1048
CNSTI1 0
ASGNI1
line 48
;48:	stringlength = 0;
ADDRLP4 1032
CNSTI4 0
ASGNI4
line 49
;49:	scoreFlags = 0;
ADDRLP4 2052
CNSTI4 0
ASGNI4
line 51
;50:
;51:	numSorted = level.numConnectedClients;
ADDRLP4 2048
ADDRGP4 level+72
INDIRI4
ASGNI4
line 53
;52:	
;53:	for (i=0 ; i < numSorted ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $67
JUMPV
LABELV $64
line 56
;54:		int		ping;
;55:
;56:		cl = &level.clients[level.sortedClients[i]];
ADDRLP4 0
CNSTI4 2116
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 58
;57:
;58:		if ( cl->pers.connected == CON_CONNECTING ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $69
line 59
;59:			ping = -1;
ADDRLP4 2056
CNSTI4 -1
ASGNI4
line 60
;60:		} else {
ADDRGP4 $70
JUMPV
LABELV $69
line 63
;61://unlagged - true ping
;62:			//ping = cl->ps.ping < 999 ? cl->ps.ping : 999;
;63:			ping = cl->pers.realPing < 999 ? cl->pers.realPing : 999;
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 999
GEI4 $72
ADDRLP4 2060
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $73
JUMPV
LABELV $72
ADDRLP4 2060
CNSTI4 999
ASGNI4
LABELV $73
ADDRLP4 2056
ADDRLP4 2060
INDIRI4
ASGNI4
line 65
;64://unlagged - true ping
;65:		}
LABELV $70
line 67
;66:
;67:		if( cl->accuracy_shots ) {
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $74
line 68
;68:			accuracy = cl->accuracy_hits * 100 / cl->accuracy_shots;
ADDRLP4 1040
CNSTI4 100
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
DIVI4
ASGNI4
line 69
;69:		}
ADDRGP4 $75
JUMPV
LABELV $74
line 70
;70:		else {
line 71
;71:			accuracy = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 72
;72:		}
LABELV $75
line 73
;73:		perfect = ( cl->ps.persistant[PERS_RANK] == 0 && cl->ps.persistant[PERS_KILLED] == 0 ) ? 1 : 0;
ADDRLP4 2068
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ADDRLP4 2068
INDIRI4
NEI4 $77
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRLP4 2068
INDIRI4
NEI4 $77
ADDRLP4 2060
CNSTI4 1
ASGNI4
ADDRGP4 $78
JUMPV
LABELV $77
ADDRLP4 2060
CNSTI4 0
ASGNI4
LABELV $78
ADDRLP4 1044
ADDRLP4 2060
INDIRI4
ASGNI4
line 75
;74:
;75:		if(g_gametype.integer == GT_LMS) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
NEI4 $79
line 76
;76:			Com_sprintf (entry, sizeof(entry),
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $82
ARGP4
ADDRLP4 2076
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 2076
INDIRI4
ADDRGP4 level+84
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 2056
INDIRI4
ARGI4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
SUBI4
CNSTI4 60000
DIVI4
ARGI4
ADDRLP4 2052
INDIRI4
ARGI4
CNSTI4 816
ADDRLP4 2076
INDIRI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+188
ADDP4
INDIRI4
ARGI4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ARGI4
ADDRLP4 1044
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $88
ADDRLP4 2072
CNSTI4 0
ASGNI4
ADDRGP4 $89
JUMPV
LABELV $88
ADDRLP4 2072
CNSTI4 1
ASGNI4
LABELV $89
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
ADDRLP4 2072
INDIRI4
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 88
;77:				" %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i", level.sortedClients[i],
;78:				cl->ps.persistant[PERS_SCORE], ping, (level.time - cl->pers.enterTime)/60000,
;79:				scoreFlags, g_entities[level.sortedClients[i]].s.powerups, accuracy, 
;80:				cl->ps.persistant[PERS_IMPRESSIVE_COUNT],
;81:				cl->ps.persistant[PERS_EXCELLENT_COUNT],
;82:				cl->ps.persistant[PERS_GAUNTLET_FRAG_COUNT], 
;83:				cl->ps.persistant[PERS_DEFEND_COUNT], 
;84:				cl->ps.persistant[PERS_ASSIST_COUNT], 
;85:				perfect,
;86:				cl->ps.persistant[PERS_CAPTURES],
;87:				cl->pers.livesLeft + (cl->isEliminated?0:1));
;88:		}
ADDRGP4 $80
JUMPV
LABELV $79
line 89
;89:		else {
line 90
;90:			Com_sprintf (entry, sizeof(entry),
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $82
ARGP4
ADDRLP4 2072
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 2072
INDIRI4
ADDRGP4 level+84
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 2056
INDIRI4
ARGI4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
SUBI4
CNSTI4 60000
DIVI4
ARGI4
ADDRLP4 2052
INDIRI4
ARGI4
CNSTI4 816
ADDRLP4 2072
INDIRI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+188
ADDP4
INDIRI4
ARGI4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ARGI4
ADDRLP4 1044
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 102
;91:				" %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i", level.sortedClients[i],
;92:				cl->ps.persistant[PERS_SCORE], ping, (level.time - cl->pers.enterTime)/60000,
;93:				scoreFlags, g_entities[level.sortedClients[i]].s.powerups, accuracy, 
;94:				cl->ps.persistant[PERS_IMPRESSIVE_COUNT],
;95:				cl->ps.persistant[PERS_EXCELLENT_COUNT],
;96:				cl->ps.persistant[PERS_GAUNTLET_FRAG_COUNT], 
;97:				cl->ps.persistant[PERS_DEFEND_COUNT], 
;98:				cl->ps.persistant[PERS_ASSIST_COUNT], 
;99:				perfect,
;100:				cl->ps.persistant[PERS_CAPTURES],
;101:				cl->isEliminated);
;102:		}
LABELV $80
line 103
;103:		j = strlen(entry);
ADDRLP4 8
ARGP4
ADDRLP4 2072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 2072
INDIRI4
ASGNI4
line 104
;104:		if (stringlength + j > 1024)
ADDRLP4 1032
INDIRI4
ADDRLP4 1036
INDIRI4
ADDI4
CNSTI4 1024
LEI4 $94
line 105
;105:			break;
ADDRGP4 $66
JUMPV
LABELV $94
line 106
;106:		strcpy (string + stringlength, entry);
ADDRLP4 1032
INDIRI4
ADDRLP4 1048
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 107
;107:		stringlength += j;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
ADDRLP4 1036
INDIRI4
ADDI4
ASGNI4
line 108
;108:	}
LABELV $65
line 53
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $67
ADDRLP4 4
INDIRI4
ADDRLP4 2048
INDIRI4
LTI4 $64
LABELV $66
line 110
;109:
;110:	trap_SendServerCommand( ent-g_entities, va("scores %i %i %i %i%s", i, 
ADDRGP4 $96
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 level+44+4
INDIRI4
ARGI4
ADDRGP4 level+44+8
INDIRI4
ARGI4
ADDRGP4 level+9232
INDIRI4
ARGI4
ADDRLP4 1048
ARGP4
ADDRLP4 2056
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 2056
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 113
;111:		level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE], level.roundStartTime,
;112:		string ) );
;113:}
LABELV $60
endproc DeathmatchScoreboardMessage 2084 72
export G_SendWeaponProperties
proc G_SendWeaponProperties 2052 32
line 115
;114:
;115:void G_SendWeaponProperties(gentity_t *ent) {
line 117
;116:	char string[2048];
;117:	Com_sprintf(string, sizeof(string), "%i %i %i %i %i",
ADDRLP4 0
ARGP4
CNSTI4 2048
ARGI4
ADDRGP4 $103
ARGP4
ADDRGP4 mod_sgspread
INDIRI4
ARGI4
ADDRGP4 mod_sgcount
INDIRI4
ARGI4
ADDRGP4 mod_lgrange
INDIRI4
ARGI4
ADDRGP4 mod_mgspread
INDIRI4
ARGI4
ADDRGP4 mod_cgspread
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 119
;118:	            mod_sgspread, mod_sgcount, mod_lgrange, mod_mgspread, mod_cgspread);
;119:	trap_SendServerCommand(ent-g_entities, va( "weaponProperties %s", string));
ADDRGP4 $104
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 2048
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 2048
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 120
;120:}
LABELV $102
endproc G_SendWeaponProperties 2052 32
export AccMessage
proc AccMessage 1036 108
line 129
;121:
;122:
;123:/*
;124:==================
;125:AccMessage
;126:
;127:==================
;128:*/
;129:void AccMessage( gentity_t *ent ) {
line 132
;130:	char		entry[1024];
;131:
;132:	Com_sprintf (entry, sizeof(entry),
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $106
ARGP4
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 2020
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2024
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2028
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2032
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2036
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2040
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2048
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2052
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2056
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2060
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2064
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2068
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2072
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2076
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2080
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
CNSTI4 0
ASGNI4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2092
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2096
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2108
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
CNSTI4 2112
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 148
;133:			" %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i ",
;134:			ent->client->accuracy[WP_MACHINEGUN][0], ent->client->accuracy[WP_MACHINEGUN][1],
;135:			ent->client->accuracy[WP_SHOTGUN][0], ent->client->accuracy[WP_SHOTGUN][1],
;136:			ent->client->accuracy[WP_GRENADE_LAUNCHER][0], ent->client->accuracy[WP_GRENADE_LAUNCHER][1],
;137:			ent->client->accuracy[WP_ROCKET_LAUNCHER][0], ent->client->accuracy[WP_ROCKET_LAUNCHER][1],
;138:			ent->client->accuracy[WP_LIGHTNING][0], ent->client->accuracy[WP_LIGHTNING][1],
;139:			ent->client->accuracy[WP_RAILGUN][0], ent->client->accuracy[WP_RAILGUN][1],
;140:			ent->client->accuracy[WP_PLASMAGUN][0], ent->client->accuracy[WP_PLASMAGUN][1],
;141:			ent->client->accuracy[WP_BFG][0], ent->client->accuracy[WP_BFG][1],
;142:			0,0, //Hook
;143:			ent->client->accuracy[WP_NAILGUN][0], ent->client->accuracy[WP_NAILGUN][1],
;144:			0,0,
;145:			ent->client->accuracy[WP_CHAINGUN][0], ent->client->accuracy[WP_CHAINGUN][1]
;146:		);
;147:
;148:	trap_SendServerCommand( ent-g_entities, va("accs%s", entry ));
ADDRGP4 $107
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1032
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 149
;149:}
LABELV $105
endproc AccMessage 1036 108
export DominationPointStatusMessage
proc DominationPointStatusMessage 104 16
line 158
;150:
;151:
;152:/*
;153:==================
;154:DominationPointStatusMessage
;155:
;156:==================
;157:*/
;158:void DominationPointStatusMessage( gentity_t *ent ) {
line 164
;159:	char		entry[10]; //Will more likely be 2... in fact cannot be more since we are the server
;160:	char		string[10*(MAX_DOMINATION_POINTS+1)];
;161:	int			stringlength;
;162:	int i, j;
;163:
;164:	string[0] = 0;
ADDRLP4 24
CNSTI1 0
ASGNI1
line 165
;165:	stringlength = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 167
;166:
;167:	for(i = 0;i<MAX_DOMINATION_POINTS && i<level.domination_points_count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $112
JUMPV
LABELV $109
line 168
;168:		Com_sprintf (entry, sizeof(entry)," %i",level.pointStatusDom[i]);
ADDRLP4 4
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $114
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9284
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 169
;169:		j = strlen(entry);
ADDRLP4 4
ARGP4
ADDRLP4 96
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 96
INDIRI4
ASGNI4
line 170
;170:		if (stringlength + j > 10*MAX_DOMINATION_POINTS)
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
CNSTI4 60
LEI4 $116
line 171
;171:			break;
ADDRGP4 $111
JUMPV
LABELV $116
line 172
;172:		strcpy (string + stringlength, entry);
ADDRLP4 16
INDIRI4
ADDRLP4 24
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 173
;173:		stringlength += j;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ASGNI4
line 174
;174:	}
LABELV $110
line 167
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $112
ADDRLP4 0
INDIRI4
CNSTI4 6
GEI4 $118
ADDRLP4 0
INDIRI4
ADDRGP4 level+9312
INDIRI4
LTI4 $109
LABELV $118
LABELV $111
line 176
;175:
;176:	trap_SendServerCommand( ent-g_entities, va("domStatus %i%s", level.domination_points_count, string ) );
ADDRGP4 $119
ARGP4
ADDRGP4 level+9312
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 100
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 177
;177:}
LABELV $108
endproc DominationPointStatusMessage 104 16
export EliminationMessage
proc EliminationMessage 4 16
line 186
;178:
;179:/*
;180:==================
;181:EliminationMessage
;182:
;183:==================
;184:*/
;185:
;186:void EliminationMessage(gentity_t *ent) {
line 187
;187:	trap_SendServerCommand( ent-g_entities, va("elimination %i %i %i", 
ADDRGP4 $122
ARGP4
ADDRGP4 level+44+4
INDIRI4
ARGI4
ADDRGP4 level+44+8
INDIRI4
ARGI4
ADDRGP4 level+9232
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 189
;188:		level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE], level.roundStartTime) );
;189:}
LABELV $121
endproc EliminationMessage 4 16
export RespawnTimeMessage
proc RespawnTimeMessage 4 8
line 191
;190:
;191:void RespawnTimeMessage(gentity_t *ent, int time) {
line 192
;192:    trap_SendServerCommand( ent-g_entities, va("respawn %i", time) );
ADDRGP4 $129
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 193
;193:}
LABELV $128
endproc RespawnTimeMessage 4 8
export DoubleDominationScoreTimeMessage
proc DoubleDominationScoreTimeMessage 4 8
line 201
;194:
;195:/*
;196:==================
;197:DoubleDominationScoreTime
;198:
;199:==================
;200:*/
;201:void DoubleDominationScoreTimeMessage( gentity_t *ent ) {
line 202
;202:	trap_SendServerCommand( ent-g_entities, va("ddTakeAt %i", level.timeTaken + g_ddCaptureTime.integer*1000));
ADDRGP4 $131
ARGP4
ADDRGP4 level+9272
INDIRI4
CNSTI4 1000
ADDRGP4 g_ddCaptureTime+12
INDIRI4
MULI4
ADDI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 203
;203:}
LABELV $130
endproc DoubleDominationScoreTimeMessage 4 8
export DominationPointNamesMessage
proc DominationPointNamesMessage 140 12
line 211
;204:
;205:/*
;206:==================
;207:DominationPointNames
;208:==================
;209:*/
;210:
;211:void DominationPointNamesMessage( gentity_t *ent ) {
line 215
;212:	char text[MAX_DOMINATION_POINTS_NAMES*MAX_DOMINATION_POINTS];
;213:	int i,j;	
;214:	qboolean nullFound;
;215:	for(i=0;i<MAX_DOMINATION_POINTS;i++) {
ADDRLP4 124
CNSTI4 0
ASGNI4
LABELV $135
line 216
;216:		Q_strncpyz(text+i*MAX_DOMINATION_POINTS_NAMES,level.domination_points_names[i],MAX_DOMINATION_POINTS_NAMES-1);
ADDRLP4 132
CNSTI4 20
ADDRLP4 124
INDIRI4
MULI4
ASGNI4
ADDRLP4 132
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 132
INDIRI4
ADDRGP4 level+9316
ADDP4
ARGP4
CNSTI4 19
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 217
;217:		if(i!=MAX_DOMINATION_POINTS-1) {
ADDRLP4 124
INDIRI4
CNSTI4 5
EQI4 $140
line 219
;218:			//Don't allow "/0"!
;219:			nullFound = qfalse;
ADDRLP4 128
CNSTI4 0
ASGNI4
line 220
;220:			for(j=i*MAX_DOMINATION_POINTS_NAMES; j<(i+1)*MAX_DOMINATION_POINTS_NAMES;j++) {
ADDRLP4 0
CNSTI4 20
ADDRLP4 124
INDIRI4
MULI4
ASGNI4
ADDRGP4 $145
JUMPV
LABELV $142
line 221
;221:				if(text[j]==0)
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $146
line 222
;222:					nullFound = qtrue;
ADDRLP4 128
CNSTI4 1
ASGNI4
LABELV $146
line 223
;223:				if(nullFound)
ADDRLP4 128
INDIRI4
CNSTI4 0
EQI4 $148
line 224
;224:					text[j] = ' ';
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 32
ASGNI1
LABELV $148
line 225
;225:			}
LABELV $143
line 220
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $145
ADDRLP4 136
CNSTI4 20
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 136
INDIRI4
ADDRLP4 124
INDIRI4
MULI4
ADDRLP4 136
INDIRI4
ADDI4
LTI4 $142
line 226
;226:		}
LABELV $140
line 227
;227:		text[MAX_DOMINATION_POINTS_NAMES*MAX_DOMINATION_POINTS-2]=0x19;
ADDRLP4 4+118
CNSTI1 25
ASGNI1
line 228
;228:		text[MAX_DOMINATION_POINTS_NAMES*MAX_DOMINATION_POINTS-1]=0;
ADDRLP4 4+119
CNSTI1 0
ASGNI1
line 229
;229:	}
LABELV $136
line 215
ADDRLP4 124
ADDRLP4 124
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 6
LTI4 $135
line 230
;230:	trap_SendServerCommand( ent-g_entities, va("dompointnames %i \"%s\"", level.domination_points_count, text));
ADDRGP4 $152
ARGP4
ADDRGP4 level+9312
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 132
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 231
;231:}
LABELV $134
endproc DominationPointNamesMessage 140 12
export YourTeamMessage
proc YourTeamMessage 16 8
line 239
;232:
;233:/*
;234:==================
;235:YourTeamMessage
;236:==================
;237:*/
;238:
;239:void YourTeamMessage( const gentity_t *ent) {
line 240
;240:	int team = level.clients[ent-g_entities].sess.sessionTeam;
ADDRLP4 0
CNSTI4 2116
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 242
;241:
;242:	switch(team) {
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $157
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $160
ADDRGP4 $155
JUMPV
LABELV $157
line 244
;243:		case TEAM_RED:
;244:			trap_SendServerCommand( ent-g_entities, va("team \"%s\"", g_redTeamClientNumbers.string));
ADDRGP4 $158
ARGP4
ADDRGP4 g_redTeamClientNumbers+16
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 245
;245:			break;
ADDRGP4 $156
JUMPV
LABELV $160
line 247
;246:		case TEAM_BLUE:
;247:			trap_SendServerCommand( ent-g_entities, va("team \"%s\"", g_blueTeamClientNumbers.string));
ADDRGP4 $158
ARGP4
ADDRGP4 g_blueTeamClientNumbers+16
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 248
;248:			break;
ADDRGP4 $156
JUMPV
LABELV $155
line 250
;249:		default:
;250:			trap_SendServerCommand( ent-g_entities, "team \"all\"");
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $162
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 251
;251:	};
LABELV $156
line 252
;252:}
LABELV $154
endproc YourTeamMessage 16 8
export AttackingTeamMessage
proc AttackingTeamMessage 8 8
line 260
;253:
;254:/*
;255:==================
;256:AttackingTeamMessage
;257:
;258:==================
;259:*/
;260:void AttackingTeamMessage( gentity_t *ent ) {
line 262
;261:	int team;
;262:	if ( (level.eliminationSides+level.roundNumber)%2 == 0 ) {
ADDRGP4 level+9256
INDIRI4
ADDRGP4 level+9236
INDIRI4
ADDI4
CNSTI4 2
MODI4
CNSTI4 0
NEI4 $164
line 263
;263:		team = TEAM_RED;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 264
;264:	}
ADDRGP4 $165
JUMPV
LABELV $164
line 265
;265:	else {
line 266
;266:		team = TEAM_BLUE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 267
;267:	}
LABELV $165
line 268
;268:	trap_SendServerCommand( ent-g_entities, va("attackingteam %i", team));
ADDRGP4 $168
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 269
;269:}
LABELV $163
endproc AttackingTeamMessage 8 8
export ObeliskHealthMessage
proc ObeliskHealthMessage 4 12
line 275
;270:
;271:/*
;272: 
;273: */
;274:
;275:void ObeliskHealthMessage() {
line 276
;276:	if(level.MustSendObeliskHealth) {
ADDRGP4 level+9484
INDIRI4
CNSTI4 0
EQI4 $170
line 277
;277:		trap_SendServerCommand( -1, va("oh %i %i",level.healthRedObelisk,level.healthBlueObelisk) );
ADDRGP4 $173
ARGP4
ADDRGP4 level+9476
INDIRI4
ARGI4
ADDRGP4 level+9480
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 278
;278:		level.MustSendObeliskHealth = qfalse;
ADDRGP4 level+9484
CNSTI4 0
ASGNI4
line 279
;279:	}
LABELV $170
line 280
;280:}
LABELV $169
endproc ObeliskHealthMessage 4 12
export ChallengeMessage
proc ChallengeMessage 12 24
line 289
;281:
;282:/*
;283:==================
;284:ChallengeMessage
;285:
;286:==================
;287:*/
;288:
;289:void ChallengeMessage(gentity_t *ent, int challenge) {
line 290
;290:	if ( level.warmupTime != 0) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $178
line 292
;291:		//We don't send anything doring warmup
;292:		return;
ADDRGP4 $177
JUMPV
LABELV $178
line 294
;293:	}
;294:	trap_SendServerCommand( ent-g_entities, va("ch %u", challenge) );
ADDRGP4 $181
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 295
;295:	G_LogPrintf( "Challenge: %li %i %i: Client %li got award %i\n",ent-g_entities,challenge,1,ent-g_entities,challenge);
ADDRGP4 $182
ARGP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 296
;296:}
LABELV $177
endproc ChallengeMessage 12 24
export SendCustomVoteCommands
proc SendCustomVoteCommands 4 8
line 305
;297:
;298:/*
;299:==================
;300:SendCustomVoteCommands
;301:
;302:==================
;303:*/
;304:
;305:void SendCustomVoteCommands(int clientNum) {
line 306
;306:	trap_SendServerCommand( clientNum, va("customvotes %s", custom_vote_info) );
ADDRGP4 $184
ARGP4
ADDRGP4 custom_vote_info
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 307
;307:}
LABELV $183
endproc SendCustomVoteCommands 4 8
export Cmd_Score_f
proc Cmd_Score_f 0 4
line 316
;308:
;309:/*
;310:==================
;311:Cmd_Score_f
;312:
;313:Request current scoreboard information
;314:==================
;315:*/
;316:void Cmd_Score_f( gentity_t *ent ) {
line 317
;317:	DeathmatchScoreboardMessage( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 DeathmatchScoreboardMessage
CALLV
pop
line 318
;318:}
LABELV $185
endproc Cmd_Score_f 0 4
export Cmd_Acc_f
proc Cmd_Acc_f 0 4
line 327
;319:
;320:
;321:/*
;322:==================
;323: Cmd_Acc_f
;324: Request current scoreboard information
;325:==================
;326:*/
;327:void Cmd_Acc_f( gentity_t *ent ) {
line 328
;328:	AccMessage( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AccMessage
CALLV
pop
line 329
;329:}
LABELV $186
endproc Cmd_Acc_f 0 4
export CheatsOk
proc CheatsOk 4 8
line 337
;330:
;331:
;332:/*
;333:==================
;334:CheatsOk
;335:==================
;336:*/
;337:qboolean	CheatsOk( gentity_t *ent ) {
line 338
;338:	if ( !g_cheats.integer ) {
ADDRGP4 g_cheats+12
INDIRI4
CNSTI4 0
NEI4 $188
line 339
;339:		trap_SendServerCommand( ent-g_entities, va("print \"Cheats are not enabled on this server.\n\""));
ADDRGP4 $191
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 340
;340:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $187
JUMPV
LABELV $188
line 342
;341:	}
;342:	if ( ent->health <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $192
line 343
;343:		trap_SendServerCommand( ent-g_entities, va("print \"You must be alive to use this command.\n\""));
ADDRGP4 $194
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 344
;344:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $187
JUMPV
LABELV $192
line 346
;345:	}
;346:	return qtrue;
CNSTI4 1
RETI4
LABELV $187
endproc CheatsOk 4 8
bss
align 1
LABELV $196
skip 1024
export ConcatArgs
code
proc ConcatArgs 1048 12
line 355
;347:}
;348:
;349:
;350:/*
;351:==================
;352:ConcatArgs
;353:==================
;354:*/
;355:char	*ConcatArgs( int start ) {
line 361
;356:	int		i, c, tlen;
;357:	static char	line[MAX_STRING_CHARS];
;358:	int		len;
;359:	char	arg[MAX_STRING_CHARS];
;360:
;361:	len = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 362
;362:	c = trap_Argc();
ADDRLP4 1040
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1040
INDIRI4
ASGNI4
line 363
;363:	for ( i = start ; i < c ; i++ ) {
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRGP4 $200
JUMPV
LABELV $197
line 364
;364:		trap_Argv( i, arg, sizeof( arg ) );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 365
;365:		tlen = strlen( arg );
ADDRLP4 12
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1044
INDIRI4
ASGNI4
line 366
;366:		if ( len + tlen >= MAX_STRING_CHARS - 1 ) {
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
CNSTI4 1023
LTI4 $201
line 367
;367:			break;
ADDRGP4 $199
JUMPV
LABELV $201
line 369
;368:		}
;369:		memcpy( line + len, arg, tlen );
ADDRLP4 0
INDIRI4
ADDRGP4 $196
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 370
;370:		len += tlen;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 371
;371:		if ( i != c - 1 ) {
ADDRLP4 4
INDIRI4
ADDRLP4 1036
INDIRI4
CNSTI4 1
SUBI4
EQI4 $203
line 372
;372:			line[len] = ' ';
ADDRLP4 0
INDIRI4
ADDRGP4 $196
ADDP4
CNSTI1 32
ASGNI1
line 373
;373:			len++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 374
;374:		}
LABELV $203
line 375
;375:	}
LABELV $198
line 363
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $200
ADDRLP4 4
INDIRI4
ADDRLP4 1036
INDIRI4
LTI4 $197
LABELV $199
line 377
;376:
;377:	line[len] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 $196
ADDP4
CNSTI1 0
ASGNI1
line 379
;378:
;379:	return line;
ADDRGP4 $196
RETP4
LABELV $195
endproc ConcatArgs 1048 12
export StringIsInteger
proc StringIsInteger 20 4
line 388
;380:}
;381:
;382:
;383:/*
;384:==================
;385:StringIsInteger
;386:==================
;387:*/
;388:qboolean StringIsInteger( const char * s ) {
line 393
;389:	int			i;
;390:	int			len;
;391:	qboolean	foundDigit;
;392:
;393:	len = strlen( s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 394
;394:	foundDigit = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 396
;395:
;396:	for ( i=0 ; i < len ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $209
JUMPV
LABELV $206
line 397
;397:		if ( !isdigit( s[i] ) ) {
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
LTI4 $212
ADDRLP4 16
INDIRI4
CNSTI4 57
LEI4 $210
LABELV $212
line 398
;398:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $205
JUMPV
LABELV $210
line 401
;399:		}
;400:
;401:		foundDigit = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 402
;402:	}
LABELV $207
line 396
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $209
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $206
line 404
;403:
;404:	return foundDigit;
ADDRLP4 4
INDIRI4
RETI4
LABELV $205
endproc StringIsInteger 20 4
export ClientNumberFromString
proc ClientNumberFromString 1044 12
line 416
;405:}
;406:
;407:
;408:/*
;409:==================
;410:ClientNumberFromString
;411:
;412:Returns a player number for either a number or name string
;413:Returns -1 if invalid
;414:==================
;415:*/
;416:int ClientNumberFromString( gentity_t *to, char *s, qboolean checkNums, qboolean checkNames ) {
line 421
;417:	gclient_t	*cl;
;418:	int			idnum;
;419:	char        cleanName[MAX_STRING_CHARS];
;420:
;421:	if ( checkNums ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $214
line 423
;422:		// numeric values could be slot numbers
;423:		if ( StringIsInteger( s ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 StringIsInteger
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $216
line 424
;424:			idnum = atoi( s );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1036
INDIRI4
ASGNI4
line 425
;425:			if ( idnum >= 0 && idnum < level.maxclients ) {
ADDRLP4 1028
INDIRI4
CNSTI4 0
LTI4 $218
ADDRLP4 1028
INDIRI4
ADDRGP4 level+24
INDIRI4
GEI4 $218
line 426
;426:				cl = &level.clients[idnum];
ADDRLP4 1024
CNSTI4 2116
ADDRLP4 1028
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 427
;427:				if ( cl->pers.connected == CON_CONNECTED ) {
ADDRLP4 1024
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $221
line 428
;428:					return idnum;
ADDRLP4 1028
INDIRI4
RETI4
ADDRGP4 $213
JUMPV
LABELV $221
line 430
;429:				}
;430:			}
LABELV $218
line 431
;431:		}
LABELV $216
line 432
;432:	}
LABELV $214
line 434
;433:
;434:	if ( checkNames ) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $223
line 436
;435:		// check for a name match
;436:		for ( idnum=0,cl=level.clients ; idnum < level.maxclients ; idnum++,cl++ ) {
ADDRLP4 1028
CNSTI4 0
ASGNI4
ADDRLP4 1024
ADDRGP4 level
INDIRP4
ASGNP4
ADDRGP4 $228
JUMPV
LABELV $225
line 437
;437:			if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 1024
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $230
line 438
;438:				continue;
ADDRGP4 $226
JUMPV
LABELV $230
line 440
;439:			}
;440:			Q_strncpyz(cleanName, cl->pers.netname, sizeof(cleanName));
ADDRLP4 0
ARGP4
ADDRLP4 1024
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 441
;441:			Q_CleanStr(cleanName);
ADDRLP4 0
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 442
;442:			if ( !Q_stricmp( cleanName, s ) ) {
ADDRLP4 0
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
NEI4 $232
line 443
;443:				return idnum;
ADDRLP4 1028
INDIRI4
RETI4
ADDRGP4 $213
JUMPV
LABELV $232
line 445
;444:			}
;445:		}
LABELV $226
line 436
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1024
INDIRP4
CNSTI4 2116
ADDP4
ASGNP4
LABELV $228
ADDRLP4 1028
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $225
line 446
;446:	}
LABELV $223
line 448
;447:
;448:	trap_SendServerCommand( to-g_entities, va("print \"User %s is not on the server\n\"", s));
ADDRGP4 $234
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 449
;449:	return -1;
CNSTI4 -1
RETI4
LABELV $213
endproc ClientNumberFromString 1044 12
export Cmd_Give_f
proc Cmd_Give_f 132 12
line 460
;450:}
;451:
;452:/*
;453:==================
;454:Cmd_Give_f
;455:
;456:Give items to a client
;457:==================
;458:*/
;459:void Cmd_Give_f (gentity_t *ent)
;460:{
line 468
;461:	char		*name;
;462:	gitem_t		*it;
;463:	int			i;
;464:	qboolean	give_all;
;465:	gentity_t		*it_ent;
;466:	trace_t		trace;
;467:
;468:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $236
line 469
;469:		return;
ADDRGP4 $235
JUMPV
LABELV $236
line 472
;470:	}
;471:
;472:	name = ConcatArgs( 1 );
CNSTI4 1
ARGI4
ADDRLP4 80
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 80
INDIRP4
ASGNP4
line 474
;473:
;474:	if Q_strequal(name, "all") {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $240
ARGP4
ADDRLP4 84
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $238
line 475
;475:		give_all = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 476
;476:	}
ADDRGP4 $239
JUMPV
LABELV $238
line 477
;477:	else {
line 478
;478:		give_all = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 479
;479:	}
LABELV $239
line 481
;480:
;481:	if (give_all || Q_strequal( name, "health"))
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $244
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $243
ARGP4
ADDRLP4 88
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $241
LABELV $244
line 482
;482:	{
line 483
;483:		ent->health = ent->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 484
;484:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $245
line 485
;485:			return;
ADDRGP4 $235
JUMPV
LABELV $245
line 486
;486:	}
LABELV $241
line 488
;487:
;488:	if (give_all || Q_strequal(name, "weapons"))
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $250
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $249
ARGP4
ADDRLP4 92
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $247
LABELV $250
line 489
;489:	{
line 490
;490:		ent->client->ps.stats[STAT_WEAPONS] = (1 << WP_NUM_WEAPONS) - 1 - 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 15358
ASGNI4
line 492
;491:			( 1 << WP_GRAPPLING_HOOK ) - ( 1 << WP_NONE );
;492:		if (!give_all) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $251
line 493
;493:			return;
ADDRGP4 $235
JUMPV
LABELV $251
line 495
;494:		}
;495:	}
LABELV $247
line 497
;496:
;497:	if (give_all || Q_strequal(name, "ammo"))
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $256
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $255
ARGP4
ADDRLP4 96
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $253
LABELV $256
line 498
;498:	{
line 499
;499:		for ( i = 0 ; i < MAX_WEAPONS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $257
line 500
;500:			ent->client->ps.ammo[i] = 999;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 999
ASGNI4
line 501
;501:		}
LABELV $258
line 499
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $257
line 502
;502:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $261
line 503
;503:			return;
ADDRGP4 $235
JUMPV
LABELV $261
line 504
;504:	}
LABELV $253
line 506
;505:
;506:	if (give_all || Q_strequal(name, "armor"))
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $266
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $265
ARGP4
ADDRLP4 100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $263
LABELV $266
line 507
;507:	{
line 508
;508:		ent->client->ps.stats[STAT_ARMOR] = 200;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 200
ASGNI4
line 510
;509:
;510:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $267
line 511
;511:			return;
ADDRGP4 $235
JUMPV
LABELV $267
line 512
;512:	}
LABELV $263
line 514
;513:
;514:	if (Q_strequal(name, "excellent")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $271
ARGP4
ADDRLP4 104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $269
line 515
;515:		ent->client->ps.persistant[PERS_EXCELLENT_COUNT]++;
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 288
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 516
;516:		return;
ADDRGP4 $235
JUMPV
LABELV $269
line 518
;517:	}
;518:	if (Q_strequal(name, "impressive")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $274
ARGP4
ADDRLP4 108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $272
line 519
;519:		ent->client->ps.persistant[PERS_IMPRESSIVE_COUNT]++;
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 284
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 520
;520:		return;
ADDRGP4 $235
JUMPV
LABELV $272
line 522
;521:	}
;522:	if (Q_strequal(name, "gauntletaward")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $277
ARGP4
ADDRLP4 112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $275
line 523
;523:		ent->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 524
;524:		return;
ADDRGP4 $235
JUMPV
LABELV $275
line 526
;525:	}
;526:	if (Q_strequal(name, "defend")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $280
ARGP4
ADDRLP4 116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $278
line 527
;527:		ent->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 528
;528:		return;
ADDRGP4 $235
JUMPV
LABELV $278
line 530
;529:	}
;530:	if (Q_strequal(name, "assist")) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $281
line 531
;531:		ent->client->ps.persistant[PERS_ASSIST_COUNT]++;
ADDRLP4 124
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 532
;532:		return;
ADDRGP4 $235
JUMPV
LABELV $281
line 536
;533:	}
;534:
;535:	// spawn a specific item right on the player
;536:	if ( !give_all ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $284
line 537
;537:		it = BG_FindItem (name);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 124
INDIRP4
ASGNP4
line 538
;538:		if (!it) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $286
line 539
;539:			return;
ADDRGP4 $235
JUMPV
LABELV $286
line 542
;540:		}
;541:
;542:		it_ent = G_Spawn();
ADDRLP4 128
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 128
INDIRP4
ASGNP4
line 543
;543:		VectorCopy( ent->r.currentOrigin, it_ent->s.origin );
ADDRLP4 12
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 544
;544:		it_ent->classname = it->classname;
ADDRLP4 12
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 16
INDIRP4
INDIRP4
ASGNP4
line 545
;545:		G_SpawnItem (it_ent, it);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 G_SpawnItem
CALLV
pop
line 546
;546:		FinishSpawningItem(it_ent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 FinishSpawningItem
CALLV
pop
line 547
;547:		memset( &trace, 0, sizeof( trace ) );
ADDRLP4 20
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 548
;548:		Touch_Item (it_ent, ent, &trace);
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 Touch_Item
CALLV
pop
line 549
;549:		if (it_ent->inuse) {
ADDRLP4 12
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $288
line 550
;550:			G_FreeEntity( it_ent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 551
;551:		}
LABELV $288
line 552
;552:	}
LABELV $284
line 553
;553:}
LABELV $235
endproc Cmd_Give_f 132 12
export Cmd_God_f
proc Cmd_God_f 16 8
line 566
;554:
;555:
;556:/*
;557:==================
;558:Cmd_God_f
;559:
;560:Sets client to godmode
;561:
;562:argv(0) god
;563:==================
;564:*/
;565:void Cmd_God_f (gentity_t *ent)
;566:{
line 569
;567:	char	*msg;
;568:
;569:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $291
line 570
;570:		return;
ADDRGP4 $290
JUMPV
LABELV $291
line 573
;571:	}
;572:
;573:	ent->flags ^= FL_GODMODE;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 574
;574:	if (!(ent->flags & FL_GODMODE) ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $293
line 575
;575:		msg = "godmode OFF\n";
ADDRLP4 0
ADDRGP4 $295
ASGNP4
line 576
;576:	}
ADDRGP4 $294
JUMPV
LABELV $293
line 577
;577:	else {
line 578
;578:		msg = "godmode ON\n";
ADDRLP4 0
ADDRGP4 $296
ASGNP4
line 579
;579:	}
LABELV $294
line 581
;580:
;581:	trap_SendServerCommand( ent-g_entities, va("print \"%s\"", msg));
ADDRGP4 $297
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 582
;582:}
LABELV $290
endproc Cmd_God_f 16 8
export Cmd_Notarget_f
proc Cmd_Notarget_f 16 8
line 594
;583:
;584:
;585:/*
;586:==================
;587:Cmd_Notarget_f
;588:
;589:Sets client to notarget
;590:
;591:argv(0) notarget
;592:==================
;593:*/
;594:void Cmd_Notarget_f( gentity_t *ent ) {
line 597
;595:	char	*msg;
;596:
;597:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $299
line 598
;598:		return;
ADDRGP4 $298
JUMPV
LABELV $299
line 601
;599:	}
;600:
;601:	ent->flags ^= FL_NOTARGET;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BXORI4
ASGNI4
line 602
;602:	if (!(ent->flags & FL_NOTARGET) ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $301
line 603
;603:		msg = "notarget OFF\n";
ADDRLP4 0
ADDRGP4 $303
ASGNP4
line 604
;604:	}
ADDRGP4 $302
JUMPV
LABELV $301
line 605
;605:	else {
line 606
;606:		msg = "notarget ON\n";
ADDRLP4 0
ADDRGP4 $304
ASGNP4
line 607
;607:	}
LABELV $302
line 609
;608:
;609:	trap_SendServerCommand( ent-g_entities, va("print \"%s\"", msg));
ADDRGP4 $297
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 610
;610:}
LABELV $298
endproc Cmd_Notarget_f 16 8
export Cmd_Noclip_f
proc Cmd_Noclip_f 20 8
line 620
;611:
;612:
;613:/*
;614:==================
;615:Cmd_Noclip_f
;616:
;617:argv(0) noclip
;618:==================
;619:*/
;620:void Cmd_Noclip_f( gentity_t *ent ) {
line 623
;621:	char	*msg;
;622:
;623:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $306
line 624
;624:		return;
ADDRGP4 $305
JUMPV
LABELV $306
line 627
;625:	}
;626:
;627:	if ( ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
CNSTI4 0
EQI4 $308
line 628
;628:		msg = "noclip OFF\n";
ADDRLP4 0
ADDRGP4 $310
ASGNP4
line 629
;629:	} 
ADDRGP4 $309
JUMPV
LABELV $308
line 630
;630:	else {
line 631
;631:		msg = "noclip ON\n";
ADDRLP4 0
ADDRGP4 $311
ASGNP4
line 632
;632:	}
LABELV $309
line 633
;633:	ent->client->noclip = !ent->client->noclip;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1056
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $313
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $314
JUMPV
LABELV $313
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $314
ADDRLP4 12
INDIRP4
ADDRLP4 8
INDIRI4
ASGNI4
line 635
;634:
;635:	trap_SendServerCommand( ent-g_entities, va("print \"%s\"", msg));
ADDRGP4 $297
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 636
;636:}
LABELV $305
endproc Cmd_Noclip_f 20 8
export Cmd_LevelShot_f
proc Cmd_LevelShot_f 4 8
line 649
;637:
;638:
;639:/*
;640:==================
;641:Cmd_LevelShot_f
;642:
;643:This is just to help generate the level pictures
;644:for the menus.  It goes to the intermission immediately
;645:and sends over a command to the client to resize the view,
;646:hide the scoreboard, and take a special screenshot
;647:==================
;648:*/
;649:void Cmd_LevelShot_f( gentity_t *ent ) {
line 650
;650:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $316
line 651
;651:		return;
ADDRGP4 $315
JUMPV
LABELV $316
line 655
;652:	}
;653:
;654:	// doesn't work in single player
;655:	if ( g_gametype.integer != 0 ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
EQI4 $318
line 656
;656:		trap_SendServerCommand( ent-g_entities, 
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $321
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 658
;657:			"print \"Must be in g_gametype 0 for levelshot\n\"" );
;658:		return;
ADDRGP4 $315
JUMPV
LABELV $318
line 661
;659:	}
;660:
;661:	if(!ent->client->pers.localClient)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
NEI4 $322
line 662
;662:	{
line 663
;663:		trap_SendServerCommand(ent-g_entities,
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $324
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 665
;664:		"print \"The levelshot command must be executed by a local client\n\"");
;665:		return;
ADDRGP4 $315
JUMPV
LABELV $322
line 669
;666:	}
;667:
;668:
;669:	BeginIntermission();
ADDRGP4 BeginIntermission
CALLV
pop
line 670
;670:	trap_SendServerCommand( ent-g_entities, "clientLevelShot" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $325
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 671
;671:}
LABELV $315
endproc Cmd_LevelShot_f 4 8
export Cmd_TeamTask_f
proc Cmd_TeamTask_f 2068 12
line 684
;672:
;673:
;674:/*
;675:==================
;676:Cmd_LevelShot_f
;677:
;678:This is just to help generate the level pictures
;679:for the menus.  It goes to the intermission immediately
;680:and sends over a command to the client to resize the view,
;681:hide the scoreboard, and take a special screenshot
;682:==================
;683:*/
;684:void Cmd_TeamTask_f( gentity_t *ent ) {
line 688
;685:	char userinfo[MAX_INFO_STRING];
;686:	char		arg[MAX_TOKEN_CHARS];
;687:	int task;
;688:	int client = ent->client - level.clients;
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 2116
DIVI4
ASGNI4
line 690
;689:
;690:	if ( trap_Argc() != 2 ) {
ADDRLP4 2056
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 2
EQI4 $327
line 691
;691:		return;
ADDRGP4 $326
JUMPV
LABELV $327
line 693
;692:	}
;693:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 1028
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 694
;694:	task = atoi( arg );
ADDRLP4 1028
ARGP4
ADDRLP4 2060
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2052
ADDRLP4 2060
INDIRI4
ASGNI4
line 696
;695:
;696:	trap_GetUserinfo(client, userinfo, sizeof(userinfo));
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 697
;697:	Info_SetValueForKey(userinfo, "teamtask", va("%d", task));
ADDRGP4 $330
ARGP4
ADDRLP4 2052
INDIRI4
ARGI4
ADDRLP4 2064
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRGP4 $329
ARGP4
ADDRLP4 2064
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 698
;698:	trap_SetUserinfo(client, userinfo);
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 699
;699:	ClientUserinfoChanged(client);
ADDRLP4 1024
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 700
;700:}
LABELV $326
endproc Cmd_TeamTask_f 2068 12
export Cmd_Kill_f
proc Cmd_Kill_f 20 20
line 709
;701:
;702:
;703:
;704:/*
;705:=================
;706:Cmd_Kill_f
;707:=================
;708:*/
;709:void Cmd_Kill_f( gentity_t *ent ) {
line 710
;710:	if ( (ent->client->sess.sessionTeam == TEAM_SPECTATOR) || ent->client->isEliminated ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $334
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $332
LABELV $334
line 711
;711:		return;
ADDRGP4 $331
JUMPV
LABELV $332
line 713
;712:	}
;713:	if (ent->health <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $335
line 714
;714:		return;
ADDRGP4 $331
JUMPV
LABELV $335
line 716
;715:	}
;716:	ent->flags &= ~FL_GODMODE;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 717
;717:	ent->client->ps.stats[STAT_HEALTH] = ent->health = -999;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 -999
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 718
;718:	if(ent->client->lastSentFlying>-1) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1256
ADDP4
INDIRI4
CNSTI4 -1
LEI4 $337
line 720
;719:		//If player is in the air because of knockback we give credit to the person who sent it flying
;720:		player_die (ent, ent, &g_entities[ent->client->lastSentFlying], 100000, MOD_FALLING);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 816
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1256
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 19
ARGI4
ADDRGP4 player_die
CALLV
pop
line 721
;721:	}
ADDRGP4 $338
JUMPV
LABELV $337
line 722
;722:	else {
line 723
;723:		player_die (ent, ent, ent, 100000, MOD_SUICIDE);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 player_die
CALLV
pop
line 724
;724:	}
LABELV $338
line 725
;725:}
LABELV $331
endproc Cmd_Kill_f 20 20
export BroadcastTeamChange
proc BroadcastTeamChange 8 8
line 735
;726:
;727:/*
;728:=================
;729:BroadcastTeamChange
;730:
;731:Let everyone know about a team change
;732:=================
;733:*/
;734:void BroadcastTeamChange( gclient_t *client, int oldTeam )
;735:{
line 736
;736:	if ( client->sess.sessionTeam == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 1
NEI4 $340
line 737
;737:		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the red team.\n\"",
ADDRGP4 $342
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 739
;738:			client->pers.netname) );
;739:	} else if ( client->sess.sessionTeam == TEAM_BLUE ) {
ADDRGP4 $341
JUMPV
LABELV $340
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 2
NEI4 $343
line 740
;740:		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the blue team.\n\"",
ADDRGP4 $345
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 742
;741:		client->pers.netname));
;742:	} else if ( client->sess.sessionTeam == TEAM_SPECTATOR && oldTeam != TEAM_SPECTATOR ) {
ADDRGP4 $344
JUMPV
LABELV $343
ADDRLP4 0
CNSTI4 3
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $346
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $346
line 743
;743:		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the spectators.\n\"",
ADDRGP4 $348
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 745
;744:		client->pers.netname));
;745:	} else if ( client->sess.sessionTeam == TEAM_FREE ) {
ADDRGP4 $347
JUMPV
LABELV $346
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 0
NEI4 $349
line 746
;746:		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the battle.\n\"",
ADDRGP4 $351
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 748
;747:		client->pers.netname));
;748:	}
LABELV $349
LABELV $347
LABELV $344
LABELV $341
line 749
;749:}
LABELV $339
endproc BroadcastTeamChange 8 8
export SetTeam
proc SetTeam 1588 20
line 757
;750:
;751:/*
;752:=================
;753:SetTeam
;754:KK-OAX Modded this to accept a forced admin change. 
;755:=================
;756:*/
;757:void SetTeam( gentity_t *ent, const char *s ) {
line 767
;758:	int					team, oldTeam;
;759:	gclient_t			*client;
;760:	int					clientNum;
;761:	spectatorState_t	specState;
;762:	int					specClient;
;763:	int					teamLeader;
;764:	char	            userinfo[MAX_INFO_STRING];
;765:	qboolean            force;
;766:
;767:	force = G_admin_permission(ent, ADMF_FORCETEAMCHANGE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 53
ARGI4
ADDRLP4 1056
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 1056
INDIRI4
ASGNI4
line 772
;768:	
;769:	//
;770:	// see what change is requested
;771:	//
;772:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 774
;773:
;774:	clientNum = client - level.clients;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 2116
DIVI4
ASGNI4
line 775
;775:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 776
;776:	specClient = 0;
ADDRLP4 1048
CNSTI4 0
ASGNI4
line 777
;777:	specState = SPECTATOR_NOT;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 778
;778:	if ( Q_strequal( s, "scoreboard" ) || Q_strequal( s, "score" )  ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $355
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $357
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $356
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $353
LABELV $357
line 779
;779:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 780
;780:		specState = SPECTATOR_SCOREBOARD;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 781
;781:	} 
ADDRGP4 $354
JUMPV
LABELV $353
line 782
;782:	else if ( Q_strequal( s, "follow1" ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $360
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $358
line 783
;783:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 784
;784:		specState = SPECTATOR_FOLLOW;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 785
;785:		specClient = -1;
ADDRLP4 1048
CNSTI4 -1
ASGNI4
line 786
;786:	} 
ADDRGP4 $359
JUMPV
LABELV $358
line 787
;787:	else if ( Q_strequal( s, "follow2" ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $363
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $361
line 788
;788:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 789
;789:		specState = SPECTATOR_FOLLOW;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 790
;790:		specClient = -2;
ADDRLP4 1048
CNSTI4 -2
ASGNI4
line 791
;791:	} 
ADDRGP4 $362
JUMPV
LABELV $361
line 792
;792:	else if ( Q_strequal( s, "spectator" ) || Q_strequal( s, "s" ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $366
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
EQI4 $368
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $364
LABELV $368
line 793
;793:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 794
;794:		specState = SPECTATOR_FREE;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 795
;795:	} 
ADDRGP4 $365
JUMPV
LABELV $364
line 796
;796:	else if (G_IsATeamGametype(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1084
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
EQI4 $369
line 798
;797:		// if running a team game, assign player to one of the teams
;798:		specState = SPECTATOR_NOT;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 799
;799:		if ( Q_strequal( s, "red" ) || Q_strequal( s, "r" ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $374
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
EQI4 $376
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $375
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $372
LABELV $376
line 800
;800:			team = TEAM_RED;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 801
;801:		} 
ADDRGP4 $373
JUMPV
LABELV $372
line 802
;802:		else if ( Q_strequal( s, "blue" ) || Q_strequal( s, "b" ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $379
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
EQI4 $381
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $377
LABELV $381
line 803
;803:			team = TEAM_BLUE;
ADDRLP4 4
CNSTI4 2
ASGNI4
line 804
;804:		} 
ADDRGP4 $378
JUMPV
LABELV $377
line 805
;805:		else {
line 807
;806:			// pick the team with the least number of players
;807:			team = PickTeam( clientNum );
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 1104
ADDRGP4 PickTeam
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1104
INDIRI4
ASGNI4
line 808
;808:		}
LABELV $378
LABELV $373
line 809
;809:		if ( !force ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $370
line 810
;810:			if ( g_teamForceBalance.integer && !client->pers.localClient && !( ent->r.svFlags & SVF_BOT) ) {
ADDRLP4 1104
CNSTI4 0
ASGNI4
ADDRGP4 g_teamForceBalance+12
INDIRI4
ADDRLP4 1104
INDIRI4
EQI4 $370
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
ADDRLP4 1104
INDIRI4
NEI4 $370
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 1104
INDIRI4
NEI4 $370
line 813
;811:				int		counts[TEAM_NUM_TEAMS];
;812:
;813:				counts[TEAM_BLUE] = TeamCount( ent->client->ps.clientNum, TEAM_BLUE );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 1124
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 1108+8
ADDRLP4 1124
INDIRI4
ASGNI4
line 814
;814:				counts[TEAM_RED] = TeamCount( ent->client->ps.clientNum, TEAM_RED );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 1128
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 1108+4
ADDRLP4 1128
INDIRI4
ASGNI4
line 817
;815:
;816:				// We allow a spread of two
;817:				if ( team == TEAM_RED && counts[TEAM_RED] - counts[TEAM_BLUE] > 1 ) {
ADDRLP4 1132
CNSTI4 1
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 1132
INDIRI4
NEI4 $389
ADDRLP4 1108+4
INDIRI4
ADDRLP4 1108+8
INDIRI4
SUBI4
ADDRLP4 1132
INDIRI4
LEI4 $389
line 818
;818:					trap_SendServerCommand( ent->client->ps.clientNum, 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 $393
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 820
;819:						"cp \"Red team has too many players.\n\"" );
;820:					return; // ignore the request
ADDRGP4 $352
JUMPV
LABELV $389
line 822
;821:				}
;822:				if ( team == TEAM_BLUE && counts[TEAM_BLUE] - counts[TEAM_RED] > 1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $370
ADDRLP4 1108+8
INDIRI4
ADDRLP4 1108+4
INDIRI4
SUBI4
CNSTI4 1
LEI4 $370
line 823
;823:					trap_SendServerCommand( ent->client->ps.clientNum, 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 $398
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 825
;824:						"cp \"Blue team has too many players.\n\"" );
;825:					return; // ignore the request
ADDRGP4 $352
JUMPV
line 829
;826:				}
;827:
;828:				// It's ok, the team we are switching to has less or same number of players
;829:			}
line 830
;830:		}
line 831
;831:	} else {
LABELV $369
line 833
;832:		// force them to spectators if there aren't any spots free
;833:		team = TEAM_FREE;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 834
;834:	}
LABELV $370
LABELV $365
LABELV $362
LABELV $359
LABELV $354
line 835
;835:	if ( !force ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $399
line 837
;836:		// override decision if limiting the players
;837:		if ( (g_gametype.integer == GT_TOURNAMENT)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $401
ADDRGP4 level+76
INDIRI4
CNSTI4 2
LTI4 $401
line 838
;838:			&& level.numNonSpectatorClients >= 2 ) {
line 839
;839:			team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 840
;840:		} else if ( g_maxGameClients.integer > 0 && 
ADDRGP4 $402
JUMPV
LABELV $401
ADDRGP4 g_maxGameClients+12
INDIRI4
CNSTI4 0
LEI4 $405
ADDRGP4 level+76
INDIRI4
ADDRGP4 g_maxGameClients+12
INDIRI4
LTI4 $405
line 841
;841:			level.numNonSpectatorClients >= g_maxGameClients.integer ) {
line 842
;842:			team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 843
;843:		}
LABELV $405
LABELV $402
line 844
;844:	}
LABELV $399
line 849
;845:
;846:	//
;847:	// decide if we will allow the change
;848:	//
;849:	oldTeam = client->sess.sessionTeam;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 850
;850:	if ( team == oldTeam && team != TEAM_SPECTATOR ) {
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $410
ADDRLP4 4
INDIRI4
CNSTI4 3
EQI4 $410
line 851
;851:		return;
ADDRGP4 $352
JUMPV
LABELV $410
line 854
;852:	}
;853:	//KK-OAX Check to make sure the team is not locked from Admin
;854:	if ( !force ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $412
line 855
;855:		if ( team == TEAM_RED && level.RedTeamLocked ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $414
ADDRGP4 level+9464
INDIRI4
CNSTI4 0
EQI4 $414
line 856
;856:			trap_SendServerCommand( ent->client->ps.clientNum,
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 $417
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 858
;857:			"cp \"The Red Team has been locked by the Admin! \n\"" );
;858:			return;    
ADDRGP4 $352
JUMPV
LABELV $414
line 860
;859:		}
;860:		if ( team == TEAM_BLUE && level.BlueTeamLocked ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $418
ADDRGP4 level+9468
INDIRI4
CNSTI4 0
EQI4 $418
line 861
;861:			trap_SendServerCommand( ent->client->ps.clientNum,
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 $421
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 863
;862:			"cp \"The Blue Team has been locked by the Admin! \n\"" );
;863:			return;
ADDRGP4 $352
JUMPV
LABELV $418
line 865
;864:		}
;865:		if ( team == TEAM_FREE && level.FFALocked ) {
ADDRLP4 1092
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 1092
INDIRI4
NEI4 $422
ADDRGP4 level+9472
INDIRI4
ADDRLP4 1092
INDIRI4
EQI4 $422
line 866
;866:			trap_SendServerCommand( ent->client->ps.clientNum,
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 $425
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 868
;867:			"cp \"This Deathmatch has been locked by the Admin! \n\"" );
;868:			return;
ADDRGP4 $352
JUMPV
LABELV $422
line 870
;869:		}
;870:	}
LABELV $412
line 876
;871:	//
;872:	// execute the team change
;873:	//
;874:
;875:	// if the player was dead leave the body, but only if they're actually in game
;876:	if ( client->ps.stats[STAT_HEALTH] <= 0 && client->pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $426
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $426
line 877
;877:		CopyToBodyQue(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CopyToBodyQue
CALLV
pop
line 878
;878:	}
LABELV $426
line 881
;879:
;880:	// he starts at 'base'
;881:	client->pers.teamState.state = TEAM_BEGIN;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 0
ASGNI4
line 882
;882:	if ( oldTeam != TEAM_SPECTATOR ) {
ADDRLP4 8
INDIRI4
CNSTI4 3
EQI4 $428
line 883
;883:		int teamscore = -99;
ADDRLP4 1096
CNSTI4 -99
ASGNI4
line 885
;884:		//Prevent a team from loosing point because of player leaving team
;885:		if(g_gametype.integer == GT_TEAM && ent->client->ps.stats[STAT_HEALTH]) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $430
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $430
line 886
;886:			teamscore = level.teamScores[ ent->client->sess.sessionTeam ];
ADDRLP4 1096
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+44
ADDP4
INDIRI4
ASGNI4
line 887
;887:		}
LABELV $430
line 889
;888:		// Kill him (makes sure he loses flags, etc)
;889:		ent->flags &= ~FL_GODMODE;
ADDRLP4 1100
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 1100
INDIRP4
ADDRLP4 1100
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 890
;890:		ent->client->ps.stats[STAT_HEALTH] = ent->health = 0;
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1108
CNSTI4 0
ASGNI4
ADDRLP4 1104
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 1108
INDIRI4
ASGNI4
ADDRLP4 1104
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1108
INDIRI4
ASGNI4
line 891
;891:		player_die (ent, ent, ent, 100000, MOD_SUICIDE);
ADDRLP4 1112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1112
INDIRP4
ARGP4
ADDRLP4 1112
INDIRP4
ARGP4
ADDRLP4 1112
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 player_die
CALLV
pop
line 892
;892:		if (teamscore != -99) {
ADDRLP4 1096
INDIRI4
CNSTI4 -99
EQI4 $434
line 893
;893:			level.teamScores[ ent->client->sess.sessionTeam ] = teamscore;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+44
ADDP4
ADDRLP4 1096
INDIRI4
ASGNI4
line 894
;894:		}
LABELV $434
line 896
;895:
;896:		PlayerStore_store(Info_ValueForKey(userinfo,"cl_guid"),client->ps);
ADDRLP4 24
ARGP4
ADDRGP4 $437
ARGP4
ADDRLP4 1584
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1584
INDIRP4
ARGP4
ADDRLP4 1116
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 468
ADDRLP4 1116
ARGP4
ADDRGP4 PlayerStore_store
CALLV
pop
line 897
;897:	}
LABELV $428
line 899
;898:// they go to the end of the line for tournements
;899:	if(team == TEAM_SPECTATOR && oldTeam != team) {
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $438
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $438
line 900
;900:		AddTournamentQueue(client);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 AddTournamentQueue
CALLV
pop
line 901
;901:	}
LABELV $438
line 902
;902:	client->sess.sessionTeam = team;
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 903
;903:	client->sess.spectatorState = specState;
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 904
;904:	client->sess.spectatorClient = specClient;
ADDRLP4 0
INDIRP4
CNSTI4 1036
ADDP4
ADDRLP4 1048
INDIRI4
ASGNI4
line 906
;905:
;906:	client->sess.teamLeader = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 1048
ADDP4
CNSTI4 0
ASGNI4
line 907
;907:	if ( team == TEAM_RED || team == TEAM_BLUE ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $442
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $440
LABELV $442
line 908
;908:		teamLeader = TeamLeader( team );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1104
ADDRGP4 TeamLeader
CALLI4
ASGNI4
ADDRLP4 1052
ADDRLP4 1104
INDIRI4
ASGNI4
line 910
;909:		// if there is no team leader or the team leader is a bot and this client is not a bot
;910:		if ( teamLeader == -1 || ( !(g_entities[clientNum].r.svFlags & SVF_BOT) && (g_entities[teamLeader].r.svFlags & SVF_BOT) ) ) {
ADDRLP4 1108
ADDRLP4 1052
INDIRI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 -1
EQI4 $449
ADDRLP4 1112
CNSTI4 816
ASGNI4
ADDRLP4 1116
CNSTI4 8
ASGNI4
ADDRLP4 1120
CNSTI4 0
ASGNI4
ADDRLP4 1112
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
ADDRLP4 1116
INDIRI4
BANDI4
ADDRLP4 1120
INDIRI4
NEI4 $443
ADDRLP4 1112
INDIRI4
ADDRLP4 1108
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
ADDRLP4 1116
INDIRI4
BANDI4
ADDRLP4 1120
INDIRI4
EQI4 $443
LABELV $449
line 911
;911:			SetLeader( team, clientNum );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 SetLeader
CALLV
pop
line 912
;912:		}
LABELV $443
line 913
;913:	}
LABELV $440
line 915
;914:	// make sure there is a team leader on the team the player came from
;915:	if ( oldTeam == TEAM_RED || oldTeam == TEAM_BLUE ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $452
ADDRLP4 8
INDIRI4
CNSTI4 2
NEI4 $450
LABELV $452
line 916
;916:		CheckTeamLeader( oldTeam );
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CheckTeamLeader
CALLV
pop
line 917
;917:	}
LABELV $450
line 920
;918:
;919:	// get and distribute relevent paramters
;920:	ClientUserinfoChanged( clientNum );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 922
;921:	// client hasn't spawned yet, they sent an early team command, teampref userinfo, or g_teamAutoJoin is enabled
;922:	if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $453
line 923
;923:		return;
ADDRGP4 $352
JUMPV
LABELV $453
line 926
;924:	}
;925:
;926:	BroadcastTeamChange( client, oldTeam );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 BroadcastTeamChange
CALLV
pop
line 928
;927:
;928:	ClientBegin( clientNum );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 929
;929:}
LABELV $352
endproc SetTeam 1588 20
export StopFollowing
proc StopFollowing 20 8
line 939
;930:
;931:/*
;932:=================
;933:StopFollowing
;934:
;935:If the client being followed leaves the game, or you just want to drop
;936:to free floating spectator mode
;937:=================
;938:*/
;939:void StopFollowing( gentity_t *ent ) {
line 940
;940:	if(!G_IsARoundBasedGametype(g_gametype.integer))
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $456
line 941
;941:	{
line 943
;942:		//Shouldn't this already be the case?
;943:		ent->client->ps.persistant[ PERS_TEAM ] = TEAM_SPECTATOR;	
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
CNSTI4 3
ASGNI4
line 944
;944:		ent->client->sess.sessionTeam = TEAM_SPECTATOR;	
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
CNSTI4 3
ASGNI4
line 945
;945:	}
ADDRGP4 $457
JUMPV
LABELV $456
line 946
;946:	else {
line 947
;947:		ent->client->ps.stats[STAT_HEALTH] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 0
ASGNI4
line 948
;948:		ent->health = 0;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 0
ASGNI4
line 949
;949:	}
LABELV $457
line 950
;950:	ent->client->sess.spectatorState = SPECTATOR_FREE;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 1
ASGNI4
line 951
;951:	ent->client->ps.pm_flags &= ~PMF_FOLLOW;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 952
;952:	ent->r.svFlags &= ~SVF_BOT;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 953
;953:	ent->client->ps.clientNum = ent - g_entities;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ASGNI4
line 955
;954:
;955:	SetClientViewAngle( ent, ent->client->ps.viewangles );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 958
;956:
;957:	// don't use dead view angles
;958:	if ( ent->client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $459
line 959
;959:		ent->client->ps.stats[STAT_HEALTH] = 1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 1
ASGNI4
line 960
;960:	}
LABELV $459
line 961
;961:}
LABELV $455
endproc StopFollowing 20 8
export Cmd_Team_f
proc Cmd_Team_f 1044 12
line 968
;962:
;963:/*
;964:=================
;965:Cmd_Team_f
;966:=================
;967:*/
;968:void Cmd_Team_f( gentity_t *ent ) {
line 973
;969:	int			oldTeam;
;970:	char		s[MAX_TOKEN_CHARS];
;971:	qboolean    force;
;972:
;973:	if ( trap_Argc() != 2 ) {
ADDRLP4 1032
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 2
EQI4 $462
line 974
;974:		oldTeam = ent->client->sess.sessionTeam;
ADDRLP4 1028
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 975
;975:		switch ( oldTeam ) {
ADDRLP4 1036
ADDRLP4 1028
INDIRI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
LTI4 $461
ADDRLP4 1036
INDIRI4
CNSTI4 3
GTI4 $461
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $474
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $474
address $470
address $468
address $466
address $472
code
LABELV $466
line 977
;976:		case TEAM_BLUE:
;977:			trap_SendServerCommand( ent-g_entities, "print \"Blue team\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $467
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 978
;978:			break;
ADDRGP4 $461
JUMPV
LABELV $468
line 980
;979:		case TEAM_RED:
;980:			trap_SendServerCommand( ent-g_entities, "print \"Red team\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $469
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 981
;981:			break;
ADDRGP4 $461
JUMPV
LABELV $470
line 983
;982:		case TEAM_FREE:
;983:			trap_SendServerCommand( ent-g_entities, "print \"Deathmatch-Playing\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $471
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 984
;984:			break;
ADDRGP4 $461
JUMPV
LABELV $472
line 986
;985:		case TEAM_SPECTATOR:
;986:			trap_SendServerCommand( ent-g_entities, "print \"Spectator team\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $473
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 987
;987:			break;
line 989
;988:		}
;989:		return;
ADDRGP4 $461
JUMPV
LABELV $462
line 992
;990:	}
;991:    
;992:	force = G_admin_permission(ent, ADMF_FORCETEAMCHANGE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 53
ARGI4
ADDRLP4 1036
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1036
INDIRI4
ASGNI4
line 994
;993:	
;994:	if( !force ) {
ADDRLP4 1024
INDIRI4
CNSTI4 0
NEI4 $475
line 995
;995:		if ( ent->client->switchTeamTime > level.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1168
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $477
line 996
;996:			trap_SendServerCommand( ent-g_entities, "print \"May not switch teams more than once per 5 seconds.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $480
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 997
;997:			return;
ADDRGP4 $461
JUMPV
LABELV $477
line 999
;998:		}
;999:	}
LABELV $475
line 1002
;1000:
;1001:	// if they are playing a tournement game, count as a loss
;1002:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $481
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 0
NEI4 $481
line 1003
;1003:		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
line 1004
;1004:		ent->client->sess.losses++;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1044
ADDP4
ASGNP4
ADDRLP4 1040
INDIRP4
ADDRLP4 1040
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1005
;1005:	}
LABELV $481
line 1007
;1006:
;1007:	trap_Argv( 1, s, sizeof( s ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1009
;1008:
;1009:	SetTeam( ent, s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 1011
;1010:
;1011:	ent->client->switchTeamTime = level.time + 5000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1168
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 1012
;1012:}
LABELV $461
endproc Cmd_Team_f 1044 12
export Cmd_Follow_f
proc Cmd_Follow_f 1068 16
line 1020
;1013:
;1014:
;1015:/*
;1016:=================
;1017:Cmd_Follow_f
;1018:=================
;1019:*/
;1020:void Cmd_Follow_f( gentity_t *ent ) {
line 1024
;1021:	int		i;
;1022:	char	arg[MAX_TOKEN_CHARS];
;1023:	
;1024:	if ( trap_Argc() != 2 ) {
ADDRLP4 1028
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
EQI4 $486
line 1025
;1025:		if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
NEI4 $485
line 1026
;1026:			StopFollowing( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 1027
;1027:		}
line 1028
;1028:		return;
ADDRGP4 $485
JUMPV
LABELV $486
line 1032
;1029:	}
;1030:
;1031:
;1032:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1033
;1033:	i = ClientNumberFromString( ent, arg, qtrue, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1032
CNSTI4 1
ASGNI4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 1036
ADDRGP4 ClientNumberFromString
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1036
INDIRI4
ASGNI4
line 1034
;1034:	if ( i == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $490
line 1035
;1035:		return;
ADDRGP4 $485
JUMPV
LABELV $490
line 1041
;1036:	}
;1037:
;1038:	
;1039:
;1040:	// can't follow self
;1041:	if ( &level.clients[ i ] == ent->client ) {
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CVPU4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
NEU4 $492
line 1042
;1042:		return;
ADDRGP4 $485
JUMPV
LABELV $492
line 1046
;1043:	}
;1044:
;1045:	// can't follow another spectator (or an eliminated player)
;1046:	if ( (level.clients[ i ].sess.sessionTeam == TEAM_SPECTATOR) || level.clients[ i ].isEliminated) {
ADDRLP4 1040
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $496
ADDRLP4 1040
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $494
LABELV $496
line 1047
;1047:		return;
ADDRGP4 $485
JUMPV
LABELV $494
line 1050
;1048:	}
;1049:
;1050:	if ( G_IsARoundBasedGametype(g_gametype.integer) && G_IsATeamGametype(g_gametype.integer) && g_elimination_lockspectator.integer
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1044
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $497
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1048
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 1052
CNSTI4 0
ASGNI4
ADDRLP4 1048
INDIRI4
ADDRLP4 1052
INDIRI4
EQI4 $497
ADDRGP4 g_elimination_lockspectator+12
INDIRI4
ADDRLP4 1052
INDIRI4
EQI4 $497
ADDRLP4 1056
CNSTI4 1024
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 1056
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $503
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ADDRLP4 1056
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $502
LABELV $503
ADDRLP4 1060
CNSTI4 1024
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 1060
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $497
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ADDRLP4 1060
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $497
LABELV $502
line 1052
;1051:		&&  ((ent->client->sess.sessionTeam == TEAM_RED && level.clients[ i ].sess.sessionTeam == TEAM_BLUE) ||
;1052:			 (ent->client->sess.sessionTeam == TEAM_BLUE && level.clients[ i ].sess.sessionTeam == TEAM_RED) ) ) {
line 1053
;1053:		return;
ADDRGP4 $485
JUMPV
LABELV $497
line 1057
;1054:	}
;1055:
;1056:	// if they are playing a tournement game, count as a loss
;1057:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $504
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 0
NEI4 $504
line 1058
;1058:		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
line 1059
;1059:		ent->client->sess.losses++;
ADDRLP4 1064
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1044
ADDP4
ASGNP4
ADDRLP4 1064
INDIRP4
ADDRLP4 1064
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1060
;1060:	}
LABELV $504
line 1064
;1061:
;1062:	// first set them to spectator
;1063:	//if ( ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
;1064:	if ( ent->client->sess.spectatorState == SPECTATOR_NOT ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 0
NEI4 $507
line 1065
;1065:		SetTeam( ent, "spectator" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $366
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 1066
;1066:	}
LABELV $507
line 1068
;1067:
;1068:	ent->client->sess.spectatorState = SPECTATOR_FOLLOW;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 2
ASGNI4
line 1069
;1069:	ent->client->sess.spectatorClient = i;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1070
;1070:}
LABELV $485
endproc Cmd_Follow_f 1068 16
export Cmd_FollowCycle_f
proc Cmd_FollowCycle_f 64 12
line 1078
;1071:
;1072:/*
;1073:=================
;1074:Cmd_FollowCycle_f
;1075:KK-OAX Modified to trap arguments.
;1076:=================
;1077:*/
;1078:void Cmd_FollowCycle_f( gentity_t *ent ) {
line 1085
;1079:	int		clientnum;
;1080:	int		original;
;1081:	int     count;
;1082:	char    args[11];
;1083:	int     dir;
;1084:
;1085:	if( ent->client->sess.sessionTeam == TEAM_NONE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $510
line 1086
;1086:		dir = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1087
;1087:	}
LABELV $510
line 1089
;1088:
;1089:	trap_Argv( 0, args, sizeof( args ) );
CNSTI4 0
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 11
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1090
;1090:	if( Q_strequal( args, "followprev" )) {
ADDRLP4 16
ARGP4
ADDRGP4 $514
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $512
line 1091
;1091:		dir = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 1092
;1092:	} 
ADDRGP4 $513
JUMPV
LABELV $512
line 1093
;1093:	else if( Q_strequal( args, "follownext" )) {
ADDRLP4 16
ARGP4
ADDRGP4 $517
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $515
line 1094
;1094:		dir = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1095
;1095:	} 
ADDRGP4 $516
JUMPV
LABELV $515
line 1096
;1096:	else {
line 1097
;1097:		dir = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1098
;1098:	}
LABELV $516
LABELV $513
line 1101
;1099:
;1100:	// if they are playing a tournement game, count as a loss
;1101:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $518
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 0
NEI4 $518
line 1102
;1102:		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
line 1103
;1103:		ent->client->sess.losses++;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1044
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
line 1104
;1104:	}
LABELV $518
line 1106
;1105:	// first set them to spectator
;1106:	if ( ent->client->sess.spectatorState == SPECTATOR_NOT ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 0
NEI4 $521
line 1107
;1107:		SetTeam( ent, "spectator" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $366
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 1108
;1108:	}
LABELV $521
line 1110
;1109:
;1110:	if ( dir != 1 && dir != -1 ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $523
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $523
line 1111
;1111:		G_Error( "Cmd_FollowCycle_f: bad dir %i", dir );
ADDRGP4 $525
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 1112
;1112:	}
LABELV $523
line 1115
;1113:
;1114:	// if dedicated follow client, just switch between the two auto clients
;1115:	if (ent->client->sess.spectatorClient < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
CNSTI4 0
GEI4 $526
line 1116
;1116:		if (ent->client->sess.spectatorClient == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $528
line 1117
;1117:			ent->client->sess.spectatorClient = -2;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
CNSTI4 -2
ASGNI4
line 1118
;1118:		} else if (ent->client->sess.spectatorClient == -2) {
ADDRGP4 $509
JUMPV
LABELV $528
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
CNSTI4 -2
NEI4 $509
line 1119
;1119:			ent->client->sess.spectatorClient = -1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
CNSTI4 -1
ASGNI4
line 1120
;1120:		}
line 1121
;1121:		return;
ADDRGP4 $509
JUMPV
LABELV $526
line 1124
;1122:	}
;1123:
;1124:	clientnum = ent->client->sess.spectatorClient;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
ASGNI4
line 1125
;1125:	original = clientnum;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 1126
;1126:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $532
line 1127
;1127:	do {
line 1128
;1128:		clientnum += dir;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1129
;1129:		count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1130
;1130:		if ( clientnum >= level.maxclients ) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $535
line 1131
;1131:			clientnum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1132
;1132:		}
LABELV $535
line 1133
;1133:		if ( clientnum < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $538
line 1134
;1134:			clientnum = level.maxclients - 1;
ADDRLP4 0
ADDRGP4 level+24
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1135
;1135:		}
LABELV $538
line 1137
;1136:
;1137:		if(count>level.maxclients) {
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LEI4 $541
line 1139
;1138:			//We have looked at all clients at least once and found nothing
;1139:			return; //We might end up in an infinite loop here. Stop it!
ADDRGP4 $509
JUMPV
LABELV $541
line 1142
;1140:		}
;1141:		// can only follow connected clients
;1142:		if ( level.clients[ clientnum ].pers.connected != CON_CONNECTED ) {
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
EQI4 $544
line 1143
;1143:			continue;
ADDRGP4 $533
JUMPV
LABELV $544
line 1147
;1144:		}
;1145:
;1146:		// can't follow another spectator
;1147:		if ( (level.clients[ clientnum ].sess.sessionTeam == TEAM_SPECTATOR) || level.clients[ clientnum ].isEliminated) {
ADDRLP4 40
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $548
ADDRLP4 40
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $546
LABELV $548
line 1148
;1148:			continue;
ADDRGP4 $533
JUMPV
LABELV $546
line 1152
;1149:		}
;1150:
;1151:		//Stop players from spectating players on the enemy team in elimination modes.
;1152:		if ( (G_IsARoundBasedGametype(g_gametype.integer) && G_IsATeamGametype(g_gametype.integer)) && g_elimination_lockspectator.integer
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $549
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $549
ADDRGP4 g_elimination_lockspectator+12
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $549
ADDRLP4 56
CNSTI4 1024
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $555
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $554
LABELV $555
ADDRLP4 60
CNSTI4 1024
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $549
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $549
LABELV $554
line 1154
;1153:			&&  ((ent->client->sess.sessionTeam == TEAM_RED && level.clients[ clientnum ].sess.sessionTeam == TEAM_BLUE) ||
;1154:				 (ent->client->sess.sessionTeam == TEAM_BLUE && level.clients[ clientnum ].sess.sessionTeam == TEAM_RED) ) ) {
line 1155
;1155:			continue;
ADDRGP4 $533
JUMPV
LABELV $549
line 1159
;1156:		}
;1157:
;1158:		// this is good, we can use it
;1159:		ent->client->sess.spectatorClient = clientnum;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1160
;1160:		ent->client->sess.spectatorState = SPECTATOR_FOLLOW;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 2
ASGNI4
line 1161
;1161:		return;
ADDRGP4 $509
JUMPV
LABELV $533
line 1162
;1162:	} while ( clientnum != original );
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $532
line 1165
;1163:
;1164:	// leave it where it was
;1165:}
LABELV $509
endproc Cmd_FollowCycle_f 64 12
proc G_SayTo 24 24
line 1174
;1166:
;1167:
;1168:/*
;1169:==================
;1170:G_Say
;1171:==================
;1172:*/
;1173:
;1174:static void G_SayTo( gentity_t *ent, gentity_t *other, int mode, int color, const char *name, const char *message ) {
line 1175
;1175:	if (!other) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $557
line 1176
;1176:		return;
ADDRGP4 $556
JUMPV
LABELV $557
line 1178
;1177:	}
;1178:	if (!other->inuse) {
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $559
line 1179
;1179:		return;
ADDRGP4 $556
JUMPV
LABELV $559
line 1181
;1180:	}
;1181:	if (!other->client) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $561
line 1182
;1182:		return;
ADDRGP4 $556
JUMPV
LABELV $561
line 1184
;1183:	}
;1184:	if ( other->client->pers.connected != CON_CONNECTED ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $563
line 1185
;1185:		return;
ADDRGP4 $556
JUMPV
LABELV $563
line 1187
;1186:	}
;1187:	if ( mode == SAY_TEAM  && !OnSameTeam(ent, other) ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $565
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $565
line 1188
;1188:		return;
ADDRGP4 $556
JUMPV
LABELV $565
line 1191
;1189:	}
;1190:
;1191:	if ((ent->r.svFlags & SVF_BOT) && g_bot_noChat.integer > 1) return;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $567
ADDRGP4 g_bot_noChat+12
INDIRI4
CNSTI4 1
LEI4 $567
ADDRGP4 $556
JUMPV
LABELV $567
line 1194
;1192:
;1193:	// no chatting to players in tournements
;1194:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $570
ADDRLP4 4
CNSTI4 516
ASGNI4
ADDRLP4 8
CNSTI4 1024
ASGNI4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $570
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $570
line 1196
;1195:		&& other->client->sess.sessionTeam == TEAM_FREE
;1196:		&& ent->client->sess.sessionTeam != TEAM_FREE ) {
line 1197
;1197:		return;
ADDRGP4 $556
JUMPV
LABELV $570
line 1200
;1198:	}
;1199:
;1200:	trap_SendServerCommand( other-g_entities, va("%s \"%s%c%c%s\"", 
ADDRGP4 $573
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $577
ADDRLP4 16
ADDRGP4 $574
ASGNP4
ADDRGP4 $578
JUMPV
LABELV $577
ADDRLP4 16
ADDRGP4 $575
ASGNP4
LABELV $578
ADDRLP4 16
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 94
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1203
;1201:		mode == SAY_TEAM ? "tchat" : "chat",
;1202:		name, Q_COLOR_ESCAPE, color, message));
;1203:}
LABELV $556
endproc G_SayTo 24 24
export G_Say
proc G_Say 332 28
line 1207
;1204:
;1205:#define EC		"\x19"
;1206:
;1207:void G_Say( gentity_t *ent, gentity_t *target, int mode, const char *chatText ) {
line 1216
;1208:	int			j;
;1209:	gentity_t	*other;
;1210:	int			color;
;1211:	char		name[64];
;1212:	// don't let text be too long for malicious reasons
;1213:	char		text[MAX_SAY_TEXT];
;1214:	char		location[64];
;1215:
;1216:	if (!ent) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $580
line 1217
;1217:		return;
ADDRGP4 $579
JUMPV
LABELV $580
line 1220
;1218:	}
;1219:
;1220:	if ((ent->r.svFlags & SVF_BOT) && g_bot_noChat.integer > 1) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $582
ADDRGP4 g_bot_noChat+12
INDIRI4
CNSTI4 1
LEI4 $582
line 1221
;1221:		return;
ADDRGP4 $579
JUMPV
LABELV $582
line 1224
;1222:	}
;1223:
;1224:	if ( !G_IsATeamGametype(g_gametype.integer) && mode == SAY_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 292
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
NEI4 $585
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $585
line 1225
;1225:		mode = SAY_ALL;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 1226
;1226:	}
LABELV $585
line 1228
;1227:
;1228:	switch ( mode ) {
ADDRLP4 296
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
EQI4 $590
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $593
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $599
ADDRGP4 $588
JUMPV
LABELV $588
LABELV $590
line 1231
;1229:	default:
;1230:	case SAY_ALL:
;1231:		G_LogPrintf( "say: %s: %s\n", ent->client->pers.netname, chatText );
ADDRGP4 $591
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1232
;1232:		Com_sprintf (name, sizeof(name), "%s%c%c"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
ADDRLP4 158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $592
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1233
;1233:		color = COLOR_GREEN;
ADDRLP4 224
CNSTI4 50
ASGNI4
line 1234
;1234:		break;
ADDRGP4 $589
JUMPV
LABELV $593
line 1236
;1235:	case SAY_TEAM:
;1236:		G_LogPrintf( "sayteam: %s: %s\n", ent->client->pers.netname, chatText );
ADDRGP4 $594
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1237
;1237:		if (Team_GetLocationMsg(ent, location, sizeof(location)))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 228
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 300
ADDRGP4 Team_GetLocationMsg
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $595
line 1238
;1238:			Com_sprintf (name, sizeof(name), EC"(%s%c%c"EC") (%s)"EC": ", 
ADDRLP4 158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $597
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRLP4 228
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $596
JUMPV
LABELV $595
line 1241
;1239:				ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE, location);
;1240:		else
;1241:			Com_sprintf (name, sizeof(name), EC"(%s%c%c"EC")"EC": ", 
ADDRLP4 158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $598
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
LABELV $596
line 1243
;1242:				ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
;1243:		color = COLOR_CYAN;
ADDRLP4 224
CNSTI4 53
ASGNI4
line 1244
;1244:		break;
ADDRGP4 $589
JUMPV
LABELV $599
line 1246
;1245:	case SAY_TELL:
;1246:		if (target && target->inuse && target->client && G_IsATeamGametype(g_gametype.integer) &&
ADDRLP4 304
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 308
CNSTU4 0
ASGNU4
ADDRLP4 304
INDIRP4
CVPU4 4
ADDRLP4 308
INDIRU4
EQU4 $600
ADDRLP4 304
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $600
ADDRLP4 304
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 308
INDIRU4
EQU4 $600
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 312
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $600
ADDRLP4 316
CNSTI4 516
ASGNI4
ADDRLP4 320
CNSTI4 1024
ASGNI4
ADDRLP4 324
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 316
INDIRI4
ADDP4
INDIRP4
ADDRLP4 320
INDIRI4
ADDP4
INDIRI4
ADDRLP4 324
INDIRP4
ADDRLP4 316
INDIRI4
ADDP4
INDIRP4
ADDRLP4 320
INDIRI4
ADDP4
INDIRI4
NEI4 $600
ADDRLP4 324
INDIRP4
ARGP4
ADDRLP4 228
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 328
ADDRGP4 Team_GetLocationMsg
CALLI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
EQI4 $600
line 1249
;1247:			target->client->sess.sessionTeam == ent->client->sess.sessionTeam &&
;1248:			Team_GetLocationMsg(ent, location, sizeof(location)))
;1249:			Com_sprintf (name, sizeof(name), EC"[%s%c%c"EC"] (%s)"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE, location );
ADDRLP4 158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $603
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRLP4 228
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $601
JUMPV
LABELV $600
line 1251
;1250:		else
;1251:			Com_sprintf (name, sizeof(name), EC"[%s%c%c"EC"]"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
ADDRLP4 158
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $604
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
LABELV $601
line 1252
;1252:		color = COLOR_MAGENTA;
ADDRLP4 224
CNSTI4 54
ASGNI4
line 1253
;1253:		break;
LABELV $589
line 1256
;1254:	}
;1255:
;1256:	Q_strncpyz( text, chatText, sizeof(text) );
ADDRLP4 8
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1258
;1257:
;1258:	if ( target ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $605
line 1259
;1259:		G_SayTo( ent, target, mode, color, name, text );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRLP4 158
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_SayTo
CALLV
pop
line 1260
;1260:		return;
ADDRGP4 $579
JUMPV
LABELV $605
line 1264
;1261:	}
;1262:
;1263:	// echo the text to the console
;1264:	if ( g_dedicated.integer ) {
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $607
line 1265
;1265:		G_Printf( "%s%s\n", name, text);
ADDRGP4 $610
ARGP4
ADDRLP4 158
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1266
;1266:	}
LABELV $607
line 1269
;1267:
;1268:	// send it to all the apropriate clients
;1269:	for (j = 0; j < level.maxclients; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $614
JUMPV
LABELV $611
line 1270
;1270:		other = &g_entities[j];
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1271
;1271:		G_SayTo( ent, other, mode, color, name, text );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 224
INDIRI4
ARGI4
ADDRLP4 158
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_SayTo
CALLV
pop
line 1272
;1272:	}
LABELV $612
line 1269
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $614
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $611
line 1274
;1273:	//KK-OAX Admin Command Check from Say/SayTeam line
;1274:	if( g_adminParseSay.integer ) {
ADDRGP4 g_adminParseSay+12
INDIRI4
CNSTI4 0
EQI4 $616
line 1275
;1275:		G_admin_cmd_check ( ent, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 G_admin_cmd_check
CALLI4
pop
line 1276
;1276:	}
LABELV $616
line 1277
;1277:}
LABELV $579
endproc G_Say 332 28
proc SanitizeChatText 8 0
line 1279
;1278:
;1279:static void SanitizeChatText( char *text ) {
line 1282
;1280:	int i;
;1281:
;1282:	for ( i = 0; text[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $623
JUMPV
LABELV $620
line 1283
;1283:		if ( text[i] == '\n' || text[i] == '\r' ) {
ADDRLP4 4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 10
EQI4 $626
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $624
LABELV $626
line 1284
;1284:			text[i] = ' ';
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 32
ASGNI1
line 1285
;1285:		}
LABELV $624
line 1286
;1286:	}
LABELV $621
line 1282
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $623
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $620
line 1287
;1287:}
LABELV $619
endproc SanitizeChatText 8 0
proc Cmd_Say_f 1044 16
line 1295
;1288:
;1289:/*
;1290:==================
;1291:Cmd_Say_f
;1292:KK-OAX Modified this to trap the additional arguments from console.
;1293:==================
;1294:*/
;1295:static void Cmd_Say_f( gentity_t *ent ){
line 1298
;1296:	char		*p;
;1297:	char        arg[MAX_TOKEN_CHARS];
;1298:	int         mode = SAY_ALL;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 1300
;1299:
;1300:	trap_Argv( 0, arg, sizeof( arg ) );
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1301
;1301:	if( Q_strequal( arg, "say_team" ) ) {
ADDRLP4 4
ARGP4
ADDRGP4 $630
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $628
line 1302
;1302:		mode = SAY_TEAM ;
ADDRLP4 1028
CNSTI4 1
ASGNI4
line 1303
;1303:	}
LABELV $628
line 1305
;1304:
;1305:	if( trap_Argc( ) < 2 ) {
ADDRLP4 1036
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 2
GEI4 $631
line 1306
;1306:		return;
ADDRGP4 $627
JUMPV
LABELV $631
line 1309
;1307:	}
;1308:
;1309:	p = ConcatArgs( 1 );
CNSTI4 1
ARGI4
ADDRLP4 1040
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1040
INDIRP4
ASGNP4
line 1310
;1310:	SanitizeChatText( p );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 SanitizeChatText
CALLV
pop
line 1311
;1311:	G_Say( ent, NULL, mode, p );
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1312
;1312:}
LABELV $627
endproc Cmd_Say_f 1044 16
proc Cmd_Tell_f 1076 16
line 1319
;1313:
;1314:/*
;1315:==================
;1316:Cmd_Tell_f
;1317:==================
;1318:*/
;1319:static void Cmd_Tell_f( gentity_t *ent ) {
line 1325
;1320:	int			targetNum;
;1321:	gentity_t	*target;
;1322:	char		*p;
;1323:	char		arg[MAX_TOKEN_CHARS];
;1324:
;1325:	if ( trap_Argc () < 3 ) {
ADDRLP4 1036
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 3
GEI4 $634
line 1326
;1326:		trap_SendServerCommand( ent-g_entities, "print \"Usage: tell <player id> <message>\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $636
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1327
;1327:		return;
ADDRGP4 $633
JUMPV
LABELV $634
line 1330
;1328:	}
;1329:
;1330:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1331
;1331:	targetNum = ClientNumberFromString( ent, arg, qtrue, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 1040
CNSTI4 1
ASGNI4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1044
ADDRGP4 ClientNumberFromString
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1044
INDIRI4
ASGNI4
line 1332
;1332:	if ( targetNum == -1 ) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
NEI4 $637
line 1333
;1333:		return;
ADDRGP4 $633
JUMPV
LABELV $637
line 1336
;1334:	}
;1335:
;1336:	target = &g_entities[targetNum];
ADDRLP4 0
CNSTI4 816
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1337
;1337:	if ( !target || !target->inuse || !target->client ) {
ADDRLP4 1052
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 1052
INDIRU4
EQU4 $642
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $642
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1052
INDIRU4
NEU4 $639
LABELV $642
line 1338
;1338:		return;
ADDRGP4 $633
JUMPV
LABELV $639
line 1341
;1339:	}
;1340:
;1341:	p = ConcatArgs( 2 );
CNSTI4 2
ARGI4
ADDRLP4 1056
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1056
INDIRP4
ASGNP4
line 1342
;1342:	SanitizeChatText( p );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 SanitizeChatText
CALLV
pop
line 1344
;1343:
;1344:	G_LogPrintf( "tell: %s to %s: %s\n", ent->client->pers.netname, target->client->pers.netname, p );
ADDRGP4 $643
ARGP4
ADDRLP4 1060
CNSTI4 516
ASGNI4
ADDRLP4 1064
CNSTI4 512
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 1060
INDIRI4
ADDP4
INDIRP4
ADDRLP4 1064
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 1060
INDIRI4
ADDP4
INDIRP4
ADDRLP4 1064
INDIRI4
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1345
;1345:	G_Say( ent, target, SAY_TELL, p );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1348
;1346:	// don't tell to the player self if it was already directed to this player
;1347:	// also don't send the chat back to a bot
;1348:	if ( ent != target && !(ent->r.svFlags & SVF_BOT)) {
ADDRLP4 1068
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1068
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $644
ADDRLP4 1068
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $644
line 1349
;1349:		G_Say( ent, ent, SAY_TELL, p );
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
ARGP4
ADDRLP4 1072
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1350
;1350:	}
LABELV $644
line 1351
;1351:}
LABELV $633
endproc Cmd_Tell_f 1076 16
proc G_VoiceTo 16 24
line 1354
;1352:
;1353:
;1354:static void G_VoiceTo( gentity_t *ent, gentity_t *other, int mode, const char *id, qboolean voiceonly ) {
line 1358
;1355:	int color;
;1356:	char *cmd;
;1357:
;1358:	if (!other) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $647
line 1359
;1359:		return;
ADDRGP4 $646
JUMPV
LABELV $647
line 1361
;1360:	}
;1361:	if (!other->inuse) {
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $649
line 1362
;1362:		return;
ADDRGP4 $646
JUMPV
LABELV $649
line 1364
;1363:	}
;1364:	if (!other->client) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $651
line 1365
;1365:		return;
ADDRGP4 $646
JUMPV
LABELV $651
line 1367
;1366:	}
;1367:	if ( mode == SAY_TEAM && !OnSameTeam(ent, other) ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $653
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $653
line 1368
;1368:		return;
ADDRGP4 $646
JUMPV
LABELV $653
line 1371
;1369:	}
;1370:	// no chatting to players in tournements
;1371:	if ( g_gametype.integer == GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $655
line 1372
;1372:		return;
ADDRGP4 $646
JUMPV
LABELV $655
line 1375
;1373:	}
;1374:
;1375:	if (mode == SAY_TEAM) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $658
line 1376
;1376:		color = COLOR_CYAN;
ADDRLP4 0
CNSTI4 53
ASGNI4
line 1377
;1377:		cmd = "vtchat";
ADDRLP4 4
ADDRGP4 $660
ASGNP4
line 1378
;1378:	}
ADDRGP4 $659
JUMPV
LABELV $658
line 1379
;1379:	else if (mode == SAY_TELL) {
ADDRFP4 8
INDIRI4
CNSTI4 2
NEI4 $661
line 1380
;1380:		color = COLOR_MAGENTA;
ADDRLP4 0
CNSTI4 54
ASGNI4
line 1381
;1381:		cmd = "vtell";
ADDRLP4 4
ADDRGP4 $663
ASGNP4
line 1382
;1382:	}
ADDRGP4 $662
JUMPV
LABELV $661
line 1383
;1383:	else {
line 1384
;1384:		color = COLOR_GREEN;
ADDRLP4 0
CNSTI4 50
ASGNI4
line 1385
;1385:		cmd = "vchat";
ADDRLP4 4
ADDRGP4 $664
ASGNP4
line 1386
;1386:	}
LABELV $662
LABELV $659
line 1388
;1387:
;1388:	trap_SendServerCommand( other-g_entities, va("%s %d %d %d %s", cmd, voiceonly, ent->s.number, color, id));
ADDRGP4 $665
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1389
;1389:}
LABELV $646
endproc G_VoiceTo 16 24
export G_Voice
proc G_Voice 12 20
line 1391
;1390:
;1391:void G_Voice( gentity_t *ent, gentity_t *target, int mode, const char *id, qboolean voiceonly ) {
line 1395
;1392:	int			j;
;1393:	gentity_t	*other;
;1394:
;1395:	if ( !G_IsATeamGametype(g_gametype.integer) && mode == SAY_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $667
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $667
line 1396
;1396:		mode = SAY_ALL;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 1397
;1397:	}
LABELV $667
line 1399
;1398:
;1399:	if ( target ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $670
line 1400
;1400:		G_VoiceTo( ent, target, mode, id, voiceonly );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 G_VoiceTo
CALLV
pop
line 1401
;1401:		return;
ADDRGP4 $666
JUMPV
LABELV $670
line 1405
;1402:	}
;1403:
;1404:	// echo the text to the console
;1405:	if ( g_dedicated.integer ) {
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $672
line 1406
;1406:		G_Printf( "voice: %s %s\n", ent->client->pers.netname, id);
ADDRGP4 $675
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1407
;1407:	}
LABELV $672
line 1410
;1408:
;1409:	// send it to all the apropriate clients
;1410:	for (j = 0; j < level.maxclients; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $679
JUMPV
LABELV $676
line 1411
;1411:		other = &g_entities[j];
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1412
;1412:		G_VoiceTo( ent, other, mode, id, voiceonly );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 G_VoiceTo
CALLV
pop
line 1413
;1413:	}
LABELV $677
line 1410
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $679
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $676
line 1414
;1414:}
LABELV $666
endproc G_Voice 12 20
proc Cmd_Voice_f 1060 20
line 1425
;1415:
;1416:/*
;1417:==================
;1418:Cmd_Voice_f
;1419:KK-OAX Modified this to trap args.
;1420:
;1421:In the original, every call to this function would always set "arg0" to false, and it was
;1422:never passed along to other functions, so I removed/commented it out. 
;1423:==================
;1424:*/
;1425:static void Cmd_Voice_f( gentity_t *ent ) {
line 1428
;1426:	char		*p;
;1427:    char        arg[MAX_TOKEN_CHARS];
;1428:    int         mode = SAY_ALL;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 1429
;1429:    qboolean    voiceonly = qfalse;
ADDRLP4 1032
CNSTI4 0
ASGNI4
line 1431
;1430:    
;1431:	trap_Argv( 0, arg, sizeof( arg ) );
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1432
;1432:	if ((Q_strequal( arg, "vsay_team" ) ) ||
ADDRLP4 0
ARGP4
ADDRGP4 $684
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $686
ADDRLP4 0
ARGP4
ADDRGP4 $685
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $682
LABELV $686
line 1433
;1433:	    Q_strequal( arg, "vosay_team" ) ) {
line 1434
;1434:	    mode = SAY_TEAM;
ADDRLP4 1028
CNSTI4 1
ASGNI4
line 1435
;1435:	}
LABELV $682
line 1437
;1436:	
;1437:	if((Q_strequal( arg, "vosay" ) ) ||
ADDRLP4 0
ARGP4
ADDRGP4 $689
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $690
ADDRLP4 0
ARGP4
ADDRGP4 $685
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $687
LABELV $690
line 1438
;1438:	    Q_strequal( arg, "vosay_team" ) ) {
line 1439
;1439:	    voiceonly = qtrue;
ADDRLP4 1032
CNSTI4 1
ASGNI4
line 1440
;1440:	}
LABELV $687
line 1443
;1441:    
;1442:    //KK-OAX Removed "arg0" since it will always be set to qfalse.          
;1443:	if ( trap_Argc () < 2  ) {
ADDRLP4 1052
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 2
GEI4 $691
line 1444
;1444:		return;
ADDRGP4 $681
JUMPV
LABELV $691
line 1449
;1445:	}
;1446:    //KK-OAX This was tricky to figure out, but since none of the original command handlings
;1447:    //set it to "qtrue"...
;1448:    
;1449:	p = ConcatArgs( 1 );
CNSTI4 1
ARGI4
ADDRLP4 1056
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1056
INDIRP4
ASGNP4
line 1450
;1450:	SanitizeChatText( p );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 SanitizeChatText
CALLV
pop
line 1452
;1451:
;1452:	G_Voice( ent, NULL, mode, p, voiceonly );
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1453
;1453:}
LABELV $681
endproc Cmd_Voice_f 1060 20
proc Cmd_VoiceTell_f 1084 20
line 1461
;1454:
;1455:/*
;1456:==================
;1457:Cmd_VoiceTell_f
;1458:KK-OAX Modified this to trap args. 
;1459:==================
;1460:*/
;1461:static void Cmd_VoiceTell_f( gentity_t *ent ) {
line 1466
;1462:	int			targetNum;
;1463:	gentity_t	*target;
;1464:	char		*id;
;1465:	char		arg[MAX_TOKEN_CHARS];
;1466:	qboolean    voiceonly = qfalse;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 1468
;1467:
;1468:	if ( trap_Argc () < 2 ) {
ADDRLP4 1040
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 2
GEI4 $694
line 1469
;1469:		return;
ADDRGP4 $693
JUMPV
LABELV $694
line 1472
;1470:	}
;1471:	
;1472:	trap_Argv( 0, arg, sizeof( arg ) );
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1473
;1473:	if( Q_strequal( arg, "votell" ) )
ADDRLP4 4
ARGP4
ADDRGP4 $698
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $696
line 1474
;1474:	    voiceonly = qtrue;
ADDRLP4 1036
CNSTI4 1
ASGNI4
LABELV $696
line 1476
;1475:        
;1476:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1477
;1477:	targetNum = atoi( arg );
ADDRLP4 4
ARGP4
ADDRLP4 1048
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1048
INDIRI4
ASGNI4
line 1478
;1478:	if ( targetNum < 0 || targetNum >= level.maxclients ) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
LTI4 $702
ADDRLP4 1032
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $699
LABELV $702
line 1479
;1479:		return;
ADDRGP4 $693
JUMPV
LABELV $699
line 1482
;1480:	}
;1481:
;1482:	target = &g_entities[targetNum];
ADDRLP4 0
CNSTI4 816
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1483
;1483:	if ( !target || !target->inuse || !target->client ) {
ADDRLP4 1060
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 1060
INDIRU4
EQU4 $706
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $706
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1060
INDIRU4
NEU4 $703
LABELV $706
line 1484
;1484:		return;
ADDRGP4 $693
JUMPV
LABELV $703
line 1487
;1485:	}
;1486:
;1487:	id = ConcatArgs( 2 );
CNSTI4 2
ARGI4
ADDRLP4 1064
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1064
INDIRP4
ASGNP4
line 1488
;1488:	SanitizeChatText( id );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 SanitizeChatText
CALLV
pop
line 1490
;1489:
;1490:	G_LogPrintf( "vtell: %s to %s: %s\n", ent->client->pers.netname, target->client->pers.netname, id );
ADDRGP4 $707
ARGP4
ADDRLP4 1068
CNSTI4 516
ASGNI4
ADDRLP4 1072
CNSTI4 512
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 1068
INDIRI4
ADDP4
INDIRP4
ADDRLP4 1072
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 1068
INDIRI4
ADDP4
INDIRP4
ADDRLP4 1072
INDIRI4
ADDP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1491
;1491:	G_Voice( ent, target, SAY_TELL, id, voiceonly );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1494
;1492:	// don't tell to the player self if it was already directed to this player
;1493:	// also don't send the chat back to a bot
;1494:	if ( ent != target && !(ent->r.svFlags & SVF_BOT)) {
ADDRLP4 1076
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1076
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $708
ADDRLP4 1076
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $708
line 1495
;1495:		G_Voice( ent, ent, SAY_TELL, id, voiceonly );
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 1080
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1496
;1496:	}
LABELV $708
line 1497
;1497:}
LABELV $693
endproc Cmd_VoiceTell_f 1084 20
proc Cmd_VoiceTaunt_f 60 20
line 1505
;1498:
;1499:
;1500:/*
;1501:==================
;1502:Cmd_VoiceTaunt_f
;1503:==================
;1504:*/
;1505:static void Cmd_VoiceTaunt_f( gentity_t *ent ) {
line 1509
;1506:	gentity_t *who;
;1507:	int i;
;1508:
;1509:	if (!ent->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $711
line 1510
;1510:		return;
ADDRGP4 $710
JUMPV
LABELV $711
line 1514
;1511:	}
;1512:
;1513:	// insult someone who just killed you
;1514:	if (ent->enemy && ent->enemy->client && ent->enemy->client->lastkilled_client == ent->s.number) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $713
ADDRLP4 20
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $713
ADDRLP4 20
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
INDIRI4
NEI4 $713
line 1516
;1515:		// i am a dead corpse
;1516:		if (!(ent->enemy->r.svFlags & SVF_BOT)) {
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $715
line 1517
;1517:			G_Voice( ent, ent->enemy, SAY_TELL, VOICECHAT_DEATHINSULT, qfalse );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $717
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1518
;1518:		}
LABELV $715
line 1519
;1519:		if (!(ent->r.svFlags & SVF_BOT)) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $718
line 1520
;1520:			G_Voice( ent, ent,        SAY_TELL, VOICECHAT_DEATHINSULT, qfalse );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $717
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1521
;1521:		}
LABELV $718
line 1522
;1522:		ent->enemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
CNSTP4 0
ASGNP4
line 1523
;1523:		return;
ADDRGP4 $710
JUMPV
LABELV $713
line 1526
;1524:	}
;1525:	// insult someone you just killed
;1526:	if (ent->client->lastkilled_client >= 0 && ent->client->lastkilled_client != ent->s.number) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $720
ADDRLP4 28
INDIRI4
ADDRLP4 24
INDIRP4
INDIRI4
EQI4 $720
line 1527
;1527:		who = g_entities + ent->client->lastkilled_client;
ADDRLP4 0
CNSTI4 816
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1528
;1528:		if (who->client) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $722
line 1530
;1529:			// who is the person I just killed
;1530:			if (who->client->lasthurt_mod == MOD_GAUNTLET) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 2
NEI4 $724
line 1531
;1531:				if (!(who->r.svFlags & SVF_BOT)) {
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $726
line 1532
;1532:					G_Voice( ent, who, SAY_TELL, VOICECHAT_KILLGAUNTLET, qfalse );	// and I killed them with a gauntlet
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $728
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1533
;1533:				}
LABELV $726
line 1534
;1534:				if (!(ent->r.svFlags & SVF_BOT)) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $725
line 1535
;1535:					G_Voice( ent, ent, SAY_TELL, VOICECHAT_KILLGAUNTLET, qfalse );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $728
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1536
;1536:				}
line 1537
;1537:			} else {
ADDRGP4 $725
JUMPV
LABELV $724
line 1538
;1538:				if (!(who->r.svFlags & SVF_BOT)) {
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $731
line 1539
;1539:					G_Voice( ent, who, SAY_TELL, VOICECHAT_KILLINSULT, qfalse );	// and I killed them with something else
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $733
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1540
;1540:				}
LABELV $731
line 1541
;1541:				if (!(ent->r.svFlags & SVF_BOT)) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $734
line 1542
;1542:					G_Voice( ent, ent, SAY_TELL, VOICECHAT_KILLINSULT, qfalse );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $733
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1543
;1543:				}
LABELV $734
line 1544
;1544:			}
LABELV $725
line 1545
;1545:			ent->client->lastkilled_client = -1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1124
ADDP4
CNSTI4 -1
ASGNI4
line 1546
;1546:			return;
ADDRGP4 $710
JUMPV
LABELV $722
line 1548
;1547:		}
;1548:	}
LABELV $720
line 1550
;1549:
;1550:	if (G_IsATeamGametype(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $736
line 1552
;1551:		// praise a team mate who just got a reward
;1552:		for(i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $739
line 1553
;1553:			who = g_entities + i;
ADDRLP4 0
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1554
;1554:			if (who->client && who != ent && who->client->sess.sessionTeam == ent->client->sess.sessionTeam) {
ADDRLP4 40
CNSTI4 516
ASGNI4
ADDRLP4 44
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $743
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 48
INDIRP4
CVPU4 4
EQU4 $743
ADDRLP4 52
CNSTI4 1024
ASGNI4
ADDRLP4 44
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ADDRLP4 48
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
NEI4 $743
line 1555
;1555:				if (who->client->rewardTime > level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $745
line 1556
;1556:					if (!(who->r.svFlags & SVF_BOT)) {
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $748
line 1557
;1557:						G_Voice( ent, who, SAY_TELL, VOICECHAT_PRAISE, qfalse );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $750
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1558
;1558:					}
LABELV $748
line 1559
;1559:					if (!(ent->r.svFlags & SVF_BOT)) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $710
line 1560
;1560:						G_Voice( ent, ent, SAY_TELL, VOICECHAT_PRAISE, qfalse );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $750
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1561
;1561:					}
line 1562
;1562:					return;
ADDRGP4 $710
JUMPV
LABELV $745
line 1564
;1563:				}
;1564:			}
LABELV $743
line 1565
;1565:		}
LABELV $740
line 1552
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $739
line 1566
;1566:	}
LABELV $736
line 1569
;1567:
;1568:	// just say something
;1569:	G_Voice( ent, NULL, SAY_ALL, VOICECHAT_TAUNT, qfalse );
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 $753
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 G_Voice
CALLV
pop
line 1570
;1570:}
LABELV $710
endproc Cmd_VoiceTaunt_f 60 20
data
align 4
LABELV gc_orders
address $754
address $755
address $756
address $757
address $758
address $759
address $760
lit
align 4
LABELV numgc_orders
byte 4 7
export Cmd_GameCommand_f
code
proc Cmd_GameCommand_f 1088 16
line 1586
;1571:
;1572:
;1573:
;1574:static char	*gc_orders[] = {
;1575:	"hold your position",
;1576:	"hold this position",
;1577:	"come here",
;1578:	"cover me",
;1579:	"guard location",
;1580:	"search and destroy",
;1581:	"report"
;1582:};
;1583:
;1584:static const int numgc_orders = ARRAY_LEN( gc_orders );
;1585:
;1586:void Cmd_GameCommand_f( gentity_t *ent ) {
line 1592
;1587:	int			targetNum;
;1588:	gentity_t	*target;
;1589:	int			order;
;1590:	char		arg[MAX_TOKEN_CHARS];
;1591: 
;1592:	if ( trap_Argc() != 3 ) {
ADDRLP4 1036
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 3
EQI4 $762
line 1593
;1593:		trap_SendServerCommand( ent-g_entities, va( "print \"Usage: gc <player id> <order 0-%d>\n\"", numgc_orders - 1 ) );
ADDRGP4 $764
ARGP4
ADDRGP4 numgc_orders
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 1040
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1594
;1594:		return;
ADDRGP4 $761
JUMPV
LABELV $762
line 1597
;1595:	}
;1596: 
;1597:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1598
;1598:	targetNum = ClientNumberFromString( ent, arg, qtrue, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 1040
CNSTI4 1
ASGNI4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1044
ADDRGP4 ClientNumberFromString
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1044
INDIRI4
ASGNI4
line 1599
;1599:	if ( targetNum == -1 ) {
ADDRLP4 1032
INDIRI4
CNSTI4 -1
NEI4 $765
line 1600
;1600: 		return;
ADDRGP4 $761
JUMPV
LABELV $765
line 1603
;1601: 	}
;1602:
;1603:	target = &g_entities[targetNum];
ADDRLP4 0
CNSTI4 816
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1604
;1604:	if ( !target || !target->inuse || !target->client ) {
ADDRLP4 1052
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 1052
INDIRU4
EQU4 $770
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $770
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1052
INDIRU4
NEU4 $767
LABELV $770
line 1605
;1605: 		return;
ADDRGP4 $761
JUMPV
LABELV $767
line 1608
;1606: 	}
;1607:
;1608:	trap_Argv( 2, arg, sizeof( arg ) );
CNSTI4 2
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1609
;1609:	order = atoi( arg );
ADDRLP4 8
ARGP4
ADDRLP4 1056
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1056
INDIRI4
ASGNI4
line 1611
;1610:
;1611:	if ( order < 0 || order >= numgc_orders ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $773
ADDRLP4 4
INDIRI4
ADDRGP4 numgc_orders
INDIRI4
LTI4 $771
LABELV $773
line 1612
;1612:		trap_SendServerCommand( ent-g_entities, va("print \"Bad order: %i\n\"", order));
ADDRGP4 $774
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1064
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1613
;1613:		return;
ADDRGP4 $761
JUMPV
LABELV $771
line 1616
;1614:	}
;1615:
;1616:	G_LogPrintf( "tell: %s to %s: %s\n", ent->client->pers.netname, target->client->pers.netname, gc_orders[order] );
ADDRGP4 $643
ARGP4
ADDRLP4 1064
CNSTI4 516
ASGNI4
ADDRLP4 1068
CNSTI4 512
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 1064
INDIRI4
ADDP4
INDIRP4
ADDRLP4 1068
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 1064
INDIRI4
ADDP4
INDIRP4
ADDRLP4 1068
INDIRI4
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gc_orders
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1617
;1617:	G_Say( ent, target, SAY_TELL, gc_orders[order] );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1072
CNSTI4 2
ASGNI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 1072
INDIRI4
LSHI4
ADDRGP4 gc_orders
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1620
;1618:	// don't tell to the player self if it was already directed to this player
;1619:	// also don't send the chat back to a bot
;1620:	if ( ent != target && !(ent->r.svFlags & SVF_BOT)) {
ADDRLP4 1076
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1076
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $775
ADDRLP4 1076
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $775
line 1621
;1621:		G_Say( ent, ent, SAY_TELL, gc_orders[order] );
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 1084
CNSTI4 2
ASGNI4
ADDRLP4 1084
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 1084
INDIRI4
LSHI4
ADDRGP4 gc_orders
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1622
;1622:	}
LABELV $775
line 1623
;1623:}
LABELV $761
endproc Cmd_GameCommand_f 1088 16
export Cmd_Where_f
proc Cmd_Where_f 8 8
line 1630
;1624:
;1625:/*
;1626:==================
;1627:Cmd_Where_f
;1628:==================
;1629:*/
;1630:void Cmd_Where_f( gentity_t *ent ) {
line 1631
;1631:	trap_SendServerCommand( ent-g_entities, va("print \"%s\n\"", vtos(ent->r.currentOrigin) ) );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $778
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1632
;1632:}
LABELV $777
endproc Cmd_Where_f 8 8
data
align 4
LABELV gameNames
address $779
address $780
address $781
address $782
address $783
address $784
address $785
address $786
address $787
address $788
address $789
address $790
address $791
address $792
export Cmd_CallVote_f
code
proc Cmd_CallVote_f 3400 24
line 1658
;1633:
;1634:static const char *gameNames[] = {
;1635:	"Free For All",
;1636:	"Tournament",
;1637:	"Single Player",
;1638:	"Team Deathmatch",
;1639:	"Capture the Flag",
;1640:	"One Flag CTF",
;1641:	"Overload",
;1642:	"Harvester",
;1643:	"Elimination",
;1644:	"CTF Elimination",
;1645:	"Last Man Standing",
;1646:	"Double Domination",
;1647:	"Domination",
;1648:	"Possession"
;1649:};
;1650:
;1651:
;1652:
;1653:/*
;1654:==================
;1655:Cmd_CallVote_f
;1656:==================
;1657:*/
;1658:void Cmd_CallVote_f( gentity_t *ent ) {
line 1665
;1659:	char*	c;
;1660:	int		i;
;1661:	char	arg1[MAX_STRING_TOKENS];
;1662:	char	arg2[MAX_STRING_TOKENS];
;1663:	char    buffer[256];
;1664:
;1665:	if ( !g_allowVote.integer ) {
ADDRGP4 g_allowVote+12
INDIRI4
CNSTI4 0
NEI4 $794
line 1666
;1666:		trap_SendServerCommand( ent-g_entities, "print \"Voting not allowed here.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $797
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1667
;1667:		return;
ADDRGP4 $793
JUMPV
LABELV $794
line 1670
;1668:	}
;1669:
;1670:	if ( level.voteTime ) {
ADDRGP4 level+2404
INDIRI4
CNSTI4 0
EQI4 $798
line 1671
;1671:		trap_SendServerCommand( ent-g_entities, "print \"A vote is already in progress.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $801
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1672
;1672:		return;
ADDRGP4 $793
JUMPV
LABELV $798
line 1674
;1673:	}
;1674:	if ( ent->client->pers.voteCount >= g_maxvotes.integer ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
ADDRGP4 g_maxvotes+12
INDIRI4
LTI4 $802
line 1675
;1675:		trap_SendServerCommand( ent-g_entities, "print \"You have called the maximum number of votes.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $805
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1676
;1676:		return;
ADDRGP4 $793
JUMPV
LABELV $802
line 1678
;1677:	}
;1678:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $806
line 1679
;1679:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to call a vote as spectator.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $808
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1680
;1680:		return;
ADDRGP4 $793
JUMPV
LABELV $806
line 1684
;1681:	}
;1682:
;1683:	// make sure it is a valid command to vote on
;1684:	trap_Argv( 1, arg1, sizeof( arg1 ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1685
;1685:	trap_Argv( 2, arg2, sizeof( arg2 ) );
CNSTI4 2
ARGI4
ADDRLP4 1288
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1688
;1686:
;1687:	// check for command separators in arg2
;1688:	for( c = arg2; *c; ++c) {
ADDRLP4 4
ADDRLP4 1288
ASGNP4
ADDRGP4 $812
JUMPV
LABELV $809
line 1689
;1689:		switch(*c) {
ADDRLP4 2312
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2320
CNSTI4 10
ASGNI4
ADDRLP4 2312
INDIRI4
ADDRLP4 2320
INDIRI4
EQI4 $816
ADDRLP4 2312
INDIRI4
CNSTI4 13
EQI4 $816
ADDRLP4 2312
INDIRI4
ADDRLP4 2320
INDIRI4
LTI4 $813
LABELV $818
ADDRLP4 2312
INDIRI4
CNSTI4 59
EQI4 $816
ADDRGP4 $813
JUMPV
LABELV $816
line 1693
;1690:			case '\n':
;1691:			case '\r':
;1692:			case ';':
;1693:				trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $817
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1694
;1694:				return;
ADDRGP4 $793
JUMPV
line 1695
;1695:			break;
LABELV $813
line 1697
;1696:		}
;1697:	}
LABELV $810
line 1688
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $812
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $809
line 1700
;1698:
;1699:
;1700:	if ( Q_strequal( arg1, "map_restart" ) ) {
ADDRLP4 8
ARGP4
ADDRGP4 $821
ARGP4
ADDRLP4 2312
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2312
INDIRI4
CNSTI4 0
NEI4 $819
line 1701
;1701:	} else if ( Q_strequal( arg1, "nextmap" ) ) {
ADDRGP4 $820
JUMPV
LABELV $819
ADDRLP4 8
ARGP4
ADDRGP4 $824
ARGP4
ADDRLP4 2316
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2316
INDIRI4
CNSTI4 0
NEI4 $822
line 1702
;1702:	} else if ( Q_strequal( arg1, "map" ) ) {
ADDRGP4 $823
JUMPV
LABELV $822
ADDRLP4 8
ARGP4
ADDRGP4 $827
ARGP4
ADDRLP4 2320
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2320
INDIRI4
CNSTI4 0
NEI4 $825
line 1703
;1703:	} else if ( Q_strequal( arg1, "g_gametype" ) ) {
ADDRGP4 $826
JUMPV
LABELV $825
ADDRLP4 8
ARGP4
ADDRGP4 $830
ARGP4
ADDRLP4 2324
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2324
INDIRI4
CNSTI4 0
NEI4 $828
line 1704
;1704:	} else if ( Q_strequal( arg1, "kick" ) ) {
ADDRGP4 $829
JUMPV
LABELV $828
ADDRLP4 8
ARGP4
ADDRGP4 $833
ARGP4
ADDRLP4 2328
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2328
INDIRI4
CNSTI4 0
NEI4 $831
line 1705
;1705:	} else if ( Q_strequal( arg1, "clientkick" ) ) {
ADDRGP4 $832
JUMPV
LABELV $831
ADDRLP4 8
ARGP4
ADDRGP4 $836
ARGP4
ADDRLP4 2332
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2332
INDIRI4
CNSTI4 0
NEI4 $834
line 1706
;1706:	} else if ( Q_strequal( arg1, "g_doWarmup" ) ) {
ADDRGP4 $835
JUMPV
LABELV $834
ADDRLP4 8
ARGP4
ADDRGP4 $839
ARGP4
ADDRLP4 2336
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2336
INDIRI4
CNSTI4 0
NEI4 $837
line 1707
;1707:	} else if ( Q_strequal( arg1, "timelimit" ) ) {
ADDRGP4 $838
JUMPV
LABELV $837
ADDRLP4 8
ARGP4
ADDRGP4 $842
ARGP4
ADDRLP4 2340
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2340
INDIRI4
CNSTI4 0
NEI4 $840
line 1708
;1708:	} else if ( Q_strequal( arg1, "fraglimit" ) ) {
ADDRGP4 $841
JUMPV
LABELV $840
ADDRLP4 8
ARGP4
ADDRGP4 $845
ARGP4
ADDRLP4 2344
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2344
INDIRI4
CNSTI4 0
NEI4 $843
line 1709
;1709:	} else if ( Q_strequal( arg1, "custom" ) ) {
ADDRGP4 $844
JUMPV
LABELV $843
ADDRLP4 8
ARGP4
ADDRGP4 $848
ARGP4
ADDRLP4 2348
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2348
INDIRI4
CNSTI4 0
NEI4 $846
line 1710
;1710:	} else if ( Q_strequal( arg1, "shuffle" ) ) {
ADDRGP4 $847
JUMPV
LABELV $846
ADDRLP4 8
ARGP4
ADDRGP4 $851
ARGP4
ADDRLP4 2352
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2352
INDIRI4
CNSTI4 0
NEI4 $849
line 1711
;1711:	} else {
ADDRGP4 $850
JUMPV
LABELV $849
line 1712
;1712:		trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $817
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1714
;1713:		//trap_SendServerCommand( ent-g_entities, "print \"Vote commands are: map_restart, nextmap, map <mapname>, g_gametype <n>, kick <player>, clientkick <clientnum>, g_doWarmup, timelimit <time>, fraglimit <frags>.\n\"" );
;1714:		buffer[0] = 0;
ADDRLP4 1032
CNSTI1 0
ASGNI1
line 1715
;1715:		strcat(buffer,"print \"Vote commands are: ");
ADDRLP4 1032
ARGP4
ADDRGP4 $852
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1716
;1716:		if(allowedVote("map_restart"))
ADDRGP4 $821
ARGP4
ADDRLP4 2356
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2356
INDIRI4
CNSTI4 0
EQI4 $853
line 1717
;1717:			strcat(buffer, "map_restart, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $855
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $853
line 1718
;1718:		if(allowedVote("nextmap"))
ADDRGP4 $824
ARGP4
ADDRLP4 2360
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2360
INDIRI4
CNSTI4 0
EQI4 $856
line 1719
;1719:			strcat(buffer, "nextmap, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $858
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $856
line 1720
;1720:		if(allowedVote("map"))
ADDRGP4 $827
ARGP4
ADDRLP4 2364
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2364
INDIRI4
CNSTI4 0
EQI4 $859
line 1721
;1721:			strcat(buffer, "map <mapname>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $861
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $859
line 1722
;1722:		if(allowedVote("g_gametype"))
ADDRGP4 $830
ARGP4
ADDRLP4 2368
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2368
INDIRI4
CNSTI4 0
EQI4 $862
line 1723
;1723:			strcat(buffer, "g_gametype <n>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $864
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $862
line 1724
;1724:		if(allowedVote("kick"))
ADDRGP4 $833
ARGP4
ADDRLP4 2372
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2372
INDIRI4
CNSTI4 0
EQI4 $865
line 1725
;1725:			strcat(buffer, "kick <player>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $867
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $865
line 1726
;1726:		if(allowedVote("clientkick"))
ADDRGP4 $836
ARGP4
ADDRLP4 2376
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2376
INDIRI4
CNSTI4 0
EQI4 $868
line 1727
;1727:			strcat(buffer, "clientkick <clientnum>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $870
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $868
line 1728
;1728:		if(allowedVote("g_doWarmup"))
ADDRGP4 $839
ARGP4
ADDRLP4 2380
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2380
INDIRI4
CNSTI4 0
EQI4 $871
line 1729
;1729:			strcat(buffer, "g_doWarmup, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $873
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $871
line 1730
;1730:		if(allowedVote("timelimit"))
ADDRGP4 $842
ARGP4
ADDRLP4 2384
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2384
INDIRI4
CNSTI4 0
EQI4 $874
line 1731
;1731:			strcat(buffer, "timelimit <time>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $876
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $874
line 1732
;1732:		if(allowedVote("fraglimit"))
ADDRGP4 $845
ARGP4
ADDRLP4 2388
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2388
INDIRI4
CNSTI4 0
EQI4 $877
line 1733
;1733:			strcat(buffer, "fraglimit <frags>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $879
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $877
line 1734
;1734:		if(allowedVote("shuffle"))
ADDRGP4 $851
ARGP4
ADDRLP4 2392
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2392
INDIRI4
CNSTI4 0
EQI4 $880
line 1735
;1735:			strcat(buffer, "shuffle, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $882
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $880
line 1736
;1736:		if(allowedVote("custom"))
ADDRGP4 $848
ARGP4
ADDRLP4 2396
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2396
INDIRI4
CNSTI4 0
EQI4 $883
line 1737
;1737:			strcat(buffer, "custom <special>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $885
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $883
line 1738
;1738:		buffer[strlen(buffer)-2] = 0;
ADDRLP4 1032
ARGP4
ADDRLP4 2400
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2400
INDIRI4
ADDRLP4 1032-2
ADDP4
CNSTI1 0
ASGNI1
line 1739
;1739:		strcat(buffer, ".\"");
ADDRLP4 1032
ARGP4
ADDRGP4 $887
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1740
;1740:		trap_SendServerCommand( ent-g_entities, buffer);
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 1032
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1741
;1741:		return;
ADDRGP4 $793
JUMPV
LABELV $850
LABELV $847
LABELV $844
LABELV $841
LABELV $838
LABELV $835
LABELV $832
LABELV $829
LABELV $826
LABELV $823
LABELV $820
line 1744
;1742:	}
;1743:        
;1744:	if(!allowedVote(arg1)) {
ADDRLP4 8
ARGP4
ADDRLP4 2356
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2356
INDIRI4
CNSTI4 0
NEI4 $888
line 1745
;1745:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed here.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $890
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1746
;1746:		buffer[0] = 0;
ADDRLP4 1032
CNSTI1 0
ASGNI1
line 1747
;1747:		strcat(buffer,"print \"Vote commands are: ");
ADDRLP4 1032
ARGP4
ADDRGP4 $852
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1748
;1748:		if(allowedVote("map_restart"))
ADDRGP4 $821
ARGP4
ADDRLP4 2360
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2360
INDIRI4
CNSTI4 0
EQI4 $891
line 1749
;1749:			strcat(buffer, "map_restart, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $855
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $891
line 1750
;1750:		if(allowedVote("nextmap"))
ADDRGP4 $824
ARGP4
ADDRLP4 2364
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2364
INDIRI4
CNSTI4 0
EQI4 $893
line 1751
;1751:			strcat(buffer, "nextmap, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $858
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $893
line 1752
;1752:		if(allowedVote("map"))
ADDRGP4 $827
ARGP4
ADDRLP4 2368
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2368
INDIRI4
CNSTI4 0
EQI4 $895
line 1753
;1753:			strcat(buffer, "map <mapname>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $861
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $895
line 1754
;1754:		if(allowedVote("g_gametype"))
ADDRGP4 $830
ARGP4
ADDRLP4 2372
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2372
INDIRI4
CNSTI4 0
EQI4 $897
line 1755
;1755:			strcat(buffer, "g_gametype <n>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $864
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $897
line 1756
;1756:		if(allowedVote("kick"))
ADDRGP4 $833
ARGP4
ADDRLP4 2376
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2376
INDIRI4
CNSTI4 0
EQI4 $899
line 1757
;1757:			strcat(buffer, "kick <player>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $867
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $899
line 1758
;1758:		if(allowedVote("clientkick"))
ADDRGP4 $836
ARGP4
ADDRLP4 2380
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2380
INDIRI4
CNSTI4 0
EQI4 $901
line 1759
;1759:			strcat(buffer, "clientkick <clientnum>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $870
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $901
line 1760
;1760:		if(allowedVote("shuffle"))
ADDRGP4 $851
ARGP4
ADDRLP4 2384
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2384
INDIRI4
CNSTI4 0
EQI4 $903
line 1761
;1761:			strcat(buffer, "shuffle, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $882
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $903
line 1762
;1762:		if(allowedVote("g_doWarmup"))
ADDRGP4 $839
ARGP4
ADDRLP4 2388
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2388
INDIRI4
CNSTI4 0
EQI4 $905
line 1763
;1763:			strcat(buffer, "g_doWarmup, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $873
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $905
line 1764
;1764:		if(allowedVote("timelimit"))
ADDRGP4 $842
ARGP4
ADDRLP4 2392
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2392
INDIRI4
CNSTI4 0
EQI4 $907
line 1765
;1765:			strcat(buffer, "timelimit <time>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $876
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $907
line 1766
;1766:		if(allowedVote("fraglimit"))
ADDRGP4 $845
ARGP4
ADDRLP4 2396
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2396
INDIRI4
CNSTI4 0
EQI4 $909
line 1767
;1767:			strcat(buffer, "fraglimit <frags>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $879
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $909
line 1768
;1768:		if(allowedVote("custom"))
ADDRGP4 $848
ARGP4
ADDRLP4 2400
ADDRGP4 allowedVote
CALLI4
ASGNI4
ADDRLP4 2400
INDIRI4
CNSTI4 0
EQI4 $911
line 1769
;1769:			strcat(buffer, "custom <special>, ");
ADDRLP4 1032
ARGP4
ADDRGP4 $885
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $911
line 1770
;1770:		buffer[strlen(buffer)-2] = 0;
ADDRLP4 1032
ARGP4
ADDRLP4 2404
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2404
INDIRI4
ADDRLP4 1032-2
ADDP4
CNSTI1 0
ASGNI1
line 1771
;1771:		strcat(buffer, ".\"");
ADDRLP4 1032
ARGP4
ADDRGP4 $887
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1772
;1772:		trap_SendServerCommand( ent-g_entities, buffer);
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 1032
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1773
;1773:		return;
ADDRGP4 $793
JUMPV
LABELV $888
line 1777
;1774:	}
;1775:
;1776:	// if there is still a vote to be executed
;1777:	if ( level.voteExecuteTime ) {
ADDRGP4 level+2408
INDIRI4
CNSTI4 0
EQI4 $914
line 1779
;1778:		// don't start a vote when map change or restart is in progress
;1779:		if ( !Q_stricmpn( level.voteString, "map", 3 )
ADDRGP4 level+356
ARGP4
ADDRGP4 $827
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 2360
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 2360
INDIRI4
CNSTI4 0
EQI4 $921
ADDRGP4 level+356
ARGP4
ADDRGP4 $824
ARGP4
CNSTI4 7
ARGI4
ADDRLP4 2364
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 2364
INDIRI4
CNSTI4 0
NEI4 $917
LABELV $921
line 1780
;1780:			|| !Q_stricmpn( level.voteString, "nextmap", 7 ) ) {
line 1781
;1781:			trap_SendServerCommand( ent-g_entities, "print \"Vote after map change.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $922
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1782
;1782:			return;
ADDRGP4 $793
JUMPV
LABELV $917
line 1785
;1783:		}
;1784:
;1785:		level.voteExecuteTime = 0;
ADDRGP4 level+2408
CNSTI4 0
ASGNI4
line 1786
;1786:		trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.voteString ) );
ADDRGP4 $924
ARGP4
ADDRGP4 level+356
ARGP4
ADDRLP4 2368
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 2368
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1787
;1787:	}
LABELV $914
line 1789
;1788:
;1789:	level.voteKickClient = -1; //not a client
ADDRGP4 level+2424
CNSTI4 -1
ASGNI4
line 1790
;1790:	level.voteKickType = 0; //not a ban
ADDRGP4 level+2428
CNSTI4 0
ASGNI4
line 1791
;1791:	level.voteDisplayString[0] = 0;
ADDRGP4 level+1380
CNSTI1 0
ASGNI1
line 1794
;1792:
;1793:	// special case for g_gametype, check for bad values
;1794:	if ( Q_strequal( arg1, "g_gametype" ) ) {
ADDRLP4 8
ARGP4
ADDRGP4 $830
ARGP4
ADDRLP4 2360
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2360
INDIRI4
CNSTI4 0
NEI4 $929
line 1796
;1795:		char	s[MAX_STRING_CHARS];
;1796:		i = atoi( arg2 );
ADDRLP4 1288
ARGP4
ADDRLP4 3388
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3388
INDIRI4
ASGNI4
line 1797
;1797:		if( i == GT_SINGLE_PLAYER || i < GT_FFA || i >= GT_MAX_GAME_TYPE) {
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $934
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $934
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $931
LABELV $934
line 1798
;1798:			trap_SendServerCommand( ent-g_entities, "print \"Invalid gametype.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $935
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1799
;1799:			return;
ADDRGP4 $793
JUMPV
LABELV $931
line 1802
;1800:		}
;1801:
;1802:		if( i== g_gametype.integer ) {
ADDRLP4 0
INDIRI4
ADDRGP4 g_gametype+12
INDIRI4
NEI4 $936
line 1803
;1803:			trap_SendServerCommand( ent-g_entities, "print \"This is current gametype\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $939
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1804
;1804:			return;
ADDRGP4 $793
JUMPV
LABELV $936
line 1807
;1805:		}
;1806:                
;1807:		if(!allowedGametype(arg2)){
ADDRLP4 1288
ARGP4
ADDRLP4 3396
ADDRGP4 allowedGametype
CALLI4
ASGNI4
ADDRLP4 3396
INDIRI4
CNSTI4 0
NEI4 $940
line 1808
;1808:			trap_SendServerCommand( ent-g_entities, "print \"Gametype is not available.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $942
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1809
;1809:			return;
ADDRGP4 $793
JUMPV
LABELV $940
line 1812
;1810:		}
;1811:
;1812:		trap_Cvar_VariableStringBuffer( "nextmap", s, sizeof(s) );
ADDRGP4 $824
ARGP4
ADDRLP4 2364
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1813
;1813:		if (*s) {
ADDRLP4 2364
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $943
line 1814
;1814:			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %d; map_restart; set nextmap \"%s\"", arg1, i,s );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $947
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2364
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1815
;1815:			Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Change gametype to: %s?", gameNames[i] );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $950
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gameNames
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1816
;1816:		} else {
ADDRGP4 $930
JUMPV
LABELV $943
line 1817
;1817:			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %d; map_restart", arg1, i );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $953
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1818
;1818:			Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Change gametype to: %s?", gameNames[i] );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $950
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gameNames
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1819
;1819:		}
line 1820
;1820:	} else if ( Q_strequal( arg1, "map" ) ) {
ADDRGP4 $930
JUMPV
LABELV $929
ADDRLP4 8
ARGP4
ADDRGP4 $827
ARGP4
ADDRLP4 2364
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2364
INDIRI4
CNSTI4 0
NEI4 $956
line 1825
;1821:		// special case for map changes, we want to reset the nextmap setting
;1822:		// this allows a player to change maps, but not upset the map rotation
;1823:		char	s[MAX_STRING_CHARS];
;1824:                
;1825:		if(!allowedMap(arg2)){
ADDRLP4 1288
ARGP4
ADDRLP4 3392
ADDRGP4 allowedMap
CALLI4
ASGNI4
ADDRLP4 3392
INDIRI4
CNSTI4 0
NEI4 $958
line 1826
;1826:			trap_SendServerCommand( ent-g_entities, "print \"Map is not available.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $960
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1827
;1827:			return;
ADDRGP4 $793
JUMPV
LABELV $958
line 1830
;1828:		}
;1829:
;1830:		trap_Cvar_VariableStringBuffer( "nextmap", s, sizeof(s) );
ADDRGP4 $824
ARGP4
ADDRLP4 2368
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1831
;1831:		if (*s) {
ADDRLP4 2368
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $961
line 1832
;1832:			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %s; set nextmap \"%s\"", arg1, arg2, s );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $965
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 1288
ARGP4
ADDRLP4 2368
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1833
;1833:		} else {
ADDRGP4 $962
JUMPV
LABELV $961
line 1834
;1834:			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %s", arg1, arg2 );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $968
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 1288
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1835
;1835:		}
LABELV $962
line 1837
;1836:		//Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.voteString );
;1837:                Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Change map to: %s?", arg2 );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $971
ARGP4
ADDRLP4 1288
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1838
;1838:	} else if ( Q_strequal( arg1, "nextmap" ) ) {
ADDRGP4 $957
JUMPV
LABELV $956
ADDRLP4 8
ARGP4
ADDRGP4 $824
ARGP4
ADDRLP4 2368
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2368
INDIRI4
CNSTI4 0
NEI4 $972
line 1847
;1839:		char	s[MAX_STRING_CHARS];
;1840:
;1841:		//Sago: Needs to think about this, we miss code to parse if nextmap has arg2
;1842:		/*if(!allowedMap(arg2)){
;1843:			trap_SendServerCommand( ent-g_entities, "print \"Map is not available.\n\"" );
;1844:			return;
;1845:		}*/
;1846:
;1847:		if(g_autonextmap.integer) {
ADDRGP4 g_autonextmap+12
INDIRI4
CNSTI4 0
EQI4 $974
line 1848
;1848:			Com_sprintf( level.voteString, sizeof( level.voteString ), "endgamenow");
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $979
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1849
;1849:		} 
ADDRGP4 $975
JUMPV
LABELV $974
line 1850
;1850:		else {
line 1851
;1851:			trap_Cvar_VariableStringBuffer( "nextmap", s, sizeof(s) );
ADDRGP4 $824
ARGP4
ADDRLP4 2372
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1852
;1852:			if (s[0] == '\0') {
ADDRLP4 2372
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $980
line 1853
;1853:				trap_SendServerCommand( ent-g_entities, "print \"nextmap not set.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $982
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1854
;1854:				return;
ADDRGP4 $793
JUMPV
LABELV $980
line 1856
;1855:			}
;1856:			Com_sprintf( level.voteString, sizeof( level.voteString ), "vstr nextmap");
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $985
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1857
;1857:		}
LABELV $975
line 1859
;1858:		//Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.voteString );
;1859:		Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", "Next map?" );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $988
ARGP4
ADDRGP4 $989
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1860
;1860:	} else if ( Q_strequal( arg1, "fraglimit" ) ) {
ADDRGP4 $973
JUMPV
LABELV $972
ADDRLP4 8
ARGP4
ADDRGP4 $845
ARGP4
ADDRLP4 2372
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2372
INDIRI4
CNSTI4 0
NEI4 $990
line 1861
;1861:		i = atoi(arg2);
ADDRLP4 1288
ARGP4
ADDRLP4 2376
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 2376
INDIRI4
ASGNI4
line 1862
;1862:		if(!allowedFraglimit(i)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2380
ADDRGP4 allowedFraglimit
CALLI4
ASGNI4
ADDRLP4 2380
INDIRI4
CNSTI4 0
NEI4 $992
line 1863
;1863:			trap_SendServerCommand( ent-g_entities, "print \"Cannot set fraglimit.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $994
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1864
;1864:			return;
ADDRGP4 $793
JUMPV
LABELV $992
line 1867
;1865:		}
;1866:
;1867:		Com_sprintf( level.voteString, sizeof( level.voteString ), "%s \"%d\"", arg1, i );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $997
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1868
;1868:		if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $998
line 1869
;1869:			Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Change fraglimit to: %d", i );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1002
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1870
;1870:		}
ADDRGP4 $991
JUMPV
LABELV $998
line 1871
;1871:		else {
line 1872
;1872:			Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Remove fraglimit?");
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1005
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1873
;1873:		}
line 1874
;1874:	} 
ADDRGP4 $991
JUMPV
LABELV $990
line 1875
;1875:	else if ( Q_strequal( arg1, "timelimit" ) ) {
ADDRLP4 8
ARGP4
ADDRGP4 $842
ARGP4
ADDRLP4 2376
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2376
INDIRI4
CNSTI4 0
NEI4 $1006
line 1876
;1876:		i = atoi(arg2);
ADDRLP4 1288
ARGP4
ADDRLP4 2380
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 2380
INDIRI4
ASGNI4
line 1877
;1877:		if(!allowedTimelimit(i)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2384
ADDRGP4 allowedTimelimit
CALLI4
ASGNI4
ADDRLP4 2384
INDIRI4
CNSTI4 0
NEI4 $1008
line 1878
;1878:			trap_SendServerCommand( ent-g_entities, "print \"Cannot set timelimit.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1010
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1879
;1879:			return;
ADDRGP4 $793
JUMPV
LABELV $1008
line 1882
;1880:		}
;1881:
;1882:		Com_sprintf( level.voteString, sizeof( level.voteString ), "%s \"%d\"", arg1, i );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $997
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1883
;1883:		if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1013
line 1884
;1884:			Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Change timelimit to: %d", i );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1017
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1885
;1885:		}
ADDRGP4 $1007
JUMPV
LABELV $1013
line 1886
;1886:		else {
line 1887
;1887:			Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Remove timelimit?" );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1020
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1888
;1888:		}
line 1889
;1889:	} 
ADDRGP4 $1007
JUMPV
LABELV $1006
line 1890
;1890:	else if ( Q_strequal( arg1, "map_restart" ) ) {
ADDRLP4 8
ARGP4
ADDRGP4 $821
ARGP4
ADDRLP4 2380
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2380
INDIRI4
CNSTI4 0
NEI4 $1021
line 1891
;1891:		Com_sprintf( level.voteString, sizeof( level.voteString ), "map_restart" );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $821
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1892
;1892:		Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Restart map?" );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1027
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1893
;1893:	} else if ( Q_strequal( arg1, "g_doWarmup" ) ) {
ADDRGP4 $1022
JUMPV
LABELV $1021
ADDRLP4 8
ARGP4
ADDRGP4 $839
ARGP4
ADDRLP4 2384
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2384
INDIRI4
CNSTI4 0
NEI4 $1028
line 1894
;1894:		i = atoi(arg2);
ADDRLP4 1288
ARGP4
ADDRLP4 2388
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 2388
INDIRI4
ASGNI4
line 1895
;1895:		if(i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1030
line 1896
;1896:			Com_sprintf( level.voteString, sizeof( level.voteString ), "g_doWarmup \"1\"" );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1034
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1897
;1897:			Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Enable warmup?" );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1037
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1898
;1898:		}
ADDRGP4 $1029
JUMPV
LABELV $1030
line 1899
;1899:		else {
line 1900
;1900:			Com_sprintf( level.voteString, sizeof( level.voteString ), "g_doWarmup \"0\"" );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1040
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1901
;1901:			Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Disable warmup?" );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1043
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1902
;1902:		}
line 1903
;1903:	} else if ( Q_strequal( arg1, "clientkick" ) ) {
ADDRGP4 $1029
JUMPV
LABELV $1028
ADDRLP4 8
ARGP4
ADDRGP4 $836
ARGP4
ADDRLP4 2388
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2388
INDIRI4
CNSTI4 0
NEI4 $1044
line 1904
;1904:		i = atoi(arg2);
ADDRLP4 1288
ARGP4
ADDRLP4 2392
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 2392
INDIRI4
ASGNI4
line 1906
;1905:
;1906:		if(i>=MAX_CLIENTS) { //Only numbers <128 is clients
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1046
line 1907
;1907:			trap_SendServerCommand( ent-g_entities, "print \"Cannot kick that number.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1048
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1908
;1908:			return;
ADDRGP4 $793
JUMPV
LABELV $1046
line 1910
;1909:		}
;1910:		level.voteKickClient = i;
ADDRGP4 level+2424
ADDRLP4 0
INDIRI4
ASGNI4
line 1911
;1911:		if(g_voteBan.integer<1) {
ADDRGP4 g_voteBan+12
INDIRI4
CNSTI4 1
GEI4 $1050
line 1912
;1912:			Com_sprintf( level.voteString, sizeof( level.voteString ), "clientkick_game \"%d\"", i );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1055
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1913
;1913:		} else {
ADDRGP4 $1051
JUMPV
LABELV $1050
line 1914
;1914:			Com_sprintf( level.voteString, sizeof( level.voteString ), "!ban \"%d\" \"%dm\" \"Banned by public vote\"", i, g_voteBan.integer );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1058
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 g_voteBan+12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1915
;1915:			level.voteKickType = 1; //ban
ADDRGP4 level+2428
CNSTI4 1
ASGNI4
line 1916
;1916:		}
LABELV $1051
line 1917
;1917:		Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Kick %s?" , level.clients[i].pers.netname );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1063
ARGP4
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1918
;1918:	} 
ADDRGP4 $1045
JUMPV
LABELV $1044
line 1919
;1919:	else if ( Q_strequal( arg1, "shuffle" ) ) {
ADDRLP4 8
ARGP4
ADDRGP4 $851
ARGP4
ADDRLP4 2392
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2392
INDIRI4
CNSTI4 0
NEI4 $1064
line 1920
;1920:		if(!G_IsATeamGametype(g_gametype.integer)) { //Not a team game
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 2396
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 2396
INDIRI4
CNSTI4 0
NEI4 $1066
line 1921
;1921:			trap_SendServerCommand( ent-g_entities, "print \"Can only be used in team games.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1069
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1922
;1922:			return;
ADDRGP4 $793
JUMPV
LABELV $1066
line 1925
;1923:		}
;1924:
;1925:		Com_sprintf( level.voteString, sizeof( level.voteString ), "shuffle" );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $851
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1926
;1926:		Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Shuffle teams?" );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1074
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1927
;1927:	} 
ADDRGP4 $1065
JUMPV
LABELV $1064
line 1928
;1928:	else if ( Q_strequal( arg1, "kick" ) ) {
ADDRLP4 8
ARGP4
ADDRGP4 $833
ARGP4
ADDRLP4 2396
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2396
INDIRI4
CNSTI4 0
NEI4 $1075
line 1929
;1929:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1078
JUMPV
LABELV $1077
line 1930
;1930:		while( !(g_entities+i) || !((g_entities+i)->client) || !Q_strequal(arg2,(g_entities+i)->client->pers.netname)) {
line 1932
;1931:			//Not client i, try next
;1932:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1933
;1933:			if(i>=MAX_CLIENTS){ //Only numbers <128 is clients
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1082
line 1934
;1934:				trap_SendServerCommand( ent-g_entities, "print \"Cannot find the playername. Try clientkick instead.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1084
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1935
;1935:				return;
ADDRGP4 $793
JUMPV
LABELV $1082
line 1937
;1936:			}
;1937:		}
LABELV $1078
line 1930
ADDRLP4 2400
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 2404
CNSTU4 0
ASGNU4
ADDRLP4 2400
INDIRI4
ADDRGP4 g_entities
ADDP4
CVPU4 4
ADDRLP4 2404
INDIRU4
EQU4 $1077
ADDRLP4 2400
INDIRI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 2404
INDIRU4
EQU4 $1077
ADDRLP4 1288
ARGP4
ADDRLP4 2400
INDIRI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 2408
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2408
INDIRI4
CNSTI4 0
NEI4 $1077
line 1938
;1938:		level.voteKickClient = i;
ADDRGP4 level+2424
ADDRLP4 0
INDIRI4
ASGNI4
line 1939
;1939:		if(g_voteBan.integer<1) {
ADDRGP4 g_voteBan+12
INDIRI4
CNSTI4 1
GEI4 $1086
line 1940
;1940:			Com_sprintf( level.voteString, sizeof( level.voteString ), "clientkick_game \"%d\"", i );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1055
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1941
;1941:		} else {
ADDRGP4 $1087
JUMPV
LABELV $1086
line 1942
;1942:			Com_sprintf( level.voteString, sizeof( level.voteString ), "!ban \"%d\" \"%dm\" \"Banned by public vote\"", i, g_voteBan.integer );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1058
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 g_voteBan+12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1943
;1943:			level.voteKickType = 1; //ban
ADDRGP4 level+2428
CNSTI4 1
ASGNI4
line 1944
;1944:		}
LABELV $1087
line 1945
;1945:		Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "Kick %s?" , level.clients[i].pers.netname );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1063
ARGP4
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1946
;1946:	} 
ADDRGP4 $1076
JUMPV
LABELV $1075
line 1947
;1947:	else if ( Q_strequal( arg1, "custom" ) ) {
ADDRLP4 8
ARGP4
ADDRGP4 $848
ARGP4
ADDRLP4 2400
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2400
INDIRI4
CNSTI4 0
NEI4 $1097
line 1950
;1948:		t_customvote customvote;
;1949:		//Sago: There must always be a test to ensure that length(arg2) is non-zero or the client might be able to execute random commands.
;1950:		if(strlen(arg2)<1) {
ADDRLP4 1288
ARGP4
ADDRLP4 2588
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2588
INDIRI4
CNSTI4 1
GEI4 $1099
line 1951
;1951:			trap_SendServerCommand( ent-g_entities, va("print \"Custom vote commands are: %s\n\"",custom_vote_info) );
ADDRGP4 $1101
ARGP4
ADDRGP4 custom_vote_info
ARGP4
ADDRLP4 2592
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 2592
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1952
;1952:			return;
ADDRGP4 $793
JUMPV
LABELV $1099
line 1954
;1953:		}
;1954:		customvote = getCustomVote(arg2);
ADDRLP4 2404
ARGP4
ADDRLP4 1288
ARGP4
ADDRGP4 getCustomVote
CALLV
pop
line 1955
;1955:		if( !Q_strequal(customvote.votename, arg2)) {
ADDRLP4 2404
ARGP4
ADDRLP4 1288
ARGP4
ADDRLP4 2592
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2592
INDIRI4
CNSTI4 0
EQI4 $1102
line 1956
;1956:			trap_SendServerCommand( ent-g_entities, "print \"Command could not be found\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1104
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1957
;1957:			return;
ADDRGP4 $793
JUMPV
LABELV $1102
line 1959
;1958:		}
;1959:		Com_sprintf( level.voteString, sizeof( level.voteString ), "%s", customvote.command );
ADDRGP4 level+356
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $988
ARGP4
ADDRLP4 2404+82
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1960
;1960:		if(strlen(customvote.displayname)) {
ADDRLP4 2404+32
ARGP4
ADDRLP4 2596
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2596
INDIRI4
CNSTI4 0
EQI4 $1108
line 1961
;1961:			Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", customvote.displayname );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $988
ARGP4
ADDRLP4 2404+32
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1962
;1962:		}
ADDRGP4 $1098
JUMPV
LABELV $1108
line 1963
;1963:		else {
line 1964
;1964:			Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", customvote.command );
ADDRGP4 level+1380
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $988
ARGP4
ADDRLP4 2404+82
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1965
;1965:		}
line 1966
;1966:	} 
ADDRGP4 $1098
JUMPV
LABELV $1097
line 1967
;1967:	else {
line 1968
;1968:		trap_SendServerCommand( ent-g_entities, "print \"Server vality check failed, appears to be my fault. Sorry\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1117
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1969
;1969:		return;
ADDRGP4 $793
JUMPV
LABELV $1098
LABELV $1076
LABELV $1065
LABELV $1045
LABELV $1029
LABELV $1022
LABELV $1007
LABELV $991
LABELV $973
LABELV $957
LABELV $930
line 1972
;1970:	}
;1971:
;1972:	ent->client->pers.voteCount++;
ADDRLP4 2404
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 604
ADDP4
ASGNP4
ADDRLP4 2404
INDIRP4
ADDRLP4 2404
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1973
;1973:	trap_SendServerCommand( -1, va("print \"%s called a vote (%s).\n\"", ent->client->pers.netname, whiteListedStr(level.voteDisplayString) ) );
ADDRGP4 level+1380
ARGP4
ADDRLP4 2408
ADDRGP4 whiteListedStr
CALLP4
ASGNP4
ADDRGP4 $1118
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 2408
INDIRP4
ARGP4
ADDRLP4 2412
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 2412
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1976
;1974:
;1975:	// start the voting, the caller automatically votes yes
;1976:	level.voteTime = level.time;
ADDRGP4 level+2404
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1977
;1977:	level.voteYes = 1;
ADDRGP4 level+2412
CNSTI4 1
ASGNI4
line 1978
;1978:	level.voteNo = 0;
ADDRGP4 level+2416
CNSTI4 0
ASGNI4
line 1980
;1979:
;1980:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1127
JUMPV
LABELV $1124
line 1981
;1981:		level.clients[i].ps.eFlags &= ~EF_VOTED;
ADDRLP4 2416
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 2416
INDIRP4
ADDRLP4 2416
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1982
;1982:		level.clients[i].vote = 0;
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1252
ADDP4
CNSTI4 0
ASGNI4
line 1983
;1983:	}
LABELV $1125
line 1980
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1127
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1124
line 1984
;1984:	ent->client->ps.eFlags |= EF_VOTED;
ADDRLP4 2416
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 2416
INDIRP4
ADDRLP4 2416
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 1985
;1985:	ent->client->vote = 1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1252
ADDP4
CNSTI4 1
ASGNI4
line 1987
;1986:	//Do a first count to make sure that numvotingclients is correct!
;1987:	CountVotes();
ADDRGP4 CountVotes
CALLV
pop
line 1989
;1988:
;1989:	trap_SetConfigstring( CS_VOTE_TIME, va("%i", level.voteTime ) );
ADDRGP4 $1129
ARGP4
ADDRGP4 level+2404
INDIRI4
ARGI4
ADDRLP4 2420
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 8
ARGI4
ADDRLP4 2420
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1990
;1990:	trap_SetConfigstring( CS_VOTE_STRING, level.voteDisplayString );	
CNSTI4 9
ARGI4
ADDRGP4 level+1380
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1991
;1991:	trap_SetConfigstring( CS_VOTE_YES, va("%i", level.voteYes ) );
ADDRGP4 $1129
ARGP4
ADDRGP4 level+2412
INDIRI4
ARGI4
ADDRLP4 2424
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 10
ARGI4
ADDRLP4 2424
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1992
;1992:	trap_SetConfigstring( CS_VOTE_NO, va("%i", level.voteNo ) );
ADDRGP4 $1129
ARGP4
ADDRGP4 level+2416
INDIRI4
ARGI4
ADDRLP4 2428
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 11
ARGI4
ADDRLP4 2428
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1993
;1993:}
LABELV $793
endproc Cmd_CallVote_f 3400 24
export Cmd_Vote_f
proc Cmd_Vote_f 68 12
line 2000
;1994:
;1995:/*
;1996:==================
;1997:Cmd_Vote_f
;1998:==================
;1999:*/
;2000:void Cmd_Vote_f( gentity_t *ent ) {
line 2003
;2001:	char		msg[64];
;2002:
;2003:	if ( !level.voteTime ) {
ADDRGP4 level+2404
INDIRI4
CNSTI4 0
NEI4 $1135
line 2004
;2004:		trap_SendServerCommand( ent-g_entities, "print \"No vote in progress.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1138
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2005
;2005:		return;
ADDRGP4 $1134
JUMPV
LABELV $1135
line 2007
;2006:	}
;2007:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1139
line 2008
;2008:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to vote as spectator.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1141
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2009
;2009:		return;
ADDRGP4 $1134
JUMPV
LABELV $1139
line 2012
;2010:	}
;2011:
;2012:	trap_SendServerCommand( ent-g_entities, "print \"Vote cast.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1142
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2014
;2013:
;2014:	ent->client->ps.eFlags |= EF_VOTED;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 2016
;2015:
;2016:	trap_Argv( 1, msg, sizeof( msg ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2018
;2017:
;2018:	if ( msg[0] == 'y' || msg[1] == 'Y' || msg[1] == '1' ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 121
EQI4 $1148
ADDRLP4 0+1
INDIRI1
CVII4 1
CNSTI4 89
EQI4 $1148
ADDRLP4 0+1
INDIRI1
CVII4 1
CNSTI4 49
NEI4 $1143
LABELV $1148
line 2019
;2019:		ent->client->vote = 1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1252
ADDP4
CNSTI4 1
ASGNI4
line 2020
;2020:	} 
ADDRGP4 $1144
JUMPV
LABELV $1143
line 2021
;2021:	else {
line 2022
;2022:		ent->client->vote = -1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1252
ADDP4
CNSTI4 -1
ASGNI4
line 2023
;2023:	}
LABELV $1144
line 2026
;2024:
;2025:	//Re count the votes
;2026:	CountVotes();
ADDRGP4 CountVotes
CALLV
pop
line 2030
;2027:
;2028:	// a majority will be determined in CheckVote, which will also account
;2029:	// for players entering or leaving
;2030:}
LABELV $1134
endproc Cmd_Vote_f 68 12
export Cmd_CallTeamVote_f
proc Cmd_CallTeamVote_f 2160 20
line 2037
;2031:
;2032:/*
;2033:==================
;2034:Cmd_CallTeamVote_f
;2035:==================
;2036:*/
;2037:void Cmd_CallTeamVote_f( gentity_t *ent ) {
line 2043
;2038:	char*	c;
;2039:	int		i, team, cs_offset;
;2040:	char	arg1[MAX_STRING_TOKENS];
;2041:	char	arg2[MAX_STRING_TOKENS];
;2042:
;2043:	team = ent->client->sess.sessionTeam;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 2044
;2044:	if ( team == TEAM_RED ) {
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $1150
line 2045
;2045:		cs_offset = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 2046
;2046:	}
ADDRGP4 $1151
JUMPV
LABELV $1150
line 2047
;2047:	else if ( team == TEAM_BLUE ) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
NEI4 $1149
line 2048
;2048:		cs_offset = 1;
ADDRLP4 1036
CNSTI4 1
ASGNI4
line 2049
;2049:	}
line 2050
;2050:	else {
line 2051
;2051:		return;
LABELV $1153
LABELV $1151
line 2054
;2052:	}
;2053:
;2054:	if ( !g_allowVote.integer ) {
ADDRGP4 g_allowVote+12
INDIRI4
CNSTI4 0
NEI4 $1154
line 2055
;2055:		trap_SendServerCommand( ent-g_entities, "print \"Voting not allowed here.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $797
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2056
;2056:		return;
ADDRGP4 $1149
JUMPV
LABELV $1154
line 2059
;2057:	}
;2058:
;2059:	if ( level.teamVoteTime[cs_offset] ) {
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4480
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1157
line 2060
;2060:		trap_SendServerCommand( ent-g_entities, "print \"A team vote is already in progress.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1160
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2061
;2061:		return;
ADDRGP4 $1149
JUMPV
LABELV $1157
line 2063
;2062:	}
;2063:	if ( ent->client->pers.teamVoteCount >= g_maxvotes.integer ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
ADDRGP4 g_maxvotes+12
INDIRI4
LTI4 $1161
line 2064
;2064:		trap_SendServerCommand( ent-g_entities, "print \"You have called the maximum number of team votes.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1164
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2065
;2065:		return;
ADDRGP4 $1149
JUMPV
LABELV $1161
line 2067
;2066:	}
;2067:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1165
line 2068
;2068:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to call a vote as spectator.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $808
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2069
;2069:		return;
ADDRGP4 $1149
JUMPV
LABELV $1165
line 2073
;2070:	}
;2071:
;2072:	// make sure it is a valid command to vote on
;2073:	trap_Argv( 1, arg1, sizeof( arg1 ) );
CNSTI4 1
ARGI4
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2074
;2074:	arg2[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 2075
;2075:	for ( i = 2; i < trap_Argc(); i++ ) {
ADDRLP4 0
CNSTI4 2
ASGNI4
ADDRGP4 $1170
JUMPV
LABELV $1167
line 2076
;2076:		if (i > 2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LEI4 $1171
line 2077
;2077:			strcat(arg2, " ");
ADDRLP4 4
ARGP4
ADDRGP4 $1173
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 2078
;2078:		}
LABELV $1171
line 2079
;2079:		trap_Argv( i, &arg2[strlen(arg2)], sizeof( arg2 ) - strlen(arg2) );
ADDRLP4 4
ARGP4
ADDRLP4 2064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 2068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2064
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
CNSTU4 1024
ADDRLP4 2068
INDIRI4
CVIU4 4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2080
;2080:	}
LABELV $1168
line 2075
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1170
ADDRLP4 2064
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 2064
INDIRI4
LTI4 $1167
line 2083
;2081:
;2082:	// check for command separators in arg2
;2083:	for( c = arg2; *c; ++c) {
ADDRLP4 1028
ADDRLP4 4
ASGNP4
ADDRGP4 $1177
JUMPV
LABELV $1174
line 2084
;2084:		switch(*c) {
ADDRLP4 2068
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2076
CNSTI4 10
ASGNI4
ADDRLP4 2068
INDIRI4
ADDRLP4 2076
INDIRI4
EQI4 $1181
ADDRLP4 2068
INDIRI4
CNSTI4 13
EQI4 $1181
ADDRLP4 2068
INDIRI4
ADDRLP4 2076
INDIRI4
LTI4 $1178
LABELV $1182
ADDRLP4 2068
INDIRI4
CNSTI4 59
EQI4 $1181
ADDRGP4 $1178
JUMPV
LABELV $1181
line 2088
;2085:			case '\n':
;2086:			case '\r':
;2087:			case ';':
;2088:				trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $817
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2089
;2089:				return;
ADDRGP4 $1149
JUMPV
line 2090
;2090:			break;
LABELV $1178
line 2092
;2091:		}
;2092:	}
LABELV $1175
line 2083
ADDRLP4 1028
ADDRLP4 1028
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $1177
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1174
line 2094
;2093:
;2094:	if ( Q_strequal( arg1, "leader" ) ) {
ADDRLP4 1040
ARGP4
ADDRGP4 $1185
ARGP4
ADDRLP4 2068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $1183
line 2097
;2095:		char netname[MAX_NETNAME], leader[MAX_NETNAME];
;2096:
;2097:		if ( !arg2[0] ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1186
line 2098
;2098:			i = ent->client->ps.clientNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 2099
;2099:		}
ADDRGP4 $1187
JUMPV
LABELV $1186
line 2100
;2100:		else {
line 2102
;2101:			// numeric values are just slot numbers
;2102:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1188
line 2103
;2103:				if ( !arg2[i] || arg2[i] < '0' || arg2[i] > '9' ) {
ADDRLP4 2144
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2144
INDIRI4
CNSTI4 0
EQI4 $1195
ADDRLP4 2144
INDIRI4
CNSTI4 48
LTI4 $1195
ADDRLP4 2144
INDIRI4
CNSTI4 57
LEI4 $1192
LABELV $1195
line 2104
;2104:					break;
ADDRGP4 $1190
JUMPV
LABELV $1192
line 2106
;2105:				}
;2106:			}
LABELV $1189
line 2102
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1188
LABELV $1190
line 2107
;2107:			if ( i >= 3 || !arg2[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 3
GEI4 $1198
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1196
LABELV $1198
line 2108
;2108:				i = atoi( arg2 );
ADDRLP4 4
ARGP4
ADDRLP4 2148
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 2148
INDIRI4
ASGNI4
line 2109
;2109:				if ( i < 0 || i >= level.maxclients ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1202
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1199
LABELV $1202
line 2110
;2110:					trap_SendServerCommand( ent-g_entities, va("print \"Bad client slot: %i\n\"", i) );
ADDRGP4 $1203
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2156
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 2156
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2111
;2111:					return;
ADDRGP4 $1149
JUMPV
LABELV $1199
line 2114
;2112:				}
;2113:
;2114:				if ( !g_entities[i].inuse ) {
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1197
line 2115
;2115:					trap_SendServerCommand( ent-g_entities, va("print \"Client %i is not active\n\"", i) );
ADDRGP4 $1207
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2156
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 2156
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2116
;2116:					return;
ADDRGP4 $1149
JUMPV
line 2118
;2117:				}
;2118:			}
LABELV $1196
line 2119
;2119:			else {
line 2120
;2120:				Q_strncpyz(leader, arg2, sizeof(leader));
ADDRLP4 2108
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2121
;2121:				Q_CleanStr(leader);
ADDRLP4 2108
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 2122
;2122:				for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1211
JUMPV
LABELV $1208
line 2123
;2123:					if ( level.clients[i].pers.connected == CON_DISCONNECTED )
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
CNSTI4 0
NEI4 $1213
line 2124
;2124:						continue;
ADDRGP4 $1209
JUMPV
LABELV $1213
line 2125
;2125:					if (level.clients[i].sess.sessionTeam != team)
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
EQI4 $1215
line 2126
;2126:						continue;
ADDRGP4 $1209
JUMPV
LABELV $1215
line 2127
;2127:					Q_strncpyz(netname, level.clients[i].pers.netname, sizeof(netname));
ADDRLP4 2072
ARGP4
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2128
;2128:					Q_CleanStr(netname);
ADDRLP4 2072
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 2129
;2129:					if ( Q_strequal(netname, leader) ) {
ADDRLP4 2072
ARGP4
ADDRLP4 2108
ARGP4
ADDRLP4 2148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2148
INDIRI4
CNSTI4 0
NEI4 $1217
line 2130
;2130:						break;
ADDRGP4 $1210
JUMPV
LABELV $1217
line 2132
;2131:					}
;2132:				}
LABELV $1209
line 2122
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1211
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1208
LABELV $1210
line 2133
;2133:				if ( i >= level.maxclients ) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1219
line 2134
;2134:					trap_SendServerCommand( ent-g_entities, va("print \"%s is not a valid player on your team.\n\"", arg2) );
ADDRGP4 $1222
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 2148
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 2148
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2135
;2135:					return;
ADDRGP4 $1149
JUMPV
LABELV $1219
line 2137
;2136:				}
;2137:			}
LABELV $1197
line 2138
;2138:		}
LABELV $1187
line 2139
;2139:		Com_sprintf(arg2, sizeof(arg2), "%d", i);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $330
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 2140
;2140:	} 
ADDRGP4 $1184
JUMPV
LABELV $1183
line 2141
;2141:	else {
line 2142
;2142:		trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $817
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2143
;2143:		trap_SendServerCommand( ent-g_entities, "print \"Team vote commands are: leader <player>.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1223
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2144
;2144:		return;
ADDRGP4 $1149
JUMPV
LABELV $1184
line 2147
;2145:	}
;2146:
;2147:	Com_sprintf( level.teamVoteString[cs_offset], sizeof( level.teamVoteString[cs_offset] ), "%s %s", arg1, arg2 );
ADDRLP4 1036
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+2432
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $968
ARGP4
ADDRLP4 1040
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2149
;2148:
;2149:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1229
JUMPV
LABELV $1226
line 2150
;2150:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
CNSTI4 0
NEI4 $1231
line 2151
;2151:			continue;
ADDRGP4 $1227
JUMPV
LABELV $1231
line 2153
;2152:		}
;2153:		if (level.clients[i].sess.sessionTeam == team) {
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
NEI4 $1233
line 2154
;2154:			trap_SendServerCommand( i, va("print \"%s called a team vote.\n\"", ent->client->pers.netname ) );
ADDRGP4 $1235
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 2072
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2072
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2155
;2155:		}
LABELV $1233
line 2156
;2156:	}
LABELV $1227
line 2149
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1229
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1226
line 2159
;2157:
;2158:	// start the voting, the caller automatically votes yes
;2159:	level.teamVoteTime[cs_offset] = level.time;
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4480
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2160
;2160:	level.teamVoteYes[cs_offset] = 1;
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4488
ADDP4
CNSTI4 1
ASGNI4
line 2161
;2161:	level.teamVoteNo[cs_offset] = 0;
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4496
ADDP4
CNSTI4 0
ASGNI4
line 2163
;2162:
;2163:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1243
JUMPV
LABELV $1240
line 2164
;2164:		if (level.clients[i].sess.sessionTeam == team ) {
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
NEI4 $1245
line 2165
;2165:			level.clients[i].ps.eFlags &= ~EF_TEAMVOTED;
ADDRLP4 2072
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 2072
INDIRP4
ADDRLP4 2072
INDIRP4
INDIRI4
CNSTI4 -524289
BANDI4
ASGNI4
line 2166
;2166:		}
LABELV $1245
line 2167
;2167:	}
LABELV $1241
line 2163
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1243
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1240
line 2168
;2168:	ent->client->ps.eFlags |= EF_TEAMVOTED;
ADDRLP4 2072
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 2072
INDIRP4
ADDRLP4 2072
INDIRP4
INDIRI4
CNSTI4 524288
BORI4
ASGNI4
line 2170
;2169:
;2170:	trap_SetConfigstring( CS_TEAMVOTE_TIME + cs_offset, va("%i", level.teamVoteTime[cs_offset] ) );
ADDRGP4 $1129
ARGP4
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4480
ADDP4
INDIRI4
ARGI4
ADDRLP4 2076
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1036
INDIRI4
CNSTI4 12
ADDI4
ARGI4
ADDRLP4 2076
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 2171
;2171:	trap_SetConfigstring( CS_TEAMVOTE_STRING + cs_offset, level.teamVoteString[cs_offset] );
ADDRLP4 1036
INDIRI4
CNSTI4 14
ADDI4
ARGI4
ADDRLP4 1036
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+2432
ADDP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 2172
;2172:	trap_SetConfigstring( CS_TEAMVOTE_YES + cs_offset, va("%i", level.teamVoteYes[cs_offset] ) );
ADDRGP4 $1129
ARGP4
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4488
ADDP4
INDIRI4
ARGI4
ADDRLP4 2084
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1036
INDIRI4
CNSTI4 16
ADDI4
ARGI4
ADDRLP4 2084
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 2173
;2173:	trap_SetConfigstring( CS_TEAMVOTE_NO + cs_offset, va("%i", level.teamVoteNo[cs_offset] ) );
ADDRGP4 $1129
ARGP4
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4496
ADDP4
INDIRI4
ARGI4
ADDRLP4 2088
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1036
INDIRI4
CNSTI4 18
ADDI4
ARGI4
ADDRLP4 2088
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 2174
;2174:}
LABELV $1149
endproc Cmd_CallTeamVote_f 2160 20
export Cmd_TeamVote_f
proc Cmd_TeamVote_f 84 12
line 2181
;2175:
;2176:/*
;2177:==================
;2178:Cmd_TeamVote_f
;2179:==================
;2180:*/
;2181:void Cmd_TeamVote_f( gentity_t *ent ) {
line 2185
;2182:	int			team, cs_offset;
;2183:	char		msg[64];
;2184:
;2185:	team = ent->client->sess.sessionTeam;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 2186
;2186:	if ( team == TEAM_RED ) {
ADDRLP4 68
INDIRI4
CNSTI4 1
NEI4 $1252
line 2187
;2187:		cs_offset = 0;
ADDRLP4 64
CNSTI4 0
ASGNI4
line 2188
;2188:	}
ADDRGP4 $1253
JUMPV
LABELV $1252
line 2189
;2189:	else if ( team == TEAM_BLUE ) {
ADDRLP4 68
INDIRI4
CNSTI4 2
NEI4 $1251
line 2190
;2190:		cs_offset = 1;
ADDRLP4 64
CNSTI4 1
ASGNI4
line 2191
;2191:	}
line 2192
;2192:	else {
line 2193
;2193:		return;
LABELV $1255
LABELV $1253
line 2196
;2194:	}
;2195:
;2196:	if ( !level.teamVoteTime[cs_offset] ) {
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4480
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1256
line 2197
;2197:		trap_SendServerCommand( ent-g_entities, "print \"No team vote in progress.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1259
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2198
;2198:		return;
ADDRGP4 $1251
JUMPV
LABELV $1256
line 2200
;2199:	}
;2200:	if ( ent->client->ps.eFlags & EF_TEAMVOTED ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $1260
line 2201
;2201:		trap_SendServerCommand( ent-g_entities, "print \"Team vote already cast.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1262
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2202
;2202:		return;
ADDRGP4 $1251
JUMPV
LABELV $1260
line 2204
;2203:	}
;2204:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1263
line 2205
;2205:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to vote as spectator.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1141
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2206
;2206:		return;
ADDRGP4 $1251
JUMPV
LABELV $1263
line 2209
;2207:	}
;2208:
;2209:	trap_SendServerCommand( ent-g_entities, "print \"Team vote cast.\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $1265
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2211
;2210:
;2211:	ent->client->ps.eFlags |= EF_TEAMVOTED;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 524288
BORI4
ASGNI4
line 2213
;2212:
;2213:	trap_Argv( 1, msg, sizeof( msg ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2215
;2214:
;2215:	if ( msg[0] == 'y' || msg[1] == 'Y' || msg[1] == '1' ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 121
EQI4 $1271
ADDRLP4 0+1
INDIRI1
CVII4 1
CNSTI4 89
EQI4 $1271
ADDRLP4 0+1
INDIRI1
CVII4 1
CNSTI4 49
NEI4 $1266
LABELV $1271
line 2216
;2216:		level.teamVoteYes[cs_offset]++;
ADDRLP4 76
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4488
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2217
;2217:		trap_SetConfigstring( CS_TEAMVOTE_YES + cs_offset, va("%i", level.teamVoteYes[cs_offset] ) );
ADDRGP4 $1129
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4488
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 64
INDIRI4
CNSTI4 16
ADDI4
ARGI4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 2218
;2218:	} 
ADDRGP4 $1267
JUMPV
LABELV $1266
line 2219
;2219:	else {
line 2220
;2220:		level.teamVoteNo[cs_offset]++;
ADDRLP4 76
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4496
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2221
;2221:		trap_SetConfigstring( CS_TEAMVOTE_NO + cs_offset, va("%i", level.teamVoteNo[cs_offset] ) );	
ADDRGP4 $1129
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4496
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 64
INDIRI4
CNSTI4 18
ADDI4
ARGI4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 2222
;2222:	}
LABELV $1267
line 2226
;2223:
;2224:	// a majority will be determined in TeamCheckVote, which will also account
;2225:	// for players entering or leaving
;2226:}
LABELV $1251
endproc Cmd_TeamVote_f 84 12
export Cmd_SetViewpos_f
proc Cmd_SetViewpos_f 1064 12
line 2234
;2227:
;2228:
;2229:/*
;2230:=================
;2231:Cmd_SetViewpos_f
;2232:=================
;2233:*/
;2234:void Cmd_SetViewpos_f( gentity_t *ent ) {
line 2239
;2235:	vec3_t		origin, angles;
;2236:	char		buffer[MAX_TOKEN_CHARS];
;2237:	int			i;
;2238:
;2239:	if ( !g_cheats.integer ) {
ADDRGP4 g_cheats+12
INDIRI4
CNSTI4 0
NEI4 $1277
line 2240
;2240:		trap_SendServerCommand( ent-g_entities, va("print \"Cheats are not enabled on this server.\n\""));
ADDRGP4 $191
ARGP4
ADDRLP4 1052
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2241
;2241:		return;
ADDRGP4 $1276
JUMPV
LABELV $1277
line 2243
;2242:	}
;2243:	if ( trap_Argc() != 5 ) {
ADDRLP4 1052
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 5
EQI4 $1280
line 2244
;2244:		trap_SendServerCommand( ent-g_entities, va("print \"usage: setviewpos x y z yaw\n\""));
ADDRGP4 $1282
ARGP4
ADDRLP4 1056
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2245
;2245:		return;
ADDRGP4 $1276
JUMPV
LABELV $1280
line 2248
;2246:	}
;2247:
;2248:	VectorClear( angles );
ADDRLP4 1056
CNSTF4 0
ASGNF4
ADDRLP4 1040+8
ADDRLP4 1056
INDIRF4
ASGNF4
ADDRLP4 1040+4
ADDRLP4 1056
INDIRF4
ASGNF4
ADDRLP4 1040
ADDRLP4 1056
INDIRF4
ASGNF4
line 2249
;2249:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1285
line 2250
;2250:		trap_Argv( i + 1, buffer, sizeof( buffer ) );
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2251
;2251:		origin[i] = atof( buffer );
ADDRLP4 4
ARGP4
ADDRLP4 1060
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
ADDP4
ADDRLP4 1060
INDIRF4
ASGNF4
line 2252
;2252:	}
LABELV $1286
line 2249
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1285
line 2254
;2253:
;2254:	trap_Argv( 4, buffer, sizeof( buffer ) );
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2255
;2255:	angles[YAW] = atof( buffer );
ADDRLP4 4
ARGP4
ADDRLP4 1060
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1040+4
ADDRLP4 1060
INDIRF4
ASGNF4
line 2257
;2256:
;2257:	TeleportPlayer( ent, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1040
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 2258
;2258:}
LABELV $1276
endproc Cmd_SetViewpos_f 1064 12
export Cmd_GetMappage_f
proc Cmd_GetMappage_f 1688 48
line 2260
;2259:
;2260:void Cmd_GetMappage_f( gentity_t *ent ) {
line 2264
;2261:	t_mappage page;
;2262:	char string[(MAX_MAPNAME+1)*MAPS_PER_PAGE+1];
;2263:	char arg[MAX_STRING_TOKENS];
;2264:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 655
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2265
;2265:	page = getMappage(atoi(arg));
ADDRLP4 655
ARGP4
ADDRLP4 1680
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ARGP4
ADDRLP4 1680
INDIRI4
ARGI4
ADDRGP4 getMappage
CALLV
pop
line 2266
;2266:	Q_strncpyz(string,va("mappage %d %s %s %s %s %s %s %s %s %s %s",page.pagenumber,page.mapname[0],
ADDRGP4 $1291
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0+4
ARGP4
ADDRLP4 0+4+32
ARGP4
ADDRLP4 0+4+64
ARGP4
ADDRLP4 0+4+96
ARGP4
ADDRLP4 0+4+128
ARGP4
ADDRLP4 0+4+160
ARGP4
ADDRLP4 0+4+192
ARGP4
ADDRLP4 0+4+224
ARGP4
ADDRLP4 0+4+256
ARGP4
ADDRLP4 0+4+288
ARGP4
ADDRLP4 1684
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 324
ARGP4
ADDRLP4 1684
INDIRP4
ARGP4
CNSTI4 331
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2269
;2267:			page.mapname[1],page.mapname[2],page.mapname[3],page.mapname[4],page.mapname[5],\
;2268:			page.mapname[6],page.mapname[7],page.mapname[8],page.mapname[9]),sizeof(string));
;2269:	trap_SendServerCommand( ent-g_entities, string );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 324
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2270
;2270:}
LABELV $1290
endproc Cmd_GetMappage_f 1688 48
data
export cmds
align 4
LABELV cmds
address $1311
byte 4 0
address Cmd_Team_f
address $1312
byte 4 0
address Cmd_Vote_f
address $1313
byte 4 4
address Cmd_Tell_f
address $1314
byte 4 4
address Cmd_CallVote_f
address $1315
byte 4 12
address Cmd_CallTeamVote_f
address $1316
byte 4 260
address Cmd_Say_f
address $630
byte 4 260
address Cmd_Say_f
address $1317
byte 4 260
address Cmd_Voice_f
address $684
byte 4 260
address Cmd_Voice_f
address $1318
byte 4 260
address Cmd_Voice_f
address $663
byte 4 260
address Cmd_VoiceTell_f
address $689
byte 4 260
address Cmd_Voice_f
address $685
byte 4 260
address Cmd_Voice_f
address $1319
byte 4 260
address Cmd_Voice_f
address $698
byte 4 260
address Cmd_VoiceTell_f
address $1320
byte 4 260
address Cmd_VoiceTaunt_f
address $356
byte 4 256
address Cmd_Score_f
address $1321
byte 4 256
address Cmd_Acc_f
address $1322
byte 4 129
address Cmd_Give_f
address $1323
byte 4 129
address Cmd_God_f
address $1324
byte 4 129
address Cmd_Notarget_f
address $1325
byte 4 1
address Cmd_LevelShot_f
address $1326
byte 4 1
address Cmd_SetViewpos_f
address $1327
byte 4 1
address Cmd_Noclip_f
address $1328
byte 4 136
address Cmd_Kill_f
address $1329
byte 4 0
address Cmd_Where_f
address $1330
byte 4 16
address Cmd_Follow_f
address $517
byte 4 16
address Cmd_FollowCycle_f
address $514
byte 4 16
address Cmd_FollowCycle_f
address $1331
byte 4 8
address Cmd_TeamVote_f
address $329
byte 4 8
address Cmd_TeamTask_f
address $1332
byte 4 16
address StopFollowing
address $1333
byte 4 0
address Cmd_GetMappage_f
address $1334
byte 4 0
address Cmd_GameCommand_f
align 4
LABELV numCmds
byte 4 34
export ClientCommand
code
proc ClientCommand 1052 12
line 2335
;2271:
;2272://KK-OAX This is the table that ClientCommands runs the console entry against. 
;2273:commands_t cmds[ ] = 
;2274:{
;2275:	// normal commands
;2276:	{ "team", 0, Cmd_Team_f },
;2277:	{ "vote", 0, Cmd_Vote_f },
;2278:
;2279:	// communication commands
;2280:	{ "tell", CMD_MESSAGE, Cmd_Tell_f },
;2281:	{ "callvote", CMD_MESSAGE, Cmd_CallVote_f },
;2282:	{ "callteamvote", CMD_MESSAGE|CMD_TEAM, Cmd_CallTeamVote_f },
;2283:	// can be used even during intermission
;2284:	{ "say", CMD_MESSAGE|CMD_INTERMISSION, Cmd_Say_f },
;2285:	{ "say_team", CMD_MESSAGE|CMD_INTERMISSION, Cmd_Say_f },
;2286:	{ "vsay", CMD_MESSAGE|CMD_INTERMISSION, Cmd_Voice_f },
;2287:	{ "vsay_team", CMD_MESSAGE|CMD_INTERMISSION, Cmd_Voice_f },
;2288:	{ "vsay_local", CMD_MESSAGE|CMD_INTERMISSION, Cmd_Voice_f },
;2289:	{ "vtell", CMD_MESSAGE|CMD_INTERMISSION, Cmd_VoiceTell_f },
;2290:	{ "vosay", CMD_MESSAGE|CMD_INTERMISSION, Cmd_Voice_f },
;2291:	{ "vosay_team", CMD_MESSAGE|CMD_INTERMISSION, Cmd_Voice_f },
;2292:	{ "vosay_local", CMD_MESSAGE|CMD_INTERMISSION, Cmd_Voice_f },
;2293:	{ "votell", CMD_MESSAGE|CMD_INTERMISSION, Cmd_VoiceTell_f },
;2294:	{ "vtaunt", CMD_MESSAGE|CMD_INTERMISSION, Cmd_VoiceTaunt_f },
;2295:
;2296:	{ "score", CMD_INTERMISSION, Cmd_Score_f },
;2297:	{ "acc", CMD_INTERMISSION, Cmd_Acc_f},
;2298:
;2299:	// cheats
;2300:	{ "give", CMD_CHEAT|CMD_LIVING, Cmd_Give_f },
;2301:	{ "god", CMD_CHEAT|CMD_LIVING, Cmd_God_f },
;2302:	{ "notarget", CMD_CHEAT|CMD_LIVING, Cmd_Notarget_f },
;2303:	{ "levelshot", CMD_CHEAT, Cmd_LevelShot_f },
;2304:	{ "setviewpos", CMD_CHEAT, Cmd_SetViewpos_f },
;2305:	{ "noclip", CMD_CHEAT, Cmd_Noclip_f },
;2306:
;2307:	{ "kill", CMD_TEAM|CMD_LIVING, Cmd_Kill_f },
;2308:	{ "where", 0, Cmd_Where_f },
;2309:
;2310:	// game commands
;2311:
;2312:	{ "follow", CMD_NOTEAM, Cmd_Follow_f },
;2313:	{ "follownext", CMD_NOTEAM, Cmd_FollowCycle_f },
;2314:	{ "followprev", CMD_NOTEAM, Cmd_FollowCycle_f },
;2315:
;2316:	{ "teamvote", CMD_TEAM, Cmd_TeamVote_f },
;2317:	{ "teamtask", CMD_TEAM, Cmd_TeamTask_f },
;2318:	//KK-OAX
;2319:	{ "freespectator", CMD_NOTEAM, StopFollowing },
;2320:	{ "getmappage", 0, Cmd_GetMappage_f },
;2321:	{ "gc", 0, Cmd_GameCommand_f }
;2322:
;2323:};
;2324:
;2325:static int numCmds = sizeof( cmds ) / sizeof( cmds[ 0 ] );
;2326:
;2327:/*
;2328:=================
;2329:ClientCommand
;2330:KK-OAX, Takes the client command and runs it through a loop which matches
;2331:it against the table. 
;2332:=================
;2333:*/
;2334:void ClientCommand( int clientNum )
;2335:{
line 2340
;2336:	gentity_t *ent;
;2337:	char      cmd[ MAX_TOKEN_CHARS ];
;2338:	int       i;
;2339:
;2340:	ent = g_entities + clientNum;
ADDRLP4 1028
CNSTI4 816
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2341
;2341: 	if (!ent->client || ent->client->pers.connected != CON_CONNECTED) {
ADDRLP4 1032
ADDRLP4 1028
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1338
ADDRLP4 1032
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1336
LABELV $1338
line 2342
;2342:		if (ent->client && ent->client->pers.localClient) {
ADDRLP4 1036
ADDRLP4 1028
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1335
ADDRLP4 1036
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1335
line 2345
;2343:			// Handle early team command sent by UI when starting a local
;2344:			// team play game.
;2345:			trap_Argv( 0, cmd, sizeof( cmd ) );
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2346
;2346:			if (Q_stricmp (cmd, "team") == 0) {
ADDRLP4 4
ARGP4
ADDRGP4 $1311
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $1335
line 2347
;2347:				Cmd_Team_f (ent);
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 Cmd_Team_f
CALLV
pop
line 2348
;2348:			}
line 2349
;2349:		}
line 2350
;2350:		return;   // not fully in game yet
ADDRGP4 $1335
JUMPV
LABELV $1336
line 2353
;2351:	}
;2352:
;2353:	trap_Argv( 0, cmd, sizeof( cmd ) );
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 2355
;2354:
;2355:	for( i = 0; i < numCmds; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1346
JUMPV
LABELV $1343
line 2356
;2356:		if( Q_strequal( cmd, cmds[ i ].cmdName ) ) {
ADDRLP4 4
ARGP4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cmds
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $1347
line 2357
;2357:			break;
ADDRGP4 $1345
JUMPV
LABELV $1347
line 2359
;2358:		}
;2359:	}
LABELV $1344
line 2355
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1346
ADDRLP4 0
INDIRI4
ADDRGP4 numCmds
INDIRI4
LTI4 $1343
LABELV $1345
line 2361
;2360:
;2361:	if( i == numCmds ) {
ADDRLP4 0
INDIRI4
ADDRGP4 numCmds
INDIRI4
NEI4 $1349
line 2363
;2362:		// KK-OAX Admin Command Check
;2363:		if( !G_admin_cmd_check( ent, qfalse ) ) {
ADDRLP4 1028
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1036
ADDRGP4 G_admin_cmd_check
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $1335
line 2364
;2364:			trap_SendServerCommand( clientNum, va( "print \"Unknown command %s\n\"", cmd ) );
ADDRGP4 $1353
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1040
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2365
;2365:		}
line 2366
;2366:		return;
ADDRGP4 $1335
JUMPV
LABELV $1349
line 2370
;2367:	}
;2368:
;2369:	// do tests here to reduce the amount of repeated code
;2370:	if( !( cmds[ i ].cmdFlags & CMD_INTERMISSION ) && level.intermissiontime ) {
ADDRLP4 1036
CNSTI4 0
ASGNI4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cmds+4
ADDP4
INDIRI4
CNSTI4 256
BANDI4
ADDRLP4 1036
INDIRI4
NEI4 $1354
ADDRGP4 level+9144
INDIRI4
ADDRLP4 1036
INDIRI4
EQI4 $1354
line 2371
;2371:		return;
ADDRGP4 $1335
JUMPV
LABELV $1354
line 2374
;2372:	}
;2373:
;2374:	if( cmds[ i ].cmdFlags & CMD_CHEAT && !g_cheats.integer ) {
ADDRLP4 1040
CNSTI4 0
ASGNI4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cmds+4
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 1040
INDIRI4
EQI4 $1358
ADDRGP4 g_cheats+12
INDIRI4
ADDRLP4 1040
INDIRI4
NEI4 $1358
line 2375
;2375:		trap_SendServerCommand( clientNum,
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $1362
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2377
;2376:			"print \"Cheats are not enabled on this server\n\"" );
;2377:		return;
ADDRGP4 $1335
JUMPV
LABELV $1358
line 2381
;2378:	}
;2379:
;2380:	//KK-OAX Do I need to change this for FFA gametype?
;2381:	if( cmds[ i ].cmdFlags & CMD_TEAM &&
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cmds+4
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1363
ADDRLP4 1028
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1363
line 2382
;2382:		ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
line 2383
;2383:		trap_SendServerCommand( clientNum, "print \"Join a team first\n\"" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $1366
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2384
;2384:		return;
ADDRGP4 $1335
JUMPV
LABELV $1363
line 2387
;2385:	}
;2386:
;2387:	if( ( cmds[ i ].cmdFlags & CMD_NOTEAM ||
ADDRLP4 1044
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 1048
CNSTI4 0
ASGNI4
ADDRLP4 1044
INDIRI4
ADDRGP4 cmds+4
ADDP4
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 1048
INDIRI4
NEI4 $1372
ADDRLP4 1044
INDIRI4
ADDRGP4 cmds+4
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 1048
INDIRI4
EQI4 $1367
ADDRGP4 g_cheats+12
INDIRI4
ADDRLP4 1048
INDIRI4
NEI4 $1367
LABELV $1372
ADDRLP4 1028
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1367
line 2389
;2388:		( cmds[ i ].cmdFlags & CMD_CHEAT_TEAM && !g_cheats.integer ) ) &&
;2389:		ent->client->sess.sessionTeam != TEAM_NONE ) {
line 2390
;2390:		trap_SendServerCommand( clientNum,
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $1373
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2392
;2391:			"print \"Cannot use this command when on a team\n\"" );
;2392:		return;
ADDRGP4 $1335
JUMPV
LABELV $1367
line 2395
;2393:	}
;2394:
;2395:	if( cmds[ i ].cmdFlags & CMD_RED &&
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cmds+4
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1374
ADDRLP4 1028
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1374
line 2396
;2396:		ent->client->sess.sessionTeam != TEAM_RED ) {
line 2397
;2397:		trap_SendServerCommand( clientNum,
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $1377
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2399
;2398:			"print \"Must be on the Red Team to use this command\n\"" );
;2399:		return;
ADDRGP4 $1335
JUMPV
LABELV $1374
line 2402
;2400:	}
;2401:
;2402:	if( cmds[ i ].cmdFlags & CMD_BLUE &&
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cmds+4
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1378
ADDRLP4 1028
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1378
line 2404
;2403:		ent->client->sess.sessionTeam != TEAM_BLUE )
;2404:	{
line 2405
;2405:		trap_SendServerCommand( clientNum,
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $1381
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2407
;2406:			"print \"Must be on the Blue Team to use this command\n\"" );
;2407:		return;
ADDRGP4 $1335
JUMPV
LABELV $1378
line 2410
;2408:	}
;2409:
;2410:	if( ( ent->client->ps.pm_type == PM_DEAD ) && ( cmds[ i ].cmdFlags & CMD_LIVING ) )
ADDRLP4 1028
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1382
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cmds+4
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1382
line 2411
;2411:	{
line 2412
;2412:		trap_SendServerCommand( clientNum,
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $1385
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2414
;2413:			"print \"Must be alive to use this command\n\"" );
;2414:		return;
ADDRGP4 $1335
JUMPV
LABELV $1382
line 2417
;2415:	}
;2416:
;2417:	cmds[ i ].cmdHandler( ent );
ADDRLP4 1028
INDIRP4
ARGP4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cmds+8
ADDP4
INDIRP4
CALLV
pop
line 2418
;2418:}
LABELV $1335
endproc ClientCommand 1052 12
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
LABELV $1385
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1381
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
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
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1377
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1373
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1366
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1362
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1353
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 85
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
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1334
byte 1 103
byte 1 99
byte 1 0
align 1
LABELV $1333
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
LABELV $1332
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1331
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
LABELV $1330
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1329
byte 1 119
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $1328
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1327
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $1326
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
LABELV $1325
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
LABELV $1324
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
LABELV $1323
byte 1 103
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $1322
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1321
byte 1 97
byte 1 99
byte 1 99
byte 1 0
align 1
LABELV $1320
byte 1 118
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1319
byte 1 118
byte 1 111
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1318
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1317
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1316
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1315
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
LABELV $1314
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
LABELV $1313
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1312
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1311
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $1291
byte 1 109
byte 1 97
byte 1 112
byte 1 112
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1282
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
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
byte 1 32
byte 1 120
byte 1 32
byte 1 121
byte 1 32
byte 1 122
byte 1 32
byte 1 121
byte 1 97
byte 1 119
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1265
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1262
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1259
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
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1235
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1223
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 60
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 62
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1222
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1207
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1203
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
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
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1185
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1173
byte 1 32
byte 1 0
align 1
LABELV $1164
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1160
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 65
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1142
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1141
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
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1138
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
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1129
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1118
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1117
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 109
byte 1 121
byte 1 32
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 32
byte 1 83
byte 1 111
byte 1 114
byte 1 114
byte 1 121
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1104
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1101
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1084
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 32
byte 1 84
byte 1 114
byte 1 121
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1074
byte 1 83
byte 1 104
byte 1 117
byte 1 102
byte 1 102
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 63
byte 1 0
align 1
LABELV $1069
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 97
byte 1 110
byte 1 32
byte 1 111
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1063
byte 1 75
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 37
byte 1 115
byte 1 63
byte 1 0
align 1
LABELV $1058
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 34
byte 1 37
byte 1 100
byte 1 34
byte 1 32
byte 1 34
byte 1 37
byte 1 100
byte 1 109
byte 1 34
byte 1 32
byte 1 34
byte 1 66
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 112
byte 1 117
byte 1 98
byte 1 108
byte 1 105
byte 1 99
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 34
byte 1 0
align 1
LABELV $1055
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 34
byte 1 37
byte 1 100
byte 1 34
byte 1 0
align 1
LABELV $1048
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1043
byte 1 68
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 63
byte 1 0
align 1
LABELV $1040
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 32
byte 1 34
byte 1 48
byte 1 34
byte 1 0
align 1
LABELV $1037
byte 1 69
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 63
byte 1 0
align 1
LABELV $1034
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 32
byte 1 34
byte 1 49
byte 1 34
byte 1 0
align 1
LABELV $1027
byte 1 82
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 63
byte 1 0
align 1
LABELV $1020
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 63
byte 1 0
align 1
LABELV $1017
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1010
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1005
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 63
byte 1 0
align 1
LABELV $1002
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $997
byte 1 37
byte 1 115
byte 1 32
byte 1 34
byte 1 37
byte 1 100
byte 1 34
byte 1 0
align 1
LABELV $994
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $989
byte 1 78
byte 1 101
byte 1 120
byte 1 116
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 63
byte 1 0
align 1
LABELV $988
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $985
byte 1 118
byte 1 115
byte 1 116
byte 1 114
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $982
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $979
byte 1 101
byte 1 110
byte 1 100
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $971
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 116
byte 1 111
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 63
byte 1 0
align 1
LABELV $968
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $965
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 59
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $960
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 97
byte 1 112
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $953
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 59
byte 1 32
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
LABELV $950
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 63
byte 1 0
align 1
LABELV $947
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 59
byte 1 32
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
byte 1 59
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $942
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $939
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $935
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $924
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $922
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 102
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $890
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
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $887
byte 1 46
byte 1 34
byte 1 0
align 1
LABELV $885
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 32
byte 1 60
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 62
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $882
byte 1 115
byte 1 104
byte 1 117
byte 1 102
byte 1 102
byte 1 108
byte 1 101
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $879
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 60
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 62
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $876
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 60
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 62
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $873
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $870
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 60
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 110
byte 1 117
byte 1 109
byte 1 62
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $867
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 60
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 62
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $864
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
byte 1 32
byte 1 60
byte 1 110
byte 1 62
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $861
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 60
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $858
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $855
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
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $852
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $851
byte 1 115
byte 1 104
byte 1 117
byte 1 102
byte 1 102
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $848
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $845
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
LABELV $842
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
LABELV $839
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $836
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $833
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $830
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
LABELV $827
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $824
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $821
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
LABELV $817
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $808
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
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $805
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $801
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 65
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $797
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $792
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
byte 1 0
align 1
LABELV $791
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
byte 1 0
align 1
LABELV $790
byte 1 68
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
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
byte 1 0
align 1
LABELV $789
byte 1 76
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 77
byte 1 97
byte 1 110
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $788
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 69
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
LABELV $787
byte 1 69
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
LABELV $786
byte 1 72
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
LABELV $785
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $784
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
byte 1 0
align 1
LABELV $783
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $782
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
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
byte 1 0
align 1
LABELV $781
byte 1 83
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $780
byte 1 84
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
LABELV $779
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $778
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $774
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $764
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 103
byte 1 99
byte 1 32
byte 1 60
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 100
byte 1 62
byte 1 32
byte 1 60
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 48
byte 1 45
byte 1 37
byte 1 100
byte 1 62
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $760
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $759
byte 1 115
byte 1 101
byte 1 97
byte 1 114
byte 1 99
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 121
byte 1 0
align 1
LABELV $758
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 32
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
LABELV $757
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $756
byte 1 99
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $755
byte 1 104
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
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
LABELV $754
byte 1 104
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
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
LABELV $753
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $750
byte 1 112
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $733
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $728
byte 1 107
byte 1 105
byte 1 108
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
LABELV $717
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $707
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $698
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $689
byte 1 118
byte 1 111
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $685
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
LABELV $684
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
LABELV $675
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $665
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $664
byte 1 118
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $663
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $660
byte 1 118
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $643
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $636
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 60
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 100
byte 1 62
byte 1 32
byte 1 60
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 62
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $630
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
LABELV $610
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $604
byte 1 25
byte 1 91
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 93
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $603
byte 1 25
byte 1 91
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 93
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $598
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $597
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 41
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $594
byte 1 115
byte 1 97
byte 1 121
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $592
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $591
byte 1 115
byte 1 97
byte 1 121
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $575
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $574
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $573
byte 1 37
byte 1 115
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $525
byte 1 67
byte 1 109
byte 1 100
byte 1 95
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 95
byte 1 102
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 100
byte 1 105
byte 1 114
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $517
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $514
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $480
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 97
byte 1 121
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
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
byte 1 111
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 53
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $473
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 83
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $471
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
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
byte 1 45
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $469
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
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $467
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
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $437
byte 1 99
byte 1 108
byte 1 95
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $425
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 84
byte 1 104
byte 1 105
byte 1 115
byte 1 32
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
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 65
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 33
byte 1 32
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $421
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 84
byte 1 104
byte 1 101
byte 1 32
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
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 65
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 33
byte 1 32
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $417
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
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
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 65
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 33
byte 1 32
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $398
byte 1 99
byte 1 112
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
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $393
byte 1 99
byte 1 112
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
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $380
byte 1 98
byte 1 0
align 1
LABELV $379
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $375
byte 1 114
byte 1 0
align 1
LABELV $374
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $367
byte 1 115
byte 1 0
align 1
LABELV $366
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $363
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 50
byte 1 0
align 1
LABELV $360
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 49
byte 1 0
align 1
LABELV $356
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $355
byte 1 115
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
LABELV $351
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $348
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $345
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $342
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $330
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $329
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
LABELV $325
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
LABELV $324
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $321
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
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
byte 1 32
byte 1 48
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $311
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $310
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $304
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $303
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $297
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $296
byte 1 103
byte 1 111
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $295
byte 1 103
byte 1 111
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $283
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $280
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $277
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 97
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $274
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
LABELV $271
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
LABELV $265
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $255
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $249
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $243
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $240
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $234
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 85
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $194
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $191
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $184
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
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $182
byte 1 67
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 108
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 108
byte 1 105
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $181
byte 1 99
byte 1 104
byte 1 32
byte 1 37
byte 1 117
byte 1 0
align 1
LABELV $173
byte 1 111
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $168
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
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $162
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 34
byte 1 97
byte 1 108
byte 1 108
byte 1 34
byte 1 0
align 1
LABELV $158
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $152
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
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $131
byte 1 100
byte 1 100
byte 1 84
byte 1 97
byte 1 107
byte 1 101
byte 1 65
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $129
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $122
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
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $119
byte 1 100
byte 1 111
byte 1 109
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $114
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $107
byte 1 97
byte 1 99
byte 1 99
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $106
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
byte 1 32
byte 1 0
align 1
LABELV $104
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
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $103
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
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $96
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
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
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $82
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
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
