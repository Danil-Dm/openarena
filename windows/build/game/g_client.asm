data
align 4
LABELV playerMins
byte 4 3245342720
byte 4 3245342720
byte 4 3250585600
align 4
LABELV playerMaxs
byte 4 1097859072
byte 4 1097859072
byte 4 1107296256
export SP_info_player_deathmatch
code
proc SP_info_player_deathmatch 8 12
file "../../../code/game/g_client.c"
line 37
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
;25:// g_client.c -- client functions that don't happen every frame
;26:
;27:static vec3_t	playerMins = {-15, -15, -24};
;28:static vec3_t	playerMaxs = {15, 15, 32};
;29:
;30:/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 32) initial
;31:potential spawning position for deathmatch games.
;32:The first time a player enters the game, they will be at an 'initial' spot.
;33:Targets will be fired when someone spawns in on them.
;34:"nobots" will prevent bots from using this spot.
;35:"nohumans" will prevent non-bots from using this spot.
;36:*/
;37:void SP_info_player_deathmatch( gentity_t *ent ) {
line 40
;38:	int		i;
;39:
;40:	G_SpawnInt( "nobots", "0", &i);
ADDRGP4 $61
ARGP4
ADDRGP4 $62
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 41
;41:	if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $63
line 42
;42:		ent->flags |= FL_NO_BOTS;
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
CNSTI4 8192
BORI4
ASGNI4
line 43
;43:	}
LABELV $63
line 44
;44:	G_SpawnInt( "nohumans", "0", &i );
ADDRGP4 $65
ARGP4
ADDRGP4 $62
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 45
;45:	if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $66
line 46
;46:		ent->flags |= FL_NO_HUMANS;
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
CNSTI4 16384
BORI4
ASGNI4
line 47
;47:	}
LABELV $66
line 48
;48:}
LABELV $60
endproc SP_info_player_deathmatch 8 12
export SP_info_player_start
proc SP_info_player_start 0 4
line 53
;49:
;50:/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 32)
;51:equivelant to info_player_deathmatch
;52:*/
;53:void SP_info_player_start(gentity_t *ent) {
line 54
;54:	ent->classname = "info_player_deathmatch";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $69
ASGNP4
line 55
;55:	SP_info_player_deathmatch( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SP_info_player_deathmatch
CALLV
pop
line 56
;56:}
LABELV $68
endproc SP_info_player_start 0 4
export SP_domination_point
proc SP_domination_point 0 0
line 59
;57:
;58://One for Standard Domination, not really a player spawn point
;59:void SP_domination_point(gentity_t *ent) {
line 60
;60:}
LABELV $70
endproc SP_domination_point 0 0
export SP_info_player_intermission
proc SP_info_player_intermission 0 0
line 65
;61:
;62:/*QUAKED info_player_intermission (1 0 1) (-16 -16 -24) (16 16 32)
;63:The intermission will be viewed from this point.  Target an info_notnull for the view direction.
;64:*/
;65:void SP_info_player_intermission( gentity_t *ent ) {
line 67
;66:
;67:}
LABELV $71
endproc SP_info_player_intermission 0 0
export SpotWouldTelefrag
proc SpotWouldTelefrag 4144 16
line 85
;68:
;69:
;70:
;71:/*
;72:=======================================================================
;73:
;74: SelectSpawnPoint
;75:
;76:=======================================================================
;77:*/
;78:
;79:/*
;80:================
;81:SpotWouldTelefrag
;82:
;83:================
;84:*/
;85:qboolean SpotWouldTelefrag( gentity_t *spot ) {
line 91
;86:	int			i, num;
;87:	int			touch[MAX_GENTITIES];
;88:	gentity_t	*hit;
;89:	vec3_t		mins, maxs;
;90:
;91:	VectorAdd( spot->s.origin, playerMins, mins );
ADDRLP4 4132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4108
ADDRLP4 4132
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 playerMins
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+4
ADDRLP4 4132
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 playerMins+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 playerMins+8
INDIRF4
ADDF4
ASGNF4
line 92
;92:	VectorAdd( spot->s.origin, playerMaxs, maxs );
ADDRLP4 4136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4120
ADDRLP4 4136
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 playerMaxs
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+4
ADDRLP4 4136
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 playerMaxs+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 playerMaxs+8
INDIRF4
ADDF4
ASGNF4
line 93
;93:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 4108
ARGP4
ADDRLP4 4120
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4140
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 4140
INDIRI4
ASGNI4
line 95
;94:
;95:	for (i=0 ; i<num ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $84
JUMPV
LABELV $81
line 96
;96:		hit = &g_entities[touch[i]];
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 98
;97:		//if ( hit->client && hit->client->ps.stats[STAT_HEALTH] > 0 ) {
;98:		if ( hit->client) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $85
line 99
;99:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $72
JUMPV
LABELV $85
line 102
;100:		}
;101:
;102:	}
LABELV $82
line 95
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $84
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $81
line 104
;103:
;104:	return qfalse;
CNSTI4 0
RETI4
LABELV $72
endproc SpotWouldTelefrag 4144 16
export SelectNearestDeathmatchSpawnPoint
proc SelectNearestDeathmatchSpawnPoint 40 12
line 115
;105:}
;106:
;107:/*
;108:================
;109:SelectNearestDeathmatchSpawnPoint
;110:
;111:Find the spot that we DON'T want to use
;112:================
;113:*/
;114:#define	MAX_SPAWN_POINTS	128
;115:gentity_t *SelectNearestDeathmatchSpawnPoint( vec3_t from ) {
line 121
;116:	gentity_t	*spot;
;117:	vec3_t		delta;
;118:	float		dist, nearestDist;
;119:	gentity_t	*nearestSpot;
;120:
;121:	nearestDist = 999999;
ADDRLP4 20
CNSTF4 1232348144
ASGNF4
line 122
;122:	nearestSpot = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 123
;123:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $89
JUMPV
LABELV $88
line 125
;124:
;125:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
line 127
;126:
;127:		VectorSubtract( spot->s.origin, from, delta );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 128
;128:		dist = VectorLength( delta );
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 36
INDIRF4
ASGNF4
line 129
;129:		if ( dist < nearestDist ) {
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
GEF4 $93
line 130
;130:			nearestDist = dist;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 131
;131:			nearestSpot = spot;
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
line 132
;132:		}
LABELV $93
line 133
;133:	}
LABELV $89
line 125
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $69
ARGP4
ADDRLP4 28
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $88
line 135
;134:
;135:	return nearestSpot;
ADDRLP4 24
INDIRP4
RETP4
LABELV $87
endproc SelectNearestDeathmatchSpawnPoint 40 12
proc SelectRandomDeathmatchSpawnPoint 536 12
line 145
;136:}
;137:
;138:#define	MAX_SPAWN_POINTS	128
;139:/**
;140: * Pick a random info_player_deathmatch spawnpoint
;141: * Will prefer a spot that wont telefrag if such a point exist. 
;142: * @param filter_flags Will NEVER pick a spawnpoint mathcing these flags.
;143: * @return Returns a pointer to a spot or NULL if no spots exists. 
;144: */
;145:static gentity_t *SelectRandomDeathmatchSpawnPoint( int filter_flags ) {
line 152
;146:	gentity_t	*spot;
;147:	int			count;
;148:	int			selection;
;149:	gentity_t	*spots[MAX_SPAWN_POINTS];
;150:	gentity_t	*last_valid_spot; //Last valid spot although it might telefrag; 
;151:
;152:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 153
;153:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 154
;154:	last_valid_spot = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
ADDRGP4 $97
JUMPV
LABELV $96
line 156
;155:
;156:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
line 157
;157:		if (spot->flags & filter_flags) {
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
BANDI4
CNSTI4 0
EQI4 $99
line 158
;158:			continue;
ADDRGP4 $97
JUMPV
LABELV $99
line 160
;159:		}
;160:		last_valid_spot = spot;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
line 161
;161:		if ( SpotWouldTelefrag( spot ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 528
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 528
INDIRI4
CNSTI4 0
EQI4 $101
line 162
;162:			continue;
ADDRGP4 $97
JUMPV
LABELV $101
line 164
;163:		}
;164:		spots[ count ] = spot;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 165
;165:		count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 166
;166:	}
LABELV $97
line 156
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $69
ARGP4
ADDRLP4 528
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 528
INDIRP4
ASGNP4
ADDRLP4 528
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $96
line 168
;167:
;168:	if ( count == 0 ) {	// no spots that won't telefrag
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $103
line 169
;169:		return last_valid_spot;
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $95
JUMPV
LABELV $103
line 172
;170:	}
;171:
;172:	selection = rand() % count;
ADDRLP4 532
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 524
ADDRLP4 532
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
ASGNI4
line 173
;173:	return spots[ selection ];
ADDRLP4 524
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
RETP4
LABELV $95
endproc SelectRandomDeathmatchSpawnPoint 536 12
export SelectSpawnPoint
proc SelectSpawnPoint 24 4
line 183
;174:}
;175:
;176:/*
;177:===========
;178:SelectSpawnPoint
;179:
;180:Chooses a player start, deathmatch start, etc
;181:============
;182:*/
;183:gentity_t *SelectSpawnPoint ( vec3_t avoidPoint, vec3_t origin, vec3_t angles, int filter_flags ) {	
line 187
;184:	gentity_t	*spot;
;185:	gentity_t	*nearestSpot;
;186:
;187:	nearestSpot = SelectNearestDeathmatchSpawnPoint( avoidPoint );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 SelectNearestDeathmatchSpawnPoint
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 189
;188:
;189:	spot = SelectRandomDeathmatchSpawnPoint ( filter_flags );
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 SelectRandomDeathmatchSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 190
;190:	if ( spot == nearestSpot ) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $106
line 192
;191:		// roll again if it would be real close to point of death
;192:		spot = SelectRandomDeathmatchSpawnPoint ( filter_flags );
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 SelectRandomDeathmatchSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 193
;193:		if ( spot == nearestSpot ) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $108
line 195
;194:			// last try
;195:			spot = SelectRandomDeathmatchSpawnPoint ( filter_flags );
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 SelectRandomDeathmatchSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 196
;196:		}		
LABELV $108
line 197
;197:	}
LABELV $106
line 200
;198:
;199:	// find a single player start spot
;200:	if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $110
line 201
;201:		if (g_cheats.integer) {
ADDRGP4 g_cheats+12
INDIRI4
CNSTI4 0
EQI4 $112
line 203
;202:			//If in developer mode: Crash to ensure that the developer discovers the problem.
;203:			G_Error( "Couldn't find a spawn point.\nAny map must contain at least one \"info_player_deathmatch\" with no spawn restrictions" );
ADDRGP4 $115
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 204
;204:		}
LABELV $112
line 205
;205:		spot = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 206
;206:	}
LABELV $110
line 208
;207:
;208:	VectorCopy (spot->s.origin, origin);
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 209
;209:	origin[2] += 9;
ADDRLP4 16
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 210
;210:	VectorCopy (spot->s.angles, angles);
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 212
;211:
;212:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $105
endproc SelectSpawnPoint 24 4
proc SelectInitialSpawnPoint 20 16
line 223
;213:}
;214:
;215:/*
;216:===========
;217:SelectInitialSpawnPoint
;218:
;219:Try to find a spawn point marked 'initial', otherwise
;220:use normal spawn selection.
;221:============
;222:*/
;223:static gentity_t *SelectInitialSpawnPoint( vec3_t origin, vec3_t angles, int filter_flags ) {
line 226
;224:	gentity_t	*spot;
;225:
;226:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $118
JUMPV
LABELV $117
line 227
;227:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
line 228
;228:		if (spot->flags & filter_flags) {
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
BANDI4
CNSTI4 0
EQI4 $120
line 229
;229:			continue;
ADDRGP4 $118
JUMPV
LABELV $120
line 231
;230:		}
;231:		if ( spot->spawnflags & 1 ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $122
line 232
;232:			break;
ADDRGP4 $119
JUMPV
LABELV $122
line 234
;233:		}
;234:	}
LABELV $118
line 227
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $69
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $117
LABELV $119
line 236
;235:
;236:	if ( !spot || SpotWouldTelefrag( spot ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $126
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $124
LABELV $126
line 237
;237:		return SelectSpawnPoint( vec3_origin, origin, angles, filter_flags );
ADDRGP4 vec3_origin
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
RETP4
ADDRGP4 $116
JUMPV
LABELV $124
line 240
;238:	}
;239:
;240:	VectorCopy (spot->s.origin, origin);
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 241
;241:	origin[2] += 9;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 242
;242:	VectorCopy (spot->s.angles, angles);
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 244
;243:
;244:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $116
endproc SelectInitialSpawnPoint 20 16
proc SelectSpectatorSpawnPoint 0 0
line 253
;245:}
;246:
;247:/*
;248:===========
;249:SelectSpectatorSpawnPoint
;250:
;251:============
;252:*/
;253:static gentity_t *SelectSpectatorSpawnPoint( vec3_t origin, vec3_t angles ) {
line 254
;254:	FindIntermissionPoint();
ADDRGP4 FindIntermissionPoint
CALLV
pop
line 256
;255:
;256:	VectorCopy( level.intermission_origin, origin );
ADDRFP4 0
INDIRP4
ADDRGP4 level+9160
INDIRB
ASGNB 12
line 257
;257:	VectorCopy( level.intermission_angle, angles );
ADDRFP4 4
INDIRP4
ADDRGP4 level+9172
INDIRB
ASGNB 12
line 259
;258:
;259:	return NULL; //spot;
CNSTP4 0
RETP4
LABELV $127
endproc SelectSpectatorSpawnPoint 0 0
export InitBodyQue
proc InitBodyQue 12 0
line 275
;260:}
;261:
;262:/*
;263:=======================================================================
;264:
;265:BODYQUE
;266:
;267:=======================================================================
;268:*/
;269:
;270:/*
;271:===============
;272:InitBodyQue
;273:===============
;274:*/
;275:void InitBodyQue (void) {
line 279
;276:	int		i;
;277:	gentity_t	*ent;
;278:
;279:	level.bodyQueIndex = 0;
ADDRGP4 level+9192
CNSTI4 0
ASGNI4
line 280
;280:	for (i=0; i<BODY_QUEUE_SIZE ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $132
line 281
;281:		ent = G_Spawn();
ADDRLP4 8
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 282
;282:		ent->classname = "bodyque";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $136
ASGNP4
line 283
;283:		ent->neverFree = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 1
ASGNI4
line 284
;284:		level.bodyQue[i] = ent;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9196
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 285
;285:	}
LABELV $133
line 280
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $132
line 286
;286:}
LABELV $130
endproc InitBodyQue 12 0
export BodySink
proc BodySink 4 4
line 295
;287:
;288:/*
;289:=============
;290:BodySink
;291:
;292:After sitting around for five seconds, fall into the ground and dissapear
;293:=============
;294:*/
;295:void BodySink( gentity_t *ent ) {
line 296
;296:	if ( level.time - ent->timestamp > 6500 ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
SUBI4
CNSTI4 6500
LEI4 $139
line 300
;297:
;298:
;299:		// the body ques are never actually freed, they are just unlinked
;300:		trap_UnlinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 301
;301:		ent->physicsObject = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 0
ASGNI4
line 302
;302:		return;	
ADDRGP4 $138
JUMPV
LABELV $139
line 304
;303:	}
;304:	ent->nextthink = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 305
;305:	ent->s.pos.trBase[2] -= 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 306
;306:}
LABELV $138
endproc BodySink 4 4
export CopyToBodyQue
proc CopyToBodyQue 56 8
line 316
;307:
;308:/*
;309:=============
;310:CopyToBodyQue
;311:
;312:A player is respawning, so make an entity that looks
;313:just like the existing corpse to leave behind.
;314:=============
;315:*/
;316:void CopyToBodyQue( gentity_t *ent ) {
line 322
;317:	gentity_t	*e;
;318:	int i;
;319:	gentity_t		*body;
;320:	int			contents;
;321:
;322:	trap_UnlinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 325
;323:
;324:	// if client is in a nodrop area, don't leave the body
;325:	contents = trap_PointContents( ent->s.origin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 16
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 16
INDIRI4
ASGNI4
line 326
;326:	if ( (contents & CONTENTS_NODROP) && !(ent->s.eFlags & EF_KAMIKAZE) ) { //the check for kamikaze is a workaround for ctf4ish
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $144
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $144
line 327
;327:		return;
ADDRGP4 $143
JUMPV
LABELV $144
line 331
;328:	}
;329:
;330:	// grab a body que and cycle to the next one
;331:	body = level.bodyQue[ level.bodyQueIndex ];
ADDRLP4 4
ADDRGP4 level+9192
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9196
ADDP4
INDIRP4
ASGNP4
line 332
;332:	level.bodyQueIndex = (level.bodyQueIndex + 1) % BODY_QUEUE_SIZE;
ADDRGP4 level+9192
ADDRGP4 level+9192
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 8
MODI4
ASGNI4
line 335
;333:
;334:	//Check if the next body has the kamikaze, in that case skip it.
;335:	for(i=0;(level.bodyQue[ level.bodyQueIndex ]->s.eFlags & EF_KAMIKAZE) && (i<10);i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $153
JUMPV
LABELV $150
line 336
;336:		level.bodyQueIndex = (level.bodyQueIndex + 1) % BODY_QUEUE_SIZE;
ADDRGP4 level+9192
ADDRGP4 level+9192
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 8
MODI4
ASGNI4
line 337
;337:	}
LABELV $151
line 335
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $153
ADDRGP4 level+9192
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9196
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $158
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $150
LABELV $158
line 339
;338:
;339:	body->s = ent->s;
ADDRLP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 208
line 340
;340:	body->s.eFlags = EF_DEAD;		// clear EF_TALK, etc
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 1
ASGNI4
line 341
;341:	if ( ent->s.eFlags & EF_KAMIKAZE ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $159
line 342
;342:		ent->s.eFlags &= ~EF_KAMIKAZE;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 343
;343:		body->s.eFlags |= EF_KAMIKAZE;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 346
;344:
;345:		// check if there is a kamikaze timer around for this owner
;346:		for (i = 0; i < level.num_entities; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $164
JUMPV
LABELV $161
line 347
;347:			e = &g_entities[i];
ADDRLP4 8
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 348
;348:			if (!e->inuse)
ADDRLP4 8
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $166
line 349
;349:				continue;
ADDRGP4 $162
JUMPV
LABELV $166
line 350
;350:			if (e->activator != ent)
ADDRLP4 8
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $168
line 351
;351:				continue;
ADDRGP4 $162
JUMPV
LABELV $168
line 352
;352:			if (!strequals(e->classname, "kamikaze timer"))
ADDRLP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $172
ARGP4
ADDRLP4 28
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $170
line 353
;353:				continue;
ADDRGP4 $162
JUMPV
LABELV $170
line 354
;354:			e->activator = body;
ADDRLP4 8
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 355
;355:			break;
ADDRGP4 $163
JUMPV
LABELV $162
line 346
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $164
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $161
LABELV $163
line 357
;356:		}
;357:	}
LABELV $159
line 358
;358:	body->s.powerups = 0;	// clear powerups
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 359
;359:	body->s.loopSound = 0;	// clear lava burning
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 360
;360:	body->s.number = body - g_entities;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ASGNI4
line 361
;361:	body->timestamp = level.time;
ADDRLP4 4
INDIRP4
CNSTI4 640
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 362
;362:	body->physicsObject = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 1
ASGNI4
line 363
;363:	body->physicsBounce = 0;		// don't bounce
ADDRLP4 4
INDIRP4
CNSTI4 568
ADDP4
CNSTF4 0
ASGNF4
line 364
;364:	if ( body->s.groundEntityNum == ENTITYNUM_NONE ) {
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $174
line 365
;365:		body->s.pos.trType = TR_GRAVITY;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 366
;366:		body->s.pos.trTime = level.time;
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 367
;367:		VectorCopy( ent->client->ps.velocity, body->s.pos.trDelta );
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 368
;368:	} else {
ADDRGP4 $175
JUMPV
LABELV $174
line 369
;369:		body->s.pos.trType = TR_STATIONARY;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 370
;370:	}
LABELV $175
line 371
;371:	body->s.event = 0;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 375
;372:
;373:	// change the animation to the last-frame only, so the sequence
;374:	// doesn't repeat anew for the body
;375:	switch ( body->s.legsAnim & ~ANIM_TOGGLEBIT ) {
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $177
ADDRLP4 24
INDIRI4
CNSTI4 5
GTI4 $177
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $183
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $183
address $180
address $180
address $181
address $181
address $182
address $182
code
LABELV $180
line 378
;376:	case BOTH_DEATH1:
;377:	case BOTH_DEAD1:
;378:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD1;
ADDRLP4 36
CNSTI4 1
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 379
;379:		break;
ADDRGP4 $178
JUMPV
LABELV $181
line 382
;380:	case BOTH_DEATH2:
;381:	case BOTH_DEAD2:
;382:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD2;
ADDRLP4 44
CNSTI4 3
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 383
;383:		break;
ADDRGP4 $178
JUMPV
LABELV $182
LABELV $177
line 387
;384:	case BOTH_DEATH3:
;385:	case BOTH_DEAD3:
;386:	default:
;387:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD3;
ADDRLP4 52
CNSTI4 5
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 388
;388:		break;
LABELV $178
line 391
;389:	}
;390:
;391:	body->r.svFlags = ent->r.svFlags;
ADDRLP4 32
CNSTI4 424
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 392
;392:	VectorCopy (ent->r.mins, body->r.mins);
ADDRLP4 36
CNSTI4 436
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 393
;393:	VectorCopy (ent->r.maxs, body->r.maxs);
ADDRLP4 40
CNSTI4 448
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 394
;394:	VectorCopy (ent->r.absmin, body->r.absmin);
ADDRLP4 44
CNSTI4 464
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 395
;395:	VectorCopy (ent->r.absmax, body->r.absmax);
ADDRLP4 48
CNSTI4 476
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 397
;396:
;397:	body->clipmask = CONTENTS_SOLID | CONTENTS_PLAYERCLIP;
ADDRLP4 4
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 65537
ASGNI4
line 398
;398:	body->r.contents = CONTENTS_CORPSE;
ADDRLP4 4
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 399
;399:	body->r.ownerNum = ent->s.number;
ADDRLP4 4
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 401
;400:
;401:	body->nextthink = level.time + 5000;
ADDRLP4 4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 402
;402:	body->think = BodySink;
ADDRLP4 4
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 BodySink
ASGNP4
line 404
;403:
;404:	body->die = body_die;
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 body_die
ASGNP4
line 407
;405:
;406:	// don't take more damage if already gibbed
;407:	if ( ent->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $185
line 408
;408:		body->takedamage = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 409
;409:	} else {
ADDRGP4 $186
JUMPV
LABELV $185
line 410
;410:		body->takedamage = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 411
;411:	}
LABELV $186
line 414
;412:
;413:
;414:	VectorCopy ( body->s.pos.trBase, body->r.currentOrigin );
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 415
;415:	trap_LinkEntity (body);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 416
;416:}
LABELV $143
endproc CopyToBodyQue 56 8
export SetClientViewAngle
proc SetClientViewAngle 16 0
line 427
;417:
;418://======================================================================
;419:
;420:
;421:/*
;422:==================
;423:SetClientViewAngle
;424:
;425:==================
;426:*/
;427:void SetClientViewAngle( gentity_t *ent, vec3_t angle ) {
line 431
;428:	int			i;
;429:
;430:	// set the delta angle
;431:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $188
line 434
;432:		int		cmdAngle;
;433:
;434:		cmdAngle = ANGLE2SHORT(angle[i]);
ADDRLP4 4
CNSTF4 1199570944
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 435
;435:		ent->client->ps.delta_angles[i] = cmdAngle - ent->client->pers.cmd.angles[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 56
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 436
;436:	}
LABELV $189
line 431
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $188
line 437
;437:	VectorCopy( angle, ent->s.angles );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 438
;438:	VectorCopy (ent->s.angles, ent->client->ps.viewangles);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 439
;439:}
LABELV $187
endproc SetClientViewAngle 16 0
export ClientRespawn
proc ClientRespawn 36 8
line 446
;440:
;441:/*
;442:================
;443:respawn
;444:================
;445:*/
;446:void ClientRespawn( gentity_t *ent ) {
line 449
;447:	gentity_t	*tent;
;448:
;449:	if( !G_IsARoundBasedGametype(g_gametype.integer) && !ent->client->isEliminated)
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $193
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $193
line 450
;450:	{
line 451
;451:		ent->client->isEliminated = qtrue; //must not be true in warmup
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 1
ASGNI4
line 452
;452:	} else {
ADDRGP4 $194
JUMPV
LABELV $193
line 454
;453:		//Must always be false in other gametypes
;454:		ent->client->isEliminated = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 0
ASGNI4
line 455
;455:	}
LABELV $194
line 456
;456:	CopyToBodyQue (ent); //Unlinks ent
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CopyToBodyQue
CALLV
pop
line 458
;457:
;458:	if(g_gametype.integer==GT_LMS) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
NEI4 $196
line 459
;459:		if(ent->client->pers.livesLeft>0)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
CNSTI4 0
LEI4 $199
line 460
;460:		{
line 461
;461:			ent->client->isEliminated = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 0
ASGNI4
line 462
;462:		}
ADDRGP4 $200
JUMPV
LABELV $199
line 464
;463:		else //We have used all our lives
;464:		{
line 465
;465:			if( ent->client->isEliminated!=qtrue) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 1
EQI4 $192
line 466
;466:				ent->client->isEliminated = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 1
ASGNI4
line 467
;467:				if((g_lms_mode.integer == 2 || g_lms_mode.integer == 3) && level.roundNumber == level.roundNumberStarted) {
ADDRGP4 g_lms_mode+12
INDIRI4
CNSTI4 2
EQI4 $209
ADDRGP4 g_lms_mode+12
INDIRI4
CNSTI4 3
NEI4 $203
LABELV $209
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $203
line 468
;468:					LMSpoint();	
ADDRGP4 LMSpoint
CALLV
pop
line 469
;469:				}
LABELV $203
line 472
;470:				//Sago: This is really bad
;471:				//TODO: Try not to make people spectators here
;472:				ent->client->sess.spectatorState = SPECTATOR_FOLLOW;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 2
ASGNI4
line 473
;473:				ent->client->ps.pm_type = PM_SPECTATOR;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 475
;474:				//We have to force spawn imidiantly to prevent lag.
;475:				ClientSpawn(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 476
;476:			}
line 477
;477:			return;
ADDRGP4 $192
JUMPV
LABELV $200
line 479
;478:		}
;479:	}
LABELV $196
line 481
;480:
;481:	if(G_IsARoundBasedGametype(g_gametype.integer) && ent->client->ps.pm_type == PM_SPECTATOR && ent->client->ps.stats[STAT_HEALTH] > 0) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $210
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $210
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
LEI4 $210
line 482
;482:		return;
ADDRGP4 $192
JUMPV
LABELV $210
line 484
;483:	}
;484:	ClientSpawn(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 487
;485:
;486:	// add a teleportation effect
;487:	if(!G_IsARoundBasedGametype(g_gametype.integer))
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $213
line 488
;488:	{	
line 489
;489:		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 28
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 490
;490:		tent->s.clientNum = ent->s.clientNum;
ADDRLP4 32
CNSTI4 168
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 491
;491:	}
LABELV $213
line 492
;492:}
LABELV $192
endproc ClientRespawn 36 8
export respawnRound
proc respawnRound 16 8
line 499
;493:
;494:/*
;495:================
;496:respawnRound
;497:================
;498:*/
;499:void respawnRound( gentity_t *ent ) {
line 502
;500:	gentity_t	*tent;
;501:
;502:	if(ent->client->hook)
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
EQU4 $217
line 503
;503:		Weapon_HookFree(ent->client->hook);
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
LABELV $217
line 505
;504:
;505:	trap_UnlinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 507
;506:
;507:	ClientSpawn(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 510
;508:
;509:	// add a teleportation effect
;510:	if(!G_IsARoundBasedGametype(g_gametype.integer))
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $219
line 511
;511:	{
line 512
;512:		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 8
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 513
;513:		tent->s.clientNum = ent->s.clientNum;
ADDRLP4 12
CNSTI4 168
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 514
;514:	}
LABELV $219
line 515
;515:}
LABELV $216
endproc respawnRound 16 8
export TeamCvarSet
proc TeamCvarSet 28 12
line 525
;516:
;517:/*
;518:================
;519:TeamCvarSet
;520:
;521:Sets the red and blue team client number cvars.
;522:================
;523: */
;524:void TeamCvarSet( void )
;525:{
line 527
;526:	int i;
;527:	qboolean redChanged = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 528
;528:	qboolean blueChanged = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 529
;529:	qboolean first = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 530
;530:	const char* temp = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 532
;531:
;532:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $226
JUMPV
LABELV $223
line 533
;533:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $228
line 534
;534:			continue;
ADDRGP4 $224
JUMPV
LABELV $228
line 536
;535:		}
;536:		if ( level.clients[i].sess.sessionTeam == TEAM_RED ) {
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
CNSTI4 1
NEI4 $230
line 537
;537:			if(first) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $232
line 538
;538:				temp = va("%i",i);
ADDRGP4 $234
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 539
;539:				first = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 540
;540:			}
ADDRGP4 $233
JUMPV
LABELV $232
line 541
;541:			else {
line 542
;542:				temp = va("%s,%i",temp,i);
ADDRGP4 $235
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 543
;543:			}
LABELV $233
line 544
;544:		}
LABELV $230
line 545
;545:	}
LABELV $224
line 532
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $226
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $223
line 547
;546:
;547:	if ( !Q_strequal(g_redTeamClientNumbers.string, temp)) {
ADDRGP4 g_redTeamClientNumbers+16
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $236
line 548
;548:		redChanged = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 549
;549:	}
LABELV $236
line 550
;550:	trap_Cvar_Set("g_redTeamClientNumbers",temp); //Set it right
ADDRGP4 $239
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 551
;551:	first= qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 553
;552:
;553:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $243
JUMPV
LABELV $240
line 554
;554:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $245
line 555
;555:			continue;
ADDRGP4 $241
JUMPV
LABELV $245
line 557
;556:		}
;557:		if ( level.clients[i].sess.sessionTeam == TEAM_BLUE ) {
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
CNSTI4 2
NEI4 $247
line 558
;558:			if(first) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $249
line 559
;559:				temp = va("%i",i);
ADDRGP4 $234
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 560
;560:				first = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 561
;561:			}
ADDRGP4 $250
JUMPV
LABELV $249
line 563
;562:			else
;563:				temp = va("%s,%i",temp,i);
ADDRGP4 $235
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
LABELV $250
line 564
;564:		}
LABELV $247
line 565
;565:	}
LABELV $241
line 553
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $243
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $240
line 566
;566:	if ( !Q_strequal(g_blueTeamClientNumbers.string,temp)) {
ADDRGP4 g_blueTeamClientNumbers+16
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $251
line 567
;567:		blueChanged = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 568
;568:	}
LABELV $251
line 569
;569:	trap_Cvar_Set("g_blueTeamClientNumbers",temp);
ADDRGP4 $254
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 572
;570:
;571:	//Note: We need to force update of the cvar or SendYourTeamMessage will send the old cvar value!
;572:	if(redChanged) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $255
line 573
;573:		trap_Cvar_Update(&g_redTeamClientNumbers); //Force update of CVAR
ADDRGP4 g_redTeamClientNumbers
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 574
;574:		SendYourTeamMessageToTeam(TEAM_RED);
CNSTI4 1
ARGI4
ADDRGP4 SendYourTeamMessageToTeam
CALLV
pop
line 575
;575:	}
LABELV $255
line 576
;576:	if(blueChanged) {
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $257
line 577
;577:		trap_Cvar_Update(&g_blueTeamClientNumbers);
ADDRGP4 g_blueTeamClientNumbers
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 578
;578:		SendYourTeamMessageToTeam(TEAM_BLUE); //Force update of CVAR
CNSTI4 2
ARGI4
ADDRGP4 SendYourTeamMessageToTeam
CALLV
pop
line 579
;579:	}
LABELV $257
line 580
;580:}
LABELV $222
endproc TeamCvarSet 28 12
export TeamCount
proc TeamCount 8 0
line 589
;581:
;582:/*
;583:================
;584:TeamCount
;585:
;586:Returns number of players on a team
;587:================
;588:*/
;589:int TeamCount( int ignoreClientNum, team_t team ) {
line 591
;590:	int		i;
;591:	int		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 593
;592:
;593:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $263
JUMPV
LABELV $260
line 594
;594:		if ( i == ignoreClientNum ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $265
line 595
;595:			continue;
ADDRGP4 $261
JUMPV
LABELV $265
line 597
;596:		}
;597:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $267
line 598
;598:			continue;
ADDRGP4 $261
JUMPV
LABELV $267
line 601
;599:		}
;600:
;601:		if ( level.clients[i].pers.connected == CON_CONNECTING) {
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
CNSTI4 1
NEI4 $269
line 602
;602:			continue;
ADDRGP4 $261
JUMPV
LABELV $269
line 605
;603:		}
;604:
;605:		if ( level.clients[i].sess.sessionTeam == team ) {
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
ADDRFP4 4
INDIRI4
NEI4 $271
line 606
;606:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 607
;607:		}
LABELV $271
line 608
;608:	}
LABELV $261
line 593
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $263
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $260
line 610
;609:
;610:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $259
endproc TeamCount 8 0
export TeamLivingCount
proc TeamLivingCount 24 0
line 620
;611:}
;612:
;613:/*
;614:================
;615:TeamLivingCount
;616:
;617:Returns number of living players on a team
;618:================
;619:*/
;620:team_t TeamLivingCount( int ignoreClientNum, int team ) {
line 622
;621:	int		i;
;622:	int		count = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 623
;623:	qboolean	isLMS = (g_gametype.integer==GT_LMS);
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
NEI4 $276
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $277
JUMPV
LABELV $276
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $277
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 625
;624:
;625:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $281
JUMPV
LABELV $278
line 626
;626:		if ( i == ignoreClientNum ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $283
line 627
;627:			continue;
ADDRGP4 $279
JUMPV
LABELV $283
line 629
;628:		}
;629:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $285
line 630
;630:			continue;
ADDRGP4 $279
JUMPV
LABELV $285
line 633
;631:		}
;632:
;633:		if ( level.clients[i].pers.connected == CON_CONNECTING) {
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
CNSTI4 1
NEI4 $287
line 634
;634:			continue;
ADDRGP4 $279
JUMPV
LABELV $287
line 637
;635:		}
;636:		//crash if g_gametype.integer is used here, why?
;637:		if ( level.clients[i].sess.sessionTeam == team && (level.clients[i].ps.stats[STAT_HEALTH]>0 || isLMS) && !(level.clients[i].isEliminated)) {
ADDRLP4 16
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $289
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
GTI4 $291
ADDRLP4 4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $289
LABELV $291
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
NEI4 $289
line 638
;638:			count++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 639
;639:		}
LABELV $289
line 640
;640:	}
LABELV $279
line 625
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $281
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $278
line 642
;641:
;642:	return count;
ADDRLP4 8
INDIRI4
RETI4
LABELV $273
endproc TeamLivingCount 24 0
export TeamLivingHumanCount
proc TeamLivingHumanCount 20 0
line 645
;643:}
;644:
;645:int TeamLivingHumanCount(int ignoreClientNum) {
line 647
;646:	int i;
;647:	int count = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 648
;648:	qboolean	isLMS = (g_gametype.integer==GT_LMS);
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
NEI4 $295
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $296
JUMPV
LABELV $295
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $296
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 650
;649:
;650:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $300
JUMPV
LABELV $297
line 651
;651:		if ( i == ignoreClientNum ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $302
line 652
;652:			continue;
ADDRGP4 $298
JUMPV
LABELV $302
line 654
;653:		}
;654:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $304
line 655
;655:			continue;
ADDRGP4 $298
JUMPV
LABELV $304
line 658
;656:		}
;657:
;658:		if ( level.clients[i].pers.connected == CON_CONNECTING) {
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
CNSTI4 1
NEI4 $306
line 659
;659:			continue;
ADDRGP4 $298
JUMPV
LABELV $306
line 661
;660:		}
;661:		if (g_entities[i].r.svFlags & SVF_BOT) {
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
EQI4 $308
line 662
;662:			continue;
ADDRGP4 $298
JUMPV
LABELV $308
line 664
;663:		}
;664:		if (level.clients[i].sess.sessionTeam == TEAM_SPECTATOR) {
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
NEI4 $312
line 665
;665:			continue;
ADDRGP4 $298
JUMPV
LABELV $312
line 668
;666:		}
;667:		//crash if g_gametype.integer is used here, why?
;668:		if ( (level.clients[i].ps.stats[STAT_HEALTH]>0 || isLMS) && !(level.clients[i].isEliminated)) {
ADDRLP4 16
CNSTI4 0
ASGNI4
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
GTI4 $316
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $314
LABELV $316
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
NEI4 $314
line 669
;669:			count++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 670
;670:		}
LABELV $314
line 671
;671:	}
LABELV $298
line 650
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $300
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $297
line 672
;672:	return count;
ADDRLP4 8
INDIRI4
RETI4
LABELV $292
endproc TeamLivingHumanCount 20 0
export TeamHumanParticipantsCount
proc TeamHumanParticipantsCount 8 0
line 675
;673:}
;674:
;675:int TeamHumanParticipantsCount(int ignoreClientNum) {
line 677
;676:	int i;
;677:	int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 679
;678:
;679:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $321
JUMPV
LABELV $318
line 680
;680:		if ( i == ignoreClientNum ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $323
line 681
;681:			continue;
ADDRGP4 $319
JUMPV
LABELV $323
line 683
;682:		}
;683:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $325
line 684
;684:			continue;
ADDRGP4 $319
JUMPV
LABELV $325
line 687
;685:		}
;686:
;687:		if ( level.clients[i].pers.connected == CON_CONNECTING) {
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
CNSTI4 1
NEI4 $327
line 688
;688:			continue;
ADDRGP4 $319
JUMPV
LABELV $327
line 690
;689:		}
;690:		if (g_entities[i].r.svFlags & SVF_BOT) {
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
EQI4 $329
line 691
;691:			continue;
ADDRGP4 $319
JUMPV
LABELV $329
line 693
;692:		}
;693:		if (level.clients[i].sess.sessionTeam == TEAM_SPECTATOR) {
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
NEI4 $333
line 694
;694:			continue;
ADDRGP4 $319
JUMPV
LABELV $333
line 696
;695:		}
;696:		count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 697
;697:	}
LABELV $319
line 679
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $321
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $318
line 699
;698:
;699:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $317
endproc TeamHumanParticipantsCount 8 0
export TeamHealthCount
proc TeamHealthCount 16 0
line 710
;700:}
;701:
;702:/*
;703:================
;704:TeamHealthCount
;705:
;706:Count total number of healthpoints on teh teams used for draws in Elimination
;707:================
;708:*/
;709:
;710:team_t TeamHealthCount(int ignoreClientNum, int team ) {
line 712
;711:	int 		i;
;712:	int 		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 714
;713:
;714:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $339
JUMPV
LABELV $336
line 715
;715:		if ( i == ignoreClientNum ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $341
line 716
;716:			continue;
ADDRGP4 $337
JUMPV
LABELV $341
line 718
;717:		}
;718:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $343
line 719
;719:			continue;
ADDRGP4 $337
JUMPV
LABELV $343
line 722
;720:		}
;721:
;722:		if ( level.clients[i].pers.connected == CON_CONNECTING) {
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
CNSTI4 1
NEI4 $345
line 723
;723:			continue;
ADDRGP4 $337
JUMPV
LABELV $345
line 727
;724:		}
;725:
;726:		//only count clients with positive health
;727:		if ( level.clients[i].sess.sessionTeam == team && (level.clients[i].ps.stats[STAT_HEALTH]>0)&& !(level.clients[i].isEliminated)) {
ADDRLP4 8
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $347
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $347
ADDRLP4 8
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $347
line 728
;728:			count+=level.clients[i].ps.stats[STAT_HEALTH];
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 184
ADDP4
INDIRI4
ADDI4
ASGNI4
line 729
;729:		}
LABELV $347
line 730
;730:	}
LABELV $337
line 714
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $339
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $336
line 732
;731:
;732:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $335
endproc TeamHealthCount 16 0
export RespawnAll
proc RespawnAll 8 4
line 745
;733:}
;734:
;735:
;736:/*
;737:================
;738:RespawnAll
;739:
;740:Forces all clients to respawn.
;741:================
;742:*/
;743:
;744:void RespawnAll(void)
;745:{
line 748
;746:	int i;
;747:	gentity_t	*client;
;748:	for(i=0;i<level.maxclients;i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $353
JUMPV
LABELV $350
line 749
;749:	{
line 750
;750:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $355
line 751
;751:			continue;
ADDRGP4 $351
JUMPV
LABELV $355
line 754
;752:		}
;753:
;754:		if ( level.clients[i].pers.connected == CON_CONNECTING) {
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
CNSTI4 1
NEI4 $357
line 755
;755:			continue;
ADDRGP4 $351
JUMPV
LABELV $357
line 758
;756:		}
;757:
;758:		if ( level.clients[i].sess.sessionTeam == TEAM_SPECTATOR ) {
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
NEI4 $359
line 759
;759:			continue;
ADDRGP4 $351
JUMPV
LABELV $359
line 761
;760:		}
;761:		client = g_entities + i;
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 762
;762:		client->client->ps.pm_type = PM_NORMAL;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 763
;763:		client->client->pers.livesLeft = g_lms_lives.integer;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 620
ADDP4
ADDRGP4 g_lms_lives+12
INDIRI4
ASGNI4
line 764
;764:		respawnRound(client);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 respawnRound
CALLV
pop
line 765
;765:	}
LABELV $351
line 748
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $353
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $350
line 766
;766:	return;
LABELV $349
endproc RespawnAll 8 4
export RespawnDead
proc RespawnDead 8 4
line 778
;767:}
;768:
;769:/*
;770:================
;771:RespawnDead
;772:
;773:Forces all *DEAD* clients to respawn.
;774:================
;775:*/
;776:
;777:void RespawnDead(void)
;778:{
line 781
;779:	int i;
;780:	gentity_t	*client;
;781:	for(i=0;i<level.maxclients;i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $366
JUMPV
LABELV $363
line 782
;782:	{
line 784
;783:		
;784:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $368
line 785
;785:			continue;
ADDRGP4 $364
JUMPV
LABELV $368
line 787
;786:		}
;787:		if ( level.clients[i].pers.connected == CON_CONNECTING) {
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
CNSTI4 1
NEI4 $370
line 788
;788:			continue;
ADDRGP4 $364
JUMPV
LABELV $370
line 790
;789:		}
;790:		client = g_entities + i;
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 791
;791:		client->client->pers.livesLeft = g_lms_lives.integer-1;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 620
ADDP4
ADDRGP4 g_lms_lives+12
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 792
;792:		if ( level.clients[i].isEliminated == qfalse ){
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
NEI4 $373
line 793
;793:			continue;
ADDRGP4 $364
JUMPV
LABELV $373
line 795
;794:		}
;795:		if ( level.clients[i].sess.sessionTeam == TEAM_SPECTATOR ) {
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
NEI4 $375
line 796
;796:			continue;
ADDRGP4 $364
JUMPV
LABELV $375
line 799
;797:		}
;798:		
;799:		client->client->pers.livesLeft = g_lms_lives.integer;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 620
ADDP4
ADDRGP4 g_lms_lives+12
INDIRI4
ASGNI4
line 801
;800:
;801:		respawnRound(client);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 respawnRound
CALLV
pop
line 802
;802:	}
LABELV $364
line 781
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $366
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $363
line 803
;803:	return;
LABELV $362
endproc RespawnDead 8 4
export DisableWeapons
proc DisableWeapons 12 0
line 815
;804:}
;805:
;806:/*
;807:================
;808:DisableWeapons
;809:
;810:disables all weapons
;811:================
;812:*/
;813:
;814:void DisableWeapons(void)
;815:{
line 818
;816:	int i;
;817:	gentity_t	*client;
;818:	for(i=0;i<level.maxclients;i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $382
JUMPV
LABELV $379
line 819
;819:	{
line 820
;820:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $384
line 821
;821:			continue;
ADDRGP4 $380
JUMPV
LABELV $384
line 823
;822:		}
;823:			if ( level.clients[i].pers.connected == CON_CONNECTING) {
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
CNSTI4 1
NEI4 $386
line 824
;824:				continue;
ADDRGP4 $380
JUMPV
LABELV $386
line 827
;825:			}
;826:
;827:		if ( level.clients[i].sess.sessionTeam == TEAM_SPECTATOR ) {
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
NEI4 $388
line 828
;828:			continue;
ADDRGP4 $380
JUMPV
LABELV $388
line 830
;829:		}
;830:		client = g_entities + i;
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 831
;831:		client->client->ps.pm_flags |= PMF_ELIMWARMUP;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 832
;832:	}
LABELV $380
line 818
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $382
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $379
line 833
;833:	ProximityMine_RemoveAll(); //Remove all the prox mines
ADDRGP4 ProximityMine_RemoveAll
CALLV
pop
line 834
;834:	return;
LABELV $378
endproc DisableWeapons 12 0
export EnableWeapons
proc EnableWeapons 12 0
line 846
;835:}
;836:
;837:/*
;838:================
;839:EnableWeapons
;840:
;841:enables all weapons
;842:================
;843:*/
;844:
;845:void EnableWeapons(void)
;846:{
line 849
;847:	int i;
;848:	gentity_t	*client;
;849:	for(i=0;i<level.maxclients;i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $394
JUMPV
LABELV $391
line 850
;850:	{
line 851
;851:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $396
line 852
;852:			continue;
ADDRGP4 $392
JUMPV
LABELV $396
line 855
;853:		}
;854:
;855:		if ( level.clients[i].sess.sessionTeam == TEAM_SPECTATOR ) {
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
NEI4 $398
line 856
;856:			continue;
ADDRGP4 $392
JUMPV
LABELV $398
line 859
;857:		}
;858:
;859:		client = g_entities + i;
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 860
;860:		client->client->ps.pm_flags &= ~PMF_ELIMWARMUP;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 861
;861:	}
LABELV $392
line 849
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $394
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $391
line 862
;862:	return;
LABELV $390
endproc EnableWeapons 12 0
export LMSpoint
proc LMSpoint 20 20
line 874
;863:}
;864:
;865:/*
;866:================
;867:LMSpoint
;868:
;869:Gives a point to the lucky survivor
;870:================
;871:*/
;872:
;873:void LMSpoint(void)
;874:{
line 877
;875:	int i;
;876:	gentity_t	*client;
;877:	for(i=0;i<level.maxclients;i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $404
JUMPV
LABELV $401
line 878
;878:	{
line 879
;879:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $406
line 880
;880:			continue;
ADDRGP4 $402
JUMPV
LABELV $406
line 883
;881:		}
;882:
;883:		if ( level.clients[i].sess.sessionTeam == TEAM_SPECTATOR ) {
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
NEI4 $408
line 884
;884:			continue;
ADDRGP4 $402
JUMPV
LABELV $408
line 887
;885:		}
;886:
;887:		if ( level.clients[i].isEliminated ){
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $410
line 888
;888:			continue;
ADDRGP4 $402
JUMPV
LABELV $410
line 891
;889:		}
;890:		
;891:		client = g_entities + i;
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 893
;892:	
;893:		client->client->ps.persistant[PERS_SCORE] += 1;
ADDRLP4 8
ADDRLP4 4
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
CNSTI4 1
ADDI4
ASGNI4
line 894
;894:		G_LogPrintf("PlayerScore: %i %i: %s now has %d points\n",
ADDRGP4 $412
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRLP4 4
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
line 896
;895:			i, client->client->ps.persistant[PERS_SCORE], client->client->pers.netname, client->client->ps.persistant[PERS_SCORE] );
;896:	}
LABELV $402
line 877
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $404
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $401
line 898
;897:	
;898:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 899
;899:	return;
LABELV $400
endproc LMSpoint 20 20
export TeamLeader
proc TeamLeader 4 0
line 909
;900:}
;901:
;902:/*
;903:================
;904:TeamLeader
;905:
;906:Returns the client number of the team leader
;907:================
;908:*/
;909:int TeamLeader( int team ) {
line 912
;910:	int		i;
;911:
;912:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $417
JUMPV
LABELV $414
line 913
;913:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
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
NEI4 $419
line 914
;914:			continue;
ADDRGP4 $415
JUMPV
LABELV $419
line 916
;915:		}
;916:		if ( level.clients[i].sess.sessionTeam == team ) {
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
ADDRFP4 0
INDIRI4
NEI4 $421
line 917
;917:			if ( level.clients[i].sess.teamLeader )
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1048
ADDP4
INDIRI4
CNSTI4 0
EQI4 $423
line 918
;918:				return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $413
JUMPV
LABELV $423
line 919
;919:		}
LABELV $421
line 920
;920:	}
LABELV $415
line 912
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $417
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $414
line 922
;921:
;922:	return -1;
CNSTI4 -1
RETI4
LABELV $413
endproc TeamLeader 4 0
export PickTeam
proc PickTeam 28 8
line 932
;923:}
;924:
;925:
;926:/*
;927:================
;928:PickTeam
;929:
;930:================
;931:*/
;932:team_t PickTeam( int ignoreClientNum ) {
line 935
;933:	int		counts[TEAM_NUM_TEAMS];
;934:
;935:	counts[TEAM_BLUE] = TeamCount( ignoreClientNum, TEAM_BLUE );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
ASGNI4
line 936
;936:	counts[TEAM_RED] = TeamCount( ignoreClientNum, TEAM_RED );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 20
INDIRI4
ASGNI4
line 939
;937:
;938:	//KK-OAX Both Teams locked...forget about it, print an error message, keep as spec
;939:	if ( level.RedTeamLocked && level.BlueTeamLocked ) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 level+9464
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $428
ADDRGP4 level+9468
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $428
line 940
;940:		G_Printf( "Both teams have been locked by the Admin! \n" );
ADDRGP4 $432
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 941
;941:		return TEAM_NONE;
CNSTI4 3
RETI4
ADDRGP4 $425
JUMPV
LABELV $428
line 943
;942:}	
;943:	if ( ( counts[TEAM_BLUE] > counts[TEAM_RED] ) && ( !level.RedTeamLocked ) ) {
ADDRLP4 0+8
INDIRI4
ADDRLP4 0+4
INDIRI4
LEI4 $433
ADDRGP4 level+9464
INDIRI4
CNSTI4 0
NEI4 $433
line 944
;944:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $425
JUMPV
LABELV $433
line 946
;945:	}
;946:	if ( ( counts[TEAM_RED] > counts[TEAM_BLUE] ) && ( !level.BlueTeamLocked ) ) {
ADDRLP4 0+4
INDIRI4
ADDRLP4 0+8
INDIRI4
LEI4 $438
ADDRGP4 level+9468
INDIRI4
CNSTI4 0
NEI4 $438
line 947
;947:		return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $425
JUMPV
LABELV $438
line 950
;948:	}
;949:	// equal team count, so join the team with the lowest score
;950:	if ( ( level.teamScores[TEAM_BLUE] > level.teamScores[TEAM_RED] ) && ( !level.RedTeamLocked ) ) {
ADDRGP4 level+44+8
INDIRI4
ADDRGP4 level+44+4
INDIRI4
LEI4 $443
ADDRGP4 level+9464
INDIRI4
CNSTI4 0
NEI4 $443
line 951
;951:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $425
JUMPV
LABELV $443
line 953
;952:	}
;953:	if ( ( level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE] ) && ( !level.BlueTeamLocked ) ) {  
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 level+44+8
INDIRI4
LEI4 $450
ADDRGP4 level+9468
INDIRI4
CNSTI4 0
NEI4 $450
line 954
;954:		return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $425
JUMPV
LABELV $450
line 957
;955:	}
;956:	//KK-OAX Force Team Blue?
;957:	return TEAM_BLUE;
CNSTI4 2
RETI4
LABELV $425
endproc PickTeam 28 8
proc ClientCleanName 36 12
line 967
;958:}
;959:
;960:
;961:/*
;962:===========
;963:ClientCleanName
;964:============
;965:*/
;966:static void ClientCleanName(const char *in, char *out, int outSize, int clientNum)
;967:{
line 968
;968:	int outpos = 0, colorlessLen = 0, spaces = 0, notblack=0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
line 969
;969:	qboolean black = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 972
;970:
;971:	// discard leading spaces
;972:	for(; *in == ' '; in++) {};
ADDRGP4 $461
JUMPV
LABELV $458
LABELV $459
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $461
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $458
line 974
;973:
;974:	for(; *in && outpos < outSize - 1; in++) {
ADDRGP4 $465
JUMPV
LABELV $462
line 975
;975:		out[outpos] = *in;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRFP4 0
INDIRP4
INDIRI1
ASGNI1
line 977
;976:
;977:		if(*in == ' ') {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $466
line 979
;978:			// don't allow too many consecutive spaces
;979:			if(spaces > 2) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LEI4 $468
line 980
;980:				continue;
ADDRGP4 $463
JUMPV
LABELV $468
line 982
;981:			}
;982:			spaces++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 983
;983:		}
ADDRGP4 $467
JUMPV
LABELV $466
line 984
;984:		else if(outpos > 0 && out[outpos - 1] == Q_COLOR_ESCAPE) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $470
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $470
line 985
;985:			if(Q_IsColorString(&out[outpos - 1])) {
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRLP4 28
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ADDRFP4 4
INDIRP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $472
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $472
ADDRLP4 32
ADDRLP4 28
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $472
ADDRLP4 32
INDIRI4
CNSTI4 48
LTI4 $472
ADDRLP4 32
INDIRI4
CNSTI4 56
GTI4 $472
line 986
;986:				colorlessLen--;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 988
;987:
;988:				if(ColorIndex(*in) == 0) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 0
NEI4 $474
line 993
;989:					// Disallow color black in names to prevent players
;990:					// from getting advantage playing in front of black backgrounds
;991:					//outpos--;
;992:					//continue;
;993:					black = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 994
;994:				}
ADDRGP4 $471
JUMPV
LABELV $474
line 995
;995:				else {
line 996
;996:					black = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 997
;997:				}
line 998
;998:			}
ADDRGP4 $471
JUMPV
LABELV $472
line 999
;999:			else {
line 1000
;1000:				spaces = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1001
;1001:				colorlessLen++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1002
;1002:			}
line 1003
;1003:		}
ADDRGP4 $471
JUMPV
LABELV $470
line 1004
;1004:		else {
line 1005
;1005:			spaces = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1006
;1006:			colorlessLen++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1007
;1007:			if(!black && (Q_isalpha(*in) || (*in>='0' && *in<='9') ) ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $476
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 Q_isalpha
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $478
ADDRLP4 28
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 48
LTI4 $476
ADDRLP4 28
INDIRI4
CNSTI4 57
GTI4 $476
LABELV $478
line 1008
;1008:				notblack++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1009
;1009:			}
LABELV $476
line 1010
;1010:		}
LABELV $471
LABELV $467
line 1012
;1011:
;1012:		outpos++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1013
;1013:	}
LABELV $463
line 974
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $465
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $479
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
LTI4 $462
LABELV $479
line 1015
;1014:
;1015:	out[outpos] = '\0';
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1018
;1016:
;1017:	//There was none not-black alphanum chars. Remove all colors
;1018:	if(notblack<1)
ADDRLP4 16
INDIRI4
CNSTI4 1
GEI4 $480
line 1019
;1019:		Q_CleanStr(out);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
LABELV $480
line 1022
;1020:
;1021:	// don't allow empty names
;1022:	if( *out == '\0' || colorlessLen == 0) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
EQI4 $484
ADDRLP4 8
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $482
LABELV $484
line 1023
;1023:		Q_strncpyz(out, va("Nameless%i",clientNum), outSize );
ADDRGP4 $485
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1024
;1024:	}
LABELV $482
line 1025
;1025:}
LABELV $457
endproc ClientCleanName 36 12
export ClientUserinfoChanged
proc ClientUserinfoChanged 7420 56
line 1040
;1026:
;1027:
;1028:
;1029:/*
;1030:===========
;1031:ClientUserInfoChanged
;1032:
;1033:Called from ClientConnect when the player first connects and
;1034:directly by the server system when the player updates a userinfo variable.
;1035:
;1036:The game can override any of the settings and call trap_SetUserinfo
;1037:if desired.
;1038:============
;1039:*/
;1040:void ClientUserinfoChanged( int clientNum ) {
line 1049
;1041:	gentity_t *ent;
;1042:	int		teamTask, teamLeader, health;
;1043:	char	*s;
;1044:	char	model[MAX_QPATH];
;1045:	char	headModel[MAX_QPATH];
;1046:	char	oldname[MAX_STRING_CHARS];
;1047:	//KK-OAX
;1048:	char        err[MAX_STRING_CHARS];
;1049:	qboolean    revertName = qfalse;
ADDRLP4 4236
CNSTI4 0
ASGNI4
line 1058
;1050:	
;1051:	gclient_t	*client;
;1052:	char	c1[MAX_INFO_STRING];
;1053:	char	c2[MAX_INFO_STRING];
;1054:	char	redTeam[MAX_INFO_STRING];
;1055:	char	blueTeam[MAX_INFO_STRING];
;1056:	char	userinfo[MAX_INFO_STRING];
;1057:
;1058:	ent = g_entities + clientNum;
ADDRLP4 1032
CNSTI4 816
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1059
;1059:	client = ent->client;
ADDRLP4 0
ADDRLP4 1032
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1061
;1060:
;1061:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1064
;1062:
;1063:	// check for malformed or illegal info strings
;1064:	if ( !Info_Validate(userinfo) ) {
ADDRLP4 4
ARGP4
ADDRLP4 7324
ADDRGP4 Info_Validate
CALLI4
ASGNI4
ADDRLP4 7324
INDIRI4
CNSTI4 0
NEI4 $487
line 1065
;1065:		strcpy (userinfo, "\\name\\badinfo");
ADDRLP4 4
ARGP4
ADDRGP4 $489
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1066
;1066:	}
LABELV $487
line 1069
;1067:
;1068:	// check the item prediction
;1069:	s = Info_ValueForKey( userinfo, "cg_predictItems" );
ADDRLP4 4
ARGP4
ADDRGP4 $490
ARGP4
ADDRLP4 7328
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 7328
INDIRP4
ASGNP4
line 1070
;1070:	if ( !atoi( s ) ) {
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 7332
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 7332
INDIRI4
CNSTI4 0
NEI4 $491
line 1071
;1071:		client->pers.predictItemPickup = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 1072
;1072:	} else {
ADDRGP4 $492
JUMPV
LABELV $491
line 1073
;1073:		client->pers.predictItemPickup = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 1
ASGNI4
line 1074
;1074:	}
LABELV $492
line 1078
;1075:
;1076://unlagged - client options
;1077:	// see if the player has opted out
;1078:	s = Info_ValueForKey( userinfo, "cg_delag" );
ADDRLP4 4
ARGP4
ADDRGP4 $493
ARGP4
ADDRLP4 7336
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 7336
INDIRP4
ASGNP4
line 1079
;1079:	if ( !atoi( s ) ) {
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 7340
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 7340
INDIRI4
CNSTI4 0
NEI4 $494
line 1080
;1080:		client->pers.delag = 0;
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
CNSTI4 0
ASGNI4
line 1081
;1081:	} else {
ADDRGP4 $495
JUMPV
LABELV $494
line 1082
;1082:		client->pers.delag = atoi( s );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 7344
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 7344
INDIRI4
ASGNI4
line 1083
;1083:	}
LABELV $495
line 1086
;1084:
;1085:	// see if the player is nudging his shots
;1086:	s = Info_ValueForKey( userinfo, "cg_cmdTimeNudge" );
ADDRLP4 4
ARGP4
ADDRGP4 $496
ARGP4
ADDRLP4 7344
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 7344
INDIRP4
ASGNP4
line 1087
;1087:	client->pers.cmdTimeNudge = atoi( s );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 7348
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 7348
INDIRI4
ASGNI4
line 1112
;1088:
;1089:	// see if the player wants to debug the backward reconciliation
;1090:	/*s = Info_ValueForKey( userinfo, "cg_debugDelag" );
;1091:	if ( !atoi( s ) ) {
;1092:		client->pers.debugDelag = qfalse;
;1093:	}
;1094:	else {
;1095:		client->pers.debugDelag = qtrue;
;1096:	}*/
;1097:
;1098:	// see if the player is simulating incoming latency
;1099:	//s = Info_ValueForKey( userinfo, "cg_latentSnaps" );
;1100:	//client->pers.latentSnaps = atoi( s );
;1101:
;1102:	// see if the player is simulating outgoing latency
;1103:	//s = Info_ValueForKey( userinfo, "cg_latentCmds" );
;1104:	//client->pers.latentCmds = atoi( s );
;1105:
;1106:	// see if the player is simulating outgoing packet loss
;1107:	//s = Info_ValueForKey( userinfo, "cg_plOut" );
;1108:	//client->pers.plOut = atoi( s );
;1109://unlagged - client options
;1110:
;1111:	// set name
;1112:	Q_strncpyz ( oldname, client->pers.netname, sizeof( oldname ) );
ADDRLP4 1036
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1113
;1113:	s = Info_ValueForKey (userinfo, "name");
ADDRLP4 4
ARGP4
ADDRGP4 $497
ARGP4
ADDRLP4 7352
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 7352
INDIRP4
ASGNP4
line 1114
;1114:	ClientCleanName( s, client->pers.netname, sizeof(client->pers.netname), clientNum );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientCleanName
CALLV
pop
line 1117
;1115:
;1116:	//KK-OAPub Added From Tremulous-Control Name Changes
;1117:	if( !strequals( oldname, client->pers.netname ) )
ADDRLP4 1036
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 7356
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 7356
INDIRI4
CNSTI4 0
EQI4 $498
line 1118
;1118:	{
line 1119
;1119:		if( client->pers.nameChangeTime &&
ADDRLP4 7360
ADDRLP4 0
INDIRP4
CNSTI4 1012
ADDP4
INDIRI4
ASGNI4
ADDRLP4 7360
INDIRI4
CNSTI4 0
EQI4 $500
ADDRGP4 level+32
INDIRI4
ADDRLP4 7360
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1148846080
ADDRGP4 g_minNameChangePeriod+8
INDIRF4
MULF4
GTF4 $500
line 1122
;1120:			( level.time - client->pers.nameChangeTime )
;1121:			<= ( g_minNameChangePeriod.value * 1000 ) )
;1122:		{
line 1123
;1123:			trap_SendServerCommand( ent - g_entities, va(
ADDRGP4 $504
ARGP4
ADDRGP4 g_minNameChangePeriod+12
INDIRI4
ARGI4
ADDRLP4 7364
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 7364
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1126
;1124:			"print \"Name change spam protection (g_minNameChangePeriod = %d)\n\"",
;1125:			g_minNameChangePeriod.integer ) );
;1126:			revertName = qtrue;
ADDRLP4 4236
CNSTI4 1
ASGNI4
line 1127
;1127:		}
ADDRGP4 $501
JUMPV
LABELV $500
line 1128
;1128:		else if( g_maxNameChanges.integer > 0
ADDRGP4 g_maxNameChanges+12
INDIRI4
CNSTI4 0
LEI4 $506
ADDRLP4 0
INDIRP4
CNSTI4 1016
ADDP4
INDIRI4
ADDRGP4 g_maxNameChanges+12
INDIRI4
LTI4 $506
line 1130
;1129:			&& client->pers.nameChanges >= g_maxNameChanges.integer  )
;1130:		{
line 1131
;1131:			trap_SendServerCommand( ent - g_entities, va(
ADDRGP4 $510
ARGP4
ADDRGP4 g_maxNameChanges+12
INDIRI4
ARGI4
ADDRLP4 7364
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 7364
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1134
;1132:				"print \"Maximum name changes reached (g_maxNameChanges = %d)\n\"",
;1133:				g_maxNameChanges.integer ) );
;1134:			revertName = qtrue;
ADDRLP4 4236
CNSTI4 1
ASGNI4
line 1135
;1135:		}
ADDRGP4 $507
JUMPV
LABELV $506
line 1136
;1136:		else if( client->pers.muted )
ADDRLP4 0
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
CNSTI4 0
EQI4 $512
line 1137
;1137:		{
line 1138
;1138:			trap_SendServerCommand( ent - g_entities,
ADDRLP4 1032
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRGP4 $514
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1140
;1139:				"print \"You cannot change your name while you are muted\n\"" );
;1140:			revertName = qtrue;
ADDRLP4 4236
CNSTI4 1
ASGNI4
line 1141
;1141:		}
ADDRGP4 $513
JUMPV
LABELV $512
line 1142
;1142:		else if( !G_admin_name_check( ent, client->pers.netname, err, sizeof( err ) ) )
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 6300
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 7364
ADDRGP4 G_admin_name_check
CALLI4
ASGNI4
ADDRLP4 7364
INDIRI4
CNSTI4 0
NEI4 $515
line 1143
;1143:		{
line 1144
;1144:			trap_SendServerCommand( ent - g_entities, va( "print \"%s\n\"", err ) );
ADDRGP4 $517
ARGP4
ADDRLP4 6300
ARGP4
ADDRLP4 7368
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 7368
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1145
;1145:			revertName = qtrue;
ADDRLP4 4236
CNSTI4 1
ASGNI4
line 1146
;1146:		}
LABELV $515
LABELV $513
LABELV $507
LABELV $501
line 1149
;1147:
;1148:		//Never revert a bots name... just to bad if it hapens... but the bot will always be expendeble :-)
;1149:		if (ent->r.svFlags & SVF_BOT)
ADDRLP4 1032
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $518
line 1150
;1150:			revertName = qfalse;
ADDRLP4 4236
CNSTI4 0
ASGNI4
LABELV $518
line 1152
;1151:
;1152:		if( revertName )
ADDRLP4 4236
INDIRI4
CNSTI4 0
EQI4 $520
line 1153
;1153:		{
line 1154
;1154:			Q_strncpyz( client->pers.netname, *oldname ? oldname : "UnnamedPlayer",
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1036
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $524
ADDRLP4 7368
ADDRLP4 1036
ASGNP4
ADDRGP4 $525
JUMPV
LABELV $524
ADDRLP4 7368
ADDRGP4 $522
ASGNP4
LABELV $525
ADDRLP4 7368
INDIRP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1156
;1155:				sizeof( client->pers.netname ) );
;1156:			Info_SetValueForKey( userinfo, "name", oldname );
ADDRLP4 4
ARGP4
ADDRGP4 $497
ARGP4
ADDRLP4 1036
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 1157
;1157:			trap_SetUserinfo( clientNum, userinfo );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 1158
;1158:		}
ADDRGP4 $521
JUMPV
LABELV $520
line 1160
;1159:		else
;1160:		{
line 1161
;1161:			if( client->pers.connected == CON_CONNECTED )
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $526
line 1162
;1162:			{
line 1163
;1163:				client->pers.nameChangeTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 1012
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1164
;1164:				client->pers.nameChanges++;
ADDRLP4 7368
ADDRLP4 0
INDIRP4
CNSTI4 1016
ADDP4
ASGNP4
ADDRLP4 7368
INDIRP4
ADDRLP4 7368
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1165
;1165:			}
LABELV $526
line 1166
;1166:		}
LABELV $521
line 1167
;1167:	}
LABELV $498
line 1168
;1168:	if ( ( ( client->sess.sessionTeam == TEAM_SPECTATOR ) ||
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $532
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $529
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 7364
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 7364
INDIRI4
CNSTI4 0
EQI4 $529
LABELV $532
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 3
NEI4 $529
line 1172
;1169:		( ( ( client->isEliminated ) /*||
;1170:		( client->ps.pm_type == PM_SPECTATOR )*/ ) &&   //Sago: If this is true client.isEliminated or TEAM_SPECTATOR is true to and this is redundant
;1171:		G_IsARoundBasedGametype(g_gametype.integer) ) ) &&
;1172:		( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) ) {
line 1174
;1173:
;1174:		Q_strncpyz( client->pers.netname, "scoreboard", sizeof(client->pers.netname) );
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $533
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1175
;1175:	}
LABELV $529
line 1177
;1176:
;1177:	if ( client->pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $534
line 1178
;1178:		if ( !strequals( oldname, client->pers.netname ) ) {
ADDRLP4 1036
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 7368
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 7368
INDIRI4
CNSTI4 0
EQI4 $536
line 1179
;1179:			trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " renamed to %s\n\"", oldname, 
ADDRGP4 $538
ARGP4
ADDRLP4 1036
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 7372
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 7372
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1181
;1180:				client->pers.netname) );
;1181:		}
LABELV $536
line 1182
;1182:	}
LABELV $534
line 1185
;1183:
;1184:	// set max health
;1185:	if (client->ps.powerups[PW_GUARD]) {
ADDRLP4 0
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $539
line 1186
;1186:		client->pers.maxHealth = 200;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 200
ASGNI4
line 1187
;1187:	} else {
ADDRGP4 $540
JUMPV
LABELV $539
line 1188
;1188:		health = atoi( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $541
ARGP4
ADDRLP4 7368
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 7368
INDIRP4
ARGP4
ADDRLP4 7372
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 6296
ADDRLP4 7372
INDIRI4
ASGNI4
line 1189
;1189:		client->pers.maxHealth = health;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 6296
INDIRI4
ASGNI4
line 1190
;1190:		if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
ADDRLP4 7376
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
ADDRLP4 7376
INDIRI4
CNSTI4 1
LTI4 $544
ADDRLP4 7376
INDIRI4
CNSTI4 100
LEI4 $542
LABELV $544
line 1191
;1191:			client->pers.maxHealth = 100;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 100
ASGNI4
line 1192
;1192:		}
LABELV $542
line 1193
;1193:	}
LABELV $540
line 1194
;1194:	client->ps.stats[STAT_MAX_HEALTH] = client->pers.maxHealth;
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
line 1197
;1195:
;1196:	// set model
;1197:	if(G_IsATeamGametype(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 7372
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 7372
INDIRI4
CNSTI4 0
EQI4 $545
line 1198
;1198:		Q_strncpyz( model, Info_ValueForKey (userinfo, "team_model"), sizeof( model ) );
ADDRLP4 4
ARGP4
ADDRGP4 $548
ARGP4
ADDRLP4 7376
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2060
ARGP4
ADDRLP4 7376
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1199
;1199:		Q_strncpyz( headModel, Info_ValueForKey (userinfo, "team_headmodel"), sizeof( headModel ) );
ADDRLP4 4
ARGP4
ADDRGP4 $549
ARGP4
ADDRLP4 7380
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2124
ARGP4
ADDRLP4 7380
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1200
;1200:	} else {
ADDRGP4 $546
JUMPV
LABELV $545
line 1201
;1201:		Q_strncpyz( model, Info_ValueForKey (userinfo, "model"), sizeof( model ) );
ADDRLP4 4
ARGP4
ADDRGP4 $550
ARGP4
ADDRLP4 7376
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2060
ARGP4
ADDRLP4 7376
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1202
;1202:		Q_strncpyz( headModel, Info_ValueForKey (userinfo, "headmodel"), sizeof( headModel ) );
ADDRLP4 4
ARGP4
ADDRGP4 $551
ARGP4
ADDRLP4 7380
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2124
ARGP4
ADDRLP4 7380
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1203
;1203:	}
LABELV $546
line 1205
;1204:
;1205:	if (G_IsATeamGametype(g_gametype.integer) && !(ent->r.svFlags & SVF_BOT)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 7376
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 7380
CNSTI4 0
ASGNI4
ADDRLP4 7376
INDIRI4
ADDRLP4 7380
INDIRI4
EQI4 $552
ADDRLP4 1032
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 7380
INDIRI4
NEI4 $552
line 1206
;1206:		client->pers.teamInfo = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 1207
;1207:	} else {
ADDRGP4 $553
JUMPV
LABELV $552
line 1208
;1208:		s = Info_ValueForKey( userinfo, "teamoverlay" );
ADDRLP4 4
ARGP4
ADDRGP4 $555
ARGP4
ADDRLP4 7384
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 7384
INDIRP4
ASGNP4
line 1209
;1209:		if ( ! *s || atoi( s ) != 0 ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $558
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 7392
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 7392
INDIRI4
CNSTI4 0
EQI4 $556
LABELV $558
line 1210
;1210:			client->pers.teamInfo = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 1211
;1211:		} else {
ADDRGP4 $557
JUMPV
LABELV $556
line 1212
;1212:			client->pers.teamInfo = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 1213
;1213:		}
LABELV $557
line 1214
;1214:	}
LABELV $553
line 1217
;1215:
;1216:	// team task (0 = none, 1 = offence, 2 = defence)
;1217:	teamTask = atoi(Info_ValueForKey(userinfo, "teamtask"));
ADDRLP4 4
ARGP4
ADDRGP4 $559
ARGP4
ADDRLP4 7384
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 7384
INDIRP4
ARGP4
ADDRLP4 7388
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 6288
ADDRLP4 7388
INDIRI4
ASGNI4
line 1219
;1218:	// team Leader (1 = leader, 0 is normal player)
;1219:	teamLeader = client->sess.teamLeader;
ADDRLP4 6292
ADDRLP4 0
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
ASGNI4
line 1222
;1220:
;1221:	// colors
;1222:	if(G_IsATeamGametype(g_gametype.integer) && g_instantgib.integer) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 7392
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 7396
CNSTI4 0
ASGNI4
ADDRLP4 7392
INDIRI4
ADDRLP4 7396
INDIRI4
EQI4 $560
ADDRGP4 g_instantgib+12
INDIRI4
ADDRLP4 7396
INDIRI4
EQI4 $560
line 1223
;1223:		switch(client->sess.sessionTeam) {
ADDRLP4 7400
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
ADDRLP4 7400
INDIRI4
CNSTI4 1
EQI4 $567
ADDRLP4 7400
INDIRI4
CNSTI4 2
EQI4 $570
ADDRGP4 $561
JUMPV
LABELV $567
line 1225
;1224:			case TEAM_RED:
;1225:				c1[0] = COLOR_BLUE;
ADDRLP4 4240
CNSTI1 52
ASGNI1
line 1226
;1226:				c2[0] = COLOR_BLUE;
ADDRLP4 5264
CNSTI1 52
ASGNI1
line 1227
;1227:				c1[1] = 0;
ADDRLP4 4240+1
CNSTI1 0
ASGNI1
line 1228
;1228:				c2[1] = 0;
ADDRLP4 5264+1
CNSTI1 0
ASGNI1
line 1229
;1229:				break;
ADDRGP4 $561
JUMPV
LABELV $570
line 1231
;1230:			case TEAM_BLUE:
;1231:				c1[0] = COLOR_RED;
ADDRLP4 4240
CNSTI1 49
ASGNI1
line 1232
;1232:				c2[0] = COLOR_RED;
ADDRLP4 5264
CNSTI1 49
ASGNI1
line 1233
;1233:				c1[1] = 0;
ADDRLP4 4240+1
CNSTI1 0
ASGNI1
line 1234
;1234:				c2[1] = 0;
ADDRLP4 5264+1
CNSTI1 0
ASGNI1
line 1235
;1235:				break;
line 1237
;1236:			default:
;1237:				break;
line 1239
;1238:		}
;1239:	} else {
ADDRGP4 $561
JUMPV
LABELV $560
line 1240
;1240:		Q_strncpyz(c1, Info_ValueForKey( userinfo, "color1" ), sizeof( c1 ));
ADDRLP4 4
ARGP4
ADDRGP4 $573
ARGP4
ADDRLP4 7400
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4240
ARGP4
ADDRLP4 7400
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1241
;1241:		Q_strncpyz(c2, Info_ValueForKey( userinfo, "color2" ), sizeof( c2 ));
ADDRLP4 4
ARGP4
ADDRGP4 $574
ARGP4
ADDRLP4 7404
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 5264
ARGP4
ADDRLP4 7404
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1242
;1242:	}
LABELV $561
line 1244
;1243:
;1244:	Q_strncpyz(redTeam, Info_ValueForKey( userinfo, "g_redteam" ), sizeof( redTeam ));
ADDRLP4 4
ARGP4
ADDRGP4 $575
ARGP4
ADDRLP4 7400
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2188
ARGP4
ADDRLP4 7400
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1245
;1245:	Q_strncpyz(blueTeam, Info_ValueForKey( userinfo, "g_blueteam" ), sizeof( blueTeam ));
ADDRLP4 4
ARGP4
ADDRGP4 $576
ARGP4
ADDRLP4 7404
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3212
ARGP4
ADDRLP4 7404
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1249
;1246:
;1247:	// send over a subset of the userinfo keys so other clients can
;1248:	// print scoreboards, display models, and play custom sounds
;1249:	if ( ent->r.svFlags & SVF_BOT ) {
ADDRLP4 1032
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $577
line 1250
;1250:		s = va("n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\c1\\%s\\c2\\%s\\hc\\%i\\w\\%i\\l\\%i\\skill\\%s\\tt\\%d\\tl\\%d",
ADDRLP4 4
ARGP4
ADDRGP4 $580
ARGP4
ADDRLP4 7408
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $579
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 2060
ARGP4
ADDRLP4 2124
ARGP4
ADDRLP4 4240
ARGP4
ADDRLP4 5264
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1040
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
ARGI4
ADDRLP4 7408
INDIRP4
ARGP4
ADDRLP4 6288
INDIRI4
ARGI4
ADDRLP4 6292
INDIRI4
ARGI4
ADDRLP4 7416
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 7416
INDIRP4
ASGNP4
line 1254
;1251:			client->pers.netname, client->sess.sessionTeam, model, headModel, c1, c2, 
;1252:			client->pers.maxHealth, client->sess.wins, client->sess.losses,
;1253:			Info_ValueForKey( userinfo, "skill" ), teamTask, teamLeader );
;1254:	} else {
ADDRGP4 $578
JUMPV
LABELV $577
line 1255
;1255:		s = va("n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\g_redteam\\%s\\g_blueteam\\%s\\c1\\%s\\c2\\%s\\hc\\%i\\w\\%i\\l\\%i\\tt\\%d\\tl\\%d",
ADDRGP4 $581
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 2060
ARGP4
ADDRLP4 2124
ARGP4
ADDRLP4 2188
ARGP4
ADDRLP4 3212
ARGP4
ADDRLP4 4240
ARGP4
ADDRLP4 5264
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1040
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
ARGI4
ADDRLP4 6288
INDIRI4
ARGI4
ADDRLP4 6292
INDIRI4
ARGI4
ADDRLP4 7412
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 7412
INDIRP4
ASGNP4
line 1258
;1256:			client->pers.netname, client->sess.sessionTeam, model, headModel, redTeam, blueTeam, c1, c2, 
;1257:			client->pers.maxHealth, client->sess.wins, client->sess.losses, teamTask, teamLeader);
;1258:	}
LABELV $578
line 1260
;1259:
;1260:	trap_SetConfigstring( CS_PLAYERS+clientNum, s );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1263
;1261:
;1262:	// this is not the userinfo, more like the configstring actually
;1263:	G_LogPrintf( "ClientUserinfoChanged: %i %s\\id\\%s\n", clientNum, s, Info_ValueForKey(userinfo, "cl_guid") );
ADDRLP4 4
ARGP4
ADDRGP4 $583
ARGP4
ADDRLP4 7408
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $582
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 7408
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1264
;1264:}
LABELV $486
endproc ClientUserinfoChanged 7420 56
lit
align 1
LABELV $585
byte 1 0
skip 1023
export ClientConnect
code
proc ClientConnect 2132 12
line 1287
;1265:
;1266:
;1267:/*
;1268:===========
;1269:ClientConnect
;1270:
;1271:Called when a player begins connecting to the server.
;1272:Called again for every map change or tournement restart.
;1273:
;1274:The session information will be valid after exit.
;1275:
;1276:Return NULL if the client should be allowed, otherwise return
;1277:a string with the reason for denial.
;1278:
;1279:Otherwise, the client will be sent the current gamestate
;1280:and will eventually get to ClientBegin.
;1281:
;1282:firstTime will be qtrue the very first time a client connects
;1283:to the server machine, but qfalse on map changes and tournement
;1284:restarts.
;1285:============
;1286:*/
;1287:char *ClientConnect( int clientNum, qboolean firstTime, qboolean isBot ) {
line 1293
;1288:	char		*value;
;1289://	char		*areabits;
;1290:	gclient_t	*client;
;1291:	char		userinfo[MAX_INFO_STRING];
;1292:	gentity_t	*ent;
;1293:	char        reason[ MAX_STRING_CHARS ] = {""};
ADDRLP4 1040
ADDRGP4 $585
INDIRB
ASGNB 1024
line 1297
;1294:	int         i;
;1295:
;1296:	//KK-OAX I moved these up so userinfo could be assigned/used. 
;1297:	ent = &g_entities[ clientNum ];
ADDRLP4 1036
CNSTI4 816
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1298
;1298:	client = &level.clients[ clientNum ];
ADDRLP4 4
CNSTI4 2116
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1299
;1299:	ent->client = client;
ADDRLP4 1036
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 1300
;1300:	memset( client, 0, sizeof(*client) );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2116
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1302
;1301:
;1302:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1304
;1303:
;1304: 	value = Info_ValueForKey( userinfo, "cl_guid" );
ADDRLP4 12
ARGP4
ADDRGP4 $583
ARGP4
ADDRLP4 2064
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 2064
INDIRP4
ASGNP4
line 1305
;1305: 	Q_strncpyz( client->pers.guid, value, sizeof( client->pers.guid ) );
ADDRLP4 4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1312
;1306: 	
;1307:
;1308: 	// IP filtering //KK-OAX Has this been obsoleted? 
;1309: 	// https://zerowing.idsoftware.com/bugzilla/show_bug.cgi?id=500
;1310: 	// recommanding PB based IP / GUID banning, the builtin system is pretty limited
;1311: 	// check to see if they are on the banned IP list
;1312:	value = Info_ValueForKey (userinfo, "ip");
ADDRLP4 12
ARGP4
ADDRGP4 $586
ARGP4
ADDRLP4 2068
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 2068
INDIRP4
ASGNP4
line 1313
;1313:	Q_strncpyz( client->pers.ip, value, sizeof( client->pers.ip ) );
ADDRLP4 4
INDIRP4
CNSTI4 945
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 40
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1315
;1314:	
;1315:	if ( G_FilterPacket( value ) && Q_strequal(value,"localhost") ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 2072
ADDRGP4 G_FilterPacket
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
EQI4 $587
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 2076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $587
line 1316
;1316:		G_Printf("Player with IP: %s is banned\n",value);
ADDRGP4 $590
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1317
;1317:		return "You are banned from this server.";
ADDRGP4 $591
RETP4
ADDRGP4 $584
JUMPV
LABELV $587
line 1320
;1318:	}
;1319:	
;1320:	if( G_admin_ban_check( userinfo, reason, sizeof( reason ) ) ) {    
ADDRLP4 12
ARGP4
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2080
ADDRGP4 G_admin_ban_check
CALLI4
ASGNI4
ADDRLP4 2080
INDIRI4
CNSTI4 0
EQI4 $592
line 1321
;1321:		return va( "%s", reason );
ADDRGP4 $594
ARGP4
ADDRLP4 1040
ARGP4
ADDRLP4 2084
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 2084
INDIRP4
RETP4
ADDRGP4 $584
JUMPV
LABELV $592
line 1328
;1322: 	}
;1323: 	 
;1324://KK-OAX
;1325:// we don't check GUID or password for bots and local client
;1326:// NOTE: local client <-> "ip" "localhost"
;1327://   this means this client is not running in our current process
;1328:	if ( !isBot && !strequals(value, "localhost") ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $595
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 2084
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 0
EQI4 $595
line 1330
;1329:		// check for a password
;1330:		value = Info_ValueForKey (userinfo, "password");
ADDRLP4 12
ARGP4
ADDRGP4 $597
ARGP4
ADDRLP4 2088
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 2088
INDIRP4
ASGNP4
line 1331
;1331:		if ( g_password.string[0] && !Q_strequal( g_password.string, "none" ) &&
ADDRGP4 g_password+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $598
ADDRGP4 g_password+16
ARGP4
ADDRGP4 $602
ARGP4
ADDRLP4 2092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2092
INDIRI4
CNSTI4 0
EQI4 $598
ADDRGP4 g_password+16
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 2096
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2096
INDIRI4
CNSTI4 0
EQI4 $598
line 1332
;1332:			!strequals( g_password.string, value)) {
line 1333
;1333:			return "Invalid password";
ADDRGP4 $604
RETP4
ADDRGP4 $584
JUMPV
LABELV $598
line 1335
;1334:		}
;1335:		for( i = 0; i < sizeof( client->pers.guid ) - 1 &&
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $608
JUMPV
LABELV $605
line 1336
;1336:			isxdigit( client->pers.guid[ i ] ); i++ ) {};
LABELV $606
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $608
line 1335
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 32
GEU4 $613
ADDRLP4 2104
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 912
ADDP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2104
INDIRI4
CNSTI4 48
LTI4 $610
ADDRLP4 2104
INDIRI4
CNSTI4 57
LEI4 $605
LABELV $610
ADDRLP4 2108
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 912
ADDP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2108
INDIRI4
CNSTI4 65
LTI4 $611
ADDRLP4 2108
INDIRI4
CNSTI4 70
LEI4 $605
LABELV $611
ADDRLP4 2112
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 912
ADDP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2112
INDIRI4
CNSTI4 48
LTI4 $612
ADDRLP4 2112
INDIRI4
CNSTI4 57
LEI4 $605
LABELV $612
ADDRLP4 2116
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 912
ADDP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2116
INDIRI4
CNSTI4 97
LTI4 $613
ADDRLP4 2116
INDIRI4
CNSTI4 102
LEI4 $605
LABELV $613
line 1336
line 1337
;1337:		if( i < sizeof( client->pers.guid ) - 1 )
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 32
GEU4 $614
line 1338
;1338:			return "Invalid GUID";
ADDRGP4 $616
RETP4
ADDRGP4 $584
JUMPV
LABELV $614
line 1340
;1339:
;1340:		for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $620
JUMPV
LABELV $617
line 1342
;1341:		
;1342:			if( level.clients[ i ].pers.connected == CON_DISCONNECTED )
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
NEI4 $622
line 1343
;1343:				continue;
ADDRGP4 $618
JUMPV
LABELV $622
line 1345
;1344:
;1345:			if( Q_strequal( client->pers.guid, level.clients[ i ].pers.guid ) ) {
ADDRLP4 2120
CNSTI4 912
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 2120
INDIRI4
ADDP4
ARGP4
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ADDRLP4 2120
INDIRI4
ADDP4
ARGP4
ADDRLP4 2124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2124
INDIRI4
CNSTI4 0
NEI4 $624
line 1346
;1346:				if( !G_ClientIsLagging( level.clients + i ) ) {
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ARGP4
ADDRLP4 2128
ADDRGP4 G_ClientIsLagging
CALLI4
ASGNI4
ADDRLP4 2128
INDIRI4
CNSTI4 0
NEI4 $626
line 1347
;1347:					trap_SendServerCommand( i, "cp \"Your GUID is not secure\"" );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $628
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1348
;1348:					return "Duplicate GUID";
ADDRGP4 $629
RETP4
ADDRGP4 $584
JUMPV
LABELV $626
line 1350
;1349:				}
;1350:				trap_DropClient( i, "Ghost" );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $630
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 1351
;1351:			}
LABELV $624
line 1352
;1352:		}
LABELV $618
line 1340
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $620
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $617
line 1354
;1353:		 
;1354:	}
LABELV $595
line 1357
;1355:
;1356:	//Check for local client
;1357:	if( strequals( client->pers.ip, "localhost" ) ) {
ADDRLP4 4
INDIRP4
CNSTI4 945
ADDP4
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 2088
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2088
INDIRI4
CNSTI4 0
NEI4 $631
line 1358
;1358:		client->pers.localClient = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
CNSTI4 1
ASGNI4
line 1359
;1359:	}
LABELV $631
line 1360
;1360:	client->pers.adminLevel = G_admin_level( ent );
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 2092
ADDRGP4 G_admin_level
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 1000
ADDP4
ADDRLP4 2092
INDIRI4
ASGNI4
line 1362
;1361:
;1362:	client->pers.connected = CON_CONNECTING;
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 1
ASGNI4
line 1365
;1363:
;1364:	// check for local client
;1365:	value = Info_ValueForKey( userinfo, "ip" );
ADDRLP4 12
ARGP4
ADDRGP4 $586
ARGP4
ADDRLP4 2096
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 2096
INDIRP4
ASGNP4
line 1366
;1366:	if ( !strcmp( value, "localhost" ) ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 2100
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2100
INDIRI4
CNSTI4 0
NEI4 $633
line 1367
;1367:		client->pers.localClient = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
CNSTI4 1
ASGNI4
line 1368
;1368:	}
LABELV $633
line 1370
;1369:
;1370:	if( isBot ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $635
line 1371
;1371:		ent->r.svFlags |= SVF_BOT;
ADDRLP4 2104
ADDRLP4 1036
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 2104
INDIRP4
ADDRLP4 2104
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1372
;1372:		ent->inuse = qtrue;
ADDRLP4 1036
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 1373
;1373:		if( !G_BotConnect( clientNum, !firstTime ) ) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $640
ADDRLP4 2108
CNSTI4 1
ASGNI4
ADDRGP4 $641
JUMPV
LABELV $640
ADDRLP4 2108
CNSTI4 0
ASGNI4
LABELV $641
ADDRLP4 2108
INDIRI4
ARGI4
ADDRLP4 2112
ADDRGP4 G_BotConnect
CALLI4
ASGNI4
ADDRLP4 2112
INDIRI4
CNSTI4 0
NEI4 $637
line 1374
;1374:			return "BotConnectfailed";
ADDRGP4 $642
RETP4
ADDRGP4 $584
JUMPV
LABELV $637
line 1376
;1375:		}
;1376:	}
LABELV $635
line 1378
;1377:	// read or initialize the session data
;1378:	if ( firstTime || level.newSession ) {
ADDRLP4 2104
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 2104
INDIRI4
NEI4 $646
ADDRGP4 level+64
INDIRI4
ADDRLP4 2104
INDIRI4
EQI4 $643
LABELV $646
line 1379
;1379:		G_InitSessionData( client, userinfo );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 G_InitSessionData
CALLV
pop
line 1380
;1380:	}
LABELV $643
line 1381
;1381:	G_ReadSessionData( client );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_ReadSessionData
CALLV
pop
line 1385
;1382:
;1383:	//KK-OAX Swapped these in order...seemed to help the connection process.
;1384:	// get and distribute relevent paramters
;1385:	ClientUserinfoChanged( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 1386
;1386:	G_LogPrintf( "ClientConnect: %i\n", clientNum );
ADDRGP4 $647
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1390
;1387:	
;1388:
;1389:	// don't do the "xxx connected" messages if they were caried over from previous level
;1390:	if ( firstTime ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $648
line 1391
;1391:		trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " connected\n\"", client->pers.netname) );
ADDRGP4 $650
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 2108
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 2108
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1392
;1392:	}
LABELV $648
line 1394
;1393:
;1394:	if (G_IsATeamGametype(g_gametype.integer) && client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 2108
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 2108
INDIRI4
CNSTI4 0
EQI4 $651
ADDRLP4 4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $651
line 1395
;1395:		BroadcastTeamChange( client, -1 );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 BroadcastTeamChange
CALLV
pop
line 1396
;1396:	}
LABELV $651
line 1399
;1397:
;1398:	// count current clients and rank for scoreboard
;1399:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1409
;1400:
;1401:	// for statistics
;1402://	client->areabits = areabits;
;1403://	if ( !client->areabits )
;1404://		client->areabits = G_Alloc( (trap_AAS_PointReachabilityAreaIndex( NULL ) + 7) / 8 );
;1405:
;1406://Sago: Changed the message
;1407://unlagged - backward reconciliation #5
;1408:	// announce it
;1409:	if ( g_delagHitscan.integer ) {
ADDRGP4 g_delagHitscan+12
INDIRI4
CNSTI4 0
EQI4 $654
line 1410
;1410:		trap_SendServerCommand( clientNum, "print \"Full lag compensation is ON!\n\"" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $657
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1411
;1411:	}
ADDRGP4 $655
JUMPV
LABELV $654
line 1412
;1412:	else {
line 1413
;1413:		trap_SendServerCommand( clientNum, "print \"Full lag compensation is OFF!\n\"" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $658
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1414
;1414:	}
LABELV $655
line 1417
;1415:
;1416://unlagged - backward reconciliation #5
;1417:	G_admin_namelog_update( client, qfalse );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 G_admin_namelog_update
CALLV
pop
line 1418
;1418:	return NULL;
CNSTP4 0
RETP4
LABELV $584
endproc ClientConnect 2132 12
export motd
proc motd 1052 12
line 1422
;1419:}
;1420:
;1421:void motd (gentity_t *ent)
;1422:{
line 1428
;1423:	char motd[1024];
;1424:	fileHandle_t motdFile;
;1425:	int motdLen;
;1426:	int fileLen;
;1427:
;1428:	strcpy (motd, "cp \"");
ADDRLP4 0
ARGP4
ADDRGP4 $660
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1429
;1429:	fileLen = trap_FS_FOpenFile(g_motdfile.string, &motdFile, FS_READ);
ADDRGP4 g_motdfile+16
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1036
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1036
INDIRI4
ASGNI4
line 1430
;1430:	if(motdFile)
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $662
line 1431
;1431:	{
line 1434
;1432:		char * p;
;1433:
;1434:		motdLen = strlen(motd);
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1044
INDIRI4
ASGNI4
line 1435
;1435:		if((motdLen + fileLen) > (sizeof(motd) - 2)) {
ADDRLP4 1028
INDIRI4
ADDRLP4 1024
INDIRI4
ADDI4
CVIU4 4
CNSTU4 1022
LEU4 $664
line 1436
;1436:			fileLen = (sizeof(motd) - 2 - motdLen);
ADDRLP4 1024
CNSTU4 1022
ADDRLP4 1028
INDIRI4
CVIU4 4
SUBU4
CVUI4 4
ASGNI4
line 1437
;1437:		}
LABELV $664
line 1438
;1438:		trap_FS_Read(motd + motdLen, fileLen, motdFile);
ADDRLP4 1028
INDIRI4
ADDRLP4 0
ADDP4
ARGP4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 1439
;1439:		motd[motdLen + fileLen] = '"';
ADDRLP4 1028
INDIRI4
ADDRLP4 1024
INDIRI4
ADDI4
ADDRLP4 0
ADDP4
CNSTI1 34
ASGNI1
line 1440
;1440:		motd[motdLen + fileLen + 1] = 0;
ADDRLP4 1028
INDIRI4
ADDRLP4 1024
INDIRI4
ADDI4
ADDRLP4 0+1
ADDP4
CNSTI1 0
ASGNI1
line 1441
;1441:		trap_FS_FCloseFile(motdFile);
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
ADDRGP4 $668
JUMPV
LABELV $667
line 1443
;1442:
;1443:		while((p = strchr(motd, '\r'))) {
line 1445
;1444:			//Remove carrier return. 0x0D
;1445:			memmove(p, p + 1, motdLen + fileLen - (p - motd));
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1040
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1028
INDIRI4
ADDRLP4 1024
INDIRI4
ADDI4
ADDRLP4 1040
INDIRP4
CVPU4 4
ADDRLP4 0
CVPU4 4
SUBU4
CVUI4 4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1446
;1446:		}
LABELV $668
line 1443
ADDRLP4 0
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 1048
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1048
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $667
line 1447
;1447:	}
LABELV $662
line 1448
;1448:	trap_SendServerCommand(ent - g_entities, motd);
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
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1449
;1449:}
LABELV $659
endproc motd 1052 12
export ClientBegin
proc ClientBegin 1092 12
line 1460
;1450:
;1451:/*
;1452:===========
;1453:ClientBegin
;1454:
;1455:called when a client has finished connecting, and is ready
;1456:to be placed into the level.  This will happen every level load,
;1457:and on transition between teams, but doesn't happen on respawns
;1458:============
;1459:*/
;1460:void ClientBegin( int clientNum ) {
line 1468
;1461:	gentity_t	*ent;
;1462:	gclient_t	*client;
;1463:	gentity_t       *tent;
;1464:	int			flags;
;1465:	int		countRed, countBlue, countFree;
;1466:	char		userinfo[MAX_INFO_STRING];
;1467:
;1468:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1470
;1469:
;1470:	ent = g_entities + clientNum;
ADDRLP4 4
CNSTI4 816
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1472
;1471:
;1472:	client = level.clients + clientNum;
ADDRLP4 0
CNSTI4 2116
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1474
;1473:
;1474:	if ( ent->r.linked ) {
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $671
line 1475
;1475:		trap_UnlinkEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1476
;1476:	}
LABELV $671
line 1477
;1477:	G_InitGentity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_InitGentity
CALLV
pop
line 1478
;1478:	ent->touch = 0;
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
CNSTP4 0
ASGNP4
line 1479
;1479:	ent->pain = 0;
ADDRLP4 4
INDIRP4
CNSTI4 712
ADDP4
CNSTP4 0
ASGNP4
line 1480
;1480:	ent->client = client;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1482
;1481:
;1482:	client->pers.connected = CON_CONNECTED;
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 2
ASGNI4
line 1483
;1483:	client->pers.enterTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1484
;1484:	client->pers.teamState.state = TEAM_BEGIN;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 0
ASGNI4
line 1487
;1485:
;1486:	//Elimination:
;1487:	client->pers.roundReached = 0; //We will spawn in next round
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
CNSTI4 0
ASGNI4
line 1488
;1488:	if(g_gametype.integer == GT_LMS) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
NEI4 $674
line 1489
;1489:		client->isEliminated = qtrue; //So player does not give a point in gamemode 2 and 3
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 1
ASGNI4
line 1491
;1490:		//trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " will start dead\n\"", client->pers.netname) );
;1491:	}
LABELV $674
line 1494
;1492:
;1493:	//player is a bot:
;1494:	if( ent->r.svFlags & SVF_BOT )
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $677
line 1495
;1495:	{
line 1496
;1496:		if(!level.hadBots)
ADDRGP4 level+9436
INDIRI4
CNSTI4 0
NEI4 $679
line 1497
;1497:		{
line 1498
;1498:			G_LogPrintf( "Info: There has been at least 1 bot now\n" );
ADDRGP4 $682
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1499
;1499:			level.hadBots = qtrue;
ADDRGP4 level+9436
CNSTI4 1
ASGNI4
line 1500
;1500:		}
LABELV $679
line 1501
;1501:	}
LABELV $677
line 1504
;1502:
;1503:	//Count smallest team
;1504:	countFree = TeamCount(-1,TEAM_FREE);
CNSTI4 -1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1052
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 1044
ADDRLP4 1052
INDIRI4
ASGNI4
line 1505
;1505:	countRed = TeamCount(-1,TEAM_RED);
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 1056
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1056
INDIRI4
ASGNI4
line 1506
;1506:	countBlue = TeamCount(-1,TEAM_BLUE);
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 1060
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1060
INDIRI4
ASGNI4
line 1507
;1507:	if(!G_IsATeamGametype(g_gametype.integer))
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1064
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $684
line 1508
;1508:	{
line 1509
;1509:		if(countFree>level.teamSize)
ADDRLP4 1044
INDIRI4
ADDRGP4 level+9440
INDIRI4
LEI4 $685
line 1510
;1510:			level.teamSize=countFree;
ADDRGP4 level+9440
ADDRLP4 1044
INDIRI4
ASGNI4
line 1511
;1511:	}
ADDRGP4 $685
JUMPV
LABELV $684
line 1513
;1512:	else
;1513:	if(countRed>countBlue)
ADDRLP4 1036
INDIRI4
ADDRLP4 1040
INDIRI4
LEI4 $691
line 1514
;1514:	{
line 1515
;1515:		if(countBlue>level.teamSize)
ADDRLP4 1040
INDIRI4
ADDRGP4 level+9440
INDIRI4
LEI4 $692
line 1516
;1516:			level.teamSize=countBlue;
ADDRGP4 level+9440
ADDRLP4 1040
INDIRI4
ASGNI4
line 1517
;1517:	}
ADDRGP4 $692
JUMPV
LABELV $691
line 1519
;1518:	else
;1519:	{
line 1520
;1520:		if(countRed>level.teamSize)
ADDRLP4 1036
INDIRI4
ADDRGP4 level+9440
INDIRI4
LEI4 $697
line 1521
;1521:			level.teamSize=countRed;
ADDRGP4 level+9440
ADDRLP4 1036
INDIRI4
ASGNI4
LABELV $697
line 1522
;1522:	}
LABELV $692
LABELV $685
line 1529
;1523:
;1524:	// save eflags around this, because changing teams will
;1525:	// cause this to happen with a valid entity, and we
;1526:	// want to make sure the teleport bit is set right
;1527:	// so the viewpoint doesn't interpolate through the
;1528:	// world to the new position
;1529:	flags = client->ps.eFlags;
ADDRLP4 1032
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ASGNI4
line 1530
;1530:	memset( &client->ps, 0, sizeof( client->ps ) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 468
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1531
;1531:	if( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $701
line 1532
;1532:		PlayerStore_restore(Info_ValueForKey(userinfo,"cl_guid"),&(client->ps));
ADDRLP4 8
ARGP4
ADDRGP4 $583
ARGP4
ADDRLP4 1068
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 PlayerStore_restore
CALLV
pop
line 1533
;1533:	}
LABELV $701
line 1534
;1534:	client->ps.eFlags = flags;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 1537
;1535:
;1536:	// locate ent at a spawn point
;1537:	ClientSpawn( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 1539
;1538:
;1539:	if( ( client->sess.sessionTeam != TEAM_SPECTATOR ) &&
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $703
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $708
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1072
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 1076
CNSTI4 0
ASGNI4
ADDRLP4 1072
INDIRI4
ADDRLP4 1076
INDIRI4
EQI4 $708
ADDRGP4 level+9144
INDIRI4
ADDRLP4 1076
INDIRI4
EQI4 $703
LABELV $708
line 1542
;1540:		( ( !( client->isEliminated ) /*&&
;1541:		( ( !client->ps.pm_type ) == PM_SPECTATOR ) */ ) || //Sago: Yes, it made no sense 
;1542:		( (!G_IsARoundBasedGametype(g_gametype.integer) || level.intermissiontime) ) ) ) {
line 1544
;1543:		// send event
;1544:		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 1080
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 1048
ADDRLP4 1080
INDIRP4
ASGNP4
line 1545
;1545:		tent->s.clientNum = ent->s.clientNum;
ADDRLP4 1084
CNSTI4 168
ASGNI4
ADDRLP4 1048
INDIRP4
ADDRLP4 1084
INDIRI4
ADDP4
ADDRLP4 4
INDIRP4
ADDRLP4 1084
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1547
;1546:
;1547:		if ( g_gametype.integer != GT_TOURNAMENT  ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $709
line 1548
;1548:			trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " entered the game\n\"", client->pers.netname) );
ADDRGP4 $712
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1088
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1088
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1549
;1549:		}
LABELV $709
line 1550
;1550:	}
LABELV $703
line 1552
;1551:
;1552:	motd ( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 motd
CALLV
pop
line 1554
;1553:
;1554:	G_LogPrintf( "ClientBegin: %i\n", clientNum );
ADDRGP4 $713
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1557
;1555:
;1556:	//Send domination point names:
;1557:	if(g_gametype.integer == GT_DOMINATION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 12
NEI4 $714
line 1558
;1558:		DominationPointNamesMessage(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 DominationPointNamesMessage
CALLV
pop
line 1559
;1559:		DominationPointStatusMessage(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 DominationPointStatusMessage
CALLV
pop
line 1560
;1560:	}
LABELV $714
line 1562
;1561:
;1562:	TeamCvarSet();
ADDRGP4 TeamCvarSet
CALLV
pop
line 1565
;1563:
;1564:	// count current clients and rank for scoreboard
;1565:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1568
;1566:
;1567:	//Send the list of custom vote options:
;1568:	if(strlen(custom_vote_info)) {
ADDRGP4 custom_vote_info
ARGP4
ADDRLP4 1080
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
EQI4 $717
line 1569
;1569:		SendCustomVoteCommands(clientNum);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 SendCustomVoteCommands
CALLV
pop
line 1570
;1570:	}
LABELV $717
line 1571
;1571:	G_SendWeaponProperties( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_SendWeaponProperties
CALLV
pop
line 1572
;1572:}
LABELV $670
endproc ClientBegin 1092 12
export ClientSpawn
proc ClientSpawn 1948 20
line 1583
;1573:
;1574:/*
;1575:===========
;1576:ClientSpawn
;1577:
;1578:Called every time a client is placed fresh in the world:
;1579:after the first ClientBegin, and after each respawn
;1580:Initializes all non-persistant parts of playerState
;1581:============
;1582:*/
;1583:void ClientSpawn(gentity_t *ent) {
line 1601
;1584:	int		index;
;1585:	vec3_t	spawn_origin, spawn_angles;
;1586:	gclient_t	*client;
;1587:	int		i;
;1588:	clientPersistant_t	saved;
;1589:	clientSession_t		savedSess;
;1590:	int		persistant[MAX_PERSISTANT];
;1591:	gentity_t	*spawnPoint;
;1592:	//gentity_t *tent;
;1593:	int		flags;
;1594:	int		savedPing;
;1595://	char	*savedAreaBits;
;1596:	int		accuracy_hits, accuracy_shots,vote;
;1597:	int		accuracy[WP_NUM_WEAPONS][2];
;1598:	int		eventSequence;
;1599:	char	userinfo[MAX_INFO_STRING];
;1600:
;1601:	index = ent - g_entities;
ADDRLP4 8
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
line 1602
;1602:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1607
;1603:
;1604:	//In Elimination the player should not spawn if he have already spawned in the round (but not for spectators)
;1605:	// N_G: You've obviously wanted something ELSE
;1606:	//Sago: Yes, the !level.intermissiontime is currently redundant but it might still be the bast place to make the test, CheckElimination in g_main makes sure the next if will fail and the rest of the things this block does might not affect if in Intermission (I'll just test that)
;1607:	if((((G_IsARoundBasedGametype(g_gametype.integer) && G_IsATeamGametype(g_gametype.integer)) || (g_gametype.integer == GT_LMS && client->isEliminated)) && (!level.intermissiontime || level.warmupTime != 0)) && ( client->sess.sessionTeam != TEAM_SPECTATOR))
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1848
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 1848
INDIRI4
CNSTI4 0
EQI4 $728
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1852
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 1852
INDIRI4
CNSTI4 0
NEI4 $727
LABELV $728
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
NEI4 $720
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $720
LABELV $727
ADDRLP4 1856
CNSTI4 0
ASGNI4
ADDRGP4 level+9144
INDIRI4
ADDRLP4 1856
INDIRI4
EQI4 $729
ADDRGP4 level+16
INDIRI4
ADDRLP4 1856
INDIRI4
EQI4 $720
LABELV $729
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $720
line 1608
;1608:	{
line 1612
;1609:		// N_G: Another condition that makes no sense to me, see for
;1610:		// yourself if you really meant this
;1611:		// Sago: I beleive the TeamCount is to make sure people can join even if the game can't start
;1612:		if( ( level.roundNumber == level.roundNumberStarted ) ||
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
EQI4 $737
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_activewarmup+12
INDIRI4
MULI4
SUBI4
GEI4 $730
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 1860
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 1860
INDIRI4
CNSTI4 0
EQI4 $730
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 1864
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 1864
INDIRI4
CNSTI4 0
EQI4 $730
LABELV $737
line 1616
;1613:			( (level.time < level.roundStartTime - g_elimination_activewarmup.integer*1000 ) &&
;1614:			TeamCount( -1, TEAM_BLUE ) &&
;1615:			TeamCount( -1, TEAM_RED )  ) )
;1616:		{	
line 1617
;1617:			client->sess.spectatorState = SPECTATOR_FREE;
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 1
ASGNI4
line 1618
;1618:			client->isEliminated = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 1
ASGNI4
line 1619
;1619:			if(g_gametype.integer == GT_LMS) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
NEI4 $738
line 1620
;1620:				G_LogPrintf( "LMS: %i %i %i: Player \"%s^7\" eliminated!\n", level.roundNumber, index, 1, client->pers.netname );
ADDRGP4 $741
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1621
;1621:			}
LABELV $738
line 1622
;1622:			client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 1623
;1623:			CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1624
;1624:			return;
ADDRGP4 $719
JUMPV
LABELV $730
line 1627
;1625:		}
;1626:		else
;1627:		{
line 1628
;1628:			client->pers.roundReached = level.roundNumber+1;
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
ADDRGP4 level+9236
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1629
;1629:			client->sess.spectatorState = SPECTATOR_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 0
ASGNI4
line 1630
;1630:			client->ps.pm_type = PM_NORMAL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 1631
;1631:			client->isEliminated = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 0
ASGNI4
line 1632
;1632:			CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1633
;1633:		}
line 1634
;1634:	} else {
ADDRGP4 $721
JUMPV
LABELV $720
line 1636
;1635:		//Force false.
;1636:		if(client->isEliminated) {
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $744
line 1637
;1637:			client->isEliminated = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 0
ASGNI4
line 1638
;1638:			CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1639
;1639:		}
LABELV $744
line 1640
;1640:	}
LABELV $721
line 1642
;1641:
;1642:	if(g_gametype.integer == GT_LMS && client->sess.sessionTeam != TEAM_SPECTATOR && (!level.intermissiontime || level.warmupTime != 0))
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
NEI4 $746
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $746
ADDRLP4 1860
CNSTI4 0
ASGNI4
ADDRGP4 level+9144
INDIRI4
ADDRLP4 1860
INDIRI4
EQI4 $751
ADDRGP4 level+16
INDIRI4
ADDRLP4 1860
INDIRI4
EQI4 $746
LABELV $751
line 1643
;1643:	{
line 1644
;1644:		if(level.roundNumber==level.roundNumberStarted /*|| level.time<level.roundStartTime-g_elimination_activewarmup.integer*1000*/ && 1>client->pers.livesLeft)
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $752
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
LEI4 $752
line 1645
;1645:		{	
line 1646
;1646:			client->sess.spectatorState = SPECTATOR_FREE;
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 1
ASGNI4
line 1647
;1647:			if( ent->client->isEliminated!=qtrue) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 1
EQI4 $756
line 1648
;1648:				client->isEliminated = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 1
ASGNI4
line 1649
;1649:				if((g_lms_mode.integer == 2 || g_lms_mode.integer == 3) && level.roundNumber == level.roundNumberStarted) {
ADDRGP4 g_lms_mode+12
INDIRI4
CNSTI4 2
EQI4 $764
ADDRGP4 g_lms_mode+12
INDIRI4
CNSTI4 3
NEI4 $758
LABELV $764
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $758
line 1650
;1650:					LMSpoint();
ADDRGP4 LMSpoint
CALLV
pop
line 1651
;1651:				}
LABELV $758
line 1652
;1652:				G_LogPrintf( "LMS: %i %i %i: Player \"%s^7\" eliminated!\n", level.roundNumber, index, 1, client->pers.netname );
ADDRGP4 $741
ARGP4
ADDRGP4 level+9236
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1653
;1653:			}
LABELV $756
line 1654
;1654:			client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 1655
;1655:			return;
ADDRGP4 $719
JUMPV
LABELV $752
line 1658
;1656:		}
;1657:		
;1658:		client->sess.spectatorState = SPECTATOR_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 0
ASGNI4
line 1659
;1659:		client->ps.pm_type = PM_NORMAL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 1660
;1660:		client->isEliminated = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 0
ASGNI4
line 1661
;1661:		if(client->pers.livesLeft>0)
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
CNSTI4 0
LEI4 $766
line 1662
;1662:			client->pers.livesLeft--;
ADDRLP4 1864
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
ASGNP4
ADDRLP4 1864
INDIRP4
ADDRLP4 1864
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $766
line 1663
;1663:	}
LABELV $746
line 1668
;1664:
;1665:	// find a spawn point
;1666:	// do it before setting health back up, so farthest
;1667:	// ranging doesn't count this client
;1668:	if ((client->sess.sessionTeam == TEAM_SPECTATOR)  || ((client->ps.pm_type == PM_SPECTATOR || client->isEliminated )  &&
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $772
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $773
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $768
LABELV $773
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1868
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 1868
INDIRI4
CNSTI4 0
EQI4 $768
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1872
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 1872
INDIRI4
CNSTI4 0
EQI4 $768
LABELV $772
line 1669
;1669:		(G_IsARoundBasedGametype(g_gametype.integer) && G_IsATeamGametype(g_gametype.integer)))) {
line 1670
;1670:		spawnPoint = SelectSpectatorSpawnPoint ( spawn_origin, spawn_angles);
ADDRLP4 188
ARGP4
ADDRLP4 1228
ARGP4
ADDRLP4 1876
ADDRGP4 SelectSpectatorSpawnPoint
CALLP4
ASGNP4
ADDRLP4 1844
ADDRLP4 1876
INDIRP4
ASGNP4
line 1671
;1671:	} else if (g_gametype.integer == GT_DOUBLE_D) {
ADDRGP4 $769
JUMPV
LABELV $768
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 11
NEI4 $774
line 1673
;1672:		//Double Domination uses special spawn points:
;1673:		spawnPoint = SelectDoubleDominationSpawnPoint (client->sess.sessionTeam, spawn_origin, spawn_angles);
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 188
ARGP4
ADDRLP4 1228
ARGP4
ADDRLP4 1876
ADDRGP4 SelectDoubleDominationSpawnPoint
CALLP4
ASGNP4
ADDRLP4 1844
ADDRLP4 1876
INDIRP4
ASGNP4
line 1674
;1674:	} else if (g_gametype.integer == GT_DOMINATION) {
ADDRGP4 $775
JUMPV
LABELV $774
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 12
NEI4 $777
line 1676
;1675:		//Domination uses special spawn points:
;1676:		spawnPoint = SelectDominationSpawnPoint (client->sess.sessionTeam, spawn_origin, spawn_angles);
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 188
ARGP4
ADDRLP4 1228
ARGP4
ADDRLP4 1876
ADDRGP4 SelectDominationSpawnPoint
CALLP4
ASGNP4
ADDRLP4 1844
ADDRLP4 1876
INDIRP4
ASGNP4
line 1677
;1677:	} else if (G_IsATeamGametype(g_gametype.integer)) {
ADDRGP4 $778
JUMPV
LABELV $777
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1876
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 1876
INDIRI4
CNSTI4 0
EQI4 $780
line 1679
;1678:		// all base oriented team games use the CTF spawn points
;1679:		spawnPoint = SelectCTFSpawnPoint ( 
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ARGI4
ADDRLP4 188
ARGP4
ADDRLP4 1228
ARGP4
ADDRLP4 1884
ADDRGP4 SelectCTFSpawnPoint
CALLP4
ASGNP4
ADDRLP4 1844
ADDRLP4 1884
INDIRP4
ASGNP4
line 1683
;1680:						client->sess.sessionTeam, 
;1681:						client->pers.teamState.state, 
;1682:						spawn_origin, spawn_angles);
;1683:	} else {
ADDRGP4 $781
JUMPV
LABELV $780
line 1685
;1684:		int filters;
;1685:		if (ent->r.svFlags & SVF_BOT) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $783
line 1686
;1686:			filters = FL_NO_BOTS;
ADDRLP4 1880
CNSTI4 8192
ASGNI4
line 1687
;1687:		}
ADDRGP4 $784
JUMPV
LABELV $783
line 1688
;1688:		else {
line 1689
;1689:			filters = FL_NO_HUMANS;
ADDRLP4 1880
CNSTI4 16384
ASGNI4
line 1690
;1690:		}
LABELV $784
line 1692
;1691:		// the first spawn should be at a good looking spot
;1692:		if ( !client->pers.initialSpawn && client->pers.localClient ) {
ADDRLP4 1888
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
ADDRLP4 1888
INDIRI4
NEI4 $785
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
ADDRLP4 1888
INDIRI4
EQI4 $785
line 1693
;1693:			client->pers.initialSpawn = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 1
ASGNI4
line 1694
;1694:			spawnPoint = SelectInitialSpawnPoint( spawn_origin, spawn_angles, filters );
ADDRLP4 188
ARGP4
ADDRLP4 1228
ARGP4
ADDRLP4 1880
INDIRI4
ARGI4
ADDRLP4 1892
ADDRGP4 SelectInitialSpawnPoint
CALLP4
ASGNP4
ADDRLP4 1844
ADDRLP4 1892
INDIRP4
ASGNP4
line 1695
;1695:		} else {
ADDRGP4 $786
JUMPV
LABELV $785
line 1697
;1696:			// don't spawn near existing origin if possible
;1697:			spawnPoint = SelectSpawnPoint ( 
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 188
ARGP4
ADDRLP4 1228
ARGP4
ADDRLP4 1880
INDIRI4
ARGI4
ADDRLP4 1892
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 1844
ADDRLP4 1892
INDIRP4
ASGNP4
line 1700
;1698:				client->ps.origin, 
;1699:				spawn_origin, spawn_angles, filters);
;1700:		}
LABELV $786
line 1701
;1701:	}
LABELV $781
LABELV $778
LABELV $775
LABELV $769
line 1702
;1702:	client->pers.teamState.state = TEAM_ACTIVE;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 1705
;1703:
;1704:	// always clear the kamikaze flag
;1705:	ent->s.eFlags &= ~EF_KAMIKAZE;
ADDRLP4 1880
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 1880
INDIRP4
ADDRLP4 1880
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 1709
;1706:
;1707:	// toggle the teleport bit so the client knows to not lerp
;1708:	// and never clear the voted flag
;1709:	flags = ent->client->ps.eFlags & (EF_TELEPORT_BIT | EF_VOTED | EF_TEAMVOTED);
ADDRLP4 200
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 540676
BANDI4
ASGNI4
line 1710
;1710:	flags ^= EF_TELEPORT_BIT;
ADDRLP4 200
ADDRLP4 200
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 1714
;1711:
;1712://unlagged - backward reconciliation #3
;1713:	// we don't want players being backward-reconciled to the place they died
;1714:	G_ResetHistory( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_ResetHistory
CALLV
pop
line 1716
;1715:	// and this is as good a time as any to clear the saved state
;1716:	ent->client->saved.leveltime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1988
ADDP4
CNSTI4 0
ASGNI4
line 1721
;1717://unlagged - backward reconciliation #3
;1718:
;1719:	// clear everything but the persistant data
;1720:
;1721:	saved = client->pers;
ADDRLP4 1240
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRB
ASGNB 556
line 1722
;1722:	savedSess = client->sess;
ADDRLP4 1796
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRB
ASGNB 28
line 1723
;1723:	savedPing = client->ps.ping;
ADDRLP4 1824
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 1724
;1724:	vote = client->vote;
ADDRLP4 1836
ADDRLP4 0
INDIRP4
CNSTI4 1252
ADDP4
INDIRI4
ASGNI4
line 1726
;1725://	savedAreaBits = client->areabits;
;1726:	accuracy_hits = client->accuracy_hits;
ADDRLP4 1828
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
ASGNI4
line 1727
;1727:	accuracy_shots = client->accuracy_shots;
ADDRLP4 1832
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ASGNI4
line 1728
;1728:	memcpy(accuracy,client->accuracy,sizeof(accuracy));
ADDRLP4 76
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 2004
ADDP4
ARGP4
CNSTI4 112
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1730
;1729:
;1730:	memcpy(persistant,client->ps.persistant,sizeof(persistant));
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1731
;1731:	eventSequence = client->ps.eventSequence;
ADDRLP4 1840
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
line 1733
;1732:
;1733:	Com_Memset (client, 0, sizeof(*client));
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2116
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1735
;1734:
;1735:	client->pers = saved;
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
ADDRLP4 1240
INDIRB
ASGNB 556
line 1736
;1736:	client->sess = savedSess;
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ADDRLP4 1796
INDIRB
ASGNB 28
line 1737
;1737:	client->ps.ping = savedPing;
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 1824
INDIRI4
ASGNI4
line 1738
;1738:	client->vote = vote;
ADDRLP4 0
INDIRP4
CNSTI4 1252
ADDP4
ADDRLP4 1836
INDIRI4
ASGNI4
line 1740
;1739://	client->areabits = savedAreaBits;
;1740:	client->accuracy_hits = accuracy_hits;
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
ADDRLP4 1828
INDIRI4
ASGNI4
line 1741
;1741:	client->accuracy_shots = accuracy_shots;
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
ADDRLP4 1832
INDIRI4
ASGNI4
line 1742
;1742:	memcpy(client->accuracy,accuracy,sizeof(accuracy));
ADDRLP4 0
INDIRP4
CNSTI4 2004
ADDP4
ARGP4
ADDRLP4 76
ARGP4
CNSTI4 112
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1744
;1743:
;1744:	client->lastkilled_client = -1;
ADDRLP4 0
INDIRP4
CNSTI4 1124
ADDP4
CNSTI4 -1
ASGNI4
line 1746
;1745:
;1746:	memcpy(client->ps.persistant,persistant,sizeof(persistant));
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1747
;1747:	client->ps.eventSequence = eventSequence;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 1840
INDIRI4
ASGNI4
line 1749
;1748:	// increment the spawncount so the client will detect the respawn
;1749:	client->ps.persistant[PERS_SPAWN_COUNT]++;
ADDRLP4 1884
ADDRLP4 0
INDIRP4
CNSTI4 264
ADDP4
ASGNP4
ADDRLP4 1884
INDIRP4
ADDRLP4 1884
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1750
;1750:	client->ps.persistant[PERS_TEAM] = client->sess.sessionTeam;
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
line 1752
;1751:
;1752:	client->airOutTime = level.time + 12000;
ADDRLP4 0
INDIRP4
CNSTI4 1152
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 1754
;1753:
;1754:	trap_GetUserinfo( index, userinfo, sizeof(userinfo) );
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 204
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1756
;1755:	// set max health
;1756:	client->pers.maxHealth = atoi( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 204
ARGP4
ADDRGP4 $541
ARGP4
ADDRLP4 1892
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1892
INDIRP4
ARGP4
ADDRLP4 1896
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 1896
INDIRI4
ASGNI4
line 1757
;1757:	if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
ADDRLP4 1900
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1900
INDIRI4
CNSTI4 1
LTI4 $790
ADDRLP4 1900
INDIRI4
CNSTI4 100
LEI4 $788
LABELV $790
line 1758
;1758:		client->pers.maxHealth = 100;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 100
ASGNI4
line 1759
;1759:	}
LABELV $788
line 1761
;1760:	// clear entity values
;1761:	client->ps.stats[STAT_MAX_HEALTH] = client->pers.maxHealth;
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
line 1762
;1762:	client->ps.eFlags = flags;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 200
INDIRI4
ASGNI4
line 1764
;1763:
;1764:	ent->s.groundEntityNum = ENTITYNUM_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1023
ASGNI4
line 1765
;1765:	ent->client = &level.clients[index];
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
CNSTI4 2116
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1766
;1766:	ent->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 1767
;1767:	ent->inuse = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 1768
;1768:	ent->classname = "player";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $791
ASGNP4
line 1769
;1769:	ent->r.contents = CONTENTS_BODY;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 33554432
ASGNI4
line 1770
;1770:	ent->clipmask = MASK_PLAYERSOLID;
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 33619969
ASGNI4
line 1771
;1771:	ent->die = player_die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 player_die
ASGNP4
line 1772
;1772:	ent->waterlevel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
CNSTI4 0
ASGNI4
line 1773
;1773:	ent->watertype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
CNSTI4 0
ASGNI4
line 1774
;1774:	ent->flags = 0;
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 0
ASGNI4
line 1777
;1775:
;1776:	//Sago: No one has hit the client yet!
;1777:	client->lastSentFlying = -1;
ADDRLP4 0
INDIRP4
CNSTI4 1256
ADDP4
CNSTI4 -1
ASGNI4
line 1779
;1778:	
;1779:	VectorCopy (playerMins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 playerMins
INDIRB
ASGNB 12
line 1780
;1780:	VectorCopy (playerMaxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRGP4 playerMaxs
INDIRB
ASGNB 12
line 1782
;1781:
;1782:	client->ps.clientNum = index;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1784
;1783:
;1784:	if(!G_IsARoundBasedGametype(g_gametype.integer) && !g_elimination_allgametypes.integer && g_spawnselect.integer != 1)
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1908
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 1912
CNSTI4 0
ASGNI4
ADDRLP4 1908
INDIRI4
ADDRLP4 1912
INDIRI4
NEI4 $792
ADDRGP4 g_elimination_allgametypes+12
INDIRI4
ADDRLP4 1912
INDIRI4
NEI4 $792
ADDRGP4 g_spawnselect+12
INDIRI4
CNSTI4 1
EQI4 $792
line 1785
;1785:	{
line 1786
;1786:		client->ps.stats[STAT_WEAPONS] = ( 1 << WP_MACHINEGUN );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 4
ASGNI4
line 1787
;1787:		if ( g_gametype.integer == GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $797
line 1788
;1788:			client->ps.ammo[WP_MACHINEGUN] = 50;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 50
ASGNI4
line 1789
;1789:		} else {
ADDRGP4 $798
JUMPV
LABELV $797
line 1790
;1790:			client->ps.ammo[WP_MACHINEGUN] = 100;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 100
ASGNI4
line 1791
;1791:		}
LABELV $798
line 1793
;1792:
;1793:		client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GAUNTLET );
ADDRLP4 1916
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1916
INDIRP4
ADDRLP4 1916
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1794
;1794:		client->ps.ammo[WP_GAUNTLET] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 380
ADDP4
CNSTI4 -1
ASGNI4
line 1795
;1795:		client->ps.ammo[WP_GRAPPLING_HOOK] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 -1
ASGNI4
line 1798
;1796:
;1797:		// health will count down towards max_health
;1798:		ent->health = client->ps.stats[STAT_HEALTH] = client->ps.stats[STAT_MAX_HEALTH] + 25;
ADDRLP4 1924
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1924
INDIRI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 1924
INDIRI4
ASGNI4
line 1799
;1799:	}
ADDRGP4 $793
JUMPV
LABELV $792
line 1801
;1800:	else
;1801:	{
line 1802
;1802:		client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GAUNTLET );
ADDRLP4 1916
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1916
INDIRP4
ADDRLP4 1916
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1803
;1803:		client->ps.ammo[WP_GAUNTLET] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 380
ADDP4
CNSTI4 -1
ASGNI4
line 1804
;1804:		client->ps.ammo[WP_GRAPPLING_HOOK] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 -1
ASGNI4
line 1805
;1805:		if (g_elimination_machinegun.integer > 0) {
ADDRGP4 g_elimination_machinegun+12
INDIRI4
CNSTI4 0
LEI4 $800
line 1806
;1806:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_MACHINEGUN );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 1807
;1807:			client->ps.ammo[WP_MACHINEGUN] = g_elimination_machinegun.integer;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
ADDRGP4 g_elimination_machinegun+12
INDIRI4
ASGNI4
line 1808
;1808:		}
LABELV $800
line 1809
;1809:		if (g_elimination_shotgun.integer > 0) {
ADDRGP4 g_elimination_shotgun+12
INDIRI4
CNSTI4 0
LEI4 $804
line 1810
;1810:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_SHOTGUN );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1811
;1811:			client->ps.ammo[WP_SHOTGUN] = g_elimination_shotgun.integer;
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
ADDRGP4 g_elimination_shotgun+12
INDIRI4
ASGNI4
line 1812
;1812:		}
LABELV $804
line 1813
;1813:		if (g_elimination_grenade.integer > 0) {	
ADDRGP4 g_elimination_grenade+12
INDIRI4
CNSTI4 0
LEI4 $808
line 1814
;1814:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GRENADE_LAUNCHER );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1815
;1815:			client->ps.ammo[WP_GRENADE_LAUNCHER] = g_elimination_grenade.integer;
ADDRLP4 0
INDIRP4
CNSTI4 392
ADDP4
ADDRGP4 g_elimination_grenade+12
INDIRI4
ASGNI4
line 1816
;1816:		}
LABELV $808
line 1817
;1817:		if (g_elimination_rocket.integer > 0) {
ADDRGP4 g_elimination_rocket+12
INDIRI4
CNSTI4 0
LEI4 $812
line 1818
;1818:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_ROCKET_LAUNCHER );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1819
;1819:			client->ps.ammo[WP_ROCKET_LAUNCHER] = g_elimination_rocket.integer;
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 g_elimination_rocket+12
INDIRI4
ASGNI4
line 1820
;1820:		}
LABELV $812
line 1821
;1821:		if (g_elimination_lightning.integer > 0) {
ADDRGP4 g_elimination_lightning+12
INDIRI4
CNSTI4 0
LEI4 $816
line 1822
;1822:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_LIGHTNING );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1823
;1823:			client->ps.ammo[WP_LIGHTNING] = g_elimination_lightning.integer;
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 g_elimination_lightning+12
INDIRI4
ASGNI4
line 1824
;1824:		}
LABELV $816
line 1825
;1825:		if (g_elimination_railgun.integer > 0) {
ADDRGP4 g_elimination_railgun+12
INDIRI4
CNSTI4 0
LEI4 $820
line 1826
;1826:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_RAILGUN );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1827
;1827:			client->ps.ammo[WP_RAILGUN] = g_elimination_railgun.integer;
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
ADDRGP4 g_elimination_railgun+12
INDIRI4
ASGNI4
line 1828
;1828:		}
LABELV $820
line 1829
;1829:		if (g_elimination_plasmagun.integer > 0) {
ADDRGP4 g_elimination_plasmagun+12
INDIRI4
CNSTI4 0
LEI4 $824
line 1830
;1830:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_PLASMAGUN );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 1831
;1831:			client->ps.ammo[WP_PLASMAGUN] = g_elimination_plasmagun.integer;
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
ADDRGP4 g_elimination_plasmagun+12
INDIRI4
ASGNI4
line 1832
;1832:		}
LABELV $824
line 1833
;1833:		if (g_elimination_bfg.integer > 0) {
ADDRGP4 g_elimination_bfg+12
INDIRI4
CNSTI4 0
LEI4 $828
line 1834
;1834:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_BFG );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 1835
;1835:			client->ps.ammo[WP_BFG] = g_elimination_bfg.integer;
ADDRLP4 0
INDIRP4
CNSTI4 412
ADDP4
ADDRGP4 g_elimination_bfg+12
INDIRI4
ASGNI4
line 1836
;1836:		}
LABELV $828
line 1837
;1837:		if (g_elimination_nail.integer > 0) {
ADDRGP4 g_elimination_nail+12
INDIRI4
CNSTI4 0
LEI4 $832
line 1838
;1838:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_NAILGUN );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 1839
;1839:			client->ps.ammo[WP_NAILGUN] = g_elimination_nail.integer;
ADDRLP4 0
INDIRP4
CNSTI4 420
ADDP4
ADDRGP4 g_elimination_nail+12
INDIRI4
ASGNI4
line 1840
;1840:		}
LABELV $832
line 1841
;1841:		if (g_elimination_mine.integer > 0) {
ADDRGP4 g_elimination_mine+12
INDIRI4
CNSTI4 0
LEI4 $836
line 1842
;1842:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_PROX_LAUNCHER );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1843
;1843:			client->ps.ammo[WP_PROX_LAUNCHER] = g_elimination_mine.integer;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ADDRGP4 g_elimination_mine+12
INDIRI4
ASGNI4
line 1844
;1844:		}
LABELV $836
line 1845
;1845:		if (g_elimination_chain.integer > 0) {
ADDRGP4 g_elimination_chain+12
INDIRI4
CNSTI4 0
LEI4 $840
line 1846
;1846:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_CHAINGUN );
ADDRLP4 1920
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1920
INDIRP4
ADDRLP4 1920
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1847
;1847:			client->ps.ammo[WP_CHAINGUN] = g_elimination_chain.integer;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRGP4 g_elimination_chain+12
INDIRI4
ASGNI4
line 1848
;1848:		}
LABELV $840
line 1850
;1849:
;1850:		ent->health = client->ps.stats[STAT_ARMOR] = g_elimination_startArmor.integer; //client->ps.stats[STAT_MAX_HEALTH]*2;
ADDRLP4 1920
ADDRGP4 g_elimination_startArmor+12
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 1920
INDIRI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 1920
INDIRI4
ASGNI4
line 1851
;1851:		ent->health = client->ps.stats[STAT_HEALTH] = g_elimination_startHealth.integer; //client->ps.stats[STAT_MAX_HEALTH]*2;	
ADDRLP4 1924
ADDRGP4 g_elimination_startHealth+12
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1924
INDIRI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 1924
INDIRI4
ASGNI4
line 1852
;1852:	}
LABELV $793
line 1854
;1853:
;1854:	if(g_instantgib.integer)
ADDRGP4 g_instantgib+12
INDIRI4
CNSTI4 0
EQI4 $846
line 1855
;1855:	{
line 1856
;1856:		client->ps.stats[STAT_WEAPONS] = ( 1 << WP_RAILGUN );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 128
ASGNI4
line 1857
;1857:		client->ps.ammo[WP_RAILGUN] = 999; //Don't display any ammo
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
CNSTI4 999
ASGNI4
line 1858
;1858:		if (g_instantgib.integer>1) {
ADDRGP4 g_instantgib+12
INDIRI4
CNSTI4 1
LEI4 $849
line 1859
;1859:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GAUNTLET );
ADDRLP4 1916
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1916
INDIRP4
ADDRLP4 1916
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1860
;1860:			client->ps.ammo[WP_GAUNTLET] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 380
ADDP4
CNSTI4 -1
ASGNI4
line 1861
;1861:		}
LABELV $849
line 1862
;1862:	}
LABELV $846
line 1864
;1863:
;1864:	if (g_rockets.integer) {
ADDRGP4 g_rockets+12
INDIRI4
CNSTI4 0
EQI4 $852
line 1865
;1865:		client->ps.stats[STAT_WEAPONS] = ( 1 << WP_ROCKET_LAUNCHER );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 32
ASGNI4
line 1866
;1866:		client->ps.ammo[WP_ROCKET_LAUNCHER] = 999;
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
CNSTI4 999
ASGNI4
line 1867
;1867:	}
LABELV $852
line 1869
;1868:
;1869:	if (g_grapple.integer) {
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 0
EQI4 $855
line 1870
;1870:		client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GRAPPLING_HOOK );
ADDRLP4 1916
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 1916
INDIRP4
ADDRLP4 1916
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1871
;1871:	}
LABELV $855
line 1873
;1872:
;1873:	G_SetOrigin( ent, spawn_origin );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 188
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1874
;1874:	VectorCopy( spawn_origin, client->ps.origin );
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 188
INDIRB
ASGNB 12
line 1877
;1875:
;1876:	// the respawned flag will be cleared after the attack and jump keys come up
;1877:	client->ps.pm_flags |= PMF_RESPAWNED;
ADDRLP4 1916
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 1916
INDIRP4
ADDRLP4 1916
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 1878
;1878:	if(G_IsARoundBasedGametype(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1920
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 1920
INDIRI4
CNSTI4 0
EQI4 $858
line 1879
;1879:		client->ps.pm_flags |= PMF_ELIMWARMUP;
ADDRLP4 1924
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 1924
INDIRP4
ADDRLP4 1924
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 1880
;1880:	}
LABELV $858
line 1882
;1881:
;1882:	trap_GetUsercmd( client - level.clients, &ent->client->pers.cmd );
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
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRGP4 trap_GetUsercmd
CALLV
pop
line 1883
;1883:	SetClientViewAngle( ent, spawn_angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1228
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 1885
;1884:
;1885:	if ( (ent->client->sess.sessionTeam == TEAM_SPECTATOR) || ((client->ps.pm_type == PM_SPECTATOR || client->isEliminated) && 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $864
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $865
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $861
LABELV $865
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1928
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 1928
INDIRI4
CNSTI4 0
EQI4 $861
LABELV $864
line 1886
;1886:		G_IsARoundBasedGametype(g_gametype.integer))) {
line 1887
;1887:	} else {
ADDRGP4 $862
JUMPV
LABELV $861
line 1888
;1888:		G_KillBox( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_KillBox
CALLV
pop
line 1889
;1889:		trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1892
;1890:
;1891:		// force the base weapon up
;1892:		client->ps.weapon = WP_MACHINEGUN;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 2
ASGNI4
line 1893
;1893:		client->ps.weaponstate = WEAPON_READY;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1895
;1894:
;1895:	}
LABELV $862
line 1898
;1896:
;1897:	// don't allow full run speed for a bit
;1898:	client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 1932
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 1932
INDIRP4
ADDRLP4 1932
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1899
;1899:	client->ps.pm_time = 100;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 100
ASGNI4
line 1901
;1900:
;1901:	client->respawnTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 1136
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1902
;1902:	client->inactivityTime = level.time + g_inactivity.integer * 1000;
ADDRLP4 0
INDIRP4
CNSTI4 1140
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_inactivity+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 1903
;1903:	client->latched_buttons = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1068
ADDP4
CNSTI4 0
ASGNI4
line 1906
;1904:
;1905:	// set default animations
;1906:	client->ps.torsoAnim = TORSO_STAND;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 11
ASGNI4
line 1907
;1907:	client->ps.legsAnim = LEGS_IDLE;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTI4 22
ASGNI4
line 1909
;1908:
;1909:	if ( level.intermissiontime ) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $869
line 1910
;1910:		MoveClientToIntermission( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 MoveClientToIntermission
CALLV
pop
line 1911
;1911:	} else {
ADDRGP4 $870
JUMPV
LABELV $869
line 1913
;1912:		// fire the targets of the spawn point
;1913:		G_UseTargets( spawnPoint, ent );
ADDRLP4 1844
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 1917
;1914:
;1915:		// select the highest weapon number available, after any
;1916:		// spawn given items have fired
;1917:		client->ps.weapon = 1;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 1
ASGNI4
line 1918
;1918:		for ( i = WP_NUM_WEAPONS - 1 ; i > 0 ; i-- ) {
ADDRLP4 4
CNSTI4 13
ASGNI4
LABELV $872
line 1919
;1919:			if ( client->ps.stats[STAT_WEAPONS] & ( 1 << i ) && i !=WP_GRAPPLING_HOOK ) {
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $876
ADDRLP4 4
INDIRI4
CNSTI4 10
EQI4 $876
line 1920
;1920:				client->ps.weapon = i;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1921
;1921:				break;
ADDRGP4 $874
JUMPV
LABELV $876
line 1923
;1922:			}
;1923:		}
LABELV $873
line 1918
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
GTI4 $872
LABELV $874
line 1924
;1924:	}
LABELV $870
line 1928
;1925:
;1926:	// run a client frame to drop exactly to the floor,
;1927:	// initialize animations and other things
;1928:	client->ps.commandTime = level.time - 100;
ADDRLP4 0
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
SUBI4
ASGNI4
line 1929
;1929:	ent->client->pers.cmd.serverTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1930
;1930:	ClientThink( ent-g_entities );
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
ADDRGP4 ClientThink
CALLV
pop
line 1933
;1931:
;1932:	// positively link the client, even if the command times are weird
;1933:	if ( (ent->client->sess.sessionTeam != TEAM_SPECTATOR) || ( (!client->isEliminated || client->ps.pm_type != PM_SPECTATOR) && 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $883
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $884
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $880
LABELV $884
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1940
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 1940
INDIRI4
CNSTI4 0
EQI4 $880
LABELV $883
line 1934
;1934:		G_IsARoundBasedGametype(g_gametype.integer) ) ) {
line 1935
;1935:		BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1936
;1936:		VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );
ADDRLP4 1944
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1944
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 1944
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1937
;1937:		trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1938
;1938:	}
LABELV $880
line 1941
;1939:
;1940:	// run the presend to set anything else
;1941:	ClientEndFrame( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientEndFrame
CALLV
pop
line 1944
;1942:
;1943:	// clear entity state values
;1944:	BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1946
;1945:
;1946:	if(g_spawnprotect.integer)
ADDRGP4 g_spawnprotect+12
INDIRI4
CNSTI4 0
EQI4 $885
line 1947
;1947:		client->spawnprotected = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 2000
ADDP4
CNSTI4 1
ASGNI4
LABELV $885
line 1949
;1948:
;1949:	RespawnTimeMessage(ent,0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 RespawnTimeMessage
CALLV
pop
line 1950
;1950:}
LABELV $719
endproc ClientSpawn 1948 20
export ClientDisconnect
proc ClientDisconnect 1516 20
line 1965
;1951:
;1952:
;1953:/*
;1954:===========
;1955:ClientDisconnect
;1956:
;1957:Called when a player drops from the server.
;1958:Will not be called between levels.
;1959:
;1960:This should NOT be called directly by any game logic,
;1961:call trap_DropClient(), which will call this and do
;1962:server system housekeeping.
;1963:============
;1964:*/
;1965:void ClientDisconnect( int clientNum ) {
line 1972
;1966:	gentity_t	*ent;
;1967:	int			i;
;1968:	char	userinfo[MAX_INFO_STRING];
;1969:
;1970:	// cleanup if we are kicking a bot that
;1971:	// hasn't spawned yet
;1972:	G_RemoveQueuedBotBegin( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_RemoveQueuedBotBegin
CALLV
pop
line 1974
;1973:
;1974:	ent = g_entities + clientNum;
ADDRLP4 4
CNSTI4 816
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1975
;1975:	if ( !ent->client ) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $889
line 1976
;1976:		return;
ADDRGP4 $888
JUMPV
LABELV $889
line 1979
;1977:	}
;1978:
;1979:	ClientLeaving( clientNum);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientLeaving
CALLV
pop
line 1981
;1980:	//KK-OAX Admin
;1981:	G_admin_namelog_update( ent->client, qtrue );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 G_admin_namelog_update
CALLV
pop
line 1983
;1982:
;1983:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1986
;1984:
;1985:	// stop any following clients
;1986:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $894
JUMPV
LABELV $891
line 1987
;1987:		if ( (level.clients[i].sess.sessionTeam == TEAM_SPECTATOR || level.clients[i].ps.pm_type == PM_SPECTATOR)
ADDRLP4 1032
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $898
ADDRLP4 1032
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $896
LABELV $898
ADDRLP4 1036
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 1036
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
NEI4 $896
ADDRLP4 1036
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $896
line 1989
;1988:			&& level.clients[i].sess.spectatorState == SPECTATOR_FOLLOW
;1989:			&& level.clients[i].sess.spectatorClient == clientNum ) {
line 1990
;1990:			StopFollowing( &g_entities[i] );
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 1991
;1991:		}
LABELV $896
line 1992
;1992:	}
LABELV $892
line 1986
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $894
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $891
line 1995
;1993:
;1994:	//Is the player alive?
;1995:	i = (ent->client->ps.stats[STAT_HEALTH]>0);
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $900
ADDRLP4 1032
CNSTI4 1
ASGNI4
ADDRGP4 $901
JUMPV
LABELV $900
ADDRLP4 1032
CNSTI4 0
ASGNI4
LABELV $901
ADDRLP4 0
ADDRLP4 1032
INDIRI4
ASGNI4
line 1997
;1996:	//Commit suicide!
;1997:	if ( ent->client->pers.connected == CON_CONNECTED
ADDRLP4 1036
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $902
ADDRLP4 1036
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $902
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $902
line 1998
;1998:	&& ent->client->sess.sessionTeam != TEAM_SPECTATOR && i ) {
line 2000
;1999:		//Prevent a team from loosing point because of player leaving
;2000:		int teamscore = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 2001
;2001:		if (g_gametype.integer == GT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $904
line 2002
;2002:			teamscore = level.teamScores[ ent->client->sess.sessionTeam ];
ADDRLP4 1040
ADDRLP4 4
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
line 2003
;2003:		}
LABELV $904
line 2005
;2004:		// Kill him (makes sure he loses flags, etc)
;2005:		ent->flags &= ~FL_GODMODE;
ADDRLP4 1044
ADDRLP4 4
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
ADDRLP4 1044
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2006
;2006:		ent->client->ps.stats[STAT_HEALTH] = ent->health = 0;
ADDRLP4 1052
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 1052
INDIRI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1052
INDIRI4
ASGNI4
line 2007
;2007:		player_die (ent, ent, g_entities + ENTITYNUM_WORLD, 100000, MOD_SUICIDE);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 g_entities+833952
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 player_die
CALLV
pop
line 2008
;2008:		if (g_gametype.integer == GT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $909
line 2009
;2009:			level.teamScores[ ent->client->sess.sessionTeam ] = teamscore;
ADDRLP4 4
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
ADDRLP4 1040
INDIRI4
ASGNI4
line 2010
;2010:		}
LABELV $909
line 2011
;2011:	}
LABELV $902
line 2015
;2012:
;2013:
;2014:
;2015:	if ( ent->client->pers.connected == CON_CONNECTED && ent->client->sess.sessionTeam != TEAM_SPECTATOR) {
ADDRLP4 1040
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $913
ADDRLP4 1040
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $913
line 2016
;2016:		PlayerStore_store(Info_ValueForKey(userinfo,"cl_guid"),ent->client->ps);
ADDRLP4 8
ARGP4
ADDRGP4 $583
ARGP4
ADDRLP4 1512
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1512
INDIRP4
ARGP4
ADDRLP4 1044
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
INDIRB
ASGNB 468
ADDRLP4 1044
ARGP4
ADDRGP4 PlayerStore_store
CALLV
pop
line 2017
;2017:	}
LABELV $913
line 2019
;2018:
;2019:	G_LogPrintf( "ClientDisconnect: %i\n", clientNum );
ADDRGP4 $915
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 2022
;2020:
;2021:	// if we are playing in tourney mode and losing, give a win to the other player
;2022:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $916
ADDRLP4 1044
CNSTI4 0
ASGNI4
ADDRGP4 level+9144
INDIRI4
ADDRLP4 1044
INDIRI4
NEI4 $916
ADDRGP4 level+16
INDIRI4
ADDRLP4 1044
INDIRI4
NEI4 $916
ADDRGP4 level+84+4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $916
line 2024
;2023:		&& !level.intermissiontime
;2024:		&& !level.warmupTime && level.sortedClients[1] == clientNum ) {
line 2025
;2025:		level.clients[ level.sortedClients[0] ].sess.wins++;
ADDRLP4 1048
CNSTI4 2116
ADDRGP4 level+84
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1040
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2026
;2026:		ClientUserinfoChanged( level.sortedClients[0] );
ADDRGP4 level+84
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 2027
;2027:	}
LABELV $916
line 2029
;2028:
;2029:	if( g_gametype.integer == GT_TOURNAMENT &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $925
ADDRLP4 1048
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 1048
INDIRI4
NEI4 $925
ADDRGP4 level+9144
INDIRI4
ADDRLP4 1048
INDIRI4
EQI4 $925
line 2031
;2030:		ent->client->sess.sessionTeam == TEAM_FREE &&
;2031:		level.intermissiontime ) {
line 2033
;2032:
;2033:		trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
CNSTI4 2
ARGI4
ADDRGP4 $929
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 2034
;2034:		level.restarted = qtrue;
ADDRGP4 level+68
CNSTI4 1
ASGNI4
line 2035
;2035:		level.changemap = NULL;
ADDRGP4 level+9148
CNSTP4 0
ASGNP4
line 2036
;2036:		level.intermissiontime = 0;
ADDRGP4 level+9144
CNSTI4 0
ASGNI4
line 2037
;2037:	}
LABELV $925
line 2039
;2038:
;2039:	trap_UnlinkEntity (ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 2040
;2040:	ent->s.modelindex = 0;
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 2041
;2041:	ent->inuse = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 0
ASGNI4
line 2042
;2042:	ent->classname = "disconnected";
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $933
ASGNP4
line 2043
;2043:	ent->client->pers.connected = CON_DISCONNECTED;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 0
ASGNI4
line 2044
;2044:	ent->client->ps.persistant[PERS_TEAM] = TEAM_FREE;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
CNSTI4 0
ASGNI4
line 2045
;2045:	ent->client->sess.sessionTeam = TEAM_FREE;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
CNSTI4 0
ASGNI4
line 2047
;2046:
;2047:	trap_SetConfigstring( CS_PLAYERS + clientNum, "");
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRGP4 $934
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 2049
;2048:
;2049:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 2050
;2050:	CountVotes();
ADDRGP4 CountVotes
CALLV
pop
line 2052
;2051:
;2052:	if ( ent->r.svFlags & SVF_BOT ) {
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $935
line 2053
;2053:		BotAIShutdownClient( clientNum, qfalse );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 2054
;2054:	}
LABELV $935
line 2055
;2055:}
LABELV $888
endproc ClientDisconnect 1516 20
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
import CalculateRanks
import AddScore
import player_die
import InitClientResp
import InitClientPersistant
import BeginIntermission
import EndEliminationRound
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
LABELV $934
byte 1 0
align 1
LABELV $933
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
LABELV $929
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
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $915
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 68
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $791
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $741
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
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 34
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
byte 1 0
align 1
LABELV $713
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 66
byte 1 101
byte 1 103
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $712
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $682
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 114
byte 1 101
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
byte 1 97
byte 1 116
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 49
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 10
byte 1 0
align 1
LABELV $660
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 0
align 1
LABELV $658
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 70
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $657
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 70
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 79
byte 1 78
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $650
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $647
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $642
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $630
byte 1 71
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $629
byte 1 68
byte 1 117
byte 1 112
byte 1 108
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 71
byte 1 85
byte 1 73
byte 1 68
byte 1 0
align 1
LABELV $628
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 71
byte 1 85
byte 1 73
byte 1 68
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 117
byte 1 114
byte 1 101
byte 1 34
byte 1 0
align 1
LABELV $616
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 71
byte 1 85
byte 1 73
byte 1 68
byte 1 0
align 1
LABELV $604
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $602
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $597
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $594
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $591
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
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
byte 1 0
align 1
LABELV $590
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 73
byte 1 80
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $589
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $586
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $583
byte 1 99
byte 1 108
byte 1 95
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $582
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 85
byte 1 115
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 92
byte 1 105
byte 1 100
byte 1 92
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $581
byte 1 110
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 103
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 49
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 50
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 99
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 119
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 108
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 116
byte 1 116
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 116
byte 1 108
byte 1 92
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $580
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $579
byte 1 110
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 49
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 50
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 99
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 119
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 108
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 116
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 116
byte 1 108
byte 1 92
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $576
byte 1 103
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $575
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $574
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $573
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $559
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
LABELV $555
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
LABELV $551
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
LABELV $550
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $549
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
LABELV $548
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
LABELV $541
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $538
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $533
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
LABELV $522
byte 1 85
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $517
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
LABELV $514
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
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 119
byte 1 104
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $510
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 97
byte 1 120
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 40
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 115
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $504
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 109
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 40
byte 1 103
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 80
byte 1 101
byte 1 114
byte 1 105
byte 1 111
byte 1 100
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $497
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $496
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
LABELV $493
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
LABELV $490
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
LABELV $489
byte 1 92
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 92
byte 1 98
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 0
align 1
LABELV $485
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 115
byte 1 115
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $432
byte 1 66
byte 1 111
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
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
byte 1 0
align 1
LABELV $412
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
LABELV $254
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
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $239
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $235
byte 1 37
byte 1 115
byte 1 44
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $234
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $172
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
LABELV $136
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 113
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $115
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 46
byte 1 10
byte 1 65
byte 1 110
byte 1 121
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 116
byte 1 97
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 34
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 34
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $69
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
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
LABELV $65
byte 1 110
byte 1 111
byte 1 104
byte 1 117
byte 1 109
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $62
byte 1 48
byte 1 0
align 1
LABELV $61
byte 1 110
byte 1 111
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
