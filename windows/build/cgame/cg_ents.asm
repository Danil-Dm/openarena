export CG_PositionEntityOnTag
code
proc CG_PositionEntityOnTag 84 24
file "../../../code/cgame/cg_ents.c"
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
;23:// cg_ents.c -- present snapshot entities, happens every single frame
;24:
;25:#include "cg_local.h"
;26:
;27:
;28:/*
;29:======================
;30:CG_PositionEntityOnTag
;31:
;32:Modifies the entities position and axis by the given
;33:tag location
;34:======================
;35:*/
;36:void CG_PositionEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;37:							qhandle_t parentModel, char *tagName ) {
line 42
;38:	int				i;
;39:	orientation_t	lerped;
;40:	
;41:	// lerp the tag
;42:	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 52
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 46
;43:		1.0 - parent->backlerp, tagName );
;44:
;45:	// FIXME: allow origin offsets along tag?
;46:	VectorCopy( parent->origin, entity->origin );
ADDRLP4 56
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 47
;47:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $75
line 48
;48:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 49
;49:	}
LABELV $76
line 47
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $75
line 52
;50:
;51:	// had to cast away the const to avoid compiler problems...
;52:	MatrixMultiply( lerped.axis, ((refEntity_t *)parent)->axis, entity->axis );
ADDRLP4 4+12
ARGP4
ADDRLP4 60
CNSTI4 28
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 53
;53:	entity->backlerp = parent->backlerp;
ADDRLP4 64
CNSTI4 100
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 54
;54:}
LABELV $74
endproc CG_PositionEntityOnTag 84 24
export CG_PositionRotatedEntityOnTag
proc CG_PositionRotatedEntityOnTag 120 24
line 66
;55:
;56:
;57:/*
;58:======================
;59:CG_PositionRotatedEntityOnTag
;60:
;61:Modifies the entities position and axis by the given
;62:tag location
;63:======================
;64:*/
;65:void CG_PositionRotatedEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;66:							qhandle_t parentModel, char *tagName ) {
line 73
;67:	int				i;
;68:	orientation_t	lerped;
;69:	vec3_t			tempAxis[3];
;70:
;71://AxisClear( entity->axis );
;72:	// lerp the tag
;73:	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 88
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 77
;74:		1.0 - parent->backlerp, tagName );
;75:
;76:	// FIXME: allow origin offsets along tag?
;77:	VectorCopy( parent->origin, entity->origin );
ADDRLP4 92
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 78
;78:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $81
line 79
;79:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 80
;80:	}
LABELV $82
line 78
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $81
line 83
;81:
;82:	// had to cast away the const to avoid compiler problems...
;83:	MatrixMultiply( entity->axis, lerped.axis, tempAxis );
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 84
;84:	MatrixMultiply( tempAxis, ((refEntity_t *)parent)->axis, entity->axis );
ADDRLP4 52
ARGP4
ADDRLP4 96
CNSTI4 28
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 96
INDIRI4
ADDP
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 85
;85:}
LABELV $80
endproc CG_PositionRotatedEntityOnTag 120 24
export CG_SetEntitySoundPosition
proc CG_SetEntitySoundPosition 24 8
line 104
;86:
;87:
;88:
;89:/*
;90:==========================================================================
;91:
;92:FUNCTIONS CALLED EACH FRAME
;93:
;94:==========================================================================
;95:*/
;96:
;97:/*
;98:======================
;99:CG_SetEntitySoundPosition
;100:
;101:Also called by event processing code
;102:======================
;103:*/
;104:void CG_SetEntitySoundPosition( centity_t *cent ) {
line 105
;105:	if ( cent->currentState.solid == SOLID_BMODEL ) {
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $87
line 109
;106:		vec3_t	origin;
;107:		float	*v;
;108:
;109:		v = cgs.inlineModelMidpoints[ cent->currentState.modelindex ];
ADDRLP4 12
CNSTI4 12
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+38080
ADDP4
ASGNP4
line 110
;110:		VectorAdd( cent->lerpOrigin, v, origin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 776
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
CNSTI4 780
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 111
;111:		trap_S_UpdateEntityPosition( cent->currentState.number, origin );
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_S_UpdateEntityPosition
CALLV
pop
line 112
;112:	} else {
ADDRGP4 $88
JUMPV
LABELV $87
line 113
;113:		trap_S_UpdateEntityPosition( cent->currentState.number, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 trap_S_UpdateEntityPosition
CALLV
pop
line 114
;114:	}
LABELV $88
line 115
;115:}
LABELV $86
endproc CG_SetEntitySoundPosition 24 8
proc CG_EntityEffects 20 20
line 124
;116:
;117:/*
;118:==================
;119:CG_EntityEffects
;120:
;121:Add continuous entity effects, like local entity emission and lighting
;122:==================
;123:*/
;124:static void CG_EntityEffects( centity_t *cent ) {
line 127
;125:
;126:	// update sound origins
;127:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 130
;128:
;129:	// add loop sound
;130:	if ( cent->currentState.loopSound ) {
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $93
line 131
;131:		if (cent->currentState.eType != ET_SPEAKER) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 7
EQI4 $95
line 132
;132:			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36028
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 134
;133:				cgs.gameSounds[ cent->currentState.loopSound ] );
;134:		} else {
ADDRGP4 $96
JUMPV
LABELV $95
line 135
;135:			trap_S_AddRealLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36028
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddRealLoopingSound
CALLV
pop
line 137
;136:				cgs.gameSounds[ cent->currentState.loopSound ] );
;137:		}
LABELV $96
line 138
;138:	}
LABELV $93
line 142
;139:
;140:
;141:	// constant light glow
;142:	if(cent->currentState.constantLight)
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
CNSTI4 0
EQI4 $99
line 143
;143:	{
line 147
;144:		int		cl;
;145:		float		i, r, g, b;
;146:
;147:		cl = cent->currentState.constantLight;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ASGNI4
line 148
;148:		r = (float) (cl & 0xFF) / 255.0;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 1132396544
DIVF4
ASGNF4
line 149
;149:		g = (float) ((cl >> 8) & 0xFF) / 255.0;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 1132396544
DIVF4
ASGNF4
line 150
;150:		b = (float) ((cl >> 16) & 0xFF) / 255.0;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 1132396544
DIVF4
ASGNF4
line 151
;151:		i = (float) ((cl >> 24) & 0xFF) * 4.0;
ADDRLP4 4
CNSTF4 1082130432
ADDRLP4 0
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 255
BANDI4
CVIF4 4
MULF4
ASGNF4
line 152
;152:		trap_R_AddLightToScene(cent->lerpOrigin, i, r, g, b);
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 153
;153:	}
LABELV $99
line 155
;154:
;155:}
LABELV $92
endproc CG_EntityEffects 20 20
proc CG_General 180 12
line 163
;156:
;157:
;158:/*
;159:==================
;160:CG_General
;161:==================
;162:*/
;163:static void CG_General( centity_t *cent ) {
line 167
;164:	refEntity_t			ent;
;165:	entityState_t		*s1;
;166:
;167:	s1 = &cent->currentState;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
line 170
;168:
;169:	// if set to invisible, skip
;170:	if (!s1->modelindex) {
ADDRLP4 176
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 0
NEI4 $102
line 171
;171:		return;
ADDRGP4 $101
JUMPV
LABELV $102
line 174
;172:	}
;173:
;174:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 178
;175:
;176:	// set frame
;177:
;178:	ent.frame = s1->frame;
ADDRLP4 0+80
ADDRLP4 176
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 179
;179:	ent.oldframe = ent.frame;
ADDRLP4 0+96
ADDRLP4 0+80
INDIRI4
ASGNI4
line 180
;180:	ent.backlerp = 0;
ADDRLP4 0+100
CNSTF4 0
ASGNF4
line 182
;181:
;182:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 183
;183:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 185
;184:
;185:	ent.hModel = cgs.gameModels[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 176
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35004
ADDP4
INDIRI4
ASGNI4
line 188
;186:
;187:	// player model
;188:	if (s1->number == cg.snap->ps.clientNum) {
ADDRLP4 176
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $112
line 189
;189:		ent.renderfx |= RF_THIRD_PERSON;	// only draw from mirrors
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 190
;190:	}
LABELV $112
line 193
;191:
;192:	// convert angles to axis
;193:	AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 196
;194:
;195:	// add to refresh list
;196:	trap_R_AddRefEntityToScene (&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 197
;197:}
LABELV $101
endproc CG_General 180 12
proc CG_Speaker 16 16
line 206
;198:
;199:/*
;200:==================
;201:CG_Speaker
;202:
;203:Speaker entities can automatically play sounds
;204:==================
;205:*/
;206:static void CG_Speaker( centity_t *cent ) {
line 207
;207:	if ( ! cent->currentState.clientNum ) {	// FIXME: use something other than clientNum...
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 0
NEI4 $118
line 208
;208:		return;		// not auto triggering
ADDRGP4 $117
JUMPV
LABELV $118
line 211
;209:	}
;210:
;211:	if ( cg.time < cent->miscTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
GEI4 $120
line 212
;212:		return;
ADDRGP4 $117
JUMPV
LABELV $120
line 215
;213:	}
;214:
;215:	trap_S_StartSound (NULL, cent->currentState.number, CHAN_ITEM, cgs.gameSounds[cent->currentState.eventParm] );
CNSTP4 0
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36028
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 219
;216:
;217:	//	ent->s.frame = ent->wait * 10;
;218:	//	ent->s.clientNum = ent->random * 10;
;219:	cent->miscTime = cg.time + cent->currentState.frame * 100 + cent->currentState.clientNum * 100 * crandom();
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 100
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
MULI4
ADDI4
CVIF4 4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
CVIF4 4
CNSTF4 1073741824
ADDRLP4 4
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
ADDF4
CVFI4 4
ASGNI4
line 220
;220:}
LABELV $117
endproc CG_Speaker 16 16
proc CG_Item 408 16
line 227
;221:
;222:/*
;223:==================
;224:CG_Item
;225:==================
;226:*/
;227:static void CG_Item( centity_t *cent ) {
line 236
;228:	refEntity_t		ent;
;229:	entityState_t	*es;
;230:	gitem_t			*item;
;231:	int				msec;
;232:	float			frac;
;233:	float			scale;
;234:	weaponInfo_t	*wi;
;235:
;236:	es = &cent->currentState;
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
line 237
;237:	if ( es->modelindex >= bg_numItems ) {
ADDRLP4 184
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $126
line 238
;238:		CG_Error( "Bad item index %i on entity", es->modelindex );
ADDRGP4 $128
ARGP4
ADDRLP4 184
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 239
;239:	}
LABELV $126
line 242
;240:
;241:	// if set to invisible, skip
;242:	if ( !es->modelindex || ( es->eFlags & EF_NODRAW ) ) {
ADDRLP4 204
CNSTI4 0
ASGNI4
ADDRLP4 184
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 204
INDIRI4
EQI4 $131
ADDRLP4 184
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 204
INDIRI4
EQI4 $129
LABELV $131
line 243
;243:		return;
ADDRGP4 $125
JUMPV
LABELV $129
line 246
;244:	}
;245:
;246:	item = &bg_itemlist[ es->modelindex ];
ADDRLP4 176
CNSTI4 52
ADDRLP4 184
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 247
;247:	if ( cg_simpleItems.integer && item->giType != IT_TEAM ) {
ADDRGP4 cg_simpleItems+12
INDIRI4
CNSTI4 0
EQI4 $132
ADDRLP4 176
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $132
line 248
;248:		memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 249
;249:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 250
;250:		VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 251
;251:		ent.radius = 14;
ADDRLP4 0+132
CNSTF4 1096810496
ASGNF4
line 252
;252:		ent.customShader = cg_items[es->modelindex].icon;
ADDRLP4 0+112
CNSTI4 24
ADDRLP4 184
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ASGNI4
line 253
;253:		ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 254
;254:		ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 255
;255:		ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 256
;256:		ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 257
;257:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 258
;258:		return;
ADDRGP4 $125
JUMPV
LABELV $132
line 262
;259:	}
;260:
;261:	// items bob up and down continuously
;262:	scale = 0.005 + cent->currentState.number * 0.00001;
ADDRLP4 196
CNSTF4 925353388
ADDRFP4 0
INDIRP4
INDIRI4
CVIF4 4
MULF4
CNSTF4 1000593162
ADDF4
ASGNF4
line 263
;263:	cent->lerpOrigin[2] += 4 + cos( ( cg.time + 1000 ) *  scale ) * 4;
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
ADDRLP4 196
INDIRF4
MULF4
ARGF4
ADDRLP4 208
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 212
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
ASGNP4
ADDRLP4 212
INDIRP4
ADDRLP4 212
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 208
INDIRF4
MULF4
CNSTF4 1082130432
ADDF4
ADDF4
ASGNF4
line 265
;264:
;265:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 268
;266:
;267:	// autorotate at one of two speeds
;268:	if ( item->giType == IT_HEALTH ) {
ADDRLP4 176
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 4
NEI4 $147
line 269
;269:		VectorCopy( cg.autoAnglesFast, cent->lerpAngles );
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRGP4 cg+109204
INDIRB
ASGNB 12
line 270
;270:		AxisCopy( cg.autoAxisFast, ent.axis );
ADDRGP4 cg+109216
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 271
;271:	} else {
ADDRGP4 $148
JUMPV
LABELV $147
line 272
;272:		VectorCopy( cg.autoAngles, cent->lerpAngles );
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRGP4 cg+109156
INDIRB
ASGNB 12
line 273
;273:		AxisCopy( cg.autoAxis, ent.axis );
ADDRGP4 cg+109168
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 274
;274:	}
LABELV $148
line 276
;275:
;276:	wi = NULL;
ADDRLP4 180
CNSTP4 0
ASGNP4
line 280
;277:	// the weapons have their origin where they attatch to player
;278:	// models, so we need to offset them or they will rotate
;279:	// eccentricly
;280:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 176
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $155
line 281
;281:		wi = &cg_weapons[item->giTag];
ADDRLP4 180
CNSTI4 172
ADDRLP4 176
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 282
;282:		cent->lerpOrigin[0] -= 
ADDRLP4 216
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ASGNP4
ADDRLP4 216
INDIRP4
ADDRLP4 216
INDIRP4
INDIRF4
ADDRLP4 180
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28
INDIRF4
MULF4
ADDRLP4 180
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12
INDIRF4
MULF4
ADDF4
ADDRLP4 180
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 286
;283:			wi->weaponMidpoint[0] * ent.axis[0][0] +
;284:			wi->weaponMidpoint[1] * ent.axis[1][0] +
;285:			wi->weaponMidpoint[2] * ent.axis[2][0];
;286:		cent->lerpOrigin[1] -= 
ADDRLP4 224
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
ASGNP4
ADDRLP4 224
INDIRP4
ADDRLP4 224
INDIRP4
INDIRF4
ADDRLP4 180
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28+4
INDIRF4
MULF4
ADDRLP4 180
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 180
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24+4
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 290
;287:			wi->weaponMidpoint[0] * ent.axis[0][1] +
;288:			wi->weaponMidpoint[1] * ent.axis[1][1] +
;289:			wi->weaponMidpoint[2] * ent.axis[2][1];
;290:		cent->lerpOrigin[2] -= 
ADDRLP4 232
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
ASGNP4
ADDRLP4 232
INDIRP4
ADDRLP4 232
INDIRP4
INDIRF4
ADDRLP4 180
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28+8
INDIRF4
MULF4
ADDRLP4 180
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 180
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24+8
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 295
;291:			wi->weaponMidpoint[0] * ent.axis[0][2] +
;292:			wi->weaponMidpoint[1] * ent.axis[1][2] +
;293:			wi->weaponMidpoint[2] * ent.axis[2][2];
;294:
;295:		cent->lerpOrigin[2] += 8;	// an extra height boost
ADDRLP4 240
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
ASGNP4
ADDRLP4 240
INDIRP4
ADDRLP4 240
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 296
;296:	}
LABELV $155
line 298
;297:
;298:	ent.hModel = cg_items[es->modelindex].models[0];
ADDRLP4 0+8
CNSTI4 24
ADDRLP4 184
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+4
ADDP4
INDIRI4
ASGNI4
line 300
;299:
;300:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 301
;301:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 303
;302:
;303:	ent.nonNormalizedAxes = qfalse;
ADDRLP4 0+64
CNSTI4 0
ASGNI4
line 306
;304:
;305:	// if just respawned, slowly scale up
;306:	msec = cg.time - cent->miscTime;
ADDRLP4 192
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
SUBI4
ASGNI4
line 307
;307:	if ( msec >= 0 && msec < ITEM_SCALEUP_TIME ) {
ADDRLP4 192
INDIRI4
CNSTI4 0
LTI4 $184
ADDRLP4 192
INDIRI4
CNSTI4 1000
GEI4 $184
line 308
;308:		frac = (float)msec / ITEM_SCALEUP_TIME;
ADDRLP4 188
ADDRLP4 192
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 309
;309:		VectorScale( ent.axis[0], frac, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
line 310
;310:		VectorScale( ent.axis[1], frac, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
line 311
;311:		VectorScale( ent.axis[2], frac, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
line 312
;312:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 313
;313:	} else {
ADDRGP4 $185
JUMPV
LABELV $184
line 314
;314:		frac = 1.0;
ADDRLP4 188
CNSTF4 1065353216
ASGNF4
line 315
;315:	}
LABELV $185
line 319
;316:
;317:	// items without glow textures need to keep a minimum light value
;318:	// so they are always visible
;319:	if ( ( item->giType == IT_WEAPON ) ||
ADDRLP4 220
ADDRLP4 176
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 1
EQI4 $231
ADDRLP4 220
INDIRI4
CNSTI4 3
NEI4 $229
LABELV $231
line 320
;320:		 ( item->giType == IT_ARMOR ) ) {
line 321
;321:		ent.renderfx |= RF_MINLIGHT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 322
;322:	}
LABELV $229
line 325
;323:
;324:	// increase the size of the weapons when they are presented as items
;325:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 176
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $233
line 326
;326:		VectorScale( ent.axis[0], 1.5, ent.axis[0] );
ADDRLP4 0+28
CNSTF4 1069547520
ADDRLP4 0+28
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
CNSTF4 1069547520
ADDRLP4 0+28+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
CNSTF4 1069547520
ADDRLP4 0+28+8
INDIRF4
MULF4
ASGNF4
line 327
;327:		VectorScale( ent.axis[1], 1.5, ent.axis[1] );
ADDRLP4 0+28+12
CNSTF4 1069547520
ADDRLP4 0+28+12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
CNSTF4 1069547520
ADDRLP4 0+28+12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
CNSTF4 1069547520
ADDRLP4 0+28+12+8
INDIRF4
MULF4
ASGNF4
line 328
;328:		VectorScale( ent.axis[2], 1.5, ent.axis[2] );
ADDRLP4 0+28+24
CNSTF4 1069547520
ADDRLP4 0+28+24
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
CNSTF4 1069547520
ADDRLP4 0+28+24+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
CNSTF4 1069547520
ADDRLP4 0+28+24+8
INDIRF4
MULF4
ASGNF4
line 329
;329:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 330
;330:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.weaponHoverSound );
ADDRLP4 224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 224
INDIRP4
INDIRI4
ARGI4
ADDRLP4 224
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+180268+1264
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 331
;331:	}
LABELV $233
line 333
;332:
;333:	if ( item->giType == IT_HOLDABLE && item->giTag == HI_KAMIKAZE ) {
ADDRLP4 176
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 6
NEI4 $280
ADDRLP4 176
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $280
line 334
;334:		VectorScale( ent.axis[0], 2, ent.axis[0] );
ADDRLP4 0+28
CNSTF4 1073741824
ADDRLP4 0+28
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
CNSTF4 1073741824
ADDRLP4 0+28+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
CNSTF4 1073741824
ADDRLP4 0+28+8
INDIRF4
MULF4
ASGNF4
line 335
;335:		VectorScale( ent.axis[1], 2, ent.axis[1] );
ADDRLP4 0+28+12
CNSTF4 1073741824
ADDRLP4 0+28+12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
CNSTF4 1073741824
ADDRLP4 0+28+12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
CNSTF4 1073741824
ADDRLP4 0+28+12+8
INDIRF4
MULF4
ASGNF4
line 336
;336:		VectorScale( ent.axis[2], 2, ent.axis[2] );
ADDRLP4 0+28+24
CNSTF4 1073741824
ADDRLP4 0+28+24
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
CNSTF4 1073741824
ADDRLP4 0+28+24+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
CNSTF4 1073741824
ADDRLP4 0+28+24+8
INDIRF4
MULF4
ASGNF4
line 337
;337:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 338
;338:	}
LABELV $280
line 341
;339:
;340:	// add to refresh list
;341:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 343
;342:
;343:	if ( wi && wi->barrelModel ) {
ADDRLP4 180
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $325
ADDRLP4 180
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $325
line 346
;344:		refEntity_t	barrel;
;345:
;346:		memset( &barrel, 0, sizeof( barrel ) );
ADDRLP4 232
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 348
;347:
;348:		barrel.hModel = wi->barrelModel;
ADDRLP4 232+8
ADDRLP4 180
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 350
;349:
;350:		VectorCopy( ent.lightingOrigin, barrel.lightingOrigin );
ADDRLP4 232+12
ADDRLP4 0+12
INDIRB
ASGNB 12
line 351
;351:		barrel.shadowPlane = ent.shadowPlane;
ADDRLP4 232+24
ADDRLP4 0+24
INDIRF4
ASGNF4
line 352
;352:		barrel.renderfx = ent.renderfx;
ADDRLP4 232+4
ADDRLP4 0+4
INDIRI4
ASGNI4
line 354
;353:
;354:		CG_PositionRotatedEntityOnTag( &barrel, &ent, wi->weaponModel, "tag_barrel" );
ADDRLP4 232
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 180
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 $334
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 356
;355:
;356:		AxisCopy( ent.axis, barrel.axis );
ADDRLP4 0+28
ARGP4
ADDRLP4 232+28
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 357
;357:		barrel.nonNormalizedAxes = ent.nonNormalizedAxes;
ADDRLP4 232+64
ADDRLP4 0+64
INDIRI4
ASGNI4
line 359
;358:
;359:		trap_R_AddRefEntityToScene( &barrel );
ADDRLP4 232
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 360
;360:	}
LABELV $325
line 363
;361:
;362:	// accompanying rings / spheres for powerups
;363:	if ( !cg_simpleItems.integer ) 
ADDRGP4 cg_simpleItems+12
INDIRI4
CNSTI4 0
NEI4 $339
line 364
;364:	{
line 367
;365:		vec3_t spinAngles;
;366:
;367:		VectorClear( spinAngles );
ADDRLP4 244
CNSTF4 0
ASGNF4
ADDRLP4 232+8
ADDRLP4 244
INDIRF4
ASGNF4
ADDRLP4 232+4
ADDRLP4 244
INDIRF4
ASGNF4
ADDRLP4 232
ADDRLP4 244
INDIRF4
ASGNF4
line 369
;368:
;369:		if ( item->giType == IT_HEALTH || item->giType == IT_POWERUP )
ADDRLP4 248
ADDRLP4 176
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 4
EQI4 $346
ADDRLP4 248
INDIRI4
CNSTI4 5
NEI4 $344
LABELV $346
line 370
;370:		{
line 371
;371:			if ( ( ent.hModel = cg_items[es->modelindex].models[1] ) != 0 )
ADDRLP4 252
CNSTI4 24
ADDRLP4 184
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+4+4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 252
INDIRI4
ASGNI4
ADDRLP4 252
INDIRI4
CNSTI4 0
EQI4 $347
line 372
;372:			{
line 373
;373:				if ( item->giType == IT_POWERUP )
ADDRLP4 176
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $352
line 374
;374:				{
line 375
;375:					ent.origin[2] += 12;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 376
;376:					spinAngles[1] = ( cg.time & 1023 ) * 360 / -1024.0f;
ADDRLP4 232+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1023
BANDI4
MULI4
CVIF4 4
CNSTF4 3296722944
DIVF4
ASGNF4
line 377
;377:				}
LABELV $352
line 378
;378:				AnglesToAxis( spinAngles, ent.axis );
ADDRLP4 232
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 381
;379:				
;380:				// scale up if respawning
;381:				if ( frac != 1.0 ) {
ADDRLP4 188
INDIRF4
CNSTF4 1065353216
EQF4 $359
line 382
;382:					VectorScale( ent.axis[0], frac, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
line 383
;383:					VectorScale( ent.axis[1], frac, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
line 384
;384:					VectorScale( ent.axis[2], frac, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 188
INDIRF4
MULF4
ASGNF4
line 385
;385:					ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 386
;386:				}
LABELV $359
line 387
;387:				trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 388
;388:			}
LABELV $347
line 389
;389:		}
LABELV $344
line 390
;390:	}
LABELV $339
line 391
;391:}
LABELV $125
endproc CG_Item 408 16
proc CG_Missile 200 20
line 400
;392:
;393://============================================================================
;394:
;395:/*
;396:===============
;397:CG_Missile
;398:===============
;399:*/
;400:static void CG_Missile( centity_t *cent ) {
line 406
;401:	refEntity_t			ent;
;402:	entityState_t		*s1;
;403:	const weaponInfo_t		*weapon;
;404://	int	col;
;405:
;406:	s1 = &cent->currentState;
ADDRLP4 180
ADDRFP4 0
INDIRP4
ASGNP4
line 407
;407:	if ( s1->weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 180
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 14
LTI4 $405
line 408
;408:		s1->weapon = 0;
ADDRLP4 180
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 409
;409:	}
LABELV $405
line 410
;410:	weapon = &cg_weapons[s1->weapon];
ADDRLP4 176
CNSTI4 172
ADDRLP4 180
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 413
;411:
;412:	// calculate the axis
;413:	VectorCopy( s1->angles, cent->lerpAngles);
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRLP4 180
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 416
;414:
;415:	// add trails
;416:	if ( weapon->missileTrailFunc ) 
ADDRLP4 176
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $407
line 417
;417:	{
line 418
;418:		weapon->missileTrailFunc( cent, weapon );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRLP4 176
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 419
;419:	}
LABELV $407
line 438
;420:/*
;421:	if ( cent->currentState.modelindex == TEAM_RED ) {
;422:		col = 1;
;423:	}
;424:	else if ( cent->currentState.modelindex == TEAM_BLUE ) {
;425:		col = 2;
;426:	}
;427:	else {
;428:		col = 0;
;429:	}
;430:
;431:	// add dynamic light
;432:	if ( weapon->missileDlight ) {
;433:		trap_R_AddLightToScene(cent->lerpOrigin, weapon->missileDlight, 
;434:			weapon->missileDlightColor[col][0], weapon->missileDlightColor[col][1], weapon->missileDlightColor[col][2] );
;435:	}
;436:*/
;437:	// add dynamic light
;438:	if ( weapon->missileDlight ) {
ADDRLP4 176
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
CNSTF4 0
EQF4 $409
line 439
;439:		trap_R_AddLightToScene(cent->lerpOrigin, weapon->missileDlight, 
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 176
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ARGF4
ADDRLP4 176
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ARGF4
ADDRLP4 176
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ARGF4
ADDRLP4 176
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 441
;440:			weapon->missileDlightColor[0], weapon->missileDlightColor[1], weapon->missileDlightColor[2] );
;441:	}
LABELV $409
line 444
;442:
;443:	// add missile sound
;444:	if ( weapon->missileSound ) {
ADDRLP4 176
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
EQI4 $411
line 447
;445:		vec3_t	velocity;
;446:
;447:		BG_EvaluateTrajectoryDelta( &cent->currentState.pos, cg.time, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 184
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 449
;448:
;449:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, velocity, weapon->missileSound );
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
INDIRI4
ARGI4
ADDRLP4 196
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 184
ARGP4
ADDRLP4 176
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 450
;450:	}
LABELV $411
line 453
;451:
;452:	// create the render entity
;453:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 454
;454:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 455
;455:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 457
;456:
;457:	if ( cent->currentState.weapon == WP_PLASMAGUN ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 8
NEI4 $416
line 458
;458:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 459
;459:		ent.radius = 16;
ADDRLP4 0+132
CNSTF4 1098907648
ASGNF4
line 460
;460:		ent.rotation = 0;
ADDRLP4 0+136
CNSTF4 0
ASGNF4
line 461
;461:		ent.customShader = cgs.media.plasmaBallShader;
ADDRLP4 0+112
ADDRGP4 cgs+180268+352
INDIRI4
ASGNI4
line 462
;462:		trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 463
;463:		return;
ADDRGP4 $404
JUMPV
LABELV $416
line 467
;464:	}
;465:
;466:	// flicker between two skins
;467:	ent.skinNum = cg.clientFrame & 1;
ADDRLP4 0+104
ADDRGP4 cg
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 468
;468:	ent.hModel = weapon->missileModel;
ADDRLP4 0+8
ADDRLP4 176
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 469
;469:	ent.renderfx = weapon->missileRenderfx | RF_NOSHADOW;
ADDRLP4 0+4
ADDRLP4 176
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 471
;470:
;471:	if ( cent->currentState.weapon == WP_PROX_LAUNCHER ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
NEI4 $426
line 472
;472:		if (s1->generic1 == TEAM_BLUE) {
ADDRLP4 180
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $428
line 473
;473:			ent.hModel = cgs.media.blueProxMine;
ADDRLP4 0+8
ADDRGP4 cgs+180268+448
INDIRI4
ASGNI4
line 474
;474:		}
LABELV $428
line 475
;475:	}
LABELV $426
line 478
;476:
;477:	// convert direction of travel into axis
;478:	if ( VectorNormalize2( s1->pos.trDelta, ent.axis[0] ) == 0 ) {
ADDRLP4 180
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 184
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 184
INDIRF4
CNSTF4 0
NEF4 $433
line 479
;479:		ent.axis[0][2] = 1;
ADDRLP4 0+28+8
CNSTF4 1065353216
ASGNF4
line 480
;480:	}
LABELV $433
line 483
;481:
;482:	// spin as it moves
;483:	if ( s1->pos.trType != TR_STATIONARY ) {
ADDRLP4 180
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $438
line 484
;484:		RotateAroundDirection( ent.axis, cg.time / 4 );
ADDRLP4 0+28
ARGP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4
DIVI4
CVIF4 4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 485
;485:	} else {
ADDRGP4 $439
JUMPV
LABELV $438
line 486
;486:		if ( s1->weapon == WP_PROX_LAUNCHER ) {
ADDRLP4 180
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
NEI4 $442
line 487
;487:			AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 488
;488:		}
ADDRGP4 $443
JUMPV
LABELV $442
line 490
;489:		else
;490:		{
line 491
;491:			RotateAroundDirection( ent.axis, s1->time );
ADDRLP4 0+28
ARGP4
ADDRLP4 180
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 492
;492:		}
LABELV $443
line 493
;493:	}
LABELV $439
line 496
;494:
;495:	// add to refresh list, possibly with quad glow
;496:	CG_AddRefEntityWithPowerups( &ent, s1, TEAM_FREE, qtrue );
ADDRLP4 0
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 497
;497:}
LABELV $404
endproc CG_Missile 200 20
proc CG_Grapple 188 16
line 506
;498:
;499:/*
;500:===============
;501:CG_Grapple
;502:
;503:This is called when the grapple is sitting up against the wall
;504:===============
;505:*/
;506:static void CG_Grapple( centity_t *cent ) {
line 511
;507:	refEntity_t			ent;
;508:	entityState_t		*s1;
;509:	const weaponInfo_t		*weapon;
;510:
;511:	s1 = &cent->currentState;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
line 512
;512:	if ( s1->weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 176
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 14
LTI4 $447
line 513
;513:		s1->weapon = 0;
ADDRLP4 176
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 514
;514:	}
LABELV $447
line 515
;515:	weapon = &cg_weapons[s1->weapon];
ADDRLP4 180
CNSTI4 172
ADDRLP4 176
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 518
;516:
;517:	// calculate the axis
;518:	VectorCopy( s1->angles, cent->lerpAngles);
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRLP4 176
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 522
;519:
;520: // FIXME add grapple pull sound here..?
;521:	// add missile sound
;522:	if ( weapon->missileSound ) {
ADDRLP4 180
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
EQI4 $449
line 523
;523:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->missileSound );
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 184
INDIRP4
INDIRI4
ARGI4
ADDRLP4 184
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 180
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 524
;524:	}
LABELV $449
line 528
;525:
;526:
;527:	// Will draw cable if needed
;528:	CG_GrappleTrail ( cent, weapon );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
ADDRGP4 CG_GrappleTrail
CALLV
pop
line 531
;529:
;530:	// create the render entity
;531:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 532
;532:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 533
;533:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 536
;534:
;535:	// flicker between two skins
;536:	ent.skinNum = cg.clientFrame & 1;
ADDRLP4 0+104
ADDRGP4 cg
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 537
;537:	ent.hModel = weapon->missileModel;
ADDRLP4 0+8
ADDRLP4 180
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 538
;538:	ent.renderfx = weapon->missileRenderfx | RF_NOSHADOW;
ADDRLP4 0+4
ADDRLP4 180
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 541
;539:
;540:	// convert direction of travel into axis
;541:	if ( VectorNormalize2( s1->pos.trDelta, ent.axis[0] ) == 0 ) {
ADDRLP4 176
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 184
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 184
INDIRF4
CNSTF4 0
NEF4 $456
line 542
;542:		ent.axis[0][2] = 1;
ADDRLP4 0+28+8
CNSTF4 1065353216
ASGNF4
line 543
;543:	}
LABELV $456
line 545
;544:
;545:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 546
;546:}
LABELV $446
endproc CG_Grapple 188 16
proc CG_Mover 180 12
line 553
;547:
;548:/*
;549:===============
;550:CG_Mover
;551:===============
;552:*/
;553:static void CG_Mover( centity_t *cent ) {
line 557
;554:	refEntity_t			ent;
;555:	entityState_t		*s1;
;556:
;557:	s1 = &cent->currentState;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
line 560
;558:
;559:	// create the render entity
;560:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 561
;561:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 562
;562:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 563
;563:	AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 565
;564:
;565:	ent.renderfx = RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 568
;566:
;567:	// flicker between two skins (FIXME?)
;568:	ent.skinNum = ( cg.time >> 6 ) & 1;
ADDRLP4 0+104
ADDRGP4 cg+107604
INDIRI4
CNSTI4 6
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 571
;569:
;570:	// get the model, either as a bmodel or a modelindex
;571:	if ( s1->solid == SOLID_BMODEL ) {
ADDRLP4 176
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $468
line 572
;572:		ent.hModel = cgs.inlineDrawModel[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 176
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+37056
ADDP4
INDIRI4
ASGNI4
line 573
;573:	} else {
ADDRGP4 $469
JUMPV
LABELV $468
line 574
;574:		ent.hModel = cgs.gameModels[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 176
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35004
ADDP4
INDIRI4
ASGNI4
line 575
;575:	}
LABELV $469
line 578
;576:
;577:	// add to refresh list
;578:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 581
;579:
;580:	// add the secondary model
;581:	if ( s1->modelindex2 ) {
ADDRLP4 176
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
EQI4 $474
line 582
;582:		ent.skinNum = 0;
ADDRLP4 0+104
CNSTI4 0
ASGNI4
line 583
;583:		ent.hModel = cgs.gameModels[s1->modelindex2];
ADDRLP4 0+8
ADDRLP4 176
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35004
ADDP4
INDIRI4
ASGNI4
line 584
;584:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 585
;585:	}
LABELV $474
line 587
;586:
;587:}
LABELV $461
endproc CG_Mover 180 12
export CG_Beam
proc CG_Beam 180 12
line 596
;588:
;589:/*
;590:===============
;591:CG_Beam
;592:
;593:Also called as an event
;594:===============
;595:*/
;596:void CG_Beam( centity_t *cent ) {
line 600
;597:	refEntity_t			ent;
;598:	entityState_t		*s1;
;599:
;600:	s1 = &cent->currentState;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
line 603
;601:
;602:	// create the render entity
;603:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 604
;604:	VectorCopy( s1->pos.trBase, ent.origin );
ADDRLP4 0+68
ADDRLP4 176
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 605
;605:	VectorCopy( s1->origin2, ent.oldorigin );
ADDRLP4 0+84
ADDRLP4 176
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 606
;606:	AxisClear( ent.axis );
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 607
;607:	ent.reType = RT_BEAM;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 609
;608:
;609:	ent.renderfx = RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 612
;610:
;611:	// add to refresh list
;612:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 613
;613:}
LABELV $479
endproc CG_Beam 180 12
proc CG_Portal 180 12
line 621
;614:
;615:
;616:/*
;617:===============
;618:CG_Portal
;619:===============
;620:*/
;621:static void CG_Portal( centity_t *cent ) {
line 625
;622:	refEntity_t			ent;
;623:	entityState_t		*s1;
;624:
;625:	s1 = &cent->currentState;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
line 628
;626:
;627:	// create the render entity
;628:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 629
;629:	VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 630
;630:	VectorCopy( s1->origin2, ent.oldorigin );
ADDRLP4 0+84
ADDRLP4 176
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 631
;631:	ByteToDir( s1->eventParm, ent.axis[0] );
ADDRLP4 176
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 0+28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 632
;632:	PerpendicularVector( ent.axis[1], ent.axis[0] );
ADDRLP4 0+28+12
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 636
;633:
;634:	// negating this tends to get the directions like they want
;635:	// we really should have a camera roll value
;636:	VectorSubtract( vec3_origin, ent.axis[1], ent.axis[1] );
ADDRLP4 0+28+12
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0+28+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+28+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+28+12+8
INDIRF4
SUBF4
ASGNF4
line 638
;637:
;638:	CrossProduct( ent.axis[0], ent.axis[1], ent.axis[2] );
ADDRLP4 0+28
ARGP4
ADDRLP4 0+28+12
ARGP4
ADDRLP4 0+28+24
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 639
;639:	ent.reType = RT_PORTALSURFACE;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 640
;640:	ent.oldframe = s1->powerups;
ADDRLP4 0+96
ADDRLP4 176
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 641
;641:	ent.frame = s1->frame;		// rotation speed
ADDRLP4 0+80
ADDRLP4 176
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 642
;642:	ent.skinNum = s1->clientNum/256.0 * 360;	// roll offset
ADDRLP4 0+104
CNSTF4 1135869952
ADDRLP4 176
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
MULF4
CVFI4 4
ASGNI4
line 645
;643:
;644:	// add to refresh list
;645:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 646
;646:}
LABELV $484
endproc CG_Portal 180 12
export CG_CreateRotationMatrix
proc CG_CreateRotationMatrix 4 16
line 653
;647:
;648:/*
;649:================
;650:CG_CreateRotationMatrix
;651:================
;652:*/
;653:void CG_CreateRotationMatrix(vec3_t angles, vec3_t matrix[3]) {
line 654
;654:	AngleVectors(angles, matrix[0], matrix[1], matrix[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 655
;655:	VectorInverse(matrix[1]);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 VectorInverse
CALLV
pop
line 656
;656:}
LABELV $517
endproc CG_CreateRotationMatrix 4 16
export CG_TransposeMatrix
proc CG_TransposeMatrix 24 0
line 663
;657:
;658:/*
;659:================
;660:CG_TransposeMatrix
;661:================
;662:*/
;663:void CG_TransposeMatrix(vec3_t matrix[3], vec3_t transpose[3]) {
line 665
;664:	int i, j;
;665:	for (i = 0; i < 3; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $519
line 666
;666:		for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $523
line 667
;667:			transpose[i][j] = matrix[j][i];
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 16
CNSTI4 12
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRLP4 16
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
ADDP4
ADDP4
INDIRF4
ASGNF4
line 668
;668:		}
LABELV $524
line 666
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $523
line 669
;669:	}
LABELV $520
line 665
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $519
line 670
;670:}
LABELV $518
endproc CG_TransposeMatrix 24 0
export CG_RotatePoint
proc CG_RotatePoint 24 0
line 677
;671:
;672:/*
;673:================
;674:CG_RotatePoint
;675:================
;676:*/
;677:void CG_RotatePoint(vec3_t point, vec3_t matrix[3]) {
line 680
;678:	vec3_t tvec;
;679:
;680:	VectorCopy(point, tvec);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 681
;681:	point[0] = DotProduct(matrix[0], tvec);
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 682
;682:	point[1] = DotProduct(matrix[1], tvec);
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 683
;683:	point[2] = DotProduct(matrix[2], tvec);
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 684
;684:}
LABELV $527
endproc CG_RotatePoint 24 0
export CG_AdjustPositionForMover
proc CG_AdjustPositionForMover 212 12
line 693
;685:
;686:/*
;687:=========================
;688:CG_AdjustPositionForMover
;689:
;690:Also called by client movement prediction code
;691:=========================
;692:*/
;693:void CG_AdjustPositionForMover( const vec3_t in, int moverNum, int fromTime, int toTime, vec3_t out, vec3_t angles_in, vec3_t angles_out ) {
line 700
;694:	centity_t	*cent;
;695:	vec3_t	oldOrigin, origin, deltaOrigin;
;696:	vec3_t	oldAngles, angles, deltaAngles;
;697:	vec3_t	matrix[3], transpose[3];
;698:	vec3_t	org, org2, move2;
;699:
;700:	if ( moverNum <= 0 || moverNum >= ENTITYNUM_MAX_NORMAL ) {
ADDRLP4 184
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
LEI4 $537
ADDRLP4 184
INDIRI4
CNSTI4 1022
LTI4 $535
LABELV $537
line 701
;701:		VectorCopy( in, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 702
;702:		VectorCopy( angles_in, angles_out );
ADDRFP4 24
INDIRP4
ADDRFP4 20
INDIRP4
INDIRB
ASGNB 12
line 703
;703:		return;
ADDRGP4 $534
JUMPV
LABELV $535
line 706
;704:	}
;705:
;706:	cent = &cg_entities[ moverNum ];
ADDRLP4 48
CNSTI4 936
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 707
;707:	if ( cent->currentState.eType != ET_MOVER ) {
ADDRLP4 188
CNSTI4 4
ASGNI4
ADDRLP4 48
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRI4
ADDRLP4 188
INDIRI4
EQI4 $538
line 708
;708:		VectorCopy( in, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 709
;709:		VectorCopy( angles_in, angles_out );
ADDRFP4 24
INDIRP4
ADDRFP4 20
INDIRP4
INDIRB
ASGNB 12
line 710
;710:		return;
ADDRGP4 $534
JUMPV
LABELV $538
line 713
;711:	}
;712:
;713:	BG_EvaluateTrajectory( &cent->currentState.pos, fromTime, oldOrigin );
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 714
;714:	BG_EvaluateTrajectory( &cent->currentState.apos, fromTime, oldAngles );
ADDRLP4 48
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 88
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 716
;715:
;716:	BG_EvaluateTrajectory( &cent->currentState.pos, toTime, origin );
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 76
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 717
;717:	BG_EvaluateTrajectory( &cent->currentState.apos, toTime, angles );
ADDRLP4 48
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 100
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 719
;718:
;719:	VectorSubtract( origin, oldOrigin, deltaOrigin );
ADDRLP4 0
ADDRLP4 76
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 76+4
INDIRF4
ADDRLP4 12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 76+8
INDIRF4
ADDRLP4 12+8
INDIRF4
SUBF4
ASGNF4
line 720
;720:	VectorSubtract( angles, oldAngles, deltaAngles );
ADDRLP4 24
ADDRLP4 100
INDIRF4
ADDRLP4 88
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 100+4
INDIRF4
ADDRLP4 88+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 100+8
INDIRF4
ADDRLP4 88+8
INDIRF4
SUBF4
ASGNF4
line 723
;721:
;722:	// origin change when on a rotating object
;723:	CG_CreateRotationMatrix( deltaAngles, transpose );
ADDRLP4 24
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 CG_CreateRotationMatrix
CALLV
pop
line 724
;724:	CG_TransposeMatrix( transpose, matrix );
ADDRLP4 148
ARGP4
ADDRLP4 112
ARGP4
ADDRGP4 CG_TransposeMatrix
CALLV
pop
line 725
;725:	VectorSubtract( in, oldOrigin, org );
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 192
INDIRP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 192
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
SUBF4
ASGNF4
line 726
;726:	VectorCopy( org, org2 );
ADDRLP4 64
ADDRLP4 36
INDIRB
ASGNB 12
line 727
;727:	CG_RotatePoint( org2, matrix );
ADDRLP4 64
ARGP4
ADDRLP4 112
ARGP4
ADDRGP4 CG_RotatePoint
CALLV
pop
line 728
;728:	VectorSubtract( org2, org, move2 );
ADDRLP4 52
ADDRLP4 64
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
ASGNF4
ADDRLP4 52+4
ADDRLP4 64+4
INDIRF4
ADDRLP4 36+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 52+8
ADDRLP4 64+8
INDIRF4
ADDRLP4 36+8
INDIRF4
SUBF4
ASGNF4
line 729
;729:	VectorAdd( deltaOrigin, move2, deltaOrigin );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 52
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 52+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 52+8
INDIRF4
ADDF4
ASGNF4
line 731
;730:
;731:	VectorAdd( in, deltaOrigin, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 196
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 200
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 200
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 200
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 732
;732:	VectorAdd( angles_in, deltaAngles, angles_out );
ADDRFP4 24
INDIRP4
ADDRFP4 20
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 204
CNSTI4 4
ASGNI4
ADDRFP4 24
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
ADDRFP4 20
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 208
CNSTI4 8
ASGNI4
ADDRFP4 24
INDIRP4
ADDRLP4 208
INDIRI4
ADDP4
ADDRFP4 20
INDIRP4
ADDRLP4 208
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 733
;733:}
LABELV $534
endproc CG_AdjustPositionForMover 212 12
proc CG_InterpolateEntityPosition 44 12
line 740
;734:
;735:/*
;736:=============================
;737:CG_InterpolateEntityPosition
;738:=============================
;739:*/
;740:static void CG_InterpolateEntityPosition( centity_t *cent ) {
line 746
;741:	vec3_t		current, next;
;742:	float		f;
;743:
;744:	// it would be an internal error to find an entity that interpolates without
;745:	// a snapshot ahead of the current one
;746:	if ( cg.nextSnap == NULL ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $573
line 747
;747:		CG_Error( "CG_InterpoateEntityPosition: cg.nextSnap == NULL" );
ADDRGP4 $576
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 748
;748:	}
LABELV $573
line 750
;749:
;750:	f = cg.frameInterpolation;
ADDRLP4 24
ADDRGP4 cg+107588
INDIRF4
ASGNF4
line 754
;751:
;752:	// this will linearize a sine or parabolic curve, but it is important
;753:	// to not extrapolate player positions if more recent data is available
;754:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, current );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 755
;755:	BG_EvaluateTrajectory( &cent->nextState.pos, cg.nextSnap->serverTime, next );
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 757
;756:
;757:	cent->lerpOrigin[0] = current[0] + f * ( next[0] - current[0] );
ADDRLP4 28
ADDRLP4 0
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 758
;758:	cent->lerpOrigin[1] = current[1] + f * ( next[1] - current[1] );
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 759
;759:	cent->lerpOrigin[2] = current[2] + f * ( next[2] - current[2] );
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 761
;760:
;761:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.snap->serverTime, current );
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 762
;762:	BG_EvaluateTrajectory( &cent->nextState.apos, cg.nextSnap->serverTime, next );
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 764
;763:
;764:	cent->lerpAngles[0] = LerpAngle( current[0], next[0], f );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 765
;765:	cent->lerpAngles[1] = LerpAngle( current[1], next[1], f );
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
line 766
;766:	cent->lerpAngles[2] = LerpAngle( current[2], next[2], f );
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
line 768
;767:
;768:}
LABELV $572
endproc CG_InterpolateEntityPosition 44 12
proc CG_CalcEntityLerpPositions 120 28
line 776
;769:
;770:/*
;771:===============
;772:CG_CalcEntityLerpPositions
;773:
;774:===============
;775:*/
;776:static void CG_CalcEntityLerpPositions( centity_t *cent ) {
line 779
;777://unlagged - projectile nudge
;778:	// this will be set to how far forward projectiles will be extrapolated
;779:	int timeshift = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 782
;780://unlagged - projectile nudge
;781:
;782:	if ( cent->interpolate && cent->currentState.pos.trType == TR_INTERPOLATE ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $593
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
NEI4 $593
line 783
;783:		CG_InterpolateEntityPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_InterpolateEntityPosition
CALLV
pop
line 784
;784:		return;
ADDRGP4 $592
JUMPV
LABELV $593
line 789
;785:	}
;786:
;787:	// first see if we can interpolate between two snaps for
;788:	// linear extrapolated clients
;789:	if ( cent->interpolate && cent->currentState.pos.trType == TR_LINEAR_STOP &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $595
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 3
NEI4 $595
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 64
GEI4 $595
line 790
;790:											cent->currentState.number < MAX_CLIENTS) {
line 791
;791:		CG_InterpolateEntityPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_InterpolateEntityPosition
CALLV
pop
line 792
;792:		return;
ADDRGP4 $592
JUMPV
LABELV $595
line 799
;793:	}
;794:
;795://unlagged - timenudge extrapolation
;796:	// interpolating failed (probably no nextSnap), so extrapolate
;797:	// this can also happen if the teleport bit is flipped, but that
;798:	// won't be noticeable
;799:	if ( cent->currentState.number < MAX_CLIENTS &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 64
GEI4 $597
ADDRLP4 12
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $597
line 800
;800:			cent->currentState.clientNum != cg.predictedPlayerState.clientNum ) {
line 801
;801:		cent->currentState.pos.trType = TR_LINEAR_STOP;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 3
ASGNI4
line 802
;802:		cent->currentState.pos.trTime = cg.snap->serverTime;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 803
;803:		cent->currentState.pos.trDuration = 1000 / sv_fps.integer;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 1000
ADDRGP4 sv_fps+12
INDIRI4
DIVI4
ASGNI4
line 804
;804:	}
LABELV $597
line 809
;805://unlagged - timenudge extrapolation
;806:
;807://unlagged - projectile nudge
;808:	// if it's a missile but not a grappling hook
;809:	if ( cent->currentState.eType == ET_MISSILE && cent->currentState.weapon != WP_GRAPPLING_HOOK ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $603
ADDRLP4 16
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
EQI4 $603
line 811
;810:		// if it's one of ours
;811:		if ( cent->currentState.otherEntityNum == cg.clientNum ) {
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRGP4 cg+4
INDIRI4
NEI4 $605
line 815
;812:			// extrapolate one server frame's worth - this will correct for tiny
;813:			// visual inconsistencies introduced by backward-reconciling all players
;814:			// one server frame before running projectiles
;815:			timeshift = 1000 / sv_fps.integer;
ADDRLP4 0
CNSTI4 1000
ADDRGP4 sv_fps+12
INDIRI4
DIVI4
ASGNI4
line 816
;816:		}
ADDRGP4 $606
JUMPV
LABELV $605
line 818
;817:		// if it's not, and it's not a grenade launcher
;818:		else if ( cent->currentState.weapon != WP_GRENADE_LAUNCHER ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 4
EQI4 $609
line 820
;819:			// extrapolate based on cg_projectileNudge
;820:			timeshift = cg_projectileNudge.integer + 1000 / sv_fps.integer;
ADDRLP4 0
ADDRGP4 cg_projectileNudge+12
INDIRI4
CNSTI4 1000
ADDRGP4 sv_fps+12
INDIRI4
DIVI4
ADDI4
ASGNI4
line 821
;821:		}
LABELV $609
LABELV $606
line 822
;822:	}
LABELV $603
line 827
;823:
;824:	// just use the current frame and evaluate as best we can
;825://	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
;826://	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );
;827:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time + timeshift, cent->lerpOrigin );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 828
;828:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time + timeshift, cent->lerpAngles );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 788
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 831
;829:
;830:	// if there's a time shift
;831:	if ( timeshift != 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $615
line 835
;832:		trace_t tr;
;833:		vec3_t lastOrigin;
;834:
;835:		BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, lastOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 837
;836:
;837:		CG_Trace( &tr, lastOrigin, vec3_origin, vec3_origin, cent->lerpOrigin, cent->currentState.number, MASK_SHOT );
ADDRLP4 40
ARGP4
ADDRLP4 28
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
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 840
;838:
;839:		// don't let the projectile go through the floor
;840:		if ( tr.fraction < 1.0f ) {
ADDRLP4 40+8
INDIRF4
CNSTF4 1065353216
GEF4 $618
line 841
;841:			cent->lerpOrigin[0] = lastOrigin[0] + tr.fraction * ( cent->lerpOrigin[0] - lastOrigin[0] );
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ASGNP4
ADDRLP4 108
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 104
INDIRP4
ADDRLP4 108
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 104
INDIRP4
INDIRF4
ADDRLP4 108
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 842
;842:			cent->lerpOrigin[1] = lastOrigin[1] + tr.fraction * ( cent->lerpOrigin[1] - lastOrigin[1] );
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 28+4
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 112
INDIRP4
INDIRF4
ADDRLP4 28+4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 843
;843:			cent->lerpOrigin[2] = lastOrigin[2] + tr.fraction * ( cent->lerpOrigin[2] - lastOrigin[2] );
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 28+8
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 116
INDIRP4
INDIRF4
ADDRLP4 28+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 844
;844:		}
LABELV $618
line 845
;845:	}
LABELV $615
line 850
;846://unlagged - projectile nudge
;847:
;848:	// adjust for riding a mover if it wasn't rolled into the predicted
;849:	// player state
;850:	if ( cent != &cg.predictedPlayerEntity ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cg+108104
CVPU4 4
EQU4 $628
line 851
;851:		CG_AdjustPositionForMover( cent->lerpOrigin, cent->currentState.groundEntityNum, 
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 776
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRLP4 28
INDIRP4
CNSTI4 788
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 853
;852:		cg.snap->serverTime, cg.time, cent->lerpOrigin, cent->lerpAngles, cent->lerpAngles );
;853:	}
LABELV $628
line 854
;854:}
LABELV $592
endproc CG_CalcEntityLerpPositions 120 28
proc CG_TeamBase 256 16
line 861
;855:
;856:/*
;857:===============
;858:CG_TeamBase
;859:===============
;860:*/
;861:static void CG_TeamBase( centity_t *cent ) {
line 867
;862:	refEntity_t model;
;863:	vec3_t angles;
;864:	int t, h;
;865:	float c;
;866:
;867:	if ( CG_UsesTeamFlags(cgs.gametype) ) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 200
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $634
line 869
;868:		// show the flag base
;869:		memset(&model, 0, sizeof(model));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 870
;870:		model.reType = RT_MODEL;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 871
;871:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 872
;872:		VectorCopy( cent->lerpOrigin, model.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 873
;873:		AnglesToAxis( cent->currentState.angles, model.axis );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 874
;874:		if ( cent->currentState.modelindex == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $640
line 875
;875:			model.hModel = cgs.media.redFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+140
INDIRI4
ASGNI4
line 876
;876:		}
ADDRGP4 $641
JUMPV
LABELV $640
line 877
;877:		else if ( cent->currentState.modelindex == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
NEI4 $645
line 878
;878:			model.hModel = cgs.media.blueFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+144
INDIRI4
ASGNI4
line 879
;879:		}
ADDRGP4 $646
JUMPV
LABELV $645
line 880
;880:		else {
line 881
;881:			model.hModel = cgs.media.neutralFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+148
INDIRI4
ASGNI4
line 882
;882:		}
LABELV $646
LABELV $641
line 883
;883:		trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 884
;884:	}
ADDRGP4 $635
JUMPV
LABELV $634
line 885
;885:	else if ( cgs.gametype == GT_OBELISK ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 6
NEI4 $653
line 887
;886:		// show the obelisk
;887:		memset(&model, 0, sizeof(model));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 888
;888:		model.reType = RT_MODEL;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 889
;889:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 890
;890:		VectorCopy( cent->lerpOrigin, model.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 891
;891:		AnglesToAxis( cent->currentState.angles, model.axis );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 893
;892:
;893:		model.hModel = cgs.media.overloadBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+152
INDIRI4
ASGNI4
line 894
;894:		trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 896
;895:		// if hit
;896:		if ( cent->currentState.frame == 1) {
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 1
NEI4 $662
line 899
;897:			// show hit model
;898:			// modelindex2 is the health value of the obelisk
;899:			c = cent->currentState.modelindex2;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 900
;900:			model.shaderRGBA[0] = 0xff;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 901
;901:			model.shaderRGBA[1] = c;
ADDRLP4 208
ADDRLP4 176
INDIRF4
ASGNF4
ADDRLP4 212
CNSTF4 1325400064
ASGNF4
ADDRLP4 208
INDIRF4
ADDRLP4 212
INDIRF4
LTF4 $668
ADDRLP4 204
ADDRLP4 208
INDIRF4
ADDRLP4 212
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $669
JUMPV
LABELV $668
ADDRLP4 204
ADDRLP4 208
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $669
ADDRLP4 0+116+1
ADDRLP4 204
INDIRU4
CVUU1 4
ASGNU1
line 902
;902:			model.shaderRGBA[2] = c;
ADDRLP4 220
ADDRLP4 176
INDIRF4
ASGNF4
ADDRLP4 224
CNSTF4 1325400064
ASGNF4
ADDRLP4 220
INDIRF4
ADDRLP4 224
INDIRF4
LTF4 $673
ADDRLP4 216
ADDRLP4 220
INDIRF4
ADDRLP4 224
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $674
JUMPV
LABELV $673
ADDRLP4 216
ADDRLP4 220
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $674
ADDRLP4 0+116+2
ADDRLP4 216
INDIRU4
CVUU1 4
ASGNU1
line 903
;903:			model.shaderRGBA[3] = 0xff;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 905
;904:			//
;905:			model.hModel = cgs.media.overloadEnergyModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+164
INDIRI4
ASGNI4
line 906
;906:			trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 907
;907:		}
LABELV $662
line 909
;908:		// if respawning
;909:		if ( cent->currentState.frame == 2) {
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 2
NEI4 $680
line 910
;910:			if ( !cent->miscTime ) {
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
CNSTI4 0
NEI4 $682
line 911
;911:				cent->miscTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 912
;912:			}
LABELV $682
line 913
;913:			t = cg.time - cent->miscTime;
ADDRLP4 184
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
SUBI4
ASGNI4
line 914
;914:			h = (cg_obeliskRespawnDelay.integer - 5) * 1000;
ADDRLP4 180
CNSTI4 1000
ADDRGP4 cg_obeliskRespawnDelay+12
INDIRI4
MULI4
CNSTI4 5000
SUBI4
ASGNI4
line 916
;915:			//
;916:			if (t > h) {
ADDRLP4 184
INDIRI4
ADDRLP4 180
INDIRI4
LEI4 $687
line 917
;917:				c = (float) (t - h) / h;
ADDRLP4 204
ADDRLP4 180
INDIRI4
ASGNI4
ADDRLP4 176
ADDRLP4 184
INDIRI4
ADDRLP4 204
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 204
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 918
;918:				if (c > 1)
ADDRLP4 176
INDIRF4
CNSTF4 1065353216
LEF4 $688
line 919
;919:					c = 1;
ADDRLP4 176
CNSTF4 1065353216
ASGNF4
line 920
;920:			}
ADDRGP4 $688
JUMPV
LABELV $687
line 921
;921:			else {
line 922
;922:				c = 0;
ADDRLP4 176
CNSTF4 0
ASGNF4
line 923
;923:			}
LABELV $688
line 925
;924:			// show the lights
;925:			AnglesToAxis( cent->currentState.angles, model.axis );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 927
;926:			//
;927:			model.shaderRGBA[0] = c * 0xff;
ADDRLP4 208
CNSTF4 1132396544
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
ADDRLP4 212
CNSTF4 1325400064
ASGNF4
ADDRLP4 208
INDIRF4
ADDRLP4 212
INDIRF4
LTF4 $694
ADDRLP4 204
ADDRLP4 208
INDIRF4
ADDRLP4 212
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $695
JUMPV
LABELV $694
ADDRLP4 204
ADDRLP4 208
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $695
ADDRLP4 0+116
ADDRLP4 204
INDIRU4
CVUU1 4
ASGNU1
line 928
;928:			model.shaderRGBA[1] = c * 0xff;
ADDRLP4 220
CNSTF4 1132396544
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
ADDRLP4 224
CNSTF4 1325400064
ASGNF4
ADDRLP4 220
INDIRF4
ADDRLP4 224
INDIRF4
LTF4 $699
ADDRLP4 216
ADDRLP4 220
INDIRF4
ADDRLP4 224
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $700
JUMPV
LABELV $699
ADDRLP4 216
ADDRLP4 220
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $700
ADDRLP4 0+116+1
ADDRLP4 216
INDIRU4
CVUU1 4
ASGNU1
line 929
;929:			model.shaderRGBA[2] = c * 0xff;
ADDRLP4 232
CNSTF4 1132396544
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
ADDRLP4 236
CNSTF4 1325400064
ASGNF4
ADDRLP4 232
INDIRF4
ADDRLP4 236
INDIRF4
LTF4 $704
ADDRLP4 228
ADDRLP4 232
INDIRF4
ADDRLP4 236
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $705
JUMPV
LABELV $704
ADDRLP4 228
ADDRLP4 232
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $705
ADDRLP4 0+116+2
ADDRLP4 228
INDIRU4
CVUU1 4
ASGNU1
line 930
;930:			model.shaderRGBA[3] = c * 0xff;
ADDRLP4 244
CNSTF4 1132396544
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
ADDRLP4 248
CNSTF4 1325400064
ASGNF4
ADDRLP4 244
INDIRF4
ADDRLP4 248
INDIRF4
LTF4 $709
ADDRLP4 240
ADDRLP4 244
INDIRF4
ADDRLP4 248
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $710
JUMPV
LABELV $709
ADDRLP4 240
ADDRLP4 244
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $710
ADDRLP4 0+116+3
ADDRLP4 240
INDIRU4
CVUU1 4
ASGNU1
line 932
;931:
;932:			model.hModel = cgs.media.overloadLightsModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+160
INDIRI4
ASGNI4
line 933
;933:			trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 935
;934:			// show the target
;935:			if (t > h) {
ADDRLP4 184
INDIRI4
ADDRLP4 180
INDIRI4
LEI4 $654
line 936
;936:				if ( !cent->muzzleFlashTime ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 0
NEI4 $716
line 937
;937:					trap_S_StartSound (cent->lerpOrigin, ENTITYNUM_NONE, CHAN_BODY,  cgs.media.obeliskRespawnSound);
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+180268+1044
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 938
;938:					cent->muzzleFlashTime = 1;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 1
ASGNI4
line 939
;939:				}
LABELV $716
line 940
;940:				VectorCopy(cent->currentState.angles, angles);
ADDRLP4 188
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 941
;941:				angles[YAW] += (float) 16 * acos(1-c) * 180 / M_PI;
CNSTF4 1065353216
ADDRLP4 176
INDIRF4
SUBF4
ARGF4
ADDRLP4 252
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 188+4
ADDRLP4 188+4
INDIRF4
CNSTF4 1127481344
CNSTF4 1098907648
ADDRLP4 252
INDIRF4
MULF4
MULF4
CNSTF4 1078530011
DIVF4
ADDF4
ASGNF4
line 942
;942:				AnglesToAxis( angles, model.axis );
ADDRLP4 188
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 944
;943:
;944:				VectorScale( model.axis[0], c, model.axis[0]);
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
line 945
;945:				VectorScale( model.axis[1], c, model.axis[1]);
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
line 946
;946:				VectorScale( model.axis[2], c, model.axis[2]);
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ASGNF4
line 948
;947:
;948:				model.shaderRGBA[0] = 0xff;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 949
;949:				model.shaderRGBA[1] = 0xff;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 950
;950:				model.shaderRGBA[2] = 0xff;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 951
;951:				model.shaderRGBA[3] = 0xff;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 953
;952:				//
;953:				model.origin[2] += 56;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1113587712
ADDF4
ASGNF4
line 954
;954:				model.hModel = cgs.media.overloadTargetModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+156
INDIRI4
ASGNI4
line 955
;955:				trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 956
;956:			}
line 957
;957:			else {
line 959
;958:				//FIXME: show animated smoke
;959:			}
line 960
;960:		}
ADDRGP4 $654
JUMPV
LABELV $680
line 961
;961:		else {
line 962
;962:			cent->miscTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTI4 0
ASGNI4
line 963
;963:			cent->muzzleFlashTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 0
ASGNI4
line 965
;964:			// modelindex2 is the health value of the obelisk
;965:			c = cent->currentState.modelindex2;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 966
;966:			model.shaderRGBA[0] = 0xff;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 967
;967:			model.shaderRGBA[1] = c;
ADDRLP4 208
ADDRLP4 176
INDIRF4
ASGNF4
ADDRLP4 212
CNSTF4 1325400064
ASGNF4
ADDRLP4 208
INDIRF4
ADDRLP4 212
INDIRF4
LTF4 $780
ADDRLP4 204
ADDRLP4 208
INDIRF4
ADDRLP4 212
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $781
JUMPV
LABELV $780
ADDRLP4 204
ADDRLP4 208
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $781
ADDRLP4 0+116+1
ADDRLP4 204
INDIRU4
CVUU1 4
ASGNU1
line 968
;968:			model.shaderRGBA[2] = c;
ADDRLP4 220
ADDRLP4 176
INDIRF4
ASGNF4
ADDRLP4 224
CNSTF4 1325400064
ASGNF4
ADDRLP4 220
INDIRF4
ADDRLP4 224
INDIRF4
LTF4 $785
ADDRLP4 216
ADDRLP4 220
INDIRF4
ADDRLP4 224
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $786
JUMPV
LABELV $785
ADDRLP4 216
ADDRLP4 220
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $786
ADDRLP4 0+116+2
ADDRLP4 216
INDIRU4
CVUU1 4
ASGNU1
line 969
;969:			model.shaderRGBA[3] = 0xff;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 971
;970:			// show the lights
;971:			model.hModel = cgs.media.overloadLightsModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+160
INDIRI4
ASGNI4
line 972
;972:			trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 974
;973:			// show the target
;974:			model.origin[2] += 56;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1113587712
ADDF4
ASGNF4
line 975
;975:			model.hModel = cgs.media.overloadTargetModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+156
INDIRI4
ASGNI4
line 976
;976:			trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 977
;977:		}
line 978
;978:	}
ADDRGP4 $654
JUMPV
LABELV $653
line 979
;979:	else if ( cgs.gametype == GT_HARVESTER ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 7
NEI4 $797
line 981
;980:		// show harvester model
;981:		memset(&model, 0, sizeof(model));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 982
;982:		model.reType = RT_MODEL;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 983
;983:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 984
;984:		VectorCopy( cent->lerpOrigin, model.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 985
;985:		AnglesToAxis( cent->currentState.angles, model.axis );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 987
;986:
;987:		if ( cent->currentState.modelindex == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $803
line 988
;988:			model.hModel = cgs.media.harvesterModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+168
INDIRI4
ASGNI4
line 989
;989:			model.customSkin = cgs.media.harvesterRedSkin;
ADDRLP4 0+108
ADDRGP4 cgs+180268+172
INDIRI4
ASGNI4
line 990
;990:		}
ADDRGP4 $804
JUMPV
LABELV $803
line 991
;991:		else if ( cent->currentState.modelindex == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
NEI4 $811
line 992
;992:			model.hModel = cgs.media.harvesterModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+168
INDIRI4
ASGNI4
line 993
;993:			model.customSkin = cgs.media.harvesterBlueSkin;
ADDRLP4 0+108
ADDRGP4 cgs+180268+176
INDIRI4
ASGNI4
line 994
;994:		}
ADDRGP4 $812
JUMPV
LABELV $811
line 995
;995:		else {
line 996
;996:			model.hModel = cgs.media.harvesterNeutralModel;
ADDRLP4 0+8
ADDRGP4 cgs+180268+180
INDIRI4
ASGNI4
line 997
;997:			model.customSkin = 0;
ADDRLP4 0+108
CNSTI4 0
ASGNI4
line 998
;998:		}
LABELV $812
LABELV $804
line 999
;999:		trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1000
;1000:	}
LABELV $797
LABELV $654
LABELV $635
line 1001
;1001:}
LABELV $633
endproc CG_TeamBase 256 16
proc CG_AddCEntity 8 8
line 1009
;1002:
;1003:/*
;1004:===============
;1005:CG_AddCEntity
;1006:
;1007:===============
;1008:*/
;1009:static void CG_AddCEntity( centity_t *cent ) {
line 1011
;1010:	// event-only entities will have been dealt with already
;1011:	if ( cent->currentState.eType >= ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LTI4 $824
line 1012
;1012:		return;
ADDRGP4 $823
JUMPV
LABELV $824
line 1016
;1013:	}
;1014:
;1015:	// calculate the current origin
;1016:	CG_CalcEntityLerpPositions( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 1019
;1017:
;1018:	// add automatic effects
;1019:	CG_EntityEffects( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_EntityEffects
CALLV
pop
line 1021
;1020:
;1021:	switch ( cent->currentState.eType ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $826
ADDRLP4 0
INDIRI4
CNSTI4 12
GTI4 $826
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $841
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $841
address $831
address $832
address $833
address $834
address $835
address $836
address $837
address $838
address $827
address $827
address $827
address $839
address $840
code
LABELV $826
line 1023
;1022:	default:
;1023:		CG_Error( "Bad entity type: %i\n", cent->currentState.eType );
ADDRGP4 $829
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1024
;1024:		break;
ADDRGP4 $827
JUMPV
line 1028
;1025:	case ET_INVISIBLE:
;1026:	case ET_PUSH_TRIGGER:
;1027:	case ET_TELEPORT_TRIGGER:
;1028:		break;
LABELV $831
line 1030
;1029:	case ET_GENERAL:
;1030:		CG_General( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_General
CALLV
pop
line 1031
;1031:		break;
ADDRGP4 $827
JUMPV
LABELV $832
line 1033
;1032:	case ET_PLAYER:
;1033:		CG_Player( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Player
CALLV
pop
line 1034
;1034:		break;
ADDRGP4 $827
JUMPV
LABELV $833
line 1036
;1035:	case ET_ITEM:
;1036:		CG_Item( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Item
CALLV
pop
line 1037
;1037:		break;
ADDRGP4 $827
JUMPV
LABELV $834
line 1039
;1038:	case ET_MISSILE:
;1039:		CG_Missile( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Missile
CALLV
pop
line 1040
;1040:		break;
ADDRGP4 $827
JUMPV
LABELV $835
line 1042
;1041:	case ET_MOVER:
;1042:		CG_Mover( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Mover
CALLV
pop
line 1043
;1043:		break;
ADDRGP4 $827
JUMPV
LABELV $836
line 1045
;1044:	case ET_BEAM:
;1045:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1046
;1046:		break;
ADDRGP4 $827
JUMPV
LABELV $837
line 1048
;1047:	case ET_PORTAL:
;1048:		CG_Portal( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Portal
CALLV
pop
line 1049
;1049:		break;
ADDRGP4 $827
JUMPV
LABELV $838
line 1051
;1050:	case ET_SPEAKER:
;1051:		CG_Speaker( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Speaker
CALLV
pop
line 1052
;1052:		break;
ADDRGP4 $827
JUMPV
LABELV $839
line 1054
;1053:	case ET_GRAPPLE:
;1054:		CG_Grapple( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Grapple
CALLV
pop
line 1055
;1055:		break;
ADDRGP4 $827
JUMPV
LABELV $840
line 1057
;1056:	case ET_TEAM:
;1057:		CG_TeamBase( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_TeamBase
CALLV
pop
line 1058
;1058:		break;
LABELV $827
line 1060
;1059:	}
;1060:}
LABELV $823
endproc CG_AddCEntity 8 8
export CG_AddPacketEntities
proc CG_AddPacketEntities 20 12
line 1068
;1061:
;1062:/*
;1063:===============
;1064:CG_AddPacketEntities
;1065:
;1066:===============
;1067:*/
;1068:void CG_AddPacketEntities( void ) {
line 1074
;1069:	int					num;
;1070:	centity_t			*cent;
;1071:	playerState_t		*ps;
;1072:
;1073:	// set cg.frameInterpolation
;1074:	if ( cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $843
line 1077
;1075:		int		delta;
;1076:
;1077:		delta = (cg.nextSnap->serverTime - cg.snap->serverTime);
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 12
ADDRGP4 cg+40
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1078
;1078:		if ( delta == 0 ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $848
line 1079
;1079:			cg.frameInterpolation = 0;
ADDRGP4 cg+107588
CNSTF4 0
ASGNF4
line 1080
;1080:		} else {
ADDRGP4 $844
JUMPV
LABELV $848
line 1081
;1081:			cg.frameInterpolation = (float)( cg.time - cg.snap->serverTime ) / delta;
ADDRGP4 cg+107588
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 12
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1082
;1082:		}
line 1083
;1083:	} else {
ADDRGP4 $844
JUMPV
LABELV $843
line 1084
;1084:		cg.frameInterpolation = 0;	// actually, it should never be used, because 
ADDRGP4 cg+107588
CNSTF4 0
ASGNF4
line 1086
;1085:									// no entities should be marked as interpolating
;1086:	}
LABELV $844
line 1089
;1087:
;1088:	// the auto-rotating items will all have the same axis
;1089:	cg.autoAngles[0] = 0;
ADDRGP4 cg+109156
CNSTF4 0
ASGNF4
line 1090
;1090:	cg.autoAngles[1] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRGP4 cg+109156+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
MULI4
CVIF4 4
CNSTF4 1157627904
DIVF4
ASGNF4
line 1091
;1091:	cg.autoAngles[2] = 0;
ADDRGP4 cg+109156+8
CNSTF4 0
ASGNF4
line 1093
;1092:
;1093:	cg.autoAnglesFast[0] = 0;
ADDRGP4 cg+109204
CNSTF4 0
ASGNF4
line 1094
;1094:	cg.autoAnglesFast[1] = ( cg.time & 1023 ) * 360 / 1024.0f;
ADDRGP4 cg+109204+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1023
BANDI4
MULI4
CVIF4 4
CNSTF4 1149239296
DIVF4
ASGNF4
line 1095
;1095:	cg.autoAnglesFast[2] = 0;
ADDRGP4 cg+109204+8
CNSTF4 0
ASGNF4
line 1097
;1096:
;1097:	AnglesToAxis( cg.autoAngles, cg.autoAxis );
ADDRGP4 cg+109156
ARGP4
ADDRGP4 cg+109168
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1098
;1098:	AnglesToAxis( cg.autoAnglesFast, cg.autoAxisFast );
ADDRGP4 cg+109204
ARGP4
ADDRGP4 cg+109216
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1101
;1099:
;1100:	// generate and add the entity from the playerstate
;1101:	ps = &cg.predictedPlayerState;
ADDRLP4 8
ADDRGP4 cg+107636
ASGNP4
line 1102
;1102:	BG_PlayerStateToEntityState( ps, &cg.predictedPlayerEntity.currentState, qfalse );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 cg+108104
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1103
;1103:	CG_AddCEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+108104
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 1106
;1104:
;1105:	// lerp the non-predicted value for lightning gun origins
;1106:	CG_CalcEntityLerpPositions( &cg_entities[ cg.snap->ps.clientNum ] );
CNSTI4 936
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 1109
;1107:
;1108://unlagged - early transitioning
;1109:	if ( cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $875
line 1112
;1110:		// pre-add some of the entities sent over by the server
;1111:		// we have data for them and they don't need to interpolate
;1112:		for ( num = 0 ; num < cg.nextSnap->numEntities ; num++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $881
JUMPV
LABELV $878
line 1113
;1113:			cent = &cg_entities[ cg.nextSnap->entities[ num ].number ];
ADDRLP4 0
CNSTI4 936
CNSTI4 208
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+40
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1114
;1114:			if ( cent->nextState.eType == ET_MISSILE || cent->nextState.eType == ET_GENERAL ) {
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 3
EQI4 $886
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $884
LABELV $886
line 1116
;1115:				// transition it immediately and add it
;1116:				CG_TransitionEntity( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_TransitionEntity
CALLV
pop
line 1117
;1117:				cent->interpolate = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 1
ASGNI4
line 1118
;1118:				CG_AddCEntity( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 1119
;1119:			}
LABELV $884
line 1120
;1120:		}
LABELV $879
line 1112
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $881
ADDRLP4 4
INDIRI4
ADDRGP4 cg+40
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $878
line 1121
;1121:	}
LABELV $875
line 1125
;1122://unlagged - early transitioning
;1123:
;1124:	// add each entity sent over by the server
;1125:	for ( num = 0 ; num < cg.snap->numEntities ; num++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $890
JUMPV
LABELV $887
line 1126
;1126:		cent = &cg_entities[ cg.snap->entities[ num ].number ];
ADDRLP4 0
CNSTI4 936
CNSTI4 208
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1128
;1127://unlagged - early transitioning
;1128:		if ( !cg.nextSnap || (cent->nextState.eType != ET_MISSILE && cent->nextState.eType != ET_GENERAL) ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $896
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 3
EQI4 $893
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $893
LABELV $896
line 1130
;1129://unlagged - early transitioning
;1130:			CG_AddCEntity( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 1131
;1131:		} //Also unlagged
LABELV $893
line 1132
;1132:	}
LABELV $888
line 1125
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $890
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $887
line 1133
;1133:}
LABELV $842
endproc CG_AddPacketEntities 20 12
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
LABELV $829
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $576
byte 1 67
byte 1 71
byte 1 95
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 112
byte 1 111
byte 1 97
byte 1 116
byte 1 101
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 80
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $334
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $128
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
