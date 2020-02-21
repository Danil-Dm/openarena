export CG_BuildSolidList
code
proc CG_BuildSolidList 28 0
file "../../../code/cgame/cg_predict.c"
line 46
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
;23:// cg_predict.c -- this file generates cg.predictedPlayerState by either
;24:// interpolating between snapshots from the server or locally predicting
;25:// ahead the client's movement.
;26:// It also handles local physics interaction, like fragments bouncing off walls
;27:
;28:#include "cg_local.h"
;29:
;30:static	pmove_t		cg_pmove;
;31:
;32:static	int			cg_numSolidEntities;
;33:static	centity_t	*cg_solidEntities[MAX_ENTITIES_IN_SNAPSHOT];
;34:static	int			cg_numTriggerEntities;
;35:static	centity_t	*cg_triggerEntities[MAX_ENTITIES_IN_SNAPSHOT];
;36:
;37:/*
;38:====================
;39:CG_BuildSolidList
;40:
;41:When a new cg.snap has been set, this function builds a sublist
;42:of the entities that are actually solid, to make for more
;43:efficient collision detection
;44:====================
;45:*/
;46:void CG_BuildSolidList( void ) {
line 52
;47:	int			i;
;48:	centity_t	*cent;
;49:	snapshot_t	*snap;
;50:	entityState_t	*ent;
;51:
;52:	cg_numSolidEntities = 0;
ADDRGP4 cg_numSolidEntities
CNSTI4 0
ASGNI4
line 53
;53:	cg_numTriggerEntities = 0;
ADDRGP4 cg_numTriggerEntities
CNSTI4 0
ASGNI4
line 55
;54:
;55:	if ( cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $75
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 cg+107596
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $75
ADDRGP4 cg+107592
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $75
line 56
;56:		snap = cg.nextSnap;
ADDRLP4 12
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 57
;57:	} else {
ADDRGP4 $76
JUMPV
LABELV $75
line 58
;58:		snap = cg.snap;
ADDRLP4 12
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 59
;59:	}
LABELV $76
line 61
;60:
;61:	for ( i = 0 ; i < snap->numEntities ; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $85
JUMPV
LABELV $82
line 62
;62:		cent = &cg_entities[ snap->entities[ i ].number ];
ADDRLP4 0
CNSTI4 936
CNSTI4 208
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 63
;63:		ent = &cent->currentState;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 65
;64:
;65:		if ( ent->eType == ET_ITEM || ent->eType == ET_PUSH_TRIGGER || ent->eType == ET_TELEPORT_TRIGGER ) {
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $89
ADDRLP4 20
INDIRI4
CNSTI4 8
EQI4 $89
ADDRLP4 20
INDIRI4
CNSTI4 9
NEI4 $86
LABELV $89
line 66
;66:			cg_triggerEntities[cg_numTriggerEntities] = cent;
ADDRGP4 cg_numTriggerEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 67
;67:			cg_numTriggerEntities++;
ADDRLP4 24
ADDRGP4 cg_numTriggerEntities
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 68
;68:			continue;
ADDRGP4 $83
JUMPV
LABELV $86
line 71
;69:		}
;70:
;71:		if ( cent->nextState.solid ) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $90
line 72
;72:			cg_solidEntities[cg_numSolidEntities] = cent;
ADDRGP4 cg_numSolidEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 73
;73:			cg_numSolidEntities++;
ADDRLP4 24
ADDRGP4 cg_numSolidEntities
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 74
;74:			continue;
LABELV $90
line 76
;75:		}
;76:	}
LABELV $83
line 61
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $85
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $82
line 77
;77:}
LABELV $74
endproc CG_BuildSolidList 28 0
proc CG_ClipMoveToEntities 144 36
line 86
;78:
;79:/*
;80:====================
;81:CG_ClipMoveToEntities
;82:
;83:====================
;84:*/
;85:static void CG_ClipMoveToEntities ( const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end,
;86:							int skipNumber, int mask, trace_t *tr ) {
line 95
;87:	int			i, x, zd, zu;
;88:	trace_t		trace;
;89:	entityState_t	*ent;
;90:	clipHandle_t 	cmodel;
;91:	vec3_t		bmins, bmaxs;
;92:	vec3_t		origin, angles;
;93:	centity_t	*cent;
;94:
;95:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 $96
JUMPV
LABELV $93
line 96
;96:		cent = cg_solidEntities[ i ];
ADDRLP4 60
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 97
;97:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
line 99
;98:
;99:		if ( ent->number == skipNumber ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 16
INDIRI4
NEI4 $97
line 100
;100:			continue;
ADDRGP4 $94
JUMPV
LABELV $97
line 103
;101:		}
;102:
;103:		if ( ent->solid == SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $99
line 105
;104:			// special value for bmodel
;105:			cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 132
INDIRI4
ASGNI4
line 106
;106:			VectorCopy( cent->lerpAngles, angles );
ADDRLP4 108
ADDRLP4 60
INDIRP4
CNSTI4 788
ADDP4
INDIRB
ASGNB 12
line 107
;107:			BG_EvaluateTrajectory( &cent->currentState.pos, cg.physicsTime, origin );
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 108
;108:		} else {
ADDRGP4 $100
JUMPV
LABELV $99
line 110
;109:			// encoded bbox
;110:			x = (ent->solid & 255);
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 111
;111:			zd = ((ent->solid>>8) & 255);
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 112
;112:			zu = ((ent->solid>>16) & 255) - 32;
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CNSTI4 32
SUBI4
ASGNI4
line 114
;113:
;114:			bmins[0] = bmins[1] = -x;
ADDRLP4 132
ADDRLP4 120
INDIRI4
NEGI4
CVIF4 4
ASGNF4
ADDRLP4 72+4
ADDRLP4 132
INDIRF4
ASGNF4
ADDRLP4 72
ADDRLP4 132
INDIRF4
ASGNF4
line 115
;115:			bmaxs[0] = bmaxs[1] = x;
ADDRLP4 136
ADDRLP4 120
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 84+4
ADDRLP4 136
INDIRF4
ASGNF4
ADDRLP4 84
ADDRLP4 136
INDIRF4
ASGNF4
line 116
;116:			bmins[2] = -zd;
ADDRLP4 72+8
ADDRLP4 124
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 117
;117:			bmaxs[2] = zu;
ADDRLP4 84+8
ADDRLP4 128
INDIRI4
CVIF4 4
ASGNF4
line 119
;118:
;119:			cmodel = trap_CM_TempBoxModel( bmins, bmaxs );
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 140
ADDRGP4 trap_CM_TempBoxModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 140
INDIRI4
ASGNI4
line 120
;120:			VectorCopy( vec3_origin, angles );
ADDRLP4 108
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 121
;121:			VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 96
ADDRLP4 60
INDIRP4
CNSTI4 776
ADDP4
INDIRB
ASGNB 12
line 122
;122:		}
LABELV $100
line 125
;123:
;124:
;125:		trap_CM_TransformedBoxTrace ( &trace, start, end,
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRGP4 trap_CM_TransformedBoxTrace
CALLV
pop
line 128
;126:			mins, maxs, cmodel,  mask, origin, angles);
;127:
;128:		if (trace.allsolid || trace.fraction < tr->fraction) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $109
ADDRLP4 4+8
INDIRF4
ADDRFP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GEF4 $106
LABELV $109
line 129
;129:			trace.entityNum = ent->number;
ADDRLP4 4+52
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 130
;130:			*tr = trace;
ADDRFP4 24
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 56
line 131
;131:		} else if (trace.startsolid) {
ADDRGP4 $107
JUMPV
LABELV $106
ADDRLP4 4+4
INDIRI4
CNSTI4 0
EQI4 $111
line 132
;132:			tr->startsolid = qtrue;
ADDRFP4 24
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 133
;133:		}
LABELV $111
LABELV $107
line 134
;134:		if ( tr->allsolid ) {
ADDRFP4 24
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $114
line 135
;135:			return;
ADDRGP4 $92
JUMPV
LABELV $114
line 137
;136:		}
;137:	}
LABELV $94
line 95
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $96
ADDRLP4 64
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $93
line 138
;138:}
LABELV $92
endproc CG_ClipMoveToEntities 144 36
export CG_Trace
proc CG_Trace 60 28
line 146
;139:
;140:/*
;141:================
;142:CG_Trace
;143:================
;144:*/
;145:void	CG_Trace( trace_t *result, const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end, 
;146:					 int skipNumber, int mask ) {
line 149
;147:	trace_t	t;
;148:
;149:	trap_CM_BoxTrace ( &t, start, end, mins, maxs, 0, mask);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 150
;150:	t.entityNum = t.fraction != 1.0 ? ENTITYNUM_WORLD : ENTITYNUM_NONE;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $120
ADDRLP4 56
CNSTI4 1022
ASGNI4
ADDRGP4 $121
JUMPV
LABELV $120
ADDRLP4 56
CNSTI4 1023
ASGNI4
LABELV $121
ADDRLP4 0+52
ADDRLP4 56
INDIRI4
ASGNI4
line 152
;151:	// check all other solid models
;152:	CG_ClipMoveToEntities (start, mins, maxs, end, skipNumber, mask, &t);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ClipMoveToEntities
CALLV
pop
line 154
;153:
;154:	*result = t;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 56
line 155
;155:}
LABELV $116
endproc CG_Trace 60 28
export CG_PointContents
proc CG_PointContents 36 16
line 162
;156:
;157:/*
;158:================
;159:CG_PointContents
;160:================
;161:*/
;162:int		CG_PointContents( const vec3_t point, int passEntityNum ) {
line 169
;163:	int			i;
;164:	entityState_t	*ent;
;165:	centity_t	*cent;
;166:	clipHandle_t cmodel;
;167:	int			contents;
;168:
;169:	contents = trap_CM_PointContents (point, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 171
;170:
;171:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $126
JUMPV
LABELV $123
line 172
;172:		cent = cg_solidEntities[ i ];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 174
;173:
;174:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 176
;175:
;176:		if ( ent->number == passEntityNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $127
line 177
;177:			continue;
ADDRGP4 $124
JUMPV
LABELV $127
line 180
;178:		}
;179:
;180:		if (ent->solid != SOLID_BMODEL) { // special value for bmodel
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $129
line 181
;181:			continue;
ADDRGP4 $124
JUMPV
LABELV $129
line 184
;182:		}
;183:
;184:		cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 185
;185:		if ( !cmodel ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $131
line 186
;186:			continue;
ADDRGP4 $124
JUMPV
LABELV $131
line 189
;187:		}
;188:
;189:		contents |= trap_CM_TransformedPointContents( point, cmodel, cent->lerpOrigin, cent->lerpAngles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 788
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_CM_TransformedPointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
BORI4
ASGNI4
line 190
;190:	}
LABELV $124
line 171
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $126
ADDRLP4 8
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $123
line 192
;191:
;192:	return contents;
ADDRLP4 16
INDIRI4
RETI4
LABELV $122
endproc CG_PointContents 36 16
proc CG_InterpolatePlayerState 64 12
line 204
;193:}
;194:
;195:
;196:/*
;197:========================
;198:CG_InterpolatePlayerState
;199:
;200:Generates cg.predictedPlayerState by interpolating between
;201:cg.snap->player_state and cg.nextFrame->player_state
;202:========================
;203:*/
;204:static void CG_InterpolatePlayerState( qboolean grabAngles ) {
line 210
;205:	float			f;
;206:	int				i;
;207:	playerState_t	*out;
;208:	snapshot_t		*prev, *next;
;209:
;210:	out = &cg.predictedPlayerState;
ADDRLP4 12
ADDRGP4 cg+107636
ASGNP4
line 211
;211:	prev = cg.snap;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 212
;212:	next = cg.nextSnap;
ADDRLP4 8
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 214
;213:
;214:	*out = cg.snap->ps;
ADDRLP4 12
INDIRP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 217
;215:
;216:	// if we are still allowing local input, short circuit the view angles
;217:	if ( grabAngles ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $138
line 221
;218:		usercmd_t	cmd;
;219:		int			cmdNum;
;220:
;221:		cmdNum = trap_GetCurrentCmdNumber();
ADDRLP4 48
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 48
INDIRI4
ASGNI4
line 222
;222:		trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 224
;223:
;224:		PM_UpdateViewAngles( out, &cmd );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 225
;225:	}
LABELV $138
line 228
;226:
;227:	// if the next frame is a teleport, we can't lerp to it
;228:	if ( cg.nextFrameTeleport ) {
ADDRGP4 cg+107596
INDIRI4
CNSTI4 0
EQI4 $140
line 229
;229:		return;
ADDRGP4 $133
JUMPV
LABELV $140
line 232
;230:	}
;231:
;232:	if ( !next || next->serverTime <= prev->serverTime ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $145
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
GTI4 $143
LABELV $145
line 233
;233:		return;
ADDRGP4 $133
JUMPV
LABELV $143
line 236
;234:	}
;235:
;236:	f = (float)( cg.time - prev->serverTime ) / ( next->serverTime - prev->serverTime );
ADDRLP4 28
CNSTI4 8
ASGNI4
ADDRLP4 32
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 238
;237:
;238:	i = next->ps.bobCycle;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
line 239
;239:	if ( i < prev->ps.bobCycle ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
GEI4 $147
line 240
;240:		i += 256;		// handle wraparound
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
ADDI4
ASGNI4
line 241
;241:	}
LABELV $147
line 242
;242:	out->bobCycle = prev->ps.bobCycle + f * ( i - prev->ps.bobCycle );
ADDRLP4 36
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 244
;243:
;244:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $149
line 245
;245:		out->origin[i] = prev->ps.origin[i] + f * (next->ps.origin[i] - prev->ps.origin[i] );
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 44
CNSTI4 64
ASGNI4
ADDRLP4 48
ADDRLP4 40
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ADDRLP4 48
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 40
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDP4
INDIRF4
ADDRLP4 48
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 246
;246:		if ( !grabAngles ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $153
line 247
;247:			out->viewangles[i] = LerpAngle( 
ADDRLP4 52
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
CNSTI4 196
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRLP4 52
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 152
ADDP4
ADDP4
ADDRLP4 60
INDIRF4
ASGNF4
line 249
;248:				prev->ps.viewangles[i], next->ps.viewangles[i], f );
;249:		}
LABELV $153
line 250
;250:		out->velocity[i] = prev->ps.velocity[i] + 
ADDRLP4 52
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
CNSTI4 76
ASGNI4
ADDRLP4 60
ADDRLP4 52
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 60
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 52
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 252
;251:			f * (next->ps.velocity[i] - prev->ps.velocity[i] );
;252:	}
LABELV $150
line 244
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $149
line 254
;253:
;254:}
LABELV $133
endproc CG_InterpolatePlayerState 64 12
proc CG_TouchItem 60 12
line 261
;255:
;256:/*
;257:===================
;258:CG_TouchItem
;259:===================
;260:*/
;261:static void CG_TouchItem( centity_t *cent ) {
line 266
;262:	gitem_t		*item;
;263:	//For instantgib
;264:	qboolean	canBePicked;
;265:
;266:	if(CG_IsARoundBasedGametype(cgs.gametype) && !CG_UsesTeamFlags(cgs.gametype))
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $156
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $156
line 267
;267:		return; //No weapon pickup in elimination
ADDRGP4 $155
JUMPV
LABELV $156
line 269
;268:
;269:	if(CG_IsARoundBasedGametype(cgs.gametype) && cgs.roundStartTime > cgs.roundtime)
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $160
ADDRGP4 cgs+34808
INDIRI4
ADDRGP4 cgs+34812
INDIRI4
LEI4 $160
line 270
;270:		return; //We cannot pickup before the round has started
ADDRGP4 $155
JUMPV
LABELV $160
line 273
;271:
;272:	//normally we can
;273:	canBePicked = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 276
;274:
;275:	//But in instantgib, rocket arena, and CTF_ELIMINATION we normally can't:
;276:	if(cgs.nopickup || cgs.gametype == GT_CTF_ELIMINATION)
ADDRGP4 cgs+34824
INDIRI4
CNSTI4 0
NEI4 $169
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $165
LABELV $169
line 277
;277:		canBePicked = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $165
line 279
;278:
;279:	if ( !cg_predictItems.integer ) {
ADDRGP4 cg_predictItems+12
INDIRI4
CNSTI4 0
NEI4 $170
line 280
;280:		return;
ADDRGP4 $155
JUMPV
LABELV $170
line 282
;281:	}
;282:	if ( !BG_PlayerTouchesItem( &cg.predictedPlayerState, &cent->currentState, cg.time ) ) {
ADDRGP4 cg+107636
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $173
line 283
;283:		return;
ADDRGP4 $155
JUMPV
LABELV $173
line 287
;284:	}
;285:
;286:	// never pick an item up twice in a prediction
;287:	if ( cent->miscTime == cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
NEI4 $177
line 288
;288:		return;
ADDRGP4 $155
JUMPV
LABELV $177
line 291
;289:	}
;290:
;291:	if ( !BG_CanItemBeGrabbed( cgs.gametype, &cent->currentState, &cg.predictedPlayerState ) ) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+107636
ARGP4
ADDRLP4 24
ADDRGP4 BG_CanItemBeGrabbed
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $180
line 292
;292:		return;		// can't hold it
ADDRGP4 $155
JUMPV
LABELV $180
line 295
;293:	}
;294:
;295:	item = &bg_itemlist[ cent->currentState.modelindex ];
ADDRLP4 0
CNSTI4 52
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 299
;296:
;297:	// Special case for flags.  
;298:	// We don't predict touching our own flag
;299:	if( cgs.gametype == GT_1FCTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 5
NEI4 $184
line 300
;300:		if( item->giType == IT_TEAM && item->giTag != PW_NEUTRALFLAG ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $187
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
EQI4 $187
line 301
;301:			return;
ADDRGP4 $155
JUMPV
LABELV $187
line 303
;302:		}
;303:	}
LABELV $184
line 304
;304:	if (cgs.gametype == GT_POSSESSION) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 13
NEI4 $189
line 305
;305:		if( item->giType == IT_TEAM && item->giTag == PW_NEUTRALFLAG ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $192
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $192
line 306
;306:			canBePicked = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 307
;307:		}
LABELV $192
line 308
;308:	}
LABELV $189
line 310
;309:	
;310:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_CTF_ELIMINATION ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $198
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $194
LABELV $198
line 311
;311:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_RED &&
ADDRGP4 cg+107636+248+12
INDIRI4
CNSTI4 1
NEI4 $199
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $199
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $199
line 313
;312:			item->giType == IT_TEAM && item->giTag == PW_REDFLAG)
;313:			return;
ADDRGP4 $155
JUMPV
LABELV $199
line 314
;314:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_BLUE &&
ADDRGP4 cg+107636+248+12
INDIRI4
CNSTI4 2
NEI4 $204
ADDRLP4 36
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $204
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $204
line 316
;315:			item->giType == IT_TEAM && item->giTag == PW_BLUEFLAG)
;316:			return;
ADDRGP4 $155
JUMPV
LABELV $204
line 318
;317:		//Even in instantgib, we can predict our enemy flag
;318:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_RED &&
ADDRLP4 40
CNSTI4 1
ASGNI4
ADDRGP4 cg+107636+248+12
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $209
ADDRLP4 48
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $209
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $209
ADDRGP4 cgs+31468
INDIRI4
ADDRLP4 40
INDIRI4
BANDI4
CNSTI4 0
EQI4 $216
ADDRGP4 cgs+34816
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $209
LABELV $216
line 320
;319:			item->giType == IT_TEAM && item->giTag == PW_BLUEFLAG && (!(cgs.elimflags&EF_ONEWAY) || cgs.attackingTeam == TEAM_RED))
;320:			canBePicked = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $209
line 321
;321:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_BLUE &&
ADDRLP4 52
CNSTI4 2
ASGNI4
ADDRGP4 cg+107636+248+12
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $217
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $217
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $217
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $224
ADDRGP4 cgs+34816
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $217
LABELV $224
line 323
;322:			item->giType == IT_TEAM && item->giTag == PW_REDFLAG && (!(cgs.elimflags&EF_ONEWAY) || cgs.attackingTeam == TEAM_BLUE))
;323:			canBePicked = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $217
line 324
;324:	}
LABELV $194
line 327
;325:
;326:	//Currently we don't predict anything in Double Domination because it looks like we take a flag
;327:	if( cgs.gametype == GT_DOUBLE_D ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
NEI4 $225
line 328
;328:		if(cgs.redflag == TEAM_NONE)
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 3
NEI4 $228
line 329
;329:			return; //Can never pick if just one flag is NONE (because then the other is too)
ADDRGP4 $155
JUMPV
LABELV $228
line 330
;330:		if(item->giTag == PW_REDFLAG){ //at point A
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $231
line 331
;331:			if(cgs.redflag != cg.predictedPlayerState.persistant[PERS_TEAM]) //not already taken
ADDRGP4 cgs+34988
INDIRI4
ADDRGP4 cg+107636+248+12
INDIRI4
EQI4 $155
line 332
;332:                            trap_S_StartLocalSound( cgs.media.hitSound , CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1168
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 333
;333:			return;
ADDRGP4 $155
JUMPV
LABELV $231
line 335
;334:		}	
;335:		if(item->giTag == PW_BLUEFLAG){ //at point B
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $241
line 336
;336:			if(cgs.blueflag != cg.predictedPlayerState.persistant[PERS_TEAM]) //already taken
ADDRGP4 cgs+34992
INDIRI4
ADDRGP4 cg+107636+248+12
INDIRI4
EQI4 $155
line 337
;337:                            trap_S_StartLocalSound( cgs.media.hitSound , CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1168
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 338
;338:			return;
ADDRGP4 $155
JUMPV
LABELV $241
line 340
;339:		}	
;340:	}
LABELV $225
line 343
;341:
;342:	// grab it
;343:	if(canBePicked)
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $251
line 344
;344:	{
line 345
;345:		BG_AddPredictableEventToPlayerstate( EV_ITEM_PICKUP, cent->currentState.modelindex , &cg.predictedPlayerState);
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107636
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 348
;346:
;347:		// remove it from the frame so it won't be drawn
;348:		cent->currentState.eFlags |= EF_NODRAW;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 351
;349:
;350:		// don't touch it again this prediction
;351:		cent->miscTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 354
;352:
;353:		// if its a weapon, give them some predicted ammo so the autoswitch will work
;354:		if ( item->giType == IT_WEAPON ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $255
line 355
;355:			cg.predictedPlayerState.stats[ STAT_WEAPONS ] |= 1 << item->giTag;
ADDRLP4 32
ADDRGP4 cg+107636+184+8
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 356
;356:			if ( !cg.predictedPlayerState.ammo[ item->giTag ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
INDIRI4
CNSTI4 0
NEI4 $260
line 357
;357:				cg.predictedPlayerState.ammo[ item->giTag ] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
CNSTI4 1
ASGNI4
line 358
;358:			}
LABELV $260
line 359
;359:		}
LABELV $255
line 360
;360:	}
LABELV $251
line 361
;361:}
LABELV $155
endproc CG_TouchItem 60 12
proc CG_TouchTriggerPrediction 88 28
line 371
;362:
;363:
;364:/*
;365:=========================
;366:CG_TouchTriggerPrediction
;367:
;368:Predict push triggers and items
;369:=========================
;370:*/
;371:static void CG_TouchTriggerPrediction( void ) {
line 380
;372:	int			i;
;373:	trace_t		trace;
;374:	entityState_t	*ent;
;375:	clipHandle_t cmodel;
;376:	centity_t	*cent;
;377:	qboolean	spectator;
;378:
;379:	// dead clients don't activate triggers
;380:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $267
line 381
;381:		return;
ADDRGP4 $266
JUMPV
LABELV $267
line 384
;382:	}
;383:
;384:	spectator = ( cg.predictedPlayerState.pm_type == PM_SPECTATOR );
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 2
NEI4 $274
ADDRLP4 76
CNSTI4 1
ASGNI4
ADDRGP4 $275
JUMPV
LABELV $274
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $275
ADDRLP4 72
ADDRLP4 76
INDIRI4
ASGNI4
line 386
;385:
;386:	if ( cg.predictedPlayerState.pm_type != PM_NORMAL && !spectator ) {
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRGP4 cg+107636+4
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $276
ADDRLP4 72
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $276
line 387
;387:		return;
ADDRGP4 $266
JUMPV
LABELV $276
line 390
;388:	}
;389:
;390:	for ( i = 0 ; i < cg_numTriggerEntities ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $283
JUMPV
LABELV $280
line 391
;391:		cent = cg_triggerEntities[ i ];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
INDIRP4
ASGNP4
line 392
;392:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 394
;393:
;394:		if ( ent->eType == ET_ITEM && !spectator ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $284
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $284
line 395
;395:			CG_TouchItem( cent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_TouchItem
CALLV
pop
line 396
;396:			continue;
ADDRGP4 $281
JUMPV
LABELV $284
line 399
;397:		}
;398:
;399:		if ( ent->solid != SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $286
line 400
;400:			continue;
ADDRGP4 $281
JUMPV
LABELV $286
line 403
;401:		}
;402:
;403:		cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 84
INDIRI4
ASGNI4
line 404
;404:		if ( !cmodel ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $288
line 405
;405:			continue;
ADDRGP4 $281
JUMPV
LABELV $288
line 408
;406:		}
;407:
;408:		trap_CM_BoxTrace( &trace, cg.predictedPlayerState.origin, cg.predictedPlayerState.origin, 
ADDRLP4 16
ARGP4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg_pmove+180
ARGP4
ADDRGP4 cg_pmove+192
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 411
;409:			cg_pmove.mins, cg_pmove.maxs, cmodel, -1 );
;410:
;411:		if ( !trace.startsolid ) {
ADDRLP4 16+4
INDIRI4
CNSTI4 0
NEI4 $296
line 412
;412:			continue;
ADDRGP4 $281
JUMPV
LABELV $296
line 415
;413:		}
;414:
;415:		if ( ent->eType == ET_TELEPORT_TRIGGER ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
NEI4 $299
line 416
;416:			cg.hyperspace = qtrue;
ADDRGP4 cg+107632
CNSTI4 1
ASGNI4
line 417
;417:		} else if ( ent->eType == ET_PUSH_TRIGGER ) {
ADDRGP4 $300
JUMPV
LABELV $299
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $302
line 418
;418:			BG_TouchJumpPad( &cg.predictedPlayerState, ent );
ADDRGP4 cg+107636
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BG_TouchJumpPad
CALLV
pop
line 419
;419:		}
LABELV $302
LABELV $300
line 420
;420:	}
LABELV $281
line 390
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $283
ADDRLP4 4
INDIRI4
ADDRGP4 cg_numTriggerEntities
INDIRI4
LTI4 $280
line 423
;421:
;422:	// if we didn't touch a jump pad this pmove frame
;423:	if ( cg.predictedPlayerState.jumppad_frame != cg.predictedPlayerState.pmove_framecount ) {
ADDRGP4 cg+107636+460
INDIRI4
ADDRGP4 cg+107636+456
INDIRI4
EQI4 $305
line 424
;424:		cg.predictedPlayerState.jumppad_frame = 0;
ADDRGP4 cg+107636+460
CNSTI4 0
ASGNI4
line 425
;425:		cg.predictedPlayerState.jumppad_ent = 0;
ADDRGP4 cg+107636+448
CNSTI4 0
ASGNI4
line 426
;426:	}
LABELV $305
line 427
;427:}
LABELV $266
endproc CG_TouchTriggerPrediction 88 28
proc IsUnacceptableError 316 8
line 432
;428:
;429://unlagged - optimized prediction
;430:#define ABS(x) ((x) < 0 ? (-(x)) : (x))
;431:
;432:static int IsUnacceptableError( playerState_t *ps, playerState_t *pps ) {
line 436
;433:	vec3_t delta;
;434:	int i;
;435:
;436:	if ( pps->pm_type != ps->pm_type ||
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
NEI4 $319
ADDRLP4 28
CNSTI4 12
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
NEI4 $319
ADDRLP4 32
CNSTI4 16
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $316
LABELV $319
line 438
;437:			pps->pm_flags != ps->pm_flags ||
;438:			pps->pm_time != ps->pm_time ) {
line 439
;439:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $315
JUMPV
LABELV $316
line 442
;440:	}
;441:
;442:	VectorSubtract( pps->origin, ps->origin, delta );
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
CNSTI4 20
ASGNI4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 24
ASGNI4
ADDRLP4 4+4
ADDRLP4 36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 52
CNSTI4 28
ASGNI4
ADDRLP4 4+8
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 443
;443:	if ( VectorLengthSquared( delta ) > 0.1f * 0.1f ) {
ADDRLP4 4
ARGP4
ADDRLP4 56
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 1008981770
LEF4 $322
line 444
;444:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $324
line 445
;445:			CG_Printf("delta: %.2f  ", VectorLength(delta) );
ADDRLP4 4
ARGP4
ADDRLP4 60
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRGP4 $327
ARGP4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 446
;446:		}
LABELV $324
line 447
;447:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $315
JUMPV
LABELV $322
line 450
;448:	}
;449:
;450:	VectorSubtract( pps->velocity, ps->velocity, delta );
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
CNSTI4 32
ASGNI4
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 60
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 72
CNSTI4 36
ASGNI4
ADDRLP4 4+4
ADDRLP4 60
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 76
CNSTI4 40
ASGNI4
ADDRLP4 4+8
ADDRFP4 4
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 451
;451:	if ( VectorLengthSquared( delta ) > 0.1f * 0.1f ) {
ADDRLP4 4
ARGP4
ADDRLP4 80
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 80
INDIRF4
CNSTF4 1008981770
LEF4 $330
line 452
;452:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $332
line 453
;453:			CG_Printf("delta: %.2f  ", VectorLength(delta) );
ADDRLP4 4
ARGP4
ADDRLP4 84
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRGP4 $327
ARGP4
ADDRLP4 84
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 454
;454:		}
LABELV $332
line 455
;455:		return 3;
CNSTI4 3
RETI4
ADDRGP4 $315
JUMPV
LABELV $330
line 458
;456:	}
;457:
;458:	if ( pps->weaponTime != ps->weaponTime ||
ADDRLP4 84
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
CNSTI4 44
ASGNI4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
NEI4 $342
ADDRLP4 96
CNSTI4 48
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
NEI4 $342
ADDRLP4 100
CNSTI4 52
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRI4
NEI4 $342
ADDRLP4 104
CNSTI4 56
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRI4
NEI4 $342
ADDRLP4 108
CNSTI4 60
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRI4
NEI4 $342
ADDRLP4 112
CNSTI4 64
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRI4
NEI4 $342
ADDRLP4 116
CNSTI4 68
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRI4
EQI4 $335
LABELV $342
line 464
;459:			pps->gravity != ps->gravity ||
;460:			pps->speed != ps->speed ||
;461:			pps->delta_angles[0] != ps->delta_angles[0] ||
;462:			pps->delta_angles[1] != ps->delta_angles[1] ||
;463:			pps->delta_angles[2] != ps->delta_angles[2] || 
;464:			pps->groundEntityNum != ps->groundEntityNum ) {
line 465
;465:		return 4;
CNSTI4 4
RETI4
ADDRGP4 $315
JUMPV
LABELV $335
line 468
;466:	}
;467:
;468:	if ( pps->legsTimer != ps->legsTimer ||
ADDRLP4 120
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 124
CNSTI4 72
ASGNI4
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRI4
NEI4 $348
ADDRLP4 132
CNSTI4 76
ASGNI4
ADDRLP4 120
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
INDIRI4
NEI4 $348
ADDRLP4 136
CNSTI4 80
ASGNI4
ADDRLP4 120
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRI4
NEI4 $348
ADDRLP4 140
CNSTI4 84
ASGNI4
ADDRLP4 120
INDIRP4
ADDRLP4 140
INDIRI4
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
ADDRLP4 140
INDIRI4
ADDP4
INDIRI4
NEI4 $348
ADDRLP4 144
CNSTI4 88
ASGNI4
ADDRLP4 120
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRI4
EQI4 $343
LABELV $348
line 472
;469:			pps->legsAnim != ps->legsAnim ||
;470:			pps->torsoTimer != ps->torsoTimer ||
;471:			pps->torsoAnim != ps->torsoAnim ||
;472:			pps->movementDir != ps->movementDir ) {
line 473
;473:		return 5;
CNSTI4 5
RETI4
ADDRGP4 $315
JUMPV
LABELV $343
line 476
;474:	}
;475:
;476:	VectorSubtract( pps->grapplePoint, ps->grapplePoint, delta );
ADDRLP4 148
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 152
CNSTI4 92
ASGNI4
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 148
INDIRP4
ADDRLP4 152
INDIRI4
ADDP4
INDIRF4
ADDRLP4 156
INDIRP4
ADDRLP4 152
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160
CNSTI4 96
ASGNI4
ADDRLP4 4+4
ADDRLP4 148
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
INDIRF4
ADDRLP4 156
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 164
CNSTI4 100
ASGNI4
ADDRLP4 4+8
ADDRFP4 4
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 477
;477:	if ( VectorLengthSquared( delta ) > 0.1f * 0.1f ) {
ADDRLP4 4
ARGP4
ADDRLP4 168
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 168
INDIRF4
CNSTF4 1008981770
LEF4 $351
line 478
;478:		return 6;
CNSTI4 6
RETI4
ADDRGP4 $315
JUMPV
LABELV $351
line 481
;479:	}
;480:
;481:	if ( pps->eFlags != ps->eFlags ) {
ADDRLP4 172
CNSTI4 104
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
INDIRI4
EQI4 $353
line 482
;482:		return 7;
CNSTI4 7
RETI4
ADDRGP4 $315
JUMPV
LABELV $353
line 485
;483:	}
;484:
;485:	if ( pps->eventSequence != ps->eventSequence ) {
ADDRLP4 176
CNSTI4 108
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 176
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 176
INDIRI4
ADDP4
INDIRI4
EQI4 $355
line 486
;486:		return 8;
CNSTI4 8
RETI4
ADDRGP4 $315
JUMPV
LABELV $355
line 489
;487:	}
;488:
;489:	for ( i = 0; i < MAX_PS_EVENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $357
line 490
;490:		if ( pps->events[i] != ps->events[i] ||
ADDRLP4 180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 184
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 188
CNSTI4 112
ASGNI4
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 180
INDIRI4
ADDRLP4 184
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 180
INDIRI4
ADDRLP4 192
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
ADDP4
INDIRI4
NEI4 $363
ADDRLP4 196
CNSTI4 120
ASGNI4
ADDRLP4 180
INDIRI4
ADDRLP4 184
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 180
INDIRI4
ADDRLP4 192
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $361
LABELV $363
line 491
;491:				pps->eventParms[i] != ps->eventParms[i] ) {
line 492
;492:			return 9;
CNSTI4 9
RETI4
ADDRGP4 $315
JUMPV
LABELV $361
line 494
;493:		}
;494:	}
LABELV $358
line 489
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $357
line 496
;495:
;496:	if ( pps->externalEvent != ps->externalEvent ||
ADDRLP4 180
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 184
CNSTI4 128
ASGNI4
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
INDIRI4
ADDRLP4 188
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
INDIRI4
NEI4 $367
ADDRLP4 192
CNSTI4 132
ASGNI4
ADDRLP4 180
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRI4
ADDRLP4 188
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRI4
NEI4 $367
ADDRLP4 196
CNSTI4 136
ASGNI4
ADDRLP4 180
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
INDIRI4
ADDRLP4 188
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
INDIRI4
EQI4 $364
LABELV $367
line 498
;497:			pps->externalEventParm != ps->externalEventParm ||
;498:			pps->externalEventTime != ps->externalEventTime ) {
line 499
;499:		return 10;
CNSTI4 10
RETI4
ADDRGP4 $315
JUMPV
LABELV $364
line 502
;500:	}
;501:
;502:	if ( pps->clientNum != ps->clientNum ||
ADDRLP4 200
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 204
CNSTI4 140
ASGNI4
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRI4
ADDRLP4 208
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRI4
NEI4 $371
ADDRLP4 212
CNSTI4 144
ASGNI4
ADDRLP4 200
INDIRP4
ADDRLP4 212
INDIRI4
ADDP4
INDIRI4
ADDRLP4 208
INDIRP4
ADDRLP4 212
INDIRI4
ADDP4
INDIRI4
NEI4 $371
ADDRLP4 216
CNSTI4 148
ASGNI4
ADDRLP4 200
INDIRP4
ADDRLP4 216
INDIRI4
ADDP4
INDIRI4
ADDRLP4 208
INDIRP4
ADDRLP4 216
INDIRI4
ADDP4
INDIRI4
EQI4 $368
LABELV $371
line 504
;503:			pps->weapon != ps->weapon ||
;504:			pps->weaponstate != ps->weaponstate ) {
line 505
;505:		return 11;
CNSTI4 11
RETI4
ADDRGP4 $315
JUMPV
LABELV $368
line 508
;506:	}
;507:
;508:	if ( ABS(pps->viewangles[0] - ps->viewangles[0]) > 1.0f ||
ADDRLP4 232
CNSTI4 152
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
INDIRF4
SUBF4
CNSTF4 0
GEF4 $378
ADDRLP4 236
CNSTI4 152
ASGNI4
ADDRLP4 220
ADDRFP4 4
INDIRP4
ADDRLP4 236
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 236
INDIRI4
ADDP4
INDIRF4
SUBF4
NEGF4
ASGNF4
ADDRGP4 $379
JUMPV
LABELV $378
ADDRLP4 240
CNSTI4 152
ASGNI4
ADDRLP4 220
ADDRFP4 4
INDIRP4
ADDRLP4 240
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 240
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $379
ADDRLP4 220
INDIRF4
CNSTF4 1065353216
GTF4 $380
ADDRLP4 244
CNSTI4 156
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 244
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 244
INDIRI4
ADDP4
INDIRF4
SUBF4
CNSTF4 0
GEF4 $381
ADDRLP4 248
CNSTI4 156
ASGNI4
ADDRLP4 224
ADDRFP4 4
INDIRP4
ADDRLP4 248
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 248
INDIRI4
ADDP4
INDIRF4
SUBF4
NEGF4
ASGNF4
ADDRGP4 $382
JUMPV
LABELV $381
ADDRLP4 252
CNSTI4 156
ASGNI4
ADDRLP4 224
ADDRFP4 4
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $382
ADDRLP4 224
INDIRF4
CNSTF4 1065353216
GTF4 $380
ADDRLP4 256
CNSTI4 160
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
INDIRF4
SUBF4
CNSTF4 0
GEF4 $383
ADDRLP4 260
CNSTI4 160
ASGNI4
ADDRLP4 228
ADDRFP4 4
INDIRP4
ADDRLP4 260
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 260
INDIRI4
ADDP4
INDIRF4
SUBF4
NEGF4
ASGNF4
ADDRGP4 $384
JUMPV
LABELV $383
ADDRLP4 264
CNSTI4 160
ASGNI4
ADDRLP4 228
ADDRFP4 4
INDIRP4
ADDRLP4 264
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 264
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $384
ADDRLP4 228
INDIRF4
CNSTF4 1065353216
LEF4 $372
LABELV $380
line 510
;509:			ABS(pps->viewangles[1] - ps->viewangles[1]) > 1.0f ||
;510:			ABS(pps->viewangles[2] - ps->viewangles[2]) > 1.0f ) {
line 511
;511:		return 12;
CNSTI4 12
RETI4
ADDRGP4 $315
JUMPV
LABELV $372
line 514
;512:	}
;513:
;514:	if ( pps->viewheight != ps->viewheight ) {
ADDRLP4 268
CNSTI4 164
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 268
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 268
INDIRI4
ADDP4
INDIRI4
EQI4 $385
line 515
;515:		return 13;
CNSTI4 13
RETI4
ADDRGP4 $315
JUMPV
LABELV $385
line 518
;516:	}
;517:
;518:	if ( pps->damageEvent != ps->damageEvent ||
ADDRLP4 272
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 276
CNSTI4 168
ASGNI4
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
ADDRLP4 276
INDIRI4
ADDP4
INDIRI4
ADDRLP4 280
INDIRP4
ADDRLP4 276
INDIRI4
ADDP4
INDIRI4
NEI4 $391
ADDRLP4 284
CNSTI4 172
ASGNI4
ADDRLP4 272
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRI4
ADDRLP4 280
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRI4
NEI4 $391
ADDRLP4 288
CNSTI4 176
ASGNI4
ADDRLP4 272
INDIRP4
ADDRLP4 288
INDIRI4
ADDP4
INDIRI4
ADDRLP4 280
INDIRP4
ADDRLP4 288
INDIRI4
ADDP4
INDIRI4
NEI4 $391
ADDRLP4 292
CNSTI4 180
ASGNI4
ADDRLP4 272
INDIRP4
ADDRLP4 292
INDIRI4
ADDP4
INDIRI4
ADDRLP4 280
INDIRP4
ADDRLP4 292
INDIRI4
ADDP4
INDIRI4
EQI4 $387
LABELV $391
line 521
;519:			pps->damageYaw != ps->damageYaw ||
;520:			pps->damagePitch != ps->damagePitch ||
;521:			pps->damageCount != ps->damageCount ) {
line 522
;522:		return 14;
CNSTI4 14
RETI4
ADDRGP4 $315
JUMPV
LABELV $387
line 525
;523:	}
;524:
;525:	for ( i = 0; i < MAX_STATS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $392
line 526
;526:		if ( pps->stats[i] != ps->stats[i] ) {
ADDRLP4 296
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 300
CNSTI4 184
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $396
line 527
;527:			return 15;
CNSTI4 15
RETI4
ADDRGP4 $315
JUMPV
LABELV $396
line 529
;528:		}
;529:	}
LABELV $393
line 525
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $392
line 531
;530:
;531:	for ( i = 0; i < MAX_PERSISTANT; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $398
line 532
;532:		if ( pps->persistant[i] != ps->persistant[i] ) {
ADDRLP4 296
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 300
CNSTI4 248
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $402
line 533
;533:			return 16;
CNSTI4 16
RETI4
ADDRGP4 $315
JUMPV
LABELV $402
line 535
;534:		}
;535:	}
LABELV $399
line 531
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $398
line 537
;536:
;537:	for ( i = 0; i < MAX_POWERUPS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $404
line 538
;538:		if ( pps->powerups[i] != ps->powerups[i] ) {
ADDRLP4 296
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 300
CNSTI4 312
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $408
line 539
;539:			return 17;
CNSTI4 17
RETI4
ADDRGP4 $315
JUMPV
LABELV $408
line 541
;540:		}
;541:	}
LABELV $405
line 537
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $404
line 543
;542:
;543:	for ( i = 0; i < MAX_WEAPONS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $410
line 544
;544:		if ( pps->ammo[i] != ps->ammo[i] ) {
ADDRLP4 296
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 300
CNSTI4 376
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $414
line 545
;545:			return 18;
CNSTI4 18
RETI4
ADDRGP4 $315
JUMPV
LABELV $414
line 547
;546:		}
;547:	}
LABELV $411
line 543
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $410
line 549
;548:
;549:	if ( pps->generic1 != ps->generic1 ||
ADDRLP4 296
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 300
CNSTI4 440
ASGNI4
ADDRLP4 304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
INDIRI4
ADDRLP4 304
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
INDIRI4
NEI4 $419
ADDRLP4 308
CNSTI4 444
ASGNI4
ADDRLP4 296
INDIRP4
ADDRLP4 308
INDIRI4
ADDP4
INDIRI4
ADDRLP4 304
INDIRP4
ADDRLP4 308
INDIRI4
ADDP4
INDIRI4
NEI4 $419
ADDRLP4 312
CNSTI4 448
ASGNI4
ADDRLP4 296
INDIRP4
ADDRLP4 312
INDIRI4
ADDP4
INDIRI4
ADDRLP4 304
INDIRP4
ADDRLP4 312
INDIRI4
ADDP4
INDIRI4
EQI4 $416
LABELV $419
line 551
;550:			pps->loopSound != ps->loopSound ||
;551:			pps->jumppad_ent != ps->jumppad_ent ) {
line 552
;552:		return 19;
CNSTI4 19
RETI4
ADDRGP4 $315
JUMPV
LABELV $416
line 555
;553:	}
;554:
;555:	return 0;
CNSTI4 0
RETI4
LABELV $315
endproc IsUnacceptableError 316 8
export CG_PredictPlayerState
proc CG_PredictPlayerState 620 28
line 585
;556:}
;557://unlagged - optimized prediction
;558:
;559:/*
;560:=================
;561:CG_PredictPlayerState
;562:
;563:Generates cg.predictedPlayerState for the current cg.time
;564:cg.predictedPlayerState is guaranteed to be valid after exiting.
;565:
;566:For demo playback, this will be an interpolation between two valid
;567:playerState_t.
;568:
;569:For normal gameplay, it will be the result of predicted usercmd_t on
;570:top of the most recent playerState_t received from the server.
;571:
;572:Each new snapshot will usually have one or more new usercmd over the last,
;573:but we simulate all unacknowledged commands each time, not just the new ones.
;574:This means that on an internet connection, quite a few pmoves may be issued
;575:each frame.
;576:
;577:OPTIMIZE: don't re-simulate unless the newly arrived snapshot playerState_t
;578:differs from the predicted one.  Would require saving all intermediate
;579:playerState_t during prediction.
;580:
;581:We detect prediction errors and allow them to be decayed off over several frames
;582:to ease the jerk.
;583:=================
;584:*/
;585:void CG_PredictPlayerState( void ) {
line 592
;586:	int			cmdNum, current;
;587:	playerState_t	oldPlayerState;
;588:	qboolean	moved;
;589:	usercmd_t	oldestCmd;
;590:	usercmd_t	latestCmd;
;591://unlagged - optimized prediction
;592:	int stateIndex = 0, predictCmd = 0; //Sago: added initializing
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 512
CNSTI4 0
ASGNI4
line 593
;593:	int numPredicted = 0, numPlayedBack = 0; // debug code
ADDRLP4 508
CNSTI4 0
ASGNI4
ADDRLP4 516
CNSTI4 0
ASGNI4
line 596
;594://unlagged - optimized prediction
;595:
;596:	cg.hyperspace = qfalse;	// will be set if touching a trigger_teleport
ADDRGP4 cg+107632
CNSTI4 0
ASGNI4
line 601
;597:
;598:	// if this is the first frame we must guarantee
;599:	// predictedPlayerState is valid even if there is some
;600:	// other error condition
;601:	if ( !cg.validPPS ) {
ADDRGP4 cg+109040
INDIRI4
CNSTI4 0
NEI4 $422
line 602
;602:		cg.validPPS = qtrue;
ADDRGP4 cg+109040
CNSTI4 1
ASGNI4
line 603
;603:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 604
;604:	}
LABELV $422
line 608
;605:
;606:
;607:	// demo playback just copies the moves
;608:	if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRLP4 544
CNSTI4 0
ASGNI4
ADDRGP4 cg+8
INDIRI4
ADDRLP4 544
INDIRI4
NEI4 $432
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 544
INDIRI4
EQI4 $428
LABELV $432
line 609
;609:		CG_InterpolatePlayerState( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 610
;610:		return;
ADDRGP4 $420
JUMPV
LABELV $428
line 614
;611:	}
;612:
;613:	// non-predicting local movement will grab the latest angles
;614:	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
ADDRLP4 548
CNSTI4 0
ASGNI4
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 548
INDIRI4
NEI4 $437
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 548
INDIRI4
EQI4 $433
LABELV $437
line 615
;615:		CG_InterpolatePlayerState( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 616
;616:		return;
ADDRGP4 $420
JUMPV
LABELV $433
line 620
;617:	}
;618:
;619:	// prepare for pmove
;620:	cg_pmove.ps = &cg.predictedPlayerState;
ADDRGP4 cg_pmove
ADDRGP4 cg+107636
ASGNP4
line 621
;621:	cg_pmove.trace = CG_Trace;
ADDRGP4 cg_pmove+232
ADDRGP4 CG_Trace
ASGNP4
line 622
;622:	cg_pmove.pointcontents = CG_PointContents;
ADDRGP4 cg_pmove+236
ADDRGP4 CG_PointContents
ASGNP4
line 623
;623:	if ( cg_pmove.ps->pm_type == PM_DEAD ) {
ADDRGP4 cg_pmove
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $441
line 624
;624:		cg_pmove.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRGP4 cg_pmove+28
CNSTI4 65537
ASGNI4
line 625
;625:	}
ADDRGP4 $442
JUMPV
LABELV $441
line 626
;626:	else {
line 627
;627:		cg_pmove.tracemask = MASK_PLAYERSOLID;
ADDRGP4 cg_pmove+28
CNSTI4 33619969
ASGNI4
line 628
;628:	}
LABELV $442
line 629
;629:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $445
line 630
;630:		cg_pmove.tracemask &= ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 552
ADDRGP4 cg_pmove+28
ASGNP4
ADDRLP4 552
INDIRP4
ADDRLP4 552
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 631
;631:	}
LABELV $445
line 632
;632:	cg_pmove.noFootsteps = ( cgs.dmflags & DF_NO_FOOTSTEPS ) > 0;
ADDRGP4 cgs+31460
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
LEI4 $452
ADDRLP4 552
CNSTI4 1
ASGNI4
ADDRGP4 $453
JUMPV
LABELV $452
ADDRLP4 552
CNSTI4 0
ASGNI4
LABELV $453
ADDRGP4 cg_pmove+36
ADDRLP4 552
INDIRI4
ASGNI4
line 635
;633:
;634:	// save the state before the pmove so we can detect transitions
;635:	oldPlayerState = cg.predictedPlayerState;
ADDRLP4 8
ADDRGP4 cg+107636
INDIRB
ASGNB 468
line 637
;636:
;637:	current = trap_GetCurrentCmdNumber();
ADDRLP4 556
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 476
ADDRLP4 556
INDIRI4
ASGNI4
line 642
;638:
;639:	// if we don't have the commands right after the snapshot, we
;640:	// can't accurately predict a current position, so just freeze at
;641:	// the last good position we had
;642:	cmdNum = current - CMD_BACKUP + 1;
ADDRLP4 0
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 643
;643:	trap_GetUserCmd( cmdNum, &oldestCmd );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 520
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 644
;644:	if ( oldestCmd.serverTime > cg.snap->ps.commandTime 
ADDRLP4 560
ADDRLP4 520
INDIRI4
ASGNI4
ADDRLP4 560
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $455
ADDRLP4 560
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $455
line 645
;645:		&& oldestCmd.serverTime < cg.time ) {	// special check for map_restart
line 646
;646:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $420
line 647
;647:			CG_Printf ("exceeded PACKET_BACKUP on commands\n");
ADDRGP4 $462
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 648
;648:		}
line 649
;649:		return;
ADDRGP4 $420
JUMPV
LABELV $455
line 653
;650:	}
;651:
;652:	// get the latest command so we can know which commands are from previous map_restarts
;653:	trap_GetUserCmd( current, &latestCmd );
ADDRLP4 476
INDIRI4
ARGI4
ADDRLP4 484
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 659
;654:
;655:	// get the most recent information we have, even if
;656:	// the server time is beyond our current cg.time,
;657:	// because predicted player positions are going to 
;658:	// be ahead of everything else anyway
;659:	if ( cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $463
ADDRLP4 564
CNSTI4 0
ASGNI4
ADDRGP4 cg+107596
INDIRI4
ADDRLP4 564
INDIRI4
NEI4 $463
ADDRGP4 cg+107592
INDIRI4
ADDRLP4 564
INDIRI4
NEI4 $463
line 660
;660:		cg.predictedPlayerState = cg.nextSnap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+40
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 661
;661:		cg.physicsTime = cg.nextSnap->serverTime;
ADDRGP4 cg+107612
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 662
;662:	} else {
ADDRGP4 $464
JUMPV
LABELV $463
line 663
;663:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 664
;664:		cg.physicsTime = cg.snap->serverTime;
ADDRGP4 cg+107612
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 665
;665:	}
LABELV $464
line 667
;666:
;667:	if ( pmove_msec.integer < 8 ) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 8
GEI4 $476
line 668
;668:		trap_Cvar_Set("pmove_msec", "8");
ADDRGP4 $479
ARGP4
ADDRGP4 $480
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 669
;669:		trap_Cvar_Update(&pmove_msec);
ADDRGP4 pmove_msec
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 670
;670:	}
ADDRGP4 $477
JUMPV
LABELV $476
line 671
;671:	else if (pmove_msec.integer > 33) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 33
LEI4 $481
line 672
;672:		trap_Cvar_Set("pmove_msec", "33");
ADDRGP4 $479
ARGP4
ADDRGP4 $484
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 673
;673:		trap_Cvar_Update(&pmove_msec);
ADDRGP4 pmove_msec
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 674
;674:	}
LABELV $481
LABELV $477
line 676
;675:
;676:	cg_pmove.pmove_fixed = pmove_fixed.integer;// | cg_pmove_fixed.integer;
ADDRGP4 cg_pmove+216
ADDRGP4 pmove_fixed+12
INDIRI4
ASGNI4
line 677
;677:	cg_pmove.pmove_msec = pmove_msec.integer;
ADDRGP4 cg_pmove+220
ADDRGP4 pmove_msec+12
INDIRI4
ASGNI4
line 678
;678:        cg_pmove.pmove_float = pmove_float.integer;
ADDRGP4 cg_pmove+224
ADDRGP4 pmove_float+12
INDIRI4
ASGNI4
line 679
;679:        cg_pmove.pmove_flags = cgs.dmflags;
ADDRGP4 cg_pmove+228
ADDRGP4 cgs+31460
INDIRI4
ASGNI4
line 702
;680:        
;681:
;682://unlagged - optimized prediction
;683:	// Like the comments described above, a player's state is entirely
;684:	// re-predicted from the last valid snapshot every client frame, which
;685:	// can be really, really, really slow.  Every old command has to be
;686:	// run again.  For every client frame that is *not* directly after a
;687:	// snapshot, this is unnecessary, since we have no new information.
;688:	// For those, we'll play back the predictions from the last frame and
;689:	// predict only the newest commands.  Essentially, we'll be doing
;690:	// an incremental predict instead of a full predict.
;691:	//
;692:	// If we have a new snapshot, we can compare its player state's command
;693:	// time to the command times in the queue to find a match.  If we find
;694:	// a matching state, and the predicted version has not deviated, we can
;695:	// use the predicted state as a base - and also do an incremental predict.
;696:	//
;697:	// With this method, we get incremental predicts on every client frame
;698:	// except a frame following a new snapshot in which there was a prediction
;699:	// error.  This yeilds anywhere from a 15% to 40% performance increase,
;700:	// depending on how much of a bottleneck the CPU is.
;701:
;702:	if ( cg_optimizePrediction.integer ) {
ADDRGP4 cg_optimizePrediction+12
INDIRI4
CNSTI4 0
EQI4 $493
line 703
;703:		if ( cg.nextFrameTeleport || cg.thisFrameTeleport ) {
ADDRLP4 568
CNSTI4 0
ASGNI4
ADDRGP4 cg+107596
INDIRI4
ADDRLP4 568
INDIRI4
NEI4 $500
ADDRGP4 cg+107592
INDIRI4
ADDRLP4 568
INDIRI4
EQI4 $496
LABELV $500
line 705
;704:			// do a full predict
;705:			cg.lastPredictedCommand = 0;
ADDRGP4 cg+125628
CNSTI4 0
ASGNI4
line 706
;706:			cg.stateTail = cg.stateHead;
ADDRGP4 cg+156528
ADDRGP4 cg+156524
INDIRI4
ASGNI4
line 707
;707:			predictCmd = current - CMD_BACKUP + 1;
ADDRLP4 512
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 708
;708:		}
ADDRGP4 $497
JUMPV
LABELV $496
line 711
;709:		// cg.physicsTime is the current snapshot's serverTime
;710:		// if it's the same as the last one
;711:		else if ( cg.physicsTime == cg.lastServerTime ) {
ADDRGP4 cg+107612
INDIRI4
ADDRGP4 cg+125632
INDIRI4
NEI4 $504
line 713
;712:			// we have no new information, so do an incremental predict
;713:			predictCmd = cg.lastPredictedCommand + 1;
ADDRLP4 512
ADDRGP4 cg+125628
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 714
;714:		}
ADDRGP4 $505
JUMPV
LABELV $504
line 715
;715:		else {
line 719
;716:			// we have a new snapshot
;717:
;718:			int i;
;719:			qboolean error = qtrue;
ADDRLP4 576
CNSTI4 1
ASGNI4
line 722
;720:
;721:			// loop through the saved states queue
;722:			for ( i = cg.stateHead; i != cg.stateTail; i = (i + 1) % NUM_SAVED_STATES ) {
ADDRLP4 572
ADDRGP4 cg+156524
INDIRI4
ASGNI4
ADDRGP4 $512
JUMPV
LABELV $509
line 724
;723:				// if we find a predicted state whose commandTime matches the snapshot player state's commandTime
;724:				if ( cg.savedPmoveStates[i].commandTime == cg.predictedPlayerState.commandTime ) {
CNSTI4 468
ADDRLP4 572
INDIRI4
MULI4
ADDRGP4 cg+125636
ADDP4
INDIRI4
ADDRGP4 cg+107636
INDIRI4
NEI4 $515
line 726
;725:					// make sure the state differences are acceptable
;726:					int errorcode = IsUnacceptableError( &cg.predictedPlayerState, &cg.savedPmoveStates[i] );
ADDRGP4 cg+107636
ARGP4
CNSTI4 468
ADDRLP4 572
INDIRI4
MULI4
ADDRGP4 cg+125636
ADDP4
ARGP4
ADDRLP4 584
ADDRGP4 IsUnacceptableError
CALLI4
ASGNI4
ADDRLP4 580
ADDRLP4 584
INDIRI4
ASGNI4
line 729
;727:
;728:					// too much change?
;729:					if ( errorcode ) {
ADDRLP4 580
INDIRI4
CNSTI4 0
EQI4 $521
line 730
;730:						if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $511
line 731
;731:							CG_Printf("errorcode %d at %d\n", errorcode, cg.time);
ADDRGP4 $526
ARGP4
ADDRLP4 580
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 732
;732:						}
line 734
;733:						// yeah, so do a full predict
;734:						break;
ADDRGP4 $511
JUMPV
LABELV $521
line 738
;735:					}
;736:
;737:					// this one is almost exact, so we'll copy it in as the starting point
;738:					*cg_pmove.ps = cg.savedPmoveStates[i];
ADDRGP4 cg_pmove
INDIRP4
CNSTI4 468
ADDRLP4 572
INDIRI4
MULI4
ADDRGP4 cg+125636
ADDP4
INDIRB
ASGNB 468
line 740
;739:					// advance the head
;740:					cg.stateHead = (i + 1) % NUM_SAVED_STATES;
ADDRGP4 cg+156524
ADDRLP4 572
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 743
;741:
;742:					// set the next command to predict
;743:					predictCmd = cg.lastPredictedCommand + 1;
ADDRLP4 512
ADDRGP4 cg+125628
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 746
;744:
;745:					// a saved state matched, so flag it
;746:					error = qfalse;
ADDRLP4 576
CNSTI4 0
ASGNI4
line 747
;747:					break;
ADDRGP4 $511
JUMPV
LABELV $515
line 749
;748:				}
;749:			}
LABELV $510
line 722
ADDRLP4 572
ADDRLP4 572
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
LABELV $512
ADDRLP4 572
INDIRI4
ADDRGP4 cg+156528
INDIRI4
NEI4 $509
LABELV $511
line 752
;750:
;751:			// if no saved states matched
;752:			if ( error ) {
ADDRLP4 576
INDIRI4
CNSTI4 0
EQI4 $531
line 754
;753:				// do a full predict
;754:				cg.lastPredictedCommand = 0;
ADDRGP4 cg+125628
CNSTI4 0
ASGNI4
line 755
;755:				cg.stateTail = cg.stateHead;
ADDRGP4 cg+156528
ADDRGP4 cg+156524
INDIRI4
ASGNI4
line 756
;756:				predictCmd = current - CMD_BACKUP + 1;
ADDRLP4 512
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 757
;757:			}
LABELV $531
line 758
;758:		}
LABELV $505
LABELV $497
line 762
;759:
;760:		// keep track of the server time of the last snapshot so we
;761:		// know when we're starting from a new one in future calls
;762:		cg.lastServerTime = cg.physicsTime;
ADDRGP4 cg+125632
ADDRGP4 cg+107612
INDIRI4
ASGNI4
line 763
;763:		stateIndex = cg.stateHead;
ADDRLP4 4
ADDRGP4 cg+156524
INDIRI4
ASGNI4
line 764
;764:	}
LABELV $493
line 768
;765://unlagged - optimized prediction
;766:
;767:	// run cmds
;768:	moved = qfalse;
ADDRLP4 480
CNSTI4 0
ASGNI4
line 769
;769:	for ( cmdNum = current - CMD_BACKUP + 1 ; cmdNum <= current ; cmdNum++ ) {
ADDRLP4 0
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $542
JUMPV
LABELV $539
line 771
;770:		// get the command
;771:		trap_GetUserCmd( cmdNum, &cg_pmove.cmd );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 773
;772:
;773:		if ( cg_pmove.pmove_fixed ) {
ADDRGP4 cg_pmove+216
INDIRI4
CNSTI4 0
EQI4 $544
line 774
;774:			PM_UpdateViewAngles( cg_pmove.ps, &cg_pmove.cmd );
ADDRGP4 cg_pmove
INDIRP4
ARGP4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 775
;775:		}
LABELV $544
line 778
;776:
;777:		// don't do anything if the time is before the snapshot player time
;778:		if ( cg_pmove.cmd.serverTime <= cg.predictedPlayerState.commandTime ) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg+107636
INDIRI4
GTI4 $548
line 779
;779:			continue;
ADDRGP4 $540
JUMPV
LABELV $548
line 783
;780:		}
;781:
;782:		// don't do anything if the command was from a previous map_restart
;783:		if ( cg_pmove.cmd.serverTime > latestCmd.serverTime ) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRLP4 484
INDIRI4
LEI4 $552
line 784
;784:			continue;
ADDRGP4 $540
JUMPV
LABELV $552
line 792
;785:		}
;786:
;787:		// check for a prediction error from last frame
;788:		// on a lan, this will often be the exact value
;789:		// from the snapshot, but on a wan we will have
;790:		// to predict several commands to get to the point
;791:		// we want to compare
;792:		if ( cg.predictedPlayerState.commandTime == oldPlayerState.commandTime ) {
ADDRGP4 cg+107636
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $555
line 796
;793:			vec3_t	delta;
;794:			float	len;
;795:
;796:			if ( cg.thisFrameTeleport ) {
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
EQI4 $558
line 798
;797:				// a teleport will not cause an error decay
;798:				VectorClear( cg.predictedError );
ADDRLP4 584
CNSTF4 0
ASGNF4
ADDRGP4 cg+109048+8
ADDRLP4 584
INDIRF4
ASGNF4
ADDRGP4 cg+109048+4
ADDRLP4 584
INDIRF4
ASGNF4
ADDRGP4 cg+109048
ADDRLP4 584
INDIRF4
ASGNF4
line 799
;799:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $566
line 800
;800:					CG_Printf( "PredictionTeleport\n" );
ADDRGP4 $569
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 801
;801:				}
LABELV $566
line 802
;802:				cg.thisFrameTeleport = qfalse;
ADDRGP4 cg+107592
CNSTI4 0
ASGNI4
line 803
;803:			} else {
ADDRGP4 $559
JUMPV
LABELV $558
line 805
;804:				vec3_t	adjusted,new_angles;
;805:				CG_AdjustPositionForMover( cg.predictedPlayerState.origin, 
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+68
INDIRI4
ARGI4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRGP4 cg+107608
INDIRI4
ARGI4
ADDRLP4 584
ARGP4
ADDRGP4 cg+107636+152
ARGP4
ADDRLP4 596
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 808
;806:					cg.predictedPlayerState.groundEntityNum, cg.physicsTime, cg.oldTime, adjusted, cg.predictedPlayerState.viewangles, new_angles );
;807:
;808:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $579
line 809
;809:					if (!VectorCompare( oldPlayerState.origin, adjusted )) {
ADDRLP4 8+20
ARGP4
ADDRLP4 584
ARGP4
ADDRLP4 608
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 608
INDIRI4
CNSTI4 0
NEI4 $582
line 810
;810:						CG_Printf("prediction error\n");
ADDRGP4 $585
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 811
;811:					}
LABELV $582
line 812
;812:				}
LABELV $579
line 813
;813:				VectorSubtract( oldPlayerState.origin, adjusted, delta );
ADDRLP4 568
ADDRLP4 8+20
INDIRF4
ADDRLP4 584
INDIRF4
SUBF4
ASGNF4
ADDRLP4 568+4
ADDRLP4 8+20+4
INDIRF4
ADDRLP4 584+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 568+8
ADDRLP4 8+20+8
INDIRF4
ADDRLP4 584+8
INDIRF4
SUBF4
ASGNF4
line 814
;814:				len = VectorLength( delta );
ADDRLP4 568
ARGP4
ADDRLP4 608
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 580
ADDRLP4 608
INDIRF4
ASGNF4
line 815
;815:				if ( len > 0.1 ) {
ADDRLP4 580
INDIRF4
CNSTF4 1036831949
LEF4 $595
line 816
;816:					if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $597
line 817
;817:						CG_Printf("Prediction miss: %f\n", len);
ADDRGP4 $600
ARGP4
ADDRLP4 580
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 818
;818:					}
LABELV $597
line 819
;819:					if ( cg_errorDecay.integer ) {
ADDRGP4 cg_errorDecay+12
INDIRI4
CNSTI4 0
EQI4 $601
line 823
;820:						int		t;
;821:						float	f;
;822:
;823:						t = cg.time - cg.predictedErrorTime;
ADDRLP4 616
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109044
INDIRI4
SUBI4
ASGNI4
line 824
;824:						f = ( cg_errorDecay.value - t ) / cg_errorDecay.value;
ADDRLP4 612
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 616
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 825
;825:						if ( f < 0 ) {
ADDRLP4 612
INDIRF4
CNSTF4 0
GEF4 $608
line 826
;826:							f = 0;
ADDRLP4 612
CNSTF4 0
ASGNF4
line 827
;827:						}
LABELV $608
line 828
;828:						if ( f > 0 && cg_showmiss.integer ) {
ADDRLP4 612
INDIRF4
CNSTF4 0
LEF4 $610
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $610
line 829
;829:							CG_Printf("Double prediction decay: %f\n", f);
ADDRGP4 $613
ARGP4
ADDRLP4 612
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 830
;830:						}
LABELV $610
line 831
;831:						VectorScale( cg.predictedError, f, cg.predictedError );
ADDRGP4 cg+109048
ADDRGP4 cg+109048
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+109048+4
ADDRGP4 cg+109048+4
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+109048+8
ADDRGP4 cg+109048+8
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ASGNF4
line 832
;832:					} else {
ADDRGP4 $602
JUMPV
LABELV $601
line 833
;833:						VectorClear( cg.predictedError );
ADDRLP4 612
CNSTF4 0
ASGNF4
ADDRGP4 cg+109048+8
ADDRLP4 612
INDIRF4
ASGNF4
ADDRGP4 cg+109048+4
ADDRLP4 612
INDIRF4
ASGNF4
ADDRGP4 cg+109048
ADDRLP4 612
INDIRF4
ASGNF4
line 834
;834:					}
LABELV $602
line 835
;835:					VectorAdd( delta, cg.predictedError, cg.predictedError );
ADDRGP4 cg+109048
ADDRLP4 568
INDIRF4
ADDRGP4 cg+109048
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+109048+4
ADDRLP4 568+4
INDIRF4
ADDRGP4 cg+109048+4
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+109048+8
ADDRLP4 568+8
INDIRF4
ADDRGP4 cg+109048+8
INDIRF4
ADDF4
ASGNF4
line 836
;836:					cg.predictedErrorTime = cg.oldTime;
ADDRGP4 cg+109044
ADDRGP4 cg+107608
INDIRI4
ASGNI4
line 837
;837:				}
LABELV $595
line 838
;838:			}
LABELV $559
line 839
;839:		}
LABELV $555
line 843
;840:
;841:		// don't predict gauntlet firing, which is only supposed to happen
;842:		// when it actually inflicts damage
;843:		cg_pmove.gauntletHit = qfalse;
ADDRGP4 cg_pmove+40
CNSTI4 0
ASGNI4
line 845
;844:
;845:		if ( cg_pmove.pmove_fixed ) {
ADDRGP4 cg_pmove+216
INDIRI4
CNSTI4 0
EQI4 $644
line 846
;846:			cg_pmove.cmd.serverTime = ((cg_pmove.cmd.serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
ADDRGP4 cg_pmove+4
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 pmove_msec+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRGP4 pmove_msec+12
INDIRI4
DIVI4
ADDRGP4 pmove_msec+12
INDIRI4
MULI4
ASGNI4
line 847
;847:		}
LABELV $644
line 850
;848:
;849://unlagged - optimized prediction
;850:		if ( cg_optimizePrediction.integer ) {
ADDRGP4 cg_optimizePrediction+12
INDIRI4
CNSTI4 0
EQI4 $652
line 852
;851:			// if we need to predict this command, or we've run out of space in the saved states queue
;852:			if ( cmdNum >= predictCmd || (stateIndex + 1) % NUM_SAVED_STATES == cg.stateHead ) {
ADDRLP4 0
INDIRI4
ADDRLP4 512
INDIRI4
GEI4 $658
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ADDRGP4 cg+156524
INDIRI4
NEI4 $655
LABELV $658
line 854
;853:				// run the Pmove
;854:				Pmove (&cg_pmove);
ADDRGP4 cg_pmove
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 856
;855:
;856:				numPredicted++; // debug code
ADDRLP4 508
ADDRLP4 508
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 859
;857:
;858:				// record the last predicted command
;859:				cg.lastPredictedCommand = cmdNum;
ADDRGP4 cg+125628
ADDRLP4 0
INDIRI4
ASGNI4
line 862
;860:
;861:				// if we haven't run out of space in the saved states queue
;862:				if ( (stateIndex + 1) % NUM_SAVED_STATES != cg.stateHead ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ADDRGP4 cg+156524
INDIRI4
EQI4 $653
line 865
;863:					// save the state for the false case (of cmdNum >= predictCmd)
;864:					// in later calls to this function
;865:					cg.savedPmoveStates[stateIndex] = *cg_pmove.ps;
CNSTI4 468
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+125636
ADDP4
ADDRGP4 cg_pmove
INDIRP4
INDIRB
ASGNB 468
line 866
;866:					stateIndex = (stateIndex + 1) % NUM_SAVED_STATES;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 867
;867:					cg.stateTail = stateIndex;
ADDRGP4 cg+156528
ADDRLP4 4
INDIRI4
ASGNI4
line 868
;868:				}
line 869
;869:			}
ADDRGP4 $653
JUMPV
LABELV $655
line 870
;870:			else {
line 871
;871:				numPlayedBack++; // debug code
ADDRLP4 516
ADDRLP4 516
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 873
;872:
;873:				if ( cg_showmiss.integer && 
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $665
CNSTI4 468
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+125636
ADDP4
INDIRI4
ADDRGP4 cg_pmove+4
INDIRI4
EQI4 $665
line 874
;874:						cg.savedPmoveStates[stateIndex].commandTime != cg_pmove.cmd.serverTime) {
line 876
;875:					// this should ONLY happen just after changing the value of pmove_fixed
;876:					CG_Printf( "saved state miss\n" );
ADDRGP4 $670
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 877
;877:				}
LABELV $665
line 880
;878:
;879:				// play back the command from the saved states
;880:				*cg_pmove.ps = cg.savedPmoveStates[stateIndex];
ADDRGP4 cg_pmove
INDIRP4
CNSTI4 468
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+125636
ADDP4
INDIRB
ASGNB 468
line 883
;881:
;882:				// go to the next element in the saved states array
;883:				stateIndex = (stateIndex + 1) % NUM_SAVED_STATES;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 884
;884:			}
line 885
;885:		}
ADDRGP4 $653
JUMPV
LABELV $652
line 886
;886:		else {
line 888
;887:			// run the Pmove
;888:			Pmove (&cg_pmove);
ADDRGP4 cg_pmove
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 890
;889:
;890:			numPredicted++; // debug code
ADDRLP4 508
ADDRLP4 508
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 891
;891:		}
LABELV $653
line 894
;892://unlagged - optimized prediction
;893:
;894:		moved = qtrue;
ADDRLP4 480
CNSTI4 1
ASGNI4
line 897
;895:
;896:		// add push trigger movement effects
;897:		CG_TouchTriggerPrediction();
ADDRGP4 CG_TouchTriggerPrediction
CALLV
pop
line 901
;898:
;899:		// check for predictable events that changed from previous predictions
;900:		//CG_CheckChangedPredictableEvents(&cg.predictedPlayerState);
;901:	}
LABELV $540
line 769
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $542
ADDRLP4 0
INDIRI4
ADDRLP4 476
INDIRI4
LEI4 $539
line 912
;902:
;903://unlagged - optimized prediction
;904:	// do a /condump after a few seconds of this
;905:	//CG_Printf("cg.time: %d, numPredicted: %d, numPlayedBack: %d\n", cg.time, numPredicted, numPlayedBack); // debug code
;906:	// if everything is working right, numPredicted should be 1 more than 98%
;907:	// of the time, meaning only ONE predicted move was done in the frame
;908:	// you should see other values for numPredicted after IsUnacceptableError
;909:	// returns nonzero, and that's it
;910://unlagged - optimized prediction
;911:
;912:	if ( cg_showmiss.integer > 1 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $672
line 913
;913:		CG_Printf( "[%i : %i] ", cg_pmove.cmd.serverTime, cg.time );
ADDRGP4 $675
ARGP4
ADDRGP4 cg_pmove+4
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 914
;914:	}
LABELV $672
line 916
;915:
;916:	if ( !moved ) {
ADDRLP4 480
INDIRI4
CNSTI4 0
NEI4 $678
line 917
;917:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $420
line 918
;918:			CG_Printf( "not moved\n" );
ADDRGP4 $683
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 919
;919:		}
line 920
;920:		return;
ADDRGP4 $420
JUMPV
LABELV $678
line 924
;921:	}
;922:
;923:	// adjust for the movement of the groundentity
;924:	CG_AdjustPositionForMover( cg.predictedPlayerState.origin, 
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+68
INDIRI4
ARGI4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+152
ARGP4
ADDRGP4 cg+107636+152
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 928
;925:		cg.predictedPlayerState.groundEntityNum, 
;926:		cg.physicsTime, cg.time, cg.predictedPlayerState.origin,cg.predictedPlayerState.viewangles,cg.predictedPlayerState.viewangles );
;927:
;928:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $696
line 929
;929:		if (cg.predictedPlayerState.eventSequence > oldPlayerState.eventSequence + MAX_PS_EVENTS) {
ADDRGP4 cg+107636+108
INDIRI4
ADDRLP4 8+108
INDIRI4
CNSTI4 2
ADDI4
LEI4 $699
line 930
;930:			CG_Printf("WARNING: dropped event\n");
ADDRGP4 $704
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 931
;931:		}
LABELV $699
line 932
;932:	}
LABELV $696
line 935
;933:
;934:	// fire events and other transition triggered things
;935:	CG_TransitionPlayerState( &cg.predictedPlayerState, &oldPlayerState );
ADDRGP4 cg+107636
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_TransitionPlayerState
CALLV
pop
line 937
;936:
;937:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $706
line 938
;938:		if (cg.eventSequence > cg.predictedPlayerState.eventSequence) {
ADDRGP4 cg+109060
INDIRI4
ADDRGP4 cg+107636+108
INDIRI4
LEI4 $709
line 939
;939:			CG_Printf("WARNING: double event\n");
ADDRGP4 $714
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 940
;940:			cg.eventSequence = cg.predictedPlayerState.eventSequence;
ADDRGP4 cg+109060
ADDRGP4 cg+107636+108
INDIRI4
ASGNI4
line 941
;941:		}
LABELV $709
line 942
;942:	}
LABELV $706
line 943
;943:}
LABELV $420
endproc CG_PredictPlayerState 620 28
bss
align 4
LABELV cg_triggerEntities
skip 1024
align 4
LABELV cg_numTriggerEntities
skip 4
align 4
LABELV cg_solidEntities
skip 1024
align 4
LABELV cg_numSolidEntities
skip 4
align 4
LABELV cg_pmove
skip 240
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
LABELV $714
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $704
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $683
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $675
byte 1 91
byte 1 37
byte 1 105
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 0
align 1
LABELV $670
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $613
byte 1 68
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $600
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $585
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $569
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 84
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $526
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 99
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $484
byte 1 51
byte 1 51
byte 1 0
align 1
LABELV $480
byte 1 56
byte 1 0
align 1
LABELV $479
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $462
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 80
byte 1 65
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 66
byte 1 65
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $327
byte 1 100
byte 1 101
byte 1 108
byte 1 116
byte 1 97
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 32
byte 1 0
