export CG_TestModel_f
code
proc CG_TestModel_f 36 12
file "../../../code/cgame/cg_view.c"
line 71
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
;23:// cg_view.c -- setup all the parameters (position, angle, etc)
;24:// for a 3D rendering
;25:#include "cg_local.h"
;26:
;27:
;28:/*
;29:=============================================================================
;30:
;31:  MODEL TESTING
;32:
;33:The viewthing and gun positioning tools from Q2 have been integrated and
;34:enhanced into a single model testing facility.
;35:
;36:Model viewing can begin with either "testmodel <modelname>" or "testgun <modelname>".
;37:
;38:The names must be the full pathname after the basedir, like 
;39:"models/weapons/v_launch/tris.md3" or "players/male/tris.md3"
;40:
;41:Testmodel will create a fake entity 100 units in front of the current view
;42:position, directly facing the viewer.  It will remain immobile, so you can
;43:move around it to view it from different angles.
;44:
;45:Testgun will cause the model to follow the player around and supress the real
;46:view weapon model.  The default frame 0 of most guns is completely off screen,
;47:so you will probably have to cycle a couple frames to see it.
;48:
;49:"nextframe", "prevframe", "nextskin", and "prevskin" commands will change the
;50:frame or skin of the testmodel.  These are bound to F5, F6, F7, and F8 in
;51:q3default.cfg.
;52:
;53:If a gun is being tested, the "gun_x", "gun_y", and "gun_z" variables will let
;54:you adjust the positioning.
;55:
;56:Note that none of the model testing features update while the game is paused, so
;57:it may be convenient to test with deathmatch set to 1 so that bringing down the
;58:console doesn't pause the game.
;59:
;60:=============================================================================
;61:*/
;62:
;63:/*
;64:=================
;65:CG_TestModel_f
;66:
;67:Creates an entity in front of the current position, which
;68:can then be moved around
;69:=================
;70:*/
;71:void CG_TestModel_f (void) {
line 74
;72:	vec3_t		angles;
;73:
;74:	cg.testGun = qfalse;
ADDRGP4 cg+125624
CNSTI4 0
ASGNI4
line 75
;75:	memset( &cg.testModelEntity, 0, sizeof(cg.testModelEntity) );
ADDRGP4 cg+125384
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 76
;76:	if ( trap_Argc() < 2 ) {
ADDRLP4 12
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
GEI4 $78
line 77
;77:		return;
ADDRGP4 $74
JUMPV
LABELV $78
line 80
;78:	}
;79:
;80:	Q_strncpyz (cg.testModelName, CG_Argv( 1 ), MAX_QPATH );
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRGP4 cg+125560
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 81
;81:	cg.testModelEntity.hModel = trap_R_RegisterModel( cg.testModelName );
ADDRGP4 cg+125560
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cg+125384+8
ADDRLP4 20
INDIRI4
ASGNI4
line 83
;82:
;83:	if ( trap_Argc() == 3 ) {
ADDRLP4 24
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 3
NEI4 $84
line 84
;84:		cg.testModelEntity.backlerp = atof( CG_Argv( 2 ) );
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 cg+125384+100
ADDRLP4 32
INDIRF4
ASGNF4
line 85
;85:		cg.testModelEntity.frame = 1;
ADDRGP4 cg+125384+80
CNSTI4 1
ASGNI4
line 86
;86:		cg.testModelEntity.oldframe = 0;
ADDRGP4 cg+125384+96
CNSTI4 0
ASGNI4
line 87
;87:	}
LABELV $84
line 88
;88:	if (! cg.testModelEntity.hModel ) {
ADDRGP4 cg+125384+8
INDIRI4
CNSTI4 0
NEI4 $92
line 89
;89:		CG_Printf( "Can't register model\n" );
ADDRGP4 $96
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 90
;90:		return;
ADDRGP4 $74
JUMPV
LABELV $92
line 93
;91:	}
;92:
;93:	VectorMA( cg.refdef.vieworg, 100, cg.refdef.viewaxis[0], cg.testModelEntity.origin );
ADDRGP4 cg+125384+68
ADDRGP4 cg+109252+24
INDIRF4
CNSTF4 1120403456
ADDRGP4 cg+109252+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+125384+68+4
ADDRGP4 cg+109252+24+4
INDIRF4
CNSTF4 1120403456
ADDRGP4 cg+109252+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+125384+68+8
ADDRGP4 cg+109252+24+8
INDIRF4
CNSTF4 1120403456
ADDRGP4 cg+109252+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 95
;94:
;95:	angles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 96
;96:	angles[YAW] = 180 + cg.refdefViewAngles[1];
ADDRLP4 0+4
ADDRGP4 cg+109620+4
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 97
;97:	angles[ROLL] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 99
;98:
;99:	AnglesToAxis( angles, cg.testModelEntity.axis );
ADDRLP4 0
ARGP4
ADDRGP4 cg+125384+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 100
;100:}
LABELV $74
endproc CG_TestModel_f 36 12
export CG_TestGun_f
proc CG_TestGun_f 0 0
line 109
;101:
;102:/*
;103:=================
;104:CG_TestGun_f
;105:
;106:Replaces the current view weapon with the given model
;107:=================
;108:*/
;109:void CG_TestGun_f (void) {
line 110
;110:	CG_TestModel_f();
ADDRGP4 CG_TestModel_f
CALLV
pop
line 112
;111:
;112:	if ( !cg.testModelEntity.hModel ) {
ADDRGP4 cg+125384+8
INDIRI4
CNSTI4 0
NEI4 $128
line 113
;113:		return;
ADDRGP4 $127
JUMPV
LABELV $128
line 116
;114:	}
;115:
;116:	cg.testGun = qtrue;
ADDRGP4 cg+125624
CNSTI4 1
ASGNI4
line 117
;117:	cg.testModelEntity.renderfx = RF_MINLIGHT | RF_DEPTHHACK | RF_FIRST_PERSON;
ADDRGP4 cg+125384+4
CNSTI4 13
ASGNI4
line 118
;118:}
LABELV $127
endproc CG_TestGun_f 0 0
export CG_TestModelNextFrame_f
proc CG_TestModelNextFrame_f 4 8
line 121
;119:
;120:
;121:void CG_TestModelNextFrame_f (void) {
line 122
;122:	cg.testModelEntity.frame++;
ADDRLP4 0
ADDRGP4 cg+125384+80
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 123
;123:	CG_Printf( "frame %i\n", cg.testModelEntity.frame );
ADDRGP4 $138
ARGP4
ADDRGP4 cg+125384+80
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 124
;124:}
LABELV $135
endproc CG_TestModelNextFrame_f 4 8
export CG_TestModelPrevFrame_f
proc CG_TestModelPrevFrame_f 4 8
line 126
;125:
;126:void CG_TestModelPrevFrame_f (void) {
line 127
;127:	cg.testModelEntity.frame--;
ADDRLP4 0
ADDRGP4 cg+125384+80
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 128
;128:	if ( cg.testModelEntity.frame < 0 ) {
ADDRGP4 cg+125384+80
INDIRI4
CNSTI4 0
GEI4 $144
line 129
;129:		cg.testModelEntity.frame = 0;
ADDRGP4 cg+125384+80
CNSTI4 0
ASGNI4
line 130
;130:	}
LABELV $144
line 131
;131:	CG_Printf( "frame %i\n", cg.testModelEntity.frame );
ADDRGP4 $138
ARGP4
ADDRGP4 cg+125384+80
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 132
;132:}
LABELV $141
endproc CG_TestModelPrevFrame_f 4 8
export CG_TestModelNextSkin_f
proc CG_TestModelNextSkin_f 4 8
line 134
;133:
;134:void CG_TestModelNextSkin_f (void) {
line 135
;135:	cg.testModelEntity.skinNum++;
ADDRLP4 0
ADDRGP4 cg+125384+104
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 136
;136:	CG_Printf( "skin %i\n", cg.testModelEntity.skinNum );
ADDRGP4 $155
ARGP4
ADDRGP4 cg+125384+104
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 137
;137:}
LABELV $152
endproc CG_TestModelNextSkin_f 4 8
export CG_TestModelPrevSkin_f
proc CG_TestModelPrevSkin_f 4 8
line 139
;138:
;139:void CG_TestModelPrevSkin_f (void) {
line 140
;140:	cg.testModelEntity.skinNum--;
ADDRLP4 0
ADDRGP4 cg+125384+104
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 141
;141:	if ( cg.testModelEntity.skinNum < 0 ) {
ADDRGP4 cg+125384+104
INDIRI4
CNSTI4 0
GEI4 $161
line 142
;142:		cg.testModelEntity.skinNum = 0;
ADDRGP4 cg+125384+104
CNSTI4 0
ASGNI4
line 143
;143:	}
LABELV $161
line 144
;144:	CG_Printf( "skin %i\n", cg.testModelEntity.skinNum );
ADDRGP4 $155
ARGP4
ADDRGP4 cg+125384+104
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 145
;145:}
LABELV $158
endproc CG_TestModelPrevSkin_f 4 8
proc CG_AddTestModel 32 4
line 147
;146:
;147:static void CG_AddTestModel (void) {
line 151
;148:	int		i;
;149:
;150:	// re-register the model, because the level may have changed
;151:	cg.testModelEntity.hModel = trap_R_RegisterModel( cg.testModelName );
ADDRGP4 cg+125560
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cg+125384+8
ADDRLP4 4
INDIRI4
ASGNI4
line 152
;152:	if (! cg.testModelEntity.hModel ) {
ADDRGP4 cg+125384+8
INDIRI4
CNSTI4 0
NEI4 $173
line 153
;153:		CG_Printf ("Can't register model\n");
ADDRGP4 $96
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 154
;154:		return;
ADDRGP4 $169
JUMPV
LABELV $173
line 158
;155:	}
;156:
;157:	// if testing a gun, set the origin reletive to the view origin
;158:	if ( cg.testGun ) {
ADDRGP4 cg+125624
INDIRI4
CNSTI4 0
EQI4 $177
line 159
;159:		VectorCopy( cg.refdef.vieworg, cg.testModelEntity.origin );
ADDRGP4 cg+125384+68
ADDRGP4 cg+109252+24
INDIRB
ASGNB 12
line 160
;160:		VectorCopy( cg.refdef.viewaxis[0], cg.testModelEntity.axis[0] );
ADDRGP4 cg+125384+28
ADDRGP4 cg+109252+36
INDIRB
ASGNB 12
line 161
;161:		VectorCopy( cg.refdef.viewaxis[1], cg.testModelEntity.axis[1] );
ADDRGP4 cg+125384+28+12
ADDRGP4 cg+109252+36+12
INDIRB
ASGNB 12
line 162
;162:		VectorCopy( cg.refdef.viewaxis[2], cg.testModelEntity.axis[2] );
ADDRGP4 cg+125384+28+24
ADDRGP4 cg+109252+36+24
INDIRB
ASGNB 12
line 165
;163:
;164:		// allow the position to be adjusted
;165:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $200
line 166
;166:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[0][i] * cg_gun_x.value;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 cg+125384+68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 8
INDIRI4
ADDRGP4 cg+109252+36
ADDP4
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 167
;167:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[1][i] * cg_gun_y.value;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
ADDRLP4 16
INDIRI4
ADDRGP4 cg+125384+68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 16
INDIRI4
ADDRGP4 cg+109252+36+12
ADDP4
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 168
;168:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[2][i] * cg_gun_z.value;
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
ADDRLP4 24
INDIRI4
ADDRGP4 cg+125384+68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 24
INDIRI4
ADDRGP4 cg+109252+36+24
ADDP4
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 169
;169:		}
LABELV $201
line 165
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $200
line 170
;170:	}
LABELV $177
line 172
;171:
;172:	trap_R_AddRefEntityToScene( &cg.testModelEntity );
ADDRGP4 cg+125384
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 173
;173:}
LABELV $169
endproc CG_AddTestModel 32 4
proc CG_CalcVrect 20 8
line 187
;174:
;175:
;176:
;177://============================================================================
;178:
;179:
;180:/*
;181:=================
;182:CG_CalcVrect
;183:
;184:Sets the coordinates of the rendered window
;185:=================
;186:*/
;187:static void CG_CalcVrect (void) {
line 192
;188:	int		size;
;189:	int		size2;
;190:
;191:	// the intermission should allways be full screen
;192:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $223
line 193
;193:		size = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 194
;194:	} else {
ADDRGP4 $224
JUMPV
LABELV $223
line 196
;195:		// bound normal viewsize
;196:		if (cg_viewsize.integer < 30) {
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 30
GEI4 $226
line 197
;197:			trap_Cvar_Set ("cg_viewsize","30");
ADDRGP4 $229
ARGP4
ADDRGP4 $230
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 198
;198:			size = 30;
ADDRLP4 0
CNSTI4 30
ASGNI4
line 199
;199:		} else if (cg_viewsize.integer > 120) {
ADDRGP4 $227
JUMPV
LABELV $226
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 120
LEI4 $231
line 200
;200:			trap_Cvar_Set ("cg_viewsize","120");	// leilei - increased to 120 for retro sbar disabling
ADDRGP4 $229
ARGP4
ADDRGP4 $234
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 201
;201:			size = 120;
ADDRLP4 0
CNSTI4 120
ASGNI4
line 202
;202:		} else {
ADDRGP4 $232
JUMPV
LABELV $231
line 203
;203:			size = cg_viewsize.integer;
ADDRLP4 0
ADDRGP4 cg_viewsize+12
INDIRI4
ASGNI4
line 204
;204:		}
LABELV $232
LABELV $227
line 206
;205:
;206:	}
LABELV $224
line 208
;207:
;208:	size2 = size;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 209
;209:	if (size>100){
ADDRLP4 0
INDIRI4
CNSTI4 100
LEI4 $236
line 210
;210:		size = 100;	// leilei - size should actually be normal...
ADDRLP4 0
CNSTI4 100
ASGNI4
line 211
;211:	}
LABELV $236
line 212
;212:	cg.refdef.width = cgs.glconfig.vidWidth*size/100;
ADDRGP4 cg+109252+8
ADDRGP4 cgs+20100+11304
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 213
;213:	cg.refdef.width &= ~1;
ADDRLP4 8
ADDRGP4 cg+109252+8
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 215
;214:
;215:	cg.refdef.height = cgs.glconfig.vidHeight*size/100;
ADDRGP4 cg+109252+12
ADDRGP4 cgs+20100+11308
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 216
;216:	cg.refdef.height &= ~1;
ADDRLP4 12
ADDRGP4 cg+109252+12
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 218
;217:
;218:	cg.refdef.x = (cgs.glconfig.vidWidth - cg.refdef.width)/2;
ADDRGP4 cg+109252
ADDRGP4 cgs+20100+11304
INDIRI4
ADDRGP4 cg+109252+8
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 219
;219:	cg.refdef.y = (cgs.glconfig.vidHeight - cg.refdef.height)/2;
ADDRGP4 cg+109252+4
ADDRGP4 cgs+20100+11308
INDIRI4
ADDRGP4 cg+109252+12
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 222
;220:
;221:	// leilei - nudge
;222:		if (cg_viewnudge.integer) {
ADDRGP4 cg_viewnudge+12
INDIRI4
CNSTI4 0
EQI4 $261
line 223
;223:			int nudged = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 225
;224:
;225:			if (size2 < 110) {
ADDRLP4 4
INDIRI4
CNSTI4 110
GEI4 $264
line 226
;226:				nudged = 48;
ADDRLP4 16
CNSTI4 48
ASGNI4
line 227
;227:			}
ADDRGP4 $265
JUMPV
LABELV $264
line 228
;228:			else if (size2 < 120) {
ADDRLP4 4
INDIRI4
CNSTI4 120
GEI4 $266
line 229
;229:				nudged = 24;
ADDRLP4 16
CNSTI4 24
ASGNI4
line 230
;230:			}
LABELV $266
LABELV $265
line 233
;231:
;232:
;233:			nudged = nudged * (cgs.glconfig.vidHeight / 480.0);
ADDRLP4 16
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
CNSTF4 1139802112
DIVF4
MULF4
CVFI4 4
ASGNI4
line 234
;234:			cg.refdef.y = ( cgs.glconfig.vidHeight  - cg.refdef.height) /2 - nudged;
ADDRGP4 cg+109252+4
ADDRGP4 cgs+20100+11308
INDIRI4
ADDRGP4 cg+109252+12
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ADDRLP4 16
INDIRI4
SUBI4
ASGNI4
line 236
;235:
;236:		}
LABELV $261
line 237
;237:}
LABELV $222
endproc CG_CalcVrect 20 8
proc CG_OffsetThirdPersonView 176 16
line 252
;238:
;239://==============================================================================
;240:
;241:// leilei - eyes hack
;242:
;243:extern vec3_t headpos;
;244:extern vec3_t headang;
;245:/*
;246:===============
;247:CG_OffsetThirdPersonView
;248:
;249:===============
;250:*/
;251:#define	FOCUS_DISTANCE	512
;252:static void CG_OffsetThirdPersonView( void ) {
line 261
;253:	vec3_t		forward, right, up;
;254:	vec3_t		view;
;255:	vec3_t		focusAngles;
;256:	vec3_t		focusPoint;
;257:	float		focusDist;
;258:	float		forwardScale, sideScale;
;259:
;260:
;261:	float		range = cg_thirdPersonRange.value;
ADDRLP4 36
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
ASGNF4
line 264
;262:
;263:		
;264:	cg.refdef.vieworg[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 88
ADDRGP4 cg+109252+24+8
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 266
;265:
;266:	VectorCopy( cg.refdefViewAngles, focusAngles );
ADDRLP4 60
ADDRGP4 cg+109620
INDIRB
ASGNB 12
line 269
;267:
;268:	// if dead, look at killer
;269:	if ( (cg.predictedPlayerState.stats[STAT_HEALTH] <= 0) && !CG_IsARoundBasedGametype(cgs.gametype) ) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $284
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $284
line 270
;270:		focusAngles[YAW] = cg.predictedPlayerState.stats[STAT_DEAD_YAW];
ADDRLP4 60+4
ADDRGP4 cg+107636+184+16
INDIRI4
CVIF4 4
ASGNF4
line 271
;271:		cg.refdefViewAngles[YAW] = cg.predictedPlayerState.stats[STAT_DEAD_YAW];
ADDRGP4 cg+109620+4
ADDRGP4 cg+107636+184+16
INDIRI4
CVIF4 4
ASGNF4
line 272
;272:	}
LABELV $284
line 274
;273:
;274:	if (cg_deathcam.integer == 2 && (cg.predictedPlayerState.stats[STAT_HEALTH] <= 0) ){	// leilei - deathcam
ADDRGP4 cg_deathcam+12
INDIRI4
CNSTI4 2
NEI4 $298
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $298
line 276
;275:
;276:		range = 100;
ADDRLP4 36
CNSTF4 1120403456
ASGNF4
line 280
;277:		//origin = cg.refdef.vieworg;
;278:	//	focusAngles[YAW] = cg.refdefViewAngles[YAW];
;279:	//	focusAngles[PITCH] = cg.refdefViewAngles[PITCH];
;280:	}
LABELV $298
line 282
;281:
;282:	if (cg_cameramode.integer && (cg.predictedPlayerState.stats[STAT_HEALTH] > 0))		// leilei this mode is off to the player's right
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRGP4 cg_cameramode+12
INDIRI4
ADDRLP4 96
INDIRI4
EQI4 $303
ADDRGP4 cg+107636+184
INDIRI4
ADDRLP4 96
INDIRI4
LEI4 $303
line 283
;283:	{											
line 285
;284:		// and should look towards a 3d crosshair
;285:		AngleVectors( focusAngles, forward, NULL, NULL );
ADDRLP4 60
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 100
CNSTP4 0
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 286
;286:		VectorMA( cg.refdef.vieworg, FOCUS_DISTANCE, forward, focusPoint );
ADDRLP4 104
CNSTF4 1140850688
ASGNF4
ADDRLP4 12
ADDRGP4 cg+109252+24
INDIRF4
ADDRLP4 104
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 cg+109252+24+4
INDIRF4
ADDRLP4 104
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 cg+109252+24+8
INDIRF4
CNSTF4 1140850688
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 287
;287:		VectorCopy( cg.refdef.vieworg, view );
ADDRLP4 0
ADDRGP4 cg+109252+24
INDIRB
ASGNB 12
line 289
;288:
;289:		view[2] += 3;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 291
;290:
;291:		cg.refdefViewAngles[PITCH] *= 0.5;
ADDRLP4 108
ADDRGP4 cg+109620
ASGNP4
ADDRLP4 108
INDIRP4
CNSTF4 1056964608
ADDRLP4 108
INDIRP4
INDIRF4
MULF4
ASGNF4
line 296
;292:
;293:		// hmm HMMhmmhHMHMHMhmhmh
;294:
;295:		//cg.refdefViewAngles[YAW] -= cg_leiDebug.value;
;296:		AngleVectors( focusAngles, forward, NULL, NULL );
ADDRLP4 60
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 112
CNSTP4 0
ASGNP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 297
;297:		VectorMA( cg.refdef.vieworg, FOCUS_DISTANCE, forward, focusPoint );
ADDRLP4 116
CNSTF4 1140850688
ASGNF4
ADDRLP4 12
ADDRGP4 cg+109252+24
INDIRF4
ADDRLP4 116
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 cg+109252+24+4
INDIRF4
ADDRLP4 116
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 cg+109252+24+8
INDIRF4
CNSTF4 1140850688
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 298
;298:		VectorCopy( cg.refdef.vieworg, view );
ADDRLP4 0
ADDRGP4 cg+109252+24
INDIRB
ASGNB 12
line 300
;299:
;300:		AngleVectors( cg.refdefViewAngles, forward, right, up );
ADDRGP4 cg+109620
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 302
;301:
;302:		forwardScale = cos( 0 / 180 * M_PI );
CNSTF4 0
ARGF4
ADDRLP4 120
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 120
INDIRF4
ASGNF4
line 303
;303:		sideScale = sin( 0 / 180 * M_PI ) - 0.465;
CNSTF4 0
ARGF4
ADDRLP4 124
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 124
INDIRF4
CNSTF4 1055790203
SUBF4
ASGNF4
line 304
;304:		VectorMA( view, -range * forwardScale, forward, view );
ADDRLP4 128
ADDRLP4 36
INDIRF4
NEGF4
ADDRLP4 52
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 128
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRLP4 128
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRLP4 36
INDIRF4
NEGF4
ADDRLP4 52
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 305
;305:		VectorMA( view, -range * sideScale, right, view );
ADDRLP4 132
ADDRLP4 36
INDIRF4
NEGF4
ADDRLP4 56
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 132
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 132
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 36
INDIRF4
NEGF4
ADDRLP4 56
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 307
;306:
;307:		VectorCopy( view, cg.refdef.vieworg );
ADDRGP4 cg+109252+24
ADDRLP4 0
INDIRB
ASGNB 12
line 310
;308:
;309:		// select pitch to look at focus point from vieword
;310:		VectorSubtract( focusPoint, cg.refdef.vieworg, focusPoint );
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109252+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109252+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109252+24+8
INDIRF4
SUBF4
ASGNF4
line 311
;311:		focusDist = sqrt( focusPoint[0] * focusPoint[0] + focusPoint[1] * focusPoint[1] );
ADDRLP4 136
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 136
INDIRF4
ADDRLP4 136
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 140
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 72
ADDRLP4 140
INDIRF4
ASGNF4
line 312
;312:		if ( focusDist < 1 ) {
ADDRLP4 72
INDIRF4
CNSTF4 1065353216
GEF4 $367
line 313
;313:			focusDist = 1;	// should never happen
ADDRLP4 72
CNSTF4 1065353216
ASGNF4
line 314
;314:		}
LABELV $367
line 315
;315:		cg.refdefViewAngles[PITCH] = -180 / M_PI * atan2( focusPoint[2], focusDist );
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 144
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRGP4 cg+109620
CNSTF4 3261411041
ADDRLP4 144
INDIRF4
MULF4
ASGNF4
line 321
;316:
;317:		// leilei - make it look to a 3d cursor
;318:
;319:		//cg.refdefViewAngles[YAW] -= cg_thirdPersonAngle.value;	 // can't do this right now.
;320:
;321:		{
line 324
;322:			vec3_t			forward, up;
;323:
;324:			cg.refdef.vieworg[2] -= 24;
ADDRLP4 172
ADDRGP4 cg+109252+24+8
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 325
;325:			AngleVectors( cg.refdefViewAngles, forward, NULL, up );
ADDRGP4 cg+109620
ARGP4
ADDRLP4 148
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 160
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 326
;326:			VectorMA( cg.refdef.vieworg, 1, forward, cg.refdef.vieworg );
ADDRGP4 cg+109252+24
ADDRGP4 cg+109252+24
INDIRF4
CNSTF4 1065353216
ADDRLP4 148
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109252+24+4
ADDRGP4 cg+109252+24+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 148+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109252+24+8
ADDRGP4 cg+109252+24+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 148+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 327
;327:			VectorMA( cg.refdef.vieworg, 24, up, cg.refdef.vieworg );
ADDRGP4 cg+109252+24
ADDRGP4 cg+109252+24
INDIRF4
CNSTF4 1103101952
ADDRLP4 160
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109252+24+4
ADDRGP4 cg+109252+24+4
INDIRF4
CNSTF4 1103101952
ADDRLP4 160+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109252+24+8
ADDRGP4 cg+109252+24+8
INDIRF4
CNSTF4 1103101952
ADDRLP4 160+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 328
;328:		}
line 331
;329:
;330:
;331:	}
ADDRGP4 $304
JUMPV
LABELV $303
line 333
;332:	else
;333:	{
line 334
;334:		if ( focusAngles[PITCH] > 45 ) {
ADDRLP4 60
INDIRF4
CNSTF4 1110704128
LEF4 $411
line 335
;335:			focusAngles[PITCH] = 45;		// don't go too far overhead
ADDRLP4 60
CNSTF4 1110704128
ASGNF4
line 336
;336:		}
LABELV $411
line 337
;337:		AngleVectors( focusAngles, forward, NULL, NULL );
ADDRLP4 60
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 100
CNSTP4 0
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 339
;338:
;339:		VectorMA( cg.refdef.vieworg, FOCUS_DISTANCE, forward, focusPoint );
ADDRLP4 104
CNSTF4 1140850688
ASGNF4
ADDRLP4 12
ADDRGP4 cg+109252+24
INDIRF4
ADDRLP4 104
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 cg+109252+24+4
INDIRF4
ADDRLP4 104
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 cg+109252+24+8
INDIRF4
CNSTF4 1140850688
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 341
;340:
;341:		VectorCopy( cg.refdef.vieworg, view );
ADDRLP4 0
ADDRGP4 cg+109252+24
INDIRB
ASGNB 12
line 343
;342:
;343:		view[2] += 8;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 345
;344:
;345:		cg.refdefViewAngles[PITCH] *= 0.5;
ADDRLP4 108
ADDRGP4 cg+109620
ASGNP4
ADDRLP4 108
INDIRP4
CNSTF4 1056964608
ADDRLP4 108
INDIRP4
INDIRF4
MULF4
ASGNF4
line 347
;346:
;347:		AngleVectors( cg.refdefViewAngles, forward, right, up );
ADDRGP4 cg+109620
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 349
;348:
;349:		forwardScale = cos( cg_thirdPersonAngle.value / 180 * M_PI );
CNSTF4 1078530011
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
CNSTF4 1127481344
DIVF4
MULF4
ARGF4
ADDRLP4 112
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 112
INDIRF4
ASGNF4
line 350
;350:		sideScale = sin( cg_thirdPersonAngle.value / 180 * M_PI );
CNSTF4 1078530011
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
CNSTF4 1127481344
DIVF4
MULF4
ARGF4
ADDRLP4 116
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 116
INDIRF4
ASGNF4
line 351
;351:		VectorMA( view, -range * forwardScale, forward, view );
ADDRLP4 120
ADDRLP4 36
INDIRF4
NEGF4
ADDRLP4 52
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 120
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRLP4 120
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRLP4 36
INDIRF4
NEGF4
ADDRLP4 52
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 352
;352:		VectorMA( view, -range * sideScale, right, view );
ADDRLP4 124
ADDRLP4 36
INDIRF4
NEGF4
ADDRLP4 56
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 36
INDIRF4
NEGF4
ADDRLP4 56
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 373
;353:
;354:		// trace a ray from the origin to the viewpoint to make sure the view isn't
;355:		// in a solid block.  Use an 8 by 8 block to prevent the view from near clipping anything
;356:	/*
;357:		if (!cg_cameraMode.integer) {
;358:			CG_Trace( &trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_SOLID );
;359:
;360:			if ( trace.fraction != 1.0 ) {
;361:				VectorCopy( trace.endpos, view );
;362:				view[2] += (1.0 - trace.fraction) * 32;
;363:				// try another trace to this position, because a tunnel may have the ceiling
;364:				// close enough that this is poking out
;365:
;366:				CG_Trace( &trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_SOLID );
;367:				VectorCopy( trace.endpos, view );
;368:			}
;369:		}
;370:	*/
;371:
;372:
;373:		VectorCopy( view, cg.refdef.vieworg );
ADDRGP4 cg+109252+24
ADDRLP4 0
INDIRB
ASGNB 12
line 376
;374:
;375:		// select pitch to look at focus point from vieword
;376:		VectorSubtract( focusPoint, cg.refdef.vieworg, focusPoint );
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109252+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109252+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109252+24+8
INDIRF4
SUBF4
ASGNF4
line 377
;377:		focusDist = sqrt( focusPoint[0] * focusPoint[0] + focusPoint[1] * focusPoint[1] );
ADDRLP4 128
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 128
INDIRF4
ADDRLP4 128
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 132
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 72
ADDRLP4 132
INDIRF4
ASGNF4
line 378
;378:		if ( focusDist < 1 ) {
ADDRLP4 72
INDIRF4
CNSTF4 1065353216
GEF4 $460
line 379
;379:			focusDist = 1;	// should never happen
ADDRLP4 72
CNSTF4 1065353216
ASGNF4
line 380
;380:		}
LABELV $460
line 381
;381:		cg.refdefViewAngles[PITCH] = -180 / M_PI * atan2( focusPoint[2], focusDist );
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 136
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRGP4 cg+109620
CNSTF4 3261411041
ADDRLP4 136
INDIRF4
MULF4
ASGNF4
line 382
;382:		cg.refdefViewAngles[YAW] -= cg_thirdPersonAngle.value;
ADDRLP4 140
ADDRGP4 cg+109620+4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRF4
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
SUBF4
ASGNF4
line 383
;383:	}
LABELV $304
line 386
;384:
;385:	
;386:}
LABELV $276
endproc CG_OffsetThirdPersonView 176 16
proc CG_StepOffset 8 0
line 390
;387:
;388:
;389:// this causes a compiler bug on mac MrC compiler
;390:static void CG_StepOffset( void ) {
line 394
;391:	int		timeDelta;
;392:	
;393:	// smooth out stair climbing
;394:	timeDelta = cg.time - cg.stepTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109132
INDIRI4
SUBI4
ASGNI4
line 395
;395:	if ( timeDelta < STEP_TIME ) {
ADDRLP4 0
INDIRI4
CNSTI4 200
GEI4 $470
line 396
;396:		cg.refdef.vieworg[2] -= cg.stepChange 
ADDRLP4 4
ADDRGP4 cg+109252+24+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+109128
INDIRF4
CNSTI4 200
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 398
;397:			* (STEP_TIME - timeDelta) / STEP_TIME;
;398:	}
LABELV $470
line 399
;399:}
LABELV $467
endproc CG_StepOffset 8 0
proc CG_OffsetFirstPersonView 116 16
line 407
;400:
;401:/*
;402:===============
;403:CG_OffsetFirstPersonView
;404:
;405:===============
;406:*/
;407:static void CG_OffsetFirstPersonView( void ) {
line 418
;408:	float			*origin;
;409:	float			*angles;
;410:	float			bob;
;411:	float			ratio;
;412:	float			delta;
;413:	float			speed;
;414:	float			f;
;415:	vec3_t			predictedVelocity;
;416:	int				timeDelta;
;417:	
;418:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $477
line 419
;419:		return;
ADDRGP4 $476
JUMPV
LABELV $477
line 422
;420:	}
;421:
;422:	origin = cg.refdef.vieworg;
ADDRLP4 0
ADDRGP4 cg+109252+24
ASGNP4
line 423
;423:	angles = cg.refdefViewAngles;
ADDRLP4 4
ADDRGP4 cg+109620
ASGNP4
line 426
;424:
;425:	// if dead, fix the angle and don't add any kick
;426:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $483
line 427
;427:		angles[ROLL] = 40;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1109393408
ASGNF4
line 428
;428:		angles[PITCH] = -15;
ADDRLP4 4
INDIRP4
CNSTF4 3245342720
ASGNF4
line 429
;429:		angles[YAW] = cg.snap->ps.stats[STAT_DEAD_YAW];
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 430
;430:		origin[2] += cg.predictedPlayerState.viewheight;
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
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 431
;431:		return;
ADDRGP4 $476
JUMPV
LABELV $483
line 435
;432:	}
;433:
;434:	// add angles based on weapon kick
;435:	VectorAdd (angles, cg.kick_angles, angles);
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+125336
INDIRF4
ADDF4
ASGNF4
ADDRLP4 48
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRGP4 cg+125336+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 52
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRGP4 cg+125336+8
INDIRF4
ADDF4
ASGNF4
line 438
;436:
;437:	// add angles based on damage kick
;438:	if ( cg.damageTime && !CG_IsARoundBasedGametype(cgs.gametype)) {
ADDRGP4 cg+125280
INDIRF4
CNSTF4 0
EQF4 $494
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $494
line 439
;439:		ratio = cg.time - cg.damageTime;
ADDRLP4 24
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+125280
INDIRF4
SUBF4
ASGNF4
line 440
;440:		if ( ratio < DAMAGE_DEFLECT_TIME ) {
ADDRLP4 24
INDIRF4
CNSTF4 1120403456
GEF4 $500
line 441
;441:			ratio /= DAMAGE_DEFLECT_TIME;
ADDRLP4 24
ADDRLP4 24
INDIRF4
CNSTF4 1120403456
DIVF4
ASGNF4
line 442
;442:			angles[PITCH] += ratio * cg.v_dmg_pitch * cg_kickScale.value;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRGP4 cg+125328
INDIRF4
MULF4
ADDRGP4 cg_kickScale+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 443
;443:			angles[ROLL] += ratio * cg.v_dmg_roll * cg_kickScale.value;
ADDRLP4 64
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRGP4 cg+125332
INDIRF4
MULF4
ADDRGP4 cg_kickScale+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 444
;444:		} else {
ADDRGP4 $501
JUMPV
LABELV $500
line 445
;445:			ratio = 1.0 - ( ratio - DAMAGE_DEFLECT_TIME ) / DAMAGE_RETURN_TIME;
ADDRLP4 24
CNSTF4 1065353216
ADDRLP4 24
INDIRF4
CNSTF4 1120403456
SUBF4
CNSTF4 1137180672
DIVF4
SUBF4
ASGNF4
line 446
;446:			if ( ratio > 0 ) {
ADDRLP4 24
INDIRF4
CNSTF4 0
LEF4 $506
line 447
;447:				angles[PITCH] += ratio * cg.v_dmg_pitch * cg_kickScale.value;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRGP4 cg+125328
INDIRF4
MULF4
ADDRGP4 cg_kickScale+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 448
;448:				angles[ROLL] += ratio * cg.v_dmg_roll * cg_kickScale.value;
ADDRLP4 64
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRGP4 cg+125332
INDIRF4
MULF4
ADDRGP4 cg_kickScale+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 449
;449:			}
LABELV $506
line 450
;450:		}
LABELV $501
line 451
;451:	}
LABELV $494
line 462
;452:
;453:	// add pitch based on fall kick
;454:#if 0
;455:	ratio = ( cg.time - cg.landTime) / FALL_TIME;
;456:	if (ratio < 0)
;457:		ratio = 0;
;458:	angles[PITCH] += ratio * cg.fall_value;
;459:#endif
;460:
;461:	// add angles based on velocity
;462:	VectorCopy( cg.predictedPlayerState.velocity, predictedVelocity );
ADDRLP4 12
ADDRGP4 cg+107636+32
INDIRB
ASGNB 12
line 464
;463:
;464:	delta = DotProduct ( predictedVelocity, cg.refdef.viewaxis[0]);
ADDRLP4 8
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109252+36
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109252+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109252+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 465
;465:	angles[PITCH] += delta * cg_runpitch.value;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 cg_runpitch+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 467
;466:	
;467:	delta = DotProduct ( predictedVelocity, cg.refdef.viewaxis[1]);
ADDRLP4 8
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109252+36+12
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109252+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109252+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 468
;468:	angles[ROLL] -= delta * cg_runroll.value;
ADDRLP4 64
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 cg_runroll+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 472
;469:
;470:	// add angles based on bob
;471:
;472:	if ( cg_bob.integer == 6 ) // leilei - sweeney bob
ADDRGP4 cg_bob+12
INDIRI4
CNSTI4 6
NEI4 $539
line 473
;473:	{
line 475
;474:		vec3_t		forward, right, up;
;475:		speed = cg.xyspeed;
ADDRLP4 28
ADDRGP4 cg+125372
INDIRF4
ASGNF4
line 476
;476:		if (speed > 320) {
ADDRLP4 28
INDIRF4
CNSTF4 1134559232
LEF4 $543
line 477
;477:			speed = 320;
ADDRLP4 28
CNSTF4 1134559232
ASGNF4
line 478
;478:		}
LABELV $543
line 479
;479:		delta = cg.bobfracsin * 0.006 * speed;
ADDRLP4 8
CNSTF4 1002740646
ADDRGP4 cg+125360
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 480
;480:		if (cg.bobcycle & 1) {
ADDRGP4 cg+125364
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $546
line 481
;481:			delta = -delta;
ADDRLP4 8
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
line 482
;482:		}
LABELV $546
line 483
;483:		AngleVectors (angles, forward, right, up);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 92
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 484
;484:		VectorMA (origin, delta, right, origin);
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 68
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 108
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 68+4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
ADDRLP4 68+8
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 485
;485:	}
ADDRGP4 $540
JUMPV
LABELV $539
line 486
;486:	else if ( cg_bob.integer ) 
ADDRGP4 cg_bob+12
INDIRI4
CNSTI4 0
EQI4 $551
line 487
;487:	{
line 489
;488:		// make sure the bob is visible even at low speeds
;489:		speed = cg.xyspeed > 200 ? cg.xyspeed : 200;
ADDRGP4 cg+125372
INDIRF4
CNSTF4 1128792064
LEF4 $557
ADDRLP4 68
ADDRGP4 cg+125372
INDIRF4
ASGNF4
ADDRGP4 $558
JUMPV
LABELV $557
ADDRLP4 68
CNSTF4 1128792064
ASGNF4
LABELV $558
ADDRLP4 28
ADDRLP4 68
INDIRF4
ASGNF4
line 491
;490:
;491:		delta = cg.bobfracsin * cg_bobpitch.value * speed;
ADDRLP4 8
ADDRGP4 cg+125360
INDIRF4
ADDRGP4 cg_bobpitch+8
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 492
;492:		if (cg.predictedPlayerState.pm_flags & PMF_DUCKED) {
ADDRGP4 cg+107636+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $561
line 493
;493:			delta *= 3;		// crouching
ADDRLP4 8
CNSTF4 1077936128
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 494
;494:		}
LABELV $561
line 496
;495:		// leilei - no pitch for 3 or 4
;496:		if ( cg_bob.integer == 1 || cg_bob.integer == 2 ) {
ADDRGP4 cg_bob+12
INDIRI4
CNSTI4 1
EQI4 $569
ADDRGP4 cg_bob+12
INDIRI4
CNSTI4 2
NEI4 $565
LABELV $569
line 497
;497:			angles[PITCH] += delta;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ASGNF4
line 498
;498:		}
LABELV $565
line 499
;499:		delta = cg.bobfracsin * cg_bobroll.value * speed;
ADDRLP4 8
ADDRGP4 cg+125360
INDIRF4
ADDRGP4 cg_bobroll+8
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 500
;500:		if (cg.predictedPlayerState.pm_flags & PMF_DUCKED) {
ADDRGP4 cg+107636+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $572
line 501
;501:			delta *= 3;		// crouching accentuates roll
ADDRLP4 8
CNSTF4 1077936128
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 502
;502:		}
LABELV $572
line 503
;503:		if (cg.bobcycle & 1) {
ADDRGP4 cg+125364
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $576
line 504
;504:			delta = -delta;
ADDRLP4 8
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
line 505
;505:		}
LABELV $576
line 507
;506:		// leilei - no roll for 2 or 4
;507:		if ( cg_bob.integer == 1 || cg_bob.integer == 3 || cg_bob.integer == 5 ) {
ADDRGP4 cg_bob+12
INDIRI4
CNSTI4 1
EQI4 $585
ADDRGP4 cg_bob+12
INDIRI4
CNSTI4 3
EQI4 $585
ADDRGP4 cg_bob+12
INDIRI4
CNSTI4 5
NEI4 $579
LABELV $585
line 508
;508:			angles[ROLL] += delta;
ADDRLP4 72
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ASGNF4
line 509
;509:		}
LABELV $579
line 510
;510:	}
LABELV $551
LABELV $540
line 515
;511:
;512://===================================
;513:
;514:	// add view height
;515:	origin[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 518
;516:
;517:	// smooth out duck height changes
;518:	timeDelta = cg.time - cg.duckTime;
ADDRLP4 32
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109140
INDIRI4
SUBI4
ASGNI4
line 519
;519:	if ( timeDelta < DUCK_TIME) {
ADDRLP4 32
INDIRI4
CNSTI4 100
GEI4 $590
line 520
;520:		cg.refdef.vieworg[2] -= cg.duckChange 
ADDRLP4 72
ADDRGP4 cg+109252+24+8
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRGP4 cg+109136
INDIRF4
CNSTI4 100
ADDRLP4 32
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1120403456
DIVF4
SUBF4
ASGNF4
line 522
;521:			* (DUCK_TIME - timeDelta) / DUCK_TIME;
;522:	}
LABELV $590
line 524
;523:
;524:	if ( cg_bob.integer ) {
ADDRGP4 cg_bob+12
INDIRI4
CNSTI4 0
EQI4 $596
line 526
;525:		// add bob height
;526:		bob = cg.bobfracsin * cg.xyspeed * cg_bobup.value;
ADDRLP4 36
ADDRGP4 cg+125360
INDIRF4
ADDRGP4 cg+125372
INDIRF4
MULF4
ADDRGP4 cg_bobup+8
INDIRF4
MULF4
ASGNF4
line 527
;527:		if (bob > 6) {
ADDRLP4 36
INDIRF4
CNSTF4 1086324736
LEF4 $602
line 528
;528:			bob = 6;
ADDRLP4 36
CNSTF4 1086324736
ASGNF4
line 529
;529:		}
LABELV $602
line 530
;530:		origin[2] += bob;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
line 531
;531:	}
LABELV $596
line 534
;532:
;533:	// add fall height
;534:	delta = cg.time - cg.landTime;
ADDRLP4 8
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109148
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 535
;535:	if ( delta < LAND_DEFLECT_TIME ) {
ADDRLP4 8
INDIRF4
CNSTF4 1125515264
GEF4 $606
line 536
;536:		f = delta / LAND_DEFLECT_TIME;
ADDRLP4 40
ADDRLP4 8
INDIRF4
CNSTF4 1125515264
DIVF4
ASGNF4
line 537
;537:		cg.refdef.vieworg[2] += cg.landChange * f;
ADDRLP4 72
ADDRGP4 cg+109252+24+8
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRGP4 cg+109144
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
line 538
;538:	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
ADDRGP4 $607
JUMPV
LABELV $606
ADDRLP4 8
INDIRF4
CNSTF4 1138819072
GEF4 $612
line 539
;539:		delta -= LAND_DEFLECT_TIME;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1125515264
SUBF4
ASGNF4
line 540
;540:		f = 1.0 - ( delta / LAND_RETURN_TIME );
ADDRLP4 40
CNSTF4 1065353216
ADDRLP4 8
INDIRF4
CNSTF4 1133903872
DIVF4
SUBF4
ASGNF4
line 541
;541:		cg.refdef.vieworg[2] += cg.landChange * f;
ADDRLP4 72
ADDRGP4 cg+109252+24+8
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRGP4 cg+109144
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
line 542
;542:	}
LABELV $612
LABELV $607
line 545
;543:
;544:	// add step offset
;545:	CG_StepOffset();
ADDRGP4 CG_StepOffset
CALLV
pop
line 549
;546:
;547:	// add kick offset
;548:
;549:	VectorAdd (origin, cg.kick_origin, origin);
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 cg+125348
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRGP4 cg+125348+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 80
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRGP4 cg+125348+8
INDIRF4
ADDF4
ASGNF4
line 563
;550:
;551:	// pivot the eye based on a neck length
;552:#if 0
;553:	{
;554:#define	NECK_LENGTH		8
;555:	vec3_t			forward, up;
;556: 
;557:	cg.refdef.vieworg[2] -= NECK_LENGTH;
;558:	AngleVectors( cg.refdefViewAngles, forward, NULL, up );
;559:	VectorMA( cg.refdef.vieworg, 3, forward, cg.refdef.vieworg );
;560:	VectorMA( cg.refdef.vieworg, NECK_LENGTH, up, cg.refdef.vieworg );
;561:	}
;562:#endif
;563:}
LABELV $476
endproc CG_OffsetFirstPersonView 116 16
export CG_ZoomDown_f
proc CG_ZoomDown_f 0 0
line 567
;564:
;565://======================================================================
;566:
;567:void CG_ZoomDown_f( void ) { 
line 568
;568:	if ( cg.zoomed ) {
ADDRGP4 cg+109632
INDIRI4
CNSTI4 0
EQI4 $624
line 569
;569:		return;
ADDRGP4 $623
JUMPV
LABELV $624
line 571
;570:	}
;571:	cg.zoomed = qtrue;
ADDRGP4 cg+109632
CNSTI4 1
ASGNI4
line 572
;572:	cg.zoomTime = cg.time;
ADDRGP4 cg+109636
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 573
;573:}
LABELV $623
endproc CG_ZoomDown_f 0 0
export CG_ZoomUp_f
proc CG_ZoomUp_f 0 0
line 575
;574:
;575:void CG_ZoomUp_f( void ) { 
line 576
;576:	if ( !cg.zoomed ) {
ADDRGP4 cg+109632
INDIRI4
CNSTI4 0
NEI4 $631
line 577
;577:		return;
ADDRGP4 $630
JUMPV
LABELV $631
line 579
;578:	}
;579:	cg.zoomed = qfalse;
ADDRGP4 cg+109632
CNSTI4 0
ASGNI4
line 580
;580:	cg.zoomTime = cg.time;
ADDRGP4 cg+109636
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 581
;581:}
LABELV $630
endproc CG_ZoomUp_f 0 0
proc CG_CalcFov 52 8
line 594
;582:
;583:
;584:/*
;585:====================
;586:CG_CalcFov
;587:
;588:Fixed fov at intermissions, otherwise account for fov variable and zooms.
;589:====================
;590:*/
;591:#define	WAVE_AMPLITUDE	1
;592:#define	WAVE_FREQUENCY	0.4
;593:
;594:static int CG_CalcFov( void ) {
line 604
;595:	float	x;
;596:	float	phase;
;597:	float	v;
;598:	int		contents;
;599:	float	fov_x, fov_y;
;600:	float	zoomFov;
;601:	float	f;
;602:	int		inwater;
;603:
;604:	if ( cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 5
NEI4 $638
line 606
;605:		// if in intermission, use a fixed value
;606:		fov_x = 90;
ADDRLP4 0
CNSTF4 1119092736
ASGNF4
line 607
;607:	} else {
ADDRGP4 $639
JUMPV
LABELV $638
line 609
;608:		// user selectable
;609:		if ( cgs.dmflags & DF_FIXED_FOV ) {
ADDRGP4 cgs+31460
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $642
line 611
;610:			// dmflag to prevent wide fov for all clients
;611:			fov_x = 90;
ADDRLP4 0
CNSTF4 1119092736
ASGNF4
line 612
;612:		} else {
ADDRGP4 $643
JUMPV
LABELV $642
line 613
;613:			fov_x = cg_fov.value;
ADDRLP4 0
ADDRGP4 cg_fov+8
INDIRF4
ASGNF4
line 614
;614:			if ( fov_x < 1 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $646
line 615
;615:				fov_x = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 616
;616:			} 
ADDRGP4 $647
JUMPV
LABELV $646
line 617
;617:			else if ( fov_x > 160 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1126170624
LEF4 $648
line 618
;618:				fov_x = 160;
ADDRLP4 0
CNSTF4 1126170624
ASGNF4
line 619
;619:			}
LABELV $648
LABELV $647
line 620
;620:			if( (cgs.videoflags & VF_LOCK_CVARS_BASIC) && fov_x>140 ) {
ADDRGP4 cgs+31464
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $650
ADDRLP4 0
INDIRF4
CNSTF4 1124859904
LEF4 $650
line 621
;621:				fov_x = 140;
ADDRLP4 0
CNSTF4 1124859904
ASGNF4
line 622
;622:			}
LABELV $650
line 624
;623:
;624:		}
LABELV $643
line 626
;625:
;626:		if ( cgs.dmflags & DF_FIXED_FOV ) {
ADDRGP4 cgs+31460
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $653
line 628
;627:			// dmflag to prevent wide fov for all clients
;628:			zoomFov = 22.5;
ADDRLP4 20
CNSTF4 1102315520
ASGNF4
line 629
;629:		} 
ADDRGP4 $654
JUMPV
LABELV $653
line 630
;630:		else {
line 632
;631:			// account for zooms
;632:			zoomFov = cg_zoomFov.value;
ADDRLP4 20
ADDRGP4 cg_zoomFov+8
INDIRF4
ASGNF4
line 633
;633:			if ( zoomFov < 1 ) {
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
GEF4 $657
line 634
;634:				zoomFov = 1;
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
line 635
;635:			} 
ADDRGP4 $658
JUMPV
LABELV $657
line 636
;636:			else if ( zoomFov > 160 ) {
ADDRLP4 20
INDIRF4
CNSTF4 1126170624
LEF4 $659
line 637
;637:				zoomFov = 160;
ADDRLP4 20
CNSTF4 1126170624
ASGNF4
line 638
;638:			}
LABELV $659
LABELV $658
line 640
;639:
;640:			if( (cgs.videoflags & VF_LOCK_CVARS_BASIC) && zoomFov>140 ) {
ADDRGP4 cgs+31464
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $661
ADDRLP4 20
INDIRF4
CNSTF4 1124859904
LEF4 $661
line 641
;641:				zoomFov = 140;
ADDRLP4 20
CNSTF4 1124859904
ASGNF4
line 642
;642:			}
LABELV $661
line 643
;643:		}
LABELV $654
line 645
;644:
;645:		if ( cg.zoomed ) {
ADDRGP4 cg+109632
INDIRI4
CNSTI4 0
EQI4 $664
line 646
;646:			f = ( cg.time - cg.zoomTime ) / (float)ZOOM_TIME;
ADDRLP4 28
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109636
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1125515264
DIVF4
ASGNF4
line 647
;647:			if ( f > 1.0 ) {
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
LEF4 $669
line 648
;648:				fov_x = zoomFov;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 649
;649:			} 
ADDRGP4 $665
JUMPV
LABELV $669
line 650
;650:			else {
line 651
;651:				fov_x = fov_x + f * ( zoomFov - fov_x );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 652
;652:			}
line 653
;653:		}
ADDRGP4 $665
JUMPV
LABELV $664
line 654
;654:		else {
line 655
;655:			f = ( cg.time - cg.zoomTime ) / (float)ZOOM_TIME;
ADDRLP4 28
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109636
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1125515264
DIVF4
ASGNF4
line 656
;656:			if ( f > 1.0 ) {
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
LEF4 $673
line 657
;657:			} 
ADDRGP4 $674
JUMPV
LABELV $673
line 658
;658:			else {
line 659
;659:				fov_x = zoomFov + f * ( fov_x - zoomFov );
ADDRLP4 36
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 660
;660:			}
LABELV $674
line 661
;661:		}
LABELV $665
line 662
;662:	}
LABELV $639
line 664
;663:
;664:	if (cg_cameramode.integer == 1 && cg_thirdPerson.integer){
ADDRGP4 cg_cameramode+12
INDIRI4
CNSTI4 1
NEI4 $675
ADDRGP4 cg_thirdPerson+12
INDIRI4
CNSTI4 0
EQI4 $675
line 666
;665:		// fov scaling for the modern third person view
;666:		fov_x = fov_x * 0.93 * (cg.xyspeed * (0.0006) + 1);
ADDRLP4 0
CNSTF4 1064178811
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 974997842
ADDRGP4 cg+125372
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 667
;667:	}
LABELV $675
line 669
;668:
;669:	x = cg.refdef.width / tan( fov_x / 360 * M_PI );
CNSTF4 1078530011
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 8
ADDRGP4 cg+109252+8
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
DIVF4
ASGNF4
line 670
;670:	fov_y = atan2( cg.refdef.height, x );
ADDRGP4 cg+109252+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 40
INDIRF4
ASGNF4
line 671
;671:	fov_y = fov_y * 360 / M_PI;
ADDRLP4 4
CNSTF4 1135869952
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 674
;672:
;673:	// warp if underwater
;674:	contents = CG_PointContents( cg.refdef.vieworg, -1 );
ADDRGP4 cg+109252+24
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 44
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 675
;675:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ){
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $686
line 676
;676:		phase = cg.time / 1000.0 * WAVE_FREQUENCY * M_PI * 2;
ADDRLP4 32
CNSTF4 1073741824
CNSTF4 1078530011
CNSTF4 1053609165
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
MULF4
MULF4
MULF4
ASGNF4
line 677
;677:		v = WAVE_AMPLITUDE * sin( phase );
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 24
CNSTF4 1065353216
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 678
;678:		fov_x += v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 679
;679:		fov_y -= v;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
ASGNF4
line 680
;680:		inwater = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 681
;681:	}
ADDRGP4 $687
JUMPV
LABELV $686
line 682
;682:	else {
line 683
;683:		inwater = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 684
;684:	}
LABELV $687
line 688
;685:
;686:
;687:	// set it
;688:	cg.refdef.fov_x = fov_x;
ADDRGP4 cg+109252+16
ADDRLP4 0
INDIRF4
ASGNF4
line 689
;689:	cg.refdef.fov_y = fov_y;
ADDRGP4 cg+109252+20
ADDRLP4 4
INDIRF4
ASGNF4
line 691
;690:
;691:	if ( !cg.zoomed ) {
ADDRGP4 cg+109632
INDIRI4
CNSTI4 0
NEI4 $693
line 692
;692:		cg.zoomSensitivity = 1;
ADDRGP4 cg+109640
CNSTF4 1065353216
ASGNF4
line 693
;693:	} 
ADDRGP4 $694
JUMPV
LABELV $693
line 694
;694:	else {
line 695
;695:		cg.zoomSensitivity = cg.refdef.fov_y / 75.0;
ADDRGP4 cg+109640
ADDRGP4 cg+109252+20
INDIRF4
CNSTF4 1117126656
DIVF4
ASGNF4
line 696
;696:	}
LABELV $694
line 698
;697:
;698:	return inwater;
ADDRLP4 16
INDIRI4
RETI4
LABELV $637
endproc CG_CalcFov 52 8
proc CG_DamageBlendBlob 200 12
line 709
;699:}
;700:
;701:
;702:
;703:/*
;704:===============
;705:CG_DamageBlendBlob
;706:
;707:===============
;708:*/
;709:static void CG_DamageBlendBlob( void ) {
line 714
;710:	int			t;
;711:	int			maxTime;
;712:	refEntity_t		ent;
;713:
;714:	if ( !cg.damageValue ) {
ADDRGP4 cg+125292
INDIRF4
CNSTF4 0
NEF4 $701
line 715
;715:		return;
ADDRGP4 $700
JUMPV
LABELV $701
line 718
;716:	}
;717:
;718:	if (cg.cameraMode) {
ADDRGP4 cg+125380
INDIRI4
CNSTI4 0
EQI4 $704
line 719
;719:		return;
ADDRGP4 $700
JUMPV
LABELV $704
line 723
;720:	}
;721:
;722:	// ragePro systems can't fade blends, so don't obscure the screen
;723:	if ( cgs.glconfig.hardwareType == GLHW_RAGEPRO ) {
ADDRGP4 cgs+20100+11288
INDIRI4
CNSTI4 3
NEI4 $707
line 724
;724:		return;
ADDRGP4 $700
JUMPV
LABELV $707
line 727
;725:	}
;726:
;727:	maxTime = DAMAGE_TIME;
ADDRLP4 180
CNSTI4 500
ASGNI4
line 728
;728:	t = cg.time - cg.damageTime;
ADDRLP4 176
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+125280
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 729
;729:	if ( t <= 0 || t >= maxTime ) {
ADDRLP4 176
INDIRI4
CNSTI4 0
LEI4 $715
ADDRLP4 176
INDIRI4
ADDRLP4 180
INDIRI4
LTI4 $713
LABELV $715
line 730
;730:		return;
ADDRGP4 $700
JUMPV
LABELV $713
line 734
;731:	}
;732:
;733:
;734:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 735
;735:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 736
;736:	ent.renderfx = RF_FIRST_PERSON;
ADDRLP4 0+4
CNSTI4 4
ASGNI4
line 738
;737:
;738:	VectorMA( cg.refdef.vieworg, 8, cg.refdef.viewaxis[0], ent.origin );
ADDRLP4 0+68
ADDRGP4 cg+109252+24
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+109252+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRGP4 cg+109252+24+4
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+109252+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRGP4 cg+109252+24+8
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+109252+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 739
;739:	VectorMA( ent.origin, cg.damageX * -8, cg.refdef.viewaxis[1], ent.origin );
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109252+36+12
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+125284
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109252+36+12+4
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+125284
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109252+36+12+8
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+125284
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 740
;740:	VectorMA( ent.origin, cg.damageY * 8, cg.refdef.viewaxis[2], ent.origin );
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109252+36+24
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+125288
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109252+36+24+4
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+125288
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109252+36+24+8
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+125288
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 742
;741:
;742:	ent.radius = cg.damageValue * 3;
ADDRLP4 0+132
CNSTF4 1077936128
ADDRGP4 cg+125292
INDIRF4
MULF4
ASGNF4
line 743
;743:	ent.customShader = cgs.media.viewBloodShader;
ADDRLP4 0+112
ADDRGP4 cgs+180268+280
INDIRI4
ASGNI4
line 744
;744:	ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 745
;745:	ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 746
;746:	ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 747
;747:	ent.shaderRGBA[3] = 200 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 192
CNSTF4 1128792064
CNSTF4 1065353216
ADDRLP4 176
INDIRI4
CVIF4 4
ADDRLP4 180
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 196
CNSTF4 1325400064
ASGNF4
ADDRLP4 192
INDIRF4
ADDRLP4 196
INDIRF4
LTF4 $799
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
ADDRGP4 $800
JUMPV
LABELV $799
ADDRLP4 188
ADDRLP4 192
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $800
ADDRLP4 0+116+3
ADDRLP4 188
INDIRU4
CVUU1 4
ASGNU1
line 748
;748:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 749
;749:}
LABELV $700
endproc CG_DamageBlendBlob 200 12
proc CG_CalcViewValues 88 16
line 759
;750:
;751:
;752:/*
;753:===============
;754:CG_CalcViewValues
;755:
;756:Sets cg.refdef view values
;757:===============
;758:*/
;759:static int CG_CalcViewValues( void ) {
line 762
;760:	playerState_t	*ps;
;761:
;762:	memset( &cg.refdef, 0, sizeof( cg.refdef ) );
ADDRGP4 cg+109252
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 769
;763:
;764:	// strings for in game rendering
;765:	// Q_strncpyz( cg.refdef.text[0], "Park Ranger", sizeof(cg.refdef.text[0]) );
;766:	// Q_strncpyz( cg.refdef.text[1], "19", sizeof(cg.refdef.text[1]) );
;767:
;768:	// calculate size of 3D view
;769:	CG_CalcVrect();
ADDRGP4 CG_CalcVrect
CALLV
pop
line 771
;770:
;771:	ps = &cg.predictedPlayerState;
ADDRLP4 0
ADDRGP4 cg+107636
ASGNP4
line 774
;772:
;773:	// intermission view
;774:	if ( ps->pm_type == PM_INTERMISSION ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
NEI4 $805
line 775
;775:		VectorCopy( ps->origin, cg.refdef.vieworg );
ADDRGP4 cg+109252+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 776
;776:		VectorCopy( ps->viewangles, cg.refdefViewAngles );
ADDRGP4 cg+109620
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 777
;777:		AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
ADDRGP4 cg+109620
ARGP4
ADDRGP4 cg+109252+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 778
;778:		return CG_CalcFov();
ADDRLP4 4
ADDRGP4 CG_CalcFov
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $801
JUMPV
LABELV $805
line 781
;779:	}
;780:
;781:	cg.bobcycle = ( ps->bobCycle & 128 ) >> 7;
ADDRGP4 cg+125364
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 7
RSHI4
ASGNI4
line 782
;782:	cg.bobfracsin = fabs( sin( ( ps->bobCycle & 127 ) / 127.0 * M_PI ) );
CNSTF4 1078530011
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 127
BANDI4
CVIF4 4
CNSTF4 1123942400
DIVF4
MULF4
ARGF4
ADDRLP4 4
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRGP4 cg+125360
ADDRLP4 8
INDIRF4
ASGNF4
line 784
;783:
;784:	cg.bobfraccos = fabs( cos( ( ps->bobCycle & 127 ) / 127.0 * M_PI ) );
CNSTF4 1078530011
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 127
BANDI4
CVIF4 4
CNSTF4 1123942400
DIVF4
MULF4
ARGF4
ADDRLP4 12
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRGP4 cg+156544
ADDRLP4 16
INDIRF4
ASGNF4
line 785
;785:	cg.bobfracsin2 = fabs( sin( ( ps->bobCycle & 127) / 127.0 * (M_PI) ));
CNSTF4 1078530011
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 127
BANDI4
CVIF4 4
CNSTF4 1123942400
DIVF4
MULF4
ARGF4
ADDRLP4 20
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRGP4 cg+156548
ADDRLP4 24
INDIRF4
ASGNF4
line 787
;786:
;787:	cg.xyspeed = sqrt( ps->velocity[0] * ps->velocity[0] +
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDRLP4 36
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRGP4 cg+125372
ADDRLP4 40
INDIRF4
ASGNF4
line 790
;788:		ps->velocity[1] * ps->velocity[1] );
;789:
;790:	cg.bobcycle2 = ps->bobCycle; // leilei - copy the bobcycle so we can use it directly elsewhere
ADDRGP4 cg+125368
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 792
;791:
;792:	VectorCopy( ps->origin, cg.refdef.vieworg );
ADDRGP4 cg+109252+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 793
;793:	VectorCopy( ps->viewangles, cg.refdefViewAngles );
ADDRGP4 cg+109620
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 795
;794:
;795:	if (cg_cameraOrbit.integer) {
ADDRGP4 cg_cameraOrbit+12
INDIRI4
CNSTI4 0
EQI4 $822
line 796
;796:		if (cg.time > cg.nextOrbitTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125376
INDIRI4
LEI4 $825
line 797
;797:			cg.nextOrbitTime = cg.time + cg_cameraOrbitDelay.integer;
ADDRGP4 cg+125376
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg_cameraOrbitDelay+12
INDIRI4
ADDI4
ASGNI4
line 798
;798:			cg_thirdPersonAngle.value += cg_cameraOrbit.value;
ADDRLP4 44
ADDRGP4 cg_thirdPersonAngle+8
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRGP4 cg_cameraOrbit+8
INDIRF4
ADDF4
ASGNF4
line 799
;799:		}
LABELV $825
line 800
;800:	}
LABELV $822
line 802
;801:	// add error decay
;802:	if ( cg_errorDecay.value > 0 ) {
ADDRGP4 cg_errorDecay+8
INDIRF4
CNSTF4 0
LEF4 $834
line 806
;803:		int		t;
;804:		float	f;
;805:
;806:		t = cg.time - cg.predictedErrorTime;
ADDRLP4 48
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109044
INDIRI4
SUBI4
ASGNI4
line 807
;807:		f = ( cg_errorDecay.value - t ) / cg_errorDecay.value;
ADDRLP4 44
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 48
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 808
;808:		if ( f > 0 && f < 1 ) {
ADDRLP4 52
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 0
LEF4 $841
ADDRLP4 52
INDIRF4
CNSTF4 1065353216
GEF4 $841
line 809
;809:			VectorMA( cg.refdef.vieworg, f, cg.predictedError, cg.refdef.vieworg );
ADDRGP4 cg+109252+24
ADDRGP4 cg+109252+24
INDIRF4
ADDRGP4 cg+109048
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109252+24+4
ADDRGP4 cg+109252+24+4
INDIRF4
ADDRGP4 cg+109048+4
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109252+24+8
ADDRGP4 cg+109252+24+8
INDIRF4
ADDRGP4 cg+109048+8
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDF4
ASGNF4
line 810
;810:		} else {
ADDRGP4 $842
JUMPV
LABELV $841
line 811
;811:			cg.predictedErrorTime = 0;
ADDRGP4 cg+109044
CNSTI4 0
ASGNI4
line 812
;812:		}
LABELV $842
line 813
;813:	}
LABELV $834
line 815
;814:
;815:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $865
line 817
;816:		// back away from character
;817:		CG_OffsetThirdPersonView();
ADDRGP4 CG_OffsetThirdPersonView
CALLV
pop
line 818
;818:	} else {
ADDRGP4 $866
JUMPV
LABELV $865
line 820
;819:		// offset for local bobbing and kicks
;820:		CG_OffsetFirstPersonView();
ADDRGP4 CG_OffsetFirstPersonView
CALLV
pop
line 821
;821:	}
LABELV $866
line 824
;822:
;823:	// leilei - View-from-the-model-eyes feature, aka "fullbody awareness" lol
;824:	if (cg_cameraEyes.integer && !cg.renderingThirdPerson){
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRGP4 cg_cameraEyes+12
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $868
ADDRGP4 cg+107628
INDIRI4
ADDRLP4 44
INDIRI4
NEI4 $868
line 826
;825:		vec3_t		forward, up;	
;826:		cg.refdefViewAngles[ROLL] = headang[ROLL];
ADDRGP4 cg+109620+8
ADDRGP4 headang+8
INDIRF4
ASGNF4
line 827
;827:		cg.refdefViewAngles[PITCH] = headang[PITCH];
ADDRGP4 cg+109620
ADDRGP4 headang
INDIRF4
ASGNF4
line 828
;828:		cg.refdefViewAngles[YAW] = headang[YAW];
ADDRGP4 cg+109620+4
ADDRGP4 headang+4
INDIRF4
ASGNF4
line 830
;829:
;830:		AngleVectors( headang, forward, NULL, up );
ADDRGP4 headang
ARGP4
ADDRLP4 48
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 60
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 831
;831:		if (cg_cameraEyes.integer == 2){
ADDRGP4 cg_cameraEyes+12
INDIRI4
CNSTI4 2
NEI4 $879
line 832
;832:			VectorMA( headpos, 0, forward, headpos );
ADDRLP4 72
ADDRGP4 headpos
ASGNP4
ADDRLP4 76
CNSTF4 0
ASGNF4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 76
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 headpos+4
ADDRGP4 headpos+4
INDIRF4
ADDRLP4 76
INDIRF4
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 headpos+8
ADDRGP4 headpos+8
INDIRF4
CNSTF4 0
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 833
;833:			VectorMA( headpos, 4, up, headpos );
ADDRLP4 80
ADDRGP4 headpos
ASGNP4
ADDRLP4 84
CNSTF4 1082130432
ASGNF4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 headpos+4
ADDRGP4 headpos+4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 60+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 headpos+8
ADDRGP4 headpos+8
INDIRF4
CNSTF4 1082130432
ADDRLP4 60+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 834
;834:		}
ADDRGP4 $880
JUMPV
LABELV $879
line 836
;835:		else
;836:		{
line 837
;837:			VectorMA( headpos, cg_cameraEyes_Fwd.value, forward, headpos );
ADDRLP4 72
ADDRGP4 headpos
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 48
INDIRF4
ADDRGP4 cg_cameraEyes_Fwd+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 headpos+4
ADDRGP4 headpos+4
INDIRF4
ADDRLP4 48+4
INDIRF4
ADDRGP4 cg_cameraEyes_Fwd+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 headpos+8
ADDRGP4 headpos+8
INDIRF4
ADDRLP4 48+8
INDIRF4
ADDRGP4 cg_cameraEyes_Fwd+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 838
;838:			VectorMA( headpos, cg_cameraEyes_Up.value, up, headpos );
ADDRLP4 76
ADDRGP4 headpos
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 60
INDIRF4
ADDRGP4 cg_cameraEyes_Up+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 headpos+4
ADDRGP4 headpos+4
INDIRF4
ADDRLP4 60+4
INDIRF4
ADDRGP4 cg_cameraEyes_Up+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 headpos+8
ADDRGP4 headpos+8
INDIRF4
ADDRLP4 60+8
INDIRF4
ADDRGP4 cg_cameraEyes_Up+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 839
;839:		}
LABELV $880
line 841
;840:
;841:		cg.refdef.vieworg[0] = ps->origin[0] + headpos[0];
ADDRGP4 cg+109252+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 headpos
INDIRF4
ADDF4
ASGNF4
line 842
;842:		cg.refdef.vieworg[1] = ps->origin[1] + headpos[1];
ADDRGP4 cg+109252+24+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 headpos+4
INDIRF4
ADDF4
ASGNF4
line 843
;843:		cg.refdef.vieworg[2] = ps->origin[2] + headpos[2];
ADDRGP4 cg+109252+24+8
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 headpos+8
INDIRF4
ADDF4
ASGNF4
line 845
;844:		
;845:	}
LABELV $868
line 848
;846:
;847:	// position eye reletive to origin
;848:	AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
ADDRGP4 cg+109620
ARGP4
ADDRGP4 cg+109252+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 850
;849:
;850:	if ( cg.hyperspace ) {
ADDRGP4 cg+107632
INDIRI4
CNSTI4 0
EQI4 $925
line 851
;851:		cg.refdef.rdflags |= RDF_NOWORLDMODEL | RDF_HYPERSPACE;
ADDRLP4 48
ADDRGP4 cg+109252+76
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 5
BORI4
ASGNI4
line 852
;852:	}
LABELV $925
line 855
;853:
;854:	// field of view
;855:	return CG_CalcFov();
ADDRLP4 48
ADDRGP4 CG_CalcFov
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
RETI4
LABELV $801
endproc CG_CalcViewValues 88 16
proc CG_PowerupTimerSounds 16 16
line 864
;856:}
;857:
;858:
;859:/*
;860:=====================
;861:CG_PowerupTimerSounds
;862:=====================
;863:*/
;864:static void CG_PowerupTimerSounds( void ) {
line 869
;865:	int		i;
;866:	int		t;
;867:
;868:	// powerup timers going away
;869:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $931
line 870
;870:		t = cg.snap->ps.powerups[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 356
ADDP4
ADDP4
INDIRI4
ASGNI4
line 871
;871:		if ( t <= cg.time ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GTI4 $936
line 872
;872:			continue;
ADDRGP4 $932
JUMPV
LABELV $936
line 874
;873:		}
;874:		if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $939
line 875
;875:			continue;
ADDRGP4 $932
JUMPV
LABELV $939
line 877
;876:		}
;877:		if ( ( t - cg.time ) / POWERUP_BLINK_TIME != ( t - cg.oldTime ) / POWERUP_BLINK_TIME ) {
ADDRLP4 12
CNSTI4 1000
ASGNI4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ADDRLP4 12
INDIRI4
DIVI4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107608
INDIRI4
SUBI4
ADDRLP4 12
INDIRI4
DIVI4
EQI4 $942
line 878
;878:			trap_S_StartSound( NULL, cg.snap->ps.clientNum, CHAN_ITEM, cgs.media.wearOffSound );
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+180268+820
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 879
;879:		}
LABELV $942
line 880
;880:	}
LABELV $932
line 869
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 16
LTI4 $931
line 881
;881:}
LABELV $930
endproc CG_PowerupTimerSounds 16 16
export CG_AddBufferedSound
proc CG_AddBufferedSound 4 0
line 888
;882:
;883:/*
;884:=====================
;885:CG_AddBufferedSound
;886:=====================
;887:*/
;888:void CG_AddBufferedSound( sfxHandle_t sfx ) {
line 889
;889:	if ( !sfx )
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $950
line 890
;890:		return;
ADDRGP4 $949
JUMPV
LABELV $950
line 891
;891:	cg.soundBuffer[cg.soundBufferIn] = sfx;
ADDRGP4 cg+125144
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125156
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 892
;892:	cg.soundBufferIn = (cg.soundBufferIn + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+125144
ADDRGP4 cg+125144
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 893
;893:	if (cg.soundBufferIn == cg.soundBufferOut) {
ADDRGP4 cg+125144
INDIRI4
ADDRGP4 cg+125148
INDIRI4
NEI4 $956
line 894
;894:		cg.soundBufferOut++;
ADDRLP4 0
ADDRGP4 cg+125148
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 895
;895:	}
LABELV $956
line 896
;896:}
LABELV $949
endproc CG_AddBufferedSound 4 0
proc CG_PlayBufferedSounds 0 8
line 903
;897:
;898:/*
;899:=====================
;900:CG_PlayBufferedSounds
;901:=====================
;902:*/
;903:static void CG_PlayBufferedSounds( void ) {
line 904
;904:	if ( cg.soundTime < cg.time ) {
ADDRGP4 cg+125152
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $962
line 905
;905:		if (cg.soundBufferOut != cg.soundBufferIn && cg.soundBuffer[cg.soundBufferOut]) {
ADDRGP4 cg+125148
INDIRI4
ADDRGP4 cg+125144
INDIRI4
EQI4 $966
ADDRGP4 cg+125148
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $966
line 906
;906:			trap_S_StartLocalSound(cg.soundBuffer[cg.soundBufferOut], CHAN_ANNOUNCER);
ADDRGP4 cg+125148
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125156
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 907
;907:			cg.soundBuffer[cg.soundBufferOut] = 0;
ADDRGP4 cg+125148
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125156
ADDP4
CNSTI4 0
ASGNI4
line 908
;908:			cg.soundBufferOut = (cg.soundBufferOut + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+125148
ADDRGP4 cg+125148
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 909
;909:			cg.soundTime = cg.time + 750;
ADDRGP4 cg+125152
ADDRGP4 cg+107604
INDIRI4
CNSTI4 750
ADDI4
ASGNI4
line 910
;910:		}
LABELV $966
line 911
;911:	}
LABELV $962
line 912
;912:}
LABELV $961
endproc CG_PlayBufferedSounds 0 8
export CG_DrawActiveFrame
proc CG_DrawActiveFrame 16 16
line 923
;913:
;914://=========================================================================
;915:
;916:/*
;917:=================
;918:CG_DrawActiveFrame
;919:
;920:Generates and draws a game scene and status information at the given time.
;921:=================
;922:*/
;923:void CG_DrawActiveFrame( int serverTime, stereoFrame_t stereoView, qboolean demoPlayback ) {
line 926
;924:	int		inwater;
;925:
;926:	cg.time = serverTime;
ADDRGP4 cg+107604
ADDRFP4 0
INDIRI4
ASGNI4
line 927
;927:	cg.demoPlayback = demoPlayback;
ADDRGP4 cg+8
ADDRFP4 8
INDIRI4
ASGNI4
line 930
;928:
;929:	// update cvars
;930:	CG_UpdateCvars();
ADDRGP4 CG_UpdateCvars
CALLV
pop
line 934
;931:
;932:	// if we are only updating the screen as a loading
;933:	// pacifier, don't even try to read snapshots
;934:	if ( cg.infoScreenText[0] != 0 ) {
ADDRGP4 cg+109644
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $983
line 939
;935:// loadingscreen
;936:#ifdef SCRIPTHUD
;937:		CG_DrawLoadingScreen( );
;938:#else
;939:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 942
;940:#endif
;941:// end loadingscreen
;942:		return;
ADDRGP4 $980
JUMPV
LABELV $983
line 947
;943:	}
;944:
;945:	// any looped sounds will be respecified as entities
;946:	// are added to the render list
;947:	trap_S_ClearLoopingSounds(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 950
;948:
;949:	// clear all the render lists
;950:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 953
;951:
;952:	// set up cg.snap and possibly cg.nextSnap
;953:	CG_ProcessSnapshots();
ADDRGP4 CG_ProcessSnapshots
CALLV
pop
line 957
;954:
;955:	// if we haven't received any snapshots yet, all
;956:	// we can draw is the information screen
;957:	if ( !cg.snap || ( cg.snap->snapFlags & SNAPFLAG_NOT_ACTIVE ) ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $990
ADDRGP4 cg+36
INDIRP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $986
LABELV $990
line 962
;958:// loadingscreen
;959:#ifdef SCRIPTHUD
;960:		CG_DrawLoadingScreen( );
;961:#else
;962:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 965
;963:#endif
;964:// end loadingscreen
;965:		return;
ADDRGP4 $980
JUMPV
LABELV $986
line 969
;966:	}
;967:
;968:	// let the client system know what our weapon and zoom settings are
;969:	trap_SetUserCmdValue( cg.weaponSelect, cg.zoomSensitivity );
ADDRGP4 cg+109152
INDIRI4
ARGI4
ADDRGP4 cg+109640
INDIRF4
ARGF4
ADDRGP4 trap_SetUserCmdValue
CALLV
pop
line 972
;970:
;971:	// this counter will be bumped for every valid scene we generate
;972:	cg.clientFrame++;
ADDRLP4 4
ADDRGP4 cg
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 975
;973:
;974:	// update cg.predictedPlayerState
;975:	CG_PredictPlayerState();
ADDRGP4 CG_PredictPlayerState
CALLV
pop
line 979
;976:
;977:	// decide on third person view
;978:
;979:	if (!cg_deathcam.integer) {
ADDRGP4 cg_deathcam+12
INDIRI4
CNSTI4 0
NEI4 $993
line 981
;980:		// leilei - allow first person deathcam
;981:		cg.renderingThirdPerson = cg_thirdPerson.integer;
ADDRGP4 cg+107628
ADDRGP4 cg_thirdPerson+12
INDIRI4
ASGNI4
line 982
;982:	}
ADDRGP4 $994
JUMPV
LABELV $993
line 983
;983:	else {
line 984
;984:		cg.renderingThirdPerson = cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1003
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 cg_thirdPerson+12
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1005
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
GTI4 $1003
LABELV $1005
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $1004
JUMPV
LABELV $1003
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1004
ADDRGP4 cg+107628
ADDRLP4 8
INDIRI4
ASGNI4
line 986
;985:			&& (cg_thirdPerson.integer || (cg.snap->ps.stats[STAT_HEALTH] <= 0));
;986:	}
LABELV $994
line 989
;987:
;988:	// build cg.refdef
;989:	inwater = CG_CalcViewValues();
ADDRLP4 8
ADDRGP4 CG_CalcViewValues
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 992
;990:
;991:	// first person blend blobs, done after AnglesToAxis
;992:	if ( !cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1006
line 993
;993:		CG_DamageBlendBlob();
ADDRGP4 CG_DamageBlendBlob
CALLV
pop
line 994
;994:	}
LABELV $1006
line 997
;995:
;996:	// build the render lists
;997:	if ( !cg.hyperspace ) {
ADDRGP4 cg+107632
INDIRI4
CNSTI4 0
NEI4 $1009
line 998
;998:		CG_AddPacketEntities();			// adter calcViewValues, so predicted player state is correct
ADDRGP4 CG_AddPacketEntities
CALLV
pop
line 999
;999:		CG_AddMarks();
ADDRGP4 CG_AddMarks
CALLV
pop
line 1000
;1000:		CG_AddLocalEntities();
ADDRGP4 CG_AddLocalEntities
CALLV
pop
line 1001
;1001:	}
LABELV $1009
line 1002
;1002:	CG_AddViewWeapon( &cg.predictedPlayerState );
ADDRGP4 cg+107636
ARGP4
ADDRGP4 CG_AddViewWeapon
CALLV
pop
line 1005
;1003:
;1004:	// add buffered sounds
;1005:	CG_PlayBufferedSounds();
ADDRGP4 CG_PlayBufferedSounds
CALLV
pop
line 1008
;1006:
;1007:	// play buffered voice chats
;1008:	CG_PlayBufferedVoiceChats();
ADDRGP4 CG_PlayBufferedVoiceChats
CALLV
pop
line 1011
;1009:
;1010:	// finish up the rest of the refdef
;1011:	if ( cg.testModelEntity.hModel ) {
ADDRGP4 cg+125384+8
INDIRI4
CNSTI4 0
EQI4 $1013
line 1012
;1012:		CG_AddTestModel();
ADDRGP4 CG_AddTestModel
CALLV
pop
line 1013
;1013:	}
LABELV $1013
line 1014
;1014:	cg.refdef.time = cg.time;
ADDRGP4 cg+109252+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1015
;1015:	memcpy( cg.refdef.areamask, cg.snap->areamask, sizeof( cg.refdef.areamask ) );
ADDRGP4 cg+109252+80
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1018
;1016:
;1017:	// warning sounds when powerup is wearing off
;1018:	CG_PowerupTimerSounds();
ADDRGP4 CG_PowerupTimerSounds
CALLV
pop
line 1021
;1019:
;1020:	// update audio positions
;1021:	trap_S_Respatialize( cg.snap->ps.clientNum, cg.refdef.vieworg, cg.refdef.viewaxis, inwater );
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+109252+24
ARGP4
ADDRGP4 cg+109252+36
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_S_Respatialize
CALLV
pop
line 1024
;1022:
;1023:	// make sure the lagometerSample and frame timing isn't done twice when in stereo
;1024:	if ( stereoView != STEREO_RIGHT ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
EQI4 $1030
line 1025
;1025:		cg.frametime = cg.time - cg.oldTime;
ADDRGP4 cg+107600
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+107608
INDIRI4
SUBI4
ASGNI4
line 1026
;1026:		if ( cg.frametime < 0 ) {
ADDRGP4 cg+107600
INDIRI4
CNSTI4 0
GEI4 $1035
line 1027
;1027:			cg.frametime = 0;
ADDRGP4 cg+107600
CNSTI4 0
ASGNI4
line 1028
;1028:		}
LABELV $1035
line 1029
;1029:		cg.oldTime = cg.time;
ADDRGP4 cg+107608
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1030
;1030:		CG_AddLagometerFrameInfo();
ADDRGP4 CG_AddLagometerFrameInfo
CALLV
pop
line 1031
;1031:	}
LABELV $1030
line 1032
;1032:	if (cg_timescale.value != cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
EQF4 $1041
line 1033
;1033:		if (cg_timescale.value < cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
GEF4 $1045
line 1034
;1034:			cg_timescale.value += cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
ADDRLP4 12
ADDRGP4 cg_timescale+8
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
MULF4
CNSTF4 1148846080
DIVF4
ADDF4
ASGNF4
line 1035
;1035:			if (cg_timescale.value > cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
LEF4 $1046
line 1036
;1036:				cg_timescale.value = cg_timescaleFadeEnd.value;
ADDRGP4 cg_timescale+8
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
ASGNF4
line 1037
;1037:			}
line 1038
;1038:		}
ADDRGP4 $1046
JUMPV
LABELV $1045
line 1039
;1039:		else {
line 1040
;1040:			cg_timescale.value -= cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
ADDRLP4 12
ADDRGP4 cg_timescale+8
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
MULF4
CNSTF4 1148846080
DIVF4
SUBF4
ASGNF4
line 1041
;1041:			if (cg_timescale.value < cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
GEF4 $1061
line 1042
;1042:				cg_timescale.value = cg_timescaleFadeEnd.value;
ADDRGP4 cg_timescale+8
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
ASGNF4
line 1043
;1043:			}
LABELV $1061
line 1044
;1044:		}
LABELV $1046
line 1045
;1045:		if (cg_timescaleFadeSpeed.value) {
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
CNSTF4 0
EQF4 $1067
line 1046
;1046:			trap_Cvar_Set("timescale", va("%f", cg_timescale.value));
ADDRGP4 $1071
ARGP4
ADDRGP4 cg_timescale+8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1070
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1047
;1047:		}
LABELV $1067
line 1048
;1048:	}
LABELV $1041
line 1051
;1049:
;1050:	// actually issue the rendering calls
;1051:	CG_DrawActive( stereoView );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawActive
CALLV
pop
line 1053
;1052:
;1053:	if ( cg_stats.integer ) {
ADDRGP4 cg_stats+12
INDIRI4
CNSTI4 0
EQI4 $1073
line 1054
;1054:		CG_Printf( "cg.clientFrame:%i\n", cg.clientFrame );
ADDRGP4 $1076
ARGP4
ADDRGP4 cg
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1055
;1055:	}
LABELV $1073
line 1058
;1056:
;1057:
;1058:}
LABELV $980
endproc CG_DrawActiveFrame 16 16
import headang
import headpos
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
LABELV $1076
byte 1 99
byte 1 103
byte 1 46
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 70
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $1071
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $1070
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $234
byte 1 49
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $230
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $229
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $155
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $138
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $96
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 10
byte 1 0
