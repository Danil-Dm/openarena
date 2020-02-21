export Svcmd_Status_f
code
proc Svcmd_Status_f 1040 12
file "../../../code/game/g_svcmds_ext.c"
line 34
;1://KK-OAX
;2:/*
;3:===========================================================================
;4:Copyright (C) 1999-2005 Id Software, Inc.
;5:
;6:This file is part of the Open Arena source code.
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
;25:#include "g_local.h"
;26:
;27:/*
;28:============
;29:Svcmd_status_f
;30:Does Server Status from Console
;31:============
;32:*/
;33:void Svcmd_Status_f( void )
;34:{
line 39
;35:	int       i;
;36:	gclient_t *cl;
;37:	char      userinfo[ MAX_INFO_STRING ];
;38:
;39:	G_Printf( "slot score ping address               rate     name\n" );
ADDRGP4 $61
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 40
;40:	G_Printf( "---- ----- ---- -------               ----     ----\n" );
ADDRGP4 $62
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 41
;41:	for( i = 0, cl = level.clients; i < level.maxclients; i++, cl++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 level
INDIRP4
ASGNP4
ADDRGP4 $66
JUMPV
LABELV $63
line 42
;42:		if( cl->pers.connected == CON_DISCONNECTED )
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $68
line 43
;43:			continue;
ADDRGP4 $64
JUMPV
LABELV $68
line 45
;44:
;45:		G_Printf( "%-4d ", i );
ADDRGP4 $70
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 46
;46:		G_Printf( "%-5d ", cl->ps.persistant[ PERS_SCORE ] );
ADDRGP4 $71
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 48
;47:
;48:		if( cl->pers.connected == CON_CONNECTING )
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $72
line 49
;49:			G_Printf( "CNCT " );
ADDRGP4 $74
ARGP4
ADDRGP4 G_Printf
CALLV
pop
ADDRGP4 $73
JUMPV
LABELV $72
line 51
;50:		else
;51:			G_Printf( "%-4d ", cl->ps.ping );
ADDRGP4 $70
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
LABELV $73
line 53
;52:
;53:		trap_GetUserinfo( i, userinfo, sizeof( userinfo ) );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 54
;54:		G_Printf( "%-21s ", Info_ValueForKey( userinfo, "ip" ) );
ADDRLP4 8
ARGP4
ADDRGP4 $76
ARGP4
ADDRLP4 1032
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $75
ARGP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 55
;55:		G_Printf( "%-8s ", Info_ValueForKey( userinfo, "rate" ) );
ADDRLP4 8
ARGP4
ADDRGP4 $78
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $77
ARGP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 56
;56:		G_Printf( "%s\n", cl->pers.netname ); // Info_ValueForKey( userinfo, "name" )
ADDRGP4 $79
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 57
;57:	}
LABELV $64
line 41
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2116
ADDP4
ASGNP4
LABELV $66
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $63
line 58
;58:}
LABELV $60
endproc Svcmd_Status_f 1040 12
export Svcmd_TeamMessage_f
proc Svcmd_TeamMessage_f 44 12
line 67
;59:
;60:/*
;61:============
;62:Svcmd_TeamMessage_f
;63:Sends a Chat Message to a Team from the Console
;64:============
;65:*/
;66:void Svcmd_TeamMessage_f( void )
;67:{
line 72
;68:	char   teamNum[ 2 ];
;69:	const char*   prefix;
;70:	team_t team;
;71:
;72:	if( trap_Argc( ) < 3 ) {
ADDRLP4 12
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 3
GEI4 $81
line 73
;73:		G_Printf( "usage: say_team <team> <message>\n" );
ADDRGP4 $83
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 74
;74:		return;
ADDRGP4 $80
JUMPV
LABELV $81
line 77
;75:	}
;76:
;77:	trap_Argv( 1, teamNum, sizeof( teamNum ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 78
;78:	team = G_TeamFromString( teamNum );
ADDRLP4 8
ARGP4
ADDRLP4 16
ADDRGP4 G_TeamFromString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 80
;79:
;80:	if( team == TEAM_NUM_TEAMS ) {
ADDRLP4 4
INDIRI4
CNSTI4 4
NEI4 $84
line 81
;81:		G_Printf( "say_team: invalid team \"%s\"\n", teamNum );
ADDRGP4 $86
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 82
;82:		return;
ADDRGP4 $80
JUMPV
LABELV $84
line 85
;83:	}
;84:
;85:	prefix = BG_TeamName( team );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 BG_TeamName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 86
;86:	prefix = va( "[%c] ", toupper( *prefix ) );
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRGP4 $87
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 88
;87:
;88:	G_TeamCommand( team, va( "tchat \"(console): " S_COLOR_CYAN "%s\"", ConcatArgs( 2 ) ) );
CNSTI4 2
ARGI4
ADDRLP4 32
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $88
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 G_TeamCommand
CALLV
pop
line 89
;89:	G_LogPrintf( "sayteam: %sconsole: " S_COLOR_CYAN "%s\n", prefix, ConcatArgs( 2 ) );
CNSTI4 2
ARGI4
ADDRLP4 40
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $89
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 90
;90:}
LABELV $80
endproc Svcmd_TeamMessage_f 44 12
export Svcmd_CenterPrint_f
proc Svcmd_CenterPrint_f 12 8
line 99
;91:
;92:/*
;93:============
;94:Svcmd_CenterPrint_f
;95:Does a CenterPrint from the Console
;96:============
;97:*/
;98:void Svcmd_CenterPrint_f( void )
;99:{
line 100
;100:	if( trap_Argc( ) < 2 ) {
ADDRLP4 0
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
GEI4 $91
line 101
;101:		G_Printf( "usage: cp <message>\n" );
ADDRGP4 $93
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 102
;102:		return;
ADDRGP4 $90
JUMPV
LABELV $91
line 105
;103:	}
;104:
;105:	trap_SendServerCommand( -1, va( "cp \"%s\"", ConcatArgs( 1 ) ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $94
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 106
;106:}
LABELV $90
endproc Svcmd_CenterPrint_f 12 8
export Svcmd_BannerPrint_f
proc Svcmd_BannerPrint_f 12 8
line 115
;107:/*
;108:============
;109:Svcmd_BannerPrint_f
;110:Does a BannerPrint from the Console
;111:KK-OAX Commented out in g_svccmds.c, so right now it's useless.
;112:============
;113:*/
;114:void Svcmd_BannerPrint_f( void )
;115:{
line 116
;116:	if( trap_Argc( ) < 2 ) {
ADDRLP4 0
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
GEI4 $96
line 117
;117:		G_Printf( "usage: bp <message>\n" );
ADDRGP4 $98
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 118
;118:		return;
ADDRGP4 $95
JUMPV
LABELV $96
line 121
;119:	}
;120:
;121:	trap_SendServerCommand( -1, va( "bp \"%s\"", ConcatArgs( 1 ) ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $99
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 122
;122:}
LABELV $95
endproc Svcmd_BannerPrint_f 12 8
export Svcmd_EjectClient_f
proc Svcmd_EjectClient_f 1048 12
line 132
;123:/*
;124:============
;125:Svcmd_EjectClient_f
;126:Kicks a Client from Console
;127:KK-OAX, I'm pretty sure this is also done in the "server" portion
;128:of the engine code with "kick," but oh well.
;129:============
;130:*/
;131:void Svcmd_EjectClient_f( void )
;132:{
line 135
;133:	char *reason, name[ MAX_STRING_CHARS ];
;134:
;135:	if( trap_Argc( ) < 2 ) {
ADDRLP4 1028
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
GEI4 $101
line 136
;136:		G_Printf( "usage: eject <player|-1> <reason>\n" );
ADDRGP4 $103
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 137
;137:		return;
ADDRGP4 $100
JUMPV
LABELV $101
line 140
;138:	}
;139:
;140:	trap_Argv( 1, name, sizeof( name ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 141
;141:	reason = ConcatArgs( 2 );
CNSTI4 2
ARGI4
ADDRLP4 1032
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1032
INDIRP4
ASGNP4
line 143
;142:
;143:	if( atoi( name ) == -1 ) {
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 -1
NEI4 $104
line 145
;144:		int i;
;145:		for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 1040
CNSTI4 0
ASGNI4
ADDRGP4 $109
JUMPV
LABELV $106
line 146
;146:			if( level.clients[ i ].pers.connected == CON_DISCONNECTED )
CNSTI4 2116
ADDRLP4 1040
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $111
line 147
;147:				continue;
ADDRGP4 $107
JUMPV
LABELV $111
line 148
;148:			if( level.clients[ i ].pers.localClient )
CNSTI4 2116
ADDRLP4 1040
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
EQI4 $113
line 149
;149:				continue;
ADDRGP4 $107
JUMPV
LABELV $113
line 150
;150:			trap_DropClient( i, reason );
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 151
;151:		}
LABELV $107
line 145
ADDRLP4 1040
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $109
ADDRLP4 1040
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $106
line 152
;152:	}
ADDRGP4 $105
JUMPV
LABELV $104
line 153
;153:	else {
line 154
;154:		gclient_t *cl = ClientForString( name );
ADDRLP4 4
ARGP4
ADDRLP4 1044
ADDRGP4 ClientForString
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1044
INDIRP4
ASGNP4
line 155
;155:		if( !cl )
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $115
line 156
;156:			return;
ADDRGP4 $100
JUMPV
LABELV $115
line 157
;157:		if( cl->pers.localClient ) {
ADDRLP4 1040
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
EQI4 $117
line 158
;158:			G_Printf( "eject: cannot eject local clients\n" );
ADDRGP4 $119
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 159
;159:			return;
ADDRGP4 $100
JUMPV
LABELV $117
line 161
;160:		}
;161:		trap_DropClient( cl-level.clients, reason );
ADDRLP4 1040
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 2116
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 162
;162:	}
LABELV $105
line 163
;163:}
LABELV $100
endproc Svcmd_EjectClient_f 1048 12
export Svcmd_DumpUser_f
proc Svcmd_DumpUser_f 18448 12
line 172
;164:
;165:/*
;166:============
;167:Svcmd_DumpUser_f
;168:Shows User Info
;169:============
;170:*/
;171:void Svcmd_DumpUser_f( void )
;172:{
line 178
;173:	char name[ MAX_STRING_CHARS ], userinfo[ MAX_INFO_STRING ];
;174:	char key[ BIG_INFO_KEY ], value[ BIG_INFO_VALUE ];
;175:	const char *info;
;176:	gclient_t *cl;
;177:
;178:	if( trap_Argc( ) != 2 ) {
ADDRLP4 18440
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 18440
INDIRI4
CNSTI4 2
EQI4 $121
line 179
;179:		G_Printf( "usage: dumpuser <player>\n" );
ADDRGP4 $123
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 180
;180:		return;
ADDRGP4 $120
JUMPV
LABELV $121
line 183
;181:	}
;182:
;183:	trap_Argv( 1, name, sizeof( name ) );
CNSTI4 1
ARGI4
ADDRLP4 16388
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 184
;184:	cl = ClientForString( name );
ADDRLP4 16388
ARGP4
ADDRLP4 18444
ADDRGP4 ClientForString
CALLP4
ASGNP4
ADDRLP4 18436
ADDRLP4 18444
INDIRP4
ASGNP4
line 185
;185:	if( !cl )
ADDRLP4 18436
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $124
line 186
;186:		return;
ADDRGP4 $120
JUMPV
LABELV $124
line 188
;187:
;188:	trap_GetUserinfo( cl-level.clients, userinfo, sizeof( userinfo ) );
ADDRLP4 18436
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 2116
DIVI4
ARGI4
ADDRLP4 17412
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 189
;189:	info = &userinfo[ 0 ];
ADDRLP4 0
ADDRLP4 17412
ASGNP4
line 190
;190:	G_Printf( "userinfo\n--------\n" );
ADDRGP4 $126
ARGP4
ADDRGP4 G_Printf
CALLV
pop
ADDRGP4 $128
JUMPV
LABELV $127
line 192
;191:	//Info_Print( userinfo );
;192:	while( 1 ) {
line 193
;193:		Info_NextPair( &info, key, value );
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8196
ARGP4
ADDRGP4 Info_NextPair
CALLV
pop
line 194
;194:		if( !*info )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $130
line 195
;195:			return;
ADDRGP4 $120
JUMPV
LABELV $130
line 197
;196:
;197:		G_Printf( "%-20s%s\n", key, value );
ADDRGP4 $132
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8196
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 198
;198:	}
LABELV $128
line 192
ADDRGP4 $127
JUMPV
line 199
;199:}
LABELV $120
endproc Svcmd_DumpUser_f 18448 12
export Svcmd_Chat_f
proc Svcmd_Chat_f 12 8
line 202
;200:
;201:void Svcmd_Chat_f( void )
;202:{
line 203
;203:	trap_SendServerCommand( -1, va( "chat \"%s\"", ConcatArgs( 1 ) ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $134
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 204
;204:	G_LogPrintf("chat: %s\n", ConcatArgs( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $135
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 205
;205:}
LABELV $133
endproc Svcmd_Chat_f 12 8
export Svcmd_ListIP_f
proc Svcmd_ListIP_f 0 8
line 214
;206:
;207:/*
;208:=============
;209:Svcmd_ListIP_f
;210:Dumb Wrapper for the trap_Send command
;211:=============
;212:*/
;213:void Svcmd_ListIP_f( void )
;214:{
line 215
;215:	trap_SendConsoleCommand( EXEC_NOW, "g_banIPs\n" );
CNSTI4 0
ARGI4
ADDRGP4 $137
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 216
;216:}
LABELV $136
endproc Svcmd_ListIP_f 0 8
export Svcmd_MessageWrapper
proc Svcmd_MessageWrapper 20 16
line 225
;217:
;218:/*
;219:=============
;220:Svcmd_MessageWrapper
;221:Dumb wrapper for "a" and "m" and "say"
;222:=============
;223:*/
;224:void Svcmd_MessageWrapper( void )
;225:{
line 227
;226:	char cmd[ 5 ];
;227:	trap_Argv( 0, cmd, sizeof( cmd ) );
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 233
;228:	/*if( Q_strequal( cmd, "a" ) )
;229:	  Cmd_AdminMessage_f( NULL );
;230:	else if( Q_strequal( cmd, "m" ) )
;231:	  Cmd_PrivateMessage_f( NULL );
;232:	else*/
;233:	if( Q_strequal( cmd, "say" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $141
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $139
line 234
;234:		G_Say( NULL, NULL, SAY_ALL, ConcatArgs( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 16
CNSTP4 0
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
LABELV $139
line 235
;235:}
LABELV $138
endproc Svcmd_MessageWrapper 20 16
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
LABELV $141
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $137
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 110
byte 1 73
byte 1 80
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $135
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $134
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
LABELV $132
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $126
byte 1 117
byte 1 115
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 10
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $123
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 117
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 60
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $119
byte 1 101
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $103
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 101
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 60
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 124
byte 1 45
byte 1 49
byte 1 62
byte 1 32
byte 1 60
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $99
byte 1 98
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $98
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 98
byte 1 112
byte 1 32
byte 1 60
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $94
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $93
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 112
byte 1 32
byte 1 60
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $89
byte 1 115
byte 1 97
byte 1 121
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 53
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $88
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 34
byte 1 40
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 41
byte 1 58
byte 1 32
byte 1 94
byte 1 53
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $87
byte 1 91
byte 1 37
byte 1 99
byte 1 93
byte 1 32
byte 1 0
align 1
LABELV $86
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $83
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 60
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 62
byte 1 32
byte 1 60
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $79
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $78
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $77
byte 1 37
byte 1 45
byte 1 56
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $76
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $75
byte 1 37
byte 1 45
byte 1 50
byte 1 49
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $74
byte 1 67
byte 1 78
byte 1 67
byte 1 84
byte 1 32
byte 1 0
align 1
LABELV $71
byte 1 37
byte 1 45
byte 1 53
byte 1 100
byte 1 32
byte 1 0
align 1
LABELV $70
byte 1 37
byte 1 45
byte 1 52
byte 1 100
byte 1 32
byte 1 0
align 1
LABELV $62
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
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
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $61
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
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
byte 1 32
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
