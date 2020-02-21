code
proc VectorCompare 16 0
file "../../../code/qcommon/q_shared.h"
line 501
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
;23:#ifndef __Q_SHARED_H
;24:#define __Q_SHARED_H
;25:
;26:// q_shared.h -- included first by ALL program modules.
;27:// A user mod should never modify this file
;28:
;29://#ifdef STANDALONE
;30:  #define PRODUCT_NAME			"ioq3+oa"
;31:  #define BASEGAME			"baseoa"
;32:  #define CLIENT_WINDOW_TITLE     	"OpenArena"
;33:  #define CLIENT_WINDOW_MIN_TITLE 	"OA"
;34:/*#else
;35:  #define PRODUCT_NAME			"ioq3"
;36:  #define BASEGAME			"baseq3"
;37:  #define CLIENT_WINDOW_TITLE     	"ioquake3"
;38:  #define CLIENT_WINDOW_MIN_TITLE 	"ioq3"
;39:#endif*/
;40:
;41:#ifdef _MSC_VER
;42:  #define PRODUCT_VERSION "1.35"
;43:#endif
;44:
;45:#ifndef PRODUCT_DATE
;46:#  define PRODUCT_DATE __DATE__
;47:#endif
;48:
;49:#define Q3_VERSION PRODUCT_NAME " " PRODUCT_VERSION
;50:
;51:#define MAX_TEAMNAME 32
;52:
;53:#ifdef _MSC_VER
;54:
;55:#pragma warning(disable : 4018)     // signed/unsigned mismatch
;56:#pragma warning(disable : 4032)
;57:#pragma warning(disable : 4051)
;58:#pragma warning(disable : 4057)		// slightly different base types
;59:#pragma warning(disable : 4100)		// unreferenced formal parameter
;60:#pragma warning(disable : 4115)
;61:#pragma warning(disable : 4125)		// decimal digit terminates octal escape sequence
;62:#pragma warning(disable : 4127)		// conditional expression is constant
;63:#pragma warning(disable : 4136)
;64:#pragma warning(disable : 4152)		// nonstandard extension, function/data pointer conversion in expression
;65://#pragma warning(disable : 4201)
;66://#pragma warning(disable : 4214)
;67:#pragma warning(disable : 4244)
;68:#pragma warning(disable : 4142)		// benign redefinition
;69://#pragma warning(disable : 4305)		// truncation from const double to float
;70://#pragma warning(disable : 4310)		// cast truncates constant value
;71://#pragma warning(disable:  4505) 	// unreferenced local function has been removed
;72:#pragma warning(disable : 4514)
;73:#pragma warning(disable : 4702)		// unreachable code
;74:#pragma warning(disable : 4711)		// selected for automatic inline expansion
;75:#pragma warning(disable : 4220)		// varargs matches remaining parameters
;76://#pragma intrinsic( memset, memcpy )
;77:#endif
;78:
;79://Ignore __attribute__ on non-gcc platforms
;80:#ifndef __GNUC__
;81:#ifndef __attribute__
;82:#define __attribute__(x)
;83:#endif
;84:#endif
;85:
;86:#if (defined _MSC_VER)
;87:#define Q_EXPORT __declspec(dllexport)
;88:#elif (defined __SUNPRO_C)
;89:#define Q_EXPORT __global
;90:#elif ((__GNUC__ >= 3) && (!__EMX__) && (!sun))
;91:#define Q_EXPORT __attribute__((visibility("default")))
;92:#else
;93:#define Q_EXPORT
;94:#endif
;95:
;96:
;97:/**********************************************************************
;98:  VM Considerations
;99:
;100:  The VM can not use the standard system headers because we aren't really
;101:  using the compiler they were meant for.  We use bg_lib.h which contains
;102:  prototypes for the functions we define for our own use in bg_lib.c.
;103:
;104:  When writing mods, please add needed headers HERE, do not start including
;105:  stuff like <stdio.h> in the various .c files that make up each of the VMs
;106:  since you will be including system headers files can will have issues.
;107:
;108:  Remember, if you use a C library function that is not defined in bg_lib.c,
;109:  you will have to add your own version for support in the VM.
;110:
;111: **********************************************************************/
;112:
;113:#ifdef Q3_VM
;114:
;115:#include "../game/bg_lib.h"
;116:
;117:typedef int intptr_t;
;118:
;119:#else
;120:
;121:#include <assert.h>
;122:#include <math.h>
;123:#include <stdio.h>
;124:#include <stdarg.h>
;125:#include <string.h>
;126:#include <stdlib.h>
;127:#include <time.h>
;128:#include <ctype.h>
;129:#include <limits.h>
;130:
;131:// vsnprintf is ISO/IEC 9899:1999
;132:// abstracting this to make it portable
;133:#ifdef _WIN32
;134:  #define Q_vsnprintf _vsnprintf
;135:  #define Q_snprintf _snprintf
;136:#else
;137:  #define Q_vsnprintf vsnprintf
;138:  #define Q_snprintf snprintf
;139:#endif
;140:
;141:#ifdef _MSC_VER
;142:  #include <io.h>
;143:
;144:  typedef __int64 int64_t;
;145:  typedef __int32 int32_t;
;146:  typedef __int16 int16_t;
;147:  typedef __int8 int8_t;
;148:  typedef unsigned __int64 uint64_t;
;149:  typedef unsigned __int32 uint32_t;
;150:  typedef unsigned __int16 uint16_t;
;151:  typedef unsigned __int8 uint8_t;
;152:#else
;153:  #include <stdint.h>
;154:#endif
;155:
;156:#endif
;157:
;158:
;159:#include "q_platform.h"
;160:
;161://=============================================================
;162:
;163:typedef unsigned char 		byte;
;164:
;165:typedef enum {qfalse, qtrue}	qboolean;
;166:
;167:typedef union {
;168:	float f;
;169:	int i;
;170:	unsigned int ui;
;171:} floatint_t;
;172:
;173:typedef int		qhandle_t;
;174:typedef int		sfxHandle_t;
;175:typedef int		fileHandle_t;
;176:typedef int		clipHandle_t;
;177:
;178:#define PAD(x,y) (((x)+(y)-1) & ~((y)-1))
;179:
;180:#ifdef __GNUC__
;181:#define ALIGN(x) __attribute__((aligned(x)))
;182:#else
;183:#define ALIGN(x)
;184:#endif
;185:
;186:#ifndef NULL
;187:#define NULL ((void *)0)
;188:#endif
;189:
;190:#define	MAX_QINT			0x7fffffff
;191:#define	MIN_QINT			(-MAX_QINT-1)
;192:
;193:#define ARRAY_LEN(x)			(sizeof(x) / sizeof(*(x)))
;194:#define STRARRAY_LEN(x)			(ARRAY_LEN(x) - 1)
;195:
;196:// angle indexes
;197:#define	PITCH				0		// up / down
;198:#define	YAW					1		// left / right
;199:#define	ROLL				2		// fall over
;200:
;201:// the game guarantees that no string from the network will ever
;202:// exceed MAX_STRING_CHARS
;203:#define	MAX_STRING_CHARS	1024	// max length of a string passed to Cmd_TokenizeString
;204:#define	MAX_STRING_TOKENS	1024	// max tokens resulting from Cmd_TokenizeString
;205:#define	MAX_TOKEN_CHARS		1024	// max length of an individual token
;206:
;207:#define	MAX_INFO_STRING		1024
;208:#define	MAX_INFO_KEY		  1024
;209:#define	MAX_INFO_VALUE		1024
;210:
;211:#define	BIG_INFO_STRING		8192  // used for system info key only
;212:#define	BIG_INFO_KEY		  8192
;213:#define	BIG_INFO_VALUE		8192
;214:
;215:
;216:#define	MAX_QPATH			64		// max length of a quake game pathname
;217:#ifdef PATH_MAX
;218:#define MAX_OSPATH			PATH_MAX
;219:#else
;220:#define	MAX_OSPATH			256		// max length of a filesystem pathname
;221:#endif
;222:
;223:#define	MAX_NAME_LENGTH		32		// max length of a client name
;224:
;225:#define	MAX_SAY_TEXT	150
;226:
;227:// paramters for command buffer stuffing
;228:typedef enum {
;229:	EXEC_NOW,			// don't return until completed, a VM should NEVER use this,
;230:						// because some commands might cause the VM to be unloaded...
;231:	EXEC_INSERT,		// insert at current position, but don't run yet
;232:	EXEC_APPEND			// add to end of the command buffer (normal case)
;233:} cbufExec_t;
;234:
;235:
;236://
;237:// these aren't needed by any of the VMs.  put in another header?
;238://
;239:#define	MAX_MAP_AREA_BYTES		32		// bit vector of area visibility
;240:
;241:
;242:// print levels from renderer (FIXME: set up for game / cgame?)
;243:typedef enum {
;244:	PRINT_ALL,
;245:	PRINT_DEVELOPER,		// only print when "developer 1"
;246:	PRINT_WARNING,
;247:	PRINT_ERROR
;248:} printParm_t;
;249:
;250:
;251:#ifdef ERR_FATAL
;252:#undef ERR_FATAL			// this is be defined in malloc.h
;253:#endif
;254:
;255:// parameters to the main Error routine
;256:typedef enum {
;257:	ERR_FATAL,					// exit the entire game with a popup window
;258:	ERR_DROP,					// print to console and disconnect from game
;259:	ERR_SERVERDISCONNECT,		// don't kill server
;260:	ERR_DISCONNECT,				// client disconnected from the server
;261:	ERR_NEED_CD					// pop up the need-cd dialog
;262:} errorParm_t;
;263:
;264:
;265:// font rendering values used by ui and cgame
;266:
;267:#define PROP_GAP_WIDTH			3
;268:#define PROP_SPACE_WIDTH		8
;269:#define PROP_HEIGHT				27
;270:#define PROP_SMALL_SIZE_SCALE	0.75
;271:
;272:#define BLINK_DIVISOR			200
;273:#define PULSE_DIVISOR			75
;274:
;275:#define UI_LEFT			0x00000000	// default
;276:#define UI_CENTER		0x00000001
;277:#define UI_RIGHT		0x00000002
;278:#define UI_FORMATMASK	0x00000007
;279:#define UI_SMALLFONT	0x00000010
;280:#define UI_BIGFONT		0x00000020	// default
;281:#define UI_GIANTFONT	0x00000040
;282:#define UI_DROPSHADOW	0x00000800
;283:#define UI_BLINK		0x00001000
;284:#define UI_INVERSE		0x00002000
;285:#define UI_PULSE		0x00004000
;286:
;287:#if defined(_DEBUG) && !defined(BSPC)
;288:	#define HUNK_DEBUG
;289:#endif
;290:
;291:typedef enum {
;292:	h_high,
;293:	h_low,
;294:	h_dontcare
;295:} ha_pref;
;296:
;297:#ifdef HUNK_DEBUG
;298:#define Hunk_Alloc( size, preference )				Hunk_AllocDebug(size, preference, #size, __FILE__, __LINE__)
;299:void *Hunk_AllocDebug( int size, ha_pref preference, char *label, char *file, int line );
;300:#else
;301:void *Hunk_Alloc( int size, ha_pref preference );
;302:#endif
;303:
;304:#define Com_Memset memset
;305:#define Com_Memcpy memcpy
;306:
;307:#define CIN_system	1
;308:#define CIN_loop	2
;309:#define	CIN_hold	4
;310:#define CIN_silent	8
;311:#define CIN_shader	16
;312:
;313:/*
;314:==============================================================
;315:
;316:MATHLIB
;317:
;318:==============================================================
;319:*/
;320:
;321:
;322:typedef float vec_t;
;323:typedef vec_t vec2_t[2];
;324:typedef vec_t vec3_t[3];
;325:typedef vec_t vec4_t[4];
;326:typedef vec_t vec5_t[5];
;327:
;328:typedef	int	fixed4_t;
;329:typedef	int	fixed8_t;
;330:typedef	int	fixed16_t;
;331:
;332:#ifndef M_PI
;333:#define M_PI		3.14159265358979323846f	// matches value in gcc v2 math.h
;334:#endif
;335:
;336:#define NUMVERTEXNORMALS	162
;337:extern	vec3_t	bytedirs[NUMVERTEXNORMALS];
;338:
;339:// all drawing is done to a 640*480 virtual screen size
;340:// and will be automatically scaled to the real resolution
;341:#define	SCREEN_WIDTH		640
;342:#define	SCREEN_HEIGHT		480
;343:
;344:#define TINYCHAR_WIDTH		(SMALLCHAR_WIDTH)
;345:#define TINYCHAR_HEIGHT		(SMALLCHAR_HEIGHT/2)
;346:
;347:#define SMALLCHAR_WIDTH		8
;348:#define SMALLCHAR_HEIGHT	16
;349:
;350:#define BIGCHAR_WIDTH		16
;351:#define BIGCHAR_HEIGHT		16
;352:
;353:#define	GIANTCHAR_WIDTH		32
;354:#define	GIANTCHAR_HEIGHT	48
;355:
;356:extern	vec4_t		colorBlack;
;357:extern	vec4_t		colorRed;
;358:extern	vec4_t		colorGreen;
;359:extern	vec4_t		colorBlue;
;360:extern	vec4_t		colorYellow;
;361:extern	vec4_t		colorMagenta;
;362:extern	vec4_t		colorCyan;
;363:extern	vec4_t		colorWhite;
;364:extern	vec4_t		colorLtGrey;
;365:extern	vec4_t		colorMdGrey;
;366:extern	vec4_t		colorDkGrey;
;367:
;368:#define Q_COLOR_ESCAPE	'^'
;369:#define Q_IsColorString(p)      ((p) && *(p) == Q_COLOR_ESCAPE && *((p)+1) && *((p)+1) >= '0' && *((p)+1) <= '8') // ^[0-8]
;370:#define COLOR_BLACK		'0'
;371:#define COLOR_RED		'1'
;372:#define COLOR_GREEN		'2'
;373:#define COLOR_YELLOW	'3'
;374:#define COLOR_BLUE		'4'
;375:#define COLOR_CYAN		'5'
;376:#define COLOR_MAGENTA	'6'
;377:#define COLOR_WHITE		'7'
;378:#define COLOR_MENU      '8'
;379:#define ColorIndex(c)   ((c) - '0')
;380:
;381:#define S_COLOR_BLACK	"^0"
;382:#define S_COLOR_RED		"^1"
;383:#define S_COLOR_GREEN	"^2"
;384:#define S_COLOR_YELLOW	"^3"
;385:#define S_COLOR_BLUE	"^4"
;386:#define S_COLOR_CYAN	"^5"
;387:#define S_COLOR_MAGENTA	"^6"
;388:#define S_COLOR_WHITE	"^7"
;389:#define S_COLOR_MENU	"^8"
;390:
;391:extern vec4_t	g_color_table[9];
;392:
;393:#define	MAKERGB( v, r, g, b ) v[0]=r;v[1]=g;v[2]=b
;394:#define	MAKERGBA( v, r, g, b, a ) v[0]=r;v[1]=g;v[2]=b;v[3]=a
;395:
;396:#define DEG2RAD( a ) ( ( (a) * M_PI ) / 180.0F )
;397:#define RAD2DEG( a ) ( ( (a) * 180.0f ) / M_PI )
;398:
;399:struct cplane_s;
;400:
;401:extern	vec3_t	vec3_origin;
;402:extern	vec3_t	axisDefault[3];
;403:
;404:#define	nanmask (255<<23)
;405:
;406:#define	IS_NAN(x) (((*(int *)&x)&nanmask)==nanmask)
;407:
;408:#if idppc
;409:
;410:static ID_INLINE float Q_rsqrt( float number ) {
;411:		float x = 0.5f * number;
;412:                float y;
;413:#ifdef __GNUC__            
;414:                asm("frsqrte %0,%1" : "=f" (y) : "f" (number));
;415:#else
;416:		y = __frsqrte( number );
;417:#endif
;418:		return y * (1.5f - (x * y * y));
;419:	}
;420:
;421:#ifdef __GNUC__            
;422:static ID_INLINE float Q_fabs(float x) {
;423:    float abs_x;
;424:    
;425:    asm("fabs %0,%1" : "=f" (abs_x) : "f" (x));
;426:    return abs_x;
;427:}
;428:#else
;429:#define Q_fabs __fabsf
;430:#endif
;431:
;432:#else
;433:float Q_fabs( float f );
;434:float Q_rsqrt( float f );		// reciprocal square root
;435:#endif
;436:
;437:#define SQRTFAST( x ) ( (x) * Q_rsqrt( x ) )
;438:
;439:signed char ClampChar( int i );
;440:signed short ClampShort( int i );
;441:
;442:// this isn't a real cheap function to call!
;443:int DirToByte( vec3_t dir );
;444:void ByteToDir( int b, vec3_t dir );
;445:
;446:#if	1
;447:
;448:#define DotProduct(x,y)			((x)[0]*(y)[0]+(x)[1]*(y)[1]+(x)[2]*(y)[2])
;449:#define VectorSubtract(a,b,c)	((c)[0]=(a)[0]-(b)[0],(c)[1]=(a)[1]-(b)[1],(c)[2]=(a)[2]-(b)[2])
;450:#define VectorAdd(a,b,c)		((c)[0]=(a)[0]+(b)[0],(c)[1]=(a)[1]+(b)[1],(c)[2]=(a)[2]+(b)[2])
;451:#define VectorCopy(a,b)			((b)[0]=(a)[0],(b)[1]=(a)[1],(b)[2]=(a)[2])
;452:#define	VectorScale(v, s, o)	((o)[0]=(v)[0]*(s),(o)[1]=(v)[1]*(s),(o)[2]=(v)[2]*(s))
;453:#define	VectorMA(v, s, b, o)	((o)[0]=(v)[0]+(b)[0]*(s),(o)[1]=(v)[1]+(b)[1]*(s),(o)[2]=(v)[2]+(b)[2]*(s))
;454:
;455:#else
;456:
;457:#define DotProduct(x,y)			_DotProduct(x,y)
;458:#define VectorSubtract(a,b,c)	_VectorSubtract(a,b,c)
;459:#define VectorAdd(a,b,c)		_VectorAdd(a,b,c)
;460:#define VectorCopy(a,b)			_VectorCopy(a,b)
;461:#define	VectorScale(v, s, o)	_VectorScale(v,s,o)
;462:#define	VectorMA(v, s, b, o)	_VectorMA(v,s,b,o)
;463:
;464:#endif
;465:
;466:#ifdef Q3_VM
;467:#ifdef VectorCopy
;468:#undef VectorCopy
;469:// this is a little hack to get more efficient copies in our interpreter
;470:typedef struct {
;471:	float	v[3];
;472:} vec3struct_t;
;473:#define VectorCopy(a,b)	(*(vec3struct_t *)b=*(const vec3struct_t *)a)
;474:#endif
;475:#endif
;476:
;477:#define VectorClear(a)			((a)[0]=(a)[1]=(a)[2]=0)
;478:#define VectorNegate(a,b)		((b)[0]=-(a)[0],(b)[1]=-(a)[1],(b)[2]=-(a)[2])
;479:#define VectorSet(v, x, y, z)	((v)[0]=(x), (v)[1]=(y), (v)[2]=(z))
;480:#define Vector4Copy(a,b)		((b)[0]=(a)[0],(b)[1]=(a)[1],(b)[2]=(a)[2],(b)[3]=(a)[3])
;481:
;482:#define	SnapVector(v) {v[0]=((int)(v[0]));v[1]=((int)(v[1]));v[2]=((int)(v[2]));}
;483:// just in case you do't want to use the macros
;484:vec_t _DotProduct( const vec3_t v1, const vec3_t v2 );
;485:void _VectorSubtract( const vec3_t veca, const vec3_t vecb, vec3_t out );
;486:void _VectorAdd( const vec3_t veca, const vec3_t vecb, vec3_t out );
;487:void _VectorCopy( const vec3_t in, vec3_t out );
;488:void _VectorScale( const vec3_t in, float scale, vec3_t out );
;489:void _VectorMA( const vec3_t veca, float scale, const vec3_t vecb, vec3_t vecc );
;490:
;491:unsigned ColorBytes3 (float r, float g, float b);
;492:unsigned ColorBytes4 (float r, float g, float b, float a);
;493:
;494:float NormalizeColor( const vec3_t in, vec3_t out );
;495:
;496:float RadiusFromBounds( const vec3_t mins, const vec3_t maxs );
;497:void ClearBounds( vec3_t mins, vec3_t maxs );
;498:void AddPointToBounds( const vec3_t v, vec3_t mins, vec3_t maxs );
;499:
;500:#if !defined( Q3_VM ) || ( defined( Q3_VM ) && defined( __Q3_VM_MATH ) )
;501:static ID_INLINE int VectorCompare( const vec3_t v1, const vec3_t v2 ) {
line 502
;502:	if (v1[0] != v2[0] || v1[1] != v2[1] || v1[2] != v2[2]) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
NEF4 $12
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
NEF4 $12
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
EQF4 $9
LABELV $12
line 503
;503:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $8
JUMPV
LABELV $9
line 505
;504:	}			
;505:	return 1;
CNSTI4 1
RETI4
LABELV $8
endproc VectorCompare 16 0
proc VectorLength 20 4
line 508
;506:}
;507:
;508:static ID_INLINE vec_t VectorLength( const vec3_t v ) {
line 509
;509:	return (vec_t)sqrt (v[0]*v[0] + v[1]*v[1] + v[2]*v[2]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 8
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 16
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
RETF4
LABELV $13
endproc VectorLength 20 4
proc VectorLengthSquared 16 0
line 512
;510:}
;511:
;512:static ID_INLINE vec_t VectorLengthSquared( const vec3_t v ) {
line 513
;513:	return (v[0]*v[0] + v[1]*v[1] + v[2]*v[2]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 8
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
RETF4
LABELV $14
endproc VectorLengthSquared 16 0
proc Distance 32 4
line 516
;514:}
;515:
;516:static ID_INLINE vec_t Distance( const vec3_t p1, const vec3_t p2 ) {
line 519
;517:	vec3_t	v;
;518:
;519:	VectorSubtract (p2, p1, v);
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 0+4
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
SUBF4
ASGNF4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 520
;520:	return VectorLength( v );
ADDRLP4 0
ARGP4
ADDRLP4 28
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 28
INDIRF4
RETF4
LABELV $15
endproc Distance 32 4
proc DistanceSquared 32 0
line 523
;521:}
;522:
;523:static ID_INLINE vec_t DistanceSquared( const vec3_t p1, const vec3_t p2 ) {
line 526
;524:	vec3_t	v;
;525:
;526:	VectorSubtract (p2, p1, v);
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 0+4
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
SUBF4
ASGNF4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 527
;527:	return v[0]*v[0] + v[1]*v[1] + v[2]*v[2];
ADDRLP4 28
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
RETF4
LABELV $18
endproc DistanceSquared 32 0
proc VectorNormalizeFast 36 4
line 533
;528:}
;529:
;530:// fast vector normalize routine that does not check to make sure
;531:// that length != 0, nor does it return length, uses rsqrt approximation
;532:static ID_INLINE void VectorNormalizeFast( vec3_t v )
;533:{
line 536
;534:	float ilength;
;535:
;536:	ilength = Q_rsqrt( DotProduct( v, v ) );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDRLP4 12
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 20
ADDRGP4 Q_rsqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 538
;537:
;538:	v[0] *= ilength;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 539
;539:	v[1] *= ilength;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 540
;540:	v[2] *= ilength;
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
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 541
;541:}
LABELV $25
endproc VectorNormalizeFast 36 4
proc VectorInverse 12 0
line 543
;542:
;543:static ID_INLINE void VectorInverse( vec3_t v ){
line 544
;544:	v[0] = -v[0];
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
NEGF4
ASGNF4
line 545
;545:	v[1] = -v[1];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
NEGF4
ASGNF4
line 546
;546:	v[2] = -v[2];
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
NEGF4
ASGNF4
line 547
;547:}
LABELV $26
endproc VectorInverse 12 0
proc CrossProduct 40 0
line 549
;548:
;549:static ID_INLINE void CrossProduct( const vec3_t v1, const vec3_t v2, vec3_t cross ) {
line 550
;550:	cross[0] = v1[1]*v2[2] - v1[2]*v2[1];
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 551
;551:	cross[1] = v1[2]*v2[0] - v1[0]*v2[2];
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 8
ASGNI4
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 552
;552:	cross[2] = v1[0]*v2[1] - v1[1]*v2[0];
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 4
ASGNI4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
MULF4
ADDRLP4 28
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 553
;553:}
LABELV $27
endproc CrossProduct 40 0
data
export vec3_origin
align 4
LABELV vec3_origin
byte 4 0
byte 4 0
byte 4 0
export axisDefault
align 4
LABELV axisDefault
byte 4 1065353216
byte 4 0
byte 4 0
byte 4 0
byte 4 1065353216
byte 4 0
byte 4 0
byte 4 0
byte 4 1065353216
export colorBlack
align 4
LABELV colorBlack
byte 4 0
byte 4 0
byte 4 0
byte 4 1065353216
export colorRed
align 4
LABELV colorRed
byte 4 1065353216
byte 4 0
byte 4 0
byte 4 1065353216
export colorGreen
align 4
LABELV colorGreen
byte 4 0
byte 4 1065353216
byte 4 0
byte 4 1065353216
export colorBlue
align 4
LABELV colorBlue
byte 4 0
byte 4 0
byte 4 1065353216
byte 4 1065353216
export colorYellow
align 4
LABELV colorYellow
byte 4 1065353216
byte 4 1065353216
byte 4 0
byte 4 1065353216
export colorMagenta
align 4
LABELV colorMagenta
byte 4 1065353216
byte 4 0
byte 4 1065353216
byte 4 1065353216
export colorCyan
align 4
LABELV colorCyan
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export colorWhite
align 4
LABELV colorWhite
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export colorLtGrey
align 4
LABELV colorLtGrey
byte 4 1061158912
byte 4 1061158912
byte 4 1061158912
byte 4 1065353216
export colorMdGrey
align 4
LABELV colorMdGrey
byte 4 1056964608
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
export colorDkGrey
align 4
LABELV colorDkGrey
byte 4 1048576000
byte 4 1048576000
byte 4 1048576000
byte 4 1065353216
export g_color_table
align 4
LABELV g_color_table
byte 4 0
byte 4 0
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 0
byte 4 0
byte 4 1065353216
byte 4 0
byte 4 1065353216
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 0
byte 4 1065353216
byte 4 0
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1054615798
byte 4 0
byte 4 1065353216
export bytedirs
align 4
LABELV bytedirs
byte 4 3204879951
byte 4 0
byte 4 1062847556
byte 4 3202531056
byte 4 1047828139
byte 4 1063074669
byte 4 3197577718
byte 4 0
byte 4 1064605338
byte 4 3198039930
byte 4 1056964608
byte 4 1062149053
byte 4 3190184938
byte 4 1049007711
byte 4 1064532072
byte 4 0
byte 4 0
byte 4 1065353216
byte 4 0
byte 4 1062847556
byte 4 1057396303
byte 4 3189189110
byte 4 1060597999
byte 4 1060013330
byte 4 1041705462
byte 4 1060597999
byte 4 1060013330
byte 4 0
byte 4 1057396303
byte 4 1062847556
byte 4 1050556282
byte 4 1056964608
byte 4 1062149053
byte 4 1057396303
byte 4 0
byte 4 1062847556
byte 4 1050094070
byte 4 0
byte 4 1064605338
byte 4 1055047408
byte 4 1047828139
byte 4 1063074669
byte 4 1042701290
byte 4 1049007711
byte 4 1064532072
byte 4 3207496978
byte 4 1041705462
byte 4 1060597999
byte 4 3209632701
byte 4 1050556282
byte 4 1056964608
byte 4 3205921044
byte 4 1054458931
byte 4 1060121929
byte 4 3210331204
byte 4 1057396303
byte 4 0
byte 4 3210558317
byte 4 1055047408
byte 4 1047828139
byte 4 3208081647
byte 4 1060013330
byte 4 1041705462
byte 4 3207605577
byte 4 1058437396
byte 4 1054458931
byte 4 3204448256
byte 4 1062149053
byte 4 1050556282
byte 4 3195311787
byte 4 1063074669
byte 4 1055047408
byte 4 3201942579
byte 4 1060121929
byte 4 1058437396
byte 4 3208081647
byte 4 1060013330
byte 4 3189189110
byte 4 3204448256
byte 4 1062149053
byte 4 3198039930
byte 4 3204879951
byte 4 1062847556
byte 4 0
byte 4 0
byte 4 1062847556
byte 4 3204879951
byte 4 3195311787
byte 4 1063074669
byte 4 3202531056
byte 4 0
byte 4 1064605338
byte 4 3197577718
byte 4 3196491359
byte 4 1064532072
byte 4 3190184938
byte 4 0
byte 4 1065353216
byte 4 0
byte 4 0
byte 4 1064605338
byte 4 1050094070
byte 4 3196491359
byte 4 1064532072
byte 4 1042701290
byte 4 1047828139
byte 4 1063074669
byte 4 1055047408
byte 4 1049007711
byte 4 1064532072
byte 4 1042701290
byte 4 1056964608
byte 4 1062149053
byte 4 1050556282
byte 4 1047828139
byte 4 1063074669
byte 4 3202531056
byte 4 1049007711
byte 4 1064532072
byte 4 3190184938
byte 4 1056964608
byte 4 1062149053
byte 4 3198039930
byte 4 1062847556
byte 4 1057396303
byte 4 0
byte 4 1060597999
byte 4 1060013330
byte 4 1041705462
byte 4 1060597999
byte 4 1060013330
byte 4 3189189110
byte 4 1057396303
byte 4 1062847556
byte 4 0
byte 4 1054458931
byte 4 1060121929
byte 4 1058437396
byte 4 1063074669
byte 4 1055047408
byte 4 1047828139
byte 4 1060121929
byte 4 1058437396
byte 4 1054458931
byte 4 1062149053
byte 4 1050556282
byte 4 1056964608
byte 4 1060013330
byte 4 1041705462
byte 4 1060597999
byte 4 1058437396
byte 4 1054458931
byte 4 1060121929
byte 4 1064605338
byte 4 1050094070
byte 4 0
byte 4 1065353216
byte 4 0
byte 4 0
byte 4 1064532072
byte 4 1042701290
byte 4 1049007711
byte 4 1062847556
byte 4 3204879951
byte 4 0
byte 4 1064605338
byte 4 3197577718
byte 4 0
byte 4 1063074669
byte 4 3202531056
byte 4 1047828139
byte 4 1064532072
byte 4 3190184938
byte 4 1049007711
byte 4 1062149053
byte 4 3198039930
byte 4 1056964608
byte 4 1060013330
byte 4 3189189110
byte 4 1060597999
byte 4 1062847556
byte 4 0
byte 4 1057396303
byte 4 1063074669
byte 4 1055047408
byte 4 3195311787
byte 4 1062149053
byte 4 1050556282
byte 4 3204448256
byte 4 1064532072
byte 4 1042701290
byte 4 3196491359
byte 4 1057396303
byte 4 0
byte 4 3210331204
byte 4 1060013330
byte 4 1041705462
byte 4 3208081647
byte 4 1060013330
byte 4 3189189110
byte 4 3208081647
byte 4 1062847556
byte 4 0
byte 4 3204879951
byte 4 1062149053
byte 4 3198039930
byte 4 3204448256
byte 4 1063074669
byte 4 3202531056
byte 4 3195311787
byte 4 1064532072
byte 4 3190184938
byte 4 3196491359
byte 4 1041705462
byte 4 1060597999
byte 4 3207496978
byte 4 1050556282
byte 4 1056964608
byte 4 3209632701
byte 4 1054458931
byte 4 1060121929
byte 4 3205921044
byte 4 1055047408
byte 4 1047828139
byte 4 3210558317
byte 4 1058437396
byte 4 1054458931
byte 4 3207605577
byte 4 1060121929
byte 4 1058437396
byte 4 3201942579
byte 4 3189189110
byte 4 1060597999
byte 4 3207496978
byte 4 3198039930
byte 4 1056964608
byte 4 3209632701
byte 4 0
byte 4 1057396303
byte 4 3210331204
byte 4 3204879951
byte 4 0
byte 4 3210331204
byte 4 3202531056
byte 4 1047828139
byte 4 3210558317
byte 4 3197577718
byte 4 0
byte 4 3212088986
byte 4 3190184938
byte 4 1049007711
byte 4 3212015720
byte 4 0
byte 4 0
byte 4 3212836864
byte 4 1050094070
byte 4 0
byte 4 3212088986
byte 4 1042701290
byte 4 1049007711
byte 4 3212015720
byte 4 3202531056
byte 4 3195311787
byte 4 3210558317
byte 4 3198039930
byte 4 3204448256
byte 4 3209632701
byte 4 3190184938
byte 4 3196491359
byte 4 3212015720
byte 4 0
byte 4 3210331204
byte 4 3204879951
byte 4 3189189110
byte 4 3208081647
byte 4 3207496978
byte 4 1041705462
byte 4 3208081647
byte 4 3207496978
byte 4 0
byte 4 3204879951
byte 4 3210331204
byte 4 1050556282
byte 4 3204448256
byte 4 3209632701
byte 4 1055047408
byte 4 3195311787
byte 4 3210558317
byte 4 1042701290
byte 4 3196491359
byte 4 3212015720
byte 4 1047828139
byte 4 3210558317
byte 4 3202531056
byte 4 1056964608
byte 4 3209632701
byte 4 3198039930
byte 4 1054458931
byte 4 3207605577
byte 4 3205921044
byte 4 1060597999
byte 4 3207496978
byte 4 3189189110
byte 4 1060121929
byte 4 3205921044
byte 4 3201942579
byte 4 1058437396
byte 4 3201942579
byte 4 3207605577
byte 4 0
byte 4 3212088986
byte 4 3197577718
byte 4 0
byte 4 3212836864
byte 4 0
byte 4 1049007711
byte 4 3212015720
byte 4 3190184938
byte 4 0
byte 4 3210331204
byte 4 1057396303
byte 4 0
byte 4 3212088986
byte 4 1050094070
byte 4 1047828139
byte 4 3210558317
byte 4 1055047408
byte 4 1049007711
byte 4 3212015720
byte 4 1042701290
byte 4 1056964608
byte 4 3209632701
byte 4 1050556282
byte 4 1060597999
byte 4 3207496978
byte 4 1041705462
byte 4 1057396303
byte 4 3210331204
byte 4 0
byte 4 3195311787
byte 4 3210558317
byte 4 3202531056
byte 4 3204448256
byte 4 3209632701
byte 4 3198039930
byte 4 3196491359
byte 4 3212015720
byte 4 3190184938
byte 4 3210331204
byte 4 3204879951
byte 4 0
byte 4 3208081647
byte 4 3207496978
byte 4 3189189110
byte 4 3208081647
byte 4 3207496978
byte 4 1041705462
byte 4 3204879951
byte 4 3210331204
byte 4 0
byte 4 3204448256
byte 4 3209632701
byte 4 1050556282
byte 4 3195311787
byte 4 3210558317
byte 4 1055047408
byte 4 3196491359
byte 4 3212015720
byte 4 1042701290
byte 4 3210558317
byte 4 3202531056
byte 4 1047828139
byte 4 3209632701
byte 4 3198039930
byte 4 1056964608
byte 4 3207605577
byte 4 3205921044
byte 4 1054458931
byte 4 3207496978
byte 4 3189189110
byte 4 1060597999
byte 4 3202531056
byte 4 3195311787
byte 4 1063074669
byte 4 3205921044
byte 4 3201942579
byte 4 1060121929
byte 4 3198039930
byte 4 3204448256
byte 4 1062149053
byte 4 3189189110
byte 4 3208081647
byte 4 1060013330
byte 4 3201942579
byte 4 3207605577
byte 4 1058437396
byte 4 3190184938
byte 4 3196491359
byte 4 1064532072
byte 4 1055047408
byte 4 3195311787
byte 4 1063074669
byte 4 1042701290
byte 4 3196491359
byte 4 1064532072
byte 4 1050556282
byte 4 3204448256
byte 4 1062149053
byte 4 1041705462
byte 4 3208081647
byte 4 1060013330
byte 4 0
byte 4 3204879951
byte 4 1062847556
byte 4 1054458931
byte 4 3207605577
byte 4 1058437396
byte 4 1058437396
byte 4 3201942579
byte 4 1060121929
byte 4 1060121929
byte 4 3205921044
byte 4 1054458931
byte 4 3212088986
byte 4 1050094070
byte 4 0
byte 4 3212015720
byte 4 1042701290
byte 4 1049007711
byte 4 3212836864
byte 4 0
byte 4 0
byte 4 3210331204
byte 4 0
byte 4 1057396303
byte 4 3212088986
byte 4 3197577718
byte 4 0
byte 4 3212015720
byte 4 3190184938
byte 4 1049007711
byte 4 3210558317
byte 4 1055047408
byte 4 3195311787
byte 4 3212015720
byte 4 1042701290
byte 4 3196491359
byte 4 3209632701
byte 4 1050556282
byte 4 3204448256
byte 4 3210558317
byte 4 3202531056
byte 4 3195311787
byte 4 3212015720
byte 4 3190184938
byte 4 3196491359
byte 4 3209632701
byte 4 3198039930
byte 4 3204448256
byte 4 3207496978
byte 4 1041705462
byte 4 3208081647
byte 4 3207496978
byte 4 3189189110
byte 4 3208081647
byte 4 3210331204
byte 4 0
byte 4 3204879951
byte 4 3207605577
byte 4 1058437396
byte 4 3201942579
byte 4 3205921044
byte 4 1054458931
byte 4 3207605577
byte 4 3201942579
byte 4 1060121929
byte 4 3205921044
byte 4 3201942579
byte 4 3207605577
byte 4 3205921044
byte 4 3205921044
byte 4 3201942579
byte 4 3207605577
byte 4 3207605577
byte 4 3205921044
byte 4 3201942579
export Q_rand
code
proc Q_rand 4 0
file "../../../code/qcommon/q_math.c"
line 151
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
;23:// q_math.c -- stateless support routines that are included in each code module
;24:
;25:// Some of the vector functions are static inline in q_shared.h. q3asm
;26:// doesn't understand static functions though, so we only want them in
;27:// one file. That's what this is about.
;28:#ifdef Q3_VM
;29:#define __Q3_VM_MATH
;30:#endif
;31:
;32:#include "q_shared.h"
;33:
;34:vec3_t	vec3_origin = {0,0,0};
;35:vec3_t	axisDefault[3] = { { 1, 0, 0 }, { 0, 1, 0 }, { 0, 0, 1 } };
;36:
;37:
;38:vec4_t		colorBlack	= {0, 0, 0, 1};
;39:vec4_t		colorRed	= {1, 0, 0, 1};
;40:vec4_t		colorGreen	= {0, 1, 0, 1};
;41:vec4_t		colorBlue	= {0, 0, 1, 1};
;42:vec4_t		colorYellow	= {1, 1, 0, 1};
;43:vec4_t		colorMagenta= {1, 0, 1, 1};
;44:vec4_t		colorCyan	= {0, 1, 1, 1};
;45:vec4_t		colorWhite	= {1, 1, 1, 1};
;46:vec4_t		colorLtGrey	= {0.75, 0.75, 0.75, 1};
;47:vec4_t		colorMdGrey	= {0.5, 0.5, 0.5, 1};
;48:vec4_t		colorDkGrey	= {0.25, 0.25, 0.25, 1};
;49:
;50:vec4_t	g_color_table[9] =
;51:	{
;52:	{0.0, 0.0, 0.0, 1.0},
;53:	{1.0, 0.0, 0.0, 1.0},
;54:	{0.0, 1.0, 0.0, 1.0},
;55:	{1.0, 1.0, 0.0, 1.0},
;56:	{0.0, 0.0, 1.0, 1.0},
;57:	{0.0, 1.0, 1.0, 1.0},
;58:	{1.0, 0.0, 1.0, 1.0},
;59:	{1.0, 1.0, 1.0, 1.0},
;60:	{1.00f, 0.43f, 0.00f, 1.00f},
;61:	};
;62:
;63:
;64:vec3_t	bytedirs[NUMVERTEXNORMALS] =
;65:{
;66:{-0.525731f, 0.000000f, 0.850651f}, {-0.442863f, 0.238856f, 0.864188f}, 
;67:{-0.295242f, 0.000000f, 0.955423f}, {-0.309017f, 0.500000f, 0.809017f}, 
;68:{-0.162460f, 0.262866f, 0.951056f}, {0.000000f, 0.000000f, 1.000000f}, 
;69:{0.000000f, 0.850651f, 0.525731f}, {-0.147621f, 0.716567f, 0.681718f}, 
;70:{0.147621f, 0.716567f, 0.681718f}, {0.000000f, 0.525731f, 0.850651f}, 
;71:{0.309017f, 0.500000f, 0.809017f}, {0.525731f, 0.000000f, 0.850651f}, 
;72:{0.295242f, 0.000000f, 0.955423f}, {0.442863f, 0.238856f, 0.864188f}, 
;73:{0.162460f, 0.262866f, 0.951056f}, {-0.681718f, 0.147621f, 0.716567f}, 
;74:{-0.809017f, 0.309017f, 0.500000f},{-0.587785f, 0.425325f, 0.688191f}, 
;75:{-0.850651f, 0.525731f, 0.000000f},{-0.864188f, 0.442863f, 0.238856f}, 
;76:{-0.716567f, 0.681718f, 0.147621f},{-0.688191f, 0.587785f, 0.425325f}, 
;77:{-0.500000f, 0.809017f, 0.309017f}, {-0.238856f, 0.864188f, 0.442863f}, 
;78:{-0.425325f, 0.688191f, 0.587785f}, {-0.716567f, 0.681718f, -0.147621f}, 
;79:{-0.500000f, 0.809017f, -0.309017f}, {-0.525731f, 0.850651f, 0.000000f}, 
;80:{0.000000f, 0.850651f, -0.525731f}, {-0.238856f, 0.864188f, -0.442863f}, 
;81:{0.000000f, 0.955423f, -0.295242f}, {-0.262866f, 0.951056f, -0.162460f}, 
;82:{0.000000f, 1.000000f, 0.000000f}, {0.000000f, 0.955423f, 0.295242f}, 
;83:{-0.262866f, 0.951056f, 0.162460f}, {0.238856f, 0.864188f, 0.442863f}, 
;84:{0.262866f, 0.951056f, 0.162460f}, {0.500000f, 0.809017f, 0.309017f}, 
;85:{0.238856f, 0.864188f, -0.442863f},{0.262866f, 0.951056f, -0.162460f}, 
;86:{0.500000f, 0.809017f, -0.309017f},{0.850651f, 0.525731f, 0.000000f}, 
;87:{0.716567f, 0.681718f, 0.147621f}, {0.716567f, 0.681718f, -0.147621f}, 
;88:{0.525731f, 0.850651f, 0.000000f}, {0.425325f, 0.688191f, 0.587785f}, 
;89:{0.864188f, 0.442863f, 0.238856f}, {0.688191f, 0.587785f, 0.425325f}, 
;90:{0.809017f, 0.309017f, 0.500000f}, {0.681718f, 0.147621f, 0.716567f}, 
;91:{0.587785f, 0.425325f, 0.688191f}, {0.955423f, 0.295242f, 0.000000f}, 
;92:{1.000000f, 0.000000f, 0.000000f}, {0.951056f, 0.162460f, 0.262866f}, 
;93:{0.850651f, -0.525731f, 0.000000f},{0.955423f, -0.295242f, 0.000000f}, 
;94:{0.864188f, -0.442863f, 0.238856f}, {0.951056f, -0.162460f, 0.262866f}, 
;95:{0.809017f, -0.309017f, 0.500000f}, {0.681718f, -0.147621f, 0.716567f}, 
;96:{0.850651f, 0.000000f, 0.525731f}, {0.864188f, 0.442863f, -0.238856f}, 
;97:{0.809017f, 0.309017f, -0.500000f}, {0.951056f, 0.162460f, -0.262866f}, 
;98:{0.525731f, 0.000000f, -0.850651f}, {0.681718f, 0.147621f, -0.716567f}, 
;99:{0.681718f, -0.147621f, -0.716567f},{0.850651f, 0.000000f, -0.525731f}, 
;100:{0.809017f, -0.309017f, -0.500000f}, {0.864188f, -0.442863f, -0.238856f}, 
;101:{0.951056f, -0.162460f, -0.262866f}, {0.147621f, 0.716567f, -0.681718f}, 
;102:{0.309017f, 0.500000f, -0.809017f}, {0.425325f, 0.688191f, -0.587785f}, 
;103:{0.442863f, 0.238856f, -0.864188f}, {0.587785f, 0.425325f, -0.688191f}, 
;104:{0.688191f, 0.587785f, -0.425325f}, {-0.147621f, 0.716567f, -0.681718f}, 
;105:{-0.309017f, 0.500000f, -0.809017f}, {0.000000f, 0.525731f, -0.850651f}, 
;106:{-0.525731f, 0.000000f, -0.850651f}, {-0.442863f, 0.238856f, -0.864188f}, 
;107:{-0.295242f, 0.000000f, -0.955423f}, {-0.162460f, 0.262866f, -0.951056f}, 
;108:{0.000000f, 0.000000f, -1.000000f}, {0.295242f, 0.000000f, -0.955423f}, 
;109:{0.162460f, 0.262866f, -0.951056f}, {-0.442863f, -0.238856f, -0.864188f}, 
;110:{-0.309017f, -0.500000f, -0.809017f}, {-0.162460f, -0.262866f, -0.951056f}, 
;111:{0.000000f, -0.850651f, -0.525731f}, {-0.147621f, -0.716567f, -0.681718f}, 
;112:{0.147621f, -0.716567f, -0.681718f}, {0.000000f, -0.525731f, -0.850651f}, 
;113:{0.309017f, -0.500000f, -0.809017f}, {0.442863f, -0.238856f, -0.864188f}, 
;114:{0.162460f, -0.262866f, -0.951056f}, {0.238856f, -0.864188f, -0.442863f}, 
;115:{0.500000f, -0.809017f, -0.309017f}, {0.425325f, -0.688191f, -0.587785f}, 
;116:{0.716567f, -0.681718f, -0.147621f}, {0.688191f, -0.587785f, -0.425325f}, 
;117:{0.587785f, -0.425325f, -0.688191f}, {0.000000f, -0.955423f, -0.295242f}, 
;118:{0.000000f, -1.000000f, 0.000000f}, {0.262866f, -0.951056f, -0.162460f}, 
;119:{0.000000f, -0.850651f, 0.525731f}, {0.000000f, -0.955423f, 0.295242f}, 
;120:{0.238856f, -0.864188f, 0.442863f}, {0.262866f, -0.951056f, 0.162460f}, 
;121:{0.500000f, -0.809017f, 0.309017f}, {0.716567f, -0.681718f, 0.147621f}, 
;122:{0.525731f, -0.850651f, 0.000000f}, {-0.238856f, -0.864188f, -0.442863f}, 
;123:{-0.500000f, -0.809017f, -0.309017f}, {-0.262866f, -0.951056f, -0.162460f}, 
;124:{-0.850651f, -0.525731f, 0.000000f}, {-0.716567f, -0.681718f, -0.147621f}, 
;125:{-0.716567f, -0.681718f, 0.147621f}, {-0.525731f, -0.850651f, 0.000000f}, 
;126:{-0.500000f, -0.809017f, 0.309017f}, {-0.238856f, -0.864188f, 0.442863f}, 
;127:{-0.262866f, -0.951056f, 0.162460f}, {-0.864188f, -0.442863f, 0.238856f}, 
;128:{-0.809017f, -0.309017f, 0.500000f}, {-0.688191f, -0.587785f, 0.425325f}, 
;129:{-0.681718f, -0.147621f, 0.716567f}, {-0.442863f, -0.238856f, 0.864188f}, 
;130:{-0.587785f, -0.425325f, 0.688191f}, {-0.309017f, -0.500000f, 0.809017f}, 
;131:{-0.147621f, -0.716567f, 0.681718f}, {-0.425325f, -0.688191f, 0.587785f}, 
;132:{-0.162460f, -0.262866f, 0.951056f}, {0.442863f, -0.238856f, 0.864188f}, 
;133:{0.162460f, -0.262866f, 0.951056f}, {0.309017f, -0.500000f, 0.809017f}, 
;134:{0.147621f, -0.716567f, 0.681718f}, {0.000000f, -0.525731f, 0.850651f}, 
;135:{0.425325f, -0.688191f, 0.587785f}, {0.587785f, -0.425325f, 0.688191f}, 
;136:{0.688191f, -0.587785f, 0.425325f}, {-0.955423f, 0.295242f, 0.000000f}, 
;137:{-0.951056f, 0.162460f, 0.262866f}, {-1.000000f, 0.000000f, 0.000000f}, 
;138:{-0.850651f, 0.000000f, 0.525731f}, {-0.955423f, -0.295242f, 0.000000f}, 
;139:{-0.951056f, -0.162460f, 0.262866f}, {-0.864188f, 0.442863f, -0.238856f}, 
;140:{-0.951056f, 0.162460f, -0.262866f}, {-0.809017f, 0.309017f, -0.500000f}, 
;141:{-0.864188f, -0.442863f, -0.238856f}, {-0.951056f, -0.162460f, -0.262866f}, 
;142:{-0.809017f, -0.309017f, -0.500000f}, {-0.681718f, 0.147621f, -0.716567f}, 
;143:{-0.681718f, -0.147621f, -0.716567f}, {-0.850651f, 0.000000f, -0.525731f}, 
;144:{-0.688191f, 0.587785f, -0.425325f}, {-0.587785f, 0.425325f, -0.688191f}, 
;145:{-0.425325f, 0.688191f, -0.587785f}, {-0.425325f, -0.688191f, -0.587785f}, 
;146:{-0.587785f, -0.425325f, -0.688191f}, {-0.688191f, -0.587785f, -0.425325f}
;147:};
;148:
;149://==============================================================
;150:
;151:int		Q_rand( int *seed ) {
line 152
;152:	*seed = (69069 * *seed + 1);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 69069
ADDRLP4 0
INDIRP4
INDIRI4
MULI4
CNSTI4 1
ADDI4
ASGNI4
line 153
;153:	return *seed;
ADDRFP4 0
INDIRP4
INDIRI4
RETI4
LABELV $43
endproc Q_rand 4 0
export Q_random
proc Q_random 4 4
line 156
;154:}
;155:
;156:float	Q_random( int *seed ) {
line 157
;157:	return ( Q_rand( seed ) & 0xffff ) / (float)0x10000;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Q_rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 65535
BANDI4
CVIF4 4
CNSTF4 1199570944
DIVF4
RETF4
LABELV $44
endproc Q_random 4 4
export Q_crandom
proc Q_crandom 4 4
line 160
;158:}
;159:
;160:float	Q_crandom( int *seed ) {
line 161
;161:	return 2.0 * ( Q_random( seed ) - 0.5 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Q_random
CALLF4
ASGNF4
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
RETF4
LABELV $45
endproc Q_crandom 4 4
export ClampChar
proc ClampChar 0 0
line 166
;162:}
;163:
;164://=======================================================
;165:
;166:signed char ClampChar( int i ) {
line 167
;167:	if ( i < -128 ) {
ADDRFP4 0
INDIRI4
CNSTI4 -128
GEI4 $47
line 168
;168:		return -128;
CNSTI4 -128
RETI4
ADDRGP4 $46
JUMPV
LABELV $47
line 170
;169:	}
;170:	if ( i > 127 ) {
ADDRFP4 0
INDIRI4
CNSTI4 127
LEI4 $49
line 171
;171:		return 127;
CNSTI4 127
RETI4
ADDRGP4 $46
JUMPV
LABELV $49
line 173
;172:	}
;173:	return i;
ADDRFP4 0
INDIRI4
CVII1 4
CVII4 1
RETI4
LABELV $46
endproc ClampChar 0 0
export ClampShort
proc ClampShort 0 0
line 176
;174:}
;175:
;176:signed short ClampShort( int i ) {
line 177
;177:	if ( i < -32768 ) {
ADDRFP4 0
INDIRI4
CNSTI4 -32768
GEI4 $52
line 178
;178:		return -32768;
CNSTI4 -32768
RETI4
ADDRGP4 $51
JUMPV
LABELV $52
line 180
;179:	}
;180:	if ( i > 0x7fff ) {
ADDRFP4 0
INDIRI4
CNSTI4 32767
LEI4 $54
line 181
;181:		return 0x7fff;
CNSTI4 32767
RETI4
ADDRGP4 $51
JUMPV
LABELV $54
line 183
;182:	}
;183:	return i;
ADDRFP4 0
INDIRI4
CVII2 4
CVII4 2
RETI4
LABELV $51
endproc ClampShort 0 0
export DirToByte
proc DirToByte 24 0
line 188
;184:}
;185:
;186:
;187:// this isn't a real cheap function to call!
;188:int DirToByte( vec3_t dir ) {
line 192
;189:	int		i, best;
;190:	float	d, bestd;
;191:
;192:	if ( !dir ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $57
line 193
;193:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $56
JUMPV
LABELV $57
line 196
;194:	}
;195:
;196:	bestd = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 197
;197:	best = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 198
;198:	for (i=0 ; i<NUMVERTEXNORMALS ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $59
line 199
;199:	{
line 200
;200:		d = DotProduct (dir, bytedirs[i]);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 20
INDIRI4
ADDRGP4 bytedirs
ADDP4
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRI4
ADDRGP4 bytedirs+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 20
INDIRI4
ADDRGP4 bytedirs+8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 201
;201:		if (d > bestd)
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $65
line 202
;202:		{
line 203
;203:			bestd = d;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ASGNF4
line 204
;204:			best = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 205
;205:		}
LABELV $65
line 206
;206:	}
LABELV $60
line 198
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 162
LTI4 $59
line 208
;207:
;208:	return best;
ADDRLP4 12
INDIRI4
RETI4
LABELV $56
endproc DirToByte 24 0
export ByteToDir
proc ByteToDir 4 0
line 211
;209:}
;210:
;211:void ByteToDir( int b, vec3_t dir ) {
line 212
;212:	if ( b < 0 || b >= NUMVERTEXNORMALS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $70
ADDRLP4 0
INDIRI4
CNSTI4 162
LTI4 $68
LABELV $70
line 213
;213:		VectorCopy( vec3_origin, dir );
ADDRFP4 4
INDIRP4
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 214
;214:		return;
ADDRGP4 $67
JUMPV
LABELV $68
line 216
;215:	}
;216:	VectorCopy (bytedirs[b], dir);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bytedirs
ADDP4
INDIRB
ASGNB 12
line 217
;217:}
LABELV $67
endproc ByteToDir 4 0
export ColorBytes3
proc ColorBytes3 40 0
line 220
;218:
;219:
;220:unsigned ColorBytes3 (float r, float g, float b) {
line 223
;221:	unsigned	i;
;222:
;223:	( (byte *)&i )[0] = r * 255;
ADDRLP4 8
CNSTF4 1132396544
ADDRFP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
CNSTF4 1325400064
ASGNF4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
LTF4 $73
ADDRLP4 4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $74
JUMPV
LABELV $73
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $74
ADDRLP4 0
ADDRLP4 4
INDIRU4
CVUU1 4
ASGNU1
line 224
;224:	( (byte *)&i )[1] = g * 255;
ADDRLP4 20
CNSTF4 1132396544
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 24
CNSTF4 1325400064
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
LTF4 $77
ADDRLP4 16
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $78
JUMPV
LABELV $77
ADDRLP4 16
ADDRLP4 20
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $78
ADDRLP4 0+1
ADDRLP4 16
INDIRU4
CVUU1 4
ASGNU1
line 225
;225:	( (byte *)&i )[2] = b * 255;
ADDRLP4 32
CNSTF4 1132396544
ADDRFP4 8
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
LTF4 $81
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
ADDRGP4 $82
JUMPV
LABELV $81
ADDRLP4 28
ADDRLP4 32
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $82
ADDRLP4 0+2
ADDRLP4 28
INDIRU4
CVUU1 4
ASGNU1
line 227
;226:
;227:	return i;
ADDRLP4 0
INDIRU4
RETU4
LABELV $71
endproc ColorBytes3 40 0
export ColorBytes4
proc ColorBytes4 52 0
line 230
;228:}
;229:
;230:unsigned ColorBytes4 (float r, float g, float b, float a) {
line 233
;231:	unsigned	i;
;232:
;233:	( (byte *)&i )[0] = r * 255;
ADDRLP4 8
CNSTF4 1132396544
ADDRFP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
CNSTF4 1325400064
ASGNF4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
LTF4 $85
ADDRLP4 4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $86
JUMPV
LABELV $85
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $86
ADDRLP4 0
ADDRLP4 4
INDIRU4
CVUU1 4
ASGNU1
line 234
;234:	( (byte *)&i )[1] = g * 255;
ADDRLP4 20
CNSTF4 1132396544
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 24
CNSTF4 1325400064
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
LTF4 $89
ADDRLP4 16
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $90
JUMPV
LABELV $89
ADDRLP4 16
ADDRLP4 20
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $90
ADDRLP4 0+1
ADDRLP4 16
INDIRU4
CVUU1 4
ASGNU1
line 235
;235:	( (byte *)&i )[2] = b * 255;
ADDRLP4 32
CNSTF4 1132396544
ADDRFP4 8
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
LTF4 $93
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
ADDRGP4 $94
JUMPV
LABELV $93
ADDRLP4 28
ADDRLP4 32
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $94
ADDRLP4 0+2
ADDRLP4 28
INDIRU4
CVUU1 4
ASGNU1
line 236
;236:	( (byte *)&i )[3] = a * 255;
ADDRLP4 44
CNSTF4 1132396544
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 48
CNSTF4 1325400064
ASGNF4
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
LTF4 $97
ADDRLP4 40
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $98
JUMPV
LABELV $97
ADDRLP4 40
ADDRLP4 44
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $98
ADDRLP4 0+3
ADDRLP4 40
INDIRU4
CVUU1 4
ASGNU1
line 238
;237:
;238:	return i;
ADDRLP4 0
INDIRU4
RETU4
LABELV $83
endproc ColorBytes4 52 0
export NormalizeColor
proc NormalizeColor 12 0
line 241
;239:}
;240:
;241:float NormalizeColor( const vec3_t in, vec3_t out ) {
line 244
;242:	float	max;
;243:	
;244:	max = in[0];
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 245
;245:	if ( in[1] > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
LEF4 $100
line 246
;246:		max = in[1];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 247
;247:	}
LABELV $100
line 248
;248:	if ( in[2] > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
LEF4 $102
line 249
;249:		max = in[2];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 250
;250:	}
LABELV $102
line 252
;251:
;252:	if ( !max ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
NEF4 $104
line 253
;253:		VectorClear( out );
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRF4
ASGNF4
line 254
;254:	} else {
ADDRGP4 $105
JUMPV
LABELV $104
line 255
;255:		out[0] = in[0] / max;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
DIVF4
ASGNF4
line 256
;256:		out[1] = in[1] / max;
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
DIVF4
ASGNF4
line 257
;257:		out[2] = in[2] / max;
ADDRLP4 8
CNSTI4 8
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
DIVF4
ASGNF4
line 258
;258:	}
LABELV $105
line 259
;259:	return max;
ADDRLP4 0
INDIRF4
RETF4
LABELV $99
endproc NormalizeColor 12 0
export PlaneFromPoints
proc PlaneFromPoints 76 12
line 271
;260:}
;261:
;262:
;263:/*
;264:=====================
;265:PlaneFromPoints
;266:
;267:Returns false if the triangle is degenrate.
;268:The normal will point out of the clock for clockwise ordered points
;269:=====================
;270:*/
;271:qboolean PlaneFromPoints( vec4_t plane, const vec3_t a, const vec3_t b, const vec3_t c ) {
line 274
;272:	vec3_t	d1, d2;
;273:
;274:	VectorSubtract( b, a, d1 );
ADDRLP4 24
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 28
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
CNSTI4 4
ASGNI4
ADDRLP4 0+4
ADDRLP4 24
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
CNSTI4 8
ASGNI4
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 275
;275:	VectorSubtract( c, a, d2 );
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 44
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 4
ASGNI4
ADDRLP4 12+4
ADDRLP4 40
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
CNSTI4 8
ASGNI4
ADDRLP4 12+8
ADDRFP4 12
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 276
;276:	CrossProduct( d2, d1, plane );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 277
;277:	if ( VectorNormalize( plane ) == 0 ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 0
NEF4 $111
line 278
;278:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $106
JUMPV
LABELV $111
line 281
;279:	}
;280:
;281:	plane[3] = DotProduct( a, plane );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 4
ASGNI4
ADDRLP4 72
CNSTI4 8
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRF4
MULF4
ADDRLP4 64
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 64
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 282
;282:	return qtrue;
CNSTI4 1
RETI4
LABELV $106
endproc PlaneFromPoints 76 12
export RotatePointAroundVector
proc RotatePointAroundVector 256 12
line 293
;283:}
;284:
;285:/*
;286:===============
;287:RotatePointAroundVector
;288:
;289:This is not implemented very well...
;290:===============
;291:*/
;292:void RotatePointAroundVector( vec3_t dst, const vec3_t dir, const vec3_t point,
;293:							 float degrees ) {
line 303
;294:	float	m[3][3];
;295:	float	im[3][3];
;296:	float	zrot[3][3];
;297:	float	tmpmat[3][3];
;298:	float	rot[3][3];
;299:	int	i;
;300:	vec3_t vr, vup, vf;
;301:	float	rad;
;302:
;303:	vf[0] = dir[0];
ADDRLP4 148
ADDRFP4 4
INDIRP4
INDIRF4
ASGNF4
line 304
;304:	vf[1] = dir[1];
ADDRLP4 148+4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 305
;305:	vf[2] = dir[2];
ADDRLP4 148+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 307
;306:
;307:	PerpendicularVector( vr, dir );
ADDRLP4 160
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 308
;308:	CrossProduct( vr, vf, vup );
ADDRLP4 160
ARGP4
ADDRLP4 148
ARGP4
ADDRLP4 176
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 310
;309:
;310:	m[0][0] = vr[0];
ADDRLP4 40
ADDRLP4 160
INDIRF4
ASGNF4
line 311
;311:	m[1][0] = vr[1];
ADDRLP4 40+12
ADDRLP4 160+4
INDIRF4
ASGNF4
line 312
;312:	m[2][0] = vr[2];
ADDRLP4 40+24
ADDRLP4 160+8
INDIRF4
ASGNF4
line 314
;313:
;314:	m[0][1] = vup[0];
ADDRLP4 40+4
ADDRLP4 176
INDIRF4
ASGNF4
line 315
;315:	m[1][1] = vup[1];
ADDRLP4 40+12+4
ADDRLP4 176+4
INDIRF4
ASGNF4
line 316
;316:	m[2][1] = vup[2];
ADDRLP4 40+24+4
ADDRLP4 176+8
INDIRF4
ASGNF4
line 318
;317:
;318:	m[0][2] = vf[0];
ADDRLP4 40+8
ADDRLP4 148
INDIRF4
ASGNF4
line 319
;319:	m[1][2] = vf[1];
ADDRLP4 40+12+8
ADDRLP4 148+4
INDIRF4
ASGNF4
line 320
;320:	m[2][2] = vf[2];
ADDRLP4 40+24+8
ADDRLP4 148+8
INDIRF4
ASGNF4
line 322
;321:
;322:	memcpy( im, m, sizeof( im ) );
ADDRLP4 112
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 324
;323:
;324:	im[0][1] = m[1][0];
ADDRLP4 112+4
ADDRLP4 40+12
INDIRF4
ASGNF4
line 325
;325:	im[0][2] = m[2][0];
ADDRLP4 112+8
ADDRLP4 40+24
INDIRF4
ASGNF4
line 326
;326:	im[1][0] = m[0][1];
ADDRLP4 112+12
ADDRLP4 40+4
INDIRF4
ASGNF4
line 327
;327:	im[1][2] = m[2][1];
ADDRLP4 112+12+8
ADDRLP4 40+24+4
INDIRF4
ASGNF4
line 328
;328:	im[2][0] = m[0][2];
ADDRLP4 112+24
ADDRLP4 40+8
INDIRF4
ASGNF4
line 329
;329:	im[2][1] = m[1][2];
ADDRLP4 112+24+4
ADDRLP4 40+12+8
INDIRF4
ASGNF4
line 331
;330:
;331:	memset( zrot, 0, sizeof( zrot ) );
ADDRLP4 76
ARGP4
CNSTI4 0
ARGI4
CNSTI4 36
ARGI4
ADDRGP4 memset
CALLP4
pop
line 332
;332:	zrot[0][0] = zrot[1][1] = zrot[2][2] = 1.0F;
ADDRLP4 224
CNSTF4 1065353216
ASGNF4
ADDRLP4 76+24+8
ADDRLP4 224
INDIRF4
ASGNF4
ADDRLP4 76+12+4
ADDRLP4 224
INDIRF4
ASGNF4
ADDRLP4 76
ADDRLP4 224
INDIRF4
ASGNF4
line 334
;333:
;334:	rad = DEG2RAD( degrees );
ADDRLP4 172
CNSTF4 1078530011
ADDRFP4 12
INDIRF4
MULF4
CNSTF4 1127481344
DIVF4
ASGNF4
line 335
;335:	zrot[0][0] = cos( rad );
ADDRLP4 172
INDIRF4
ARGF4
ADDRLP4 228
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 76
ADDRLP4 228
INDIRF4
ASGNF4
line 336
;336:	zrot[0][1] = sin( rad );
ADDRLP4 172
INDIRF4
ARGF4
ADDRLP4 232
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 232
INDIRF4
ASGNF4
line 337
;337:	zrot[1][0] = -sin( rad );
ADDRLP4 172
INDIRF4
ARGF4
ADDRLP4 236
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 76+12
ADDRLP4 236
INDIRF4
NEGF4
ASGNF4
line 338
;338:	zrot[1][1] = cos( rad );
ADDRLP4 172
INDIRF4
ARGF4
ADDRLP4 240
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 76+12+4
ADDRLP4 240
INDIRF4
ASGNF4
line 340
;339:
;340:	MatrixMultiply( m, zrot, tmpmat );
ADDRLP4 40
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 188
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 341
;341:	MatrixMultiply( tmpmat, im, rot );
ADDRLP4 188
ARGP4
ADDRLP4 112
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 343
;342:
;343:	for ( i = 0; i < 3; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $158
line 344
;344:		dst[i] = rot[i][0] * point[0] + rot[i][1] * point[1] + rot[i][2] * point[2];
ADDRLP4 248
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 252
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ADDRLP4 248
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
ADDRLP4 252
INDIRP4
INDIRF4
MULF4
ADDRLP4 248
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
ADDRLP4 252
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 248
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
ADDRLP4 252
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 345
;345:	}
LABELV $159
line 343
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $158
line 346
;346:}
LABELV $113
endproc RotatePointAroundVector 256 12
export RotateAroundDirection
proc RotateAroundDirection 20 16
line 353
;347:
;348:/*
;349:===============
;350:RotateAroundDirection
;351:===============
;352:*/
;353:void RotateAroundDirection( vec3_t axis[3], float yaw ) {
line 356
;354:
;355:	// create an arbitrary axis[1] 
;356:	PerpendicularVector( axis[1], axis[0] );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 359
;357:
;358:	// rotate it around axis[0] by yaw
;359:	if ( yaw ) {
ADDRFP4 4
INDIRF4
CNSTF4 0
EQF4 $165
line 362
;360:		vec3_t	temp;
;361:
;362:		VectorCopy( axis[1], temp );
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 363
;363:		RotatePointAroundVector( axis[1], axis[0], temp, yaw );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 RotatePointAroundVector
CALLV
pop
line 364
;364:	}
LABELV $165
line 367
;365:
;366:	// cross to get axis[2]
;367:	CrossProduct( axis[0], axis[1], axis[2] );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 368
;368:}
LABELV $164
endproc RotateAroundDirection 20 16
export vectoangles
proc vectoangles 40 8
line 372
;369:
;370:
;371:
;372:void vectoangles( const vec3_t value1, vec3_t angles ) {
line 376
;373:	float	forward;
;374:	float	yaw, pitch;
;375:	
;376:	if ( value1[1] == 0 && value1[0] == 0 ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
NEF4 $168
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRF4
NEF4 $168
line 377
;377:		yaw = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 378
;378:		if ( value1[2] > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 0
LEF4 $170
line 379
;379:			pitch = 90;
ADDRLP4 4
CNSTF4 1119092736
ASGNF4
line 380
;380:		}
ADDRGP4 $169
JUMPV
LABELV $170
line 381
;381:		else {
line 382
;382:			pitch = 270;
ADDRLP4 4
CNSTF4 1132920832
ASGNF4
line 383
;383:		}
line 384
;384:	}
ADDRGP4 $169
JUMPV
LABELV $168
line 385
;385:	else {
line 386
;386:		if ( value1[0] ) {
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 0
EQF4 $172
line 387
;387:			yaw = ( atan2 ( value1[1], value1[0] ) * 180 / M_PI );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1127481344
ADDRLP4 24
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 388
;388:		}
ADDRGP4 $173
JUMPV
LABELV $172
line 389
;389:		else if ( value1[1] > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 0
LEF4 $174
line 390
;390:			yaw = 90;
ADDRLP4 0
CNSTF4 1119092736
ASGNF4
line 391
;391:		}
ADDRGP4 $175
JUMPV
LABELV $174
line 392
;392:		else {
line 393
;393:			yaw = 270;
ADDRLP4 0
CNSTF4 1132920832
ASGNF4
line 394
;394:		}
LABELV $175
LABELV $173
line 395
;395:		if ( yaw < 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $176
line 396
;396:			yaw += 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 397
;397:		}
LABELV $176
line 399
;398:
;399:		forward = sqrt ( value1[0]*value1[0] + value1[1]*value1[1] );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 28
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 32
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 400
;400:		pitch = ( atan2(value1[2], forward) * 180 / M_PI );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1127481344
ADDRLP4 36
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 401
;401:		if ( pitch < 0 ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $178
line 402
;402:			pitch += 360;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 403
;403:		}
LABELV $178
line 404
;404:	}
LABELV $169
line 406
;405:
;406:	angles[PITCH] = -pitch;
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRF4
NEGF4
ASGNF4
line 407
;407:	angles[YAW] = yaw;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
line 408
;408:	angles[ROLL] = 0;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 409
;409:}
LABELV $167
endproc vectoangles 40 8
export AnglesToAxis
proc AnglesToAxis 16 16
line 417
;410:
;411:
;412:/*
;413:=================
;414:AnglesToAxis
;415:=================
;416:*/
;417:void AnglesToAxis( const vec3_t angles, vec3_t axis[3] ) {
line 421
;418:	vec3_t	right;
;419:
;420:	// angle vectors returns "right" instead of "y axis"
;421:	AngleVectors( angles, axis[0], right, axis[2] );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 422
;422:	VectorSubtract( vec3_origin, right, axis[1] );
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 423
;423:}
LABELV $180
endproc AnglesToAxis 16 16
export AxisClear
proc AxisClear 0 0
line 425
;424:
;425:void AxisClear( vec3_t axis[3] ) {
line 426
;426:	axis[0][0] = 1;
ADDRFP4 0
INDIRP4
CNSTF4 1065353216
ASGNF4
line 427
;427:	axis[0][1] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 428
;428:	axis[0][2] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 429
;429:	axis[1][0] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 0
ASGNF4
line 430
;430:	axis[1][1] = 1;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1065353216
ASGNF4
line 431
;431:	axis[1][2] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 0
ASGNF4
line 432
;432:	axis[2][0] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 0
ASGNF4
line 433
;433:	axis[2][1] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 0
ASGNF4
line 434
;434:	axis[2][2] = 1;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1065353216
ASGNF4
line 435
;435:}
LABELV $185
endproc AxisClear 0 0
export AxisCopy
proc AxisCopy 8 0
line 437
;436:
;437:void AxisCopy( vec3_t in[3], vec3_t out[3] ) {
line 438
;438:	VectorCopy( in[0], out[0] );
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 439
;439:	VectorCopy( in[1], out[1] );
ADDRLP4 0
CNSTI4 12
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 440
;440:	VectorCopy( in[2], out[2] );
ADDRLP4 4
CNSTI4 24
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 441
;441:}
LABELV $186
endproc AxisCopy 8 0
export ProjectPointOnPlane
proc ProjectPointOnPlane 60 0
line 444
;442:
;443:void ProjectPointOnPlane( vec3_t dst, const vec3_t p, const vec3_t normal )
;444:{
line 449
;445:	float d;
;446:	vec3_t n;
;447:	float inv_denom;
;448:
;449:	inv_denom =  DotProduct( normal, normal );
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 28
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ADDRLP4 32
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDF4
ASGNF4
line 453
;450:#ifndef Q3_VM
;451:	assert( Q_fabs(inv_denom) != 0.0f ); // zero vectors get here
;452:#endif
;453:	inv_denom = 1.0f / inv_denom;
ADDRLP4 0
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
DIVF4
ASGNF4
line 455
;454:
;455:	d = DotProduct( normal, p ) * inv_denom;
ADDRLP4 36
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 4
ASGNI4
ADDRLP4 48
CNSTI4 8
ASGNI4
ADDRLP4 16
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRF4
MULF4
ADDRLP4 36
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 457
;456:
;457:	n[0] = normal[0] * inv_denom;
ADDRLP4 4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 458
;458:	n[1] = normal[1] * inv_denom;
ADDRLP4 4+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 459
;459:	n[2] = normal[2] * inv_denom;
ADDRLP4 4+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 461
;460:
;461:	dst[0] = p[0] - d * n[0];
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
SUBF4
ASGNF4
line 462
;462:	dst[1] = p[1] - d * n[1];
ADDRLP4 52
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
SUBF4
ASGNF4
line 463
;463:	dst[2] = p[2] - d * n[2];
ADDRLP4 56
CNSTI4 8
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
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 4+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 464
;464:}
LABELV $187
endproc ProjectPointOnPlane 60 0
export MakeNormalVectors
proc MakeNormalVectors 40 12
line 474
;465:
;466:/*
;467:================
;468:MakeNormalVectors
;469:
;470:Given a normalized forward vector, create two
;471:other perpendicular vectors
;472:================
;473:*/
;474:void MakeNormalVectors( const vec3_t forward, vec3_t right, vec3_t up) {
line 479
;475:	float		d;
;476:
;477:	// this rotate and negate guarantees a vector
;478:	// not colinear with the original
;479:	right[1] = -forward[0];
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
INDIRF4
NEGF4
ASGNF4
line 480
;480:	right[2] = forward[1];
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 481
;481:	right[0] = forward[2];
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 483
;482:
;483:	d = DotProduct (right, forward);
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 4
ASGNI4
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 8
INDIRP4
INDIRF4
MULF4
ADDRLP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 484
;484:	VectorMA (right, -d, forward, right);
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 24
CNSTI4 4
ASGNI4
ADDRLP4 28
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRLP4 36
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 485
;485:	VectorNormalize (right);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 486
;486:	CrossProduct (right, forward, up);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 487
;487:}
LABELV $192
endproc MakeNormalVectors 40 12
export VectorRotate
proc VectorRotate 40 0
line 491
;488:
;489:
;490:void VectorRotate( vec3_t in, vec3_t matrix[3], vec3_t out )
;491:{
line 492
;492:	out[0] = DotProduct( in, matrix[0] );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 493
;493:	out[1] = DotProduct( in, matrix[1] );
ADDRLP4 16
CNSTI4 4
ASGNI4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDRLP4 20
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 494
;494:	out[2] = DotProduct( in, matrix[2] );
ADDRLP4 28
CNSTI4 8
ASGNI4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 32
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 495
;495:}
LABELV $193
endproc VectorRotate 40 0
export Q_rsqrt
proc Q_rsqrt 20 0
line 504
;496:
;497://============================================================================
;498:
;499:#if !idppc
;500:/*
;501:** float q_rsqrt( float number )
;502:*/
;503:float Q_rsqrt( float number )
;504:{
line 510
;505:	union {
;506:		float f;
;507:		int i;
;508:	} t;
;509:	float x2, y;
;510:	const float threehalfs = 1.5F;
ADDRLP4 12
CNSTF4 1069547520
ASGNF4
line 512
;511:
;512:	x2 = number * 0.5F;
ADDRLP4 8
CNSTF4 1056964608
ADDRFP4 0
INDIRF4
MULF4
ASGNF4
line 513
;513:	t.f  = number;
ADDRLP4 4
ADDRFP4 0
INDIRF4
ASGNF4
line 514
;514:	t.i  = 0x5f3759df - ( t.i >> 1 );               // what the fuck?
ADDRLP4 4
CNSTI4 1597463007
ADDRLP4 4
INDIRI4
CNSTI4 1
RSHI4
SUBI4
ASGNI4
line 515
;515:	y  = t.f;
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 516
;516:	y  = y * ( threehalfs - ( x2 * y * y ) );   // 1st iteration
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 519
;517://	y  = y * ( threehalfs - ( x2 * y * y ) );   // 2nd iteration, this can be removed
;518:
;519:	return y;
ADDRLP4 0
INDIRF4
RETF4
LABELV $194
endproc Q_rsqrt 20 0
export Q_fabs
proc Q_fabs 4 0
line 522
;520:}
;521:
;522:float Q_fabs( float f ) {
line 523
;523:	int tmp = * ( int * ) &f;
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
line 524
;524:	tmp &= 0x7FFFFFFF;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2147483647
BANDI4
ASGNI4
line 525
;525:	return * ( float * ) &tmp;
ADDRLP4 0
INDIRF4
RETF4
LABELV $196
endproc Q_fabs 4 0
export LerpAngle
proc LerpAngle 8 0
line 537
;526:}
;527:#endif
;528:
;529://============================================================
;530:
;531:/*
;532:===============
;533:LerpAngle
;534:
;535:===============
;536:*/
;537:float LerpAngle (float from, float to, float frac) {
line 540
;538:	float	a;
;539:
;540:	if ( to - from > 180 ) {
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
SUBF4
CNSTF4 1127481344
LEF4 $198
line 541
;541:		to -= 360;
ADDRFP4 4
ADDRFP4 4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 542
;542:	}
LABELV $198
line 543
;543:	if ( to - from < -180 ) {
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
SUBF4
CNSTF4 3274964992
GEF4 $200
line 544
;544:		to += 360;
ADDRFP4 4
ADDRFP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 545
;545:	}
LABELV $200
line 546
;546:	a = from + frac * (to - from);
ADDRLP4 4
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ADDRFP4 8
INDIRF4
ADDRFP4 4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 548
;547:
;548:	return a;
ADDRLP4 0
INDIRF4
RETF4
LABELV $197
endproc LerpAngle 8 0
export AngleSubtract
proc AngleSubtract 4 0
line 559
;549:}
;550:
;551:
;552:/*
;553:=================
;554:AngleSubtract
;555:
;556:Always returns a value from -180 to 180
;557:=================
;558:*/
;559:float	AngleSubtract( float a1, float a2 ) {
line 562
;560:	float	a;
;561:
;562:	a = a1 - a2;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $204
JUMPV
LABELV $203
line 563
;563:	while ( a > 180 ) {
line 564
;564:		a -= 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 565
;565:	}
LABELV $204
line 563
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
GTF4 $203
ADDRGP4 $207
JUMPV
LABELV $206
line 566
;566:	while ( a < -180 ) {
line 567
;567:		a += 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 568
;568:	}
LABELV $207
line 566
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
LTF4 $206
line 569
;569:	return a;
ADDRLP4 0
INDIRF4
RETF4
LABELV $202
endproc AngleSubtract 4 0
export AnglesSubtract
proc AnglesSubtract 20 8
line 573
;570:}
;571:
;572:
;573:void AnglesSubtract( vec3_t v1, vec3_t v2, vec3_t v3 ) {
line 574
;574:	v3[0] = AngleSubtract( v1[0], v2[0] );
ADDRFP4 0
INDIRP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRF4
ASGNF4
line 575
;575:	v3[1] = AngleSubtract( v1[1], v2[1] );
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 576
;576:	v3[2] = AngleSubtract( v1[2], v2[2] );
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 577
;577:}
LABELV $209
endproc AnglesSubtract 20 8
export AngleMod
proc AngleMod 0 0
line 580
;578:
;579:
;580:float	AngleMod(float a) {
line 581
;581:	a = (360.0/65536) * ((int)(a*(65536/360.0)) & 65535);
ADDRFP4 0
CNSTF4 1001652224
CNSTF4 1127615329
ADDRFP4 0
INDIRF4
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
CVIF4 4
MULF4
ASGNF4
line 582
;582:	return a;
ADDRFP4 0
INDIRF4
RETF4
LABELV $210
endproc AngleMod 0 0
export AngleNormalize360
proc AngleNormalize360 0 0
line 593
;583:}
;584:
;585:
;586:/*
;587:=================
;588:AngleNormalize360
;589:
;590:returns angle normalized to the range [0 <= angle < 360]
;591:=================
;592:*/
;593:float AngleNormalize360 ( float angle ) {
line 594
;594:	return (360.0 / 65536) * ((int)(angle * (65536 / 360.0)) & 65535);
CNSTF4 1001652224
CNSTF4 1127615329
ADDRFP4 0
INDIRF4
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
CVIF4 4
MULF4
RETF4
LABELV $211
endproc AngleNormalize360 0 0
export AngleNormalize180
proc AngleNormalize180 4 4
line 605
;595:}
;596:
;597:
;598:/*
;599:=================
;600:AngleNormalize180
;601:
;602:returns angle normalized to the range [-180 < angle <= 180]
;603:=================
;604:*/
;605:float AngleNormalize180 ( float angle ) {
line 606
;606:	angle = AngleNormalize360( angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 0
ADDRGP4 AngleNormalize360
CALLF4
ASGNF4
ADDRFP4 0
ADDRLP4 0
INDIRF4
ASGNF4
line 607
;607:	if ( angle > 180.0 ) {
ADDRFP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $213
line 608
;608:		angle -= 360.0;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 609
;609:	}
LABELV $213
line 610
;610:	return angle;
ADDRFP4 0
INDIRF4
RETF4
LABELV $212
endproc AngleNormalize180 4 4
export AngleDelta
proc AngleDelta 4 4
line 621
;611:}
;612:
;613:
;614:/*
;615:=================
;616:AngleDelta
;617:
;618:returns the normalized delta from angle1 to angle2
;619:=================
;620:*/
;621:float AngleDelta ( float angle1, float angle2 ) {
line 622
;622:	return AngleNormalize180( angle1 - angle2 );
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
ADDRGP4 AngleNormalize180
CALLF4
ASGNF4
ADDRLP4 0
INDIRF4
RETF4
LABELV $215
endproc AngleDelta 4 4
export SetPlaneSignbits
proc SetPlaneSignbits 8 0
line 634
;623:}
;624:
;625:
;626://============================================================
;627:
;628:
;629:/*
;630:=================
;631:SetPlaneSignbits
;632:=================
;633:*/
;634:void SetPlaneSignbits (cplane_t *out) {
line 638
;635:	int	bits, j;
;636:
;637:	// for fast box on planeside test
;638:	bits = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 639
;639:	for (j=0 ; j<3 ; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $217
line 640
;640:		if (out->normal[j] < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $221
line 641
;641:			bits |= 1<<j;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BORI4
ASGNI4
line 642
;642:		}
LABELV $221
line 643
;643:	}
LABELV $218
line 639
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $217
line 644
;644:	out->signbits = bits;
ADDRFP4 0
INDIRP4
CNSTI4 17
ADDP4
ADDRLP4 4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 645
;645:}
LABELV $216
endproc SetPlaneSignbits 8 0
export BoxOnPlaneSide
proc BoxOnPlaneSide 280 0
line 692
;646:
;647:
;648:/*
;649:==================
;650:BoxOnPlaneSide
;651:
;652:Returns 1, 2, or 1 + 2
;653:
;654:// this is the slow, general version
;655:int BoxOnPlaneSide2 (vec3_t emins, vec3_t emaxs, struct cplane_s *p)
;656:{
;657:	int		i;
;658:	float	dist1, dist2;
;659:	int		sides;
;660:	vec3_t	corners[2];
;661:
;662:	for (i=0 ; i<3 ; i++)
;663:	{
;664:		if (p->normal[i] < 0)
;665:		{
;666:			corners[0][i] = emins[i];
;667:			corners[1][i] = emaxs[i];
;668:		}
;669:		else
;670:		{
;671:			corners[1][i] = emins[i];
;672:			corners[0][i] = emaxs[i];
;673:		}
;674:	}
;675:	dist1 = DotProduct (p->normal, corners[0]) - p->dist;
;676:	dist2 = DotProduct (p->normal, corners[1]) - p->dist;
;677:	sides = 0;
;678:	if (dist1 >= 0)
;679:		sides = 1;
;680:	if (dist2 < 0)
;681:		sides |= 2;
;682:
;683:	return sides;
;684:}
;685:
;686:==================
;687:*/
;688:
;689:#if !id386
;690:
;691:int BoxOnPlaneSide (vec3_t emins, vec3_t emaxs, struct cplane_s *p)
;692:{
line 697
;693:	float	dist1, dist2;
;694:	int		sides;
;695:
;696:// fast axial cases
;697:	if (p->type < 3)
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRU1
CVUI4 1
CNSTI4 3
GEI4 $224
line 698
;698:	{
line 699
;699:		if (p->dist <= emins[p->type])
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
INDIRU1
CVUI4 1
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
GTF4 $226
line 700
;700:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $223
JUMPV
LABELV $226
line 701
;701:		if (p->dist >= emaxs[p->type])
ADDRLP4 16
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRU1
CVUI4 1
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
LTF4 $228
line 702
;702:			return 2;
CNSTI4 2
RETI4
ADDRGP4 $223
JUMPV
LABELV $228
line 703
;703:		return 3;
CNSTI4 3
RETI4
ADDRGP4 $223
JUMPV
LABELV $224
line 707
;704:	}
;705:
;706:// general case
;707:	switch (p->signbits)
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 17
ADDP4
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $230
ADDRLP4 12
INDIRI4
CNSTI4 7
GTI4 $230
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $241
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $241
address $233
address $234
address $235
address $236
address $237
address $238
address $239
address $240
code
line 708
;708:	{
LABELV $233
line 710
;709:	case 0:
;710:		dist1 = p->normal[0]*emaxs[0] + p->normal[1]*emaxs[1] + p->normal[2]*emaxs[2];
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
MULF4
ADDRLP4 20
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 20
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 711
;711:		dist2 = p->normal[0]*emins[0] + p->normal[1]*emins[1] + p->normal[2]*emins[2];
ADDRLP4 36
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 4
ASGNI4
ADDRLP4 48
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRF4
MULF4
ADDRLP4 36
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 712
;712:		break;
ADDRGP4 $231
JUMPV
LABELV $234
line 714
;713:	case 1:
;714:		dist1 = p->normal[0]*emins[0] + p->normal[1]*emaxs[1] + p->normal[2]*emaxs[2];
ADDRLP4 52
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 56
CNSTI4 4
ASGNI4
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
CNSTI4 8
ASGNI4
ADDRLP4 4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
MULF4
ADDRLP4 52
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 52
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 715
;715:		dist2 = p->normal[0]*emaxs[0] + p->normal[1]*emins[1] + p->normal[2]*emins[2];
ADDRLP4 68
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 72
CNSTI4 4
ASGNI4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 68
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
MULF4
ADDRLP4 68
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 68
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 716
;716:		break;
ADDRGP4 $231
JUMPV
LABELV $235
line 718
;717:	case 2:
;718:		dist1 = p->normal[0]*emaxs[0] + p->normal[1]*emins[1] + p->normal[2]*emaxs[2];
ADDRLP4 84
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 92
CNSTI4 4
ASGNI4
ADDRLP4 96
CNSTI4 8
ASGNI4
ADDRLP4 4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 88
INDIRP4
INDIRF4
MULF4
ADDRLP4 84
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 84
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 719
;719:		dist2 = p->normal[0]*emins[0] + p->normal[1]*emaxs[1] + p->normal[2]*emins[2];
ADDRLP4 100
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
CNSTI4 4
ASGNI4
ADDRLP4 112
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 104
INDIRP4
INDIRF4
MULF4
ADDRLP4 100
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 100
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 720
;720:		break;
ADDRGP4 $231
JUMPV
LABELV $236
line 722
;721:	case 3:
;722:		dist1 = p->normal[0]*emins[0] + p->normal[1]*emins[1] + p->normal[2]*emaxs[2];
ADDRLP4 116
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
CNSTI4 4
ASGNI4
ADDRLP4 128
CNSTI4 8
ASGNI4
ADDRLP4 4
ADDRLP4 116
INDIRP4
INDIRF4
ADDRLP4 120
INDIRP4
INDIRF4
MULF4
ADDRLP4 116
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRF4
ADDRLP4 120
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 116
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 723
;723:		dist2 = p->normal[0]*emaxs[0] + p->normal[1]*emaxs[1] + p->normal[2]*emins[2];
ADDRLP4 132
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 136
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 140
CNSTI4 4
ASGNI4
ADDRLP4 144
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 132
INDIRP4
INDIRF4
ADDRLP4 136
INDIRP4
INDIRF4
MULF4
ADDRLP4 132
INDIRP4
ADDRLP4 140
INDIRI4
ADDP4
INDIRF4
ADDRLP4 136
INDIRP4
ADDRLP4 140
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 132
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 724
;724:		break;
ADDRGP4 $231
JUMPV
LABELV $237
line 726
;725:	case 4:
;726:		dist1 = p->normal[0]*emaxs[0] + p->normal[1]*emaxs[1] + p->normal[2]*emins[2];
ADDRLP4 148
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 152
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 156
CNSTI4 4
ASGNI4
ADDRLP4 160
CNSTI4 8
ASGNI4
ADDRLP4 4
ADDRLP4 148
INDIRP4
INDIRF4
ADDRLP4 152
INDIRP4
INDIRF4
MULF4
ADDRLP4 148
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
INDIRF4
ADDRLP4 152
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 148
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 727
;727:		dist2 = p->normal[0]*emins[0] + p->normal[1]*emins[1] + p->normal[2]*emaxs[2];
ADDRLP4 164
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
CNSTI4 4
ASGNI4
ADDRLP4 176
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 164
INDIRP4
INDIRF4
ADDRLP4 168
INDIRP4
INDIRF4
MULF4
ADDRLP4 164
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
INDIRF4
ADDRLP4 168
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 164
INDIRP4
ADDRLP4 176
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 176
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 728
;728:		break;
ADDRGP4 $231
JUMPV
LABELV $238
line 730
;729:	case 5:
;730:		dist1 = p->normal[0]*emins[0] + p->normal[1]*emaxs[1] + p->normal[2]*emins[2];
ADDRLP4 180
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 188
CNSTI4 4
ASGNI4
ADDRLP4 192
CNSTI4 8
ASGNI4
ADDRLP4 4
ADDRLP4 180
INDIRP4
INDIRF4
ADDRLP4 184
INDIRP4
INDIRF4
MULF4
ADDRLP4 180
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 180
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRF4
ADDRLP4 184
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 731
;731:		dist2 = p->normal[0]*emaxs[0] + p->normal[1]*emins[1] + p->normal[2]*emaxs[2];
ADDRLP4 196
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 200
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 204
CNSTI4 4
ASGNI4
ADDRLP4 208
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 196
INDIRP4
INDIRF4
ADDRLP4 200
INDIRP4
INDIRF4
MULF4
ADDRLP4 196
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 196
INDIRP4
ADDRLP4 208
INDIRI4
ADDP4
INDIRF4
ADDRLP4 200
INDIRP4
ADDRLP4 208
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 732
;732:		break;
ADDRGP4 $231
JUMPV
LABELV $239
line 734
;733:	case 6:
;734:		dist1 = p->normal[0]*emaxs[0] + p->normal[1]*emins[1] + p->normal[2]*emins[2];
ADDRLP4 212
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 216
CNSTI4 4
ASGNI4
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 224
CNSTI4 8
ASGNI4
ADDRLP4 4
ADDRLP4 212
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
MULF4
ADDRLP4 212
INDIRP4
ADDRLP4 216
INDIRI4
ADDP4
INDIRF4
ADDRLP4 220
INDIRP4
ADDRLP4 216
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 212
INDIRP4
ADDRLP4 224
INDIRI4
ADDP4
INDIRF4
ADDRLP4 220
INDIRP4
ADDRLP4 224
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 735
;735:		dist2 = p->normal[0]*emins[0] + p->normal[1]*emaxs[1] + p->normal[2]*emaxs[2];
ADDRLP4 228
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 232
CNSTI4 4
ASGNI4
ADDRLP4 236
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 240
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 228
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
MULF4
ADDRLP4 228
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
INDIRF4
ADDRLP4 236
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 228
INDIRP4
ADDRLP4 240
INDIRI4
ADDP4
INDIRF4
ADDRLP4 236
INDIRP4
ADDRLP4 240
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 736
;736:		break;
ADDRGP4 $231
JUMPV
LABELV $240
line 738
;737:	case 7:
;738:		dist1 = p->normal[0]*emins[0] + p->normal[1]*emins[1] + p->normal[2]*emins[2];
ADDRLP4 244
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
CNSTI4 4
ASGNI4
ADDRLP4 256
CNSTI4 8
ASGNI4
ADDRLP4 4
ADDRLP4 244
INDIRP4
INDIRF4
ADDRLP4 248
INDIRP4
INDIRF4
MULF4
ADDRLP4 244
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
INDIRF4
ADDRLP4 248
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 244
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
INDIRF4
ADDRLP4 248
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 739
;739:		dist2 = p->normal[0]*emaxs[0] + p->normal[1]*emaxs[1] + p->normal[2]*emaxs[2];
ADDRLP4 260
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 264
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 268
CNSTI4 4
ASGNI4
ADDRLP4 272
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 260
INDIRP4
INDIRF4
ADDRLP4 264
INDIRP4
INDIRF4
MULF4
ADDRLP4 260
INDIRP4
ADDRLP4 268
INDIRI4
ADDP4
INDIRF4
ADDRLP4 264
INDIRP4
ADDRLP4 268
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 260
INDIRP4
ADDRLP4 272
INDIRI4
ADDP4
INDIRF4
ADDRLP4 264
INDIRP4
ADDRLP4 272
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 740
;740:		break;
ADDRGP4 $231
JUMPV
LABELV $230
line 742
;741:	default:
;742:		dist1 = dist2 = 0;		// shut up compiler
ADDRLP4 276
CNSTF4 0
ASGNF4
ADDRLP4 8
ADDRLP4 276
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 276
INDIRF4
ASGNF4
line 743
;743:		break;
LABELV $231
line 746
;744:	}
;745:
;746:	sides = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 747
;747:	if (dist1 >= p->dist)
ADDRLP4 4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
LTF4 $242
line 748
;748:		sides = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $242
line 749
;749:	if (dist2 < p->dist)
ADDRLP4 8
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
GEF4 $244
line 750
;750:		sides |= 2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $244
line 752
;751:
;752:	return sides;
ADDRLP4 0
INDIRI4
RETI4
LABELV $223
endproc BoxOnPlaneSide 280 0
export RadiusFromBounds
proc RadiusFromBounds 36 4
line 997
;753:}
;754:#elif __GNUC__
;755:// use matha.s
;756:#else
;757:#pragma warning( disable: 4035 )
;758:
;759:__declspec( naked ) int BoxOnPlaneSide (vec3_t emins, vec3_t emaxs, struct cplane_s *p)
;760:{
;761:	static int bops_initialized;
;762:	static int Ljmptab[8];
;763:
;764:	__asm {
;765:
;766:		push ebx
;767:			
;768:		cmp bops_initialized, 1
;769:		je  initialized
;770:		mov bops_initialized, 1
;771:		
;772:		mov Ljmptab[0*4], offset Lcase0
;773:		mov Ljmptab[1*4], offset Lcase1
;774:		mov Ljmptab[2*4], offset Lcase2
;775:		mov Ljmptab[3*4], offset Lcase3
;776:		mov Ljmptab[4*4], offset Lcase4
;777:		mov Ljmptab[5*4], offset Lcase5
;778:		mov Ljmptab[6*4], offset Lcase6
;779:		mov Ljmptab[7*4], offset Lcase7
;780:			
;781:initialized:
;782:
;783:		mov edx,dword ptr[4+12+esp]
;784:		mov ecx,dword ptr[4+4+esp]
;785:		xor eax,eax
;786:		mov ebx,dword ptr[4+8+esp]
;787:		mov al,byte ptr[17+edx]
;788:		cmp al,8
;789:		jge Lerror
;790:		fld dword ptr[0+edx]
;791:		fld st(0)
;792:		jmp dword ptr[Ljmptab+eax*4]
;793:Lcase0:
;794:		fmul dword ptr[ebx]
;795:		fld dword ptr[0+4+edx]
;796:		fxch st(2)
;797:		fmul dword ptr[ecx]
;798:		fxch st(2)
;799:		fld st(0)
;800:		fmul dword ptr[4+ebx]
;801:		fld dword ptr[0+8+edx]
;802:		fxch st(2)
;803:		fmul dword ptr[4+ecx]
;804:		fxch st(2)
;805:		fld st(0)
;806:		fmul dword ptr[8+ebx]
;807:		fxch st(5)
;808:		faddp st(3),st(0)
;809:		fmul dword ptr[8+ecx]
;810:		fxch st(1)
;811:		faddp st(3),st(0)
;812:		fxch st(3)
;813:		faddp st(2),st(0)
;814:		jmp LSetSides
;815:Lcase1:
;816:		fmul dword ptr[ecx]
;817:		fld dword ptr[0+4+edx]
;818:		fxch st(2)
;819:		fmul dword ptr[ebx]
;820:		fxch st(2)
;821:		fld st(0)
;822:		fmul dword ptr[4+ebx]
;823:		fld dword ptr[0+8+edx]
;824:		fxch st(2)
;825:		fmul dword ptr[4+ecx]
;826:		fxch st(2)
;827:		fld st(0)
;828:		fmul dword ptr[8+ebx]
;829:		fxch st(5)
;830:		faddp st(3),st(0)
;831:		fmul dword ptr[8+ecx]
;832:		fxch st(1)
;833:		faddp st(3),st(0)
;834:		fxch st(3)
;835:		faddp st(2),st(0)
;836:		jmp LSetSides
;837:Lcase2:
;838:		fmul dword ptr[ebx]
;839:		fld dword ptr[0+4+edx]
;840:		fxch st(2)
;841:		fmul dword ptr[ecx]
;842:		fxch st(2)
;843:		fld st(0)
;844:		fmul dword ptr[4+ecx]
;845:		fld dword ptr[0+8+edx]
;846:		fxch st(2)
;847:		fmul dword ptr[4+ebx]
;848:		fxch st(2)
;849:		fld st(0)
;850:		fmul dword ptr[8+ebx]
;851:		fxch st(5)
;852:		faddp st(3),st(0)
;853:		fmul dword ptr[8+ecx]
;854:		fxch st(1)
;855:		faddp st(3),st(0)
;856:		fxch st(3)
;857:		faddp st(2),st(0)
;858:		jmp LSetSides
;859:Lcase3:
;860:		fmul dword ptr[ecx]
;861:		fld dword ptr[0+4+edx]
;862:		fxch st(2)
;863:		fmul dword ptr[ebx]
;864:		fxch st(2)
;865:		fld st(0)
;866:		fmul dword ptr[4+ecx]
;867:		fld dword ptr[0+8+edx]
;868:		fxch st(2)
;869:		fmul dword ptr[4+ebx]
;870:		fxch st(2)
;871:		fld st(0)
;872:		fmul dword ptr[8+ebx]
;873:		fxch st(5)
;874:		faddp st(3),st(0)
;875:		fmul dword ptr[8+ecx]
;876:		fxch st(1)
;877:		faddp st(3),st(0)
;878:		fxch st(3)
;879:		faddp st(2),st(0)
;880:		jmp LSetSides
;881:Lcase4:
;882:		fmul dword ptr[ebx]
;883:		fld dword ptr[0+4+edx]
;884:		fxch st(2)
;885:		fmul dword ptr[ecx]
;886:		fxch st(2)
;887:		fld st(0)
;888:		fmul dword ptr[4+ebx]
;889:		fld dword ptr[0+8+edx]
;890:		fxch st(2)
;891:		fmul dword ptr[4+ecx]
;892:		fxch st(2)
;893:		fld st(0)
;894:		fmul dword ptr[8+ecx]
;895:		fxch st(5)
;896:		faddp st(3),st(0)
;897:		fmul dword ptr[8+ebx]
;898:		fxch st(1)
;899:		faddp st(3),st(0)
;900:		fxch st(3)
;901:		faddp st(2),st(0)
;902:		jmp LSetSides
;903:Lcase5:
;904:		fmul dword ptr[ecx]
;905:		fld dword ptr[0+4+edx]
;906:		fxch st(2)
;907:		fmul dword ptr[ebx]
;908:		fxch st(2)
;909:		fld st(0)
;910:		fmul dword ptr[4+ebx]
;911:		fld dword ptr[0+8+edx]
;912:		fxch st(2)
;913:		fmul dword ptr[4+ecx]
;914:		fxch st(2)
;915:		fld st(0)
;916:		fmul dword ptr[8+ecx]
;917:		fxch st(5)
;918:		faddp st(3),st(0)
;919:		fmul dword ptr[8+ebx]
;920:		fxch st(1)
;921:		faddp st(3),st(0)
;922:		fxch st(3)
;923:		faddp st(2),st(0)
;924:		jmp LSetSides
;925:Lcase6:
;926:		fmul dword ptr[ebx]
;927:		fld dword ptr[0+4+edx]
;928:		fxch st(2)
;929:		fmul dword ptr[ecx]
;930:		fxch st(2)
;931:		fld st(0)
;932:		fmul dword ptr[4+ecx]
;933:		fld dword ptr[0+8+edx]
;934:		fxch st(2)
;935:		fmul dword ptr[4+ebx]
;936:		fxch st(2)
;937:		fld st(0)
;938:		fmul dword ptr[8+ecx]
;939:		fxch st(5)
;940:		faddp st(3),st(0)
;941:		fmul dword ptr[8+ebx]
;942:		fxch st(1)
;943:		faddp st(3),st(0)
;944:		fxch st(3)
;945:		faddp st(2),st(0)
;946:		jmp LSetSides
;947:Lcase7:
;948:		fmul dword ptr[ecx]
;949:		fld dword ptr[0+4+edx]
;950:		fxch st(2)
;951:		fmul dword ptr[ebx]
;952:		fxch st(2)
;953:		fld st(0)
;954:		fmul dword ptr[4+ecx]
;955:		fld dword ptr[0+8+edx]
;956:		fxch st(2)
;957:		fmul dword ptr[4+ebx]
;958:		fxch st(2)
;959:		fld st(0)
;960:		fmul dword ptr[8+ecx]
;961:		fxch st(5)
;962:		faddp st(3),st(0)
;963:		fmul dword ptr[8+ebx]
;964:		fxch st(1)
;965:		faddp st(3),st(0)
;966:		fxch st(3)
;967:		faddp st(2),st(0)
;968:LSetSides:
;969:		faddp st(2),st(0)
;970:		fcomp dword ptr[12+edx]
;971:		xor ecx,ecx
;972:		fnstsw ax
;973:		fcomp dword ptr[12+edx]
;974:		and ah,1
;975:		xor ah,1
;976:		add cl,ah
;977:		fnstsw ax
;978:		and ah,1
;979:		add ah,ah
;980:		add cl,ah
;981:		pop ebx
;982:		mov eax,ecx
;983:		ret
;984:Lerror:
;985:		int 3
;986:	}
;987:}
;988:#pragma warning( default: 4035 )
;989:
;990:#endif
;991:
;992:/*
;993:=================
;994:RadiusFromBounds
;995:=================
;996:*/
;997:float RadiusFromBounds( const vec3_t mins, const vec3_t maxs ) {
line 1002
;998:	int		i;
;999:	vec3_t	corner;
;1000:	float	a, b;
;1001:
;1002:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $247
line 1003
;1003:		a = fabs( mins[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 1004
;1004:		b = fabs( maxs[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 28
INDIRF4
ASGNF4
line 1005
;1005:		corner[i] = a > b ? a : b;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $252
ADDRLP4 32
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $253
JUMPV
LABELV $252
ADDRLP4 32
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $253
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 1006
;1006:	}
LABELV $248
line 1002
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $247
line 1008
;1007:
;1008:	return VectorLength (corner);
ADDRLP4 12
ARGP4
ADDRLP4 24
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
RETF4
LABELV $246
endproc RadiusFromBounds 36 4
export ClearBounds
proc ClearBounds 16 0
line 1012
;1009:}
;1010:
;1011:
;1012:void ClearBounds( vec3_t mins, vec3_t maxs ) {
line 1013
;1013:	mins[0] = mins[1] = mins[2] = 99999;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 1203982208
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1014
;1014:	maxs[0] = maxs[1] = maxs[2] = -99999;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 3351465856
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 1015
;1015:}
LABELV $254
endproc ClearBounds 16 0
export AddPointToBounds
proc AddPointToBounds 20 0
line 1017
;1016:
;1017:void AddPointToBounds( const vec3_t v, vec3_t mins, vec3_t maxs ) {
line 1018
;1018:	if ( v[0] < mins[0] ) {
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
GEF4 $256
line 1019
;1019:		mins[0] = v[0];
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1020
;1020:	}
LABELV $256
line 1021
;1021:	if ( v[0] > maxs[0]) {
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
LEF4 $258
line 1022
;1022:		maxs[0] = v[0];
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1023
;1023:	}
LABELV $258
line 1025
;1024:
;1025:	if ( v[1] < mins[1] ) {
ADDRLP4 0
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
GEF4 $260
line 1026
;1026:		mins[1] = v[1];
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1027
;1027:	}
LABELV $260
line 1028
;1028:	if ( v[1] > maxs[1]) {
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
LEF4 $262
line 1029
;1029:		maxs[1] = v[1];
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1030
;1030:	}
LABELV $262
line 1032
;1031:
;1032:	if ( v[2] < mins[2] ) {
ADDRLP4 8
CNSTI4 8
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
GEF4 $264
line 1033
;1033:		mins[2] = v[2];
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1034
;1034:	}
LABELV $264
line 1035
;1035:	if ( v[2] > maxs[2]) {
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
LEF4 $266
line 1036
;1036:		maxs[2] = v[2];
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1037
;1037:	}
LABELV $266
line 1038
;1038:}
LABELV $255
endproc AddPointToBounds 20 0
export BoundsIntersect
proc BoundsIntersect 24 0
line 1042
;1039:
;1040:qboolean BoundsIntersect(const vec3_t mins, const vec3_t maxs,
;1041:		const vec3_t mins2, const vec3_t maxs2)
;1042:{
line 1043
;1043:	if ( maxs[0] < mins2[0] ||
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
LTF4 $275
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
LTF4 $275
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
LTF4 $275
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
GTF4 $275
ADDRLP4 16
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
GTF4 $275
ADDRLP4 16
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
LEF4 $269
LABELV $275
line 1049
;1044:		maxs[1] < mins2[1] ||
;1045:		maxs[2] < mins2[2] ||
;1046:		mins[0] > maxs2[0] ||
;1047:		mins[1] > maxs2[1] ||
;1048:		mins[2] > maxs2[2])
;1049:	{
line 1050
;1050:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $268
JUMPV
LABELV $269
line 1053
;1051:	}
;1052:
;1053:	return qtrue;
CNSTI4 1
RETI4
LABELV $268
endproc BoundsIntersect 24 0
export BoundsIntersectSphere
proc BoundsIntersectSphere 36 0
line 1058
;1054:}
;1055:
;1056:qboolean BoundsIntersectSphere(const vec3_t mins, const vec3_t maxs,
;1057:		const vec3_t origin, vec_t radius)
;1058:{
line 1059
;1059:	if ( origin[0] - radius > maxs[0] ||
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 8
ADDRFP4 12
INDIRF4
ASGNF4
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ADDRLP4 12
INDIRP4
INDIRF4
GTF4 $283
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ADDRLP4 16
INDIRP4
INDIRF4
LTF4 $283
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 24
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
GTF4 $283
ADDRLP4 24
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
LTF4 $283
ADDRLP4 28
CNSTI4 8
ASGNI4
ADDRLP4 32
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ADDRLP4 12
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
GTF4 $283
ADDRLP4 32
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ADDRLP4 16
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
GEF4 $277
LABELV $283
line 1065
;1060:		origin[0] + radius < mins[0] ||
;1061:		origin[1] - radius > maxs[1] ||
;1062:		origin[1] + radius < mins[1] ||
;1063:		origin[2] - radius > maxs[2] ||
;1064:		origin[2] + radius < mins[2])
;1065:	{
line 1066
;1066:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $276
JUMPV
LABELV $277
line 1069
;1067:	}
;1068:
;1069:	return qtrue;
CNSTI4 1
RETI4
LABELV $276
endproc BoundsIntersectSphere 36 0
export BoundsIntersectPoint
proc BoundsIntersectPoint 32 0
line 1074
;1070:}
;1071:
;1072:qboolean BoundsIntersectPoint(const vec3_t mins, const vec3_t maxs,
;1073:		const vec3_t origin)
;1074:{
line 1075
;1075:	if ( origin[0] > maxs[0] ||
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRP4
INDIRF4
GTF4 $291
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRP4
INDIRF4
LTF4 $291
ADDRLP4 16
CNSTI4 4
ASGNI4
ADDRLP4 20
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
GTF4 $291
ADDRLP4 20
INDIRF4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
LTF4 $291
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 28
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
GTF4 $291
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
GEF4 $285
LABELV $291
line 1081
;1076:		origin[0] < mins[0] ||
;1077:		origin[1] > maxs[1] ||
;1078:		origin[1] < mins[1] ||
;1079:		origin[2] > maxs[2] ||
;1080:		origin[2] < mins[2])
;1081:	{
line 1082
;1082:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $285
line 1085
;1083:	}
;1084:
;1085:	return qtrue;
CNSTI4 1
RETI4
LABELV $284
endproc BoundsIntersectPoint 32 0
export VectorNormalize
proc VectorNormalize 40 4
line 1088
;1086:}
;1087:
;1088:vec_t VectorNormalize( vec3_t v ) {
line 1092
;1089:	// NOTE: TTimo - Apple G4 altivec source uses double?
;1090:	float	length, ilength;
;1091:
;1092:	length = v[0]*v[0] + v[1]*v[1] + v[2]*v[2];
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDRLP4 16
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 1093
;1093:	length = sqrt (length);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ASGNF4
line 1095
;1094:
;1095:	if ( length ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $293
line 1096
;1096:		ilength = 1/length;
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
DIVF4
ASGNF4
line 1097
;1097:		v[0] *= ilength;
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1098
;1098:		v[1] *= ilength;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1099
;1099:		v[2] *= ilength;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1100
;1100:	}
LABELV $293
line 1102
;1101:		
;1102:	return length;
ADDRLP4 0
INDIRF4
RETF4
LABELV $292
endproc VectorNormalize 40 4
export VectorNormalize2
proc VectorNormalize2 36 4
line 1105
;1103:}
;1104:
;1105:vec_t VectorNormalize2( const vec3_t v, vec3_t out) {
line 1108
;1106:	float	length, ilength;
;1107:
;1108:	length = v[0]*v[0] + v[1]*v[1] + v[2]*v[2];
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDRLP4 16
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 1109
;1109:	length = sqrt (length);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ASGNF4
line 1111
;1110:
;1111:	if (length)
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $296
line 1112
;1112:	{
line 1113
;1113:		ilength = 1/length;
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
DIVF4
ASGNF4
line 1114
;1114:		out[0] = v[0]*ilength;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1115
;1115:		out[1] = v[1]*ilength;
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1116
;1116:		out[2] = v[2]*ilength;
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1117
;1117:	} else {
ADDRGP4 $297
JUMPV
LABELV $296
line 1118
;1118:		VectorClear( out );
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
CNSTF4 0
ASGNF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRF4
ASGNF4
line 1119
;1119:	}
LABELV $297
line 1121
;1120:		
;1121:	return length;
ADDRLP4 0
INDIRF4
RETF4
LABELV $295
endproc VectorNormalize2 36 4
export _VectorMA
proc _VectorMA 8 0
line 1125
;1122:
;1123:}
;1124:
;1125:void _VectorMA( const vec3_t veca, float scale, const vec3_t vecb, vec3_t vecc) {
line 1126
;1126:	vecc[0] = veca[0] + scale*vecb[0];
ADDRFP4 12
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1127
;1127:	vecc[1] = veca[1] + scale*vecb[1];
ADDRLP4 0
CNSTI4 4
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1128
;1128:	vecc[2] = veca[2] + scale*vecb[2];
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1129
;1129:}
LABELV $298
endproc _VectorMA 8 0
export _DotProduct
proc _DotProduct 16 0
line 1132
;1130:
;1131:
;1132:vec_t _DotProduct( const vec3_t v1, const vec3_t v2 ) {
line 1133
;1133:	return v1[0]*v2[0] + v1[1]*v2[1] + v1[2]*v2[2];
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
RETF4
LABELV $299
endproc _DotProduct 16 0
export _VectorSubtract
proc _VectorSubtract 8 0
line 1136
;1134:}
;1135:
;1136:void _VectorSubtract( const vec3_t veca, const vec3_t vecb, vec3_t out ) {
line 1137
;1137:	out[0] = veca[0]-vecb[0];
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 1138
;1138:	out[1] = veca[1]-vecb[1];
ADDRLP4 0
CNSTI4 4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1139
;1139:	out[2] = veca[2]-vecb[2];
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1140
;1140:}
LABELV $300
endproc _VectorSubtract 8 0
export _VectorAdd
proc _VectorAdd 8 0
line 1142
;1141:
;1142:void _VectorAdd( const vec3_t veca, const vec3_t vecb, vec3_t out ) {
line 1143
;1143:	out[0] = veca[0]+vecb[0];
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 1144
;1144:	out[1] = veca[1]+vecb[1];
ADDRLP4 0
CNSTI4 4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1145
;1145:	out[2] = veca[2]+vecb[2];
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1146
;1146:}
LABELV $301
endproc _VectorAdd 8 0
export _VectorCopy
proc _VectorCopy 8 0
line 1148
;1147:
;1148:void _VectorCopy( const vec3_t in, vec3_t out ) {
line 1149
;1149:	out[0] = in[0];
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1150
;1150:	out[1] = in[1];
ADDRLP4 0
CNSTI4 4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1151
;1151:	out[2] = in[2];
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1152
;1152:}
LABELV $302
endproc _VectorCopy 8 0
export _VectorScale
proc _VectorScale 8 0
line 1154
;1153:
;1154:void _VectorScale( const vec3_t in, vec_t scale, vec3_t out ) {
line 1155
;1155:	out[0] = in[0]*scale;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 1156
;1156:	out[1] = in[1]*scale;
ADDRLP4 0
CNSTI4 4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 1157
;1157:	out[2] = in[2]*scale;
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 1158
;1158:}
LABELV $303
endproc _VectorScale 8 0
export Vector4Scale
proc Vector4Scale 12 0
line 1160
;1159:
;1160:void Vector4Scale( const vec4_t in, vec_t scale, vec4_t out ) {
line 1161
;1161:	out[0] = in[0]*scale;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 1162
;1162:	out[1] = in[1]*scale;
ADDRLP4 0
CNSTI4 4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 1163
;1163:	out[2] = in[2]*scale;
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 1164
;1164:	out[3] = in[3]*scale;
ADDRLP4 8
CNSTI4 12
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 1165
;1165:}
LABELV $304
endproc Vector4Scale 12 0
export Q_log2
proc Q_log2 8 0
line 1168
;1166:
;1167:
;1168:int Q_log2( int val ) {
line 1171
;1169:	int answer;
;1170:
;1171:	answer = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $307
JUMPV
LABELV $306
line 1172
;1172:	while ( ( val>>=1 ) != 0 ) {
line 1173
;1173:		answer++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1174
;1174:	}
LABELV $307
line 1172
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 1
RSHI4
ASGNI4
ADDRFP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $306
line 1175
;1175:	return answer;
ADDRLP4 0
INDIRI4
RETI4
LABELV $305
endproc Q_log2 8 0
export MatrixMultiply
proc MatrixMultiply 104 0
line 1204
;1176:}
;1177:
;1178:
;1179:
;1180:/*
;1181:=================
;1182:PlaneTypeForNormal
;1183:=================
;1184:*/
;1185:/*
;1186:int	PlaneTypeForNormal (vec3_t normal) {
;1187:	if ( normal[0] == 1.0 )
;1188:		return PLANE_X;
;1189:	if ( normal[1] == 1.0 )
;1190:		return PLANE_Y;
;1191:	if ( normal[2] == 1.0 )
;1192:		return PLANE_Z;
;1193:	
;1194:	return PLANE_NON_AXIAL;
;1195:}
;1196:*/
;1197:
;1198:
;1199:/*
;1200:================
;1201:MatrixMultiply
;1202:================
;1203:*/
;1204:void MatrixMultiply(float in1[3][3], float in2[3][3], float out[3][3]) {
line 1205
;1205:	out[0][0] = in1[0][0] * in2[0][0] + in1[0][1] * in2[1][0] +
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1207
;1206:				in1[0][2] * in2[2][0];
;1207:	out[0][1] = in1[0][0] * in2[0][1] + in1[0][1] * in2[1][1] +
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1209
;1208:				in1[0][2] * in2[2][1];
;1209:	out[0][2] = in1[0][0] * in2[0][2] + in1[0][1] * in2[1][2] +
ADDRLP4 20
CNSTI4 8
ASGNI4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
MULF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1211
;1210:				in1[0][2] * in2[2][2];
;1211:	out[1][0] = in1[1][0] * in2[0][0] + in1[1][1] * in2[1][0] +
ADDRLP4 32
CNSTI4 12
ASGNI4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRLP4 36
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRF4
MULF4
ADDRLP4 36
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 36
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1213
;1212:				in1[1][2] * in2[2][0];
;1213:	out[1][1] = in1[1][0] * in2[0][1] + in1[1][1] * in2[1][1] +
ADDRLP4 44
CNSTI4 16
ASGNI4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1215
;1214:				in1[1][2] * in2[2][1];
;1215:	out[1][2] = in1[1][0] * in2[0][2] + in1[1][1] * in2[1][2] +
ADDRLP4 56
CNSTI4 20
ASGNI4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDRLP4 60
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 60
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1217
;1216:				in1[1][2] * in2[2][2];
;1217:	out[2][0] = in1[2][0] * in2[0][0] + in1[2][1] * in2[1][0] +
ADDRLP4 68
CNSTI4 24
ASGNI4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
ADDRLP4 72
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
INDIRF4
MULF4
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1219
;1218:				in1[2][2] * in2[2][0];
;1219:	out[2][1] = in1[2][0] * in2[0][1] + in1[2][1] * in2[1][1] +
ADDRLP4 80
CNSTI4 28
ASGNI4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 84
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 84
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1221
;1220:				in1[2][2] * in2[2][1];
;1221:	out[2][2] = in1[2][0] * in2[0][2] + in1[2][1] * in2[1][2] +
ADDRLP4 92
CNSTI4 32
ASGNI4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
ADDRLP4 96
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDRLP4 96
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 96
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRLP4 100
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1223
;1222:				in1[2][2] * in2[2][2];
;1223:}
LABELV $309
endproc MatrixMultiply 104 0
bss
align 4
LABELV $311
skip 4
align 4
LABELV $312
skip 4
align 4
LABELV $313
skip 4
align 4
LABELV $314
skip 4
align 4
LABELV $315
skip 4
align 4
LABELV $316
skip 4
export AngleVectors
code
proc AngleVectors 36 4
line 1226
;1224:
;1225:
;1226:void AngleVectors( const vec3_t angles, vec3_t forward, vec3_t right, vec3_t up) {
line 1231
;1227:	float		angle;
;1228:	static float		sr, sp, sy, cr, cp, cy;
;1229:	// static to help MS compiler fp bugs
;1230:
;1231:	angle = angles[YAW] * (M_PI*2 / 360);
ADDRLP4 0
CNSTF4 1016003125
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
line 1232
;1232:	sy = sin(angle);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 sin
CALLF4
ASGNF4
ADDRGP4 $313
ADDRLP4 4
INDIRF4
ASGNF4
line 1233
;1233:	cy = cos(angle);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 $316
ADDRLP4 8
INDIRF4
ASGNF4
line 1234
;1234:	angle = angles[PITCH] * (M_PI*2 / 360);
ADDRLP4 0
CNSTF4 1016003125
ADDRFP4 0
INDIRP4
INDIRF4
MULF4
ASGNF4
line 1235
;1235:	sp = sin(angle);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 sin
CALLF4
ASGNF4
ADDRGP4 $312
ADDRLP4 12
INDIRF4
ASGNF4
line 1236
;1236:	cp = cos(angle);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 $315
ADDRLP4 16
INDIRF4
ASGNF4
line 1237
;1237:	angle = angles[ROLL] * (M_PI*2 / 360);
ADDRLP4 0
CNSTF4 1016003125
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 1238
;1238:	sr = sin(angle);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 sin
CALLF4
ASGNF4
ADDRGP4 $311
ADDRLP4 20
INDIRF4
ASGNF4
line 1239
;1239:	cr = cos(angle);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 $314
ADDRLP4 24
INDIRF4
ASGNF4
line 1241
;1240:
;1241:	if (forward)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $317
line 1242
;1242:	{
line 1243
;1243:		forward[0] = cp*cy;
ADDRFP4 4
INDIRP4
ADDRGP4 $315
INDIRF4
ADDRGP4 $316
INDIRF4
MULF4
ASGNF4
line 1244
;1244:		forward[1] = cp*sy;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 $315
INDIRF4
ADDRGP4 $313
INDIRF4
MULF4
ASGNF4
line 1245
;1245:		forward[2] = -sp;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 $312
INDIRF4
NEGF4
ASGNF4
line 1246
;1246:	}
LABELV $317
line 1247
;1247:	if (right)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $319
line 1248
;1248:	{
line 1249
;1249:		right[0] = (-1*sr*sp*cy+-1*cr*-sy);
ADDRLP4 28
CNSTF4 3212836864
ASGNF4
ADDRFP4 8
INDIRP4
ADDRLP4 28
INDIRF4
ADDRGP4 $311
INDIRF4
MULF4
ADDRGP4 $312
INDIRF4
MULF4
ADDRGP4 $316
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
ADDRGP4 $314
INDIRF4
MULF4
ADDRGP4 $313
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 1250
;1250:		right[1] = (-1*sr*sp*sy+-1*cr*cy);
ADDRLP4 32
CNSTF4 3212836864
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 32
INDIRF4
ADDRGP4 $311
INDIRF4
MULF4
ADDRGP4 $312
INDIRF4
MULF4
ADDRGP4 $313
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
ADDRGP4 $314
INDIRF4
MULF4
ADDRGP4 $316
INDIRF4
MULF4
ADDF4
ASGNF4
line 1251
;1251:		right[2] = -1*sr*cp;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 3212836864
ADDRGP4 $311
INDIRF4
MULF4
ADDRGP4 $315
INDIRF4
MULF4
ASGNF4
line 1252
;1252:	}
LABELV $319
line 1253
;1253:	if (up)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $321
line 1254
;1254:	{
line 1255
;1255:		up[0] = (cr*sp*cy+-sr*-sy);
ADDRFP4 12
INDIRP4
ADDRGP4 $314
INDIRF4
ADDRGP4 $312
INDIRF4
MULF4
ADDRGP4 $316
INDIRF4
MULF4
ADDRGP4 $311
INDIRF4
NEGF4
ADDRGP4 $313
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 1256
;1256:		up[1] = (cr*sp*sy+-sr*cy);
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 $314
INDIRF4
ADDRGP4 $312
INDIRF4
MULF4
ADDRGP4 $313
INDIRF4
MULF4
ADDRGP4 $311
INDIRF4
NEGF4
ADDRGP4 $316
INDIRF4
MULF4
ADDF4
ASGNF4
line 1257
;1257:		up[2] = cr*cp;
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 $314
INDIRF4
ADDRGP4 $315
INDIRF4
MULF4
ASGNF4
line 1258
;1258:	}
LABELV $321
line 1259
;1259:}
LABELV $310
endproc AngleVectors 36 4
export PerpendicularVector
proc PerpendicularVector 36 12
line 1265
;1260:
;1261:/*
;1262:** assumes "src" is normalized
;1263:*/
;1264:void PerpendicularVector( vec3_t dst, const vec3_t src )
;1265:{
line 1268
;1266:	int	pos;
;1267:	int i;
;1268:	float minelem = 1.0F;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1274
;1269:	vec3_t tempvec;
;1270:
;1271:	/*
;1272:	** find the smallest magnitude axially aligned vector
;1273:	*/
;1274:	for ( pos = 0, i = 0; i < 3; i++ )
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
ADDRGP4 $327
JUMPV
LABELV $324
line 1275
;1275:	{
line 1276
;1276:		if ( fabs( src[i] ) < minelem )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $328
line 1277
;1277:		{
line 1278
;1278:			pos = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 1279
;1279:			minelem = fabs( src[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 32
INDIRF4
ASGNF4
line 1280
;1280:		}
LABELV $328
line 1281
;1281:	}
LABELV $325
line 1274
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $327
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $324
line 1282
;1282:	tempvec[0] = tempvec[1] = tempvec[2] = 0.0F;
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ASGNF4
line 1283
;1283:	tempvec[pos] = 1.0F;
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 1288
;1284:
;1285:	/*
;1286:	** project the point onto the plane defined by src
;1287:	*/
;1288:	ProjectPointOnPlane( dst, tempvec, src );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ProjectPointOnPlane
CALLV
pop
line 1293
;1289:
;1290:	/*
;1291:	** normalize the result
;1292:	*/
;1293:	VectorNormalize( dst );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1294
;1294:}
LABELV $323
endproc PerpendicularVector 36 12
export Q_isnan
proc Q_isnan 4 0
line 1304
;1295:
;1296:/*
;1297:================
;1298:Q_isnan
;1299:
;1300:Don't pass doubles to this
;1301:================
;1302:*/
;1303:int Q_isnan( float x )
;1304:{
line 1311
;1305:	union
;1306:	{
;1307:		float f;
;1308:		unsigned int i;
;1309:	} t;
;1310:
;1311:	t.f = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
line 1312
;1312:	t.i &= 0x7FFFFFFF;
ADDRLP4 0
ADDRLP4 0
INDIRU4
CNSTU4 2147483647
BANDU4
ASGNU4
line 1313
;1313:	t.i = 0x7F800000 - t.i;
ADDRLP4 0
CNSTU4 2139095040
ADDRLP4 0
INDIRU4
SUBU4
ASGNU4
line 1315
;1314:
;1315:	return (int)( (unsigned int)t.i >> 31 );
ADDRLP4 0
INDIRU4
CNSTI4 31
RSHU4
CVUI4 4
RETI4
LABELV $332
endproc Q_isnan 4 0
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
import Q_acos
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
