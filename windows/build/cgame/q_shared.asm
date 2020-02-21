export Com_Clamp
code
proc Com_Clamp 0 0
file "../../../code/qcommon/q_shared.c"
line 26
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
;21: */
;22://
;23:// q_shared.c -- stateless support routines that are included in each code dll
;24:#include "q_shared.h"
;25:
;26:float Com_Clamp(float min, float max, float value) {
line 27
;27:	if (value < min) {
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRF4
GEF4 $24
line 28
;28:		return min;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $23
JUMPV
LABELV $24
line 30
;29:	}
;30:	if (value > max) {
ADDRFP4 8
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $26
line 31
;31:		return max;
ADDRFP4 4
INDIRF4
RETF4
ADDRGP4 $23
JUMPV
LABELV $26
line 33
;32:	}
;33:	return value;
ADDRFP4 8
INDIRF4
RETF4
LABELV $23
endproc Com_Clamp 0 0
export COM_SkipPath
proc COM_SkipPath 4 0
line 41
;34:}
;35:
;36:/*
;37:============
;38:COM_SkipPath
;39:============
;40: */
;41:char *COM_SkipPath(char *pathname) {
line 44
;42:	char *last;
;43:
;44:	last = pathname;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $30
JUMPV
LABELV $29
line 45
;45:	while (*pathname) {
line 46
;46:		if (*pathname == '/')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $32
line 47
;47:			last = pathname + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $32
line 48
;48:		pathname++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 49
;49:	}
LABELV $30
line 45
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $29
line 50
;50:	return last;
ADDRLP4 0
INDIRP4
RETP4
LABELV $28
endproc COM_SkipPath 4 0
export COM_GetExtension
proc COM_GetExtension 16 4
line 58
;51:}
;52:
;53:/*
;54:============
;55:COM_GetExtension
;56:============
;57: */
;58:const char *COM_GetExtension(const char *name) {
line 61
;59:	int length, i;
;60:
;61:	length = strlen(name) - 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 62
;62:	i = length;
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $36
JUMPV
LABELV $35
line 64
;63:
;64:	while (name[i] != '.') {
line 65
;65:		i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 66
;66:		if (name[i] == '/' || i == 0)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
EQI4 $40
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $38
LABELV $40
line 67
;67:			return ""; // no extension
ADDRGP4 $41
RETP4
ADDRGP4 $34
JUMPV
LABELV $38
line 68
;68:	}
LABELV $36
line 64
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 46
NEI4 $35
line 70
;69:
;70:	return &name[i + 1];
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ADDRFP4 0
INDIRP4
ADDP4
RETP4
LABELV $34
endproc COM_GetExtension 16 4
export COM_StripExtension
proc COM_StripExtension 12 12
line 78
;71:}
;72:
;73:/*
;74:============
;75:COM_StripExtension
;76:============
;77: */
;78:void COM_StripExtension(const char *in, char *out, int destsize) {
line 81
;79:	int length;
;80:
;81:	Q_strncpyz(out, in, destsize);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 83
;82:
;83:	length = strlen(out) - 1;
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $44
JUMPV
LABELV $43
line 84
;84:	while (length > 0 && out[length] != '.') {
line 85
;85:		length--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 86
;86:		if (out[length] == '/')
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $46
line 87
;87:			return; // no extension
ADDRGP4 $42
JUMPV
LABELV $46
line 88
;88:	}
LABELV $44
line 84
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $48
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 46
NEI4 $43
LABELV $48
line 89
;89:	if (length)
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $49
line 90
;90:		out[length] = 0;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
LABELV $49
line 91
;91:}
LABELV $42
endproc COM_StripExtension 12 12
export COM_DefaultExtension
proc COM_DefaultExtension 76 20
line 98
;92:
;93:/*
;94:==================
;95:COM_DefaultExtension
;96:==================
;97: */
;98:void COM_DefaultExtension(char *path, int maxSize, const char *extension) {
line 106
;99:	char oldPath[MAX_QPATH];
;100:	char *src;
;101:
;102:	//
;103:	// if path doesn't have a .EXT, append extension
;104:	// (extension should include the .)
;105:	//
;106:	src = path + strlen(path) - 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 68
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI4 -1
ADDP4
ASGNP4
ADDRGP4 $53
JUMPV
LABELV $52
line 108
;107:
;108:	while (*src != '/' && src != path) {
line 109
;109:		if (*src == '.') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 46
NEI4 $55
line 110
;110:			return; // it has an extension
ADDRGP4 $51
JUMPV
LABELV $55
line 112
;111:		}
;112:		src--;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 -1
ADDP4
ASGNP4
line 113
;113:	}
LABELV $53
line 108
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 47
EQI4 $57
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $52
LABELV $57
line 115
;114:
;115:	Q_strncpyz(oldPath, path, sizeof ( oldPath));
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 116
;116:	Com_sprintf(path, maxSize, "%s%s", oldPath, extension);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $58
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 117
;117:}
LABELV $51
endproc COM_DefaultExtension 76 20
export ShortSwap
proc ShortSwap 2 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII2 4
ASGNI2
line 149
;118:
;119:/*
;120:============================================================================
;121:
;122:					BYTE ORDER FUNCTIONS
;123:
;124:============================================================================
;125: */
;126:
;127:/*
;128:// can't just use function pointers, or dll linkage can
;129:// mess up when qcommon is included in multiple places
;130:static short	(*_BigShort) (short l);
;131:static short	(*_LittleShort) (short l);
;132:static int		(*_BigLong) (int l);
;133:static int		(*_LittleLong) (int l);
;134:static qint64	(*_BigLong64) (qint64 l);
;135:static qint64	(*_LittleLong64) (qint64 l);
;136:static float	(*_BigFloat) (const float *l);
;137:static float	(*_LittleFloat) (const float *l);
;138:
;139:short	BigShort(short l){return _BigShort(l);}
;140:short	LittleShort(short l) {return _LittleShort(l);}
;141:int		BigLong (int l) {return _BigLong(l);}
;142:int		LittleLong (int l) {return _LittleLong(l);}
;143:qint64 	BigLong64 (qint64 l) {return _BigLong64(l);}
;144:qint64 	LittleLong64 (qint64 l) {return _LittleLong64(l);}
;145:float	BigFloat (const float *l) {return _BigFloat(l);}
;146:float	LittleFloat (const float *l) {return _LittleFloat(l);}
;147: */
;148:
;149:short ShortSwap(short l) {
line 152
;150:	byte b1, b2;
;151:
;152:	b1 = l & 255;
ADDRLP4 0
ADDRFP4 0
INDIRI2
CVII4 2
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 153
;153:	b2 = (l >> 8)&255;
ADDRLP4 1
ADDRFP4 0
INDIRI2
CVII4 2
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 155
;154:
;155:	return (b1 << 8) +b2;
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 8
LSHI4
ADDRLP4 1
INDIRU1
CVUI4 1
ADDI4
CVII2 4
CVII4 2
RETI4
LABELV $59
endproc ShortSwap 2 0
export ShortNoSwap
proc ShortNoSwap 0 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII2 4
ASGNI2
line 158
;156:}
;157:
;158:short ShortNoSwap(short l) {
line 159
;159:	return l;
ADDRFP4 0
INDIRI2
CVII4 2
RETI4
LABELV $60
endproc ShortNoSwap 0 0
export LongSwap
proc LongSwap 4 0
line 162
;160:}
;161:
;162:int LongSwap(int l) {
line 165
;163:	byte b1, b2, b3, b4;
;164:
;165:	b1 = l & 255;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 166
;166:	b2 = (l >> 8)&255;
ADDRLP4 1
ADDRFP4 0
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 167
;167:	b3 = (l >> 16)&255;
ADDRLP4 2
ADDRFP4 0
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 168
;168:	b4 = (l >> 24)&255;
ADDRLP4 3
ADDRFP4 0
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 170
;169:
;170:	return ((int) b1 << 24) + ((int) b2 << 16) + ((int) b3 << 8) + b4;
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 24
LSHI4
ADDRLP4 1
INDIRU1
CVUI4 1
CNSTI4 16
LSHI4
ADDI4
ADDRLP4 2
INDIRU1
CVUI4 1
CNSTI4 8
LSHI4
ADDI4
ADDRLP4 3
INDIRU1
CVUI4 1
ADDI4
RETI4
LABELV $61
endproc LongSwap 4 0
export LongNoSwap
proc LongNoSwap 0 0
line 173
;171:}
;172:
;173:int LongNoSwap(int l) {
line 174
;174:	return l;
ADDRFP4 0
INDIRI4
RETI4
LABELV $62
endproc LongNoSwap 0 0
export Long64Swap
proc Long64Swap 8 0
line 177
;175:}
;176:
;177:qint64 Long64Swap(qint64 ll) {
line 180
;178:	qint64 result;
;179:
;180:	result.b0 = ll.b7;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 7
ADDP4
INDIRU1
ASGNU1
line 181
;181:	result.b1 = ll.b6;
ADDRLP4 0+1
ADDRFP4 4
INDIRP4
CNSTI4 6
ADDP4
INDIRU1
ASGNU1
line 182
;182:	result.b2 = ll.b5;
ADDRLP4 0+2
ADDRFP4 4
INDIRP4
CNSTI4 5
ADDP4
INDIRU1
ASGNU1
line 183
;183:	result.b3 = ll.b4;
ADDRLP4 0+3
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRU1
ASGNU1
line 184
;184:	result.b4 = ll.b3;
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 3
ADDP4
INDIRU1
ASGNU1
line 185
;185:	result.b5 = ll.b2;
ADDRLP4 0+5
ADDRFP4 4
INDIRP4
CNSTI4 2
ADDP4
INDIRU1
ASGNU1
line 186
;186:	result.b6 = ll.b1;
ADDRLP4 0+6
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
ASGNU1
line 187
;187:	result.b7 = ll.b0;
ADDRLP4 0+7
ADDRFP4 4
INDIRP4
INDIRU1
ASGNU1
line 189
;188:
;189:	return result;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 8
LABELV $63
endproc Long64Swap 8 0
export Long64NoSwap
proc Long64NoSwap 0 0
line 192
;190:}
;191:
;192:qint64 Long64NoSwap(qint64 ll) {
line 193
;193:	return ll;
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 8
LABELV $72
endproc Long64NoSwap 0 0
export FloatSwap
proc FloatSwap 8 4
line 201
;194:}
;195:
;196:typedef union {
;197:	float f;
;198:	unsigned int i;
;199:} _FloatByteUnion;
;200:
;201:float FloatSwap(const float *f) {
line 204
;202:	_FloatByteUnion out;
;203:
;204:	out.f = *f;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 205
;205:	out.i = LongSwap(out.i);
ADDRLP4 0
INDIRU4
CVUI4 4
ARGI4
ADDRLP4 4
ADDRGP4 LongSwap
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CVIU4 4
ASGNU4
line 207
;206:
;207:	return out.f;
ADDRLP4 0
INDIRF4
RETF4
LABELV $75
endproc FloatSwap 8 4
export FloatNoSwap
proc FloatNoSwap 0 0
line 210
;208:}
;209:
;210:float FloatNoSwap(const float *f) {
line 211
;211:	return *f;
ADDRFP4 0
INDIRP4
INDIRF4
RETF4
LABELV $76
endproc FloatNoSwap 0 0
export COM_BeginParseSession
proc COM_BeginParseSession 0 16
line 263
;212:}
;213:
;214:/*
;215:================
;216:Swap_Init
;217:================
;218: */
;219:/*
;220:void Swap_Init (void)
;221:{
;222:	byte	swaptest[2] = {1,0};
;223:
;224:// set the byte swapping variables in a portable manner	
;225:	if ( *(short *)swaptest == 1)
;226:	{
;227:		_BigShort = ShortSwap;
;228:		_LittleShort = ShortNoSwap;
;229:		_BigLong = LongSwap;
;230:		_LittleLong = LongNoSwap;
;231:		_BigLong64 = Long64Swap;
;232:		_LittleLong64 = Long64NoSwap;
;233:		_BigFloat = FloatSwap;
;234:		_LittleFloat = FloatNoSwap;
;235:	}
;236:	else
;237:	{
;238:		_BigShort = ShortNoSwap;
;239:		_LittleShort = ShortSwap;
;240:		_BigLong = LongNoSwap;
;241:		_LittleLong = LongSwap;
;242:		_BigLong64 = Long64NoSwap;
;243:		_LittleLong64 = Long64Swap;
;244:		_BigFloat = FloatNoSwap;
;245:		_LittleFloat = FloatSwap;
;246:	}
;247:
;248:}
;249: */
;250:
;251:/*
;252:============================================================================
;253:
;254:PARSING
;255:
;256:============================================================================
;257: */
;258:
;259:static char com_token[MAX_TOKEN_CHARS];
;260:static char com_parsename[MAX_TOKEN_CHARS];
;261:static int com_lines;
;262:
;263:void COM_BeginParseSession(const char *name) {
line 264
;264:	com_lines = 0;
ADDRGP4 com_lines
CNSTI4 0
ASGNI4
line 265
;265:	Com_sprintf(com_parsename, sizeof (com_parsename), "%s", name);
ADDRGP4 com_parsename
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $78
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 266
;266:}
LABELV $77
endproc COM_BeginParseSession 0 16
export COM_GetCurrentParseLine
proc COM_GetCurrentParseLine 0 0
line 268
;267:
;268:int COM_GetCurrentParseLine(void) {
line 269
;269:	return com_lines;
ADDRGP4 com_lines
INDIRI4
RETI4
LABELV $79
endproc COM_GetCurrentParseLine 0 0
export COM_Parse
proc COM_Parse 4 8
line 272
;270:}
;271:
;272:char *COM_Parse(char **data_p) {
line 273
;273:	return COM_ParseExt(data_p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
RETP4
LABELV $80
endproc COM_Parse 4 8
bss
align 1
LABELV $82
skip 4096
export COM_ParseError
code
proc COM_ParseError 4 16
line 276
;274:}
;275:
;276:void COM_ParseError(char *format, ...) {
line 280
;277:	va_list argptr;
;278:	static char string[4096];
;279:
;280:	va_start(argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 281
;281:	Q_vsnprintf(string, sizeof (string), format, argptr);
ADDRGP4 $82
ARGP4
CNSTI4 4096
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_vsnprintf
CALLI4
pop
line 282
;282:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 284
;283:
;284:	Com_Printf("ERROR: %s, line %d: %s\n", com_parsename, com_lines, string);
ADDRGP4 $84
ARGP4
ADDRGP4 com_parsename
ARGP4
ADDRGP4 com_lines
INDIRI4
ARGI4
ADDRGP4 $82
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 285
;285:}
LABELV $81
endproc COM_ParseError 4 16
bss
align 1
LABELV $86
skip 4096
export COM_ParseWarning
code
proc COM_ParseWarning 4 16
line 287
;286:
;287:void COM_ParseWarning(char *format, ...) {
line 291
;288:	va_list argptr;
;289:	static char string[4096];
;290:
;291:	va_start(argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 292
;292:	Q_vsnprintf(string, sizeof (string), format, argptr);
ADDRGP4 $86
ARGP4
CNSTI4 4096
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_vsnprintf
CALLI4
pop
line 293
;293:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 295
;294:
;295:	Com_Printf("WARNING: %s, line %d: %s\n", com_parsename, com_lines, string);
ADDRGP4 $88
ARGP4
ADDRGP4 com_parsename
ARGP4
ADDRGP4 com_lines
INDIRI4
ARGI4
ADDRGP4 $86
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 296
;296:}
LABELV $85
endproc COM_ParseWarning 4 16
proc SkipWhitespace 8 0
line 310
;297:
;298:/*
;299:==============
;300:COM_Parse
;301:
;302:Parse a token out of a string
;303:Will never return NULL, just empty strings
;304:
;305:If "allowLineBreaks" is qtrue then an empty
;306:string will be returned if the next token is
;307:a newline.
;308:==============
;309: */
;310:static char *SkipWhitespace(char *data, qboolean *hasNewLines) {
ADDRGP4 $91
JUMPV
LABELV $90
line 313
;311:	int c;
;312:
;313:	while ((c = *data) <= ' ') {
line 314
;314:		if (!c) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $93
line 315
;315:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $89
JUMPV
LABELV $93
line 317
;316:		}
;317:		if (c == '\n') {
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $95
line 318
;318:			com_lines++;
ADDRLP4 4
ADDRGP4 com_lines
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 319
;319:			*hasNewLines = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 320
;320:		}
LABELV $95
line 321
;321:		data++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 322
;322:	}
LABELV $91
line 313
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 32
LEI4 $90
line 324
;323:
;324:	return data;
ADDRFP4 0
INDIRP4
RETP4
LABELV $89
endproc SkipWhitespace 8 0
export COM_Compress
proc COM_Compress 48 0
line 327
;325:}
;326:
;327:int COM_Compress(char *data_p) {
line 330
;328:	char *in, *out;
;329:	int c;
;330:	qboolean newline = qfalse, whitespace = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
line 332
;331:
;332:	in = out = data_p;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 333
;333:	if (in) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $98
ADDRGP4 $101
JUMPV
LABELV $100
line 334
;334:		while ((c = *in) != 0) {
line 336
;335:			// skip double slash comments
;336:			if (c == '/' && in[1] == '/') {
ADDRLP4 24
CNSTI4 47
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $103
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRI4
NEI4 $103
ADDRGP4 $106
JUMPV
LABELV $105
line 337
;337:				while (*in && *in != '\n') {
line 338
;338:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 339
;339:				}
LABELV $106
line 337
ADDRLP4 28
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $108
ADDRLP4 28
INDIRI4
CNSTI4 10
NEI4 $105
LABELV $108
line 341
;340:				// skip /* */ comments
;341:			} else if (c == '/' && in[1] == '*') {
ADDRGP4 $104
JUMPV
LABELV $103
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $109
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $109
ADDRGP4 $112
JUMPV
LABELV $111
line 343
;342:				while (*in && (*in != '*' || in[1] != '/'))
;343:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $112
line 342
ADDRLP4 32
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $114
ADDRLP4 32
INDIRI4
CNSTI4 42
NEI4 $111
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $111
LABELV $114
line 344
;344:				if (*in)
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $110
line 345
;345:					in += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 347
;346:				// record when we hit a newline
;347:			} else if (c == '\n' || c == '\r') {
ADDRGP4 $110
JUMPV
LABELV $109
ADDRLP4 4
INDIRI4
CNSTI4 10
EQI4 $119
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $117
LABELV $119
line 348
;348:				newline = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 349
;349:				in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 351
;350:				// record when we hit whitespace
;351:			} else if (c == ' ' || c == '\t') {
ADDRGP4 $118
JUMPV
LABELV $117
ADDRLP4 4
INDIRI4
CNSTI4 32
EQI4 $122
ADDRLP4 4
INDIRI4
CNSTI4 9
NEI4 $120
LABELV $122
line 352
;352:				whitespace = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 353
;353:				in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 355
;354:				// an actual token
;355:			} else {
ADDRGP4 $121
JUMPV
LABELV $120
line 357
;356:				// if we have a pending newline, emit it (and it counts as whitespace)
;357:				if (newline) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $123
line 358
;358:					*out++ = '\n';
ADDRLP4 36
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI1 10
ASGNI1
line 359
;359:					newline = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 360
;360:					whitespace = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 361
;361:				}
LABELV $123
line 362
;362:				if (whitespace) {
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $125
line 363
;363:					*out++ = ' ';
ADDRLP4 36
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI1 32
ASGNI1
line 364
;364:					whitespace = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 365
;365:				}
LABELV $125
line 368
;366:
;367:				// copy quoted strings unmolested
;368:				if (c == '"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $127
line 369
;369:					*out++ = c;
ADDRLP4 36
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 370
;370:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $130
JUMPV
LABELV $129
line 371
;371:					while (1) {
line 372
;372:						c = *in;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 373
;373:						if (c && c != '"') {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $131
ADDRLP4 4
INDIRI4
CNSTI4 34
EQI4 $131
line 374
;374:							*out++ = c;
ADDRLP4 44
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 375
;375:							in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 376
;376:						} else {
line 377
;377:							break;
LABELV $133
line 379
;378:						}
;379:					}
LABELV $130
line 371
ADDRGP4 $129
JUMPV
LABELV $131
line 380
;380:					if (c == '"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $128
line 381
;381:						*out++ = c;
ADDRLP4 40
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 382
;382:						in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 383
;383:					}
line 384
;384:				} else {
ADDRGP4 $128
JUMPV
LABELV $127
line 385
;385:					*out = c;
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 386
;386:					out++;
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 387
;387:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 388
;388:				}
LABELV $128
line 389
;389:			}
LABELV $121
LABELV $118
LABELV $110
LABELV $104
line 390
;390:		}
LABELV $101
line 334
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $100
line 391
;391:		*out = 0;
ADDRLP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 392
;392:		return out - data_p;
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
RETI4
ADDRGP4 $97
JUMPV
LABELV $98
line 394
;393:	}
;394:	return 0;
CNSTI4 0
RETI4
LABELV $97
endproc COM_Compress 48 0
export COM_ParseExt
proc COM_ParseExt 36 8
line 397
;395:}
;396:
;397:char *COM_ParseExt(char **data_p, qboolean allowLineBreaks) {
line 398
;398:	int c = 0, len;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 399
;399:	qboolean hasNewLines = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 402
;400:	char *data;
;401:
;402:	data = *data_p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 403
;403:	len = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 404
;404:	com_token[0] = 0;
ADDRGP4 com_token
CNSTI1 0
ASGNI1
line 407
;405:
;406:	// make sure incoming data is valid
;407:	if (!data) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $140
line 408
;408:		*data_p = NULL;
ADDRFP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 409
;409:		return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $136
JUMPV
LABELV $139
line 412
;410:	}
;411:
;412:	while (1) {
line 414
;413:		// skip whitespace
;414:		data = SkipWhitespace(data, &hasNewLines);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ADDRGP4 SkipWhitespace
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 415
;415:		if (!data) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $142
line 416
;416:			*data_p = NULL;
ADDRFP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 417
;417:			return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $136
JUMPV
LABELV $142
line 419
;418:		}
;419:		if (hasNewLines && !allowLineBreaks) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $144
ADDRFP4 4
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $144
line 420
;420:			*data_p = data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 421
;421:			return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $136
JUMPV
LABELV $144
line 424
;422:		}
;423:
;424:		c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 427
;425:
;426:		// skip double slash comments
;427:		if (c == '/' && data[1] == '/') {
ADDRLP4 24
CNSTI4 47
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $146
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRI4
NEI4 $146
line 428
;428:			data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $148
line 429
;429:			while (*data && *data != '\n') {
line 430
;430:				data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 431
;431:			}
LABELV $149
line 429
ADDRLP4 28
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $151
ADDRLP4 28
INDIRI4
CNSTI4 10
NEI4 $148
LABELV $151
line 432
;432:		}			// skip /* */ comments
ADDRGP4 $147
JUMPV
LABELV $146
line 433
;433:		else if (c == '/' && data[1] == '*') {
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $141
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $141
line 434
;434:			data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
ADDRGP4 $155
JUMPV
LABELV $154
line 435
;435:			while (*data && (*data != '*' || data[1] != '/')) {
line 436
;436:				data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 437
;437:			}
LABELV $155
line 435
ADDRLP4 32
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $157
ADDRLP4 32
INDIRI4
CNSTI4 42
NEI4 $154
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $154
LABELV $157
line 438
;438:			if (*data) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $153
line 439
;439:				data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 440
;440:			}
line 441
;441:		} else {
line 442
;442:			break;
LABELV $153
LABELV $147
line 444
;443:		}
;444:	}
LABELV $140
line 412
ADDRGP4 $139
JUMPV
LABELV $141
line 447
;445:
;446:	// handle quoted strings
;447:	if (c == '\"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $160
line 448
;448:		data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $163
JUMPV
LABELV $162
line 449
;449:		while (1) {
line 450
;450:			c = *data++;
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 451
;451:			if (c == '\"' || !c) {
ADDRLP4 4
INDIRI4
CNSTI4 34
EQI4 $167
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $165
LABELV $167
line 452
;452:				com_token[len] = 0;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
CNSTI1 0
ASGNI1
line 453
;453:				*data_p = (char *) data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 454
;454:				return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $136
JUMPV
LABELV $165
line 456
;455:			}
;456:			if (len < MAX_TOKEN_CHARS - 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1023
GEI4 $168
line 457
;457:				com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 458
;458:				len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 459
;459:			}
LABELV $168
line 460
;460:		}
LABELV $163
line 449
ADDRGP4 $162
JUMPV
line 461
;461:	}
LABELV $160
LABELV $170
line 464
;462:
;463:	// parse a regular word
;464:	do {
line 465
;465:		if (len < MAX_TOKEN_CHARS - 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1023
GEI4 $173
line 466
;466:			com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 467
;467:			len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 468
;468:		}
LABELV $173
line 469
;469:		data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 470
;470:		c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 471
;471:		if (c == '\n')
ADDRLP4 4
INDIRI4
CNSTI4 10
NEI4 $175
line 472
;472:			com_lines++;
ADDRLP4 16
ADDRGP4 com_lines
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $175
line 473
;473:	} while (c > 32);
LABELV $171
ADDRLP4 4
INDIRI4
CNSTI4 32
GTI4 $170
line 475
;474:
;475:	com_token[len] = 0;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
CNSTI1 0
ASGNI1
line 477
;476:
;477:	*data_p = (char *) data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 478
;478:	return com_token;
ADDRGP4 com_token
RETP4
LABELV $136
endproc COM_ParseExt 36 8
export COM_MatchToken
proc COM_MatchToken 12 16
line 542
;479:}
;480:
;481:
;482:#if 0
;483:// no longer used
;484:
;485:/*
;486:===============
;487:COM_ParseInfos
;488:===============
;489: */
;490:int COM_ParseInfos(char *buf, int max, char infos[][MAX_INFO_STRING]) {
;491:	char *token;
;492:	int count;
;493:	char key[MAX_TOKEN_CHARS];
;494:
;495:	count = 0;
;496:
;497:	while (1) {
;498:		token = COM_Parse(&buf);
;499:		if (!token[0]) {
;500:			break;
;501:		}
;502:		if (strcmp(token, "{")) {
;503:			Com_Printf("Missing { in info file\n");
;504:			break;
;505:		}
;506:
;507:		if (count == max) {
;508:			Com_Printf("Max infos exceeded\n");
;509:			break;
;510:		}
;511:
;512:		infos[count][0] = 0;
;513:		while (1) {
;514:			token = COM_ParseExt(&buf, qtrue);
;515:			if (!token[0]) {
;516:				Com_Printf("Unexpected end of info file\n");
;517:				break;
;518:			}
;519:			if (!strcmp(token, "}")) {
;520:				break;
;521:			}
;522:			Q_strncpyz(key, token, sizeof ( key));
;523:
;524:			token = COM_ParseExt(&buf, qfalse);
;525:			if (!token[0]) {
;526:				strcpy(token, "<NULL>");
;527:			}
;528:			Info_SetValueForKey(infos[count], key, token);
;529:		}
;530:		count++;
;531:	}
;532:
;533:	return count;
;534:}
;535:#endif
;536:
;537:/*
;538:==================
;539:COM_MatchToken
;540:==================
;541: */
;542:void COM_MatchToken(char **buf_p, char *match) {
line 545
;543:	char *token;
;544:
;545:	token = COM_Parse(buf_p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 546
;546:	if (strcmp(token, match)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $178
line 547
;547:		Com_Error(ERR_DROP, "MatchToken: %s != %s", token, match);
CNSTI4 1
ARGI4
ADDRGP4 $180
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 548
;548:	}
LABELV $178
line 549
;549:}
LABELV $177
endproc COM_MatchToken 12 16
export SkipBracedSection
proc SkipBracedSection 12 8
line 560
;550:
;551:/*
;552:=================
;553:SkipBracedSection
;554:
;555:The next token should be an open brace.
;556:Skips until a matching close brace is found.
;557:Internal brace depths are properly skipped.
;558:=================
;559: */
;560:void SkipBracedSection(char **program) {
line 564
;561:	char *token;
;562:	int depth;
;563:
;564:	depth = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $182
line 565
;565:	do {
line 566
;566:		token = COM_ParseExt(program, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 567
;567:		if (token[1] == 0) {
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $185
line 568
;568:			if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $187
line 569
;569:				depth++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 570
;570:			} else if (token[0] == '}') {
ADDRGP4 $188
JUMPV
LABELV $187
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $189
line 571
;571:				depth--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 572
;572:			}
LABELV $189
LABELV $188
line 573
;573:		}
LABELV $185
line 574
;574:	} while (depth && *program);
LABELV $183
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $191
ADDRFP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $182
LABELV $191
line 575
;575:}
LABELV $181
endproc SkipBracedSection 12 8
export SkipRestOfLine
proc SkipRestOfLine 16 0
line 582
;576:
;577:/*
;578:=================
;579:SkipRestOfLine
;580:=================
;581: */
;582:void SkipRestOfLine(char **data) {
line 586
;583:	char *p;
;584:	int c;
;585:
;586:	p = *data;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRGP4 $194
JUMPV
LABELV $193
line 587
;587:	while ((c = *p++) != 0) {
line 588
;588:		if (c == '\n') {
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $196
line 589
;589:			com_lines++;
ADDRLP4 8
ADDRGP4 com_lines
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 590
;590:			break;
ADDRGP4 $195
JUMPV
LABELV $196
line 592
;591:		}
;592:	}
LABELV $194
line 587
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $193
LABELV $195
line 594
;593:
;594:	*data = p;
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRP4
ASGNP4
line 595
;595:}
LABELV $192
endproc SkipRestOfLine 16 0
export Parse1DMatrix
proc Parse1DMatrix 16 8
line 597
;596:
;597:void Parse1DMatrix(char **buf_p, int x, float *m) {
line 601
;598:	char *token;
;599:	int i;
;600:
;601:	COM_MatchToken(buf_p, "(");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $199
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 603
;602:
;603:	for (i = 0; i < x; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $203
JUMPV
LABELV $200
line 604
;604:		token = COM_Parse(buf_p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 605
;605:		m[i] = atof(token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 606
;606:	}
LABELV $201
line 603
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $203
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $200
line 608
;607:
;608:	COM_MatchToken(buf_p, ")");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $204
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 609
;609:}
LABELV $198
endproc Parse1DMatrix 16 8
export Parse2DMatrix
proc Parse2DMatrix 8 12
line 611
;610:
;611:void Parse2DMatrix(char **buf_p, int y, int x, float *m) {
line 614
;612:	int i;
;613:
;614:	COM_MatchToken(buf_p, "(");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $199
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 616
;615:
;616:	for (i = 0; i < y; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $209
JUMPV
LABELV $206
line 617
;617:		Parse1DMatrix(buf_p, x, m + i * x);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 2
LSHI4
ADDRFP4 12
INDIRP4
ADDP4
ARGP4
ADDRGP4 Parse1DMatrix
CALLV
pop
line 618
;618:	}
LABELV $207
line 616
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $209
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $206
line 620
;619:
;620:	COM_MatchToken(buf_p, ")");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $204
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 621
;621:}
LABELV $205
endproc Parse2DMatrix 8 12
export Parse3DMatrix
proc Parse3DMatrix 12 16
line 623
;622:
;623:void Parse3DMatrix(char **buf_p, int z, int y, int x, float *m) {
line 626
;624:	int i;
;625:
;626:	COM_MatchToken(buf_p, "(");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $199
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 628
;627:
;628:	for (i = 0; i < z; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $214
JUMPV
LABELV $211
line 629
;629:		Parse2DMatrix(buf_p, y, x, m + i * x * y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRFP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 2
LSHI4
ADDRFP4 16
INDIRP4
ADDP4
ARGP4
ADDRGP4 Parse2DMatrix
CALLV
pop
line 630
;630:	}
LABELV $212
line 628
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $214
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $211
line 632
;631:
;632:	COM_MatchToken(buf_p, ")");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $204
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 633
;633:}
LABELV $210
endproc Parse3DMatrix 12 16
export Q_StrToLower
proc Q_StrToLower 12 4
line 635
;634:
;635:void Q_StrToLower(char *io_string) {
line 637
;636:	int i;
;637:	for (i = 0; i < strlen(io_string); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $219
JUMPV
LABELV $216
line 638
;638:		io_string[i] = tolower(io_string[i]);
ADDRLP4 4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 639
;639:	}
LABELV $217
line 637
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $219
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $216
line 640
;640:}
LABELV $215
endproc Q_StrToLower 12 4
export Q_isprint
proc Q_isprint 4 0
line 650
;641:
;642:/*
;643:============================================================================
;644:
;645:					LIBRARY REPLACEMENT FUNCTIONS
;646:
;647:============================================================================
;648: */
;649:
;650:int Q_isprint(int c) {
line 651
;651:	if (c >= 0x20 && c <= 0x7E)
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $221
ADDRLP4 0
INDIRI4
CNSTI4 126
GTI4 $221
line 652
;652:		return ( 1);
CNSTI4 1
RETI4
ADDRGP4 $220
JUMPV
LABELV $221
line 653
;653:	return ( 0);
CNSTI4 0
RETI4
LABELV $220
endproc Q_isprint 4 0
export Q_islower
proc Q_islower 4 0
line 656
;654:}
;655:
;656:int Q_islower(int c) {
line 657
;657:	if (c >= 'a' && c <= 'z')
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $224
ADDRLP4 0
INDIRI4
CNSTI4 122
GTI4 $224
line 658
;658:		return ( 1);
CNSTI4 1
RETI4
ADDRGP4 $223
JUMPV
LABELV $224
line 659
;659:	return ( 0);
CNSTI4 0
RETI4
LABELV $223
endproc Q_islower 4 0
export Q_isupper
proc Q_isupper 4 0
line 662
;660:}
;661:
;662:int Q_isupper(int c) {
line 663
;663:	if (c >= 'A' && c <= 'Z')
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $227
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $227
line 664
;664:		return ( 1);
CNSTI4 1
RETI4
ADDRGP4 $226
JUMPV
LABELV $227
line 665
;665:	return ( 0);
CNSTI4 0
RETI4
LABELV $226
endproc Q_isupper 4 0
export Q_isalpha
proc Q_isalpha 8 0
line 668
;666:}
;667:
;668:int Q_isalpha(int c) {
line 669
;669:	if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $233
ADDRLP4 0
INDIRI4
CNSTI4 122
LEI4 $232
LABELV $233
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 65
LTI4 $230
ADDRLP4 4
INDIRI4
CNSTI4 90
GTI4 $230
LABELV $232
line 670
;670:		return ( 1);
CNSTI4 1
RETI4
ADDRGP4 $229
JUMPV
LABELV $230
line 671
;671:	return ( 0);
CNSTI4 0
RETI4
LABELV $229
endproc Q_isalpha 8 0
export Q_strrchr
proc Q_strrchr 12 0
line 674
;672:}
;673:
;674:char* Q_strrchr(const char* string, int c) {
line 675
;675:	char cc = c;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 677
;676:	char *s;
;677:	char *sp = (char *) 0;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 679
;678:
;679:	s = (char*) string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $236
JUMPV
LABELV $235
line 681
;680:
;681:	while (*s) {
line 682
;682:		if (*s == cc)
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI1
CVII4 1
NEI4 $238
line 683
;683:			sp = s;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $238
line 684
;684:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 685
;685:	}
LABELV $236
line 681
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $235
line 686
;686:	if (cc == 0)
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $240
line 687
;687:		sp = s;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $240
line 689
;688:
;689:	return sp;
ADDRLP4 8
INDIRP4
RETP4
LABELV $234
endproc Q_strrchr 12 0
export Q_strncpyz
proc Q_strncpyz 0 12
line 699
;690:}
;691:
;692:/*
;693:=============
;694:Q_strncpyz
;695: 
;696:Safe strncpy that ensures a trailing zero
;697:=============
;698: */
;699:void Q_strncpyz(char *dest, const char *src, int destsize) {
line 700
;700:	if (!dest) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $243
line 701
;701:		Com_Error(ERR_FATAL, "Q_strncpyz: NULL dest");
CNSTI4 0
ARGI4
ADDRGP4 $245
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 702
;702:	}
LABELV $243
line 703
;703:	if (!src) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $246
line 704
;704:		Com_Error(ERR_FATAL, "Q_strncpyz: NULL src");
CNSTI4 0
ARGI4
ADDRGP4 $248
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 705
;705:	}
LABELV $246
line 706
;706:	if (destsize < 1) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $249
line 707
;707:		Com_Error(ERR_FATAL, "Q_strncpyz: destsize < 1");
CNSTI4 0
ARGI4
ADDRGP4 $251
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 708
;708:	}
LABELV $249
line 710
;709:
;710:	strncpy(dest, src, destsize - 1);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 711
;711:	dest[destsize - 1] = 0;
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 712
;712:}
LABELV $242
endproc Q_strncpyz 0 12
export Q_stricmpn
proc Q_stricmpn 32 0
line 714
;713:
;714:int Q_stricmpn(const char *s1, const char *s2, int n) {
line 717
;715:	int c1, c2;
;716:
;717:	if (s1 == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $253
line 718
;718:		if (s2 == NULL)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $255
line 719
;719:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $252
JUMPV
LABELV $255
line 721
;720:		else
;721:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $252
JUMPV
LABELV $253
line 722
;722:	} else if (s2 == NULL)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $257
line 723
;723:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $252
JUMPV
LABELV $257
LABELV $259
line 727
;724:
;725:
;726:
;727:	do {
line 728
;728:		c1 = *s1++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 729
;729:		c2 = *s2++;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 731
;730:
;731:		if (!n--) {
ADDRLP4 16
ADDRFP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $262
line 732
;732:			return 0; // strings are equal until end point
CNSTI4 0
RETI4
ADDRGP4 $252
JUMPV
LABELV $262
line 735
;733:		}
;734:
;735:		if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $264
line 736
;736:			if (c1 >= 'a' && c1 <= 'z') {
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $266
ADDRLP4 0
INDIRI4
CNSTI4 122
GTI4 $266
line 737
;737:				c1 -= ('a' - 'A');
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 738
;738:			}
LABELV $266
line 739
;739:			if (c2 >= 'a' && c2 <= 'z') {
ADDRLP4 4
INDIRI4
CNSTI4 97
LTI4 $268
ADDRLP4 4
INDIRI4
CNSTI4 122
GTI4 $268
line 740
;740:				c2 -= ('a' - 'A');
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 741
;741:			}
LABELV $268
line 742
;742:			if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $270
line 743
;743:				return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $273
ADDRLP4 28
CNSTI4 -1
ASGNI4
ADDRGP4 $274
JUMPV
LABELV $273
ADDRLP4 28
CNSTI4 1
ASGNI4
LABELV $274
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $252
JUMPV
LABELV $270
line 745
;744:			}
;745:		}
LABELV $264
line 746
;746:	} while (c1);
LABELV $260
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $259
line 748
;747:
;748:	return 0; // strings are equal
CNSTI4 0
RETI4
LABELV $252
endproc Q_stricmpn 32 0
export Q_strncmp
proc Q_strncmp 24 0
line 751
;749:}
;750:
;751:int Q_strncmp(const char *s1, const char *s2, int n) {
LABELV $276
line 754
;752:	int c1, c2;
;753:
;754:	do {
line 755
;755:		c1 = *s1++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 756
;756:		c2 = *s2++;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 758
;757:
;758:		if (!n--) {
ADDRLP4 16
ADDRFP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $279
line 759
;759:			return 0; // strings are equal until end point
CNSTI4 0
RETI4
ADDRGP4 $275
JUMPV
LABELV $279
line 762
;760:		}
;761:
;762:		if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $281
line 763
;763:			return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $284
ADDRLP4 20
CNSTI4 -1
ASGNI4
ADDRGP4 $285
JUMPV
LABELV $284
ADDRLP4 20
CNSTI4 1
ASGNI4
LABELV $285
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $275
JUMPV
LABELV $281
line 765
;764:		}
;765:	} while (c1);
LABELV $277
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $276
line 767
;766:
;767:	return 0; // strings are equal
CNSTI4 0
RETI4
LABELV $275
endproc Q_strncmp 24 0
export Q_stricmp
proc Q_stricmp 12 12
line 770
;768:}
;769:
;770:int Q_stricmp(const char *s1, const char *s2) {
line 771
;771:	return (s1 && s2) ? Q_stricmpn(s1, s2, 99999) : -1;
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $288
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $288
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 99999
ARGI4
ADDRLP4 8
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
ADDRGP4 $289
JUMPV
LABELV $288
ADDRLP4 0
CNSTI4 -1
ASGNI4
LABELV $289
ADDRLP4 0
INDIRI4
RETI4
LABELV $286
endproc Q_stricmp 12 12
export Q_strlwr
proc Q_strlwr 12 4
line 774
;772:}
;773:
;774:char *Q_strlwr(char *s1) {
line 777
;775:	char *s;
;776:
;777:	s = s1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $292
JUMPV
LABELV $291
line 778
;778:	while (*s) {
line 779
;779:		*s = tolower(*s);
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 780
;780:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 781
;781:	}
LABELV $292
line 778
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $291
line 782
;782:	return s1;
ADDRFP4 0
INDIRP4
RETP4
LABELV $290
endproc Q_strlwr 12 4
export Q_strupr
proc Q_strupr 12 4
line 785
;783:}
;784:
;785:char *Q_strupr(char *s1) {
line 788
;786:	char *s;
;787:
;788:	s = s1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $296
JUMPV
LABELV $295
line 789
;789:	while (*s) {
line 790
;790:		*s = toupper(*s);
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 791
;791:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 792
;792:	}
LABELV $296
line 789
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $295
line 793
;793:	return s1;
ADDRFP4 0
INDIRP4
RETP4
LABELV $294
endproc Q_strupr 12 4
export Q_strcat
proc Q_strcat 12 12
line 799
;794:}
;795:
;796:
;797:// never goes past bounds or leaves without a terminating 0
;798:
;799:void Q_strcat(char *dest, int size, const char *src) {
line 802
;800:	int l1;
;801:
;802:	l1 = strlen(dest);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 803
;803:	if (l1 >= size) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $299
line 804
;804:		Com_Error(ERR_FATAL, "Q_strcat: already overflowed");
CNSTI4 0
ARGI4
ADDRGP4 $301
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 805
;805:	}
LABELV $299
line 806
;806:	Q_strncpyz(dest + l1, src, size - l1);
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 807
;807:}
LABELV $298
endproc Q_strcat 12 12
export Q_stristr
proc Q_stristr 36 12
line 812
;808:
;809:/*
;810: * Find the first occurrence of find in s.
;811: */
;812:const char *Q_stristr(const char *s, const char *find) {
line 816
;813:	char c, sc;
;814:	size_t len;
;815:
;816:	if ((c = *find++) != 0) {
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRI1
ASGNI1
ADDRLP4 1
ADDRLP4 12
INDIRI1
ASGNI1
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $303
line 817
;817:		if (c >= 'a' && c <= 'z') {
ADDRLP4 16
ADDRLP4 1
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 97
LTI4 $305
ADDRLP4 16
INDIRI4
CNSTI4 122
GTI4 $305
line 818
;818:			c -= ('a' - 'A');
ADDRLP4 1
ADDRLP4 1
INDIRI1
CVII4 1
CNSTI4 32
SUBI4
CVII1 4
ASGNI1
line 819
;819:		}
LABELV $305
line 820
;820:		len = strlen(find);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
LABELV $307
line 821
;821:		do {
LABELV $310
line 822
;822:			do {
line 823
;823:				if ((sc = *s++) == 0)
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
INDIRI1
ASGNI1
ADDRLP4 0
ADDRLP4 28
INDIRI1
ASGNI1
ADDRLP4 28
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $313
line 824
;824:					return NULL;
CNSTP4 0
RETP4
ADDRGP4 $302
JUMPV
LABELV $313
line 825
;825:				if (sc >= 'a' && sc <= 'z') {
ADDRLP4 32
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 97
LTI4 $315
ADDRLP4 32
INDIRI4
CNSTI4 122
GTI4 $315
line 826
;826:					sc -= ('a' - 'A');
ADDRLP4 0
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 32
SUBI4
CVII1 4
ASGNI1
line 827
;827:				}
LABELV $315
line 828
;828:			} while (sc != c);
LABELV $311
ADDRLP4 0
INDIRI1
CVII4 1
ADDRLP4 1
INDIRI1
CVII4 1
NEI4 $310
line 829
;829:		} while (!Q_strequaln(s, find, len));
LABELV $308
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $307
line 830
;830:		s--;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 -1
ADDP4
ASGNP4
line 831
;831:	}
LABELV $303
line 832
;832:	return s;
ADDRFP4 0
INDIRP4
RETP4
LABELV $302
endproc Q_stristr 36 12
export Q_PrintStrlen
proc Q_PrintStrlen 16 0
line 835
;833:}
;834:
;835:int Q_PrintStrlen(const char *string) {
line 839
;836:	int len;
;837:	const char *p;
;838:
;839:	if (!string) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $318
line 840
;840:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $317
JUMPV
LABELV $318
line 843
;841:	}
;842:
;843:	len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 844
;844:	p = string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $321
JUMPV
LABELV $320
line 845
;845:	while (*p) {
line 846
;846:		if (Q_IsColorString(p)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $323
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $323
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $323
ADDRLP4 12
INDIRI4
CNSTI4 48
LTI4 $323
ADDRLP4 12
INDIRI4
CNSTI4 56
GTI4 $323
line 847
;847:			p += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 848
;848:			continue;
ADDRGP4 $321
JUMPV
LABELV $323
line 850
;849:		}
;850:		p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 851
;851:		len++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 852
;852:	}
LABELV $321
line 845
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $320
line 854
;853:
;854:	return len;
ADDRLP4 4
INDIRI4
RETI4
LABELV $317
endproc Q_PrintStrlen 16 0
export Q_CleanStr
proc Q_CleanStr 32 4
line 857
;855:}
;856:
;857:char *Q_CleanStr(char *string) {
line 861
;858:	char* d;
;859:	char* s;
;860:	int c;
;861:	qboolean hadColor = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 863
;862:
;863:	s = string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 864
;864:	d = string;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $327
JUMPV
LABELV $326
line 865
;865:	while ((c = *s) != 0) {
line 866
;866:		if (Q_IsColorString(s)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $329
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $329
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $329
ADDRLP4 20
INDIRI4
CNSTI4 48
LTI4 $329
ADDRLP4 20
INDIRI4
CNSTI4 56
GTI4 $329
line 867
;867:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 868
;868:			hadColor = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 869
;869:		} else if (c >= 0x20 && c <= 0x7E) {
ADDRGP4 $330
JUMPV
LABELV $329
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $331
ADDRLP4 4
INDIRI4
CNSTI4 126
GTI4 $331
line 870
;870:			*d++ = c;
ADDRLP4 28
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 871
;871:		}
LABELV $331
LABELV $330
line 872
;872:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 873
;873:	}
LABELV $327
line 865
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $326
line 874
;874:	*d = '\0';
ADDRLP4 12
INDIRP4
CNSTI1 0
ASGNI1
line 875
;875:	if (hadColor)
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $333
line 876
;876:		return Q_CleanStr(string);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_CleanStr
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
RETP4
ADDRGP4 $325
JUMPV
LABELV $333
line 878
;877:	else
;878:		return string;
ADDRFP4 0
INDIRP4
RETP4
LABELV $325
endproc Q_CleanStr 32 4
export Q_CountChar
proc Q_CountChar 4 0
ADDRFP4 4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 881
;879:}
;880:
;881:int Q_CountChar(const char *string, char tocount) {
line 884
;882:	int count;
;883:
;884:	for (count = 0; *string; string++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $339
JUMPV
LABELV $336
line 885
;885:		if (*string == tocount)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRFP4 4
INDIRI1
CVII4 1
NEI4 $340
line 886
;886:			count++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $340
line 887
;887:	}
LABELV $337
line 884
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $339
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $336
line 889
;888:
;889:	return count;
ADDRLP4 0
INDIRI4
RETI4
LABELV $335
endproc Q_CountChar 4 0
export Com_sprintf
proc Com_sprintf 32012 16
line 892
;890:}
;891:
;892:void QDECL Com_sprintf(char *dest, int size, const char *fmt, ...) {
line 897
;893:	int len;
;894:	va_list argptr;
;895:	char bigbuffer[32000]; // big, but small enough to fit in PPC stack
;896:
;897:	va_start(argptr, fmt);
ADDRLP4 32004
ADDRFP4 8+4
ASGNP4
line 898
;898:	len = Q_vsnprintf(bigbuffer, sizeof (bigbuffer), fmt, argptr);
ADDRLP4 0
ARGP4
CNSTI4 32000
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 32004
INDIRP4
ARGP4
ADDRLP4 32008
ADDRGP4 Q_vsnprintf
CALLI4
ASGNI4
ADDRLP4 32000
ADDRLP4 32008
INDIRI4
ASGNI4
line 899
;899:	va_end(argptr);
ADDRLP4 32004
CNSTP4 0
ASGNP4
line 900
;900:	if (len >= sizeof ( bigbuffer)) {
ADDRLP4 32000
INDIRI4
CVIU4 4
CNSTU4 32000
LTU4 $344
line 901
;901:		Com_Error(ERR_FATAL, "Com_sprintf: overflowed bigbuffer");
CNSTI4 0
ARGI4
ADDRGP4 $346
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 902
;902:	}
LABELV $344
line 903
;903:	if (len >= size) {
ADDRLP4 32000
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $347
line 904
;904:		Com_Printf("Com_sprintf: overflow of %i in %i\n", len, size);
ADDRGP4 $349
ARGP4
ADDRLP4 32000
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 911
;905:#ifdef _DEBUG
;906:		__asm
;907:		{
;908:			int 3;
;909:		}
;910:#endif
;911:	}
LABELV $347
line 912
;912:	Q_strncpyz(dest, bigbuffer, size);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 913
;913:}
LABELV $342
endproc Com_sprintf 32012 16
bss
align 1
LABELV $351
skip 64000
data
align 4
LABELV $352
byte 4 0
export va
code
proc va 12 16
line 923
;914:
;915:/*
;916:============
;917:va
;918:
;919:does a varargs printf into a temp buffer, so I don't need to have
;920:varargs versions of all text functions.
;921:============
;922: */
;923:char * QDECL va(char *format, ...) {
line 929
;924:	va_list argptr;
;925:	static char string[2][32000]; // in case va is called by nested functions
;926:	static int index = 0;
;927:	char *buf;
;928:
;929:	buf = string[index & 1];
ADDRLP4 4
CNSTI4 32000
ADDRGP4 $352
INDIRI4
CNSTI4 1
BANDI4
MULI4
ADDRGP4 $351
ADDP4
ASGNP4
line 930
;930:	index++;
ADDRLP4 8
ADDRGP4 $352
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 932
;931:
;932:	va_start(argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 933
;933:	Q_vsnprintf(buf, sizeof (*string), format, argptr);
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 32000
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_vsnprintf
CALLI4
pop
line 934
;934:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 936
;935:
;936:	return buf;
ADDRLP4 4
INDIRP4
RETP4
LABELV $350
endproc va 12 16
export Com_TruncateLongString
proc Com_TruncateLongString 8 12
line 946
;937:}
;938:
;939:/*
;940:============
;941:Com_TruncateLongString
;942:
;943:Assumes buffer is atleast TRUNCATE_LENGTH big
;944:============
;945: */
;946:void Com_TruncateLongString(char *buffer, const char *s) {
line 947
;947:	int length = strlen(s);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 949
;948:
;949:	if (length <= TRUNCATE_LENGTH) {
ADDRLP4 0
INDIRI4
CNSTI4 64
GTI4 $355
line 950
;950:		Q_strncpyz(buffer, s, TRUNCATE_LENGTH);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 951
;951:	}
ADDRGP4 $356
JUMPV
LABELV $355
line 952
;952:	else {
line 953
;953:		Q_strncpyz(buffer, s, (TRUNCATE_LENGTH / 2) - 3);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 29
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 954
;954:		Q_strcat(buffer, TRUNCATE_LENGTH, " ... ");
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $357
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 955
;955:		Q_strcat(buffer, TRUNCATE_LENGTH, s + length - (TRUNCATE_LENGTH / 2) + 3);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI4 -29
ADDP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 956
;956:	}
LABELV $356
line 957
;957:}
LABELV $354
endproc Com_TruncateLongString 8 12
bss
align 1
LABELV $359
skip 16384
data
align 4
LABELV $360
byte 4 0
export Info_ValueForKey
code
proc Info_ValueForKey 8220 8
line 976
;958:
;959:/*
;960:=====================================================================
;961:
;962: INFO STRINGS
;963:
;964:=====================================================================
;965: */
;966:
;967:/*
;968:===============
;969:Info_ValueForKey
;970:
;971:Searches the string for the given
;972:key and returns the associated value, or an empty string.
;973:FIXME: overflow check?
;974:===============
;975: */
;976:char *Info_ValueForKey(const char *s, const char *key) {
line 983
;977:	char pkey[BIG_INFO_KEY];
;978:	static char value[2][BIG_INFO_VALUE]; // use two buffers so compares
;979:	// work without stomping on each other
;980:	static int valueindex = 0;
;981:	char *o;
;982:
;983:	if (!s || !key) {
ADDRLP4 8196
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 8196
INDIRU4
EQU4 $363
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 8196
INDIRU4
NEU4 $361
LABELV $363
line 984
;984:		return "";
ADDRGP4 $41
RETP4
ADDRGP4 $358
JUMPV
LABELV $361
line 987
;985:	}
;986:
;987:	if (strlen(s) >= BIG_INFO_STRING) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8200
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8200
INDIRI4
CNSTI4 8192
LTI4 $364
line 988
;988:		Com_Error(ERR_DROP, "Info_ValueForKey: oversize infostring");
CNSTI4 1
ARGI4
ADDRGP4 $366
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 989
;989:	}
LABELV $364
line 991
;990:
;991:	valueindex ^= 1;
ADDRLP4 8204
ADDRGP4 $360
ASGNP4
ADDRLP4 8204
INDIRP4
ADDRLP4 8204
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 992
;992:	if (*s == '\\')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $370
line 993
;993:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $370
JUMPV
LABELV $369
line 994
;994:	while (1) {
line 995
;995:		o = pkey;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $373
JUMPV
LABELV $372
line 996
;996:		while (*s != '\\') {
line 997
;997:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $375
line 998
;998:				return "";
ADDRGP4 $41
RETP4
ADDRGP4 $358
JUMPV
LABELV $375
line 999
;999:			*o++ = *s++;
ADDRLP4 8208
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 8216
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 8208
INDIRP4
ADDRLP4 8216
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8212
INDIRP4
ADDRLP4 8216
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8208
INDIRP4
ADDRLP4 8212
INDIRP4
INDIRI1
ASGNI1
line 1000
;1000:		}
LABELV $373
line 996
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $372
line 1001
;1001:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1002
;1002:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1004
;1003:
;1004:		o = value[valueindex];
ADDRLP4 0
ADDRGP4 $360
INDIRI4
CNSTI4 13
LSHI4
ADDRGP4 $359
ADDP4
ASGNP4
ADDRGP4 $378
JUMPV
LABELV $377
line 1006
;1005:
;1006:		while (*s != '\\' && *s) {
line 1007
;1007:			*o++ = *s++;
ADDRLP4 8208
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 8216
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 8208
INDIRP4
ADDRLP4 8216
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8212
INDIRP4
ADDRLP4 8216
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8208
INDIRP4
ADDRLP4 8212
INDIRP4
INDIRI1
ASGNI1
line 1008
;1008:		}
LABELV $378
line 1006
ADDRLP4 8208
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8208
INDIRI4
CNSTI4 92
EQI4 $380
ADDRLP4 8208
INDIRI4
CNSTI4 0
NEI4 $377
LABELV $380
line 1009
;1009:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1011
;1010:
;1011:		if (Q_strequal(key, pkey))
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8212
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8212
INDIRI4
CNSTI4 0
NEI4 $381
line 1012
;1012:			return value[valueindex];
ADDRGP4 $360
INDIRI4
CNSTI4 13
LSHI4
ADDRGP4 $359
ADDP4
RETP4
ADDRGP4 $358
JUMPV
LABELV $381
line 1014
;1013:
;1014:		if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $383
line 1015
;1015:			break;
ADDRGP4 $371
JUMPV
LABELV $383
line 1016
;1016:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1017
;1017:	}
LABELV $370
line 994
ADDRGP4 $369
JUMPV
LABELV $371
line 1019
;1018:
;1019:	return "";
ADDRGP4 $41
RETP4
LABELV $358
endproc Info_ValueForKey 8220 8
export Info_NextPair
proc Info_NextPair 20 0
line 1029
;1020:}
;1021:
;1022:/*
;1023:===================
;1024:Info_NextPair
;1025:
;1026:Used to itterate through all the key/value pairs in an info string
;1027:===================
;1028: */
;1029:void Info_NextPair(const char **head, char *key, char *value) {
line 1033
;1030:	char *o;
;1031:	const char *s;
;1032:
;1033:	s = *head;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 1035
;1034:
;1035:	if (*s == '\\') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $386
line 1036
;1036:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1037
;1037:	}
LABELV $386
line 1038
;1038:	key[0] = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1039
;1039:	value[0] = 0;
ADDRFP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 1041
;1040:
;1041:	o = key;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRGP4 $389
JUMPV
LABELV $388
line 1042
;1042:	while (*s != '\\') {
line 1043
;1043:		if (!*s) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $391
line 1044
;1044:			*o = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1045
;1045:			*head = s;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1046
;1046:			return;
ADDRGP4 $385
JUMPV
LABELV $391
line 1048
;1047:		}
;1048:		*o++ = *s++;
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI1
ASGNI1
line 1049
;1049:	}
LABELV $389
line 1042
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $388
line 1050
;1050:	*o = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1051
;1051:	s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1053
;1052:
;1053:	o = value;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $394
JUMPV
LABELV $393
line 1054
;1054:	while (*s != '\\' && *s) {
line 1055
;1055:		*o++ = *s++;
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI1
ASGNI1
line 1056
;1056:	}
LABELV $394
line 1054
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 92
EQI4 $396
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $393
LABELV $396
line 1057
;1057:	*o = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1059
;1058:
;1059:	*head = s;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1060
;1060:}
LABELV $385
endproc Info_NextPair 20 0
export Info_RemoveKey
proc Info_RemoveKey 2076 12
line 1067
;1061:
;1062:/*
;1063:===================
;1064:Info_RemoveKey
;1065:===================
;1066: */
;1067:void Info_RemoveKey(char *s, const char *key) {
line 1073
;1068:	char *start;
;1069:	char pkey[MAX_INFO_KEY];
;1070:	char value[MAX_INFO_VALUE];
;1071:	char *o;
;1072:
;1073:	if (strlen(s) >= MAX_INFO_STRING) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 2056
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 1024
LTI4 $398
line 1074
;1074:		Com_Error(ERR_DROP, "Info_RemoveKey: oversize infostring");
CNSTI4 1
ARGI4
ADDRGP4 $400
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1075
;1075:	}
LABELV $398
line 1077
;1076:
;1077:	if (strchr(key, '\\')) {
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 2060
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2060
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $404
line 1078
;1078:		return;
ADDRGP4 $397
JUMPV
LABELV $403
line 1081
;1079:	}
;1080:
;1081:	while (1) {
line 1082
;1082:		start = s;
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
line 1083
;1083:		if (*s == '\\')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $406
line 1084
;1084:			s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $406
line 1085
;1085:		o = pkey;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $409
JUMPV
LABELV $408
line 1086
;1086:		while (*s != '\\') {
line 1087
;1087:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $411
line 1088
;1088:				return;
ADDRGP4 $397
JUMPV
LABELV $411
line 1089
;1089:			*o++ = *s++;
ADDRLP4 2064
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 2072
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
ADDRLP4 2072
INDIRI4
ADDP4
ASGNP4
ADDRLP4 2068
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 2068
INDIRP4
ADDRLP4 2072
INDIRI4
ADDP4
ASGNP4
ADDRLP4 2064
INDIRP4
ADDRLP4 2068
INDIRP4
INDIRI1
ASGNI1
line 1090
;1090:		}
LABELV $409
line 1086
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $408
line 1091
;1091:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1092
;1092:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1094
;1093:
;1094:		o = value;
ADDRLP4 0
ADDRLP4 1032
ASGNP4
ADDRGP4 $414
JUMPV
LABELV $413
line 1095
;1095:		while (*s != '\\' && *s) {
line 1096
;1096:			if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $416
line 1097
;1097:				return;
ADDRGP4 $397
JUMPV
LABELV $416
line 1098
;1098:			*o++ = *s++;
ADDRLP4 2064
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 2072
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
ADDRLP4 2072
INDIRI4
ADDP4
ASGNP4
ADDRLP4 2068
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 2068
INDIRP4
ADDRLP4 2072
INDIRI4
ADDP4
ASGNP4
ADDRLP4 2064
INDIRP4
ADDRLP4 2068
INDIRP4
INDIRI1
ASGNI1
line 1099
;1099:		}
LABELV $414
line 1095
ADDRLP4 2064
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2064
INDIRI4
CNSTI4 92
EQI4 $418
ADDRLP4 2064
INDIRI4
CNSTI4 0
NEI4 $413
LABELV $418
line 1100
;1100:		*o = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1102
;1101:
;1102:		if (!strcmp(key, pkey)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 2068
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $419
line 1103
;1103:			memmove(start, s, strlen(s) + 1); // remove this part
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 2072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 2072
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1105
;1104:
;1105:			return;
ADDRGP4 $397
JUMPV
LABELV $419
line 1108
;1106:		}
;1107:
;1108:		if (!*s)
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $421
line 1109
;1109:			return;
ADDRGP4 $397
JUMPV
LABELV $421
line 1110
;1110:	}
LABELV $404
line 1081
ADDRGP4 $403
JUMPV
line 1112
;1111:
;1112:}
LABELV $397
endproc Info_RemoveKey 2076 12
export Info_Validate
proc Info_Validate 8 8
line 1123
;1113:
;1114:
;1115:/*
;1116:==================
;1117:Info_Validate
;1118:
;1119:Some characters are illegal in info strings because they
;1120:can mess up the server's parsing
;1121:==================
;1122: */
;1123:qboolean Info_Validate(const char *s) {
line 1124
;1124:	if (strchr(s, '\"')) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 0
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $424
line 1125
;1125:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $423
JUMPV
LABELV $424
line 1127
;1126:	}
;1127:	if (strchr(s, ';')) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 4
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $426
line 1128
;1128:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $423
JUMPV
LABELV $426
line 1130
;1129:	}
;1130:	return qtrue;
CNSTI4 1
RETI4
LABELV $423
endproc Info_Validate 8 8
export Info_SetValueForKey
proc Info_SetValueForKey 1048 20
line 1140
;1131:}
;1132:
;1133:/*
;1134:==================
;1135:Info_SetValueForKey
;1136:
;1137:Changes or adds a key/value pair
;1138:==================
;1139: */
;1140:void Info_SetValueForKey(char *s, const char *key, const char *value) {
line 1142
;1141:	char newi[MAX_INFO_STRING];
;1142:	const char* blacklist = "\\;\"";
ADDRLP4 0
ADDRGP4 $429
ASGNP4
line 1144
;1143:
;1144:	if (strlen(s) >= MAX_INFO_STRING) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 1024
LTI4 $436
line 1145
;1145:		Com_Error(ERR_DROP, "Info_SetValueForKey: oversize infostring");
CNSTI4 1
ARGI4
ADDRGP4 $432
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1146
;1146:	}
line 1148
;1147:
;1148:	for (; *blacklist; ++blacklist) {
ADDRGP4 $436
JUMPV
LABELV $433
line 1149
;1149:		if (strchr(key, *blacklist) || strchr(value, *blacklist)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 1032
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $439
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 1036
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $437
LABELV $439
line 1150
;1150:			Com_Printf(S_COLOR_YELLOW "Can't use keys or values with a '%c': %s = %s\n", *blacklist, key, value);
ADDRGP4 $440
ARGP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1151
;1151:			return;
ADDRGP4 $428
JUMPV
LABELV $437
line 1153
;1152:		}
;1153:	}
LABELV $434
line 1148
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $436
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $433
line 1155
;1154:
;1155:	Info_RemoveKey(s, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Info_RemoveKey
CALLV
pop
line 1156
;1156:	if (!value || !strlen(value))
ADDRLP4 1032
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $443
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $441
LABELV $443
line 1157
;1157:		return;
ADDRGP4 $428
JUMPV
LABELV $441
line 1159
;1158:
;1159:	Com_sprintf(newi, sizeof (newi), "\\%s\\%s", key, value);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $444
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1161
;1160:
;1161:	if (strlen(newi) + strlen(s) >= MAX_INFO_STRING) {
ADDRLP4 4
ARGP4
ADDRLP4 1040
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
ADDRLP4 1044
INDIRI4
ADDI4
CNSTI4 1024
LTI4 $445
line 1162
;1162:		Com_Printf("Info string length exceeded\n");
ADDRGP4 $447
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1163
;1163:		return;
ADDRGP4 $428
JUMPV
LABELV $445
line 1166
;1164:	}
;1165:
;1166:	strcat(newi, s);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1167
;1167:	strcpy(s, newi);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1168
;1168:}
LABELV $428
endproc Info_SetValueForKey 1048 20
proc Com_CharIsOneOfCharset 8 4
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII1 4
ASGNI1
line 1178
;1169:
;1170:
;1171://====================================================================
;1172:
;1173:/*
;1174:==================
;1175:Com_CharIsOneOfCharset
;1176:==================
;1177: */
;1178:static qboolean Com_CharIsOneOfCharset(char c, char *set) {
line 1181
;1179:	int i;
;1180:
;1181:	for (i = 0; i < strlen(set); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $452
JUMPV
LABELV $449
line 1182
;1182:		if (set[ i ] == c)
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRFP4 0
INDIRI1
CVII4 1
NEI4 $453
line 1183
;1183:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $448
JUMPV
LABELV $453
line 1184
;1184:	}
LABELV $450
line 1181
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $452
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $449
line 1186
;1185:
;1186:	return qfalse;
CNSTI4 0
RETI4
LABELV $448
endproc Com_CharIsOneOfCharset 8 4
export Com_SkipCharset
proc Com_SkipCharset 8 8
line 1194
;1187:}
;1188:
;1189:/*
;1190:==================
;1191:Com_SkipCharset
;1192:==================
;1193: */
;1194:char *Com_SkipCharset(char *s, char *sep) {
line 1195
;1195:	char *p = s;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $457
JUMPV
LABELV $456
line 1197
;1196:
;1197:	while (p) {
line 1198
;1198:		if (Com_CharIsOneOfCharset(*p, sep))
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Com_CharIsOneOfCharset
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $458
line 1199
;1199:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1201
;1200:		else
;1201:			break;
LABELV $460
line 1202
;1202:	}
LABELV $457
line 1197
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $456
LABELV $458
line 1204
;1203:
;1204:	return p;
ADDRLP4 0
INDIRP4
RETP4
LABELV $455
endproc Com_SkipCharset 8 8
export Com_SkipTokens
proc Com_SkipTokens 20 8
line 1212
;1205:}
;1206:
;1207:/*
;1208:==================
;1209:Com_SkipTokens
;1210:==================
;1211: */
;1212:char *Com_SkipTokens(char *s, int numTokens, char *sep) {
line 1213
;1213:	int sepCount = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1214
;1214:	char *p = s;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $463
JUMPV
LABELV $462
line 1216
;1215:
;1216:	while (sepCount < numTokens) {
line 1217
;1217:		if (Com_CharIsOneOfCharset(*p++, sep)) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Com_CharIsOneOfCharset
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $465
line 1218
;1218:			sepCount++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $468
JUMPV
LABELV $467
line 1220
;1219:			while (Com_CharIsOneOfCharset(*p, sep))
;1220:				p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $468
line 1219
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Com_CharIsOneOfCharset
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $467
line 1221
;1221:		} else if (*p == '\0')
ADDRGP4 $466
JUMPV
LABELV $465
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $470
line 1222
;1222:			break;
ADDRGP4 $464
JUMPV
LABELV $470
LABELV $466
line 1223
;1223:	}
LABELV $463
line 1216
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $462
LABELV $464
line 1225
;1224:
;1225:	if (sepCount == numTokens)
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $472
line 1226
;1226:		return p;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $461
JUMPV
LABELV $472
line 1228
;1227:	else
;1228:		return s;
ADDRFP4 0
INDIRP4
RETP4
LABELV $461
endproc Com_SkipTokens 20 8
bss
align 4
LABELV com_lines
skip 4
align 1
LABELV com_parsename
skip 1024
align 1
LABELV com_token
skip 1024
import Com_Printf
import Com_Error
import Info_RemoveKey_big
import Com_RandomBytes
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
LABELV $447
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $444
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $440
byte 1 94
byte 1 51
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 39
byte 1 37
byte 1 99
byte 1 39
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $432
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 70
byte 1 111
byte 1 114
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $429
byte 1 92
byte 1 59
byte 1 34
byte 1 0
align 1
LABELV $400
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $366
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 70
byte 1 111
byte 1 114
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $357
byte 1 32
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 0
align 1
LABELV $349
byte 1 67
byte 1 111
byte 1 109
byte 1 95
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 102
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $346
byte 1 67
byte 1 111
byte 1 109
byte 1 95
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 102
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 105
byte 1 103
byte 1 98
byte 1 117
byte 1 102
byte 1 102
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $301
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $251
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 60
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $248
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 115
byte 1 114
byte 1 99
byte 1 0
align 1
LABELV $245
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $204
byte 1 41
byte 1 0
align 1
LABELV $199
byte 1 40
byte 1 0
align 1
LABELV $180
byte 1 77
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 84
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $88
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $84
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $78
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $58
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $41
byte 1 0
