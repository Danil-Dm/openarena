export trap_Cvar_VariableValue
code
proc trap_Cvar_VariableValue 132 12
file "../../../code/game/g_bot.c"
line 56
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
;23:// g_bot.c
;24:
;25:#include "g_local.h"
;26:
;27:
;28:static int		g_numBots;
;29:static char		*g_botInfos[MAX_BOTS];
;30:
;31:
;32:int				g_numArenas;
;33:static char		*g_arenaInfos[MAX_ARENAS];
;34:
;35:
;36:#define BOT_BEGIN_DELAY_BASE		2000
;37:#define BOT_BEGIN_DELAY_INCREMENT	1500
;38:
;39:#define BOT_SPAWN_QUEUE_DEPTH	16
;40:
;41:typedef struct {
;42:	int		clientNum;
;43:	int		spawnTime;
;44:} botSpawnQueue_t;
;45:
;46://static int			botBeginDelay = 0;  // bk001206 - unused, init
;47:static botSpawnQueue_t	botSpawnQueue[BOT_SPAWN_QUEUE_DEPTH];
;48:
;49:vmCvar_t bot_minplayers;
;50:vmCvar_t bot_autominplayers;
;51:
;52:extern gentity_t	*podium1;
;53:extern gentity_t	*podium2;
;54:extern gentity_t	*podium3;
;55:
;56:float trap_Cvar_VariableValue( const char *var_name ) {
line 59
;57:	char buf[128];
;58:
;59:	trap_Cvar_VariableStringBuffer(var_name, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 60
;60:	return atof(buf);
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
RETF4
LABELV $61
endproc trap_Cvar_VariableValue 132 12
export G_ParseInfos
proc G_ParseInfos 2104 12
line 70
;61:}
;62:
;63:
;64:
;65:/*
;66:===============
;67:G_ParseInfos
;68:===============
;69:*/
;70:int G_ParseInfos( char *buf, int max, char *infos[] ) {
line 76
;71:	char	*token;
;72:	int		count;
;73:	char	key[MAX_TOKEN_CHARS];
;74:	char	info[MAX_INFO_STRING];
;75:
;76:	count = 0;
ADDRLP4 2052
CNSTI4 0
ASGNI4
ADDRGP4 $64
JUMPV
LABELV $63
line 78
;77:
;78:	while ( 1 ) {
line 79
;79:		token = COM_Parse( &buf );
ADDRFP4 0
ARGP4
ADDRLP4 2056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2056
INDIRP4
ASGNP4
line 80
;80:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $66
line 81
;81:			break;
ADDRGP4 $65
JUMPV
LABELV $66
line 83
;82:		}
;83:		if ( !strequals( token, "{" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $70
ARGP4
ADDRLP4 2060
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
EQI4 $68
line 84
;84:			Com_Printf( "Missing { in info file\n" );
ADDRGP4 $71
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 85
;85:			break;
ADDRGP4 $65
JUMPV
LABELV $68
line 88
;86:		}
;87:
;88:		if ( count == max ) {
ADDRLP4 2052
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $72
line 89
;89:			Com_Printf( "Max infos exceeded\n" );
ADDRGP4 $74
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 90
;90:			break;
ADDRGP4 $65
JUMPV
LABELV $72
line 93
;91:		}
;92:
;93:		info[0] = '\0';
ADDRLP4 1028
CNSTI1 0
ASGNI1
ADDRGP4 $76
JUMPV
LABELV $75
line 94
;94:		while ( 1 ) {
line 95
;95:			token = COM_ParseExt( &buf, qtrue );
ADDRFP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 2064
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
ASGNP4
line 96
;96:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $78
line 97
;97:				Com_Printf( "Unexpected end of info file\n" );
ADDRGP4 $80
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 98
;98:				break;
ADDRGP4 $77
JUMPV
LABELV $78
line 100
;99:			}
;100:			if ( strequals( token, "}" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $83
ARGP4
ADDRLP4 2068
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $81
line 101
;101:				break;
ADDRGP4 $77
JUMPV
LABELV $81
line 103
;102:			}
;103:			Q_strncpyz( key, token, sizeof( key ) );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 105
;104:
;105:			token = COM_ParseExt( &buf, qfalse );
ADDRFP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 2072
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2072
INDIRP4
ASGNP4
line 106
;106:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $84
line 107
;107:				strcpy( token, "<NULL>" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $86
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 108
;108:			}
LABELV $84
line 109
;109:			Info_SetValueForKey( info, key, token );
ADDRLP4 1028
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 110
;110:		}
LABELV $76
line 94
ADDRGP4 $75
JUMPV
LABELV $77
line 111
;111:		if(!BG_CanAlloc(strlen(info) + strlen("\\num\\") + strlen(va("%d", MAX_ARENAS)) + 1))
ADDRLP4 1028
ARGP4
ADDRLP4 2064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $89
ARGP4
ADDRLP4 2068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $90
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2072
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 2072
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2064
INDIRI4
ADDRLP4 2068
INDIRI4
ADDI4
ADDRLP4 2076
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CVIU4 4
ARGU4
ADDRLP4 2080
ADDRGP4 BG_CanAlloc
CALLI4
ASGNI4
ADDRLP4 2080
INDIRI4
CNSTI4 0
NEI4 $87
line 112
;112:			break; //Not enough memory. Don't even try
ADDRGP4 $65
JUMPV
LABELV $87
line 115
;113:		//NOTE: extra space for arena number
;114:		//KK-OAX Changed to Tremulous's BG_Alloc
;115:		infos[count] = BG_Alloc(strlen(info) + strlen("\\num\\") + strlen(va("%d", MAX_ARENAS)) + 1);
ADDRLP4 1028
ARGP4
ADDRLP4 2084
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $89
ARGP4
ADDRLP4 2088
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $90
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2092
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 2092
INDIRP4
ARGP4
ADDRLP4 2096
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
ADDRLP4 2088
INDIRI4
ADDI4
ADDRLP4 2096
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CVIU4 4
ARGU4
ADDRLP4 2100
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 2100
INDIRP4
ASGNP4
line 116
;116:		if (infos[count]) {
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $91
line 117
;117:			strcpy(infos[count], info);
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 118
;118:			count++;
ADDRLP4 2052
ADDRLP4 2052
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 119
;119:		}
LABELV $91
line 120
;120:	}
LABELV $64
line 78
ADDRGP4 $63
JUMPV
LABELV $65
line 121
;121:	return count;
ADDRLP4 2052
INDIRI4
RETI4
LABELV $62
endproc G_ParseInfos 2104 12
proc G_LoadArenasFromFile 8216 16
line 129
;122:}
;123:
;124:/*
;125:===============
;126:G_LoadArenasFromFile
;127:===============
;128:*/
;129:static void G_LoadArenasFromFile( char *filename ) {
line 134
;130:	int				len;
;131:	fileHandle_t	f;
;132:	char			buf[MAX_ARENAS_TEXT];
;133:
;134:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8200
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8200
INDIRI4
ASGNI4
line 135
;135:	if ( !f ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $94
line 136
;136:		trap_Printf( va( S_COLOR_RED "file not found: %s\n", filename ) );
ADDRGP4 $96
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 137
;137:		return;
ADDRGP4 $93
JUMPV
LABELV $94
line 139
;138:	}
;139:	if ( len >= MAX_ARENAS_TEXT ) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $97
line 140
;140:		trap_Printf( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i\n", filename, len, MAX_ARENAS_TEXT ) );
ADDRGP4 $99
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8192
ARGI4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 141
;141:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 142
;142:		return;
ADDRGP4 $93
JUMPV
LABELV $97
line 145
;143:	}
;144:
;145:	trap_FS_Read( buf, len, f );
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 146
;146:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 147
;147:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 149
;148:
;149:	g_numArenas += G_ParseInfos( buf, MAX_ARENAS - g_numArenas, &g_arenaInfos[g_numArenas] );
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 g_numArenas
ASGNP4
ADDRLP4 8208
ADDRLP4 8204
INDIRP4
INDIRI4
ASGNI4
CNSTI4 1024
ADDRLP4 8208
INDIRI4
SUBI4
ARGI4
ADDRLP4 8208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 G_ParseInfos
CALLI4
ASGNI4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRI4
ADDRLP4 8212
INDIRI4
ADDI4
ASGNI4
line 150
;150:}
LABELV $93
endproc G_LoadArenasFromFile 8216 16
proc G_LoadArenas 1460 16
line 157
;151:
;152:/*
;153:===============
;154:G_LoadArenas
;155:===============
;156:*/
;157:static void G_LoadArenas( void ) {
line 166
;158:	int			numdirs;
;159:	vmCvar_t	arenasFile;
;160:	char		filename[128];
;161:	char		dirlist[1024];
;162:	char*		dirptr;
;163:	int			i, n;
;164:	int			dirlen;
;165:
;166:	g_numArenas = 0;
ADDRGP4 g_numArenas
CNSTI4 0
ASGNI4
line 168
;167:
;168:	trap_Cvar_Register( &arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM );
ADDRLP4 148
ARGP4
ADDRGP4 $101
ARGP4
ADDRGP4 $102
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 169
;169:	if( *arenasFile.string ) {
ADDRLP4 148+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $103
line 170
;170:		G_LoadArenasFromFile(arenasFile.string);
ADDRLP4 148+16
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 171
;171:	}
ADDRGP4 $104
JUMPV
LABELV $103
line 172
;172:	else {
line 173
;173:		G_LoadArenasFromFile("scripts/arenas.txt");
ADDRGP4 $107
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 174
;174:	}
LABELV $104
line 177
;175:
;176:	// get all arenas from .arena files
;177:	numdirs = trap_FS_GetFileList("scripts", ".arena", dirlist, 1024 );
ADDRGP4 $108
ARGP4
ADDRGP4 $109
ARGP4
ADDRLP4 420
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1444
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 1444
INDIRI4
ASGNI4
line 178
;178:	dirptr  = dirlist;
ADDRLP4 4
ADDRLP4 420
ASGNP4
line 179
;179:	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $113
JUMPV
LABELV $110
line 180
;180:		dirlen = strlen(dirptr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1448
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 1448
INDIRI4
ASGNI4
line 181
;181:		strcpy(filename, "scripts/");
ADDRLP4 8
ARGP4
ADDRGP4 $114
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 182
;182:		strcat(filename, dirptr);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 183
;183:		G_LoadArenasFromFile(filename);
ADDRLP4 8
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 184
;184:	}
LABELV $111
line 179
ADDRLP4 1448
CNSTI4 1
ASGNI4
ADDRLP4 136
ADDRLP4 136
INDIRI4
ADDRLP4 1448
INDIRI4
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 140
INDIRI4
ADDRLP4 1448
INDIRI4
ADDI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
LABELV $113
ADDRLP4 136
INDIRI4
ADDRLP4 144
INDIRI4
LTI4 $110
line 185
;185:	trap_Printf( va( "%i arenas parsed\n", g_numArenas ) );
ADDRGP4 $115
ARGP4
ADDRGP4 g_numArenas
INDIRI4
ARGI4
ADDRLP4 1452
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1452
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 187
;186:	
;187:	for( n = 0; n < g_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $119
JUMPV
LABELV $116
line 188
;188:		Info_SetValueForKey( g_arenaInfos[n], "num", va( "%i", n ) );
ADDRGP4 $121
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1456
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $120
ARGP4
ADDRLP4 1456
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 189
;189:	}
LABELV $117
line 187
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $119
ADDRLP4 0
INDIRI4
ADDRGP4 g_numArenas
INDIRI4
LTI4 $116
line 190
;190:}
LABELV $100
endproc G_LoadArenas 1460 16
export G_GetArenaInfoByMap
proc G_GetArenaInfoByMap 12 8
line 198
;191:
;192:
;193:/*
;194:===============
;195:G_GetArenaInfoByNumber
;196:===============
;197:*/
;198:const char *G_GetArenaInfoByMap( const char *map ) {
line 201
;199:	int			n;
;200:
;201:	for( n = 0; n < g_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $126
JUMPV
LABELV $123
line 202
;202:		if( Q_strequal( Info_ValueForKey( g_arenaInfos[n], "map" ), map ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $129
ARGP4
ADDRLP4 4
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $127
line 203
;203:			return g_arenaInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $122
JUMPV
LABELV $127
line 205
;204:		}
;205:	}
LABELV $124
line 201
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $126
ADDRLP4 0
INDIRI4
ADDRGP4 g_numArenas
INDIRI4
LTI4 $123
line 207
;206:
;207:	return NULL;
CNSTP4 0
RETP4
LABELV $122
endproc G_GetArenaInfoByMap 12 8
proc PlayerIntroSound 80 12
line 216
;208:}
;209:
;210:
;211:/*
;212:=================
;213:PlayerIntroSound
;214:=================
;215:*/
;216:static void PlayerIntroSound( const char *modelAndSkin ) {
line 220
;217:	char	model[MAX_QPATH];
;218:	char	*skin;
;219:
;220:	Q_strncpyz( model, modelAndSkin, sizeof(model) );
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
line 221
;221:	skin = strrchr( model, '/' );
ADDRLP4 4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 68
ADDRGP4 strrchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 222
;222:	if ( skin ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $131
line 223
;223:		*skin++ = '\0';
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI1 0
ASGNI1
line 224
;224:	}
ADDRGP4 $132
JUMPV
LABELV $131
line 225
;225:	else {
line 226
;226:		skin = model;
ADDRLP4 0
ADDRLP4 4
ASGNP4
line 227
;227:	}
LABELV $132
line 229
;228:
;229:	if( Q_strequal( skin, "default" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $135
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $133
line 230
;230:		skin = model;
ADDRLP4 0
ADDRLP4 4
ASGNP4
line 231
;231:	}
LABELV $133
line 233
;232:
;233:	trap_SendConsoleCommand( EXEC_APPEND, va( "play sound/player/announce/%s.wav\n", skin ) );
ADDRGP4 $136
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 234
;234:}
LABELV $130
endproc PlayerIntroSound 80 12
export G_CountBotPlayersByName
proc G_CountBotPlayersByName 24 8
line 245
;235:
;236:/*
;237:===============
;238:G_CountBotPlayersByName
;239:
;240:Check connected and connecting (delay join) bots.
;241:
;242:Returns number of bots with name on specified team or whole server if team is -1.
;243:===============
;244:*/
;245:int G_CountBotPlayersByName( const char *name, int team ) {
line 249
;246:	int			i, num;
;247:	gclient_t	*cl;
;248:
;249:	num = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 250
;250:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $141
JUMPV
LABELV $138
line 251
;251:		cl = level.clients + i;
ADDRLP4 4
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 252
;252:		if ( cl->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $143
line 253
;253:			continue;
ADDRGP4 $139
JUMPV
LABELV $143
line 255
;254:		}
;255:		if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $145
line 256
;256:			continue;
ADDRGP4 $139
JUMPV
LABELV $145
line 258
;257:		}
;258:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $149
ADDRLP4 4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $149
line 259
;259:			continue;
ADDRGP4 $139
JUMPV
LABELV $149
line 261
;260:		}
;261:		if ( name && Q_stricmp( name, cl->pers.netname ) ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $151
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $151
line 262
;262:			continue;
ADDRGP4 $139
JUMPV
LABELV $151
line 264
;263:		}
;264:		num++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 265
;265:	}
LABELV $139
line 250
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $141
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $138
line 266
;266:	return num;
ADDRLP4 8
INDIRI4
RETI4
LABELV $137
endproc G_CountBotPlayersByName 24 8
export G_SelectRandomBotInfo
proc G_SelectRandomBotInfo 4136 8
line 276
;267:}
;268:
;269:/*
;270:===============
;271:G_SelectRandomBotInfo
;272:
;273:Get random least used bot info on team or whole server if team is -1.
;274:===============
;275:*/
;276:int G_SelectRandomBotInfo( int team ) {
line 283
;277:	int		selection[MAX_BOTS];
;278:	int		n, num;
;279:	int		count, bestCount;
;280:	char	*value;
;281:
;282:	// don't add duplicate bots to the server if there are less bots than bot types
;283:	if ( team != -1 && G_CountBotPlayersByName( NULL, -1 ) < g_numBots ) {
ADDRLP4 4116
CNSTI4 -1
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 4116
INDIRI4
EQI4 $154
CNSTP4 0
ARGP4
ADDRLP4 4116
INDIRI4
ARGI4
ADDRLP4 4120
ADDRGP4 G_CountBotPlayersByName
CALLI4
ASGNI4
ADDRLP4 4120
INDIRI4
ADDRGP4 g_numBots
INDIRI4
GEI4 $154
line 284
;284:		team = -1;
ADDRFP4 0
CNSTI4 -1
ASGNI4
line 285
;285:	}
LABELV $154
line 287
;286:
;287:	num = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 288
;288:	bestCount = MAX_CLIENTS;
ADDRLP4 12
CNSTI4 64
ASGNI4
line 289
;289:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $159
JUMPV
LABELV $156
line 290
;290:		value = Info_ValueForKey( g_botInfos[n], "funname" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $160
ARGP4
ADDRLP4 4124
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 4124
INDIRP4
ASGNP4
line 291
;291:		if ( !value[0] ) {
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $161
line 292
;292:			value = Info_ValueForKey( g_botInfos[n], "name" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 4128
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 4128
INDIRP4
ASGNP4
line 293
;293:		}
LABELV $161
line 295
;294:		//
;295:		count = G_CountBotPlayersByName( value, team );
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4128
ADDRGP4 G_CountBotPlayersByName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 4128
INDIRI4
ASGNI4
line 297
;296:
;297:		if ( count < bestCount ) {
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
GEI4 $164
line 298
;298:			bestCount = count;
ADDRLP4 12
ADDRLP4 4
INDIRI4
ASGNI4
line 299
;299:			num = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 300
;300:		}
LABELV $164
line 302
;301:
;302:		if ( count == bestCount ) {
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $166
line 303
;303:			selection[num++] = n;
ADDRLP4 4132
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 16
ADDRLP4 4132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 305
;304:
;305:			if ( num == MAX_BOTS ) {
ADDRLP4 16
INDIRI4
CNSTI4 1024
NEI4 $168
line 306
;306:				break;
ADDRGP4 $158
JUMPV
LABELV $168
line 308
;307:			}
;308:		}
LABELV $166
line 309
;309:	}
LABELV $157
line 289
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $159
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $156
LABELV $158
line 311
;310:
;311:	if ( num > 0 ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $170
line 312
;312:		num = random() * ( num - 1 );
ADDRLP4 4124
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 4124
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 313
;313:		return selection[num];
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
RETI4
ADDRGP4 $153
JUMPV
LABELV $170
line 316
;314:	}
;315:
;316:	return -1;
CNSTI4 -1
RETI4
LABELV $153
endproc G_SelectRandomBotInfo 4136 8
export G_AddRandomBot
proc G_AddRandomBot 8 16
line 324
;317:}
;318:
;319:/*
;320:===============
;321:G_AddRandomBot
;322:===============
;323:*/
;324:void G_AddRandomBot( int team ) {
line 327
;325:	char	*teamstr;
;326:
;327:	if (team == TEAM_RED) teamstr = "red";
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $173
ADDRLP4 0
ADDRGP4 $175
ASGNP4
ADDRGP4 $174
JUMPV
LABELV $173
line 328
;328:	else if (team == TEAM_BLUE) teamstr = "blue";
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $176
ADDRLP4 0
ADDRGP4 $178
ASGNP4
ADDRGP4 $177
JUMPV
LABELV $176
line 329
;329:	else teamstr = "free";
ADDRLP4 0
ADDRGP4 $179
ASGNP4
LABELV $177
LABELV $174
line 330
;330:	trap_SendConsoleCommand( EXEC_INSERT, va("addbot random %f %s %i\n", g_spSkill.integer, teamstr, 0) );
ADDRGP4 $180
ARGP4
ADDRGP4 g_spSkill+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 331
;331:}
LABELV $172
endproc G_AddRandomBot 8 16
export G_RemoveRandomBot
proc G_RemoveRandomBot 16 8
line 338
;332:
;333:/*
;334:===============
;335:G_RemoveRandomBot
;336:===============
;337:*/
;338:int G_RemoveRandomBot( int team ) {
line 342
;339:	int i;
;340:	gclient_t	*cl;
;341:
;342:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $186
JUMPV
LABELV $183
line 343
;343:		cl = level.clients + i;
ADDRLP4 0
CNSTI4 2116
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 344
;344:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $188
line 345
;345:			continue;
ADDRGP4 $184
JUMPV
LABELV $188
line 347
;346:		}
;347:		if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
CNSTI4 816
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $190
line 348
;348:			continue;
ADDRGP4 $184
JUMPV
LABELV $190
line 350
;349:		}
;350:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $194
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $194
line 351
;351:			continue;
ADDRGP4 $184
JUMPV
LABELV $194
line 353
;352:		}
;353:		trap_SendConsoleCommand( EXEC_INSERT, va("clientkick %d\n", cl->ps.clientNum) );
ADDRGP4 $196
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 354
;354:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $182
JUMPV
LABELV $184
line 342
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $186
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $183
line 356
;355:	}
;356:	return qfalse;
CNSTI4 0
RETI4
LABELV $182
endproc G_RemoveRandomBot 16 8
export G_CountHumanPlayers
proc G_CountHumanPlayers 16 0
line 364
;357:}
;358:
;359:/*
;360:===============
;361:G_CountHumanPlayers
;362:===============
;363:*/
;364:int G_CountHumanPlayers( int team ) {
line 368
;365:	int i, num;
;366:	gclient_t	*cl;
;367:
;368:	num = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 369
;369:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $201
JUMPV
LABELV $198
line 370
;370:		cl = level.clients + i;
ADDRLP4 0
CNSTI4 2116
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 371
;371:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $203
line 372
;372:			continue;
ADDRGP4 $199
JUMPV
LABELV $203
line 374
;373:		}
;374:		if ( g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT ) {
CNSTI4 816
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $205
line 375
;375:			continue;
ADDRGP4 $199
JUMPV
LABELV $205
line 377
;376:		}
;377:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $209
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $209
line 378
;378:			continue;
ADDRGP4 $199
JUMPV
LABELV $209
line 380
;379:		}
;380:		num++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 381
;381:	}
LABELV $199
line 369
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $201
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $198
line 382
;382:	return num;
ADDRLP4 8
INDIRI4
RETI4
LABELV $197
endproc G_CountHumanPlayers 16 0
export G_CountBotPlayers
proc G_CountBotPlayers 16 0
line 392
;383:}
;384:
;385:/*
;386:===============
;387:G_CountBotPlayers
;388:
;389:Check connected and connecting (delay join) bots.
;390:===============
;391:*/
;392:int G_CountBotPlayers( int team ) {
line 396
;393:	int i, num;
;394:	gclient_t	*cl;
;395:
;396:	num = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 397
;397:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $215
JUMPV
LABELV $212
line 398
;398:		cl = level.clients + i;
ADDRLP4 0
CNSTI4 2116
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 399
;399:		if ( cl->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $217
line 400
;400:			continue;
ADDRGP4 $213
JUMPV
LABELV $217
line 402
;401:		}
;402:		if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
CNSTI4 816
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $219
line 403
;403:			continue;
ADDRGP4 $213
JUMPV
LABELV $219
line 405
;404:		}
;405:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $223
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $223
line 406
;406:			continue;
ADDRGP4 $213
JUMPV
LABELV $223
line 408
;407:		}
;408:		num++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 409
;409:	}
LABELV $213
line 397
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $215
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $212
line 410
;410:	return num;
ADDRLP4 8
INDIRI4
RETI4
LABELV $211
endproc G_CountBotPlayers 16 0
bss
align 4
LABELV $226
skip 4
export G_CheckMinimumPlayers
code
proc G_CheckMinimumPlayers 44 4
line 418
;411:}
;412:
;413:/*
;414:===============
;415:G_CheckMinimumPlayers
;416:===============
;417:*/
;418:void G_CheckMinimumPlayers( void ) {
line 423
;419:	int minplayers;
;420:	int humanplayers, botplayers;
;421:	static int checkminimumplayers_time;
;422:
;423:	if (level.intermissiontime) return;
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $227
ADDRGP4 $225
JUMPV
LABELV $227
line 425
;424:	//only check once each 10 seconds
;425:	if (checkminimumplayers_time > level.time - 10000) {
ADDRGP4 $226
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $230
line 426
;426:		return;
ADDRGP4 $225
JUMPV
LABELV $230
line 428
;427:	}
;428:	checkminimumplayers_time = level.time;
ADDRGP4 $226
ADDRGP4 level+32
INDIRI4
ASGNI4
line 429
;429:	trap_Cvar_Update(&bot_minplayers);
ADDRGP4 bot_minplayers
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 430
;430:	minplayers = bot_minplayers.integer;
ADDRLP4 0
ADDRGP4 bot_minplayers+12
INDIRI4
ASGNI4
line 431
;431:	if (minplayers <= 0) return;
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $235
ADDRGP4 $225
JUMPV
LABELV $235
line 433
;432:
;433:	if (!trap_AAS_Initialized()) {
ADDRLP4 12
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $237
line 434
;434:		minplayers = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 435
;435:		checkminimumplayers_time = level.time+600*1000;
ADDRGP4 $226
ADDRGP4 level+32
INDIRI4
CNSTI4 600000
ADDI4
ASGNI4
line 436
;436:		return; //If no AAS then don't even try
ADDRGP4 $225
JUMPV
LABELV $237
line 439
;437:	}
;438:
;439:	if (G_IsATeamGametype(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $240
line 440
;440:		if (minplayers >= g_maxclients.integer / 2) {
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 2
DIVI4
LTI4 $243
line 441
;441:			minplayers = (g_maxclients.integer / 2) -1;
ADDRLP4 0
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 1
SUBI4
ASGNI4
line 442
;442:		}
LABELV $243
line 444
;443:
;444:		humanplayers = G_CountHumanPlayers( TEAM_RED );
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 445
;445:		botplayers = G_CountBotPlayers(	TEAM_RED );
CNSTI4 1
ARGI4
ADDRLP4 24
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
line 447
;446:		//
;447:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $247
line 448
;448:			G_AddRandomBot( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 449
;449:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $248
JUMPV
LABELV $247
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $249
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $249
line 450
;450:			G_RemoveRandomBot( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 451
;451:		}
LABELV $249
LABELV $248
line 453
;452:		//
;453:		humanplayers = G_CountHumanPlayers( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRLP4 32
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 32
INDIRI4
ASGNI4
line 454
;454:		botplayers = G_CountBotPlayers( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRLP4 36
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 36
INDIRI4
ASGNI4
line 456
;455:		//
;456:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $251
line 457
;457:			G_AddRandomBot( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 458
;458:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $241
JUMPV
LABELV $251
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $241
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $241
line 459
;459:			G_RemoveRandomBot( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 460
;460:		}
line 461
;461:	}
ADDRGP4 $241
JUMPV
LABELV $240
line 462
;462:	else if (g_gametype.integer == GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $255
line 463
;463:		if (minplayers >= g_maxclients.integer) {
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $258
line 464
;464:			minplayers = g_maxclients.integer-1;
ADDRLP4 0
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 465
;465:		}
LABELV $258
line 466
;466:		humanplayers = G_CountHumanPlayers( -1 );
CNSTI4 -1
ARGI4
ADDRLP4 20
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 467
;467:		botplayers = G_CountBotPlayers( -1 );
CNSTI4 -1
ARGI4
ADDRLP4 24
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
line 469
;468:		//
;469:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $262
line 470
;470:			G_AddRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 471
;471:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $256
JUMPV
LABELV $262
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $256
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $256
line 473
;472:			// try to remove spectators first
;473:			if (!G_RemoveRandomBot( TEAM_SPECTATOR )) {
CNSTI4 3
ARGI4
ADDRLP4 32
ADDRGP4 G_RemoveRandomBot
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $256
line 475
;474:				// just remove the bot that is playing
;475:				G_RemoveRandomBot( -1 );
CNSTI4 -1
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 476
;476:			}
line 477
;477:		}
line 478
;478:	}
ADDRGP4 $256
JUMPV
LABELV $255
line 479
;479:	else {
line 480
;480:		if (minplayers >= g_maxclients.integer) {
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $268
line 481
;481:			minplayers = g_maxclients.integer-1;
ADDRLP4 0
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 482
;482:		}
LABELV $268
line 483
;483:		humanplayers = G_CountHumanPlayers( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 484
;484:		botplayers = G_CountBotPlayers( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRLP4 24
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
line 486
;485:		//
;486:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $272
line 487
;487:			G_AddRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 488
;488:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $273
JUMPV
LABELV $272
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $274
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $274
line 489
;489:			G_RemoveRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 490
;490:		}
LABELV $274
LABELV $273
line 491
;491:	}
LABELV $256
LABELV $241
line 492
;492:}
LABELV $225
endproc G_CheckMinimumPlayers 44 4
export G_CheckBotSpawn
proc G_CheckBotSpawn 1032 12
line 499
;493:
;494:/*
;495:===============
;496:G_CheckBotSpawn
;497:===============
;498:*/
;499:void G_CheckBotSpawn( void ) {
line 503
;500:	int		n;
;501:	char	userinfo[MAX_INFO_VALUE];
;502:
;503:	G_CheckMinimumPlayers();
ADDRGP4 G_CheckMinimumPlayers
CALLV
pop
line 505
;504:
;505:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $277
line 506
;506:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $281
line 507
;507:			continue;
ADDRGP4 $278
JUMPV
LABELV $281
line 509
;508:		}
;509:		if ( botSpawnQueue[n].spawnTime > level.time ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $284
line 510
;510:			continue;
ADDRGP4 $278
JUMPV
LABELV $284
line 512
;511:		}
;512:		ClientBegin( botSpawnQueue[n].clientNum );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 513
;513:		botSpawnQueue[n].spawnTime = 0;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
CNSTI4 0
ASGNI4
line 515
;514:
;515:		if( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $289
line 516
;516:			trap_GetUserinfo( botSpawnQueue[n].clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 517
;517:			PlayerIntroSound( Info_ValueForKey (userinfo, "model") );
ADDRLP4 4
ARGP4
ADDRGP4 $292
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 PlayerIntroSound
CALLV
pop
line 518
;518:		}
LABELV $289
line 519
;519:	}
LABELV $278
line 505
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $277
line 520
;520:}
LABELV $276
endproc G_CheckBotSpawn 1032 12
proc AddBotToSpawnQueue 4 4
line 528
;521:
;522:
;523:/*
;524:===============
;525:AddBotToSpawnQueue
;526:===============
;527:*/
;528:static void AddBotToSpawnQueue( int clientNum, int delay ) {
line 531
;529:	int		n;
;530:
;531:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $294
line 532
;532:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $298
line 533
;533:			botSpawnQueue[n].spawnTime = level.time + delay;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 534
;534:			botSpawnQueue[n].clientNum = clientNum;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 535
;535:			return;
ADDRGP4 $293
JUMPV
LABELV $298
line 537
;536:		}
;537:	}
LABELV $295
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
LTI4 $294
line 538
;538:        G_Printf( S_COLOR_YELLOW "Unable to delay spawn\n" );
ADDRGP4 $303
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 539
;539:	ClientBegin( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 540
;540:}
LABELV $293
endproc AddBotToSpawnQueue 4 4
export G_RemoveQueuedBotBegin
proc G_RemoveQueuedBotBegin 4 0
line 551
;541:
;542:
;543:/*
;544:===============
;545:G_RemoveQueuedBotBegin
;546:
;547:Called on client disconnect to make sure the delayed spawn
;548:doesn't happen on a freed index
;549:===============
;550:*/
;551:void G_RemoveQueuedBotBegin( int clientNum ) {
line 554
;552:	int		n;
;553:
;554:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $305
line 555
;555:		if( botSpawnQueue[n].clientNum == clientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $309
line 556
;556:			botSpawnQueue[n].spawnTime = 0;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
CNSTI4 0
ASGNI4
line 557
;557:			return;
ADDRGP4 $304
JUMPV
LABELV $309
line 559
;558:		}
;559:	}
LABELV $306
line 554
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $305
line 560
;560:}
LABELV $304
endproc G_RemoveQueuedBotBegin 4 0
export G_BotConnect
proc G_BotConnect 1192 12
line 568
;561:
;562:
;563:/*
;564:===============
;565:G_BotConnect
;566:===============
;567:*/
;568:qboolean G_BotConnect( int clientNum, qboolean restart ) {
line 572
;569:	bot_settings_t	settings;
;570:	char			userinfo[MAX_INFO_STRING];
;571:
;572:	trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 574
;573:
;574:	Q_strncpyz( settings.characterfile, Info_ValueForKey( userinfo, "characterfile" ), sizeof(settings.characterfile) );
ADDRLP4 148
ARGP4
ADDRGP4 $313
ARGP4
ADDRLP4 1172
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1172
INDIRP4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 575
;575:	settings.skill = atof( Info_ValueForKey( userinfo, "skill" ) );
ADDRLP4 148
ARGP4
ADDRGP4 $315
ARGP4
ADDRLP4 1176
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1176
INDIRP4
ARGP4
ADDRLP4 1180
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0+144
ADDRLP4 1180
INDIRF4
ASGNF4
line 577
;576:
;577:	if (!trap_AAS_Initialized() || !BotAISetupClient( clientNum, &settings, restart )) {
ADDRLP4 1184
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 1184
INDIRI4
CNSTI4 0
EQI4 $318
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 1188
ADDRGP4 BotAISetupClient
CALLI4
ASGNI4
ADDRLP4 1188
INDIRI4
CNSTI4 0
NEI4 $316
LABELV $318
line 578
;578:		trap_DropClient( clientNum, "BotAISetupClient failed" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $319
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 579
;579:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $312
JUMPV
LABELV $316
line 582
;580:	}
;581:
;582:	return qtrue;
CNSTI4 1
RETI4
LABELV $312
endproc G_BotConnect 1192 12
proc G_AddBot 1128 12
line 591
;583:}
;584:
;585:
;586:/*
;587:===============
;588:G_AddBot
;589:===============
;590:*/
;591:static void G_AddBot( const char *name, float skill, const char *team, int delay, char *altname) {
line 604
;592:	int				clientNum;
;593:	int				teamNum;
;594:	int				botinfoNum;
;595:	char			*botinfo;
;596:	char			*key;
;597:	char			*s;
;598:	char			*botname;
;599:	char			*model;
;600:	char			*headmodel;
;601:	char			userinfo[MAX_INFO_STRING];
;602:
;603:	// have the server allocate a client slot
;604:	clientNum = trap_BotAllocateClient();
ADDRLP4 1060
ADDRGP4 trap_BotAllocateClient
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1060
INDIRI4
ASGNI4
line 605
;605:	if ( clientNum == -1 ) {
ADDRLP4 1036
INDIRI4
CNSTI4 -1
NEI4 $321
line 606
;606:		G_Printf( S_COLOR_RED "Unable to add bot. All player slots are in use.\n" );
ADDRGP4 $323
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 607
;607:		G_Printf( S_COLOR_RED "Start server with more 'open' slots (or check setting of sv_maxclients cvar).\n" );
ADDRGP4 $324
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 608
;608:		return;
ADDRGP4 $320
JUMPV
LABELV $321
line 612
;609:	}
;610:
;611:	// set default team
;612:	if( !team || !*team ) {
ADDRLP4 1064
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $327
ADDRLP4 1064
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $325
LABELV $327
line 613
;613:		if( GAMETYPE_IS_A_TEAM_GAME(g_gametype.integer) ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
EQI4 $328
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $328
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $328
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
EQI4 $328
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
EQI4 $328
line 614
;614:			if( PickTeam(clientNum) == TEAM_RED) {
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1068
ADDRGP4 PickTeam
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 1
NEI4 $335
line 615
;615:				team = "red";
ADDRFP4 8
ADDRGP4 $175
ASGNP4
line 616
;616:			}
ADDRGP4 $329
JUMPV
LABELV $335
line 617
;617:			else {
line 618
;618:				team = "blue";
ADDRFP4 8
ADDRGP4 $178
ASGNP4
line 619
;619:			}
line 620
;620:		}
ADDRGP4 $329
JUMPV
LABELV $328
line 621
;621:		else {
line 622
;622:			team = "free";
ADDRFP4 8
ADDRGP4 $179
ASGNP4
line 623
;623:		}
LABELV $329
line 624
;624:	}
LABELV $325
line 627
;625:
;626:	// get the botinfo from bots.txt
;627:	if ( Q_strequal( name, "random" ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $339
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $337
line 628
;628:		if ( Q_strequal( team, "red" ) || Q_strequal( team, "r" ) ) {
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $175
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
EQI4 $343
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $342
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $340
LABELV $343
line 629
;629:			teamNum = TEAM_RED;
ADDRLP4 1056
CNSTI4 1
ASGNI4
line 630
;630:		}
ADDRGP4 $341
JUMPV
LABELV $340
line 631
;631:		else if ( Q_strequal( team, "blue" ) || Q_strequal( team, "b" ) ) {
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
EQI4 $347
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $346
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $344
LABELV $347
line 632
;632:			teamNum = TEAM_BLUE;
ADDRLP4 1056
CNSTI4 2
ASGNI4
line 633
;633:		}
ADDRGP4 $345
JUMPV
LABELV $344
line 634
;634:		else if ( Q_strequal( team, "spectator" ) || Q_strequal( team, "s" ) ) {
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $350
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
EQI4 $352
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $351
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $348
LABELV $352
line 635
;635:			teamNum = TEAM_SPECTATOR;
ADDRLP4 1056
CNSTI4 3
ASGNI4
line 636
;636:		}
ADDRGP4 $349
JUMPV
LABELV $348
line 637
;637:		else {
line 638
;638:			teamNum = TEAM_FREE;
ADDRLP4 1056
CNSTI4 0
ASGNI4
line 639
;639:		}
LABELV $349
LABELV $345
LABELV $341
line 641
;640:
;641:		botinfoNum = G_SelectRandomBotInfo( teamNum );
ADDRLP4 1056
INDIRI4
ARGI4
ADDRLP4 1096
ADDRGP4 G_SelectRandomBotInfo
CALLI4
ASGNI4
ADDRLP4 1052
ADDRLP4 1096
INDIRI4
ASGNI4
line 643
;642:
;643:		if ( botinfoNum < 0 ) {
ADDRLP4 1052
INDIRI4
CNSTI4 0
GEI4 $353
line 644
;644:			G_Printf( S_COLOR_RED "Error: Cannot add random bot, no bot info available.\n" );
ADDRGP4 $355
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 645
;645:			trap_BotFreeClient( clientNum );
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeClient
CALLV
pop
line 646
;646:			return;
ADDRGP4 $320
JUMPV
LABELV $353
line 649
;647:		}
;648:
;649:		botinfo = G_GetBotInfoByNumber( botinfoNum );
ADDRLP4 1052
INDIRI4
ARGI4
ADDRLP4 1100
ADDRGP4 G_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1100
INDIRP4
ASGNP4
line 650
;650:	}
ADDRGP4 $338
JUMPV
LABELV $337
line 651
;651:	else {
line 652
;652:		botinfo = G_GetBotInfoByName( name );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 G_GetBotInfoByName
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1072
INDIRP4
ASGNP4
line 653
;653:	}
LABELV $338
line 655
;654:
;655:	if ( !botinfo ) {
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $356
line 656
;656:		G_Printf( S_COLOR_RED "Error: Bot '%s' not defined\n", name );
ADDRGP4 $358
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 657
;657:		trap_BotFreeClient( clientNum );
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeClient
CALLV
pop
line 658
;658:		return;
ADDRGP4 $320
JUMPV
LABELV $356
line 662
;659:	}
;660:
;661:	// create the bot's userinfo
;662:	userinfo[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 664
;663:
;664:	botname = Info_ValueForKey( botinfo, "funname" );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 $160
ARGP4
ADDRLP4 1072
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
ADDRLP4 1072
INDIRP4
ASGNP4
line 665
;665:	if( !botname[0] ) {
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $359
line 666
;666:		botname = Info_ValueForKey( botinfo, "name" );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 1076
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
ADDRLP4 1076
INDIRP4
ASGNP4
line 667
;667:	}
LABELV $359
line 669
;668:	// check for an alternative name
;669:	if (altname && altname[0]) {
ADDRLP4 1076
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1076
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $361
ADDRLP4 1076
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $361
line 670
;670:		botname = altname;
ADDRLP4 1048
ADDRFP4 16
INDIRP4
ASGNP4
line 671
;671:	}
LABELV $361
line 672
;672:	Info_SetValueForKey( userinfo, "name", botname );
ADDRLP4 4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 673
;673:	Info_SetValueForKey( userinfo, "rate", "25000" );
ADDRLP4 4
ARGP4
ADDRGP4 $363
ARGP4
ADDRGP4 $364
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 674
;674:	Info_SetValueForKey( userinfo, "snaps", "20" );
ADDRLP4 4
ARGP4
ADDRGP4 $365
ARGP4
ADDRGP4 $366
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 675
;675:	Info_SetValueForKey( userinfo, "skill", va("%.2f", skill) );
ADDRGP4 $367
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 1080
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRGP4 $315
ARGP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 676
;676:	Info_SetValueForKey( userinfo, "teampref", team );
ADDRLP4 4
ARGP4
ADDRGP4 $368
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 678
;677:
;678:	if ( skill >= 1 && skill < 2 ) {
ADDRLP4 1084
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1084
INDIRF4
CNSTF4 1065353216
LTF4 $369
ADDRLP4 1084
INDIRF4
CNSTF4 1073741824
GEF4 $369
line 679
;679:		Info_SetValueForKey( userinfo, "handicap", "50" );
ADDRLP4 4
ARGP4
ADDRGP4 $371
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 680
;680:	}
ADDRGP4 $370
JUMPV
LABELV $369
line 681
;681:	else if ( skill >= 2 && skill < 3 ) {
ADDRLP4 1088
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1088
INDIRF4
CNSTF4 1073741824
LTF4 $373
ADDRLP4 1088
INDIRF4
CNSTF4 1077936128
GEF4 $373
line 682
;682:		Info_SetValueForKey( userinfo, "handicap", "70" );
ADDRLP4 4
ARGP4
ADDRGP4 $371
ARGP4
ADDRGP4 $375
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 683
;683:	}
ADDRGP4 $374
JUMPV
LABELV $373
line 684
;684:	else if ( skill >= 3 && skill < 4 ) {
ADDRLP4 1092
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1092
INDIRF4
CNSTF4 1077936128
LTF4 $376
ADDRLP4 1092
INDIRF4
CNSTF4 1082130432
GEF4 $376
line 685
;685:		Info_SetValueForKey( userinfo, "handicap", "90" );
ADDRLP4 4
ARGP4
ADDRGP4 $371
ARGP4
ADDRGP4 $378
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 686
;686:	}
LABELV $376
LABELV $374
LABELV $370
line 688
;687:
;688:	key = "model";
ADDRLP4 0
ADDRGP4 $292
ASGNP4
line 689
;689:	model = Info_ValueForKey( botinfo, key );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1096
INDIRP4
ASGNP4
line 690
;690:	if ( !*model ) {
ADDRLP4 1040
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $379
line 691
;691:		model = "sarge/default";
ADDRLP4 1040
ADDRGP4 $381
ASGNP4
line 692
;692:	}
LABELV $379
line 693
;693:	Info_SetValueForKey( userinfo, key, model );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 694
;694:	key = "team_model";
ADDRLP4 0
ADDRGP4 $382
ASGNP4
line 695
;695:	Info_SetValueForKey( userinfo, key, model );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 697
;696:
;697:	key = "headmodel";
ADDRLP4 0
ADDRGP4 $383
ASGNP4
line 698
;698:	headmodel = Info_ValueForKey( botinfo, key );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
ADDRLP4 1100
INDIRP4
ASGNP4
line 699
;699:	if ( !*headmodel ) {
ADDRLP4 1044
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $384
line 700
;700:		headmodel = model;
ADDRLP4 1044
ADDRLP4 1040
INDIRP4
ASGNP4
line 701
;701:	}
LABELV $384
line 702
;702:	Info_SetValueForKey( userinfo, key, headmodel );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 703
;703:	key = "team_headmodel";
ADDRLP4 0
ADDRGP4 $386
ASGNP4
line 704
;704:	Info_SetValueForKey( userinfo, key, headmodel );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 706
;705:
;706:	key = "gender";
ADDRLP4 0
ADDRGP4 $387
ASGNP4
line 707
;707:	s = Info_ValueForKey( botinfo, key );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1104
INDIRP4
ASGNP4
line 708
;708:	if ( !*s ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $388
line 709
;709:		s = "male";
ADDRLP4 1028
ADDRGP4 $390
ASGNP4
line 710
;710:	}
LABELV $388
line 711
;711:	Info_SetValueForKey( userinfo, "sex", s );
ADDRLP4 4
ARGP4
ADDRGP4 $391
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 713
;712:
;713:	key = "color1";
ADDRLP4 0
ADDRGP4 $392
ASGNP4
line 714
;714:	s = Info_ValueForKey( botinfo, key );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1108
INDIRP4
ASGNP4
line 715
;715:	if ( !*s ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $393
line 716
;716:		s = "4";
ADDRLP4 1028
ADDRGP4 $395
ASGNP4
line 717
;717:	}
LABELV $393
line 718
;718:	Info_SetValueForKey( userinfo, key, s );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 720
;719:
;720:	key = "color2";
ADDRLP4 0
ADDRGP4 $396
ASGNP4
line 721
;721:	s = Info_ValueForKey( botinfo, key );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1112
INDIRP4
ASGNP4
line 722
;722:	if ( !*s ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $397
line 723
;723:		s = "5";
ADDRLP4 1028
ADDRGP4 $399
ASGNP4
line 724
;724:	}
LABELV $397
line 725
;725:	Info_SetValueForKey( userinfo, key, s );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 727
;726:
;727:	s = Info_ValueForKey(botinfo, "aifile");
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 $400
ARGP4
ADDRLP4 1116
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1116
INDIRP4
ASGNP4
line 728
;728:	if (!*s ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $401
line 729
;729:		trap_Printf( S_COLOR_RED "Error: bot has no aifile specified\n" );
ADDRGP4 $403
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 730
;730:		trap_BotFreeClient( clientNum );
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeClient
CALLV
pop
line 731
;731:		return;
ADDRGP4 $320
JUMPV
LABELV $401
line 733
;732:	}
;733:	Info_SetValueForKey( userinfo, "characterfile", s );
ADDRLP4 4
ARGP4
ADDRGP4 $313
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 736
;734:
;735:	// don't send tinfo to bots, they don't parse it
;736:	Info_SetValueForKey( userinfo, "teamoverlay", "0" );
ADDRLP4 4
ARGP4
ADDRGP4 $404
ARGP4
ADDRGP4 $405
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 739
;737:
;738:	// register the userinfo
;739:	trap_SetUserinfo( clientNum, userinfo );
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 742
;740:
;741:	// have it connect to the game as a normal client
;742:	if ( ClientConnect( clientNum, qtrue, qtrue ) ) {
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1120
CNSTI4 1
ASGNI4
ADDRLP4 1120
INDIRI4
ARGI4
ADDRLP4 1120
INDIRI4
ARGI4
ADDRLP4 1124
ADDRGP4 ClientConnect
CALLP4
ASGNP4
ADDRLP4 1124
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $406
line 743
;743:		return;
ADDRGP4 $320
JUMPV
LABELV $406
line 746
;744:	}
;745:
;746:	if( delay == 0 ) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $408
line 747
;747:		ClientBegin( clientNum );
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 748
;748:		return;
ADDRGP4 $320
JUMPV
LABELV $408
line 751
;749:	}
;750:
;751:	AddBotToSpawnQueue( clientNum, delay );
ADDRLP4 1036
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 AddBotToSpawnQueue
CALLV
pop
line 752
;752:}
LABELV $320
endproc G_AddBot 1128 12
export Svcmd_AddBot_f
proc Svcmd_AddBot_f 4120 20
line 760
;753:
;754:
;755:/*
;756:===============
;757:Svcmd_AddBot_f
;758:===============
;759:*/
;760:void Svcmd_AddBot_f( void ) {
line 769
;761:	float			skill;
;762:	int				delay;
;763:	char			name[MAX_TOKEN_CHARS];
;764:	char			altname[MAX_TOKEN_CHARS];
;765:	char			string[MAX_TOKEN_CHARS];
;766:	char			team[MAX_TOKEN_CHARS];
;767:
;768:	// are bots enabled?
;769:	if ( !trap_Cvar_VariableIntegerValue( "bot_enable" ) || !trap_AAS_Initialized() ) {
ADDRGP4 $413
ARGP4
ADDRLP4 4104
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 4104
INDIRI4
CNSTI4 0
EQI4 $414
ADDRLP4 4108
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 4108
INDIRI4
CNSTI4 0
NEI4 $411
LABELV $414
line 770
;770:		return;
ADDRGP4 $410
JUMPV
LABELV $411
line 774
;771:	}
;772:
;773:	// name
;774:	trap_Argv( 1, name, sizeof( name ) );
CNSTI4 1
ARGI4
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 775
;775:	if ( !name[0] ) {
ADDRLP4 1024
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $415
line 776
;776:		trap_Printf( "Usage: Addbot <botname> [skill 1-5] [team] [msec delay] [altname]\n" );
ADDRGP4 $417
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 777
;777:		return;
ADDRGP4 $410
JUMPV
LABELV $415
line 781
;778:	}
;779:
;780:	// skill
;781:	trap_Argv( 2, string, sizeof( string ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 782
;782:	if ( !string[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $418
line 783
;783:		skill = 4;
ADDRLP4 4096
CNSTF4 1082130432
ASGNF4
line 784
;784:	}
ADDRGP4 $419
JUMPV
LABELV $418
line 785
;785:	else {
line 786
;786:		skill = Com_Clamp( 1, 5, atof( string ) );
ADDRLP4 0
ARGP4
ADDRLP4 4112
ADDRGP4 atof
CALLF4
ASGNF4
CNSTF4 1065353216
ARGF4
CNSTF4 1084227584
ARGF4
ADDRLP4 4112
INDIRF4
ARGF4
ADDRLP4 4116
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 4096
ADDRLP4 4116
INDIRF4
ASGNF4
line 787
;787:	}
LABELV $419
line 790
;788:
;789:	// team
;790:	trap_Argv( 3, team, sizeof( team ) );
CNSTI4 3
ARGI4
ADDRLP4 3072
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 793
;791:
;792:	// delay
;793:	trap_Argv( 4, string, sizeof( string ) );
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 794
;794:	if ( !string[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $420
line 795
;795:		delay = 0;
ADDRLP4 4100
CNSTI4 0
ASGNI4
line 796
;796:	}
ADDRGP4 $421
JUMPV
LABELV $420
line 797
;797:	else {
line 798
;798:		delay = atoi( string );
ADDRLP4 0
ARGP4
ADDRLP4 4112
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4100
ADDRLP4 4112
INDIRI4
ASGNI4
line 799
;799:	}
LABELV $421
line 802
;800:
;801:	// alternative name
;802:	trap_Argv( 5, altname, sizeof( altname ) );
CNSTI4 5
ARGI4
ADDRLP4 2048
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 804
;803:
;804:	G_AddBot( name, skill, team, delay, altname );
ADDRLP4 1024
ARGP4
ADDRLP4 4096
INDIRF4
ARGF4
ADDRLP4 3072
ARGP4
ADDRLP4 4100
INDIRI4
ARGI4
ADDRLP4 2048
ARGP4
ADDRGP4 G_AddBot
CALLV
pop
line 808
;805:
;806:	// if this was issued during gameplay and we are playing locally,
;807:	// go ahead and load the bot's media immediately
;808:	if ( level.time - level.startTime > 1000 &&
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+40
INDIRI4
SUBI4
CNSTI4 1000
LEI4 $422
ADDRGP4 $426
ARGP4
ADDRLP4 4112
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 4112
INDIRI4
CNSTI4 0
EQI4 $422
line 809
;809:		trap_Cvar_VariableIntegerValue( "cl_running" ) ) {
line 810
;810:		trap_SendServerCommand( -1, "loaddefered\n" );	// FIXME: spelled wrong, but not changing for demo
CNSTI4 -1
ARGI4
ADDRGP4 $427
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 811
;811:	}
LABELV $422
line 812
;812:}
LABELV $410
endproc Svcmd_AddBot_f 4120 20
export Svcmd_BotList_f
proc Svcmd_BotList_f 4120 20
line 819
;813:
;814:/*
;815:===============
;816:Svcmd_BotList_f
;817:===============
;818:*/
;819:void Svcmd_BotList_f( void ) {
line 826
;820:	int i;
;821:	char name[MAX_TOKEN_CHARS];
;822:	char funname[MAX_TOKEN_CHARS];
;823:	char model[MAX_TOKEN_CHARS];
;824:	char aifile[MAX_TOKEN_CHARS];
;825:
;826:	trap_Printf("^1name             model            aifile              funname\n");
ADDRGP4 $429
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 827
;827:	for (i = 0; i < g_numBots; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $433
JUMPV
LABELV $430
line 828
;828:		Q_strncpyz(name, Info_ValueForKey( g_botInfos[i], "name" ), sizeof( name ));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 4100
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 4100
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 829
;829:		if ( !*name ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $434
line 830
;830:			strcpy(name, "UnnamedPlayer");
ADDRLP4 4
ARGP4
ADDRGP4 $436
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 831
;831:		}
LABELV $434
line 832
;832:		Q_strncpyz(funname, Info_ValueForKey( g_botInfos[i], "funname" ), sizeof( funname ));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $160
ARGP4
ADDRLP4 4104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ARGP4
ADDRLP4 4104
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 833
;833:		if ( !*funname ) {
ADDRLP4 1028
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $437
line 834
;834:			strcpy(funname, "");
ADDRLP4 1028
ARGP4
ADDRGP4 $102
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 835
;835:		}
LABELV $437
line 836
;836:		Q_strncpyz(model, Info_ValueForKey( g_botInfos[i], "model" ), sizeof( model ));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $292
ARGP4
ADDRLP4 4108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2052
ARGP4
ADDRLP4 4108
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 837
;837:		if ( !*model ) {
ADDRLP4 2052
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $439
line 838
;838:			strcpy(model, "sarge/default");
ADDRLP4 2052
ARGP4
ADDRGP4 $381
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 839
;839:		}
LABELV $439
line 840
;840:		Q_strncpyz(aifile, Info_ValueForKey( g_botInfos[i], "aifile"), sizeof( aifile ));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $400
ARGP4
ADDRLP4 4112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3076
ARGP4
ADDRLP4 4112
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 841
;841:		if (!*aifile ) {
ADDRLP4 3076
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $441
line 842
;842:			strcpy(aifile, "bots/default_c.c");
ADDRLP4 3076
ARGP4
ADDRGP4 $443
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 843
;843:		}
LABELV $441
line 844
;844:		trap_Printf(va("%-16s %-16s %-20s %-20s\n", name, model, aifile, funname));
ADDRGP4 $444
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 2052
ARGP4
ADDRLP4 3076
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 4116
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4116
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 845
;845:	}
LABELV $431
line 827
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $433
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $430
line 846
;846:}
LABELV $428
endproc Svcmd_BotList_f 4120 20
proc G_SpawnBots 1044 16
line 854
;847:
;848:
;849:/*
;850:===============
;851:G_SpawnBots
;852:===============
;853:*/
;854:static void G_SpawnBots( char *botList, int baseDelay ) {
line 860
;855:	char		*bot;
;856:	char		*p;
;857:	int			delay;
;858:	char		bots[MAX_INFO_VALUE];
;859:
;860:	podium1 = NULL;
ADDRGP4 podium1
CNSTP4 0
ASGNP4
line 861
;861:	podium2 = NULL;
ADDRGP4 podium2
CNSTP4 0
ASGNP4
line 862
;862:	podium3 = NULL;
ADDRGP4 podium3
CNSTP4 0
ASGNP4
line 864
;863:
;864:	if( g_spSkill.integer < 1 ) {
ADDRGP4 g_spSkill+12
INDIRI4
CNSTI4 1
GEI4 $446
line 865
;865:		g_spSkill.integer = 1;
ADDRGP4 g_spSkill+12
CNSTI4 1
ASGNI4
line 866
;866:	}
ADDRGP4 $447
JUMPV
LABELV $446
line 867
;867:	else if ( g_spSkill.integer > 5 ) {
ADDRGP4 g_spSkill+12
INDIRI4
CNSTI4 5
LEI4 $450
line 868
;868:		g_spSkill.integer = 5;
ADDRGP4 g_spSkill+12
CNSTI4 5
ASGNI4
line 869
;869:	}
LABELV $450
LABELV $447
line 871
;870:
;871:	Q_strncpyz( bots, botList, sizeof(bots) );
ADDRLP4 12
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 872
;872:	p = &bots[0];
ADDRLP4 0
ADDRLP4 12
ASGNP4
line 873
;873:	delay = baseDelay;
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $455
JUMPV
line 874
;874:	while( *p ) {
LABELV $457
line 876
;875:		//skip spaces
;876:		while( *p == ' ' ) {
line 877
;877:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 878
;878:		}
LABELV $458
line 876
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $457
line 879
;879:		if( !*p ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $460
line 880
;880:			break;
ADDRGP4 $456
JUMPV
LABELV $460
line 884
;881:		}
;882:
;883:		// mark start of bot name
;884:		bot = p;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $463
JUMPV
LABELV $462
line 887
;885:
;886:		// skip until space of null
;887:		while( *p && *p != ' ' ) {
line 888
;888:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 889
;889:		}
LABELV $463
line 887
ADDRLP4 1036
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $465
ADDRLP4 1036
INDIRI4
CNSTI4 32
NEI4 $462
LABELV $465
line 890
;890:		if( *p ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $466
line 891
;891:			*p++ = 0;
ADDRLP4 1040
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1040
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI1 0
ASGNI1
line 892
;892:		}
LABELV $466
line 896
;893:
;894:		// we must add the bot this way, calling G_AddBot directly at this stage
;895:		// does "Bad Things"
;896:		trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s %f free %i\n", bot, g_spSkill.integer, delay) );
ADDRGP4 $468
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 g_spSkill+12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1040
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 898
;897:
;898:		delay += BOT_BEGIN_DELAY_INCREMENT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1500
ADDI4
ASGNI4
line 899
;899:	}
LABELV $455
line 874
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $458
LABELV $456
line 900
;900:}
LABELV $445
endproc G_SpawnBots 1044 16
proc G_LoadBotsFromFile 8216 16
line 908
;901:
;902:
;903:/*
;904:===============
;905:G_LoadBotsFromFile
;906:===============
;907:*/
;908:static void G_LoadBotsFromFile( char *filename ) {
line 913
;909:	int				len;
;910:	fileHandle_t	f;
;911:	char			buf[MAX_BOTS_TEXT];
;912:
;913:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8200
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8200
INDIRI4
ASGNI4
line 914
;914:	if ( !f ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $471
line 915
;915:		trap_Printf( va( S_COLOR_RED "file not found: %s\n", filename ) );
ADDRGP4 $96
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 916
;916:		return;
ADDRGP4 $470
JUMPV
LABELV $471
line 918
;917:	}
;918:	if ( len >= MAX_BOTS_TEXT ) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $473
line 919
;919:		trap_Printf( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i\n", filename, len, MAX_BOTS_TEXT ) );
ADDRGP4 $99
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8192
ARGI4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 920
;920:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 921
;921:		return;
ADDRGP4 $470
JUMPV
LABELV $473
line 924
;922:	}
;923:
;924:	trap_FS_Read( buf, len, f );
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 925
;925:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 926
;926:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 928
;927:
;928:	g_numBots += G_ParseInfos( buf, MAX_BOTS - g_numBots, &g_botInfos[g_numBots] );
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 g_numBots
ASGNP4
ADDRLP4 8208
ADDRLP4 8204
INDIRP4
INDIRI4
ASGNI4
CNSTI4 1024
ADDRLP4 8208
INDIRI4
SUBI4
ARGI4
ADDRLP4 8208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 G_ParseInfos
CALLI4
ASGNI4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRI4
ADDRLP4 8212
INDIRI4
ADDI4
ASGNI4
line 929
;929:}
LABELV $470
endproc G_LoadBotsFromFile 8216 16
proc G_LoadBots 1456 16
line 936
;930:
;931:/*
;932:===============
;933:G_LoadBots
;934:===============
;935:*/
;936:static void G_LoadBots( void ) {
line 945
;937:	vmCvar_t	botsFile;
;938:	int			numdirs;
;939:	char		filename[128];
;940:	char		dirlist[1024];
;941:	char*		dirptr;
;942:	int			i;
;943:	int			dirlen;
;944:
;945:	if ( !trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $413
ARGP4
ADDRLP4 1440
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 1440
INDIRI4
CNSTI4 0
NEI4 $476
line 946
;946:		return;
ADDRGP4 $475
JUMPV
LABELV $476
line 949
;947:	}
;948:
;949:	g_numBots = 0;
ADDRGP4 g_numBots
CNSTI4 0
ASGNI4
line 951
;950:
;951:	trap_Cvar_Register( &botsFile, "g_botsFile", "", CVAR_INIT|CVAR_ROM );
ADDRLP4 144
ARGP4
ADDRGP4 $478
ARGP4
ADDRGP4 $102
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 952
;952:	if( *botsFile.string ) {
ADDRLP4 144+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $479
line 953
;953:		G_LoadBotsFromFile(botsFile.string);
ADDRLP4 144+16
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 954
;954:	}
ADDRGP4 $480
JUMPV
LABELV $479
line 955
;955:	else {
line 956
;956:		G_LoadBotsFromFile("scripts/bots.txt");
ADDRGP4 $483
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 957
;957:	}
LABELV $480
line 960
;958:
;959:	// get all bots from .bot files
;960:	numdirs = trap_FS_GetFileList("scripts", ".bot", dirlist, 1024 );
ADDRGP4 $108
ARGP4
ADDRGP4 $484
ARGP4
ADDRLP4 416
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1444
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 1444
INDIRI4
ASGNI4
line 961
;961:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 416
ASGNP4
line 962
;962:	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $488
JUMPV
LABELV $485
line 963
;963:		dirlen = strlen(dirptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1448
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 136
ADDRLP4 1448
INDIRI4
ASGNI4
line 964
;964:		strcpy(filename, "scripts/");
ADDRLP4 4
ARGP4
ADDRGP4 $114
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 965
;965:		strcat(filename, dirptr);
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 966
;966:		G_LoadBotsFromFile(filename);
ADDRLP4 4
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 967
;967:	}
LABELV $486
line 962
ADDRLP4 1448
CNSTI4 1
ASGNI4
ADDRLP4 132
ADDRLP4 132
INDIRI4
ADDRLP4 1448
INDIRI4
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 136
INDIRI4
ADDRLP4 1448
INDIRI4
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
LABELV $488
ADDRLP4 132
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $485
line 968
;968:	trap_Printf( va( "%i bots parsed\n", g_numBots ) );
ADDRGP4 $489
ARGP4
ADDRGP4 g_numBots
INDIRI4
ARGI4
ADDRLP4 1452
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1452
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 969
;969:}
LABELV $475
endproc G_LoadBots 1456 16
export G_GetBotInfoByNumber
proc G_GetBotInfoByNumber 8 8
line 978
;970:
;971:
;972:
;973:/*
;974:===============
;975:G_GetBotInfoByNumber
;976:===============
;977:*/
;978:char *G_GetBotInfoByNumber( int num ) {
line 979
;979:	if( num < 0 || num >= g_numBots ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $493
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $491
LABELV $493
line 980
;980:		trap_Printf( va( S_COLOR_RED "Invalid bot number: %i\n", num ) );
ADDRGP4 $494
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 981
;981:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $490
JUMPV
LABELV $491
line 983
;982:	}
;983:	return g_botInfos[num];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
RETP4
LABELV $490
endproc G_GetBotInfoByNumber 8 8
export G_GetBotInfoByName
proc G_GetBotInfoByName 16 8
line 992
;984:}
;985:
;986:
;987:/*
;988:===============
;989:G_GetBotInfoByName
;990:===============
;991:*/
;992:char *G_GetBotInfoByName( const char *name ) {
line 996
;993:	int		n;
;994:	char	*value;
;995:
;996:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $499
JUMPV
LABELV $496
line 997
;997:		value = Info_ValueForKey( g_botInfos[n], "name" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 998
;998:		if ( Q_strequal( value, name ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $500
line 999
;999:			return g_botInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $495
JUMPV
LABELV $500
line 1001
;1000:		}
;1001:	}
LABELV $497
line 996
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $499
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $496
line 1003
;1002:
;1003:	return NULL;
CNSTP4 0
RETP4
LABELV $495
endproc G_GetBotInfoByName 16 8
export G_InitBots
proc G_InitBots 1148 16
line 1011
;1004:}
;1005:
;1006:/*
;1007:===============
;1008:G_InitBots
;1009:===============
;1010:*/
;1011:void G_InitBots( qboolean restart ) {
line 1020
;1012:	int			fragLimit;
;1013:	int			timeLimit;
;1014:	const char	*arenainfo;
;1015:	char		*strValue;
;1016:	int			basedelay;
;1017:	char		map[MAX_QPATH];
;1018:	char		serverinfo[MAX_INFO_STRING];
;1019:
;1020:	G_LoadBots();
ADDRGP4 G_LoadBots
CALLV
pop
line 1021
;1021:	G_LoadArenas();
ADDRGP4 G_LoadArenas
CALLV
pop
line 1023
;1022:
;1023:	trap_Cvar_Register( &bot_minplayers, "bot_minplayers", "0", CVAR_SERVERINFO );
ADDRGP4 bot_minplayers
ARGP4
ADDRGP4 $503
ARGP4
ADDRGP4 $405
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1024
;1024:	trap_Cvar_Register( &bot_autominplayers, "bot_autominplayers", "0", CVAR_SERVERINFO );
ADDRGP4 bot_autominplayers
ARGP4
ADDRGP4 $504
ARGP4
ADDRGP4 $405
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1026
;1025:
;1026:	if( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $505
line 1027
;1027:		trap_GetServerinfo( serverinfo, sizeof(serverinfo) );
ADDRLP4 84
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 1028
;1028:		Q_strncpyz( map, Info_ValueForKey( serverinfo, "mapname" ), sizeof(map) );
ADDRLP4 84
ARGP4
ADDRGP4 $508
ARGP4
ADDRLP4 1108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ARGP4
ADDRLP4 1108
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1029
;1029:		arenainfo = G_GetArenaInfoByMap( map );
ADDRLP4 20
ARGP4
ADDRLP4 1112
ADDRGP4 G_GetArenaInfoByMap
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1112
INDIRP4
ASGNP4
line 1030
;1030:		if ( !arenainfo ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $509
line 1031
;1031:			return;
ADDRGP4 $502
JUMPV
LABELV $509
line 1034
;1032:		}
;1033:
;1034:		strValue = Info_ValueForKey( arenainfo, "fraglimit" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $511
ARGP4
ADDRLP4 1116
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1116
INDIRP4
ASGNP4
line 1035
;1035:		fragLimit = atoi( strValue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1120
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 1120
INDIRI4
ASGNI4
line 1036
;1036:		if ( fragLimit ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $512
line 1037
;1037:			trap_Cvar_Set( "fraglimit", strValue );
ADDRGP4 $511
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1038
;1038:		}
ADDRGP4 $513
JUMPV
LABELV $512
line 1039
;1039:		else {
line 1040
;1040:			trap_Cvar_Set( "fraglimit", "0" );
ADDRGP4 $511
ARGP4
ADDRGP4 $405
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1041
;1041:		}
LABELV $513
line 1043
;1042:
;1043:		strValue = Info_ValueForKey( arenainfo, "timelimit" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $514
ARGP4
ADDRLP4 1124
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1124
INDIRP4
ASGNP4
line 1044
;1044:		timeLimit = atoi( strValue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1128
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 1128
INDIRI4
ASGNI4
line 1045
;1045:		if ( timeLimit ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $515
line 1046
;1046:			trap_Cvar_Set( "timelimit", strValue );
ADDRGP4 $514
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1047
;1047:		}
ADDRGP4 $516
JUMPV
LABELV $515
line 1048
;1048:		else {
line 1049
;1049:			trap_Cvar_Set( "timelimit", "0" );
ADDRGP4 $514
ARGP4
ADDRGP4 $405
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1050
;1050:		}
LABELV $516
line 1052
;1051:
;1052:		if ( !fragLimit && !timeLimit ) {
ADDRLP4 1132
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 1132
INDIRI4
NEI4 $517
ADDRLP4 16
INDIRI4
ADDRLP4 1132
INDIRI4
NEI4 $517
line 1053
;1053:			trap_Cvar_Set( "fraglimit", "10" );
ADDRGP4 $511
ARGP4
ADDRGP4 $519
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1054
;1054:			trap_Cvar_Set( "timelimit", "0" );
ADDRGP4 $514
ARGP4
ADDRGP4 $405
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1055
;1055:		}
LABELV $517
line 1057
;1056:
;1057:		basedelay = BOT_BEGIN_DELAY_BASE;
ADDRLP4 8
CNSTI4 2000
ASGNI4
line 1058
;1058:		strValue = Info_ValueForKey( arenainfo, "special" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $520
ARGP4
ADDRLP4 1136
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1136
INDIRP4
ASGNP4
line 1059
;1059:		if( Q_strequal( strValue, "training" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $523
ARGP4
ADDRLP4 1140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1140
INDIRI4
CNSTI4 0
NEI4 $521
line 1060
;1060:			basedelay += 10000;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 1061
;1061:		}
LABELV $521
line 1063
;1062:
;1063:		if( !restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $506
line 1064
;1064:			G_SpawnBots( Info_ValueForKey( arenainfo, "bots" ), basedelay );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $526
ARGP4
ADDRLP4 1144
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 G_SpawnBots
CALLV
pop
line 1065
;1065:		}
line 1066
;1066:	} else {
ADDRGP4 $506
JUMPV
LABELV $505
line 1067
;1067:		if(bot_autominplayers.integer) {
ADDRGP4 bot_autominplayers+12
INDIRI4
CNSTI4 0
EQI4 $527
line 1069
;1068:			//Set bot_minplayers
;1069:			if(g_gametype.integer == GT_TOURNAMENT) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $530
line 1070
;1070:				trap_Cvar_Set("bot_minplayers","2"); //Always 2 for Tourney
ADDRGP4 $503
ARGP4
ADDRGP4 $533
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1071
;1071:			} else {
ADDRGP4 $531
JUMPV
LABELV $530
line 1072
;1072:				basedelay = MinSpawnpointCount()/2;
ADDRLP4 1108
ADDRGP4 MinSpawnpointCount
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1108
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1073
;1073:				if(basedelay < 3 && !(G_IsATeamGametype(g_gametype.integer))) {
ADDRLP4 8
INDIRI4
CNSTI4 3
GEI4 $534
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1112
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $534
line 1074
;1074:					basedelay = 3; //Minimum 3 for FFA
ADDRLP4 8
CNSTI4 3
ASGNI4
line 1075
;1075:				}
LABELV $534
line 1076
;1076:				if(basedelay < 2 && G_IsATeamGametype(g_gametype.integer)) {
ADDRLP4 8
INDIRI4
CNSTI4 2
GEI4 $537
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 1116
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
EQI4 $537
line 1077
;1077:					basedelay = 2; //Minimum 2 for TEAM
ADDRLP4 8
CNSTI4 2
ASGNI4
line 1078
;1078:				}
LABELV $537
line 1079
;1079:				trap_Cvar_Set("bot_minplayers",va("%i",basedelay) );
ADDRGP4 $121
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1120
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $503
ARGP4
ADDRLP4 1120
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1080
;1080:			}
LABELV $531
line 1081
;1081:		}
LABELV $527
line 1082
;1082:	}
LABELV $506
line 1083
;1083:}
LABELV $502
endproc G_InitBots 1148 16
import podium3
import podium2
import podium1
bss
export bot_autominplayers
align 4
LABELV bot_autominplayers
skip 272
export bot_minplayers
align 4
LABELV bot_minplayers
skip 272
align 4
LABELV botSpawnQueue
skip 128
align 4
LABELV g_arenaInfos
skip 4096
export g_numArenas
align 4
LABELV g_numArenas
skip 4
align 4
LABELV g_botInfos
skip 4096
align 4
LABELV g_numBots
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
LABELV $533
byte 1 50
byte 1 0
align 1
LABELV $526
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $523
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $520
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $519
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $514
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $511
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $508
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $504
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $503
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $494
byte 1 94
byte 1 49
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $489
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $484
byte 1 46
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $483
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $478
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $468
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $444
byte 1 37
byte 1 45
byte 1 49
byte 1 54
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 49
byte 1 54
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $443
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 95
byte 1 99
byte 1 46
byte 1 99
byte 1 0
align 1
LABELV $436
byte 1 85
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $429
byte 1 94
byte 1 49
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 102
byte 1 117
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $427
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $426
byte 1 99
byte 1 108
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $417
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 65
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 60
byte 1 98
byte 1 111
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 32
byte 1 91
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 49
byte 1 45
byte 1 53
byte 1 93
byte 1 32
byte 1 91
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 93
byte 1 32
byte 1 91
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 93
byte 1 32
byte 1 91
byte 1 97
byte 1 108
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $413
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $405
byte 1 48
byte 1 0
align 1
LABELV $404
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $403
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 105
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $400
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $399
byte 1 53
byte 1 0
align 1
LABELV $396
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $395
byte 1 52
byte 1 0
align 1
LABELV $392
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $391
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $390
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $387
byte 1 103
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $386
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $383
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $382
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $381
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $378
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $375
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $372
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $371
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $368
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $367
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 0
align 1
LABELV $366
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $365
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $364
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $363
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $358
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 66
byte 1 111
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $355
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 67
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 44
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
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
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $351
byte 1 115
byte 1 0
align 1
LABELV $350
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $346
byte 1 98
byte 1 0
align 1
LABELV $342
byte 1 114
byte 1 0
align 1
LABELV $339
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $324
byte 1 94
byte 1 49
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 39
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 39
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 40
byte 1 111
byte 1 114
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 41
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $323
byte 1 94
byte 1 49
byte 1 85
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 46
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $319
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 83
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $315
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $313
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $303
byte 1 94
byte 1 51
byte 1 85
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $292
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $196
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $180
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $179
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 0
align 1
LABELV $178
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $175
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $163
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $160
byte 1 102
byte 1 117
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $136
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $135
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $129
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $121
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $120
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $115
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $114
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $109
byte 1 46
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $108
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $102
byte 1 0
align 1
LABELV $101
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $99
byte 1 94
byte 1 49
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $96
byte 1 94
byte 1 49
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $90
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $89
byte 1 92
byte 1 110
byte 1 117
byte 1 109
byte 1 92
byte 1 0
align 1
LABELV $86
byte 1 60
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 62
byte 1 0
align 1
LABELV $83
byte 1 125
byte 1 0
align 1
LABELV $80
byte 1 85
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $74
byte 1 77
byte 1 97
byte 1 120
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
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
LABELV $71
byte 1 77
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 123
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $70
byte 1 123
byte 1 0
