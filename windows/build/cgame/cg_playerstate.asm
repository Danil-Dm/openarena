export CG_CheckAmmo
code
proc CG_CheckAmmo 24 8
file "../../../code/cgame/cg_playerstate.c"
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
;23:// cg_playerstate.c -- this file acts on changes in a new playerState_t
;24:// With normal play, this will be done after local prediction, but when
;25:// following another player or playing back a demo, it will be checked
;26:// when the snapshot transitions like all the other entities
;27:
;28:#include "cg_local.h"
;29:
;30:/*
;31:==============
;32:CG_CheckAmmo
;33:
;34:If the ammo has gone low enough to generate the warning, play a sound
;35:==============
;36:*/
;37:void CG_CheckAmmo( void ) {
line 44
;38:	int		i;
;39:	int		total;
;40:	int		previous;
;41:	int		weapons;
;42:
;43:	// see about how many seconds of ammo we have remaining
;44:	weapons = cg.snap->ps.stats[ STAT_WEAPONS ];
ADDRLP4 8
ADDRGP4 cg+36
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
line 45
;45:	total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 46
;46:	for ( i = WP_MACHINEGUN ; i < WP_NUM_WEAPONS ; i++ ) {
ADDRLP4 0
CNSTI4 2
ASGNI4
LABELV $76
line 47
;47:		if ( ! ( weapons & ( 1 << i ) ) || i == WP_GRAPPLING_HOOK ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $82
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $80
LABELV $82
line 48
;48:			continue;
ADDRGP4 $77
JUMPV
LABELV $80
line 50
;49:		}
;50:		switch ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $83
ADDRLP4 0
INDIRI4
CNSTI4 12
GTI4 $83
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $88-12
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $88
address $85
address $85
address $85
address $83
address $85
address $83
address $83
address $83
address $83
address $85
code
LABELV $85
line 56
;51:		case WP_ROCKET_LAUNCHER:
;52:		case WP_GRENADE_LAUNCHER:
;53:		case WP_RAILGUN:
;54:		case WP_SHOTGUN:
;55:		case WP_PROX_LAUNCHER:
;56:			total += cg.snap->ps.ammo[i] * 1000;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1000
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 420
ADDP4
ADDP4
INDIRI4
MULI4
ADDI4
ASGNI4
line 57
;57:			break;
ADDRGP4 $84
JUMPV
LABELV $83
line 59
;58:		default:
;59:			total += cg.snap->ps.ammo[i] * 200;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 200
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 420
ADDP4
ADDP4
INDIRI4
MULI4
ADDI4
ASGNI4
line 60
;60:			break;
LABELV $84
line 62
;61:		}
;62:		if ( total >= 5000 ) {
ADDRLP4 4
INDIRI4
CNSTI4 5000
LTI4 $90
line 63
;63:			cg.lowAmmoWarning = 0;
ADDRGP4 cg+124984
CNSTI4 0
ASGNI4
line 64
;64:			return;
ADDRGP4 $74
JUMPV
LABELV $90
line 66
;65:		}
;66:	}
LABELV $77
line 46
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $76
line 68
;67:
;68:	previous = cg.lowAmmoWarning;
ADDRLP4 12
ADDRGP4 cg+124984
INDIRI4
ASGNI4
line 70
;69:
;70:	if ( total == 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $94
line 71
;71:		cg.lowAmmoWarning = 2;
ADDRGP4 cg+124984
CNSTI4 2
ASGNI4
line 72
;72:	} else {
ADDRGP4 $95
JUMPV
LABELV $94
line 73
;73:		cg.lowAmmoWarning = 1;
ADDRGP4 cg+124984
CNSTI4 1
ASGNI4
line 74
;74:	}
LABELV $95
line 77
;75:
;76:	// play a sound on transitions
;77:	if ( cg.lowAmmoWarning != previous ) {
ADDRGP4 cg+124984
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $98
line 78
;78:		trap_S_StartLocalSound( cgs.media.noAmmoSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+180268+1084
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 79
;79:	}
LABELV $98
line 80
;80:}
LABELV $74
endproc CG_CheckAmmo 24 8
export CG_DamageFeedback
proc CG_DamageFeedback 72 16
line 87
;81:
;82:/*
;83:==============
;84:CG_DamageFeedback
;85:==============
;86:*/
;87:void CG_DamageFeedback( int yawByte, int pitchByte, int damage ) {
line 98
;88:	float		left, front, up;
;89:	float		kick;
;90:	int			health;
;91:	float		scale;
;92:	vec3_t		dir;
;93:	vec3_t		angles;
;94:	float		dist;
;95:	float		yaw, pitch;
;96:
;97:	// show the attacking player's head and name in corner
;98:	cg.attackerTime = cg.time;
ADDRGP4 cg+125008
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 101
;99:
;100:	// the lower on health you are, the greater the view kick will be
;101:	health = cg.snap->ps.stats[STAT_HEALTH];
ADDRLP4 20
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ASGNI4
line 102
;102:	if ( health < 40 ) {
ADDRLP4 20
INDIRI4
CNSTI4 40
GEI4 $107
line 103
;103:		scale = 1;
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
line 104
;104:	} else {
ADDRGP4 $108
JUMPV
LABELV $107
line 105
;105:		scale = 40.0 / health;
ADDRLP4 28
CNSTF4 1109393408
ADDRLP4 20
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 106
;106:	}
LABELV $108
line 107
;107:	kick = damage * scale;
ADDRLP4 12
ADDRFP4 8
INDIRI4
CVIF4 4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 109
;108:
;109:	if (kick < 5)
ADDRLP4 12
INDIRF4
CNSTF4 1084227584
GEF4 $109
line 110
;110:		kick = 5;
ADDRLP4 12
CNSTF4 1084227584
ASGNF4
LABELV $109
line 111
;111:	if (kick > 10)
ADDRLP4 12
INDIRF4
CNSTF4 1092616192
LEF4 $111
line 112
;112:		kick = 10;
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
LABELV $111
line 115
;113:
;114:	// if yaw and pitch are both 255, make the damage always centered (falling, etc)
;115:	if ( yawByte == 255 && pitchByte == 255 ) {
ADDRLP4 60
CNSTI4 255
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $113
ADDRFP4 4
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $113
line 116
;116:		cg.damageX = 0;
ADDRGP4 cg+125284
CNSTF4 0
ASGNF4
line 117
;117:		cg.damageY = 0;
ADDRGP4 cg+125288
CNSTF4 0
ASGNF4
line 118
;118:		cg.v_dmg_roll = 0;
ADDRGP4 cg+125332
CNSTF4 0
ASGNF4
line 119
;119:		cg.v_dmg_pitch = -kick;
ADDRGP4 cg+125328
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
line 120
;120:	} else {
ADDRGP4 $114
JUMPV
LABELV $113
line 122
;121:		// positional
;122:		pitch = pitchByte / 255.0 * 360;
ADDRLP4 56
CNSTF4 1135869952
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1132396544
DIVF4
MULF4
ASGNF4
line 123
;123:		yaw = yawByte / 255.0 * 360;
ADDRLP4 52
CNSTF4 1135869952
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1132396544
DIVF4
MULF4
ASGNF4
line 125
;124:
;125:		angles[PITCH] = pitch;
ADDRLP4 32
ADDRLP4 56
INDIRF4
ASGNF4
line 126
;126:		angles[YAW] = yaw;
ADDRLP4 32+4
ADDRLP4 52
INDIRF4
ASGNF4
line 127
;127:		angles[ROLL] = 0;
ADDRLP4 32+8
CNSTF4 0
ASGNF4
line 129
;128:
;129:		AngleVectors( angles, dir, NULL, NULL );
ADDRLP4 32
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 64
CNSTP4 0
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 130
;130:		VectorSubtract( vec3_origin, dir, dir );
ADDRLP4 0
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 132
;131:
;132:		front = DotProduct (dir, cg.refdef.viewaxis[0] );
ADDRLP4 16
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109252+36
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109252+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109252+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 133
;133:		left = DotProduct (dir, cg.refdef.viewaxis[1] );
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109252+36+12
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109252+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109252+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 134
;134:		up = DotProduct (dir, cg.refdef.viewaxis[2] );
ADDRLP4 48
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109252+36+24
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109252+36+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109252+36+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 136
;135:
;136:		dir[0] = front;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 137
;137:		dir[1] = left;
ADDRLP4 0+4
ADDRLP4 24
INDIRF4
ASGNF4
line 138
;138:		dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 139
;139:		dist = VectorLength( dir );
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 68
INDIRF4
ASGNF4
line 140
;140:		if ( dist < 0.1 ) {
ADDRLP4 44
INDIRF4
CNSTF4 1036831949
GEF4 $165
line 141
;141:			dist = 0.1f;
ADDRLP4 44
CNSTF4 1036831949
ASGNF4
line 142
;142:		}
LABELV $165
line 144
;143:
;144:		cg.v_dmg_roll = kick * left;
ADDRGP4 cg+125332
ADDRLP4 12
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 146
;145:		
;146:		cg.v_dmg_pitch = -kick * front;
ADDRGP4 cg+125328
ADDRLP4 12
INDIRF4
NEGF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 148
;147:
;148:		if ( front <= 0.1 ) {
ADDRLP4 16
INDIRF4
CNSTF4 1036831949
GTF4 $169
line 149
;149:			front = 0.1f;
ADDRLP4 16
CNSTF4 1036831949
ASGNF4
line 150
;150:		}
LABELV $169
line 151
;151:		cg.damageX = -left / front;
ADDRGP4 cg+125284
ADDRLP4 24
INDIRF4
NEGF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
line 152
;152:		cg.damageY = up / dist;
ADDRGP4 cg+125288
ADDRLP4 48
INDIRF4
ADDRLP4 44
INDIRF4
DIVF4
ASGNF4
line 153
;153:	}
LABELV $114
line 156
;154:
;155:	// clamp the position
;156:	if ( cg.damageX > 1.0 ) {
ADDRGP4 cg+125284
INDIRF4
CNSTF4 1065353216
LEF4 $173
line 157
;157:		cg.damageX = 1.0;
ADDRGP4 cg+125284
CNSTF4 1065353216
ASGNF4
line 158
;158:	}
LABELV $173
line 159
;159:	if ( cg.damageX < - 1.0 ) {
ADDRGP4 cg+125284
INDIRF4
CNSTF4 3212836864
GEF4 $177
line 160
;160:		cg.damageX = -1.0;
ADDRGP4 cg+125284
CNSTF4 3212836864
ASGNF4
line 161
;161:	}
LABELV $177
line 163
;162:
;163:	if ( cg.damageY > 1.0 ) {
ADDRGP4 cg+125288
INDIRF4
CNSTF4 1065353216
LEF4 $181
line 164
;164:		cg.damageY = 1.0;
ADDRGP4 cg+125288
CNSTF4 1065353216
ASGNF4
line 165
;165:	}
LABELV $181
line 166
;166:	if ( cg.damageY < - 1.0 ) {
ADDRGP4 cg+125288
INDIRF4
CNSTF4 3212836864
GEF4 $185
line 167
;167:		cg.damageY = -1.0;
ADDRGP4 cg+125288
CNSTF4 3212836864
ASGNF4
line 168
;168:	}
LABELV $185
line 171
;169:
;170:	// don't let the screen flashes vary as much
;171:	if ( kick > 10 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1092616192
LEF4 $189
line 172
;172:		kick = 10;
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
line 173
;173:	}
LABELV $189
line 174
;174:	cg.damageValue = kick;
ADDRGP4 cg+125292
ADDRLP4 12
INDIRF4
ASGNF4
line 175
;175:	cg.v_dmg_time = cg.time + DAMAGE_TIME;
ADDRGP4 cg+125324
ADDRGP4 cg+107604
INDIRI4
CNSTI4 500
ADDI4
CVIF4 4
ASGNF4
line 176
;176:	cg.damageTime = cg.snap->serverTime;
ADDRGP4 cg+125280
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 177
;177:}
LABELV $103
endproc CG_DamageFeedback 72 16
export CG_Respawn
proc CG_Respawn 0 0
line 189
;178:
;179:
;180:
;181:
;182:/*
;183:================
;184:CG_Respawn
;185:
;186:A respawn happened this snapshot
;187:================
;188:*/
;189:void CG_Respawn( void ) {
line 191
;190:	// no error decay on player movement
;191:	cg.thisFrameTeleport = qtrue;
ADDRGP4 cg+107592
CNSTI4 1
ASGNI4
line 194
;192:
;193:	// display weapons available
;194:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+125268
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 197
;195:
;196:	// select the weapon the server says we are using
;197:	cg.weaponSelect = cg.snap->ps.weapon;
ADDRGP4 cg+109152
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 198
;198:}
LABELV $196
endproc CG_Respawn 0 0
export CG_CheckPlayerstateEvents
proc CG_CheckPlayerstateEvents 52 8
line 207
;199:
;200:extern char *eventnames[];
;201:
;202:/*
;203:==============
;204:CG_CheckPlayerstateEvents
;205:==============
;206:*/
;207:void CG_CheckPlayerstateEvents( playerState_t *ps, playerState_t *ops ) {
line 212
;208:	int			i;
;209:	int			event;
;210:	centity_t	*cent;
;211:
;212:	if ( ps->externalEvent && ps->externalEvent != ops->externalEvent ) {
ADDRLP4 12
CNSTI4 128
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $203
ADDRLP4 16
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
EQI4 $203
line 213
;213:		cent = &cg_entities[ ps->clientNum ];
ADDRLP4 4
CNSTI4 936
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 214
;214:		cent->currentState.event = ps->externalEvent;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ASGNI4
line 215
;215:		cent->currentState.eventParm = ps->externalEventParm;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ASGNI4
line 216
;216:		CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 217
;217:	}
LABELV $203
line 219
;218:
;219:	cent = &cg.predictedPlayerEntity; // cg_entities[ ps->clientNum ];
ADDRLP4 4
ADDRGP4 cg+108104
ASGNP4
line 221
;220:	// go through the predictable events buffer
;221:	for ( i = ps->eventSequence - MAX_PS_EVENTS ; i < ps->eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
ADDRGP4 $209
JUMPV
LABELV $206
line 223
;222:		// if we have a new predictable event
;223:		if ( i >= ops->eventSequence
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 28
INDIRI4
GEI4 $212
ADDRLP4 32
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
LEI4 $210
ADDRLP4 36
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 32
INDIRI4
LSHI4
ASGNI4
ADDRLP4 40
CNSTI4 112
ASGNI4
ADDRLP4 36
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 24
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $210
LABELV $212
line 226
;224:			// or the server told us to play another event instead of a predicted event we already issued
;225:			// or something the server told us changed our prediction causing a different event
;226:			|| (i > ops->eventSequence - MAX_PS_EVENTS && ps->events[i & (MAX_PS_EVENTS-1)] != ops->events[i & (MAX_PS_EVENTS-1)]) ) {
line 228
;227:
;228:			event = ps->events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 229
;229:			cent->currentState.event = event;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 230
;230:			cent->currentState.eventParm = ps->eventParms[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ASGNI4
line 231
;231:			CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 233
;232:
;233:			cg.predictableEvents[ i & (MAX_PREDICTED_EVENTS-1) ] = event;
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109064
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 235
;234:
;235:			cg.eventSequence++;
ADDRLP4 48
ADDRGP4 cg+109060
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 236
;236:		}
LABELV $210
line 237
;237:	}
LABELV $207
line 221
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $209
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $206
line 238
;238:}
LABELV $202
endproc CG_CheckPlayerstateEvents 52 8
export CG_CheckChangedPredictableEvents
proc CG_CheckChangedPredictableEvents 24 8
line 245
;239:
;240:/*
;241:==================
;242:CG_CheckChangedPredictableEvents
;243:==================
;244:*/
;245:void CG_CheckChangedPredictableEvents( playerState_t *ps ) {
line 250
;246:	int i;
;247:	int event;
;248:	centity_t	*cent;
;249:
;250:	cent = &cg.predictedPlayerEntity;
ADDRLP4 4
ADDRGP4 cg+108104
ASGNP4
line 251
;251:	for ( i = ps->eventSequence - MAX_PS_EVENTS ; i < ps->eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
ADDRGP4 $220
JUMPV
LABELV $217
line 253
;252:		//
;253:		if (i >= cg.eventSequence) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+109060
INDIRI4
LTI4 $221
line 254
;254:			continue;
ADDRGP4 $218
JUMPV
LABELV $221
line 257
;255:		}
;256:		// if this event is not further back in than the maximum predictable events we remember
;257:		if (i > cg.eventSequence - MAX_PREDICTED_EVENTS) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+109060
INDIRI4
CNSTI4 16
SUBI4
LEI4 $224
line 259
;258:			// if the new playerstate event is different from a previously predicted one
;259:			if ( ps->events[i & (MAX_PS_EVENTS-1)] != cg.predictableEvents[i & (MAX_PREDICTED_EVENTS-1) ] ) {
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRGP4 cg+109064
ADDP4
INDIRI4
EQI4 $227
line 261
;260:
;261:				event = ps->events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 262
;262:				cent->currentState.event = event;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 263
;263:				cent->currentState.eventParm = ps->eventParms[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ASGNI4
line 264
;264:				CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 776
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 266
;265:
;266:				cg.predictableEvents[ i & (MAX_PREDICTED_EVENTS-1) ] = event;
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109064
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 268
;267:
;268:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $231
line 269
;269:					CG_Printf("WARNING: changed predicted event\n");
ADDRGP4 $234
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 270
;270:				}
LABELV $231
line 271
;271:			}
LABELV $227
line 272
;272:		}
LABELV $224
line 273
;273:	}
LABELV $218
line 251
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $220
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $217
line 274
;274:}
LABELV $215
endproc CG_CheckChangedPredictableEvents 24 8
proc pushReward 4 0
line 281
;275:
;276:/*
;277:==================
;278:pushReward
;279:==================
;280:*/
;281:static void pushReward(sfxHandle_t sfx, qhandle_t shader, int rewardCount) {
line 282
;282:	if (cg.rewardStack < (MAX_REWARDSTACK-1)) {
ADDRGP4 cg+125016
INDIRI4
CNSTI4 9
GEI4 $236
line 283
;283:		cg.rewardStack++;
ADDRLP4 0
ADDRGP4 cg+125016
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 284
;284:		cg.rewardSound[cg.rewardStack] = sfx;
ADDRGP4 cg+125016
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125104
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 285
;285:		cg.rewardShader[cg.rewardStack] = shader;
ADDRGP4 cg+125016
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125064
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 286
;286:		cg.rewardCount[cg.rewardStack] = rewardCount;
ADDRGP4 cg+125016
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125024
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 287
;287:	}
LABELV $236
line 288
;288:}
LABELV $235
endproc pushReward 4 0
export CG_CheckLocalSounds
proc CG_CheckLocalSounds 76 12
line 295
;289:
;290:/*
;291:==================
;292:CG_CheckLocalSounds
;293:==================
;294:*/
;295:void CG_CheckLocalSounds( playerState_t *ps, playerState_t *ops ) {
line 300
;296:	int			highScore, reward;
;297:	sfxHandle_t sfx;
;298:
;299:	// don't play the sounds if the player just changed teams
;300:	if ( ps->persistant[PERS_TEAM] != ops->persistant[PERS_TEAM] ) {
ADDRLP4 12
CNSTI4 260
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
EQI4 $247
line 301
;301:		return;
ADDRGP4 $246
JUMPV
LABELV $247
line 305
;302:	}
;303:
;304:	// hit changes
;305:	if ( ps->persistant[PERS_HITS] > ops->persistant[PERS_HITS] ) {
ADDRLP4 16
CNSTI4 252
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
LEI4 $249
line 318
;306:#ifdef MISSIONPACK
;307:		int health, armor;
;308:		armor  = ps->persistant[PERS_ATTACKEE_ARMOR] & 0xff;
;309:		health = ps->persistant[PERS_ATTACKEE_ARMOR] >> 8;
;310:		if (armor > 50 ) {
;311:			trap_S_StartLocalSound( cgs.media.hitSoundHighArmor, CHAN_LOCAL_SOUND );
;312:		} else if (armor || health > 100) {
;313:			trap_S_StartLocalSound( cgs.media.hitSoundLowArmor, CHAN_LOCAL_SOUND );
;314:		} else {
;315:			trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
;316:		}
;317:#else
;318:		trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+180268+1168
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 320
;319:#endif
;320:	} else if ( ps->persistant[PERS_HITS] < ops->persistant[PERS_HITS] ) {
ADDRGP4 $250
JUMPV
LABELV $249
ADDRLP4 20
CNSTI4 252
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
GEI4 $253
line 321
;321:		trap_S_StartLocalSound( cgs.media.hitTeamSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+180268+1180
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 322
;322:	}
LABELV $253
LABELV $250
line 325
;323:
;324:	// health changes of more than -1 should make pain sounds
;325:	if ( ps->stats[STAT_HEALTH] < ops->stats[STAT_HEALTH] - 1 ) {
ADDRLP4 24
CNSTI4 184
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $257
line 326
;326:		if ( ps->stats[STAT_HEALTH] > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $259
line 327
;327:			CG_PainEvent( &cg.predictedPlayerEntity, ps->stats[STAT_HEALTH] );
ADDRGP4 cg+108104
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 328
;328:		}
LABELV $259
line 329
;329:	}
LABELV $257
line 333
;330:
;331:
;332:	// if we are going into the intermission, don't start any voices
;333:	if ( cg.intermissionStarted ) {
ADDRGP4 cg+24
INDIRI4
CNSTI4 0
EQI4 $262
line 334
;334:		return;
ADDRGP4 $246
JUMPV
LABELV $262
line 338
;335:	}
;336:
;337:	// reward sounds
;338:	reward = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 339
;339:	if (ps->persistant[PERS_CAPTURES] != ops->persistant[PERS_CAPTURES]) {
ADDRLP4 28
CNSTI4 304
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
EQI4 $265
line 340
;340:		pushReward(cgs.media.captureAwardSound, cgs.media.medalCapture, ps->persistant[PERS_CAPTURES]);
ADDRGP4 cgs+180268+1268
INDIRI4
ARGI4
ADDRGP4 cgs+180268+740
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 341
;341:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 343
;342:		//Com_Printf("capture\n");
;343:	}
LABELV $265
line 344
;344:	if (ps->persistant[PERS_IMPRESSIVE_COUNT] != ops->persistant[PERS_IMPRESSIVE_COUNT]) {
ADDRLP4 32
CNSTI4 284
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $271
line 352
;345:#ifdef MISSIONPACK
;346:		if (ps->persistant[PERS_IMPRESSIVE_COUNT] == 1) {
;347:			sfx = cgs.media.firstImpressiveSound;
;348:		} else {
;349:			sfx = cgs.media.impressiveSound;
;350:		}
;351:#else
;352:		sfx = cgs.media.impressiveSound;
ADDRLP4 4
ADDRGP4 cgs+180268+1184
INDIRI4
ASGNI4
line 354
;353:#endif
;354:		pushReward(sfx, cgs.media.medalImpressive, ps->persistant[PERS_IMPRESSIVE_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+180268+720
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 355
;355:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 357
;356:		//Com_Printf("impressive\n");
;357:	}
LABELV $271
line 359
;358:	//KK-OAX We Just Won't Draw The Excellent Stuff if Multikills are Enabled!!!
;359:	if( !cgs.altExcellent ) {
ADDRGP4 cgs+181712
INDIRI4
CNSTI4 0
NEI4 $277
line 360
;360:	    if (ps->persistant[PERS_EXCELLENT_COUNT] != ops->persistant[PERS_EXCELLENT_COUNT]) {
ADDRLP4 36
CNSTI4 288
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
EQI4 $280
line 368
;361:#ifdef MISSIONPACK
;362:		    if (ps->persistant[PERS_EXCELLENT_COUNT] == 1) {
;363:			    sfx = cgs.media.firstExcellentSound;
;364:		    } else {
;365:			    sfx = cgs.media.excellentSound;
;366:		    }
;367:#else
;368:		    sfx = cgs.media.excellentSound;
ADDRLP4 4
ADDRGP4 cgs+180268+1188
INDIRI4
ASGNI4
line 371
;369:#endif
;370:
;371:		    pushReward(sfx, cgs.media.medalExcellent, ps->persistant[PERS_EXCELLENT_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+180268+724
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 372
;372:		    reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 374
;373:		    //Com_Printf("excellent\n");
;374:	    }
LABELV $280
line 375
;375:	}
LABELV $277
line 376
;376:	if (ps->persistant[PERS_GAUNTLET_FRAG_COUNT] != ops->persistant[PERS_GAUNTLET_FRAG_COUNT]) {
ADDRLP4 36
CNSTI4 300
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
EQI4 $286
line 384
;377:#ifdef MISSIONPACK
;378:		if (ops->persistant[PERS_GAUNTLET_FRAG_COUNT] == 1) {
;379:			sfx = cgs.media.firstHumiliationSound;
;380:		} else {
;381:			sfx = cgs.media.humiliationSound;
;382:		}
;383:#else
;384:		sfx = cgs.media.humiliationSound;
ADDRLP4 4
ADDRGP4 cgs+180268+1196
INDIRI4
ASGNI4
line 386
;385:#endif
;386:		pushReward(sfx, cgs.media.medalGauntlet, ps->persistant[PERS_GAUNTLET_FRAG_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+180268+728
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 387
;387:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 389
;388:		//Com_Printf("gauntlet frag\n");
;389:	}
LABELV $286
line 390
;390:	if (ps->persistant[PERS_DEFEND_COUNT] != ops->persistant[PERS_DEFEND_COUNT]) {
ADDRLP4 40
CNSTI4 292
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
EQI4 $292
line 391
;391:		pushReward(cgs.media.defendSound, cgs.media.medalDefend, ps->persistant[PERS_DEFEND_COUNT]);
ADDRGP4 cgs+180268+1204
INDIRI4
ARGI4
ADDRGP4 cgs+180268+732
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 392
;392:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 394
;393:		//Com_Printf("defend\n");
;394:	}
LABELV $292
line 395
;395:	if (ps->persistant[PERS_ASSIST_COUNT] != ops->persistant[PERS_ASSIST_COUNT]) {
ADDRLP4 44
CNSTI4 296
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
EQI4 $298
line 396
;396:		pushReward(cgs.media.assistSound, cgs.media.medalAssist, ps->persistant[PERS_ASSIST_COUNT]);
ADDRGP4 cgs+180268+1200
INDIRI4
ARGI4
ADDRGP4 cgs+180268+736
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 397
;397:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 399
;398:		//Com_Printf("assist\n");
;399:	}
LABELV $298
line 401
;400:	// if any of the player event bits changed
;401:	if (ps->persistant[PERS_PLAYEREVENTS] != ops->persistant[PERS_PLAYEREVENTS]) {
ADDRLP4 48
CNSTI4 268
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
EQI4 $304
line 402
;402:		if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_DENIEDREWARD) !=
ADDRLP4 52
CNSTI4 268
ASGNI4
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
BANDI4
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
BANDI4
EQI4 $306
line 403
;403:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_DENIEDREWARD)) {
line 404
;404:			trap_S_StartLocalSound( cgs.media.deniedSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1192
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 405
;405:		}
ADDRGP4 $307
JUMPV
LABELV $306
line 406
;406:		else if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_GAUNTLETREWARD) !=
ADDRLP4 60
CNSTI4 268
ASGNI4
ADDRLP4 64
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
BANDI4
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
BANDI4
EQI4 $310
line 407
;407:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_GAUNTLETREWARD)) {
line 408
;408:			trap_S_StartLocalSound( cgs.media.humiliationSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1196
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 409
;409:		}
ADDRGP4 $311
JUMPV
LABELV $310
line 410
;410:		else if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_HOLYSHIT) !=
ADDRLP4 68
CNSTI4 268
ASGNI4
ADDRLP4 72
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
BANDI4
ADDRFP4 4
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
BANDI4
EQI4 $314
line 411
;411:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_HOLYSHIT)) {
line 412
;412:			trap_S_StartLocalSound( cgs.media.holyShitSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1352
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 413
;413:		}
LABELV $314
LABELV $311
LABELV $307
line 414
;414:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 415
;415:	}
LABELV $304
line 418
;416:
;417:	// check for flag pickup
;418:	if ( cgs.gametype > GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LEI4 $318
line 419
;419:		if ((ps->powerups[PW_REDFLAG] != ops->powerups[PW_REDFLAG] && ps->powerups[PW_REDFLAG]) ||
ADDRLP4 52
CNSTI4 340
ASGNI4
ADDRLP4 56
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
EQI4 $324
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $325
LABELV $324
ADDRLP4 60
CNSTI4 344
ASGNI4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
EQI4 $326
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $325
LABELV $326
ADDRLP4 68
CNSTI4 348
ASGNI4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRI4
EQI4 $321
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $321
LABELV $325
line 422
;420:			(ps->powerups[PW_BLUEFLAG] != ops->powerups[PW_BLUEFLAG] && ps->powerups[PW_BLUEFLAG]) ||
;421:			(ps->powerups[PW_NEUTRALFLAG] != ops->powerups[PW_NEUTRALFLAG] && ps->powerups[PW_NEUTRALFLAG]) )
;422:		{
line 423
;423:			trap_S_StartLocalSound( cgs.media.youHaveFlagSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1344
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 424
;424:		}
LABELV $321
line 425
;425:	}
LABELV $318
line 428
;426:
;427:	// lead changes
;428:	if (!reward) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $329
line 430
;429:		//
;430:		if ( !cg.warmup ) {
ADDRGP4 cg+125248
INDIRI4
CNSTI4 0
NEI4 $331
line 432
;431:			// never play lead changes during warmup
;432:			if ( ps->persistant[PERS_RANK] != ops->persistant[PERS_RANK] ) {
ADDRLP4 52
CNSTI4 256
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
EQI4 $334
line 433
;433:				if (!CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $336
line 434
;434:					if (  ps->persistant[PERS_RANK] == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
NEI4 $339
line 435
;435:						CG_AddBufferedSound(cgs.media.takenLeadSound);
ADDRGP4 cgs+180268+1220
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 436
;436:					} else if ( ps->persistant[PERS_RANK] == RANK_TIED_FLAG && cgs.gametype != GT_POSSESSION ) {
ADDRGP4 $340
JUMPV
LABELV $339
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 16384
NEI4 $343
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 13
EQI4 $343
line 437
;437:						CG_AddBufferedSound(cgs.media.tiedLeadSound);
ADDRGP4 cgs+180268+1224
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 438
;438:					} else if ( ps->persistant[PERS_RANK] != RANK_TIED_FLAG &&( ops->persistant[PERS_RANK] & ~RANK_TIED_FLAG ) == 0 ) {
ADDRGP4 $344
JUMPV
LABELV $343
ADDRLP4 60
CNSTI4 256
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
CNSTI4 16384
EQI4 $348
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
CNSTI4 -16385
BANDI4
CNSTI4 0
NEI4 $348
line 439
;439:						CG_AddBufferedSound(cgs.media.lostLeadSound);
ADDRGP4 cgs+180268+1228
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 440
;440:					}
LABELV $348
LABELV $344
LABELV $340
line 441
;441:				}
LABELV $336
line 442
;442:			}
LABELV $334
line 443
;443:		}
LABELV $331
line 444
;444:	}
LABELV $329
line 447
;445:
;446:	// timelimit warnings
;447:	if ( cgs.timelimit > 0 && cgs.timelimit <= 1000 ) {
ADDRGP4 cgs+31484
INDIRI4
CNSTI4 0
LEI4 $352
ADDRGP4 cgs+31484
INDIRI4
CNSTI4 1000
GTI4 $352
line 450
;448:		int		msec;
;449:
;450:		msec = cg.time - cgs.levelStartTime;
ADDRLP4 52
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+34804
INDIRI4
SUBI4
ASGNI4
line 451
;451:		if ( !( cg.timelimitWarnings & 4 ) && msec > ( cgs.timelimit * 60 + 2 ) * 1000 ) {
ADDRGP4 cg+107616
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $358
ADDRLP4 52
INDIRI4
CNSTI4 1000
CNSTI4 60
ADDRGP4 cgs+31484
INDIRI4
MULI4
MULI4
CNSTI4 2000
ADDI4
LEI4 $358
line 452
;452:			cg.timelimitWarnings |= 1 | 2 | 4;
ADDRLP4 56
ADDRGP4 cg+107616
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 453
;453:			trap_S_StartLocalSound( cgs.media.suddenDeathSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1152
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 454
;454:		}
ADDRGP4 $359
JUMPV
LABELV $358
line 455
;455:		else if ( !( cg.timelimitWarnings & 2 ) && msec > (cgs.timelimit - 1) * 60 * 1000 ) {
ADDRGP4 cg+107616
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $365
ADDRLP4 52
INDIRI4
CNSTI4 1000
CNSTI4 60
ADDRGP4 cgs+31484
INDIRI4
MULI4
MULI4
CNSTI4 60000
SUBI4
LEI4 $365
line 456
;456:			cg.timelimitWarnings |= 1 | 2;
ADDRLP4 56
ADDRGP4 cg+107616
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 3
BORI4
ASGNI4
line 457
;457:			trap_S_StartLocalSound( cgs.media.oneMinuteSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1144
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 458
;458:		}
ADDRGP4 $366
JUMPV
LABELV $365
line 459
;459:		else if ( cgs.timelimit > 5 && !( cg.timelimitWarnings & 1 ) && msec > (cgs.timelimit - 5) * 60 * 1000 ) {
ADDRGP4 cgs+31484
INDIRI4
CNSTI4 5
LEI4 $372
ADDRGP4 cg+107616
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $372
ADDRLP4 52
INDIRI4
CNSTI4 1000
CNSTI4 60
ADDRGP4 cgs+31484
INDIRI4
MULI4
MULI4
CNSTI4 300000
SUBI4
LEI4 $372
line 460
;460:			cg.timelimitWarnings |= 1;
ADDRLP4 56
ADDRGP4 cg+107616
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 461
;461:			trap_S_StartLocalSound( cgs.media.fiveMinuteSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+180268+1148
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 462
;462:		}
LABELV $372
LABELV $366
LABELV $359
line 463
;463:	}
LABELV $352
line 466
;464:
;465:	// fraglimit warnings
;466:	if (!CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $380
line 467
;467:		highScore = cgs.scores1;
ADDRLP4 8
ADDRGP4 cgs+34980
INDIRI4
ASGNI4
line 469
;468:
;469:		if (cgs.gametype == GT_TEAM && cgs.scores2 > highScore) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
NEI4 $384
ADDRGP4 cgs+34984
INDIRI4
ADDRLP4 8
INDIRI4
LEI4 $384
line 470
;470:			highScore = cgs.scores2;
ADDRLP4 8
ADDRGP4 cgs+34984
INDIRI4
ASGNI4
line 471
;471:		}
LABELV $384
line 473
;472:
;473:		if ( !( cg.fraglimitWarnings & 4 ) && highScore == (cgs.fraglimit - 1) ) {
ADDRGP4 cg+107620
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $389
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 1
SUBI4
NEI4 $389
line 474
;474:			cg.fraglimitWarnings |= 1 | 2 | 4;
ADDRLP4 56
ADDRGP4 cg+107620
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 475
;475:			CG_AddBufferedSound(cgs.media.oneFragSound);
ADDRGP4 cgs+180268+1164
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 476
;476:		}
ADDRGP4 $390
JUMPV
LABELV $389
line 477
;477:		else if ( cgs.fraglimit > 2 && !( cg.fraglimitWarnings & 2 ) && highScore == (cgs.fraglimit - 2) ) {
ADDRLP4 56
CNSTI4 2
ASGNI4
ADDRGP4 cgs+31476
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $396
ADDRGP4 cg+107620
INDIRI4
ADDRLP4 56
INDIRI4
BANDI4
CNSTI4 0
NEI4 $396
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31476
INDIRI4
ADDRLP4 56
INDIRI4
SUBI4
NEI4 $396
line 478
;478:			cg.fraglimitWarnings |= 1 | 2;
ADDRLP4 60
ADDRGP4 cg+107620
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 3
BORI4
ASGNI4
line 479
;479:			CG_AddBufferedSound(cgs.media.twoFragSound);
ADDRGP4 cgs+180268+1160
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 480
;480:		}
ADDRGP4 $397
JUMPV
LABELV $396
line 481
;481:		else if ( cgs.fraglimit > 3 && !( cg.fraglimitWarnings & 1 ) && highScore == (cgs.fraglimit - 3) ) {
ADDRLP4 60
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31476
INDIRI4
ADDRLP4 60
INDIRI4
LEI4 $404
ADDRGP4 cg+107620
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $404
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31476
INDIRI4
ADDRLP4 60
INDIRI4
SUBI4
NEI4 $404
line 482
;482:			cg.fraglimitWarnings |= 1;
ADDRLP4 64
ADDRGP4 cg+107620
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 483
;483:			CG_AddBufferedSound(cgs.media.threeFragSound);
ADDRGP4 cgs+180268+1156
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 484
;484:		}
LABELV $404
LABELV $397
LABELV $390
line 485
;485:	}
LABELV $380
line 486
;486:}
LABELV $246
endproc CG_CheckLocalSounds 76 12
export CG_TransitionPlayerState
proc CG_TransitionPlayerState 24 12
line 494
;487:
;488:/*
;489:===============
;490:CG_TransitionPlayerState
;491:
;492:===============
;493:*/
;494:void CG_TransitionPlayerState( playerState_t *ps, playerState_t *ops ) {
line 496
;495:	// check for changing follow mode
;496:	if ( ps->clientNum != ops->clientNum ) {
ADDRLP4 0
CNSTI4 140
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
EQI4 $413
line 497
;497:		cg.thisFrameTeleport = qtrue;
ADDRGP4 cg+107592
CNSTI4 1
ASGNI4
line 499
;498:		// make sure we don't get any unwanted transition effects
;499:		*ops = *ps;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 468
line 500
;500:	}
LABELV $413
line 503
;501:
;502:	// damage events (player is getting wounded)
;503:	if ( ps->damageEvent != ops->damageEvent && ps->damageCount ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 168
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
EQI4 $416
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $416
line 504
;504:		CG_DamageFeedback( ps->damageYaw, ps->damagePitch, ps->damageCount );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DamageFeedback
CALLV
pop
line 505
;505:	}
LABELV $416
line 508
;506:
;507:	// respawning
;508:	if ( ps->persistant[PERS_SPAWN_COUNT] != ops->persistant[PERS_SPAWN_COUNT] ) {
ADDRLP4 12
CNSTI4 264
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
EQI4 $418
line 509
;509:		CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 510
;510:	}
LABELV $418
line 512
;511:
;512:	if ( cg.mapRestart ) {
ADDRGP4 cg+107624
INDIRI4
CNSTI4 0
EQI4 $420
line 513
;513:		CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 514
;514:		cg.mapRestart = qfalse;
ADDRGP4 cg+107624
CNSTI4 0
ASGNI4
line 515
;515:	}
LABELV $420
line 517
;516:
;517:	if ( cg.snap->ps.pm_type != PM_INTERMISSION 
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
EQI4 $424
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
EQI4 $424
line 518
;518:		&& ps->persistant[PERS_TEAM] != TEAM_SPECTATOR ) {
line 519
;519:		CG_CheckLocalSounds( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CheckLocalSounds
CALLV
pop
line 520
;520:	}
LABELV $424
line 523
;521:
;522:	// check for going low on ammo
;523:	CG_CheckAmmo();
ADDRGP4 CG_CheckAmmo
CALLV
pop
line 526
;524:
;525:	// run events
;526:	CG_CheckPlayerstateEvents( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CheckPlayerstateEvents
CALLV
pop
line 529
;527:
;528:	// smooth the ducking viewheight change
;529:	if ( ps->viewheight != ops->viewheight ) {
ADDRLP4 16
CNSTI4 164
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
EQI4 $427
line 530
;530:		cg.duckChange = ps->viewheight - ops->viewheight;
ADDRLP4 20
CNSTI4 164
ASGNI4
ADDRGP4 cg+109136
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 531
;531:		cg.duckTime = cg.time;
ADDRGP4 cg+109140
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 532
;532:	}
LABELV $427
line 533
;533:}
LABELV $412
endproc CG_TransitionPlayerState 24 12
import eventnames
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
LABELV $234
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
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
