export PM_SlideMove
code
proc PM_SlideMove 300 28
file "../../../code/game/bg_slidemove.c"
line 45
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
;23:// bg_slidemove.c -- part of bg_pmove functionality
;24:
;25:#include "../qcommon/q_shared.h"
;26:#include "bg_public.h"
;27:#include "bg_local.h"
;28:
;29:/*
;30:
;31:input: origin, velocity, bounds, groundPlane, trace function
;32:
;33:output: origin, velocity, impacts, stairup boolean
;34:
;35:*/
;36:
;37:/*
;38:==================
;39:PM_SlideMove
;40:
;41:Returns qtrue if the velocity was clipped in some way
;42:==================
;43:*/
;44:#define	MAX_CLIP_PLANES	5
;45:qboolean	PM_SlideMove( qboolean gravity ) {
line 61
;46:	int			bumpcount, numbumps;
;47:	vec3_t		dir;
;48:	float		d;
;49:	int			numplanes;
;50:	vec3_t		planes[MAX_CLIP_PLANES];
;51:	vec3_t		primal_velocity;
;52:	vec3_t		clipVelocity;
;53:	int			i, j, k;
;54:	trace_t	trace;
;55:	vec3_t		end;
;56:	float		time_left;
;57:	float		into;
;58:	vec3_t		endVelocity;
;59:	vec3_t		endClipVelocity;
;60:	
;61:	numbumps = 4;
ADDRLP4 208
CNSTI4 4
ASGNI4
line 63
;62:
;63:	VectorCopy (pm->ps->velocity, primal_velocity);
ADDRLP4 212
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 65
;64:
;65:	if ( gravity ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $45
line 66
;66:		VectorCopy( pm->ps->velocity, endVelocity );
ADDRLP4 116
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 67
;67:		endVelocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 116+8
ADDRLP4 116+8
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 68
;68:		pm->ps->velocity[2] = ( pm->ps->velocity[2] + endVelocity[2] ) * 0.5;
ADDRLP4 224
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 224
INDIRP4
CNSTF4 1056964608
ADDRLP4 224
INDIRP4
INDIRF4
ADDRLP4 116+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 69
;69:		primal_velocity[2] = endVelocity[2];
ADDRLP4 212+8
ADDRLP4 116+8
INDIRF4
ASGNF4
line 70
;70:		if ( pml.groundPlane ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $52
line 72
;71:			// slide along the ground plane
;72:			PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 228
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 228
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 228
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 74
;73:				pm->ps->velocity, OVERCLIP );
;74:		}
LABELV $52
line 75
;75:	}
LABELV $45
line 77
;76:
;77:	time_left = pml.frametime;
ADDRLP4 188
ADDRGP4 pml+36
INDIRF4
ASGNF4
line 80
;78:
;79:	// never turn against the ground plane
;80:	if ( pml.groundPlane ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $58
line 81
;81:		numplanes = 1;
ADDRLP4 96
CNSTI4 1
ASGNI4
line 82
;82:		VectorCopy( pml.groundTrace.plane.normal, planes[0] );
ADDRLP4 4
ADDRGP4 pml+52+24
INDIRB
ASGNB 12
line 83
;83:	} else {
ADDRGP4 $59
JUMPV
LABELV $58
line 84
;84:		numplanes = 0;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 85
;85:	}
LABELV $59
line 88
;86:
;87:	// never turn against original velocity
;88:	VectorNormalize2( pm->ps->velocity, planes[numplanes] );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTI4 12
ADDRLP4 96
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 89
;89:	numplanes++;
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 91
;90:
;91:	for ( bumpcount=0 ; bumpcount < numbumps ; bumpcount++ ) {
ADDRLP4 204
CNSTI4 0
ASGNI4
ADDRGP4 $66
JUMPV
LABELV $63
line 94
;92:
;93:		// calculate position we are trying to move to
;94:		VectorMA( pm->ps->origin, time_left, pm->ps->velocity, end );
ADDRLP4 224
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 228
ADDRLP4 224
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 192
ADDRLP4 228
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 228
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 236
ADDRLP4 224
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 192+4
ADDRLP4 236
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 236
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 240
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 192+8
ADDRLP4 240
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 240
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ADDF4
ASGNF4
line 97
;95:
;96:		// see if we can make it there
;97:		pm->trace ( &trace, pm->ps->origin, pm->mins, pm->maxs, end, pm->ps->clientNum, pm->tracemask);
ADDRLP4 128
ARGP4
ADDRLP4 244
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 248
ADDRLP4 244
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 248
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 244
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 244
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 192
ARGP4
ADDRLP4 248
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 244
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 244
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CALLV
pop
line 99
;98:
;99:		if (trace.allsolid) {
ADDRLP4 128
INDIRI4
CNSTI4 0
EQI4 $69
line 101
;100:			// entity is completely trapped in another solid
;101:			pm->ps->velocity[2] = 0;	// don't build up falling damage, but allow sideways acceleration
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 0
ASGNF4
line 102
;102:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $44
JUMPV
LABELV $69
line 105
;103:		}
;104:
;105:		if (trace.fraction > 0) {
ADDRLP4 128+8
INDIRF4
CNSTF4 0
LEF4 $71
line 107
;106:			// actually covered some distance
;107:			VectorCopy (trace.endpos, pm->ps->origin);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 128+12
INDIRB
ASGNB 12
line 108
;108:		}
LABELV $71
line 110
;109:
;110:		if (trace.fraction == 1) {
ADDRLP4 128+8
INDIRF4
CNSTF4 1065353216
NEF4 $75
line 111
;111:			 break;		// moved the entire distance
ADDRGP4 $65
JUMPV
LABELV $75
line 115
;112:		}
;113:
;114:		// save entity for contact
;115:		PM_AddTouchEnt( trace.entityNum );
ADDRLP4 128+52
INDIRI4
ARGI4
ADDRGP4 PM_AddTouchEnt
CALLV
pop
line 117
;116:
;117:		time_left -= time_left * trace.fraction;
ADDRLP4 188
ADDRLP4 188
INDIRF4
ADDRLP4 188
INDIRF4
ADDRLP4 128+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 119
;118:
;119:		if (numplanes >= MAX_CLIP_PLANES) {
ADDRLP4 96
INDIRI4
CNSTI4 5
LTI4 $80
line 121
;120:			// this shouldn't really happen
;121:			VectorClear( pm->ps->velocity );
ADDRLP4 256
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 260
CNSTF4 0
ASGNF4
ADDRLP4 256
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 260
INDIRF4
ASGNF4
ADDRLP4 256
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 260
INDIRF4
ASGNF4
ADDRLP4 256
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 260
INDIRF4
ASGNF4
line 122
;122:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $44
JUMPV
LABELV $80
line 130
;123:		}
;124:
;125:		//
;126:		// if this is the same plane we hit before, nudge velocity
;127:		// out along it, which fixes some epsilon issues with
;128:		// non-axial planes
;129:		//
;130:		for ( i = 0 ; i < numplanes ; i++ ) {
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRGP4 $85
JUMPV
LABELV $82
line 131
;131:			if ( DotProduct( trace.plane.normal, planes[i] ) > 0.99 ) {
ADDRLP4 256
CNSTI4 12
ADDRLP4 80
INDIRI4
MULI4
ASGNI4
ADDRLP4 128+24
INDIRF4
ADDRLP4 256
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 128+24+4
INDIRF4
ADDRLP4 256
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 128+24+8
INDIRF4
ADDRLP4 256
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1065185444
LEF4 $86
line 132
;132:				VectorAdd( trace.plane.normal, pm->ps->velocity, pm->ps->velocity );
ADDRLP4 260
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 128+24
INDIRF4
ADDRLP4 260
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 264
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 264
INDIRP4
ADDRLP4 128+24+4
INDIRF4
ADDRLP4 264
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 268
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ADDRLP4 128+24+8
INDIRF4
ADDRLP4 268
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 133
;133:				break;
ADDRGP4 $84
JUMPV
LABELV $86
line 135
;134:			}
;135:		}
LABELV $83
line 130
ADDRLP4 80
ADDRLP4 80
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $85
ADDRLP4 80
INDIRI4
ADDRLP4 96
INDIRI4
LTI4 $82
LABELV $84
line 136
;136:		if ( i < numplanes ) {
ADDRLP4 80
INDIRI4
ADDRLP4 96
INDIRI4
GEI4 $100
line 137
;137:			continue;
ADDRGP4 $64
JUMPV
LABELV $100
line 139
;138:		}
;139:		VectorCopy (trace.plane.normal, planes[numplanes]);
CNSTI4 12
ADDRLP4 96
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ADDRLP4 128+24
INDIRB
ASGNB 12
line 140
;140:		numplanes++;
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 147
;141:
;142:		//
;143:		// modify velocity so it parallels all of the clip planes
;144:		//
;145:
;146:		// find a plane that it enters
;147:		for ( i = 0 ; i < numplanes ; i++ ) {
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRGP4 $106
JUMPV
LABELV $103
line 148
;148:			into = DotProduct( pm->ps->velocity, planes[i] );
ADDRLP4 256
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 260
CNSTI4 12
ADDRLP4 80
INDIRI4
MULI4
ASGNI4
ADDRLP4 184
ADDRLP4 256
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 260
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 256
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 260
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 256
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 260
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 149
;149:			if ( into >= 0.1 ) {
ADDRLP4 184
INDIRF4
CNSTF4 1036831949
LTF4 $109
line 150
;150:				continue;		// move doesn't interact with the plane
ADDRGP4 $104
JUMPV
LABELV $109
line 154
;151:			}
;152:
;153:			// see how hard we are hitting things
;154:			if ( -into > pml.impactSpeed ) {
ADDRLP4 184
INDIRF4
NEGF4
ADDRGP4 pml+108
INDIRF4
LEF4 $111
line 155
;155:				pml.impactSpeed = -into;
ADDRGP4 pml+108
ADDRLP4 184
INDIRF4
NEGF4
ASGNF4
line 156
;156:			}
LABELV $111
line 159
;157:
;158:			// slide along the plane
;159:			PM_ClipVelocity (pm->ps->velocity, planes[i], clipVelocity, OVERCLIP );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTI4 12
ADDRLP4 80
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 64
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 161
;160:
;161:			if ( gravity ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $115
line 163
;162:				// slide along the plane
;163:				PM_ClipVelocity (endVelocity, planes[i], endClipVelocity, OVERCLIP );
ADDRLP4 116
ARGP4
CNSTI4 12
ADDRLP4 80
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 104
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 164
;164:			}
LABELV $115
line 167
;165:
;166:			// see if there is a second plane that the new move enters
;167:			for ( j = 0 ; j < numplanes ; j++ ) {
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRGP4 $120
JUMPV
LABELV $117
line 168
;168:				if ( j == i ) {
ADDRLP4 76
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $121
line 169
;169:					continue;
ADDRGP4 $118
JUMPV
LABELV $121
line 171
;170:				}
;171:				if ( DotProduct( clipVelocity, planes[j] ) >= 0.1 ) {
ADDRLP4 264
CNSTI4 12
ADDRLP4 76
INDIRI4
MULI4
ASGNI4
ADDRLP4 64
INDIRF4
ADDRLP4 264
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 64+4
INDIRF4
ADDRLP4 264
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 64+8
INDIRF4
ADDRLP4 264
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1036831949
LTF4 $123
line 172
;172:					continue;		// move doesn't interact with the plane
ADDRGP4 $118
JUMPV
LABELV $123
line 176
;173:				}
;174:
;175:				// try clipping the move to the plane
;176:				PM_ClipVelocity( clipVelocity, planes[j], clipVelocity, OVERCLIP );
ADDRLP4 64
ARGP4
CNSTI4 12
ADDRLP4 76
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 64
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 178
;177:
;178:				if ( gravity ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $129
line 179
;179:					PM_ClipVelocity( endClipVelocity, planes[j], endClipVelocity, OVERCLIP );
ADDRLP4 104
ARGP4
CNSTI4 12
ADDRLP4 76
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 104
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 180
;180:				}
LABELV $129
line 183
;181:
;182:				// see if it goes back into the first clip plane
;183:				if ( DotProduct( clipVelocity, planes[i] ) >= 0 ) {
ADDRLP4 268
CNSTI4 12
ADDRLP4 80
INDIRI4
MULI4
ASGNI4
ADDRLP4 64
INDIRF4
ADDRLP4 268
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 64+4
INDIRF4
ADDRLP4 268
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 64+8
INDIRF4
ADDRLP4 268
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 0
LTF4 $131
line 184
;184:					continue;
ADDRGP4 $118
JUMPV
LABELV $131
line 188
;185:				}
;186:
;187:				// slide the original velocity along the crease
;188:				CrossProduct (planes[i], planes[j], dir);
ADDRLP4 272
CNSTI4 12
ASGNI4
ADDRLP4 272
INDIRI4
ADDRLP4 80
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 272
INDIRI4
ADDRLP4 76
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 84
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 189
;189:				VectorNormalize( dir );
ADDRLP4 84
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 190
;190:				d = DotProduct( dir, pm->ps->velocity );
ADDRLP4 276
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 100
ADDRLP4 84
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDRLP4 84+4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 84+8
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 191
;191:				VectorScale( dir, d, clipVelocity );
ADDRLP4 64
ADDRLP4 84
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ASGNF4
line 193
;192:
;193:				if ( gravity ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $143
line 194
;194:					CrossProduct (planes[i], planes[j], dir);
ADDRLP4 284
CNSTI4 12
ASGNI4
ADDRLP4 284
INDIRI4
ADDRLP4 80
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 284
INDIRI4
ADDRLP4 76
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 84
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 195
;195:					VectorNormalize( dir );
ADDRLP4 84
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 196
;196:					d = DotProduct( dir, endVelocity );
ADDRLP4 100
ADDRLP4 84
INDIRF4
ADDRLP4 116
INDIRF4
MULF4
ADDRLP4 84+4
INDIRF4
ADDRLP4 116+4
INDIRF4
MULF4
ADDF4
ADDRLP4 84+8
INDIRF4
ADDRLP4 116+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 197
;197:					VectorScale( dir, d, endClipVelocity );
ADDRLP4 104
ADDRLP4 84
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ASGNF4
ADDRLP4 104+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ASGNF4
ADDRLP4 104+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ASGNF4
line 198
;198:				}
LABELV $143
line 201
;199:
;200:				// see if there is a third plane the the new move enters
;201:				for ( k = 0 ; k < numplanes ; k++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $156
JUMPV
LABELV $153
line 202
;202:					if ( k == i || k == j ) {
ADDRLP4 0
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $159
ADDRLP4 0
INDIRI4
ADDRLP4 76
INDIRI4
NEI4 $157
LABELV $159
line 203
;203:						continue;
ADDRGP4 $154
JUMPV
LABELV $157
line 205
;204:					}
;205:					if ( DotProduct( clipVelocity, planes[k] ) >= 0.1 ) {
ADDRLP4 288
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 64
INDIRF4
ADDRLP4 288
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 64+4
INDIRF4
ADDRLP4 288
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 64+8
INDIRF4
ADDRLP4 288
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1036831949
LTF4 $160
line 206
;206:						continue;		// move doesn't interact with the plane
ADDRGP4 $154
JUMPV
LABELV $160
line 210
;207:					}
;208:
;209:					// stop dead at a tripple plane interaction
;210:					VectorClear( pm->ps->velocity );
ADDRLP4 292
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 296
CNSTF4 0
ASGNF4
ADDRLP4 292
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 296
INDIRF4
ASGNF4
ADDRLP4 292
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 296
INDIRF4
ASGNF4
ADDRLP4 292
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 296
INDIRF4
ASGNF4
line 211
;211:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $44
JUMPV
LABELV $154
line 201
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $156
ADDRLP4 0
INDIRI4
ADDRLP4 96
INDIRI4
LTI4 $153
line 213
;212:				}
;213:			}
LABELV $118
line 167
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $120
ADDRLP4 76
INDIRI4
ADDRLP4 96
INDIRI4
LTI4 $117
line 216
;214:
;215:			// if we have fixed all interactions, try another move
;216:			VectorCopy( clipVelocity, pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 64
INDIRB
ASGNB 12
line 218
;217:
;218:			if ( gravity ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $105
line 219
;219:				VectorCopy( endClipVelocity, endVelocity );
ADDRLP4 116
ADDRLP4 104
INDIRB
ASGNB 12
line 220
;220:			}
line 222
;221:
;222:			break;
ADDRGP4 $105
JUMPV
LABELV $104
line 147
ADDRLP4 80
ADDRLP4 80
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $106
ADDRLP4 80
INDIRI4
ADDRLP4 96
INDIRI4
LTI4 $103
LABELV $105
line 224
;223:		}
;224:	}
LABELV $64
line 91
ADDRLP4 204
ADDRLP4 204
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $66
ADDRLP4 204
INDIRI4
ADDRLP4 208
INDIRI4
LTI4 $63
LABELV $65
line 226
;225:
;226:	if ( gravity ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $168
line 227
;227:		VectorCopy( endVelocity, pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 116
INDIRB
ASGNB 12
line 228
;228:	}
LABELV $168
line 231
;229:
;230:	// don't change velocity if in a timer (FIXME: is this correct?)
;231:	if ( pm->ps->pm_time ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $170
line 232
;232:		VectorCopy( primal_velocity, pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 212
INDIRB
ASGNB 12
line 233
;233:	}
LABELV $170
line 235
;234:
;235:	return ( bumpcount != 0 );
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $173
ADDRLP4 224
CNSTI4 1
ASGNI4
ADDRGP4 $174
JUMPV
LABELV $173
ADDRLP4 224
CNSTI4 0
ASGNI4
LABELV $174
ADDRLP4 224
INDIRI4
RETI4
LABELV $44
endproc PM_SlideMove 300 28
export PM_StepSlideMove
proc PM_StepSlideMove 136 28
line 244
;236:}
;237:
;238:/*
;239:==================
;240:PM_StepSlideMove
;241:
;242:==================
;243:*/
;244:void PM_StepSlideMove( qboolean gravity ) {
line 255
;245:	vec3_t		start_o, start_v;
;246:#if 0
;247:	vec3_t		down_o, down_v;
;248:#endif
;249:	trace_t		trace;
;250://	float		down_dist, up_dist;
;251://	vec3_t		delta, delta2;
;252:	vec3_t		up, down;
;253:	float		stepSize;
;254:
;255:	VectorCopy (pm->ps->origin, start_o);
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 256
;256:	VectorCopy (pm->ps->velocity, start_v);
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 258
;257:
;258:	if ( PM_SlideMove( gravity ) == 0 ) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 PM_SlideMove
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $176
line 259
;259:		return;		// we got exactly where we wanted to go first try	
ADDRGP4 $175
JUMPV
LABELV $176
line 262
;260:	}
;261:
;262:	VectorCopy(start_o, down);
ADDRLP4 80
ADDRLP4 68
INDIRB
ASGNB 12
line 263
;263:	down[2] -= STEPSIZE;
ADDRLP4 80+8
ADDRLP4 80+8
INDIRF4
CNSTF4 1099956224
SUBF4
ASGNF4
line 264
;264:	pm->trace (&trace, start_o, pm->mins, pm->maxs, down, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 112
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 112
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 112
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CALLV
pop
line 265
;265:	VectorSet(up, 0, 0, 1);
ADDRLP4 116
CNSTF4 0
ASGNF4
ADDRLP4 56
ADDRLP4 116
INDIRF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 116
INDIRF4
ASGNF4
ADDRLP4 56+8
CNSTF4 1065353216
ASGNF4
line 267
;266:	// never step up when you still have up velocity
;267:	if ( pm->ps->velocity[2] > 0 && (trace.fraction == 1.0 ||
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
LEF4 $181
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $191
ADDRLP4 0+24
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 56+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 56+8
INDIRF4
MULF4
ADDF4
CNSTF4 1060320051
GEF4 $181
LABELV $191
line 268
;268:										DotProduct(trace.plane.normal, up) < 0.7)) {
line 269
;269:		return;
ADDRGP4 $175
JUMPV
LABELV $181
line 277
;270:	}
;271:
;272:#if 0
;273:	VectorCopy (pm->ps->origin, down_o);
;274:	VectorCopy (pm->ps->velocity, down_v);
;275:#endif
;276:
;277:	VectorCopy (start_o, up);
ADDRLP4 56
ADDRLP4 68
INDIRB
ASGNB 12
line 278
;278:	up[2] += STEPSIZE;
ADDRLP4 56+8
ADDRLP4 56+8
INDIRF4
CNSTF4 1099956224
ADDF4
ASGNF4
line 281
;279:
;280:	// test the player position if they were a stepheight higher
;281:	pm->trace (&trace, start_o, pm->mins, pm->maxs, up, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 120
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 120
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 120
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 120
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 120
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CALLV
pop
line 282
;282:	if ( trace.allsolid ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $193
line 283
;283:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $175
line 284
;284:			Com_Printf("%i:bend can't step\n", c_pmove);
ADDRGP4 $197
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 285
;285:		}
line 286
;286:		return;		// can't step up
ADDRGP4 $175
JUMPV
LABELV $193
line 289
;287:	}
;288:
;289:	stepSize = trace.endpos[2] - start_o[2];
ADDRLP4 104
ADDRLP4 0+12+8
INDIRF4
ADDRLP4 68+8
INDIRF4
SUBF4
ASGNF4
line 291
;290:	// try slidemove from this position
;291:	VectorCopy (trace.endpos, pm->ps->origin);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 292
;292:	VectorCopy (start_v, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 92
INDIRB
ASGNB 12
line 294
;293:
;294:	PM_SlideMove( gravity );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_SlideMove
CALLI4
pop
line 297
;295:
;296:	// push down the final amount
;297:	VectorCopy (pm->ps->origin, down);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 298
;298:	down[2] -= stepSize;
ADDRLP4 80+8
ADDRLP4 80+8
INDIRF4
ADDRLP4 104
INDIRF4
SUBF4
ASGNF4
line 299
;299:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, down, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 124
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 128
ADDRLP4 124
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 124
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 124
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 128
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 124
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 124
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CALLV
pop
line 300
;300:	if ( !trace.allsolid ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $203
line 301
;301:		VectorCopy (trace.endpos, pm->ps->origin);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 302
;302:	}
LABELV $203
line 303
;303:	if ( trace.fraction < 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $206
line 304
;304:		PM_ClipVelocity( pm->ps->velocity, trace.plane.normal, pm->ps->velocity, OVERCLIP );
ADDRLP4 132
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 305
;305:	}
LABELV $206
line 319
;306:
;307:#if 0
;308:	// if the down trace can trace back to the original position directly, don't step
;309:	pm->trace( &trace, pm->ps->origin, pm->mins, pm->maxs, start_o, pm->ps->clientNum, pm->tracemask);
;310:	if ( trace.fraction == 1.0 ) {
;311:		// use the original move
;312:		VectorCopy (down_o, pm->ps->origin);
;313:		VectorCopy (down_v, pm->ps->velocity);
;314:		if ( pm->debugLevel ) {
;315:			Com_Printf("%i:bend\n", c_pmove);
;316:		}
;317:	} else 
;318:#endif
;319:	{
line 323
;320:		// use the step move
;321:		float	delta;
;322:
;323:		delta = pm->ps->origin[2] - start_o[2];
ADDRLP4 132
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 68+8
INDIRF4
SUBF4
ASGNF4
line 324
;324:		if ( delta > 2 ) {
ADDRLP4 132
INDIRF4
CNSTF4 1073741824
LEF4 $211
line 325
;325:			if ( delta < 7 ) {
ADDRLP4 132
INDIRF4
CNSTF4 1088421888
GEF4 $213
line 326
;326:				PM_AddEvent( EV_STEP_4 );
CNSTI4 6
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 327
;327:			} else if ( delta < 11 ) {
ADDRGP4 $214
JUMPV
LABELV $213
ADDRLP4 132
INDIRF4
CNSTF4 1093664768
GEF4 $215
line 328
;328:				PM_AddEvent( EV_STEP_8 );
CNSTI4 7
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 329
;329:			} else if ( delta < 15 ) {
ADDRGP4 $216
JUMPV
LABELV $215
ADDRLP4 132
INDIRF4
CNSTF4 1097859072
GEF4 $217
line 330
;330:				PM_AddEvent( EV_STEP_12 );
CNSTI4 8
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 331
;331:			} else {
ADDRGP4 $218
JUMPV
LABELV $217
line 332
;332:				PM_AddEvent( EV_STEP_16 );
CNSTI4 9
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 333
;333:			}
LABELV $218
LABELV $216
LABELV $214
line 334
;334:		}
LABELV $211
line 335
;335:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $219
line 336
;336:			Com_Printf("%i:stepped\n", c_pmove);
ADDRGP4 $221
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 337
;337:		}
LABELV $219
line 338
;338:	}
line 339
;339:}
LABELV $175
endproc PM_StepSlideMove 136 28
import PM_AddEvent
import PM_AddTouchEnt
import PM_ClipVelocity
import c_pmove
import pm_flightfriction
import pm_waterfriction
import pm_friction
import pm_flyaccelerate
import pm_wateraccelerate
import pm_airaccelerate
import pm_accelerate
import pm_wadeScale
import pm_duckScale
import pm_stopspeed
import pml
import pm
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
LABELV $221
byte 1 37
byte 1 105
byte 1 58
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $197
byte 1 37
byte 1 105
byte 1 58
byte 1 98
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 10
byte 1 0
