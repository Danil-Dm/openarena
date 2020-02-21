export SP_info_camp
code
proc SP_info_camp 4 8
file "../../../code/game/g_misc.c"
line 36
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
;23:// g_misc.c
;24:
;25:#include "g_local.h"
;26:
;27:
;28:/*QUAKED func_group (0 0 0) ?
;29:Used to group brushes together just for editor convenience.  They are turned into normal brushes by the utilities.
;30:*/
;31:
;32:
;33:/*QUAKED info_camp (0 0.5 0) (-4 -4 -4) (4 4 4)
;34:Used as a positional target for calculations in the utilities (spotlights, etc), but removed during gameplay.
;35:*/
;36:void SP_info_camp( gentity_t *self ) {
line 37
;37:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 38
;38:}
LABELV $60
endproc SP_info_camp 4 8
export SP_info_null
proc SP_info_null 0 4
line 44
;39:
;40:
;41:/*QUAKED info_null (0 0.5 0) (-4 -4 -4) (4 4 4)
;42:Used as a positional target for calculations in the utilities (spotlights, etc), but removed during gameplay.
;43:*/
;44:void SP_info_null( gentity_t *self ) {
line 45
;45:	G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 46
;46:}
LABELV $61
endproc SP_info_null 0 4
export SP_info_notnull
proc SP_info_notnull 4 8
line 53
;47:
;48:
;49:/*QUAKED info_notnull (0 0.5 0) (-4 -4 -4) (4 4 4)
;50:Used as a positional target for in-game calculation, like jumppad targets.
;51:target_position does the same thing
;52:*/
;53:void SP_info_notnull( gentity_t *self ){
line 54
;54:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 55
;55:}
LABELV $62
endproc SP_info_notnull 4 8
export SP_light
proc SP_light 0 4
line 65
;56:
;57:
;58:/*QUAKED light (0 1 0) (-8 -8 -8) (8 8 8) linear
;59:Non-displayed light.
;60:"light" overrides the default 300 intensity.
;61:Linear checbox gives linear falloff instead of inverse square
;62:Lights pointed at a target will be spotlights.
;63:"radius" overrides the default 64 unit radius of a spotlight at the target point.
;64:*/
;65:void SP_light( gentity_t *self ) {
line 66
;66:	G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 67
;67:}
LABELV $63
endproc SP_light 0 4
export TeleportPlayer
proc TeleportPlayer 40 16
line 79
;68:
;69:
;70:
;71:/*
;72:=================================================================================
;73:
;74:TELEPORTERS
;75:
;76:=================================================================================
;77:*/
;78:
;79:void TeleportPlayer( gentity_t *player, vec3_t origin, vec3_t angles ) {
line 83
;80:	gentity_t	*tent;
;81:	qboolean noAngles;
;82:
;83:	noAngles = (angles[0] > 999999.0);
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1232348144
LEF4 $66
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $67
JUMPV
LABELV $66
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $67
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 86
;84:	// use temp events at source and destination to prevent the effect
;85:	// from getting dropped by a second player event
;86:	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR && player->client->ps.pm_type != PM_SPECTATOR) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $68
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $68
line 87
;87:		tent = G_TempEntity( player->client->ps.origin, EV_PLAYER_TELEPORT_OUT );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 43
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 88
;88:		tent->s.clientNum = player->s.clientNum;
ADDRLP4 20
CNSTI4 168
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 90
;89:
;90:		tent = G_TempEntity( origin, EV_PLAYER_TELEPORT_IN );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 24
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 91
;91:		tent->s.clientNum = player->s.clientNum;
ADDRLP4 28
CNSTI4 168
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 92
;92:	}
LABELV $68
line 95
;93:
;94:	// unlink to make sure it can't possibly interfere with G_KillBox
;95:	trap_UnlinkEntity (player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 97
;96:
;97:	VectorCopy ( origin, player->client->ps.origin );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 98
;98:	player->client->ps.origin[2] += 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 100
;99:
;100:	if (!noAngles) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $70
line 102
;101:		// spit the player out
;102:		AngleVectors( angles, player->client->ps.velocity, NULL, NULL );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 20
CNSTP4 0
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 103
;103:		VectorScale( player->client->ps.velocity, 400, player->client->ps.velocity );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTF4 1137180672
ADDRLP4 24
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTF4 1137180672
ADDRLP4 28
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTF4 1137180672
ADDRLP4 32
INDIRP4
INDIRF4
MULF4
ASGNF4
line 104
;104:		player->client->ps.pm_time = 160;		// hold time
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 160
ASGNI4
line 105
;105:		player->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 108
;106:
;107:		// set angles
;108:		SetClientViewAngle(player, angles);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 109
;109:	}
LABELV $70
line 112
;110:
;111:	// toggle the teleport bit so the client knows to not lerp
;112:	player->client->ps.eFlags ^= EF_TELEPORT_BIT;
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
CNSTI4 4
BXORI4
ASGNI4
line 116
;113:
;114://unlagged - backward reconciliation #3
;115:	// we don't want players being backward-reconciled back through teleporters
;116:	G_ResetHistory( player );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_ResetHistory
CALLV
pop
line 120
;117://unlagged - backward reconciliation #3
;118:
;119:	// kill anything at the destination
;120:	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR && player->client->ps.pm_type != PM_SPECTATOR ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $72
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $72
line 121
;121:		G_KillBox (player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_KillBox
CALLV
pop
line 122
;122:	}
LABELV $72
line 125
;123:
;124:	// save results of pmove
;125:	BG_PlayerStateToEntityState( &player->client->ps, &player->s, qtrue );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 128
;126:
;127:	// use the precise origin for linking
;128:	VectorCopy( player->client->ps.origin, player->r.currentOrigin );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 130
;129:
;130:	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR && player->client->ps.pm_type != PM_SPECTATOR ) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $74
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $74
line 131
;131:		trap_LinkEntity (player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 132
;132:	}
LABELV $74
line 133
;133:}
LABELV $64
endproc TeleportPlayer 40 16
export SP_misc_teleporter_dest
proc SP_misc_teleporter_dest 0 0
line 141
;134:
;135:
;136:/*QUAKED misc_teleporter_dest (1 0 0) (-32 -32 -24) (32 32 -16)
;137:Point teleporters at these.
;138:Now that we don't have teleport destination pads, this is just
;139:an info_notnull
;140:*/
;141:void SP_misc_teleporter_dest( gentity_t *ent ) {
line 142
;142:}
LABELV $76
endproc SP_misc_teleporter_dest 0 0
export SP_misc_model
proc SP_misc_model 0 4
line 150
;143:
;144:
;145://===========================================================
;146:
;147:/*QUAKED misc_model (1 0 0) (-16 -16 -16) (16 16 16)
;148:"model"		arbitrary .md3 file to display
;149:*/
;150:void SP_misc_model( gentity_t *ent ) {
line 161
;151:
;152:#if 0
;153:	ent->s.modelindex = G_ModelIndex( ent->model );
;154:	VectorSet (ent->mins, -16, -16, -16);
;155:	VectorSet (ent->maxs, 16, 16, 16);
;156:	trap_LinkEntity (ent);
;157:
;158:	G_SetOrigin( ent, ent->s.origin );
;159:	VectorCopy( ent->s.angles, ent->s.apos.trBase );
;160:#else
;161:	G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 163
;162:#endif
;163:}
LABELV $77
endproc SP_misc_model 0 4
export locateCamera
proc locateCamera 52 8
line 167
;164:
;165://===========================================================
;166:
;167:void locateCamera( gentity_t *ent ) {
line 172
;168:	vec3_t		dir;
;169:	gentity_t	*target;
;170:	gentity_t	*owner;
;171:
;172:	owner = G_PickTarget( ent->target );
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 173
;173:	if ( !owner ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $79
line 174
;174:		G_Printf( "Couldn't find target for misc_partal_surface\n" );
ADDRGP4 $81
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 175
;175:		G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 176
;176:		return;
ADDRGP4 $78
JUMPV
LABELV $79
line 178
;177:	}
;178:	ent->r.ownerNum = owner->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 181
;179:
;180:	// frame holds the rotate speed
;181:	if ( owner->spawnflags & 1 ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $82
line 182
;182:		ent->s.frame = 25;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 25
ASGNI4
line 183
;183:	} else if ( owner->spawnflags & 2 ) {
ADDRGP4 $83
JUMPV
LABELV $82
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $84
line 184
;184:		ent->s.frame = 75;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 75
ASGNI4
line 185
;185:	}
LABELV $84
LABELV $83
line 188
;186:
;187:	// swing camera ?
;188:	if ( owner->spawnflags & 4 ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $86
line 190
;189:		// set to 0 for no rotation at all
;190:		ent->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 191
;191:	}
ADDRGP4 $87
JUMPV
LABELV $86
line 192
;192:	else {
line 193
;193:		ent->s.powerups = 1;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 1
ASGNI4
line 194
;194:	}
LABELV $87
line 197
;195:
;196:	// clientNum holds the rotate offset
;197:	ent->s.clientNum = owner->s.clientNum;
ADDRLP4 24
CNSTI4 168
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 199
;198:
;199:	VectorCopy( owner->s.origin, ent->s.origin2 );
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 202
;200:
;201:	// see if the portal_camera has a target
;202:	target = G_PickTarget( owner->target );
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 28
INDIRP4
ASGNP4
line 203
;203:	if ( target ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $88
line 204
;204:		VectorSubtract( target->s.origin, owner->s.origin, dir );
ADDRLP4 36
CNSTI4 92
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
CNSTI4 96
ASGNI4
ADDRLP4 4+4
ADDRLP4 16
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 100
ASGNI4
ADDRLP4 4+8
ADDRLP4 16
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 205
;205:		VectorNormalize( dir );
ADDRLP4 4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 206
;206:	} else {
ADDRGP4 $89
JUMPV
LABELV $88
line 207
;207:		G_SetMovedir( owner->s.angles, dir );
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 208
;208:	}
LABELV $89
line 210
;209:
;210:	ent->s.eventParm = DirToByte( dir );
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 211
;211:}
LABELV $78
endproc locateCamera 52 8
export SP_misc_portal_surface
proc SP_misc_portal_surface 20 4
line 217
;212:
;213:/*QUAKED misc_portal_surface (0 0 1) (-8 -8 -8) (8 8 8)
;214:The portal surface nearest this entity will show a view from the targeted misc_portal_camera, or a mirror view if untargeted.
;215:This must be within 64 world units of the surface!
;216:*/
;217:void SP_misc_portal_surface(gentity_t *ent) {
line 218
;218:	VectorClear( ent->r.mins );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 219
;219:	VectorClear( ent->r.maxs );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 456
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 220
;220:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 222
;221:
;222:	ent->r.svFlags = SVF_PORTAL;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 64
ASGNI4
line 223
;223:	ent->s.eType = ET_PORTAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 6
ASGNI4
line 225
;224:
;225:	if ( !ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $93
line 226
;226:		VectorCopy( ent->s.origin, ent->s.origin2 );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 227
;227:	} else {
ADDRGP4 $94
JUMPV
LABELV $93
line 228
;228:		ent->think = locateCamera;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 locateCamera
ASGNP4
line 229
;229:		ent->nextthink = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 230
;230:	}
LABELV $94
line 231
;231:}
LABELV $92
endproc SP_misc_portal_surface 20 4
export SP_misc_portal_camera
proc SP_misc_portal_camera 20 12
line 237
;232:
;233:/*QUAKED misc_portal_camera (0 0 1) (-8 -8 -8) (8 8 8) slowrotate fastrotate noswing
;234:The target for a misc_portal_director.  You can set either angles or target another entity to determine the direction of view.
;235:"roll" an angle modifier to orient the camera around the target vector;
;236:*/
;237:void SP_misc_portal_camera(gentity_t *ent) {
line 240
;238:	float	roll;
;239:
;240:	VectorClear( ent->r.mins );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 241
;241:	VectorClear( ent->r.maxs );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 456
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 242
;242:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 244
;243:
;244:	G_SpawnFloat( "roll", "0", &roll );
ADDRGP4 $97
ARGP4
ADDRGP4 $98
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 246
;245:
;246:	ent->s.clientNum = roll/360.0 * 256;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
CNSTF4 1132462080
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
CVFI4 4
ASGNI4
line 247
;247:}
LABELV $96
endproc SP_misc_portal_camera 20 12
export Use_Shooter
proc Use_Shooter 76 12
line 257
;248:
;249:/*
;250:======================================================================
;251:
;252:  SHOOTERS
;253:
;254:======================================================================
;255:*/
;256:
;257:void Use_Shooter( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 263
;258:	vec3_t		dir;
;259:	float		deg;
;260:	vec3_t		up, right;
;261:
;262:	// see if we have a target
;263:	if ( ent->enemy ) {
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $100
line 264
;264:		VectorSubtract( ent->enemy->r.currentOrigin, ent->s.origin, dir );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 768
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 48
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 265
;265:		VectorNormalize( dir );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 266
;266:	} else {
ADDRGP4 $101
JUMPV
LABELV $100
line 267
;267:		VectorCopy( ent->movedir, dir );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRB
ASGNB 12
line 268
;268:	}
LABELV $101
line 271
;269:
;270:	// randomize a bit
;271:	PerpendicularVector( up, dir );
ADDRLP4 16
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 272
;272:	CrossProduct( up, dir, right );
ADDRLP4 16
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 274
;273:
;274:	deg = crandom() * ent->random;
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
CNSTF4 1073741824
ADDRLP4 40
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
MULF4
ASGNF4
line 275
;275:	VectorMA( dir, deg, up, dir );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 16+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 277
;276:
;277:	deg = crandom() * ent->random;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
CNSTF4 1073741824
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
MULF4
ASGNF4
line 278
;278:	VectorMA( dir, deg, right, dir );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 280
;279:
;280:	VectorNormalize( dir );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 282
;281:
;282:	switch ( ent->s.weapon ) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 4
EQI4 $119
ADDRLP4 56
INDIRI4
CNSTI4 5
EQI4 $120
ADDRLP4 56
INDIRI4
CNSTI4 8
EQI4 $121
ADDRGP4 $116
JUMPV
LABELV $119
line 284
;283:	case WP_GRENADE_LAUNCHER:
;284:		fire_grenade( ent, ent->s.origin, dir );
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 fire_grenade
CALLP4
pop
line 285
;285:		break;
ADDRGP4 $117
JUMPV
LABELV $120
line 287
;286:	case WP_ROCKET_LAUNCHER:
;287:		fire_rocket( ent, ent->s.origin, dir );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 fire_rocket
CALLP4
pop
line 288
;288:		break;
ADDRGP4 $117
JUMPV
LABELV $121
line 290
;289:	case WP_PLASMAGUN:
;290:		fire_plasma( ent, ent->s.origin, dir );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 fire_plasma
CALLP4
pop
line 291
;291:		break;
LABELV $116
LABELV $117
line 294
;292:	}
;293:
;294:	G_AddEvent( ent, EV_FIRE_WEAPON, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 23
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 295
;295:}
LABELV $99
endproc Use_Shooter 76 12
proc InitShooter_Finish 8 4
line 298
;296:
;297:
;298:static void InitShooter_Finish( gentity_t *ent ) {
line 299
;299:	ent->enemy = G_PickTarget( ent->target );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 300
;300:	ent->think = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTP4 0
ASGNP4
line 301
;301:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 302
;302:}
LABELV $122
endproc InitShooter_Finish 8 4
export InitShooter
proc InitShooter 16 8
line 304
;303:
;304:void InitShooter( gentity_t *ent, int weapon ) {
line 305
;305:	ent->use = Use_Shooter;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Shooter
ASGNP4
line 306
;306:	ent->s.weapon = weapon;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 308
;307:
;308:	RegisterItem( BG_FindItemForWeapon( weapon ) );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 310
;309:
;310:	G_SetMovedir( ent->s.angles, ent->movedir );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 312
;311:
;312:	if ( !ent->random ) {
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
CNSTF4 0
NEF4 $124
line 313
;313:		ent->random = 1.0;
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
CNSTF4 1065353216
ASGNF4
line 314
;314:	}
LABELV $124
line 315
;315:	ent->random = sin( M_PI * ent->random / 180 );
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
ASGNP4
CNSTF4 1078530011
ADDRLP4 8
INDIRP4
INDIRF4
MULF4
CNSTF4 1127481344
DIVF4
ARGF4
ADDRLP4 12
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 317
;316:	// target might be a moving object, so we can't set movedir for it
;317:	if ( ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $126
line 318
;318:		ent->think = InitShooter_Finish;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 InitShooter_Finish
ASGNP4
line 319
;319:		ent->nextthink = level.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 320
;320:	}
LABELV $126
line 321
;321:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 322
;322:}
LABELV $123
endproc InitShooter 16 8
export SP_shooter_rocket
proc SP_shooter_rocket 0 8
line 328
;323:
;324:/*QUAKED shooter_rocket (1 0 0) (-16 -16 -16) (16 16 16)
;325:Fires at either the target or the current direction.
;326:"random" the number of degrees of deviance from the taget. (1.0 default)
;327:*/
;328:void SP_shooter_rocket( gentity_t *ent ) {
line 329
;329:	InitShooter( ent, WP_ROCKET_LAUNCHER );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 InitShooter
CALLV
pop
line 330
;330:}
LABELV $129
endproc SP_shooter_rocket 0 8
export SP_shooter_plasma
proc SP_shooter_plasma 0 8
line 336
;331:
;332:/*QUAKED shooter_plasma (1 0 0) (-16 -16 -16) (16 16 16)
;333:Fires at either the target or the current direction.
;334:"random" is the number of degrees of deviance from the taget. (1.0 default)
;335:*/
;336:void SP_shooter_plasma( gentity_t *ent ) {
line 337
;337:	InitShooter( ent, WP_PLASMAGUN);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 InitShooter
CALLV
pop
line 338
;338:}
LABELV $130
endproc SP_shooter_plasma 0 8
export SP_shooter_grenade
proc SP_shooter_grenade 0 8
line 344
;339:
;340:/*QUAKED shooter_grenade (1 0 0) (-16 -16 -16) (16 16 16)
;341:Fires at either the target or the current direction.
;342:"random" is the number of degrees of deviance from the taget. (1.0 default)
;343:*/
;344:void SP_shooter_grenade( gentity_t *ent ) {
line 345
;345:	InitShooter( ent, WP_GRENADE_LAUNCHER);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 InitShooter
CALLV
pop
line 346
;346:}
LABELV $131
endproc SP_shooter_grenade 0 8
proc PortalDie 0 4
line 348
;347:
;348:static void PortalDie (gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int mod) {
line 349
;349:	G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 351
;350:	//FIXME do something more interesting
;351:}
LABELV $132
endproc PortalDie 0 4
export DropPortalDestination
proc DropPortalDestination 44 8
line 354
;352:
;353:
;354:void DropPortalDestination( gentity_t *player ) {
line 359
;355:	gentity_t	*ent;
;356:	vec3_t		snapped;
;357:
;358:	// create the portal destination
;359:	ent = G_Spawn();
ADDRLP4 16
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 360
;360:	ent->s.modelindex = G_ModelIndex( "models/powerups/teleporter/tele_exit.md3" );
ADDRGP4 $134
ARGP4
ADDRLP4 20
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 362
;361:
;362:	VectorCopy( player->s.pos.trBase, snapped );
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 363
;363:	SnapVector( snapped );
ADDRLP4 4
ADDRLP4 4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 364
;364:	G_SetOrigin( ent, snapped );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 365
;365:	VectorCopy( player->r.mins, ent->r.mins );
ADDRLP4 24
CNSTI4 436
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 366
;366:	VectorCopy( player->r.maxs, ent->r.maxs );
ADDRLP4 28
CNSTI4 448
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 368
;367:
;368:	ent->classname = "hi_portal destination";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $139
ASGNP4
line 369
;369:	ent->s.pos.trType = TR_STATIONARY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 371
;370:
;371:	ent->r.contents = CONTENTS_CORPSE;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 372
;372:	ent->takedamage = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 373
;373:	ent->health = 200;
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 200
ASGNI4
line 374
;374:	ent->die = PortalDie;
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 PortalDie
ASGNP4
line 376
;375:
;376:	VectorCopy( player->s.apos.trBase, ent->s.angles );
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 378
;377:
;378:	ent->think = G_FreeEntity;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 379
;379:	ent->nextthink = level.time + 2 * 60 * 1000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 120000
ADDI4
ASGNI4
line 381
;380:
;381:	trap_LinkEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 383
;382:
;383:	player->client->portalID = ++level.portalSequence;
ADDRLP4 32
ADDRGP4 level+9228
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1180
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 384
;384:	ent->count = player->client->portalID;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1180
ADDP4
INDIRI4
ASGNI4
line 387
;385:
;386:	// give the item back so they can drop the source now
;387:	player->client->ps.stats[STAT_HOLDABLE_ITEM] = BG_FindItem( "Portal" ) - bg_itemlist;
ADDRGP4 $142
ARGP4
ADDRLP4 40
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 40
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 388
;388:}
LABELV $133
endproc DropPortalDestination 44 8
proc PortalTouch 24 32
line 391
;389:
;390:
;391:static void PortalTouch( gentity_t *self, gentity_t *other, trace_t *trace) {
line 395
;392:	gentity_t	*destination;
;393:
;394:	// see if we will even let other try to use it
;395:	if( other->health <= 0 ) {
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $144
line 396
;396:		return;
ADDRGP4 $143
JUMPV
LABELV $144
line 398
;397:	}
;398:	if( !other->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $146
line 399
;399:		return;
ADDRGP4 $143
JUMPV
LABELV $146
line 405
;400:	}
;401://	if( other->client->ps.persistant[PERS_TEAM] != self->spawnflags ) {
;402://		return;
;403://	}
;404:
;405:	if ( other->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $148
line 406
;406:		Drop_Item( other, BG_FindItemForPowerup( PW_NEUTRALFLAG ), 0 );
CNSTI4 9
ARGI4
ADDRLP4 4
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Drop_Item
CALLP4
pop
line 407
;407:		other->client->ps.powerups[PW_NEUTRALFLAG] = 0;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
CNSTI4 0
ASGNI4
line 408
;408:	}
ADDRGP4 $149
JUMPV
LABELV $148
line 409
;409:	else if ( other->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $150
line 410
;410:		Drop_Item( other, BG_FindItemForPowerup( PW_REDFLAG ), 0 );
CNSTI4 7
ARGI4
ADDRLP4 4
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Drop_Item
CALLP4
pop
line 411
;411:		other->client->ps.powerups[PW_REDFLAG] = 0;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 0
ASGNI4
line 412
;412:	}
ADDRGP4 $151
JUMPV
LABELV $150
line 413
;413:	else if ( other->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $152
line 414
;414:		Drop_Item( other, BG_FindItemForPowerup( PW_BLUEFLAG ), 0 );
CNSTI4 8
ARGI4
ADDRLP4 4
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Drop_Item
CALLP4
pop
line 415
;415:		other->client->ps.powerups[PW_BLUEFLAG] = 0;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 0
ASGNI4
line 416
;416:	}
LABELV $152
LABELV $151
LABELV $149
line 419
;417:
;418:	// find the destination
;419:	destination = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $155
JUMPV
LABELV $154
line 420
;420:	while( (destination = G_Find(destination, FOFS(classname), "hi_portal destination")) != NULL ) {
line 421
;421:		if( destination->count == self->count ) {
ADDRLP4 4
CNSTI4 760
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
NEI4 $157
line 422
;422:			break;
ADDRGP4 $156
JUMPV
LABELV $157
line 424
;423:		}
;424:	}
LABELV $155
line 420
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $139
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
NEU4 $154
LABELV $156
line 427
;425:
;426:	// if there is not one, die!
;427:	if( !destination ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $159
line 428
;428:		if( self->pos1[0] || self->pos1[1] || self->pos1[2] ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
NEF4 $164
ADDRLP4 8
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
NEF4 $164
ADDRLP4 8
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
EQF4 $161
LABELV $164
line 429
;429:			TeleportPlayer( other, self->pos1, self->s.angles );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 612
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 430
;430:		}
LABELV $161
line 431
;431:		G_Damage( other, other, other, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_TELEFRAG );
ADDRLP4 16
ADDRFP4 4
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
ADDRLP4 20
CNSTP4 0
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 8
ARGI4
CNSTI4 18
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 432
;432:		return;
ADDRGP4 $143
JUMPV
LABELV $159
line 435
;433:	}
;434:
;435:	TeleportPlayer( other, destination->s.pos.trBase, destination->s.angles );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 436
;436:}
LABELV $143
endproc PortalTouch 24 32
proc PortalEnable 0 0
line 439
;437:
;438:
;439:static void PortalEnable( gentity_t *self ) {
line 440
;440:	self->touch = PortalTouch;
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 PortalTouch
ASGNP4
line 441
;441:	self->think = G_FreeEntity;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 442
;442:	self->nextthink = level.time + 2 * 60 * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 120000
ADDI4
ASGNI4
line 443
;443:}
LABELV $165
endproc PortalEnable 0 0
export DropPortalSource
proc DropPortalSource 40 12
line 446
;444:
;445:
;446:void DropPortalSource( gentity_t *player ) {
line 452
;447:	gentity_t	*ent;
;448:	gentity_t	*destination;
;449:	vec3_t		snapped;
;450:
;451:	// create the portal source
;452:	ent = G_Spawn();
ADDRLP4 20
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 453
;453:	ent->s.modelindex = G_ModelIndex( "models/powerups/teleporter/tele_enter.md3" );
ADDRGP4 $168
ARGP4
ADDRLP4 24
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 455
;454:
;455:	VectorCopy( player->s.pos.trBase, snapped );
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 456
;456:	SnapVector( snapped );
ADDRLP4 8
ADDRLP4 8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 8+4
ADDRLP4 8+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 457
;457:	G_SetOrigin( ent, snapped );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 458
;458:	VectorCopy( player->r.mins, ent->r.mins );
ADDRLP4 28
CNSTI4 436
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 459
;459:	VectorCopy( player->r.maxs, ent->r.maxs );
ADDRLP4 32
CNSTI4 448
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
INDIRB
ASGNB 12
line 461
;460:
;461:	ent->classname = "hi_portal source";
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $173
ASGNP4
line 462
;462:	ent->s.pos.trType = TR_STATIONARY;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 464
;463:
;464:	ent->r.contents = CONTENTS_CORPSE | CONTENTS_TRIGGER;
ADDRLP4 4
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1140850688
ASGNI4
line 465
;465:	ent->takedamage = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 466
;466:	ent->health = 200;
ADDRLP4 4
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 200
ASGNI4
line 467
;467:	ent->die = PortalDie;
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 PortalDie
ASGNP4
line 469
;468:
;469:	trap_LinkEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 471
;470:
;471:	ent->count = player->client->portalID;
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1180
ADDP4
INDIRI4
ASGNI4
line 472
;472:	player->client->portalID = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1180
ADDP4
CNSTI4 0
ASGNI4
line 476
;473:
;474://	ent->spawnflags = player->client->ps.persistant[PERS_TEAM];
;475:
;476:	ent->nextthink = level.time + 1000;
ADDRLP4 4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 477
;477:	ent->think = PortalEnable;
ADDRLP4 4
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 PortalEnable
ASGNP4
line 480
;478:
;479:	// find the destination
;480:	destination = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $176
JUMPV
LABELV $175
line 481
;481:	while( (destination = G_Find(destination, FOFS(classname), "hi_portal destination")) != NULL ) {
line 482
;482:		if( destination->count == ent->count ) {
ADDRLP4 36
CNSTI4 760
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
NEI4 $178
line 483
;483:			VectorCopy( destination->s.pos.trBase, ent->pos1 );
ADDRLP4 4
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 484
;484:			break;
ADDRGP4 $177
JUMPV
LABELV $178
line 486
;485:		}
;486:	}
LABELV $176
line 481
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $139
ARGP4
ADDRLP4 36
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $175
LABELV $177
line 488
;487:
;488:}
LABELV $167
endproc DropPortalSource 40 12
proc countItems 12 12
line 490
;489:
;490:static int countItems(const char* itemname, qboolean exclude_no_bots) {
line 494
;491:	gentity_t	*spot;
;492:	int			count;
;493:
;494:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 495
;495:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $182
JUMPV
LABELV $181
line 497
;496:
;497:	while ((spot = G_Find (spot, FOFS(classname), itemname)) != NULL) {
line 498
;498:			if(exclude_no_bots && spot->flags & (FL_NO_BOTS|FL_NO_HUMANS) )
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $184
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 24576
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $184
line 499
;499:		continue; //Do not count no_humans or no_bots items
ADDRGP4 $182
JUMPV
LABELV $184
line 500
;500:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 501
;501:	}
LABELV $182
line 497
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $181
line 502
;502:	G_Printf("Number of %s: %i\n",itemname,count);
ADDRGP4 $186
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 503
;503:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $180
endproc countItems 12 12
proc countFfaSpawnpoints 4 8
line 506
;504:}
;505:
;506:static int countFfaSpawnpoints(void) {
line 507
;507:    return countItems("info_player_deathmatch",qtrue);
ADDRGP4 $188
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 countItems
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $187
endproc countFfaSpawnpoints 4 8
proc countDdSpawnpoints 20 8
line 510
;508:}
;509:
;510:static int countDdSpawnpoints(void) {
line 512
;511:	int mincount,tmp;
;512:	mincount = 100;
ADDRLP4 4
CNSTI4 100
ASGNI4
line 514
;513:
;514:	tmp = countItems("info_player_dd_red",qtrue);
ADDRGP4 $190
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 countItems
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 515
;515:	if(!tmp){
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $191
line 516
;516:	tmp = countFfaSpawnpoints(); //tmp==0 -> Fallback to FFA spawnpoints!
ADDRLP4 12
ADDRGP4 countFfaSpawnpoints
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 517
;517:	}
LABELV $191
line 518
;518:	if(tmp<mincount)
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $193
line 519
;519:		mincount=tmp;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
LABELV $193
line 521
;520:
;521:	tmp = countItems("info_player_dd_blue",qtrue);
ADDRGP4 $195
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 countItems
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 522
;522:	if(!tmp){
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $196
line 523
;523:	tmp = countFfaSpawnpoints(); //tmp==0 -> Fallback to FFA spawnpoints!
ADDRLP4 16
ADDRGP4 countFfaSpawnpoints
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 524
;524:	}
LABELV $196
line 525
;525:	if(tmp<mincount)
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $198
line 526
;526:		mincount=tmp;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
LABELV $198
line 528
;527:
;528:	return mincount;
ADDRLP4 4
INDIRI4
RETI4
LABELV $189
endproc countDdSpawnpoints 20 8
proc countCtfSpawnpoints 28 8
line 532
;529:
;530:}
;531:
;532:static int countCtfSpawnpoints(void) {
line 535
;533:	int mincount,tmp;
;534:
;535:	mincount=100;
ADDRLP4 4
CNSTI4 100
ASGNI4
line 537
;536:
;537:	tmp = countItems("team_CTF_redplayer",qtrue);
ADDRGP4 $201
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 countItems
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 538
;538:	if(!tmp){
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $202
line 539
;539:		tmp = countFfaSpawnpoints(); //tmp==0 -> Fallback to FFA spawnpoints!
ADDRLP4 12
ADDRGP4 countFfaSpawnpoints
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 540
;540:	}
LABELV $202
line 541
;541:	if(tmp<mincount) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $204
line 542
;542:		mincount=tmp;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 543
;543:	}
LABELV $204
line 545
;544:
;545:	tmp = countItems("team_CTF_blueplayer",qtrue);
ADDRGP4 $206
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 countItems
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 546
;546:	if(!tmp){
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $207
line 547
;547:		tmp = countFfaSpawnpoints(); //tmp==0 -> Fallback to FFA spawnpoints!
ADDRLP4 16
ADDRGP4 countFfaSpawnpoints
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 548
;548:	}
LABELV $207
line 549
;549:	if(tmp<mincount) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $209
line 550
;550:		mincount=tmp;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 551
;551:	}
LABELV $209
line 553
;552:
;553:	tmp = countItems("team_CTF_redspawn",qtrue);
ADDRGP4 $211
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 countItems
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 554
;554:	if(!tmp){
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $212
line 555
;555:		tmp = countFfaSpawnpoints(); //tmp==0 -> Fallback to FFA spawnpoints!
ADDRLP4 20
ADDRGP4 countFfaSpawnpoints
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 556
;556:	}
LABELV $212
line 557
;557:	if(tmp<mincount)
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $214
line 558
;558:		mincount=tmp;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
LABELV $214
line 560
;559:
;560:	tmp = countItems("team_CTF_bluespawn",qtrue);
ADDRGP4 $216
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 countItems
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 561
;561:	if(!tmp){
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $217
line 562
;562:		tmp = countFfaSpawnpoints(); //tmp==0 -> Fallback to FFA spawnpoints!
ADDRLP4 24
ADDRGP4 countFfaSpawnpoints
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 563
;563:	}
LABELV $217
line 564
;564:	if(tmp<mincount) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $219
line 565
;565:		mincount=tmp;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 566
;566:	}
LABELV $219
line 568
;567:
;568:	return mincount;
ADDRLP4 4
INDIRI4
RETI4
LABELV $200
endproc countCtfSpawnpoints 28 8
export MinSpawnpointCount
proc MinSpawnpointCount 8 4
line 571
;569:}
;570:
;571:int MinSpawnpointCount(void) {
line 572
;572:	if(!G_IsATeamGametype(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $222
line 573
;573:		return countFfaSpawnpoints();
ADDRLP4 4
ADDRGP4 countFfaSpawnpoints
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $221
JUMPV
LABELV $222
line 575
;574:	}
;575:	if(g_gametype.integer == GT_DOUBLE_D ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 11
NEI4 $225
line 576
;576:		return countDdSpawnpoints();
ADDRLP4 4
ADDRGP4 countDdSpawnpoints
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $221
JUMPV
LABELV $225
line 578
;577:	}
;578:	return countCtfSpawnpoints();
ADDRLP4 4
ADDRGP4 countCtfSpawnpoints
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
LABELV $221
endproc MinSpawnpointCount 8 4
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
LABELV $216
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
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $211
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
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $206
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
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $201
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
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $195
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
byte 1 100
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $190
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
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $188
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
LABELV $186
byte 1 78
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $173
byte 1 104
byte 1 105
byte 1 95
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 114
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $168
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
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 95
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $142
byte 1 80
byte 1 111
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $139
byte 1 104
byte 1 105
byte 1 95
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $134
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
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 95
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $98
byte 1 48
byte 1 0
align 1
LABELV $97
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $81
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
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 95
byte 1 115
byte 1 117
byte 1 114
byte 1 102
byte 1 97
byte 1 99
byte 1 101
byte 1 10
byte 1 0
