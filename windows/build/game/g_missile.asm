export G_BounceMissile
code
proc G_BounceMissile 40 12
file "../../../code/game/g_missile.c"
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
;23:#include "g_local.h"
;24:
;25:#define	MISSILE_PRESTEP_TIME	50
;26:
;27:/*
;28:================
;29:G_BounceMissile
;30:
;31:================
;32:*/
;33:void G_BounceMissile( gentity_t *ent, trace_t *trace )
;34:{
line 40
;35:	vec3_t	velocity;
;36:	float	dot;
;37:	int		hitTime;
;38:
;39:	// reflect the velocity on the trace plane
;40:	hitTime = level.previousTime + ( level.time - level.previousTime ) * trace->fraction;
ADDRLP4 16
ADDRGP4 level+36
INDIRI4
CVIF4 4
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+36
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 41
;41:	BG_EvaluateTrajectoryDelta( &ent->s.pos, hitTime, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 42
;42:	dot = DotProduct( velocity, trace->plane.normal );
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 43
;43:	VectorMA( velocity, -2*dot, trace->plane.normal, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 45
;44:
;45:	if ( ent->s.eFlags & EF_BOUNCE_HALF ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $68
line 46
;46:		VectorScale( ent->s.pos.trDelta, 0.65, ent->s.pos.trDelta );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTF4 1059481190
ADDRLP4 24
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTF4 1059481190
ADDRLP4 28
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTF4 1059481190
ADDRLP4 32
INDIRP4
INDIRF4
MULF4
ASGNF4
line 48
;47:		// check for stop
;48:		if ( trace->plane.normal[2] > 0.2 && VectorLength( ent->s.pos.trDelta ) < 40 ) {
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 1045220557
LEF4 $70
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 1109393408
GEF4 $70
line 49
;49:			G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 50
;50:			ent->s.time = level.time / 4;
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 4
DIVI4
ASGNI4
line 51
;51:			return;
ADDRGP4 $60
JUMPV
LABELV $70
line 53
;52:		}
;53:	}
LABELV $68
line 55
;54:
;55:	VectorAdd( ent->r.currentOrigin, trace->plane.normal, ent->r.currentOrigin);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 492
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDF4
ASGNF4
line 56
;56:	VectorCopy( ent->r.currentOrigin, ent->s.pos.trBase );
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 57
;57:	ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 58
;58:}
LABELV $60
endproc G_BounceMissile 40 12
export G_ExplodeMissile
proc G_ExplodeMissile 52 24
line 69
;59:
;60:
;61:/*
;62:================
;63:G_ExplodeMissile
;64:
;65:Explode a missile without an impact
;66:================
;67:*/
;68:void G_ExplodeMissile( gentity_t *ent )
;69:{
line 73
;70:	vec3_t		dir;
;71:	vec3_t		origin;
;72:
;73:	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 74
;74:	SnapVector( origin );
ADDRLP4 0
ADDRLP4 0
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 75
;75:	G_SetOrigin( ent, origin );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 78
;76:
;77:	// we don't have a valid direction, so just point straight up
;78:	dir[0] = dir[1] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 79
;79:	dir[2] = 1;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 81
;80:
;81:	ent->s.eType = ET_GENERAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 82
;82:	G_AddEvent( ent, EV_MISSILE_MISS, DirToByte( dir ) );
ADDRLP4 12
ARGP4
ADDRLP4 28
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 84
;83:
;84:	ent->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 87
;85:
;86:	// splash damage
;87:	if ( ent->splashDamage ) {
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CNSTI4 0
EQI4 $82
line 88
;88:		if( G_RadiusDamage( ent->r.currentOrigin, ent->parent, ent->splashDamage, ent->splashRadius, ent
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 G_RadiusDamage
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $84
line 89
;89:		                    , ent->splashMethodOfDeath ) ) {
line 90
;90:			g_entities[ent->r.ownerNum].client->accuracy_hits++;
ADDRLP4 40
CNSTI4 816
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 1120
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 91
;91:			g_entities[ent->r.ownerNum].client->accuracy[ent->s.weapon][1]++;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 816
ADDRLP4 44
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 2004
ADDP4
ADDP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 92
;92:		}
LABELV $84
line 93
;93:	}
LABELV $82
line 95
;94:
;95:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 96
;96:}
LABELV $74
endproc G_ExplodeMissile 52 24
proc ProximityMine_Explode 0 4
line 104
;97:
;98:/*
;99:================
;100:ProximityMine_Explode
;101:================
;102:*/
;103:static void ProximityMine_Explode( gentity_t *mine )
;104:{
line 105
;105:	G_ExplodeMissile( mine );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_ExplodeMissile
CALLV
pop
line 107
;106:	// if the prox mine has a trigger free it
;107:	if (mine->activator) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $89
line 108
;108:		G_FreeEntity(mine->activator);
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 109
;109:		mine->activator = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
CNSTP4 0
ASGNP4
line 110
;110:	}
LABELV $89
line 111
;111:}
LABELV $88
endproc ProximityMine_Explode 0 4
proc ProximityMine_Die 0 0
line 119
;112:
;113:/*
;114:================
;115:ProximityMine_Die
;116:================
;117:*/
;118:static void ProximityMine_Die( gentity_t *ent, gentity_t *inflictor, gentity_t *attacker, int damage, int mod )
;119:{
line 120
;120:	ent->think = ProximityMine_Explode;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ProximityMine_Explode
ASGNP4
line 121
;121:	ent->nextthink = level.time + 1;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 122
;122:}
LABELV $91
endproc ProximityMine_Die 0 0
export ProximityMine_Trigger
proc ProximityMine_Trigger 48 12
line 130
;123:
;124:/*
;125:================
;126:ProximityMine_Trigger
;127:================
;128:*/
;129:void ProximityMine_Trigger( gentity_t *trigger, gentity_t *other, trace_t *trace )
;130:{
line 134
;131:	vec3_t		v;
;132:	gentity_t	*mine;
;133:
;134:	if( !other->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $94
line 135
;135:		return;
ADDRGP4 $93
JUMPV
LABELV $94
line 139
;136:	}
;137:
;138:	// trigger is a cube, do a distance test now to act as if it's a sphere
;139:	VectorSubtract( trigger->s.pos.trBase, other->s.pos.trBase, v );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 24
ASGNI4
ADDRLP4 24
ADDRFP4 4
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
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 140
;140:	if( VectorLength( v ) > trigger->parent->splashRadius ) {
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CVIF4 4
LEF4 $98
line 141
;141:		return;
ADDRGP4 $93
JUMPV
LABELV $98
line 145
;142:	}
;143:
;144:
;145:	if (G_IsATeamGametype(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $100
line 147
;146:		// don't trigger same team mines
;147:		if (trigger->parent->s.generic1 == other->client->sess.sessionTeam) {
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
NEI4 $103
line 148
;148:			return;
ADDRGP4 $93
JUMPV
LABELV $103
line 150
;149:		}
;150:	}
LABELV $100
line 153
;151:
;152:	// ok, now check for ability to damage so we don't get triggered thru walls, closed doors, etc...
;153:	if( !CanDamage( other, trigger->s.pos.trBase ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $105
line 154
;154:		return;
ADDRGP4 $93
JUMPV
LABELV $105
line 158
;155:	}
;156:
;157:	// trigger the mine!
;158:	mine = trigger->parent;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ASGNP4
line 159
;159:	mine->s.loopSound = 0;
ADDRLP4 12
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 160
;160:	G_AddEvent( mine, EV_PROXIMITY_MINE_TRIGGER, 0 );
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 67
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 161
;161:	mine->nextthink = level.time + 500;
ADDRLP4 12
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 163
;162:
;163:	G_FreeEntity( trigger );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 164
;164:}
LABELV $93
endproc ProximityMine_Trigger 48 12
proc ProximityMine_Activate 64 12
line 172
;165:
;166:/*
;167:================
;168:ProximityMine_Activate
;169:================
;170:*/
;171:static void ProximityMine_Activate( gentity_t *ent )
;172:{
line 177
;173:	gentity_t	*trigger;
;174:	float		r;
;175:	vec3_t          v1;
;176:	gentity_t       *flag;
;177:	char            *c = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 178
;178:	qboolean        nearFlag = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 181
;179:
;180:	// find the flag
;181:	if (G_UsesTeamFlags(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $109
line 182
;182:		switch (ent->s.generic1) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 1
EQI4 $115
ADDRLP4 36
INDIRI4
CNSTI4 2
EQI4 $117
ADDRGP4 $112
JUMPV
LABELV $115
line 184
;183:			case TEAM_RED:
;184:				c = "team_CTF_redflag";
ADDRLP4 8
ADDRGP4 $116
ASGNP4
line 185
;185:				break;
ADDRGP4 $113
JUMPV
LABELV $117
line 187
;186:			case TEAM_BLUE:
;187:				c = "team_CTF_blueflag";
ADDRLP4 8
ADDRGP4 $118
ASGNP4
line 188
;188:				break;
ADDRGP4 $113
JUMPV
LABELV $112
line 190
;189:			default:
;190:				c = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 191
;191:		}
LABELV $113
line 192
;192:	}
LABELV $109
line 194
;193:
;194:	if (g_gametype.integer == GT_HARVESTER || g_gametype.integer == GT_OBELISK) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $123
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $119
LABELV $123
line 195
;195:		switch (ent->s.generic1) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 1
EQI4 $127
ADDRLP4 36
INDIRI4
CNSTI4 2
EQI4 $129
ADDRGP4 $124
JUMPV
LABELV $127
line 197
;196:		case TEAM_RED:
;197:			c = "team_redobelisk";
ADDRLP4 8
ADDRGP4 $128
ASGNP4
line 198
;198:			break;
ADDRGP4 $125
JUMPV
LABELV $129
line 200
;199:		case TEAM_BLUE:
;200:			c = "team_blueobelisk";
ADDRLP4 8
ADDRGP4 $130
ASGNP4
line 201
;201:			break;
ADDRGP4 $125
JUMPV
LABELV $124
line 203
;202:		default:
;203:			c = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 204
;204:		}
LABELV $125
line 205
;205:	}
LABELV $119
line 207
;206:
;207:	if(c) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $131
line 208
;208:		flag = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $134
JUMPV
LABELV $133
line 209
;209:		while ((flag = G_Find (flag, FOFS(classname), c)) != NULL) {
line 210
;210:			if (!(flag->flags & FL_DROPPED_ITEM))
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $136
line 211
;211:				break;
ADDRGP4 $135
JUMPV
LABELV $136
line 212
;212:		}
LABELV $134
line 209
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
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
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $133
LABELV $135
line 214
;213:
;214:		if(flag) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $138
line 215
;215:			VectorSubtract(ent->r.currentOrigin,flag->r.currentOrigin , v1);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 488
ASGNI4
ADDRLP4 20
ADDRLP4 40
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
ADDRLP4 52
CNSTI4 492
ASGNI4
ADDRLP4 20+4
ADDRLP4 40
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56
CNSTI4 496
ASGNI4
ADDRLP4 20+8
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 216
;216:			if(VectorLength(v1) < 500)
ADDRLP4 20
ARGP4
ADDRLP4 60
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 1140457472
GEF4 $142
line 217
;217:				nearFlag = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
LABELV $142
line 218
;218:		}
LABELV $138
line 219
;219:	}
LABELV $131
line 221
;220:
;221:	ent->think = ProximityMine_Explode;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ProximityMine_Explode
ASGNP4
line 222
;222:	if( nearFlag)
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $144
line 223
;223:		ent->nextthink = level.time + g_proxMineTimeout.integer/15;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_proxMineTimeout+12
INDIRI4
CNSTI4 15
DIVI4
ADDI4
ASGNI4
ADDRGP4 $145
JUMPV
LABELV $144
line 225
;224:	else
;225:		ent->nextthink = level.time + g_proxMineTimeout.integer;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_proxMineTimeout+12
INDIRI4
ADDI4
ASGNI4
LABELV $145
line 227
;226:
;227:	ent->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 228
;228:	ent->health = 1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 1
ASGNI4
line 229
;229:	ent->die = ProximityMine_Die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 ProximityMine_Die
ASGNP4
line 231
;230:
;231:	ent->s.loopSound = G_SoundIndex( "sound/weapons/proxmine/wstbtick.wav" );
ADDRGP4 $150
ARGP4
ADDRLP4 36
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 234
;232:
;233:	// build the proximity trigger
;234:	trigger = G_Spawn ();
ADDRLP4 40
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 236
;235:
;236:	trigger->classname = "proxmine_trigger";
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $151
ASGNP4
line 238
;237:
;238:	r = ent->splashRadius;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 239
;239:	VectorSet( trigger->r.mins, -r, -r, -r );
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
line 240
;240:	VectorSet( trigger->r.maxs, r, r, r );
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 456
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 242
;241:
;242:	G_SetOrigin( trigger, ent->s.pos.trBase );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 244
;243:
;244:	trigger->parent = ent;
ADDRLP4 4
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 245
;245:	trigger->r.contents = CONTENTS_TRIGGER;
ADDRLP4 4
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 246
;246:	trigger->touch = ProximityMine_Trigger;
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 ProximityMine_Trigger
ASGNP4
line 248
;247:
;248:	trap_LinkEntity (trigger);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 251
;249:
;250:	// set pointer to trigger so the entity can be freed when the mine explodes
;251:	ent->activator = trigger;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 252
;252:}
LABELV $108
endproc ProximityMine_Activate 64 12
proc ProximityMine_ExplodeOnPlayer 16 32
line 260
;253:
;254:/*
;255:================
;256:ProximityMine_ExplodeOnPlayer
;257:================
;258:*/
;259:static void ProximityMine_ExplodeOnPlayer( gentity_t *mine )
;260:{
line 263
;261:	gentity_t	*player;
;262:
;263:	player = mine->enemy;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ASGNP4
line 264
;264:	player->client->ps.eFlags &= ~EF_TICKING;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 266
;265:
;266:	if ( player->client->invulnerabilityTime > level.time ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $153
line 267
;267:		G_Damage( player, mine->parent, mine->parent, vec3_origin, mine->s.origin, 1000, DAMAGE_NO_KNOCKBACK, MOD_JUICED );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 1000
ARGI4
CNSTI4 4
ARGI4
CNSTI4 27
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 268
;268:		player->client->invulnerabilityTime = 0;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1240
ADDP4
CNSTI4 0
ASGNI4
line 269
;269:		G_TempEntity( player->client->ps.origin, EV_JUICED );
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 72
ARGI4
ADDRGP4 G_TempEntity
CALLP4
pop
line 270
;270:	}
ADDRGP4 $154
JUMPV
LABELV $153
line 271
;271:	else {
line 272
;272:		G_SetOrigin( mine, player->s.pos.trBase );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 274
;273:		// make sure the explosion gets to the client
;274:		mine->r.svFlags &= ~SVF_NOCLIENT;
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
CNSTI4 -2
BANDI4
ASGNI4
line 275
;275:		mine->splashMethodOfDeath = MOD_PROXIMITY_MINE;
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 25
ASGNI4
line 276
;276:		G_ExplodeMissile( mine );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_ExplodeMissile
CALLV
pop
line 277
;277:	}
LABELV $154
line 278
;278:}
LABELV $152
endproc ProximityMine_ExplodeOnPlayer 16 32
proc ProximityMine_Player 20 12
line 286
;279:
;280:/*
;281:================
;282:ProximityMine_Player
;283:================
;284:*/
;285:static void ProximityMine_Player( gentity_t *mine, gentity_t *player )
;286:{
line 287
;287:	if( mine->s.eFlags & EF_NODRAW ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $157
line 288
;288:		return;
ADDRGP4 $156
JUMPV
LABELV $157
line 291
;289:	}
;290:
;291:	G_AddEvent( mine, EV_PROXIMITY_MINE_STICK, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 66
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 293
;292:
;293:	if( player->s.eFlags & EF_TICKING ) {
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $159
line 294
;294:		player->activator->splashDamage += mine->splashDamage;
ADDRLP4 0
CNSTI4 744
ASGNI4
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 295
;295:		player->activator->splashRadius *= 1.50;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 748
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTF4 1069547520
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 296
;296:		mine->think = G_FreeEntity;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 297
;297:		mine->nextthink = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 298
;298:		return;
ADDRGP4 $156
JUMPV
LABELV $159
line 301
;299:	}
;300:
;301:	player->client->ps.eFlags |= EF_TICKING;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 302
;302:	player->activator = mine;
ADDRFP4 4
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 304
;303:
;304:	mine->s.eFlags |= EF_NODRAW;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 305
;305:	mine->r.svFlags |= SVF_NOCLIENT;
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
CNSTI4 1
BORI4
ASGNI4
line 306
;306:	mine->s.pos.trType = TR_LINEAR;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 307
;307:	VectorClear( mine->s.pos.trDelta );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 309
;308:
;309:	mine->enemy = player;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 310
;310:	mine->think = ProximityMine_ExplodeOnPlayer;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ProximityMine_ExplodeOnPlayer
ASGNP4
line 311
;311:	if ( player->client->invulnerabilityTime > level.time ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $162
line 312
;312:		mine->nextthink = level.time + 2 * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 313
;313:	}
ADDRGP4 $163
JUMPV
LABELV $162
line 314
;314:	else {
line 315
;315:		mine->nextthink = level.time + 10 * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 316
;316:	}
LABELV $163
line 317
;317:}
LABELV $156
endproc ProximityMine_Player 20 12
export ProximityMine_RemoveAll
proc ProximityMine_RemoveAll 8 12
line 326
;318:
;319:/*
;320: *=================
;321: *ProximityMine_RemoveAll
;322: *=================
;323: */
;324:
;325:void ProximityMine_RemoveAll()
;326:{
line 329
;327:	gentity_t	*mine;
;328:
;329:	mine = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $169
JUMPV
LABELV $168
line 331
;330:
;331:	while ((mine = G_Find (mine, FOFS(classname), "prox mine")) != NULL) {
line 332
;332:		mine->think = ProximityMine_Explode;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ProximityMine_Explode
ASGNP4
line 333
;333:		mine->nextthink = level.time + 1;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 334
;334:	}
LABELV $169
line 331
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $171
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
NEU4 $168
line 335
;335:}
LABELV $167
endproc ProximityMine_RemoveAll 8 12
export G_MissileImpact
proc G_MissileImpact 96 32
line 343
;336:
;337:/*
;338:================
;339:G_MissileImpact
;340:================
;341:*/
;342:void G_MissileImpact( gentity_t *ent, trace_t *trace )
;343:{
line 345
;344:	gentity_t		*other;
;345:	qboolean		hitClient = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 348
;346:	vec3_t			forward, impactpoint, bouncedir;
;347:	int				eFlags;
;348:	other = &g_entities[trace->entityNum];
ADDRLP4 0
CNSTI4 816
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 351
;349:
;350:	// check for bounce
;351:	if ( !other->takedamage &&
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $174
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 48
BANDI4
ADDRLP4 48
INDIRI4
EQI4 $174
line 352
;352:	        ( ent->s.eFlags & ( EF_BOUNCE | EF_BOUNCE_HALF ) ) ) {
line 353
;353:		G_BounceMissile( ent, trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_BounceMissile
CALLV
pop
line 354
;354:		G_AddEvent( ent, EV_GRENADE_BOUNCE, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 44
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 355
;355:		return;
ADDRGP4 $173
JUMPV
LABELV $174
line 358
;356:	}
;357:
;358:	if ( other->takedamage ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $176
line 359
;359:		if ( ent->s.weapon != WP_PROX_LAUNCHER ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
EQI4 $178
line 360
;360:			if ( other->client && other->client->invulnerabilityTime > level.time ) {
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $180
ADDRLP4 52
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $180
line 363
;361:
;362:				//
;363:				VectorCopy( ent->s.pos.trDelta, forward );
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 364
;364:				VectorNormalize( forward );
ADDRLP4 8
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 365
;365:				if (G_InvulnerabilityEffect( other, forward, ent->s.pos.trBase, impactpoint, bouncedir )) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 56
ADDRGP4 G_InvulnerabilityEffect
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $183
line 366
;366:					VectorCopy( bouncedir, trace->plane.normal );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 20
INDIRB
ASGNB 12
line 367
;367:					eFlags = ent->s.eFlags & EF_BOUNCE_HALF;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 32
BANDI4
ASGNI4
line 368
;368:					ent->s.eFlags &= ~EF_BOUNCE_HALF;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 369
;369:					G_BounceMissile( ent, trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_BounceMissile
CALLV
pop
line 370
;370:					ent->s.eFlags |= eFlags;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
ADDRLP4 44
INDIRI4
BORI4
ASGNI4
line 371
;371:				}
LABELV $183
line 372
;372:				ent->target_ent = other;
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 373
;373:				return;
ADDRGP4 $173
JUMPV
LABELV $180
line 375
;374:			}
;375:		}
LABELV $178
line 376
;376:	}
LABELV $176
line 378
;377:	// impact damage
;378:	if (other->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $185
line 380
;379:		// FIXME: wrong damage direction?
;380:		if ( ent->damage ) {
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $187
line 383
;381:			vec3_t	velocity;
;382:
;383:			if( LogAccuracyHit( other, &g_entities[ent->r.ownerNum] ) ) {
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 816
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $189
line 384
;384:				g_entities[ent->r.ownerNum].client->accuracy_hits++;
ADDRLP4 68
CNSTI4 816
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 1120
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
line 385
;385:				hitClient = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 386
;386:				g_entities[ent->r.ownerNum].client->accuracy[ent->s.weapon][1]++;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 72
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 816
ADDRLP4 72
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 2004
ADDP4
ADDP4
CNSTI4 4
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
line 387
;387:			}
LABELV $189
line 388
;388:			BG_EvaluateTrajectoryDelta( &ent->s.pos, level.time, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 389
;389:			if ( VectorLength( velocity ) == 0 ) {
ADDRLP4 52
ARGP4
ADDRLP4 68
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 68
INDIRF4
CNSTF4 0
NEF4 $194
line 390
;390:				velocity[2] = 1;	// stepped on a grenade
ADDRLP4 52+8
CNSTF4 1065353216
ASGNF4
line 391
;391:			}
LABELV $194
line 392
;392:			G_Damage (other, ent, &g_entities[ent->r.ownerNum], velocity,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTI4 816
ADDRLP4 72
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 752
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 395
;393:			          ent->s.origin, ent->damage,
;394:			          0, ent->methodOfDeath);
;395:		}
LABELV $187
line 396
;396:	}
LABELV $185
line 398
;397:
;398:	if( ent->s.weapon == WP_PROX_LAUNCHER ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
NEI4 $197
line 399
;399:		if( ent->s.pos.trType != TR_GRAVITY ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 5
EQI4 $199
line 400
;400:			return;
ADDRGP4 $173
JUMPV
LABELV $199
line 404
;401:		}
;402:
;403:		// if it's a player, stick it on to them (flag them and remove this entity)
;404:		if( other->s.eType == ET_PLAYER && other->health > 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $201
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $201
line 405
;405:			ProximityMine_Player( ent, other );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ProximityMine_Player
CALLV
pop
line 406
;406:			return;
ADDRGP4 $173
JUMPV
LABELV $201
line 409
;407:		}
;408:
;409:		SnapVectorTowards( trace->endpos, ent->s.pos.trBase );
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 410
;410:		G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 411
;411:		ent->s.pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 412
;412:		VectorClear( ent->s.pos.trDelta );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 56
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 56
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 56
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 60
INDIRF4
ASGNF4
line 414
;413:
;414:		G_AddEvent( ent, EV_PROXIMITY_MINE_STICK, trace->surfaceFlags );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 66
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 416
;415:
;416:		ent->think = ProximityMine_Activate;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ProximityMine_Activate
ASGNP4
line 417
;417:		ent->nextthink = level.time + 2000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 419
;418:
;419:		vectoangles( trace->plane.normal, ent->s.angles );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 420
;420:		ent->s.angles[0] += 90;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 423
;421:
;422:		// link the prox mine to the other entity
;423:		ent->enemy = other;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 424
;424:		ent->die = ProximityMine_Die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 ProximityMine_Die
ASGNP4
line 425
;425:		VectorCopy(trace->plane.normal, ent->movedir);
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 426
;426:		VectorSet(ent->r.mins, -4, -4, -4);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3229614080
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3229614080
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3229614080
ASGNF4
line 427
;427:		VectorSet(ent->r.maxs, 4, 4, 4);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1082130432
ASGNF4
line 428
;428:		trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 430
;429:
;430:		return;
ADDRGP4 $173
JUMPV
LABELV $197
line 433
;431:	}
;432:
;433:	if (strequals(ent->classname, "hook")) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $206
ARGP4
ADDRLP4 52
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $204
line 437
;434:		gentity_t *nent;
;435:		vec3_t v;
;436:
;437:		nent = G_Spawn();
ADDRLP4 72
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 56
ADDRLP4 72
INDIRP4
ASGNP4
line 438
;438:		if ( other->takedamage && other->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $207
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $207
line 440
;439:
;440:			G_AddEvent( nent, EV_MISSILE_HIT, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 80
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 56
INDIRP4
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 441
;441:			nent->s.otherEntityNum = other->s.number;
ADDRLP4 56
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 443
;442:
;443:			ent->enemy = other;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 445
;444:
;445:			v[0] = other->r.currentOrigin[0] + (other->r.mins[0] + other->r.maxs[0]) * 0.5;
ADDRLP4 60
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 446
;446:			v[1] = other->r.currentOrigin[1] + (other->r.mins[1] + other->r.maxs[1]) * 0.5;
ADDRLP4 60+4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 447
;447:			v[2] = other->r.currentOrigin[2] + (other->r.mins[2] + other->r.maxs[2]) * 0.5;
ADDRLP4 60+8
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 449
;448:
;449:			SnapVectorTowards( v, ent->s.pos.trBase );	// save net bandwidth
ADDRLP4 60
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 450
;450:		}
ADDRGP4 $208
JUMPV
LABELV $207
line 451
;451:		else {
line 452
;452:			VectorCopy(trace->endpos, v);
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 453
;453:			G_AddEvent( nent, EV_MISSILE_MISS, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 80
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 56
INDIRP4
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 454
;454:			ent->enemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
CNSTP4 0
ASGNP4
line 455
;455:		}
LABELV $208
line 457
;456:
;457:		SnapVectorTowards( v, ent->s.pos.trBase );	// save net bandwidth
ADDRLP4 60
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 459
;458:
;459:		nent->freeAfterEvent = qtrue;
ADDRLP4 56
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 461
;460:		// change over to a normal entity right at the point of impact
;461:		nent->s.eType = ET_GENERAL;
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 462
;462:		ent->s.eType = ET_GRAPPLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 11
ASGNI4
line 464
;463:
;464:		G_SetOrigin( ent, v );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 465
;465:		G_SetOrigin( nent, v );
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 467
;466:
;467:		ent->think = Weapon_HookThink;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Weapon_HookThink
ASGNP4
line 468
;468:		ent->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 470
;469:
;470:		ent->parent->client->ps.pm_flags |= PMF_GRAPPLE_PULL;
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 471
;471:		VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 473
;472:
;473:		trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 474
;474:		trap_LinkEntity( nent );
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 476
;475:
;476:		return;
ADDRGP4 $173
JUMPV
LABELV $204
line 482
;477:	}
;478:
;479:	// is it cheaper in bandwidth to just remove this ent and create a new
;480:	// one, rather than changing the missile into the explosion?
;481:
;482:	if ( other->takedamage && other->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $212
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $212
line 483
;483:		G_AddEvent( ent, EV_MISSILE_HIT, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 60
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 484
;484:		ent->s.otherEntityNum = other->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 485
;485:	}
ADDRGP4 $213
JUMPV
LABELV $212
line 486
;486:	else if( trace->surfaceFlags & SURF_METALSTEPS ) {
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $214
line 487
;487:		G_AddEvent( ent, EV_MISSILE_MISS_METAL, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 60
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 52
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 488
;488:	}
ADDRGP4 $215
JUMPV
LABELV $214
line 489
;489:	else {
line 490
;490:		G_AddEvent( ent, EV_MISSILE_MISS, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 60
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 491
;491:	}
LABELV $215
LABELV $213
line 493
;492:
;493:	ent->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 496
;494:
;495:	// change over to a normal entity right at the point of impact
;496:	ent->s.eType = ET_GENERAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 498
;497:
;498:	SnapVectorTowards( trace->endpos, ent->s.pos.trBase );	// save net bandwidth
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 500
;499:
;500:	G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 503
;501:
;502:	// splash damage (doesn't apply to person directly hit)
;503:	if ( ent->splashDamage ) {
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CNSTI4 0
EQI4 $216
line 504
;504:		if( G_RadiusDamage( trace->endpos, ent->parent, ent->splashDamage, ent->splashRadius,
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 G_RadiusDamage
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $218
line 505
;505:		                    other, ent->splashMethodOfDeath ) ) {
line 506
;506:			if( !hitClient ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $220
line 507
;507:				g_entities[ent->r.ownerNum].client->accuracy_hits++;
ADDRLP4 68
CNSTI4 816
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 1120
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
line 508
;508:				g_entities[ent->r.ownerNum].client->accuracy[ent->s.weapon][1]++;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 72
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 816
ADDRLP4 72
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 2004
ADDP4
ADDP4
CNSTI4 4
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
line 509
;509:			}
LABELV $220
line 510
;510:		}
LABELV $218
line 511
;511:	}
LABELV $216
line 513
;512:
;513:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 514
;514:}
LABELV $173
endproc G_MissileImpact 96 32
export G_RunMissile
proc G_RunMissile 100 28
line 522
;515:
;516:/*
;517:================
;518:G_RunMissile
;519:================
;520:*/
;521:void G_RunMissile( gentity_t *ent )
;522:{
line 528
;523:	vec3_t		origin;
;524:	trace_t		tr;
;525:	int			passent;
;526:
;527:	// get current position
;528:	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 60
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 531
;529:
;530:	// if this missile bounced off an invulnerability sphere
;531:	if ( ent->target_ent ) {
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $226
line 532
;532:		passent = ent->target_ent->s.number;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
INDIRI4
ASGNI4
line 533
;533:	}
ADDRGP4 $227
JUMPV
LABELV $226
line 535
;534:	// prox mines that left the owner bbox will attach to anything, even the owner
;535:	else if (ent->s.weapon == WP_PROX_LAUNCHER && ent->count) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
NEI4 $228
ADDRLP4 72
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $228
line 536
;536:		passent = ENTITYNUM_NONE;
ADDRLP4 56
CNSTI4 1023
ASGNI4
line 537
;537:	}
ADDRGP4 $229
JUMPV
LABELV $228
line 538
;538:	else {
line 540
;539:		// ignore interactions with the missile owner
;540:		passent = ent->r.ownerNum;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 541
;541:	}
LABELV $229
LABELV $227
line 543
;542:	// trace a line from the previous position to the current position
;543:	trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, passent, ent->clipmask );
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 545
;544:
;545:	if ( tr.startsolid || tr.allsolid ) {
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRLP4 0+4
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $233
ADDRLP4 0
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $230
LABELV $233
line 547
;546:		// make sure the tr.entityNum is set to the entity we're stuck in
;547:		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, ent->r.currentOrigin, passent, ent->clipmask );
ADDRLP4 0
ARGP4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
ADDRLP4 84
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 84
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 548
;548:		tr.fraction = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 549
;549:	}
ADDRGP4 $231
JUMPV
LABELV $230
line 550
;550:	else {
line 551
;551:		VectorCopy( tr.endpos, ent->r.currentOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 552
;552:	}
LABELV $231
line 554
;553:
;554:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 556
;555:
;556:	if ( tr.fraction != 1 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $236
line 558
;557:		// never explode or bounce on sky
;558:		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 0+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $239
line 560
;559:			// If grapple, reset owner
;560:			if (ent->parent && ent->parent->client && ent->parent->client->hook == ent) {
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
ADDRLP4 84
INDIRP4
CNSTI4 600
ADDP4
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
EQU4 $242
ADDRLP4 96
ADDRLP4 88
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CVPU4 4
ADDRLP4 92
INDIRU4
EQU4 $242
ADDRLP4 96
INDIRP4
CNSTI4 1164
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 84
INDIRP4
CVPU4 4
NEU4 $242
line 561
;561:				ent->parent->client->hook = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1164
ADDP4
CNSTP4 0
ASGNP4
line 562
;562:			}
LABELV $242
line 563
;563:			G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 564
;564:			return;
ADDRGP4 $224
JUMPV
LABELV $239
line 566
;565:		}
;566:		G_MissileImpact( ent, &tr );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_MissileImpact
CALLV
pop
line 567
;567:		if ( ent->s.eType != ET_MISSILE ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
EQI4 $244
line 568
;568:			return;		// exploded
ADDRGP4 $224
JUMPV
LABELV $244
line 570
;569:		}
;570:	}
LABELV $236
line 572
;571:	// if the prox mine wasn't yet outside the player body
;572:	if (ent->s.weapon == WP_PROX_LAUNCHER && !ent->count) {
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
NEI4 $246
ADDRLP4 84
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
NEI4 $246
line 574
;573:		// check if the prox mine is outside the owner bbox
;574:		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, ent->r.currentOrigin, ENTITYNUM_NONE, ent->clipmask );
ADDRLP4 0
ARGP4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
CNSTI4 1023
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 575
;575:		if (!tr.startsolid || tr.entityNum != ent->r.ownerNum) {
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $252
ADDRLP4 0+52
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
EQI4 $248
LABELV $252
line 576
;576:			ent->count = 1;
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 577
;577:		}
LABELV $248
line 578
;578:	}
LABELV $246
line 580
;579:	// check think function after bouncing
;580:	G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 581
;581:}
LABELV $224
endproc G_RunMissile 100 28
export fire_plasma
proc fire_plasma 20 4
line 593
;582:
;583:
;584://=============================================================================
;585:
;586:/*
;587:=================
;588:fire_plasma
;589:
;590:=================
;591:*/
;592:gentity_t *fire_plasma (gentity_t *self, vec3_t start, vec3_t dir)
;593:{
line 596
;594:	gentity_t	*bolt;
;595:
;596:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 598
;597:
;598:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 599
;599:	bolt->classname = "plasma";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $254
ASGNP4
line 600
;600:	bolt->nextthink = level.time + g_pgtimeout.integer;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_pgtimeout+12
INDIRI4
ADDI4
ASGNI4
line 601
;601:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 602
;602:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 603
;603:	if (g_pgbounce.integer == 1)
ADDRGP4 g_pgbounce+12
INDIRI4
CNSTI4 1
NEI4 $257
line 604
;604:	bolt->s.eFlags = EF_BOUNCE_HALF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 32
ASGNI4
ADDRGP4 $258
JUMPV
LABELV $257
line 606
;605:	else
;606:	if (g_pgbounce.integer == 2)
ADDRGP4 g_pgbounce+12
INDIRI4
CNSTI4 2
NEI4 $260
line 607
;607:	bolt->s.eFlags = EF_BOUNCE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 16
ASGNI4
ADDRGP4 $261
JUMPV
LABELV $260
line 609
;608:	else
;609:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
LABELV $261
LABELV $258
line 610
;610:	bolt->s.weapon = WP_PLASMAGUN;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 8
ASGNI4
line 611
;611:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 614
;612://unlagged - projectile nudge
;613:	// we'll need this for nudging projectiles later
;614:	bolt->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 616
;615://unlagged - projectile nudge
;616:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 617
;617:	bolt->damage = g_pgdamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_pgdamage+12
INDIRI4
ASGNI4
line 618
;618:	bolt->splashDamage = g_pgsdamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_pgsdamage+12
INDIRI4
ASGNI4
line 619
;619:	bolt->splashRadius = g_pgsradius.integer;
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 g_pgsradius+12
INDIRI4
ASGNI4
line 620
;620:	bolt->methodOfDeath = MOD_PLASMA;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 8
ASGNI4
line 621
;621:	bolt->splashMethodOfDeath = MOD_PLASMA_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 9
ASGNI4
line 622
;622:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 623
;623:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 624
;624:	if (g_pggravity.integer == 1)
ADDRGP4 g_pggravity+12
INDIRI4
CNSTI4 1
NEI4 $266
line 625
;625:	bolt->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
ADDRGP4 $267
JUMPV
LABELV $266
line 627
;626:	else
;627:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
LABELV $267
line 628
;628:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 629
;629:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 630
;630:	VectorScale( dir, g_pgspeed.integer, bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 g_pgspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_pgspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_pgspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 631
;631:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 36
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
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 633
;632:
;633:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 635
;634:
;635:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $253
endproc fire_plasma 20 4
export fire_grenade
proc fire_grenade 20 4
line 647
;636:}
;637:
;638://=============================================================================
;639:
;640:
;641:/*
;642:=================
;643:fire_grenade
;644:=================
;645:*/
;646:gentity_t *fire_grenade (gentity_t *self, vec3_t start, vec3_t dir)
;647:{
line 650
;648:	gentity_t	*bolt;
;649:
;650:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 652
;651:
;652:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 653
;653:	bolt->classname = "grenade";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $274
ASGNP4
line 654
;654:	bolt->nextthink = level.time + g_gltimeout.integer;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_gltimeout+12
INDIRI4
ADDI4
ASGNI4
line 655
;655:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 656
;656:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 657
;657:	if (g_glbounce.integer == 1)
ADDRGP4 g_glbounce+12
INDIRI4
CNSTI4 1
NEI4 $277
line 658
;658:	bolt->s.eFlags = EF_BOUNCE_HALF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 32
ASGNI4
ADDRGP4 $278
JUMPV
LABELV $277
line 660
;659:	else
;660:	if (g_glbounce.integer == 2)
ADDRGP4 g_glbounce+12
INDIRI4
CNSTI4 2
NEI4 $280
line 661
;661:	bolt->s.eFlags = EF_BOUNCE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 16
ASGNI4
ADDRGP4 $281
JUMPV
LABELV $280
line 663
;662:	else
;663:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
LABELV $281
LABELV $278
line 664
;664:	bolt->s.weapon = WP_GRENADE_LAUNCHER;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 4
ASGNI4
line 665
;665:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 668
;666://unlagged - projectile nudge
;667:	// we'll need this for nudging projectiles later
;668:	bolt->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 670
;669://unlagged - projectile nudge
;670:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 671
;671:	bolt->damage = g_gldamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_gldamage+12
INDIRI4
ASGNI4
line 672
;672:	bolt->splashDamage = g_glsdamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_glsdamage+12
INDIRI4
ASGNI4
line 673
;673:	bolt->splashRadius = g_glsradius.integer;
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 g_glsradius+12
INDIRI4
ASGNI4
line 674
;674:	bolt->methodOfDeath = MOD_GRENADE;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 4
ASGNI4
line 675
;675:	bolt->splashMethodOfDeath = MOD_GRENADE_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 5
ASGNI4
line 676
;676:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 677
;677:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 678
;678:	if (g_glgravity.integer == 1)
ADDRGP4 g_glgravity+12
INDIRI4
CNSTI4 1
NEI4 $286
line 679
;679:	bolt->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
ADDRGP4 $287
JUMPV
LABELV $286
line 681
;680:	else
;681:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
LABELV $287
line 682
;682:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 683
;683:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 684
;684:	VectorScale( dir, g_glspeed.integer, bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 g_glspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_glspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_glspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 685
;685:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 36
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
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 687
;686:
;687:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 689
;688:
;689:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $273
endproc fire_grenade 20 4
export fire_bfg
proc fire_bfg 20 4
line 701
;690:}
;691:
;692://=============================================================================
;693:
;694:
;695:/*
;696:=================
;697:fire_bfg
;698:=================
;699:*/
;700:gentity_t *fire_bfg (gentity_t *self, vec3_t start, vec3_t dir)
;701:{
line 704
;702:	gentity_t	*bolt;
;703:
;704:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 706
;705:
;706:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 707
;707:	bolt->classname = "bfg";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $294
ASGNP4
line 708
;708:	bolt->nextthink = level.time + g_bfgtimeout.integer;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_bfgtimeout+12
INDIRI4
ADDI4
ASGNI4
line 709
;709:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 710
;710:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 711
;711:	if (g_bfgbounce.integer == 1)
ADDRGP4 g_bfgbounce+12
INDIRI4
CNSTI4 1
NEI4 $297
line 712
;712:	bolt->s.eFlags = EF_BOUNCE_HALF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 32
ASGNI4
ADDRGP4 $298
JUMPV
LABELV $297
line 714
;713:	else
;714:	if (g_bfgbounce.integer == 2)
ADDRGP4 g_bfgbounce+12
INDIRI4
CNSTI4 2
NEI4 $300
line 715
;715:	bolt->s.eFlags = EF_BOUNCE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 16
ASGNI4
ADDRGP4 $301
JUMPV
LABELV $300
line 717
;716:	else
;717:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
LABELV $301
LABELV $298
line 718
;718:	bolt->s.weapon = WP_BFG;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 9
ASGNI4
line 719
;719:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 722
;720://unlagged - projectile nudge
;721:	// we'll need this for nudging projectiles later
;722:	bolt->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 724
;723://unlagged - projectile nudge
;724:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 725
;725:	bolt->damage = g_bfgdamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_bfgdamage+12
INDIRI4
ASGNI4
line 726
;726:	bolt->splashDamage = g_bfgsdamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_bfgsdamage+12
INDIRI4
ASGNI4
line 727
;727:	bolt->splashRadius = g_bfgsradius.integer;
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 g_bfgsradius+12
INDIRI4
ASGNI4
line 728
;728:	bolt->methodOfDeath = MOD_BFG;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 12
ASGNI4
line 729
;729:	bolt->splashMethodOfDeath = MOD_BFG_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 13
ASGNI4
line 730
;730:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 731
;731:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 732
;732:	if (g_bfggravity.integer == 1)
ADDRGP4 g_bfggravity+12
INDIRI4
CNSTI4 1
NEI4 $306
line 733
;733:	bolt->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
ADDRGP4 $307
JUMPV
LABELV $306
line 735
;734:	else
;735:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
LABELV $307
line 736
;736:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 737
;737:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 738
;738:	VectorScale( dir, g_bfgspeed.integer, bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 g_bfgspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_bfgspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_bfgspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 739
;739:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 36
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
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 740
;740:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 742
;741:
;742:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $293
endproc fire_bfg 20 4
export fire_rocket
proc fire_rocket 20 4
line 754
;743:}
;744:
;745://=============================================================================
;746:
;747:
;748:/*
;749:=================
;750:fire_rocket
;751:=================
;752:*/
;753:gentity_t *fire_rocket (gentity_t *self, vec3_t start, vec3_t dir)
;754:{
line 757
;755:	gentity_t	*bolt;
;756:
;757:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 759
;758:
;759:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 760
;760:	bolt->classname = "rocket";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $314
ASGNP4
line 761
;761:	bolt->nextthink = level.time + g_rltimeout.integer;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_rltimeout+12
INDIRI4
ADDI4
ASGNI4
line 762
;762:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 763
;763:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 764
;764:	if (g_rlbounce.integer == 1)
ADDRGP4 g_rlbounce+12
INDIRI4
CNSTI4 1
NEI4 $317
line 765
;765:	bolt->s.eFlags = EF_BOUNCE_HALF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 32
ASGNI4
ADDRGP4 $318
JUMPV
LABELV $317
line 767
;766:	else
;767:	if (g_rlbounce.integer == 2)
ADDRGP4 g_rlbounce+12
INDIRI4
CNSTI4 2
NEI4 $320
line 768
;768:	bolt->s.eFlags = EF_BOUNCE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 16
ASGNI4
ADDRGP4 $321
JUMPV
LABELV $320
line 770
;769:	else
;770:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
LABELV $321
LABELV $318
line 771
;771:	bolt->s.weapon = WP_ROCKET_LAUNCHER;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 5
ASGNI4
line 772
;772:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 775
;773://unlagged - projectile nudge
;774:	// we'll need this for nudging projectiles later
;775:	bolt->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 777
;776://unlagged - projectile nudge
;777:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 778
;778:	bolt->damage = g_rldamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_rldamage+12
INDIRI4
ASGNI4
line 779
;779:	bolt->splashDamage = g_rlsdamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_rlsdamage+12
INDIRI4
ASGNI4
line 780
;780:	bolt->splashRadius = g_rlsradius.integer;
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 g_rlsradius+12
INDIRI4
ASGNI4
line 781
;781:	bolt->methodOfDeath = MOD_ROCKET;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 6
ASGNI4
line 782
;782:	bolt->splashMethodOfDeath = MOD_ROCKET_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 7
ASGNI4
line 783
;783:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 784
;784:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 785
;785:	if (g_rlgravity.integer == 1)
ADDRGP4 g_rlgravity+12
INDIRI4
CNSTI4 1
NEI4 $326
line 786
;786:	bolt->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
ADDRGP4 $327
JUMPV
LABELV $326
line 788
;787:	else
;788:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
LABELV $327
line 789
;789:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 790
;790:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 791
;791:	VectorScale( dir, g_rlspeed.integer, bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 g_rlspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_rlspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_rlspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 792
;792:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 36
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
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 793
;793:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 795
;794:
;795:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $313
endproc fire_rocket 20 4
export fire_grapple
proc fire_grapple 24 4
line 804
;796:}
;797:
;798:/*
;799:=================
;800:fire_grapple
;801:=================
;802:*/
;803:gentity_t *fire_grapple (gentity_t *self, vec3_t start, vec3_t dir)
;804:{
line 810
;805:	gentity_t	*hook;
;806://unlagged - grapple
;807:	int hooktime;
;808://unlagged - grapple
;809:
;810:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 812
;811:
;812:	hook = G_Spawn();
ADDRLP4 8
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 813
;813:	hook->classname = "hook";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $206
ASGNP4
line 814
;814:	hook->nextthink = level.time + g_ghtimeout.integer;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_ghtimeout+12
INDIRI4
ADDI4
ASGNI4
line 815
;815:	hook->think = Weapon_HookFree;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Weapon_HookFree
ASGNP4
line 816
;816:	hook->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 817
;817:	hook->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 818
;818:	hook->s.weapon = WP_GRAPPLING_HOOK;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 10
ASGNI4
line 819
;819:	hook->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 820
;820:	hook->methodOfDeath = MOD_GRAPPLE;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 28
ASGNI4
line 821
;821:	hook->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 822
;822:	hook->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 823
;823:	hook->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 827
;824:
;825://unlagged - grapple
;826:	// we might want this later
;827:	hook->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 832
;828:
;829:	// setting the projectile base time back makes the hook's first
;830:	// step larger
;831:
;832:	if ( self->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $336
line 833
;833:		hooktime = self->client->pers.cmd.serverTime + 50;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 50
ADDI4
ASGNI4
line 834
;834:	}
ADDRGP4 $337
JUMPV
LABELV $336
line 835
;835:	else {
line 836
;836:		hooktime = level.time - MISSILE_PRESTEP_TIME;
ADDRLP4 4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 837
;837:	}
LABELV $337
line 839
;838:
;839:	hook->s.pos.trTime = hooktime;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 842
;840://unlagged - grapple
;841:
;842:	hook->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 846
;843://unlagged - grapple
;844:	//hook->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
;845://unlagged - grapple
;846:	hook->s.otherEntityNum = self->s.number; // use to match beam in client
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 847
;847:	VectorCopy( start, hook->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 848
;848:	VectorScale( dir, g_ghspeed.integer, hook->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 g_ghspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_ghspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_ghspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 849
;849:	SnapVector( hook->s.pos.trDelta );			// save net bandwidth
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 850
;850:	VectorCopy (start, hook->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 852
;851:
;852:	if(self->client)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $342
line 853
;853:		self->client->hook = hook;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1164
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $342
line 855
;854:
;855:	return hook;
ADDRLP4 0
INDIRP4
RETP4
LABELV $333
endproc fire_grapple 24 4
export fire_nail
proc fire_nail 120 4
line 866
;856:}
;857:
;858:/*
;859:=================
;860:fire_nail
;861:=================
;862:*/
;863:#define NAILGUN_SPREAD	g_ngspread.integer
;864:
;865:gentity_t *fire_nail( gentity_t *self, vec3_t start, vec3_t forward, vec3_t right, vec3_t up )
;866:{
line 872
;867:	gentity_t	*bolt;
;868:	vec3_t		dir;
;869:	vec3_t		end;
;870:	float		r, u, scale;
;871:
;872:	bolt = G_Spawn();
ADDRLP4 40
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 873
;873:	bolt->classname = "nail";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $345
ASGNP4
line 874
;874:	bolt->nextthink = level.time + g_ngtimeout.integer;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_ngtimeout+12
INDIRI4
ADDI4
ASGNI4
line 875
;875:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 876
;876:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 877
;877:	if (g_ngbounce.integer == 1)
ADDRGP4 g_ngbounce+12
INDIRI4
CNSTI4 1
NEI4 $348
line 878
;878:	bolt->s.eFlags = EF_BOUNCE_HALF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 32
ASGNI4
ADDRGP4 $349
JUMPV
LABELV $348
line 880
;879:	else
;880:	if (g_ngbounce.integer == 2)
ADDRGP4 g_ngbounce+12
INDIRI4
CNSTI4 2
NEI4 $351
line 881
;881:	bolt->s.eFlags = EF_BOUNCE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 16
ASGNI4
ADDRGP4 $352
JUMPV
LABELV $351
line 883
;882:	else
;883:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
LABELV $352
LABELV $349
line 884
;884:	bolt->s.weapon = WP_NAILGUN;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 11
ASGNI4
line 885
;885:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 888
;886://unlagged - projectile nudge
;887:	// we'll need this for nudging projectiles later
;888:	bolt->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 890
;889://unlagged - projectile nudge
;890:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 891
;891:	bolt->damage = g_ngdamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_ngdamage+12
INDIRI4
ASGNI4
line 892
;892:	bolt->methodOfDeath = MOD_NAIL;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 23
ASGNI4
line 893
;893:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 894
;894:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 895
;895:	if (g_nggravity.integer == 1)
ADDRGP4 g_nggravity+12
INDIRI4
CNSTI4 1
NEI4 $355
line 896
;896:	bolt->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
ADDRGP4 $356
JUMPV
LABELV $355
line 898
;897:	else
;898:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
LABELV $356
line 899
;899:	bolt->s.pos.trTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 900
;900:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 902
;901:
;902:	r = random() * M_PI * 2.0f;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 28
CNSTF4 1073741824
CNSTF4 1078530011
ADDRLP4 44
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
MULF4
ASGNF4
line 903
;903:	u = sin(r) * crandom() * NAILGUN_SPREAD * 16;
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 32
CNSTF4 1098907648
ADDRLP4 48
INDIRF4
CNSTF4 1073741824
ADDRLP4 52
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
ADDRGP4 g_ngspread+12
INDIRI4
CVIF4 4
MULF4
MULF4
ASGNF4
line 904
;904:	r = cos(r) * crandom() * NAILGUN_SPREAD * 16;
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 28
CNSTF4 1098907648
ADDRLP4 56
INDIRF4
CNSTF4 1073741824
ADDRLP4 60
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
ADDRGP4 g_ngspread+12
INDIRI4
CVIF4 4
MULF4
MULF4
ASGNF4
line 905
;905:	VectorMA( start, 8192 * 16, forward, end);
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 68
CNSTF4 1207959552
ASGNF4
ADDRLP4 72
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
CNSTI4 4
ASGNI4
ADDRLP4 4+4
ADDRLP4 64
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 80
CNSTI4 8
ASGNI4
ADDRLP4 4+8
ADDRFP4 4
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
CNSTF4 1207959552
ADDRFP4 8
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 906
;906:	VectorMA (end, r, right, end);
ADDRLP4 84
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
line 907
;907:	VectorMA (end, u, up, end);
ADDRLP4 92
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDF4
ASGNF4
line 908
;908:	VectorSubtract( end, start, dir );
ADDRLP4 100
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 4
INDIRF4
ADDRLP4 100
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 4+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 909
;909:	VectorNormalize( dir );
ADDRLP4 16
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 911
;910:
;911:	scale = g_ngspeed.integer + random() * 1800;
ADDRLP4 104
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 36
ADDRGP4 g_ngspeed+12
INDIRI4
CVIF4 4
CNSTF4 1155596288
ADDRLP4 104
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 912
;912:	VectorScale( dir, scale, bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 16
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16+4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 16+8
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 913
;913:	SnapVector( bolt->s.pos.trDelta );
ADDRLP4 108
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 116
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 915
;914:
;915:	VectorCopy( start, bolt->r.currentOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 917
;916:
;917:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $344
endproc fire_nail 120 4
export fire_prox
proc fire_prox 20 4
line 927
;918:}
;919:
;920:
;921:/*
;922:=================
;923:fire_prox
;924:=================
;925:*/
;926:gentity_t *fire_prox( gentity_t *self, vec3_t start, vec3_t dir )
;927:{
line 930
;928:	gentity_t	*bolt;
;929:
;930:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 932
;931:
;932:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 933
;933:	bolt->classname = "prox mine";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $171
ASGNP4
line 934
;934:	bolt->nextthink = level.time + 3000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 935
;935:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 936
;936:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 937
;937:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 938
;938:	bolt->s.weapon = WP_PROX_LAUNCHER;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 12
ASGNI4
line 939
;939:	bolt->s.eFlags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 940
;940:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 943
;941://unlagged - projectile nudge
;942:	// we'll need this for nudging projectiles later
;943:	bolt->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 945
;944://unlagged - projectile nudge
;945:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 946
;946:	bolt->damage = g_pldamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_pldamage+12
INDIRI4
ASGNI4
line 947
;947:	bolt->splashDamage = g_plsdamage.integer;
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_plsdamage+12
INDIRI4
ASGNI4
line 948
;948:	bolt->splashRadius = g_plsradius.integer;
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 g_plsradius+12
INDIRI4
ASGNI4
line 949
;949:	bolt->methodOfDeath = MOD_PROXIMITY_MINE;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 25
ASGNI4
line 950
;950:	bolt->splashMethodOfDeath = MOD_PROXIMITY_MINE;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 25
ASGNI4
line 951
;951:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 952
;952:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 955
;953:	// count is used to check if the prox mine left the player bbox
;954:	// if count == 1 then the prox mine left the player bbox and can attack to it
;955:	bolt->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 958
;956:
;957:	//FIXME: we prolly wanna abuse another field
;958:	bolt->s.generic1 = self->client->sess.sessionTeam;
ADDRLP4 0
INDIRP4
CNSTI4 204
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
line 959
;959:	if (g_plgravity.integer == 1)
ADDRGP4 g_plgravity+12
INDIRI4
CNSTI4 1
NEI4 $383
line 960
;960:	bolt->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
ADDRGP4 $384
JUMPV
LABELV $383
line 962
;961:	else
;962:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
LABELV $384
line 963
;963:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 964
;964:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 965
;965:	VectorScale( dir, g_plspeed.integer, bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 g_plspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_plspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_plspeed+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 966
;966:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 36
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
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 968
;967:
;968:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 970
;969:
;970:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $378
endproc fire_prox 20 4
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
import fire_blaster
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
LABELV $345
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $314
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $294
byte 1 98
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $274
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $254
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $206
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $171
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $151
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 95
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $150
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
byte 1 116
byte 1 105
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $130
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
LABELV $128
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
LABELV $118
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
LABELV $116
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
