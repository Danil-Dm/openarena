export G_SayArgc
code
proc G_SayArgc 16 4
file "../../../code/game/g_cmds_ext.c"
line 38
;1:/*
;2:===========================================================================
;3:Copyright (C) 2004-2006 Tony J. White
;4:
;5:This file is part of the Open Arena source code.
;6:
;7:Copied from Tremulous under GPL version 2 including any later version.
;8:
;9:Open Arena source code is free software; you can redistribute it
;10:and/or modify it under the terms of the GNU General Public License as
;11:published by the Free Software Foundation; either version 2 of the License,
;12:or (at your option) any later version.
;13:
;14:Open Arena source code is distributed in the hope that it will be
;15:useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;16:MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;17:GNU General Public License for more details.
;18:
;19:You should have received a copy of the GNU General Public License
;20:along with Open Arena source code; if not, write to the Free Software
;21:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;22:===========================================================================
;23:*/
;24:
;25:#include  "g_local.h"
;26:
;27:/*
;28:=================
;29:G_SayArgc
;30:G_SayArgv
;31:G_SayConcatArgs
;32:
;33:trap_Argc, trap_Argv, and ConcatArgs consider say text as a single argument
;34:These functions assemble the text and re-parse it on word boundaries
;35:=================
;36:*/
;37:int G_SayArgc( void )
;38:{
line 39
;39:	int c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 42
;40:	char *s;
;41:
;42:	s = ConcatArgs( 0 );
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $62
JUMPV
line 43
;43:	while( 1 ) {
LABELV $64
line 45
;44:		while( *s == ' ' )
;45:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $65
line 44
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $64
line 46
;46:		if( !*s )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $67
line 47
;47:			break;
ADDRGP4 $63
JUMPV
LABELV $67
line 48
;48:		c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $70
JUMPV
LABELV $69
line 50
;49:		while( *s && *s != ' ' )
;50:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $70
line 49
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $72
ADDRLP4 12
INDIRI4
CNSTI4 32
NEI4 $69
LABELV $72
line 51
;51:	}
LABELV $62
line 43
ADDRGP4 $65
JUMPV
LABELV $63
line 52
;52:	return c;
ADDRLP4 4
INDIRI4
RETI4
LABELV $60
endproc G_SayArgc 16 4
export G_SayArgv
proc G_SayArgv 20 4
line 56
;53:}
;54:
;55:qboolean G_SayArgv( int n, char *buffer, int bufferLength )
;56:{
line 59
;57:	char *s;
;58:
;59:	if( bufferLength < 1 )
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $74
line 60
;60:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $73
JUMPV
LABELV $74
line 61
;61:	if( n < 0 )
ADDRFP4 0
INDIRI4
CNSTI4 0
GEI4 $76
line 62
;62:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $73
JUMPV
LABELV $76
line 63
;63:	s = ConcatArgs( 0 );
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $79
JUMPV
line 64
;64:	while( 1 ) {
LABELV $81
line 66
;65:		while( *s == ' ' )
;66:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $82
line 65
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $81
line 67
;67:		if( !*s || n == 0 )
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
EQI4 $86
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $84
LABELV $86
line 68
;68:			break;
ADDRGP4 $80
JUMPV
LABELV $84
line 69
;69:		n--;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $88
JUMPV
LABELV $87
line 71
;70:		while( *s && *s != ' ' )
;71:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $88
line 70
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $90
ADDRLP4 12
INDIRI4
CNSTI4 32
NEI4 $87
LABELV $90
line 72
;72:	}
LABELV $79
line 64
ADDRGP4 $82
JUMPV
LABELV $80
line 73
;73:	if( n > 0 )
ADDRFP4 0
INDIRI4
CNSTI4 0
LEI4 $94
line 74
;74:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $73
JUMPV
LABELV $93
line 76
;75:	//memccpy( buffer, s, ' ', bufferLength );
;76:	while( *s && *s != ' ' && bufferLength > 1 ) {
line 77
;77:		*buffer++ = *s++;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRFP4 4
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
line 78
;78:		bufferLength--;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 79
;79:	}
LABELV $94
line 76
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $97
ADDRLP4 8
INDIRI4
CNSTI4 32
EQI4 $97
ADDRFP4 8
INDIRI4
CNSTI4 1
GTI4 $93
LABELV $97
line 80
;80:	*buffer = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 81
;81:	return qtrue;
CNSTI4 1
RETI4
LABELV $73
endproc G_SayArgv 20 4
export G_SayConcatArgs
proc G_SayConcatArgs 16 4
line 85
;82:}
;83:
;84:char *G_SayConcatArgs( int start )
;85:{
line 88
;86:	char *s;
;87:
;88:	s = ConcatArgs( 0 );
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $100
JUMPV
line 89
;89:	while( 1 ) {
LABELV $102
line 91
;90:		while( *s == ' ' )
;91:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $103
line 90
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $102
line 92
;92:		if( !*s || start == 0 )
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
EQI4 $107
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $105
LABELV $107
line 93
;93:			break;
ADDRGP4 $101
JUMPV
LABELV $105
line 94
;94:		start--;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $109
JUMPV
LABELV $108
line 96
;95:		while( *s && *s != ' ' )
;96:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $109
line 95
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $111
ADDRLP4 12
INDIRI4
CNSTI4 32
NEI4 $108
LABELV $111
line 97
;97:	}
LABELV $100
line 89
ADDRGP4 $103
JUMPV
LABELV $101
line 98
;98:	return s;
ADDRLP4 0
INDIRP4
RETP4
LABELV $98
endproc G_SayConcatArgs 16 4
export G_DecolorString
proc G_DecolorString 20 0
line 102
;99:}
;100:
;101:void G_DecolorString( char *in, char *out, int len )
;102:{
line 103
;103:	len--;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $114
JUMPV
LABELV $113
line 105
;104:
;105:	while( *in && len > 0 ) {
line 106
;106:		if( Q_IsColorString( in ) ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $116
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $116
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $116
ADDRLP4 4
INDIRI4
CNSTI4 48
LTI4 $116
ADDRLP4 4
INDIRI4
CNSTI4 56
GTI4 $116
line 107
;107:			in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 108
;108:			if( *in )
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $114
line 109
;109:				in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 110
;110:			continue;
ADDRGP4 $114
JUMPV
LABELV $116
line 112
;111:		}
;112:		*out++ = *in++;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRFP4 4
ADDRLP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
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
line 113
;113:		len--;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 114
;114:	}
LABELV $114
line 105
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 0
INDIRI4
EQI4 $120
ADDRFP4 8
INDIRI4
ADDRLP4 0
INDIRI4
GTI4 $113
LABELV $120
line 115
;115:	*out = '\0';
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 116
;116:}
LABELV $112
endproc G_DecolorString 20 0
lit
align 1
LABELV $122
byte 1 0
skip 41
export G_MatchOnePlayer
code
proc G_MatchOnePlayer 60 20
line 128
;117:
;118:/*
;119:==================
;120:G_MatchOnePlayer
;121:
;122:This is a companion function to G_ClientNumbersFromString()
;123:
;124:err will be populated with an error message.
;125:==================
;126:*/
;127:void G_MatchOnePlayer( int *plist, int num, char *err, int len )
;128:{
line 131
;129:	gclient_t *cl;
;130:	int i;
;131:	char line[ MAX_NAME_LENGTH + 10 ] = {""};
ADDRLP4 0
ADDRGP4 $122
INDIRB
ASGNB 42
line 133
;132:
;133:	err[ 0 ] = '\0';
ADDRFP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 134
;134:	if( num == 0 ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $123
line 135
;135:		Q_strcat( err, len, "no connected player by that name or slot #" );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 $125
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 136
;136:	}
ADDRGP4 $124
JUMPV
LABELV $123
line 137
;137:	else if( num > 1 ) {
ADDRFP4 4
INDIRI4
CNSTI4 1
LEI4 $126
line 138
;138:		Q_strcat( err, len, "more than one player name matches. Be more specific or use the slot #:\n" );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 $128
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 139
;139:		for( i = 0; i < num; i++ ) {
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRGP4 $132
JUMPV
LABELV $129
line 140
;140:			cl = &level.clients[ plist[ i ] ];
ADDRLP4 48
CNSTI4 2116
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 141
;141:			if( cl->pers.connected == CON_DISCONNECTED )
ADDRLP4 48
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $133
line 142
;142:				continue;
ADDRGP4 $130
JUMPV
LABELV $133
line 143
;143:			Com_sprintf( line, sizeof( line ), "%2i - %s^7\n",
ADDRLP4 0
ARGP4
CNSTI4 42
ARGI4
ADDRGP4 $135
ARGP4
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 145
;144:			             plist[ i ], cl->pers.netname );
;145:			if( strlen( err ) + strlen( line ) > len )
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ARGP4
ADDRLP4 56
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
ADDI4
ADDRFP4 12
INDIRI4
LEI4 $136
line 146
;146:				break;
ADDRGP4 $131
JUMPV
LABELV $136
line 147
;147:			Q_strcat( err, len, line );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 148
;148:		}
LABELV $130
line 139
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $132
ADDRLP4 44
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $129
LABELV $131
line 149
;149:	}
LABELV $126
LABELV $124
line 150
;150:}
LABELV $121
endproc G_MatchOnePlayer 60 20
export G_SanitiseString
proc G_SanitiseString 32 4
line 160
;151:
;152:/*
;153:==================
;154:G_SanitiseString
;155:
;156:Remove case and control characters from a string
;157:==================
;158:*/
;159:void G_SanitiseString( char *in, char *out, int len )
;160:{
line 161
;161:	qboolean skip = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 162
;162:	int spaces = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 164
;163:
;164:	len--;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $140
JUMPV
LABELV $139
line 166
;165:
;166:	while( *in && len > 0 ) {
line 168
;167:		// strip leading white space
;168:		if( *in == ' ' ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $142
line 169
;169:			if( skip ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $144
line 170
;170:				in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 171
;171:				continue;
ADDRGP4 $140
JUMPV
LABELV $144
line 173
;172:			}
;173:			spaces++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 174
;174:		}
ADDRGP4 $143
JUMPV
LABELV $142
line 175
;175:		else {
line 176
;176:			spaces = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 177
;177:			skip = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 178
;178:		}
LABELV $143
line 180
;179:
;180:		if( Q_IsColorString( in ) ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $146
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $146
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $146
ADDRLP4 12
INDIRI4
CNSTI4 48
LTI4 $146
ADDRLP4 12
INDIRI4
CNSTI4 56
GTI4 $146
line 181
;181:			in += 2;    // skip color code
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 182
;182:			continue;
ADDRGP4 $140
JUMPV
LABELV $146
line 185
;183:		}
;184:
;185:		if( *in < 32 ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
GEI4 $148
line 186
;186:			in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 187
;187:			continue;
ADDRGP4 $140
JUMPV
LABELV $148
line 190
;188:		}
;189:
;190:		*out++ = tolower( *in++ );
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRFP4 4
ADDRLP4 16
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 28
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 28
INDIRI4
CVII1 4
ASGNI1
line 191
;191:		len--;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 192
;192:	}
LABELV $140
line 166
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
EQI4 $150
ADDRFP4 8
INDIRI4
ADDRLP4 8
INDIRI4
GTI4 $139
LABELV $150
line 193
;193:	out -= spaces;
ADDRFP4 4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
SUBP4
ASGNP4
line 194
;194:	*out = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 195
;195:}
LABELV $138
endproc G_SanitiseString 32 4
lit
align 1
LABELV $152
byte 1 0
skip 31
align 1
LABELV $153
byte 1 0
skip 31
export G_ClientNumbersFromString
code
proc G_ClientNumbersFromString 92 12
line 209
;196:
;197:
;198:/*
;199:==================
;200:G_ClientNumbersFromString
;201:
;202:Sets plist to an array of integers that represent client numbers that have
;203:names that are a partial match for s.
;204:
;205:Returns number of matching clientids up to max.
;206:==================
;207:*/
;208:int G_ClientNumbersFromString( char *s, int *plist, int max )
;209:{
line 211
;210:	gclient_t *p;
;211:	int i, found = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 212
;212:	char n2[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 4
ADDRGP4 $152
INDIRB
ASGNB 32
line 213
;213:	char s2[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 44
ADDRGP4 $153
INDIRB
ASGNB 32
line 215
;214:
;215:	if( max == 0 )
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $154
line 216
;216:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $151
JUMPV
LABELV $154
line 219
;217:
;218:	// if a number is provided, it is a clientnum
;219:	for( i = 0; s[ i ] && isdigit( s[ i ] ); i++ );
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $159
JUMPV
LABELV $156
LABELV $157
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $159
ADDRLP4 76
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $161
ADDRLP4 76
INDIRI4
CNSTI4 48
LTI4 $161
ADDRLP4 76
INDIRI4
CNSTI4 57
LEI4 $156
LABELV $161
line 220
;220:	if( !s[ i ] ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $162
line 221
;221:		i = atoi( s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 80
INDIRI4
ASGNI4
line 222
;222:		if ( i >= 0 && i < level.maxclients ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $164
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
GEI4 $164
line 223
;223:			p = &level.clients[ i ];
ADDRLP4 36
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 224
;224:			if( p->pers.connected != CON_DISCONNECTED ) {
ADDRLP4 36
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $167
line 225
;225:				*plist = i;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 226
;226:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $151
JUMPV
LABELV $167
line 228
;227:			}
;228:		}
LABELV $164
line 230
;229:		// we must assume that if only a number is provided, it is a clientNum
;230:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $151
JUMPV
LABELV $162
line 234
;231:	}
;232:
;233:	// now look for name matches
;234:	G_SanitiseString( s, s2, sizeof( s2 ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 235
;235:	if( strlen( s2 ) < 1 )
ADDRLP4 44
ARGP4
ADDRLP4 80
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 1
GEI4 $169
line 236
;236:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $151
JUMPV
LABELV $169
line 237
;237:	for ( i = 0; i < level.maxclients && found < max; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $174
JUMPV
LABELV $171
line 238
;238:		p = &level.clients[ i ];
ADDRLP4 36
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 239
;239:		if( p->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 36
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $176
line 240
;240:			continue;
ADDRGP4 $172
JUMPV
LABELV $176
line 242
;241:		}
;242:		G_SanitiseString( p->pers.netname, n2, sizeof( n2 ) );
ADDRLP4 36
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 243
;243:		if ( strstr( n2, s2 ) ) {
ADDRLP4 4
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 84
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 84
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $178
line 244
;244:			*plist++ = i;
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 245
;245:			found++;
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 246
;246:		}
LABELV $178
line 247
;247:	}
LABELV $172
line 237
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $174
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
GEI4 $180
ADDRLP4 40
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $171
LABELV $180
line 248
;248:	return found;
ADDRLP4 40
INDIRI4
RETI4
LABELV $151
endproc G_ClientNumbersFromString 92 12
export G_FloodLimited
proc G_FloodLimited 32 12
line 262
;249:}
;250:
;251:
;252:/*
;253:==================
;254:G_FloodLimited
;255:
;256:Determine whether a user is flood limited, and adjust their flood demerits
;257:Print them a warning message if they are over the limit
;258:Return is time in msec until the user can speak again
;259:==================
;260:*/
;261:int G_FloodLimited( gentity_t *ent )
;262:{
line 265
;263:	int deltatime, ms;
;264:
;265:	if( g_floodMinTime.integer <= 0 )
ADDRGP4 g_floodMinTime+12
INDIRI4
CNSTI4 0
GTI4 $182
line 266
;266:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $181
JUMPV
LABELV $182
line 269
;267:
;268:	// handles !ent
;269:	if( G_admin_permission( ent, ADMF_NOCENSORFLOOD ) )
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 8
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $185
line 270
;270:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $181
JUMPV
LABELV $185
line 272
;271:
;272:	deltatime = level.time - ent->client->pers.floodTime;
ADDRLP4 4
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1008
ADDP4
INDIRI4
SUBI4
ASGNI4
line 274
;273:
;274:	ent->client->pers.floodDemerits += g_floodMinTime.integer - deltatime;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1004
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRGP4 g_floodMinTime+12
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 275
;275:	if( ent->client->pers.floodDemerits < 0 )
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1004
ADDP4
INDIRI4
CNSTI4 0
GEI4 $189
line 276
;276:		ent->client->pers.floodDemerits = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1004
ADDP4
CNSTI4 0
ASGNI4
LABELV $189
line 277
;277:	ent->client->pers.floodTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1008
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 279
;278:
;279:	ms = ent->client->pers.floodDemerits - g_floodMaxDemerits.integer;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1004
ADDP4
INDIRI4
ADDRGP4 g_floodMaxDemerits+12
INDIRI4
SUBI4
ASGNI4
line 280
;280:	if( ms <= 0 )
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $193
line 281
;281:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $181
JUMPV
LABELV $193
line 282
;282:	trap_SendServerCommand( ent - g_entities, va( "print \"You are flooding: please wait %d second%s before trying again\n",
ADDRGP4 $195
ARGP4
ADDRLP4 24
CNSTI4 1000
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 999
ADDI4
ADDRLP4 24
INDIRI4
DIVI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $199
ADDRLP4 16
ADDRGP4 $196
ASGNP4
ADDRGP4 $200
JUMPV
LABELV $199
ADDRLP4 16
ADDRGP4 $197
ASGNP4
LABELV $200
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 284
;283:	                        ( ms + 999 ) / 1000, ( ms > 1000 ) ? "s" : "" ) );
;284:	return ms;
ADDRLP4 0
INDIRI4
RETI4
LABELV $181
endproc G_FloodLimited 32 12
proc G_AdminMessage 2068 20
line 298
;285:}
;286:
;287:static void QDECL G_AdminMessage( const char *prefix, const char *fmt, ... )  __attribute__ ((format (printf, 2, 3)));
;288:
;289:/*
;290:=================
;291:G_AdminMessage
;292:
;293:Print to all active server admins, and to the logfile, and to the server console
;294:Prepend *prefix, or '[SERVER]' if no *prefix is given
;295:=================
;296:*/
;297:static void QDECL G_AdminMessage( const char *prefix, const char *fmt, ... )
;298:{
line 305
;299:	va_list argptr;
;300:	char    string[ 1024 ];
;301:	char    outstring[ 1024 ];
;302:	int     i;
;303:
;304:	// Format the text
;305:	va_start( argptr, fmt );
ADDRLP4 1028
ADDRFP4 4+4
ASGNP4
line 306
;306:	Q_vsnprintf( string, sizeof( string ), fmt, argptr );
ADDRLP4 1032
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 Q_vsnprintf
CALLI4
pop
line 307
;307:	va_end( argptr );
ADDRLP4 1028
CNSTP4 0
ASGNP4
line 311
;308:
;309:	// If there is no prefix, assume that this function was called directly
;310:	// and we should add one
;311:	if( !prefix || !prefix[ 0 ] ) {
ADDRLP4 2056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2056
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $205
ADDRLP4 2056
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $203
LABELV $205
line 312
;312:		prefix = "[SERVER]:";
ADDRFP4 0
ADDRGP4 $206
ASGNP4
line 313
;313:	}
LABELV $203
line 316
;314:
;315:	// Create the final string
;316:	Com_sprintf( outstring, sizeof( outstring ), "%s " S_COLOR_MAGENTA "%s",
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $207
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 320
;317:	             prefix, string );
;318:
;319:	// Send to all appropriate clients
;320:	for( i = 0; i < level.maxclients; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $211
JUMPV
LABELV $208
line 321
;321:		if( G_admin_permission( &g_entities[ i ], ADMF_ADMINCHAT ) )
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
CNSTI4 63
ARGI4
ADDRLP4 2060
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
EQI4 $213
line 322
;322:			trap_SendServerCommand( i, va( "chat \"%s\"", outstring ) );
ADDRGP4 $215
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 2064
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 2064
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
LABELV $213
LABELV $209
line 320
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $211
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $208
line 325
;323:
;324:	// Send to the logfile and server console
;325:	G_LogPrintf("adminmsg: %s\n", outstring );
ADDRGP4 $216
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 326
;326:}
LABELV $201
endproc G_AdminMessage 2068 20
export Cmd_AdminMessage_f
proc Cmd_AdminMessage_f 92 16
line 336
;327:
;328:/*
;329:=================
;330:Cmd_AdminMessage_f
;331:
;332:Send a message to all active admins
;333:=================
;334:*/
;335:void Cmd_AdminMessage_f( gentity_t *ent )
;336:{
line 340
;337:	char cmd[ sizeof( "say_team" ) ];
;338:	char prefix[ 50 ];
;339:	char *msg;
;340:	int skiparg = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 343
;341:
;342:	// Check permissions and add the appropriate user [prefix]
;343:	if( !ent ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $219
line 344
;344:		Com_sprintf( prefix, sizeof( prefix ), "[CONSOLE]:" );
ADDRLP4 16
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 $221
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 345
;345:	}
ADDRGP4 $220
JUMPV
LABELV $219
line 346
;346:	else if( !G_admin_permission( ent, ADMF_ADMINCHAT ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 63
ARGI4
ADDRLP4 72
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $222
line 347
;347:		if( !g_publicAdminMessages.integer ) {
ADDRGP4 g_publicAdminMessages+12
INDIRI4
CNSTI4 0
NEI4 $224
line 348
;348:			ADMP( "Sorry, but use of /a by non-admins has been disabled.\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $227
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 349
;349:			return;
ADDRGP4 $217
JUMPV
LABELV $224
line 351
;350:		}
;351:		else {
line 352
;352:			Com_sprintf( prefix, sizeof( prefix ), "[PLAYER] %s" S_COLOR_WHITE ":",
ADDRLP4 16
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 $228
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 354
;353:			             ent->client->pers.netname );
;354:			ADMP( "Your message has been sent to any available admins and to the server logs.\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $229
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 355
;355:		}
line 356
;356:	}
ADDRGP4 $223
JUMPV
LABELV $222
line 357
;357:	else {
line 358
;358:		Com_sprintf( prefix, sizeof( prefix ), "[ADMIN] %s" S_COLOR_WHITE ":",
ADDRLP4 16
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 $230
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 360
;359:		             ent->client->pers.netname );
;360:	}
LABELV $223
LABELV $220
line 363
;361:
;362:	// Skip say/say_team if this was used from one of those
;363:	G_SayArgv( 0, cmd, sizeof( cmd ) );
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 9
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 364
;364:	if( Q_strequal( cmd, "say" ) || Q_strequal( cmd, "say_team" ) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $234
ADDRLP4 0
ARGP4
ADDRGP4 $218
ARGP4
ADDRLP4 80
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
NEI4 $231
LABELV $234
line 365
;365:		skiparg = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 366
;366:		G_SayArgv( 1, cmd, sizeof( cmd ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 9
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 367
;367:	}
LABELV $231
line 368
;368:	if( G_SayArgc( ) < 2 + skiparg ) {
ADDRLP4 84
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 2
ADDI4
GEI4 $235
line 369
;369:		ADMP( va( "usage: %s [message]\n", cmd ) );
ADDRGP4 $237
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 88
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 370
;370:		return;
ADDRGP4 $217
JUMPV
LABELV $235
line 373
;371:	}
;372:
;373:	msg = G_SayConcatArgs( 1 + skiparg );
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 88
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 88
INDIRP4
ASGNP4
line 376
;374:
;375:	// Send it
;376:	G_AdminMessage( prefix, "%s", msg );
ADDRLP4 16
ARGP4
ADDRGP4 $238
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 G_AdminMessage
CALLV
pop
line 377
;377:}
LABELV $217
endproc Cmd_AdminMessage_f 92 16
export G_ClientNumberFromString
proc G_ClientNumberFromString 84 12
line 389
;378:
;379:
;380:/*
;381:==================
;382:G_ClientNumberFromString
;383:
;384:Returns a player number for either a number or name string
;385:Returns -1 if invalid
;386:==================
;387:*/
;388:int G_ClientNumberFromString( char *s )
;389:{
line 396
;390:	gclient_t *cl;
;391:	int       i;
;392:	char      s2[ MAX_NAME_LENGTH ];
;393:	char      n2[ MAX_NAME_LENGTH ];
;394:
;395:	// numeric values are just slot numbers
;396:	for( i = 0; s[ i ] && isdigit( s[ i ] ); i++ );
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $243
JUMPV
LABELV $240
LABELV $241
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $243
ADDRLP4 72
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $245
ADDRLP4 72
INDIRI4
CNSTI4 48
LTI4 $245
ADDRLP4 72
INDIRI4
CNSTI4 57
LEI4 $240
LABELV $245
line 397
;397:	if( !s[ i ] ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $246
line 398
;398:		i = atoi( s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 76
INDIRI4
ASGNI4
line 400
;399:
;400:		if( i < 0 || i >= level.maxclients )
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $251
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $248
LABELV $251
line 401
;401:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $239
JUMPV
LABELV $248
line 403
;402:
;403:		cl = &level.clients[ i ];
ADDRLP4 4
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 405
;404:
;405:		if( cl->pers.connected == CON_DISCONNECTED )
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $252
line 406
;406:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $239
JUMPV
LABELV $252
line 408
;407:
;408:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $239
JUMPV
LABELV $246
line 412
;409:	}
;410:
;411:	// check for a name match
;412:	G_SanitiseString( s, s2, sizeof( s2 ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 414
;413:
;414:	for( i = 0, cl = level.clients; i < level.maxclients; i++, cl++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRGP4 level
INDIRP4
ASGNP4
ADDRGP4 $257
JUMPV
LABELV $254
line 415
;415:		if( cl->pers.connected == CON_DISCONNECTED )
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $259
line 416
;416:			continue;
ADDRGP4 $255
JUMPV
LABELV $259
line 418
;417:
;418:		G_SanitiseString( cl->pers.netname, n2, sizeof( n2 ) );
ADDRLP4 4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 420
;419:
;420:		if( strequals( n2, s2 ) )
ADDRLP4 8
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 76
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $261
line 421
;421:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $239
JUMPV
LABELV $261
line 422
;422:	}
LABELV $255
line 414
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 2116
ADDP4
ASGNP4
LABELV $257
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $254
line 424
;423:
;424:	return -1;
CNSTI4 -1
RETI4
LABELV $239
endproc G_ClientNumberFromString 84 12
export G_ClientIsLagging
proc G_ClientIsLagging 0 0
line 434
;425:}
;426:
;427://KK-OAX Used to !spec999'ers
;428:/*
;429:=============
;430:G_ClientIsLagging
;431:=============
;432:*/
;433:qboolean G_ClientIsLagging( gclient_t *client )
;434:{
line 435
;435:	if( client ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $264
line 436
;436:		if( client->ps.ping >= 999 )
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 999
LTI4 $266
line 437
;437:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $263
JUMPV
LABELV $266
line 439
;438:		else
;439:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $264
line 442
;440:	}
;441:
;442:	return qfalse; //is a non-existant client lagging? woooo zen
CNSTI4 0
RETI4
LABELV $263
endproc G_ClientIsLagging 0 0
export SanitizeString
proc SanitizeString 16 4
line 453
;443:}
;444:
;445:/*
;446:==================
;447:SanitizeString
;448:
;449:Remove case and control characters
;450:==================
;451:*/
;452:void SanitizeString( char *in, char *out )
;453:{
ADDRGP4 $270
JUMPV
LABELV $269
line 454
;454:	while ( *in ) {
line 455
;455:		if ( *in == 27 ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 27
NEI4 $272
line 456
;456:			in += 2;		// skip color code
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 457
;457:			continue;
ADDRGP4 $270
JUMPV
LABELV $272
line 459
;458:		}
;459:		if ( *in < 32 ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
GEI4 $274
line 460
;460:			in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 461
;461:			continue;
ADDRGP4 $270
JUMPV
LABELV $274
line 463
;462:		}
;463:		*out++ = tolower( *in++ );
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRFP4 4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
CVII1 4
ASGNI1
line 464
;464:	}
LABELV $270
line 454
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $269
line 466
;465:
;466:	*out = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 467
;467:}
LABELV $268
endproc SanitizeString 16 4
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
LABELV $238
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $237
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 91
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $233
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $230
byte 1 91
byte 1 65
byte 1 68
byte 1 77
byte 1 73
byte 1 78
byte 1 93
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 58
byte 1 0
align 1
LABELV $229
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $228
byte 1 91
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 93
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 58
byte 1 0
align 1
LABELV $227
byte 1 83
byte 1 111
byte 1 114
byte 1 114
byte 1 121
byte 1 44
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 47
byte 1 97
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 110
byte 1 111
byte 1 110
byte 1 45
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $221
byte 1 91
byte 1 67
byte 1 79
byte 1 78
byte 1 83
byte 1 79
byte 1 76
byte 1 69
byte 1 93
byte 1 58
byte 1 0
align 1
LABELV $218
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $216
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 109
byte 1 115
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $215
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $207
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 54
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $206
byte 1 91
byte 1 83
byte 1 69
byte 1 82
byte 1 86
byte 1 69
byte 1 82
byte 1 93
byte 1 58
byte 1 0
align 1
LABELV $197
byte 1 0
align 1
LABELV $196
byte 1 115
byte 1 0
align 1
LABELV $195
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 112
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 114
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 103
byte 1 97
byte 1 105
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $135
byte 1 37
byte 1 50
byte 1 105
byte 1 32
byte 1 45
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 10
byte 1 0
align 1
LABELV $128
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 46
byte 1 32
byte 1 66
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 105
byte 1 99
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 32
byte 1 35
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $125
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 32
byte 1 35
byte 1 0
