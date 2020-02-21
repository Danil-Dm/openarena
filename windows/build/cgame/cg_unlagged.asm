export CG_PredictWeaponEffects
code
proc CG_PredictWeaponEffects 184 48
file "../../../code/cgame/cg_unlagged.c"
line 45
;1:/*
;2:===========================================================================
;3:Copyright (C) 2006 Neil Toronto.
;4:
;5:This file is part of the Unlagged source code.
;6:
;7:Unlagged source code is free software; you can redistribute it and/or
;8:modify it under the terms of the GNU General Public License as published by
;9:the Free Software Foundation; either version 2 of the License, or (at your
;10:option) any later version.
;11:
;12:Unlagged source code is distributed in the hope that it will be useful, but
;13:WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;14:or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;15:for more details.
;16:
;17:You should have received a copy of the GNU General Public License
;18:along with Unlagged source code; if not, write to the Free Software
;19:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;20:===========================================================================
;21:*/
;22:
;23://#include "cg_local.h"
;24:
;25:#include "cg_local.h"
;26:
;27:// we'll need these prototypes
;28:void CG_ShotgunPattern( vec3_t origin, vec3_t origin2, int seed, int otherEntNum );
;29:void CG_Bullet( vec3_t end, int sourceEntityNum, vec3_t normal, qboolean flesh, int fleshEntityNum );
;30:
;31:// and this as well
;32://Must be in sync with g_weapon.c
;33:#define MACHINEGUN_SPREAD	200
;34:#define CHAINGUN_SPREAD		600
;35:
;36:/*
;37:=======================
;38:CG_PredictWeaponEffects
;39:
;40:Draws predicted effects for the railgun, shotgun, and machinegun.  The
;41:lightning gun is done in CG_LightningBolt, since it was just a matter
;42:of setting the right origin and angles.
;43:=======================
;44:*/
;45:void CG_PredictWeaponEffects( centity_t *cent ) {
line 47
;46:	vec3_t		muzzlePoint, forward, right, up;
;47:	entityState_t *ent = &cent->currentState;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
line 50
;48:
;49:	// if the client isn't us, forget it
;50:	if ( cent->currentState.number != cg.predictedPlayerState.clientNum ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $75
line 51
;51:		return;
ADDRGP4 $74
JUMPV
LABELV $75
line 55
;52:	}
;53:
;54:	// if it's not switched on server-side, forget it
;55:	if ( !cgs.delagHitscan ) {
ADDRGP4 cgs+181708
INDIRI4
CNSTI4 0
NEI4 $79
line 56
;56:		return;
ADDRGP4 $74
JUMPV
LABELV $79
line 60
;57:	}
;58:
;59:	// get the muzzle point
;60:	VectorCopy( cg.predictedPlayerState.origin, muzzlePoint );
ADDRLP4 0
ADDRGP4 cg+107636+20
INDIRB
ASGNB 12
line 61
;61:	muzzlePoint[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 64
;62:
;63:	// get forward, right, and up
;64:	AngleVectors( cg.predictedPlayerState.viewangles, forward, right, up );
ADDRGP4 cg+107636+152
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 65
;65:	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
ADDRLP4 52
CNSTF4 1096810496
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1096810496
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 68
;66:
;67:	// was it a rail attack?
;68:	if ( ent->weapon == WP_RAILGUN ) {
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 7
NEI4 $95
line 70
;69:		// do we have it on for the rail gun?
;70:		if ( cg_delag.integer & 1 || cg_delag.integer & 16 ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 56
INDIRI4
NEI4 $101
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 56
INDIRI4
EQI4 $96
LABELV $101
line 75
;71:			trace_t trace;
;72:			vec3_t endPoint;
;73:
;74:			// trace forward
;75:			VectorMA( muzzlePoint, 8192, forward, endPoint );
ADDRLP4 128
CNSTF4 1174405120
ASGNF4
ADDRLP4 116
ADDRLP4 0
INDIRF4
ADDRLP4 128
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 116+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 128
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 116+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1174405120
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 133
;76:
;77:			// THIS IS FOR DEBUGGING!
;78:			// you definitely *will* want something like this to test the backward reconciliation
;79:			// to make sure it's working *exactly* right
;80:			/*if ( cg_debugDelag.integer ) {
;81:				* Sago: There are some problems with some unlagged code. People will just have to trust it
;82:				// trace forward
;83:				CG_Trace( &trace, muzzlePoint, vec3_origin, vec3_origin, endPoint, cent->currentState.number, CONTENTS_BODY|CONTENTS_SOLID );
;84:
;85:				// did we hit another player?
;86:				if ( trace.fraction < 1.0f && (trace.contents & CONTENTS_BODY) ) {
;87:					// if we have two snapshots (we're interpolating)
;88:					if ( cg.nextSnap ) {
;89:						centity_t *c = &cg_entities[trace.entityNum];
;90:						vec3_t origin1, origin2;
;91:
;92:						// figure the two origins used for interpolation
;93:						BG_EvaluateTrajectory( &c->currentState.pos, cg.snap->serverTime, origin1 );
;94:						BG_EvaluateTrajectory( &c->nextState.pos, cg.nextSnap->serverTime, origin2 );
;95:
;96:						// print some debugging stuff exactly like what the server does
;97:
;98:						// it starts with "Int:" to let you know the target was interpolated
;99:						CG_Printf("^3Int: time: %d, j: %d, k: %d, origin: %0.2f %0.2f %0.2f\n",
;100:								cg.oldTime, cg.snap->serverTime, cg.nextSnap->serverTime,
;101:								c->lerpOrigin[0], c->lerpOrigin[1], c->lerpOrigin[2]);
;102:						CG_Printf("^5frac: %0.4f, origin1: %0.2f %0.2f %0.2f, origin2: %0.2f %0.2f %0.2f\n",
;103:							cg.frameInterpolation, origin1[0], origin1[1], origin1[2], origin2[0], origin2[1], origin2[2]);
;104:					}
;105:					else {
;106:						// we haven't got a next snapshot
;107:						// the client clock has either drifted ahead (seems to happen once per server frame
;108:						// when you play locally) or the client is using timenudge
;109:						// in any case, CG_CalcEntityLerpPositions extrapolated rather than interpolated
;110:						centity_t *c = &cg_entities[trace.entityNum];
;111:						vec3_t origin1, origin2;
;112:
;113:						c->currentState.pos.trTime = TR_LINEAR_STOP;
;114:						c->currentState.pos.trTime = cg.snap->serverTime;
;115:						c->currentState.pos.trDuration = 1000 / sv_fps.integer;
;116:
;117:						BG_EvaluateTrajectory( &c->currentState.pos, cg.snap->serverTime, origin1 );
;118:						BG_EvaluateTrajectory( &c->currentState.pos, cg.snap->serverTime + 1000 / sv_fps.integer, origin2 );
;119:
;120:						// print some debugging stuff exactly like what the server does
;121:
;122:						// it starts with "Ext:" to let you know the target was extrapolated
;123:						CG_Printf("^3Ext: time: %d, j: %d, k: %d, origin: %0.2f %0.2f %0.2f\n",
;124:								cg.oldTime, cg.snap->serverTime, cg.snap->serverTime,
;125:								c->lerpOrigin[0], c->lerpOrigin[1], c->lerpOrigin[2]);
;126:						CG_Printf("^5frac: %0.4f, origin1: %0.2f %0.2f %0.2f, origin2: %0.2f %0.2f %0.2f\n",
;127:							cg.frameInterpolation, origin1[0], origin1[1], origin1[2], origin2[0], origin2[1], origin2[2]);
;128:					}
;129:				}
;130:			}*/
;131:
;132:			// find the rail's end point
;133:			CG_Trace( &trace, muzzlePoint, vec3_origin, vec3_origin, endPoint, cg.predictedPlayerState.clientNum, CONTENTS_SOLID );
ADDRLP4 60
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 116
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 136
;134:
;135:			// do the magic-number adjustment
;136:			VectorMA( muzzlePoint, 4, right, muzzlePoint );
ADDRLP4 136
CNSTF4 1082130432
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 136
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 136
INDIRF4
ADDRLP4 28+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1082130432
ADDRLP4 28+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 137
;137:			VectorMA( muzzlePoint, -1, up, muzzlePoint );
ADDRLP4 140
CNSTF4 3212836864
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 40+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 3212836864
ADDRLP4 40+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 139
;138:
;139:			if(!cg.renderingThirdPerson) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $122
line 140
;140:				if(cg_drawGun.integer == 2) {
ADDRGP4 cg_drawGun+12
INDIRI4
CNSTI4 2
NEI4 $125
line 141
;141:					VectorMA(muzzlePoint, 8, cg.refdef.viewaxis[1], muzzlePoint);
ADDRLP4 144
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 144
INDIRF4
ADDRGP4 cg+109252+36+12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 144
INDIRF4
ADDRGP4 cg+109252+36+12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+109252+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 142
;142:				}
ADDRGP4 $126
JUMPV
LABELV $125
line 143
;143:				else if(cg_drawGun.integer == 3) {
ADDRGP4 cg_drawGun+12
INDIRI4
CNSTI4 3
NEI4 $143
line 144
;144:					VectorMA(muzzlePoint, 4, cg.refdef.viewaxis[1], muzzlePoint);
ADDRLP4 144
CNSTF4 1082130432
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 144
INDIRF4
ADDRGP4 cg+109252+36+12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 144
INDIRF4
ADDRGP4 cg+109252+36+12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1082130432
ADDRGP4 cg+109252+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 145
;145:				}
LABELV $143
LABELV $126
line 146
;146:			}
LABELV $122
line 149
;147:
;148:			// draw a rail trail
;149:			CG_RailTrail( &cgs.clientinfo[cent->currentState.number], muzzlePoint, trace.endpos );
CNSTI4 2120
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 60+12
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 153
;150:			//Com_Printf( "Predicted rail trail\n" );
;151:
;152:			// explosion at end if not SURF_NOIMPACT
;153:			if ( !(trace.surfaceFlags & SURF_NOIMPACT) ) {
ADDRLP4 60+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $96
line 155
;154:				// predict an explosion
;155:				CG_MissileHitWall( ent->weapon, cg.predictedPlayerState.clientNum, trace.endpos, trace.plane.normal, IMPACTSOUND_DEFAULT );
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
ADDRLP4 60+12
ARGP4
ADDRLP4 60+24
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 156
;156:			}
line 157
;157:		}
line 158
;158:	}
ADDRGP4 $96
JUMPV
LABELV $95
line 160
;159:	// was it a shotgun attack?
;160:	else if ( ent->weapon == WP_SHOTGUN ) {
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 3
NEI4 $170
line 162
;161:		// do we have it on for the shotgun?
;162:		if ( cg_delag.integer & 1 || cg_delag.integer & 4 ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 56
INDIRI4
NEI4 $176
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 56
INDIRI4
EQI4 $171
LABELV $176
line 168
;163:			int contents;
;164:			vec3_t endPoint, v;
;165:
;166:			// do everything like the server does
;167:
;168:			SnapVector( muzzlePoint );
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
line 170
;169:
;170:			VectorScale( forward, 4096, endPoint );
ADDRLP4 88
CNSTF4 1166016512
ASGNF4
ADDRLP4 72
ADDRLP4 88
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 72+4
ADDRLP4 88
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 72+8
CNSTF4 1166016512
ADDRLP4 12+8
INDIRF4
MULF4
ASGNF4
line 171
;171:			SnapVector( endPoint );
ADDRLP4 72
ADDRLP4 72
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 72+4
ADDRLP4 72+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 72+8
ADDRLP4 72+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 173
;172:
;173:			VectorSubtract( endPoint, muzzlePoint, v );
ADDRLP4 60
ADDRLP4 72
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 60+4
ADDRLP4 72+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 60+8
ADDRLP4 72+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 174
;174:			VectorNormalize( v );
ADDRLP4 60
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 175
;175:			VectorScale( v, 32, v );
ADDRLP4 92
CNSTF4 1107296256
ASGNF4
ADDRLP4 60
ADDRLP4 92
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ASGNF4
ADDRLP4 60+4
ADDRLP4 92
INDIRF4
ADDRLP4 60+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 60+8
CNSTF4 1107296256
ADDRLP4 60+8
INDIRF4
MULF4
ASGNF4
line 176
;176:			VectorAdd( muzzlePoint, v, v );
ADDRLP4 60
ADDRLP4 0
INDIRF4
ADDRLP4 60
INDIRF4
ADDF4
ASGNF4
ADDRLP4 60+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 60+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 60+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 60+8
INDIRF4
ADDF4
ASGNF4
line 178
;177:
;178:			if ( cgs.glconfig.hardwareType != GLHW_RAGEPRO ) {
ADDRGP4 cgs+20100+11288
INDIRI4
CNSTI4 3
EQI4 $205
line 182
;179:				// ragepro can't alpha fade, so don't even bother with smoke
;180:				vec3_t			up;
;181:
;182:				contents = trap_CM_PointContents( muzzlePoint, 0 );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 108
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 84
ADDRLP4 108
INDIRI4
ASGNI4
line 183
;183:				if ( !( contents & CONTENTS_WATER ) ) {
ADDRLP4 84
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $209
line 184
;184:					VectorSet( up, 0, 0, 8 );
ADDRLP4 112
CNSTF4 0
ASGNF4
ADDRLP4 96
ADDRLP4 112
INDIRF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 112
INDIRF4
ASGNF4
ADDRLP4 96+8
CNSTF4 1090519040
ASGNF4
line 185
;185:					CG_SmokePuff( v, up, 32, 1, 1, 1, 0.33f, 900, cg.time, 0, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader );
ADDRLP4 60
ARGP4
ADDRLP4 96
ARGP4
CNSTF4 1107296256
ARGF4
ADDRLP4 116
CNSTF4 1065353216
ASGNF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 116
INDIRF4
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1147207680
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+180268+348
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 186
;186:				}
LABELV $209
line 187
;187:			}
LABELV $205
line 190
;188:
;189:			// do the shotgun pellets
;190:			CG_ShotgunPattern( muzzlePoint, endPoint, cg.oldTime % 256, cg.predictedPlayerState.clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 72
ARGP4
ADDRGP4 cg+107608
INDIRI4
CNSTI4 256
MODI4
ARGI4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
ADDRGP4 CG_ShotgunPattern
CALLV
pop
line 192
;191:			//Com_Printf( "Predicted shotgun pattern\n" );
;192:		}
line 193
;193:	}
ADDRGP4 $171
JUMPV
LABELV $170
line 195
;194:	// was it a machinegun attack?
;195:	else if ( ent->weapon == WP_MACHINEGUN ) {
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
NEI4 $219
line 197
;196:		// do we have it on for the machinegun?
;197:		if ( cg_delag.integer & 1 || cg_delag.integer & 2 ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 56
INDIRI4
NEI4 $225
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 56
INDIRI4
EQI4 $220
LABELV $225
line 199
;198:			// the server will use this exact time (it'll be serverTime on that end)
;199:			int seed = cg.oldTime % 256;
ADDRLP4 60
ADDRGP4 cg+107608
INDIRI4
CNSTI4 256
MODI4
ASGNI4
line 203
;200:			float r, u;
;201:			trace_t tr;
;202:			qboolean flesh;
;203:			int fleshEntityNum = 0;
ADDRLP4 64
CNSTI4 0
ASGNI4
line 208
;204:			vec3_t endPoint;
;205:
;206:			// do everything exactly like the server does
;207:
;208:			r = Q_random(&seed) * M_PI * 2.0f;
ADDRLP4 60
ARGP4
ADDRLP4 148
ADDRGP4 Q_random
CALLF4
ASGNF4
ADDRLP4 80
CNSTF4 1073741824
CNSTF4 1078530011
ADDRLP4 148
INDIRF4
MULF4
MULF4
ASGNF4
line 209
;209:			u = sin(r) * Q_crandom(&seed) * mod_mgspread * 16;
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 152
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 60
ARGP4
ADDRLP4 156
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 140
CNSTF4 1098907648
ADDRLP4 152
INDIRF4
ADDRLP4 156
INDIRF4
MULF4
ADDRGP4 mod_mgspread
INDIRI4
CVIF4 4
MULF4
MULF4
ASGNF4
line 210
;210:			r = cos(r) * Q_crandom(&seed) * mod_mgspread * 16;
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 160
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 60
ARGP4
ADDRLP4 164
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 80
CNSTF4 1098907648
ADDRLP4 160
INDIRF4
ADDRLP4 164
INDIRF4
MULF4
ADDRGP4 mod_mgspread
INDIRI4
CVIF4 4
MULF4
MULF4
ASGNF4
line 212
;211:
;212:			VectorMA( muzzlePoint, 8192*16, forward, endPoint );
ADDRLP4 168
CNSTF4 1207959552
ASGNF4
ADDRLP4 68
ADDRLP4 0
INDIRF4
ADDRLP4 168
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 168
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1207959552
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 213
;213:			VectorMA( endPoint, r, right, endPoint );
ADDRLP4 172
ADDRLP4 80
INDIRF4
ASGNF4
ADDRLP4 68
ADDRLP4 68
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 68+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDRLP4 80
INDIRF4
MULF4
ADDF4
ASGNF4
line 214
;214:			VectorMA( endPoint, u, up, endPoint );
ADDRLP4 176
ADDRLP4 140
INDIRF4
ASGNF4
ADDRLP4 68
ADDRLP4 68
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 68+4
INDIRF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 140
INDIRF4
MULF4
ADDF4
ASGNF4
line 216
;215:
;216:			CG_Trace(&tr, muzzlePoint, NULL, NULL, endPoint, cg.predictedPlayerState.clientNum, MASK_SHOT );
ADDRLP4 84
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 180
CNSTP4 0
ASGNP4
ADDRLP4 180
INDIRP4
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 218
;217:
;218:			if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 84+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $247
line 219
;219:				return;
ADDRGP4 $74
JUMPV
LABELV $247
line 223
;220:			}
;221:
;222:			// snap the endpos to integers, but nudged towards the line
;223:			SnapVectorTowards( tr.endpos, muzzlePoint );
ADDRLP4 84+12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 226
;224:
;225:			// do bullet impact
;226:			if ( tr.entityNum < MAX_CLIENTS ) {
ADDRLP4 84+52
INDIRI4
CNSTI4 64
GEI4 $251
line 227
;227:				flesh = qtrue;
ADDRLP4 144
CNSTI4 1
ASGNI4
line 228
;228:				fleshEntityNum = tr.entityNum;
ADDRLP4 64
ADDRLP4 84+52
INDIRI4
ASGNI4
line 229
;229:			} else {
ADDRGP4 $252
JUMPV
LABELV $251
line 230
;230:				flesh = qfalse;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 231
;231:			}
LABELV $252
line 234
;232:
;233:			// do the bullet impact
;234:			CG_Bullet( tr.endpos, cg.predictedPlayerState.clientNum, tr.plane.normal, flesh, fleshEntityNum );
ADDRLP4 84+12
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
ADDRLP4 84+24
ARGP4
ADDRLP4 144
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 236
;235:			//Com_Printf( "Predicted bullet\n" );
;236:		}
line 237
;237:	}
ADDRGP4 $220
JUMPV
LABELV $219
line 239
;238:	// was it a chaingun attack?
;239:	else if ( ent->weapon == WP_CHAINGUN ) {
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 13
NEI4 $259
line 241
;240:		// do we have it on for the machinegun?
;241:		if ( cg_delag.integer & 1 || cg_delag.integer & 2 ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 56
INDIRI4
NEI4 $265
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 56
INDIRI4
EQI4 $261
LABELV $265
line 243
;242:			// the server will use this exact time (it'll be serverTime on that end)
;243:			int seed = cg.oldTime % 256;
ADDRLP4 60
ADDRGP4 cg+107608
INDIRI4
CNSTI4 256
MODI4
ASGNI4
line 247
;244:			float r, u;
;245:			trace_t tr;
;246:			qboolean flesh;
;247:			int fleshEntityNum = 0;
ADDRLP4 64
CNSTI4 0
ASGNI4
line 252
;248:			vec3_t endPoint;
;249:
;250:			// do everything exactly like the server does
;251:
;252:			r = Q_random(&seed) * M_PI * 2.0f;
ADDRLP4 60
ARGP4
ADDRLP4 148
ADDRGP4 Q_random
CALLF4
ASGNF4
ADDRLP4 80
CNSTF4 1073741824
CNSTF4 1078530011
ADDRLP4 148
INDIRF4
MULF4
MULF4
ASGNF4
line 253
;253:			u = sin(r) * Q_crandom(&seed) * mod_cgspread * 16;
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 152
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 60
ARGP4
ADDRLP4 156
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 140
CNSTF4 1098907648
ADDRLP4 152
INDIRF4
ADDRLP4 156
INDIRF4
MULF4
ADDRGP4 mod_cgspread
INDIRI4
CVIF4 4
MULF4
MULF4
ASGNF4
line 254
;254:			r = cos(r) * Q_crandom(&seed) * mod_cgspread * 16;
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 160
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 60
ARGP4
ADDRLP4 164
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 80
CNSTF4 1098907648
ADDRLP4 160
INDIRF4
ADDRLP4 164
INDIRF4
MULF4
ADDRGP4 mod_cgspread
INDIRI4
CVIF4 4
MULF4
MULF4
ASGNF4
line 256
;255:
;256:			VectorMA( muzzlePoint, 8192*16, forward, endPoint );
ADDRLP4 168
CNSTF4 1207959552
ASGNF4
ADDRLP4 68
ADDRLP4 0
INDIRF4
ADDRLP4 168
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 168
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1207959552
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 257
;257:			VectorMA( endPoint, r, right, endPoint );
ADDRLP4 172
ADDRLP4 80
INDIRF4
ASGNF4
ADDRLP4 68
ADDRLP4 68
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 68+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDRLP4 80
INDIRF4
MULF4
ADDF4
ASGNF4
line 258
;258:			VectorMA( endPoint, u, up, endPoint );
ADDRLP4 176
ADDRLP4 140
INDIRF4
ASGNF4
ADDRLP4 68
ADDRLP4 68
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 68+4
INDIRF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 140
INDIRF4
MULF4
ADDF4
ASGNF4
line 260
;259:
;260:			CG_Trace(&tr, muzzlePoint, NULL, NULL, endPoint, cg.predictedPlayerState.clientNum, MASK_SHOT );
ADDRLP4 84
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 180
CNSTP4 0
ASGNP4
ADDRLP4 180
INDIRP4
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 262
;261:
;262:			if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 84+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $287
line 263
;263:				return;
ADDRGP4 $74
JUMPV
LABELV $287
line 267
;264:			}
;265:
;266:			// snap the endpos to integers, but nudged towards the line
;267:			SnapVectorTowards( tr.endpos, muzzlePoint );
ADDRLP4 84+12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 270
;268:
;269:			// do bullet impact
;270:			if ( tr.entityNum < MAX_CLIENTS ) {
ADDRLP4 84+52
INDIRI4
CNSTI4 64
GEI4 $291
line 271
;271:				flesh = qtrue;
ADDRLP4 144
CNSTI4 1
ASGNI4
line 272
;272:				fleshEntityNum = tr.entityNum;
ADDRLP4 64
ADDRLP4 84+52
INDIRI4
ASGNI4
line 273
;273:			} else {
ADDRGP4 $292
JUMPV
LABELV $291
line 274
;274:				flesh = qfalse;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 275
;275:			}
LABELV $292
line 278
;276:
;277:			// do the bullet impact
;278:			CG_Bullet( tr.endpos, cg.predictedPlayerState.clientNum, tr.plane.normal, flesh, fleshEntityNum );
ADDRLP4 84+12
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
ADDRLP4 84+24
ARGP4
ADDRLP4 144
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 280
;279:			//Com_Printf( "Predicted bullet\n" );
;280:		}
LABELV $261
line 281
;281:	}
LABELV $259
LABELV $220
LABELV $171
LABELV $96
line 282
;282:}
LABELV $74
endproc CG_PredictWeaponEffects 184 48
export CG_Cvar_ClampInt
proc CG_Cvar_ClampInt 0 16
line 455
;283:
;284:/*
;285:=================
;286:CG_AddBoundingBox
;287:
;288:Draws a bounding box around a player.  Called from CG_Player.
;289:=================
;290:*/
;291:/*void CG_AddBoundingBox( centity_t *cent ) {
;292:	polyVert_t verts[4];
;293:	clientInfo_t *ci;
;294:	int i;
;295:	vec3_t mins = {-15, -15, -24};
;296:	vec3_t maxs = {15, 15, 32};
;297:	float extx, exty, extz;
;298:	vec3_t corners[8];
;299:	qhandle_t bboxShader, bboxShader_nocull;
;300:
;301:	if ( !cg_drawBBox.integer ) {
;302:		return;
;303:	}
;304:
;305:	// don't draw it if it's us in first-person
;306:	if ( cent->currentState.number == cg.predictedPlayerState.clientNum &&
;307:			!cg.renderingThirdPerson ) {
;308:		return;
;309:	}
;310:
;311:	// don't draw it for dead players
;312:	if ( cent->currentState.eFlags & EF_DEAD ) {
;313:		return;
;314:	}
;315:
;316:	// get the shader handles
;317:	bboxShader = trap_R_RegisterShader( "bbox" );
;318:	bboxShader_nocull = trap_R_RegisterShader( "bbox_nocull" );
;319:
;320:	// if they don't exist, forget it
;321:	if ( !bboxShader || !bboxShader_nocull ) {
;322:		return;
;323:	}
;324:
;325:	// get the player's client info
;326:	ci = &cgs.clientinfo[cent->currentState.clientNum];
;327:
;328:	// if it's us
;329:	if ( cent->currentState.number == cg.predictedPlayerState.clientNum ) {
;330:		// use the view height
;331:		maxs[2] = cg.predictedPlayerState.viewheight + 6;
;332:	}
;333:	else {
;334:		int x, zd, zu;
;335:
;336:		// otherwise grab the encoded bounding box
;337:		x = (cent->currentState.solid & 255);
;338:		zd = ((cent->currentState.solid>>8) & 255);
;339:		zu = ((cent->currentState.solid>>16) & 255) - 32;
;340:
;341:		mins[0] = mins[1] = -x;
;342:		maxs[0] = maxs[1] = x;
;343:		mins[2] = -zd;
;344:		maxs[2] = zu;
;345:	}
;346:
;347:	// get the extents (size)
;348:	extx = maxs[0] - mins[0];
;349:	exty = maxs[1] - mins[1];
;350:	extz = maxs[2] - mins[2];
;351:
;352:	
;353:	// set the polygon's texture coordinates
;354:	verts[0].st[0] = 0;
;355:	verts[0].st[1] = 0;
;356:	verts[1].st[0] = 0;
;357:	verts[1].st[1] = 1;
;358:	verts[2].st[0] = 1;
;359:	verts[2].st[1] = 1;
;360:	verts[3].st[0] = 1;
;361:	verts[3].st[1] = 0;
;362:
;363:	// set the polygon's vertex colors
;364:	if ( ci->team == TEAM_RED ) {
;365:		for ( i = 0; i < 4; i++ ) {
;366:			verts[i].modulate[0] = 160;
;367:			verts[i].modulate[1] = 0;
;368:			verts[i].modulate[2] = 0;
;369:			verts[i].modulate[3] = 255;
;370:		}
;371:	}
;372:	else if ( ci->team == TEAM_BLUE ) {
;373:		for ( i = 0; i < 4; i++ ) {
;374:			verts[i].modulate[0] = 0;
;375:			verts[i].modulate[1] = 0;
;376:			verts[i].modulate[2] = 192;
;377:			verts[i].modulate[3] = 255;
;378:		}
;379:	}
;380:	else {
;381:		for ( i = 0; i < 4; i++ ) {
;382:			verts[i].modulate[0] = 0;
;383:			verts[i].modulate[1] = 128;
;384:			verts[i].modulate[2] = 0;
;385:			verts[i].modulate[3] = 255;
;386:		}
;387:	}
;388:
;389:	VectorAdd( cent->lerpOrigin, maxs, corners[3] );
;390:
;391:	VectorCopy( corners[3], corners[2] );
;392:	corners[2][0] -= extx;
;393:
;394:	VectorCopy( corners[2], corners[1] );
;395:	corners[1][1] -= exty;
;396:
;397:	VectorCopy( corners[1], corners[0] );
;398:	corners[0][0] += extx;
;399:
;400:	for ( i = 0; i < 4; i++ ) {
;401:		VectorCopy( corners[i], corners[i + 4] );
;402:		corners[i + 4][2] -= extz;
;403:	}
;404:
;405:	// top
;406:	VectorCopy( corners[0], verts[0].xyz );
;407:	VectorCopy( corners[1], verts[1].xyz );
;408:	VectorCopy( corners[2], verts[2].xyz );
;409:	VectorCopy( corners[3], verts[3].xyz );
;410:	trap_R_AddPolyToScene( bboxShader, 4, verts );
;411:
;412:	// bottom
;413:	VectorCopy( corners[7], verts[0].xyz );
;414:	VectorCopy( corners[6], verts[1].xyz );
;415:	VectorCopy( corners[5], verts[2].xyz );
;416:	VectorCopy( corners[4], verts[3].xyz );
;417:	trap_R_AddPolyToScene( bboxShader, 4, verts );
;418:
;419:	// top side
;420:	VectorCopy( corners[3], verts[0].xyz );
;421:	VectorCopy( corners[2], verts[1].xyz );
;422:	VectorCopy( corners[6], verts[2].xyz );
;423:	VectorCopy( corners[7], verts[3].xyz );
;424:	trap_R_AddPolyToScene( bboxShader_nocull, 4, verts );
;425:
;426:	// left side
;427:	VectorCopy( corners[2], verts[0].xyz );
;428:	VectorCopy( corners[1], verts[1].xyz );
;429:	VectorCopy( corners[5], verts[2].xyz );
;430:	VectorCopy( corners[6], verts[3].xyz );
;431:	trap_R_AddPolyToScene( bboxShader_nocull, 4, verts );
;432:
;433:	// right side
;434:	VectorCopy( corners[0], verts[0].xyz );
;435:	VectorCopy( corners[3], verts[1].xyz );
;436:	VectorCopy( corners[7], verts[2].xyz );
;437:	VectorCopy( corners[4], verts[3].xyz );
;438:	trap_R_AddPolyToScene( bboxShader_nocull, 4, verts );
;439:
;440:	// bottom side
;441:	VectorCopy( corners[1], verts[0].xyz );
;442:	VectorCopy( corners[0], verts[1].xyz );
;443:	VectorCopy( corners[4], verts[2].xyz );
;444:	VectorCopy( corners[5], verts[3].xyz );
;445:	trap_R_AddPolyToScene( bboxShader_nocull, 4, verts );
;446:}*/
;447:
;448:/*
;449:================
;450:CG_Cvar_ClampInt
;451:
;452:Clamps a cvar between two integer values, returns qtrue if it had to.
;453:================
;454:*/
;455:qboolean CG_Cvar_ClampInt( const char *name, vmCvar_t *vmCvar, int min, int max ) {
line 456
;456:	if ( vmCvar->integer > max ) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRFP4 12
INDIRI4
LEI4 $300
line 457
;457:		CG_Printf( "Allowed values are %d to %d.\n", min, max );
ADDRGP4 $302
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 459
;458:
;459:		Com_sprintf( vmCvar->string, MAX_CVAR_VALUE_STRING, "%d", max );
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $303
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 460
;460:		vmCvar->value = max;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 12
INDIRI4
CVIF4 4
ASGNF4
line 461
;461:		vmCvar->integer = max;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 12
INDIRI4
ASGNI4
line 463
;462:
;463:		trap_Cvar_Set( name, vmCvar->string );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 464
;464:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $299
JUMPV
LABELV $300
line 467
;465:	}
;466:
;467:	if ( vmCvar->integer < min ) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
GEI4 $304
line 468
;468:		CG_Printf( "Allowed values are %d to %d.\n", min, max );
ADDRGP4 $302
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 470
;469:
;470:		Com_sprintf( vmCvar->string, MAX_CVAR_VALUE_STRING, "%d", min );
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $303
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 471
;471:		vmCvar->value = min;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 472
;472:		vmCvar->integer = min;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 474
;473:
;474:		trap_Cvar_Set( name, vmCvar->string );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 475
;475:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $299
JUMPV
LABELV $304
line 478
;476:	}
;477:
;478:	return qfalse;
CNSTI4 0
RETI4
LABELV $299
endproc CG_Cvar_ClampInt 0 16
import CG_ShotgunPattern
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
LABELV $303
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $302
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 10
byte 1 0
