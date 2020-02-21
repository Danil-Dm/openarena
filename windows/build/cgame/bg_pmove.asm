data
export pm_stopspeed
align 4
LABELV pm_stopspeed
byte 4 1120403456
export pm_duckScale
align 4
LABELV pm_duckScale
byte 4 1048576000
export pm_swimScale
align 4
LABELV pm_swimScale
byte 4 1056964608
export pm_wadeScale
align 4
LABELV pm_wadeScale
byte 4 1060320051
export pm_swimFastScale
align 4
LABELV pm_swimFastScale
byte 4 1084227584
export pm_accelerate
align 4
LABELV pm_accelerate
byte 4 1092616192
export pm_airaccelerate
align 4
LABELV pm_airaccelerate
byte 4 1065353216
export pm_wateraccelerate
align 4
LABELV pm_wateraccelerate
byte 4 1082130432
export pm_flyaccelerate
align 4
LABELV pm_flyaccelerate
byte 4 1090519040
export pm_friction
align 4
LABELV pm_friction
byte 4 1086324736
export pm_waterfriction
align 4
LABELV pm_waterfriction
byte 4 1065353216
export pm_flightfriction
align 4
LABELV pm_flightfriction
byte 4 1077936128
export pm_spectatorfriction
align 4
LABELV pm_spectatorfriction
byte 4 1084227584
export c_pmove
align 4
LABELV c_pmove
byte 4 0
export PM_AddEvent
code
proc PM_AddEvent 0 12
file "../../../code/game/bg_pmove.c"
line 62
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
;23:// bg_pmove.c -- both games player movement code
;24:// takes a playerstate and a usercmd as input and returns a modifed playerstate
;25:
;26:#include "../qcommon/q_shared.h"
;27:#include "bg_public.h"
;28:#include "bg_local.h"
;29:#include "g_local.h"
;30:
;31:pmove_t		*pm;
;32:pml_t		pml;
;33:
;34:// movement parameters
;35:float	pm_stopspeed = 100.0f;
;36:float	pm_duckScale = 0.25f;
;37:float	pm_swimScale = 0.50f;
;38:float	pm_wadeScale = 0.70f;
;39:
;40:const float	pm_swimFastScale = 5.0f;
;41:
;42:float	pm_accelerate = 10.0f;
;43:float	pm_airaccelerate = 1.0f;
;44:float	pm_wateraccelerate = 4.0f;
;45:float	pm_flyaccelerate = 8.0f;
;46:
;47:float	pm_friction = 6.0f;
;48:float	pm_waterfriction = 1.0f;
;49:float	pm_flightfriction = 3.0f;
;50:float	pm_spectatorfriction = 5.0f;
;51:
;52:int		c_pmove = 0;
;53:
;54:extern	vmCvar_t	cg_enableQ;		// leilei - map changes player/weapons scale (for q1 adaptations)
;55:/*
;56:===============
;57:PM_AddEvent
;58:
;59:===============
;60:*/
;61:void PM_AddEvent( int newEvent )
;62:{
line 63
;63:	BG_AddPredictableEventToPlayerstate( newEvent, 0, pm->ps );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 pm
INDIRP4
INDIRP4
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 64
;64:}
LABELV $61
endproc PM_AddEvent 0 12
export PM_AddTouchEnt
proc PM_AddTouchEnt 12 0
line 72
;65:
;66:/*
;67:===============
;68:PM_AddTouchEnt
;69:===============
;70:*/
;71:void PM_AddTouchEnt( int entityNum )
;72:{
line 75
;73:	int		i;
;74:
;75:	if ( entityNum == ENTITYNUM_WORLD ) {
ADDRFP4 0
INDIRI4
CNSTI4 1022
NEI4 $63
line 76
;76:		return;
ADDRGP4 $62
JUMPV
LABELV $63
line 78
;77:	}
;78:	if ( pm->numtouch == MAXTOUCH ) {
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 32
NEI4 $65
line 79
;79:		return;
ADDRGP4 $62
JUMPV
LABELV $65
line 83
;80:	}
;81:
;82:	// see if it is already added
;83:	for ( i = 0 ; i < pm->numtouch ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $70
JUMPV
LABELV $67
line 84
;84:		if ( pm->touchents[ i ] == entityNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
CNSTI4 52
ADDP4
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $71
line 85
;85:			return;
ADDRGP4 $62
JUMPV
LABELV $71
line 87
;86:		}
;87:	}
LABELV $68
line 83
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $70
ADDRLP4 0
INDIRI4
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
LTI4 $67
line 90
;88:
;89:	// add it
;90:	pm->touchents[pm->numtouch] = entityNum;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 91
;91:	pm->numtouch++;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
CNSTI4 48
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
line 92
;92:}
LABELV $62
endproc PM_AddTouchEnt 12 0
proc PM_StartTorsoAnim 8 0
line 100
;93:
;94:/*
;95:===================
;96:PM_StartTorsoAnim
;97:===================
;98:*/
;99:static void PM_StartTorsoAnim( int anim )
;100:{
line 101
;101:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $74
line 102
;102:		return;
ADDRGP4 $73
JUMPV
LABELV $74
line 104
;103:	}
;104:	pm->ps->torsoAnim = ( ( pm->ps->torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
ASGNP4
ADDRLP4 4
CNSTI4 128
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 106
;105:	                    | anim;
;106:}
LABELV $73
endproc PM_StartTorsoAnim 8 0
proc PM_StartLegsAnim 8 0
line 108
;107:static void PM_StartLegsAnim( int anim )
;108:{
line 109
;109:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $77
line 110
;110:		return;
ADDRGP4 $76
JUMPV
LABELV $77
line 112
;111:	}
;112:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $79
line 113
;113:		return;		// a high priority animation is running
ADDRGP4 $76
JUMPV
LABELV $79
line 115
;114:	}
;115:	pm->ps->legsAnim = ( ( pm->ps->legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 4
CNSTI4 128
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 117
;116:	                   | anim;
;117:}
LABELV $76
endproc PM_StartLegsAnim 8 0
proc PM_ContinueLegsAnim 0 4
line 120
;118:
;119:static void PM_ContinueLegsAnim( int anim )
;120:{
line 121
;121:	if ( ( pm->ps->legsAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $82
line 122
;122:		return;
ADDRGP4 $81
JUMPV
LABELV $82
line 124
;123:	}
;124:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $84
line 125
;125:		return;		// a high priority animation is running
ADDRGP4 $81
JUMPV
LABELV $84
line 127
;126:	}
;127:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 128
;128:}
LABELV $81
endproc PM_ContinueLegsAnim 0 4
proc PM_ContinueTorsoAnim 0 4
line 131
;129:
;130:static void PM_ContinueTorsoAnim( int anim )
;131:{
line 132
;132:	if ( ( pm->ps->torsoAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $87
line 133
;133:		return;
ADDRGP4 $86
JUMPV
LABELV $87
line 135
;134:	}
;135:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $89
line 136
;136:		return;		// a high priority animation is running
ADDRGP4 $86
JUMPV
LABELV $89
line 138
;137:	}
;138:	PM_StartTorsoAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 139
;139:}
LABELV $86
endproc PM_ContinueTorsoAnim 0 4
proc PM_ForceLegsAnim 0 4
line 142
;140:
;141:static void PM_ForceLegsAnim( int anim )
;142:{
line 143
;143:	pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 144
;144:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 145
;145:}
LABELV $91
endproc PM_ForceLegsAnim 0 4
export PM_ClipVelocity
proc PM_ClipVelocity 32 0
line 156
;146:
;147:
;148:/*
;149:==================
;150:PM_ClipVelocity
;151:
;152:Slide off of the impacting surface
;153:==================
;154:*/
;155:void PM_ClipVelocity( vec3_t in, vec3_t normal, vec3_t out, float overbounce )
;156:{
line 161
;157:	float	backoff;
;158:	float	change;
;159:	int		i;
;160:
;161:	backoff = DotProduct (in, normal);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 163
;162:
;163:	if ( backoff < 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GEF4 $93
line 164
;164:		backoff *= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 165
;165:	}
ADDRGP4 $94
JUMPV
LABELV $93
line 166
;166:	else {
line 167
;167:		backoff /= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
ASGNF4
line 168
;168:	}
LABELV $94
line 170
;169:
;170:	for ( i=0 ; i<3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $95
line 171
;171:		change = normal[i]*backoff;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 172
;172:		out[i] = in[i] - change;
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 28
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 173
;173:	}
LABELV $96
line 170
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $95
line 174
;174:}
LABELV $92
endproc PM_ClipVelocity 32 0
proc PM_Friction 48 4
line 185
;175:
;176:
;177:/*
;178:==================
;179:PM_Friction
;180:
;181:Handles both ground friction and water friction
;182:==================
;183:*/
;184:static void PM_Friction( void )
;185:{
line 191
;186:	vec3_t	vec;
;187:	float	*vel;
;188:	float	speed, newspeed, control;
;189:	float	drop;
;190:
;191:	vel = pm->ps->velocity;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
line 193
;192:
;193:	VectorCopy( vel, vec );
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 12
line 194
;194:	if ( pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $100
line 195
;195:		vec[2] = 0;	// ignore slope movement
ADDRLP4 16+8
CNSTF4 0
ASGNF4
line 196
;196:	}
LABELV $100
line 198
;197:
;198:	speed = VectorLength(vec);
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 199
;199:	if (speed < 1) {
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
GEF4 $104
line 200
;200:		vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 201
;201:		vel[1] = 0;		// allow sinking underwater
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 203
;202:		// FIXME: still have z friction underwater?
;203:		return;
ADDRGP4 $99
JUMPV
LABELV $104
line 206
;204:	}
;205:
;206:	drop = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 209
;207:
;208:	// apply ground friction
;209:	if ( pm->waterlevel <= 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
GTI4 $106
line 210
;210:		if ( pml.walking && !(pml.groundTrace.surfaceFlags & SURF_SLICK) ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 pml+44
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $108
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 36
INDIRI4
NEI4 $108
line 212
;211:			// if getting knocked back, no friction
;212:			if ( ! (pm->ps->pm_flags & PMF_TIME_KNOCKBACK) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $113
line 213
;213:				control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 8
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $116
ADDRLP4 40
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $117
JUMPV
LABELV $116
ADDRLP4 40
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $117
ADDRLP4 28
ADDRLP4 40
INDIRF4
ASGNF4
line 214
;214:				drop += control*pm_friction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
ADDRGP4 pm_friction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 215
;215:			}
LABELV $113
line 216
;216:		}
LABELV $108
line 217
;217:	}
LABELV $106
line 220
;218:
;219:	// apply water friction even if just wading
;220:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
EQI4 $119
line 221
;221:		drop += speed*pm_waterfriction*pm->waterlevel*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_waterfriction
INDIRF4
MULF4
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 222
;222:	}
LABELV $119
line 225
;223:
;224:	// apply flying friction
;225:	if ( pm->ps->powerups[PW_FLIGHT]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $122
line 226
;226:		drop += speed*pm_flightfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_flightfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 227
;227:	}
LABELV $122
line 229
;228:
;229:	if ( pm->ps->pm_type == PM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $125
line 230
;230:		drop += speed*pm_spectatorfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_spectatorfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 231
;231:	}
LABELV $125
line 234
;232:
;233:	// scale the velocity
;234:	newspeed = speed - drop;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 235
;235:	if (newspeed < 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $128
line 236
;236:		newspeed = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 237
;237:	}
LABELV $128
line 238
;238:	newspeed /= speed;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 240
;239:
;240:	vel[0] = vel[0] * newspeed;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 241
;241:	vel[1] = vel[1] * newspeed;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 242
;242:	vel[2] = vel[2] * newspeed;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 243
;243:}
LABELV $99
endproc PM_Friction 48 4
proc PM_Accelerate 60 4
line 256
;244:
;245:
;246:/*
;247:==============
;248:PM_Accelerate
;249:
;250:TODO: bunny hoping
;251:
;252:Handles user intended acceleration
;253:==============
;254:*/
;255:static void PM_Accelerate( vec3_t wishdir, float wishspeed, float accel )
;256:{
line 257
;257:	if(! (pm->pmove_flags & DF_NO_BUNNY) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $131
line 262
;258:		// q2 style
;259:		int			i;
;260:		float		addspeed, accelspeed, currentspeed;
;261:
;262:		currentspeed = DotProduct (pm->ps->velocity, wishdir);
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 263
;263:		addspeed = wishspeed - currentspeed;
ADDRLP4 8
ADDRFP4 4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 264
;264:		if (addspeed <= 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $133
line 265
;265:			return;
ADDRGP4 $130
JUMPV
LABELV $133
line 267
;266:		}
;267:		accelspeed = accel*pml.frametime*wishspeed;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 268
;268:		if (accelspeed > addspeed) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $136
line 269
;269:			accelspeed = addspeed;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 270
;270:		}
LABELV $136
line 272
;271:
;272:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $138
line 273
;273:			pm->ps->velocity[i] += accelspeed*wishdir[i];
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
ADDRLP4 24
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 274
;274:		}
LABELV $139
line 272
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $138
line 275
;275:	}
ADDRGP4 $132
JUMPV
LABELV $131
line 276
;276:	else {
line 283
;277:		// proper way (avoids strafe jump maxspeed bug), but feels bad
;278:		vec3_t		wishVelocity;
;279:		vec3_t		pushDir;
;280:		float		pushLen;
;281:		float		canPush;
;282:
;283:		VectorScale( wishdir, wishspeed, wishVelocity );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 284
;284:		VectorSubtract( wishVelocity, pm->ps->velocity, pushDir );
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
SUBF4
ASGNF4
line 285
;285:		pushLen = VectorNormalize( pushDir );
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 44
INDIRF4
ASGNF4
line 287
;286:
;287:		canPush = accel*pml.frametime*wishspeed;
ADDRLP4 24
ADDRFP4 8
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 288
;288:		if (canPush > pushLen) {
ADDRLP4 24
INDIRF4
ADDRLP4 28
INDIRF4
LEF4 $149
line 289
;289:			canPush = pushLen;
ADDRLP4 24
ADDRLP4 28
INDIRF4
ASGNF4
line 290
;290:		}
LABELV $149
line 292
;291:
;292:		VectorMA( pm->ps->velocity, canPush, pushDir, pm->ps->velocity );
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
line 293
;293:	}
LABELV $132
line 294
;294:}
LABELV $130
endproc PM_Accelerate 60 4
proc PM_CmdScale 44 4
line 308
;295:
;296:
;297:
;298:/*
;299:============
;300:PM_CmdScale
;301:
;302:Returns the scale factor to apply to cmd movements
;303:This allows the clients to use axial -127 to 127 values for all directions
;304:without getting a sqrt(2) distortion in speed.
;305:============
;306:*/
;307:static float PM_CmdScale( usercmd_t *cmd )
;308:{
line 313
;309:	int		max;
;310:	float	total;
;311:	float	scale;
;312:
;313:	max = abs( cmd->forwardmove );
ADDRFP4 0
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 314
;314:	if ( abs( cmd->rightmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $154
line 315
;315:		max = abs( cmd->rightmove );
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 316
;316:	}
LABELV $154
line 317
;317:	if ( abs( cmd->upmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $156
line 318
;318:		max = abs( cmd->upmove );
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 319
;319:	}
LABELV $156
line 320
;320:	if ( !max ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $158
line 321
;321:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $153
JUMPV
LABELV $158
line 324
;322:	}
;323:
;324:	total = sqrt( cmd->forwardmove * cmd->forwardmove
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 36
ADDRLP4 24
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 28
INDIRI4
MULI4
ADDRLP4 32
INDIRI4
ADDRLP4 32
INDIRI4
MULI4
ADDI4
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
MULI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 40
INDIRF4
ASGNF4
line 326
;325:	              + cmd->rightmove * cmd->rightmove + cmd->upmove * cmd->upmove );
;326:	scale = (float)pm->ps->speed * max / ( 127.0 * total );
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CVIF4 4
MULF4
CNSTF4 1123942400
ADDRLP4 4
INDIRF4
MULF4
DIVF4
ASGNF4
line 328
;327:
;328:	return scale;
ADDRLP4 8
INDIRF4
RETF4
LABELV $153
endproc PM_CmdScale 44 4
proc PM_SetMovementDir 72 0
line 341
;329:}
;330:
;331:
;332:/*
;333:================
;334:PM_SetMovementDir
;335:
;336:Determine the rotation of the legs reletive
;337:to the facing dir
;338:================
;339:*/
;340:static void PM_SetMovementDir( void )
;341:{
line 342
;342:	if ( pm->cmd.forwardmove || pm->cmd.rightmove ) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $163
ADDRLP4 0
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
EQI4 $161
LABELV $163
line 343
;343:		if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove > 0 ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
NEI4 $164
ADDRLP4 8
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
LEI4 $164
line 344
;344:			pm->ps->movementDir = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 345
;345:		}
ADDRGP4 $162
JUMPV
LABELV $164
line 346
;346:		else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove > 0 ) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
GEI4 $166
ADDRLP4 16
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
LEI4 $166
line 347
;347:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 348
;348:		}
ADDRGP4 $162
JUMPV
LABELV $166
line 349
;349:		else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove == 0 ) {
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 28
INDIRI4
GEI4 $168
ADDRLP4 24
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 28
INDIRI4
NEI4 $168
line 350
;350:			pm->ps->movementDir = 2;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 2
ASGNI4
line 351
;351:		}
ADDRGP4 $162
JUMPV
LABELV $168
line 352
;352:		else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove < 0 ) {
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
GEI4 $170
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
GEI4 $170
line 353
;353:			pm->ps->movementDir = 3;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 3
ASGNI4
line 354
;354:		}
ADDRGP4 $162
JUMPV
LABELV $170
line 355
;355:		else if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove < 0 ) {
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
NEI4 $172
ADDRLP4 40
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
GEI4 $172
line 356
;356:			pm->ps->movementDir = 4;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 4
ASGNI4
line 357
;357:		}
ADDRGP4 $162
JUMPV
LABELV $172
line 358
;358:		else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove < 0 ) {
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
LEI4 $174
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
GEI4 $174
line 359
;359:			pm->ps->movementDir = 5;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 5
ASGNI4
line 360
;360:		}
ADDRGP4 $162
JUMPV
LABELV $174
line 361
;361:		else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove == 0 ) {
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 60
INDIRI4
LEI4 $176
ADDRLP4 56
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 60
INDIRI4
NEI4 $176
line 362
;362:			pm->ps->movementDir = 6;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 6
ASGNI4
line 363
;363:		}
ADDRGP4 $162
JUMPV
LABELV $176
line 364
;364:		else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove > 0 ) {
ADDRLP4 64
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 68
INDIRI4
LEI4 $162
ADDRLP4 64
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 68
INDIRI4
LEI4 $162
line 365
;365:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 366
;366:		}
line 367
;367:	}
ADDRGP4 $162
JUMPV
LABELV $161
line 368
;368:	else {
line 372
;369:		// if they aren't actively going directly sideways,
;370:		// change the animation to the diagonal so they
;371:		// don't stop too crooked
;372:		if ( pm->ps->movementDir == 2 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 2
NEI4 $180
line 373
;373:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 374
;374:		}
ADDRGP4 $181
JUMPV
LABELV $180
line 375
;375:		else if ( pm->ps->movementDir == 6 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 6
NEI4 $182
line 376
;376:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 377
;377:		}
LABELV $182
LABELV $181
line 378
;378:	}
LABELV $162
line 379
;379:}
LABELV $160
endproc PM_SetMovementDir 72 0
proc PM_CheckJump 8 4
line 388
;380:
;381:
;382:/*
;383:=============
;384:PM_CheckJump
;385:=============
;386:*/
;387:static qboolean PM_CheckJump( void )
;388:{
line 391
;389:
;390:
;391:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $185
line 392
;392:		return qfalse;		// don't allow jump until all buttons are up
CNSTI4 0
RETI4
ADDRGP4 $184
JUMPV
LABELV $185
line 395
;393:	}
;394:
;395:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $187
line 397
;396:		// not holding jump
;397:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $184
JUMPV
LABELV $187
line 402
;398:	}
;399:
;400:
;401:	// must wait for jump to be released
;402:	if ( pm->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $189
line 404
;403:		// clear upmove so cmdscale doesn't lower running speed
;404:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 405
;405:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $184
JUMPV
LABELV $189
line 411
;406:	}
;407:
;408:
;409:
;410:
;411:	pml.groundPlane = qfalse;		// jumping away
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 412
;412:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 413
;413:	pm->ps->pm_flags |= PMF_JUMP_HELD;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
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
line 415
;414:
;415:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 416
;416:	pm->ps->velocity[2] = JUMP_VELOCITY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ADDRGP4 mod_jumpheight
INDIRI4
CVIF4 4
ASGNF4
line 417
;417:	PM_AddEvent( EV_JUMP );
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 419
;418:
;419:	if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $193
line 420
;420:		PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 421
;421:		pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 422
;422:	}
ADDRGP4 $194
JUMPV
LABELV $193
line 423
;423:	else {
line 424
;424:		PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 425
;425:		pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 426
;426:	}
LABELV $194
line 428
;427:
;428:	return qtrue;
CNSTI4 1
RETI4
LABELV $184
endproc PM_CheckJump 8 4
proc PM_CheckWaterJump 56 8
line 437
;429:}
;430:
;431:/*
;432:=============
;433:PM_CheckWaterJump
;434:=============
;435:*/
;436:static qboolean	PM_CheckWaterJump( void )
;437:{
line 442
;438:	vec3_t	spot;
;439:	int		cont;
;440:	vec3_t	flatforward;
;441:
;442:	if (pm->ps->pm_time) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $196
line 443
;443:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $195
JUMPV
LABELV $196
line 447
;444:	}
;445:
;446:	// check for water jump
;447:	if ( pm->waterlevel != 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
EQI4 $198
line 448
;448:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $195
JUMPV
LABELV $198
line 451
;449:	}
;450:
;451:	flatforward[0] = pml.forward[0];
ADDRLP4 12
ADDRGP4 pml
INDIRF4
ASGNF4
line 452
;452:	flatforward[1] = pml.forward[1];
ADDRLP4 12+4
ADDRGP4 pml+4
INDIRF4
ASGNF4
line 453
;453:	flatforward[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 454
;454:	VectorNormalize (flatforward);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 456
;455:
;456:	VectorMA (pm->ps->origin, 30, flatforward, spot);
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
CNSTF4 1106247680
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1106247680
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 457
;457:	spot[2] += 4;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 458
;458:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 40
INDIRI4
ASGNI4
line 459
;459:	if ( !(cont & CONTENTS_SOLID) ) {
ADDRLP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $208
line 460
;460:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $195
JUMPV
LABELV $208
line 463
;461:	}
;462:
;463:	spot[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 464
;464:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 48
INDIRI4
ASGNI4
line 465
;465:	if ( cont & (CONTENTS_SOLID|CONTENTS_PLAYERCLIP|CONTENTS_BODY) ) {
ADDRLP4 24
INDIRI4
CNSTI4 33619969
BANDI4
CNSTI4 0
EQI4 $211
line 466
;466:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $195
JUMPV
LABELV $211
line 470
;467:	}
;468:
;469:	// jump out of water
;470:	VectorScale (pml.forward, 200, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1128792064
ADDRGP4 pml
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1128792064
ADDRGP4 pml+4
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1128792064
ADDRGP4 pml+8
INDIRF4
MULF4
ASGNF4
line 471
;471:	pm->ps->velocity[2] = 350;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1135542272
ASGNF4
line 473
;472:
;473:	pm->ps->pm_flags |= PMF_TIME_WATERJUMP;
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 474
;474:	pm->ps->pm_time = 2000;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 2000
ASGNI4
line 476
;475:
;476:	return qtrue;
CNSTI4 1
RETI4
LABELV $195
endproc PM_CheckWaterJump 56 8
proc PM_WaterJumpMove 12 4
line 490
;477:}
;478:
;479://============================================================================
;480:
;481:
;482:/*
;483:===================
;484:PM_WaterJumpMove
;485:
;486:Flying out of the water
;487:===================
;488:*/
;489:static void PM_WaterJumpMove( void )
;490:{
line 493
;491:	// waterjump has no control, but falls
;492:
;493:	PM_StepSlideMove( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 495
;494:
;495:	pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
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
line 496
;496:	if (pm->ps->velocity[2] < 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
GEF4 $217
line 498
;497:		// cancel as soon as we are falling down again
;498:		pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 499
;499:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 500
;500:	}
LABELV $217
line 501
;501:}
LABELV $215
endproc PM_WaterJumpMove 12 4
proc PM_WaterMove 80 16
line 510
;502:
;503:/*
;504:===================
;505:PM_WaterMove
;506:
;507:===================
;508:*/
;509:static void PM_WaterMove( void )
;510:{
line 519
;511:	int		i;
;512:	vec3_t	wishvel;
;513:	float	wishspeed;
;514:	vec3_t	wishdir;
;515:	float	scale;
;516:	float	vel;
;517:	float	swimScale;
;518:
;519:	if ( PM_CheckWaterJump() ) {
ADDRLP4 44
ADDRGP4 PM_CheckWaterJump
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $220
line 520
;520:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 521
;521:		return;
ADDRGP4 $219
JUMPV
LABELV $220
line 523
;522:	}
;523:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 525
;524:
;525:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 48
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 48
INDIRF4
ASGNF4
line 529
;526:	//
;527:	// user intentions
;528:	//
;529:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $222
line 530
;530:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 531
;531:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 532
;532:		wishvel[2] = -60;		// sink towards bottom
ADDRLP4 8+8
CNSTF4 3262119936
ASGNF4
line 533
;533:	}
ADDRGP4 $223
JUMPV
LABELV $222
line 534
;534:	else {
line 535
;535:		for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $226
line 536
;536:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 52
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 60
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 52
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 60
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 52
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 60
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
LABELV $227
line 535
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $226
line 538
;537:
;538:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 539
;539:	}
LABELV $223
line 541
;540:
;541:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 8
INDIRB
ASGNB 12
line 542
;542:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 52
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 52
INDIRF4
ASGNF4
line 544
;543:
;544:	swimScale = pm_swimScale;
ADDRLP4 36
ADDRGP4 pm_swimScale
INDIRF4
ASGNF4
line 545
;545:	if(pm->pmove_flags & DF_FAST_WATER_MOVE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $232
line 546
;546:		swimScale = pm_swimFastScale;
ADDRLP4 36
ADDRGP4 pm_swimFastScale
INDIRF4
ASGNF4
line 547
;547:	}
LABELV $232
line 549
;548:
;549:	if ( wishspeed > pm->ps->speed * swimScale ) {
ADDRLP4 20
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
MULF4
LEF4 $234
line 550
;550:		wishspeed = pm->ps->speed * swimScale;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 551
;551:	}
LABELV $234
line 553
;552:
;553:	PM_Accelerate (wishdir, wishspeed, pm_wateraccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 pm_wateraccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 556
;554:
;555:	// make sure we can go up slopes easily under water
;556:	if ( pml.groundPlane && DotProduct( pm->ps->velocity, pml.groundTrace.plane.normal ) < 0 ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $236
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 56
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $236
line 557
;557:		vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 60
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 60
INDIRF4
ASGNF4
line 559
;558:		// slide along the ground plane
;559:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal,
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 562
;560:		                 pm->ps->velocity, OVERCLIP );
;561:
;562:		VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 563
;563:		VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
line 564
;564:	}
LABELV $236
line 566
;565:
;566:	PM_SlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_SlideMove
CALLI4
pop
line 567
;567:}
LABELV $219
endproc PM_WaterMove 80 16
proc PM_InvulnerabilityMove 8 0
line 577
;568:
;569:/*
;570:===================
;571:PM_InvulnerabilityMove
;572:
;573:Only with the invulnerability powerup
;574:===================
;575:*/
;576:static void PM_InvulnerabilityMove( void )
;577:{
line 578
;578:	pm->cmd.forwardmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 579
;579:	pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 580
;580:	pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 581
;581:	VectorClear(pm->ps->velocity);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 582
;582:}
LABELV $249
endproc PM_InvulnerabilityMove 8 0
proc PM_FlyMove 52 12
line 592
;583:
;584:/*
;585:===================
;586:PM_FlyMove
;587:
;588:Only with the flight powerup
;589:===================
;590:*/
;591:static void PM_FlyMove( void )
;592:{
line 600
;593:	int		i;
;594:	vec3_t	wishvel;
;595:	float	wishspeed;
;596:	vec3_t	wishdir;
;597:	float	scale;
;598:
;599:	// normal slowdown
;600:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 602
;601:
;602:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
ASGNF4
line 606
;603:	//
;604:	// user intentions
;605:	//
;606:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $251
line 607
;607:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 608
;608:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 609
;609:		wishvel[2] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 610
;610:	}
ADDRGP4 $252
JUMPV
LABELV $251
line 611
;611:	else {
line 612
;612:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $255
line 613
;613:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 40
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 40
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 614
;614:		}
LABELV $256
line 612
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $255
line 616
;615:
;616:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 617
;617:	}
LABELV $252
line 619
;618:
;619:	VectorCopy (wishvel, wishdir);
ADDRLP4 20
ADDRLP4 8
INDIRB
ASGNB 12
line 620
;620:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 20
ARGP4
ADDRLP4 40
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 40
INDIRF4
ASGNF4
line 622
;621:
;622:	PM_Accelerate (wishdir, wishspeed, pm_flyaccelerate);
ADDRLP4 20
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 pm_flyaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 624
;623:
;624:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 625
;625:}
LABELV $250
endproc PM_FlyMove 52 12
proc PM_AirMove 80 16
line 635
;626:
;627:
;628:/*
;629:===================
;630:PM_AirMove
;631:
;632:===================
;633:*/
;634:static void PM_AirMove( void )
;635:{
line 644
;636:	int			i;
;637:	vec3_t		wishvel;
;638:	float		fmove, smove;
;639:	vec3_t		wishdir;
;640:	float		wishspeed;
;641:	float		scale;
;642:	usercmd_t	cmd;
;643:
;644:	PM_Friction();
ADDRGP4 PM_Friction
CALLV
pop
line 646
;645:
;646:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 647
;647:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 649
;648:
;649:	cmd = pm->cmd;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 650
;650:	scale = PM_CmdScale( &cmd );
ADDRLP4 44
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 68
INDIRF4
ASGNF4
line 653
;651:
;652:	// set the movementDir so clients can rotate the legs for strafing
;653:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 656
;654:
;655:	// project moves down to flat plane
;656:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 657
;657:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 658
;658:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 659
;659:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 661
;660:
;661:	for ( i = 0 ; i < 2 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $266
line 662
;662:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 72
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 72
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 663
;663:	}
LABELV $267
line 661
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $266
line 664
;664:	wishvel[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 666
;665:
;666:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 4
INDIRB
ASGNB 12
line 667
;667:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 72
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 72
INDIRF4
ASGNF4
line 668
;668:	wishspeed *= scale;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
line 671
;669:
;670:	// not on ground, so little effect on velocity
;671:	PM_Accelerate (wishdir, wishspeed, pm_airaccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 pm_airaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 676
;672:
;673:	// we may have a ground plane that is very steep, even
;674:	// though we don't have a groundentity
;675:	// slide along the steep plane
;676:	if ( pml.groundPlane ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $272
line 677
;677:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal,
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 679
;678:		                 pm->ps->velocity, OVERCLIP );
;679:	}
LABELV $272
line 691
;680:
;681:#if 0
;682:	//ZOID:  If we are on the grapple, try stair-stepping
;683:	//this allows a player to use the grapple to pull himself
;684:	//over a ledge
;685:	if (pm->ps->pm_flags & PMF_GRAPPLE_PULL)
;686:		PM_StepSlideMove ( qtrue );
;687:	else
;688:		PM_SlideMove ( qtrue );
;689:#endif
;690:
;691:	PM_StepSlideMove ( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 692
;692:}
LABELV $261
endproc PM_AirMove 80 16
proc PM_GrappleMove 52 4
line 701
;693:
;694:/*
;695:===================
;696:PM_GrappleMove
;697:
;698:===================
;699:*/
;700:static void PM_GrappleMove( void )
;701:{
line 705
;702:	vec3_t vel, v;
;703:	float vlen;
;704:
;705:	VectorScale(pml.forward, -16, v);
ADDRLP4 28
CNSTF4 3246391296
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ADDRGP4 pml
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28
INDIRF4
ADDRGP4 pml+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+8
CNSTF4 3246391296
ADDRGP4 pml+8
INDIRF4
MULF4
ASGNF4
line 706
;706:	VectorAdd(pm->ps->grapplePoint, v, v);
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 707
;707:	VectorSubtract(v, pm->ps->origin, vel);
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 36
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
ADDRLP4 36
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
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 708
;708:	vlen = VectorLength(vel);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 40
INDIRF4
ASGNF4
line 709
;709:	VectorNormalize( vel );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 711
;710:
;711:	if (vlen <= 100)
ADDRLP4 24
INDIRF4
CNSTF4 1120403456
GTF4 $290
line 712
;712:		VectorScale(vel, 10 * vlen, vel);
ADDRLP4 44
CNSTF4 1092616192
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1092616192
ADDRLP4 24
INDIRF4
MULF4
MULF4
ASGNF4
ADDRGP4 $291
JUMPV
LABELV $290
line 714
;713:	else
;714:		VectorScale(vel, 800, vel);
ADDRLP4 48
CNSTF4 1145569280
ASGNF4
ADDRLP4 0
ADDRLP4 48
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 48
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1145569280
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
LABELV $291
line 716
;715:
;716:	VectorCopy(vel, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 718
;717:
;718:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 719
;719:}
LABELV $277
endproc PM_GrappleMove 52 4
proc PM_WalkMove 128 16
line 728
;720:
;721:/*
;722:===================
;723:PM_WalkMove
;724:
;725:===================
;726:*/
;727:static void PM_WalkMove( void )
;728:{
line 739
;729:	int			i;
;730:	vec3_t		wishvel;
;731:	float		fmove, smove;
;732:	vec3_t		wishdir;
;733:	float		wishspeed;
;734:	float		scale;
;735:	usercmd_t	cmd;
;736:	float		accelerate;
;737:	float		vel;
;738:
;739:	if ( pm->waterlevel > 2 && DotProduct( pml.forward, pml.groundTrace.plane.normal ) > 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
LEI4 $302
ADDRGP4 pml
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRGP4 pml+4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRGP4 pml+8
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
LEF4 $302
line 741
;740:		// begin swimming
;741:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 742
;742:		return;
ADDRGP4 $301
JUMPV
LABELV $302
line 746
;743:	}
;744:
;745:
;746:	if ( PM_CheckJump () ) {
ADDRLP4 76
ADDRGP4 PM_CheckJump
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $314
line 748
;747:		// jumped away
;748:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LEI4 $316
line 749
;749:			PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 750
;750:		}
ADDRGP4 $301
JUMPV
LABELV $316
line 751
;751:		else {
line 752
;752:			PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 753
;753:		}
line 754
;754:		return;
ADDRGP4 $301
JUMPV
LABELV $314
line 757
;755:	}
;756:
;757:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 759
;758:
;759:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 760
;760:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 762
;761:
;762:	cmd = pm->cmd;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 763
;763:	scale = PM_CmdScale( &cmd );
ADDRLP4 48
ARGP4
ADDRLP4 80
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 80
INDIRF4
ASGNF4
line 766
;764:
;765:	// set the movementDir so clients can rotate the legs for strafing
;766:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 769
;767:
;768:	// project moves down to flat plane
;769:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 770
;770:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 773
;771:
;772:	// project the forward and right directions onto the ground plane
;773:	PM_ClipVelocity (pml.forward, pml.groundTrace.plane.normal, pml.forward, OVERCLIP );
ADDRLP4 84
ADDRGP4 pml
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 774
;774:	PM_ClipVelocity (pml.right, pml.groundTrace.plane.normal, pml.right, OVERCLIP );
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRGP4 pml+12
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 776
;775:	//
;776:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 777
;777:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 779
;778:
;779:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $328
line 780
;780:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 88
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 88
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 88
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 781
;781:	}
LABELV $329
line 779
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $328
line 783
;782:
;783:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 784
;784:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 88
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 88
INDIRF4
ASGNF4
line 785
;785:	wishspeed *= scale;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
line 788
;786:
;787:	// clamp the speed lower if ducking
;788:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $333
line 789
;789:		if ( wishspeed > pm->ps->speed * pm_duckScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
LEF4 $335
line 790
;790:			wishspeed = pm->ps->speed * pm_duckScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
ASGNF4
line 791
;791:		}
LABELV $335
line 792
;792:	}
LABELV $333
line 795
;793:
;794:	// clamp the speed lower if wading or walking on the bottom
;795:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
EQI4 $337
line 798
;796:		float	waterScale;
;797:
;798:		waterScale = pm->waterlevel / 3.0;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1077936128
DIVF4
ASGNF4
line 799
;799:		waterScale = 1.0 - ( 1.0 - pm_swimScale ) * waterScale;
ADDRLP4 96
CNSTF4 1065353216
ASGNF4
ADDRLP4 92
ADDRLP4 96
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 pm_swimScale
INDIRF4
SUBF4
ADDRLP4 92
INDIRF4
MULF4
SUBF4
ASGNF4
line 800
;800:		if ( wishspeed > pm->ps->speed * waterScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
LEF4 $339
line 801
;801:			wishspeed = pm->ps->speed * waterScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
line 802
;802:		}
LABELV $339
line 803
;803:	}
LABELV $337
line 807
;804:
;805:	// when a player gets hit, they temporarily lose
;806:	// full control, which allows them to be moved a bit
;807:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 92
INDIRI4
NEI4 $345
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 92
INDIRI4
EQI4 $341
LABELV $345
line 808
;808:		accelerate = pm_airaccelerate;
ADDRLP4 72
ADDRGP4 pm_airaccelerate
INDIRF4
ASGNF4
line 809
;809:	}
ADDRGP4 $342
JUMPV
LABELV $341
line 810
;810:	else {
line 811
;811:		accelerate = pm_accelerate;
ADDRLP4 72
ADDRGP4 pm_accelerate
INDIRF4
ASGNF4
line 812
;812:	}
LABELV $342
line 814
;813:
;814:	PM_Accelerate (wishdir, wishspeed, accelerate);
ADDRLP4 32
ARGP4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 816
;815:
;816:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 96
INDIRI4
NEI4 $350
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 96
INDIRI4
EQI4 $346
LABELV $350
line 817
;817:		pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 100
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 104
ADDRLP4 100
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
ADDRLP4 100
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
line 818
;818:	}
LABELV $346
line 820
;819:
;820:	vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 100
INDIRF4
ASGNF4
line 823
;821:
;822:	// slide along the ground plane
;823:	PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal,
ADDRLP4 104
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 827
;824:	                 pm->ps->velocity, OVERCLIP );
;825:
;826:	// don't decrease velocity when going up or down a slope
;827:	VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 828
;828:	VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 108
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 116
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 831
;829:
;830:	// don't do anything if standing still
;831:	if (!pm->ps->velocity[0] && !pm->ps->velocity[1]) {
ADDRLP4 120
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 124
CNSTF4 0
ASGNF4
ADDRLP4 120
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 124
INDIRF4
NEF4 $354
ADDRLP4 120
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 124
INDIRF4
NEF4 $354
line 832
;832:		return;
ADDRGP4 $301
JUMPV
LABELV $354
line 835
;833:	}
;834:
;835:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 836
;836:}
LABELV $301
endproc PM_WalkMove 128 16
proc PM_DeadMove 20 4
line 845
;837:
;838:
;839:/*
;840:==============
;841:PM_DeadMove
;842:==============
;843:*/
;844:static void PM_DeadMove( void )
;845:{
line 848
;846:	float	forward;
;847:
;848:	if ( !pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
NEI4 $357
line 849
;849:		return;
ADDRGP4 $356
JUMPV
LABELV $357
line 854
;850:	}
;851:
;852:	// extra friction
;853:
;854:	forward = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 855
;855:	forward -= 20;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 856
;856:	if ( forward <= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $360
line 857
;857:		VectorClear (pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 858
;858:	}
ADDRGP4 $361
JUMPV
LABELV $360
line 859
;859:	else {
line 860
;860:		VectorNormalize (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 861
;861:		VectorScale (pm->ps->velocity, forward, pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 862
;862:	}
LABELV $361
line 863
;863:}
LABELV $356
endproc PM_DeadMove 20 4
proc PM_NoclipMove 104 12
line 872
;864:
;865:
;866:/*
;867:===============
;868:PM_NoclipMove
;869:===============
;870:*/
;871:static void PM_NoclipMove( void )
;872:{
line 880
;873:	float	speed, drop, friction, control, newspeed;
;874:	int			i;
;875:	vec3_t		wishvel;
;876:	float		fmove, smove;
;877:	vec3_t		wishdir;
;878:	float		wishspeed;
;879:	float		scale;
;880:	if (cg_enableQ.value)
ADDRGP4 cg_enableQ+8
INDIRF4
CNSTF4 0
EQF4 $363
line 881
;881:		pm->ps->viewheight = QUACK_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 22
ASGNI4
ADDRGP4 $364
JUMPV
LABELV $363
line 883
;882:	else
;883:		pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
LABELV $364
line 887
;884:
;885:	// friction
;886:
;887:	speed = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 64
INDIRF4
ASGNF4
line 888
;888:	if (speed < 1) {
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
GEF4 $366
line 889
;889:		VectorCopy (vec3_origin, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 890
;890:	}
ADDRGP4 $367
JUMPV
LABELV $366
line 891
;891:	else {
line 892
;892:		drop = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 894
;893:
;894:		friction = pm_friction*1.5;	// extra friction
ADDRLP4 56
CNSTF4 1069547520
ADDRGP4 pm_friction
INDIRF4
MULF4
ASGNF4
line 895
;895:		control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 24
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $369
ADDRLP4 68
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $370
JUMPV
LABELV $369
ADDRLP4 68
ADDRLP4 24
INDIRF4
ASGNF4
LABELV $370
ADDRLP4 60
ADDRLP4 68
INDIRF4
ASGNF4
line 896
;896:		drop += control*friction*pml.frametime;
ADDRLP4 52
ADDRLP4 52
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 899
;897:
;898:		// scale the velocity
;899:		newspeed = speed - drop;
ADDRLP4 28
ADDRLP4 24
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
line 900
;900:		if (newspeed < 0)
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $372
line 901
;901:			newspeed = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
LABELV $372
line 902
;902:		newspeed /= speed;
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
DIVF4
ASGNF4
line 904
;903:
;904:		VectorScale (pm->ps->velocity, newspeed, pm->ps->velocity);
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 905
;905:	}
LABELV $367
line 908
;906:
;907:	// accelerate
;908:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 68
INDIRF4
ASGNF4
line 910
;909:
;910:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 911
;911:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 913
;912:
;913:	for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $374
line 914
;914:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 72
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 72
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $375
line 913
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $374
line 915
;915:	wishvel[2] += pm->cmd.upmove;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ADDF4
ASGNF4
line 917
;916:
;917:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 918
;918:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 76
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 76
INDIRF4
ASGNF4
line 919
;919:	wishspeed *= scale;
ADDRLP4 44
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 921
;920:
;921:	PM_Accelerate( wishdir, wishspeed, pm_accelerate );
ADDRLP4 32
ARGP4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 pm_accelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 924
;922:
;923:	// move
;924:	VectorMA (pm->ps->origin, pml.frametime, pm->ps->velocity, pm->ps->origin);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 100
ADDRLP4 96
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 925
;925:}
LABELV $362
endproc PM_NoclipMove 104 12
proc PM_FootstepForSurface 0 0
line 937
;926:
;927://============================================================================
;928:
;929:/*
;930:================
;931:PM_FootstepForSurface
;932:
;933:Returns an event number apropriate for the groundsurface
;934:================
;935:*/
;936:static int PM_FootstepForSurface( void )
;937:{
line 938
;938:	if ( pml.groundTrace.surfaceFlags & SURF_NOSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $384
line 939
;939:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $383
JUMPV
LABELV $384
line 941
;940:	}
;941:	if ( pml.groundTrace.surfaceFlags & SURF_METALSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $388
line 942
;942:		return EV_FOOTSTEP_METAL;
CNSTI4 2
RETI4
ADDRGP4 $383
JUMPV
LABELV $388
line 944
;943:	}
;944:	return EV_FOOTSTEP;
CNSTI4 1
RETI4
LABELV $383
endproc PM_FootstepForSurface 0 0
proc PM_CrashLand 52 4
line 956
;945:}
;946:
;947:
;948:/*
;949:=================
;950:PM_CrashLand
;951:
;952:Check for hard landings that generate sound events
;953:=================
;954:*/
;955:static void PM_CrashLand( void )
;956:{
line 964
;957:	float		delta;
;958:	float		dist;
;959:	float		vel, acc;
;960:	float		t;
;961:	float		a, b, c, den;
;962:
;963:	// decide which landing animation to use
;964:	if ( pm->ps->pm_flags & PMF_BACKWARDS_JUMP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $393
line 965
;965:		PM_ForceLegsAnim( LEGS_LANDB );
CNSTI4 21
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 966
;966:	}
ADDRGP4 $394
JUMPV
LABELV $393
line 967
;967:	else {
line 968
;968:		PM_ForceLegsAnim( LEGS_LAND );
CNSTI4 19
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 969
;969:	}
LABELV $394
line 971
;970:
;971:	pm->ps->legsTimer = TIMER_LAND;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 130
ASGNI4
line 974
;972:
;973:	// calculate the exact velocity on landing
;974:	dist = pm->ps->origin[2] - pml.previous_origin[2];
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 pml+112+8
INDIRF4
SUBF4
ASGNF4
line 975
;975:	vel = pml.previous_velocity[2];
ADDRLP4 8
ADDRGP4 pml+124+8
INDIRF4
ASGNF4
line 976
;976:	acc = -pm->ps->gravity;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 978
;977:
;978:	a = acc / 2;
ADDRLP4 16
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 979
;979:	b = vel;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 980
;980:	c = -dist;
ADDRLP4 32
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
line 982
;981:
;982:	den =  b * b - 4 * a * c;
ADDRLP4 20
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1082130432
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
MULF4
SUBF4
ASGNF4
line 983
;983:	if ( den < 0 ) {
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $399
line 984
;984:		return;
ADDRGP4 $392
JUMPV
LABELV $399
line 986
;985:	}
;986:	t = (-b - sqrt( den ) ) / ( 2 * a );
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 40
INDIRF4
SUBF4
CNSTF4 1073741824
ADDRLP4 16
INDIRF4
MULF4
DIVF4
ASGNF4
line 988
;987:
;988:	delta = vel + t * acc;
ADDRLP4 0
ADDRLP4 8
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 989
;989:	delta = delta*delta * 0.0001;
ADDRLP4 0
CNSTF4 953267991
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
MULF4
ASGNF4
line 992
;990:
;991:	// ducking while falling doubles damage
;992:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $401
line 993
;993:		delta *= 2;
ADDRLP4 0
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 994
;994:	}
LABELV $401
line 997
;995:
;996:	// never take falling damage if completely underwater
;997:	if ( pm->waterlevel == 3 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 3
NEI4 $403
line 998
;998:		return;
ADDRGP4 $392
JUMPV
LABELV $403
line 1002
;999:	}
;1000:
;1001:	// reduce falling damage if there is standing water
;1002:	if ( pm->waterlevel == 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
NEI4 $405
line 1003
;1003:		delta *= 0.25;
ADDRLP4 0
CNSTF4 1048576000
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 1004
;1004:	}
LABELV $405
line 1005
;1005:	if ( pm->waterlevel == 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
NEI4 $407
line 1006
;1006:		delta *= 0.5;
ADDRLP4 0
CNSTF4 1056964608
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 1007
;1007:	}
LABELV $407
line 1009
;1008:
;1009:	if ( delta < 1 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $409
line 1010
;1010:		return;
ADDRGP4 $392
JUMPV
LABELV $409
line 1017
;1011:	}
;1012:
;1013:	// create a local entity event to play the sound
;1014:
;1015:	// SURF_NODAMAGE is used for bounce pads where you don't ever
;1016:	// want to take damage or play a crunch sound
;1017:	if ( !(pml.groundTrace.surfaceFlags & SURF_NODAMAGE) )  {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $411
line 1018
;1018:		if ( delta > 60 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1114636288
LEF4 $415
line 1019
;1019:			PM_AddEvent( EV_FALL_FAR );
CNSTI4 12
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1020
;1020:		}
ADDRGP4 $416
JUMPV
LABELV $415
line 1021
;1021:		else if ( delta > 40 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1109393408
LEF4 $417
line 1023
;1022:			// this is a pain grunt, so don't play it if dead
;1023:			if ( pm->ps->stats[STAT_HEALTH] > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $418
line 1024
;1024:				PM_AddEvent( EV_FALL_MEDIUM );
CNSTI4 11
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1025
;1025:			}
line 1026
;1026:		}
ADDRGP4 $418
JUMPV
LABELV $417
line 1027
;1027:		else if ( delta > 7 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1088421888
LEF4 $421
line 1028
;1028:			PM_AddEvent( EV_FALL_SHORT );
CNSTI4 10
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1029
;1029:		}
ADDRGP4 $422
JUMPV
LABELV $421
line 1030
;1030:		else {
line 1031
;1031:			PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 48
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1032
;1032:		}
LABELV $422
LABELV $418
LABELV $416
line 1033
;1033:	}
LABELV $411
line 1036
;1034:
;1035:	// start footstep cycle over
;1036:	pm->ps->bobCycle = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1037
;1037:}
LABELV $392
endproc PM_CrashLand 52 4
proc PM_CorrectAllSolid 36 28
line 1045
;1038:
;1039:/*
;1040:=============
;1041:PM_CorrectAllSolid
;1042:=============
;1043:*/
;1044:static int PM_CorrectAllSolid( trace_t *trace )
;1045:{
line 1049
;1046:	int			i, j, k;
;1047:	vec3_t		point;
;1048:
;1049:	if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $424
line 1050
;1050:		Com_Printf("%i:allsolid\n", c_pmove);
ADDRGP4 $426
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1051
;1051:	}
LABELV $424
line 1054
;1052:
;1053:	// jitter around
;1054:	for (i = -1; i <= 1; i++) {
ADDRLP4 20
CNSTI4 -1
ASGNI4
LABELV $427
line 1055
;1055:		for (j = -1; j <= 1; j++) {
ADDRLP4 16
CNSTI4 -1
ASGNI4
LABELV $431
line 1056
;1056:			for (k = -1; k <= 1; k++) {
ADDRLP4 12
CNSTI4 -1
ASGNI4
LABELV $435
line 1057
;1057:				VectorCopy(pm->ps->origin, point);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1058
;1058:				point[0] += (float) i;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1059
;1059:				point[1] += (float) j;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1060
;1060:				point[2] += (float) k;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1061
;1061:				pm->trace (trace, point, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CALLV
pop
line 1062
;1062:				if ( !trace->allsolid ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $441
line 1063
;1063:					point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1064
;1064:					point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1065
;1065:					point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1067
;1066:
;1067:					pm->trace (trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CALLV
pop
line 1068
;1068:					pml.groundTrace = *trace;
ADDRGP4 pml+52
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 56
line 1069
;1069:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $423
JUMPV
LABELV $441
line 1071
;1070:				}
;1071:			}
LABELV $436
line 1056
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
LEI4 $435
line 1072
;1072:		}
LABELV $432
line 1055
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LEI4 $431
line 1073
;1073:	}
LABELV $428
line 1054
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
LEI4 $427
line 1075
;1074:
;1075:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1076
;1076:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1077
;1077:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1079
;1078:
;1079:	return qfalse;
CNSTI4 0
RETI4
LABELV $423
endproc PM_CorrectAllSolid 36 28
proc PM_GroundTraceMissed 80 28
line 1091
;1080:}
;1081:
;1082:
;1083:/*
;1084:=============
;1085:PM_GroundTraceMissed
;1086:
;1087:The ground trace didn't hit a surface, so we are in freefall
;1088:=============
;1089:*/
;1090:static void PM_GroundTraceMissed( void )
;1091:{
line 1095
;1092:	trace_t		trace;
;1093:	vec3_t		point;
;1094:
;1095:	if ( pm->ps->groundEntityNum != ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $449
line 1097
;1096:		// we just transitioned into freefall
;1097:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $451
line 1098
;1098:			Com_Printf("%i:lift\n", c_pmove);
ADDRGP4 $453
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1099
;1099:		}
LABELV $451
line 1103
;1100:
;1101:		// if they aren't in a jumping animation and the ground is a ways away, force into it
;1102:		// if we didn't do the trace, the player would be backflipping down staircases
;1103:		VectorCopy( pm->ps->origin, point );
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1104
;1104:		point[2] -= 64;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 1106
;1105:
;1106:		pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 12
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CALLV
pop
line 1107
;1107:		if ( trace.fraction == 1.0 ) {
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $455
line 1108
;1108:			if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $458
line 1109
;1109:				PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1110
;1110:				pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1111
;1111:			}
ADDRGP4 $459
JUMPV
LABELV $458
line 1112
;1112:			else {
line 1113
;1113:				PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1114
;1114:				pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1115
;1115:			}
LABELV $459
line 1116
;1116:		}
LABELV $455
line 1117
;1117:	}
LABELV $449
line 1119
;1118:
;1119:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1120
;1120:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1121
;1121:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1122
;1122:}
LABELV $448
endproc PM_GroundTraceMissed 80 28
proc PM_GroundTrace 88 28
line 1131
;1123:
;1124:
;1125:/*
;1126:=============
;1127:PM_GroundTrace
;1128:=============
;1129:*/
;1130:static void PM_GroundTrace( void )
;1131:{
line 1135
;1132:	vec3_t		point;
;1133:	trace_t		trace;
;1134:
;1135:	point[0] = pm->ps->origin[0];
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1136
;1136:	point[1] = pm->ps->origin[1];
ADDRLP4 56+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1137
;1137:	point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 56+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1139
;1138:
;1139:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CALLV
pop
line 1140
;1140:	pml.groundTrace = trace;
ADDRGP4 pml+52
ADDRLP4 0
INDIRB
ASGNB 56
line 1143
;1141:
;1142:	// do something corrective if the trace starts in a solid...
;1143:	if ( trace.allsolid ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $466
line 1144
;1144:		if ( !PM_CorrectAllSolid(&trace) )
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 PM_CorrectAllSolid
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $468
line 1145
;1145:			return;
ADDRGP4 $462
JUMPV
LABELV $468
line 1146
;1146:	}
LABELV $466
line 1149
;1147:
;1148:	// if the trace didn't hit anything, we are in free fall
;1149:	if ( trace.fraction == 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $470
line 1150
;1150:		PM_GroundTraceMissed();
ADDRGP4 PM_GroundTraceMissed
CALLV
pop
line 1151
;1151:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1152
;1152:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1153
;1153:		return;
ADDRGP4 $462
JUMPV
LABELV $470
line 1157
;1154:	}
;1155:
;1156:	// check if getting thrown off the ground
;1157:	if ( pm->ps->velocity[2] > 0 && DotProduct( pm->ps->velocity, trace.plane.normal ) > 10 ) {
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 76
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ASGNF4
ADDRLP4 80
INDIRF4
CNSTF4 0
LEF4 $475
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
MULF4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 80
INDIRF4
ADDRLP4 0+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
LEF4 $475
line 1158
;1158:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $482
line 1159
;1159:			Com_Printf("%i:kickoff\n", c_pmove);
ADDRGP4 $484
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1160
;1160:		}
LABELV $482
line 1162
;1161:		// go into jump animation
;1162:		if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $485
line 1163
;1163:			PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1164
;1164:			pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1165
;1165:		}
ADDRGP4 $486
JUMPV
LABELV $485
line 1166
;1166:		else {
line 1167
;1167:			PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1168
;1168:			pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1169
;1169:		}
LABELV $486
line 1171
;1170:
;1171:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1172
;1172:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1173
;1173:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1174
;1174:		return;
ADDRGP4 $462
JUMPV
LABELV $475
line 1178
;1175:	}
;1176:
;1177:	// slopes that are too steep will not be considered onground
;1178:	if ( trace.plane.normal[2] < MIN_WALK_NORMAL ) {
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1060320051
GEF4 $489
line 1179
;1179:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $493
line 1180
;1180:			Com_Printf("%i:steep\n", c_pmove);
ADDRGP4 $495
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1181
;1181:		}
LABELV $493
line 1184
;1182:		// FIXME: if they can't slide down the slope, let them
;1183:		// walk (sharp crevices)
;1184:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1185
;1185:		pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1186
;1186:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1187
;1187:		return;
ADDRGP4 $462
JUMPV
LABELV $489
line 1190
;1188:	}
;1189:
;1190:	pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1191
;1191:	pml.walking = qtrue;
ADDRGP4 pml+44
CNSTI4 1
ASGNI4
line 1194
;1192:
;1193:	// hitting solid ground will end a waterjump
;1194:	if (pm->ps->pm_flags & PMF_TIME_WATERJUMP) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $500
line 1195
;1195:		pm->ps->pm_flags &= ~(PMF_TIME_WATERJUMP | PMF_TIME_LAND);
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 -289
BANDI4
ASGNI4
line 1196
;1196:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1197
;1197:	}
LABELV $500
line 1199
;1198:
;1199:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $502
line 1201
;1200:		// just hit the ground
;1201:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $504
line 1202
;1202:			Com_Printf("%i:Land\n", c_pmove);
ADDRGP4 $506
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1203
;1203:		}
LABELV $504
line 1205
;1204:
;1205:		PM_CrashLand();
ADDRGP4 PM_CrashLand
CALLV
pop
line 1208
;1206:
;1207:		// don't do landing time if we were just going down a slope
;1208:		if ( pml.previous_velocity[2] < -200 ) {
ADDRGP4 pml+124+8
INDIRF4
CNSTF4 3276275712
GEF4 $507
line 1210
;1209:			// don't allow another jump for a little while
;1210:			pm->ps->pm_flags |= PMF_TIME_LAND;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1211
;1211:			pm->ps->pm_time = 250;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 250
ASGNI4
line 1212
;1212:		}
LABELV $507
line 1213
;1213:	}
LABELV $502
line 1215
;1214:
;1215:	pm->ps->groundEntityNum = trace.entityNum;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 1217
;1216:
;1217:	PM_AddTouchEnt( trace.entityNum );
ADDRLP4 0+52
INDIRI4
ARGI4
ADDRGP4 PM_AddTouchEnt
CALLV
pop
line 1218
;1218:}
LABELV $462
endproc PM_GroundTrace 88 28
proc PM_SetWaterLevel 48 8
line 1227
;1219:
;1220:
;1221:/*
;1222:=============
;1223:PM_SetWaterLevel	FIXME: avoid this twice?  certainly if not moving
;1224:=============
;1225:*/
;1226:static void PM_SetWaterLevel( void )
;1227:{
line 1236
;1228:	vec3_t		point;
;1229:	int			cont;
;1230:	int			sample1;
;1231:	int			sample2;
;1232:
;1233:	//
;1234:	// get waterlevel, accounting for ducking
;1235:	//
;1236:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 0
ASGNI4
line 1237
;1237:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1239
;1238:
;1239:	point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1240
;1240:	point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1241
;1241:	point[2] = pm->ps->origin[2] + MINS_Z + 1;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1242
;1242:	cont = pm->pointcontents( point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1244
;1243:
;1244:	if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $516
line 1245
;1245:		sample2 = pm->ps->viewheight - MINS_Z;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 1246
;1246:		sample1 = sample2 / 2;
ADDRLP4 20
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1248
;1247:
;1248:		pm->watertype = cont;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1249
;1249:		pm->waterlevel = 1;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 1
ASGNI4
line 1250
;1250:		point[2] = pm->ps->origin[2] + MINS_Z + sample1;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1251
;1251:		cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 1252
;1252:		if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $519
line 1253
;1253:			pm->waterlevel = 2;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 2
ASGNI4
line 1254
;1254:			point[2] = pm->ps->origin[2] + MINS_Z + sample2;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1255
;1255:			cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 1256
;1256:			if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $522
line 1257
;1257:				pm->waterlevel = 3;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 3
ASGNI4
line 1258
;1258:			}
LABELV $522
line 1259
;1259:		}
LABELV $519
line 1260
;1260:	}
LABELV $516
line 1262
;1261:
;1262:}
LABELV $513
endproc PM_SetWaterLevel 48 8
proc PM_CheckDuck 76 28
line 1272
;1263:
;1264:/*
;1265:==============
;1266:PM_CheckDuck
;1267:
;1268:Sets mins, maxs, and pm->ps->viewheight
;1269:==============
;1270:*/
;1271:static void PM_CheckDuck (void)
;1272:{
line 1275
;1273:	trace_t	trace;
;1274:
;1275:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $525
line 1276
;1276:		if ( pm->ps->pm_flags & PMF_INVULEXPAND ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $527
line 1278
;1277:			// invulnerability sphere has a 42 units radius
;1278:			VectorSet( pm->mins, -42, -42, -42 );
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3257401344
ASGNF4
line 1279
;1279:			VectorSet( pm->maxs, 42, 42, 42 );
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1109917696
ASGNF4
line 1280
;1280:		}
ADDRGP4 $528
JUMPV
LABELV $527
line 1281
;1281:		else {
line 1282
;1282:			VectorSet( pm->mins, -15, -15, MINS_Z );
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3250585600
ASGNF4
line 1283
;1283:			VectorSet( pm->maxs, 15, 15, 16 );
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1098907648
ASGNF4
line 1284
;1284:		}
LABELV $528
line 1285
;1285:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1286
;1286:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1287
;1287:		return;
ADDRGP4 $524
JUMPV
LABELV $525
line 1289
;1288:	}
;1289:	pm->ps->pm_flags &= ~PMF_INVULEXPAND;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1291
;1290:
;1291:	pm->mins[0] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3245342720
ASGNF4
line 1292
;1292:	pm->mins[1] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3245342720
ASGNF4
line 1294
;1293:
;1294:	pm->maxs[0] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1097859072
ASGNF4
line 1295
;1295:	pm->maxs[1] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1097859072
ASGNF4
line 1297
;1296:
;1297:	pm->mins[2] = MINS_Z;
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3250585600
ASGNF4
line 1299
;1298:
;1299:	if (pm->ps->pm_type == PM_DEAD) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $529
line 1300
;1300:		pm->maxs[2] = -8;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 3238002688
ASGNF4
line 1301
;1301:		pm->ps->viewheight = DEAD_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 -16
ASGNI4
line 1302
;1302:		return;
ADDRGP4 $524
JUMPV
LABELV $529
line 1305
;1303:	}
;1304:
;1305:	if (pm->cmd.upmove < 0) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $531
line 1307
;1306:		// duck
;1307:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1308
;1308:	}
ADDRGP4 $532
JUMPV
LABELV $531
line 1309
;1309:	else {
line 1311
;1310:		// stand up if possible
;1311:		if (pm->ps->pm_flags & PMF_DUCKED) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $533
line 1313
;1312:			// try to stand up
;1313:			pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1107296256
ASGNF4
line 1314
;1314:			pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask );
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CALLV
pop
line 1315
;1315:			if (!trace.allsolid)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $535
line 1316
;1316:				pm->ps->pm_flags &= ~PMF_DUCKED;
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
LABELV $535
line 1317
;1317:		}
LABELV $533
line 1318
;1318:	}
LABELV $532
line 1320
;1319:
;1320:	if (pm->ps->pm_flags & PMF_DUCKED) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $537
line 1321
;1321:		pm->maxs[2] = 16;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1098907648
ASGNF4
line 1322
;1322:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1323
;1323:	}
ADDRGP4 $538
JUMPV
LABELV $537
line 1324
;1324:	else {
line 1325
;1325:		pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1107296256
ASGNF4
line 1326
;1326:		if (cg_enableQ.value)
ADDRGP4 cg_enableQ+8
INDIRF4
CNSTF4 0
EQF4 $539
line 1327
;1327:			pm->ps->viewheight = QUACK_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 22
ASGNI4
ADDRGP4 $540
JUMPV
LABELV $539
line 1329
;1328:		else
;1329:			pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
LABELV $540
line 1331
;1330:
;1331:	}
LABELV $538
line 1332
;1332:}
LABELV $524
endproc PM_CheckDuck 76 28
proc PM_Footsteps 56 4
line 1345
;1333:
;1334:
;1335:
;1336://===================================================================
;1337:
;1338:
;1339:/*
;1340:===============
;1341:PM_Footsteps
;1342:===============
;1343:*/
;1344:static void PM_Footsteps( void )
;1345:{
line 1354
;1346:	float		bobmove;
;1347:	int			old;
;1348:	qboolean	footstep;
;1349:
;1350:	//
;1351:	// calculate speed and cycle to be used for
;1352:	// all cyclic walking effects
;1353:	//
;1354:	pm->xyspeed = sqrt( pm->ps->velocity[0] * pm->ps->velocity[0]
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 24
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 28
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 212
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1357
;1355:	                    +  pm->ps->velocity[1] * pm->ps->velocity[1] );
;1356:
;1357:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $543
line 1359
;1358:
;1359:		if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $545
line 1360
;1360:			PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1361
;1361:		}
LABELV $545
line 1363
;1362:		// airborne leaves position in cycle intact, but doesn't advance
;1363:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LEI4 $542
line 1364
;1364:			PM_ContinueLegsAnim( LEGS_SWIM );
CNSTI4 17
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1365
;1365:		}
line 1366
;1366:		return;
ADDRGP4 $542
JUMPV
LABELV $543
line 1370
;1367:	}
;1368:
;1369:	// if not trying to move
;1370:	if ( !pm->cmd.forwardmove && !pm->cmd.rightmove ) {
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
NEI4 $549
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
NEI4 $549
line 1371
;1371:		if (  pm->xyspeed < 5 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
CNSTF4 1084227584
GEF4 $542
line 1372
;1372:			pm->ps->bobCycle = 0;	// start at beginning of cycle again
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1373
;1373:			if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $553
line 1374
;1374:				PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1375
;1375:			}
ADDRGP4 $542
JUMPV
LABELV $553
line 1376
;1376:			else {
line 1377
;1377:				PM_ContinueLegsAnim( LEGS_IDLE );
CNSTI4 22
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1378
;1378:			}
line 1379
;1379:		}
line 1380
;1380:		return;
ADDRGP4 $542
JUMPV
LABELV $549
line 1384
;1381:	}
;1382:
;1383:
;1384:	footstep = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1386
;1385:
;1386:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $555
line 1387
;1387:		bobmove = 0.5;	// ducked characters bob much faster
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1388
;1388:		if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $557
line 1389
;1389:			PM_ContinueLegsAnim( LEGS_BACKCR );
CNSTI4 46
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1390
;1390:		}
ADDRGP4 $556
JUMPV
LABELV $557
line 1391
;1391:		else {
line 1392
;1392:			PM_ContinueLegsAnim( LEGS_WALKCR );
CNSTI4 13
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1393
;1393:		}
line 1394
;1394:	}
ADDRGP4 $556
JUMPV
LABELV $555
line 1395
;1395:	else {
line 1396
;1396:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $559
line 1397
;1397:			bobmove = 0.4f;	// faster speeds bob faster
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 1398
;1398:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $561
line 1399
;1399:				PM_ContinueLegsAnim( LEGS_BACK );
CNSTI4 16
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1400
;1400:			}
ADDRGP4 $562
JUMPV
LABELV $561
line 1402
;1401:			// leilei - new strafe animations for OA3
;1402:			else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove == 0 )
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
GEI4 $563
ADDRLP4 40
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
NEI4 $563
line 1403
;1403:				PM_ContinueLegsAnim( LEGS_STRAFE_LEFT );
CNSTI4 43
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
ADDRGP4 $564
JUMPV
LABELV $563
line 1404
;1404:			else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove == 0 )
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
LEI4 $565
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
NEI4 $565
line 1405
;1405:				PM_ContinueLegsAnim( LEGS_STRAFE_RIGHT );
CNSTI4 44
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
ADDRGP4 $566
JUMPV
LABELV $565
line 1407
;1406:
;1407:			else {
line 1408
;1408:				PM_ContinueLegsAnim( LEGS_RUN );
CNSTI4 15
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1409
;1409:			}
LABELV $566
LABELV $564
LABELV $562
line 1410
;1410:			footstep = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1411
;1411:		}
ADDRGP4 $560
JUMPV
LABELV $559
line 1412
;1412:		else {
line 1413
;1413:			bobmove = 0.3f;	// walking bobs slow
ADDRLP4 4
CNSTF4 1050253722
ASGNF4
line 1414
;1414:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $567
line 1415
;1415:				PM_ContinueLegsAnim( LEGS_BACKWALK );
CNSTI4 47
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1416
;1416:			}
ADDRGP4 $568
JUMPV
LABELV $567
line 1417
;1417:			else {
line 1418
;1418:				PM_ContinueLegsAnim( LEGS_WALK );
CNSTI4 14
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1419
;1419:			}
LABELV $568
line 1420
;1420:		}
LABELV $560
line 1421
;1421:	}
LABELV $556
line 1424
;1422:
;1423:	// check for footstep / splash sounds
;1424:	old = pm->ps->bobCycle;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1425
;1425:	pm->ps->bobCycle = (int)( old + bobmove * pml.msec ) & 255;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
CNSTI4 255
BANDI4
ASGNI4
line 1428
;1426:
;1427:	// if we just crossed a cycle boundary, play an apropriate footstep event
;1428:	if ( ( ( old + 64 ) ^ ( pm->ps->bobCycle + 64 ) ) & 128 ) {
ADDRLP4 40
CNSTI4 64
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
BXORI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $570
line 1429
;1429:		if ( pm->waterlevel == 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
NEI4 $572
line 1431
;1430:			// on ground will only play sounds if running
;1431:			if ( footstep && !pm->noFootsteps ) {
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $573
ADDRGP4 pm
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
NEI4 $573
line 1432
;1432:				PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 48
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1433
;1433:			}
line 1434
;1434:		}
ADDRGP4 $573
JUMPV
LABELV $572
line 1435
;1435:		else if ( pm->waterlevel == 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
NEI4 $576
line 1437
;1436:			// splashing
;1437:			PM_AddEvent( EV_FOOTSPLASH );
CNSTI4 3
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1438
;1438:		}
ADDRGP4 $577
JUMPV
LABELV $576
line 1439
;1439:		else if ( pm->waterlevel == 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
NEI4 $578
line 1441
;1440:			// wading / swimming at surface
;1441:			PM_AddEvent( EV_SWIM );
CNSTI4 5
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1442
;1442:		}
ADDRGP4 $579
JUMPV
LABELV $578
line 1443
;1443:		else if ( pm->waterlevel == 3 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 3
NEI4 $580
line 1446
;1444:			// no sound when completely underwater
;1445:
;1446:		}
LABELV $580
LABELV $579
LABELV $577
LABELV $573
line 1447
;1447:	}
LABELV $570
line 1448
;1448:}
LABELV $542
endproc PM_Footsteps 56 4
proc PM_WaterEvents 16 4
line 1458
;1449:
;1450:/*
;1451:==============
;1452:PM_WaterEvents
;1453:
;1454:Generate sound events for entering and leaving water
;1455:==============
;1456:*/
;1457:static void PM_WaterEvents( void )  		// FIXME?
;1458:{
line 1462
;1459:	//
;1460:	// if just entered a water volume, play a sound
;1461:	//
;1462:	if (!pml.previous_waterlevel && pm->waterlevel) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $583
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $583
line 1463
;1463:		PM_AddEvent( EV_WATER_TOUCH );
CNSTI4 15
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1464
;1464:	}
LABELV $583
line 1469
;1465:
;1466:	//
;1467:	// if just completely exited a water volume, play a sound
;1468:	//
;1469:	if (pml.previous_waterlevel && !pm->waterlevel) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $586
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $586
line 1470
;1470:		PM_AddEvent( EV_WATER_LEAVE );
CNSTI4 16
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1471
;1471:	}
LABELV $586
line 1476
;1472:
;1473:	//
;1474:	// check for head just going under water
;1475:	//
;1476:	if (pml.previous_waterlevel != 3 && pm->waterlevel == 3) {
ADDRLP4 8
CNSTI4 3
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $589
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $589
line 1477
;1477:		PM_AddEvent( EV_WATER_UNDER );
CNSTI4 17
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1478
;1478:	}
LABELV $589
line 1483
;1479:
;1480:	//
;1481:	// check for head just coming out of water
;1482:	//
;1483:	if (pml.previous_waterlevel == 3 && pm->waterlevel != 3) {
ADDRLP4 12
CNSTI4 3
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $592
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $592
line 1484
;1484:		PM_AddEvent( EV_WATER_CLEAR );
CNSTI4 18
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1485
;1485:	}
LABELV $592
line 1486
;1486:}
LABELV $582
endproc PM_WaterEvents 16 4
proc PM_BeginWeaponChange 8 4
line 1495
;1487:
;1488:
;1489:/*
;1490:===============
;1491:PM_BeginWeaponChange
;1492:===============
;1493:*/
;1494:static void PM_BeginWeaponChange( int weapon )
;1495:{
line 1496
;1496:	if ( weapon <= WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $598
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $596
LABELV $598
line 1497
;1497:		return;
ADDRGP4 $595
JUMPV
LABELV $596
line 1500
;1498:	}
;1499:
;1500:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $599
line 1501
;1501:		return;
ADDRGP4 $595
JUMPV
LABELV $599
line 1504
;1502:	}
;1503:
;1504:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $601
line 1505
;1505:		return;
ADDRGP4 $595
JUMPV
LABELV $601
line 1508
;1506:	}
;1507:
;1508:	if(pm->pmove_flags & DF_INSTANT_WEAPON_CHANGE) {
ADDRGP4 pm
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $603
line 1509
;1509:		pm->ps->weaponstate = WEAPON_DROPPING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 1510
;1510:	}
ADDRGP4 $604
JUMPV
LABELV $603
line 1511
;1511:	else {
line 1512
;1512:		PM_AddEvent( EV_CHANGE_WEAPON );
CNSTI4 22
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1513
;1513:		pm->ps->weaponstate = WEAPON_DROPPING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 1514
;1514:		pm->ps->weaponTime += 200;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1515
;1515:		PM_StartTorsoAnim( TORSO_DROP );
CNSTI4 9
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1516
;1516:	}
LABELV $604
line 1517
;1517:}
LABELV $595
endproc PM_BeginWeaponChange 8 4
proc PM_FinishWeaponChange 12 4
line 1526
;1518:
;1519:
;1520:/*
;1521:===============
;1522:PM_FinishWeaponChange
;1523:===============
;1524:*/
;1525:static void PM_FinishWeaponChange( void )
;1526:{
line 1529
;1527:	int		weapon;
;1528:
;1529:	weapon = pm->cmd.weapon;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 1530
;1530:	if ( weapon < WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $608
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $606
LABELV $608
line 1531
;1531:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1532
;1532:	}
LABELV $606
line 1534
;1533:
;1534:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $609
line 1535
;1535:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1536
;1536:	}
LABELV $609
line 1538
;1537:
;1538:	pm->ps->weapon = weapon;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1539
;1539:	pm->ps->weaponstate = WEAPON_RAISING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1
ASGNI4
line 1540
;1540:	if(! (pm->pmove_flags & DF_INSTANT_WEAPON_CHANGE)) {
ADDRGP4 pm
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $611
line 1541
;1541:		pm->ps->weaponTime += 250;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 1542
;1542:		PM_StartTorsoAnim( TORSO_RAISE );
CNSTI4 10
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1543
;1543:	}
LABELV $611
line 1544
;1544:}
LABELV $605
endproc PM_FinishWeaponChange 12 4
proc PM_TorsoAnimation 24 4
line 1581
;1545:
;1546:
;1547:/*
;1548:==============
;1549:PM_TorsoAnimation
;1550:
;1551:==============
;1552:*/
;1553:
;1554:
;1555:
;1556:
;1557:/*
;1558:
;1559:static void PM_TorsoAnimation( void ) {
;1560:	if ( pm->ps->weaponstate == WEAPON_READY ) {
;1561:		if ( pm->ps->weapon == WP_GAUNTLET ) {
;1562:			PM_ContinueTorsoAnim( TORSO_STAND2 );
;1563:		} else {
;1564:			PM_ContinueTorsoAnim( TORSO_STAND );
;1565:		}
;1566:	return;
;1567:	}
;1568:
;1569:}
;1570:
;1571:
;1572:
;1573:
;1574:
;1575:
;1576:
;1577:*/
;1578:
;1579:// leilei - heavily improved version for OA3 player animations
;1580:static void PM_TorsoAnimation( void )
;1581:{
line 1582
;1582:	if ( pm->ps->weaponstate == WEAPON_READY ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $614
line 1583
;1583:		if ( pm->ps->velocity[2] < 0 && !pml.groundPlane) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
GEF4 $616
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
NEI4 $616
line 1585
;1584:			// Falling Downward
;1585:			if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $619
line 1586
;1586:				PM_ContinueTorsoAnim( TORSO_FALL2 );
CNSTI4 39
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1587
;1587:			}
ADDRGP4 $613
JUMPV
LABELV $619
line 1588
;1588:			else if ( pm->ps->powerups[PW_REDFLAG] || pm->ps->powerups[PW_BLUEFLAG] || pm->ps->powerups[PW_NEUTRALFLAG]) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $624
ADDRLP4 0
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $624
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $621
LABELV $624
line 1589
;1589:				PM_ContinueTorsoAnim( TORSO_FALL2 );
CNSTI4 39
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1590
;1590:			}
ADDRGP4 $613
JUMPV
LABELV $621
line 1591
;1591:			else {
line 1592
;1592:				PM_ContinueTorsoAnim( TORSO_FALL );
CNSTI4 38
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1593
;1593:			}
line 1594
;1594:		}
ADDRGP4 $613
JUMPV
LABELV $616
line 1595
;1595:		else if ( pm->ps->velocity[2] > 0 && !pml.groundPlane) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
LEF4 $625
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
NEI4 $625
line 1597
;1596:			// Falling Upward
;1597:			if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $628
line 1598
;1598:				PM_ContinueTorsoAnim( TORSO_JUMP2 );
CNSTI4 36
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1599
;1599:			}
ADDRGP4 $613
JUMPV
LABELV $628
line 1600
;1600:			else if ( pm->ps->powerups[PW_REDFLAG] || pm->ps->powerups[PW_BLUEFLAG] || pm->ps->powerups[PW_NEUTRALFLAG]) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $633
ADDRLP4 0
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $633
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $630
LABELV $633
line 1601
;1601:				PM_ContinueTorsoAnim( TORSO_JUMP2 );
CNSTI4 36
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1602
;1602:			}
ADDRGP4 $613
JUMPV
LABELV $630
line 1603
;1603:			else {
line 1604
;1604:				PM_ContinueTorsoAnim( TORSO_JUMP );
CNSTI4 35
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1605
;1605:			}
line 1606
;1606:		}
ADDRGP4 $613
JUMPV
LABELV $625
line 1607
;1607:		else if ( pm->ps->velocity[2] < -7 && (pml.groundTrace.surfaceFlags & SURF_SLICK)) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 3235905536
GEF4 $634
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $634
line 1609
;1608:			// Sliding downward on a slick surface
;1609:			if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $638
line 1610
;1610:				PM_ContinueTorsoAnim( TORSO_FALL2 );
CNSTI4 39
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1611
;1611:			}
ADDRGP4 $613
JUMPV
LABELV $638
line 1612
;1612:			else if ( pm->ps->powerups[PW_REDFLAG] || pm->ps->powerups[PW_BLUEFLAG] || pm->ps->powerups[PW_NEUTRALFLAG]) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $643
ADDRLP4 0
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $643
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $640
LABELV $643
line 1613
;1613:				PM_ContinueTorsoAnim( TORSO_FALL2 );
CNSTI4 39
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1614
;1614:			}
ADDRGP4 $613
JUMPV
LABELV $640
line 1615
;1615:			else {
line 1616
;1616:				PM_ContinueTorsoAnim( TORSO_FALL );
CNSTI4 38
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1617
;1617:			}
line 1618
;1618:		}
ADDRGP4 $613
JUMPV
LABELV $634
line 1619
;1619:		else if (  	pm->cmd.forwardmove || (pm->cmd.rightmove && pml.groundPlane && pm->xyspeed > 200 && !( pm->cmd.buttons & BUTTON_WALKING ) ) ) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $647
ADDRLP4 0
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
EQI4 $644
ADDRGP4 pml+48
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $644
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
CNSTF4 1128792064
LEF4 $644
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 4
INDIRI4
NEI4 $644
LABELV $647
line 1621
;1620:			// Running Forward
;1621:			if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $648
line 1622
;1622:				PM_ContinueTorsoAnim( TORSO_RUN2 );
CNSTI4 32
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1623
;1623:			}
ADDRGP4 $613
JUMPV
LABELV $648
line 1624
;1624:			else if ( pm->ps->powerups[PW_REDFLAG] || pm->ps->powerups[PW_BLUEFLAG] || pm->ps->powerups[PW_NEUTRALFLAG])  {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $653
ADDRLP4 8
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $653
ADDRLP4 8
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $650
LABELV $653
line 1625
;1625:				PM_ContinueTorsoAnim( TORSO_RUN3 );
CNSTI4 33
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1626
;1626:			}
ADDRGP4 $613
JUMPV
LABELV $650
line 1627
;1627:			else if ( pm->cmd.rightmove && !pm->cmd.forwardmove && pml.groundPlane && !( pm->cmd.buttons & BUTTON_WALKING )) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
EQI4 $654
ADDRLP4 16
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
NEI4 $654
ADDRGP4 pml+48
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $654
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 20
INDIRI4
NEI4 $654
line 1628
;1628:				PM_ContinueTorsoAnim( TORSO_STRAFE );
CNSTI4 42
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1629
;1629:			}
ADDRGP4 $613
JUMPV
LABELV $654
line 1630
;1630:			else {
line 1631
;1631:				PM_ContinueTorsoAnim( TORSO_RUN );
CNSTI4 31
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1632
;1632:			}
line 1633
;1633:		}
ADDRGP4 $613
JUMPV
LABELV $644
line 1634
;1634:		else {
line 1635
;1635:			if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $657
line 1636
;1636:				PM_ContinueTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1637
;1637:			}
ADDRGP4 $613
JUMPV
LABELV $657
line 1638
;1638:			else if ( pm->ps->powerups[PW_REDFLAG] || pm->ps->powerups[PW_BLUEFLAG] || pm->ps->powerups[PW_NEUTRALFLAG])  {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $662
ADDRLP4 8
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $662
ADDRLP4 8
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $659
LABELV $662
line 1639
;1639:				PM_ContinueTorsoAnim( TORSO_STAND3 );
CNSTI4 34
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1640
;1640:			}
ADDRGP4 $613
JUMPV
LABELV $659
line 1641
;1641:			else {
line 1642
;1642:				PM_ContinueTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1643
;1643:			}
line 1644
;1644:		}
line 1645
;1645:		return;
LABELV $614
line 1647
;1646:	}
;1647:}
LABELV $613
endproc PM_TorsoAnimation 24 4
proc PM_Weapon 36 4
line 1661
;1648:
;1649:
;1650:/*
;1651:==============
;1652:PM_Weapon
;1653:
;1654:Generates weapon events and modifes the weapon counter
;1655:
;1656:Elimination TODO:
;1657:Make this thing stop during warmup (done)
;1658:==============
;1659:*/
;1660:static void PM_Weapon( void )
;1661:{
line 1665
;1662:	int		addTime;
;1663:
;1664:	// don't allow attack until all buttons are up
;1665:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $664
line 1666
;1666:		return;
ADDRGP4 $663
JUMPV
LABELV $664
line 1670
;1667:	}
;1668:
;1669:	// ignore if spectator
;1670:	if ( pm->ps->persistant[PERS_TEAM] == TEAM_SPECTATOR || pm->ps->pm_type == PM_SPECTATOR) {
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
EQI4 $668
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $666
LABELV $668
line 1671
;1671:		return;
ADDRGP4 $663
JUMPV
LABELV $666
line 1675
;1672:	}
;1673:
;1674:	// check for dead player
;1675:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $669
line 1676
;1676:		pm->ps->weapon = WP_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 1677
;1677:		return;
ADDRGP4 $663
JUMPV
LABELV $669
line 1681
;1678:	}
;1679:
;1680:	// check for item using
;1681:	if ( pm->cmd.buttons & BUTTON_USE_HOLDABLE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $671
line 1682
;1682:		if ( ! ( pm->ps->pm_flags & PMF_USE_ITEM_HELD ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $672
line 1683
;1683:			if ( bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag == HI_MEDKIT
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
CNSTI4 52
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $675
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 25
ADDI4
LTI4 $675
line 1684
;1684:			        && pm->ps->stats[STAT_HEALTH] >= (pm->ps->stats[STAT_MAX_HEALTH] + 25) ) {
line 1686
;1685:				// don't use medkit if at max health
;1686:			}
ADDRGP4 $663
JUMPV
LABELV $675
line 1687
;1687:			else {
line 1688
;1688:				pm->ps->pm_flags |= PMF_USE_ITEM_HELD;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1689
;1689:				PM_AddEvent( EV_USE_ITEM0 + bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag );
CNSTI4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 24
ADDI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1690
;1690:				pm->ps->stats[STAT_HOLDABLE_ITEM] = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 1691
;1691:			}
line 1692
;1692:			return;
ADDRGP4 $663
JUMPV
line 1694
;1693:		}
;1694:	}
LABELV $671
line 1695
;1695:	else {
line 1696
;1696:		pm->ps->pm_flags &= ~PMF_USE_ITEM_HELD;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 1697
;1697:	}
LABELV $672
line 1701
;1698:
;1699:
;1700:	// make weapon function
;1701:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $679
line 1702
;1702:		pm->ps->weaponTime -= pml.msec;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1703
;1703:	}
LABELV $679
line 1708
;1704:
;1705:	// check for weapon change
;1706:	// can't change if weapon is firing, but can change
;1707:	// again if lowering or raising
;1708:	if ( pm->ps->weaponTime <= 0 || pm->ps->weaponstate != WEAPON_FIRING ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $684
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
EQI4 $682
LABELV $684
line 1709
;1709:		if ( pm->ps->weapon != pm->cmd.weapon ) {
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
EQI4 $685
line 1710
;1710:			PM_BeginWeaponChange( pm->cmd.weapon );
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 PM_BeginWeaponChange
CALLV
pop
line 1711
;1711:		}
LABELV $685
line 1712
;1712:	}
LABELV $682
line 1714
;1713:
;1714:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $687
line 1715
;1715:		return;
ADDRGP4 $663
JUMPV
LABELV $687
line 1719
;1716:	}
;1717:
;1718:	// change weapon if time
;1719:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $689
line 1720
;1720:		PM_FinishWeaponChange();
ADDRGP4 PM_FinishWeaponChange
CALLV
pop
line 1721
;1721:		return;
ADDRGP4 $663
JUMPV
LABELV $689
line 1724
;1722:	}
;1723:
;1724:	if ( pm->ps->weaponstate == WEAPON_RAISING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $691
line 1725
;1725:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1726
;1726:		if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $693
line 1727
;1727:			PM_StartTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1728
;1728:		}
ADDRGP4 $663
JUMPV
LABELV $693
line 1729
;1729:		else {
line 1730
;1730:			PM_StartTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1731
;1731:		}
line 1732
;1732:		return;
ADDRGP4 $663
JUMPV
LABELV $691
line 1736
;1733:	}
;1734:
;1735:	// check for fire
;1736:	if ( ! (pm->cmd.buttons & BUTTON_ATTACK) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $695
line 1737
;1737:		pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1738
;1738:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1739
;1739:		return;
ADDRGP4 $663
JUMPV
LABELV $695
line 1743
;1740:	}
;1741:
;1742:	// start the animation even if out of ammo
;1743:	if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $697
line 1745
;1744:		// the guantlet only "fires" when it actually hits something
;1745:		if ( !pm->gauntletHit ) {
ADDRGP4 pm
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
NEI4 $699
line 1746
;1746:			pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1747
;1747:			pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1748
;1748:			return;
ADDRGP4 $663
JUMPV
LABELV $699
line 1750
;1749:		}
;1750:		PM_StartTorsoAnim( TORSO_ATTACK2 );
CNSTI4 8
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1751
;1751:	}
ADDRGP4 $698
JUMPV
LABELV $697
line 1752
;1752:	else {
line 1753
;1753:		PM_StartTorsoAnim( TORSO_ATTACK );
CNSTI4 7
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1754
;1754:	}
LABELV $698
line 1756
;1755:
;1756:	pm->ps->weaponstate = WEAPON_FIRING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 3
ASGNI4
line 1759
;1757:
;1758:	// check for out of ammo
;1759:	if ( ! pm->ps->ammo[ pm->ps->weapon ] ) {
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $701
line 1760
;1760:		PM_AddEvent( EV_NOAMMO );
CNSTI4 21
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1761
;1761:		pm->ps->weaponTime += 500;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1762
;1762:		return;
ADDRGP4 $663
JUMPV
LABELV $701
line 1766
;1763:	}
;1764:
;1765:	// take an ammo away if not infinite, 999 or up
;1766:	if ( !(pm->ps->ammo[ pm->ps->weapon ] == -1 || pm->ps->ammo[ pm->ps->weapon ] >=999 )) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 -1
EQI4 $703
ADDRLP4 20
INDIRI4
CNSTI4 999
GEI4 $703
line 1767
;1767:		pm->ps->ammo[ pm->ps->weapon ]--;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1768
;1768:	}
LABELV $703
line 1771
;1769:
;1770:	// fire weapon
;1771:	PM_AddEvent( EV_FIRE_WEAPON );
CNSTI4 23
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1773
;1772:
;1773:	switch( pm->ps->weapon ) {
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 1
LTI4 $705
ADDRLP4 24
INDIRI4
CNSTI4 13
GTI4 $705
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $721-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $721
address $708
address $711
address $710
address $712
address $713
address $709
address $715
address $714
address $716
address $717
address $718
address $719
address $720
code
LABELV $705
LABELV $708
line 1776
;1774:	default:
;1775:	case WP_GAUNTLET:
;1776:		addTime = mod_gdelay;
ADDRLP4 0
ADDRGP4 mod_gdelay
INDIRI4
ASGNI4
line 1777
;1777:		break;
ADDRGP4 $706
JUMPV
LABELV $709
line 1779
;1778:	case WP_LIGHTNING:
;1779:		addTime = mod_lgdelay;
ADDRLP4 0
ADDRGP4 mod_lgdelay
INDIRI4
ASGNI4
line 1780
;1780:		break;
ADDRGP4 $706
JUMPV
LABELV $710
line 1782
;1781:	case WP_SHOTGUN:
;1782:		addTime = mod_sgdelay;
ADDRLP4 0
ADDRGP4 mod_sgdelay
INDIRI4
ASGNI4
line 1783
;1783:		break;
ADDRGP4 $706
JUMPV
LABELV $711
line 1785
;1784:	case WP_MACHINEGUN:
;1785:		addTime = mod_mgdelay;
ADDRLP4 0
ADDRGP4 mod_mgdelay
INDIRI4
ASGNI4
line 1786
;1786:		break;
ADDRGP4 $706
JUMPV
LABELV $712
line 1788
;1787:	case WP_GRENADE_LAUNCHER:
;1788:		addTime = mod_gldelay;
ADDRLP4 0
ADDRGP4 mod_gldelay
INDIRI4
ASGNI4
line 1789
;1789:		break;
ADDRGP4 $706
JUMPV
LABELV $713
line 1791
;1790:	case WP_ROCKET_LAUNCHER:
;1791:		addTime = mod_rldelay;
ADDRLP4 0
ADDRGP4 mod_rldelay
INDIRI4
ASGNI4
line 1792
;1792:		break;
ADDRGP4 $706
JUMPV
LABELV $714
line 1794
;1793:	case WP_PLASMAGUN:
;1794:		addTime = mod_pgdelay;
ADDRLP4 0
ADDRGP4 mod_pgdelay
INDIRI4
ASGNI4
line 1795
;1795:		break;
ADDRGP4 $706
JUMPV
LABELV $715
line 1797
;1796:	case WP_RAILGUN:
;1797:		addTime = mod_rgdelay;
ADDRLP4 0
ADDRGP4 mod_rgdelay
INDIRI4
ASGNI4
line 1798
;1798:		break;
ADDRGP4 $706
JUMPV
LABELV $716
line 1800
;1799:	case WP_BFG:
;1800:		addTime = mod_bfgdelay;
ADDRLP4 0
ADDRGP4 mod_bfgdelay
INDIRI4
ASGNI4
line 1801
;1801:		break;
ADDRGP4 $706
JUMPV
LABELV $717
line 1803
;1802:	case WP_GRAPPLING_HOOK:
;1803:		addTime = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1804
;1804:		break;
ADDRGP4 $706
JUMPV
LABELV $718
line 1806
;1805:	case WP_NAILGUN:
;1806:		addTime = mod_ngdelay;
ADDRLP4 0
ADDRGP4 mod_ngdelay
INDIRI4
ASGNI4
line 1807
;1807:		break;
ADDRGP4 $706
JUMPV
LABELV $719
line 1809
;1808:	case WP_PROX_LAUNCHER:
;1809:		addTime = mod_pldelay;
ADDRLP4 0
ADDRGP4 mod_pldelay
INDIRI4
ASGNI4
line 1810
;1810:		break;
ADDRGP4 $706
JUMPV
LABELV $720
line 1812
;1811:	case WP_CHAINGUN:
;1812:		addTime = mod_cgdelay;
ADDRLP4 0
ADDRGP4 mod_cgdelay
INDIRI4
ASGNI4
line 1813
;1813:		break;
LABELV $706
line 1816
;1814:	}
;1815:
;1816:	if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
CNSTI4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $723
line 1817
;1817:		addTime /= mod_scoutfirespeed;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRGP4 mod_scoutfirespeed
INDIRI4
DIVI4
ASGNI4
line 1818
;1818:	}
ADDRGP4 $724
JUMPV
LABELV $723
line 1819
;1819:	else if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
CNSTI4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 13
NEI4 $726
line 1820
;1820:		addTime /= mod_ammoregenfirespeed;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRGP4 mod_ammoregenfirespeed
INDIRI4
DIVI4
ASGNI4
line 1821
;1821:	}
ADDRGP4 $727
JUMPV
LABELV $726
line 1822
;1822:	else if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_DOUBLER ) {
CNSTI4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $729
line 1823
;1823:		addTime /= mod_doublerfirespeed;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRGP4 mod_doublerfirespeed
INDIRI4
DIVI4
ASGNI4
line 1824
;1824:	}
ADDRGP4 $730
JUMPV
LABELV $729
line 1825
;1825:	else if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
CNSTI4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 11
NEI4 $732
line 1826
;1826:		addTime /= mod_guardfirespeed;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRGP4 mod_guardfirespeed
INDIRI4
DIVI4
ASGNI4
line 1827
;1827:	}
ADDRGP4 $733
JUMPV
LABELV $732
line 1828
;1828:	else if ( pm->ps->powerups[PW_HASTE] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $735
line 1829
;1829:		addTime /= mod_hastefirespeed;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRGP4 mod_hastefirespeed
INDIRI4
DIVI4
ASGNI4
line 1830
;1830:	}
LABELV $735
LABELV $733
LABELV $730
LABELV $727
LABELV $724
line 1832
;1831:
;1832:	pm->ps->weaponTime += addTime;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 1833
;1833:}
LABELV $663
endproc PM_Weapon 36 4
proc PM_Animate 0 4
line 1842
;1834:
;1835:/*
;1836:================
;1837:PM_Animate
;1838:================
;1839:*/
;1840:
;1841:static void PM_Animate( void )
;1842:{
line 1843
;1843:	if ( pm->cmd.buttons & BUTTON_GESTURE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $738
line 1844
;1844:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $739
line 1845
;1845:			PM_StartTorsoAnim( TORSO_GESTURE );
CNSTI4 6
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1846
;1846:			pm->ps->torsoTimer = TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 2294
ASGNI4
line 1847
;1847:			PM_AddEvent( EV_TAUNT );
CNSTI4 76
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1848
;1848:		}
line 1849
;1849:	}
ADDRGP4 $739
JUMPV
LABELV $738
line 1850
;1850:	else if ( pm->cmd.buttons & BUTTON_GETFLAG ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $742
line 1851
;1851:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $743
line 1852
;1852:			PM_StartTorsoAnim( TORSO_GETFLAG );
CNSTI4 25
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1853
;1853:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1854
;1854:		}
line 1855
;1855:	}
ADDRGP4 $743
JUMPV
LABELV $742
line 1856
;1856:	else if ( pm->cmd.buttons & BUTTON_GUARDBASE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $746
line 1857
;1857:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $747
line 1858
;1858:			PM_StartTorsoAnim( TORSO_GUARDBASE );
CNSTI4 26
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1859
;1859:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1860
;1860:		}
line 1861
;1861:	}
ADDRGP4 $747
JUMPV
LABELV $746
line 1862
;1862:	else if ( pm->cmd.buttons & BUTTON_PATROL ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $750
line 1863
;1863:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $751
line 1864
;1864:			PM_StartTorsoAnim( TORSO_PATROL );
CNSTI4 27
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1865
;1865:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1866
;1866:		}
line 1867
;1867:	}
ADDRGP4 $751
JUMPV
LABELV $750
line 1868
;1868:	else if ( pm->cmd.buttons & BUTTON_FOLLOWME ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $754
line 1869
;1869:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $755
line 1870
;1870:			PM_StartTorsoAnim( TORSO_FOLLOWME );
CNSTI4 28
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1871
;1871:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1872
;1872:		}
line 1873
;1873:	}
ADDRGP4 $755
JUMPV
LABELV $754
line 1874
;1874:	else if ( pm->cmd.buttons & BUTTON_AFFIRMATIVE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $758
line 1875
;1875:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $759
line 1876
;1876:			PM_StartTorsoAnim( TORSO_AFFIRMATIVE);
CNSTI4 29
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1877
;1877:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1878
;1878:		}
line 1879
;1879:	}
ADDRGP4 $759
JUMPV
LABELV $758
line 1880
;1880:	else if ( pm->cmd.buttons & BUTTON_NEGATIVE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $762
line 1881
;1881:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $764
line 1882
;1882:			PM_StartTorsoAnim( TORSO_NEGATIVE );
CNSTI4 30
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1883
;1883:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1884
;1884:		}
LABELV $764
line 1885
;1885:	}
LABELV $762
LABELV $759
LABELV $755
LABELV $751
LABELV $747
LABELV $743
LABELV $739
line 1886
;1886:}
LABELV $737
endproc PM_Animate 0 4
proc PM_DropTimers 4 0
line 1895
;1887:
;1888:
;1889:/*
;1890:================
;1891:PM_DropTimers
;1892:================
;1893:*/
;1894:static void PM_DropTimers( void )
;1895:{
line 1897
;1896:	// drop misc timing counter
;1897:	if ( pm->ps->pm_time ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $767
line 1898
;1898:		if ( pml.msec >= pm->ps->pm_time ) {
ADDRGP4 pml+40
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $769
line 1899
;1899:			pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 1900
;1900:			pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1901
;1901:		}
ADDRGP4 $770
JUMPV
LABELV $769
line 1902
;1902:		else {
line 1903
;1903:			pm->ps->pm_time -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1904
;1904:		}
LABELV $770
line 1905
;1905:	}
LABELV $767
line 1908
;1906:
;1907:	// drop animation counter
;1908:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $773
line 1909
;1909:		pm->ps->legsTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1910
;1910:		if ( pm->ps->legsTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
GEI4 $776
line 1911
;1911:			pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 1912
;1912:		}
LABELV $776
line 1913
;1913:	}
LABELV $773
line 1915
;1914:
;1915:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $778
line 1916
;1916:		pm->ps->torsoTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1917
;1917:		if ( pm->ps->torsoTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
GEI4 $781
line 1918
;1918:			pm->ps->torsoTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 0
ASGNI4
line 1919
;1919:		}
LABELV $781
line 1920
;1920:	}
LABELV $778
line 1921
;1921:}
LABELV $766
endproc PM_DropTimers 4 0
export PM_UpdateViewAngles
proc PM_UpdateViewAngles 24 0
line 1932
;1922:
;1923:/*
;1924:================
;1925:PM_UpdateViewAngles
;1926:
;1927:This can be used as another entry point when only the viewangles
;1928:are being updated instead of a full move
;1929:================
;1930:*/
;1931:void PM_UpdateViewAngles( playerState_t *ps, const usercmd_t *cmd )
;1932:{
line 1936
;1933:	short		temp;
;1934:	int		i;
;1935:
;1936:	if ( ps->pm_type == PM_INTERMISSION || ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
EQI4 $786
ADDRLP4 8
INDIRI4
CNSTI4 6
NEI4 $784
LABELV $786
line 1937
;1937:		return;		// no view changes at all
ADDRGP4 $783
JUMPV
LABELV $784
line 1940
;1938:	}
;1939:
;1940:	if ( ps->pm_type != PM_SPECTATOR && ps->stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $787
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $787
line 1941
;1941:		return;		// no view changes at all
ADDRGP4 $783
JUMPV
LABELV $787
line 1945
;1942:	}
;1943:
;1944:	// circularly clamp the angles with deltas
;1945:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $789
line 1946
;1946:		temp = cmd->angles[i] + ps->delta_angles[i];
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
INDIRI4
ADDI4
CVII2 4
ASGNI2
line 1947
;1947:		if ( i == PITCH ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $793
line 1949
;1948:			// don't let the player look up or down more than 90 degrees
;1949:			if ( temp > 16000 ) {
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 16000
LEI4 $795
line 1950
;1950:				ps->delta_angles[i] = 16000 - cmd->angles[i];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 16000
ADDRLP4 20
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1951
;1951:				temp = 16000;
ADDRLP4 4
CNSTI2 16000
ASGNI2
line 1952
;1952:			}
ADDRGP4 $796
JUMPV
LABELV $795
line 1953
;1953:			else if ( temp < -16000 ) {
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 -16000
GEI4 $797
line 1954
;1954:				ps->delta_angles[i] = -16000 - cmd->angles[i];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 -16000
ADDRLP4 20
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1955
;1955:				temp = -16000;
ADDRLP4 4
CNSTI2 -16000
ASGNI2
line 1956
;1956:			}
LABELV $797
LABELV $796
line 1957
;1957:		}
LABELV $793
line 1958
;1958:		ps->viewangles[i] = SHORT2ANGLE(temp);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ADDP4
CNSTF4 1001652224
ADDRLP4 4
INDIRI2
CVII4 2
CVIF4 4
MULF4
ASGNF4
line 1959
;1959:	}
LABELV $790
line 1945
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $789
line 1961
;1960:
;1961:}
LABELV $783
endproc PM_UpdateViewAngles 24 0
export PmoveSingle
proc PmoveSingle 64 16
line 1973
;1962:
;1963:
;1964:/*
;1965:================
;1966:PmoveSingle
;1967:
;1968:================
;1969:*/
;1970:void trap_SnapVector( float *v );
;1971:
;1972:void PmoveSingle (pmove_t *pmove)
;1973:{
line 1974
;1974:	pm = pmove;
ADDRGP4 pm
ADDRFP4 0
INDIRP4
ASGNP4
line 1978
;1975:
;1976:	// this counter lets us debug movement problems with a journal
;1977:	// by setting a conditional breakpoint fot the previous frame
;1978:	c_pmove++;
ADDRLP4 0
ADDRGP4 c_pmove
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1981
;1979:
;1980:	// clear results
;1981:	pm->numtouch = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1982
;1982:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1983
;1983:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 0
ASGNI4
line 1985
;1984:
;1985:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $800
line 1986
;1986:		pm->tracemask &= ~CONTENTS_BODY;	// corpses can fly through bodies
ADDRLP4 4
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 1987
;1987:	}
LABELV $800
line 1991
;1988:
;1989:	// make sure walking button is clear if they are running, to avoid
;1990:	// proxy no-footsteps cheats
;1991:	if ( abs( pm->cmd.forwardmove ) > 64 || abs( pm->cmd.rightmove ) > 64 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
GTI4 $804
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LEI4 $802
LABELV $804
line 1992
;1992:		pm->cmd.buttons &= ~BUTTON_WALKING;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 1993
;1993:	}
LABELV $802
line 1996
;1994:
;1995:	// set the talk balloon flag
;1996:	if ( pm->cmd.buttons & BUTTON_TALK ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $805
line 1997
;1997:		pm->ps->eFlags |= EF_TALK;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1998
;1998:	}
ADDRGP4 $806
JUMPV
LABELV $805
line 1999
;1999:	else {
line 2000
;2000:		pm->ps->eFlags &= ~EF_TALK;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 2001
;2001:	}
LABELV $806
line 2004
;2002:
;2003:	// set the firing flag for continuous beam weapons
;2004:	if ( !(pm->ps->pm_flags & PMF_RESPAWNED) && pm->ps->pm_type != PM_INTERMISSION && pm->ps->pm_type != PM_NOCLIP
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
ADDRLP4 20
INDIRI4
NEI4 $807
ADDRLP4 24
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 5
EQI4 $807
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $807
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
BANDI4
ADDRLP4 20
INDIRI4
EQI4 $807
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $807
line 2005
;2005:	        && ( pm->cmd.buttons & BUTTON_ATTACK ) && pm->ps->ammo[ pm->ps->weapon ] ) {
line 2006
;2006:		pm->ps->eFlags |= EF_FIRING;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2007
;2007:	}
ADDRGP4 $808
JUMPV
LABELV $807
line 2008
;2008:	else {
line 2009
;2009:		pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 2010
;2010:	}
LABELV $808
line 2013
;2011:
;2012:	// clear the respawned flag if attack and use are cleared
;2013:	if ( pm->ps->stats[STAT_HEALTH] > 0 &&
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
LEI4 $809
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
BANDI4
ADDRLP4 36
INDIRI4
NEI4 $809
line 2014
;2014:	        !( pm->cmd.buttons & (BUTTON_ATTACK | BUTTON_USE_HOLDABLE) ) ) {
line 2015
;2015:		pm->ps->pm_flags &= ~PMF_RESPAWNED;
ADDRLP4 40
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 2016
;2016:	}
LABELV $809
line 2021
;2017:
;2018:	// if talk button is down, dissallow all other input
;2019:	// this is to prevent any possible intercept proxy from
;2020:	// adding fake talk balloons
;2021:	if ( pmove->cmd.buttons & BUTTON_TALK ) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $811
line 2024
;2022:		// keep the talk button set tho for when the cmd.serverTime > 66 msec
;2023:		// and the same cmd is used multiple times in Pmove
;2024:		pmove->cmd.buttons = BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 2
ASGNI4
line 2025
;2025:		pmove->cmd.forwardmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 2026
;2026:		pmove->cmd.rightmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 2027
;2027:		pmove->cmd.upmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 2028
;2028:	}
LABELV $811
line 2031
;2029:
;2030:	// clear all pmove local vars
;2031:	memset (&pml, 0, sizeof(pml));
ADDRGP4 pml
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2034
;2032:
;2033:	// determine the time
;2034:	pml.msec = pmove->cmd.serverTime - pm->ps->commandTime;
ADDRGP4 pml+40
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2035
;2035:	if ( pml.msec < 1 ) {
ADDRGP4 pml+40
INDIRI4
CNSTI4 1
GEI4 $814
line 2036
;2036:		pml.msec = 1;
ADDRGP4 pml+40
CNSTI4 1
ASGNI4
line 2037
;2037:	}
ADDRGP4 $815
JUMPV
LABELV $814
line 2038
;2038:	else if ( pml.msec > 200 ) {
ADDRGP4 pml+40
INDIRI4
CNSTI4 200
LEI4 $818
line 2039
;2039:		pml.msec = 200;
ADDRGP4 pml+40
CNSTI4 200
ASGNI4
line 2040
;2040:	}
LABELV $818
LABELV $815
line 2041
;2041:	pm->ps->commandTime = pmove->cmd.serverTime;
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2044
;2042:
;2043:	// save old org in case we get stuck
;2044:	VectorCopy (pm->ps->origin, pml.previous_origin);
ADDRGP4 pml+112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2047
;2045:
;2046:	// save old velocity for crashlanding
;2047:	VectorCopy (pm->ps->velocity, pml.previous_velocity);
ADDRGP4 pml+124
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 2049
;2048:
;2049:	pml.frametime = pml.msec * 0.001;
ADDRGP4 pml+36
CNSTF4 981668463
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 2052
;2050:
;2051:	// update the viewangles
;2052:	PM_UpdateViewAngles( pm->ps, &pm->cmd );
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 2054
;2053:
;2054:	AngleVectors (pm->ps->viewangles, pml.forward, pml.right, pml.up);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 pml
ARGP4
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+24
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2056
;2055:
;2056:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $828
line 2058
;2057:		// not holding jump
;2058:		pm->ps->pm_flags &= ~PMF_JUMP_HELD;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2059
;2059:	}
LABELV $828
line 2062
;2060:
;2061:	// decide if backpedaling animations should be used
;2062:	if ( pm->cmd.forwardmove < 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $830
line 2063
;2063:		pm->ps->pm_flags |= PMF_BACKWARDS_RUN;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2064
;2064:	}
ADDRGP4 $831
JUMPV
LABELV $830
line 2065
;2065:	else if ( pm->cmd.forwardmove > 0 || ( pm->cmd.forwardmove == 0 && pm->cmd.rightmove ) ) {
ADDRLP4 44
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
GTI4 $834
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $832
ADDRLP4 44
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
EQI4 $832
LABELV $834
line 2066
;2066:		pm->ps->pm_flags &= ~PMF_BACKWARDS_RUN;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2067
;2067:	}
LABELV $832
LABELV $831
line 2069
;2068:
;2069:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $835
line 2070
;2070:		pm->cmd.forwardmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 2071
;2071:		pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 2072
;2072:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 2073
;2073:	}
LABELV $835
line 2075
;2074:
;2075:	if ( pm->ps->pm_type == PM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $837
line 2076
;2076:		PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 2077
;2077:		PM_FlyMove ();
ADDRGP4 PM_FlyMove
CALLV
pop
line 2078
;2078:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2079
;2079:		return;
ADDRGP4 $799
JUMPV
LABELV $837
line 2082
;2080:	}
;2081:
;2082:	if ( pm->ps->pm_type == PM_NOCLIP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $839
line 2083
;2083:		PM_NoclipMove ();
ADDRGP4 PM_NoclipMove
CALLV
pop
line 2084
;2084:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2085
;2085:		return;
ADDRGP4 $799
JUMPV
LABELV $839
line 2088
;2086:	}
;2087:
;2088:	if (pm->ps->pm_type == PM_FREEZE) {
ADDRLP4 56
CNSTI4 4
ASGNI4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $841
line 2089
;2089:		return;		// no movement at all
ADDRGP4 $799
JUMPV
LABELV $841
line 2092
;2090:	}
;2091:
;2092:	if ( pm->ps->pm_type == PM_INTERMISSION || pm->ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 5
EQI4 $845
ADDRLP4 60
INDIRI4
CNSTI4 6
NEI4 $843
LABELV $845
line 2093
;2093:		return;		// no movement at all
ADDRGP4 $799
JUMPV
LABELV $843
line 2097
;2094:	}
;2095:
;2096:	// set watertype, and waterlevel
;2097:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2098
;2098:	pml.previous_waterlevel = pmove->waterlevel;
ADDRGP4 pml+136
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 2101
;2099:
;2100:	// set mins, maxs, and viewheight
;2101:	PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 2104
;2102:
;2103:	// set groundentity
;2104:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2106
;2105:
;2106:	if ( pm->ps->pm_type == PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $847
line 2107
;2107:		PM_DeadMove ();
ADDRGP4 PM_DeadMove
CALLV
pop
line 2108
;2108:	}
LABELV $847
line 2110
;2109:
;2110:	PM_DropTimers();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2112
;2111:
;2112:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $849
line 2113
;2113:		PM_InvulnerabilityMove();
ADDRGP4 PM_InvulnerabilityMove
CALLV
pop
line 2114
;2114:	}
ADDRGP4 $850
JUMPV
LABELV $849
line 2115
;2115:	else if ( pm->ps->powerups[PW_FLIGHT] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $851
line 2117
;2116:		// flight powerup doesn't allow jump and has different friction
;2117:		PM_FlyMove();
ADDRGP4 PM_FlyMove
CALLV
pop
line 2118
;2118:	}
ADDRGP4 $852
JUMPV
LABELV $851
line 2119
;2119:	else if (pm->ps->pm_flags & PMF_GRAPPLE_PULL) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $853
line 2120
;2120:		PM_GrappleMove();
ADDRGP4 PM_GrappleMove
CALLV
pop
line 2122
;2121:		// We can wiggle a bit
;2122:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 2123
;2123:	}
ADDRGP4 $854
JUMPV
LABELV $853
line 2124
;2124:	else if (pm->ps->pm_flags & PMF_TIME_WATERJUMP) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $855
line 2125
;2125:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 2126
;2126:	}
ADDRGP4 $856
JUMPV
LABELV $855
line 2127
;2127:	else if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LEI4 $857
line 2129
;2128:		// swimming
;2129:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 2130
;2130:	}
ADDRGP4 $858
JUMPV
LABELV $857
line 2131
;2131:	else if ( pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $859
line 2133
;2132:		// walking on ground
;2133:		PM_WalkMove();
ADDRGP4 PM_WalkMove
CALLV
pop
line 2134
;2134:	}
ADDRGP4 $860
JUMPV
LABELV $859
line 2135
;2135:	else {
line 2137
;2136:		// airborne
;2137:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 2138
;2138:	}
LABELV $860
LABELV $858
LABELV $856
LABELV $854
LABELV $852
LABELV $850
line 2140
;2139:
;2140:	PM_Animate();
ADDRGP4 PM_Animate
CALLV
pop
line 2143
;2141:
;2142:	// set groundentity, watertype, and waterlevel
;2143:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2144
;2144:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2147
;2145:
;2146:	// weapons
;2147:	if(!(pm->ps->pm_flags & PMF_ELIMWARMUP))
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
NEI4 $862
line 2148
;2148:		PM_Weapon();
ADDRGP4 PM_Weapon
CALLV
pop
LABELV $862
line 2153
;2149:
;2150:
;2151:
;2152:	// footstep events / legs animations
;2153:	PM_Footsteps();
ADDRGP4 PM_Footsteps
CALLV
pop
line 2157
;2154:
;2155:
;2156:	// torso animation
;2157:	PM_TorsoAnimation();
ADDRGP4 PM_TorsoAnimation
CALLV
pop
line 2164
;2158:
;2159:	// torso animation
;2160:	//PM_TorsoAnimation2();
;2161:
;2162:
;2163:	// entering / leaving water splashes
;2164:	PM_WaterEvents();
ADDRGP4 PM_WaterEvents
CALLV
pop
line 2168
;2165:
;2166:	// snap some parts of playerstate to save network bandwidth
;2167:	//But only if pmove_float is not enabled
;2168:	if(!(pm->pmove_float))
ADDRGP4 pm
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CNSTI4 0
NEI4 $864
line 2169
;2169:		trap_SnapVector( pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 trap_SnapVector
CALLV
pop
LABELV $864
line 2170
;2170:}
LABELV $799
endproc PmoveSingle 64 16
export Pmove
proc Pmove 16 4
line 2181
;2171:
;2172:
;2173:/*
;2174:================
;2175:Pmove
;2176:
;2177:Can be called by either the server or the client
;2178:================
;2179:*/
;2180:void Pmove (pmove_t *pmove)
;2181:{
line 2184
;2182:	int			finalTime;
;2183:
;2184:	finalTime = pmove->cmd.serverTime;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2186
;2185:
;2186:	if ( finalTime < pmove->ps->commandTime ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
GEI4 $867
line 2187
;2187:		return;	// should not happen
ADDRGP4 $866
JUMPV
LABELV $867
line 2190
;2188:	}
;2189:
;2190:	if ( finalTime > pmove->ps->commandTime + 1000 ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $869
line 2191
;2191:		pmove->ps->commandTime = finalTime - 1000;
ADDRFP4 0
INDIRP4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 2192
;2192:	}
LABELV $869
line 2194
;2193:
;2194:	pmove->ps->pmove_framecount = (pmove->ps->pmove_framecount+1) & ((1<<PS_PMOVEFRAMECOUNTBITS)-1);
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 456
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 63
BANDI4
ASGNI4
ADDRGP4 $872
JUMPV
LABELV $871
line 2198
;2195:
;2196:	// chop the move up if it is too long, to prevent framerate
;2197:	// dependent behavior
;2198:	while ( pmove->ps->commandTime != finalTime ) {
line 2201
;2199:		int		msec;
;2200:
;2201:		msec = finalTime - pmove->ps->commandTime;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2203
;2202:
;2203:		if ( pmove->pmove_fixed ) {
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 0
EQI4 $874
line 2204
;2204:			if ( msec > pmove->pmove_msec ) {
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
LEI4 $875
line 2205
;2205:				msec = pmove->pmove_msec;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ASGNI4
line 2206
;2206:			}
line 2207
;2207:		}
ADDRGP4 $875
JUMPV
LABELV $874
line 2208
;2208:		else {
line 2209
;2209:			if ( msec > 66 ) {
ADDRLP4 8
INDIRI4
CNSTI4 66
LEI4 $878
line 2210
;2210:				msec = 66;
ADDRLP4 8
CNSTI4 66
ASGNI4
line 2211
;2211:			}
LABELV $878
line 2212
;2212:		}
LABELV $875
line 2213
;2213:		pmove->cmd.serverTime = pmove->ps->commandTime + msec;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 2214
;2214:		PmoveSingle( pmove );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 PmoveSingle
CALLV
pop
line 2216
;2215:
;2216:		if ( pmove->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $880
line 2217
;2217:			pmove->cmd.upmove = 20;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 20
ASGNI1
line 2218
;2218:		}
LABELV $880
line 2219
;2219:	}
LABELV $872
line 2198
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $871
line 2220
;2220:}
LABELV $866
endproc Pmove 16 4
import cg_enableQ
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
import PM_StepSlideMove
import PM_SlideMove
bss
export pml
align 4
LABELV pml
skip 140
export pm
align 4
LABELV pm
skip 4
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
LABELV $506
byte 1 37
byte 1 105
byte 1 58
byte 1 76
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $495
byte 1 37
byte 1 105
byte 1 58
byte 1 115
byte 1 116
byte 1 101
byte 1 101
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $484
byte 1 37
byte 1 105
byte 1 58
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 111
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $453
byte 1 37
byte 1 105
byte 1 58
byte 1 108
byte 1 105
byte 1 102
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $426
byte 1 37
byte 1 105
byte 1 58
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 10
byte 1 0
