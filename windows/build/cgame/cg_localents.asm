export CG_InitLocalEntities
code
proc CG_InitLocalEntities 12 12
file "../../../code/cgame/cg_localents.c"
line 41
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
;23:
;24:// cg_localents.c -- every frame, generate renderer commands for locally
;25:// processed entities, like smoke puffs, gibs, shells, etc.
;26:
;27:#include "cg_local.h"
;28:
;29:#define	MAX_LOCAL_ENTITIES	512 
;30:localEntity_t	cg_localEntities[MAX_LOCAL_ENTITIES];
;31:localEntity_t	cg_activeLocalEntities;		// double linked list
;32:localEntity_t	*cg_freeLocalEntities;		// single linked list
;33:
;34:/*
;35:===================
;36:CG_InitLocalEntities
;37:
;38:This is called at startup and for tournement restarts
;39:===================
;40:*/
;41:void	CG_InitLocalEntities( void ) {
line 44
;42:	int		i;
;43:
;44:	memset( cg_localEntities, 0, sizeof( cg_localEntities ) );
ADDRGP4 cg_localEntities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 186368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 45
;45:	cg_activeLocalEntities.next = &cg_activeLocalEntities;
ADDRGP4 cg_activeLocalEntities+4
ADDRGP4 cg_activeLocalEntities
ASGNP4
line 46
;46:	cg_activeLocalEntities.prev = &cg_activeLocalEntities;
ADDRLP4 4
ADDRGP4 cg_activeLocalEntities
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
ASGNP4
line 47
;47:	cg_freeLocalEntities = cg_localEntities;
ADDRGP4 cg_freeLocalEntities
ADDRGP4 cg_localEntities
ASGNP4
line 48
;48:	for ( i = 0 ; i < MAX_LOCAL_ENTITIES - 1 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $76
line 49
;49:		cg_localEntities[i].next = &cg_localEntities[i+1];
ADDRLP4 8
CNSTI4 364
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 cg_localEntities+4
ADDP4
ADDRLP4 8
INDIRI4
ADDRGP4 cg_localEntities+364
ADDP4
ASGNP4
line 50
;50:	}
LABELV $77
line 48
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 511
LTI4 $76
line 51
;51:}
LABELV $74
endproc CG_InitLocalEntities 12 12
export CG_FreeLocalEntity
proc CG_FreeLocalEntity 12 4
line 59
;52:
;53:
;54:/*
;55:==================
;56:CG_FreeLocalEntity
;57:==================
;58:*/
;59:void CG_FreeLocalEntity( localEntity_t *le ) {
line 60
;60:	if ( !le->prev ) {
ADDRFP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $83
line 61
;61:		CG_Error( "CG_FreeLocalEntity: not active" );
ADDRGP4 $85
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 62
;62:	}
LABELV $83
line 65
;63:
;64:	// remove from the doubly linked active list
;65:	le->prev->next = le->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 66
;66:	le->next->prev = le->prev;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ADDRLP4 8
INDIRP4
INDIRP4
ASGNP4
line 69
;67:
;68:	// the free list is only singly linked
;69:	le->next = cg_freeLocalEntities;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg_freeLocalEntities
INDIRP4
ASGNP4
line 70
;70:	cg_freeLocalEntities = le;
ADDRGP4 cg_freeLocalEntities
ADDRFP4 0
INDIRP4
ASGNP4
line 71
;71:}
LABELV $82
endproc CG_FreeLocalEntity 12 4
export CG_AllocLocalEntity
proc CG_AllocLocalEntity 8 12
line 80
;72:
;73:/*
;74:===================
;75:CG_AllocLocalEntity
;76:
;77:Will always succeed, even if it requires freeing an old active entity
;78:===================
;79:*/
;80:localEntity_t	*CG_AllocLocalEntity( void ) {
line 83
;81:	localEntity_t	*le;
;82:
;83:	if ( !cg_freeLocalEntities ) {
ADDRGP4 cg_freeLocalEntities
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $87
line 86
;84:		// no free entities, so free the one at the end of the chain
;85:		// remove the oldest active entity
;86:		CG_FreeLocalEntity( cg_activeLocalEntities.prev );
ADDRGP4 cg_activeLocalEntities
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 87
;87:	}
LABELV $87
line 89
;88:
;89:	le = cg_freeLocalEntities;
ADDRLP4 0
ADDRGP4 cg_freeLocalEntities
INDIRP4
ASGNP4
line 90
;90:	cg_freeLocalEntities = cg_freeLocalEntities->next;
ADDRLP4 4
ADDRGP4 cg_freeLocalEntities
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 92
;91:
;92:	memset( le, 0, sizeof( *le ) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 364
ARGI4
ADDRGP4 memset
CALLP4
pop
line 95
;93:
;94:	// link into the active list
;95:	le->next = cg_activeLocalEntities.next;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg_activeLocalEntities+4
INDIRP4
ASGNP4
line 96
;96:	le->prev = &cg_activeLocalEntities;
ADDRLP4 0
INDIRP4
ADDRGP4 cg_activeLocalEntities
ASGNP4
line 97
;97:	cg_activeLocalEntities.next->prev = le;
ADDRGP4 cg_activeLocalEntities+4
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 98
;98:	cg_activeLocalEntities.next = le;
ADDRGP4 cg_activeLocalEntities+4
ADDRLP4 0
INDIRP4
ASGNP4
line 99
;99:	return le;
ADDRLP4 0
INDIRP4
RETP4
LABELV $86
endproc CG_AllocLocalEntity 8 12
export CG_BloodTrail
proc CG_BloodTrail 48 48
line 121
;100:}
;101:
;102:
;103:/*
;104:====================================================================================
;105:
;106:FRAGMENT PROCESSING
;107:
;108:A fragment localentity interacts with the environment in some way (hitting walls),
;109:or generates more localentities along a trail.
;110:
;111:====================================================================================
;112:*/
;113:
;114:/*
;115:================
;116:CG_BloodTrail
;117:
;118:Leave expanding blood puffs behind gibs
;119:================
;120:*/
;121:void CG_BloodTrail( localEntity_t *le ) {
line 128
;122:	int		t;
;123:	int		t2;
;124:	int		step;
;125:	vec3_t	newOrigin;
;126:	localEntity_t	*blood;
;127:
;128:	step = 150;
ADDRLP4 20
CNSTI4 150
ASGNI4
line 129
;129:	t = step * ( (cg.time - cg.frametime + step ) / step );
ADDRLP4 0
ADDRLP4 20
INDIRI4
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+107600
INDIRI4
SUBI4
ADDRLP4 20
INDIRI4
ADDI4
ADDRLP4 20
INDIRI4
DIVI4
MULI4
ASGNI4
line 130
;130:	t2 = step * ( cg.time / step );
ADDRLP4 24
ADDRLP4 20
INDIRI4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 20
INDIRI4
DIVI4
MULI4
ASGNI4
line 132
;131:
;132:	for ( ; t <= t2; t += step ) {
ADDRGP4 $99
JUMPV
LABELV $96
line 133
;133:		BG_EvaluateTrajectory( &le->pos, t, newOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 135
;134:
;135:		blood = CG_SmokePuff( newOrigin, vec3_origin, 
ADDRLP4 8
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
CNSTF4 1157234688
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 cgs+180268+360
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 44
INDIRP4
ASGNP4
line 144
;136:					  20,		// radius
;137:					  1, 1, 1, 1,	// color
;138:					  2000,		// trailTime
;139:					  t,		// startTime
;140:					  0,		// fadeInTime
;141:					  0,		// flags
;142:					  cgs.media.bloodTrailShader );
;143:		// use the optimized version
;144:		blood->leType = LE_FALL_SCALE_FADE;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 5
ASGNI4
line 146
;145:		// drop a total of 40 units over its lifetime
;146:		blood->pos.trDelta[2] = 40;
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1109393408
ASGNF4
line 147
;147:	}
LABELV $97
line 132
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ASGNI4
LABELV $99
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $96
line 148
;148:}
LABELV $92
endproc CG_BloodTrail 48 48
export CG_SmallBloodTrail
proc CG_SmallBloodTrail 48 48
line 152
;149:
;150:
;151:// LEILEI
;152:void CG_SmallBloodTrail( localEntity_t *le ) {
line 159
;153:	int		t;
;154:	int		t2;
;155:	int		step;
;156:	vec3_t	newOrigin;
;157:	localEntity_t	*blood;
;158:
;159:	step = 61;
ADDRLP4 20
CNSTI4 61
ASGNI4
line 160
;160:	t = step * ( (cg.time - cg.frametime + step ) / step );
ADDRLP4 0
ADDRLP4 20
INDIRI4
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+107600
INDIRI4
SUBI4
ADDRLP4 20
INDIRI4
ADDI4
ADDRLP4 20
INDIRI4
DIVI4
MULI4
ASGNI4
line 161
;161:	t2 = step * ( cg.time / step );
ADDRLP4 24
ADDRLP4 20
INDIRI4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 20
INDIRI4
DIVI4
MULI4
ASGNI4
line 163
;162:
;163:	for ( ; t <= t2; t += step ) {
ADDRGP4 $109
JUMPV
LABELV $106
line 164
;164:		BG_EvaluateTrajectory( &le->pos, t, newOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 166
;165:
;166:		blood = CG_SmokePuff( newOrigin, vec3_origin, 
ADDRLP4 8
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 1077936128
ARGF4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
CNSTF4 1145077760
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 cgs+180268+400
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 44
INDIRP4
ASGNP4
line 175
;167:					  3,		// radius
;168:					  1, 1, 1, 1,	// color
;169:					  770,		// trailTime
;170:					  t,		// startTime
;171:					  0,		// fadeInTime
;172:					  0,		// flags
;173:					  cgs.media.lbldShader1 );
;174:		// use the optimized version
;175:		blood->leType = LE_FALL_SCALE_FADE;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 5
ASGNI4
line 177
;176:		// drop a total of 40 units over its lifetime
;177:		blood->pos.trDelta[2] = 120;
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1123024896
ASGNF4
line 178
;178:	}
LABELV $107
line 163
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ASGNI4
LABELV $109
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $106
line 179
;179:}
LABELV $102
endproc CG_SmallBloodTrail 48 48
export CG_FragmentBounceMark
proc CG_FragmentBounceMark 20 44
line 188
;180:
;181:
;182:
;183:/*
;184:================
;185:CG_FragmentBounceMark
;186:================
;187:*/
;188:void CG_FragmentBounceMark( localEntity_t *le, trace_t *trace ) {
line 191
;189:	int			radius;
;190:
;191:	if ( le->leMarkType == LEMT_BLOOD ) {
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
NEI4 $113
line 193
;192:
;193:		radius = 16 + (rand()&31);
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 16
ADDI4
ASGNI4
line 194
;194:		CG_ImpactMark( cgs.media.bloodMarkShader, trace->endpos, trace->plane.normal, random()*360,
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cgs+180268+524
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1135869952
ADDRLP4 8
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ARGF4
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 196
;195:			1,1,1,1, qtrue, radius, qfalse );
;196:	} else if ( le->leMarkType == LEMT_BURN ) {
ADDRGP4 $114
JUMPV
LABELV $113
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $117
line 198
;197:
;198:		radius = 8 + (rand()&15);
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 8
ADDI4
ASGNI4
line 199
;199:		CG_ImpactMark( cgs.media.burnMarkShader, trace->endpos, trace->plane.normal, random()*360,
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cgs+180268+532
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1135869952
ADDRLP4 8
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ARGF4
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 201
;200:			1,1,1,1, qtrue, radius, qfalse );
;201:	}
LABELV $117
LABELV $114
line 206
;202:
;203:
;204:	// don't allow a fragment to make multiple marks, or they
;205:	// pile up while settling
;206:	le->leMarkType = LEMT_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 207
;207:}
LABELV $112
endproc CG_FragmentBounceMark 20 44
export CG_FragmentBounceSound
proc CG_FragmentBounceSound 16 16
line 214
;208:
;209:/*
;210:================
;211:CG_FragmentBounceSound
;212:================
;213:*/
;214:void CG_FragmentBounceSound( localEntity_t *le, trace_t *trace ) {
line 215
;215:	if ( le->leBounceSoundType == LEBS_BLOOD ) {
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $122
line 217
;216:		// half the gibs will make splat sounds
;217:		if ( rand() & 1 ) {
ADDRLP4 0
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $123
line 218
;218:			int r = rand()&3;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 3
BANDI4
ASGNI4
line 221
;219:			sfxHandle_t	s;
;220:
;221:			if ( r == 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $126
line 222
;222:				s = cgs.media.gibBounce1Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1064
INDIRI4
ASGNI4
line 223
;223:			} else if ( r == 1 ) {
ADDRGP4 $127
JUMPV
LABELV $126
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $130
line 224
;224:				s = cgs.media.gibBounce2Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1068
INDIRI4
ASGNI4
line 225
;225:			} else {
ADDRGP4 $131
JUMPV
LABELV $130
line 226
;226:				s = cgs.media.gibBounce3Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1072
INDIRI4
ASGNI4
line 227
;227:			}
LABELV $131
LABELV $127
line 228
;228:			trap_S_StartSound( trace->endpos, ENTITYNUM_WORLD, CHAN_AUTO, s );
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 1022
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 229
;229:		}
line 230
;230:	} else if ( le->leBounceSoundType == LEBS_BRASS ) {
ADDRGP4 $123
JUMPV
LABELV $122
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $136
line 231
;231:		if ( cg_leiBrassNoise.integer ) {
ADDRGP4 cg_leiBrassNoise+12
INDIRI4
CNSTI4 0
EQI4 $137
line 233
;232:		// half the casings will make  casing sounds
;233:		if ( rand() & 1 ) {
ADDRLP4 0
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $137
line 234
;234:			int r = rand()&3;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 3
BANDI4
ASGNI4
line 237
;235:			sfxHandle_t	s;
;236:
;237:			if ( r == 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $143
line 238
;238:				s = cgs.media.lbul1Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1120
INDIRI4
ASGNI4
line 239
;239:			} else if ( r == 1 ) {
ADDRGP4 $144
JUMPV
LABELV $143
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $147
line 240
;240:				s = cgs.media.lbul2Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1124
INDIRI4
ASGNI4
line 241
;241:			} else {
ADDRGP4 $148
JUMPV
LABELV $147
line 242
;242:				s = cgs.media.lbul3Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1128
INDIRI4
ASGNI4
line 243
;243:			}
LABELV $148
LABELV $144
line 244
;244:			trap_S_StartSound( trace->endpos, ENTITYNUM_WORLD, CHAN_AUTO, s );
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 1022
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 245
;245:			}
line 246
;246:		}
line 248
;247:
;248:	} else if ( le->leBounceSoundType == LEBS_SHELL ) {
ADDRGP4 $137
JUMPV
LABELV $136
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
NEI4 $153
line 250
;249:		
;250:		if ( cg_leiBrassNoise.integer ) {
ADDRGP4 cg_leiBrassNoise+12
INDIRI4
CNSTI4 0
EQI4 $155
line 253
;251:			
;252:		// half the casings will make  casing sounds
;253:		if ( rand() & 1 ) {
ADDRLP4 0
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $158
line 254
;254:			int r = rand()&3;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 3
BANDI4
ASGNI4
line 257
;255:			sfxHandle_t	s;
;256:
;257:			if ( r == 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $160
line 258
;258:				s = cgs.media.lshl1Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1132
INDIRI4
ASGNI4
line 259
;259:			} else if ( r == 1 ) {
ADDRGP4 $161
JUMPV
LABELV $160
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $164
line 260
;260:				s = cgs.media.lshl2Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1136
INDIRI4
ASGNI4
line 261
;261:			} else {
ADDRGP4 $165
JUMPV
LABELV $164
line 262
;262:				s = cgs.media.lshl3Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1140
INDIRI4
ASGNI4
line 263
;263:			}
LABELV $165
LABELV $161
line 264
;264:			trap_S_StartSound( trace->endpos, ENTITYNUM_WORLD, CHAN_AUTO, s );
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 1022
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 265
;265:		}
LABELV $158
line 266
;266:		}
LABELV $155
line 268
;267:
;268:	}
LABELV $153
LABELV $137
LABELV $123
line 272
;269:
;270:	// don't allow a fragment to make multiple bounce sounds,
;271:	// or it gets too noisy as they settle
;272:	le->leBounceSoundType = LEBS_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 273
;273:}
LABELV $121
endproc CG_FragmentBounceSound 16 16
export CG_GoreMark
proc CG_GoreMark 20 44
line 277
;274:
;275:
;276:// LEILEI 
;277:void CG_GoreMark( localEntity_t *le, trace_t *trace ) {
line 280
;278:	int			radius;
;279:
;280:	if ( le->leMarkType == LEMT_BURN ) {
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $171
line 282
;281:
;282:		radius = 6 + (rand()&16);
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 6
ADDI4
ASGNI4
line 283
;283:		CG_ImpactMark( cgs.media.lbldShader2, trace->endpos, trace->plane.normal, random()*360,
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cgs+180268+404
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1135869952
ADDRLP4 8
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ARGF4
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 286
;284:			1,1,1,1, qtrue, radius, qfalse );
;285:	
;286:	}
LABELV $171
line 288
;287:
;288:	le->leMarkType = LEMT_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 289
;289:}
LABELV $170
endproc CG_GoreMark 20 44
export CG_SplatSound
proc CG_SplatSound 16 16
line 297
;290:
;291:
;292:/*
;293:================
;294:CG_SplatSound LEILEI
;295:================
;296:*/
;297:void CG_SplatSound( localEntity_t *le, trace_t *trace ) {
line 298
;298:	if ( le->leBounceSoundType == LEBS_BLOOD ) {
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $176
line 300
;299:		// half the splats will make splat sounds
;300:	if ( cg_leiGoreNoise.integer ) {
ADDRGP4 cg_leiGoreNoise+12
INDIRI4
CNSTI4 0
EQI4 $177
line 301
;301:		if ( rand() & 1 ) {
ADDRLP4 0
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $177
line 302
;302:			int r = rand()&3;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 3
BANDI4
ASGNI4
line 305
;303:			sfxHandle_t	s;
;304:
;305:			if ( r == 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $183
line 306
;306:				s = cgs.media.lspl1Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1108
INDIRI4
ASGNI4
line 307
;307:			} else if ( r == 1 ) {
ADDRGP4 $184
JUMPV
LABELV $183
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $187
line 308
;308:				s = cgs.media.lspl2Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1112
INDIRI4
ASGNI4
line 309
;309:			} else {
ADDRGP4 $188
JUMPV
LABELV $187
line 310
;310:				s = cgs.media.lspl3Sound;
ADDRLP4 8
ADDRGP4 cgs+180268+1116
INDIRI4
ASGNI4
line 311
;311:			}
LABELV $188
LABELV $184
line 312
;312:			trap_S_StartSound( trace->endpos, ENTITYNUM_WORLD, CHAN_AUTO, s );
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 1022
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 313
;313:		}
line 314
;314:		}
line 315
;315:	} else if ( le->leBounceSoundType == LEBS_BRASS ) {
ADDRGP4 $177
JUMPV
LABELV $176
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $193
line 317
;316:		// no GERMAN EURO CENSOR ROBOTS mode yet.
;317:	}
LABELV $193
LABELV $177
line 321
;318:
;319:	// don't allow a fragment to make multiple bounce sounds,
;320:	// or it gets too noisy as they settle
;321:	le->leBounceSoundType = LEBS_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 322
;322:}
LABELV $175
endproc CG_SplatSound 16 16
export CG_ReflectVelocity
proc CG_ReflectVelocity 56 12
line 331
;323:
;324:
;325:
;326:/*
;327:================
;328:CG_ReflectVelocity
;329:================
;330:*/
;331:void CG_ReflectVelocity( localEntity_t *le, trace_t *trace ) {
line 337
;332:	vec3_t	velocity;
;333:	float	dot;
;334:	int		hitTime;
;335:
;336:	// reflect the velocity on the trace plane
;337:	hitTime = cg.time - cg.frametime + cg.frametime * trace->fraction;
ADDRLP4 16
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+107600
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+107600
INDIRI4
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
line 338
;338:	BG_EvaluateTrajectoryDelta( &le->pos, hitTime, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 32
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
line 339
;339:	dot = DotProduct( velocity, trace->plane.normal );
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
line 340
;340:	VectorMA( velocity, -2*dot, trace->plane.normal, le->pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 56
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
CNSTI4 60
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
CNSTI4 64
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
line 342
;341:
;342:	VectorScale( le->pos.trDelta, le->bounceFactor, le->pos.trDelta );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 56
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
MULF4
ASGNF4
line 344
;343:
;344:	VectorCopy( trace->endpos, le->pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 345
;345:	le->pos.trTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 349
;346:
;347:
;348:	// check for stop, making sure that even on low FPS systems it doesn't bobble
;349:	if ( trace->allsolid || 
ADDRLP4 48
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $208
ADDRLP4 48
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
LEF4 $204
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1109393408
LTF4 $208
ADDRLP4 52
INDIRF4
ADDRGP4 cg+107600
INDIRI4
NEGI4
CVIF4 4
ADDRLP4 52
INDIRF4
MULF4
GEF4 $204
LABELV $208
line 351
;350:		( trace->plane.normal[2] > 0 && 
;351:		( le->pos.trDelta[2] < 40 || le->pos.trDelta[2] < -cg.frametime * le->pos.trDelta[2] ) ) ) {
line 352
;352:		le->pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 0
ASGNI4
line 353
;353:	} else {
LABELV $204
line 355
;354:
;355:	}
LABELV $205
line 356
;356:}
LABELV $195
endproc CG_ReflectVelocity 56 12
export CG_AddFragment
proc CG_AddFragment 88 28
line 363
;357:
;358:/*
;359:================
;360:CG_AddFragment
;361:================
;362:*/
;363:void CG_AddFragment( localEntity_t *le ) {
line 367
;364:	vec3_t	newOrigin;
;365:	trace_t	trace;
;366:
;367:	if ( le->pos.trType == TR_STATIONARY ) {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
NEI4 $210
line 372
;368:		// sink into the ground if near the removal time
;369:		int		t;
;370:		float	oldZ;
;371:		
;372:		t = le->endTime - cg.time;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 373
;373:		if ( t < SINK_TIME ) {
ADDRLP4 68
INDIRI4
CNSTI4 1000
GEI4 $213
line 377
;374:			// we must use an explicit lighting origin, otherwise the
;375:			// lighting would be lost as soon as the origin went
;376:			// into the ground
;377:			VectorCopy( le->refEntity.origin, le->refEntity.lightingOrigin );
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 220
ADDP4
INDIRB
ASGNB 12
line 378
;378:			le->refEntity.renderfx |= RF_LIGHTING_ORIGIN;
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 379
;379:			oldZ = le->refEntity.origin[2];
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
ASGNF4
line 380
;380:			le->refEntity.origin[2] -= 16 * ( 1.0 - (float)t / SINK_TIME );
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
CNSTF4 1098907648
CNSTF4 1065353216
ADDRLP4 68
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
SUBF4
MULF4
SUBF4
ASGNF4
line 381
;381:			trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 382
;382:			le->refEntity.origin[2] = oldZ;
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
ADDRLP4 72
INDIRF4
ASGNF4
line 383
;383:		} else {
ADDRGP4 $209
JUMPV
LABELV $213
line 384
;384:			trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 385
;385:		}
line 387
;386:
;387:		return;
ADDRGP4 $209
JUMPV
LABELV $210
line 391
;388:	}
;389:
;390:	// calculate new position
;391:	BG_EvaluateTrajectory( &le->pos, cg.time, newOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 394
;392:
;393:	// trace a line from previous position to new position
;394:	CG_Trace( &trace, le->refEntity.origin, NULL, NULL, newOrigin, -1, CONTENTS_SOLID );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 68
CNSTP4 0
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 395
;395:	if ( trace.fraction == 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $216
line 397
;396:		// still in free fall
;397:		VectorCopy( newOrigin, le->refEntity.origin );
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ADDRLP4 56
INDIRB
ASGNB 12
line 399
;398:
;399:		if ( le->leFlags & LEF_TUMBLE ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $219
line 402
;400:			vec3_t angles;
;401:
;402:			BG_EvaluateTrajectory( &le->angles, cg.time, angles );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 403
;403:			AnglesToAxis( angles, le->refEntity.axis );
ADDRLP4 72
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 404
;404:		}
LABELV $219
line 406
;405:
;406:		trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 409
;407:
;408:		// add a blood trail
;409:		if ( le->leBounceSoundType == LEBS_BLOOD ) {
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $209
line 410
;410:			CG_BloodTrail( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_BloodTrail
CALLV
pop
line 411
;411:		}
line 413
;412:
;413:		return;
ADDRGP4 $209
JUMPV
LABELV $216
line 419
;414:	}
;415:
;416:	// if it is in a nodrop zone, remove it
;417:	// this keeps gibs from waiting at the bottom of pits of death
;418:	// and floating levels
;419:	if ( CG_PointContents( trace.endpos, 0 ) & CONTENTS_NODROP ) {
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 72
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $224
line 420
;420:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 421
;421:		return;
ADDRGP4 $209
JUMPV
LABELV $224
line 425
;422:	}
;423:
;424:	// leave a mark
;425:	CG_FragmentBounceMark( le, &trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FragmentBounceMark
CALLV
pop
line 428
;426:
;427:	// do a bouncy sound
;428:	CG_FragmentBounceSound( le, &trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FragmentBounceSound
CALLV
pop
line 431
;429:
;430:	// reflect the velocity on the trace plane
;431:	CG_ReflectVelocity( le, &trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ReflectVelocity
CALLV
pop
line 433
;432:
;433:	trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 434
;434:}
LABELV $209
endproc CG_AddFragment 88 28
export CG_JustSplat
proc CG_JustSplat 56 12
line 438
;435:
;436:// LEILEI
;437:
;438:void CG_JustSplat( localEntity_t *le, trace_t *trace ) {
line 444
;439:	vec3_t	velocity;
;440:	float	dot;
;441:	int		hitTime;
;442:
;443:	// reflect the velocity on the trace plane
;444:	hitTime = cg.time - cg.frametime + cg.frametime * trace->fraction;
ADDRLP4 16
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+107600
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+107600
INDIRI4
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
line 445
;445:	BG_EvaluateTrajectoryDelta( &le->pos, hitTime, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 32
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
line 446
;446:	dot = DotProduct( velocity, trace->plane.normal );
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
line 447
;447:	VectorMA( velocity, -2*dot, trace->plane.normal, le->pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 56
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
CNSTI4 60
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
CNSTI4 64
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
line 449
;448:
;449:	VectorScale( le->pos.trDelta, le->bounceFactor, le->pos.trDelta );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 56
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
MULF4
ASGNF4
line 451
;450:
;451:	VectorCopy( trace->endpos, le->pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 452
;452:	le->pos.trTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 456
;453:
;454:
;455:	// check for stop, making sure that even on low FPS systems it doesn't bobble
;456:	if ( trace->allsolid || 
ADDRLP4 48
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $240
ADDRLP4 48
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
LEF4 $236
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1109393408
LTF4 $240
ADDRLP4 52
INDIRF4
ADDRGP4 cg+107600
INDIRI4
NEGI4
CVIF4 4
ADDRLP4 52
INDIRF4
MULF4
GEF4 $236
LABELV $240
line 458
;457:		( trace->plane.normal[2] > 0 && 
;458:		( le->pos.trDelta[2] < 40 || le->pos.trDelta[2] < -cg.frametime * le->pos.trDelta[2] ) ) ) {
line 459
;459:		le->pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 0
ASGNI4
line 460
;460:	} else {
LABELV $236
line 462
;461:
;462:	}
LABELV $237
line 463
;463:}
LABELV $227
endproc CG_JustSplat 56 12
export CG_AddGore
proc CG_AddGore 84 28
line 465
;464:
;465:void CG_AddGore( localEntity_t *le ) {
line 469
;466:	vec3_t	newOrigin;
;467:	trace_t	trace;
;468:
;469:	if ( le->pos.trType == TR_STATIONARY ) {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
NEI4 $242
line 474
;470:		// sink into the ground if near the removal time
;471:		//int		t;
;472:		//float	oldZ;
;473:		
;474:		CG_FreeLocalEntity( le ); // kill it
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 476
;475:
;476:		return;
ADDRGP4 $241
JUMPV
LABELV $242
line 480
;477:	}
;478:
;479:	// calculate new position
;480:	BG_EvaluateTrajectory( &le->pos, cg.time, newOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 483
;481:
;482:	// trace a line from previous position to new position
;483:	CG_Trace( &trace, le->refEntity.origin, NULL, NULL, newOrigin, -1, CONTENTS_SOLID );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 68
CNSTP4 0
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 484
;484:	if ( trace.fraction == 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $245
line 486
;485:		// still in free fall
;486:		VectorCopy( newOrigin, le->refEntity.origin );
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ADDRLP4 56
INDIRB
ASGNB 12
line 488
;487:
;488:		if ( le->leFlags & LEF_TUMBLE ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $248
line 491
;489:			vec3_t angles;
;490:
;491:			BG_EvaluateTrajectory( &le->angles, cg.time, angles );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 492
;492:			AnglesToAxis( angles, le->refEntity.axis );
ADDRLP4 72
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 493
;493:		}
LABELV $248
line 495
;494:
;495:		trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 497
;496:
;497:		CG_SmallBloodTrail( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SmallBloodTrail
CALLV
pop
line 499
;498:	
;499:		return;
ADDRGP4 $241
JUMPV
LABELV $245
line 505
;500:	}
;501:
;502:	// if it is in a nodrop zone, remove it
;503:	// this keeps gibs from waiting at the bottom of pits of death
;504:	// and floating levels
;505:	if ( trap_CM_PointContents( trace.endpos, 0 ) & CONTENTS_NODROP ) {
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 72
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $251
line 506
;506:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 507
;507:		return;
ADDRGP4 $241
JUMPV
LABELV $251
line 511
;508:	}
;509:
;510:	// leave a mark
;511:	CG_GoreMark( le, &trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_GoreMark
CALLV
pop
line 514
;512:
;513:	// do a juicy sound
;514:	CG_SplatSound( le, &trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_SplatSound
CALLV
pop
line 516
;515:
;516:	CG_JustSplat( le, &trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_JustSplat
CALLV
pop
line 518
;517:
;518:	trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 519
;519:}
LABELV $241
endproc CG_AddGore 84 28
export CG_AddFadeRGB
proc CG_AddFadeRGB 60 4
line 535
;520:
;521:/*
;522:=====================================================================
;523:
;524:TRIVIAL LOCAL ENTITIES
;525:
;526:These only do simple scaling or modulation before passing to the renderer
;527:=====================================================================
;528:*/
;529:
;530:/*
;531:====================
;532:CG_AddFadeRGB
;533:====================
;534:*/
;535:void CG_AddFadeRGB( localEntity_t *le ) {
line 539
;536:	refEntity_t *re;
;537:	float c;
;538:
;539:	re = &le->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 541
;540:
;541:	c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 542
;542:	c *= 0xff;
ADDRLP4 4
CNSTF4 1132396544
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 544
;543:
;544:	re->shaderRGBA[0] = le->color[0] * c;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $257
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $258
JUMPV
LABELV $257
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $258
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 545
;545:	re->shaderRGBA[1] = le->color[1] * c;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $260
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $261
JUMPV
LABELV $260
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $261
ADDRLP4 0
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 546
;546:	re->shaderRGBA[2] = le->color[2] * c;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $263
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $264
JUMPV
LABELV $263
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $264
ADDRLP4 0
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 547
;547:	re->shaderRGBA[3] = le->color[3] * c;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $266
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $267
JUMPV
LABELV $266
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $267
ADDRLP4 0
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 549
;548:
;549:	trap_R_AddRefEntityToScene( re );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 550
;550:}
LABELV $254
endproc CG_AddFadeRGB 60 4
proc CG_AddMoveScaleFade 52 12
line 557
;551:
;552:/*
;553:==================
;554:CG_AddMoveScaleFade
;555:==================
;556:*/
;557:static void CG_AddMoveScaleFade( localEntity_t *le ) {
line 563
;558:	refEntity_t	*re;
;559:	float		c;
;560:	vec3_t		delta;
;561:	float		len;
;562:
;563:	re = &le->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 565
;564:
;565:	if ( le->fadeInTime > le->startTime && cg.time < le->fadeInTime ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LEI4 $269
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 28
INDIRI4
GEI4 $269
line 567
;566:		// fade / grow time
;567:		c = 1.0 - (float) ( le->fadeInTime - cg.time ) / ( le->fadeInTime - le->startTime );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
CNSTF4 1065353216
ADDRLP4 36
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 36
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 568
;568:	}
ADDRGP4 $270
JUMPV
LABELV $269
line 569
;569:	else {
line 571
;570:		// fade / grow time
;571:		c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 32
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 572
;572:	}
LABELV $270
line 574
;573:
;574:	re->shaderRGBA[3] = 0xff * c * le->color[3];
ADDRLP4 36
CNSTF4 1132396544
ADDRLP4 16
INDIRF4
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 40
CNSTF4 1325400064
ASGNF4
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
LTF4 $275
ADDRLP4 32
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $276
JUMPV
LABELV $275
ADDRLP4 32
ADDRLP4 36
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $276
ADDRLP4 0
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 32
INDIRU4
CVUU1 4
ASGNU1
line 576
;575:
;576:	if ( !( le->leFlags & LEF_PUFF_DONT_SCALE ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $277
line 577
;577:		re->radius = le->radius * ( 1.0 - c ) + 8;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 16
INDIRF4
SUBF4
MULF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 578
;578:	}
LABELV $277
line 580
;579:
;580:	BG_EvaluateTrajectory( &le->pos, cg.time, re->origin );
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 584
;581:
;582:	// if the view would be "inside" the sprite, kill the sprite
;583:	// so it doesn't add too much overdraw
;584:	VectorSubtract( re->origin, cg.refdef.vieworg, delta );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 cg+109252+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRGP4 cg+109252+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRGP4 cg+109252+24+8
INDIRF4
SUBF4
ASGNF4
line 585
;585:	len = VectorLength( delta );
ADDRLP4 4
ARGP4
ADDRLP4 48
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 586
;586:	if ( len < le->radius ) {
ADDRLP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
GEF4 $290
line 587
;587:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 588
;588:		return;
ADDRGP4 $268
JUMPV
LABELV $290
line 591
;589:	}
;590:
;591:	trap_R_AddRefEntityToScene( re );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 592
;592:}
LABELV $268
endproc CG_AddMoveScaleFade 52 12
proc CG_AddScaleFade 48 4
line 604
;593:
;594:
;595:/*
;596:===================
;597:CG_AddScaleFade
;598:
;599:For rocket smokes that hang in place, fade out, and are
;600:removed if the view passes through them.
;601:There are often many of these, so it needs to be simple.
;602:===================
;603:*/
;604:static void CG_AddScaleFade( localEntity_t *le ) {
line 610
;605:	refEntity_t	*re;
;606:	float		c;
;607:	vec3_t		delta;
;608:	float		len;
;609:
;610:	re = &le->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 613
;611:
;612:	// fade / grow time
;613:	c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 615
;614:
;615:	re->shaderRGBA[3] = 0xff * c * le->color[3];
ADDRLP4 32
CNSTF4 1132396544
ADDRLP4 16
INDIRF4
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 36
CNSTF4 1325400064
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
LTF4 $295
ADDRLP4 28
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $296
JUMPV
LABELV $295
ADDRLP4 28
ADDRLP4 32
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $296
ADDRLP4 0
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 28
INDIRU4
CVUU1 4
ASGNU1
line 616
;616:	re->radius = le->radius * ( 1.0 - c ) + 8;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 16
INDIRF4
SUBF4
MULF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 620
;617:
;618:	// if the view would be "inside" the sprite, kill the sprite
;619:	// so it doesn't add too much overdraw
;620:	VectorSubtract( re->origin, cg.refdef.vieworg, delta );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 cg+109252+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRGP4 cg+109252+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRGP4 cg+109252+24+8
INDIRF4
SUBF4
ASGNF4
line 621
;621:	len = VectorLength( delta );
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 44
INDIRF4
ASGNF4
line 623
;622:	// LEILEI
;623:	if (!cg_leiEnhancement.integer) {
ADDRGP4 cg_leiEnhancement+12
INDIRI4
CNSTI4 0
NEI4 $307
line 624
;624:	if ( len < le->radius ) {
ADDRLP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
GEF4 $310
line 625
;625:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 626
;626:		return;
ADDRGP4 $292
JUMPV
LABELV $310
line 628
;627:	}
;628:		}
LABELV $307
line 629
;629:	trap_R_AddRefEntityToScene( re );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 630
;630:}
LABELV $292
endproc CG_AddScaleFade 48 4
proc CG_AddFallScaleFade 52 4
line 643
;631:
;632:
;633:/*
;634:=================
;635:CG_AddFallScaleFade
;636:
;637:This is just an optimized CG_AddMoveScaleFade
;638:For blood mists that drift down, fade out, and are
;639:removed if the view passes through them.
;640:There are often 100+ of these, so it needs to be simple.
;641:=================
;642:*/
;643:static void CG_AddFallScaleFade( localEntity_t *le ) {
line 649
;644:	refEntity_t	*re;
;645:	float		c;
;646:	vec3_t		delta;
;647:	float		len;
;648:
;649:	re = &le->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 652
;650:
;651:	// fade time
;652:	c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 654
;653:
;654:	re->shaderRGBA[3] = 0xff * c * le->color[3];
ADDRLP4 32
CNSTF4 1132396544
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 36
CNSTF4 1325400064
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
LTF4 $315
ADDRLP4 28
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $316
JUMPV
LABELV $315
ADDRLP4 28
ADDRLP4 32
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $316
ADDRLP4 0
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 28
INDIRU4
CVUU1 4
ASGNU1
line 656
;655:
;656:	re->origin[2] = le->pos.trBase[2] - ( 1.0 - c ) * le->pos.trDelta[2];
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 658
;657:
;658:	re->radius = le->radius * ( 1.0 - c ) + 16;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 4
INDIRF4
SUBF4
MULF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 662
;659:
;660:	// if the view would be "inside" the sprite, kill the sprite
;661:	// so it doesn't add too much overdraw
;662:	VectorSubtract( re->origin, cg.refdef.vieworg, delta );
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 cg+109252+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRGP4 cg+109252+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRGP4 cg+109252+24+8
INDIRF4
SUBF4
ASGNF4
line 663
;663:	len = VectorLength( delta );
ADDRLP4 8
ARGP4
ADDRLP4 48
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 666
;664:	
;665:	// LEILEI
;666:if (!cg_leiEnhancement.integer) {
ADDRGP4 cg_leiEnhancement+12
INDIRI4
CNSTI4 0
NEI4 $327
line 667
;667:	if ( len < le->radius ) {
ADDRLP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
GEF4 $330
line 668
;668:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 669
;669:		return;
ADDRGP4 $312
JUMPV
LABELV $330
line 671
;670:	}
;671:	}
LABELV $327
line 672
;672:	trap_R_AddRefEntityToScene( re );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 673
;673:}
LABELV $312
endproc CG_AddFallScaleFade 52 4
proc CG_AddExplosion 20 20
line 682
;674:
;675:
;676:
;677:/*
;678:================
;679:CG_AddExplosion
;680:================
;681:*/
;682:static void CG_AddExplosion( localEntity_t *ex ) {
line 685
;683:	refEntity_t	*ent;
;684:
;685:	ent = &ex->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 688
;686:
;687:	// add the entity
;688:	trap_R_AddRefEntityToScene(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 691
;689:
;690:	// add the dlight
;691:	if ( ex->light ) {
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
CNSTF4 0
EQF4 $333
line 694
;692:		float		light;
;693:
;694:		light = (float)( cg.time - ex->startTime ) / ( ex->endTime - ex->startTime );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 695
;695:		if ( light < 0.5 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
GEF4 $336
line 696
;696:			light = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 697
;697:		} else {
ADDRGP4 $337
JUMPV
LABELV $336
line 698
;698:			light = 1.0 - ( light - 0.5 ) * 2;
ADDRLP4 4
CNSTF4 1065353216
CNSTF4 1073741824
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
SUBF4
ASGNF4
line 699
;699:		}
LABELV $337
line 700
;700:		light = ex->light * light;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 701
;701:		trap_R_AddLightToScene(ent->origin, light, ex->lightColor[0], ex->lightColor[1], ex->lightColor[2] );
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 702
;702:	}
LABELV $333
line 703
;703:}
LABELV $332
endproc CG_AddExplosion 20 20
proc CG_AddSpriteExplosion 216 20
line 710
;704:
;705:/*
;706:================
;707:CG_AddSpriteExplosion
;708:================
;709:*/
;710:static void CG_AddSpriteExplosion( localEntity_t *le ) {
line 714
;711:	refEntity_t	re;
;712:	float c;
;713:
;714:	re = le->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 176
line 716
;715:
;716:	c = ( le->endTime - cg.time ) / ( float ) ( le->endTime - le->startTime );
ADDRLP4 180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 184
ADDRLP4 180
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 176
ADDRLP4 184
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 184
INDIRI4
ADDRLP4 180
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 717
;717:	if ( c > 1 ) {
ADDRLP4 176
INDIRF4
CNSTF4 1065353216
LEF4 $340
line 718
;718:		c = 1.0;	// can happen during connection problems
ADDRLP4 176
CNSTF4 1065353216
ASGNF4
line 719
;719:	}
LABELV $340
line 721
;720:
;721:	re.shaderRGBA[0] = 0xff;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 722
;722:	re.shaderRGBA[1] = 0xff;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 723
;723:	re.shaderRGBA[2] = 0xff;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 724
;724:	re.shaderRGBA[3] = 0xff * c * 0.33;
ADDRLP4 192
CNSTF4 1051260355
CNSTF4 1132396544
ADDRLP4 176
INDIRF4
MULF4
MULF4
ASGNF4
ADDRLP4 196
CNSTF4 1325400064
ASGNF4
ADDRLP4 192
INDIRF4
ADDRLP4 196
INDIRF4
LTF4 $350
ADDRLP4 188
ADDRLP4 192
INDIRF4
ADDRLP4 196
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $351
JUMPV
LABELV $350
ADDRLP4 188
ADDRLP4 192
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $351
ADDRLP4 0+116+3
ADDRLP4 188
INDIRU4
CVUU1 4
ASGNU1
line 726
;725:
;726:	re.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 727
;727:	re.radius = 42 * ( 1.0 - c ) + 30;
ADDRLP4 0+132
CNSTF4 1109917696
CNSTF4 1065353216
ADDRLP4 176
INDIRF4
SUBF4
MULF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 729
;728:
;729:	trap_R_AddRefEntityToScene( &re );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 732
;730:
;731:	// add the dlight
;732:	if ( le->light ) {
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
CNSTF4 0
EQF4 $353
line 735
;733:		float		light;
;734:
;735:		light = (float)( cg.time - le->startTime ) / ( le->endTime - le->startTime );
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
ADDRLP4 204
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 200
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 208
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 204
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 208
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 736
;736:		if ( light < 0.5 ) {
ADDRLP4 200
INDIRF4
CNSTF4 1056964608
GEF4 $356
line 737
;737:			light = 1.0;
ADDRLP4 200
CNSTF4 1065353216
ASGNF4
line 738
;738:		} else {
ADDRGP4 $357
JUMPV
LABELV $356
line 739
;739:			light = 1.0 - ( light - 0.5 ) * 2;
ADDRLP4 200
CNSTF4 1065353216
CNSTF4 1073741824
ADDRLP4 200
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
SUBF4
ASGNF4
line 740
;740:		}
LABELV $357
line 741
;741:		light = le->light * light;
ADDRLP4 200
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ADDRLP4 200
INDIRF4
MULF4
ASGNF4
line 742
;742:		trap_R_AddLightToScene(re.origin, light, le->lightColor[0], le->lightColor[1], le->lightColor[2] );
ADDRLP4 0+68
ARGP4
ADDRLP4 200
INDIRF4
ARGF4
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ARGF4
ADDRLP4 212
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 212
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 743
;743:	}
LABELV $353
line 744
;744:}
LABELV $338
endproc CG_AddSpriteExplosion 216 20
export CG_AddKamikaze
proc CG_AddKamikaze 308 20
line 752
;745:
;746:
;747:/*
;748:====================
;749:CG_AddKamikaze
;750:====================
;751:*/
;752:void CG_AddKamikaze( localEntity_t *le ) {
line 759
;753:	refEntity_t	*re;
;754:	refEntity_t shockwave;
;755:	float		c;
;756:	vec3_t		test, axis[3];
;757:	int			t;
;758:
;759:	re = &le->refEntity;
ADDRLP4 216
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 761
;760:
;761:	t = cg.time - le->startTime;
ADDRLP4 220
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
ASGNI4
line 762
;762:	VectorClear( test );
ADDRLP4 236
CNSTF4 0
ASGNF4
ADDRLP4 224+8
ADDRLP4 236
INDIRF4
ASGNF4
ADDRLP4 224+4
ADDRLP4 236
INDIRF4
ASGNF4
ADDRLP4 224
ADDRLP4 236
INDIRF4
ASGNF4
line 763
;763:	AnglesToAxis( test, axis );
ADDRLP4 224
ARGP4
ADDRLP4 180
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 765
;764:
;765:	if (t > KAMI_SHOCKWAVE_STARTTIME && t < KAMI_SHOCKWAVE_ENDTIME) {
ADDRLP4 220
INDIRI4
CNSTI4 0
LEI4 $363
ADDRLP4 220
INDIRI4
CNSTI4 2000
GEI4 $363
line 767
;766:
;767:		if (!(le->leFlags & LEF_SOUND1)) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $365
line 769
;768://			trap_S_StartSound (re->origin, ENTITYNUM_WORLD, CHAN_AUTO, cgs.media.kamikazeExplodeSound );
;769:			trap_S_StartLocalSound(cgs.media.kamikazeExplodeSound, CHAN_AUTO);
ADDRGP4 cgs+180268+1000
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 770
;770:			le->leFlags |= LEF_SOUND1;
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 244
INDIRP4
ADDRLP4 244
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 771
;771:		}
LABELV $365
line 773
;772:		// 1st kamikaze shockwave
;773:		memset(&shockwave, 0, sizeof(shockwave));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 774
;774:		shockwave.hModel = cgs.media.kamikazeShockWave;
ADDRLP4 4+8
ADDRGP4 cgs+180268+652
INDIRI4
ASGNI4
line 775
;775:		shockwave.reType = RT_MODEL;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 776
;776:		shockwave.shaderTime = re->shaderTime;
ADDRLP4 4+128
ADDRLP4 216
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ASGNF4
line 777
;777:		VectorCopy(re->origin, shockwave.origin);
ADDRLP4 4+68
ADDRLP4 216
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 779
;778:
;779:		c = (float)(t - KAMI_SHOCKWAVE_STARTTIME) / (float)(KAMI_SHOCKWAVE_ENDTIME - KAMI_SHOCKWAVE_STARTTIME);
ADDRLP4 0
ADDRLP4 220
INDIRI4
CVIF4 4
CNSTF4 1157234688
DIVF4
ASGNF4
line 780
;780:		VectorScale( axis[0], c * KAMI_SHOCKWAVE_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[0] );
ADDRLP4 4+28
ADDRLP4 180
INDIRF4
CNSTF4 1151664128
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+4
ADDRLP4 180+4
INDIRF4
CNSTF4 1151664128
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+8
ADDRLP4 180+8
INDIRF4
CNSTF4 1151664128
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
line 781
;781:		VectorScale( axis[1], c * KAMI_SHOCKWAVE_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[1] );
ADDRLP4 4+28+12
ADDRLP4 180+12
INDIRF4
CNSTF4 1151664128
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+12+4
ADDRLP4 180+12+4
INDIRF4
CNSTF4 1151664128
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+12+8
ADDRLP4 180+12+8
INDIRF4
CNSTF4 1151664128
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
line 782
;782:		VectorScale( axis[2], c * KAMI_SHOCKWAVE_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[2] );
ADDRLP4 4+28+24
ADDRLP4 180+24
INDIRF4
CNSTF4 1151664128
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+24+4
ADDRLP4 180+24+4
INDIRF4
CNSTF4 1151664128
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+24+8
ADDRLP4 180+24+8
INDIRF4
CNSTF4 1151664128
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
line 783
;783:		shockwave.nonNormalizedAxes = qtrue;
ADDRLP4 4+64
CNSTI4 1
ASGNI4
line 785
;784:
;785:		if (t > KAMI_SHOCKWAVEFADE_STARTTIME) {
ADDRLP4 220
INDIRI4
CNSTI4 1500
LEI4 $408
line 786
;786:			c = (float)(t - KAMI_SHOCKWAVEFADE_STARTTIME) / (float)(KAMI_SHOCKWAVE_ENDTIME - KAMI_SHOCKWAVEFADE_STARTTIME);
ADDRLP4 0
ADDRLP4 220
INDIRI4
CNSTI4 1500
SUBI4
CVIF4 4
CNSTF4 1140457472
DIVF4
ASGNF4
line 787
;787:		}
ADDRGP4 $409
JUMPV
LABELV $408
line 788
;788:		else {
line 789
;789:			c = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 790
;790:		}
LABELV $409
line 791
;791:		c *= 0xff;
ADDRLP4 0
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 792
;792:		shockwave.shaderRGBA[0] = 0xff - c;
ADDRLP4 248
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 252
CNSTF4 1325400064
ASGNF4
ADDRLP4 248
INDIRF4
ADDRLP4 252
INDIRF4
LTF4 $412
ADDRLP4 244
ADDRLP4 248
INDIRF4
ADDRLP4 252
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $413
JUMPV
LABELV $412
ADDRLP4 244
ADDRLP4 248
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $413
ADDRLP4 4+116
ADDRLP4 244
INDIRU4
CVUU1 4
ASGNU1
line 793
;793:		shockwave.shaderRGBA[1] = 0xff - c;
ADDRLP4 260
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 264
CNSTF4 1325400064
ASGNF4
ADDRLP4 260
INDIRF4
ADDRLP4 264
INDIRF4
LTF4 $417
ADDRLP4 256
ADDRLP4 260
INDIRF4
ADDRLP4 264
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $418
JUMPV
LABELV $417
ADDRLP4 256
ADDRLP4 260
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $418
ADDRLP4 4+116+1
ADDRLP4 256
INDIRU4
CVUU1 4
ASGNU1
line 794
;794:		shockwave.shaderRGBA[2] = 0xff - c;
ADDRLP4 272
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 276
CNSTF4 1325400064
ASGNF4
ADDRLP4 272
INDIRF4
ADDRLP4 276
INDIRF4
LTF4 $422
ADDRLP4 268
ADDRLP4 272
INDIRF4
ADDRLP4 276
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $423
JUMPV
LABELV $422
ADDRLP4 268
ADDRLP4 272
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $423
ADDRLP4 4+116+2
ADDRLP4 268
INDIRU4
CVUU1 4
ASGNU1
line 795
;795:		shockwave.shaderRGBA[3] = 0xff - c;
ADDRLP4 284
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288
CNSTF4 1325400064
ASGNF4
ADDRLP4 284
INDIRF4
ADDRLP4 288
INDIRF4
LTF4 $427
ADDRLP4 280
ADDRLP4 284
INDIRF4
ADDRLP4 288
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $428
JUMPV
LABELV $427
ADDRLP4 280
ADDRLP4 284
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $428
ADDRLP4 4+116+3
ADDRLP4 280
INDIRU4
CVUU1 4
ASGNU1
line 797
;796:
;797:		trap_R_AddRefEntityToScene( &shockwave );
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 798
;798:	}
LABELV $363
line 800
;799:
;800:	if (t > KAMI_EXPLODE_STARTTIME && t < KAMI_IMPLODE_ENDTIME) {
ADDRLP4 220
INDIRI4
CNSTI4 250
LEI4 $429
ADDRLP4 220
INDIRI4
CNSTI4 2250
GEI4 $429
line 802
;801:		// explosion and implosion
;802:		c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 248
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 248
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 803
;803:		c *= 0xff;
ADDRLP4 0
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 804
;804:		re->shaderRGBA[0] = le->color[0] * c;
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 260
CNSTF4 1325400064
ASGNF4
ADDRLP4 256
INDIRF4
ADDRLP4 260
INDIRF4
LTF4 $433
ADDRLP4 252
ADDRLP4 256
INDIRF4
ADDRLP4 260
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $434
JUMPV
LABELV $433
ADDRLP4 252
ADDRLP4 256
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $434
ADDRLP4 216
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 252
INDIRU4
CVUU1 4
ASGNU1
line 805
;805:		re->shaderRGBA[1] = le->color[1] * c;
ADDRLP4 268
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 272
CNSTF4 1325400064
ASGNF4
ADDRLP4 268
INDIRF4
ADDRLP4 272
INDIRF4
LTF4 $436
ADDRLP4 264
ADDRLP4 268
INDIRF4
ADDRLP4 272
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $437
JUMPV
LABELV $436
ADDRLP4 264
ADDRLP4 268
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $437
ADDRLP4 216
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 264
INDIRU4
CVUU1 4
ASGNU1
line 806
;806:		re->shaderRGBA[2] = le->color[2] * c;
ADDRLP4 280
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 284
CNSTF4 1325400064
ASGNF4
ADDRLP4 280
INDIRF4
ADDRLP4 284
INDIRF4
LTF4 $439
ADDRLP4 276
ADDRLP4 280
INDIRF4
ADDRLP4 284
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $440
JUMPV
LABELV $439
ADDRLP4 276
ADDRLP4 280
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $440
ADDRLP4 216
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 276
INDIRU4
CVUU1 4
ASGNU1
line 807
;807:		re->shaderRGBA[3] = le->color[3] * c;
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 296
CNSTF4 1325400064
ASGNF4
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
LTF4 $442
ADDRLP4 288
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $443
JUMPV
LABELV $442
ADDRLP4 288
ADDRLP4 292
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $443
ADDRLP4 216
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 288
INDIRU4
CVUU1 4
ASGNU1
line 809
;808:
;809:		if( t < KAMI_IMPLODE_STARTTIME ) {
ADDRLP4 220
INDIRI4
CNSTI4 2000
GEI4 $444
line 810
;810:			c = (float)(t - KAMI_EXPLODE_STARTTIME) / (float)(KAMI_IMPLODE_STARTTIME - KAMI_EXPLODE_STARTTIME);
ADDRLP4 0
ADDRLP4 220
INDIRI4
CNSTI4 250
SUBI4
CVIF4 4
CNSTF4 1155186688
DIVF4
ASGNF4
line 811
;811:		}
ADDRGP4 $445
JUMPV
LABELV $444
line 812
;812:		else {
line 813
;813:			if (!(le->leFlags & LEF_SOUND2)) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $446
line 815
;814://				trap_S_StartSound (re->origin, ENTITYNUM_WORLD, CHAN_AUTO, cgs.media.kamikazeImplodeSound );
;815:				trap_S_StartLocalSound(cgs.media.kamikazeImplodeSound, CHAN_AUTO);
ADDRGP4 cgs+180268+1004
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 816
;816:				le->leFlags |= LEF_SOUND2;
ADDRLP4 300
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 300
INDIRP4
ADDRLP4 300
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 817
;817:			}
LABELV $446
line 818
;818:			c = (float)(KAMI_IMPLODE_ENDTIME - t) / (float) (KAMI_IMPLODE_ENDTIME - KAMI_IMPLODE_STARTTIME);
ADDRLP4 0
CNSTI4 2250
ADDRLP4 220
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1132068864
DIVF4
ASGNF4
line 819
;819:		}
LABELV $445
line 820
;820:		VectorScale( axis[0], c * KAMI_BOOMSPHERE_MAXRADIUS / KAMI_BOOMSPHEREMODEL_RADIUS, re->axis[0] );
ADDRLP4 216
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 180
INDIRF4
CNSTF4 1144258560
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1116733440
DIVF4
MULF4
ASGNF4
ADDRLP4 216
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 180+4
INDIRF4
CNSTF4 1144258560
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1116733440
DIVF4
MULF4
ASGNF4
ADDRLP4 216
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 180+8
INDIRF4
CNSTF4 1144258560
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1116733440
DIVF4
MULF4
ASGNF4
line 821
;821:		VectorScale( axis[1], c * KAMI_BOOMSPHERE_MAXRADIUS / KAMI_BOOMSPHEREMODEL_RADIUS, re->axis[1] );
ADDRLP4 216
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 180+12
INDIRF4
CNSTF4 1144258560
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1116733440
DIVF4
MULF4
ASGNF4
ADDRLP4 216
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 180+12+4
INDIRF4
CNSTF4 1144258560
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1116733440
DIVF4
MULF4
ASGNF4
ADDRLP4 216
INDIRP4
CNSTI4 48
ADDP4
ADDRLP4 180+12+8
INDIRF4
CNSTF4 1144258560
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1116733440
DIVF4
MULF4
ASGNF4
line 822
;822:		VectorScale( axis[2], c * KAMI_BOOMSPHERE_MAXRADIUS / KAMI_BOOMSPHEREMODEL_RADIUS, re->axis[2] );
ADDRLP4 216
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 180+24
INDIRF4
CNSTF4 1144258560
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1116733440
DIVF4
MULF4
ASGNF4
ADDRLP4 216
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 180+24+4
INDIRF4
CNSTF4 1144258560
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1116733440
DIVF4
MULF4
ASGNF4
ADDRLP4 216
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 180+24+8
INDIRF4
CNSTF4 1144258560
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1116733440
DIVF4
MULF4
ASGNF4
line 823
;823:		re->nonNormalizedAxes = qtrue;
ADDRLP4 216
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 1
ASGNI4
line 825
;824:
;825:		trap_R_AddRefEntityToScene( re );
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 827
;826:		// add the dlight
;827:		trap_R_AddLightToScene( re->origin, c * 1000.0, 1.0, 1.0, c );
ADDRLP4 216
INDIRP4
CNSTI4 68
ADDP4
ARGP4
CNSTF4 1148846080
ADDRLP4 0
INDIRF4
MULF4
ARGF4
ADDRLP4 304
CNSTF4 1065353216
ASGNF4
ADDRLP4 304
INDIRF4
ARGF4
ADDRLP4 304
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 828
;828:	}
LABELV $429
line 830
;829:
;830:	if (t > KAMI_SHOCKWAVE2_STARTTIME && t < KAMI_SHOCKWAVE2_ENDTIME) {
ADDRLP4 220
INDIRI4
CNSTI4 2000
LEI4 $462
ADDRLP4 220
INDIRI4
CNSTI4 3000
GEI4 $462
line 832
;831:		// 2nd kamikaze shockwave
;832:		if (le->angles.trBase[0] == 0 &&
ADDRLP4 252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 256
CNSTF4 0
ASGNF4
ADDRLP4 252
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ADDRLP4 256
INDIRF4
NEF4 $464
ADDRLP4 252
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ADDRLP4 256
INDIRF4
NEF4 $464
ADDRLP4 252
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDRLP4 256
INDIRF4
NEF4 $464
line 834
;833:			le->angles.trBase[1] == 0 &&
;834:			le->angles.trBase[2] == 0) {
line 835
;835:			le->angles.trBase[0] = random() * 360;
ADDRLP4 260
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1135869952
ADDRLP4 260
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
line 836
;836:			le->angles.trBase[1] = random() * 360;
ADDRLP4 264
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1135869952
ADDRLP4 264
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
line 837
;837:			le->angles.trBase[2] = random() * 360;
ADDRLP4 268
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
CNSTF4 1135869952
ADDRLP4 268
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
line 838
;838:		}
ADDRGP4 $465
JUMPV
LABELV $464
line 839
;839:		else {
line 840
;840:			c = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 841
;841:		}
LABELV $465
line 842
;842:		memset(&shockwave, 0, sizeof(shockwave));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 843
;843:		shockwave.hModel = cgs.media.kamikazeShockWave;
ADDRLP4 4+8
ADDRGP4 cgs+180268+652
INDIRI4
ASGNI4
line 844
;844:		shockwave.reType = RT_MODEL;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 845
;845:		shockwave.shaderTime = re->shaderTime;
ADDRLP4 4+128
ADDRLP4 216
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ASGNF4
line 846
;846:		VectorCopy(re->origin, shockwave.origin);
ADDRLP4 4+68
ADDRLP4 216
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 848
;847:
;848:		test[0] = le->angles.trBase[0];
ADDRLP4 224
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 849
;849:		test[1] = le->angles.trBase[1];
ADDRLP4 224+4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 850
;850:		test[2] = le->angles.trBase[2];
ADDRLP4 224+8
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ASGNF4
line 851
;851:		AnglesToAxis( test, axis );
ADDRLP4 224
ARGP4
ADDRLP4 180
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 853
;852:
;853:		c = (float)(t - KAMI_SHOCKWAVE2_STARTTIME) / (float)(KAMI_SHOCKWAVE2_ENDTIME - KAMI_SHOCKWAVE2_STARTTIME);
ADDRLP4 0
ADDRLP4 220
INDIRI4
CNSTI4 2000
SUBI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 854
;854:		VectorScale( axis[0], c * KAMI_SHOCKWAVE2_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[0] );
ADDRLP4 4+28
ADDRLP4 180
INDIRF4
CNSTF4 1143996416
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+4
ADDRLP4 180+4
INDIRF4
CNSTF4 1143996416
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+8
ADDRLP4 180+8
INDIRF4
CNSTF4 1143996416
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
line 855
;855:		VectorScale( axis[1], c * KAMI_SHOCKWAVE2_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[1] );
ADDRLP4 4+28+12
ADDRLP4 180+12
INDIRF4
CNSTF4 1143996416
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+12+4
ADDRLP4 180+12+4
INDIRF4
CNSTF4 1143996416
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+12+8
ADDRLP4 180+12+8
INDIRF4
CNSTF4 1143996416
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
line 856
;856:		VectorScale( axis[2], c * KAMI_SHOCKWAVE2_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[2] );
ADDRLP4 4+28+24
ADDRLP4 180+24
INDIRF4
CNSTF4 1143996416
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+24+4
ADDRLP4 180+24+4
INDIRF4
CNSTF4 1143996416
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
ADDRLP4 4+28+24+8
ADDRLP4 180+24+8
INDIRF4
CNSTF4 1143996416
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1118830592
DIVF4
MULF4
ASGNF4
line 857
;857:		shockwave.nonNormalizedAxes = qtrue;
ADDRLP4 4+64
CNSTI4 1
ASGNI4
line 859
;858:
;859:		if (t > KAMI_SHOCKWAVE2FADE_STARTTIME) {
ADDRLP4 220
INDIRI4
CNSTI4 2500
LEI4 $507
line 860
;860:			c = (float)(t - KAMI_SHOCKWAVE2FADE_STARTTIME) / (float)(KAMI_SHOCKWAVE2_ENDTIME - KAMI_SHOCKWAVE2FADE_STARTTIME);
ADDRLP4 0
ADDRLP4 220
INDIRI4
CNSTI4 2500
SUBI4
CVIF4 4
CNSTF4 1140457472
DIVF4
ASGNF4
line 861
;861:		}
ADDRGP4 $508
JUMPV
LABELV $507
line 862
;862:		else {
line 863
;863:			c = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 864
;864:		}
LABELV $508
line 865
;865:		c *= 0xff;
ADDRLP4 0
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 866
;866:		shockwave.shaderRGBA[0] = 0xff - c;
ADDRLP4 264
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 268
CNSTF4 1325400064
ASGNF4
ADDRLP4 264
INDIRF4
ADDRLP4 268
INDIRF4
LTF4 $511
ADDRLP4 260
ADDRLP4 264
INDIRF4
ADDRLP4 268
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $512
JUMPV
LABELV $511
ADDRLP4 260
ADDRLP4 264
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $512
ADDRLP4 4+116
ADDRLP4 260
INDIRU4
CVUU1 4
ASGNU1
line 867
;867:		shockwave.shaderRGBA[1] = 0xff - c;
ADDRLP4 276
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 280
CNSTF4 1325400064
ASGNF4
ADDRLP4 276
INDIRF4
ADDRLP4 280
INDIRF4
LTF4 $516
ADDRLP4 272
ADDRLP4 276
INDIRF4
ADDRLP4 280
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $517
JUMPV
LABELV $516
ADDRLP4 272
ADDRLP4 276
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $517
ADDRLP4 4+116+1
ADDRLP4 272
INDIRU4
CVUU1 4
ASGNU1
line 868
;868:		shockwave.shaderRGBA[2] = 0xff - c;
ADDRLP4 288
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 292
CNSTF4 1325400064
ASGNF4
ADDRLP4 288
INDIRF4
ADDRLP4 292
INDIRF4
LTF4 $521
ADDRLP4 284
ADDRLP4 288
INDIRF4
ADDRLP4 292
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $522
JUMPV
LABELV $521
ADDRLP4 284
ADDRLP4 288
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $522
ADDRLP4 4+116+2
ADDRLP4 284
INDIRU4
CVUU1 4
ASGNU1
line 869
;869:		shockwave.shaderRGBA[3] = 0xff - c;
ADDRLP4 300
CNSTF4 1132396544
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 304
CNSTF4 1325400064
ASGNF4
ADDRLP4 300
INDIRF4
ADDRLP4 304
INDIRF4
LTF4 $526
ADDRLP4 296
ADDRLP4 300
INDIRF4
ADDRLP4 304
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $527
JUMPV
LABELV $526
ADDRLP4 296
ADDRLP4 300
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $527
ADDRLP4 4+116+3
ADDRLP4 296
INDIRU4
CVUU1 4
ASGNU1
line 871
;870:
;871:		trap_R_AddRefEntityToScene( &shockwave );
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 872
;872:	}
LABELV $462
line 873
;873:}
LABELV $359
endproc CG_AddKamikaze 308 20
export CG_AddInvulnerabilityImpact
proc CG_AddInvulnerabilityImpact 0 4
line 880
;874:
;875:/*
;876:===================
;877:CG_AddInvulnerabilityImpact
;878:===================
;879:*/
;880:void CG_AddInvulnerabilityImpact( localEntity_t *le ) {
line 881
;881:	trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 882
;882:}
LABELV $528
endproc CG_AddInvulnerabilityImpact 0 4
export CG_AddInvulnerabilityJuiced
proc CG_AddInvulnerabilityJuiced 4 4
line 889
;883:
;884:/*
;885:===================
;886:CG_AddInvulnerabilityJuiced
;887:===================
;888:*/
;889:void CG_AddInvulnerabilityJuiced( localEntity_t *le ) {
line 892
;890:	int t;
;891:
;892:	t = cg.time - le->startTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
ASGNI4
line 893
;893:	if ( t > 3000 ) {
ADDRLP4 0
INDIRI4
CNSTI4 3000
LEI4 $531
line 894
;894:		le->refEntity.axis[0][0] = (float) 1.0 + 0.3 * (t - 3000) / 2000;
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1050253722
ADDRLP4 0
INDIRI4
CNSTI4 3000
SUBI4
CVIF4 4
MULF4
CNSTF4 1157234688
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 895
;895:		le->refEntity.axis[1][1] = (float) 1.0 + 0.3 * (t - 3000) / 2000;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1050253722
ADDRLP4 0
INDIRI4
CNSTI4 3000
SUBI4
CVIF4 4
MULF4
CNSTF4 1157234688
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 896
;896:		le->refEntity.axis[2][2] = (float) 0.7 + 0.3 * (2000 - (t - 3000)) / 2000;
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1050253722
CNSTI4 2000
ADDRLP4 0
INDIRI4
CNSTI4 3000
SUBI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1157234688
DIVF4
CNSTF4 1060320051
ADDF4
ASGNF4
line 897
;897:	}
LABELV $531
line 898
;898:	if ( t > 5000 ) {
ADDRLP4 0
INDIRI4
CNSTI4 5000
LEI4 $533
line 899
;899:		le->endTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 900
;900:		CG_GibPlayer( le->refEntity.origin );
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 901
;901:	}
ADDRGP4 $534
JUMPV
LABELV $533
line 902
;902:	else {
line 903
;903:		trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 904
;904:	}
LABELV $534
line 905
;905:}
LABELV $529
endproc CG_AddInvulnerabilityJuiced 4 4
export CG_AddRefEntity
proc CG_AddRefEntity 0 4
line 912
;906:
;907:/*
;908:===================
;909:CG_AddRefEntity
;910:===================
;911:*/
;912:void CG_AddRefEntity( localEntity_t *le ) {
line 913
;913:	if (le->endTime < cg.time) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $536
line 914
;914:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 915
;915:		return;
ADDRGP4 $535
JUMPV
LABELV $536
line 917
;916:	}
;917:	trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 918
;918:}
LABELV $535
endproc CG_AddRefEntity 0 4
lit
align 4
LABELV $540
byte 4 0
byte 4 0
byte 4 1065353216
export CG_AddScorePlum
code
proc CG_AddScorePlum 168 12
line 927
;919:
;920:/*
;921:===================
;922:CG_AddScorePlum
;923:===================
;924:*/
;925:#define NUMBER_SIZE		8
;926:
;927:void CG_AddScorePlum( localEntity_t *le ) {
line 929
;928:	refEntity_t	*re;
;929:	vec3_t		origin, delta, dir, vec, up = {0, 0, 1};
ADDRLP4 112
ADDRGP4 $540
INDIRB
ASGNB 12
line 933
;930:	float		c, len;
;931:	int			i, score, digits[10], numdigits, negative;
;932:
;933:	re = &le->refEntity;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 935
;934:
;935:	c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 128
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 128
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 937
;936:
;937:	score = le->radius;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 938
;938:	if (score < 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $542
line 939
;939:		re->shaderRGBA[0] = 0xff;
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
CNSTU1 255
ASGNU1
line 940
;940:		re->shaderRGBA[1] = 0x11;
ADDRLP4 8
INDIRP4
CNSTI4 117
ADDP4
CNSTU1 17
ASGNU1
line 941
;941:		re->shaderRGBA[2] = 0x11;
ADDRLP4 8
INDIRP4
CNSTI4 118
ADDP4
CNSTU1 17
ASGNU1
line 942
;942:	}
ADDRGP4 $543
JUMPV
LABELV $542
line 943
;943:	else {
line 944
;944:		re->shaderRGBA[0] = 0xff;
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
CNSTU1 255
ASGNU1
line 945
;945:		re->shaderRGBA[1] = 0xff;
ADDRLP4 8
INDIRP4
CNSTI4 117
ADDP4
CNSTU1 255
ASGNU1
line 946
;946:		re->shaderRGBA[2] = 0xff;
ADDRLP4 8
INDIRP4
CNSTI4 118
ADDP4
CNSTU1 255
ASGNU1
line 947
;947:		if (score >= 50) {
ADDRLP4 12
INDIRI4
CNSTI4 50
LTI4 $544
line 948
;948:			re->shaderRGBA[1] = 0;
ADDRLP4 8
INDIRP4
CNSTI4 117
ADDP4
CNSTU1 0
ASGNU1
line 949
;949:		} else if (score >= 20) {
ADDRGP4 $545
JUMPV
LABELV $544
ADDRLP4 12
INDIRI4
CNSTI4 20
LTI4 $546
line 950
;950:			re->shaderRGBA[0] = re->shaderRGBA[1] = 0;
ADDRLP4 136
CNSTU1 0
ASGNU1
ADDRLP4 8
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 136
INDIRU1
ASGNU1
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 136
INDIRU1
ASGNU1
line 951
;951:		} else if (score >= 10) {
ADDRGP4 $547
JUMPV
LABELV $546
ADDRLP4 12
INDIRI4
CNSTI4 10
LTI4 $548
line 952
;952:			re->shaderRGBA[2] = 0;
ADDRLP4 8
INDIRP4
CNSTI4 118
ADDP4
CNSTU1 0
ASGNU1
line 953
;953:		} else if (score >= 2) {
ADDRGP4 $549
JUMPV
LABELV $548
ADDRLP4 12
INDIRI4
CNSTI4 2
LTI4 $550
line 954
;954:			re->shaderRGBA[0] = re->shaderRGBA[2] = 0;
ADDRLP4 136
CNSTU1 0
ASGNU1
ADDRLP4 8
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 136
INDIRU1
ASGNU1
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 136
INDIRU1
ASGNU1
line 955
;955:		}
LABELV $550
LABELV $549
LABELV $547
LABELV $545
line 957
;956:
;957:	}
LABELV $543
line 958
;958:	if (c < 0.25)
ADDRLP4 80
INDIRF4
CNSTF4 1048576000
GEF4 $552
line 959
;959:		re->shaderRGBA[3] = 0xff * 4 * c;
ADDRLP4 136
CNSTF4 1149173760
ADDRLP4 80
INDIRF4
MULF4
ASGNF4
ADDRLP4 140
CNSTF4 1325400064
ASGNF4
ADDRLP4 136
INDIRF4
ADDRLP4 140
INDIRF4
LTF4 $555
ADDRLP4 132
ADDRLP4 136
INDIRF4
ADDRLP4 140
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $556
JUMPV
LABELV $555
ADDRLP4 132
ADDRLP4 136
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $556
ADDRLP4 8
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 132
INDIRU4
CVUU1 4
ASGNU1
ADDRGP4 $553
JUMPV
LABELV $552
line 961
;960:	else
;961:		re->shaderRGBA[3] = 0xff;
ADDRLP4 8
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
LABELV $553
line 963
;962:
;963:	re->radius = NUMBER_SIZE / 2;
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1082130432
ASGNF4
line 965
;964:
;965:	VectorCopy(le->pos.trBase, origin);
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 12
line 966
;966:	origin[2] += 110 - c * 100;
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
CNSTF4 1121714176
CNSTF4 1120403456
ADDRLP4 80
INDIRF4
MULF4
SUBF4
ADDF4
ASGNF4
line 968
;967:
;968:	VectorSubtract(cg.refdef.vieworg, origin, dir);
ADDRLP4 96
ADDRGP4 cg+109252+24
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRLP4 96+4
ADDRGP4 cg+109252+24+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 96+8
ADDRGP4 cg+109252+24+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 969
;969:	CrossProduct(dir, up, vec);
ADDRLP4 96
ARGP4
ADDRLP4 112
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 970
;970:	VectorNormalize(vec);
ADDRLP4 28
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 972
;971:
;972:	VectorMA(origin, -10 + 20 * sin(c * 2 * M_PI), vec, origin);
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 80
INDIRF4
MULF4
MULF4
ARGF4
ADDRLP4 144
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1101004800
ADDRLP4 144
INDIRF4
MULF4
CNSTF4 3240099840
ADDF4
MULF4
ADDF4
ASGNF4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 80
INDIRF4
MULF4
MULF4
ARGF4
ADDRLP4 148
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
CNSTF4 1101004800
ADDRLP4 148
INDIRF4
MULF4
CNSTF4 3240099840
ADDF4
MULF4
ADDF4
ASGNF4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 80
INDIRF4
MULF4
MULF4
ARGF4
ADDRLP4 152
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
CNSTF4 1101004800
ADDRLP4 152
INDIRF4
MULF4
CNSTF4 3240099840
ADDF4
MULF4
ADDF4
ASGNF4
line 976
;973:
;974:	// if the view would be "inside" the sprite, kill the sprite
;975:	// so it doesn't add too much overdraw
;976:	VectorSubtract( origin, cg.refdef.vieworg, delta );
ADDRLP4 84
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109252+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109252+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109252+24+8
INDIRF4
SUBF4
ASGNF4
line 977
;977:	len = VectorLength( delta );
ADDRLP4 84
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 156
INDIRF4
ASGNF4
line 978
;978:	if ( len < 20 ) {
ADDRLP4 124
INDIRF4
CNSTF4 1101004800
GEF4 $588
line 979
;979:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 980
;980:		return;
ADDRGP4 $539
JUMPV
LABELV $588
line 983
;981:	}
;982:
;983:	negative = qfalse;
ADDRLP4 108
CNSTI4 0
ASGNI4
line 984
;984:	if (score < 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $590
line 985
;985:		negative = qtrue;
ADDRLP4 108
CNSTI4 1
ASGNI4
line 986
;986:		score = -score;
ADDRLP4 12
ADDRLP4 12
INDIRI4
NEGI4
ASGNI4
line 987
;987:	}
LABELV $590
line 989
;988:
;989:	for (numdigits = 0; !(numdigits && !score); numdigits++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $595
JUMPV
LABELV $592
line 990
;990:		digits[numdigits] = score % 10;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 10
MODI4
ASGNI4
line 991
;991:		score = score / 10;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 992
;992:	}
LABELV $593
line 989
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $595
ADDRLP4 160
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 160
INDIRI4
EQI4 $592
ADDRLP4 12
INDIRI4
ADDRLP4 160
INDIRI4
NEI4 $592
line 994
;993:
;994:	if (negative) {
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $596
line 995
;995:		digits[numdigits] = 10;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
CNSTI4 10
ASGNI4
line 996
;996:		numdigits++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 997
;997:	}
LABELV $596
line 999
;998:
;999:	for (i = 0; i < numdigits; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $601
JUMPV
LABELV $598
line 1000
;1000:		VectorMA(origin, (float) (((float) numdigits / 2) - i) * NUMBER_SIZE, vec, re->origin);
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1090519040
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1073741824
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
CNSTF4 1090519040
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1073741824
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
CNSTF4 1090519040
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1073741824
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
line 1001
;1001:		re->customShader = cgs.media.numberShaders[digits[numdigits-1-i]];
ADDRLP4 164
CNSTI4 2
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
ADDRLP4 164
INDIRI4
LSHI4
ADDRLP4 40
ADDP4
INDIRI4
ADDRLP4 164
INDIRI4
LSHI4
ADDRGP4 cgs+180268+452
ADDP4
INDIRI4
ASGNI4
line 1002
;1002:		trap_R_AddRefEntityToScene( re );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1003
;1003:	}
LABELV $599
line 999
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $601
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
LTI4 $598
line 1004
;1004:}
LABELV $539
endproc CG_AddScorePlum 168 12
export CG_AddLocalEntities
proc CG_AddLocalEntities 16 8
line 1017
;1005:
;1006:
;1007:
;1008:
;1009://==============================================================================
;1010:
;1011:/*
;1012:===================
;1013:CG_AddLocalEntities
;1014:
;1015:===================
;1016:*/
;1017:void CG_AddLocalEntities( void ) {
line 1022
;1018:	localEntity_t	*le, *next;
;1019:
;1020:	// walk the list backwards, so any new local entities generated
;1021:	// (trails, marks, etc) will be present this frame
;1022:	le = cg_activeLocalEntities.prev;
ADDRLP4 0
ADDRGP4 cg_activeLocalEntities
INDIRP4
ASGNP4
line 1023
;1023:	for ( ; le != &cg_activeLocalEntities ; le = next ) {
ADDRGP4 $612
JUMPV
LABELV $609
line 1026
;1024:		// grab next now, so if the local entity is freed we
;1025:		// still have it
;1026:		next = le->prev;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1028
;1027:
;1028:		if ( cg.time >= le->endTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LTI4 $613
line 1029
;1029:			CG_FreeLocalEntity( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 1030
;1030:			continue;
ADDRGP4 $610
JUMPV
LABELV $613
line 1032
;1031:		}
;1032:		switch ( le->leType ) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $616
ADDRLP4 8
INDIRI4
CNSTI4 13
GTI4 $616
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $634
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $634
address $617
address $622
address $621
address $623
address $624
address $626
address $625
address $627
address $628
address $629
address $630
address $631
address $632
address $633
code
LABELV $616
line 1034
;1033:		default:
;1034:			CG_Error( "Bad leType: %i", le->leType );
ADDRGP4 $619
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1035
;1035:			break;
ADDRGP4 $617
JUMPV
line 1038
;1036:
;1037:		case LE_MARK:
;1038:			break;
LABELV $621
line 1041
;1039:
;1040:		case LE_SPRITE_EXPLOSION:
;1041:			CG_AddSpriteExplosion( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddSpriteExplosion
CALLV
pop
line 1042
;1042:			break;
ADDRGP4 $617
JUMPV
LABELV $622
line 1045
;1043:
;1044:		case LE_EXPLOSION:
;1045:			CG_AddExplosion( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddExplosion
CALLV
pop
line 1046
;1046:			break;
ADDRGP4 $617
JUMPV
LABELV $623
line 1049
;1047:
;1048:		case LE_FRAGMENT:			// gibs and brass
;1049:			CG_AddFragment( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddFragment
CALLV
pop
line 1050
;1050:			break;
ADDRGP4 $617
JUMPV
LABELV $624
line 1053
;1051:
;1052:		case LE_MOVE_SCALE_FADE:		// water bubbles
;1053:			CG_AddMoveScaleFade( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddMoveScaleFade
CALLV
pop
line 1054
;1054:			break;
ADDRGP4 $617
JUMPV
LABELV $625
line 1057
;1055:
;1056:		case LE_FADE_RGB:				// teleporters, railtrails
;1057:			CG_AddFadeRGB( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddFadeRGB
CALLV
pop
line 1058
;1058:			break;
ADDRGP4 $617
JUMPV
LABELV $626
line 1061
;1059:
;1060:		case LE_FALL_SCALE_FADE: // gib blood trails
;1061:			CG_AddFallScaleFade( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddFallScaleFade
CALLV
pop
line 1062
;1062:			break;
ADDRGP4 $617
JUMPV
LABELV $627
line 1065
;1063:
;1064:		case LE_SCALE_FADE:		// rocket trails
;1065:			CG_AddScaleFade( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddScaleFade
CALLV
pop
line 1066
;1066:			break;
ADDRGP4 $617
JUMPV
LABELV $628
line 1069
;1067:
;1068:		case LE_SCOREPLUM:
;1069:			CG_AddScorePlum( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddScorePlum
CALLV
pop
line 1070
;1070:			break;
ADDRGP4 $617
JUMPV
LABELV $629
line 1073
;1071:
;1072:		case LE_KAMIKAZE:
;1073:			CG_AddKamikaze( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddKamikaze
CALLV
pop
line 1074
;1074:			break;
ADDRGP4 $617
JUMPV
LABELV $630
line 1076
;1075:		case LE_INVULIMPACT:
;1076:			CG_AddInvulnerabilityImpact( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddInvulnerabilityImpact
CALLV
pop
line 1077
;1077:			break;
ADDRGP4 $617
JUMPV
LABELV $631
line 1079
;1078:		case LE_INVULJUICED:
;1079:			CG_AddInvulnerabilityJuiced( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddInvulnerabilityJuiced
CALLV
pop
line 1080
;1080:			break;
ADDRGP4 $617
JUMPV
LABELV $632
line 1082
;1081:		case LE_SHOWREFENTITY:
;1082:			CG_AddRefEntity( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddRefEntity
CALLV
pop
line 1083
;1083:			break;
ADDRGP4 $617
JUMPV
LABELV $633
line 1086
;1084:
;1085:		case LE_GORE:			// blood
;1086:			CG_AddGore( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddGore
CALLV
pop
line 1087
;1087:			break;
LABELV $617
line 1089
;1088:		}
;1089:	}
LABELV $610
line 1023
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
LABELV $612
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 cg_activeLocalEntities
CVPU4 4
NEU4 $609
line 1090
;1090:}
LABELV $608
endproc CG_AddLocalEntities 16 8
bss
export cg_freeLocalEntities
align 4
LABELV cg_freeLocalEntities
skip 4
export cg_activeLocalEntities
align 4
LABELV cg_activeLocalEntities
skip 364
export cg_localEntities
align 4
LABELV cg_localEntities
skip 186368
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
LABELV $619
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 108
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $85
byte 1 67
byte 1 71
byte 1 95
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 76
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
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
byte 1 0
