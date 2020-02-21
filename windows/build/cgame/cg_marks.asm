export CG_InitMarkPolys
code
proc CG_InitMarkPolys 12 12
file "../../../code/cgame/cg_marks.c"
line 48
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
;23:// cg_marks.c -- wall marks
;24:
;25:#include "cg_local.h"
;26:
;27:/*
;28:===================================================================
;29:
;30:MARK POLYS
;31:
;32:===================================================================
;33:*/
;34:
;35:
;36:markPoly_t	cg_activeMarkPolys;			// double linked list
;37:markPoly_t	*cg_freeMarkPolys;			// single linked list
;38:markPoly_t	cg_markPolys[MAX_MARK_POLYS];
;39:static		int	markTotal;
;40:
;41:/*
;42:===================
;43:CG_InitMarkPolys
;44:
;45:This is called at startup and for tournement restarts
;46:===================
;47:*/
;48:void	CG_InitMarkPolys( void ) {
line 51
;49:	int		i;
;50:
;51:	memset( cg_markPolys, 0, sizeof(cg_markPolys) );
ADDRGP4 cg_markPolys
ARGP4
CNSTI4 0
ARGI4
CNSTI4 73728
ARGI4
ADDRGP4 memset
CALLP4
pop
line 53
;52:
;53:	cg_activeMarkPolys.nextMark = &cg_activeMarkPolys;
ADDRGP4 cg_activeMarkPolys+4
ADDRGP4 cg_activeMarkPolys
ASGNP4
line 54
;54:	cg_activeMarkPolys.prevMark = &cg_activeMarkPolys;
ADDRLP4 4
ADDRGP4 cg_activeMarkPolys
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
ASGNP4
line 55
;55:	cg_freeMarkPolys = cg_markPolys;
ADDRGP4 cg_freeMarkPolys
ADDRGP4 cg_markPolys
ASGNP4
line 56
;56:	for ( i = 0 ; i < MAX_MARK_POLYS - 1 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $76
line 57
;57:		cg_markPolys[i].nextMark = &cg_markPolys[i+1];
ADDRLP4 8
CNSTI4 288
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 cg_markPolys+4
ADDP4
ADDRLP4 8
INDIRI4
ADDRGP4 cg_markPolys+288
ADDP4
ASGNP4
line 58
;58:	}
LABELV $77
line 56
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 255
LTI4 $76
line 59
;59:}
LABELV $74
endproc CG_InitMarkPolys 12 12
export CG_FreeMarkPoly
proc CG_FreeMarkPoly 12 4
line 67
;60:
;61:
;62:/*
;63:==================
;64:CG_FreeMarkPoly
;65:==================
;66:*/
;67:void CG_FreeMarkPoly( markPoly_t *le ) {
line 68
;68:	if ( !le->prevMark ) {
ADDRFP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $83
line 69
;69:		CG_Error( "CG_FreeLocalEntity: not active" );
ADDRGP4 $85
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 70
;70:	}
LABELV $83
line 73
;71:
;72:	// remove from the doubly linked active list
;73:	le->prevMark->nextMark = le->nextMark;
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
line 74
;74:	le->nextMark->prevMark = le->prevMark;
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
line 77
;75:
;76:	// the free list is only singly linked
;77:	le->nextMark = cg_freeMarkPolys;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg_freeMarkPolys
INDIRP4
ASGNP4
line 78
;78:	cg_freeMarkPolys = le;
ADDRGP4 cg_freeMarkPolys
ADDRFP4 0
INDIRP4
ASGNP4
line 79
;79:}
LABELV $82
endproc CG_FreeMarkPoly 12 4
export CG_AllocMark
proc CG_AllocMark 12 12
line 88
;80:
;81:/*
;82:===================
;83:CG_AllocMark
;84:
;85:Will allways succeed, even if it requires freeing an old active mark
;86:===================
;87:*/
;88:markPoly_t	*CG_AllocMark( void ) {
line 92
;89:	markPoly_t	*le;
;90:	int time;
;91:
;92:	if ( !cg_freeMarkPolys ) {
ADDRGP4 cg_freeMarkPolys
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $87
line 95
;93:		// no free entities, so free the one at the end of the chain
;94:		// remove the oldest active entity
;95:		time = cg_activeMarkPolys.prevMark->time;
ADDRLP4 4
ADDRGP4 cg_activeMarkPolys
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $90
JUMPV
LABELV $89
line 96
;96:		while (cg_activeMarkPolys.prevMark && time == cg_activeMarkPolys.prevMark->time) {
line 97
;97:			CG_FreeMarkPoly( cg_activeMarkPolys.prevMark );
ADDRGP4 cg_activeMarkPolys
INDIRP4
ARGP4
ADDRGP4 CG_FreeMarkPoly
CALLV
pop
line 98
;98:		}
LABELV $90
line 96
ADDRLP4 8
ADDRGP4 cg_activeMarkPolys
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $92
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $89
LABELV $92
line 99
;99:	}
LABELV $87
line 101
;100:
;101:	le = cg_freeMarkPolys;
ADDRLP4 0
ADDRGP4 cg_freeMarkPolys
INDIRP4
ASGNP4
line 102
;102:	cg_freeMarkPolys = cg_freeMarkPolys->nextMark;
ADDRLP4 8
ADDRGP4 cg_freeMarkPolys
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 104
;103:
;104:	memset( le, 0, sizeof( *le ) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 288
ARGI4
ADDRGP4 memset
CALLP4
pop
line 107
;105:
;106:	// link into the active list
;107:	le->nextMark = cg_activeMarkPolys.nextMark;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg_activeMarkPolys+4
INDIRP4
ASGNP4
line 108
;108:	le->prevMark = &cg_activeMarkPolys;
ADDRLP4 0
INDIRP4
ADDRGP4 cg_activeMarkPolys
ASGNP4
line 109
;109:	cg_activeMarkPolys.nextMark->prevMark = le;
ADDRGP4 cg_activeMarkPolys+4
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 110
;110:	cg_activeMarkPolys.nextMark = le;
ADDRGP4 cg_activeMarkPolys+4
ADDRLP4 0
INDIRP4
ASGNP4
line 111
;111:	return le;
ADDRLP4 0
INDIRP4
RETP4
LABELV $86
endproc CG_AllocMark 12 12
export CG_ImpactMark
proc CG_ImpactMark 6088 28
line 132
;112:}
;113:
;114:
;115:
;116:/*
;117:=================
;118:CG_ImpactMark
;119:
;120:origin should be a point within a unit of the plane
;121:dir should be the plane normal
;122:
;123:temporary marks will not be stored or randomly oriented, but immediately
;124:passed to the renderer.
;125:=================
;126:*/
;127:#define	MAX_MARK_FRAGMENTS	128
;128:#define	MAX_MARK_POINTS		384
;129:
;130:void CG_ImpactMark( qhandle_t markShader, const vec3_t origin, const vec3_t dir, 
;131:				   float orientation, float red, float green, float blue, float alpha,
;132:				   qboolean alphaFade, float radius, qboolean temporary ) {
line 143
;133:	vec3_t			axis[3];
;134:	float			texCoordScale;
;135:	vec3_t			originalPoints[4];
;136:	byte			colors[4];
;137:	int				i, j;
;138:	int				numFragments;
;139:	markFragment_t	markFragments[MAX_MARK_FRAGMENTS], *mf;
;140:	vec3_t			markPoints[MAX_MARK_POINTS];
;141:	vec3_t			projection;
;142:
;143:	if ( !cg_addMarks.integer ) {
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 0
NEI4 $97
line 144
;144:		return;
ADDRGP4 $96
JUMPV
LABELV $97
line 147
;145:	}
;146:
;147:	if ( radius <= 0 ) {
ADDRFP4 36
INDIRF4
CNSTF4 0
GTF4 $100
line 148
;148:		CG_Error( "CG_ImpactMark called with <= 0 radius" );
ADDRGP4 $102
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 149
;149:	}
LABELV $100
line 156
;150:
;151:	//if ( markTotal >= MAX_MARK_POLYS ) {
;152:	//	return;
;153:	//}
;154:
;155:	// create the texture axis
;156:	VectorNormalize2( dir, axis[0] );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 157
;157:	PerpendicularVector( axis[1], axis[0] );
ADDRLP4 0+12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 159
;158:	
;159:	RotatePointAroundVector( axis[2], axis[0], axis[1], orientation );
ADDRLP4 0+24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 0+12
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 RotatePointAroundVector
CALLV
pop
line 160
;160:	CrossProduct( axis[0], axis[2], axis[1] );
ADDRLP4 0
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 162
;161:
;162:	texCoordScale = 0.5 * 1.0 / radius;
ADDRLP4 48
CNSTF4 1056964608
ADDRFP4 36
INDIRF4
DIVF4
ASGNF4
line 165
;163:
;164:	// create the full polygon
;165:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 44
CNSTI4 0
ASGNI4
LABELV $108
line 166
;166:		originalPoints[0][i] = origin[i] - radius * axis[1][i] - radius * axis[2][i];
ADDRLP4 5752
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 5756
ADDRFP4 36
INDIRF4
ASGNF4
ADDRLP4 5752
INDIRI4
ADDRLP4 4664
ADDP4
ADDRLP4 5752
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 5756
INDIRF4
ADDRLP4 5752
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
MULF4
SUBF4
ADDRLP4 5756
INDIRF4
ADDRLP4 5752
INDIRI4
ADDRLP4 0+24
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 167
;167:		originalPoints[1][i] = origin[i] + radius * axis[1][i] - radius * axis[2][i];
ADDRLP4 5760
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 5764
ADDRFP4 36
INDIRF4
ASGNF4
ADDRLP4 5760
INDIRI4
ADDRLP4 4664+12
ADDP4
ADDRLP4 5760
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 5764
INDIRF4
ADDRLP4 5760
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 5764
INDIRF4
ADDRLP4 5760
INDIRI4
ADDRLP4 0+24
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 168
;168:		originalPoints[2][i] = origin[i] + radius * axis[1][i] + radius * axis[2][i];
ADDRLP4 5768
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 5772
ADDRFP4 36
INDIRF4
ASGNF4
ADDRLP4 5768
INDIRI4
ADDRLP4 4664+24
ADDP4
ADDRLP4 5768
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 5772
INDIRF4
ADDRLP4 5768
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 5772
INDIRF4
ADDRLP4 5768
INDIRI4
ADDRLP4 0+24
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 169
;169:		originalPoints[3][i] = origin[i] - radius * axis[1][i] + radius * axis[2][i];
ADDRLP4 5776
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 5780
ADDRFP4 36
INDIRF4
ASGNF4
ADDRLP4 5776
INDIRI4
ADDRLP4 4664+36
ADDP4
ADDRLP4 5776
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 5780
INDIRF4
ADDRLP4 5776
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
MULF4
SUBF4
ADDRLP4 5780
INDIRF4
ADDRLP4 5776
INDIRI4
ADDRLP4 0+24
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 170
;170:	}
LABELV $109
line 165
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 3
LTI4 $108
line 173
;171:
;172:	// get the fragments
;173:	VectorScale( dir, -20, projection );
ADDRLP4 5752
CNSTF4 3248488448
ASGNF4
ADDRLP4 5756
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4716
ADDRLP4 5752
INDIRF4
ADDRLP4 5756
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4716+4
ADDRLP4 5752
INDIRF4
ADDRLP4 5756
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4716+8
CNSTF4 3248488448
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 174
;174:	numFragments = trap_CM_MarkFragments( 4, (void *)originalPoints,
CNSTI4 4
ARGI4
ADDRLP4 4664
ARGP4
ADDRLP4 4716
ARGP4
CNSTI4 384
ARGI4
ADDRLP4 56
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 4728
ARGP4
ADDRLP4 5760
ADDRGP4 trap_CM_MarkFragments
CALLI4
ASGNI4
ADDRLP4 4712
ADDRLP4 5760
INDIRI4
ASGNI4
line 178
;175:					projection, MAX_MARK_POINTS, markPoints[0],
;176:					MAX_MARK_FRAGMENTS, markFragments );
;177:
;178:	colors[0] = red * 255;
ADDRLP4 5768
CNSTF4 1132396544
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
ADDRLP4 5772
CNSTF4 1325400064
ASGNF4
ADDRLP4 5768
INDIRF4
ADDRLP4 5772
INDIRF4
LTF4 $126
ADDRLP4 5764
ADDRLP4 5768
INDIRF4
ADDRLP4 5772
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $127
JUMPV
LABELV $126
ADDRLP4 5764
ADDRLP4 5768
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $127
ADDRLP4 52
ADDRLP4 5764
INDIRU4
CVUU1 4
ASGNU1
line 179
;179:	colors[1] = green * 255;
ADDRLP4 5780
CNSTF4 1132396544
ADDRFP4 20
INDIRF4
MULF4
ASGNF4
ADDRLP4 5784
CNSTF4 1325400064
ASGNF4
ADDRLP4 5780
INDIRF4
ADDRLP4 5784
INDIRF4
LTF4 $130
ADDRLP4 5776
ADDRLP4 5780
INDIRF4
ADDRLP4 5784
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $131
JUMPV
LABELV $130
ADDRLP4 5776
ADDRLP4 5780
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $131
ADDRLP4 52+1
ADDRLP4 5776
INDIRU4
CVUU1 4
ASGNU1
line 180
;180:	colors[2] = blue * 255;
ADDRLP4 5792
CNSTF4 1132396544
ADDRFP4 24
INDIRF4
MULF4
ASGNF4
ADDRLP4 5796
CNSTF4 1325400064
ASGNF4
ADDRLP4 5792
INDIRF4
ADDRLP4 5796
INDIRF4
LTF4 $134
ADDRLP4 5788
ADDRLP4 5792
INDIRF4
ADDRLP4 5796
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $135
JUMPV
LABELV $134
ADDRLP4 5788
ADDRLP4 5792
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $135
ADDRLP4 52+2
ADDRLP4 5788
INDIRU4
CVUU1 4
ASGNU1
line 181
;181:	colors[3] = alpha * 255;
ADDRLP4 5804
CNSTF4 1132396544
ADDRFP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 5808
CNSTF4 1325400064
ASGNF4
ADDRLP4 5804
INDIRF4
ADDRLP4 5808
INDIRF4
LTF4 $138
ADDRLP4 5800
ADDRLP4 5804
INDIRF4
ADDRLP4 5808
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $139
JUMPV
LABELV $138
ADDRLP4 5800
ADDRLP4 5804
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $139
ADDRLP4 52+3
ADDRLP4 5800
INDIRU4
CVUU1 4
ASGNU1
line 183
;182:
;183:	for ( i = 0, mf = markFragments ; i < numFragments ; i++, mf++ ) {
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
ADDRLP4 4728
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $140
line 190
;184:		polyVert_t	*v;
;185:		polyVert_t	verts[MAX_VERTS_ON_POLY];
;186:		markPoly_t	*mark;
;187:
;188:		// we have an upper limit on the complexity of polygons
;189:		// that we store persistantly
;190:		if ( mf->numPoints > MAX_VERTS_ON_POLY ) {
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 10
LEI4 $144
line 191
;191:			mf->numPoints = MAX_VERTS_ON_POLY;
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 192
;192:		}
LABELV $144
line 193
;193:		for ( j = 0, v = verts ; j < mf->numPoints ; j++, v++ ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 5812
ADDRLP4 5820
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $146
line 196
;194:			vec3_t		delta;
;195:
;196:			VectorCopy( markPoints[mf->firstPoint + j], v->xyz );
ADDRLP4 5812
INDIRP4
CNSTI4 12
ADDRLP4 40
INDIRP4
INDIRI4
ADDRLP4 36
INDIRI4
ADDI4
MULI4
ADDRLP4 56
ADDP4
INDIRB
ASGNB 12
line 198
;197:
;198:			VectorSubtract( v->xyz, origin, delta );
ADDRLP4 6076
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 6060
ADDRLP4 5812
INDIRP4
INDIRF4
ADDRLP4 6076
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 6080
CNSTI4 4
ASGNI4
ADDRLP4 6060+4
ADDRLP4 5812
INDIRP4
ADDRLP4 6080
INDIRI4
ADDP4
INDIRF4
ADDRLP4 6076
INDIRP4
ADDRLP4 6080
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 6084
CNSTI4 8
ASGNI4
ADDRLP4 6060+8
ADDRLP4 5812
INDIRP4
ADDRLP4 6084
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 6084
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 199
;199:			v->st[0] = 0.5 + DotProduct( delta, axis[1] ) * texCoordScale;
ADDRLP4 5812
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 6060
INDIRF4
ADDRLP4 0+12
INDIRF4
MULF4
ADDRLP4 6060+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 6060+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 200
;200:			v->st[1] = 0.5 + DotProduct( delta, axis[2] ) * texCoordScale;
ADDRLP4 5812
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 6060
INDIRF4
ADDRLP4 0+24
INDIRF4
MULF4
ADDRLP4 6060+4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 6060+8
INDIRF4
ADDRLP4 0+24+8
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 201
;201:			*(int *)v->modulate = *(int *)colors;
ADDRLP4 5812
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 202
;202:		}
LABELV $147
line 193
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 5812
ADDRLP4 5812
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
LABELV $149
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $146
line 205
;203:
;204:		// if it is a temporary (shadow) mark, add it immediately and forget about it
;205:		if ( temporary ) {
ADDRFP4 40
INDIRI4
CNSTI4 0
EQI4 $166
line 206
;206:			trap_R_AddPolyToScene( markShader, mf->numPoints, verts );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 5820
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 207
;207:			continue;
ADDRGP4 $141
JUMPV
LABELV $166
line 211
;208:		}
;209:
;210:		// otherwise save it persistantly
;211:		mark = CG_AllocMark();
ADDRLP4 6060
ADDRGP4 CG_AllocMark
CALLP4
ASGNP4
ADDRLP4 5816
ADDRLP4 6060
INDIRP4
ASGNP4
line 212
;212:		mark->time = cg.time;
ADDRLP4 5816
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 213
;213:		mark->alphaFade = alphaFade;
ADDRLP4 5816
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 32
INDIRI4
ASGNI4
line 214
;214:		mark->markShader = markShader;
ADDRLP4 5816
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 215
;215:		mark->poly.numVerts = mf->numPoints;
ADDRLP4 5816
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 216
;216:		mark->color[0] = red;
ADDRLP4 5816
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 217
;217:		mark->color[1] = green;
ADDRLP4 5816
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 20
INDIRF4
ASGNF4
line 218
;218:		mark->color[2] = blue;
ADDRLP4 5816
INDIRP4
CNSTI4 28
ADDP4
ADDRFP4 24
INDIRF4
ASGNF4
line 219
;219:		mark->color[3] = alpha;
ADDRLP4 5816
INDIRP4
CNSTI4 32
ADDP4
ADDRFP4 28
INDIRF4
ASGNF4
line 220
;220:		memcpy( mark->verts, verts, mf->numPoints * sizeof( verts[0] ) );
ADDRLP4 5816
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 5820
ARGP4
CNSTU4 24
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIU4 4
MULU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 221
;221:		markTotal++;
ADDRLP4 6064
ADDRGP4 markTotal
ASGNP4
ADDRLP4 6064
INDIRP4
ADDRLP4 6064
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 222
;222:	}
LABELV $141
line 183
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 40
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
LABELV $143
ADDRLP4 44
INDIRI4
ADDRLP4 4712
INDIRI4
LTI4 $140
line 223
;223:}
LABELV $96
endproc CG_ImpactMark 6088 28
export CG_AddMarks
proc CG_AddMarks 80 12
line 234
;224:
;225:
;226:/*
;227:===============
;228:CG_AddMarks
;229:===============
;230:*/
;231:#define	MARK_TOTAL_TIME		10000
;232:#define	MARK_FADE_TIME		1000
;233:
;234:void CG_AddMarks( void ) {
line 240
;235:	int			j;
;236:	markPoly_t	*mp, *next;
;237:	int			t;
;238:	int			fade;
;239:
;240:	if ( !cg_addMarks.integer ) {
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 0
NEI4 $170
line 241
;241:		return;
ADDRGP4 $169
JUMPV
LABELV $170
line 244
;242:	}
;243:
;244:	mp = cg_activeMarkPolys.nextMark;
ADDRLP4 0
ADDRGP4 cg_activeMarkPolys+4
INDIRP4
ASGNP4
line 245
;245:	for ( ; mp != &cg_activeMarkPolys ; mp = next ) {
ADDRGP4 $177
JUMPV
LABELV $174
line 248
;246:		// grab next now, so if the local entity is freed we
;247:		// still have it
;248:		next = mp->nextMark;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 251
;249:
;250:		// see if it is time to completely remove it
;251:		if ( cg.time > mp->time + MARK_TOTAL_TIME ) {
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 10000
ADDI4
LEI4 $178
line 252
;252:			CG_FreeMarkPoly( mp );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeMarkPoly
CALLV
pop
line 253
;253:			continue;
ADDRGP4 $175
JUMPV
LABELV $178
line 257
;254:		}
;255:
;256:		// fade out the energy bursts
;257:		if ( mp->markShader == cgs.media.energyMarkShader ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 cgs+180268+540
INDIRI4
NEI4 $181
line 259
;258:
;259:			fade = 450 - 450 * ( (cg.time - mp->time ) / 3000.0 );
ADDRLP4 20
CNSTF4 1138819072
ASGNF4
ADDRLP4 8
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1161527296
DIVF4
MULF4
SUBF4
CVFI4 4
ASGNI4
line 260
;260:			if ( fade < 255 ) {
ADDRLP4 8
INDIRI4
CNSTI4 255
GEI4 $186
line 261
;261:				if ( fade < 0 ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $188
line 262
;262:					fade = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 263
;263:				}
LABELV $188
line 264
;264:				if ( mp->verts[0].modulate[0] != 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRU1
CVUI4 1
CNSTI4 0
EQI4 $190
line 265
;265:					for ( j = 0 ; j < mp->poly.numVerts ; j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $195
JUMPV
LABELV $192
line 266
;266:						mp->verts[j].modulate[0] = mp->color[0] * fade;
ADDRLP4 32
CNSTI4 20
ASGNI4
ADDRLP4 36
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 40
CNSTF4 1325400064
ASGNF4
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
LTF4 $197
ADDRLP4 24
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
ADDRGP4 $198
JUMPV
LABELV $197
ADDRLP4 24
ADDRLP4 36
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $198
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 267
;267:						mp->verts[j].modulate[1] = mp->color[1] * fade;
ADDRLP4 52
CNSTI4 24
ASGNI4
ADDRLP4 56
ADDRLP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 60
CNSTF4 1325400064
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
LTF4 $200
ADDRLP4 44
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $201
JUMPV
LABELV $200
ADDRLP4 44
ADDRLP4 56
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $201
ADDRLP4 52
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 44
INDIRU4
CVUU1 4
ASGNU1
line 268
;268:						mp->verts[j].modulate[2] = mp->color[2] * fade;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 76
CNSTF4 1325400064
ASGNF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
LTF4 $203
ADDRLP4 64
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $204
JUMPV
LABELV $203
ADDRLP4 64
ADDRLP4 72
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $204
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 269
;269:					}
LABELV $193
line 265
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $195
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LTI4 $192
line 270
;270:				}
LABELV $190
line 271
;271:			}
LABELV $186
line 272
;272:		}
LABELV $181
line 275
;273:
;274:		// fade all marks out with time
;275:		t = mp->time + MARK_TOTAL_TIME - cg.time;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 10000
ADDI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 276
;276:		if ( t < MARK_FADE_TIME ) {
ADDRLP4 12
INDIRI4
CNSTI4 1000
GEI4 $206
line 277
;277:			fade = 255 * t / MARK_FADE_TIME;
ADDRLP4 8
CNSTI4 255
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 1000
DIVI4
ASGNI4
line 278
;278:			if ( mp->alphaFade ) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $208
line 279
;279:				for ( j = 0 ; j < mp->poly.numVerts ; j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $213
JUMPV
LABELV $210
line 280
;280:					mp->verts[j].modulate[3] = fade;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
CNSTI4 23
ADDP4
ADDRLP4 8
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 281
;281:				}
LABELV $211
line 279
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $213
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LTI4 $210
line 282
;282:			} else {
ADDRGP4 $209
JUMPV
LABELV $208
line 283
;283:				for ( j = 0 ; j < mp->poly.numVerts ; j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $217
JUMPV
LABELV $214
line 284
;284:					mp->verts[j].modulate[0] = mp->color[0] * fade;
ADDRLP4 28
CNSTI4 20
ASGNI4
ADDRLP4 32
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 36
CNSTF4 1325400064
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
LTF4 $219
ADDRLP4 20
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
ADDRGP4 $220
JUMPV
LABELV $219
ADDRLP4 20
ADDRLP4 32
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $220
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 20
INDIRU4
CVUU1 4
ASGNU1
line 285
;285:					mp->verts[j].modulate[1] = mp->color[1] * fade;
ADDRLP4 48
CNSTI4 24
ASGNI4
ADDRLP4 52
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $222
ADDRLP4 40
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
ADDRGP4 $223
JUMPV
LABELV $222
ADDRLP4 40
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $223
ADDRLP4 48
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 40
INDIRU4
CVUU1 4
ASGNU1
line 286
;286:					mp->verts[j].modulate[2] = mp->color[2] * fade;
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 72
CNSTF4 1325400064
ASGNF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $225
ADDRLP4 60
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $226
JUMPV
LABELV $225
ADDRLP4 60
ADDRLP4 68
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $226
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 60
INDIRU4
CVUU1 4
ASGNU1
line 287
;287:				}
LABELV $215
line 283
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $217
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LTI4 $214
line 288
;288:			}
LABELV $209
line 289
;289:		}
LABELV $206
line 292
;290:
;291:
;292:		trap_R_AddPolyToScene( mp->markShader, mp->poly.numVerts, mp->verts );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 293
;293:	}
LABELV $175
line 245
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
LABELV $177
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 cg_activeMarkPolys
CVPU4 4
NEU4 $174
line 294
;294:}
LABELV $169
endproc CG_AddMarks 80 12
bss
align 4
LABELV markTotal
skip 4
export cg_freeMarkPolys
align 4
LABELV cg_freeMarkPolys
skip 4
export cg_activeMarkPolys
align 4
LABELV cg_activeMarkPolys
skip 288
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
export cg_markPolys
align 4
LABELV cg_markPolys
skip 73728
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
LABELV $102
byte 1 67
byte 1 71
byte 1 95
byte 1 73
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 60
byte 1 61
byte 1 32
byte 1 48
byte 1 32
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
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
