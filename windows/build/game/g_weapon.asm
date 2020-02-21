export G_BounceProjectile
code
proc G_BounceProjectile 64 4
file "../../../code/game/g_weapon.c"
line 40
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
;23:// g_weapon.c
;24:// perform the server side effects of a weapon firing
;25:
;26:#include "g_local.h"
;27:
;28:static	float	s_quadFactor;
;29:static	vec3_t	forward, right, up;
;30:static	vec3_t	muzzle;
;31:
;32:#define NUM_NAILSHOTS g_ngcount.integer
;33:
;34:/*
;35:================
;36:G_BounceProjectile
;37:================
;38:*/
;39:void G_BounceProjectile( vec3_t start, vec3_t impact, vec3_t dir, vec3_t endout )
;40:{
line 44
;41:	vec3_t v, newv;
;42:	float dot;
;43:
;44:	VectorSubtract( impact, start, v );
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
CNSTI4 4
ASGNI4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
CNSTI4 8
ASGNI4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 45
;45:	dot = DotProduct( v, dir );
ADDRLP4 44
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 46
;46:	VectorMA( v, -2*dot, dir, newv );
ADDRLP4 48
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 52
CNSTF4 3221225472
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 24
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 48
;47:
;48:	VectorNormalize(newv);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 49
;49:	VectorMA(impact, 8192, newv, endout);
ADDRFP4 12
INDIRP4
ADDRFP4 4
INDIRP4
INDIRF4
CNSTF4 1174405120
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 56
CNSTI4 4
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
CNSTF4 1174405120
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 60
CNSTI4 8
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
CNSTF4 1174405120
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 50
;50:}
LABELV $60
endproc G_BounceProjectile 64 4
export Weapon_Gauntlet
proc Weapon_Gauntlet 0 0
line 62
;51:
;52:
;53:/*
;54:======================================================================
;55:
;56:GAUNTLET
;57:
;58:======================================================================
;59:*/
;60:
;61:void Weapon_Gauntlet( gentity_t *ent )
;62:{
line 64
;63:
;64:}
LABELV $71
endproc Weapon_Gauntlet 0 0
export CheckGauntletAttack
proc CheckGauntletAttack 104 32
line 72
;65:
;66:/*
;67:===============
;68:CheckGauntletAttack
;69:===============
;70:*/
;71:qboolean CheckGauntletAttack( gentity_t *ent )
;72:{
line 80
;73:	trace_t		tr;
;74:	vec3_t		end;
;75:	gentity_t	*tent;
;76:	gentity_t	*traceEnt;
;77:	int			damage;
;78:
;79:	// set aiming directions
;80:	AngleVectors (ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 82
;81:
;82:	CalcMuzzlePoint ( ent, forward, right, up, muzzle );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePoint
CALLV
pop
line 84
;83:
;84:	VectorMA (muzzle, g_grange.integer, forward, end);
ADDRLP4 60
ADDRGP4 muzzle
INDIRF4
ADDRGP4 forward
INDIRF4
ADDRGP4 g_grange+12
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRLP4 60+4
ADDRGP4 muzzle+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
ADDRGP4 g_grange+12
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRLP4 60+8
ADDRGP4 muzzle+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
ADDRGP4 g_grange+12
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 86
;85:
;86:	trap_Trace (&tr, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
ADDRLP4 4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 80
CNSTP4 0
ASGNP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 60
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 87
;87:	if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $82
line 88
;88:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $72
JUMPV
LABELV $82
line 91
;89:	}
;90:
;91:	if ( ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
CNSTI4 0
EQI4 $85
line 92
;92:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $72
JUMPV
LABELV $85
line 95
;93:	}
;94:
;95:	traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 0
CNSTI4 816
ADDRLP4 4+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 98
;96:
;97:	// send blood impact
;98:	if ( traceEnt->takedamage && traceEnt->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $88
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $88
line 99
;99:		tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
ADDRLP4 4+12
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 88
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 88
INDIRP4
ASGNP4
line 100
;100:		tent->s.otherEntityNum = traceEnt->s.number;
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 101
;101:		tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 4+24
ARGP4
ADDRLP4 92
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 92
INDIRI4
ASGNI4
line 102
;102:		tent->s.weapon = ent->s.weapon;
ADDRLP4 96
CNSTI4 192
ASGNI4
ADDRLP4 72
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 103
;103:	}
LABELV $88
line 105
;104:
;105:	if ( !traceEnt->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $92
line 106
;106:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $72
JUMPV
LABELV $92
line 109
;107:	}
;108:
;109:	if (ent->client->ps.powerups[PW_QUAD] ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 0
EQI4 $94
line 110
;110:		G_AddEvent( ent, EV_POWERUP_QUAD, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 61
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 111
;111:		s_quadFactor = g_quadfactor.value;
ADDRGP4 s_quadFactor
ADDRGP4 g_quadfactor+8
INDIRF4
ASGNF4
line 112
;112:	}
ADDRGP4 $95
JUMPV
LABELV $94
line 113
;113:	else {
line 114
;114:		s_quadFactor = 1;
ADDRGP4 s_quadFactor
CNSTF4 1065353216
ASGNF4
line 115
;115:	}
LABELV $95
line 116
;116:	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER ) {
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1176
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
EQU4 $97
ADDRLP4 96
ADDRLP4 88
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CVPU4 4
ADDRLP4 92
INDIRU4
EQU4 $97
ADDRLP4 96
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $97
line 117
;117:		s_quadFactor *= g_doublerdamagefactor.integer;
ADDRLP4 100
ADDRGP4 s_quadFactor
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRGP4 g_doublerdamagefactor+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 118
;118:	}
LABELV $97
line 120
;119:
;120:	if(g_instantgib.integer)
ADDRGP4 g_instantgib+12
INDIRI4
CNSTI4 0
EQI4 $100
line 121
;121:		damage = 500; //High damage in instant gib (normally enough to gib)
ADDRLP4 76
CNSTI4 500
ASGNI4
ADDRGP4 $101
JUMPV
LABELV $100
line 123
;122:	else
;123:		damage = g_gdamage.integer * s_quadFactor;
ADDRLP4 76
ADDRGP4 g_gdamage+12
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
LABELV $101
line 124
;124:	G_Damage( traceEnt, ent, ent, forward, tr.endpos,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 76
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 127
;125:	          damage, 0, MOD_GAUNTLET );
;126:
;127:	return qtrue;
CNSTI4 1
RETI4
LABELV $72
endproc CheckGauntletAttack 104 32
export SnapVectorTowards
proc SnapVectorTowards 12 0
line 179
;128:}
;129:
;130:
;131:/*
;132:======================================================================
;133:
;134:MACHINEGUN
;135:
;136:======================================================================
;137:*/
;138:
;139:/*
;140:======================
;141:SnapVectorTowards
;142:
;143:Round a vector to integers for more efficient network
;144:transmission, but make sure that it rounds towards a given point
;145:rather than blindly truncating.  This prevents it from truncating
;146:into a wall.
;147:======================
;148:*/
;149://unlagged - attack prediction #3
;150:// moved to q_shared.c
;151:/*
;152:void SnapVectorTowards( vec3_t v, vec3_t to ) {
;153:	int		i;
;154:
;155:	for ( i = 0 ; i < 3 ; i++ ) {
;156:		if ( to[i] <= v[i] ) {
;157:			v[i] = floor(v[i]);
;158:		} else {
;159:			v[i] = ceil(v[i]);
;160:		}
;161:	}
;162:}
;163:*/
;164://unlagged - attack prediction #3
;165:
;166://unlagged - attack prediction #3
;167:// moved from g_weapon.c
;168:/*
;169:======================
;170:SnapVectorTowards
;171:
;172:Round a vector to integers for more efficient network
;173:transmission, but make sure that it rounds towards a given point
;174:rather than blindly truncating.  This prevents it from truncating
;175:into a wall.
;176:======================
;177:*/
;178:void SnapVectorTowards( vec3_t v, vec3_t to )
;179:{
line 182
;180:	int		i;
;181:
;182:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $106
line 183
;183:		if ( to[i] <= v[i] ) {
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
GTF4 $110
line 184
;184:			v[i] = (int)v[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
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
line 185
;185:		}
ADDRGP4 $111
JUMPV
LABELV $110
line 186
;186:		else {
line 187
;187:			v[i] = (int)v[i] + 1;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 1
ADDI4
CVIF4 4
ASGNF4
line 188
;188:		}
LABELV $111
line 189
;189:	}
LABELV $107
line 182
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $106
line 190
;190:}
LABELV $105
endproc SnapVectorTowards 12 0
export Bullet_Fire
proc Bullet_Fire 176 32
line 200
;191://unlagged - attack prediction #3
;192:
;193:#define CHAINGUN_SPREAD		600.0
;194:#define	CHAINGUN_DAMAGE		g_cgdamage.integer
;195:#define MACHINEGUN_SPREAD	200
;196:#define	MACHINEGUN_DAMAGE	g_mgdamage.integer
;197:#define	MACHINEGUN_TEAM_DAMAGE	g_mgdamage.integer		// wimpier MG in teamplay
;198:
;199:void Bullet_Fire (gentity_t *ent, float spread, int damage )
;200:{
line 212
;201:	trace_t		tr;
;202:	vec3_t		end;
;203:	vec3_t		impactpoint, bouncedir;
;204:	float		r;
;205:	float		u;
;206:	gentity_t	*tent;
;207:	gentity_t	*traceEnt;
;208:	int			i, passent;
;209:
;210://unlagged - attack prediction #2
;211:	// we have to use something now that the client knows in advance
;212:	int			seed = ent->client->attackTime % 256;
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1264
ADDP4
INDIRI4
CNSTI4 256
MODI4
ASGNI4
line 215
;213://unlagged - attack prediction #2
;214:
;215:	damage *= s_quadFactor;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 224
;216:
;217://unlagged - attack prediction #2
;218:	// this has to match what's on the client
;219:	/*
;220:		r = random() * M_PI * 2.0f;
;221:		u = sin(r) * crandom() * spread * 16;
;222:		r = cos(r) * crandom() * spread * 16;
;223:	*/
;224:	r = Q_random(&seed) * M_PI * 2.0f;
ADDRLP4 104
ARGP4
ADDRLP4 120
ADDRGP4 Q_random
CALLF4
ASGNF4
ADDRLP4 84
CNSTF4 1073741824
CNSTF4 1078530011
ADDRLP4 120
INDIRF4
MULF4
MULF4
ASGNF4
line 225
;225:	u = sin(r) * Q_crandom(&seed) * spread * 16;
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 124
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 104
ARGP4
ADDRLP4 128
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 100
CNSTF4 1098907648
ADDRLP4 124
INDIRF4
ADDRLP4 128
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
MULF4
ASGNF4
line 226
;226:	r = cos(r) * Q_crandom(&seed) * spread * 16;
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 132
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 104
ARGP4
ADDRLP4 136
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 84
CNSTF4 1098907648
ADDRLP4 132
INDIRF4
ADDRLP4 136
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
MULF4
ASGNF4
line 229
;227://unlagged - attack prediction #2
;228:
;229:	VectorMA (muzzle, 8192*16, forward, end);
ADDRLP4 140
CNSTF4 1207959552
ASGNF4
ADDRLP4 64
ADDRGP4 muzzle
INDIRF4
ADDRLP4 140
INDIRF4
ADDRGP4 forward
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRGP4 muzzle+4
INDIRF4
ADDRLP4 140
INDIRF4
ADDRGP4 forward+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRGP4 muzzle+8
INDIRF4
CNSTF4 1207959552
ADDRGP4 forward+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 230
;230:	VectorMA (end, r, right, end);
ADDRLP4 64
ADDRLP4 64
INDIRF4
ADDRGP4 right
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 64+4
INDIRF4
ADDRGP4 right+4
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 64+8
INDIRF4
ADDRGP4 right+8
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
line 231
;231:	VectorMA (end, u, up, end);
ADDRLP4 64
ADDRLP4 64
INDIRF4
ADDRGP4 up
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 64+4
INDIRF4
ADDRGP4 up+4
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 64+8
INDIRF4
ADDRGP4 up+8
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ADDF4
ASGNF4
line 233
;232:
;233:	passent = ent->s.number;
ADDRLP4 80
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 234
;234:	for (i = 0; i < 10; i++) {
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $131
line 238
;235:
;236://unlagged - backward reconciliation #2
;237:		// backward-reconcile the other clients
;238:		G_DoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 241
;239://unlagged - backward reconciliation #2
;240:
;241:		trap_Trace (&tr, muzzle, NULL, NULL, end, passent, MASK_SHOT);
ADDRLP4 4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 152
CNSTP4 0
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 80
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 245
;242:
;243://unlagged - backward reconciliation #2
;244:		// put them back
;245:		G_UndoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 248
;246://unlagged - backward reconciliation #2
;247:
;248:		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $135
line 249
;249:			return;
ADDRGP4 $112
JUMPV
LABELV $135
line 252
;250:		}
;251:
;252:		traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 0
CNSTI4 816
ADDRLP4 4+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 255
;253:
;254:		// snap the endpos to integers, but nudged towards the line
;255:		SnapVectorTowards( tr.endpos, muzzle );
ADDRLP4 4+12
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 258
;256:
;257:		// send bullet impact
;258:		if ( traceEnt->takedamage && traceEnt->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $140
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $140
line 259
;259:			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_FLESH );
ADDRLP4 4+12
ARGP4
CNSTI4 48
ARGI4
ADDRLP4 160
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 160
INDIRP4
ASGNP4
line 260
;260:			tent->s.eventParm = traceEnt->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 264
;261://unlagged - attack prediction #2
;262:			// we need the client number to determine whether or not to
;263:			// suppress this event
;264:			tent->s.clientNum = ent->s.clientNum;
ADDRLP4 164
CNSTI4 168
ASGNI4
ADDRLP4 60
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 266
;265://unlagged - attack prediction #2
;266:			if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $141
line 267
;267:				ent->client->accuracy_hits++;
ADDRLP4 172
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1120
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 268
;268:			}
line 269
;269:		}
ADDRGP4 $141
JUMPV
LABELV $140
line 270
;270:		else {
line 271
;271:			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_WALL );
ADDRLP4 4+12
ARGP4
CNSTI4 49
ARGI4
ADDRLP4 160
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 160
INDIRP4
ASGNP4
line 272
;272:			tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 4+24
ARGP4
ADDRLP4 164
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 164
INDIRI4
ASGNI4
line 276
;273://unlagged - attack prediction #2
;274:			// we need the client number to determine whether or not to
;275:			// suppress this event
;276:			tent->s.clientNum = ent->s.clientNum;
ADDRLP4 168
CNSTI4 168
ASGNI4
ADDRLP4 60
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 278
;277://unlagged - attack prediction #2
;278:		}
LABELV $141
line 279
;279:		tent->s.otherEntityNum = ent->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 281
;280:
;281:		if ( traceEnt->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $133
line 282
;282:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
ADDRLP4 160
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $149
ADDRLP4 160
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $149
line 283
;283:				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 164
ADDRGP4 G_InvulnerabilityEffect
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $152
line 284
;284:					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
ADDRGP4 muzzle
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 G_BounceProjectile
CALLV
pop
line 285
;285:					VectorCopy( impactpoint, muzzle );
ADDRGP4 muzzle
ADDRLP4 88
INDIRB
ASGNB 12
line 287
;286:					// the player can hit him/herself with the bounced rail
;287:					passent = ENTITYNUM_NONE;
ADDRLP4 80
CNSTI4 1023
ASGNI4
line 288
;288:				}
ADDRGP4 $132
JUMPV
LABELV $152
line 289
;289:				else {
line 290
;290:					VectorCopy( tr.endpos, muzzle );
ADDRGP4 muzzle
ADDRLP4 4+12
INDIRB
ASGNB 12
line 291
;291:					passent = traceEnt->s.number;
ADDRLP4 80
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 292
;292:				}
line 293
;293:				continue;
ADDRGP4 $132
JUMPV
LABELV $149
line 295
;294:			}
;295:			else {
line 296
;296:				if(spread == CHAINGUN_SPREAD) {
ADDRFP4 4
INDIRF4
CNSTF4 1142292480
NEF4 $156
line 297
;297:					G_Damage( traceEnt, ent, ent, forward, tr.endpos,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 299
;298:					          damage, 0, MOD_CHAINGUN);
;299:					ent->client->accuracy[WP_CHAINGUN][1]++;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2112
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 300
;300:				}
ADDRGP4 $133
JUMPV
LABELV $156
line 301
;301:				else {
line 302
;302:					G_Damage( traceEnt, ent, ent, forward, tr.endpos,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 304
;303:					          damage, 0, MOD_MACHINEGUN);
;304:					ent->client->accuracy[WP_MACHINEGUN][1]++;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2024
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 305
;305:				}
line 306
;306:			}
line 307
;307:		}
line 308
;308:		break;
ADDRGP4 $133
JUMPV
LABELV $132
line 234
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 10
LTI4 $131
LABELV $133
line 310
;309:	}
;310:}
LABELV $112
endproc Bullet_Fire 176 32
export BFG_Fire
proc BFG_Fire 16 12
line 322
;311:
;312:
;313:/*
;314:======================================================================
;315:
;316:BFG
;317:
;318:======================================================================
;319:*/
;320:
;321:void BFG_Fire ( gentity_t *ent )
;322:{
line 325
;323:	gentity_t	*m;
;324:
;325:	m = fire_bfg (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4
ADDRGP4 fire_bfg
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 326
;326:	m->damage *= s_quadFactor;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 327
;327:	m->splashDamage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 330
;328:
;329://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;330:}
LABELV $160
endproc BFG_Fire 16 12
export ShotgunPellet
proc ShotgunPellet 140 32
line 346
;331:
;332:
;333:/*
;334:======================================================================
;335:
;336:SHOTGUN
;337:
;338:======================================================================
;339:*/
;340:
;341:// DEFAULT_SHOTGUN_SPREAD and DEFAULT_SHOTGUN_COUNT	are in bg_public.h, because
;342:// client predicts same spreads
;343:#define	DEFAULT_SHOTGUN_DAMAGE	g_sgdamage.integer
;344:
;345:qboolean ShotgunPellet( vec3_t start, vec3_t end, gentity_t *ent )
;346:{
line 352
;347:	trace_t		tr;
;348:	int			damage, i, passent;
;349:	gentity_t	*traceEnt;
;350:	vec3_t		impactpoint, bouncedir;
;351:	vec3_t		tr_start, tr_end;
;352:	qboolean	hitClient = qfalse;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 354
;353:
;354:	passent = ent->s.number;
ADDRLP4 76
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 355
;355:	VectorCopy( start, tr_start );
ADDRLP4 64
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 356
;356:	VectorCopy( end, tr_end );
ADDRLP4 80
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 357
;357:	for (i = 0; i < 10; i++) {
ADDRLP4 60
CNSTI4 0
ASGNI4
LABELV $162
line 358
;358:		trap_Trace (&tr, tr_start, NULL, NULL, tr_end, passent, MASK_SHOT);
ADDRLP4 4
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 124
CNSTP4 0
ASGNP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 76
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 359
;359:		traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 0
CNSTI4 816
ADDRLP4 4+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 362
;360:
;361:		// send bullet impact
;362:		if (  tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $167
line 363
;363:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $167
line 366
;364:		}
;365:
;366:		if ( traceEnt->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $170
line 367
;367:			damage = DEFAULT_SHOTGUN_DAMAGE * s_quadFactor;
ADDRLP4 92
ADDRGP4 g_sgdamage+12
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 368
;368:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $173
ADDRLP4 128
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $173
line 369
;369:				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 100
ARGP4
ADDRLP4 112
ARGP4
ADDRLP4 132
ADDRGP4 G_InvulnerabilityEffect
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $176
line 370
;370:					G_BounceProjectile( tr_start, impactpoint, bouncedir, tr_end );
ADDRLP4 64
ARGP4
ADDRLP4 100
ARGP4
ADDRLP4 112
ARGP4
ADDRLP4 80
ARGP4
ADDRGP4 G_BounceProjectile
CALLV
pop
line 371
;371:					VectorCopy( impactpoint, tr_start );
ADDRLP4 64
ADDRLP4 100
INDIRB
ASGNB 12
line 373
;372:					// the player can hit him/herself with the bounced rail
;373:					passent = ENTITYNUM_NONE;
ADDRLP4 76
CNSTI4 1023
ASGNI4
line 374
;374:				}
ADDRGP4 $163
JUMPV
LABELV $176
line 375
;375:				else {
line 376
;376:					VectorCopy( tr.endpos, tr_start );
ADDRLP4 64
ADDRLP4 4+12
INDIRB
ASGNB 12
line 377
;377:					passent = traceEnt->s.number;
ADDRLP4 76
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 378
;378:				}
line 379
;379:				continue;
ADDRGP4 $163
JUMPV
LABELV $173
line 381
;380:			}
;381:			if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $180
line 382
;382:				hitClient = qtrue;
ADDRLP4 96
CNSTI4 1
ASGNI4
line 383
;383:			}
LABELV $180
line 384
;384:			G_Damage( traceEnt, ent, ent, forward, tr.endpos, damage, 0, MOD_SHOTGUN);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 92
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 385
;385:			return hitClient;
ADDRLP4 96
INDIRI4
RETI4
ADDRGP4 $161
JUMPV
LABELV $170
line 387
;386:		}
;387:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $163
line 357
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 10
LTI4 $162
line 389
;388:	}
;389:	return qfalse;
CNSTI4 0
RETI4
LABELV $161
endproc ShotgunPellet 140 32
export ShotgunPattern
proc ShotgunPattern 100 12
line 394
;390:}
;391:
;392:// this should match CG_ShotgunPattern
;393:void ShotgunPattern( vec3_t origin, vec3_t origin2, int seed, gentity_t *ent )
;394:{
line 399
;395:	int			i;
;396:	float		r, u;
;397:	vec3_t		end;
;398:	vec3_t		forward, right, up;
;399:	qboolean	hitClient = qfalse;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 408
;400:
;401://unlagged - attack prediction #2
;402:	// use this for testing
;403:	//Com_Printf( "Server seed: %d\n", seed );
;404://unlagged - attack prediction #2
;405:
;406:	// derive the right and up vectors from the forward vector, because
;407:	// the client won't have any other information
;408:	VectorNormalize2( origin2, forward );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 409
;409:	PerpendicularVector( right, forward );
ADDRLP4 32
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 410
;410:	CrossProduct( forward, right, up );
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 415
;411:
;412:
;413://unlagged - backward reconciliation #2
;414:	// backward-reconcile the other clients
;415:	G_DoTimeShiftFor( ent );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 419
;416://unlagged - backward reconciliation #2
;417:
;418:	// generate the "random" spread pattern
;419:	for ( i = 0 ; i < mod_sgcount ; i++ ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 $187
JUMPV
LABELV $184
line 420
;420:		r = Q_crandom( &seed ) * mod_sgspread * 16;
ADDRFP4 8
ARGP4
ADDRLP4 64
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 12
CNSTF4 1098907648
ADDRLP4 64
INDIRF4
ADDRGP4 mod_sgspread
INDIRI4
CVIF4 4
MULF4
MULF4
ASGNF4
line 421
;421:		u = Q_crandom( &seed ) * mod_sgspread * 16;
ADDRFP4 8
ARGP4
ADDRLP4 68
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 16
CNSTF4 1098907648
ADDRLP4 68
INDIRF4
ADDRGP4 mod_sgspread
INDIRI4
CVIF4 4
MULF4
MULF4
ASGNF4
line 422
;422:		VectorMA( origin, 8192 * 16, forward, end);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
CNSTF4 1207959552
ASGNF4
ADDRLP4 0
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 76
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 76
INDIRF4
ADDRLP4 20+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1207959552
ADDRLP4 20+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 423
;423:		VectorMA (end, r, right, end);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 32+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 32+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 424
;424:		VectorMA (end, u, up, end);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44+4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 44+8
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 425
;425:		if( ShotgunPellet( origin, end, ent ) && !hitClient ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 ShotgunPellet
CALLI4
ASGNI4
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 92
INDIRI4
EQI4 $204
ADDRLP4 60
INDIRI4
ADDRLP4 92
INDIRI4
NEI4 $204
line 426
;426:			hitClient = qtrue;
ADDRLP4 60
CNSTI4 1
ASGNI4
line 427
;427:			ent->client->accuracy_hits++;
ADDRLP4 96
ADDRFP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1120
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 428
;428:		}
LABELV $204
line 429
;429:	}
LABELV $185
line 419
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $187
ADDRLP4 56
INDIRI4
ADDRGP4 mod_sgcount
INDIRI4
LTI4 $184
line 430
;430:	if( hitClient )
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $206
line 431
;431:		ent->client->accuracy[WP_SHOTGUN][1]++;
ADDRLP4 64
ADDRFP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2032
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $206
line 435
;432:
;433://unlagged - backward reconciliation #2
;434:	// put them back
;435:	G_UndoTimeShiftFor( ent );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 437
;436://unlagged - backward reconciliation #2
;437:}
LABELV $183
endproc ShotgunPattern 100 12
export weapon_supershotgun_fire
proc weapon_supershotgun_fire 20 16
line 441
;438:
;439:
;440:void weapon_supershotgun_fire (gentity_t *ent)
;441:{
line 445
;442:	gentity_t		*tent;
;443:
;444:	// send shotgun blast
;445:	tent = G_TempEntity( muzzle, EV_SHOTGUN );
ADDRGP4 muzzle
ARGP4
CNSTI4 54
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 446
;446:	VectorScale( forward, 4096, tent->s.origin2 );
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
CNSTF4 1166016512
ADDRGP4 forward
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1166016512
ADDRGP4 forward+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1166016512
ADDRGP4 forward+8
INDIRF4
MULF4
ASGNF4
line 447
;447:	SnapVector( tent->s.origin2 );
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 104
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
CNSTI4 108
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
CNSTI4 112
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
line 452
;448://Sago: This sound like a bad idea...
;449://unlagged - attack prediction #2
;450:	// this has to be something the client can predict now
;451:	//tent->s.eventParm = rand() & 255;		// seed for spread pattern
;452:	tent->s.eventParm = ent->client->attackTime % 256; // seed for spread pattern
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1264
ADDP4
INDIRI4
CNSTI4 256
MODI4
ASGNI4
line 454
;453://unlagged - attack prediction #2
;454:	tent->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 456
;455:
;456:	ShotgunPattern( tent->s.pos.trBase, tent->s.origin2, tent->s.eventParm, ent );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ShotgunPattern
CALLV
pop
line 457
;457:}
LABELV $208
endproc weapon_supershotgun_fire 20 16
export weapon_grenadelauncher_fire
proc weapon_grenadelauncher_fire 20 12
line 469
;458:
;459:
;460:/*
;461:======================================================================
;462:
;463:GRENADE LAUNCHER
;464:
;465:======================================================================
;466:*/
;467:
;468:void weapon_grenadelauncher_fire (gentity_t *ent)
;469:{
line 473
;470:	gentity_t	*m;
;471:
;472:	// extra vertical velocity
;473:	forward[2] += 0.2f;
ADDRLP4 4
ADDRGP4 forward+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 474
;474:	VectorNormalize( forward );
ADDRGP4 forward
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 476
;475:
;476:	m = fire_grenade (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8
ADDRGP4 fire_grenade
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 477
;477:	m->damage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 478
;478:	m->splashDamage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 481
;479:
;480://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;481:}
LABELV $211
endproc weapon_grenadelauncher_fire 20 12
export Weapon_RocketLauncher_Fire
proc Weapon_RocketLauncher_Fire 16 12
line 492
;482:
;483:/*
;484:======================================================================
;485:
;486:ROCKET
;487:
;488:======================================================================
;489:*/
;490:
;491:void Weapon_RocketLauncher_Fire (gentity_t *ent)
;492:{
line 495
;493:	gentity_t	*m;
;494:
;495:	m = fire_rocket (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4
ADDRGP4 fire_rocket
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 496
;496:	m->damage *= s_quadFactor;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 497
;497:	m->splashDamage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 500
;498:
;499://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;500:}
LABELV $213
endproc Weapon_RocketLauncher_Fire 16 12
export Weapon_Plasmagun_Fire
proc Weapon_Plasmagun_Fire 16 12
line 512
;501:
;502:
;503:/*
;504:======================================================================
;505:
;506:PLASMA GUN
;507:
;508:======================================================================
;509:*/
;510:
;511:void Weapon_Plasmagun_Fire (gentity_t *ent)
;512:{
line 515
;513:	gentity_t	*m;
;514:
;515:	m = fire_plasma (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4
ADDRGP4 fire_plasma
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 516
;516:	m->damage *= s_quadFactor;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 517
;517:	m->splashDamage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 520
;518:
;519://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;520:}
LABELV $214
endproc Weapon_Plasmagun_Fire 16 12
export weapon_railgun_fire
proc weapon_railgun_fire 200 32
line 538
;521:
;522:/*
;523:======================================================================
;524:
;525:RAILGUN
;526:
;527:======================================================================
;528:*/
;529:
;530:
;531:/*
;532:=================
;533:weapon_railgun_fire
;534:=================
;535:*/
;536:#define	MAX_RAIL_HITS	4
;537:void weapon_railgun_fire (gentity_t *ent)
;538:{
line 551
;539:	vec3_t		end;
;540:	vec3_t impactpoint, bouncedir;
;541:	trace_t		trace;
;542:	gentity_t	*tent;
;543:	gentity_t	*traceEnt;
;544:	int			damage;
;545:	int			i;
;546:	int			hits;
;547:	int			unlinked;
;548:	int			passent;
;549:	gentity_t	*unlinkedEntities[MAX_RAIL_HITS];
;550:
;551:	damage = g_rgdamage.integer * s_quadFactor;
ADDRLP4 116
ADDRGP4 g_rgdamage+12
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 552
;552:	if(g_instantgib.integer)
ADDRGP4 g_instantgib+12
INDIRI4
CNSTI4 0
EQI4 $217
line 553
;553:		damage = 800;
ADDRLP4 116
CNSTI4 800
ASGNI4
LABELV $217
line 555
;554:
;555:	VectorMA (muzzle, 8192, forward, end);
ADDRLP4 136
CNSTF4 1174405120
ASGNF4
ADDRLP4 88
ADDRGP4 muzzle
INDIRF4
ADDRLP4 136
INDIRF4
ADDRGP4 forward
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88+4
ADDRGP4 muzzle+4
INDIRF4
ADDRLP4 136
INDIRF4
ADDRGP4 forward+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88+8
ADDRGP4 muzzle+8
INDIRF4
CNSTF4 1174405120
ADDRGP4 forward+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 559
;556:
;557://unlagged - backward reconciliation #2
;558:	// backward-reconcile the other clients
;559:	G_DoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 563
;560://unlagged - backward reconciliation #2
;561:
;562:	// trace only against the solids, so the railgun will go through people
;563:	unlinked = 0;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 564
;564:	hits = 0;
ADDRLP4 132
CNSTI4 0
ASGNI4
line 565
;565:	passent = ent->s.number;
ADDRLP4 100
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
LABELV $226
line 566
;566:	do {
line 567
;567:		trap_Trace (&trace, muzzle, NULL, NULL, end, passent, MASK_SHOT );
ADDRLP4 4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 140
CNSTP4 0
ASGNP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 100
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 568
;568:		if ( trace.entityNum >= ENTITYNUM_MAX_NORMAL ) {
ADDRLP4 4+52
INDIRI4
CNSTI4 1022
LTI4 $229
line 569
;569:			break;
ADDRGP4 $228
JUMPV
LABELV $229
line 571
;570:		}
;571:		traceEnt = &g_entities[ trace.entityNum ];
ADDRLP4 0
CNSTI4 816
ADDRLP4 4+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 572
;572:		if ( traceEnt->takedamage ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $233
line 573
;573:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
ADDRLP4 144
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $235
ADDRLP4 144
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $235
line 574
;574:				if ( G_InvulnerabilityEffect( traceEnt, forward, trace.endpos, impactpoint, bouncedir ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 148
ADDRGP4 G_InvulnerabilityEffect
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $236
line 575
;575:					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
ADDRGP4 muzzle
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 88
ARGP4
ADDRGP4 G_BounceProjectile
CALLV
pop
line 577
;576:					// snap the endpos to integers to save net bandwidth, but nudged towards the line
;577:					SnapVectorTowards( trace.endpos, muzzle );
ADDRLP4 4+12
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 579
;578:					// send railgun beam effect
;579:					tent = G_TempEntity( trace.endpos, EV_RAILTRAIL );
ADDRLP4 4+12
ARGP4
CNSTI4 53
ARGI4
ADDRLP4 152
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 152
INDIRP4
ASGNP4
line 581
;580:					// set player number for custom colors on the railtrail
;581:					tent->s.clientNum = ent->s.clientNum;
ADDRLP4 156
CNSTI4 168
ASGNI4
ADDRLP4 64
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 582
;582:					VectorCopy( muzzle, tent->s.origin2 );
ADDRLP4 64
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 muzzle
INDIRB
ASGNB 12
line 584
;583:					// move origin a bit to come closer to the drawn gun muzzle
;584:					VectorMA( tent->s.origin2, 4, right, tent->s.origin2 );
ADDRLP4 160
ADDRLP4 64
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 right
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 164
ADDRLP4 64
INDIRP4
CNSTI4 108
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 right+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 168
ADDRLP4 64
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 right+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 585
;585:					VectorMA( tent->s.origin2, -1, up, tent->s.origin2 );
ADDRLP4 172
ADDRLP4 64
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRF4
CNSTF4 3212836864
ADDRGP4 up
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 176
ADDRLP4 64
INDIRP4
CNSTI4 108
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRF4
CNSTF4 3212836864
ADDRGP4 up+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 180
ADDRLP4 64
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 180
INDIRP4
INDIRF4
CNSTF4 3212836864
ADDRGP4 up+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 586
;586:					tent->s.eventParm = 255;	// don't make the explosion at the end
ADDRLP4 64
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 255
ASGNI4
line 588
;587:					//
;588:					VectorCopy( impactpoint, muzzle );
ADDRGP4 muzzle
ADDRLP4 104
INDIRB
ASGNB 12
line 590
;589:					// the player can hit him/herself with the bounced rail
;590:					passent = ENTITYNUM_NONE;
ADDRLP4 100
CNSTI4 1023
ASGNI4
line 591
;591:				}
line 592
;592:			}
ADDRGP4 $236
JUMPV
LABELV $235
line 593
;593:			else {
line 594
;594:				if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $247
line 595
;595:					hits++;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 596
;596:				}
LABELV $247
line 597
;597:				G_Damage (traceEnt, ent, ent, forward, trace.endpos, damage, 0, MOD_RAILGUN);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 598
;598:			}
LABELV $236
line 599
;599:		}
LABELV $233
line 600
;600:		if ( trace.contents & CONTENTS_SOLID ) {
ADDRLP4 4+48
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $250
line 601
;601:			break;		// we hit something solid enough to stop the beam
ADDRGP4 $228
JUMPV
LABELV $250
line 604
;602:		}
;603:		// unlink this entity, so the next trace will go past it
;604:		trap_UnlinkEntity( traceEnt );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 605
;605:		unlinkedEntities[unlinked] = traceEnt;
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 606
;606:		unlinked++;
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 607
;607:	}
LABELV $227
line 608
;608:	while ( unlinked < MAX_RAIL_HITS );
ADDRLP4 60
INDIRI4
CNSTI4 4
LTI4 $226
LABELV $228
line 612
;609:
;610://unlagged - backward reconciliation #2
;611:	// put them back
;612:	G_UndoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 616
;613://unlagged - backward reconciliation #2
;614:
;615:	// link back in any entities we unlinked
;616:	for ( i = 0 ; i < unlinked ; i++ ) {
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $256
JUMPV
LABELV $253
line 617
;617:		trap_LinkEntity( unlinkedEntities[i] );
ADDRLP4 68
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 618
;618:	}
LABELV $254
line 616
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $256
ADDRLP4 68
INDIRI4
ADDRLP4 60
INDIRI4
LTI4 $253
line 623
;619:
;620:	// the final trace endpos will be the terminal point of the rail trail
;621:
;622:	// snap the endpos to integers to save net bandwidth, but nudged towards the line
;623:	SnapVectorTowards( trace.endpos, muzzle );
ADDRLP4 4+12
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 626
;624:
;625:	// send railgun beam effect
;626:	tent = G_TempEntity( trace.endpos, EV_RAILTRAIL );
ADDRLP4 4+12
ARGP4
CNSTI4 53
ARGI4
ADDRLP4 140
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 140
INDIRP4
ASGNP4
line 629
;627:
;628:	// set player number for custom colors on the railtrail
;629:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 144
CNSTI4 168
ASGNI4
ADDRLP4 64
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 631
;630:
;631:	VectorCopy( muzzle, tent->s.origin2 );
ADDRLP4 64
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 muzzle
INDIRB
ASGNB 12
line 633
;632:	// move origin a bit to come closer to the drawn gun muzzle
;633:	VectorMA( tent->s.origin2, 4, right, tent->s.origin2 );
ADDRLP4 148
ADDRLP4 64
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 right
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 152
ADDRLP4 64
INDIRP4
CNSTI4 108
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 right+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 156
ADDRLP4 64
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 right+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 634
;634:	VectorMA( tent->s.origin2, -1, up, tent->s.origin2 );
ADDRLP4 160
ADDRLP4 64
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRF4
CNSTF4 3212836864
ADDRGP4 up
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 164
ADDRLP4 64
INDIRP4
CNSTI4 108
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRF4
CNSTF4 3212836864
ADDRGP4 up+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 168
ADDRLP4 64
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRF4
CNSTF4 3212836864
ADDRGP4 up+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 637
;635:
;636:	// no explosion at end if SURF_NOIMPACT, but still make the trail
;637:	if ( trace.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $263
line 638
;638:		tent->s.eventParm = 255;	// don't make the explosion at the end
ADDRLP4 64
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 255
ASGNI4
line 639
;639:	}
ADDRGP4 $264
JUMPV
LABELV $263
line 640
;640:	else {
line 641
;641:		tent->s.eventParm = DirToByte( trace.plane.normal );
ADDRLP4 4+24
ARGP4
ADDRLP4 172
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 172
INDIRI4
ASGNI4
line 642
;642:	}
LABELV $264
line 643
;643:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 172
CNSTI4 168
ASGNI4
ADDRLP4 64
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 646
;644:
;645:	// give the shooter a reward sound if they have made two railgun hits in a row
;646:	if ( hits == 0 ) {
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $267
line 648
;647:		// complete miss
;648:		ent->client->accurateCount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1112
ADDP4
CNSTI4 0
ASGNI4
line 649
;649:	}
ADDRGP4 $268
JUMPV
LABELV $267
line 650
;650:	else {
line 652
;651:		// check for "impressive" reward sound
;652:		ent->client->accurateCount += hits;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1112
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
ADDRLP4 132
INDIRI4
ADDI4
ASGNI4
line 653
;653:		if ( ent->client->accurateCount >= 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
CNSTI4 2
LTI4 $269
line 654
;654:			ent->client->accurateCount -= 2;
ADDRLP4 180
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1112
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 180
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 655
;655:			ent->client->ps.persistant[PERS_IMPRESSIVE_COUNT]++;
ADDRLP4 184
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 284
ADDP4
ASGNP4
ADDRLP4 184
INDIRP4
ADDRLP4 184
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 656
;656:			G_LogPrintf( "Award: %i %i: %s gained the %s award!\n", ent->client->ps.clientNum, 2, ent->client->pers.netname, "IMPRESSIVE" );
ADDRGP4 $271
ARGP4
ADDRLP4 188
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 188
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 $272
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 657
;657:			if(!level.hadBots) //There has not been any bots
ADDRGP4 level+9436
INDIRI4
CNSTI4 0
NEI4 $273
line 658
;658:				ChallengeMessage(ent,AWARD_IMPRESSIVE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 301
ARGI4
ADDRGP4 ChallengeMessage
CALLV
pop
LABELV $273
line 660
;659:			// add the sprite over the player's head
;660:			ent->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 192
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 661
;661:			ent->client->ps.eFlags |= EF_AWARD_IMPRESSIVE;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 662
;662:			ent->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1148
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 663
;663:		}
LABELV $269
line 664
;664:		ent->client->accuracy_hits++;
ADDRLP4 180
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1120
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 180
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 665
;665:		ent->client->accuracy[WP_RAILGUN][1]++;
ADDRLP4 184
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2064
ADDP4
ASGNP4
ADDRLP4 184
INDIRP4
ADDRLP4 184
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 666
;666:	}
LABELV $268
line 668
;667:
;668:}
LABELV $215
endproc weapon_railgun_fire 200 32
export Weapon_GrapplingHook_Fire
proc Weapon_GrapplingHook_Fire 4 12
line 680
;669:
;670:
;671:/*
;672:======================================================================
;673:
;674:GRAPPLING HOOK
;675:
;676:======================================================================
;677:*/
;678:
;679:void Weapon_GrapplingHook_Fire (gentity_t *ent)
;680:{
line 681
;681:	if (!ent->client->fireHeld && !ent->client->hook)
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1160
ADDP4
INDIRI4
CNSTI4 0
NEI4 $278
ADDRLP4 0
INDIRP4
CNSTI4 1164
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $278
line 682
;682:		fire_grapple (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 fire_grapple
CALLP4
pop
LABELV $278
line 684
;683:
;684:	ent->client->fireHeld = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1160
ADDP4
CNSTI4 1
ASGNI4
line 685
;685:}
LABELV $277
endproc Weapon_GrapplingHook_Fire 4 12
export Weapon_HookFree
proc Weapon_HookFree 4 4
line 688
;686:
;687:void Weapon_HookFree (gentity_t *ent)
;688:{
line 689
;689:	ent->parent->client->hook = NULL;
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
line 690
;690:	ent->parent->client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
ADDRLP4 0
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
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 691
;691:	G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 692
;692:}
LABELV $280
endproc Weapon_HookFree 4 4
export Weapon_HookThink
proc Weapon_HookThink 36 8
line 695
;693:
;694:void Weapon_HookThink (gentity_t *ent)
;695:{
line 696
;696:	if (ent->enemy) {
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $282
line 699
;697:		vec3_t v, oldorigin;
;698:
;699:		VectorCopy(ent->r.currentOrigin, oldorigin);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 700
;700:		v[0] = ent->enemy->r.currentOrigin[0] + (ent->enemy->r.mins[0] + ent->enemy->r.maxs[0]) * 0.5;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 24
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 701
;701:		v[1] = ent->enemy->r.currentOrigin[1] + (ent->enemy->r.mins[1] + ent->enemy->r.maxs[1]) * 0.5;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 28
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 702
;702:		v[2] = ent->enemy->r.currentOrigin[2] + (ent->enemy->r.mins[2] + ent->enemy->r.maxs[2]) * 0.5;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 32
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 32
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 703
;703:		SnapVectorTowards( v, oldorigin );	// save net bandwidth
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 705
;704:
;705:		G_SetOrigin( ent, v );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 706
;706:	}
LABELV $282
line 708
;707:
;708:	VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 709
;709:}
LABELV $281
endproc Weapon_HookThink 36 8
export Weapon_LightningFire
proc Weapon_LightningFire 136 32
line 720
;710:
;711:/*
;712:======================================================================
;713:
;714:LIGHTNING GUN
;715:
;716:======================================================================
;717:*/
;718:
;719:void Weapon_LightningFire( gentity_t *ent )
;720:{
line 727
;721:	trace_t		tr;
;722:	vec3_t		end;
;723:	vec3_t impactpoint, bouncedir;
;724:	gentity_t	*traceEnt, *tent;
;725:	int			damage, i, passent;
;726:
;727:	damage = g_lgdamage.integer * s_quadFactor;
ADDRLP4 96
ADDRGP4 g_lgdamage+12
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 729
;728:
;729:	passent = ent->s.number;
ADDRLP4 80
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 730
;730:	for (i = 0; i < 10; i++) {
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $288
line 731
;731:		VectorMA( muzzle, mod_lgrange, forward, end );
ADDRLP4 112
ADDRGP4 mod_lgrange
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 0
ADDRGP4 muzzle
INDIRF4
ADDRGP4 forward
INDIRF4
ADDRLP4 112
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 muzzle+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
ADDRLP4 112
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 muzzle+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
ADDRGP4 mod_lgrange
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 736
;732:
;733://Sago: I'm not sure this should recieve backward reconciliation. It is not a real instant hit weapon, it can normally be dogded
;734://unlagged - backward reconciliation #2
;735:		// backward-reconcile the other clients
;736:		G_DoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 739
;737://unlagged - backward reconciliation #2
;738:
;739:		trap_Trace( &tr, muzzle, NULL, NULL, end, passent, MASK_SHOT );
ADDRLP4 16
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 116
CNSTP4 0
ASGNP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 80
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 743
;740:
;741://unlagged - backward reconciliation #2
;742:		// put them back
;743:		G_UndoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 747
;744://unlagged - backward reconciliation #2
;745:
;746:		// if not the first trace (the lightning bounced of an invulnerability sphere)
;747:		if (i) {
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $298
line 751
;748:			// add bounced off lightning bolt temp entity
;749:			// the first lightning bolt is a cgame only visual
;750:			//
;751:			tent = G_TempEntity( muzzle, EV_LIGHTNINGBOLT );
ADDRGP4 muzzle
ARGP4
CNSTI4 73
ARGI4
ADDRLP4 120
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 120
INDIRP4
ASGNP4
line 752
;752:			VectorCopy( tr.endpos, end );
ADDRLP4 0
ADDRLP4 16+12
INDIRB
ASGNB 12
line 753
;753:			SnapVector( end );
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
line 754
;754:			VectorCopy( end, tent->s.origin2 );
ADDRLP4 72
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 755
;755:		}
LABELV $298
line 756
;756:		if ( tr.entityNum == ENTITYNUM_NONE ) {
ADDRLP4 16+52
INDIRI4
CNSTI4 1023
NEI4 $305
line 757
;757:			return;
ADDRGP4 $286
JUMPV
LABELV $305
line 760
;758:		}
;759:
;760:		traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 12
CNSTI4 816
ADDRLP4 16+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 762
;761:
;762:		if ( traceEnt->takedamage) {
ADDRLP4 12
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $309
line 763
;763:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
ADDRLP4 120
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $311
ADDRLP4 120
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $311
line 764
;764:				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 16+12
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 100
ARGP4
ADDRLP4 124
ADDRGP4 G_InvulnerabilityEffect
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $314
line 765
;765:					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
ADDRGP4 muzzle
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 100
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_BounceProjectile
CALLV
pop
line 766
;766:					VectorCopy( impactpoint, muzzle );
ADDRGP4 muzzle
ADDRLP4 84
INDIRB
ASGNB 12
line 767
;767:					VectorSubtract( end, impactpoint, forward );
ADDRGP4 forward
ADDRLP4 0
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
ASGNF4
ADDRGP4 forward+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 84+4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 forward+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 84+8
INDIRF4
SUBF4
ASGNF4
line 768
;768:					VectorNormalize(forward);
ADDRGP4 forward
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 770
;769:					// the player can hit him/herself with the bounced lightning
;770:					passent = ENTITYNUM_NONE;
ADDRLP4 80
CNSTI4 1023
ASGNI4
line 771
;771:				}
ADDRGP4 $289
JUMPV
LABELV $314
line 772
;772:				else {
line 773
;773:					VectorCopy( tr.endpos, muzzle );
ADDRGP4 muzzle
ADDRLP4 16+12
INDIRB
ASGNB 12
line 774
;774:					passent = traceEnt->s.number;
ADDRLP4 80
ADDRLP4 12
INDIRP4
INDIRI4
ASGNI4
line 775
;775:				}
line 776
;776:				continue;
ADDRGP4 $289
JUMPV
LABELV $311
line 778
;777:			}
;778:			if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $324
line 779
;779:				ent->client->accuracy_hits++;
ADDRLP4 128
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1120
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 780
;780:			}
LABELV $324
line 781
;781:			G_Damage( traceEnt, ent, ent, forward, tr.endpos, damage, 0, MOD_LIGHTNING);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 16+12
ARGP4
ADDRLP4 96
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 782
;782:		}
LABELV $309
line 784
;783:
;784:		if ( traceEnt->takedamage && traceEnt->client ) {
ADDRLP4 12
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $327
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $327
line 785
;785:			tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
ADDRLP4 16+12
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 124
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 124
INDIRP4
ASGNP4
line 786
;786:			tent->s.otherEntityNum = traceEnt->s.number;
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 12
INDIRP4
INDIRI4
ASGNI4
line 787
;787:			tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 16+24
ARGP4
ADDRLP4 128
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 128
INDIRI4
ASGNI4
line 788
;788:			tent->s.weapon = ent->s.weapon;
ADDRLP4 132
CNSTI4 192
ASGNI4
ADDRLP4 72
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 789
;789:		}
ADDRGP4 $290
JUMPV
LABELV $327
line 790
;790:		else if ( !( tr.surfaceFlags & SURF_NOIMPACT ) ) {
ADDRLP4 16+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $290
line 791
;791:			tent = G_TempEntity( tr.endpos, EV_MISSILE_MISS );
ADDRLP4 16+12
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 124
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 124
INDIRP4
ASGNP4
line 792
;792:			tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 16+24
ARGP4
ADDRLP4 128
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 128
INDIRI4
ASGNI4
line 793
;793:		}
line 795
;794:
;795:		break;
ADDRGP4 $290
JUMPV
LABELV $289
line 730
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 10
LTI4 $288
LABELV $290
line 797
;796:	}
;797:}
LABELV $286
endproc Weapon_LightningFire 136 32
export Weapon_Nailgun_Fire
proc Weapon_Nailgun_Fire 20 20
line 808
;798:
;799:/*
;800:======================================================================
;801:
;802:NAILGUN
;803:
;804:======================================================================
;805:*/
;806:
;807:void Weapon_Nailgun_Fire (gentity_t *ent)
;808:{
line 812
;809:	gentity_t	*m;
;810:	int			count;
;811:
;812:	for( count = 0; count < NUM_NAILSHOTS; count++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $340
JUMPV
LABELV $337
line 813
;813:		m = fire_nail (ent, muzzle, forward, right, up );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRLP4 8
ADDRGP4 fire_nail
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 814
;814:		m->damage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 815
;815:		m->splashDamage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 816
;816:	}
LABELV $338
line 812
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $340
ADDRLP4 4
INDIRI4
ADDRGP4 g_ngcount+12
INDIRI4
LTI4 $337
line 819
;817:
;818://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;819:}
LABELV $336
endproc Weapon_Nailgun_Fire 20 20
export weapon_proxlauncher_fire
proc weapon_proxlauncher_fire 20 12
line 831
;820:
;821:
;822:/*
;823:======================================================================
;824:
;825:PROXIMITY MINE LAUNCHER
;826:
;827:======================================================================
;828:*/
;829:
;830:void weapon_proxlauncher_fire (gentity_t *ent)
;831:{
line 835
;832:	gentity_t	*m;
;833:
;834:	// extra vertical velocity
;835:	forward[2] += 0.2f;
ADDRLP4 4
ADDRGP4 forward+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 836
;836:	VectorNormalize( forward );
ADDRGP4 forward
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 838
;837:
;838:	m = fire_prox (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8
ADDRGP4 fire_prox
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 839
;839:	m->damage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 840
;840:	m->splashDamage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 843
;841:
;842://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;843:}
LABELV $342
endproc weapon_proxlauncher_fire 20 12
export LogAccuracyHit
proc LogAccuracyHit 4 8
line 855
;844:
;845:
;846://======================================================================
;847:
;848:
;849:/*
;850:===============
;851:LogAccuracyHit
;852:===============
;853:*/
;854:qboolean LogAccuracyHit( gentity_t *target, gentity_t *attacker )
;855:{
line 856
;856:	if( !target->takedamage ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $345
line 857
;857:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $344
JUMPV
LABELV $345
line 860
;858:	}
;859:
;860:	if ( target == attacker ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $347
line 861
;861:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $344
JUMPV
LABELV $347
line 864
;862:	}
;863:
;864:	if( !target->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $349
line 865
;865:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $344
JUMPV
LABELV $349
line 868
;866:	}
;867:
;868:	if( !attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $351
line 869
;869:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $344
JUMPV
LABELV $351
line 872
;870:	}
;871:
;872:	if( target->client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $353
line 873
;873:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $344
JUMPV
LABELV $353
line 876
;874:	}
;875:
;876:	if ( OnSameTeam( target, attacker ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $355
line 877
;877:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $344
JUMPV
LABELV $355
line 880
;878:	}
;879:
;880:	return qtrue;
CNSTI4 1
RETI4
LABELV $344
endproc LogAccuracyHit 4 8
export CalcMuzzlePoint
proc CalcMuzzlePoint 36 0
line 892
;881:}
;882:
;883:
;884:/*
;885:===============
;886:CalcMuzzlePoint
;887:
;888:set muzzle location relative to pivoting eye
;889:===============
;890:*/
;891:void CalcMuzzlePoint ( gentity_t *ent, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint )
;892:{
line 893
;893:	VectorCopy( ent->s.pos.trBase, muzzlePoint );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 894
;894:	muzzlePoint[2] += ent->client->ps.viewheight;
ADDRLP4 0
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 895
;895:	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
ADDRLP4 4
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 4
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRLP4 12
ADDRFP4 16
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 20
ADDRFP4 16
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 897
;896:	// snap to integer coordinates for more efficient network bandwidth usage
;897:	SnapVector( muzzlePoint );
ADDRLP4 24
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 28
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 32
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 898
;898:}
LABELV $357
endproc CalcMuzzlePoint 36 0
export CalcMuzzlePointOrigin
proc CalcMuzzlePointOrigin 36 0
line 908
;899:
;900:/*
;901:===============
;902:CalcMuzzlePointOrigin
;903:
;904:set muzzle location relative to pivoting eye
;905:===============
;906:*/
;907:void CalcMuzzlePointOrigin ( gentity_t *ent, vec3_t origin, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint )
;908:{
line 909
;909:	VectorCopy( ent->s.pos.trBase, muzzlePoint );
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 910
;910:	muzzlePoint[2] += ent->client->ps.viewheight;
ADDRLP4 0
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 911
;911:	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
ADDRLP4 4
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 8
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRLP4 12
ADDRFP4 20
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 8
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 20
ADDRFP4 20
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 913
;912:	// snap to integer coordinates for more efficient network bandwidth usage
;913:	SnapVector( muzzlePoint );
ADDRLP4 24
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 28
ADDRFP4 20
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 32
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 914
;914:}
LABELV $358
endproc CalcMuzzlePointOrigin 36 0
export FireWeapon
proc FireWeapon 64 24
line 924
;915:
;916:
;917:
;918:/*
;919:===============
;920:FireWeapon
;921:===============
;922:*/
;923:void FireWeapon( gentity_t *ent )
;924:{
line 926
;925:	//Make people drop out of follow mode (this should be moved, so people can change betwean players.)
;926:	if (ent->client->sess.spectatorState == SPECTATOR_FOLLOW) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
NEI4 $360
line 927
;927:		StopFollowing( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 928
;928:		return;
ADDRGP4 $359
JUMPV
LABELV $360
line 931
;929:	}
;930:
;931:	if (ent->client->ps.powerups[PW_QUAD] ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 0
EQI4 $362
line 932
;932:		s_quadFactor = g_quadfactor.value;
ADDRGP4 s_quadFactor
ADDRGP4 g_quadfactor+8
INDIRF4
ASGNF4
line 933
;933:	}
ADDRGP4 $363
JUMPV
LABELV $362
line 934
;934:	else {
line 935
;935:		s_quadFactor = 1;
ADDRGP4 s_quadFactor
CNSTF4 1065353216
ASGNF4
line 936
;936:	}
LABELV $363
line 937
;937:	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1176
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $365
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $365
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $365
line 938
;938:		s_quadFactor *= g_doublerdamagefactor.value;
ADDRLP4 12
ADDRGP4 s_quadFactor
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 g_doublerdamagefactor+8
INDIRF4
MULF4
ASGNF4
line 939
;939:	}
LABELV $365
line 940
;940:	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_AMMOREGEN ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1176
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $368
ADDRLP4 20
ADDRLP4 12
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $368
ADDRLP4 20
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 13
NEI4 $368
line 941
;941:	s_quadFactor *= g_ammoregendamagefactor.value;
ADDRLP4 24
ADDRGP4 s_quadFactor
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRGP4 g_ammoregendamagefactor+8
INDIRF4
MULF4
ASGNF4
line 942
;942:	}
LABELV $368
line 943
;943:	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_GUARD ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1176
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
CNSTU4 0
ASGNU4
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $371
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $371
ADDRLP4 32
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 11
NEI4 $371
line 944
;944:	s_quadFactor *= g_guarddamagefactor.value;
ADDRLP4 36
ADDRGP4 s_quadFactor
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRGP4 g_guarddamagefactor+8
INDIRF4
MULF4
ASGNF4
line 945
;945:	}
LABELV $371
line 946
;946:	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_SCOUT ) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1176
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
CNSTU4 0
ASGNU4
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $374
ADDRLP4 44
ADDRLP4 36
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $374
ADDRLP4 44
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $374
line 947
;947:	s_quadFactor *= g_scoutdamagefactor.value;
ADDRLP4 48
ADDRGP4 s_quadFactor
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRGP4 g_scoutdamagefactor+8
INDIRF4
MULF4
ASGNF4
line 948
;948:	}
LABELV $374
line 950
;949:
;950:	if (ent->client->spawnprotected)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $377
line 951
;951:		ent->client->spawnprotected = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2000
ADDP4
CNSTI4 0
ASGNI4
LABELV $377
line 954
;952:
;953:	// track shots taken for accuracy tracking.  Grapple is not a weapon and gauntet is just not tracked
;954:	if( ent->s.weapon != WP_GRAPPLING_HOOK && ent->s.weapon != WP_GAUNTLET ) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 10
EQI4 $379
ADDRLP4 48
INDIRI4
CNSTI4 1
EQI4 $379
line 955
;955:		if( ent->s.weapon == WP_NAILGUN ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $381
line 956
;956:			ent->client->accuracy_shots += NUM_NAILSHOTS;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1116
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
ADDRGP4 g_ngcount+12
INDIRI4
ADDI4
ASGNI4
line 957
;957:			ent->client->accuracy[WP_NAILGUN][0]++;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2092
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 958
;958:		}
ADDRGP4 $382
JUMPV
LABELV $381
line 959
;959:		else {
line 960
;960:			ent->client->accuracy_shots++;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1116
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 961
;961:			ent->client->accuracy[ent->s.weapon][0]++;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2004
ADDP4
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 962
;962:		}
LABELV $382
line 963
;963:	}
LABELV $379
line 966
;964:
;965:	// set aiming directions
;966:	AngleVectors (ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 968
;967:
;968:	CalcMuzzlePointOrigin ( ent, ent->client->oldOrigin, forward, right, up, muzzle );
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1072
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePointOrigin
CALLV
pop
line 971
;969:
;970:	// fire the specific weapon
;971:	switch( ent->s.weapon ) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 1
LTI4 $385
ADDRLP4 56
INDIRI4
CNSTI4 13
GTI4 $385
ADDRLP4 56
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $406-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $406
address $387
address $390
address $389
address $396
address $397
address $388
address $399
address $398
address $400
address $401
address $402
address $403
address $404
code
LABELV $387
line 973
;972:	case WP_GAUNTLET:
;973:		Weapon_Gauntlet( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Gauntlet
CALLV
pop
line 974
;974:		break;
ADDRGP4 $385
JUMPV
LABELV $388
line 976
;975:	case WP_LIGHTNING:
;976:		Weapon_LightningFire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_LightningFire
CALLV
pop
line 977
;977:		break;
ADDRGP4 $385
JUMPV
LABELV $389
line 979
;978:	case WP_SHOTGUN:
;979:		weapon_supershotgun_fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_supershotgun_fire
CALLV
pop
line 980
;980:		break;
ADDRGP4 $385
JUMPV
LABELV $390
line 982
;981:	case WP_MACHINEGUN:
;982:		if ( g_gametype.integer != GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $391
line 983
;983:			Bullet_Fire( ent, mod_mgspread, MACHINEGUN_DAMAGE );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 mod_mgspread
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 g_mgdamage+12
INDIRI4
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 984
;984:		}
ADDRGP4 $385
JUMPV
LABELV $391
line 985
;985:		else {
line 986
;986:			Bullet_Fire( ent, mod_mgspread, MACHINEGUN_TEAM_DAMAGE );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 mod_mgspread
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 g_mgdamage+12
INDIRI4
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 987
;987:		}
line 988
;988:		break;
ADDRGP4 $385
JUMPV
LABELV $396
line 990
;989:	case WP_GRENADE_LAUNCHER:
;990:		weapon_grenadelauncher_fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_grenadelauncher_fire
CALLV
pop
line 991
;991:		break;
ADDRGP4 $385
JUMPV
LABELV $397
line 993
;992:	case WP_ROCKET_LAUNCHER:
;993:		Weapon_RocketLauncher_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_RocketLauncher_Fire
CALLV
pop
line 994
;994:		break;
ADDRGP4 $385
JUMPV
LABELV $398
line 996
;995:	case WP_PLASMAGUN:
;996:		Weapon_Plasmagun_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Plasmagun_Fire
CALLV
pop
line 997
;997:		break;
ADDRGP4 $385
JUMPV
LABELV $399
line 999
;998:	case WP_RAILGUN:
;999:		weapon_railgun_fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_railgun_fire
CALLV
pop
line 1000
;1000:		break;
ADDRGP4 $385
JUMPV
LABELV $400
line 1002
;1001:	case WP_BFG:
;1002:		BFG_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BFG_Fire
CALLV
pop
line 1003
;1003:		break;
ADDRGP4 $385
JUMPV
LABELV $401
line 1005
;1004:	case WP_GRAPPLING_HOOK:
;1005:		Weapon_GrapplingHook_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_GrapplingHook_Fire
CALLV
pop
line 1006
;1006:		break;
ADDRGP4 $385
JUMPV
LABELV $402
line 1008
;1007:	case WP_NAILGUN:
;1008:		Weapon_Nailgun_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Nailgun_Fire
CALLV
pop
line 1009
;1009:		break;
ADDRGP4 $385
JUMPV
LABELV $403
line 1011
;1010:	case WP_PROX_LAUNCHER:
;1011:		weapon_proxlauncher_fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_proxlauncher_fire
CALLV
pop
line 1012
;1012:		break;
ADDRGP4 $385
JUMPV
LABELV $404
line 1014
;1013:	case WP_CHAINGUN:
;1014:		Bullet_Fire( ent, mod_cgspread, CHAINGUN_DAMAGE );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 mod_cgspread
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 g_cgdamage+12
INDIRI4
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 1015
;1015:		break;
line 1018
;1016:	default:
;1017:// FIXME		G_Error( "Bad ent->s.weapon" );
;1018:		break;
LABELV $385
line 1020
;1019:	}
;1020:}
LABELV $359
endproc FireWeapon 64 24
proc KamikazeRadiusDamage 4180 32
line 1029
;1021:
;1022:
;1023:/*
;1024:===============
;1025:KamikazeRadiusDamage
;1026:===============
;1027:*/
;1028:static void KamikazeRadiusDamage( vec3_t origin, gentity_t *attacker, float damage, float radius )
;1029:{
line 1039
;1030:	float		dist;
;1031:	gentity_t	*ent;
;1032:	int			entityList[MAX_GENTITIES];
;1033:	int			numListedEntities;
;1034:	vec3_t		mins, maxs;
;1035:	vec3_t		v;
;1036:	vec3_t		dir;
;1037:	int			i, e;
;1038:
;1039:	if ( radius < 1 ) {
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $409
line 1040
;1040:		radius = 1;
ADDRFP4 12
CNSTF4 1065353216
ASGNF4
line 1041
;1041:	}
LABELV $409
line 1043
;1042:
;1043:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $411
line 1044
;1044:		mins[i] = origin[i] - radius;
ADDRLP4 4164
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4164
INDIRI4
ADDRLP4 4140
ADDP4
ADDRLP4 4164
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
SUBF4
ASGNF4
line 1045
;1045:		maxs[i] = origin[i] + radius;
ADDRLP4 4168
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4168
INDIRI4
ADDRLP4 4152
ADDP4
ADDRLP4 4168
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 1046
;1046:	}
LABELV $412
line 1043
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $411
line 1048
;1047:
;1048:	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );
ADDRLP4 4140
ARGP4
ADDRLP4 4152
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4164
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4136
ADDRLP4 4164
INDIRI4
ASGNI4
line 1050
;1049:
;1050:	for ( e = 0 ; e < numListedEntities ; e++ ) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $418
JUMPV
LABELV $415
line 1051
;1051:		ent = &g_entities[entityList[ e ]];
ADDRLP4 4
CNSTI4 816
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1053
;1052:
;1053:		if (!ent->takedamage) {
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $419
line 1054
;1054:			continue;
ADDRGP4 $416
JUMPV
LABELV $419
line 1058
;1055:		}
;1056:
;1057:		// dont hit things we have already hit
;1058:		if( ent->kamikazeTime > level.time ) {
ADDRLP4 4
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $421
line 1059
;1059:			continue;
ADDRGP4 $416
JUMPV
LABELV $421
line 1063
;1060:		}
;1061:
;1062:		// find the distance from the edge of the bounding box
;1063:		for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $424
line 1064
;1064:			if ( origin[i] < ent->r.absmin[i] ) {
ADDRLP4 4168
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4168
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4168
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $428
line 1065
;1065:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 4172
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4172
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4172
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 4172
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1066
;1066:			}
ADDRGP4 $429
JUMPV
LABELV $428
line 1067
;1067:			else if ( origin[i] > ent->r.absmax[i] ) {
ADDRLP4 4172
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4172
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4172
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $430
line 1068
;1068:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 4176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4176
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4176
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4176
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1069
;1069:			}
ADDRGP4 $431
JUMPV
LABELV $430
line 1070
;1070:			else {
line 1071
;1071:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 1072
;1072:			}
LABELV $431
LABELV $429
line 1073
;1073:		}
LABELV $425
line 1063
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $424
line 1075
;1074:
;1075:		dist = VectorLength( v );
ADDRLP4 8
ARGP4
ADDRLP4 4168
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 4168
INDIRF4
ASGNF4
line 1076
;1076:		if ( dist >= radius ) {
ADDRLP4 36
INDIRF4
ADDRFP4 12
INDIRF4
LTF4 $432
line 1077
;1077:			continue;
ADDRGP4 $416
JUMPV
LABELV $432
line 1081
;1078:		}
;1079:
;1080://		if( CanDamage (ent, origin) ) {
;1081:		VectorSubtract (ent->r.currentOrigin, origin, dir);
ADDRLP4 4176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4176
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4176
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1084
;1082:		// push the center of mass higher than the origin so players
;1083:		// get knocked into the air more
;1084:		dir[2] += 24;
ADDRLP4 20+8
ADDRLP4 20+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 1085
;1085:		G_Damage( ent, NULL, attacker, dir, origin, damage, DAMAGE_RADIUS|DAMAGE_NO_TEAM_PROTECTION, MOD_KAMIKAZE );
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
CNSTI4 17
ARGI4
CNSTI4 26
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1086
;1086:		ent->kamikazeTime = level.time + 3000;
ADDRLP4 4
INDIRP4
CNSTI4 784
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1088
;1087://		}
;1088:	}
LABELV $416
line 1050
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $418
ADDRLP4 32
INDIRI4
ADDRLP4 4136
INDIRI4
LTI4 $415
line 1089
;1089:}
LABELV $408
endproc KamikazeRadiusDamage 4180 32
proc KamikazeShockWave 4180 32
line 1097
;1090:
;1091:/*
;1092:===============
;1093:KamikazeShockWave
;1094:===============
;1095:*/
;1096:static void KamikazeShockWave( vec3_t origin, gentity_t *attacker, float damage, float push, float radius )
;1097:{
line 1107
;1098:	float		dist;
;1099:	gentity_t	*ent;
;1100:	int			entityList[MAX_GENTITIES];
;1101:	int			numListedEntities;
;1102:	vec3_t		mins, maxs;
;1103:	vec3_t		v;
;1104:	vec3_t		dir;
;1105:	int			i, e;
;1106:
;1107:	if ( radius < 1 )
ADDRFP4 16
INDIRF4
CNSTF4 1065353216
GEF4 $439
line 1108
;1108:		radius = 1;
ADDRFP4 16
CNSTF4 1065353216
ASGNF4
LABELV $439
line 1110
;1109:
;1110:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $441
line 1111
;1111:		mins[i] = origin[i] - radius;
ADDRLP4 4164
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4164
INDIRI4
ADDRLP4 4140
ADDP4
ADDRLP4 4164
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 16
INDIRF4
SUBF4
ASGNF4
line 1112
;1112:		maxs[i] = origin[i] + radius;
ADDRLP4 4168
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4168
INDIRI4
ADDRLP4 4152
ADDP4
ADDRLP4 4168
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 16
INDIRF4
ADDF4
ASGNF4
line 1113
;1113:	}
LABELV $442
line 1110
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $441
line 1115
;1114:
;1115:	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );
ADDRLP4 4140
ARGP4
ADDRLP4 4152
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4164
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4136
ADDRLP4 4164
INDIRI4
ASGNI4
line 1117
;1116:
;1117:	for ( e = 0 ; e < numListedEntities ; e++ ) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $448
JUMPV
LABELV $445
line 1118
;1118:		ent = &g_entities[entityList[ e ]];
ADDRLP4 4
CNSTI4 816
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1121
;1119:
;1120:		// dont hit things we have already hit
;1121:		if( ent->kamikazeShockTime > level.time ) {
ADDRLP4 4
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $449
line 1122
;1122:			continue;
ADDRGP4 $446
JUMPV
LABELV $449
line 1126
;1123:		}
;1124:
;1125:		// find the distance from the edge of the bounding box
;1126:		for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $452
line 1127
;1127:			if ( origin[i] < ent->r.absmin[i] ) {
ADDRLP4 4168
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4168
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4168
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $456
line 1128
;1128:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 4172
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4172
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4172
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 4172
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1129
;1129:			}
ADDRGP4 $457
JUMPV
LABELV $456
line 1130
;1130:			else if ( origin[i] > ent->r.absmax[i] ) {
ADDRLP4 4172
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4172
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4172
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $458
line 1131
;1131:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 4176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4176
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4176
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4176
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1132
;1132:			}
ADDRGP4 $459
JUMPV
LABELV $458
line 1133
;1133:			else {
line 1134
;1134:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 1135
;1135:			}
LABELV $459
LABELV $457
line 1136
;1136:		}
LABELV $453
line 1126
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $452
line 1138
;1137:
;1138:		dist = VectorLength( v );
ADDRLP4 8
ARGP4
ADDRLP4 4168
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 4168
INDIRF4
ASGNF4
line 1139
;1139:		if ( dist >= radius ) {
ADDRLP4 36
INDIRF4
ADDRFP4 16
INDIRF4
LTF4 $460
line 1140
;1140:			continue;
ADDRGP4 $446
JUMPV
LABELV $460
line 1144
;1141:		}
;1142:
;1143://		if( CanDamage (ent, origin) ) {
;1144:		VectorSubtract (ent->r.currentOrigin, origin, dir);
ADDRLP4 4176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4176
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4176
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1145
;1145:		dir[2] += 24;
ADDRLP4 20+8
ADDRLP4 20+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 1146
;1146:		G_Damage( ent, NULL, attacker, dir, origin, damage, DAMAGE_RADIUS|DAMAGE_NO_TEAM_PROTECTION, MOD_KAMIKAZE );
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
CNSTI4 17
ARGI4
CNSTI4 26
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1148
;1147:		//
;1148:		dir[2] = 0;
ADDRLP4 20+8
CNSTF4 0
ASGNF4
line 1149
;1149:		VectorNormalize(dir);
ADDRLP4 20
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1150
;1150:		if ( ent->client ) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $466
line 1151
;1151:			ent->client->ps.velocity[0] = dir[0] * push;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 20
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 1152
;1152:			ent->client->ps.velocity[1] = dir[1] * push;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 20+4
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 1153
;1153:			ent->client->ps.velocity[2] = 100;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1120403456
ASGNF4
line 1154
;1154:		}
LABELV $466
line 1155
;1155:		ent->kamikazeShockTime = level.time + 3000;
ADDRLP4 4
INDIRP4
CNSTI4 788
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1157
;1156://		}
;1157:	}
LABELV $446
line 1117
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $448
ADDRLP4 32
INDIRI4
ADDRLP4 4136
INDIRI4
LTI4 $445
line 1158
;1158:}
LABELV $438
endproc KamikazeShockWave 4180 32
proc KamikazeDamage 64 20
line 1166
;1159:
;1160:/*
;1161:===============
;1162:KamikazeDamage
;1163:===============
;1164:*/
;1165:static void KamikazeDamage( gentity_t *self )
;1166:{
line 1172
;1167:	int i;
;1168:	float t;
;1169:	gentity_t *ent;
;1170:	vec3_t newangles;
;1171:
;1172:	self->count += 100;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1174
;1173:
;1174:	if (self->count >= KAMI_SHOCKWAVE_STARTTIME) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
LTI4 $471
line 1176
;1175:		// shockwave push back
;1176:		t = self->count - KAMI_SHOCKWAVE_STARTTIME;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1177
;1177:		KamikazeShockWave(self->s.pos.trBase, self->activator, 25, 400,	(int) (float) t * KAMI_SHOCKWAVE_MAXRADIUS / (KAMI_SHOCKWAVE_ENDTIME - KAMI_SHOCKWAVE_STARTTIME) );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
CNSTF4 1103626240
ARGF4
CNSTF4 1137180672
ARGF4
CNSTI4 1320
ADDRLP4 20
INDIRF4
CVFI4 4
MULI4
CNSTI4 2000
DIVI4
CVIF4 4
ARGF4
ADDRGP4 KamikazeShockWave
CALLV
pop
line 1178
;1178:	}
LABELV $471
line 1180
;1179:	//
;1180:	if (self->count >= KAMI_EXPLODE_STARTTIME) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 250
LTI4 $473
line 1182
;1181:		// do our damage
;1182:		t = self->count - KAMI_EXPLODE_STARTTIME;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 250
SUBI4
CVIF4 4
ASGNF4
line 1183
;1183:		KamikazeRadiusDamage( self->s.pos.trBase, self->activator, 400,	(int) (float) t * KAMI_BOOMSPHERE_MAXRADIUS / (KAMI_IMPLODE_STARTTIME - KAMI_EXPLODE_STARTTIME) );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
CNSTF4 1137180672
ARGF4
CNSTI4 720
ADDRLP4 20
INDIRF4
CVFI4 4
MULI4
CNSTI4 1750
DIVI4
CVIF4 4
ARGF4
ADDRGP4 KamikazeRadiusDamage
CALLV
pop
line 1184
;1184:	}
LABELV $473
line 1187
;1185:
;1186:	// either cycle or kill self
;1187:	if( self->count >= KAMI_SHOCKWAVE_ENDTIME ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 2000
LTI4 $475
line 1188
;1188:		G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1189
;1189:		return;
ADDRGP4 $470
JUMPV
LABELV $475
line 1191
;1190:	}
;1191:	self->nextthink = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1194
;1192:
;1193:	// add earth quake effect
;1194:	newangles[0] = crandom() * 2;
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 32
CNSTF4 1073741824
ASGNF4
ADDRLP4 4
ADDRLP4 32
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 28
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
ASGNF4
line 1195
;1195:	newangles[1] = crandom() * 2;
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
CNSTF4 1073741824
ASGNF4
ADDRLP4 4+4
ADDRLP4 40
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 36
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
ASGNF4
line 1196
;1196:	newangles[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 1197
;1197:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $480
line 1198
;1198:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 816
ADDRLP4 16
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1199
;1199:		if (!ent->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $484
line 1200
;1200:			continue;
ADDRGP4 $481
JUMPV
LABELV $484
line 1201
;1201:		if (!ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $486
line 1202
;1202:			continue;
ADDRGP4 $481
JUMPV
LABELV $486
line 1204
;1203:
;1204:		if (ent->client->ps.groundEntityNum != ENTITYNUM_NONE) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $488
line 1205
;1205:			ent->client->ps.velocity[0] += crandom() * 120;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
CNSTF4 1123024896
CNSTF4 1073741824
ADDRLP4 44
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
ASGNF4
line 1206
;1206:			ent->client->ps.velocity[1] += crandom() * 120;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1123024896
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
ADDF4
ASGNF4
line 1207
;1207:			ent->client->ps.velocity[2] = 30 + random() * 25;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1103626240
ADDRLP4 60
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 1208
;1208:		}
LABELV $488
line 1210
;1209:
;1210:		ent->client->ps.delta_angles[0] += ANGLE2SHORT(newangles[0] - self->movedir[0]);
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 56
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTF4 1199570944
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
SUBF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 1211
;1211:		ent->client->ps.delta_angles[1] += ANGLE2SHORT(newangles[1] - self->movedir[1]);
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTF4 1199570944
ADDRLP4 4+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
SUBF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 1212
;1212:		ent->client->ps.delta_angles[2] += ANGLE2SHORT(newangles[2] - self->movedir[2]);
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTF4 1199570944
ADDRLP4 4+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
SUBF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 1213
;1213:	}
LABELV $481
line 1197
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 64
LTI4 $480
line 1214
;1214:	VectorCopy(newangles, self->movedir);
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 1215
;1215:}
LABELV $470
endproc KamikazeDamage 64 20
export G_StartKamikaze
proc G_StartKamikaze 44 32
line 1223
;1216:
;1217:/*
;1218:===============
;1219:G_StartKamikaze
;1220:===============
;1221:*/
;1222:void G_StartKamikaze( gentity_t *ent )
;1223:{
line 1229
;1224:	gentity_t	*explosion;
;1225:	gentity_t	*te;
;1226:	vec3_t		snapped;
;1227:
;1228:	// start up the explosion logic
;1229:	explosion = G_Spawn();
ADDRLP4 20
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1231
;1230:
;1231:	explosion->s.eType = ET_EVENTS + EV_KAMIKAZE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 81
ASGNI4
line 1232
;1232:	explosion->eventTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1234
;1233:
;1234:	if ( ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $494
line 1235
;1235:		VectorCopy( ent->s.pos.trBase, snapped );
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1236
;1236:	}
ADDRGP4 $495
JUMPV
LABELV $494
line 1237
;1237:	else {
line 1238
;1238:		VectorCopy( ent->activator->s.pos.trBase, snapped );
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1239
;1239:	}
LABELV $495
line 1240
;1240:	SnapVector( snapped );		// save network bandwidth
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
line 1241
;1241:	G_SetOrigin( explosion, snapped );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1243
;1242:
;1243:	explosion->classname = "kamikaze";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $500
ASGNP4
line 1244
;1244:	explosion->s.pos.trType = TR_STATIONARY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1246
;1245:
;1246:	explosion->kamikazeTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 784
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1248
;1247:
;1248:	explosion->think = KamikazeDamage;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 KamikazeDamage
ASGNP4
line 1249
;1249:	explosion->nextthink = level.time + 100;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1250
;1250:	explosion->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 1251
;1251:	VectorClear(explosion->movedir);
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 684
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 680
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1253
;1252:
;1253:	trap_LinkEntity( explosion );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1255
;1254:
;1255:	if (ent->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $503
line 1257
;1256:		//
;1257:		explosion->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1259
;1258:		//
;1259:		ent->s.eFlags &= ~EF_KAMIKAZE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 1261
;1260:		// nuke the guy that used it
;1261:		G_Damage( ent, ent, ent, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_KAMIKAZE );
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
CNSTP4 0
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 8
ARGI4
CNSTI4 26
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1262
;1262:	}
ADDRGP4 $504
JUMPV
LABELV $503
line 1263
;1263:	else {
line 1264
;1264:		if ( strequals(ent->activator->classname, "bodyque") ) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $507
ARGP4
ADDRLP4 32
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $505
line 1265
;1265:			explosion->activator = &g_entities[ent->activator->r.ownerNum];
ADDRLP4 36
CNSTI4 772
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
CNSTI4 816
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1266
;1266:		}
ADDRGP4 $506
JUMPV
LABELV $505
line 1267
;1267:		else {
line 1268
;1268:			explosion->activator = ent->activator;
ADDRLP4 36
CNSTI4 772
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 1269
;1269:		}
LABELV $506
line 1270
;1270:	}
LABELV $504
line 1273
;1271:
;1272:	// play global sound at all clients
;1273:	te = G_TempEntity(snapped, EV_GLOBAL_TEAM_SOUND );
ADDRLP4 4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 32
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 1274
;1274:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 36
ADDRLP4 16
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1275
;1275:	te->s.eventParm = GTS_KAMIKAZE;
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 13
ASGNI4
line 1276
;1276:}
LABELV $492
endproc G_StartKamikaze 44 32
bss
align 4
LABELV muzzle
skip 12
align 4
LABELV up
skip 12
align 4
LABELV right
skip 12
align 4
LABELV forward
skip 12
align 4
LABELV s_quadFactor
skip 4
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
LABELV $507
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 113
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $500
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $272
byte 1 73
byte 1 77
byte 1 80
byte 1 82
byte 1 69
byte 1 83
byte 1 83
byte 1 73
byte 1 86
byte 1 69
byte 1 0
align 1
LABELV $271
byte 1 65
byte 1 119
byte 1 97
byte 1 114
byte 1 100
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
byte 1 103
byte 1 97
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 33
byte 1 10
byte 1 0
