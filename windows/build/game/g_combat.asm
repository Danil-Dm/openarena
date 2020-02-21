export ScorePlum
code
proc ScorePlum 12 8
file "../../../code/game/g_combat.c"
line 34
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
;23:// g_combat.c
;24:
;25:#include "g_local.h"
;26:#include "challenges.h"
;27:
;28:/*
;29:============
;30:ScorePlum
;31:============
;32:*/
;33:void ScorePlum( gentity_t *ent, vec3_t origin, int score )
;34:{
line 37
;35:	gentity_t *plum;
;36:
;37:	plum = G_TempEntity( origin, EV_SCOREPLUM );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 65
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 39
;38:	// only send this temp entity to a single client
;39:	plum->r.svFlags |= SVF_SINGLECLIENT;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 40
;40:	plum->r.singleClient = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 42
;41:	//
;42:	plum->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 43
;43:	plum->s.time = score;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 44
;44:}
LABELV $60
endproc ScorePlum 12 8
export AddScore
proc AddScore 28 20
line 54
;45:
;46:/*
;47:============
;48:AddScore
;49:
;50:Adds score to both the client and his team
;51:============
;52:*/
;53:void AddScore( gentity_t *ent, vec3_t origin, int score )
;54:{
line 57
;55:	int i;
;56:
;57:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $62
line 58
;58:		return;
ADDRGP4 $61
JUMPV
LABELV $62
line 61
;59:	}
;60:	// no scoring during pre-match warmup
;61:	if ( level.warmupTime ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $64
line 62
;62:		return;
ADDRGP4 $61
JUMPV
LABELV $64
line 66
;63:	}
;64:
;65:	//No scoring during intermission
;66:	if ( level.intermissiontime ) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $67
line 67
;67:		return;
ADDRGP4 $61
JUMPV
LABELV $67
line 70
;68:	}
;69:	// show score plum
;70:	if( level.numNonSpectatorClients<3 && score < 0 && !G_IsATeamGametype(g_gametype.integer)) {
ADDRGP4 level+76
INDIRI4
CNSTI4 3
GEI4 $70
ADDRFP4 8
INDIRI4
CNSTI4 0
GEI4 $70
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $70
line 71
;71:		for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $77
JUMPV
LABELV $74
line 72
;72:			if ( level.clients[ i ].pers.connected != CON_CONNECTED )
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
EQI4 $79
line 73
;73:				continue; //Client was not connected
ADDRGP4 $75
JUMPV
LABELV $79
line 75
;74:
;75:			if (level.clients[i].sess.sessionTeam == TEAM_SPECTATOR)
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
CNSTI4 3
NEI4 $81
line 76
;76:				continue; //Don't give anything to spectators
ADDRGP4 $75
JUMPV
LABELV $81
line 78
;77:
;78:			if (g_entities+i == ent)
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $83
line 79
;79:				continue; //Don't award dead one
ADDRGP4 $75
JUMPV
LABELV $83
line 81
;80:
;81:			level.clients[i].ps.persistant[PERS_SCORE] -= score;
ADDRLP4 8
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
SUBI4
ASGNI4
line 82
;82:			ScorePlum(ent, origin, -score);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
NEGI4
ARGI4
ADDRGP4 ScorePlum
CALLV
pop
line 83
;83:		}
LABELV $75
line 71
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $77
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $74
line 84
;84:	}
ADDRGP4 $71
JUMPV
LABELV $70
line 85
;85:	else {
line 86
;86:		ScorePlum(ent, origin, score);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 ScorePlum
CALLV
pop
line 88
;87:		//
;88:		ent->client->ps.persistant[PERS_SCORE] += score;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 89
;89:		if ( g_gametype.integer == GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $85
line 90
;90:			int team = ent->client->ps.persistant[PERS_TEAM];
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ASGNI4
line 91
;91:			level.teamScores[ team ] += score;
ADDRLP4 16
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 92
;92:			G_LogPrintf("TeamScore: %i %i: Team %d now has %d points\n",
ADDRGP4 $89
ARGP4
ADDRLP4 20
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 24
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 level+44
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ADDRGP4 level+44
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 94
;93:			            team, level.teamScores[ team ], team, level.teamScores[ team ] );
;94:		}
LABELV $85
line 95
;95:	}
LABELV $71
line 96
;96:	G_LogPrintf("PlayerScore: %i %i: %s now has %d points\n",
ADDRGP4 $92
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 98
;97:	            ent->s.number, ent->client->ps.persistant[PERS_SCORE], ent->client->pers.netname, ent->client->ps.persistant[PERS_SCORE] );
;98:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 99
;99:}
LABELV $61
endproc AddScore 28 20
export TossClientItems
proc TossClientItems 52 12
line 109
;100:
;101:/*
;102:=================
;103:TossClientItems
;104:
;105:Toss the weapon and powerups for the killed player
;106:=================
;107:*/
;108:void TossClientItems( gentity_t *self )
;109:{
line 117
;110:	gitem_t		*item;
;111:	int			weapon;
;112:	float		angle;
;113:	int			i;
;114:	gentity_t	*drop;
;115:
;116:	// drop the weapon if not a gauntlet or machinegun
;117:	weapon = self->s.weapon;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 120
;118:
;119:	//Never drop in elimination or last man standing mode!
;120:	if(G_IsARoundBasedGametype(g_gametype.integer) && !G_UsesTeamFlags(g_gametype.integer))
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $94
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $94
line 121
;121:		return;
ADDRGP4 $93
JUMPV
LABELV $94
line 127
;122:
;123:	// make a special check to see if they are changing to a new
;124:	// weapon that isn't the mg or gauntlet.  Without this, a client
;125:	// can pick up a weapon, be killed, and not drop the weapon because
;126:	// their weapon change hasn't completed yet and they are still holding the MG.
;127:	if ( weapon == WP_MACHINEGUN || weapon == WP_GRAPPLING_HOOK ) {
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $100
ADDRLP4 12
INDIRI4
CNSTI4 10
NEI4 $98
LABELV $100
line 128
;128:		if ( self->client->ps.weaponstate == WEAPON_DROPPING ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $101
line 129
;129:			weapon = self->client->pers.cmd.weapon;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 492
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 130
;130:		}
LABELV $101
line 131
;131:		if ( !( self->client->ps.stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $103
line 132
;132:			weapon = WP_NONE;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 133
;133:		}
LABELV $103
line 134
;134:	}
LABELV $98
line 136
;135:
;136:	if (g_instantgib.integer || g_rockets.integer || g_gametype.integer == GT_CTF_ELIMINATION || g_elimination_allgametypes.integer) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 g_instantgib+12
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $113
ADDRGP4 g_rockets+12
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $113
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $113
ADDRGP4 g_elimination_allgametypes+12
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $105
LABELV $113
line 138
;137:		//Nothing!
;138:	}
ADDRGP4 $106
JUMPV
LABELV $105
line 139
;139:	else if ( weapon > WP_MACHINEGUN && weapon != WP_GRAPPLING_HOOK &&
ADDRLP4 40
CNSTI4 2
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 40
INDIRI4
LEI4 $114
ADDRLP4 12
INDIRI4
CNSTI4 10
EQI4 $114
ADDRLP4 12
INDIRI4
ADDRLP4 40
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $114
line 140
;140:	          self->client->ps.ammo[ weapon ] ) {
line 142
;141:		// find the item type for this weapon
;142:		item = BG_FindItemForWeapon( weapon );
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 44
INDIRP4
ASGNP4
line 145
;143:
;144:		// spawn the item
;145:		Drop_Item( self, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Drop_Item
CALLP4
pop
line 146
;146:	}
LABELV $114
LABELV $106
line 149
;147:
;148:	// drop all the powerups if not in teamplay
;149:	if ( g_gametype.integer != GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $116
line 150
;150:		angle = 45;
ADDRLP4 16
CNSTF4 1110704128
ASGNF4
line 151
;151:		for ( i = 1 ; i < PW_NUM_POWERUPS ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $119
line 152
;152:			if ( self->client->ps.powerups[ i ] > level.time ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $123
line 153
;153:				item = BG_FindItemForPowerup( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 44
INDIRP4
ASGNP4
line 154
;154:				if ( !item ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $126
line 155
;155:					continue;
ADDRGP4 $120
JUMPV
LABELV $126
line 157
;156:				}
;157:				drop = Drop_Item( self, item, angle );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 48
INDIRP4
ASGNP4
line 159
;158:				// decide how many seconds it has left
;159:				drop->count = ( self->client->ps.powerups[ i ] - level.time ) / 1000;
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 160
;160:				if ( drop->count < 1 ) {
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 1
GEI4 $129
line 161
;161:					drop->count = 1;
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 162
;162:				}
LABELV $129
line 163
;163:				angle += 45;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1110704128
ADDF4
ASGNF4
line 164
;164:			}
LABELV $123
line 165
;165:		}
LABELV $120
line 151
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LTI4 $119
line 166
;166:	}
LABELV $116
line 167
;167:}
LABELV $93
endproc TossClientItems 52 12
export TossClientCubesValues
proc TossClientCubesValues 32 16
line 176
;168:
;169:/*
;170:=================
;171:TossClientCubes
;172:=================
;173:*/
;174:extern gentity_t	*neutralObelisk;
;175:
;176:void TossClientCubesValues(vec3_t angles, vec3_t origin, vec3_t velocity) {
line 177
;177:	angles[YAW] = (float)(level.time % 360);
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 178
;178:	angles[PITCH] = 0;	// always forward
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 179
;179:	angles[ROLL] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 181
;180:	
;181:	AngleVectors( angles, velocity, NULL, NULL );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 182
;182:	VectorScale( velocity, 150, velocity );
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTF4 1125515264
ADDRLP4 4
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 8
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTF4 1125515264
ADDRLP4 8
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTF4 1125515264
ADDRLP4 12
INDIRP4
INDIRF4
MULF4
ASGNF4
line 183
;183:	velocity[2] += 200 + crandom() * 50;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 20
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1112014848
CNSTF4 1073741824
ADDRLP4 16
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
CNSTF4 1128792064
ADDF4
ADDF4
ASGNF4
line 185
;184:
;185:	if( neutralObelisk ) {
ADDRGP4 neutralObelisk
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $133
line 186
;186:		VectorCopy( neutralObelisk->s.pos.trBase, origin );
ADDRFP4 4
INDIRP4
ADDRGP4 neutralObelisk
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 187
;187:		origin[2] += 44;
ADDRLP4 24
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1110441984
ADDF4
ASGNF4
line 188
;188:	}
ADDRGP4 $134
JUMPV
LABELV $133
line 189
;189:	else {
line 190
;190:		VectorClear( origin ) ;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRF4
ASGNF4
line 191
;191:	}
LABELV $134
line 192
;192:}
LABELV $131
endproc TossClientCubesValues 32 16
export TossClientCubes
proc TossClientCubes 52 12
line 195
;193:
;194:void TossClientCubes( gentity_t *self )
;195:{
line 202
;196:	gitem_t		*item;
;197:	gentity_t	*drop;
;198:	vec3_t		velocity;
;199:	vec3_t		angles;
;200:	vec3_t		origin;
;201:
;202:	self->client->ps.generic1 = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
CNSTI4 0
ASGNI4
line 206
;203:
;204:	// this should never happen but we should never
;205:	// get the server to crash due to skull being spawned in
;206:	if (!G_EntitiesFree()) {
ADDRLP4 44
ADDRGP4 G_EntitiesFree
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $136
line 207
;207:		return;
ADDRGP4 $135
JUMPV
LABELV $136
line 210
;208:	}
;209:
;210:	if( self->client->sess.sessionTeam == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 1
NEI4 $138
line 211
;211:		item = BG_FindItem( "Red Cube" );
ADDRGP4 $140
ARGP4
ADDRLP4 48
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 48
INDIRP4
ASGNP4
line 212
;212:	}
ADDRGP4 $139
JUMPV
LABELV $138
line 213
;213:	else {
line 214
;214:		item = BG_FindItem( "Blue Cube" );
ADDRGP4 $141
ARGP4
ADDRLP4 48
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 48
INDIRP4
ASGNP4
line 215
;215:	}
LABELV $139
line 217
;216:
;217:	TossClientCubesValues(angles, origin, velocity);
ADDRLP4 32
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 TossClientCubesValues
CALLV
pop
line 219
;218:	
;219:	if (g_harvesterFromBodies.integer) {
ADDRGP4 g_harvesterFromBodies+12
INDIRI4
CNSTI4 0
EQI4 $142
line 220
;220:		VectorCopy (self->s.pos.trBase, origin);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 221
;221:	}
LABELV $142
line 223
;222:
;223:	drop = LaunchItem( item, origin, velocity );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 48
ADDRGP4 LaunchItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
line 225
;224:
;225:	drop->nextthink = level.time + g_cubeTimeout.integer * 1000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_cubeTimeout+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 226
;226:	drop->think = G_FreeEntity;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 227
;227:	drop->spawnflags = self->client->sess.sessionTeam;
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 228
;228:}
LABELV $135
endproc TossClientCubes 52 12
export TossClientPersistantPowerups
proc TossClientPersistantPowerups 12 4
line 236
;229:
;230:/*
;231:=================
;232:TossClientPersistantPowerups
;233:=================
;234:*/
;235:void TossClientPersistantPowerups( gentity_t *ent )
;236:{
line 239
;237:	gentity_t	*powerup;
;238:
;239:	if( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $148
line 240
;240:		return;
ADDRGP4 $147
JUMPV
LABELV $148
line 243
;241:	}
;242:
;243:	if( !ent->client->persistantPowerup ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1176
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $150
line 244
;244:		return;
ADDRGP4 $147
JUMPV
LABELV $150
line 247
;245:	}
;246:
;247:	powerup = ent->client->persistantPowerup;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1176
ADDP4
INDIRP4
ASGNP4
line 249
;248:
;249:	powerup->r.svFlags &= ~SVF_NOCLIENT;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 250
;250:	powerup->s.eFlags &= ~EF_NODRAW;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 251
;251:	powerup->r.contents = CONTENTS_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 252
;252:	trap_LinkEntity( powerup );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 254
;253:
;254:	ent->client->ps.stats[STAT_PERSISTANT_POWERUP] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 0
ASGNI4
line 255
;255:	ent->client->persistantPowerup = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1176
ADDP4
CNSTP4 0
ASGNP4
line 256
;256:}
LABELV $147
endproc TossClientPersistantPowerups 12 4
export LookAtKiller
proc LookAtKiller 40 4
line 265
;257:
;258:
;259:/*
;260:==================
;261:LookAtKiller
;262:==================
;263:*/
;264:void LookAtKiller( gentity_t *self, gentity_t *inflictor, gentity_t *attacker )
;265:{
line 269
;266:	vec3_t		dir;
;267:	//vec3_t		angles;
;268:
;269:	if ( attacker && attacker != self ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 12
INDIRU4
CNSTU4 0
EQU4 $153
ADDRLP4 12
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $153
line 270
;270:		VectorSubtract (attacker->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 16
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 24
ASGNI4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
CNSTI4 28
ASGNI4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
CNSTI4 32
ASGNI4
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 271
;271:	}
ADDRGP4 $154
JUMPV
LABELV $153
line 272
;272:	else if ( inflictor && inflictor != self ) {
ADDRLP4 16
ADDRFP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
CNSTU4 0
EQU4 $157
ADDRLP4 16
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $157
line 273
;273:		VectorSubtract (inflictor->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 24
ASGNI4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
CNSTI4 28
ASGNI4
ADDRLP4 0+4
ADDRLP4 20
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
CNSTI4 32
ASGNI4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 274
;274:	}
ADDRGP4 $158
JUMPV
LABELV $157
line 275
;275:	else {
line 276
;276:		self->client->ps.stats[STAT_DEAD_YAW] = self->s.angles[YAW];
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 277
;277:		return;
ADDRGP4 $152
JUMPV
LABELV $158
LABELV $154
line 280
;278:	}
;279:
;280:	self->client->ps.stats[STAT_DEAD_YAW] = vectoyaw ( dir );
ADDRLP4 0
ARGP4
ADDRLP4 20
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 282
;281:
;282:	/*angles[YAW] =*/ vectoyaw ( dir );
ADDRLP4 0
ARGP4
ADDRGP4 vectoyaw
CALLF4
pop
line 285
;283:	//angles[PITCH] = 0;
;284:	//angles[ROLL] = 0;
;285:}
LABELV $152
endproc LookAtKiller 40 4
export GibEntity
proc GibEntity 12 12
line 293
;286:
;287:/*
;288:==================
;289:GibEntity
;290:==================
;291:*/
;292:void GibEntity( gentity_t *self, int killer )
;293:{
line 298
;294:	gentity_t *ent;
;295:	int i;
;296:
;297:	//if this entity still has kamikaze
;298:	if (self->s.eFlags & EF_KAMIKAZE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $162
line 300
;299:		// check if there is a kamikaze timer around for this owner
;300:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $164
line 301
;301:			ent = &g_entities[i];
ADDRLP4 0
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 302
;302:			if (!ent->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $168
line 303
;303:				continue;
ADDRGP4 $165
JUMPV
LABELV $168
line 304
;304:			if (ent->activator != self)
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $170
line 305
;305:				continue;
ADDRGP4 $165
JUMPV
LABELV $170
line 306
;306:			if ( !strequals(ent->classname, "kamikaze timer"))
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $174
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $172
line 307
;307:				continue;
ADDRGP4 $165
JUMPV
LABELV $172
line 308
;308:			G_FreeEntity(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 309
;309:			break;
ADDRGP4 $166
JUMPV
LABELV $165
line 300
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $164
LABELV $166
line 311
;310:		}
;311:	}
LABELV $162
line 312
;312:	G_AddEvent( self, EV_GIB_PLAYER, killer );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 313
;313:	self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 314
;314:	self->s.eType = ET_INVISIBLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 315
;315:	self->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 316
;316:}
LABELV $161
endproc GibEntity 12 12
export body_die
proc body_die 0 8
line 324
;317:
;318:/*
;319:==================
;320:body_die
;321:==================
;322:*/
;323:void body_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath )
;324:{
line 325
;325:	if ( self->health > GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
LEI4 $176
line 326
;326:		return;
ADDRGP4 $175
JUMPV
LABELV $176
line 328
;327:	}
;328:	if ( !g_blood.integer ) {
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $178
line 329
;329:		self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -39
ASGNI4
line 330
;330:		return;
ADDRGP4 $175
JUMPV
LABELV $178
line 333
;331:	}
;332:
;333:	GibEntity( self, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 334
;334:}
LABELV $175
endproc body_die 0 8
data
align 4
LABELV modNames
address $181
address $182
address $183
address $184
address $185
address $186
address $187
address $188
address $189
address $190
address $191
address $192
address $193
address $194
address $195
address $196
address $197
address $198
address $199
address $200
address $201
address $202
address $203
address $204
address $205
address $206
address $207
address $208
address $209
export Kamikaze_DeathActivate
code
proc Kamikaze_DeathActivate 0 4
line 376
;335:
;336:
;337:// these are just for logging, the client prints its own messages
;338:static const char *modNames[] = {
;339:	"MOD_UNKNOWN",
;340:	"MOD_SHOTGUN",
;341:	"MOD_GAUNTLET",
;342:	"MOD_MACHINEGUN",
;343:	"MOD_GRENADE",
;344:	"MOD_GRENADE_SPLASH",
;345:	"MOD_ROCKET",
;346:	"MOD_ROCKET_SPLASH",
;347:	"MOD_PLASMA",
;348:	"MOD_PLASMA_SPLASH",
;349:	"MOD_RAILGUN",
;350:	"MOD_LIGHTNING",
;351:	"MOD_BFG",
;352:	"MOD_BFG_SPLASH",
;353:	"MOD_WATER",
;354:	"MOD_SLIME",
;355:	"MOD_LAVA",
;356:	"MOD_CRUSH",
;357:	"MOD_TELEFRAG",
;358:	"MOD_FALLING",
;359:	"MOD_SUICIDE",
;360:	"MOD_TARGET_LASER",
;361:	"MOD_TRIGGER_HURT",
;362:	"MOD_NAIL",
;363:	"MOD_CHAINGUN",
;364:	"MOD_PROXIMITY_MINE",
;365:	"MOD_KAMIKAZE",
;366:	"MOD_JUICED",
;367:	"MOD_GRAPPLE"
;368:};
;369:
;370:/*
;371:==================
;372:Kamikaze_DeathActivate
;373:==================
;374:*/
;375:void Kamikaze_DeathActivate( gentity_t *ent )
;376:{
line 377
;377:	G_StartKamikaze(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_StartKamikaze
CALLV
pop
line 378
;378:	G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 379
;379:}
LABELV $210
endproc Kamikaze_DeathActivate 0 4
export Kamikaze_DeathTimer
proc Kamikaze_DeathTimer 16 0
line 387
;380:
;381:/*
;382:==================
;383:Kamikaze_DeathTimer
;384:==================
;385:*/
;386:void Kamikaze_DeathTimer( gentity_t *self )
;387:{
line 390
;388:	gentity_t *ent;
;389:
;390:	ent = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 391
;391:	ent->classname = "kamikaze timer";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $174
ASGNP4
line 392
;392:	VectorCopy(self->s.pos.trBase, ent->s.pos.trBase);
ADDRLP4 8
CNSTI4 24
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 393
;393:	ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 394
;394:	ent->think = Kamikaze_DeathActivate;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Kamikaze_DeathActivate
ASGNP4
line 395
;395:	ent->nextthink = level.time + 5 * 1000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 397
;396:
;397:	ent->activator = self;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 398
;398:}
LABELV $211
endproc Kamikaze_DeathTimer 16 0
export CheckAlmostCapture
proc CheckAlmostCapture 64 12
line 407
;399:
;400:
;401:/*
;402:==================
;403:CheckAlmostCapture
;404:==================
;405:*/
;406:void CheckAlmostCapture( gentity_t *self, gentity_t *attacker )
;407:{
line 413
;408:	gentity_t	*ent;
;409:	vec3_t		dir;
;410:	char		*classname;
;411:
;412:	// if this player was carrying a flag
;413:	if ( self->client->ps.powerups[PW_REDFLAG] ||
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $217
ADDRLP4 20
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $217
ADDRLP4 20
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $214
LABELV $217
line 415
;414:	        self->client->ps.powerups[PW_BLUEFLAG] ||
;415:	        self->client->ps.powerups[PW_NEUTRALFLAG] ) {
line 417
;416:		// get the goal flag this player should have been going for
;417:		if (G_UsesTeamFlags(g_gametype.integer) && !G_UsesTheWhiteFlag(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $218
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $218
line 418
;418:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 2
NEI4 $222
line 419
;419:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $224
ASGNP4
line 420
;420:			}
ADDRGP4 $219
JUMPV
LABELV $222
line 421
;421:			else {
line 422
;422:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $225
ASGNP4
line 423
;423:			}
line 424
;424:		}
ADDRGP4 $219
JUMPV
LABELV $218
line 425
;425:		else {
line 426
;426:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 2
NEI4 $226
line 427
;427:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $225
ASGNP4
line 428
;428:			}
ADDRGP4 $227
JUMPV
LABELV $226
line 429
;429:			else {
line 430
;430:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $224
ASGNP4
line 431
;431:			}
LABELV $227
line 432
;432:		}
LABELV $219
line 433
;433:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
LABELV $228
line 434
;434:		do {
line 435
;435:			ent = G_Find(ent, FOFS(classname), classname);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 436
;436:		} while (ent && (ent->flags & FL_DROPPED_ITEM));
LABELV $229
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $231
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $228
LABELV $231
line 438
;437:		// if we found the destination flag and it's not picked up
;438:		if (ent && !(ent->r.svFlags & SVF_NOCLIENT) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $232
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $232
line 440
;439:			// if the player was *very* close
;440:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 8
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 441
;441:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 8
ARGP4
ADDRLP4 52
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1128792064
GEF4 $236
line 442
;442:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 443
;443:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $238
line 444
;444:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 445
;445:				}
LABELV $238
line 446
;446:			}
LABELV $236
line 447
;447:		}
LABELV $232
line 448
;448:	}
LABELV $214
line 449
;449:}
LABELV $213
endproc CheckAlmostCapture 64 12
export CheckAlmostScored
proc CheckAlmostScored 44 12
line 457
;450:
;451:/*
;452:==================
;453:CheckAlmostScored
;454:==================
;455:*/
;456:void CheckAlmostScored( gentity_t *self, gentity_t *attacker )
;457:{
line 463
;458:	gentity_t	*ent;
;459:	vec3_t		dir;
;460:	char		*classname;
;461:
;462:	// if the player was carrying cubes
;463:	if ( self->client->ps.generic1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
EQI4 $241
line 464
;464:		if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 2
NEI4 $243
line 465
;465:			classname = "team_redobelisk";
ADDRLP4 16
ADDRGP4 $245
ASGNP4
line 466
;466:		}
ADDRGP4 $244
JUMPV
LABELV $243
line 467
;467:		else {
line 468
;468:			classname = "team_blueobelisk";
ADDRLP4 16
ADDRGP4 $246
ASGNP4
line 469
;469:		}
LABELV $244
line 470
;470:		ent = G_Find(NULL, FOFS(classname), classname);
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 472
;471:		// if we found the destination obelisk
;472:		if ( ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $247
line 474
;473:			// if the player was *very* close
;474:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 475
;475:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1128792064
GEF4 $251
line 476
;476:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 477
;477:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $253
line 478
;478:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 40
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 479
;479:				}
LABELV $253
line 480
;480:			}
LABELV $251
line 481
;481:		}
LABELV $247
line 482
;482:	}
LABELV $241
line 483
;483:}
LABELV $240
endproc CheckAlmostScored 44 12
bss
align 4
LABELV $438
skip 4
export player_die
code
proc player_die 128 28
line 491
;484:
;485:/*
;486:==================
;487:player_die
;488:==================
;489:*/
;490:void player_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath )
;491:{
line 500
;492:	gentity_t	*ent;
;493:	int			anim;
;494:	int			contents;
;495:	int			killer;
;496:	int			i,counter2;
;497:	const char	*killerName;
;498:	const char	*obit;
;499:
;500:	if ( !(self->client) || (self->client->ps.pm_type == PM_DEAD) ) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $258
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $256
LABELV $258
line 501
;501:		return;
ADDRGP4 $255
JUMPV
LABELV $256
line 504
;502:	}
;503:
;504:	if ( level.intermissiontime ) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $259
line 505
;505:		return;
ADDRGP4 $255
JUMPV
LABELV $259
line 510
;506:	}
;507:
;508://unlagged - backward reconciliation #2
;509:	// make sure the body shows up in the client's current position
;510:	G_UnTimeShiftClient( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UnTimeShiftClient
CALLV
pop
line 513
;511://unlagged - backward reconciliation #2
;512:	//KK-OAX Here is where we run the streak logic.
;513:	G_RunStreakLogic( attacker, self );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunStreakLogic
CALLV
pop
line 516
;514:
;515:	// check for an almost capture
;516:	CheckAlmostCapture( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostCapture
CALLV
pop
line 518
;517:	// check for a player that almost brought in cubes
;518:	CheckAlmostScored( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostScored
CALLV
pop
line 520
;519:
;520:	if (!self->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $262
line 521
;521:		return;
ADDRGP4 $255
JUMPV
LABELV $262
line 523
;522:	}
;523:	if (self->client->hook) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1164
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $264
line 524
;524:		Weapon_HookFree(self->client->hook);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1164
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 525
;525:	}
LABELV $264
line 526
;526:	if ((self->client->ps.eFlags & EF_TICKING) && self->activator) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $266
ADDRLP4 36
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $266
line 527
;527:		self->client->ps.eFlags &= ~EF_TICKING;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 528
;528:		self->activator->think = G_FreeEntity;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 529
;529:		self->activator->nextthink = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 530
;530:	}
LABELV $266
line 531
;531:	self->client->ps.pm_type = PM_DEAD;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 533
;532:
;533:	if ( attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $269
line 534
;534:		killer = attacker->s.number;
ADDRLP4 4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 535
;535:		if ( attacker->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $271
line 536
;536:			killerName = attacker->client->pers.netname;
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
line 537
;537:		}
ADDRGP4 $270
JUMPV
LABELV $271
line 538
;538:		else {
line 539
;539:			killerName = "<non-client>";
ADDRLP4 12
ADDRGP4 $273
ASGNP4
line 540
;540:		}
line 541
;541:	}
ADDRGP4 $270
JUMPV
LABELV $269
line 542
;542:	else {
line 543
;543:		killer = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 544
;544:		killerName = "<world>";
ADDRLP4 12
ADDRGP4 $274
ASGNP4
line 545
;545:	}
LABELV $270
line 547
;546:
;547:	if ( killer < 0 || killer >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $277
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $275
LABELV $277
line 548
;548:		killer = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 549
;549:		killerName = "<world>";
ADDRLP4 12
ADDRGP4 $274
ASGNP4
line 550
;550:	}
LABELV $275
line 552
;551:
;552:	if ( meansOfDeath < 0 || meansOfDeath >= sizeof( modNames ) / sizeof( modNames[0] ) ) {
ADDRLP4 44
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LTI4 $280
ADDRLP4 44
INDIRI4
CVIU4 4
CNSTU4 29
LTU4 $278
LABELV $280
line 553
;553:		obit = "<bad obituary>";
ADDRLP4 20
ADDRGP4 $281
ASGNP4
line 554
;554:	}
ADDRGP4 $279
JUMPV
LABELV $278
line 555
;555:	else {
line 556
;556:		obit = modNames[meansOfDeath];
ADDRLP4 20
ADDRFP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 modNames
ADDP4
INDIRP4
ASGNP4
line 557
;557:	}
LABELV $279
line 559
;558:
;559:	G_LogPrintf("Kill: %i %i %i: %s killed %s by %s\n",
ADDRGP4 $282
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 564
;560:	            killer, self->s.number, meansOfDeath, killerName,
;561:	            self->client->pers.netname, obit );
;562:
;563:	// broadcast the death event to everyone
;564:	ent = G_TempEntity( self->r.currentOrigin, EV_OBITUARY );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 60
ARGI4
ADDRLP4 52
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 52
INDIRP4
ASGNP4
line 565
;565:	ent->s.eventParm = meansOfDeath;
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 566
;566:	ent->s.otherEntityNum = self->s.number;
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 567
;567:	ent->s.otherEntityNum2 = killer;
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 569
;568:	//Sago: Hmmm... generic? Can I transmit anything I like? Like if it is a team kill? Let's try
;569:	ent->s.generic1 = OnSameTeam (self, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 56
INDIRI4
ASGNI4
line 570
;570:	if( !((G_IsARoundBasedGametype(g_gametype.integer) && G_IsATeamGametype(g_gametype.integer)) && level.time < level.roundStartTime) ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $289
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $289
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
LTI4 $283
LABELV $289
line 571
;571:		ent->r.svFlags = SVF_BROADCAST;	// send to everyone (if not an elimination gametype during active warmup)
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 32
ASGNI4
line 572
;572:	}
ADDRGP4 $284
JUMPV
LABELV $283
line 573
;573:	else {
line 574
;574:		ent->r.svFlags = SVF_NOCLIENT;
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 1
ASGNI4
line 575
;575:	}
LABELV $284
line 577
;576:
;577:	self->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 579
;578:
;579:	self->client->ps.persistant[PERS_KILLED]++;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 581
;580:
;581:	if (attacker && attacker->client) {
ADDRLP4 72
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 76
CNSTU4 0
ASGNU4
ADDRLP4 72
INDIRP4
CVPU4 4
ADDRLP4 76
INDIRU4
EQU4 $290
ADDRLP4 72
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 76
INDIRU4
EQU4 $290
line 582
;582:		attacker->client->lastkilled_client = self->s.number;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1124
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 584
;583:
;584:		if ( attacker == self || OnSameTeam (self, attacker ) ) {
ADDRLP4 80
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CVPU4 4
ADDRLP4 84
INDIRP4
CVPU4 4
EQU4 $294
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $292
LABELV $294
line 585
;585:			if(g_gametype.integer != GT_POSSESSION && !G_IsARoundBasedGametype(g_gametype.integer) && level.time < level.roundStartTime) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
EQI4 $291
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $291
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
GEI4 $291
line 586
;586:				if( (G_IsATeamGametype(g_gametype.integer) && self->client->ps.persistant[PERS_SCORE]>0) || level.numNonSpectatorClients<3) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRLP4 96
INDIRI4
ADDRLP4 100
INDIRI4
EQI4 $306
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ADDRLP4 100
INDIRI4
GTI4 $305
LABELV $306
ADDRGP4 level+76
INDIRI4
CNSTI4 3
GEI4 $291
LABELV $305
line 588
;587:					//Cannot get negative scores by suicide
;588:					AddScore( attacker, self->r.currentOrigin, -1 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 589
;589:				}
line 590
;590:			}
line 591
;591:		}
ADDRGP4 $291
JUMPV
LABELV $292
line 592
;592:		else {
line 593
;593:			if(g_gametype.integer!=GT_LMS && g_gametype.integer != GT_POSSESSION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
EQI4 $307
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
EQI4 $307
line 594
;594:				AddScore( attacker, self->r.currentOrigin, 1 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 595
;595:			}
LABELV $307
line 597
;596:
;597:			if( meansOfDeath == MOD_GAUNTLET ) {
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $311
line 600
;598:
;599:				// Attack gets a challenge complete:
;600:				if(!(attacker->r.svFlags & SVF_BOT) && !(self->r.svFlags & SVF_BOT)) {
ADDRLP4 92
CNSTI4 424
ASGNI4
ADDRLP4 96
CNSTI4 8
ASGNI4
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
ADDRLP4 96
INDIRI4
BANDI4
ADDRLP4 100
INDIRI4
NEI4 $313
ADDRFP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
ADDRLP4 96
INDIRI4
BANDI4
ADDRLP4 100
INDIRI4
NEI4 $313
line 601
;601:					ChallengeMessage(attacker,WEAPON_GAUNTLET_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 201
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 602
;602:				}
LABELV $313
line 605
;603:
;604:				// play humiliation on player
;605:				attacker->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;
ADDRLP4 104
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 606
;606:				G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", attacker->client->ps.clientNum, 0, attacker->client->pers.netname, "GAUNTLET" );
ADDRGP4 $315
ARGP4
ADDRLP4 108
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 108
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $316
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 609
;607:
;608:				// add the sprite over the player's head
;609:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 112
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 610
;610:				attacker->client->ps.eFlags |= EF_AWARD_GAUNTLET;
ADDRLP4 116
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 611
;611:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 614
;612:
;613:				// also play humiliation on target
;614:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_GAUNTLETREWARD;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 615
;615:			}
LABELV $311
line 618
;616:
;617:			//If neither attacker or taget is bots and not the same
;618:			if(!(attacker->r.svFlags & SVF_BOT) && !(self->r.svFlags & SVF_BOT) && self!=attacker) {
ADDRLP4 92
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 96
CNSTI4 424
ASGNI4
ADDRLP4 100
CNSTI4 8
ASGNI4
ADDRLP4 104
CNSTI4 0
ASGNI4
ADDRLP4 92
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
ADDRLP4 100
INDIRI4
BANDI4
ADDRLP4 104
INDIRI4
NEI4 $318
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
ADDRLP4 100
INDIRI4
BANDI4
ADDRLP4 104
INDIRI4
NEI4 $318
ADDRLP4 108
INDIRP4
CVPU4 4
ADDRLP4 92
INDIRP4
CVPU4 4
EQU4 $318
line 619
;619:				switch(meansOfDeath) {
ADDRLP4 112
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 1
LTI4 $320
ADDRLP4 112
INDIRI4
CNSTI4 28
GTI4 $320
ADDRLP4 112
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $341-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $341
address $324
address $322
address $323
address $325
address $325
address $326
address $326
address $328
address $328
address $329
address $327
address $333
address $333
address $320
address $338
address $338
address $339
address $340
address $338
address $320
address $320
address $338
address $334
address $335
address $336
address $320
address $320
address $337
code
LABELV $322
line 621
;620:				case MOD_GAUNTLET:
;621:					ChallengeMessage(attacker,WEAPON_GAUNTLET_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 201
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 622
;622:					break;
ADDRGP4 $321
JUMPV
LABELV $323
line 624
;623:				case MOD_MACHINEGUN:
;624:					ChallengeMessage(attacker,WEAPON_MACHINEGUN_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 202
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 625
;625:					break;
ADDRGP4 $321
JUMPV
LABELV $324
line 627
;626:				case MOD_SHOTGUN:
;627:					ChallengeMessage(attacker,WEAPON_SHOTGUN_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 203
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 628
;628:					break;
ADDRGP4 $321
JUMPV
LABELV $325
line 631
;629:				case MOD_GRENADE:
;630:				case MOD_GRENADE_SPLASH:
;631:					ChallengeMessage(attacker,WEAPON_GRANADE_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 204
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 632
;632:					break;
ADDRGP4 $321
JUMPV
LABELV $326
line 635
;633:				case MOD_ROCKET:
;634:				case MOD_ROCKET_SPLASH:
;635:					ChallengeMessage(attacker,WEAPON_ROCKET_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 205
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 636
;636:					break;
ADDRGP4 $321
JUMPV
LABELV $327
line 638
;637:				case MOD_LIGHTNING:
;638:					ChallengeMessage(attacker,WEAPON_LIGHTNING_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 206
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 639
;639:					break;
ADDRGP4 $321
JUMPV
LABELV $328
line 642
;640:				case MOD_PLASMA:
;641:				case MOD_PLASMA_SPLASH:
;642:					ChallengeMessage(attacker,WEAPON_PLASMA_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 207
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 643
;643:					break;
ADDRGP4 $321
JUMPV
LABELV $329
line 645
;644:				case MOD_RAILGUN:
;645:					if(g_instantgib.integer)
ADDRGP4 g_instantgib+12
INDIRI4
CNSTI4 0
EQI4 $330
line 646
;646:						ChallengeMessage(attacker,WEAPON_INSTANT_RAIL_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 215
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
ADDRGP4 $321
JUMPV
LABELV $330
line 648
;647:					else
;648:						ChallengeMessage(attacker,WEAPON_RAIL_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 208
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 649
;649:					break;
ADDRGP4 $321
JUMPV
LABELV $333
line 652
;650:				case MOD_BFG:
;651:				case MOD_BFG_SPLASH:
;652:					ChallengeMessage(attacker,WEAPON_BFG_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 209
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 653
;653:					break;
ADDRGP4 $321
JUMPV
LABELV $334
line 655
;654:				case MOD_NAIL:
;655:					ChallengeMessage(attacker,WEAPON_NAILGUN_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 212
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 656
;656:					break;
ADDRGP4 $321
JUMPV
LABELV $335
line 658
;657:				case MOD_CHAINGUN:
;658:					ChallengeMessage(attacker,WEAPON_CHAINGUN_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 211
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 659
;659:					break;
ADDRGP4 $321
JUMPV
LABELV $336
line 661
;660:				case MOD_PROXIMITY_MINE:
;661:					ChallengeMessage(attacker,WEAPON_MINE_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 213
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 662
;662:					break;
ADDRGP4 $321
JUMPV
LABELV $337
line 664
;663:				case MOD_GRAPPLE:
;664:					ChallengeMessage(attacker,WEAPON_GRAPPLE_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 210
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 665
;665:					break;
ADDRGP4 $321
JUMPV
LABELV $338
line 670
;666:				case MOD_LAVA:
;667:				case MOD_SLIME:
;668:				case MOD_TRIGGER_HURT:
;669:				case MOD_FALLING:
;670:					ChallengeMessage(attacker,WEAPON_PUSH_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 214
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 671
;671:					break;
ADDRGP4 $321
JUMPV
LABELV $339
line 673
;672:				case MOD_CRUSH:
;673:					ChallengeMessage(attacker,WEAPON_CRUSH_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 217
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 674
;674:					break;
ADDRGP4 $321
JUMPV
LABELV $340
line 676
;675:				case MOD_TELEFRAG:
;676:					ChallengeMessage(attacker,WEAPON_TELEFRAG_KILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 677
;677:					break;
LABELV $320
LABELV $321
line 678
;678:				};
line 679
;679:				ChallengeMessage(attacker,GENERAL_TOTALKILLS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 680
;680:				ChallengeMessage(self,GENERAL_TOTALDEATHS);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 683
;681:
;682:				//Lets count number of powerups:
;683:				i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 684
;684:				counter2 = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 686
;685:
;686:				if(attacker->client->ps.powerups[PW_QUAD]) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 0
EQI4 $343
line 687
;687:					ChallengeMessage(attacker,POWERUP_QUAD_KILL);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 401
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 688
;688:					counter2++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 689
;689:				}
LABELV $343
line 690
;690:				if(self->client->ps.powerups[PW_QUAD]) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 0
EQI4 $345
line 691
;691:					ChallengeMessage(attacker,POWERUP_COUNTER_QUAD);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 406
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 692
;692:					i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 693
;693:				}
LABELV $345
line 695
;694:
;695:				if(attacker->client->ps.powerups[PW_HASTE]) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $347
line 696
;696:					ChallengeMessage(attacker,POWERUP_SPEED_KILL);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 402
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 697
;697:					counter2++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 698
;698:				}
LABELV $347
line 699
;699:				if(self->client->ps.powerups[PW_HASTE]) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $349
line 700
;700:					ChallengeMessage(attacker,POWERUP_COUNTER_SPEED);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 407
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 701
;701:					i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 702
;702:				}
LABELV $349
line 704
;703:
;704:				if(attacker->client->ps.powerups[PW_INVIS]) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 328
ADDP4
INDIRI4
CNSTI4 0
EQI4 $351
line 705
;705:					ChallengeMessage(attacker,POWERUP_INVIS_KILL);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 404
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 706
;706:					counter2++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 707
;707:				}
LABELV $351
line 708
;708:				if(self->client->ps.powerups[PW_INVIS]) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 328
ADDP4
INDIRI4
CNSTI4 0
EQI4 $353
line 709
;709:					ChallengeMessage(attacker,POWERUP_COUNTER_INVIS);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 409
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 710
;710:					i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 711
;711:				}
LABELV $353
line 713
;712:
;713:				if(attacker->client->ps.powerups[PW_FLIGHT]) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $355
line 714
;714:					ChallengeMessage(attacker,POWERUP_FLIGHT_KILL);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 403
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 715
;715:					counter2++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 716
;716:				}
LABELV $355
line 717
;717:				if(self->client->ps.powerups[PW_FLIGHT]) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $357
line 718
;718:					ChallengeMessage(attacker,POWERUP_COUNTER_FLIGHT);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 408
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 719
;719:					i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 720
;720:				}
LABELV $357
line 722
;721:
;722:				if(self->client->ps.powerups[PW_BATTLESUIT]) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $359
line 723
;723:					ChallengeMessage(attacker,POWERUP_COUNTER_ENVIR);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 410
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 724
;724:					i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 725
;725:				}
LABELV $359
line 727
;726:
;727:				if(self->client->ps.powerups[PW_REGEN]) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $361
line 728
;728:					ChallengeMessage(attacker,POWERUP_COUNTER_REGEN);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 411
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
line 729
;729:					i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 730
;730:				}
LABELV $361
line 732
;731:
;732:				if(i>1) //The target had more than one powerup
ADDRLP4 0
INDIRI4
CNSTI4 1
LEI4 $363
line 733
;733:					ChallengeMessage(attacker,POWERUP_COUNTER_MULTI);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 412
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
LABELV $363
line 734
;734:				if(counter2>1) //The attacker has more than one powerup
ADDRLP4 28
INDIRI4
CNSTI4 1
LEI4 $365
line 735
;735:					ChallengeMessage(attacker,POWERUP_MULTI_KILL);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 405
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
LABELV $365
line 736
;736:			}
LABELV $318
line 740
;737:
;738:			// check for two kills in a short amount of time
;739:			// if this is close enough to the last kill, give a reward sound
;740:			if ( level.time - attacker->client->lastKillTime < CARNAGE_REWARD_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1156
ADDP4
INDIRI4
SUBI4
CNSTI4 3000
GEI4 $367
line 743
;741:				// KK-OAX
;742:				// Check if Multikills are enabled
;743:				if( g_altExcellent.integer ) {
ADDRGP4 g_altExcellent+12
INDIRI4
CNSTI4 0
EQI4 $370
line 744
;744:					attacker->client->pers.multiKillCount++;
ADDRLP4 112
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 908
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
line 745
;745:					G_checkForMultiKill( attacker );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 G_checkForMultiKill
CALLV
pop
line 746
;746:				} // play excellent on player
LABELV $370
line 747
;747:				attacker->client->ps.persistant[PERS_EXCELLENT_COUNT]++;
ADDRLP4 112
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 288
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
line 748
;748:				G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", attacker->client->ps.clientNum, 1, attacker->client->pers.netname, "EXCELLENT" );
ADDRGP4 $315
ARGP4
ADDRLP4 116
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 116
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $373
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 749
;749:				if(!level.hadBots) //There has not been any bots
ADDRGP4 level+9436
INDIRI4
CNSTI4 0
NEI4 $374
line 750
;750:					ChallengeMessage(attacker,AWARD_EXCELLENT);
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 302
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
LABELV $374
line 752
;751:				// add the sprite over the player's head
;752:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 120
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 753
;753:				attacker->client->ps.eFlags |= EF_AWARD_EXCELLENT;
ADDRLP4 124
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 754
;754:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 755
;755:			}
ADDRGP4 $368
JUMPV
LABELV $367
line 756
;756:			else {
line 759
;757:				//KK-OAX Clear multikill count
;758:				//Must be 1 so the correct number of kills are displayed to the clients.
;759:				attacker->client->pers.multiKillCount = 1;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 908
ADDP4
CNSTI4 1
ASGNI4
line 760
;760:			}
LABELV $368
line 761
;761:			attacker->client->lastKillTime = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1156
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 762
;762:		}
line 763
;763:	}
ADDRGP4 $291
JUMPV
LABELV $290
line 764
;764:	else {
line 765
;765:		if(g_gametype.integer != GT_POSSESSION && !G_IsARoundBasedGametype(g_gametype.integer) && level.time < level.roundStartTime) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
EQI4 $379
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
NEI4 $379
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
GEI4 $379
line 766
;766:			if(self->client->ps.persistant[PERS_SCORE]>0 || level.numNonSpectatorClients<3) { 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 0
GTI4 $388
ADDRGP4 level+76
INDIRI4
CNSTI4 3
GEI4 $385
LABELV $388
line 768
;767:				//Cannot get negative scores by suicide
;768:				AddScore( self, self->r.currentOrigin, -1 );
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 769
;769:			}
LABELV $385
line 770
;770:		}
LABELV $379
line 771
;771:	}
LABELV $291
line 774
;772:
;773:	// Add team bonuses
;774:	Team_FragBonuses(self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_FragBonuses
CALLV
pop
line 777
;775:
;776:	// if I committed suicide, the flag does not fall, it returns.
;777:	if (meansOfDeath == MOD_SUICIDE) {
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $389
line 778
;778:		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $391
line 779
;779:			Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 780
;780:			self->client->ps.powerups[PW_NEUTRALFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
CNSTI4 0
ASGNI4
line 781
;781:		}
ADDRGP4 $392
JUMPV
LABELV $391
line 782
;782:		else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $393
line 783
;783:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 784
;784:			self->client->ps.powerups[PW_REDFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 0
ASGNI4
line 785
;785:		}
ADDRGP4 $394
JUMPV
LABELV $393
line 786
;786:		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $395
line 787
;787:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 788
;788:			self->client->ps.powerups[PW_BLUEFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 0
ASGNI4
line 789
;789:		}
LABELV $395
LABELV $394
LABELV $392
line 790
;790:	}
LABELV $389
line 791
;791:	TossClientPersistantPowerups( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientPersistantPowerups
CALLV
pop
line 792
;792:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $397
line 793
;793:		TossClientCubes( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientCubes
CALLV
pop
line 794
;794:	}
LABELV $397
line 796
;795:	// if client is in a nodrop area, don't drop anything (but return CTF flags!)
;796:	TossClientItems( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 799
;797://#endif
;798:
;799:	Cmd_Score_f( self );		// show scores
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 802
;800:	// send updated scores to any clients that are following this one,
;801:	// or they would get stale scoreboards
;802:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $403
JUMPV
LABELV $400
line 805
;803:		gclient_t	*client;
;804:
;805:		client = &level.clients[i];
ADDRLP4 80
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 806
;806:		if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 80
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $405
line 807
;807:			continue;
ADDRGP4 $401
JUMPV
LABELV $405
line 809
;808:		}
;809:		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 80
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $407
line 810
;810:			continue;
ADDRGP4 $401
JUMPV
LABELV $407
line 812
;811:		}
;812:		if ( client->sess.spectatorClient == self->s.number ) {
ADDRLP4 80
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $409
line 813
;813:			Cmd_Score_f( g_entities + i );
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 814
;814:		}
LABELV $409
line 815
;815:	}
LABELV $401
line 802
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $403
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $400
line 817
;816:
;817:	self->takedamage = qtrue;	// can still be gibbed
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 819
;818:
;819:	self->s.weapon = WP_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 820
;820:	self->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 821
;821:	self->r.contents = CONTENTS_CORPSE;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 823
;822:
;823:	self->s.angles[0] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 0
ASGNF4
line 824
;824:	self->s.angles[2] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 0
ASGNF4
line 825
;825:	LookAtKiller (self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 LookAtKiller
CALLV
pop
line 827
;826:
;827:	VectorCopy( self->s.angles, self->client->ps.viewangles );
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 829
;828:
;829:	self->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 831
;830:
;831:	self->r.maxs[2] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 3238002688
ASGNF4
line 835
;832:
;833:	// don't allow respawn until the death anim is done
;834:	// g_forcerespawn may force spawning at some later time
;835:	self->client->respawnTime = level.time + 1700 +i;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1136
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1700
ADDI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 836
;836:	if(g_respawntime.integer>0) {
ADDRGP4 g_respawntime+12
INDIRI4
CNSTI4 0
LEI4 $412
line 837
;837:		for(i=0; self->client->respawnTime > i*g_respawntime.integer*1000; i++);
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $418
JUMPV
LABELV $415
LABELV $416
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $418
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
CNSTI4 1000
ADDRLP4 0
INDIRI4
ADDRGP4 g_respawntime+12
INDIRI4
MULI4
MULI4
GTI4 $415
line 839
;838:
;839:		self->client->respawnTime = i*g_respawntime.integer*1000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1136
ADDP4
CNSTI4 1000
ADDRLP4 0
INDIRI4
ADDRGP4 g_respawntime+12
INDIRI4
MULI4
MULI4
ASGNI4
line 840
;840:	}
LABELV $412
line 842
;841:	//However during warm up, we should respawn quicker!
;842:	if(G_IsARoundBasedGametype(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $421
line 843
;843:		if(level.time<=level.roundStartTime && level.time>level.roundStartTime-1000*g_elimination_activewarmup.integer) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
GTI4 $424
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
MULI4
SUBI4
LEI4 $424
line 844
;844:			self->client->respawnTime = level.time + rand()%800;
ADDRLP4 88
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1136
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 88
INDIRI4
CNSTI4 800
MODI4
ADDI4
ASGNI4
line 845
;845:		}
LABELV $424
line 846
;846:	}
LABELV $421
line 848
;847:
;848:	RespawnTimeMessage(self,self->client->respawnTime);
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
ARGI4
ADDRGP4 RespawnTimeMessage
CALLV
pop
line 852
;849:
;850:
;851:	// remove powerups
;852:	memset( self->client->ps.powerups, 0, sizeof(self->client->ps.powerups) );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 855
;853:
;854:	// never gib in a nodrop
;855:	contents = trap_PointContents( self->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 92
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 92
INDIRI4
ASGNI4
line 857
;856:
;857:	if ( (self->health <= GIB_HEALTH && !(contents & CONTENTS_NODROP) && g_blood.integer) || meansOfDeath == MOD_SUICIDE) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $437
ADDRLP4 16
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $437
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $435
LABELV $437
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $432
LABELV $435
line 859
;858:		// gib death
;859:		GibEntity( self, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 860
;860:	}
ADDRGP4 $433
JUMPV
LABELV $432
line 861
;861:	else {
line 865
;862:		// normal death
;863:		static int i;
;864:
;865:		switch ( i ) {
ADDRLP4 96
ADDRGP4 $438
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $441
ADDRLP4 96
INDIRI4
CNSTI4 1
EQI4 $442
ADDRLP4 96
INDIRI4
CNSTI4 2
EQI4 $443
ADDRGP4 $439
JUMPV
LABELV $441
line 867
;866:		case 0:
;867:			anim = BOTH_DEATH1;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 868
;868:			break;
ADDRGP4 $440
JUMPV
LABELV $442
line 870
;869:		case 1:
;870:			anim = BOTH_DEATH2;
ADDRLP4 24
CNSTI4 2
ASGNI4
line 871
;871:			break;
ADDRGP4 $440
JUMPV
LABELV $443
LABELV $439
line 874
;872:		case 2:
;873:		default:
;874:			anim = BOTH_DEATH3;
ADDRLP4 24
CNSTI4 4
ASGNI4
line 875
;875:			break;
LABELV $440
line 880
;876:		}
;877:
;878:		// for the no-blood option, we need to prevent the health
;879:		// from going to gib level
;880:		if ( self->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $444
line 881
;881:			self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -39
ASGNI4
line 882
;882:		}
LABELV $444
line 884
;883:
;884:		self->client->ps.legsAnim =
ADDRLP4 100
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 104
CNSTI4 128
ASGNI4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
ADDRLP4 104
INDIRI4
BANDI4
ADDRLP4 104
INDIRI4
BXORI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 886
;885:		    ( ( self->client->ps.legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;886:		self->client->ps.torsoAnim =
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ASGNP4
ADDRLP4 112
CNSTI4 128
ASGNI4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
ADDRLP4 112
INDIRI4
BANDI4
ADDRLP4 112
INDIRI4
BXORI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 889
;887:		    ( ( self->client->ps.torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;888:
;889:		G_AddEvent( self, EV_DEATH1 + i, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $438
INDIRI4
CNSTI4 57
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 892
;890:
;891:		// the body can still be gibbed
;892:		self->die = body_die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 body_die
ASGNP4
line 895
;893:
;894:		// globally cycle through the different death animations
;895:		i = ( i + 1 ) % 3;
ADDRLP4 116
ADDRGP4 $438
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 3
MODI4
ASGNI4
line 897
;896:
;897:		if (self->s.eFlags & EF_KAMIKAZE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $446
line 898
;898:			Kamikaze_DeathTimer( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Kamikaze_DeathTimer
CALLV
pop
line 899
;899:		}
LABELV $446
line 900
;900:	}
LABELV $433
line 902
;901:
;902:	trap_LinkEntity (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 904
;903:
;904:}
LABELV $255
endproc player_die 128 28
export CheckArmor
proc CheckArmor 20 4
line 913
;905:
;906:
;907:/*
;908:================
;909:CheckArmor
;910:================
;911:*/
;912:int CheckArmor (gentity_t *ent, int damage, int dflags)
;913:{
line 918
;914:	gclient_t	*client;
;915:	int			save;
;916:	int			count;
;917:
;918:	if (!damage)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $449
line 919
;919:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $449
line 921
;920:
;921:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 923
;922:
;923:	if (!client)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $451
line 924
;924:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $451
line 926
;925:
;926:	if (dflags & DAMAGE_NO_ARMOR)
ADDRFP4 8
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $453
line 927
;927:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $453
line 930
;928:
;929:	// armor
;930:	count = client->ps.stats[STAT_ARMOR];
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 931
;931:	save = ceil( damage * g_armorprotect.value );
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 g_armorprotect+8
INDIRF4
MULF4
ARGF4
ADDRLP4 12
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 932
;932:	if (save >= count)
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $456
line 933
;933:		save = count;
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $456
line 935
;934:
;935:	if (!save)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $458
line 936
;936:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $458
line 938
;937:
;938:	client->ps.stats[STAT_ARMOR] -= save;
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 940
;939:
;940:	return save;
ADDRLP4 0
INDIRI4
RETI4
LABELV $448
endproc CheckArmor 20 4
export RaySphereIntersections
proc RaySphereIntersections 96 4
line 949
;941:}
;942:
;943:/*
;944:================
;945:RaySphereIntersections
;946:================
;947:*/
;948:int RaySphereIntersections( vec3_t origin, float radius, vec3_t point, vec3_t dir, vec3_t intersections[2] )
;949:{
line 958
;950:	float b, c, d, t;
;951:
;952:	//	| origin - (point + t * dir) | = radius
;953:	//	a = dir[0]^2 + dir[1]^2 + dir[2]^2;
;954:	//	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
;955:	//	c = (point[0] - origin[0])^2 + (point[1] - origin[1])^2 + (point[2] - origin[2])^2 - radius^2;
;956:
;957:	// normalize dir so a = 1
;958:	VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 959
;959:	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
ADDRLP4 16
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRLP4 4
CNSTF4 1073741824
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
SUBF4
MULF4
ADDRLP4 16
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
MULF4
ASGNF4
line 960
;960:	c = (point[0] - origin[0]) * (point[0] - origin[0]) +
ADDRLP4 36
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 4
ASGNI4
ADDRLP4 52
ADDRLP4 36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56
CNSTI4 8
ASGNI4
ADDRLP4 60
ADDRLP4 36
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 44
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDRLP4 52
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ADDRLP4 60
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDF4
ADDRLP4 64
INDIRF4
ADDRLP4 64
INDIRF4
MULF4
SUBF4
ASGNF4
line 965
;961:	    (point[1] - origin[1]) * (point[1] - origin[1]) +
;962:	    (point[2] - origin[2]) * (point[2] - origin[2]) -
;963:	    radius * radius;
;964:
;965:	d = b * b - 4 * c;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1082130432
ADDRLP4 12
INDIRF4
MULF4
SUBF4
ASGNF4
line 966
;966:	if (d > 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $461
line 967
;967:		t = (- b + sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 72
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 968
;968:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 80
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 969
;969:		t = (- b - sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 84
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 84
INDIRF4
SUBF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 970
;970:		VectorMA(point, t, dir, intersections[1]);
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 92
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 971
;971:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $460
JUMPV
LABELV $461
line 973
;972:	}
;973:	else if (d == 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $463
line 974
;974:		t = (- b ) / 2;
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 975
;975:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 72
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 976
;976:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $460
JUMPV
LABELV $463
line 978
;977:	}
;978:	return 0;
CNSTI4 0
RETI4
LABELV $460
endproc RaySphereIntersections 96 4
export G_InvulnerabilityEffect
proc G_InvulnerabilityEffect 64 20
line 987
;979:}
;980:
;981:/*
;982:================
;983:G_InvulnerabilityEffect
;984:================
;985:*/
;986:int G_InvulnerabilityEffect( gentity_t *targ, vec3_t dir, vec3_t point, vec3_t impactpoint, vec3_t bouncedir )
;987:{
line 992
;988:	gentity_t	*impact;
;989:	vec3_t		intersections[2], vec;
;990:	int			n;
;991:
;992:	if ( !targ->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $466
line 993
;993:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $465
JUMPV
LABELV $466
line 995
;994:	}
;995:	VectorCopy(dir, vec);
ADDRLP4 0
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 996
;996:	VectorInverse(vec);
ADDRLP4 0
ARGP4
ADDRGP4 VectorInverse
CALLV
pop
line 998
;997:	// sphere model radius = 42 units
;998:	n = RaySphereIntersections( targ->client->ps.origin, 42, point, vec, intersections);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTF4 1109917696
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 44
ADDRGP4 RaySphereIntersections
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
line 999
;999:	if (n > 0) {
ADDRLP4 40
INDIRI4
CNSTI4 0
LEI4 $468
line 1000
;1000:		impact = G_TempEntity( targ->client->ps.origin, EV_INVUL_IMPACT );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 71
ARGI4
ADDRLP4 48
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 48
INDIRP4
ASGNP4
line 1001
;1001:		VectorSubtract(intersections[0], targ->client->ps.origin, vec);
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 52
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 52
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1002
;1002:		vectoangles(vec, impact->s.angles);
ADDRLP4 0
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1003
;1003:		impact->s.angles[0] += 90;
ADDRLP4 56
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 1004
;1004:		if (impact->s.angles[0] > 360)
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
CNSTF4 1135869952
LEF4 $474
line 1005
;1005:			impact->s.angles[0] -= 360;
ADDRLP4 60
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $474
line 1006
;1006:		if ( impactpoint ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $476
line 1007
;1007:			VectorCopy( intersections[0], impactpoint );
ADDRFP4 12
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 1008
;1008:		}
LABELV $476
line 1009
;1009:		if ( bouncedir ) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $478
line 1010
;1010:			VectorCopy( vec, bouncedir );
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 12
line 1011
;1011:			VectorNormalize( bouncedir );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1012
;1012:		}
LABELV $478
line 1013
;1013:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $465
JUMPV
LABELV $468
line 1015
;1014:	}
;1015:	else {
line 1016
;1016:		return qfalse;
CNSTI4 0
RETI4
LABELV $465
endproc G_InvulnerabilityEffect 64 20
proc catchup_damage 8 0
line 1024
;1017:	}
;1018:}
;1019:
;1020:/*
;1021:catchup_damage
;1022:*/
;1023:static int catchup_damage(int damage, int attacker_points, int target_points)
;1024:{
line 1026
;1025:	int newdamage;
;1026:	if(g_catchup.integer <= 0 )
ADDRGP4 g_catchup+12
INDIRI4
CNSTI4 0
GTI4 $481
line 1027
;1027:		return damage;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $480
JUMPV
LABELV $481
line 1029
;1028:	//Reduce damage
;1029:	if(attacker_points<=target_points+5)
ADDRFP4 4
INDIRI4
ADDRFP4 8
INDIRI4
CNSTI4 5
ADDI4
GTI4 $484
line 1030
;1030:		return damage; //Never reduce damage if only 5 points ahead.
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $480
JUMPV
LABELV $484
line 1032
;1031:
;1032:	newdamage=damage-((attacker_points-target_points-5) * (g_catchup.integer*damage))/100;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
ADDRFP4 8
INDIRI4
SUBI4
CNSTI4 5
SUBI4
ADDRGP4 g_catchup+12
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
MULI4
CNSTI4 100
DIVI4
SUBI4
ASGNI4
line 1033
;1033:	if(newdamage<damage/2)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
CNSTI4 2
DIVI4
GEI4 $487
line 1034
;1034:		return damage/2;
ADDRFP4 0
INDIRI4
CNSTI4 2
DIVI4
RETI4
ADDRGP4 $480
JUMPV
LABELV $487
line 1035
;1035:	return newdamage;
ADDRLP4 0
INDIRI4
RETI4
LABELV $480
endproc catchup_damage 8 0
export G_Damage
proc G_Damage 176 24
line 1064
;1036:}
;1037:
;1038:/*
;1039:============
;1040:G_Damage
;1041:
;1042:targ		entity that is being damaged
;1043:inflictor	entity that is causing the damage
;1044:attacker	entity that caused the inflictor to damage targ
;1045:	example: targ=monster, inflictor=rocket, attacker=player
;1046:
;1047:dir			direction of the attack for knockback
;1048:point		point at which the damage is being inflicted, used for headshots
;1049:damage		amount of damage being inflicted
;1050:knockback	force to be applied against targ as a result of the damage
;1051:
;1052:inflictor, attacker, dir, and point can be NULL for environmental effects
;1053:
;1054:dflags		these flags are used to control how T_Damage works
;1055:	DAMAGE_RADIUS			damage was indirect (from a nearby explosion)
;1056:	DAMAGE_NO_ARMOR			armor does not protect from this damage
;1057:	DAMAGE_NO_KNOCKBACK		do not affect velocity, just view angles
;1058:	DAMAGE_NO_PROTECTION	kills godmode, armor, everything
;1059:============
;1060:*/
;1061:
;1062:void G_Damage( gentity_t *targ, gentity_t *inflictor, gentity_t *attacker,
;1063:               vec3_t dir, vec3_t point, int damage, int dflags, int mod )
;1064:{
line 1074
;1065:	gclient_t	*client;
;1066:	int			take;
;1067:	//int			save;
;1068:	int			asave;
;1069:	int			knockback;
;1070:	int			max;
;1071:
;1072:	vec3_t		bouncedir, impactpoint;
;1073:
;1074:	if (!targ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $490
line 1075
;1075:		return;
ADDRGP4 $489
JUMPV
LABELV $490
line 1078
;1076:	}
;1077:
;1078:	if (!targ->takedamage) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $492
line 1079
;1079:		return;
ADDRGP4 $489
JUMPV
LABELV $492
line 1084
;1080:	}
;1081:
;1082:	// the intermission has allready been qualified for, so don't
;1083:	// allow any extra scoring
;1084:	if ( level.intermissionQueued ) {
ADDRGP4 level+9140
INDIRI4
CNSTI4 0
EQI4 $494
line 1085
;1085:		return;
ADDRGP4 $489
JUMPV
LABELV $494
line 1087
;1086:	}
;1087:	if ( targ->client && mod != MOD_JUICED) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $497
ADDRFP4 28
INDIRI4
CNSTI4 27
EQI4 $497
line 1088
;1088:		if ( targ->client->invulnerabilityTime > level.time) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $499
line 1089
;1089:			if ( dir && point ) {
ADDRLP4 44
CNSTU4 0
ASGNU4
ADDRFP4 12
INDIRP4
CVPU4 4
ADDRLP4 44
INDIRU4
EQU4 $489
ADDRFP4 16
INDIRP4
CVPU4 4
ADDRLP4 44
INDIRU4
EQU4 $489
line 1090
;1090:				G_InvulnerabilityEffect( targ, dir, point, impactpoint, bouncedir );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 G_InvulnerabilityEffect
CALLI4
pop
line 1091
;1091:			}
line 1092
;1092:			return;
ADDRGP4 $489
JUMPV
LABELV $499
line 1094
;1093:		}
;1094:	}
LABELV $497
line 1095
;1095:	client = targ->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1097
;1096:
;1097:	if ( !inflictor ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $504
line 1098
;1098:		inflictor = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 4
ADDRGP4 g_entities+833952
ASGNP4
line 1099
;1099:	}
LABELV $504
line 1100
;1100:	if ( !attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $507
line 1101
;1101:		attacker = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 8
ADDRGP4 g_entities+833952
ASGNP4
line 1102
;1102:	}
LABELV $507
line 1104
;1103:
;1104:	if ( (attacker == &g_entities[ENTITYNUM_WORLD] || attacker == targ || attacker->s.eType != ET_PLAYER) && client && client->lastSentFlying>-1 &&
ADDRLP4 44
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 48
INDIRU4
ADDRGP4 g_entities+833952
CVPU4 4
EQU4 $514
ADDRLP4 48
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $514
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $510
LABELV $514
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $510
ADDRLP4 0
INDIRP4
CNSTI4 1256
ADDP4
INDIRI4
CNSTI4 -1
LEI4 $510
ADDRLP4 56
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 19
EQI4 $518
ADDRLP4 56
INDIRI4
CNSTI4 16
EQI4 $518
ADDRLP4 56
INDIRI4
CNSTI4 15
EQI4 $518
ADDRLP4 56
INDIRI4
CNSTI4 22
EQI4 $518
ADDRLP4 56
INDIRI4
CNSTI4 20
NEI4 $510
LABELV $518
line 1105
;1105:	        ( mod==MOD_FALLING || mod==MOD_LAVA || mod==MOD_SLIME || mod==MOD_TRIGGER_HURT || mod==MOD_SUICIDE)) {
line 1106
;1106:		if( client->lastSentFlyingTime+5000<level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 1260
ADDP4
INDIRI4
CNSTI4 5000
ADDI4
ADDRGP4 level+32
INDIRI4
GEI4 $519
line 1108
;1107:			//More than 5 seconds, not a kill!
;1108:			client->lastSentFlying = -1;
ADDRLP4 0
INDIRP4
CNSTI4 1256
ADDP4
CNSTI4 -1
ASGNI4
line 1109
;1109:		}
ADDRGP4 $520
JUMPV
LABELV $519
line 1110
;1110:		else {
line 1111
;1111:			attacker = &g_entities[client->lastSentFlying];
ADDRFP4 8
CNSTI4 816
ADDRLP4 0
INDIRP4
CNSTI4 1256
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1112
;1112:		}
LABELV $520
line 1113
;1113:	}
LABELV $510
line 1116
;1114:
;1115:	// shootable doors / buttons don't actually have any health
;1116:	if ( targ->s.eType == ET_MOVER ) {
ADDRLP4 60
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $522
line 1117
;1117:		if ( targ->use && targ->moverState == MOVER_POS1 ) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $489
ADDRLP4 64
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $489
line 1118
;1118:			targ->use( targ, inflictor, attacker );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 1119
;1119:		}
line 1120
;1120:		return;
ADDRGP4 $489
JUMPV
LABELV $522
line 1122
;1121:	}
;1122:	if( g_gametype.integer == GT_OBELISK && CheckObeliskAttack( targ, attacker ) ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $526
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CheckObeliskAttack
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $526
line 1123
;1123:		return;
ADDRGP4 $489
JUMPV
LABELV $526
line 1127
;1124:	}
;1125:	// reduce damage by the attacker's handicap value
;1126:	// unless they are rocket jumping
;1127:	if ( attacker->client && attacker != targ ) {
ADDRLP4 68
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $529
ADDRLP4 68
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $529
line 1128
;1128:		max = attacker->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 16
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 1129
;1129:		if( bg_itemlist[attacker->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
CNSTI4 52
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 11
NEI4 $531
line 1130
;1130:			max /= 2;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1131
;1131:		}
LABELV $531
line 1132
;1132:		damage = damage * max / 100;
ADDRFP4 20
ADDRFP4 20
INDIRI4
ADDRLP4 16
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 1133
;1133:	}
LABELV $529
line 1135
;1134:
;1135:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $534
line 1136
;1136:		if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
CNSTI4 0
EQI4 $536
line 1137
;1137:			return;
ADDRGP4 $489
JUMPV
LABELV $536
line 1139
;1138:		}
;1139:	}
LABELV $534
line 1141
;1140:
;1141:	if ( !dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $538
line 1142
;1142:		dflags |= DAMAGE_NO_KNOCKBACK;
ADDRFP4 24
ADDRFP4 24
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 1143
;1143:	}
ADDRGP4 $539
JUMPV
LABELV $538
line 1144
;1144:	else {
line 1145
;1145:		VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1146
;1146:	}
LABELV $539
line 1148
;1147:
;1148:	knockback = damage;
ADDRLP4 8
ADDRFP4 20
INDIRI4
ASGNI4
line 1149
;1149:	if ( knockback > 200 ) {
ADDRLP4 8
INDIRI4
CNSTI4 200
LEI4 $540
line 1150
;1150:		knockback = 200;
ADDRLP4 8
CNSTI4 200
ASGNI4
line 1151
;1151:	}
LABELV $540
line 1152
;1152:	if ( targ->flags & FL_NO_KNOCKBACK ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $542
line 1153
;1153:		knockback = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1154
;1154:	}
LABELV $542
line 1155
;1155:	if ( dflags & DAMAGE_NO_KNOCKBACK ) {
ADDRFP4 24
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $544
line 1156
;1156:		knockback = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1157
;1157:	}
LABELV $544
line 1160
;1158:
;1159:	// figure momentum add, even if the damage won't be taken
;1160:	if ( knockback && targ->client ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $546
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $546
line 1164
;1161:		vec3_t	kvel;
;1162:		float	mass;
;1163:
;1164:		mass = 200;
ADDRLP4 84
CNSTF4 1128792064
ASGNF4
line 1166
;1165:
;1166:		VectorScale (dir, g_knockback.value * (float)knockback / mass, kvel);
ADDRLP4 88
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 96
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 72
ADDRLP4 88
INDIRP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 92
INDIRF4
MULF4
ADDRLP4 96
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 72+4
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 92
INDIRF4
MULF4
ADDRLP4 96
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 72+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ADDRLP4 84
INDIRF4
DIVF4
MULF4
ASGNF4
line 1167
;1167:		VectorAdd (targ->client->ps.velocity, kvel, targ->client->ps.velocity);
ADDRLP4 100
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ASGNF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
ADDRLP4 72+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 72+8
INDIRF4
ADDF4
ASGNF4
line 1171
;1168:
;1169:		// set the timer so that the other client can't cancel
;1170:		// out the movement immediately
;1171:		if ( !targ->client->ps.pm_time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $555
line 1174
;1172:			int		t;
;1173:
;1174:			t = knockback * 2;
ADDRLP4 112
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1175
;1175:			if ( t < 50 ) {
ADDRLP4 112
INDIRI4
CNSTI4 50
GEI4 $557
line 1176
;1176:				t = 50;
ADDRLP4 112
CNSTI4 50
ASGNI4
line 1177
;1177:			}
LABELV $557
line 1178
;1178:			if ( t > 200 ) {
ADDRLP4 112
INDIRI4
CNSTI4 200
LEI4 $559
line 1179
;1179:				t = 200;
ADDRLP4 112
CNSTI4 200
ASGNI4
line 1180
;1180:			}
LABELV $559
line 1181
;1181:			targ->client->ps.pm_time = t;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 112
INDIRI4
ASGNI4
line 1182
;1182:			targ->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1183
;1183:		}
LABELV $555
line 1185
;1184:		//Remeber the last person to hurt the player
;1185:		if( !g_awardpushing.integer || targ==attacker || OnSameTeam (targ, attacker)) {
ADDRGP4 g_awardpushing+12
INDIRI4
CNSTI4 0
EQI4 $565
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CVPU4 4
ADDRLP4 116
INDIRP4
CVPU4 4
EQU4 $565
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
EQI4 $561
LABELV $565
line 1186
;1186:			targ->client->lastSentFlying = -1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1256
ADDP4
CNSTI4 -1
ASGNI4
line 1187
;1187:		}
ADDRGP4 $562
JUMPV
LABELV $561
line 1188
;1188:		else {
line 1189
;1189:			targ->client->lastSentFlying = attacker->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1256
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1190
;1190:			targ->client->lastSentFlyingTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1260
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1191
;1191:		}
LABELV $562
line 1192
;1192:	}
LABELV $546
line 1195
;1193:
;1194:	// check for completely getting out of the damage
;1195:	if ( !(dflags & DAMAGE_NO_PROTECTION) ) {
ADDRFP4 24
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $567
line 1199
;1196:
;1197:		// if TF_NO_FRIENDLY_FIRE is set, don't do damage to the target
;1198:		// if the attacker was on the same team
;1199:		if ( mod != MOD_JUICED && mod != MOD_CRUSH && targ != attacker && !(dflags & DAMAGE_NO_TEAM_PROTECTION) && OnSameTeam (targ, attacker)  ) {
ADDRLP4 72
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 27
EQI4 $569
ADDRLP4 72
INDIRI4
CNSTI4 17
EQI4 $569
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CVPU4 4
ADDRLP4 80
INDIRP4
CVPU4 4
EQU4 $569
ADDRFP4 24
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $569
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $569
line 1200
;1200:			if ( ( !g_friendlyFire.integer && !(G_IsARoundBasedGametype(g_gametype.integer) && G_IsATeamGametype(g_gametype.integer)) ) || ( g_elimination_selfdamage.integer<2 && G_IsARoundBasedGametype(g_gametype.integer) ) ) {
ADDRGP4 g_friendlyFire+12
INDIRI4
CNSTI4 0
NEI4 $579
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $578
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $578
LABELV $579
ADDRGP4 g_elimination_selfdamage+12
INDIRI4
CNSTI4 2
GEI4 $571
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $571
LABELV $578
line 1201
;1201:				return;
ADDRGP4 $489
JUMPV
LABELV $571
line 1203
;1202:			}
;1203:		}
LABELV $569
line 1204
;1204:		if (mod == MOD_PROXIMITY_MINE) {
ADDRFP4 28
INDIRI4
CNSTI4 25
NEI4 $580
line 1205
;1205:			if (inflictor && inflictor->parent && OnSameTeam(targ, inflictor->parent)) {
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 92
CNSTU4 0
ASGNU4
ADDRLP4 88
INDIRP4
CVPU4 4
ADDRLP4 92
INDIRU4
EQU4 $582
ADDRLP4 96
ADDRLP4 88
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CVPU4 4
ADDRLP4 92
INDIRU4
EQU4 $582
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $582
line 1206
;1206:				return;
ADDRGP4 $489
JUMPV
LABELV $582
line 1208
;1207:			}
;1208:			if (targ == attacker) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $584
line 1209
;1209:				return;
ADDRGP4 $489
JUMPV
LABELV $584
line 1211
;1210:			}
;1211:		}
LABELV $580
line 1214
;1212:
;1213:		// check for godmode
;1214:		if ( targ->flags & FL_GODMODE ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $586
line 1215
;1215:			return;
ADDRGP4 $489
JUMPV
LABELV $586
line 1218
;1216:		}
;1217:
;1218:		if(targ->client && targ->client->spawnprotected) {
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $588
ADDRLP4 88
INDIRP4
CNSTI4 2000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $588
line 1219
;1219:			if(level.time>targ->client->respawnTime+g_spawnprotect.integer) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
ADDRGP4 g_spawnprotect+12
INDIRI4
ADDI4
LEI4 $590
line 1220
;1220:				targ->client->spawnprotected = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2000
ADDP4
CNSTI4 0
ASGNI4
line 1221
;1221:			}
ADDRGP4 $591
JUMPV
LABELV $590
line 1222
;1222:			else {
line 1223
;1223:				if( (mod > MOD_UNKNOWN && mod < MOD_WATER) || mod == MOD_TELEFRAG || mod>MOD_TRIGGER_HURT) {
ADDRLP4 92
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
LEI4 $597
ADDRLP4 92
INDIRI4
CNSTI4 14
LTI4 $598
LABELV $597
ADDRLP4 96
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 18
EQI4 $598
ADDRLP4 96
INDIRI4
CNSTI4 22
LEI4 $594
LABELV $598
line 1224
;1224:					return;
ADDRGP4 $489
JUMPV
LABELV $594
line 1226
;1225:				}
;1226:			}
LABELV $591
line 1227
;1227:		}
LABELV $588
line 1228
;1228:	}
LABELV $567
line 1232
;1229:
;1230:	// battlesuit protects from all radius damage (but takes knockback)
;1231:	// and protects 50% against all damage
;1232:	if ( client && client->ps.powerups[PW_BATTLESUIT] ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $599
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $599
line 1233
;1233:		G_AddEvent( targ, EV_POWERUP_BATTLESUIT, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 62
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1234
;1234:		if ( ( dflags & DAMAGE_RADIUS ) || ( mod == MOD_FALLING ) ) {
ADDRFP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $603
ADDRFP4 28
INDIRI4
CNSTI4 19
NEI4 $601
LABELV $603
line 1235
;1235:			return;
ADDRGP4 $489
JUMPV
LABELV $601
line 1237
;1236:		}
;1237:		damage *= 0.5;
ADDRFP4 20
CNSTF4 1056964608
ADDRFP4 20
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 1238
;1238:	}
LABELV $599
line 1241
;1239:
;1240:	// add to the attacker's hit counter (if the target isn't a general entity like a prox mine)
;1241:	if ( attacker->client && client
ADDRLP4 76
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 80
CNSTU4 0
ASGNU4
ADDRLP4 76
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 80
INDIRU4
EQU4 $604
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 80
INDIRU4
EQU4 $604
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CVPU4 4
ADDRLP4 76
INDIRP4
CVPU4 4
EQU4 $604
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRLP4 84
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 88
INDIRI4
LEI4 $604
ADDRLP4 92
ADDRLP4 84
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 3
EQI4 $604
ADDRLP4 92
INDIRI4
ADDRLP4 88
INDIRI4
EQI4 $604
line 1244
;1242:	        && targ != attacker && targ->health > 0
;1243:	        && targ->s.eType != ET_MISSILE
;1244:	        && targ->s.eType != ET_GENERAL) {
line 1245
;1245:		if ( OnSameTeam( targ, attacker ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $606
line 1246
;1246:			attacker->client->ps.persistant[PERS_HITS]--;
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1247
;1247:		}
ADDRGP4 $607
JUMPV
LABELV $606
line 1248
;1248:		else {
line 1249
;1249:			attacker->client->ps.persistant[PERS_HITS]++;
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1250
;1250:		}
LABELV $607
line 1251
;1251:		attacker->client->ps.persistant[PERS_ATTACKEE_ARMOR] = (targ->health<<8)|(client->ps.stats[STAT_ARMOR]);
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 276
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 8
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
BORI4
ASGNI4
line 1252
;1252:	}
LABELV $604
line 1256
;1253:
;1254:	// always give half damage if hurting self
;1255:	// calculated after knockback, so rocket jumping works
;1256:	if ( targ == attacker) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $608
line 1257
;1257:		damage *= 0.5;
ADDRFP4 20
CNSTF4 1056964608
ADDRFP4 20
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 1258
;1258:	}
LABELV $608
line 1260
;1259:
;1260:	if(targ->client && attacker->client ) {
ADDRLP4 96
CNSTI4 516
ASGNI4
ADDRLP4 100
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 100
INDIRU4
EQU4 $610
ADDRFP4 8
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 100
INDIRU4
EQU4 $610
line 1261
;1261:		damage = catchup_damage(damage, attacker->client->ps.persistant[PERS_SCORE], targ->client->ps.persistant[PERS_SCORE]);
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 104
CNSTI4 516
ASGNI4
ADDRLP4 108
CNSTI4 248
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 catchup_damage
CALLI4
ASGNI4
ADDRFP4 20
ADDRLP4 112
INDIRI4
ASGNI4
line 1262
;1262:	}
LABELV $610
line 1264
;1263:
;1264:	if(g_damageModifier.value > 0.01) {
ADDRGP4 g_damageModifier+8
INDIRF4
CNSTF4 1008981770
LEF4 $612
line 1265
;1265:		damage *= g_damageModifier.value;
ADDRFP4 20
ADDRFP4 20
INDIRI4
CVIF4 4
ADDRGP4 g_damageModifier+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1266
;1266:	}
LABELV $612
line 1268
;1267:
;1268:	if ( damage < 1 ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
GEI4 $616
line 1269
;1269:		damage = 1;
ADDRFP4 20
CNSTI4 1
ASGNI4
line 1270
;1270:	}
LABELV $616
line 1272
;1271:
;1272:	if(targ == attacker && (g_dmflags.integer & DF_NO_SELF_DAMAGE) ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $618
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $618
line 1273
;1273:		damage = 0;
ADDRFP4 20
CNSTI4 0
ASGNI4
line 1274
;1274:	}
LABELV $618
line 1276
;1275:
;1276:	if ((G_IsARoundBasedGametype(g_gametype.integer) || g_elimination_allgametypes.integer) &&
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 104
INDIRI4
ADDRLP4 108
INDIRI4
NEI4 $626
ADDRGP4 g_elimination_allgametypes+12
INDIRI4
ADDRLP4 108
INDIRI4
EQI4 $621
LABELV $626
ADDRGP4 g_elimination_selfdamage+12
INDIRI4
CNSTI4 1
GEI4 $621
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $627
ADDRFP4 28
INDIRI4
CNSTI4 19
NEI4 $621
LABELV $627
line 1277
;1277:		g_elimination_selfdamage.integer<1 && ( targ == attacker ||  mod == MOD_FALLING )) {
line 1278
;1278:		damage = 0;
ADDRFP4 20
CNSTI4 0
ASGNI4
line 1279
;1279:	}
LABELV $621
line 1283
;1280:
;1281:
;1282://So people can be telefragged!
;1283:	if (G_IsARoundBasedGametype(g_gametype.integer) && level.time < level.roundStartTime && ((mod == MOD_LAVA) || (mod == MOD_SLIME)) ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $628
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
GEI4 $628
ADDRLP4 116
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 16
EQI4 $633
ADDRLP4 116
INDIRI4
CNSTI4 15
NEI4 $628
LABELV $633
line 1284
;1284:		damage = 1000;
ADDRFP4 20
CNSTI4 1000
ASGNI4
line 1285
;1285:	}
LABELV $628
line 1288
;1286:
;1287:
;1288:	take = damage;
ADDRLP4 4
ADDRFP4 20
INDIRI4
ASGNI4
line 1292
;1289:	//save = 0;
;1290:
;1291:	// save some from armor
;1292:	asave = CheckArmor (targ, take, dflags);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 120
ADDRGP4 CheckArmor
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 120
INDIRI4
ASGNI4
line 1293
;1293:	take -= asave;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
ASGNI4
line 1295
;1294:
;1295:	if ( g_debugDamage.integer ) {
ADDRGP4 g_debugDamage+12
INDIRI4
CNSTI4 0
EQI4 $634
line 1296
;1296:		G_Printf( "%i: client:%i health:%i damage:%i armor:%i\n", level.time, targ->s.number,
ADDRGP4 $637
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
INDIRP4
INDIRI4
ARGI4
ADDRLP4 124
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 1298
;1297:		          targ->health, take, asave );
;1298:	}
LABELV $634
line 1303
;1299:
;1300:	// add to the damage inflicted on a player this frame
;1301:	// the total will be turned into screen blends and view angle kicks
;1302:	// at the end of the frame
;1303:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $639
line 1304
;1304:		if ( attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $641
line 1305
;1305:			client->ps.persistant[PERS_ATTACKER] = attacker->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1306
;1306:		}
ADDRGP4 $642
JUMPV
LABELV $641
line 1307
;1307:		else if(client->lastSentFlying > -1) {
ADDRLP4 0
INDIRP4
CNSTI4 1256
ADDP4
INDIRI4
CNSTI4 -1
LEI4 $643
line 1308
;1308:			client->ps.persistant[PERS_ATTACKER] = client->lastSentFlying;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 1256
ADDP4
INDIRI4
ASGNI4
line 1309
;1309:		}
ADDRGP4 $644
JUMPV
LABELV $643
line 1310
;1310:		else {
line 1311
;1311:			client->ps.persistant[PERS_ATTACKER] = ENTITYNUM_WORLD;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
CNSTI4 1022
ASGNI4
line 1312
;1312:		}
LABELV $644
LABELV $642
line 1313
;1313:		client->damage_armor += asave;
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 1084
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 1314
;1314:		client->damage_blood += take;
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 1088
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1315
;1315:		client->damage_knockback += knockback;
ADDRLP4 132
ADDRLP4 0
INDIRP4
CNSTI4 1092
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1316
;1316:		if ( dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $645
line 1317
;1317:			VectorCopy ( dir, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 1096
ADDP4
ADDRFP4 12
INDIRP4
INDIRB
ASGNB 12
line 1318
;1318:			client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 1108
ADDP4
CNSTI4 0
ASGNI4
line 1319
;1319:		}
ADDRGP4 $646
JUMPV
LABELV $645
line 1320
;1320:		else {
line 1321
;1321:			VectorCopy ( targ->r.currentOrigin, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 1096
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1322
;1322:			client->damage_fromWorld = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 1108
ADDP4
CNSTI4 1
ASGNI4
line 1323
;1323:		}
LABELV $646
line 1324
;1324:	}
LABELV $639
line 1327
;1325:
;1326:	// See if it's the player hurting the emeny flag carrier
;1327:	if(G_UsesTeamFlags(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 124
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $647
line 1328
;1328:		Team_CheckHurtCarrier(targ, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_CheckHurtCarrier
CALLV
pop
line 1329
;1329:	}
LABELV $647
line 1331
;1330:
;1331:	if (targ->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $650
line 1333
;1332:		// set the last client who damaged the target
;1333:		targ->client->lasthurt_client = attacker->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1128
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1334
;1334:		targ->client->lasthurt_mod = mod;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1132
ADDP4
ADDRFP4 28
INDIRI4
ASGNI4
line 1335
;1335:	}
LABELV $650
line 1338
;1336:
;1337:	//If vampire is enabled, gain health but not from self or teammate, cannot steal more than targ has
;1338:	if( g_vampire.value>0.0 && (targ != attacker) && take > 0 &&
ADDRGP4 g_vampire+8
INDIRF4
CNSTF4 0
LEF4 $652
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CVPU4 4
ADDRLP4 132
INDIRP4
CVPU4 4
EQU4 $652
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $652
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRLP4 136
INDIRI4
ADDRLP4 140
INDIRI4
NEI4 $652
ADDRLP4 144
CNSTI4 732
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
LEI4 $652
ADDRFP4 0
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
LEI4 $652
line 1339
;1339:	        !(OnSameTeam(targ, attacker)) && attacker->health > 0 && targ->health > 0 ) {
line 1340
;1340:		if(take<targ->health) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
GEI4 $655
line 1341
;1341:			attacker->health += (int)(((float)take)*g_vampire.value);
ADDRLP4 148
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRGP4 g_vampire+8
INDIRF4
MULF4
CVFI4 4
ADDI4
ASGNI4
line 1342
;1342:		}
ADDRGP4 $656
JUMPV
LABELV $655
line 1343
;1343:		else {
line 1344
;1344:			attacker->health += (int)(((float)targ->health)*g_vampire.value);
ADDRLP4 148
CNSTI4 732
ASGNI4
ADDRLP4 152
ADDRFP4 8
INDIRP4
ADDRLP4 148
INDIRI4
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 148
INDIRI4
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 g_vampire+8
INDIRF4
MULF4
CVFI4 4
ADDI4
ASGNI4
line 1345
;1345:		}
LABELV $656
line 1346
;1346:		if(attacker->health>g_vampireMaxHealth.integer) {
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 g_vampireMaxHealth+12
INDIRI4
LEI4 $659
line 1347
;1347:			attacker->health = g_vampireMaxHealth.integer;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 g_vampireMaxHealth+12
INDIRI4
ASGNI4
line 1348
;1348:		}
LABELV $659
line 1349
;1349:	}
LABELV $652
line 1355
;1350:
;1351:	// oatmeal begin
;1352:
;1353:
;1354:	// Vampire Weapons
;1355:	if(mod==MOD_MACHINEGUN){
ADDRFP4 28
INDIRI4
CNSTI4 3
NEI4 $663
line 1356
;1356:		if(g_mgvampire.integer==1){
ADDRGP4 g_mgvampire+12
INDIRI4
CNSTI4 1
NEI4 $665
line 1357
;1357:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $668
line 1358
;1358:				attacker->health += take;
ADDRLP4 148
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1359
;1359:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $670
line 1360
;1360:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1361
;1361:				}
LABELV $670
line 1362
;1362:			}
LABELV $668
line 1363
;1363:		}
LABELV $665
line 1364
;1364:	}
LABELV $663
line 1366
;1365:
;1366:	if(mod==MOD_SHOTGUN){
ADDRFP4 28
INDIRI4
CNSTI4 1
NEI4 $672
line 1367
;1367:		if(g_sgvampire.integer==1){
ADDRGP4 g_sgvampire+12
INDIRI4
CNSTI4 1
NEI4 $674
line 1368
;1368:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $677
line 1369
;1369:				attacker->health += take;
ADDRLP4 148
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1370
;1370:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $679
line 1371
;1371:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1372
;1372:				}
LABELV $679
line 1373
;1373:			}
LABELV $677
line 1374
;1374:		}
LABELV $674
line 1375
;1375:	}
LABELV $672
line 1377
;1376:
;1377:	if(mod==MOD_RAILGUN){
ADDRFP4 28
INDIRI4
CNSTI4 10
NEI4 $681
line 1378
;1378:		if(g_rgvampire.integer==1){
ADDRGP4 g_rgvampire+12
INDIRI4
CNSTI4 1
NEI4 $683
line 1379
;1379:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $686
line 1380
;1380:				attacker->health += take;
ADDRLP4 148
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1381
;1381:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $688
line 1382
;1382:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1383
;1383:				}
LABELV $688
line 1384
;1384:			}
LABELV $686
line 1385
;1385:		}
LABELV $683
line 1386
;1386:	}
LABELV $681
line 1388
;1387:
;1388:	if(mod==MOD_LIGHTNING){
ADDRFP4 28
INDIRI4
CNSTI4 11
NEI4 $690
line 1389
;1389:		if(g_lgvampire.integer==1){
ADDRGP4 g_lgvampire+12
INDIRI4
CNSTI4 1
NEI4 $692
line 1390
;1390:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $695
line 1391
;1391:				attacker->health += take;
ADDRLP4 148
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1392
;1392:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $697
line 1393
;1393:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1394
;1394:				}
LABELV $697
line 1395
;1395:			}
LABELV $695
line 1396
;1396:		}
LABELV $692
line 1397
;1397:	}
LABELV $690
line 1399
;1398:
;1399:	if(mod==MOD_NAIL){
ADDRFP4 28
INDIRI4
CNSTI4 23
NEI4 $699
line 1400
;1400:		if(g_ngvampire.integer==1){
ADDRGP4 g_ngvampire+12
INDIRI4
CNSTI4 1
NEI4 $701
line 1401
;1401:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $704
line 1402
;1402:				attacker->health += take;
ADDRLP4 148
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1403
;1403:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $706
line 1404
;1404:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1405
;1405:				}
LABELV $706
line 1406
;1406:			}
LABELV $704
line 1407
;1407:		}
LABELV $701
line 1408
;1408:	}
LABELV $699
line 1410
;1409:
;1410:	if(mod==MOD_CHAINGUN){
ADDRFP4 28
INDIRI4
CNSTI4 24
NEI4 $708
line 1411
;1411:		if(g_cgvampire.integer==1){
ADDRGP4 g_cgvampire+12
INDIRI4
CNSTI4 1
NEI4 $710
line 1412
;1412:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $713
line 1413
;1413:				attacker->health += take;
ADDRLP4 148
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1414
;1414:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $715
line 1415
;1415:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1416
;1416:				}
LABELV $715
line 1417
;1417:			}
LABELV $713
line 1418
;1418:		}
LABELV $710
line 1419
;1419:	}
LABELV $708
line 1421
;1420:
;1421:	if(mod==MOD_PROXIMITY_MINE){
ADDRFP4 28
INDIRI4
CNSTI4 25
NEI4 $717
line 1422
;1422:		if(g_plvampire.integer==1){
ADDRGP4 g_plvampire+12
INDIRI4
CNSTI4 1
NEI4 $719
line 1423
;1423:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $722
line 1424
;1424:				attacker->health += take;
ADDRLP4 148
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1425
;1425:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $724
line 1426
;1426:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1427
;1427:				}
LABELV $724
line 1428
;1428:			}
LABELV $722
line 1429
;1429:		}
LABELV $719
line 1430
;1430:	}
LABELV $717
line 1432
;1431:
;1432:	if((mod==MOD_GRENADE)||(mod==MOD_GRENADE_SPLASH)){
ADDRLP4 148
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 4
EQI4 $728
ADDRLP4 148
INDIRI4
CNSTI4 5
NEI4 $726
LABELV $728
line 1433
;1433:		if(g_glvampire.integer==1){
ADDRGP4 g_glvampire+12
INDIRI4
CNSTI4 1
NEI4 $729
line 1434
;1434:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $732
line 1435
;1435:				attacker->health += take;
ADDRLP4 152
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1436
;1436:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $734
line 1437
;1437:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1438
;1438:				}
LABELV $734
line 1439
;1439:			}
LABELV $732
line 1440
;1440:		}
LABELV $729
line 1441
;1441:	}
LABELV $726
line 1443
;1442:
;1443:	if((mod==MOD_ROCKET)||(mod==MOD_ROCKET_SPLASH)){
ADDRLP4 152
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 6
EQI4 $738
ADDRLP4 152
INDIRI4
CNSTI4 7
NEI4 $736
LABELV $738
line 1444
;1444:		if(g_rlvampire.integer==1){
ADDRGP4 g_rlvampire+12
INDIRI4
CNSTI4 1
NEI4 $739
line 1445
;1445:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $742
line 1446
;1446:				attacker->health += take;
ADDRLP4 156
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1447
;1447:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $744
line 1448
;1448:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1449
;1449:				}
LABELV $744
line 1450
;1450:			}
LABELV $742
line 1451
;1451:		}
LABELV $739
line 1452
;1452:	}
LABELV $736
line 1454
;1453:
;1454:	if((mod==MOD_PLASMA)||(mod==MOD_PLASMA_SPLASH)){
ADDRLP4 156
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 8
EQI4 $748
ADDRLP4 156
INDIRI4
CNSTI4 9
NEI4 $746
LABELV $748
line 1455
;1455:		if(g_pgvampire.integer==1){
ADDRGP4 g_pgvampire+12
INDIRI4
CNSTI4 1
NEI4 $749
line 1456
;1456:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $752
line 1457
;1457:				attacker->health += take;
ADDRLP4 160
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1458
;1458:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $754
line 1459
;1459:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1460
;1460:				}
LABELV $754
line 1461
;1461:			}
LABELV $752
line 1462
;1462:		}
LABELV $749
line 1463
;1463:	}
LABELV $746
line 1465
;1464:
;1465:	if((mod==MOD_BFG)||(mod==MOD_BFG_SPLASH)){
ADDRLP4 160
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 12
EQI4 $758
ADDRLP4 160
INDIRI4
CNSTI4 13
NEI4 $756
LABELV $758
line 1466
;1466:		if(g_bfgvampire.integer==1){
ADDRGP4 g_bfgvampire+12
INDIRI4
CNSTI4 1
NEI4 $759
line 1467
;1467:			if(attacker->health<mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
GEI4 $762
line 1468
;1468:				attacker->health += take;
ADDRLP4 164
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1469
;1469:				if(attacker->health>mod_vampire_max_health){
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRGP4 mod_vampire_max_health
INDIRI4
LEI4 $764
line 1470
;1470:					attacker->health = mod_vampire_max_health;
ADDRFP4 8
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 mod_vampire_max_health
INDIRI4
ASGNI4
line 1471
;1471:				}
LABELV $764
line 1472
;1472:			}
LABELV $762
line 1473
;1473:		}
LABELV $759
line 1474
;1474:	}
LABELV $756
line 1480
;1475:
;1476:
;1477:	// oatmeal end
;1478:
;1479:	// do the damage
;1480:	if (take) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $766
line 1481
;1481:		targ->health = targ->health - take;
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1482
;1482:		if ( targ->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $768
line 1483
;1483:			targ->client->ps.stats[STAT_HEALTH] = targ->health;
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 168
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 1484
;1484:		}
LABELV $768
line 1486
;1485:
;1486:		if ( targ->health <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $770
line 1487
;1487:			if ( client )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $772
line 1488
;1488:				targ->flags |= FL_NO_KNOCKBACK;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
LABELV $772
line 1490
;1489:
;1490:			if (targ->health < -999)
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -999
GEI4 $774
line 1491
;1491:				targ->health = -999;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -999
ASGNI4
LABELV $774
line 1493
;1492:
;1493:			targ->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 1494
;1494:			targ->die (targ, inflictor, attacker, take, mod);
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 172
INDIRP4
CNSTI4 716
ADDP4
INDIRP4
CALLV
pop
line 1495
;1495:			return;
ADDRGP4 $489
JUMPV
LABELV $770
line 1497
;1496:		}
;1497:		else if ( targ->pain ) {
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $776
line 1498
;1498:			targ->pain (targ, attacker, take);
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 168
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CALLV
pop
line 1499
;1499:		}
LABELV $776
line 1500
;1500:	}
LABELV $766
line 1503
;1501:
;1502:
;1503:}
LABELV $489
endproc G_Damage 176 24
export CanDamage
proc CanDamage 112 28
line 1515
;1504:
;1505:
;1506:/*
;1507:============
;1508:CanDamage
;1509:
;1510:Returns qtrue if the inflictor can directly damage the target.  Used for
;1511:explosions and melee attacks.
;1512:============
;1513:*/
;1514:qboolean CanDamage (gentity_t *targ, vec3_t origin)
;1515:{
line 1522
;1516:	vec3_t	dest;
;1517:	trace_t	tr;
;1518:	vec3_t	midpoint;
;1519:
;1520:	// use the midpoint of the bounds instead of the origin, because
;1521:	// bmodels may have their origin is 0,0,0
;1522:	VectorAdd (targ->r.absmin, targ->r.absmax, midpoint);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 80
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 84
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1523
;1523:	VectorScale (midpoint, 0.5, midpoint);
ADDRLP4 88
CNSTF4 1056964608
ASGNF4
ADDRLP4 12
ADDRLP4 88
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 88
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+8
CNSTF4 1056964608
ADDRLP4 12+8
INDIRF4
MULF4
ASGNF4
line 1525
;1524:
;1525:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1526
;1526:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1527
;1527:	if (tr.fraction == 1.0 || tr.entityNum == targ->s.number)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
EQF4 $789
ADDRLP4 24+52
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $785
LABELV $789
line 1528
;1528:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $785
line 1532
;1529:
;1530:	// this should probably check in the plane of projection,
;1531:	// rather than in world coordinate, and also include Z
;1532:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1533
;1533:	dest[0] += 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1534
;1534:	dest[1] += 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1535
;1535:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1536
;1536:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $791
line 1537
;1537:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $791
line 1539
;1538:
;1539:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1540
;1540:	dest[0] += 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1541
;1541:	dest[1] -= 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1542
;1542:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1543
;1543:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $795
line 1544
;1544:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $795
line 1546
;1545:
;1546:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1547
;1547:	dest[0] -= 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1548
;1548:	dest[1] += 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1549
;1549:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1550
;1550:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $799
line 1551
;1551:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $799
line 1553
;1552:
;1553:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1554
;1554:	dest[0] -= 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1555
;1555:	dest[1] -= 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1556
;1556:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1557
;1557:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $803
line 1558
;1558:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $803
line 1561
;1559:
;1560:
;1561:	return qfalse;
CNSTI4 0
RETI4
LABELV $778
endproc CanDamage 112 28
export G_RadiusDamage
proc G_RadiusDamage 4196 32
line 1572
;1562:}
;1563:
;1564:
;1565:/*
;1566:============
;1567:G_RadiusDamage
;1568:============
;1569:*/
;1570:qboolean G_RadiusDamage ( vec3_t origin, gentity_t *attacker, float damage, float radius,
;1571:                          gentity_t *ignore, int mod)
;1572:{
line 1581
;1573:	float		points, dist;
;1574:	gentity_t	*ent;
;1575:	int			entityList[MAX_GENTITIES];
;1576:	int			numListedEntities;
;1577:	vec3_t		mins, maxs;
;1578:	vec3_t		v;
;1579:	vec3_t		dir;
;1580:	int			i, e;
;1581:	qboolean	hitClient = qfalse;
ADDRLP4 4168
CNSTI4 0
ASGNI4
line 1583
;1582:
;1583:	if ( radius < 1 ) {
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $807
line 1584
;1584:		radius = 1;
ADDRFP4 12
CNSTF4 1065353216
ASGNF4
line 1585
;1585:	}
LABELV $807
line 1587
;1586:
;1587:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $809
line 1588
;1588:		mins[i] = origin[i] - radius;
ADDRLP4 4172
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4172
INDIRI4
ADDRLP4 4144
ADDP4
ADDRLP4 4172
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
SUBF4
ASGNF4
line 1589
;1589:		maxs[i] = origin[i] + radius;
ADDRLP4 4176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4176
INDIRI4
ADDRLP4 4156
ADDP4
ADDRLP4 4176
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 1590
;1590:	}
LABELV $810
line 1587
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $809
line 1592
;1591:
;1592:	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );
ADDRLP4 4144
ARGP4
ADDRLP4 4156
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4172
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4140
ADDRLP4 4172
INDIRI4
ASGNI4
line 1594
;1593:
;1594:	for ( e = 0 ; e < numListedEntities ; e++ ) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $816
JUMPV
LABELV $813
line 1595
;1595:		ent = &g_entities[entityList[ e ]];
ADDRLP4 4
CNSTI4 816
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1597
;1596:
;1597:		if (ent == ignore)
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRFP4 16
INDIRP4
CVPU4 4
NEU4 $817
line 1598
;1598:			continue;
ADDRGP4 $814
JUMPV
LABELV $817
line 1599
;1599:		if (!ent->takedamage)
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $819
line 1600
;1600:			continue;
ADDRGP4 $814
JUMPV
LABELV $819
line 1603
;1601:
;1602:		// find the distance from the edge of the bounding box
;1603:		for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $821
line 1604
;1604:			if ( origin[i] < ent->r.absmin[i] ) {
ADDRLP4 4176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4176
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4176
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $825
line 1605
;1605:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 4180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4180
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4180
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 4180
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1606
;1606:			}
ADDRGP4 $826
JUMPV
LABELV $825
line 1607
;1607:			else if ( origin[i] > ent->r.absmax[i] ) {
ADDRLP4 4180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4180
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4180
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $827
line 1608
;1608:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 4184
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4184
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4184
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4184
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1609
;1609:			}
ADDRGP4 $828
JUMPV
LABELV $827
line 1610
;1610:			else {
line 1611
;1611:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 1612
;1612:			}
LABELV $828
LABELV $826
line 1613
;1613:		}
LABELV $822
line 1603
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $821
line 1615
;1614:
;1615:		dist = VectorLength( v );
ADDRLP4 8
ARGP4
ADDRLP4 4176
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 4176
INDIRF4
ASGNF4
line 1616
;1616:		if ( dist >= radius ) {
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
LTF4 $829
line 1617
;1617:			continue;
ADDRGP4 $814
JUMPV
LABELV $829
line 1620
;1618:		}
;1619:
;1620:		points = damage * ( 1.0 - dist / radius );
ADDRLP4 40
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
SUBF4
MULF4
ASGNF4
line 1622
;1621:
;1622:		if( CanDamage (ent, origin) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4180
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 4180
INDIRI4
CNSTI4 0
EQI4 $831
line 1623
;1623:			if( LogAccuracyHit( ent, attacker ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4184
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 4184
INDIRI4
CNSTI4 0
EQI4 $833
line 1624
;1624:				hitClient = qtrue;
ADDRLP4 4168
CNSTI4 1
ASGNI4
line 1625
;1625:			}
LABELV $833
line 1626
;1626:			VectorSubtract (ent->r.currentOrigin, origin, dir);
ADDRLP4 4192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1629
;1627:			// push the center of mass higher than the origin so players
;1628:			// get knocked into the air more
;1629:			dir[2] += 24;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 1630
;1630:			G_Damage (ent, NULL, attacker, dir, origin, (int)points, DAMAGE_RADIUS, mod);
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1631
;1631:		}
LABELV $831
line 1632
;1632:	}
LABELV $814
line 1594
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $816
ADDRLP4 20
INDIRI4
ADDRLP4 4140
INDIRI4
LTI4 $813
line 1634
;1633:
;1634:	return hitClient;
ADDRLP4 4168
INDIRI4
RETI4
LABELV $806
endproc G_RadiusDamage 4196 32
export monster_die
proc monster_die 28 12
line 1653
;1635:}
;1636:
;1637:
;1638:
;1639:
;1640:
;1641:// Monster code
;1642:
;1643:
;1644:/*
;1645:==================
;1646:monster_die
;1647:
;1648:definitely mangled from player_die with less about the player
;1649:==================
;1650:*/
;1651:
;1652:void monster_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath )
;1653:{
line 1655
;1654:	int			contents;
;1655:	int			killer = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1657
;1656:
;1657:	if (self->client && self->client->hook) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTU4 0
ASGNU4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $839
ADDRLP4 8
INDIRP4
CNSTI4 1164
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $839
line 1658
;1658:		Weapon_HookFree(self->client->hook);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1164
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 1659
;1659:	}
LABELV $839
line 1660
;1660:	if ((self->client->ps.eFlags & EF_TICKING) && self->activator) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $841
ADDRLP4 16
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $841
line 1661
;1661:		self->client->ps.eFlags &= ~EF_TICKING;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 1662
;1662:		self->activator->think = G_FreeEntity;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 1663
;1663:		self->activator->nextthink = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1664
;1664:	}
LABELV $841
line 1665
;1665:	self->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 1666
;1666:	self->takedamage = qtrue;	// can still be gibbed
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 1668
;1667:
;1668:	self->s.weapon = WP_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 1669
;1669:	self->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 1670
;1670:	self->r.contents = CONTENTS_CORPSE;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 1672
;1671:
;1672:	self->s.angles[0] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 0
ASGNF4
line 1673
;1673:	self->s.angles[2] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 0
ASGNF4
line 1674
;1674:	LookAtKiller (self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 LookAtKiller
CALLV
pop
line 1676
;1675:
;1676:	VectorCopy( self->s.angles, self->client->ps.viewangles );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1678
;1677:
;1678:	self->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1680
;1679:
;1680:	self->r.maxs[2] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 3238002688
ASGNF4
line 1684
;1681:
;1682:
;1683:	// never gib in a nodrop
;1684:	contents = trap_PointContents( self->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 24
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 1686
;1685:
;1686:	if ( (self->health <= GIB_HEALTH && !(contents & CONTENTS_NODROP) && g_blood.integer) || meansOfDeath == MOD_SUICIDE) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $849
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $849
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $847
LABELV $849
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $844
LABELV $847
line 1688
;1687:		// gib death
;1688:		GibEntity( self, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 1689
;1689:	}
ADDRGP4 $845
JUMPV
LABELV $844
line 1690
;1690:	else {
line 1695
;1691:		// normal death
;1692:
;1693:		// for the no-blood option, we need to prevent the health
;1694:		// from going to gib level
;1695:		if ( self->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $850
line 1696
;1696:			self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -39
ASGNI4
line 1697
;1697:		}
LABELV $850
line 1700
;1698:
;1699:		// the body can still be gibbed
;1700:		self->die = body_die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 body_die
ASGNP4
line 1702
;1701:
;1702:	}
LABELV $845
line 1705
;1703:
;1704:
;1705:	trap_LinkEntity (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1707
;1706:
;1707:}
LABELV $838
endproc monster_die 28 12
import neutralObelisk
import G_IsARoundBasedGametype
import G_UsesTheWhiteFlag
import G_UsesTeamFlags
import G_IsATeamGametype
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
LABELV $637
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $373
byte 1 69
byte 1 88
byte 1 67
byte 1 69
byte 1 76
byte 1 76
byte 1 69
byte 1 78
byte 1 84
byte 1 0
align 1
LABELV $316
byte 1 71
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 76
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $315
byte 1 65
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 58
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
byte 1 103
byte 1 97
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $282
byte 1 75
byte 1 105
byte 1 108
byte 1 108
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
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $281
byte 1 60
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 62
byte 1 0
align 1
LABELV $274
byte 1 60
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 62
byte 1 0
align 1
LABELV $273
byte 1 60
byte 1 110
byte 1 111
byte 1 110
byte 1 45
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 62
byte 1 0
align 1
LABELV $246
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
LABELV $245
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
LABELV $225
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $224
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
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
LABELV $209
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 65
byte 1 80
byte 1 80
byte 1 76
byte 1 69
byte 1 0
align 1
LABELV $208
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 74
byte 1 85
byte 1 73
byte 1 67
byte 1 69
byte 1 68
byte 1 0
align 1
LABELV $207
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 75
byte 1 65
byte 1 77
byte 1 73
byte 1 75
byte 1 65
byte 1 90
byte 1 69
byte 1 0
align 1
LABELV $206
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 82
byte 1 79
byte 1 88
byte 1 73
byte 1 77
byte 1 73
byte 1 84
byte 1 89
byte 1 95
byte 1 77
byte 1 73
byte 1 78
byte 1 69
byte 1 0
align 1
LABELV $205
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 73
byte 1 78
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $204
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 78
byte 1 65
byte 1 73
byte 1 76
byte 1 0
align 1
LABELV $203
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 95
byte 1 72
byte 1 85
byte 1 82
byte 1 84
byte 1 0
align 1
LABELV $202
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 65
byte 1 82
byte 1 71
byte 1 69
byte 1 84
byte 1 95
byte 1 76
byte 1 65
byte 1 83
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $201
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 85
byte 1 73
byte 1 67
byte 1 73
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $200
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $199
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 70
byte 1 82
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $198
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 67
byte 1 82
byte 1 85
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $197
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 65
byte 1 86
byte 1 65
byte 1 0
align 1
LABELV $196
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 76
byte 1 73
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $195
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $194
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $193
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $192
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $191
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $190
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $189
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 0
align 1
LABELV $188
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $187
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $186
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $185
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $184
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 77
byte 1 65
byte 1 67
byte 1 72
byte 1 73
byte 1 78
byte 1 69
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $183
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 76
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $182
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $181
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 0
align 1
LABELV $174
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $141
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 67
byte 1 117
byte 1 98
byte 1 101
byte 1 0
align 1
LABELV $140
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 67
byte 1 117
byte 1 98
byte 1 101
byte 1 0
align 1
LABELV $92
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 58
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
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $89
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
